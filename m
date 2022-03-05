Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B40904CE1C9
	for <lists+bpf@lfdr.de>; Sat,  5 Mar 2022 02:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbiCEBCc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 4 Mar 2022 20:02:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbiCEBCb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Mar 2022 20:02:31 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929841AD963
        for <bpf@vger.kernel.org>; Fri,  4 Mar 2022 17:01:42 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 224HQpIq023871
        for <bpf@vger.kernel.org>; Fri, 4 Mar 2022 17:01:41 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ek4j6heb1-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 04 Mar 2022 17:01:41 -0800
Received: from twshared29473.14.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 4 Mar 2022 17:01:39 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 40369132C9934; Fri,  4 Mar 2022 17:01:34 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v5 bpf-next 2/3] libbpf: support custom SEC() handlers
Date:   Fri, 4 Mar 2022 17:01:28 -0800
Message-ID: <20220305010129.1549719-3-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220305010129.1549719-1-andrii@kernel.org>
References: <20220305010129.1549719-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: NDlYZFcRQJVxvXQE-FblV21sCUt3srwr
X-Proofpoint-GUID: NDlYZFcRQJVxvXQE-FblV21sCUt3srwr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-04_09,2022-03-04_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 clxscore=1015
 impostorscore=0 bulkscore=0 phishscore=0 spamscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203050002
X-FB-Internal: deliver
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Allow registering and unregistering custom handlers for BPF program.
This allows user applications and libraries to plug into libbpf's
declarative SEC() definition handling logic. This allows to offload
complex and intricate custom logic into external libraries, but still
provide a great user experience.

One such example is USDT handling library, which has a lot of code and
complexity which doesn't make sense to put into libbpf directly, but it
would be really great for users to be able to specify BPF programs with
something like SEC("usdt/<path-to-binary>:<usdt_provider>:<usdt_name>")
and have correct BPF program type set (BPF_PROGRAM_TYPE_KPROBE, as it is
uprobe) and even support BPF skeleton's auto-attach logic.

In some cases, it might be even good idea to override libbpf's default
handling, like for SEC("perf_event") programs. With custom library, it's
possible to extend logic to support specifying perf event specification
right there in SEC() definition without burdening libbpf with lots of
custom logic or extra library dependecies (e.g., libpfm4). With current
patch it's possible to override libbpf's SEC("perf_event") handling and
specify a completely custom ones.

Further, it's possible to specify a generic fallback handling for any
SEC() that doesn't match any other custom or standard libbpf handlers.
This allows to accommodate whatever legacy use cases there might be, if
necessary.

See doc comments for libbpf_register_prog_handler() and
libbpf_unregister_prog_handler() for detailed semantics.

This patch also bumps libbpf development version to v0.8 and adds new
APIs there.

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
Tested-by: Alan Maguire <alan.maguire@oracle.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c         | 204 ++++++++++++++++++++++++---------
 tools/lib/bpf/libbpf.h         | 109 ++++++++++++++++++
 tools/lib/bpf/libbpf.map       |   6 +
 tools/lib/bpf/libbpf_version.h |   2 +-
 4 files changed, 268 insertions(+), 53 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 1da4a438ba00..43161fdd44bb 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -201,13 +201,6 @@ struct reloc_desc {
 	};
 };
 
