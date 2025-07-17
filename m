Return-Path: <bpf+bounces-63613-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B394BB09053
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 17:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C8751AA0973
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 15:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917161DE4FB;
	Thu, 17 Jul 2025 15:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="ZqIrr+PF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685D51D5CC9
	for <bpf@vger.kernel.org>; Thu, 17 Jul 2025 15:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752765323; cv=none; b=GEvlFvNr1WbDaxRxSnadw4TzTgP3JbBkBn926qwlN7XA+9860ZC+o/el+MUMl4nE/38+3BeiR3bODENf8M/WywqxoNdMYdIE3Gn3UK2oWGfEgBXQh8eU3JfZQg/Ks+flkFBLlnJAEm24Lg1ddssuvfRGjpvE2D/Kjjz4v3cBJ2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752765323; c=relaxed/simple;
	bh=uYKefjG3jk2C3YLsqcotNnT24i2I/xBuxxVY0arOB/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q1BoIHOR6EPu72lqcx+otZW33Q1cSWgpCgKxD/46B9p6jYVV+3S6E5YHBAqjEOLaevLhRhOetRXOVfMSSJzIHYWmaJqp+ldnEsKl6gTWMi/1g07DOakxokbqAdVkILViatVzDYtnNfNR2FC9kTiRPwLZjLfHVt9QZQRTSi5uRsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=ZqIrr+PF; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a6cd1a6fecso927323f8f.3
        for <bpf@vger.kernel.org>; Thu, 17 Jul 2025 08:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1752765320; x=1753370120; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kJMJTA83WH07DjPioIXnI5GHGg29vRTdXy8ees4Pv1s=;
        b=ZqIrr+PFzKN31PldRkheEEhTCXz8PcjQzVlwEyUr/+8PivtPDSYctC1thKgNJblxq9
         J2i8Vgj50Qtwt3QRCYofwIwJRSnD3D1U+N+GdjYzbB8ETmDaPhDEr0oEkq96zPYyD351
         tjerzJTLpt8UfKW5vM5VJliwEqD1A1+7whs54ls/0SjwnG1u1E1uJk7bjfwV2Pc6Y5Hg
         9POPNXfNb3z/okBUA3TgZ3N+wSQaqy4l4jpDAzhywpwbNjLltVN/nclpM9EPmyjZ1N8f
         LJIdrihd9B8sUTm4LuP86p2jS/IPOwXK/2Vr/+PpH/tcu0DGJOBLCbgW6/4+yVWBpDdY
         JlEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752765320; x=1753370120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kJMJTA83WH07DjPioIXnI5GHGg29vRTdXy8ees4Pv1s=;
        b=fTOgam0skpiPxzLG7RumwD3SryfLTShZe/GErDTcgRgwBCh8rvGPwGxJQ/m/jnc8md
         7LfUkH0MwZTcbaS9M+8bup35ZfpPOJnAabTjrH+v+abElejFYTYSiQ/AnS1guabYdNiS
         VtF0/pbRQznXWgdko16QgXdjDhxc005HgbhQGPIorufhbJ8WNnqovK1GnkIx8Wiq+hBF
         /wkD5t8SMVGPZBgnWRRlYQq1InhRa8NATlHJFQJEk7OUIx6PeqJygD2jwHfwgWY5+vxa
         PT6DJqeOW0cj1cLzffMCjDeHOBND47w+r/z1h8Iw6W1saIioje4lLt5BdKSYKwv1dYDj
         H7jg==
X-Forwarded-Encrypted: i=1; AJvYcCXd8/PEAuqfm+LF6WB8jwJwKTKFe8k3q3G6i6rzx5EecIkuT15U4zvFGByHt+po21HCgeU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi7i7w/U9+WRiax1k93KWlD53UM6KE5fl5zoketNB7arnOOfjm
	ur3l3e2NUEcmCdWP6Kg3Z7WbNWVjb9XqznvKcAvtx3G3DGcGqUZOV9O4qiHcLwM8i6Qb8e0ygJY
	4ffzR/lmjrQLln23okagz8xjbM/LplJPT0QNyewPRsw==
X-Gm-Gg: ASbGncuYEVejLNH/vzRdS2j612JpRQ2+iVhdVQgI4tH0VP4ADNQ8fel8NJ3DbD1ErIS
	p4jY4OxV3YzksO+F8nWLwulIxAHfLeJrQm1G0LH/u/iOitSsHS90i5oJPTKsNhlwXKlRGRfS9KZ
	I764JLxQSIyq39ZUPVRkI/TWeIABZbvC0nItohA+E2uR5/g0f30oVaNc5O5prSsGxjzzBPHCKsg
	vIwng==
X-Google-Smtp-Source: AGHT+IH3RQURYv6RUsyjhfCjPnbq76Yt1tIeE/r4l/zRFxghwDcy4thWAtjf1Qmjm4sX2AEpW3WUl8KV2Dpd0p1Xyr0=
X-Received: by 2002:a05:6000:658:b0:3a4:eeb5:58c0 with SMTP id
 ffacd0b85a97d-3b60dd4f752mr7612559f8f.20.1752765319635; Thu, 17 Jul 2025
 08:15:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520-vmlinux-mmap-v5-0-e8c941acc414@isovalent.com>
 <20250520-vmlinux-mmap-v5-1-e8c941acc414@isovalent.com> <g2gqhkunbu43awrofzqb4cs4sxkxg2i4eud6p4qziwrdh67q4g@mtw3d3aqfgmb>
 <CAN+4W8hsK6FMBon0-J6mAYk1yVsamYL=cHqFkj3syepxiv16Ug@mail.gmail.com> <CAADnVQ+WZsaDS-Vuc9AN7P3=xvX8TG=rY65A8wYdOARLtkt6Mw@mail.gmail.com>
In-Reply-To: <CAADnVQ+WZsaDS-Vuc9AN7P3=xvX8TG=rY65A8wYdOARLtkt6Mw@mail.gmail.com>
From: Lorenz Bauer <lmb@isovalent.com>
Date: Thu, 17 Jul 2025 16:15:07 +0100
X-Gm-Features: Ac12FXx5_43sdjKCTtLw8gtm46jTfSh3joljtt9boX2xFAkNZRIJX-9H7H7z2co
Message-ID: <CAN+4W8i+PqYDcJjWk+g63W4kdKvhFKSad61q-T=JJky5m7j79w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 1/3] btf: allow mmap of vmlinux btf
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Breno Leitao <leitao@debian.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Arnd Bergmann <arnd@arndb.de>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 3:49=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:

> __pa_symbol() should work for start_BTF, but would be good
> to double check with Ard that the rest stays linear.

Alexei,

This code in the arm64 setup does make me think we'll be OK.

kernel_code.start   =3D __pa_symbol(_stext);
kernel_code.end     =3D __pa_symbol(__init_begin - 1);
kernel_data.start   =3D __pa_symbol(_sdata);
kernel_data.end     =3D __pa_symbol(_end - 1);

Using these as start and end only makes sense to me if the addresses
are linear? See
https://elixir.bootlin.com/linux/v6.15.6/source/arch/arm64/kernel/setup.c#L=
217

Let me know if you want me to double check with Ard regardless.

Best
Lorenz

