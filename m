Return-Path: <bpf+bounces-34997-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B58934C5A
	for <lists+bpf@lfdr.de>; Thu, 18 Jul 2024 13:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 717F61C219AE
	for <lists+bpf@lfdr.de>; Thu, 18 Jul 2024 11:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2914136657;
	Thu, 18 Jul 2024 11:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kuc3dqbH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50BA84DF5;
	Thu, 18 Jul 2024 11:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721301838; cv=none; b=hkc3YAnCtSbHvXVVGqyteuREb/JpRm9Vbvp9WLXde9iMmeJl9Vmh8QjKM+2x6+EkHKHZgjP5t56FKwmVfeZAtDRefT2Ayw1GIF3dc01qUPm9MWD8DlJJICWFQYUJlmoBPF0KTDcrkA4O0jl302IVjdqdJOIEu9EeeckNWm6NH2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721301838; c=relaxed/simple;
	bh=FwJX+xwUnW9pkx83N4AVhoBtlboTFynyRd7gffnCtsA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AXt3zblzXFW0PL2k8+juHq4+MEPeYDOHXxsOp27CvaQGlnhue8zgKaxux+3sLkjzjCcKILfjdnS2z2MQOkpnL4PNJlCh+7D3U8TovKNCt01zkBdD7JTmi6RmWhvfOMcTdYFcxkAbySqBM65IDXjlB6psBueiMrDI01dCwt+eEi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kuc3dqbH; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52ea929ea56so453156e87.0;
        Thu, 18 Jul 2024 04:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721301835; x=1721906635; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TNGEw9G6hlNTVMdR62vu/xQv+QUz3CjemylwMV9az8k=;
        b=Kuc3dqbHHP5kSbyH9LnWr0GybD3lpvl/V7jLAWMt+8V4RQO6K4MNvVsVq2mcijmQL9
         MZxxj79iMryCCH9kZNXSTPPYBP5JAfcj/z6/YVDU4CvrNg697zeaoXeRmiSkIeMgvJ2Z
         pWfd/kUt0GwtHmfZJYeMZs6zu4ADOnYJrxI66a5PunRLXR1z0sN7VbJN+fGXBwQtDAA4
         i07UXzbm3B0Bz2h3DHqiDKPd47j++4aScdrC+VSVuVUyMzv8XW9FvoPJRkt8SgJptgCu
         fXWnjAq4tagrtED4sUwCDod239JizJDrX5DEgGHvnkrRh16+rgq/+CdERjEGh+HaR8Vt
         Q9Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721301835; x=1721906635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TNGEw9G6hlNTVMdR62vu/xQv+QUz3CjemylwMV9az8k=;
        b=Wjqgg5AmD1ZjJQEOL8Jl4dLQ9iYeMH5zlrfFlcqC4ZgmJrrnELld4L4HkTBqLxFUfh
         zEmjtTTvt2yLBWMXeKAoE4b5hoJ/eeBMEBqeuQPLuB4paFIrGdWXzw3JNCbKtHFZyAq2
         w7d4t/ERMoDH0y2YFqYDtTVSdDn/4rqhuilg/TZ4Sc3I09f2ZqH8n49giOgwnxygNfTi
         CwE1mkeddbVTBlT8Lm4UFOBhAhiFby+5vM5r/EUHdIZm/pSx3iSIl9kzJhvNLTF87GaF
         2etZ4Q0k1fNhc6A7tSxXPcO0JdAzrkJa8hGgoQQr8h8mwionWYP7fcFKJlRdOwYiN7BC
         /ONQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDtEz+/ZWr8uGVA/9iYxEaa1EPmcCYi0YvbNiF6etUCpZ1aWGfvBw4p9koJqj5wlUOuo616gb9ZcefB++fOcWxtv/eDG76rh5idkBf0LgrQZXzoMLJNud985Qj
X-Gm-Message-State: AOJu0Yye6THKIbv1cPYzydTGZZ07UWZdV4/7J2j3ogwkiEZjUyjytpYz
	8kzLiYHANC4FoSpmJUqO6kYgUeowdMCjJMoyibZ15NcH3iXvfysiTFKmm34EdopOilxq9dYNnBM
	NqZ6g3+DFrACXJH+Q8uHVo47IrvU=
