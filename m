Return-Path: <bpf+bounces-27938-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA208B3C94
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 18:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63DEE1F24045
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 16:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8C0152DED;
	Fri, 26 Apr 2024 16:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TLJbSRWb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C031FC4
	for <bpf@vger.kernel.org>; Fri, 26 Apr 2024 16:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714148139; cv=none; b=h3NGI36UdrT39LgBwaAx4tz+D283OiRdBtqt9nxxHvGDW15NVx3xSJ2tQux6BybWMmptZLDRKz3IytDwcEpbT2wwkKMhXfss4mb3ubfZ9R150bIv9QUWMJn5b3X0QEhaoWj+iSGgI8t+0MRRQMURlPMV5mKAsxNlDXnpzHzGXHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714148139; c=relaxed/simple;
	bh=U7cy+aH+Xnpdl6uTCa30erNHs3pZf5sgjvSPJZEIrA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PZfxCy2rxYSomaMzzVvO9SOdElAY2gmkAMS1mKV/ftBHmNHbVKe6DNibiKC8xQPs8S5uLZ7IUPIZdG5goBMQPagZ21fl2hmPO7h/69dgDW8R1t9uPqGEus7QzOKmNOsjktw9/4vd59kUQnfford5rx7O8xOlA4tZQkHV8zm4qLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TLJbSRWb; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2a5ef566c7aso2063611a91.1
        for <bpf@vger.kernel.org>; Fri, 26 Apr 2024 09:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714148137; x=1714752937; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pMWebnNi5NyPAzc9VdFdPOGHvE+7IdjLUrW+F6tSl0w=;
        b=TLJbSRWbAtpJuzIohaXSrNZyln3vjX5jin1Z691wi1D5/V9V/C7GoOWUMH7jJgtqc/
         1TXChpE5RxatsR1CU2J7XKzeE4kSBtEM7YlwYm9VA8sSymBy7UG9GQi00I3BpbaQUV9m
         xUHyOvy+1lleOZKB/Tj4+9LZ9dDakzgMvNV1b1bUG73HMShZZgmstgfm8oP6Gwu60R9g
         T+WB7t53FYpkE5FUPln2X7Y8PjMiUsaK4dkRFpRSTwmbZDUu/h5OokmITFc+yvma9QL+
         rFRZsO2gFPXsa2hBcbGbSH5pELkk9PWsbxRaEW9+7AP3dB0gu190dDPe+6OlrsQmryxm
         vDdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714148137; x=1714752937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pMWebnNi5NyPAzc9VdFdPOGHvE+7IdjLUrW+F6tSl0w=;
        b=Htsx/i/GQoCWNKyknPcxk0eA63DRmg3Rif7BvbP2qOqv1th0BHW9hdLN7wviVlBkrM
         +fvgE43mK6gmc2Eb38o6GVrmz7xPEn0xwsUfrIFx4qpcRAAZnGxfzYSEn/Z9Jx2FVoIp
         aUW/cZ3WOcYv0N7UuSZG5N7UYDZhqFkL09bOB5QoN/ArRSi52NMdHFyOI/4RuHqnpZk9
         VXyuyE8XoIZfs6KHpGgpOUlXIlNP79CgfIp8c9GHq25RKTToSD9qOlSAm4GzJP0/GQ0d
         dcCKHyj24UakX5UXQSTuABOhC/SztSZj5VibP8xBzl+yqlnUHT+dQn2XOLnP2hCfIzvC
         B3/A==
X-Gm-Message-State: AOJu0Yw8ICAlAWQAe6Qdg87IN4qT5aeodicvEmGe+/eB2lfsgP5k/BAR
	CxHGykD58SWa+wTPYLVN82Z0nE9r3NGbg6wV4Y/SaDumtUT0N0PiPFYLLn7lTGoMdYkBNMpS3j7
	4c5DDAlMqaBsCHVJ+Oeun1r0UlNK14Hya
X-Google-Smtp-Source: AGHT+IFR/6hHY9XVSJnJ7bQTm0+1zTfz6x550vOHwsrLvmUcW2z60ASzr+W/byX6hQhS1XLGil4Cazx3qOPMBy5UxIw=
X-Received: by 2002:a17:90a:ed03:b0:2ab:a825:ae5 with SMTP id
 kq3-20020a17090aed0300b002aba8250ae5mr3074350pjb.22.1714148136794; Fri, 26
 Apr 2024 09:15:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426092214.16426-1-jose.marchesi@oracle.com>
