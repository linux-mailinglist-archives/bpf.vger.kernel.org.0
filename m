Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEBCB6334F4
	for <lists+bpf@lfdr.de>; Tue, 22 Nov 2022 06:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbiKVF4k (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Nov 2022 00:56:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbiKVF4S (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Nov 2022 00:56:18 -0500
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFAE7264BB;
        Mon, 21 Nov 2022 21:55:51 -0800 (PST)
Received: by mail-qk1-f180.google.com with SMTP id z1so9592916qkl.9;
        Mon, 21 Nov 2022 21:55:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f0Q962li9LjosC9Js/NBZYh/Sr3ElN5/7bG9cHOxkEk=;
        b=7T3tnxDltr3TEe+SxNJcWvo9QgGJUWYSK7ZS8hSrLOnEiiuowi0KAKocF5B3yM7nan
         POoXWbtVr+5tDdmO0cEhyt45ldbKvun9vl5RFwxx8fc4jy8NMgfErW9bA5b8xpmCj5Yb
         8EGGdy+Vrm7sYgEYuFYnQaF+zA78BB9KR3yz1QQ5c+nKeIf6kvJcVm2Z5beuy8ecdWVH
         zkzuPp3ACy7gK6EPIQNzO4PklekE+/g+2i4NsuAgKuVUHP70T4F74oqmuAcbLC3X8/M5
         oC7d1MCgehnKe5w60z3kk12PdoInyNEo//MKWU9RyijsCCzrUUTVFVR/qY2n1shqXuns
         IQng==
X-Gm-Message-State: ANoB5plZiEWINZzQX+vwjFPptvyWbSPqv1ycc7iTh7v9XsLTUkohW4gW
        b6+3iM+SwacTOdbjmzu+34WIwcVLhu16ZwD2
X-Google-Smtp-Source: AA0mqf6RYsEO5WXghiscHTWjQSrF4m5R8Qk12w1GtS6kEOn1Tw755P+2NGexrmXwOARb9PfkZKQH6g==
X-Received: by 2002:a05:620a:2214:b0:6fa:e58e:64e3 with SMTP id m20-20020a05620a221400b006fae58e64e3mr19752385qkh.430.1669096550615;
        Mon, 21 Nov 2022 21:55:50 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:3170])
        by smtp.gmail.com with ESMTPSA id y28-20020a37f61c000000b006fa22f0494bsm9280633qkj.117.2022.11.21.21.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 21:55:50 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, yhs@fb.com, song@kernel.org, sdf@google.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, jolsa@kernel.org,
        haoluo@google.com, tj@kernel.org, kernel-team@fb.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 4/4] selftests/bpf: Add selftests for bpf_cgroup_ancestor() kfunc
Date:   Mon, 21 Nov 2022 23:54:58 -0600
Message-Id: <20221122055458.173143-5-void@manifault.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221122055458.173143-1-void@manifault.com>
References: <20221122055458.173143-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

bpf_cgroup_ancestor() allows BPF programs to access the ancestor of a
struct cgroup *. This patch adds selftests that validate its expected
behavior.

Signed-off-by: David Vernet <void@manifault.com>
---
 .../selftests/bpf/prog_tests/cgrp_kfunc.c     |  1 +
 .../selftests/bpf/progs/cgrp_kfunc_common.h   |  1 +
 .../selftests/bpf/progs/cgrp_kfunc_success.c  | 45 +++++++++++++++++++
 3 files changed, 47 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/cgrp_kfunc.c b/tools/testing/selftests/bpf/prog_tests/cgrp_kfunc.c
index a59b166bbcc4..973f0c5af965 100644
--- a/tools/testing/selftests/bpf/prog_tests/cgrp_kfunc.c
+++ b/tools/testing/selftests/bpf/prog_tests/cgrp_kfunc.c
@@ -86,6 +86,7 @@ static const char * const success_tests[] = {
 	"test_cgrp_acquire_leave_in_map",
 	"test_cgrp_xchg_release",
 	"test_cgrp_get_release",
+	"test_cgrp_get_ancestors",
 };
 
 static struct {
diff --git a/tools/testing/selftests/bpf/progs/cgrp_kfunc_common.h b/tools/testing/selftests/bpf/progs/cgrp_kfunc_common.h
index 3f18def0e45c..7d30855bfe78 100644
--- a/tools/testing/selftests/bpf/progs/cgrp_kfunc_common.h
+++ b/tools/testing/selftests/bpf/progs/cgrp_kfunc_common.h
@@ -23,6 +23,7 @@ struct hash_map {
 struct cgroup *bpf_cgroup_acquire(struct cgroup *p) __ksym;
 struct cgroup *bpf_cgroup_kptr_get(struct cgroup **pp) __ksym;
 void bpf_cgroup_release(struct cgroup *p) __ksym;
+struct cgroup *bpf_cgroup_ancestor(struct cgroup *cgrp, int level) __ksym;
 
 static inline struct __cgrps_kfunc_map_value *cgrps_kfunc_map_value_lookup(struct cgroup *cgrp)
 {
diff --git a/tools/testing/selftests/bpf/progs/cgrp_kfunc_success.c b/tools/testing/selftests/bpf/progs/cgrp_kfunc_success.c
index 9f4569f7598b..0c23ea32df9f 100644
--- a/tools/testing/selftests/bpf/progs/cgrp_kfunc_success.c
+++ b/tools/testing/selftests/bpf/progs/cgrp_kfunc_success.c
@@ -123,3 +123,48 @@ int BPF_PROG(test_cgrp_get_release, struct cgroup *cgrp, const char *path)
 
 	return 0;
 }
+
+SEC("tp_btf/cgroup_mkdir")
+int BPF_PROG(test_cgrp_get_ancestors, struct cgroup *cgrp, const char *path)
+{
+	struct cgroup *self, *ancestor1, *invalid;
+
+	if (!is_test_kfunc_task())
+		return 0;
+
+	self = bpf_cgroup_ancestor(cgrp, cgrp->level);
+	if (!self) {
+		err = 1;
+		return 0;
+	}
+
+	if (self->self.id != cgrp->self.id) {
+		bpf_cgroup_release(self);
+		err = 2;
+		return 0;
+	}
+	bpf_cgroup_release(self);
+
+	ancestor1 = bpf_cgroup_ancestor(cgrp, cgrp->level - 1);
+	if (!ancestor1) {
+		err = 3;
+		return 0;
+	}
+	bpf_cgroup_release(ancestor1);
+
+	invalid = bpf_cgroup_ancestor(cgrp, 10000);
+	if (invalid) {
+		bpf_cgroup_release(invalid);
+		err = 4;
+		return 0;
+	}
+
+	invalid = bpf_cgroup_ancestor(cgrp, -1);
+	if (invalid) {
+		bpf_cgroup_release(invalid);
+		err = 5;
+		return 0;
+	}
+
+	return 0;
+}
-- 
2.38.1

