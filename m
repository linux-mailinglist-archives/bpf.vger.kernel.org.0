Return-Path: <bpf+bounces-46179-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 295349E602B
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 22:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C6841884DB1
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 21:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D83E1CCEED;
	Thu,  5 Dec 2024 21:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JkHC75IA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249E71B87C8;
	Thu,  5 Dec 2024 21:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733434513; cv=none; b=FVGpVAoTBxCvc7LgVw0cIIrG7Anu42+QeMU+Nd0jNCnLMev6WDjp4exRtVLOny8DvM+yl1UcDDVJCo8tTlA5/3Pm69OwxeebJ057rUzBmGjNvcUDzfnJ7IrRQnKEz+r0IZBUUzaZDH+olt74hO0JnsJ+1zAsDK7qvdf5PSGMr3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733434513; c=relaxed/simple;
	bh=9osjdTBG4Gc+WKDe1rMs5RM1vpWafc/vIF99UIfgr6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KzhkXcBkMSQTFWDPWCz00Szy2cMRjWMBl/uyOSadXU5YfNjCE2bi83X52lvvrDJnoCcz022wT/owQL9mpLN3MOH8h6mgbSwvc/zaEM43A4Tf1Zpo6ulqMspKGWoTpphlMTw1OiLvph+IxVX4QLrssFDUSjh6zq1eg688rogWdWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JkHC75IA; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ee9a780de4so1206146a91.3;
        Thu, 05 Dec 2024 13:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733434511; x=1734039311; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vDz3RwgDohqSZCfDPmKODxZpbSK/BAgqhtU7Mdsf4XY=;
        b=JkHC75IA8HCXcREvtPQem9z4SwWx3nY1LJNkU2dlA1AC8sabc2yBf0/6+o82zBJ1kt
         TWfcEKk7vohappctrQC8ioHpwgDkGpJ8FwVAmUjL7MgwLd/G9XBe8enVmXJHRcHmkT5w
         31nY+PRwWFDfHvWPHnBbuolvFTR/I12w1NZKX9U1SX/Dp6g+Z46OqCpkJzCAyY1iVGvY
         XL5oPRI72jgkGsS9udfQjtGaDFPNEO27Rm+bhc6YYnt+mUvHoW84nT0Oipn9OhJHmWJr
         b9BcbY+rvSiRhIN/7VgDrCqq8Zbk3ZhARxK4dMoVG/Xdt5ynVU3fVSjhyH54Rc2Aa0Fx
         nG4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733434511; x=1734039311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vDz3RwgDohqSZCfDPmKODxZpbSK/BAgqhtU7Mdsf4XY=;
        b=ZrWUSaLCpWYJSl1SoTgasAMriwAMAmJjgmCSdhaPm5gxAAqgglJGvvQhx5E/54fQbL
         b+nyfl1xZZ/17ulONwVFzwSTu7pdaNtcxhm14IiN7cMSP3voA1BQ+lHYK7jW2Wb7h6Pw
         iursPT7KDVbI1A4ks4ejI94xrqPaGKSSGvrw1LxW+QyPMXpCJP+d7anGPjdu3Qor+yrM
         UadNk6uEyFCJWZMt46g6vicWlCEI6sNF+483iA7VmA2wEHdZ78THcvmErwvBUGnncieX
         p1F9KF0lQMNMwPlMwebQSkggGmaQg3R7zcDeKJ7eyZS+981FC4IV11wkojVllNXg/g3w
         FUWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIddneruKTvXjA0eert61pUgh1Z29NfSBdxKaQ9tTHR3uc7oBDjZZdAazRbIKCOJ1K/Hk=@vger.kernel.org, AJvYcCWgA+g7OzML8eDpHOEOdsAdyqVpQX9tSumGdUC31pSaD0TR7YFKI4+2KGCrchuAejbY6VHRTuxeyIHTJg8a@vger.kernel.org
X-Gm-Message-State: AOJu0YysCJS1BYyyMVtt9EhH9Hg3pbZ/GbmTXEw8vDkKKhfPtCCFLirr
	G/1Z7ZVLFYYcudommvDB21zDaWCYAOZKK3jr2inlIKpac9NX5km1i///ZZkxn34frLvRvydGWxe
	Q5fcc3zk/Gey+NpZNULSu7CAJC3s=
X-Gm-Gg: ASbGncsq5fG1Jxe2hqDgwQUD3kQkycScLbFagHru0YVrS00bdK0WTP9kggmeo6yLyP0
	LWOXBrQbAX6RO94NTql/97lsC4VxwX8KJqPyjkSBZTQNq7bA=
X-Google-Smtp-Source: AGHT+IHONkoY0V+Q0vXwFujZNPsgCK47RBbuS5Gc9ubEOlpAo0tr/fZX5XDrQ9DqvsOA4ysEOeok7xgw7By9fBNnE1s=
X-Received: by 2002:a17:90b:1a8e:b0:2ee:bbe0:98c6 with SMTP id
 98e67ed59e1d1-2ef6965469cmr1007629a91.8.1733434511113; Thu, 05 Dec 2024
 13:35:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_A7A870BF168D6A21BA193408D5645D5D920A@qq.com> <0b96aa24-13ca-4e0a-8e80-f2586fbe2b57@kernel.org>
In-Reply-To: <0b96aa24-13ca-4e0a-8e80-f2586fbe2b57@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 5 Dec 2024 13:34:59 -0800
Message-ID: <CAEf4BzbLmXF9XB=fBvL7NLMoPmfD=DFFvuM8Fw5h6T7vfFXUFg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3] bpftool: Fix gen object segfault
To: Quentin Monnet <qmo@kernel.org>
Cc: Rong Tao <rtoax@foxmail.com>, ast@kernel.org, daniel@iogearbox.net, 
	rongtao@cestc.cn, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, 
	"open list:BPF [TOOLING] (bpftool)" <bpf@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 4:22=E2=80=AFAM Quentin Monnet <qmo@kernel.org> wrot=
e:
>
> On 05/12/2024 12:09, Rong Tao wrote:
> > From: Rong Tao <rongtao@cestc.cn>
> >
> > If the input file and output file are the same, the input file is clear=
ed
> > due to opening, resulting in a NULL pointer access by libbpf.
> >
> >     $ bpftool gen object prog.o prog.o
> >     libbpf: failed to get ELF header for prog.o: invalid `Elf' handle
> >     Segmentation fault
> >
> >     (gdb) bt
> >     #0  0x0000000000450285 in linker_append_elf_syms (linker=3D0x4feda0=
, obj=3D0x7fffffffe100) at linker.c:1296
> >     #1  bpf_linker__add_file (linker=3D0x4feda0, filename=3D<optimized =
out>, opts=3D<optimized out>) at linker.c:453
> >     #2  0x000000000040c235 in do_object ()
> >     #3  0x00000000004021d7 in main ()
> >     (gdb) frame 0
> >     #0  0x0000000000450285 in linker_append_elf_syms (linker=3D0x4feda0=
, obj=3D0x7fffffffe100) at linker.c:1296
> >     1296              Elf64_Sym *sym =3D symtab->data->d_buf;
> >
> > Signed-off-by: Rong Tao <rongtao@cestc.cn>
>
> Tested-by: Quentin Monnet <qmo@kernel.org>
> Reviewed-by: Quentin Monnet <qmo@kernel.org>

Isn't this papering over a deeper underlying issue? Why do we get
SIGSEGV inside the linker at all instead of just erroring out?
Comparison based on file path isn't a reliable way to check if input
and output are both the same file, so this fixes the most obvious
case, but not the actual issue.

>
> Thank you!

