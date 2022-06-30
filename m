Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B045562631
	for <lists+bpf@lfdr.de>; Fri,  1 Jul 2022 00:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiF3WmH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Jun 2022 18:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiF3WmH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Jun 2022 18:42:07 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B813751B0E
        for <bpf@vger.kernel.org>; Thu, 30 Jun 2022 15:42:06 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id u13-20020a170902e5cd00b0016a53274671so320309plf.15
        for <bpf@vger.kernel.org>; Thu, 30 Jun 2022 15:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=USCl0oClyAQxwwBeZaSfPbfkeObzur+l0xwvn6Jqc88=;
        b=VLFe/81gXdcHB/VZERKU6+8ZOhUv/ptFVauyHgzah14cVfFKYCuyu/jClUcn/LyAFH
         nR6vw0Z7lj5OwcUAcKDobkMJFRo1oXoTTeUpo3AOg34B9MEFKHs4ZYtvFLiI65gpw0mV
         YdS41k70jrK2RytzpWr+cbqKnBAvvPu7JdK2PuejEy8P3kMMC0F2k9MrKY5l6sK62L9c
         ccs9TPsE4Zg507+T3ZpkW/1OD4JwWlXjUeK1EFbfuQ58/Z95Ysa16EkGhT9IK1EaDSX3
         /fpT2ZbQOJ2Nl1CBSEuLkhhoWU5LcocBXqxi5/q0jqKRGUtt0haOU9gRRKgAKnqtzWVc
         rqlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=USCl0oClyAQxwwBeZaSfPbfkeObzur+l0xwvn6Jqc88=;
        b=4zLEroR8McgTFIk6GKS58EUseT2wNeMdWR6/wUt2om77RXCpGD05hJfAFYFzRaSVap
         6xo946067Fxbc7qpAyJlw+sm2BzypzwSs9qXKDv/viLFxEBefUF4zm+cMZxdnM6L8ZnS
         PX2S36NJI/1z3vRsGJun0yo+HoN93FYIxOGjFe0l4Ck3WgEhCl5CKbIE8edirlEvCL7O
         IIx0Zijg1WM80HGXC+41DVQt4oWClJBG9lU9tW9tBCNG7GcXTKO09ogDDnuE3WR/zsYw
         iFT3sx2T6Fca2oZLHgCPWzL1B77hAe57mNQqCgN/REm8MrYXQHkd4m04r7XRspcPAhT9
         1piw==
X-Gm-Message-State: AJIora9xA098AA42iIQcKZbz+MtZ0+DeZeS9mLurwChhuBNld3D3YeGM
        7aGo9zRnjuH79jt/SukaR0GRVxeu+pERmtF08ZMBvt7Dz/FH5Be2EnRyCMNoiuWMLdFZcP1KmRQ
        q+GDs5fIQkqmsw8wPjFKVgFVmTsX/w2wYeMmyNilFsWAwXHbRaA==
X-Google-Smtp-Source: AGRyM1s0zPVy53MJm9COjd8r2wqBHfUoJwBl+O8a1u3eZKxGee1qBsZ4fxLUFMc3kgKJaPXVtwdTiys=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:902:6901:b0:168:9bb4:7adb with SMTP id
 j1-20020a170902690100b001689bb47adbmr16777502plk.147.1656628925752; Thu, 30
 Jun 2022 15:42:05 -0700 (PDT)
Date:   Thu, 30 Jun 2022 15:42:03 -0700
Message-Id: <20220630224203.512815-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH bpf-next] selftests/bpf: skip lsm_cgroup when don't have trampolines
From:   Stanislav Fomichev <sdf@google.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org
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

With arch_prepare_bpf_trampoline removed on x86:

 #98/1    lsm_cgroup/functional:SKIP
 #98      lsm_cgroup:SKIP
 Summary: 1/0 PASSED, 1 SKIPPED, 0 FAILED

Fixes: dca85aac8895 ("selftests/bpf: lsm_cgroup functional test")
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c b/tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c
index d40810a742fa..c542d7e80a5b 100644
--- a/tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c
+++ b/tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c
@@ -9,6 +9,10 @@
 #include "cgroup_helpers.h"
 #include "network_helpers.h"
 
+#ifndef ENOTSUPP
+#define ENOTSUPP 524
+#endif
+
 static struct btf *btf;
 
 static __u32 query_prog_cnt(int cgroup_fd, const char *attach_func)
@@ -100,6 +104,10 @@ static void test_lsm_cgroup_functional(void)
 	ASSERT_EQ(query_prog_cnt(cgroup_fd, "bpf_lsm_sk_alloc_security"), 0, "prog count");
 	ASSERT_EQ(query_prog_cnt(cgroup_fd, NULL), 0, "total prog count");
 	err = bpf_prog_attach(alloc_prog_fd, cgroup_fd, BPF_LSM_CGROUP, 0);
+	if (err == -ENOTSUPP) {
+		test__skip();
+		goto close_cgroup;
+	}
 	if (!ASSERT_OK(err, "attach alloc_prog_fd"))
 		goto detach_cgroup;
 	ASSERT_EQ(query_prog_cnt(cgroup_fd, "bpf_lsm_sk_alloc_security"), 1, "prog count");
-- 
2.37.0.rc0.161.g10f37bed90-goog

