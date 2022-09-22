Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 312865E7011
	for <lists+bpf@lfdr.de>; Fri, 23 Sep 2022 01:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbiIVXIF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 22 Sep 2022 19:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbiIVXIB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Sep 2022 19:08:01 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15297113B46
        for <bpf@vger.kernel.org>; Thu, 22 Sep 2022 16:08:00 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28MKiQdO001102
        for <bpf@vger.kernel.org>; Thu, 22 Sep 2022 16:07:59 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jrhjgpu37-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 22 Sep 2022 16:07:59 -0700
Received: from twshared13579.04.prn5.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 16:07:58 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 425111F384489; Thu, 22 Sep 2022 16:07:47 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 3/5] selftests/bpf: make veristat skip non-BPF and failing-to-open BPF objects
Date:   Thu, 22 Sep 2022 16:07:37 -0700
Message-ID: <20220922230739.1288536-4-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220922230739.1288536-1-andrii@kernel.org>
References: <20220922230739.1288536-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: Eho8KIGqimvDAOzkkGFay-QBgzHtqm2a
X-Proofpoint-ORIG-GUID: Eho8KIGqimvDAOzkkGFay-QBgzHtqm2a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-22_15,2022-09-22_02,2022-06-22_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Make veristat ignore non-BPF object files. This allows simpler
mass-verification (e.g., `sudo ./veristat *.bpf.o` in selftests/bpf
directory). Note that `sudo ./veristat *.o` would also work, but with
selftests's multiple copies of BPF object files (.bpf.o and
.bpf.linked{1,2,3}.o) it's 4x slower.

Also, given some of BPF object files could be incomplete in the sense
that they are meant to be statically linked into final BPF object file
(like linked_maps, linked_funcs, linked_vars), note such instances in
stderr, but proceed anyways. This seems like a better trade off between
completely silently ignoring BPF object file and aborting
mass-verification altogether.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/veristat.c | 78 +++++++++++++++++++++++---
 1 file changed, 70 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index 77bdfd6fe302..f09dd143a8df 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -15,6 +15,8 @@
 #include <sys/sysinfo.h>
 #include <sys/stat.h>
 #include <bpf/libbpf.h>
+#include <libelf.h>
+#include <gelf.h>
 
 enum stat_id {
 	VERDICT,
@@ -78,6 +80,11 @@ static struct env {
 	struct filter *deny_filters;
 	int allow_filter_cnt;
 	int deny_filter_cnt;
+
+	int files_processed;
+	int files_skipped;
+	int progs_processed;
+	int progs_skipped;
 } env;
 
 static int libbpf_print_fn(enum libbpf_print_level level, const char *format, va_list args)
@@ -226,8 +233,41 @@ static bool should_process_file(const char *filename)
 	return false;
 }
 
-static bool should_process_prog(const char *filename, const char *prog_name)
+static bool is_bpf_obj_file(const char *path) {
+	Elf64_Ehdr *ehdr;
+	int fd, err = -EINVAL;
+	Elf *elf = NULL;
+
+	fd = open(path, O_RDONLY | O_CLOEXEC);
+	if (fd < 0)
+		return true; /* we'll fail later and propagate error */
+
+	/* ensure libelf is initialized */
+	(void)elf_version(EV_CURRENT);
+
+	elf = elf_begin(fd, ELF_C_READ, NULL);
+	if (!elf)
+		goto cleanup;
+
+	if (elf_kind(elf) != ELF_K_ELF || gelf_getclass(elf) != ELFCLASS64)
+		goto cleanup;
+
+	ehdr = elf64_getehdr(elf);
+	/* Old LLVM set e_machine to EM_NONE */
+	if (!ehdr || ehdr->e_type != ET_REL || (ehdr->e_machine && ehdr->e_machine != EM_BPF))
+		goto cleanup;
+
+	err = 0;
+cleanup:
+	if (elf)
+		elf_end(elf);
+	close(fd);
+	return err == 0;
+}
+
+static bool should_process_prog(const char *path, const char *prog_name)
 {
+	const char *filename = basename(path);
 	int i;
 
 	if (env.deny_filter_cnt > 0) {
@@ -303,7 +343,7 @@ static int append_filter_file(const char *path)
 	f = fopen(path, "r");
 	if (!f) {
 		err = -errno;
-		fprintf(stderr, "Failed to open '%s': %d\n", path, err);
+		fprintf(stderr, "Failed to open filters in '%s': %d\n", path, err);
 		return err;
 	}
 
@@ -463,8 +503,10 @@ static int process_prog(const char *filename, struct bpf_object *obj, struct bpf
 	int err = 0;
 	void *tmp;
 
-	if (!should_process_prog(basename(filename), bpf_program__name(prog)))
+	if (!should_process_prog(filename, bpf_program__name(prog))) {
+		env.progs_skipped++;
 		return 0;
+	}
 
 	tmp = realloc(env.prog_stats, (env.prog_stat_cnt + 1) * sizeof(*env.prog_stats));
 	if (!tmp)
@@ -487,6 +529,7 @@ static int process_prog(const char *filename, struct bpf_object *obj, struct bpf
 	verif_log_buf[0] = '\0';
 
 	err = bpf_object__load(obj);
+	env.progs_processed++;
 
 	stats->file_name = strdup(basename(filename));
 	stats->prog_name = strdup(bpf_program__name(prog));
@@ -513,18 +556,37 @@ static int process_obj(const char *filename)
 	LIBBPF_OPTS(bpf_object_open_opts, opts);
 	int err = 0, prog_cnt = 0;
 
-	if (!should_process_file(basename(filename)))
+	if (!should_process_file(basename(filename))) {
+		if (env.verbose)
+			printf("Skipping '%s' due to filters...\n", filename);
+		env.files_skipped++;
+		return 0;
+	}
+	if (!is_bpf_obj_file(filename)) {
+		if (env.verbose)
+			printf("Skipping '%s' as it's not a BPF object file...\n", filename);
+		env.files_skipped++;
 		return 0;
+	}
 
 	old_libbpf_print_fn = libbpf_set_print(libbpf_print_fn);
 
 	obj = bpf_object__open_file(filename, &opts);
 	if (!obj) {
-		err = -errno;
-		fprintf(stderr, "Failed to open '%s': %d\n", filename, err);
+		/* if libbpf can't open BPF object file, it could be because
+		 * that BPF object file is incomplete and has to be statically
+		 * linked into a final BPF object file; instead of bailing
+		 * out, report it into stderr, mark it as skipped, and
+		 * proceeed
+		 */
+		fprintf(stderr, "Failed to open '%s': %d\n", filename, -errno);
+		env.files_skipped++;
+		err = 0;
 		goto cleanup;
 	}
 
+	env.files_processed++;
+
 	bpf_object__for_each_program(prog, obj) {
 		prog_cnt++;
 	}
@@ -732,8 +794,8 @@ static void output_stats(const struct verif_stats *s, enum resfmt fmt, bool last
 
 	if (last && fmt == RESFMT_TABLE) {
 		output_header_underlines();
-		printf("Done. Processed %d object files, %d programs.\n",
-		       env.filename_cnt, env.prog_stat_cnt);
+		printf("Done. Processed %d files, %d programs. Skipped %d files, %d programs.\n",
+		       env.files_processed, env.files_skipped, env.progs_processed, env.progs_skipped);
 	}
 }
 
-- 
2.30.2