-typedef int (*libbpf_prog_setup_fn_t)(struct bpf_program *prog, long cookie);
-typedef int (*libbpf_prog_prepare_load_fn_t)(struct bpf_program *prog,
-					     struct bpf_prog_load_opts *opts, long cookie);
-/* If auto-attach is not supported, callback should return 0 and set link to NULL */
-typedef int (*libbpf_prog_attach_fn_t)(const struct bpf_program *prog, long cookie,
-				       struct bpf_link **link);
-
 /* stored as sec_def->cookie for all libbpf-supported SEC()s */
 enum sec_def_flags {
 	SEC_NONE = 0,
@@ -235,10 +228,11 @@ enum sec_def_flags {
 };
 
 struct bpf_sec_def {
-	const char *sec;
+	char *sec;
 	enum bpf_prog_type prog_type;
 	enum bpf_attach_type expected_attach_type;
 	long cookie;
+	int handler_id;
 
 	libbpf_prog_setup_fn_t prog_setup_fn;
 	libbpf_prog_prepare_load_fn_t prog_prepare_load_fn;
@@ -8590,7 +8584,7 @@ int bpf_program__set_log_buf(struct bpf_program *prog, char *log_buf, size_t log
 }
 
 #define SEC_DEF(sec_pfx, ptype, atype, flags, ...) {			    \
-	.sec = sec_pfx,							    \
+	.sec = (char *)sec_pfx,						    \
 	.prog_type = BPF_PROG_TYPE_##ptype,				    \
 	.expected_attach_type = atype,					    \
 	.cookie = (long)(flags),					    \
@@ -8683,61 +8677,167 @@ static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("sk_lookup",		SK_LOOKUP, BPF_SK_LOOKUP, SEC_ATTACHABLE | SEC_SLOPPY_PFX),
 };
 
-#define MAX_TYPE_NAME_SIZE 32
+static size_t custom_sec_def_cnt;
+static struct bpf_sec_def *custom_sec_defs;
+static struct bpf_sec_def custom_fallback_def;
+static bool has_custom_fallback_def;
 
-static const struct bpf_sec_def *find_sec_def(const char *sec_name)
+static int last_custom_sec_def_handler_id;
+
+int libbpf_register_prog_handler(const char *sec,
+				 enum bpf_prog_type prog_type,
+				 enum bpf_attach_type exp_attach_type,
+				 const struct libbpf_prog_handler_opts *opts)
 {
-	const struct bpf_sec_def *sec_def;
-	enum sec_def_flags sec_flags;
-	int i, n = ARRAY_SIZE(section_defs), len;
-	bool strict = libbpf_mode & LIBBPF_STRICT_SEC_NAME;
+	struct bpf_sec_def *sec_def;
 
-	for (i = 0; i < n; i++) {
-		sec_def = &section_defs[i];
-		sec_flags = sec_def->cookie;
-		len = strlen(sec_def->sec);
+	if (!OPTS_VALID(opts, libbpf_prog_handler_opts))
+		return libbpf_err(-EINVAL);
 
-		/* "type/" always has to have proper SEC("type/extras") form */
-		if (sec_def->sec[len - 1] == '/') {
-			if (str_has_pfx(sec_name, sec_def->sec))
-				return sec_def;
-			continue;
-		}
+	if (last_custom_sec_def_handler_id == INT_MAX) /* prevent overflow */
+		return libbpf_err(-E2BIG);
 
-		/* "type+" means it can be either exact SEC("type") or
-		 * well-formed SEC("type/extras") with proper '/' separator
-		 */
-		if (sec_def->sec[len - 1] == '+') {
-			len--;
-			/* not even a prefix */
-			if (strncmp(sec_name, sec_def->sec, len) != 0)
-				continue;
-			/* exact match or has '/' separator */
-			if (sec_name[len] == '\0' || sec_name[len] == '/')
-				return sec_def;
-			continue;
-		}
+	if (sec) {
+		sec_def = libbpf_reallocarray(custom_sec_defs, custom_sec_def_cnt + 1,
+					      sizeof(*sec_def));
+		if (!sec_def)
+			return libbpf_err(-ENOMEM);
 
-		/* SEC_SLOPPY_PFX definitions are allowed to be just prefix
-		 * matches, unless strict section name mode
-		 * (LIBBPF_STRICT_SEC_NAME) is enabled, in which case the
-		 * match has to be exact.
-		 */
-		if ((sec_flags & SEC_SLOPPY_PFX) && !strict)  {
-			if (str_has_pfx(sec_name, sec_def->sec))
-				return sec_def;
-			continue;
-		}
+		custom_sec_defs = sec_def;
+		sec_def = &custom_sec_defs[custom_sec_def_cnt];
+	} else {
+		if (has_custom_fallback_def)
+			return libbpf_err(-EBUSY);
 
-		/* Definitions not marked SEC_SLOPPY_PFX (e.g.,
-		 * SEC("syscall")) are exact matches in both modes.
-		 */
-		if (strcmp(sec_name, sec_def->sec) == 0)
+		sec_def = &custom_fallback_def;
+	}
+
+	sec_def->sec = sec ? strdup(sec) : NULL;
+	if (sec && !sec_def->sec)
+		return libbpf_err(-ENOMEM);
+
+	sec_def->prog_type = prog_type;
+	sec_def->expected_attach_type = exp_attach_type;
+	sec_def->cookie = OPTS_GET(opts, cookie, 0);
+
+	sec_def->prog_setup_fn = OPTS_GET(opts, prog_setup_fn, NULL);
+	sec_def->prog_prepare_load_fn = OPTS_GET(opts, prog_prepare_load_fn, NULL);
+	sec_def->prog_attach_fn = OPTS_GET(opts, prog_attach_fn, NULL);
+
+	sec_def->handler_id = ++last_custom_sec_def_handler_id;
+
+	if (sec)
+		custom_sec_def_cnt++;
+	else
+		has_custom_fallback_def = true;
+
+	return sec_def->handler_id;
+}
+
+int libbpf_unregister_prog_handler(int handler_id)
+{
+	struct bpf_sec_def *sec_defs;
+	int i;
+
+	if (handler_id <= 0)
+		return libbpf_err(-EINVAL);
+
+	if (has_custom_fallback_def && custom_fallback_def.handler_id == handler_id) {
+		memset(&custom_fallback_def, 0, sizeof(custom_fallback_def));
+		has_custom_fallback_def = false;
+		return 0;
+	}
+
+	for (i = 0; i < custom_sec_def_cnt; i++) {
+		if (custom_sec_defs[i].handler_id == handler_id)
+			break;
+	}
+
+	if (i == custom_sec_def_cnt)
+		return libbpf_err(-ENOENT);
+
+	free(custom_sec_defs[i].sec);
+	for (i = i + 1; i < custom_sec_def_cnt; i++)
+		custom_sec_defs[i - 1] = custom_sec_defs[i];
+	custom_sec_def_cnt--;
+
+	/* try to shrink the array, but it's ok if we couldn't */
+	sec_defs = libbpf_reallocarray(custom_sec_defs, custom_sec_def_cnt, sizeof(*sec_defs));
+	if (sec_defs)
+		custom_sec_defs = sec_defs;
+
+	return 0;
+}
+
+static bool sec_def_matches(const struct bpf_sec_def *sec_def, const char *sec_name,
+			    bool allow_sloppy)
+{
+	size_t len = strlen(sec_def->sec);
+
+	/* "type/" always has to have proper SEC("type/extras") form */
+	if (sec_def->sec[len - 1] == '/') {
+		if (str_has_pfx(sec_name, sec_def->sec))
+			return true;
+		return false;
+	}
+
+	/* "type+" means it can be either exact SEC("type") or
+	 * well-formed SEC("type/extras") with proper '/' separator
+	 */
+	if (sec_def->sec[len - 1] == '+') {
+		len--;
+		/* not even a prefix */
+		if (strncmp(sec_name, sec_def->sec, len) != 0)
+			return false;
+		/* exact match or has '/' separator */
+		if (sec_name[len] == '\0' || sec_name[len] == '/')
+			return true;
+		return false;
+	}
+
+	/* SEC_SLOPPY_PFX definitions are allowed to be just prefix
+	 * matches, unless strict section name mode
+	 * (LIBBPF_STRICT_SEC_NAME) is enabled, in which case the
+	 * match has to be exact.
+	 */
+	if (allow_sloppy && str_has_pfx(sec_name, sec_def->sec))
+		return true;
+
+	/* Definitions not marked SEC_SLOPPY_PFX (e.g.,
+	 * SEC("syscall")) are exact matches in both modes.
+	 */
+	return strcmp(sec_name, sec_def->sec) == 0;
+}
+
+static const struct bpf_sec_def *find_sec_def(const char *sec_name)
+{
+	const struct bpf_sec_def *sec_def;
+	int i, n;
+	bool strict = libbpf_mode & LIBBPF_STRICT_SEC_NAME, allow_sloppy;
+
+	n = custom_sec_def_cnt;
+	for (i = 0; i < n; i++) {
+		sec_def = &custom_sec_defs[i];
+		if (sec_def_matches(sec_def, sec_name, false))
+			return sec_def;
+	}
+
+	n = ARRAY_SIZE(section_defs);
+	for (i = 0; i < n; i++) {
+		sec_def = &section_defs[i];
+		allow_sloppy = (sec_def->cookie & SEC_SLOPPY_PFX) && !strict;
+		if (sec_def_matches(sec_def, sec_name, allow_sloppy))
 			return sec_def;
 	}
+
+	if (has_custom_fallback_def)
+		return &custom_fallback_def;
+
 	return NULL;
 }
 
+#define MAX_TYPE_NAME_SIZE 32
+
 static char *libbpf_get_type_names(bool attach_type)
 {
 	int i, len = ARRAY_SIZE(section_defs) * MAX_TYPE_NAME_SIZE;
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index c8d8daad212e..c1b0c2ef14d8 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1328,6 +1328,115 @@ LIBBPF_API int bpf_linker__add_file(struct bpf_linker *linker,
 LIBBPF_API int bpf_linker__finalize(struct bpf_linker *linker);
 LIBBPF_API void bpf_linker__free(struct bpf_linker *linker);
 
+/*
+ * Custom handling of BPF program's SEC() definitions
+ */
+
+struct bpf_prog_load_opts; /* defined in bpf.h */
+
+/* Called during bpf_object__open() for each recognized BPF program. Callback
+ * can use various bpf_program__set_*() setters to adjust whatever properties
+ * are necessary.
+ */
+typedef int (*libbpf_prog_setup_fn_t)(struct bpf_program *prog, long cookie);
+
+/* Called right before libbpf performs bpf_prog_load() to load BPF program
+ * into the kernel. Callback can adjust opts as necessary.
+ */
+typedef int (*libbpf_prog_prepare_load_fn_t)(struct bpf_program *prog,
+					     struct bpf_prog_load_opts *opts, long cookie);
+
+/* Called during skeleton attach or through bpf_program__attach(). If
+ * auto-attach is not supported, callback should return 0 and set link to
+ * NULL (it's not considered an error during skeleton attach, but it will be
+ * an error for bpf_program__attach() calls). On error, error should be
+ * returned directly and link set to NULL. On success, return 0 and set link
+ * to a valid struct bpf_link.
+ */
+typedef int (*libbpf_prog_attach_fn_t)(const struct bpf_program *prog, long cookie,
+				       struct bpf_link **link);
+
+struct libbpf_prog_handler_opts {
+	/* size of this struct, for forward/backward compatiblity */
+	size_t sz;
+	/* User-provided value that is passed to prog_setup_fn,
+	 * prog_prepare_load_fn, and prog_attach_fn callbacks. Allows user to
+	 * register one set of callbacks for multiple SEC() definitions and
+	 * still be able to distinguish them, if necessary. For example,
+	 * libbpf itself is using this to pass necessary flags (e.g.,
+	 * sleepable flag) to a common internal SEC() handler.
+	 */
+	long cookie;
+	/* BPF program initialization callback (see libbpf_prog_setup_fn_t).
+	 * Callback is optional, pass NULL if it's not necessary.
+	 */
+	libbpf_prog_setup_fn_t prog_setup_fn;
+	/* BPF program loading callback (see libbpf_prog_prepare_load_fn_t).
+	 * Callback is optional, pass NULL if it's not necessary.
+	 */
+	libbpf_prog_prepare_load_fn_t prog_prepare_load_fn;
+	/* BPF program attach callback (see libbpf_prog_attach_fn_t).
+	 * Callback is optional, pass NULL if it's not necessary.
+	 */
+	libbpf_prog_attach_fn_t prog_attach_fn;
+};
+#define libbpf_prog_handler_opts__last_field prog_attach_fn
+
+/**
+ * @brief **libbpf_register_prog_handler()** registers a custom BPF program
+ * SEC() handler.
+ * @param sec section prefix for which custom handler is registered
+ * @param prog_type BPF program type associated with specified section
+ * @param exp_attach_type Expected BPF attach type associated with specified section
+ * @param opts optional cookie, callbacks, and other extra options
+ * @return Non-negative handler ID is returned on success. This handler ID has
+ * to be passed to *libbpf_unregister_prog_handler()* to unregister such
+ * custom handler. Negative error code is returned on error.
+ *
+ * *sec* defines which SEC() definitions are handled by this custom handler
+ * registration. *sec* can have few different forms:
+ *   - if *sec* is just a plain string (e.g., "abc"), it will match only
+ *   SEC("abc"). If BPF program specifies SEC("abc/whatever") it will result
+ *   in an error;
+ *   - if *sec* is of the form "abc/", proper SEC() form is
+ *   SEC("abc/something"), where acceptable "something" should be checked by
+ *   *prog_init_fn* callback, if there are additional restrictions;
+ *   - if *sec* is of the form "abc+", it will successfully match both
+ *   SEC("abc") and SEC("abc/whatever") forms;
+ *   - if *sec* is NULL, custom handler is registered for any BPF program that
+ *   doesn't match any of the registered (custom or libbpf's own) SEC()
+ *   handlers. There could be only one such generic custom handler registered
+ *   at any given time.
+ *
+ * All custom handlers (except the one with *sec* == NULL) are processed
+ * before libbpf's own SEC() handlers. It is allowed to "override" libbpf's
+ * SEC() handlers by registering custom ones for the same section prefix
+ * (i.e., it's possible to have custom SEC("perf_event/LLC-load-misses")
+ * handler).
+ *
+ * Note, like much of global libbpf APIs (e.g., libbpf_set_print(),
+ * libbpf_set_strict_mode(), etc)) these APIs are not thread-safe. User needs
+ * to ensure synchronization if there is a risk of running this API from
+ * multiple threads simultaneously.
+ */
+LIBBPF_API int libbpf_register_prog_handler(const char *sec,
+					    enum bpf_prog_type prog_type,
+					    enum bpf_attach_type exp_attach_type,
+					    const struct libbpf_prog_handler_opts *opts);
+/**
+ * @brief *libbpf_unregister_prog_handler()* unregisters previously registered
+ * custom BPF program SEC() handler.
+ * @param handler_id handler ID returned by *libbpf_register_prog_handler()*
+ * after successful registration
+ * @return 0 on success, negative error code if handler isn't found
+ *
+ * Note, like much of global libbpf APIs (e.g., libbpf_set_print(),
+ * libbpf_set_strict_mode(), etc)) these APIs are not thread-safe. User needs
+ * to ensure synchronization if there is a risk of running this API from
+ * multiple threads simultaneously.
+ */
+LIBBPF_API int libbpf_unregister_prog_handler(int handler_id);
+
 #ifdef __cplusplus
 } /* extern "C" */
 #endif
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 47e70c9058d9..df1b947792c8 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -439,3 +439,9 @@ LIBBPF_0.7.0 {
 		libbpf_probe_bpf_prog_type;
 		libbpf_set_memlock_rlim_max;
 } LIBBPF_0.6.0;
+
+LIBBPF_0.8.0 {
+	global:
+		libbpf_register_prog_handler;
+		libbpf_unregister_prog_handler;
+} LIBBPF_0.7.0;
diff --git a/tools/lib/bpf/libbpf_version.h b/tools/lib/bpf/libbpf_version.h
index 0fefefc3500b..61f2039404b6 100644
--- a/tools/lib/bpf/libbpf_version.h
+++ b/tools/lib/bpf/libbpf_version.h
@@ -4,6 +4,6 @@
 #define __LIBBPF_VERSION_H
 
 #define LIBBPF_MAJOR_VERSION 0
-#define LIBBPF_MINOR_VERSION 7
+#define LIBBPF_MINOR_VERSION 8
 
 #endif /* __LIBBPF_VERSION_H */
-- 
2.30.2

