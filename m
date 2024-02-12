Return-Path: <bpf+bounces-21805-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C4A8522CE
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 00:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9C651F23AA0
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 23:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97255024D;
	Mon, 12 Feb 2024 23:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="knHew9Zu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA7642AA3
	for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 23:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707781951; cv=none; b=NEZzsLAI3vy5YoiR7Uf/IIgoTRy064RqmIA7NzvBIgmz/9NGldRkC+Vhxn0j0yYLiye+G+Xst8x3+6iyVRfEHQuxBy7NUsTyVl2RwqwQYqjW/mO7WJrvJChgEpeSAfLT+eqeEOgSV6Ho11R4MnOjVOYRwdMHZZfcMXxwUmR1uvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707781951; c=relaxed/simple;
	bh=eSxdt9S4bndWQUP6AI4NZPjcrqLgtiTyMrcZxPuXheg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DZxzgrC67geV813PysAaNXHllVyYSYDrwE7N3z3EQU50dIW63KMbLDuSsGJDiR4K1DOgPFlMBKYUPSlooeOfOr2lHPjMk194lvvDjEzCoM7e0JRDz775MeqJFpjg9/oh5XThQbjmIuFy/rM0KxP2laqYqoKKAqn8yeQUSitZlr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=knHew9Zu; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-339289fead2so2438603f8f.3
        for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 15:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707781948; x=1708386748; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KgGsxOhsBFd8WUCfqIxd+xgiUlh0I8wT4Ea53XOwywg=;
        b=knHew9Zutj6Umq15NmAi8V5DmyHdKeW78ZX4Zz1ZgmQJyViDhI36a/t9yFJ33DPfkI
         EczDCIAjCo7rIeCdPtFFUJWxblp3mbMWrA9VKhKpcKe4ndI76dtfOQZ50tpFAl2Pf5e+
         OBwrQ9mbGHxg4Vxj22/L8PtutEwtEOYe167tn1sDGEzcGHzvHl1+b7WXDhNksDjsETwS
         /wh22kLz8uC6Hr815Rfh8cIoyFAaQIoAOzSTEMch41/ES0AmKO6wJWVVUwHNFoigaVVL
         sBC3BMGq6YGo8JMxSbFouvGqEvE7RtjQTNICn3iCsTcLbZdaiFXZD+HLO2VYqC4h/VLj
         jcog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707781948; x=1708386748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KgGsxOhsBFd8WUCfqIxd+xgiUlh0I8wT4Ea53XOwywg=;
        b=QZuKsP0yFNug5usflsaJKxszHRIv6MCcqStEwRKgQIjWQk/NkhrM36Kbb+lDYkLRQW
         dupF8O18UWaOhK7MVkXeRa3VOFK2AXQURN4wqITt59WRdsimrKSVHIShxBLhcxZ7SQa3
         8eUWF+1evhYTMCNIRv14jX74Ev1soSohDj9HqR8lRT8BMscelzNiFzfFjcOl7pW6klwK
         7WRnSF9eVwR040pihzy37Ka9Hh9QfpN31RbnrbU44wmDof9guaHsOTJYxWaDxmz4z6rd
         k3BLy3TBeWc8R89JzajrR/Lz6XuUpwTSHFoUJ6/yWGPPFS47DCD/coyEFLPbBXJKAi7Q
         pAlw==
X-Forwarded-Encrypted: i=1; AJvYcCXiSbMC0Z4YwY+SS31hjLeHFInepRpYefRMZ63qCVtiz/6ukUOFbE7bW3gsquEqXi/HHh0qPOexwDubPJUBA1PROpcG
X-Gm-Message-State: AOJu0Yxkx0U41PYOQIMXb6VirMUHPACk9a8qiADs6zM9vf7DqRgDAfvm
	r4ytB6+SEayMnYu+qn7U4P4TCg/+2tqSBgj2cODmQxLmGwccv4to25hkLs1hNOSdi6FvYTI/aN3
	SPC/NsHUSPcRhWQ0bp6gyCxDoDHeMpZdup+g=