In-Reply-To: <20240426092214.16426-1-jose.marchesi@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 26 Apr 2024 09:15:24 -0700
Message-ID: <CAEf4BzY14jZkUUgkZb3A88KguX6=7pJLhNZ3T1H-Hde7raLb6A@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: avoid casts from pointers to enums in bpf_tracing.h
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc: bpf@vger.kernel.org, david.faust@oracle.com, cupertino.miranda@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 2:22=E2=80=AFAM Jose E. Marchesi
<jose.marchesi@oracle.com> wrote:
>
> The BPF_PROG, BPF_KPROBE and BPF_KSYSCALL macros defined in
> tools/lib/bpf/bpf_tracing.h use a clever hack in order to provide a
> convenient way to define entry points for BPF programs as if they were
> normal C functions that get typed actual arguments, instead of as
> elements in a single "context" array argument.
>
> For example, PPF_PROGS allows writing:
>
>   SEC("struct_ops/cwnd_event")
>   void BPF_PROG(cwnd_event, struct sock *sk, enum tcp_ca_event event)
>   {
>         bbr_cwnd_event(sk, event);
>         dctcp_cwnd_event(sk, event);
>         cubictcp_cwnd_event(sk, event);
>   }
>
> That expands into a pair of functions:
>
>   void ____cwnd_event (unsigned long long *ctx, struct sock *sk, enum tcp=
_ca_event event)
>   {
>         bbr_cwnd_event(sk, event);
>         dctcp_cwnd_event(sk, event);
>         cubictcp_cwnd_event(sk, event);
>   }
>
>   void cwnd_event (unsigned long long *ctx)
>   {
>         _Pragma("GCC diagnostic push")
>         _Pragma("GCC diagnostic ignored \"-Wint-conversion\"")
>         return ____cwnd_event(ctx, (void*)ctx[0], (void*)ctx[1]);
>         _Pragma("GCC diagnostic pop")
>   }
>
> Note how the 64-bit unsigned integers in the incoming CTX get casted
> to a void pointer, and then implicitly converted to whatever type of
> the actual argument in the wrapped function.  In this case:
>
>   Arg1: unsigned long long -> void * -> struct sock *
>   Arg2: unsigned long long -> void * -> enum tcp_ca_event
>
> The behavior of GCC and clang when facing such conversions differ:
>
>   pointer -> pointer
>
>     Allowed by the C standard.
>     GCC: no warning nor error.
>     clang: no warning nor error.
>
>   pointer -> integer type
>
>     [C standard says the result of this conversion is implementation
>      defined, and it may lead to unaligned pointer etc.]
>
>     GCC: error: integer from pointer without a cast [-Wint-conversion]
>     clang: error: incompatible pointer to integer conversion [-Wint-conve=
rsion]
>
>   pointer -> enumerated type
>
>     GCC: error: incompatible types in assigment (*)
>     clang: error: incompatible pointer to integer conversion [-Wint-conve=
rsion]
>
> These macros work because converting pointers to pointers is allowed,
> and converting pointers to integers also works provided a suitable
> integer type even if it is implementation defined, much like casting a
> pointer to uintptr_t is guaranteed to work by the C standard.  The
> conversion errors emitted by both compilers by default are silenced by
> the pragmas.
>
> However, the GCC error marked with (*) above when assigning a pointer
> to an enumerated value is not associated with the -Wint-conversion
> warning, and it is not possible to turn it off.
>
> This is preventing building the BPF kernel selftests with GCC.
>
> This patch fixes this by avoiding intermediate casts to void*,
> replaced with casts to `uintptr', which is an integer type capable of
> safely store a BPF pointer, much like the standard uintptr_t.
>
> Tested in bpf-next master.
> No regressions.
>
> Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: david.faust@oracle.com
> Cc: cupertino.miranda@oracle.com
> ---
>  tools/lib/bpf/bpf_tracing.h | 80 ++++++++++++++++++++-----------------
>  1 file changed, 43 insertions(+), 37 deletions(-)
>
> diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
> index 1c13f8e88833..1098505a89c7 100644
> --- a/tools/lib/bpf/bpf_tracing.h
> +++ b/tools/lib/bpf/bpf_tracing.h
> @@ -4,6 +4,12 @@
>
>  #include "bpf_helpers.h"
>
> +/* The following integer unsigned type must be able to hold a pointer.
> +   It is used in the macros below in order to avoid eventual casts
> +   from pointers to enum values, since these are rejected by GCC.  */
> +
> +typedef unsigned long long uintptr;
> +

hold on, we didn't talk about adding new typedefs. This bpf_tracing.h
header is included into tons of user code, so we should avoid adding
extra global definitions and typedes. Please just use (unsigned long
long) explicitly everywhere.

Also please check CI failures ([0]).

  [0] https://github.com/kernel-patches/bpf/actions/runs/8846180836/job/242=
91582343

pw-bot: cr

>  /* Scan the ARCH passed in from ARCH env variable (see Makefile) */
>  #if defined(__TARGET_ARCH_x86)
>         #define bpf_target_x86
> @@ -523,9 +529,9 @@ struct pt_regs;
>  #else
>
>  #define BPF_KPROBE_READ_RET_IP(ip, ctx)                                 =
           \
> -       ({ bpf_probe_read_kernel(&(ip), sizeof(ip), (void *)PT_REGS_RET(c=
tx)); })
> +       ({ bpf_probe_read_kernel(&(ip), sizeof(ip), (uintptr)PT_REGS_RET(=
ctx)); })
>  #define BPF_KRETPROBE_READ_RET_IP(ip, ctx)                              =
   \
> -       ({ bpf_probe_read_kernel(&(ip), sizeof(ip), (void *)(PT_REGS_FP(c=
tx) + sizeof(ip))); })
> +       ({ bpf_probe_read_kernel(&(ip), sizeof(ip), (uintptr)(PT_REGS_FP(=
ctx) + sizeof(ip))); })

these are passing pointers, please don't just do a blind find&replace

>
>  #endif
>

[...]

