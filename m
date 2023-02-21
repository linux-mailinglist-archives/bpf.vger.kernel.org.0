Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE19A69E9E4
	for <lists+bpf@lfdr.de>; Tue, 21 Feb 2023 23:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjBUWJD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Feb 2023 17:09:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjBUWJC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Feb 2023 17:09:02 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77503166C6;
        Tue, 21 Feb 2023 14:09:01 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id h31so3216529pgl.6;
        Tue, 21 Feb 2023 14:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=2/cvfn2P/6dBt03KejtEoOWPr9vJQTPbptmWp6RbvNA=;
        b=RacUKCd47RAs3xlAAJzCUyxayp7HY8JOFtavlOlU+dxNZjXDpP8X9rhgrUjurX8Prv
         1t/N+OMaxczPUR51S3t1bD71it0qeS9h3sbY9lJhjcwopYyfuehHCK7s+ghuCXXbxoZe
         DyRI4zscjWzWAPspBG/jySgmPKWI/sPo2VV3K9QwtB+FUavR5qVe8kxsRzTW1CEQt/gh
         /7/R93Z7f3sP3Bo8oh7r+I0oLV9fyHBo/1/npmmWLa6S+oAYsNajpc40BbiT2jV0LgSX
         7dvYn1sHIDQLovbAaF2y47icmb2k0qFrh23gzkcajOR754Gf0jGi0L+hZKOY+zKPGyLJ
         hHdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2/cvfn2P/6dBt03KejtEoOWPr9vJQTPbptmWp6RbvNA=;
        b=WVkifObDcI/MeddzhD3vimq7VPRwJoTED03Rbc0i7kKATfGyeDBmZhTaDzxkCOca3Y
         c6VUUFJZHmKXhcA7qsigZazE1A7tvIlmM40aO9kq8zqVpqmT0UqAGGEC3pNWl/LeY3UE
         hsZfjA+pF1wg1mO+HEsS1ayi8FBdh6Wh7pS2HqFVqvcYD9fmBTLiq/jhKT5NsYun6zxI
         CkgENfOw/HPVHjDgjqssdgVKLbKVV+vZg2eNhP+iCfoRg1jA8cUpbT1Q1YMpa5MetqDy
         SExSbIf2hu9nauieMW0tGUD85PQALqZ6UemZ3RqTRanXrTFahqMJqNaoHQG7g3GiFyiA
         Eyyw==
X-Gm-Message-State: AO0yUKUsarNiFeM9V1t+1zdvBVbndTpVKD5mHvexIOk1qWT3s059kIhk
        O1Ni3qaWOtNSrVRXUMMQuos=
X-Google-Smtp-Source: AK7set/bE9uZEH796vAgoGN31p3TdpDMgzsCvQBRO6hSzWvXbGDsLTWZwvUQV6ZsZVFpxT0Xecmheg==
X-Received: by 2002:a62:1605:0:b0:5a8:ba8d:8040 with SMTP id 5-20020a621605000000b005a8ba8d8040mr6391751pfw.23.1677017340634;
        Tue, 21 Feb 2023 14:09:00 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id u20-20020a62ed14000000b00581ad007a9fsm3347481pfh.153.2023.02.21.14.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 14:08:59 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 21 Feb 2023 12:08:58 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, Dave Marchevsky <davemarchevsky@meta.com>,
        David Vernet <void@manifault.com>,
        linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: [PATCH bpf-next] bpf: Add bpf_cgroup_from_id() kfunc
Message-ID: <Y/VA+jP0mB5cMZEz@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

cgroup ID is an userspace-visible 64bit value uniquely identifying a given
cgroup. As the IDs are used widely, it's useful to be able to look up the
matching cgroups. Add bpf_cgroup_from_id().

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 Documentation/bpf/kfuncs.rst                  | 10 +++--
 kernel/bpf/helpers.c                          | 18 ++++++++
 .../selftests/bpf/prog_tests/cgrp_kfunc.c     |  1 +
 .../selftests/bpf/progs/cgrp_kfunc_common.h   |  1 +
 .../selftests/bpf/progs/cgrp_kfunc_success.c  | 42 +++++++++++++++++++
 5 files changed, 69 insertions(+), 3 deletions(-)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index ca96ef3f6896..226313747be5 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -583,13 +583,17 @@ You may also acquire a reference to a ``struct cgroup`` kptr that's already
 
 ----
 
-Another kfunc available for interacting with ``struct cgroup *`` objects is
-bpf_cgroup_ancestor(). This allows callers to access the ancestor of a cgroup,
-and return it as a cgroup kptr.
+Other kfuncs available for interacting with ``struct cgroup *`` objects are
+bpf_cgroup_ancestor() and bpf_cgroup_from_id(), allowing callers to access
+the ancestor of a cgroup and find a cgroup by its ID, respectively. Both
+return a cgroup kptr.
 
 .. kernel-doc:: kernel/bpf/helpers.c
    :identifiers: bpf_cgroup_ancestor
 
