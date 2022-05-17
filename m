Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11BF3529B11
	for <lists+bpf@lfdr.de>; Tue, 17 May 2022 09:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241974AbiEQHia (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 May 2022 03:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241684AbiEQHhK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 May 2022 03:37:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6B44248E6B
        for <bpf@vger.kernel.org>; Tue, 17 May 2022 00:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652773020;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Mqoy+gV+cPqf1cM9iO48i7hrZpV+uT4NBe8cPuE9DHk=;
        b=CxJ+M0tAy+rk8LlickzFKL6A2UkKI0ofYRYjyfr4PjSOWg/S+tP41tXQDUw4gVEjAwMsij
        720p/TjhZoEJ/YrU5tR5P1g0C2VAxljz3ZSMe/IiMg2Vn/P27BofKpTjVUvDxfDDiN7PND
        QskTZnrjOtX+7LfefcVSByLDSwYzXPY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-88-cZvUbg2HOE6qVtAgQLSAdg-1; Tue, 17 May 2022 03:36:55 -0400
X-MC-Unique: cZvUbg2HOE6qVtAgQLSAdg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0DF6F299E751;
        Tue, 17 May 2022 07:36:54 +0000 (UTC)
Received: from asgard.redhat.com (unknown [10.36.110.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2B55215687CF;
        Tue, 17 May 2022 07:36:49 +0000 (UTC)
Date:   Tue, 17 May 2022 09:36:47 +0200
From:   Eugene Syromiatnikov <esyr@redhat.com>
To:     Jiri Olsa <jolsa@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v3 4/4] bpf_trace: pass array of u64 values in
 kprobe_multi.addrs
Message-ID: <6ef675aeeea442fa8fc168cd1cb4e4e474f65a3f.1652772731.git.esyr@redhat.com>
References: <cover.1652772731.git.esyr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1652772731.git.esyr@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

With the interface as defined, it is impossible to pass 64-bit kernel
addresses from a 32-bit userspace process in BPF_LINK_TYPE_KPROBE_MULTI,
which severly limits the useability of the interface, change the ABI
to accept an array of u64 values instead of (kernel? user?) longs.
Interestingly, the rest of the libbpf infrastructure uses 64-bit values
for kallsyms addresses already, so this patch also eliminates
the sym_addr cast in tools/lib/bpf/libbpf.c:resolve_kprobe_multi_cb().

Fixes: 0dcac272540613d4 ("bpf: Add multi kprobe link")
Fixes: 5117c26e877352bc ("libbpf: Add bpf_link_create support for multi kprobes")
Fixes: ddc6b04989eb0993 ("libbpf: Add bpf_program__attach_kprobe_multi_opts function")
Fixes: f7a11eeccb111854 ("selftests/bpf: Add kprobe_multi attach test")
Fixes: 9271a0c7ae7a9147 ("selftests/bpf: Add attach test for bpf_program__attach_kprobe_multi_opts")
Fixes: 2c6401c966ae1fbe ("selftests/bpf: Add kprobe_multi bpf_cookie test")
Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
---
 kernel/trace/bpf_trace.c                           | 25 ++++++++++++++++++----
 tools/lib/bpf/bpf.h                                |  2 +-
 tools/lib/bpf/libbpf.c                             |  8 +++----
 tools/lib/bpf/libbpf.h                             |  2 +-
 .../testing/selftests/bpf/prog_tests/bpf_cookie.c  |  2 +-
 .../selftests/bpf/prog_tests/kprobe_multi_test.c   |  8 +++----
 6 files changed, 32 insertions(+), 15 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 9d3028a..30a15b3 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2454,7 +2454,7 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 	void __user *ucookies;
 	unsigned long *addrs;
 	u32 flags, cnt, size, cookies_size;
-	void __user *uaddrs;
+	u64 __user *uaddrs;
 	u64 *cookies = NULL;
 	void __user *usyms;
 	int err;
@@ -2486,9 +2486,26 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 		return -ENOMEM;
 
 	if (uaddrs) {
-		if (copy_from_user(addrs, uaddrs, size)) {
-			err = -EFAULT;
-			goto error;
+		if (sizeof(*addrs) == sizeof(*uaddrs)) {
+			if (copy_from_user(addrs, uaddrs, size)) {
+				err = -EFAULT;
+				goto error;
+			}
+		} else {
+			u32 i;
+			u64 addr;
+
+			for (i = 0; i < cnt; i++) {
+				if (get_user(addr, uaddrs + i)) {
+					err = -EFAULT;
+					goto error;
+				}
+				if (addr > ULONG_MAX) {
+					err = -EINVAL;
+					goto error;
+				}
+				addrs[i] = addr;
+			}
 		}
 	} else {
 		struct user_syms us;
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 2e0d373..da9c6037 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -418,7 +418,7 @@ struct bpf_link_create_opts {
 			__u32 flags;
 			__u32 cnt;
 			const char **syms;
-			const unsigned long *addrs;
+			const __u64 *addrs;
 			const __u64 *cookies;
 		} kprobe_multi;
 		struct {
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index ef7f302..35fa9c5 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -10737,7 +10737,7 @@ static bool glob_match(const char *str, const char *pat)
 
 struct kprobe_multi_resolve {
 	const char *pattern;
-	unsigned long *addrs;
+	__u64 *addrs;
 	size_t cap;
 	size_t cnt;
 };
@@ -10752,12 +10752,12 @@ resolve_kprobe_multi_cb(unsigned long long sym_addr, char sym_type,
 	if (!glob_match(sym_name, res->pattern))
 		return 0;
 
-	err = libbpf_ensure_mem((void **) &res->addrs, &res->cap, sizeof(unsigned long),
+	err = libbpf_ensure_mem((void **) &res->addrs, &res->cap, sizeof(__u64),
 				res->cnt + 1);
 	if (err)
 		return err;
 
-	res->addrs[res->cnt++] = (unsigned long) sym_addr;
+	res->addrs[res->cnt++] = sym_addr;
 	return 0;
 }
 
@@ -10772,7 +10772,7 @@ bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
 	};
 	struct bpf_link *link = NULL;
 	char errmsg[STRERR_BUFSIZE];
-	const unsigned long *addrs;
+	const __u64 *addrs;
 	int err, link_fd, prog_fd;
 	const __u64 *cookies;
 	const char **syms;
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 9e9a3fd..76e171d 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -489,7 +489,7 @@ struct bpf_kprobe_multi_opts {
 	/* array of function symbols to attach */
 	const char **syms;
 	/* array of function addresses to attach */
-	const unsigned long *addrs;
+	const __u64 *addrs;
 	/* array of user-provided values fetchable through bpf_get_attach_cookie */
 	const __u64 *cookies;
 	/* number of elements in syms/addrs/cookies arrays */
diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
index 83ef55e3..e843840 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
@@ -140,7 +140,7 @@ static void kprobe_multi_link_api_subtest(void)
 	cookies[6] = 7;
 	cookies[7] = 8;
 
-	opts.kprobe_multi.addrs = (const unsigned long *) &addrs;
+	opts.kprobe_multi.addrs = (const __u64 *) &addrs;
 	opts.kprobe_multi.cnt = ARRAY_SIZE(addrs);
 	opts.kprobe_multi.cookies = (const __u64 *) &cookies;
 	prog_fd = bpf_program__fd(skel->progs.test_kprobe);
diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
index 586dc52..7646112 100644
--- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
@@ -108,7 +108,7 @@ static void test_link_api_addrs(void)
 	GET_ADDR("bpf_fentry_test7", addrs[6]);
 	GET_ADDR("bpf_fentry_test8", addrs[7]);
 
-	opts.kprobe_multi.addrs = (const unsigned long*) addrs;
+	opts.kprobe_multi.addrs = (const __u64 *) addrs;
 	opts.kprobe_multi.cnt = ARRAY_SIZE(addrs);
 	test_link_api(&opts);
 }
@@ -186,7 +186,7 @@ static void test_attach_api_addrs(void)
 	GET_ADDR("bpf_fentry_test7", addrs[6]);
 	GET_ADDR("bpf_fentry_test8", addrs[7]);
 
-	opts.addrs = (const unsigned long *) addrs;
+	opts.addrs = (const __u64 *) addrs;
 	opts.cnt = ARRAY_SIZE(addrs);
 	test_attach_api(NULL, &opts);
 }
@@ -244,7 +244,7 @@ static void test_attach_api_fails(void)
 		goto cleanup;
 
 	/* fail_2 - both addrs and syms set */
-	opts.addrs = (const unsigned long *) addrs;
+	opts.addrs = (const __u64 *) addrs;
 	opts.syms = syms;
 	opts.cnt = ARRAY_SIZE(syms);
 	opts.cookies = NULL;
@@ -258,7 +258,7 @@ static void test_attach_api_fails(void)
 		goto cleanup;
 
 	/* fail_3 - pattern and addrs set */
-	opts.addrs = (const unsigned long *) addrs;
+	opts.addrs = (const __u64 *) addrs;
 	opts.syms = NULL;
 	opts.cnt = ARRAY_SIZE(syms);
 	opts.cookies = NULL;
-- 
2.1.4

