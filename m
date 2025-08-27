Return-Path: <bpf+bounces-66613-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66BF1B376EA
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 03:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 047367C0D20
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 01:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4B91A0BFD;
	Wed, 27 Aug 2025 01:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lxyRPrmh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0951DB95E;
	Wed, 27 Aug 2025 01:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756258067; cv=none; b=ZqYf5nXGs7RhAxrnAyCf4nBEdl3OScIUn8kQjPabXNR1+IEI1jcJpw5GHiXzzP1HfXXrNRT0baFKSEqYnIo9U99lBa3O3IsQla0NZ7FXC2GOd2W1iMqv9KIK7rYnlcbNi49nr50tmBvlni1k+8GWEXS4rdtwh7rjgDRHZ0U5VTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756258067; c=relaxed/simple;
	bh=gI6Q4Kyq1mNp+NmEvmHD8jeVYE/sXBX5uM2/qQUg5K8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AWLuj3SSc1l9Nfov6j7scFy5QMJ7QF1q42koxnwEJfOoLa/JSudFE9XDIN2E85JnwHAXxyujFDfJ//hwVah1fb/IC5QkSU9TAbczIppUnneZzfTLUcqf7MAJQqXGSSert4A8UBj7MuIucjM+60gpM6N/eFNoycC2c1JFcR3eNh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lxyRPrmh; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7451ee5e750so1572461a34.2;
        Tue, 26 Aug 2025 18:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756258064; x=1756862864; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YmiNjyEr+Wx48a8h5Fef3wHTELiSArVsPhkw4HBK1jY=;
        b=lxyRPrmhkzN7Ulv6gDIxmHxKgZWfmOWFQi2ox1pi6Uis4Ob6Sp2wbHaxakmMkqxQFL
         68/3N4vtXZrttYIjXk5PTrmZvFW9DV72MzUXaLyKp7JrVduOm1/bmCVHFwizVRYP//os
         3NrrEcq+LrE5nOdAcUQj2+/D4N3dQClDcKro8FvA1N5+Ul4KJyKs9xQ6wXhTCTI2hdta
         LbCAz7jXhc2QMvFCrx5U/8XHYLps/5quaSOPAn/y5zOH4dQrL/289BpbaILzfQEiqef8
         s9oM6akYRCDttMVjTWqKb9Q9lWWPtqvJZBpFQaltJWsbXghIvAUNK74d2igTsM9OC3P4
         GA5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756258064; x=1756862864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YmiNjyEr+Wx48a8h5Fef3wHTELiSArVsPhkw4HBK1jY=;
        b=j02YU+rHDc5vf8gLLTbrTyFuR52usGudUb5iNkWeRal5lLU0TmTsEnX+ipPgnXOs3y
         MIniZFOaDNPA4EC1q4NpOc/LN3JuVxM0YM/fd1vSTiMQMLhMvRFoNvqLPgdiIs4Whg4p
         J3FZJufobkH1Yg4VDP1S2Tde+Om9pJuORdIihzgQK5n0KI3zaDrXXK/43NaaueqPenEG
         gXi+ne5cHQ3s7xNKFX/nTTbFI+XV7yULM4QKPjFfllM8C9LcIUBFICNiOnw5hN253Nis
         oyZ2fQa6XjMRkijGlYlz/LVN9jFvURmVoO1NN7C7VpFgZRVkUwGhSVVWDdu5ugv1Sphc
         CEqw==
X-Forwarded-Encrypted: i=1; AJvYcCXeHNWSO5Mru8WzGsapvbjaBVSR6KTs8A154ABWGGIWq/6Y3jg7kLcaryStLTMVsZFYeRpXDFEKJl/PWAtg@vger.kernel.org, AJvYcCXx62Qd/CPk4h02Hte2elZkAcODKDp8ERHMdl1MhpbTe9ZR0U1wxoPDFvLNk6dLgtSJfOo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKm/crDs5kh6m9YZl2sE3ixvQQuiYFeQQpjGnkzYmrNs1g+UfP
	29oeZnqsJabhKNX/atHj98yxHbWk6yteuuQO+kzg7rI0H35nXGT4ehAaJaNxaydEKgpW9XkkRL2
	8Tx06YUFvCEszTrTJpQdmt+ucWZhpjnOAtjb2ga7W1Q==
