Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB50956AD55
	for <lists+bpf@lfdr.de>; Thu,  7 Jul 2022 23:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236468AbiGGVTs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Jul 2022 17:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236225AbiGGVTr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Jul 2022 17:19:47 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708FC31393
        for <bpf@vger.kernel.org>; Thu,  7 Jul 2022 14:19:45 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 4E9D924010A
        for <bpf@vger.kernel.org>; Thu,  7 Jul 2022 23:19:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1657228783; bh=0Z49pH8EfqqgYcQOLxfKZCYIgJ/hPqVIYCOKzIvZVkI=;
        h=From:To:Subject:Date:From;
        b=Zai7+GjipsfGhtdWBvsrkIJaKWIHGib56qLndswU730arzod2lKJ64jq4aYSagvsB
         zUd6plUtlI4Pau3Sr3AamorPbVIzybQc7ZEJKjb4D7dn3dAs2i9A+MtKv2x9l2B7Jl
         sV/zppU9pSAGw4h9sIfMSSwKXCKXad8MmB+AJAOzJuONNZTl9CJ8bu7ZldOL/4Taf3
         +kzxr1H7dNXHl+FaGaA3PtERkjGWuLb1J63eYKwoa5j8gBE397/5/CDT9g/RaaTU64
         4w/k5okrOtZzqRkb/xmIPaUHKKZ10lCz71koylKzCPfuUJLcsfiFO0gCtNQMxDexfp
         t52P92bk+d1MA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4Lf8SG4000z6tmB;
        Thu,  7 Jul 2022 23:19:42 +0200 (CEST)
From:   =?UTF-8?q?Daniel=20M=C3=BCller?= <deso@posteo.net>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
Subject: [PATCH bpf-next] bpf: Correctly propagate errors up from bpf_core_composites_match
Date:   Thu,  7 Jul 2022 21:19:31 +0000
Message-Id: <20220707211931.3415440-1-deso@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This change addresses a comment made earlier [0] about a missing return
of an error when __bpf_core_types_match is invoked from
bpf_core_composites_match, which could have let to us erroneously
ignoring errors.

Regarding the typedef name check pointed out in the same context, it is
not actually an issue, because callers of the function perform a name
check for the root type anyway. To make that more obvious, let's add
comments to the function (similar to what we have for
bpf_core_types_are_compat, which is called in pretty much the same
context).

[0]: https://lore.kernel.org/bpf/165708121449.4919.13204634393477172905.git-patchwork-notify@kernel.org/T/#m55141e8f8cfd2e8d97e65328fa04852870d01af6

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Daniel Müller <deso@posteo.net>
---
 tools/lib/bpf/relo_core.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/relo_core.c b/tools/lib/bpf/relo_core.c
index fe25330..c4b0e8 100644
--- a/tools/lib/bpf/relo_core.c
+++ b/tools/lib/bpf/relo_core.c
@@ -1500,6 +1500,8 @@ static int bpf_core_composites_match(const struct btf *local_btf, const struct b
 
 			err = __bpf_core_types_match(local_btf, local_m->type, targ_btf,
 						     targ_m->type, behind_ptr, level - 1);
+			if (err < 0)
+				return err;
 			if (err > 0) {
 				matched = true;
 				break;
@@ -1512,7 +1514,8 @@ static int bpf_core_composites_match(const struct btf *local_btf, const struct b
 	return 1;
 }
 
-/* Check that two types "match".
+/* Check that two types "match". This function assumes that root types were
+ * already checked for name match.
  *
  * The matching relation is defined as follows:
  * - modifiers and typedefs are stripped (and, hence, effectively ignored)
@@ -1561,6 +1564,10 @@ int __bpf_core_types_match(const struct btf *local_btf, __u32 local_id, const st
 	if (!local_t || !targ_t)
 		return -EINVAL;
 
+	/* While the name check happens after typedefs are skipped, root-level
+	 * typedefs would still be name-matched as that's the contract with
+	 * callers.
+	 */
 	if (!bpf_core_names_match(local_btf, local_t->name_off, targ_btf, targ_t->name_off))
 		return 0;
 
-- 
2.30.2

