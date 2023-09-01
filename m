Return-Path: <bpf+bounces-9119-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE9178FF90
	for <lists+bpf@lfdr.de>; Fri,  1 Sep 2023 16:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9DE3281B6E
	for <lists+bpf@lfdr.de>; Fri,  1 Sep 2023 14:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B5BBE68;
	Fri,  1 Sep 2023 14:57:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBD6AD27
	for <bpf@vger.kernel.org>; Fri,  1 Sep 2023 14:57:40 +0000 (UTC)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF08010CF
	for <bpf@vger.kernel.org>; Fri,  1 Sep 2023 07:57:38 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-31c3df710bdso1677921f8f.1
        for <bpf@vger.kernel.org>; Fri, 01 Sep 2023 07:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693580257; x=1694185057; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T5y8qeWmsCYKE0J0cZyEJDkTOpTVZo6R+P8t4HwUj+w=;
        b=oSpiGAnhUCMD2f2mppFf/v9/nPfiILsFnVmH0uMnQFVKtPnJUVD560yliFz48RFUdm
         svUXsmU4jNoCitoL7J31/tmRpZrLIZq1idHhgjcMc9jQhz9iB7DRAmmUQu48QX+p52zc
         D9JOd02HSWXfODP7qe8hp21zSoE66szX4a5XG3/lv6CvDO+erNvgUAwFr3AzCLfy59cZ
         4OgVanFjrQq4UCo+g2qPa3K0Drz6u0ieQlUUkcitBOg4Bj4/OF2gEshNFob1GkPLBoNT
         WFlO0+bekoAeAgzbGIxXZ2u9u1C5d9jVj1fotCysfb6G/WV56vyzRd8G96Py+FyRmVr6
         Zi3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693580257; x=1694185057;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T5y8qeWmsCYKE0J0cZyEJDkTOpTVZo6R+P8t4HwUj+w=;
        b=iIFqWMTIfw/JwYgANcLidpQM1hN2fcnW26vZx4ea6OBxuYJi81PZVdFf7xHJI+2is7
         z2VAzWYne2yDq5LYBIu+HZwyF8mmc78FExMgkmjIQvsPbvemmPjD0MJb3pv/YmuHrIas
         huO7L/N44ocnjjd7KKyE7iN3EjOvSBtzIBr7K99SuoXR7B5NIrxBrU2MrbM/UFJOqJRA
         P2uhDE0XzA9VMkiXg2qlRukSyY7fWzgrgORZa2YzFEBV+IJXy4/0LWlLg4MdQz6O0H5z
         rq5LQoRrYNkSkigW5SYEa+Q8n4vi38FpqbM3wy7tw6UKfPol5es7LHUD14m8kBNSobEn
         us7g==
X-Gm-Message-State: AOJu0YzB1pNLEgtDXFl0+MN4I9RJ3QnfKHmoJgNqM9QxVtKBB6I+7eTX
	s+mEfEMdkG/rvua/NvGRM0snC+xvT8BVVY83eUI=
X-Google-Smtp-Source: AGHT+IGezmvPWcCblHuFeaKt+vWQC9B6dVRZeInZk9MZadKHXlUdFq1/AEOvLztHScP8LhXX923O/Q==
X-Received: by 2002:a5d:51c7:0:b0:317:dd94:ed38 with SMTP id n7-20020a5d51c7000000b00317dd94ed38mr2115050wrv.42.1693580256922;
        Fri, 01 Sep 2023 07:57:36 -0700 (PDT)
Received: from dev-dsk-pjy-1a-76bc80b3.eu-west-1.amazon.com (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id l5-20020adfe585000000b0031c71693449sm5457811wrm.1.2023.09.01.07.57.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Sep 2023 07:57:36 -0700 (PDT)
From: Puranjay Mohan <puranjay12@gmail.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Alexei Starovoitov <ast@kernel.org>,  Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>,
  bpf@vger.kernel.org,  Heiko Carstens <hca@linux.ibm.com>,  Vasily Gorbik
 <gor@linux.ibm.com>,  Alexander Gordeev <agordeev@linux.ibm.com>, Kumar
 Kartikeya Dwivedi <memxor@gmail.com>, Puranjay Mohan <puranjay12@gmail.com>
Subject: Re: [PATCH bpf-next 01/11] bpf: Disable zero-extension for BPF_MEMSX
In-Reply-To: <CANk7y0iNnOCZ_KmXBH_xJTG=BKzkDM_jZ+hc_NXcQbbZj-c33Q@mail.gmail.com>
	(Puranjay Mohan's message of "Fri, 1 Sep 2023 16:19:53 +0200")
References: <20230830011128.1415752-1-iii@linux.ibm.com>
	<20230830011128.1415752-2-iii@linux.ibm.com>
	<CANk7y0iNnOCZ_KmXBH_xJTG=BKzkDM_jZ+hc_NXcQbbZj-c33Q@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
Date: Fri, 01 Sep 2023 14:56:14 +0000
Message-ID: <mb61p5y4u3ptd.fsf@amazon.com>
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

On Fri, Sep 01 2023, Puranjay Mohan wrote:

> The problem here is that reg->subreg_def should be set as DEF_NOT_SUBREG for
> registers that are used as destination registers of BPF_LDX |
> BPF_MEMSX. I am seeing
> the same problem on ARM32 and was going to send a patch today.
>
> The problem is that is_reg64() returns false for destination registers
> of BPF_LDX | BPF_MEMSX.
> But BPF_LDX | BPF_MEMSX always loads a 64 bit value because of the
> sign extension so
> is_reg64() should return true.
>
> I have written a patch that I will be sending as a reply to this.
> Please let me know if that makes sense.
>

The check_reg_arg() function will mark reg->subreg_def = DEF_NOT_SUBREG for destination
registers if is_reg64() returns true for these registers. My patch below make is_reg64()
return true for destination registers of BPF_LDX with mod = BPF_MEMSX. I feel this is the
correct way to fix this problem.

Here is my patch:

--- 8< ---
From cf1bf5282183cf721926ab14d968d3d4097b89b8 Mon Sep 17 00:00:00 2001
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Fri, 1 Sep 2023 11:18:59 +0000
Subject: [PATCH bpf] bpf: verifier: mark destination of sign-extended load as
 64 bit

The verifier can emit instructions to zero-extend destination registers
when the register is being used to keep 32 bit values. This behaviour is
enabled only when the JIT sets bpf_jit_needs_zext() -> true. In the case
of a sign extended load instruction, the destination register always has a
64-bit value, therefore the verifier should not emit zero-extend
instructions for it.

Change is_reg64() to return true if the register under consideration is a
destination register of LDX instruction with mode = BPF_MEMSX.

Fixes: 1f9a1ea821ff ("bpf: Support new sign-extension load insns")
Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
 kernel/bpf/verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index bb78212fa5b2..93f84b868ccc 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3029,7 +3029,7 @@ static bool is_reg64(struct bpf_verifier_env *env, struct bpf_insn *insn,
 
 	if (class == BPF_LDX) {
 		if (t != SRC_OP)
-			return BPF_SIZE(code) == BPF_DW;
+			return (BPF_SIZE(code) == BPF_DW || BPF_MODE(code) == BPF_MEMSX);
 		/* LDX source must be ptr. */
 		return true;
 	}
-- 
2.39.2

