Return-Path: <bpf+bounces-6923-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88DE776F78C
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 04:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41392282421
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 02:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D7D1386;
	Fri,  4 Aug 2023 02:11:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7F2110A
	for <bpf@vger.kernel.org>; Fri,  4 Aug 2023 02:11:23 +0000 (UTC)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B561844AF
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 19:10:58 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id 006d021491bc7-56ce156bd37so1045918eaf.3
        for <bpf@vger.kernel.org>; Thu, 03 Aug 2023 19:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1691115054; x=1691719854;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=efS36dkbCzja1DEoOkKk5twnSGIQYzSPz7GFgwV0rps=;
        b=sL5L+XGZXxz3uilHLZ9996rABpzv96OCLn70c9kreiKgPg+WH3KJroL9cVLj2fBjI4
         NQe8+w7CLAox+ot9c6Sx0ktR3iYP5P+c8pN85u54Rsy06KDa4GcfJccDlv6X4vB+zHUn
         fOSxh1hOUBlo6UgFcJDC47IQVz1f4EDcD0TlBOGU/8cvax961M2jcrcuGJPlBRjyBApH
         Yr9yABf/BnVF1c20z4GgGSV/40DAWyj5SVhDT+9mC7k6UVziYmYdgL3moyY6QrCvZd73
         4FZ3hUQCNUuO/ok3JHJqIRfA/yxktc+meR9K37rZmH55b5iR6aKlCC4Gg1xr0MwsaNDG
         Pekw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691115054; x=1691719854;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=efS36dkbCzja1DEoOkKk5twnSGIQYzSPz7GFgwV0rps=;
        b=SeUhjLs/fxAooJxYCVQ2pVxnMNwrQZZJA+OuB4V8MkxrJ2mGx4xEr1ZMK5n01SnYvw
         c3Mwo3mZX1GkImv418v4JyWSJEeXSQwqBOdvRBGvCcXTjvFcXXtq0o4hb2VLnq2NCfu2
         +8XjyLurWhyORzyHfhntqWYqAMzQfHJWEES4EGg08Ee+9rSkvMFv8lwZYeYUimL9T35Q
         eKEOoyHMaApzIRz5xTLN25qTgZ34XY16Mrhsl0iAKLwYjvAuupcpGm1qT2KgG6ibibrX
         auKADYVYVls9aX2qASj85zpbp5dv52Jbn/WcAPXuUjMpQ6OCHjGcykskvlvamx9vWq5L
         Ab7w==
X-Gm-Message-State: AOJu0Yx9h9g9PRB3s4d8l7HmymqqacOX6tnyWFk76xejTkz4q/FKGtuS
	HMiI4Tg2F0/Mg7qzYEB6GRGdgA==
X-Google-Smtp-Source: AGHT+IHkkquc+vtnTAEnaVFOIeS3KymV7yesjBryf/XUZfueFQfWUT4yuX+ZoQdYenvjMp3+aT7A/A==
X-Received: by 2002:a05:6358:c603:b0:134:ded4:294 with SMTP id fd3-20020a056358c60300b00134ded40294mr441125rwb.17.1691115054417;
        Thu, 03 Aug 2023 19:10:54 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id g6-20020a655806000000b0055c558ac4edsm369499pgr.46.2023.08.03.19.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 19:10:53 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Thu, 03 Aug 2023 19:10:27 -0700
Subject: [PATCH 02/10] RISC-V: vector: Refactor instructions
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230803-master-refactor-instructions-v4-v1-2-2128e61fa4ff@rivosinc.com>
References: <20230803-master-refactor-instructions-v4-v1-0-2128e61fa4ff@rivosinc.com>
In-Reply-To: <20230803-master-refactor-instructions-v4-v1-0-2128e61fa4ff@rivosinc.com>
To: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, bpf@vger.kernel.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
 Jason Baron <jbaron@akamai.com>, Steven Rostedt <rostedt@goodmis.org>, 
 Ard Biesheuvel <ardb@kernel.org>, Anup Patel <anup@brainfault.org>, 
 Atish Patra <atishp@atishpatra.org>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, 
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, 
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>, 
 Luke Nelson <luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>, 
 Nam Cao <namcaov@gmail.com>, Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Use instructions in insn.h

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/kernel/vector.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/vector.c b/arch/riscv/kernel/vector.c
index d67a60369e02..1433d70abdd7 100644
--- a/arch/riscv/kernel/vector.c
+++ b/arch/riscv/kernel/vector.c
@@ -18,7 +18,6 @@
 #include <asm/csr.h>
 #include <asm/elf.h>
 #include <asm/ptrace.h>
-#include <asm/bug.h>
 
 static bool riscv_v_implicit_uacc = IS_ENABLED(CONFIG_RISCV_ISA_V_DEFAULT_ENABLE);
 
@@ -56,7 +55,7 @@ static bool insn_is_vector(u32 insn_buf)
 	 * All V-related instructions, including CSR operations are 4-Byte. So,
 	 * do not handle if the instruction length is not 4-Byte.
 	 */
-	if (unlikely(GET_INSN_LENGTH(insn_buf) != 4))
+	if (unlikely(INSN_LEN(insn_buf) != 4))
 		return false;
 
 	switch (opcode) {

-- 
2.34.1


