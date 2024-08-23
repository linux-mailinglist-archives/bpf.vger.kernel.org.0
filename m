Return-Path: <bpf+bounces-37911-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6A595C292
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 02:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD26F1C21F46
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 00:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14603D304;
	Fri, 23 Aug 2024 00:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LCAKsWfU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006EC182B9
	for <bpf@vger.kernel.org>; Fri, 23 Aug 2024 00:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724373939; cv=none; b=M9ozL6yfiSRN7M365BYnMhRP+wzEDYphPrK8lIzE7GOSM0sw9bcUaG8IOieZpQ/i9/VnecI4cAzWEVGh9o03GEUvTlopmwYsItltYk+MKg6PvuNxZkGHU2vIqvqjYMB1QxaCyp+TCSqZkZnUrMUkXMpAaALK0n2tw6y9Cffq32A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724373939; c=relaxed/simple;
	bh=ivi2fMpK94ljuHSFMQ2nzA+q6tMS0gaPzq71GpIUMWE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g/NEWJT9tIpqXlUDtjXC7HqE7StCiqI01kQbGy0yZ+lYb7fICARdQnSualfQjq7RVb/qy1JMjgEIBekml57kwTI0b/ZrdzKz68sfjauwKIU7D12dM7jPteMt1q5eW6wJytYsae1xe82oCYpc7mnY83ucDFIWRXPLTg/rfLYm1CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LCAKsWfU; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-429ec9f2155so10490955e9.2
        for <bpf@vger.kernel.org>; Thu, 22 Aug 2024 17:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724373936; x=1724978736; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mKN5Gn2D3LFRGb7Lc9m+oe85eaYGMkEJQbrnnwFwMv4=;
        b=LCAKsWfU+xKYPbrJdGg2FinPCRR5QfQi1z+8ydnlSvIkr/wnjhgAfqhbnl8lc/9ROm
         vakctgVu5y0W15AlCYUasuwAB+jDKfRdGPJXw09V5Cnd554Ccv1+lIGSFKkWES8gZ5/i
         LU3vLe2me1lTA1U/jhxvzPiV7lyeER4Whnd/8re4vI/ecrepcJPeWZ+8JSDX6WDxA2xa
         x0wAfTFt/+4Pc8WfL1+z+3nxhuzo3fIXS61siK1HdD2P4RfnyXRzt00BKXrYzuLcNPlO
         2fa63LcRPmq93jzwIPWKPMS/kuSscEpihWFkHKH8G8L3+c8YSiXrNnTdDi+PYltkN2F3
         LoZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724373936; x=1724978736;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mKN5Gn2D3LFRGb7Lc9m+oe85eaYGMkEJQbrnnwFwMv4=;
        b=fMtBl2MAw4CUWoocZXN8LXgTkeXwxQUx/rBgS/So30eFsZZ3rPzPDDcuORjNQ4XKDO
         1ZQ1w46Pc4HhBtTWAy3CXEAH2t21ucIIADGBCOKrI0Mlgn7D/VufZWF4mBc6BNw63/gM
         AoZOQM1yJO0pgymtYMkQVpjAviW2nez/6wL4uMwrJs9QVLgBxjwrrqU2XgD/w6YiiBMG
         N/Z0dUTpDXpeEy29aCwI+G/5qxr9WEY5+oZRWJk5ctNoQB2XxFd034xwkekOm2WbmEav
         +arPbz7D9HSrbjTo/Q6ndUIDdeMfrf8KdE58J2NfaaUqSYamRwlIPD0vauDvryYaN2mX
         a4Fg==
X-Gm-Message-State: AOJu0YyJEnNBpkrJUPBy/+OPG6NM1p4pN9bdRdcRPG1w+SavC1LicTIG
	IC/aQLhpLoNYgn179EDJctd2mtEvLMDZP70OF0KA3LEmdy+UyhmABrYK8GwdgT3jQ8qLj2yUoOa
	6v+DuOxad0TxulXd97ufkvOVLEdcDSpLp
X-Google-Smtp-Source: AGHT+IH6BJPLiSnkOxrPSJtRt+GPfmYz3B25VYCCSsCKQXsTDJdlpKi1sjRCV+dGFf+zVEZiNhDujaIlfrOf6/+hgkI=
X-Received: by 2002:a05:600c:1990:b0:428:e09d:3c with SMTP id
 5b1f17b1804b1-42acca00901mr3364785e9.33.1724373935802; Thu, 22 Aug 2024
 17:45:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823000552.2771166-1-linux@jordanrome.com>
 <CAADnVQKW0HepVOqjCeiDVAMfz-Yj0OYaNGiYJXJy5_JE3GVu5w@mail.gmail.com> <CA+QiOd6zG_5tP=aSJ1-e80RP8xa9chQ3HP5yHuAd5wi11LLgZw@mail.gmail.com>
In-Reply-To: <CA+QiOd6zG_5tP=aSJ1-e80RP8xa9chQ3HP5yHuAd5wi11LLgZw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 22 Aug 2024 17:45:24 -0700
Message-ID: <CAADnVQKdT5F4OPtz464ZoZQ_hGed9WYorpzc3Ga=hbtdp-yJgw@mail.gmail.com>
Subject: Re: [bpf-next v8 1/2] bpf: Add bpf_copy_from_user_str kfunc
To: Jordan Rome <linux@jordanrome.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>, 
	Kui-Feng Lee <sinquersw@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 5:22=E2=80=AFPM Jordan Rome <linux@jordanrome.com> =
wrote:
>
> On Thu, Aug 22, 2024 at 8:15=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Thu, Aug 22, 2024 at 5:06=E2=80=AFPM Jordan Rome <linux@jordanrome.c=
om> wrote:
> > >
> > > +/**
> > > + * bpf_copy_from_user_str() - Copy a string from an unsafe user addr=
ess
> > > + * @dst:             Destination address, in kernel space.  This buf=
fer must be at
> > > + *                   least @dst__szk bytes long.
> > > + * @dst__szk:        Maximum number of bytes to copy, including the =
trailing NUL.
> > > + * @unsafe_ptr__ign: Source address, in user space.
> > > + * @flags:           The only supported flag is BPF_F_PAD_ZEROS
> > > + *
> > > + * Copies a NUL-terminated string from userspace to BPF space. If us=
er string is
> > > + * too long this will still ensure zero termination in the dst buffe=
r unless
> > > + * buffer size is 0.
> > > + *
> > > + * If BPF_F_PAD_ZEROS flag is set, memset the tail of @dst to 0 on s=
uccess and
> > > + * memset all of @dst on failure.
> > > + */
> > > +__bpf_kfunc int bpf_copy_from_user_str(void *dst, u32 dst__szk, cons=
t void __user *unsafe_ptr__ign, u64 flags)
> >
> > Did you miss my previous comment re __szk vs __sz ?
> >
>
> Ah, yes, I did miss it. Will fix.
>
> > > +enum {
> > > +       BPF_F_PAD_ZEROS =3D (1ULL << 0),
> > > +};
> >
> > Pls give enum a name, so it's easier for CORE logic to detect the
> > presence of this feature in the kernel.
>
> How about 'bpf_copy_str_flags' ? As I imagine we will use this flag on
> 'bpf_copy_from_user_task_str', when I add that.

Maybe 'enum bpf_kfunc_flags' ?
since BPF_F_PAD_ZEROS is supposed to be generic and apply to various kfuncs=
.