+.. kernel-doc:: kernel/bpf/helpers.c
+   :identifiers: bpf_cgroup_from_id
+
 Eventually, BPF should be updated to allow this to happen with a normal memory
 load in the program itself. This is currently not possible without more work in
 the verifier. bpf_cgroup_ancestor() can be used as follows:
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 5b278a38ae58..a784be6f8bac 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2101,6 +2101,23 @@ __bpf_kfunc struct cgroup *bpf_cgroup_ancestor(struct cgroup *cgrp, int level)
 	cgroup_get(ancestor);
 	return ancestor;
 }
+
+/**
+ * bpf_cgroup_from_id - Find a cgroup from its ID. A cgroup returned by this
+ * kfunc which is not subsequently stored in a map, must be released by calling
+ * bpf_cgroup_release().
+ * @cgrp: The cgroup for which we're performing a lookup.
+ * @level: The level of ancestor to look up.
+ */
+__bpf_kfunc struct cgroup *bpf_cgroup_from_id(u64 cgid)
+{
+	struct cgroup *cgrp;
+
+	cgrp = cgroup_get_from_id(cgid);
+	if (IS_ERR(cgrp))
+		return NULL;
+	return cgrp;
+}
 #endif /* CONFIG_CGROUPS */
 
 /**
@@ -2167,6 +2184,7 @@ BTF_ID_FLAGS(func, bpf_cgroup_acquire, KF_ACQUIRE | KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_cgroup_kptr_get, KF_ACQUIRE | KF_KPTR_GET | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_cgroup_release, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_cgroup_ancestor, KF_ACQUIRE | KF_TRUSTED_ARGS | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_cgroup_from_id, KF_ACQUIRE | KF_RET_NULL)
 #endif
 BTF_ID_FLAGS(func, bpf_task_from_pid, KF_ACQUIRE | KF_RET_NULL)
 BTF_SET8_END(generic_btf_ids)
diff --git a/tools/testing/selftests/bpf/prog_tests/cgrp_kfunc.c b/tools/testing/selftests/bpf/prog_tests/cgrp_kfunc.c
index b3f7985c8504..adda85f97058 100644
--- a/tools/testing/selftests/bpf/prog_tests/cgrp_kfunc.c
+++ b/tools/testing/selftests/bpf/prog_tests/cgrp_kfunc.c
@@ -84,6 +84,7 @@ static const char * const success_tests[] = {
 	"test_cgrp_xchg_release",
 	"test_cgrp_get_release",
 	"test_cgrp_get_ancestors",
+	"test_cgrp_from_id",
 };
 
 void test_cgrp_kfunc(void)
diff --git a/tools/testing/selftests/bpf/progs/cgrp_kfunc_common.h b/tools/testing/selftests/bpf/progs/cgrp_kfunc_common.h
index 7d30855bfe78..2f8de933b957 100644
--- a/tools/testing/selftests/bpf/progs/cgrp_kfunc_common.h
+++ b/tools/testing/selftests/bpf/progs/cgrp_kfunc_common.h
@@ -24,6 +24,7 @@ struct cgroup *bpf_cgroup_acquire(struct cgroup *p) __ksym;
 struct cgroup *bpf_cgroup_kptr_get(struct cgroup **pp) __ksym;
 void bpf_cgroup_release(struct cgroup *p) __ksym;
 struct cgroup *bpf_cgroup_ancestor(struct cgroup *cgrp, int level) __ksym;
+struct cgroup *bpf_cgroup_from_id(u64 cgid) __ksym;
 
 static inline struct __cgrps_kfunc_map_value *cgrps_kfunc_map_value_lookup(struct cgroup *cgrp)
 {
diff --git a/tools/testing/selftests/bpf/progs/cgrp_kfunc_success.c b/tools/testing/selftests/bpf/progs/cgrp_kfunc_success.c
index 0c23ea32df9f..42e13aebdd62 100644
--- a/tools/testing/selftests/bpf/progs/cgrp_kfunc_success.c
+++ b/tools/testing/selftests/bpf/progs/cgrp_kfunc_success.c
@@ -168,3 +168,45 @@ int BPF_PROG(test_cgrp_get_ancestors, struct cgroup *cgrp, const char *path)
 
 	return 0;
 }
+
+SEC("tp_btf/cgroup_mkdir")
+int BPF_PROG(test_cgrp_from_id, struct cgroup *cgrp, const char *path)
+{
+	struct cgroup *parent, *res;
+	u64 parent_cgid;
+
+	if (!is_test_kfunc_task())
+		return 0;
+
+	/* @cgrp's ID is not visible yet, let's test with the parent */
+	parent = bpf_cgroup_ancestor(cgrp, cgrp->level - 1);
+	if (!parent) {
+		err = 1;
+		return 0;
+	}
+
+	parent_cgid = parent->kn->id;
+	bpf_cgroup_release(parent);
+
+	res = bpf_cgroup_from_id(parent_cgid);
+	if (!res) {
+		err = 2;
+		return 0;
+	}
+
+	bpf_cgroup_release(res);
+
+	if (res != parent) {
+		err = 3;
+		return 0;
+	}
+
+	res = bpf_cgroup_from_id((u64)-1);
+	if (res) {
+		bpf_cgroup_release(res);
+		err = 4;
+		return 0;
+	}
+
+	return 0;
+}
-- 
2.39.2

