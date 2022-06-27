Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA3FB55C82B
	for <lists+bpf@lfdr.de>; Tue, 28 Jun 2022 14:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241067AbiF0VQE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 27 Jun 2022 17:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241074AbiF0VQD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Jun 2022 17:16:03 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB088186D4
        for <bpf@vger.kernel.org>; Mon, 27 Jun 2022 14:16:01 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 25RJ1RBI015465
        for <bpf@vger.kernel.org>; Mon, 27 Jun 2022 14:16:01 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3gwwv75p39-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 27 Jun 2022 14:16:00 -0700
Received: from twshared10560.18.frc3.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 27 Jun 2022 14:15:59 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 825A41BAC27E7; Mon, 27 Jun 2022 14:15:52 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v2 bpf-next 11/15] libbpf: remove internal multi-instance prog support
Date:   Mon, 27 Jun 2022 14:15:23 -0700
Message-ID: <20220627211527.2245459-12-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220627211527.2245459-1-andrii@kernel.org>
References: <20220627211527.2245459-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 8lG8566-gOybXzxtsQbzXVqkidkOTVxw
X-Proofpoint-ORIG-GUID: 8lG8566-gOybXzxtsQbzXVqkidkOTVxw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-27_06,2022-06-24_01,2022-06-22_01
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Clean up internals that had to deal with the possibility of
multi-instance bpf_programs. Libbpf 1.0 doesn't support this, so all
this is not necessary now and can be simplified.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 317 +++++------------------------------------
 1 file changed, 34 insertions(+), 283 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index fe98789d1776..65f2a57bc78d 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -366,16 +366,6 @@ struct bpf_sec_def {
 	libbpf_prog_attach_fn_t prog_attach_fn;
 };
 
-struct bpf_prog_prep_result {
-	struct bpf_insn *new_insn_ptr;
-	int new_insn_cnt;
-	int *pfd;
-};
-
-typedef int (*bpf_program_prep_t)(struct bpf_program *prog, int n,
-				  struct bpf_insn *insns, int insns_cnt,
-				  struct bpf_prog_prep_result *res);
-
 /*
  * bpf_prog should be a better name but it has been used in
  * linux/filter.h.
@@ -429,22 +419,19 @@ struct bpf_program {
 	size_t log_size;
 	__u32 log_level;
 
-	struct {
-		int nr;
-		int *fds;
-	} instances;
-	bpf_program_prep_t preprocessor;
-
 	struct bpf_object *obj;
 
+	int fd;
 	bool autoload;
 	bool mark_btf_static;
 	enum bpf_prog_type type;
 	enum bpf_attach_type expected_attach_type;
+
 	int prog_ifindex;
 	__u32 attach_btf_obj_fd;
 	__u32 attach_btf_id;
 	__u32 attach_prog_fd;
+
 	void *func_info;
 	__u32 func_info_rec_size;
 	__u32 func_info_cnt;
@@ -695,25 +682,10 @@ static Elf64_Rel *elf_rel_by_idx(Elf_Data *data, size_t idx);
 
 void bpf_program__unload(struct bpf_program *prog)
 {
-	int i;
-
 	if (!prog)
 		return;
 
-	/*
-	 * If the object is opened but the program was never loaded,
-	 * it is possible that prog->instances.nr == -1.
-	 */
-	if (prog->instances.nr > 0) {
-		for (i = 0; i < prog->instances.nr; i++)
-			zclose(prog->instances.fds[i]);
-	} else if (prog->instances.nr != -1) {
-		pr_warn("Internal error: instances.nr is %d\n",
-			prog->instances.nr);
-	}
-
-	prog->instances.nr = -1;
-	zfree(&prog->instances.fds);
+	zclose(prog->fd);
 
 	zfree(&prog->func_info);
 	zfree(&prog->line_info);
