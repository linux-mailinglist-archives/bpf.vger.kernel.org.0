Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E655D62FCD7
	for <lists+bpf@lfdr.de>; Fri, 18 Nov 2022 19:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235378AbiKRSeX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Nov 2022 13:34:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235346AbiKRSeW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Nov 2022 13:34:22 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDBF1658C
        for <bpf@vger.kernel.org>; Fri, 18 Nov 2022 10:34:20 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id g62so5655654pfb.10
        for <bpf@vger.kernel.org>; Fri, 18 Nov 2022 10:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JWBg2ZM+5LY+DPWE9KaJWuwKCy+tCudVMmncE2yGD/w=;
        b=YI9XhArXpxIssWvzDDKUAPsPQRsDbBXsCvssOj329a1V33PILDfsCv1QtkvOXno5Uk
         2ohX2Yph9tzOaS6mPz/ztfB19uu4mth+aIDdbPLR4IBpSt8KonYF2BrUrj4Tod6H+KvI
         nNsLOBnqjnfCAu15W83Zck7APkMPr3fT0evWU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JWBg2ZM+5LY+DPWE9KaJWuwKCy+tCudVMmncE2yGD/w=;
        b=dwUPSO6Os6y1EC9PxoyxSyaQ95BzvNVO0pBPullb4925zkcG9T2wzKoLPz0kmhjS6q
         BgpsTjpm+Wz6MSKDdtSf5hAiGOnpfq+DvUvB27Rvovh3ecGMwR3R1kbOnY7+l25j5mRu
         61hUfIUL3yWIjOUrQge5+FkdN/iD9JCHBV2xlFd5fWTQbE6lCpKlLlF8HfdmIbyhoHUr
         XxSlu/z87Ys+hgK0H23TkkJw1sCgCWA0Bs3UCMl7yvqKFKnOjvgcEixJZUrzGDjC6Cfd
         Rp4ksMVOvVy7rUYgKehECJgQtrH2qAbBJBwC3FIqJUtY8hl5GYF2OfnYNEK6afARXpUb
         bXwA==
X-Gm-Message-State: ANoB5pkmfycFvJmSTlDZKMkfjpfawMW/pZOASQNyWt/TCLGadSzsBb84
        7lFLwwflT6J57GlqhIAYL9d3zw==
X-Google-Smtp-Source: AA0mqf68n5Vi70FZHtlJfpm84MyPVpxCEiFDQvN+/+JJ1+WkfRdVfKGRYpmOxWhMUA3LHPSw5jWJag==
X-Received: by 2002:a65:6049:0:b0:477:2ac1:9d2c with SMTP id a9-20020a656049000000b004772ac19d2cmr4147048pgp.184.1668796460410;
        Fri, 18 Nov 2022 10:34:20 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e7-20020aa798c7000000b0056bee23a80bsm3465524pfm.137.2022.11.18.10.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 10:34:19 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH bpf-next v3] bpf/verifier: Use kmalloc_size_roundup() to match ksize() usage
Date:   Fri, 18 Nov 2022 10:34:14 -0800
Message-Id: <20221118183409.give.387-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4318; h=from:subject:message-id; bh=nSdV4wW4rhE2V2JgCPdZCO/CD3bcTE7aQbwWRnxWy7M=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjd9AmEhS0Oiwnde/cDpv1CK8Q0c5N9kxXIxXFg3zD C2cfTj+JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY3fQJgAKCRCJcvTf3G3AJsIwD/ 4lBP73J5C3K2v0Blo/NFbBficvB0M/s/lCRJefT1g8onHiFpL7bEBFYnGI1KiObgY83cBXwkR77O8s vCOmMYNQl1M8sTrwP+MFvGDjNcNMf101GzlUi43idXgjZFRXuXAZjxMt+ClxrMbgrM+fD3sON0WgPu 4wVOkaFqdEv5wNnWz0TLbq5cgcEHYcT8Yd6p7vZNOy3UQLsdrDo5vGPtMKH1/Fs+JmyuBlid8Tslrg pLD0xf1SAShe9WI987JIok8jFcB6aGe5FOJ+BEpbt3OdRRrQpofkQcuMYn1ZlIoNLZUnFaOQODAzVs WuBZ21HtCJPiwrrZErvnZK56OCco5G80+bjrHMDgkhRAGyfE25gyv3X0TVv7Zf/1+TTDwt3OAT/HY8 pPh891vY8GOMNlmqwUG0hyBo/v1qN1E54INHRr2nY75z1ga+4AEHdAqN04U9i7v5i5m0SWNdQ3NPCZ sDPy+gnX6yeUpqKEJpUaK9ah+OmpGgDao2u2XcGTved1UPfw2wnRnpsPZrtT+tjL79O1OkS24NJKjh gSWr0EpzLaYvgrkafqVAUYTSE6pj+Ikro010v1DIpIoL7zYKrqPr7aYKNy7lyW7Wcx8QTzpFDxUBNK NxSLc0jHogciAXOErC1Y9iGAEHgOnj1Va2NrHGEieG5IsD0GBv7FY51SkDCg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Most allocation sites in the kernel want an explicitly sized allocation
(and not "more"), and that dynamic runtime analysis tools (e.g. KASAN,
UBSAN_BOUNDS, FORTIFY_SOURCE, etc) are looking for precise bounds checking
(i.e. not something that is rounded up). A tiny handful of allocations
were doing an implicit alloc/realloc loop that actually depended on
ksize(), and didn't actually always call realloc. This has created a
long series of bugs and problems over many years related to the runtime
bounds checking, so these callers are finally being adjusted to _not_
depend on the ksize() side-effect, by doing one of several things:

