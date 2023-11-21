Return-Path: <bpf+bounces-15543-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 884C87F3384
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 17:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E5031C21C9C
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 16:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5600A56762;
	Tue, 21 Nov 2023 16:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2AZEhr3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09202191
	for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 08:20:32 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9fcfd2a069aso361184166b.1
        for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 08:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700583630; x=1701188430; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=P6xBvDJbbJUuSqFRkWNcuODJPSTkt1N+vdY67UrEPTw=;
        b=K2AZEhr3d9k5GmEoUkYm2YBj6er1BIAafu9hidqiaSbM6KVAVldZuclRQGUABM6nGI
         g/UR6gttjBEvZqgqihdf6ir1KAQRvS7lmjRxA4o9xG9wFeJiEHcgRnEsgg05l3GJwD00
         RYzh8+db55ypFfT+kEjNWQRTSAchlqcXQgpEY6w/nXMWAnYFD9B7rwg9XqXm295Yj30f
         mpDsQRcD5ssBwNXYjug7oY2QVP0zQ/p1p9ErDr4MryAwTCcY63uWMyu8wvaClFFRjmbp
         ic5oZ8sqsDerJU2vy5kwx7X8dh7HUdZK2OGVD6BgQ7qqAzPBXGS2ORxaWfL19+Sc8QyP
         tp0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700583630; x=1701188430;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P6xBvDJbbJUuSqFRkWNcuODJPSTkt1N+vdY67UrEPTw=;
        b=KpL4pgHRy3k7oLBgurZv217OYvyv5AOzyUPOuCUOW1B98onOIDuRspc1fjzmIrGohM
         c9q3iRAbyVBEIIXi0jsRd0WdW0IRx2U5ENHJIm8I+cB0/DvtuxMqgKJB35fzuZN/u7PS
         RtWk59YX/8XRS9nuXt0bBl/8EL7G2YaokIS29oKlXmVPJGX79kit3e9dRa6h1km92hAO
         PmeJGYTEek3IYjbbAXjXIBYy6snuRaDXheWYSEszl9SsJskPf80l2oqgGxxAaz9ZzqCB
         xegHBYMTDsThwx4MfnoBLh0IkH8TKPPjKSGKREnaAA95WbPMQnvMH6PziLbbCeOOaNh8
         ajYQ==
X-Gm-Message-State: AOJu0YwWI4X4IcBh1WFS0z6ODXjCjCSSQrLK06pGuelZb5fGNSPmIV6m
	Ncxf1g298oN3R3gsxp3CdsVCjZ/knPw=
X-Google-Smtp-Source: AGHT+IEtZ2GBEJof9UvnNYwq6qbk6llRCNE+6q1P2nBcpsVolb6LGqfAwVNXUMrTDA03B2Gl2PWVYA==
X-Received: by 2002:a17:906:4f:b0:9e6:9abb:d3cc with SMTP id 15-20020a170906004f00b009e69abbd3ccmr7470107ejg.1.1700583630166;
        Tue, 21 Nov 2023 08:20:30 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id d2-20020a170906640200b0099bd7b26639sm5409254ejm.6.2023.11.21.08.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 08:20:29 -0800 (PST)
Message-ID: <0aea72de9d5d283be329e1f95fa8373bcba5e86a.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 07/10] selftests/bpf: validate zero
 preservation for sub-slot loads
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com
Date: Tue, 21 Nov 2023 18:20:28 +0200
In-Reply-To: <20231121002221.3687787-8-andrii@kernel.org>
References: <20231121002221.3687787-1-andrii@kernel.org>
	 <20231121002221.3687787-8-andrii@kernel.org>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2023-11-20 at 16:22 -0800, Andrii Nakryiko wrote:
[...]

> +SEC("raw_tp")
> +__log_level(2)
> +__success
> +__naked void partial_stack_load_preserves_zeros(void)
> +{
> +	asm volatile (
> +		/* fp-8 is all STACK_ZERO */
> +		"*(u64 *)(r10 -8) =3D 0;"

This fails when compiled with llvm-16, bpf st assembly support is only
present in llvm-18. If we want to preserve support for llvm-16 this
test would require ifdefs or the following patch:

@@ -3,6 +3,7 @@
=20
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
+#include "../../../include/linux/filter.h"
 #include "bpf_misc.h"
=20
 struct {
@@ -510,7 +511,7 @@ __naked void partial_stack_load_preserves_zeros(void)
 {
        asm volatile (
                /* fp-8 is all STACK_ZERO */
-               "*(u64 *)(r10 -8) =3D 0;"
+               ".8byte %[fp8_st_zero];"
=20
                /* fp-16 is const zero register */
                "r0 =3D 0;"
@@ -559,7 +560,8 @@ __naked void partial_stack_load_preserves_zeros(void)
                "r0 =3D 0;"
                "exit;"
        :
-       : __imm_ptr(single_byte_buf)
+       : __imm_ptr(single_byte_buf),
+         __imm_insn(fp8_st_zero, BPF_ST_MEM(BPF_DW, BPF_REG_FP, -8, 0))
        : __clobber_common);
 }


> +		/* fp-16 is const zero register */
> +		"r0 =3D 0;"
> +		"*(u64 *)(r10 -16) =3D r0;"
> +
> +		/* load single U8 from non-aligned STACK_ZERO slot */
> +		"r1 =3D %[single_byte_buf];"
> +		"r2 =3D *(u8 *)(r10 -1);"
> +		"r1 +=3D r2;" /* this should be fine */

Question: the comment suggests that adding something other than
          zero would be an error, however error would only be
          reported if *r1 is attempted, maybe add such access?
          E.g. "*(u8 *)(r1 + 0) =3D r2;"?

[...]




