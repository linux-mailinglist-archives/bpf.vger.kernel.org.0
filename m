Return-Path: <bpf+bounces-10577-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 227C27A9CA2
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 21:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3416E2845AE
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 19:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA1266DC2;
	Thu, 21 Sep 2023 18:34:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21295513B4
	for <bpf@vger.kernel.org>; Thu, 21 Sep 2023 18:34:34 +0000 (UTC)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40DA1DA21F
	for <bpf@vger.kernel.org>; Thu, 21 Sep 2023 11:31:22 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9adb9fa7200so284179866b.0
        for <bpf@vger.kernel.org>; Thu, 21 Sep 2023 11:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695321081; x=1695925881; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=z37WjdyoqytJ5EK0Y6Vbt/drMAv8xvko1Ju9K9owCOs=;
        b=bfYmHK5xyNz4uy6LAb+r2zJ0Q5jOpOZhBNJMS9md/W+Pgi/Y+vmxaK8hRKTv18BWRc
         mweKej2wfHrkdbvmC5qydFP+8gJIb5O1Mo8TK7UJ+xb28imDxS2Lri8s7QL3OH8bvy0x
         A4gXhu4HsLR3mVTjdIQXP44lJTma8FilHResBgLEAdxk84DZpl47sAVdZvf8abH6DwLl
         egYFl6Xbe8brJsaZgSC02ynW33thYM7nwwhXdxEPfP53A6qDk6dv6L5tz3PnzXOwU52v
         DAwlY7TZf0CAAoConQxeqh+Btlja7WfvjskVeWn5sgBL2zFRihMMcdq/eIDbL98kw1Xk
         vLaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695321081; x=1695925881;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z37WjdyoqytJ5EK0Y6Vbt/drMAv8xvko1Ju9K9owCOs=;
        b=CKaXbSQ/5FQmZxSXubRFiLgs89CCGrWqSVn4bjck5vN5dIUuEhIdl/AzyDy4+Z6nE1
         aK5TurIyvUBMCYItLWvScq9c/DbZEwxOL2Rh+6tcOEfqPTNUkH9weiCn03s0KsLGBzJE
         ZZtHV1YSNGpAPpoitTK90XZSxo+UBXTGmM4lk1LZc5lU4bRCWKufz1FnLqwWn4dla7ln
         vf9D++BVPhkaamY50m25OdBjLvhHCoYNx9EmAZSlxoHhxfx2GD+fFODXRfFi9gLnVwxL
         ptV5net4WoSNIELQ0IN/Hr5S5G0sLCS8SgjuyRwJyOufj/5fL04i0YCitjxUKCN0LsTH
         AlCQ==
X-Gm-Message-State: AOJu0Yz/bVm7V0/OeYzYz7ttRIKSx2SEespXy/T0Lah10uNTNgBPy6Ei
	7tVquh0cfHeKC3Ub0451iMQWywnunfc5giXh
X-Google-Smtp-Source: AGHT+IFhS1LeUd3IHpeK1DJBSuKeWHphDs/ZRBVLs8x7ILIih/nmqOc9LGFbhTbACM64motDO85AeQ==
X-Received: by 2002:a05:6000:1182:b0:31c:8c5f:877e with SMTP id g2-20020a056000118200b0031c8c5f877emr6816674wrx.33.1695299761921;
        Thu, 21 Sep 2023 05:36:01 -0700 (PDT)
Received: from localhost (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id p22-20020a05600c205600b003fbe4cecc3bsm4662593wmg.16.2023.09.21.05.36.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Sep 2023 05:36:01 -0700 (PDT)
From: Puranjay Mohan <puranjay12@gmail.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Ilya
 Leoshkevich <iii@linux.ibm.com>
Subject: Re: [PATCH bpf-next v2 01/10] bpf: Disable zero-extension for
 BPF_MEMSX
In-Reply-To: <20230919101336.2223655-2-iii@linux.ibm.com>
References: <20230919101336.2223655-1-iii@linux.ibm.com>
 <20230919101336.2223655-2-iii@linux.ibm.com>
Date: Thu, 21 Sep 2023 12:35:57 +0000
Message-ID: <mb61pleczk8k2.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Ilya Leoshkevich <iii@linux.ibm.com> writes:

> On the architectures that use bpf_jit_needs_zext(), e.g., s390x, the
> verifier incorrectly inserts a zero-extension after BPF_MEMSX, leading
> to miscompilations like the one below:
>
>       24:       89 1a ff fe 00 00 00 00 "r1 = *(s16 *)(r10 - 2);"       # zext_dst set
>    0x3ff7fdb910e:       lgh     %r2,-2(%r13,%r0)                        # load halfword
>    0x3ff7fdb9114:       llgfr   %r2,%r2                                 # wrong!
>       25:       65 10 00 03 00 00 7f ff if r1 s> 32767 goto +3 <l0_1>   # check_cond_jmp_op()
>
> Disable such zero-extensions. The JITs need to insert sign-extension
> themselves, if necessary.
>
> Suggested-by: Puranjay Mohan <puranjay12@gmail.com>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  kernel/bpf/verifier.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index a7178ecf676d..614bf3fa4fd5 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -3114,7 +3114,7 @@ static bool is_reg64(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  
>  	if (class == BPF_LDX) {
>  		if (t != SRC_OP)
> -			return BPF_SIZE(code) == BPF_DW;
> +			return BPF_SIZE(code) == BPF_DW || BPF_MODE(code) == BPF_MEMSX;
>  		/* LDX source must be ptr. */
>  		return true;
>  	}
> -- 
> 2.41.0

Reviewed-by: Puranjay Mohan <puranjay12@gmail.com>

Thanks for this.
Puranjay

