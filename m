Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C7A53AA54
	for <lists+bpf@lfdr.de>; Wed,  1 Jun 2022 17:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355767AbiFAPkc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Jun 2022 11:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345941AbiFAPkb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Jun 2022 11:40:31 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206F32B1AE
        for <bpf@vger.kernel.org>; Wed,  1 Jun 2022 08:40:30 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 1212624010C
        for <bpf@vger.kernel.org>; Wed,  1 Jun 2022 17:40:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1654098028; bh=NdRlku+BA7FU9K8kgblXaX45bWHf86JfBwt12gqii8A=;
        h=From:To:Subject:Date:From;
        b=I4zHLTiIHAxPSACcKzbJKKliCFqt9cAlb9odGAqd6sogzjJjrnemcruUH8LcPfemH
         D0P/E0bTzszVlrXfintbScYrmIP7UOiDh5oEvnTa3UGrBUzuylKDtfS1eoZUz1Fr8m
         7Y+HTv//SwhB0TzFUyX5PRKO2a1ZFgYZGhUMG4rNPkxj5etObiJ0D5CSXRiKThCk/l
         +z5LGrM583tFGR4W8cLhFCEE0AaaTyHWE3IN7rdTtYaeYDORWrBDOZ34sq+q9cr1IN
         PC7FvowIwPFN8FZ9oDOW1IYSfkQR4nZ4EgpUccXlDxQ91VUNhZShej02gT9vG1PyCD
         vKapI3GaX2r9A==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4LCtdR1qcDz6tm4;
        Wed,  1 Jun 2022 17:40:27 +0200 (CEST)
From:   =?UTF-8?q?Daniel=20M=C3=BCller?= <deso@posteo.net>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
Subject: [PATCH bpf-next] libbpf: Fix a couple of typos
Date:   Wed,  1 Jun 2022 15:40:25 +0000
Message-Id: <20220601154025.3295035-1-deso@posteo.net>
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

This change fixes a couple of typos that were encountered while studying
the source code.

Signed-off-by: Daniel Müller <deso@posteo.net>
---
 tools/lib/bpf/btf.c       | 2 +-
 tools/lib/bpf/libbpf.h    | 2 +-
 tools/lib/bpf/relo_core.c | 8 ++++----
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 3d6c30d9..2e9c23b 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -130,7 +130,7 @@ static inline __u64 ptr_to_u64(const void *ptr)
 
 /* Ensure given dynamically allocated memory region pointed to by *data* with
  * capacity of *cap_cnt* elements each taking *elem_sz* bytes has enough
- * memory to accomodate *add_cnt* new elements, assuming *cur_cnt* elements
+ * memory to accommodate *add_cnt* new elements, assuming *cur_cnt* elements
  * are already used. At most *max_cnt* elements can be ever allocated.
  * If necessary, memory is reallocated and all existing data is copied over,
  * new pointer to the memory region is stored at *data, new memory region
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 5b34ca..fa2796 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -107,7 +107,7 @@ struct bpf_object_open_attr {
 };
 
 struct bpf_object_open_opts {
-	/* size of this struct, for forward/backward compatiblity */
+	/* size of this struct, for forward/backward compatibility */
 	size_t sz;
 	/* object name override, if provided:
 	 * - for object open from file, this will override setting object
diff --git a/tools/lib/bpf/relo_core.c b/tools/lib/bpf/relo_core.c
index ba4453..d8ab4c6 100644
--- a/tools/lib/bpf/relo_core.c
+++ b/tools/lib/bpf/relo_core.c
@@ -167,7 +167,7 @@ static bool core_relo_is_enumval_based(enum bpf_core_relo_kind kind)
  * just a parsed access string representation): [0, 1, 2, 3].
  *
  * High-level spec will capture only 3 points:
- *   - intial zero-index access by pointer (&s->... is the same as &s[0]...);
+ *   - initial zero-index access by pointer (&s->... is the same as &s[0]...);
  *   - field 'a' access (corresponds to '2' in low-level spec);
  *   - array element #3 access (corresponds to '3' in low-level spec).
  *
@@ -1148,11 +1148,11 @@ int bpf_core_format_spec(char *buf, size_t buf_sz, const struct bpf_core_spec *s
  * 3. It is supported and expected that there might be multiple flavors
  *    matching the spec. As long as all the specs resolve to the same set of
  *    offsets across all candidates, there is no error. If there is any
- *    ambiguity, CO-RE relocation will fail. This is necessary to accomodate
- *    imprefection of BTF deduplication, which can cause slight duplication of
+ *    ambiguity, CO-RE relocation will fail. This is necessary to accommodate
+ *    imperfection of BTF deduplication, which can cause slight duplication of
  *    the same BTF type, if some directly or indirectly referenced (by
  *    pointer) type gets resolved to different actual types in different
- *    object files. If such situation occurs, deduplicated BTF will end up
+ *    object files. If such a situation occurs, deduplicated BTF will end up
  *    with two (or more) structurally identical types, which differ only in
  *    types they refer to through pointer. This should be OK in most cases and
  *    is not an error.
-- 
2.30.2

