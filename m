Return-Path: <bpf+bounces-17833-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07CE88132EC
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 15:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A3E71C21A0E
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 14:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE49759E44;
	Thu, 14 Dec 2023 14:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SO0PMO0M"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A1C9C
	for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 06:21:35 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-50e0ba402b4so4159840e87.1
        for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 06:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702563694; x=1703168494; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/q+kOazTm7615E8pB4q67yWPah/yHlPryL6A2SBbNcM=;
        b=SO0PMO0Myl1f/hQuvIp9GN1dytAGz2Ekx1Gd4Oj62+TDhl+CfoaVK1fru6F+JfZGSm
         msvUYdfOqmvflmOFBDcNlmxHrk6GUBDSyBiB7si7M2gIGovx+U9up4QV8bQdxcJ6Is6n
         UNgW1yxcNyydQXQTavPxK8POuOAKcNZDEwJ80zu169ppf8knvILPD2ZOf7n8POuDafZV
         zgTjNR/O3F+BR2z+BiZjViSlgU4oXDfxBPJmO1WQocGOKPBlfa7ZNo4za7gb70g4igyz
         BHLYgj/iBhg7Hxr0+68jbj5YpQuZMiIFUdbe7qiC4zZ+o2SGrQa5FRIe6YY2hZ54W8Ue
         YpGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702563694; x=1703168494;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/q+kOazTm7615E8pB4q67yWPah/yHlPryL6A2SBbNcM=;
        b=Bg1D6jNWXyBN84ML+oPjdwlHrOtsThPlPvaaYLx9Dy7HDdUxF2EC4gDHGJMM26SV+T
         jMmcKGxyH6M7hbpRDVDXy2u8+0oLW0Ld4RONC4dQfwVvOVubxWqI6EgY7fZ4DMxetlGv
         bWSL22DAZ3HKrEBr/5FmXfqfc6hmgWe1Bmzg8U9/6FeA+rCZwxtKo46HNlXBoqxvjHaH
         fYcl+T2DYuEAOHiWe2kzL4RwuOHpzKrtRjV/2mY5pwC5XD0/qmcZvSXHHEksNP5uNxQg
         WyGOt6bsJQODCLpFmrvtfmViVSyaRucHFzZ6+u3B7IuGYk1kY1PlAmbCy2KRN4c+DRWh
         4z8Q==
X-Gm-Message-State: AOJu0YwphAbk5NvtiSlN9md6xHeSihQaLs5v9D2CcErhgYVgWn0us+/S
	De+K1p3vfb0paGwwfwrx6ws=
X-Google-Smtp-Source: AGHT+IGRMfSPDUp44sd9xf+vc/3DwOU6EGU6S1QKCc9inlgBsOu7rqOpEQPHjAGxYamIiGpIxVrd+A==
X-Received: by 2002:a19:2d45:0:b0:50d:180a:b800 with SMTP id t5-20020a192d45000000b0050d180ab800mr4583753lft.10.1702563693690;
        Thu, 14 Dec 2023 06:21:33 -0800 (PST)
Received: from localhost (tor-exit-8.zbau.f3netze.de. [185.220.100.247])
        by smtp.gmail.com with ESMTPSA id ul5-20020a170907ca8500b00a1f7b445f5dsm8171506ejc.124.2023.12.14.06.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 06:21:33 -0800 (PST)
Date: Thu, 14 Dec 2023 16:21:14 +0200
From: Maxim Mikityanskiy <maxtram95@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@kernel.org, kernel-team@meta.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: Re: [PATCH v4 bpf-next 09/10] selftests/bpf: validate precision
 logic in partial_stack_load_preserves_zeros
Message-ID: <ZXsPWvgt6xWtUizn@mail.gmail.com>
References: <20231205184248.1502704-1-andrii@kernel.org>
 <20231205184248.1502704-10-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205184248.1502704-10-andrii@kernel.org>
X-Spam-Level: *

Hi Andrii,

I'm preparing a series for submission [1], and it started failing on
this selftest on big endian after I rebased over your series. Can we
discuss (see below) to figure out whether it's a bug in your patch or
whether I'm missing something?

On Tue, 05 Dec 2023 at 10:42:47 -0800, Andrii Nakryiko wrote:
> Enhance partial_stack_load_preserves_zeros subtest with detailed
> precision propagation log checks. We know expect fp-16 to be spilled,
> initially imprecise, zero const register, which is later marked as
> precise even when partial stack slot load is performed, even if it's not
> a register fill (!).
> 
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  .../selftests/bpf/progs/verifier_spill_fill.c    | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
> index 41fd61299eab..df4920da3472 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
> @@ -495,6 +495,22 @@ char single_byte_buf[1] SEC(".data.single_byte_buf");
>  SEC("raw_tp")
>  __log_level(2)
>  __success
> +/* make sure fp-8 is all STACK_ZERO */
> +__msg("2: (7a) *(u64 *)(r10 -8) = 0          ; R10=fp0 fp-8_w=00000000")
> +/* but fp-16 is spilled IMPRECISE zero const reg */
> +__msg("4: (7b) *(u64 *)(r10 -16) = r0        ; R0_w=0 R10=fp0 fp-16_w=0")
> +/* and now check that precision propagation works even for such tricky case */
> +__msg("10: (71) r2 = *(u8 *)(r10 -9)         ; R2_w=P0 R10=fp0 fp-16_w=0")

Why do we require R2 to be precise at this point? It seems the only
reason it's marked as precise here is because it was marked at line 6,
and the mark was never cleared: when R2 was overwritten at line 10, only
__mark_reg_const_zero was called, and no-one cleared the flag, although
R2 was overwritten.

Moreover, if I replace r2 with r3 in this block, it doesn't get the
precise mark, as I expect.

Preserving the flag looks like a bug to me, but I wanted to double-check
with you.

The context why it's relevant to my series: after patch [3], this fill
goes to the then-branch on big endian (not to the else-branch, as
before), and I copy the register with copy_register_state, which
preserves the precise flag from the stack, not from the old value of r2.

> +__msg("11: (0f) r1 += r2")
> +__msg("mark_precise: frame0: last_idx 11 first_idx 0 subseq_idx -1")
> +__msg("mark_precise: frame0: regs=r2 stack= before 10: (71) r2 = *(u8 *)(r10 -9)")
> +__msg("mark_precise: frame0: regs= stack=-16 before 9: (bf) r1 = r6")
> +__msg("mark_precise: frame0: regs= stack=-16 before 8: (73) *(u8 *)(r1 +0) = r2")
> +__msg("mark_precise: frame0: regs= stack=-16 before 7: (0f) r1 += r2")
> +__msg("mark_precise: frame0: regs= stack=-16 before 6: (71) r2 = *(u8 *)(r10 -1)")
> +__msg("mark_precise: frame0: regs= stack=-16 before 5: (bf) r1 = r6")
> +__msg("mark_precise: frame0: regs= stack=-16 before 4: (7b) *(u64 *)(r10 -16) = r0")
> +__msg("mark_precise: frame0: regs=r0 stack= before 3: (b7) r0 = 0")
>  __naked void partial_stack_load_preserves_zeros(void)
>  {
>  	asm volatile (
> -- 
> 2.34.1
> 
> 

[1]: https://github.com/kernel-patches/bpf/pull/6132
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/kernel/bpf/verifier.c?id=c838fe1282df540ebf6e24e386ac34acb3ef3115#n4806
[3]: https://github.com/kernel-patches/bpf/pull/6132/commits/0e72ee541180812e515b2bf3ebd127b6e670fd59

