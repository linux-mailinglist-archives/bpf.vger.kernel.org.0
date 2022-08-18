Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B08A7597D41
	for <lists+bpf@lfdr.de>; Thu, 18 Aug 2022 06:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243243AbiHREY3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Aug 2022 00:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243341AbiHREYI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Aug 2022 00:24:08 -0400
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B045300A;
        Wed, 17 Aug 2022 21:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1660796648; x=1692332648;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VW3HIGgYxFAFoiz7vYhcWWx0hLr90CLY3OkcGq4WdIc=;
  b=b2jjEtUHF2XKi9gPMwexmNoeXBqNOOZln7jk0MW4qJsyfUlug39MCb9X
   WEhIFfWKZxANDrUEKPzagx7/RLLZiF/4PpxeUVdF8vJXuMjK1c1oUTPQM
   CaOt35MRnyszUm1sQ3Upq8D14TYCfzBDx18SWCbw87bMurJwVrCVPlPoO
   o=;
X-IronPort-AV: E=Sophos;i="5.93,245,1654560000"; 
   d="scan'208";a="234363655"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-7d0c7241.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2022 04:24:06 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2c-7d0c7241.us-west-2.amazon.com (Postfix) with ESMTPS id BE654448E3;
        Thu, 18 Aug 2022 04:24:04 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Thu, 18 Aug 2022 04:24:03 +0000
Received: from 88665a182662.ant.amazon.com.com (10.43.162.158) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.12;
 Thu, 18 Aug 2022 04:24:01 +0000
From:   Kuniyuki Iwashima <kuniyu@amazon.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
CC:     Kuniyuki Iwashima <kuniyu@amazon.com>,
        Kuniyuki Iwashima <kuni1840@gmail.com>, <bpf@vger.kernel.org>,
        <netdev@vger.kernel.org>
Subject: [PATCH v1 bpf 1/4] bpf: Fix data-races around bpf_jit_enable.
Date:   Wed, 17 Aug 2022 21:23:36 -0700
Message-ID: <20220818042339.82992-2-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220818042339.82992-1-kuniyu@amazon.com>
References: <20220818042339.82992-1-kuniyu@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.43.162.158]
X-ClientProxiedBy: EX13D43UWC002.ant.amazon.com (10.43.162.172) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

A sysctl variable bpf_jit_enable is accessed concurrently, and there is
always a chance of data-race.  So, all readers and a writer need some
basic protection to avoid load/store-tearing.

Fixes: 0a14842f5a3c ("net: filter: Just In Time compiler for x86-64")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 arch/arm/net/bpf_jit_32.c        | 2 +-
 arch/arm64/net/bpf_jit_comp.c    | 2 +-
 arch/mips/net/bpf_jit_comp.c     | 2 +-
 arch/powerpc/net/bpf_jit_comp.c  | 5 +++--
 arch/riscv/net/bpf_jit_core.c    | 2 +-
 arch/s390/net/bpf_jit_comp.c     | 2 +-
 arch/sparc/net/bpf_jit_comp_32.c | 5 +++--
 arch/sparc/net/bpf_jit_comp_64.c | 5 +++--
 arch/x86/net/bpf_jit_comp.c      | 2 +-
 arch/x86/net/bpf_jit_comp32.c    | 2 +-
 include/linux/filter.h           | 2 +-
 net/core/sysctl_net_core.c       | 4 ++--
 12 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
index 6a1c9fca5260..4b6b62a6fdd4 100644
--- a/arch/arm/net/bpf_jit_32.c
+++ b/arch/arm/net/bpf_jit_32.c
@@ -1999,7 +1999,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	}
 	flush_icache_range((u32)header, (u32)(ctx.target + ctx.idx));
 
-	if (bpf_jit_enable > 1)
+	if (READ_ONCE(bpf_jit_enable) > 1)
 		/* there are 2 passes here */
 		bpf_jit_dump(prog->len, image_size, 2, ctx.target);
 
diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 389623ae5a91..03bb40352d2c 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -1568,7 +1568,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	}
 
 	/* And we're done. */
