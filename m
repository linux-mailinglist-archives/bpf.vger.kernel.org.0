Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5180F4C1E58
	for <lists+bpf@lfdr.de>; Wed, 23 Feb 2022 23:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243277AbiBWWUv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Feb 2022 17:20:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241233AbiBWWUt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Feb 2022 17:20:49 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C17C3191D
        for <bpf@vger.kernel.org>; Wed, 23 Feb 2022 14:20:21 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2d6914a097cso4537067b3.10
        for <bpf@vger.kernel.org>; Wed, 23 Feb 2022 14:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=QqbfAnQFPeyq1W2tzhLj13WtIhug1v2RV5kcw4bVyD8=;
        b=M3LRsVVYMLqrkPVLhjVgzgO6oqomWeWvslWNtCgCaeozs+5JE3quxKQloPnPmcFAuN
         d7LWDcsYVSKoZuU4ViisNnctC3lgl8I6RE7cM1HGoAnEzeXzIdMKId9NHw6QHNCnah0y
         KfR5ai8+6KnX5MTu/BMqpAfx/0CskzCX+mnEg/ntIanrAsX7ZRC93w9NVGjB6mg8Pm30
         r5kPFzDatXjbWW3qMkJXTDRcvUn5rJShylq7agDYTAWRukZ73Km+RPnEAuEz/bnGS0PL
         s3Z407McuBKx/uoaQvA5KCNE5qILDHK2YxyCo0vSEU+H/5bM0+UxlvQSjV7+p2eEo9u3
         mQRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=QqbfAnQFPeyq1W2tzhLj13WtIhug1v2RV5kcw4bVyD8=;
        b=S6V3pRiAFKxh03WcAZ5ccx2RtNDvcjFl41Vc2xI4JfyvgLNgdcHVqZDr4ldAHajtZq
         mOagack9Uv6eR8yMC4O1XiqMtwZRqq3suH9A3RgaSA1vhzesyMcDvxm/iKz21R5/z/wI
         zfUGOHa0o7loKW3CfaJq526wTvSEaHhFewJAkF7cZYFhwhV3cUp8p9ceJ5qRq+jM0cji
         Wt2P3zrr9IpVIjtHx/TUYINDUQE1LU1WrU9Wq2QywdF5UN5fPi1theNHNcpmMdh+to1w
         MwZXoDfh3R2soA4ziWjAs2euEvMGMnWzHv77rZQLj+02ojDjl74BfXaBIZgxNDJEP27y
         foEQ==
X-Gm-Message-State: AOAM531Jxe9GKGe6+rnnqSmDLL1UzVgJTyaQswoAlbFm6TNbX9qqIXLS
        JyrxL3On5846iaA11TkQpIogg297AMM=
X-Google-Smtp-Source: ABdhPJy/KCJzay+oXWVPFlExuCe+j7tVl9NmWdRWJNWkS6pwrvnF8azwTDDu/N3fEA3sjOjL5ZKCjTdWyTM=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:9479:7f16:e9b8:14e4])
 (user=haoluo job=sendgmr) by 2002:a25:7e86:0:b0:622:6217:16a6 with SMTP id
 z128-20020a257e86000000b00622621716a6mr1568678ybc.188.1645654820555; Wed, 23
 Feb 2022 14:20:20 -0800 (PST)
Date:   Wed, 23 Feb 2022 14:20:02 -0800
Message-Id: <20220223222002.1085114-1-haoluo@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.473.g83b2b277ed-goog
Subject: [PATCH bpf-next] bpf: Cache the last valid build_id.
From:   Hao Luo <haoluo@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Song Liu <songliubraving@fb.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Blake Jones <blakejones@google.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hao Luo <haoluo@google.com>,
        Greg Thelen <gthelen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

For binaries that are statically linked, consecutive stack frames are
likely to be in the same VMA and therefore have the same build id.
As an optimization for this case, we can cache the previous frame's
VMA, if the new frame has the same VMA as the previous one, reuse the
previous one's build id. We are holding the MM locks as reader across
the entire loop, so we don't need to worry about VMA going away.

Tested through "stacktrace_build_id" and "stacktrace_build_id_nmi" in
test_progs.

Suggested-by: Greg Thelen <gthelen@google.com>
Signed-off-by: Hao Luo <haoluo@google.com>
---
 kernel/bpf/stackmap.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 22c8ae94e4c1..280b9198af27 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -132,7 +132,8 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
 	int i;
 	struct mmap_unlock_irq_work *work = NULL;
 	bool irq_work_busy = bpf_mmap_unlock_get_irq_work(&work);
-	struct vm_area_struct *vma;
+	struct vm_area_struct *vma, *prev_vma = NULL;
+	const char *prev_build_id;
 
 	/* If the irq_work is in use, fall back to report ips. Same
 	 * fallback is used for kernel stack (!user) on a stackmap with
@@ -151,6 +152,11 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
 
 	for (i = 0; i < trace_nr; i++) {
 		vma = find_vma(current->mm, ips[i]);
+		if (vma && vma == prev_vma) {
+			memcpy(id_offs[i].build_id, prev_build_id,
+			       BUILD_ID_SIZE_MAX);
+			goto build_id_valid;
+		}
 		if (!vma || build_id_parse(vma, id_offs[i].build_id, NULL)) {
 			/* per entry fall back to ips */
 			id_offs[i].status = BPF_STACK_BUILD_ID_IP;
@@ -158,9 +164,12 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
 			memset(id_offs[i].build_id, 0, BUILD_ID_SIZE_MAX);
 			continue;
 		}
+build_id_valid:
 		id_offs[i].offset = (vma->vm_pgoff << PAGE_SHIFT) + ips[i]
 			- vma->vm_start;
 		id_offs[i].status = BPF_STACK_BUILD_ID_VALID;
+		prev_vma = vma;
+		prev_build_id = id_offs[i].build_id;
 	}
 	bpf_mmap_unlock_mm(work, current->mm);
 }
-- 
2.35.1.473.g83b2b277ed-goog