X-Google-Smtp-Source: AGHT+IECtAPb0b+f9uyt7XeNHB8NxpEMb/mRqIdTbc31O8qaqw/qDOITzaOuREwSVl1EcYl0JHjvTmk9M3UhOTlx/4M=
X-Received: by 2002:a05:6512:6c8:b0:52c:e1cd:39bd with SMTP id
 2adb3069b0e04-52ee53a7937mr3831477e87.13.1721301834382; Thu, 18 Jul 2024
 04:23:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701114659.39539-1-pjy@amazon.com> <2024071834-chalice-renewal-3412@gregkh>
In-Reply-To: <2024071834-chalice-renewal-3412@gregkh>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Thu, 18 Jul 2024 13:23:43 +0200
Message-ID: <CANk7y0h0rw5B4L0Xuv-9+Efnt88FmKWHCnhzNm7Tr7xoGi3=EA@mail.gmail.com>
Subject: Re: [PATCH 5.10] arm64/bpf: Remove 128MB limit for BPF JIT programs
To: Greg KH <greg@kroah.com>
Cc: Puranjay Mohan <pjy@amazon.com>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Russell King <russell.king@oracle.com>, 
	Alan Maguire <alan.maguire@oracle.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, 
	stable@vger.kernel.org, puranjay@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 8:55=E2=80=AFAM Greg KH <greg@kroah.com> wrote:
>
> On Mon, Jul 01, 2024 at 11:46:59AM +0000, Puranjay Mohan wrote:
> > From: Russell King <russell.king@oracle.com>
> >
> > [ Upstream commit b89ddf4cca43f1269093942cf5c4e457fd45c335 ]
> >
> > Commit 91fc957c9b1d ("arm64/bpf: don't allocate BPF JIT programs in mod=
ule
> > memory") restricts BPF JIT program allocation to a 128MB region to ensu=
re
> > BPF programs are still in branching range of each other. However this
> > restriction should not apply to the aarch64 JIT, since BPF_JMP | BPF_CA=
LL
> > are implemented as a 64-bit move into a register and then a BLR instruc=
tion -
> > which has the effect of being able to call anything without proximity
> > limitation.
> >
> > The practical reason to relax this restriction on JIT memory is that 12=
8MB of
> > JIT memory can be quickly exhausted, especially where PAGE_SIZE is 64KB=
 - one
> > page is needed per program. In cases where seccomp filters are applied =
to
> > multiple VMs on VM launch - such filters are classic BPF but converted =
to
> > BPF - this can severely limit the number of VMs that can be launched. I=
n a
> > world where we support BPF JIT always on, turning off the JIT isn't alw=
ays an
> > option either.
> >
> > Fixes: 91fc957c9b1d ("arm64/bpf: don't allocate BPF JIT programs in mod=
ule memory")
> > Suggested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > Signed-off-by: Russell King <russell.king@oracle.com>
> > Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> > Tested-by: Alan Maguire <alan.maguire@oracle.com>
> > Link: https://lore.kernel.org/bpf/1636131046-5982-2-git-send-email-alan=
.maguire@oracle.com
> > [Replace usage of in_bpf_jit() with is_bpf_text_address()]
> > Signed-off-by: Puranjay Mohan <pjy@amazon.com>
> > ---
> >  arch/arm64/include/asm/extable.h | 9 ---------
> >  arch/arm64/include/asm/memory.h  | 5 +----
> >  arch/arm64/kernel/traps.c        | 2 +-
> >  arch/arm64/mm/extable.c          | 3 ++-
> >  arch/arm64/mm/ptdump.c           | 2 --
> >  arch/arm64/net/bpf_jit_comp.c    | 7 ++-----
> >  6 files changed, 6 insertions(+), 22 deletions(-)
> >
>
> This is reported to cause problems:
>         https://lore.kernel.org/r/CA+G9fYtfAbfcQ9J9Hzq-e6yoBVG3t_iHZ=3DbS=
2eJbO_aiOcquXQ@mail.gmail.com
> so I will drop it now.

I will try to debug this!

> How did you test this?

I tested this on an AWS Graviton based EC2 instance by loading 16000
BPF programs.

> And if you really need this feature, why not move to a more modern
> kernel version?
> thanks,
>
> greg k-h


Thanks,
Puranjay