@@ -797,6 +769,7 @@ bpf_object__init_prog(struct bpf_object *obj, struct bpf_program *prog,
 	prog->insns_cnt = prog->sec_insn_cnt;
 
 	prog->type = BPF_PROG_TYPE_UNSPEC;
+	prog->fd = -1;
 
 	/* libbpf's convention for SEC("?abc...") is that it's just like
 	 * SEC("abc...") but the corresponding bpf_program starts out with
@@ -810,9 +783,6 @@ bpf_object__init_prog(struct bpf_object *obj, struct bpf_program *prog,
 		prog->autoload = true;
 	}
 
-	prog->instances.fds = NULL;
-	prog->instances.nr = -1;
-
 	/* inherit object's log_level */
 	prog->log_level = obj->log_level;
 
@@ -6862,10 +6832,9 @@ static int libbpf_prepare_prog_load(struct bpf_program *prog,
 
 static void fixup_verifier_log(struct bpf_program *prog, char *buf, size_t buf_sz);
 
-static int bpf_object_load_prog_instance(struct bpf_object *obj, struct bpf_program *prog,
-					 struct bpf_insn *insns, int insns_cnt,
-					 const char *license, __u32 kern_version,
-					 int *prog_fd)
+static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog,
+				struct bpf_insn *insns, int insns_cnt,
+				const char *license, __u32 kern_version, int *prog_fd)
 {
 	LIBBPF_OPTS(bpf_prog_load_opts, load_attr);
 	const char *prog_name = NULL;
@@ -7232,88 +7201,6 @@ static int bpf_program_record_relos(struct bpf_program *prog)
 	return 0;
 }
 
-static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog,
-				const char *license, __u32 kern_ver)
-{
-	int err = 0, fd, i;
-
-	if (obj->loaded) {
-		pr_warn("prog '%s': can't load after object was loaded\n", prog->name);
-		return libbpf_err(-EINVAL);
-	}
-
-	if (prog->instances.nr < 0 || !prog->instances.fds) {
-		if (prog->preprocessor) {
-			pr_warn("Internal error: can't load program '%s'\n",
-				prog->name);
-			return libbpf_err(-LIBBPF_ERRNO__INTERNAL);
-		}
-
-		prog->instances.fds = malloc(sizeof(int));
-		if (!prog->instances.fds) {
-			pr_warn("Not enough memory for BPF fds\n");
-			return libbpf_err(-ENOMEM);
-		}
-		prog->instances.nr = 1;
-		prog->instances.fds[0] = -1;
-	}
-
-	if (!prog->preprocessor) {
-		if (prog->instances.nr != 1) {
-			pr_warn("prog '%s': inconsistent nr(%d) != 1\n",
-				prog->name, prog->instances.nr);
-		}
-		if (obj->gen_loader)
-			bpf_program_record_relos(prog);
-		err = bpf_object_load_prog_instance(obj, prog,
-						    prog->insns, prog->insns_cnt,
-						    license, kern_ver, &fd);
-		if (!err)
-			prog->instances.fds[0] = fd;
-		goto out;
-	}
-
-	for (i = 0; i < prog->instances.nr; i++) {
-		struct bpf_prog_prep_result result;
-		bpf_program_prep_t preprocessor = prog->preprocessor;
-
-		memset(&result, 0, sizeof(result));
-		err = preprocessor(prog, i, prog->insns,
-				   prog->insns_cnt, &result);
-		if (err) {
-			pr_warn("Preprocessing the %dth instance of program '%s' failed\n",
-				i, prog->name);
-			goto out;
-		}
-
-		if (!result.new_insn_ptr || !result.new_insn_cnt) {
-			pr_debug("Skip loading the %dth instance of program '%s'\n",
-				 i, prog->name);
-			prog->instances.fds[i] = -1;
-			if (result.pfd)
-				*result.pfd = -1;
-			continue;
-		}
-
-		err = bpf_object_load_prog_instance(obj, prog,
-						    result.new_insn_ptr, result.new_insn_cnt,
-						    license, kern_ver, &fd);
-		if (err) {
-			pr_warn("Loading the %dth instance of program '%s' failed\n",
-				i, prog->name);
-			goto out;
-		}
-
-		if (result.pfd)
-			*result.pfd = fd;
-		prog->instances.fds[i] = fd;
-	}
-out:
-	if (err)
-		pr_warn("failed to load program '%s'\n", prog->name);
-	return libbpf_err(err);
-}
-
 static int
 bpf_object__load_progs(struct bpf_object *obj, int log_level)
 {
@@ -7337,9 +7224,16 @@ bpf_object__load_progs(struct bpf_object *obj, int log_level)
 			continue;
 		}
 		prog->log_level |= log_level;
