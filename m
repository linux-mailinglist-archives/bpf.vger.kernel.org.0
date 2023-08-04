Return-Path: <bpf+bounces-6925-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA6F76F792
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 04:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15C3128241A
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 02:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DABB01119;
	Fri,  4 Aug 2023 02:11:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DA515A4
	for <bpf@vger.kernel.org>; Fri,  4 Aug 2023 02:11:32 +0000 (UTC)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D768D4697
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 19:11:06 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-768054797f7so131879885a.2
        for <bpf@vger.kernel.org>; Thu, 03 Aug 2023 19:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1691115056; x=1691719856;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+3U++cEq45L7iITV+zLwLaldo0Na07T+o+hHDfRRKC4=;
        b=ayC0Day7CXdP53wwIDs0tv4bKX6RYBEbt+WDQyLb8tpMqzB8hUHeS+pZ/fmXrx4qpA
         3JkEy7VvFQFPwmFiZrOcgMEo3fzpW+ldBC+JO6eugwsbDr7vJSjP1/35CxXsN0MB0Irt
         mkx9hB89+CUahHSi5pi8nO9KgVUWFgp8tr4jlCEdJmhvewPu4OWQqZ3baJYZwvTPdBfy
         +HdxqmvQtuuS7UKmZq8wZJhY55hKFLVGi3/KRn4eaZy7GtYIOEbVuJ5qIJOIr+oSnw4f
         I7cK7giGeGjDDUCgXif5SspsldvYp/giTIrzSG6SdHe7tpD9OaruV+cA9piG0QSIk91/
         G56g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691115056; x=1691719856;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+3U++cEq45L7iITV+zLwLaldo0Na07T+o+hHDfRRKC4=;
        b=EDwlL8cuZT23SIxIjUhCxJ2zFugrCcI9q8Sa1WYRCYt+w7WMgq+GR+zbAOCI/tXR2x
         v2jx6YCQm35cdreIsA+JK77Upc2agMgwgbemHMSFruPJpOBBfrZSlnedgU+mOkXvBJ0D
         feuPiLgLGzJ4up2g1pOks0xuyCDvS+rVbXCjfkwzIs03vlq990SCTLbXwQf/ncbGJKmx
         qyARtbBT4if6rOkQEYNPNyzPjR1k9sPzDvAn1mk+uUxcK8IRkKH7UMEREDo2S05vJTii
         YSsGPx9Jk/Zs/wdDQi+5D2TfSHUxM3+EgK/yyOAolCrmIMWLKim2Cu9NuZDOU06UWOn9
         6CXQ==
X-Gm-Message-State: AOJu0YxNVJYPVTViFIpdl17t7Iq0+UAt4ardqD4sakNA7pjMotTGHuP2
	7wb3eOVTHC14zQaQtAzsCcEWNw==
X-Google-Smtp-Source: AGHT+IG+6EaYMDmn7R52Jc4ascni7z5WQFwfR/PJzZqWfgRRzwdONmN63Q30hGcwUi7GhkBgKxKI9A==
X-Received: by 2002:a05:620a:1918:b0:76c:a187:13be with SMTP id bj24-20020a05620a191800b0076ca18713bemr687807qkb.33.1691115056542;
        Thu, 03 Aug 2023 19:10:56 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id g6-20020a655806000000b0055c558ac4edsm369499pgr.46.2023.08.03.19.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 19:10:56 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Thu, 03 Aug 2023 19:10:28 -0700
Subject: [PATCH 03/10] RISC-V: Refactor jump label instructions
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230803-master-refactor-instructions-v4-v1-3-2128e61fa4ff@rivosinc.com>
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

Use shared instruction definitions in insn.h instead of manually
constructing them.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/include/asm/insn.h  |  2 +-
 arch/riscv/kernel/jump_label.c | 13 ++++---------
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/riscv/include/asm/insn.h b/arch/riscv/include/asm/insn.h
index 04f7649e1add..124ab02973a7 100644
--- a/arch/riscv/include/asm/insn.h
+++ b/arch/riscv/include/asm/insn.h
@@ -1984,7 +1984,7 @@ static __always_inline bool riscv_insn_is_branch(u32 code)
 		<< RVC_J_IMM_10_OFF) | \
 	(RVC_IMM_SIGN(x_) << RVC_J_IMM_SIGN_OFF); })
 
-#define RVC_EXTRACT_BTYPE_IMM(x) \
+#define RVC_EXTRACT_BZ_IMM(x) \
 	({typeof(x) x_ = (x); \
 	(RVC_X(x_, RVC_BZ_IMM_2_1_OPOFF, RVC_BZ_IMM_2_1_MASK) \
 		<< RVC_BZ_IMM_2_1_OFF) | \
diff --git a/arch/riscv/kernel/jump_label.c b/arch/riscv/kernel/jump_label.c
index e6694759dbd0..fdaac2a13eac 100644
--- a/arch/riscv/kernel/jump_label.c
+++ b/arch/riscv/kernel/jump_label.c
@@ -9,11 +9,9 @@
 #include <linux/memory.h>
 #include <linux/mutex.h>
 #include <asm/bug.h>
+#include <asm/insn.h>
 #include <asm/patch.h>
 
-#define RISCV_INSN_NOP 0x00000013U
-#define RISCV_INSN_JAL 0x0000006fU
-
 void arch_jump_label_transform(struct jump_entry *entry,
 			       enum jump_label_type type)
 {
@@ -26,13 +24,10 @@ void arch_jump_label_transform(struct jump_entry *entry,
 		if (WARN_ON(offset & 1 || offset < -524288 || offset >= 524288))
 			return;
 
-		insn = RISCV_INSN_JAL |
-			(((u32)offset & GENMASK(19, 12)) << (12 - 12)) |
-			(((u32)offset & GENMASK(11, 11)) << (20 - 11)) |
-			(((u32)offset & GENMASK(10,  1)) << (21 -  1)) |
-			(((u32)offset & GENMASK(20, 20)) << (31 - 20));
+		insn = RVG_OPCODE_JAL;
+		riscv_insn_insert_jtype_imm(&insn, (s32)offset);
 	} else {
-		insn = RISCV_INSN_NOP;
+		insn = RVG_OPCODE_NOP;
 	}
 
 	mutex_lock(&text_mutex);

-- 
2.34.1