X-Gm-Gg: ASbGncsLvrRcfrhryPYkgFGB6MRx819mkujlzjvN3MIfGUrhwDLRDVdSMvW5TKKWJqh
	Zw8A7/wCiLaN03dwD2UcKkQcO5Nh1lYJDNKMpTiKgb2RRXN7hXTCbLRvG4mPaAfxR0qp9skMAMY
	3mQs6zdyXwKpTMOhQxpC7NhJ7CwR/QA6FuF/mWi+aja2HXrsVLzi8WICRkDxEHvZzi73MfcIZAx
	3tctuc=
X-Google-Smtp-Source: AGHT+IEEyzDa8nMTU8gc2yQwg0keE1lzdDPmweJCAQoR33t4eLc21iOp+FGhfK9jEWkq1g7Rne8LNhsiwRAuf+gpFoc=
X-Received: by 2002:a05:6808:2392:b0:40b:9bd2:460e with SMTP id
 5614622812f47-437852c299amr11217178b6e.22.1756258063675; Tue, 26 Aug 2025
 18:27:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826064906.10683-1-yangtiezhu@loongson.cn>
In-Reply-To: <20250826064906.10683-1-yangtiezhu@loongson.cn>
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Wed, 27 Aug 2025 09:27:32 +0800
X-Gm-Features: Ac12FXznrgZke7iN7qtaD0Bfbegdo_XMoR0UrmGOBz2O9QkgvfaFRMlTIBGZOAg
Message-ID: <CAEyhmHQJcCvy2TPv7nwT87yS6y698WrECwd+xA9RjsCVmrVXvw@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: BPF: Optimize sign-extention mov instructions
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>, bpf@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 2:49=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> For 8-bit and 16-bit sign-extention mov instructions, it can use the nati=
ve
> instructions ext.w.b and ext.w.h directly, no need to use the temporary t=
1
> register, just remove the redundant operations.
>
> Here are the test results:
>
>   # modprobe test_bpf test_range=3D81,84
>   # dmesg -t | tail -5
>   test_bpf: #81 ALU_MOVSX | BPF_B jited:1 5 PASS
>   test_bpf: #82 ALU_MOVSX | BPF_H jited:1 5 PASS
>   test_bpf: #83 ALU64_MOVSX | BPF_B jited:1 5 PASS
>   test_bpf: #84 ALU64_MOVSX | BPF_H jited:1 5 PASS
>   test_bpf: Summary: 4 PASSED, 0 FAILED, [4/4 JIT'ed]
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  arch/loongarch/net/bpf_jit.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index abfdb6bb5c38..7072db18c6cd 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -527,13 +527,11 @@ static int build_insn(const struct bpf_insn *insn, =
struct jit_ctx *ctx, bool ext
>                         emit_zext_32(ctx, dst, is32);
>                         break;
>                 case 8:
> -                       move_reg(ctx, t1, src);
> -                       emit_insn(ctx, extwb, dst, t1);
> +                       emit_insn(ctx, extwb, dst, src);
>                         emit_zext_32(ctx, dst, is32);
>                         break;
>                 case 16:
> -                       move_reg(ctx, t1, src);
> -                       emit_insn(ctx, extwh, dst, t1);
> +                       emit_insn(ctx, extwh, dst, src);
>                         emit_zext_32(ctx, dst, is32);
>                         break;
>                 case 32:
> --

Acked-by: Hengqi Chen <hengqi.chen@gmail.com>

> 2.42.0
>