-		err = bpf_object_load_prog(obj, prog, obj->license, obj->kern_version);
-		if (err)
+
+		if (obj->gen_loader)
+			bpf_program_record_relos(prog);
+
+		err = bpf_object_load_prog(obj, prog, prog->insns, prog->insns_cnt,
+					   obj->license, obj->kern_version, &prog->fd);
+		if (err) {
+			pr_warn("prog '%s': failed to load: %d\n", prog->name, err);
 			return err;
+		}
 	}
 
 	bpf_object__free_relocs(obj);
@@ -7985,11 +7879,16 @@ static int check_path(const char *path)
 	return err;
 }
 
-static int bpf_program_pin_instance(struct bpf_program *prog, const char *path, int instance)
+int bpf_program__pin(struct bpf_program *prog, const char *path)
 {
 	char *cp, errmsg[STRERR_BUFSIZE];
 	int err;
 
+	if (prog->fd < 0) {
+		pr_warn("prog '%s': can't pin program that wasn't loaded\n", prog->name);
+		return libbpf_err(-EINVAL);
+	}
+
 	err = make_parent_dir(path);
 	if (err)
 		return libbpf_err(err);
@@ -7998,164 +7897,35 @@ static int bpf_program_pin_instance(struct bpf_program *prog, const char *path,
 	if (err)
 		return libbpf_err(err);
 
-	if (prog == NULL) {
-		pr_warn("invalid program pointer\n");
-		return libbpf_err(-EINVAL);
-	}
-
-	if (instance < 0 || instance >= prog->instances.nr) {
-		pr_warn("invalid prog instance %d of prog %s (max %d)\n",
-			instance, prog->name, prog->instances.nr);
-		return libbpf_err(-EINVAL);
-	}
-
-	if (bpf_obj_pin(prog->instances.fds[instance], path)) {
+	if (bpf_obj_pin(prog->fd, path)) {
 		err = -errno;
 		cp = libbpf_strerror_r(err, errmsg, sizeof(errmsg));
-		pr_warn("failed to pin program: %s\n", cp);
+		pr_warn("prog '%s': failed to pin at '%s': %s\n", prog->name, path, cp);
 		return libbpf_err(err);
 	}
-	pr_debug("pinned program '%s'\n", path);
 
+	pr_debug("prog '%s': pinned at '%s'\n", prog->name, path);
 	return 0;
 }
 
-static int bpf_program_unpin_instance(struct bpf_program *prog, const char *path, int instance)
+int bpf_program__unpin(struct bpf_program *prog, const char *path)
 {
 	int err;
 
-	err = check_path(path);
-	if (err)
-		return libbpf_err(err);
-
-	if (prog == NULL) {
-		pr_warn("invalid program pointer\n");
+	if (prog->fd < 0) {
+		pr_warn("prog '%s': can't unpin program that wasn't loaded\n", prog->name);
 		return libbpf_err(-EINVAL);
 	}
 
-	if (instance < 0 || instance >= prog->instances.nr) {
-		pr_warn("invalid prog instance %d of prog %s (max %d)\n",
-			instance, prog->name, prog->instances.nr);
-		return libbpf_err(-EINVAL);
-	}
-
-	err = unlink(path);
-	if (err != 0)
-		return libbpf_err(-errno);
-
-	pr_debug("unpinned program '%s'\n", path);
-
-	return 0;
-}
-
-int bpf_program__pin(struct bpf_program *prog, const char *path)
-{
-	int i, err;
-
-	err = make_parent_dir(path);
-	if (err)
-		return libbpf_err(err);
-
-	err = check_path(path);
-	if (err)
-		return libbpf_err(err);
-
-	if (prog == NULL) {
-		pr_warn("invalid program pointer\n");
-		return libbpf_err(-EINVAL);
-	}
-
-	if (prog->instances.nr <= 0) {
-		pr_warn("no instances of prog %s to pin\n", prog->name);
-		return libbpf_err(-EINVAL);
-	}
-
-	if (prog->instances.nr == 1) {
-		/* don't create subdirs when pinning single instance */
-		return bpf_program_pin_instance(prog, path, 0);
-	}
-
-	for (i = 0; i < prog->instances.nr; i++) {
-		char buf[PATH_MAX];
-		int len;
-
-		len = snprintf(buf, PATH_MAX, "%s/%d", path, i);
-		if (len < 0) {
-			err = -EINVAL;
-			goto err_unpin;
-		} else if (len >= PATH_MAX) {
-			err = -ENAMETOOLONG;
-			goto err_unpin;
-		}
-
-		err = bpf_program_pin_instance(prog, buf, i);
-		if (err)
-			goto err_unpin;
-	}
-
-	return 0;
-
-err_unpin:
-	for (i = i - 1; i >= 0; i--) {
-		char buf[PATH_MAX];
-		int len;
-
-		len = snprintf(buf, PATH_MAX, "%s/%d", path, i);
-		if (len < 0)
-			continue;
-		else if (len >= PATH_MAX)
-			continue;
-
-		bpf_program_unpin_instance(prog, buf, i);
-	}
-
-	rmdir(path);
-
-	return libbpf_err(err);
-}
-
-int bpf_program__unpin(struct bpf_program *prog, const char *path)
-{
-	int i, err;
-
 	err = check_path(path);
 	if (err)
 		return libbpf_err(err);
 
-	if (prog == NULL) {
-		pr_warn("invalid program pointer\n");
-		return libbpf_err(-EINVAL);
-	}
-
-	if (prog->instances.nr <= 0) {
-		pr_warn("no instances of prog %s to pin\n", prog->name);
-		return libbpf_err(-EINVAL);
-	}
-
-	if (prog->instances.nr == 1) {
-		/* don't create subdirs when pinning single instance */
-		return bpf_program_unpin_instance(prog, path, 0);
-	}
-
-	for (i = 0; i < prog->instances.nr; i++) {
-		char buf[PATH_MAX];
-		int len;
-
-		len = snprintf(buf, PATH_MAX, "%s/%d", path, i);
-		if (len < 0)
-			return libbpf_err(-EINVAL);
-		else if (len >= PATH_MAX)
-			return libbpf_err(-ENAMETOOLONG);
-
-		err = bpf_program_unpin_instance(prog, buf, i);
-		if (err)
-			return err;
-	}
-
-	err = rmdir(path);
+	err = unlink(path);
 	if (err)
 		return libbpf_err(-errno);
 
+	pr_debug("prog '%s': unpinned from '%s'\n", prog->name, path);
 	return 0;
 }
 
@@ -8672,13 +8442,6 @@ int bpf_program__set_autoload(struct bpf_program *prog, bool autoload)
 	return 0;
 }
 
-static int bpf_program_nth_fd(const struct bpf_program *prog, int n);
-
-int bpf_program__fd(const struct bpf_program *prog)
-{
-	return bpf_program_nth_fd(prog, 0);
-}
-
 const struct bpf_insn *bpf_program__insns(const struct bpf_program *prog)
 {
 	return prog->insns;
@@ -8709,27 +8472,15 @@ int bpf_program__set_insns(struct bpf_program *prog,
 	return 0;
 }
 
-static int bpf_program_nth_fd(const struct bpf_program *prog, int n)
+int bpf_program__fd(const struct bpf_program *prog)
 {
-	int fd;
-
 	if (!prog)
 		return libbpf_err(-EINVAL);
 
-	if (n >= prog->instances.nr || n < 0) {
-		pr_warn("Can't get the %dth fd from program %s: only %d instances\n",
-			n, prog->name, prog->instances.nr);
-		return libbpf_err(-EINVAL);
-	}
-
-	fd = prog->instances.fds[n];
-	if (fd < 0) {
-		pr_warn("%dth instance of program '%s' is invalid\n",
-			n, prog->name);
+	if (prog->fd < 0)
 		return libbpf_err(-ENOENT);
-	}
 
-	return fd;
+	return prog->fd;
 }
 
 __alias(bpf_program__type)
-- 
2.30.2

