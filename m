Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46F305BDB28
	for <lists+bpf@lfdr.de>; Tue, 20 Sep 2022 06:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiITEIM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 20 Sep 2022 00:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiITEIM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Sep 2022 00:08:12 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550AC4BA50
        for <bpf@vger.kernel.org>; Mon, 19 Sep 2022 21:08:10 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28JMssQI019883
        for <bpf@vger.kernel.org>; Mon, 19 Sep 2022 21:08:09 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jnbrxr4ms-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 19 Sep 2022 21:08:09 -0700
Received: from twshared15978.04.prn5.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 19 Sep 2022 21:08:08 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id BC4751F1BEC3E; Mon, 19 Sep 2022 21:08:02 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 3/3] selftests/bpf: add ability to filter programs in veristat
Date:   Mon, 19 Sep 2022 21:07:36 -0700
Message-ID: <20220920040736.342025-4-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220920040736.342025-1-andrii@kernel.org>
References: <20220920040736.342025-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 1MYIVZhCv-iyLhrQt9KB_9kItLSpgLqa
X-Proofpoint-ORIG-GUID: 1MYIVZhCv-iyLhrQt9KB_9kItLSpgLqa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-19_13,2022-09-16_01,2022-06-22_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add -f (--filter) argument which accepts glob-based filters for
narrowing down what BPF object files and programs within them should be
processed by veristat. This filtering applies both to comparison and
main (verification) mode.

