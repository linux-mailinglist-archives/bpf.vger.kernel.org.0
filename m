Return-Path: <bpf+bounces-61964-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49AE4AF0228
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 19:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 033A31C05786
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 17:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C2C27C172;
	Tue,  1 Jul 2025 17:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hXLwyHMM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C90015E96
	for <bpf@vger.kernel.org>; Tue,  1 Jul 2025 17:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751392034; cv=none; b=OAgb+qD8J7hca3Aa+dn1O7bhlNfs4X/VKHmFSHcQGecfYASVkeQmpOUwgtTbrWGQD9B4xJdPYIHoLoE9HeuPx6kEpi7HpEHE9sHZClDIrbICDmOP8QrqCIe2ZcOL6dGYYWEWkeHtMMPZgU6cgCuuz/ZXCAvbCKWdlYUWDyzzhh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751392034; c=relaxed/simple;
	bh=n/nunSYr7P9aa6GoYBP4odZSLWFcdx3gwMipNHq4Tck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I8mdzA/62kYeybuPygZjk5OqbAik6fwTgptuq83M+at9rL4ok6NlKkVh8ywFijiQRiCHynSO2486tPuCOKIm/fNFqq53IkX+uE+o+M8n3WIEoZ/6L8dUsnXsMH+/bWOWJfcnWKh9k/Za8EgR9dHe4Wptj4THF6haKtCCCUMcoYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hXLwyHMM; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a536ecbf6fso3483757f8f.2
        for <bpf@vger.kernel.org>; Tue, 01 Jul 2025 10:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751392031; x=1751996831; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n/nunSYr7P9aa6GoYBP4odZSLWFcdx3gwMipNHq4Tck=;
        b=hXLwyHMMmCzgiun5zhddEJpMZ0wCCo0AUOvyTbGujmqfEzlxYnXVHllk6OJwjYeJez
         Qo33klmWaYcRE9bevbBluW1gAWIdW2MNXr/T7d9VeZTFCwUT+BTdN5k1V/LizDtBL5Sw
         RD3Ryq3u94seJKrrY6Em/8CkDaz6NkSL+MmgaufUhgaNochs2cxmAPxhoGWc0Xt8XLFW
         Zo3MaFb6UzIUSWlwsPd+1r4Lc/Yz8XRd4lGtFwQNozzqolGwzDSoXclUOq11jVnGE43G
         fi/MDmlMLxzWZKKzz4tzx7aCxQiuLaVqaQZiY+Cqdb36nrjKpMMSzm/2s1x7ym4egkTO
         RMLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751392031; x=1751996831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n/nunSYr7P9aa6GoYBP4odZSLWFcdx3gwMipNHq4Tck=;
        b=c9zV9bZGyBMHsWlyfrSpuKQqcpmONg00epKnnqonMWODlc4I5AL2Kq78dKuJiAaNDW
         BanNgQsJAYJw6RV2Oz15lCwiHYjHpWSegxxig4egnh88D5/M64OBfMqpeitU03CWYASH
         CxY8rhJcRmReQXKNTKiL8zvod6Wy+sQgAz++XioSqY9pbwyBamLWDpPZrexrJVMBgwS1
         tcocvSndM1xE/A7hoJiVzaQExhDFll+X09sJMsxufCvxCo7OwC21ZRcZL+6tg6RtykPy
         d+yuERZHtCU7ZN721W7UCrS3V/7ZHvcNW/jGiD0tQtokMyLQeEBFebpSPSefLlP127cs
         crRg==
X-Gm-Message-State: AOJu0YySrvWVpId63p/wrhT5ACrPlxkpxz7AOYAw46ZdP5gjlGeMAom7
	DhbhBXHbCgSxZ/F1n2hZ1AUNgL6nOv8GG2pZREZ05w4Do4LyHefi+nm5vVzGW/AnuQ325a/4Y/4
	1NM4m3LnEYfv6qUMq3CkcD21EaROaE9I=
X-Gm-Gg: ASbGncvhk3wFq0Rbse13Y9IG9Cn0epay0fsu6WBQ/B9TINxbSVfUuUh27lnMvTE0rtW
	3R8FSHned9sW7LBNTkzb1p6tAvANez1mzeVC7SKzlwbi8ZIhEJ9XAGuFj36qhuFjMIUXseDXYJO
	CLYnpV0dlomKVRhNkWXuEhYSt2BhKhVEAC+i8/SXeiGlK3efKEfzooFldKBv0=
X-Google-Smtp-Source: AGHT+IFTQmLGLDol4XW8X8CkDJn9RW1Rcb3BfR7jLblIr1h6CXTRI82oeZYpyNCXUVQj8womismEY87fE1D3EeZ45bc=
X-Received: by 2002:a5d:584a:0:b0:3a4:e844:745d with SMTP id
 ffacd0b85a97d-3a90be8d151mr16896007f8f.56.1751392030571; Tue, 01 Jul 2025
 10:47:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250630133524.364236-1-vmalik@redhat.com>
In-Reply-To: <20250630133524.364236-1-vmalik@redhat.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 1 Jul 2025 10:46:56 -0700
X-Gm-Features: Ac12FXwrmvoAo_yl-wb9DRp6RZ0XpReer1I6IrZCju8CEjy6mhWplt5JhfHo--w
Message-ID: <CAADnVQJF8-8zHV75Cf7v8XWGVrJwU5JaQjBm0B-Q3JUUMqNmcQ@mail.gmail.com>
Subject: Re: [PATCH bpf] selftests/bpf: Re-add kfunc declarations to qdisc tests
To: Viktor Malik <vmalik@redhat.com>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, Amery Hung <ameryhung@gmail.com>, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Feng Yang <yangfeng@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 30, 2025 at 6:35=E2=80=AFAM Viktor Malik <vmalik@redhat.com> wr=
ote:
>
> BPF selftests compilation fails on systems with CONFIG_NET_SCH_BPF=3Dn.
> The reason is that qdisc-related kfuncs are included via vmlinux.h but
> when qdisc is disabled, they are not defined and do not appear in
> vmlinux.h.

Yes and that's expected behavior. It's not a bug.
That's why we have CONFIG_NET_SCH_BPF=3Dy in
selftests/bpf/config
and CI picks it up automatically.

If we add these kfuncs to bpf_qdisc_common.h where would we
draw the line when the kfuncs should be added or not ?

Currently we don't add any new kfuncs, since they all
should be in vmlinux.h

--
pw-bot: cr

