Return-Path: <bpf+bounces-21803-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A96398522B1
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 00:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EAB71F22E5F
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 23:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E46F4F8BD;
	Mon, 12 Feb 2024 23:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNapZMTR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FD551C21
	for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 23:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707781326; cv=none; b=TFXYjNCWW0m5LkOOKPvlLDGzZaWGOXM0ZebSKk802xi8rXm6/zBcPzS0nHPeo45mST1dvVsq3q0kSfKKo16E/Ha/HufCEGR1t7Pg6oZ9gydq34FPiE1V0rhxYO75+smBmkUrF2LHVwfe+8aE4VrC1UDdc/jI+F5DnAiN7JGYGcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707781326; c=relaxed/simple;
	bh=4oMmkP3Yhlsw7JhQMAW5mW5+dQpHCTGNzzfbfWvK4aM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mt6O8efyiVUxTMIYtKs1KUfLJRQ0bcZrUDrTSrMt20BK1SuO9Nn+MmRZT2SiG8pYa8poSVxeCG/+4b4I0WYf73Iga+/xaPkyNUZCdvyg4/qB6ccp+/+T9nkqIe2aMYvJnScaK0/heophl7KfI861rONKSyGP+bJ5HqUiptgdpk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kNapZMTR; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-a3566c0309fso454552266b.1
        for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 15:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707781323; x=1708386123; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+whHTG+on+5YuUgHAWiCMsFmHNN3BAJozUs1BJCEars=;
        b=kNapZMTRlGEig4rWNQXPPjEv5R+jrtb9iT23P4vgsy3Z69ptPj7acBBPfJyaTvMYma
         44AUnFooj2/HJRBJtXnhcszqlr1eq0Ngyl8BUSi2osrEoGLBaEYazjTNV00wZmJdbulg
         VTUra4Bzc3RJd7jVqMoGNlnxnTOY7FxjDvDUnFG50qRxdHp4XYxgu1MuheWGVBORZOy/
         jO0puN2HuLXD+Ybl2uGvofYhQI4y57w1cqTgQwNT/uYWcvQuhU3pem6JvryXVS/c3+8u
         I4M0jOTcZFRg6w4LQdDge2w9NGHusWequY+wYwrVAWXiI3lEHq5bOo0TPX8maFGYnifn
         KFzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707781323; x=1708386123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+whHTG+on+5YuUgHAWiCMsFmHNN3BAJozUs1BJCEars=;
        b=SMmvOclg6SnUOPLZGPWt11/p0+roUmbYa3z8i9o2C/ZsX+B/1p8zgdSAzDRwpzgzO/
         +LOKLwvxRQO3a7ueFz1XNi34RFWStvNm4TawF80g3bY9HRMguyBuP0+edtzJBDnpBxVj
         dW6dB2VpcJdiO4buQkcIvPx8w18EtEvWAc3sm8wCt4MJtjpvvVh0WYcht9x9PCkaLvAu
         kE2+kUgWQvgIMWYYm/QYXUYfoiXagt76jLJ/TyGaXU5M9ECniEWW3KuhPzUMlY0XgZRK
         qjkmNwCx6lyOk2R63NrOgwywkhWY5+ipuPCHgPLsTsnceA6FDZyaPccUoorf5/HezydF
         XPdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjWp133vO7pBU5caLF/zu5A4YGrGXarEUitrLXEo5wgyacNwBcqXo8k2dKQCgHyRy1ysTTLRzMQCCTDZdV0M7laxmd
X-Gm-Message-State: AOJu0YyEsDYMU/4BuCPGRVhidbve97qGFmSIRj9XxQq69fyWnrVzJ781
	pJm9OK/yOy1n5URyo3OJnvFbHcUBbF+aoTgFVLLZ6O9uyNU7m2CXGq0SBFdFMEBK7WrghbgLeEO
	Xb8NNiNLW9ukyxvygAuTYdMQxcP4o+wiNrI4=
X-Google-Smtp-Source: AGHT+IFiUCq7UBOD6e+E2o70i10AmDmy+L6k9uxfK40uZTb1DqAMaOsDXnIkF3Ud67xmyV47J9520sOPrreV1qFmxas=
X-Received: by 2002:a17:906:f88c:b0:a3c:8770:3795 with SMTP id
 lg12-20020a170906f88c00b00a3c87703795mr3153454ejb.15.1707781322961; Mon, 12
 Feb 2024 15:42:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZcqYNrktYhHFTtzH@debian.debian> <CAP01T74dQAt1UUGkUazx17XAj7k3LCMvw8Y+_rKzwH8eUao75g@mail.gmail.com>
 <CALrw=nGU-gBihe-08rJaxdwpRPQLBPLEQn5q+aBwzLKZ4Go+JQ@mail.gmail.com> <CAADnVQ+EL71GN6z3RnSBX5jfCmD9f5T9WN=sr_k+JmZzOOLqPg@mail.gmail.com>
In-Reply-To: <CAADnVQ+EL71GN6z3RnSBX5jfCmD9f5T9WN=sr_k+JmZzOOLqPg@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 13 Feb 2024 00:41:26 +0100
Message-ID: <CAP01T74t_w0sDaDV5zf3RsZNQg0Hz1XEYw2myOML0L=6afCjsg@mail.gmail.com>
Subject: Re: Page faults in tracepoint caused by aliased pointer
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Ignat Korchagin <ignat@cloudflare.com>, Yan Zhai <yan@cloudflare.com>, bpf <bpf@vger.kernel.org>, 
	kernel-team <kernel-team@cloudflare.com>, Jakub Sitnicki <jakub@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 13 Feb 2024 at 00:34, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Feb 12, 2024 at 3:16=E2=80=AFPM Ignat Korchagin <ignat@cloudflare=
.com> wrote:
> >
> > [288931.217143][T109754] CPU: 4 PID: 109754 Comm: bpftrace Not tainted
> > 6.6.16+ #10
>
> ...
> > [288931.217143][T109754]  ? copy_from_kernel_nofault+0x1d/0xe0
> > [288931.217143][T109754]  bpf_probe_read_compat+0x6a/0x90
> >
> > And Jakub CCed here did it for 6.8.0-rc2+
>
> I suspect something is broken in your kernels.
> Above is doing generic copy_from_kernel_nofault(),
> so one should be able to crash the kernel without any bpf.
>
> We have this in selftests/bpf:
> __weak noinline struct file *bpf_testmod_return_ptr(int arg)
> {
>         static struct file f =3D {};
>
>         switch (arg) {
>         case 1: return (void *)EINVAL;          /* user addr */
>         case 2: return (void *)0xcafe4a11;      /* user addr */
>         case 3: return (void *)-EINVAL;         /* canonical, but invalid=
 */
>         case 4: return (void *)(1ull << 60);    /* non-canonical and inva=
lid */
>         case 5: return (void *)~(1ull << 30);   /* trigger extable */
>         case 6: return &f;                      /* valid addr */
>         case 7: return (void *)((long)&f | 1);  /* kernel tricks */
>         default: return NULL;
>         }
> }
> where we check that extables setup by JIT for bpf progs are working corre=
ctly.
> You should see the kernel crashing when you just run bpf selftests.

I agree, this appears unrelated to BPF since it is happening when
using copy_from_kernel_nofault (which should be jumping to the Efault
label instead of the oops), but I think it's not specific to some
custom kernel. I can reproduce it on my dev machine on top of bpf-next
as well, and another machine with Ubuntu's generic 6.5 kernel for
24.04. And I think Ignat tried it on the mainline 6.8-rc2 as well.