Filter can be of two forms:
  - file (object) filter: 'strobemeta*'; in this case all the programs
    within matching files are implicitly allowed (or denied, depending
    if it's positive or negative rule, see below);
  - file and prog filter: 'strobemeta*/*unroll*' will further filter
    programs within matching files to only allow those program names that
    match '*unroll*' glob.

As mentioned, filters can be positive (allowlisting) and negative
(denylisting). Negative filters should start with '!': '!strobemeta*'
will deny any filename which basename starts with "strobemeta".

Further, one extra special syntax is supported to allow more convenient
use in practice. Instead of specifying rule on the command line,
veristat allows to specify file that contains rules, both positive and
negative, one line per one filter. This is achieved with -f @<filepath>
use, where <filepath> points to a text file containing rules (negative
and positive rules can be mixed). For convenience empty lines and lines
starting with '#' are ignored. This feature is useful to have some
pre-canned list of object files and program names that are tested
repeatedly, allowing to check in a list of rules and quickly specify
them on the command line.

As a demonstration (and a short cut for nearest future), create a small
list of "interesting" BPF object files from selftests/bpf and commit it
as veristat.cfg. It currently includes 73 programs, most of which are
the most complex and largest BPF programs in selftests, as judged by
total verified instruction count and verifier states total.

If there is overlap between positive or negative filters, negative
filter takes precedence (denylisting is stronger than allowlisting). If
no allow filter is specified, veristat implicitly assumes '*/*' rule. If
no deny rule is specified, veristat (logically) assumes no negative
filters.

Also note that -f (just like -e and -s) can be specified multiple times
and their effect is cumulative.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/veristat.c   | 212 ++++++++++++++++++++++-
 tools/testing/selftests/bpf/veristat.cfg |  16 ++
 2 files changed, 226 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/veristat.cfg

diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index 158b03aab517..7779bc342780 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -52,6 +52,11 @@ enum resfmt {
 	RESFMT_CSV,
 };
 
+struct filter {
+	char *file_glob;
+	char *prog_glob;
+};
+
 static struct env {
 	char **filenames;
 	int filename_cnt;
@@ -68,6 +73,11 @@ static struct env {
 
 	struct stat_specs output_spec;
 	struct stat_specs sort_spec;
+
+	struct filter *allow_filters;
+	struct filter *deny_filters;
+	int allow_filter_cnt;
+	int deny_filter_cnt;
 } env;
 
 static int libbpf_print_fn(enum libbpf_print_level level, const char *format, va_list args)
@@ -94,10 +104,13 @@ static const struct argp_option opts[] = {
 	{ "sort", 's', "SPEC", 0, "Specify sort order" },
 	{ "output-format", 'o', "FMT", 0, "Result output format (table, csv), default is table." },
 	{ "compare", 'C', NULL, 0, "Comparison mode" },
+	{ "filter", 'f', "FILTER", 0, "Filter expressions (or @filename for file with expressions)." },
 	{},
 };
 
 static int parse_stats(const char *stats_str, struct stat_specs *specs);
+static int append_filter(struct filter **filters, int *cnt, const char *str);
+static int append_filter_file(const char *path);
 
 static error_t parse_arg(int key, char *arg, struct argp_state *state)
 {
@@ -134,6 +147,18 @@ static error_t parse_arg(int key, char *arg, struct argp_state *state)
 	case 'C':
 		env.comparison_mode = true;
 		break;
+	case 'f':
+		if (arg[0] == '@')
+			err = append_filter_file(arg + 1);
+		else if (arg[0] == '!')
+			err = append_filter(&env.deny_filters, &env.deny_filter_cnt, arg + 1);
+		else
+			err = append_filter(&env.allow_filters, &env.allow_filter_cnt, arg);
+		if (err) {
+			fprintf(stderr, "Failed to collect program filter expressions: %d\n", err);
+			return err;
+		}
+		break;
 	case ARGP_KEY_ARG:
 		tmp = realloc(env.filenames, (env.filename_cnt + 1) * sizeof(*env.filenames));
 		if (!tmp)
@@ -156,6 +181,150 @@ static const struct argp argp = {
 	.doc = argp_program_doc,
 };
 
+
+/* Adapted from perf/util/string.c */
+static bool glob_matches(const char *str, const char *pat)
+{
+	while (*str && *pat && *pat != '*') {
+		if (*str != *pat)
+			return false;
+		str++;
+		pat++;
+	}
+	/* Check wild card */
+	if (*pat == '*') {
+		while (*pat == '*')
+			pat++;
+		if (!*pat) /* Tail wild card matches all */
+			return true;
+		while (*str)
+			if (glob_matches(str++, pat))
+				return true;
+	}
+	return !*str && !*pat;
+}
+
+static bool should_process_file(const char *filename)
+{
+	int i;
+
+	if (env.deny_filter_cnt > 0) {
+		for (i = 0; i < env.deny_filter_cnt; i++) {
+			if (glob_matches(filename, env.deny_filters[i].file_glob))
+				return false;
+		}
+	}
+
+	if (env.allow_filter_cnt == 0)
+		return true;
+
+	for (i = 0; i < env.allow_filter_cnt; i++) {
+		if (glob_matches(filename, env.allow_filters[i].file_glob))
+			return true;
+	}
+
+	return false;
+}
+
+static bool should_process_prog(const char *filename, const char *prog_name)
+{
+	int i;
+
+	if (env.deny_filter_cnt > 0) {
+		for (i = 0; i < env.deny_filter_cnt; i++) {
+			if (glob_matches(filename, env.deny_filters[i].file_glob))
+				return false;
+			if (!env.deny_filters[i].prog_glob)
+				continue;
+			if (glob_matches(prog_name, env.deny_filters[i].prog_glob))
+				return false;
+		}
+	}
+
+	if (env.allow_filter_cnt == 0)
+		return true;
+
+	for (i = 0; i < env.allow_filter_cnt; i++) {
+		if (!glob_matches(filename, env.allow_filters[i].file_glob))
+			continue;
+		/* if filter specifies only filename glob part, it implicitly
+		 * allows all progs within that file
+		 */
+		if (!env.allow_filters[i].prog_glob)
+			return true;
+		if (glob_matches(prog_name, env.allow_filters[i].prog_glob))
+			return true;
+	}
+
+	return false;
+}
+
+static int append_filter(struct filter **filters, int *cnt, const char *str)
+{
+	struct filter *f;
+	void *tmp;
+	const char *p;
+
+	tmp = realloc(*filters, (*cnt + 1) * sizeof(**filters));
+	if (!tmp)
+		return -ENOMEM;
+	*filters = tmp;
+
+	f = &(*filters)[*cnt];
+	f->file_glob = f->prog_glob = NULL;
+
+	/* filter can be specified either as "<obj-glob>" or "<obj-glob>/<prog-glob>" */
+	p = strchr(str, '/');
+	if (!p) {
+		f->file_glob = strdup(str);
+		if (!f->file_glob)
+			return -ENOMEM;
+	} else {
+		f->file_glob = strndup(str, p - str);
+		f->prog_glob = strdup(p + 1);
+		if (!f->file_glob || !f->prog_glob) {
+			free(f->file_glob);
+			free(f->prog_glob);
+			f->file_glob = f->prog_glob = NULL;
+			return -ENOMEM;
+		}
+	}
+
+	*cnt = *cnt + 1;
+	return 0;
+}
+
+static int append_filter_file(const char *path)
+{
+	char buf[1024];
+	FILE *f;
+	int err = 0;
+
+	f = fopen(path, "r");
+	if (!f) {
+		err = -errno;
+		fprintf(stderr, "Failed to open '%s': %d\n", path, err);
+		return err;
+	}
+
+	while (fscanf(f, " %1023[^\n]\n", buf) == 1) {
+		/* lines starting with # are comments, skip them */
+		if (buf[0] == '\0' || buf[0] == '#')
+			continue;
+		/* lines starting with ! are negative match filters */
+		if (buf[0] == '!')
+			err = append_filter(&env.deny_filters, &env.deny_filter_cnt, buf + 1);
+		else
+			err = append_filter(&env.allow_filters, &env.allow_filter_cnt, buf);
+		if (err)
+			goto cleanup;
+	}
+
+cleanup:
+	fclose(f);
+	return err;
+}
+
 static const struct stat_specs default_output_spec = {
 	.spec_cnt = 7,
 	.ids = {
@@ -283,6 +452,9 @@ static int process_prog(const char *filename, struct bpf_object *obj, struct bpf
 	int err = 0;
 	void *tmp;
 
+	if (!should_process_prog(basename(filename), bpf_program__name(prog)))
+		return 0;
+
 	tmp = realloc(env.prog_stats, (env.prog_stat_cnt + 1) * sizeof(*env.prog_stats));
 	if (!tmp)
 		return -ENOMEM;
@@ -330,6 +502,9 @@ static int process_obj(const char *filename)
 	LIBBPF_OPTS(bpf_object_open_opts, opts);
 	int err = 0, prog_cnt = 0;
 
+	if (!should_process_file(basename(filename)))
+		return 0;
+
 	old_libbpf_print_fn = libbpf_set_print(libbpf_print_fn);
 
 	obj = bpf_object__open_file(filename, &opts);
@@ -666,7 +841,10 @@ static int parse_stats_csv(const char *filename, struct stat_specs *specs,
 				goto cleanup;
 			}
 			*statsp = tmp;
+
 			st = &(*statsp)[*stat_cntp];
+			memset(st, 0, sizeof(*st));
+
 			*stat_cntp += 1;
 		}
 
@@ -692,14 +870,34 @@ static int parse_stats_csv(const char *filename, struct stat_specs *specs,
 			col++;
 		}
 
-		if (!header && col < specs->spec_cnt) {
+		if (header) {
+			header = false;
+			continue;
+		}
+
+		if (col < specs->spec_cnt) {
 			fprintf(stderr, "Not enough columns in row #%d in '%s'\n",
 				*stat_cntp, filename);
 			err = -EINVAL;
 			goto cleanup;
 		}
 
-		header = false;
+		if (!st->file_name || !st->prog_name) {
+			fprintf(stderr, "Row #%d in '%s' is missing file and/or program name\n",
+				*stat_cntp, filename);
+			err = -EINVAL;
+			goto cleanup;
+		}
+
+		/* in comparison mode we can only check filters after we
+		 * parsed entire line; if row should be ignored we pretend we
+		 * never parsed it
+		 */
+		if (!should_process_prog(st->file_name, st->prog_name)) {
+			free(st->file_name);
+			free(st->prog_name);
+			*stat_cntp -= 1;
+		}
 	}
 
 	if (!feof(f)) {
@@ -1012,5 +1210,15 @@ int main(int argc, char **argv)
 	for (i = 0; i < env.filename_cnt; i++)
 		free(env.filenames[i]);
 	free(env.filenames);
+	for (i = 0; i < env.allow_filter_cnt; i++) {
+		free(env.allow_filters[i].file_glob);
+		free(env.allow_filters[i].prog_glob);
+	}
+	free(env.allow_filters);
+	for (i = 0; i < env.deny_filter_cnt; i++) {
+		free(env.deny_filters[i].file_glob);
+		free(env.deny_filters[i].prog_glob);
+	}
+	free(env.deny_filters);
 	return -err;
 }
diff --git a/tools/testing/selftests/bpf/veristat.cfg b/tools/testing/selftests/bpf/veristat.cfg
new file mode 100644
index 000000000000..7139d3ab0f77
--- /dev/null
+++ b/tools/testing/selftests/bpf/veristat.cfg
@@ -0,0 +1,16 @@
+# pre-canned list of rather complex selftests/bpf BPF object files to monitor
+# BPF verifier's performance on
+bpf_flow*
+bpf_loop_bench*
+loop*
+netif_receive_skb*
+profiler*
+pyperf*
+strobemeta*
+test_cls_redirect*
+test_l4lb
+test_sysctl*
+test_tcp_hdr_*
+test_usdt*
+test_verif_scale*
+test_xdp_noinline*
-- 
2.30.2