-	if (bpf_jit_enable > 1)
+	if (READ_ONCE(bpf_jit_enable) > 1)
 		bpf_jit_dump(prog->len, prog_size, 2, ctx.image);
 
 	bpf_flush_icache(header, ctx.image + ctx.idx);
diff --git a/arch/mips/net/bpf_jit_comp.c b/arch/mips/net/bpf_jit_comp.c
index b17130d510d4..1e623ae7eadf 100644
--- a/arch/mips/net/bpf_jit_comp.c
+++ b/arch/mips/net/bpf_jit_comp.c
@@ -1012,7 +1012,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	flush_icache_range((unsigned long)header,
 			   (unsigned long)&ctx.target[ctx.jit_index]);
 
-	if (bpf_jit_enable > 1)
+	if (READ_ONCE(bpf_jit_enable) > 1)
 		bpf_jit_dump(prog->len, image_size, 2, ctx.target);
 
 	prog->bpf_func = (void *)ctx.target;
diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index 43e634126514..c71d1e94ee7e 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -122,6 +122,7 @@ bool bpf_jit_needs_zext(void)
 
 struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 {
+	int jit_enable = READ_ONCE(bpf_jit_enable);
 	u32 proglen;
 	u32 alloclen;
 	u8 *image = NULL;
@@ -263,13 +264,13 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 		}
 		bpf_jit_build_epilogue(code_base, &cgctx);
 
-		if (bpf_jit_enable > 1)
+		if (jit_enable > 1)
 			pr_info("Pass %d: shrink = %d, seen = 0x%x\n", pass,
 				proglen - (cgctx.idx * 4), cgctx.seen);
 	}
 
 skip_codegen_passes:
