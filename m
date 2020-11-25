Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC982C37D6
	for <lists+bpf@lfdr.de>; Wed, 25 Nov 2020 05:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbgKYDxf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Nov 2020 22:53:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727397AbgKYDxf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Nov 2020 22:53:35 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38002C0613D4
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2020 19:53:22 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id n132so2126048qke.1
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2020 19:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5D1pNM2hFI6LwAUnWWosfwCNE4wKpOb76p8cvLAfXPE=;
        b=AqwuqbvoB1QyhBGmRRfsEDWO+jDP0XKRuMiZDGHT//tUfhDQMeIL0GjUWpXwLLuGvU
         gkeyyQ197SzDa9OkbYy9Dl9Owca3dzVDQ/HwX6VTbsR2xlw3CmucJhTtgrFgTjABXRcx
         bXmsqlsAd7hM6U1Lhqh4428Q35MWMTyb4SOdo35R4MnRJzzsVqPc/lvIGS4s/bZJpd4n
         6xXbhWNvRDsDkmNPXjPW4QkGVoDHDr2VNsivyp3cp+ZaTnBGRKji/HVRSmT9AQD68WkI
         y3leExkiKswpKPwI16E3koWv6cIe/SQmZTYl1n88YcFrDPkaC99iFVpocACLhZhMxWUB
         I+8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5D1pNM2hFI6LwAUnWWosfwCNE4wKpOb76p8cvLAfXPE=;
        b=TvhC2n7WHJS+WVgdsygIpAGyoCocwiT/78bh6ty1gly+lIkLAyxRD7Zls+T/S47s/G
         5Y2nkUadDVAcwyAwBOkIi5Nj6wU03PhNxDZl+4/tqLcgkBGEeVqT0wSv5nnQKu0IgZvW
         YM9N1dhCtmCqg6sakC7CRyEAtDfHA0ks6mF3WCrDG1G0lRIowTFQ6n7VeBPGT+selegu
         2NHHeERfS30YfrCN6sDyXo8h/oo1JGnr68u8T0YfLZ8393JgIs7D2kse6EK37RgB7L8G
         Di+Ywo+BkJdHBEnlt3OeIEOEAqij8h2C9mB23BYhalYW7XPYynLyATxtbqCC6IeoWEL+
         fVvA==
X-Gm-Message-State: AOAM533duDJ5Vy328jjkt4J6QqxWdhjOvge33DrP0+ieID1szPA2krq6
        sS5o0VQl4qBFFdxFumIMofRevx5S8MnN9g==
X-Google-Smtp-Source: ABdhPJzg60/A3vMg8cXoWWFsN5jzv1+lFaFTySNQ80BZewRZvx5md3ax/qRB4yr/ZI9PeAH3vb/eUw==
X-Received: by 2002:ae9:c303:: with SMTP id n3mr1591028qkg.60.1606276401159;
        Tue, 24 Nov 2020 19:53:21 -0800 (PST)
Received: from localhost (pool-96-239-57-246.nycmny.fios.verizon.net. [96.239.57.246])
        by smtp.gmail.com with ESMTPSA id p127sm1484586qkc.37.2020.11.24.19.53.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2020 19:53:20 -0800 (PST)
From:   Andrei Matei <andreimatei1@gmail.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, Andrei Matei <andreimatei1@gmail.com>
Subject: [PATCH bpf-next] selftest/bpf: fix compilation on clang 11
Date:   Tue, 24 Nov 2020 22:52:55 -0500
Message-Id: <20201125035255.17970-1-andreimatei1@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Before this patch, profiler.inc.h wouldn't compile with clang-11 (before
the __builtin_preserve_enum_value LLVM builtin was introduced in
https://reviews.llvm.org/D83242).
Another test that uses this builtin (test_core_enumval) is conditionally
skipped if the compiler is too old. In that spirit, this patch inhibits
part of populate_cgroup_info(), which needs this CO-RE builtin. The
selftests build again on clang-11.  The affected test (the profiler
test) doesn't pass on clang-11 because it's missing
https://reviews.llvm.org/D85570, but at least the test suite as a whole
compiles. The test's expected failure is already called out in the
README.

Signed-off-by: Andrei Matei <andreimatei1@gmail.com>
---
 tools/testing/selftests/bpf/progs/profiler.inc.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/profiler.inc.h b/tools/testing/selftests/bpf/progs/profiler.inc.h
index 30982a7e4d0f..b79d7f688655 100644
--- a/tools/testing/selftests/bpf/progs/profiler.inc.h
+++ b/tools/testing/selftests/bpf/progs/profiler.inc.h
@@ -256,6 +256,8 @@ static INLINE void* populate_cgroup_info(struct cgroup_data_t* cgroup_data,
 		BPF_CORE_READ(task, nsproxy, cgroup_ns, root_cset, dfl_cgrp, kn);
 	struct kernfs_node* proc_kernfs = BPF_CORE_READ(task, cgroups, dfl_cgrp, kn);
 
+
+#if __has_builtin(__builtin_preserve_enum_value)
 	if (ENABLE_CGROUP_V1_RESOLVER && CONFIG_CGROUP_PIDS) {
 		int cgrp_id = bpf_core_enum_value(enum cgroup_subsys_id___local,
 						  pids_cgrp_id___local);
@@ -275,6 +277,7 @@ static INLINE void* populate_cgroup_info(struct cgroup_data_t* cgroup_data,
 			}
 		}
 	}
+#endif
 
 	cgroup_data->cgroup_root_inode = get_inode_from_kernfs(root_kernfs);
 	cgroup_data->cgroup_proc_inode = get_inode_from_kernfs(proc_kernfs);
-- 
2.27.0