- tracking the allocation size precisely and just never calling ksize()
  at all[1].

- always calling realloc and not using ksize() at all. (This solution
  ends up actually be a subset of the next solution.)

- using kmalloc_size_roundup() to explicitly round up the desired
  allocation size immediately[2].

The bpf/verifier case is this another of this latter case, and is the
last outstanding case to be fixed in the kernel.

Because some of the dynamic bounds checking depends on the size being an
_argument_ to an allocator function (i.e. see the __alloc_size attribute),
the ksize() users are rare, and it could waste local variables, it
was been deemed better to explicitly separate the rounding up from the
allocation itself[3].

Round up allocations with kmalloc_size_roundup() so that the verifier's
use of ksize() is always accurate.

[1] e.g.:
    https://git.kernel.org/linus/712f210a457d
    https://git.kernel.org/linus/72c08d9f4c72

[2] e.g.:
    https://git.kernel.org/netdev/net-next/c/12d6c1d3a2ad
    https://git.kernel.org/netdev/net-next/c/ab3f7828c979
    https://git.kernel.org/netdev/net-next/c/d6dd508080a3

[3] https://lore.kernel.org/lkml/0ea1fc165a6c6117f982f4f135093e69cb884930.camel@redhat.com/

Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Song Liu <song@kernel.org>
Cc: Yonghong Song <yhs@fb.com>
Cc: KP Singh <kpsingh@kernel.org>
Cc: Stanislav Fomichev <sdf@google.com>
Cc: Hao Luo <haoluo@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: bpf@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v3:
- memory leak already taken into -next (daniel)
- improve commit log (daniel)
- drop optimization patch for now (sdf)
v2: https://lore.kernel.org/lkml/20221029024444.gonna.633-kees@kernel.org/
v1: https://lore.kernel.org/lkml/20221018090550.never.834-kees@kernel.org/
---
 kernel/bpf/verifier.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index beed7e03addc..c596c7c75d25 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1010,9 +1010,9 @@ static void *copy_array(void *dst, const void *src, size_t n, size_t size, gfp_t
 	if (unlikely(check_mul_overflow(n, size, &bytes)))
 		return NULL;
 
-	if (ksize(dst) < bytes) {
+	if (ksize(dst) < ksize(src)) {
 		kfree(dst);
-		dst = kmalloc_track_caller(bytes, flags);
+		dst = kmalloc_track_caller(kmalloc_size_roundup(bytes), flags);
 		if (!dst)
 			return NULL;
 	}
@@ -1029,12 +1029,14 @@ static void *copy_array(void *dst, const void *src, size_t n, size_t size, gfp_t
  */
 static void *realloc_array(void *arr, size_t old_n, size_t new_n, size_t size)
 {
+	size_t alloc_size;
 	void *new_arr;
 
 	if (!new_n || old_n == new_n)
 		goto out;
 
-	new_arr = krealloc_array(arr, new_n, size, GFP_KERNEL);
+	alloc_size = kmalloc_size_roundup(size_mul(new_n, size));
+	new_arr = krealloc(arr, alloc_size, GFP_KERNEL);
 	if (!new_arr) {
 		kfree(arr);
 		return NULL;
@@ -2506,9 +2508,11 @@ static int push_jmp_history(struct bpf_verifier_env *env,
 {
 	u32 cnt = cur->jmp_history_cnt;
 	struct bpf_idx_pair *p;
+	size_t alloc_size;
 
 	cnt++;
-	p = krealloc(cur->jmp_history, cnt * sizeof(*p), GFP_USER);
+	alloc_size = kmalloc_size_roundup(size_mul(cnt, sizeof(*p)));
+	p = krealloc(cur->jmp_history, alloc_size, GFP_USER);
 	if (!p)
 		return -ENOMEM;
 	p[cnt - 1].idx = env->insn_idx;
-- 
2.34.1

