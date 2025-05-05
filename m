Return-Path: <bpf+bounces-57384-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65452AA9E70
	for <lists+bpf@lfdr.de>; Mon,  5 May 2025 23:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C84D17AA58
	for <lists+bpf@lfdr.de>; Mon,  5 May 2025 21:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40582741C7;
	Mon,  5 May 2025 21:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DMkR61WA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736F8259493
	for <bpf@vger.kernel.org>; Mon,  5 May 2025 21:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746482049; cv=none; b=EPPsGBpT8au3tA3hRA/g4fafP/M9BShARUIN0KPTbgf7nacvuxU94e1m9YA0zJNkRRfCPG9VjG+Rk1cCLjKoUmSMq7XDmlLSXnZkc8aXf6Fo6GUZJsDlsQ7heYk+j/r7PAD3vB03E/zHuGldmg6jUCiZz7URXuQ83N8Of4NNE9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746482049; c=relaxed/simple;
	bh=kI1+SqxhWWiKkChuc6eBooIw7378DYhp7brFc1/Eb8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=obmz6L9sISnG0xximWC5l/zG29bdeSMSOyAWtAY7WA5FWV+jbyu6h4BVFCKzc3E5d8k42QrCS0ow4PYDoXLvrjy+owFfzWmCGqHiizVYwNuOQlnQGkj9vsNzY+rX3zPnDVaDd3AJNgtQ974ci77CQ8wdBGPCfEh8/WBzTIeGedQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DMkR61WA; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cfe63c592so45955405e9.2
        for <bpf@vger.kernel.org>; Mon, 05 May 2025 14:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746482046; x=1747086846; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kI1+SqxhWWiKkChuc6eBooIw7378DYhp7brFc1/Eb8g=;
        b=DMkR61WApKa29vBYqx5EP77UQf0jzePD3WPoQnZuGTX7sGaGkSObkgbDBFrMRRPG1D
         gXSILXWU9XWwoFWNSmhq/Z65aMWSQT7dEDYxFG4C8eE7OSU81I6wz1HpfrSOzUZYxbA4
         2PdSwGW1ktqjJYlg4I5UerszxLuGGPHYEri0xb/wPVrYPCTzYtLu3tM/eX1jOw6eeQ4M
         W5KcS6m37X5W6ToGhMlcDzWxphVtgUXN3yG4OeZKiUlYRxn+KFAjEW2Prpp8Iuw4u8cz
         u8wuKb7f5LCUbeuqeFmJTAyTAwmmL3b6HST3aoSyCaJCdlmeDrTcglUZLITQ1X2HumIw
         7fRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746482046; x=1747086846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kI1+SqxhWWiKkChuc6eBooIw7378DYhp7brFc1/Eb8g=;
        b=VYwIGHK13/tn/mN++WyFfoZb4O0r4jQg2nPVIxDYOfdmJup0VAOXaJzdKe4OEnF2s4
         AupsRD1x4giguZyvlgNNE0u5zPR9pXyWzUYphmTB2fVr0Yo6n5Q2kgGY01yjcL53WqDA
         xDN9oAVWBuP345sFBe6BYFVefeJ09Q8sqjEC9EN9lg4RrgG+xBxk8h6jIvzI9hDYofRu
         Cl/VCKMynBkVzOBPnphWFBVE/RZj0e2TASfbm9jrsn4BuupfgL+OeYklO3VXDbomlIsD
         5/BPAT1dIdKJ1I7MgiIrAcLIUFjyVfdQqK64vmA3hCwRN2C0hIv9ImB1KWhJbem7tpr5
         eJNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQhKKsOeZuYD0KOnCvimgbNwAgroTgcgZZ7EO4/3eOAnRWWsHLXAklMYTwmJeLrfXE3Vc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkrKSlap0GRZyvYRm7yr0Rt6VJ3dVeeF19Vt6GXZMfj2l7Z5q6
	jPvQvycrkKSc3hhiOsGK3Bt9LOmc5QDCJf5LFr6XAuFvgb/dtR82Zkm6p0Ou2ItjaXA8BosHmuI
	q6x1cALR4U4V3ene72AM0AHb/9g4=
