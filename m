Return-Path: <bpf+bounces-9825-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02DD679DCA9
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 01:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1BF21C2127C
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 23:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B66F13AC1;
	Tue, 12 Sep 2023 23:32:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2D117C2
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 23:32:18 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577AA1702
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 16:32:18 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id 5b1f17b1804b1-402cc6b8bedso70543195e9.1
        for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 16:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694561536; x=1695166336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vPZKosC1Aaqq1ZcoJJGdd++MUM7bZOkhdXp+eqhi/Ms=;
        b=XUC7dwoo2hlKTSxmbP0nD7jSAALeYDKmiD+S6e34SA2LM63FClO/MSxuhYss7CME5i
         80XXK7fwbeUnQAciyrrSkpzxZpSTB/0EfJtuNZW+OpjJK0iZb3p+QOraVdJnJQais/hO
         DbGKLhJBjobca1jv9QPHpbpPETGD1twZUN8OHj+qBW9HCAByEUakgknpM5NTCsVRGNit
         rqu9RJChxOGXHLrtX4jj7dpgMC2t2CZZHH8a98heRtdWwYEBay/jSdNT7dJZ8/Fx3ecu
         IiMOP102rDQuzYzdXQnZAqHZTIXqfne5hSHmxDVd8piqalGPLDozz3s/96+V2Htil1fb
         v80w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694561536; x=1695166336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vPZKosC1Aaqq1ZcoJJGdd++MUM7bZOkhdXp+eqhi/Ms=;
        b=HLEs8+pI62WPCJgMVzaNBTZHfG+AOCPV5qDIDpvhO5CoI4i9QQPuE3Tm2JliXjE5Gc
         b6x1v2mx+Vfcdp0xfc0Sbj23+G9o5x2N34+jiFNsGBQvFAM7S4aaPs2ENkWtAI+Iz0+o
         KlN2u3RpLLqP497MTRljTSGyKEpTXMe+ewlWZmRk6kl/u5RgRG/IsIB/wP+OnwFFAOe3
         aGtboZ58k6zjl82LXzptwXdwDGYOXokMejoAxc2mjNMOSpCnQvo3WbtLCoiQY0jrwZ+T
         TxpBNKI6ciowvOCdPfQNvUv8oa4vwjk0JNgMYG5pfqfk5EwTGKNuIqCuzyvYUFCQ8FNP
         u7gQ==
X-Gm-Message-State: AOJu0Ywznbdj7OW+Y/I0V3Sb8t7gWyVa6RwISCw0kQy1aSeLJi1YPYid
	+TZmHzbs1J3uylE2KdAaHbeR+GKl2IFo4Q==
X-Google-Smtp-Source: AGHT+IHc2/AQMlrd34SFVs4/2wo36w+taUmrlBQh83Bf4I6VuhBwuQTTJCHlKC139iQpdjUZhIpi+g==
X-Received: by 2002:adf:ce10:0:b0:31f:98b4:4b62 with SMTP id p16-20020adfce10000000b0031f98b44b62mr694546wrn.37.1694561536608;
        Tue, 12 Sep 2023 16:32:16 -0700 (PDT)
Received: from localhost ([212.203.98.42])
        by smtp.gmail.com with ESMTPSA id q14-20020aa7cc0e000000b00521f4ee396fsm6441032edt.12.2023.09.12.16.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 16:32:16 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>,
	David Vernet <void@manifault.com>,
	Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH bpf-next v3 01/17] bpf: Use bpf_is_subprog to check for subprogs
