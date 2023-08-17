Return-Path: <bpf+bounces-8023-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C087800A8
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 00:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 916581C21449
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 22:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F299D1BEE2;
	Thu, 17 Aug 2023 22:02:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848841BEE0
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 22:02:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2E08C433C7;
	Thu, 17 Aug 2023 22:02:43 +0000 (UTC)
Date: Fri, 18 Aug 2023 00:02:40 +0200
From: Helge Deller <deller@gmx.de>
To: bpf@vger.kernel.org
Cc: linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] bpf/tests: Enhance output on error and fix typos
Message-ID: <ZN6ZAAVoWZpsD1Jf@p100>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

If a testcase returns a wrong (unexpected) value, print the expected and
returned value in hex notation in addition to the decimal notation. This is
very useful in tests which bit-shift hex values left or right and helped me
a lot while developing the JIT compiler for the hppa architecture.

Additionally fix two typos: dowrd -> dword, tall calls -> tail calls.

Signed-off-by: Helge Deller <deller@gmx.de>

---

diff --git a/lib/test_bpf.c b/lib/test_bpf.c
index fa0833410ac1..2c01932524b3 100644
--- a/lib/test_bpf.c
+++ b/lib/test_bpf.c
@@ -596,8 +596,8 @@ static int __bpf_fill_alu_shift(struct bpf_test *self, u8 op,
 {
 	static const s64 regs[] = {
 		0x0123456789abcdefLL, /* dword > 0, word < 0 */
-		0xfedcba9876543210LL, /* dowrd < 0, word > 0 */
-		0xfedcba0198765432LL, /* dowrd < 0, word < 0 */
+		0xfedcba9876543210LL, /* dword < 0, word > 0 */
+		0xfedcba0198765432LL, /* dword < 0, word < 0 */
 		0x0123458967abcdefLL, /* dword > 0, word > 0 */
 	};
 	int bits = alu32 ? 32 : 64;
@@ -14577,8 +14577,9 @@ static int run_one(const struct bpf_prog *fp, struct bpf_test *test)
 		if (ret == test->test[i].result) {
 			pr_cont("%lld ", duration);
 		} else {
-			pr_cont("ret %d != %d ", ret,
-				test->test[i].result);
+			s32 res = test->test[i].result;
+			pr_cont("ret %d != %d (%#x != %#x)",
+				ret, res, ret, res);
 			err_cnt++;
 		}
 	}
@@ -15055,7 +15056,7 @@ static __init int prepare_tail_call_tests(struct bpf_array **pprogs)
 	struct bpf_array *progs;
 	int which, err;
 
-	/* Allocate the table of programs to be used for tall calls */
+	/* Allocate the table of programs to be used for tail calls */
 	progs = kzalloc(struct_size(progs, ptrs, ntests + 1), GFP_KERNEL);
 	if (!progs)
 		goto out_nomem;