X-Google-Smtp-Source: AGHT+IF1tF6KES+wGxmHkYiEfYkRI+kKffPGKKeC+CWHfELzwgLjmdYxjKBs33YEUD8OesYCPs4D+GR20S63CjrbgY8=
X-Received: by 2002:a05:6000:1245:b0:33b:66a0:4a85 with SMTP id
 j5-20020a056000124500b0033b66a04a85mr6339523wrx.64.1707781947520; Mon, 12 Feb
 2024 15:52:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZcqYNrktYhHFTtzH@debian.debian> <CAP01T74dQAt1UUGkUazx17XAj7k3LCMvw8Y+_rKzwH8eUao75g@mail.gmail.com>
 <CALrw=nGU-gBihe-08rJaxdwpRPQLBPLEQn5q+aBwzLKZ4Go+JQ@mail.gmail.com>
 <CAADnVQ+EL71GN6z3RnSBX5jfCmD9f5T9WN=sr_k+JmZzOOLqPg@mail.gmail.com> <CAP01T74t_w0sDaDV5zf3RsZNQg0Hz1XEYw2myOML0L=6afCjsg@mail.gmail.com>
In-Reply-To: <CAP01T74t_w0sDaDV5zf3RsZNQg0Hz1XEYw2myOML0L=6afCjsg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 12 Feb 2024 15:52:16 -0800
Message-ID: <CAADnVQLgC8wc5v8sSt=ZxAqLhwoPWXcwwLpSQwKAgaWvuuhF_g@mail.gmail.com>
Subject: Re: Page faults in tracepoint caused by aliased pointer
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Ignat Korchagin <ignat@cloudflare.com>, Yan Zhai <yan@cloudflare.com>, bpf <bpf@vger.kernel.org>, 
	kernel-team <kernel-team@cloudflare.com>, Jakub Sitnicki <jakub@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 3:42=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Tue, 13 Feb 2024 at 00:34, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, Feb 12, 2024 at 3:16=E2=80=AFPM Ignat Korchagin <ignat@cloudfla=
re.com> wrote:
> > >
> > > [288931.217143][T109754] CPU: 4 PID: 109754 Comm: bpftrace Not tainte=
d
> > > 6.6.16+ #10
> >
> > ...
> > > [288931.217143][T109754]  ? copy_from_kernel_nofault+0x1d/0xe0
> > > [288931.217143][T109754]  bpf_probe_read_compat+0x6a/0x90
> > >
> > > And Jakub CCed here did it for 6.8.0-rc2+
> >
> > I suspect something is broken in your kernels.
> > Above is doing generic copy_from_kernel_nofault(),
> > so one should be able to crash the kernel without any bpf.
> >
> > We have this in selftests/bpf:
> > __weak noinline struct file *bpf_testmod_return_ptr(int arg)
> > {
> >         static struct file f =3D {};
> >
> >         switch (arg) {
> >         case 1: return (void *)EINVAL;          /* user addr */
> >         case 2: return (void *)0xcafe4a11;      /* user addr */
> >         case 3: return (void *)-EINVAL;         /* canonical, but inval=
id */
> >         case 4: return (void *)(1ull << 60);    /* non-canonical and in=
valid */
> >         case 5: return (void *)~(1ull << 30);   /* trigger extable */
> >         case 6: return &f;                      /* valid addr */
> >         case 7: return (void *)((long)&f | 1);  /* kernel tricks */
> >         default: return NULL;
> >         }
> > }
> > where we check that extables setup by JIT for bpf progs are working cor=
rectly.
> > You should see the kernel crashing when you just run bpf selftests.
>
> I agree, this appears unrelated to BPF since it is happening when
> using copy_from_kernel_nofault (which should be jumping to the Efault
> label instead of the oops), but I think it's not specific to some
> custom kernel. I can reproduce it on my dev machine on top of bpf-next
> as well, and another machine with Ubuntu's generic 6.5 kernel for
> 24.04. And I think Ignat tried it on the mainline 6.8-rc2 as well.

Then it must be vsyscall address that this series are fixing:
https://patchwork.kernel.org/project/netdevbpf/patch/20240202103935.3154011=
-3-houtao@huaweicloud.com/

We're still waiting on x86 maintainers to ack them.