-	if (bpf_jit_enable > 1)
+	if (jit_enable > 1)
 		/*
 		 * Note that we output the base address of the code_base
 		 * rather than image, since opcodes are in code_base.
diff --git a/arch/riscv/net/bpf_jit_core.c b/arch/riscv/net/bpf_jit_core.c
index 737baf8715da..603b5b66379b 100644
--- a/arch/riscv/net/bpf_jit_core.c
+++ b/arch/riscv/net/bpf_jit_core.c
@@ -151,7 +151,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	}
 	bpf_jit_build_epilogue(ctx);
 
-	if (bpf_jit_enable > 1)
+	if (READ_ONCE(bpf_jit_enable) > 1)
 		bpf_jit_dump(prog->len, prog_size, pass, ctx->insns);
 
 	prog->bpf_func = (void *)ctx->insns;
diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index af35052d06ed..06897a4e9c62 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -1831,7 +1831,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 		fp = orig_fp;
 		goto free_addrs;
 	}
-	if (bpf_jit_enable > 1) {
+	if (READ_ONCE(bpf_jit_enable) > 1) {
 		bpf_jit_dump(fp->len, jit.size, pass, jit.prg_buf);
 		print_fn_code(jit.prg_buf, jit.size_prg);
 	}
diff --git a/arch/sparc/net/bpf_jit_comp_32.c b/arch/sparc/net/bpf_jit_comp_32.c
index b1dbf2fa8c0a..7c454b920250 100644
--- a/arch/sparc/net/bpf_jit_comp_32.c
+++ b/arch/sparc/net/bpf_jit_comp_32.c
@@ -326,13 +326,14 @@ do {	*prog++ = BR_OPC | WDISP22(OFF);		\
 void bpf_jit_compile(struct bpf_prog *fp)
 {
 	unsigned int cleanup_addr, proglen, oldproglen = 0;
+	int jit_enable = READ_ONCE(bpf_jit_enable);
 	u32 temp[8], *prog, *func, seen = 0, pass;
 	const struct sock_filter *filter = fp->insns;
 	int i, flen = fp->len, pc_ret0 = -1;
 	unsigned int *addrs;
 	void *image;
 
-	if (!bpf_jit_enable)
+	if (!jit_enable)
 		return;
 
 	addrs = kmalloc_array(flen, sizeof(*addrs), GFP_KERNEL);
@@ -743,7 +744,7 @@ cond_branch:			f_offset = addrs[i + filter[i].jf];
 		oldproglen = proglen;
 	}
 
-	if (bpf_jit_enable > 1)
+	if (jit_enable > 1)
 		bpf_jit_dump(flen, proglen, pass + 1, image);
 
 	if (image) {
diff --git a/arch/sparc/net/bpf_jit_comp_64.c b/arch/sparc/net/bpf_jit_comp_64.c
index fa0759bfe498..74cc1fa1f97f 100644
--- a/arch/sparc/net/bpf_jit_comp_64.c
+++ b/arch/sparc/net/bpf_jit_comp_64.c
@@ -1479,6 +1479,7 @@ struct sparc64_jit_data {
 
 struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 {
+	int jit_enable = READ_ONCE(bpf_jit_enable);
 	struct bpf_prog *tmp, *orig_prog = prog;
 	struct sparc64_jit_data *jit_data;
 	struct bpf_binary_header *header;
@@ -1549,7 +1550,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 		}
 		build_epilogue(&ctx);
 
-		if (bpf_jit_enable > 1)
+		if (jit_enable > 1)
 			pr_info("Pass %d: size = %u, seen = [%c%c%c%c%c%c]\n", pass,
 				ctx.idx * 4,
 				ctx.tmp_1_used ? '1' : ' ',
@@ -1596,7 +1597,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 		goto out_off;
 	}
 
-	if (bpf_jit_enable > 1)
+	if (jit_enable > 1)
 		bpf_jit_dump(prog->len, image_size, pass, ctx.image);
 
 	bpf_flush_icache(header, (u8 *)header + header->size);
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index c1f6c1c51d99..a5c7df7cab2a 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -2439,7 +2439,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 		cond_resched();
 	}
 
-	if (bpf_jit_enable > 1)
+	if (READ_ONCE(bpf_jit_enable) > 1)
 		bpf_jit_dump(prog->len, proglen, pass + 1, image);
 
 	if (image) {
diff --git a/arch/x86/net/bpf_jit_comp32.c b/arch/x86/net/bpf_jit_comp32.c
index 429a89c5468b..745f15a29dd3 100644
--- a/arch/x86/net/bpf_jit_comp32.c
+++ b/arch/x86/net/bpf_jit_comp32.c
@@ -2597,7 +2597,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 		cond_resched();
 	}
 
-	if (bpf_jit_enable > 1)
+	if (READ_ONCE(bpf_jit_enable) > 1)
 		bpf_jit_dump(prog->len, proglen, pass + 1, image);
 
 	if (image) {
diff --git a/include/linux/filter.h b/include/linux/filter.h
index a5f21dc3c432..ce8072626ccf 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1080,7 +1080,7 @@ static inline bool bpf_jit_is_ebpf(void)
 
 static inline bool ebpf_jit_enabled(void)
 {
-	return bpf_jit_enable && bpf_jit_is_ebpf();
+	return READ_ONCE(bpf_jit_enable) && bpf_jit_is_ebpf();
 }
 
 static inline bool bpf_prog_ebpf_jited(const struct bpf_prog *fp)
diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index 71a13596ea2b..2ddd153a6ff4 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -263,7 +263,7 @@ static int proc_dointvec_minmax_bpf_enable(struct ctl_table *table, int write,
 					   void *buffer, size_t *lenp,
 					   loff_t *ppos)
 {
-	int ret, jit_enable = *(int *)table->data;
+	int ret, jit_enable = READ_ONCE(*(int *)table->data);
 	int min = *(int *)table->extra1;
 	int max = *(int *)table->extra2;
 	struct ctl_table tmp = *table;
@@ -276,7 +276,7 @@ static int proc_dointvec_minmax_bpf_enable(struct ctl_table *table, int write,
 	if (write && !ret) {
 		if (jit_enable < 2 ||
 		    (jit_enable == 2 && bpf_dump_raw_ok(current_cred()))) {
-			*(int *)table->data = jit_enable;
+			WRITE_ONCE(*(int *)table->data, jit_enable);
 			if (jit_enable == 2)
 				pr_warn("bpf_jit_enable = 2 was set! NEVER use this in production, only for JIT debugging!\n");
 		} else {
-- 
2.30.2