Date: Wed, 13 Sep 2023 01:31:58 +0200
Message-ID: <20230912233214.1518551-2-memxor@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230912233214.1518551-1-memxor@gmail.com>
References: <20230912233214.1518551-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2998; i=memxor@gmail.com; h=from:subject; bh=W8BM/AO+gni3m/B/jvBaUMVNoZ0nNjaba66GzNpnA7s=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBlAPSsfnbQMNH/+vH2tFSbHwDgFBVLZjA6dauyO ZKAKEHNVV+JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZQD0rAAKCRBM4MiGSL8R ylnMEAC92ZqvQ3lBmXiYlrfG8mKbak0p2L9ba9QCMNJi1oJojSc/4Unijjw3Ue1qyTH6MvL4khj 46NAWwDhmI1muB2ABcNF27aZKCWPrxZB8qPUXouUz1b5I6sY0eVfWFfz07iDuWu7ZHLpM1XqeJL wwpCen/zIlKOr2WdF6ybDxuGvPFUiNxmDniSxCRp1ftHOrmwQOJZ05NyQof6IKOE5iWN2+hZXtH PGzSHzOPXmsHURJScSNIwsKb07/Rp4RPYrsoZ+gBQLrS7cicshqa+8jUCZwWhlS2eU3SNycN1Vw m5+NRlRnA8JF1Nlc7HvQp0hpk0QlYVzjNBcfimFO4Dcw0g8fzSWC2H7n9Mbjh+O5xPxX6CusYXL XtDQbS4+SEQyVZMAjwbWkR4p9jCEFJ4PgKWPyiBENYAFewaUCGikQ0BdLfpW9OyfCLhRxk2BZP7 /KTtqrTwp8jrurlzvdmIv2D5p5LZI7SggZ9XRMlYsQOViDtw3SINbc1ryEBUD4p6gd7gS5YTlvK Xo9HsRjLpF1cakyVa1dikD8hjN9fgZcR4Kaqzzgm1PO+I4U/CTOisUoWCd/f4jeHJj/VEzb0UwJ sBM6yNl4hcfbQf8K5IjKVzfop3hi+SPpWFAyX1GvzF7pBBe4tXc8V4a1hYJ2gwQHA2B1FYgAlHE E076KilcQxbK/PQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

We would like to know whether a bpf_prog corresponds to the main prog or
one of the subprogs. The current JIT implementations simply check this
using the func_idx in bpf_prog->aux->func_idx. When the index is 0, it
belongs to the main program, otherwise it corresponds to some
subprogram.

This will also be necessary to halt exception propagation while walking
the stack when an exception is thrown, so we add a simple helper
function to check this, named bpf_is_subprog, and convert existing JIT
implementations to also make use of it.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 arch/arm64/net/bpf_jit_comp.c | 2 +-
 arch/s390/net/bpf_jit_comp.c  | 2 +-
 arch/x86/net/bpf_jit_comp.c   | 2 +-
 include/linux/bpf.h           | 5 +++++
 4 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 150d1c6543f7..7d4af64e3982 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -288,7 +288,7 @@ static bool is_lsi_offset(int offset, int scale)
 static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf)
 {
 	const struct bpf_prog *prog = ctx->prog;
-	const bool is_main_prog = prog->aux->func_idx == 0;
+	const bool is_main_prog = !bpf_is_subprog(prog);
 	const u8 r6 = bpf2a64[BPF_REG_6];
 	const u8 r7 = bpf2a64[BPF_REG_7];
 	const u8 r8 = bpf2a64[BPF_REG_8];
diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index de2fb12120d2..eeb42e5cd7d6 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -556,7 +556,7 @@ static void bpf_jit_prologue(struct bpf_jit *jit, struct bpf_prog *fp,
 	EMIT6_PCREL_RILC(0xc0040000, 0, jit->prologue_plt);
 	jit->prologue_plt_ret = jit->prg;
 
-	if (fp->aux->func_idx == 0) {
+	if (!bpf_is_subprog(fp)) {
 		/* Initialize the tail call counter in the main program. */
 		/* xc STK_OFF_TCCNT(4,%r15),STK_OFF_TCCNT(%r15) */
 		_EMIT6(0xd703f000 | STK_OFF_TCCNT, 0xf000 | STK_OFF_TCCNT);
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 2846c21d75bf..a0d03503b3cb 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1049,7 +1049,7 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image
 
 	emit_prologue(&prog, bpf_prog->aux->stack_depth,
 		      bpf_prog_was_classic(bpf_prog), tail_call_reachable,
-		      bpf_prog->aux->func_idx != 0);
+		      bpf_is_subprog(bpf_prog));
 	push_callee_regs(&prog, callee_regs_used);
 
 	ilen = prog - temp;
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index b9e573159432..9171b0b6a590 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3194,4 +3194,9 @@ static inline gfp_t bpf_memcg_flags(gfp_t flags)
 	return flags;
 }
 
+static inline bool bpf_is_subprog(const struct bpf_prog *prog)
+{
+	return prog->aux->func_idx != 0;
+}
+
 #endif /* _LINUX_BPF_H */
-- 
2.41.0