X-Gm-Gg: ASbGncu09T54LGgPYks6WXHqKxmrIPVAnidEkC6GITAIgFkO/W5yTO5a5gKcuPDZNCM
	65Qx5Fck9Ub0EU5MUKbqZxTQ+sxnusG/bZkmdkGrbDMFUi+3DHCmsRHEC1SKltI9IwAeytU55Rj
	QqXL64ebwKVRym6PQDZG0oWPXUT1wj8BR5u2nLDh2P3oa08Kgfcg==
X-Google-Smtp-Source: AGHT+IFMnZ5+5GQjRZQuDprWhChq+iGkmlIjPoXtahYrED3tonAY7D6/Wroc5XIWtnZToeKqEkTNGf1zdwhS/wYJ/HM=
X-Received: by 2002:a05:600c:b96:b0:43c:f64c:447f with SMTP id
 5b1f17b1804b1-441c49483c0mr67575265e9.29.1746482045381; Mon, 05 May 2025
 14:54:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250501235231.1339822-1-andrii@kernel.org> <95dbb7e5-c2aa-4114-bdb9-9d9ea53653f0@oracle.com>
 <CAADnVQKmQKVTkf28Ex6T8Y03xDQ6-3o-rEcOM3vGZcVHGcrfSA@mail.gmail.com> <CAEf4BzZ-3ovbCEO+Jnn30xNsxE4nBnGtqL9FZ0O7JkUa=t0YuQ@mail.gmail.com>
In-Reply-To: <CAEf4BzZ-3ovbCEO+Jnn30xNsxE4nBnGtqL9FZ0O7JkUa=t0YuQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 5 May 2025 14:53:54 -0700
X-Gm-Features: ATxdqUEzuJ54QEaXeqxoXv6vh29x4-VMiIO5Q_-JWNd0vonPKs9YkFCFQf1DNVk
Message-ID: <CAADnVQ+chNi2BJ2ToUYOVcktAjiR-D0J7YZaLRgm+7zbwiG-1w@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: improve BTF dedup handling of
 "identical" BTF types
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, Andrii Nakryiko <andrii@kernel.org>, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 5, 2025 at 2:10=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, May 2, 2025 at 11:09=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Fri, May 2, 2025 at 2:32=E2=80=AFAM Alan Maguire <alan.maguire@oracl=
e.com> wrote:
> > >
> > > >
> > > > On the other hand, this seems to help to reduce duplication across =
many
> > > > kernel modules. In my local test, I had 639 kernel module built. Ov=
erall
> > > > .BTF sections size goes down from 41MB bytes down to 5MB (!), which=
 is
> > > > pretty impressive for such a straightforward piece of logic added. =
But
> > > > it would be nice to validate independently just in case my bash and
> > > > Python-fu is broken.
> > > >
> > > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > >
> > > Looks great!
> > >
> > > Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> > >
> > > Should have some numbers on the module size differences with this cha=
nge
> > > by Monday, had to dash before my build completed.
> >
> > I'm curious what BTF sizes you'll see.
> >
> > Sounds like dwarf has more cases of "same type but different id"
> > than we expected.
> > So existing workarounds are working only because we have very
> > few modules that rely on proper dedup of kernel types.
> > Beyond array/struct/ptrs, I wonder, what else is there.
>
> Well, turns out I screwed up the measurements. I thought that I used
> libbpf version with Alan's patch applied as a baseline, but it turned
> out it was libbpf without his patch. So all the measurements (41MB ->
> 5MB) are actually due to Alan's identical pointers fix. My patches
> have no effect on module BTF sizes (which is good and a bit more
> sensible, I should have double checked before submitting). So, if we
> are going to apply the patch, it's probably better to just drop that
> paragraph. Or I can send v2 with an adjusted commit message, whatever
> is better.

Dropped the paragraph while applying.
Thanks for double checking.

