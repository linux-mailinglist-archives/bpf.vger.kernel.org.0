Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE6165A3271
	for <lists+bpf@lfdr.de>; Sat, 27 Aug 2022 01:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbiHZXPu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 26 Aug 2022 19:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345473AbiHZXPs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Aug 2022 19:15:48 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03B4D51F2
        for <bpf@vger.kernel.org>; Fri, 26 Aug 2022 16:15:46 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27QIP8In017895
        for <bpf@vger.kernel.org>; Fri, 26 Aug 2022 16:15:46 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j6g8e09n7-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 26 Aug 2022 16:15:45 -0700
Received: from twshared30313.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 26 Aug 2022 16:15:44 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 357021E283E73; Fri, 26 Aug 2022 16:15:40 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 3/3] selftests/bpf: add veristat tool for mass-verifying BPF object files
Date:   Fri, 26 Aug 2022 16:15:31 -0700
Message-ID: <20220826231531.1031943-4-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220826231531.1031943-1-andrii@kernel.org>
References: <20220826231531.1031943-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: vybg9fqm9AMEop1tP_qiTGgYTcfBNCgR
X-Proofpoint-ORIG-GUID: vybg9fqm9AMEop1tP_qiTGgYTcfBNCgR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-26_12,2022-08-25_01,2022-06-22_01
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a small tool, veristat, that allows mass-verification of
a set of *libbpf-compatible* BPF ELF object files. For each such object
file, veristat will attempt to verify each BPF program *individually*.
Regardless of success or failure, it parses BPF verifier stats and
outputs them in human-readable table format. In the future we can also
add CSV and JSON output for more scriptable post-processing, if necessary.

veristat allows to specify a set of stats that should be output and
ordering between multiple objects and files (e.g., so that one can
easily order by total instructions processed, instead of default file
name, prog name, verdict, total instructions order).

This tool should be useful for validating various BPF verifier changes
or even validating different kernel versions for regressions.

Here's an example for some of the heaviest selftests/bpf BPF object
files:

  $ sudo ./veristat -s insns,file,prog {pyperf,loop,test_verif_scale,strobemeta,test_cls_redirect,profiler}*.linked3.o
  File                                  Program                               Verdict  Duration, us  Total insns  Total states  Peak states
  ------------------------------------  ------------------------------------  -------  ------------  -----------  ------------  -----------
  loop3.linked3.o                       while_true                            failure        350990      1000001          9663         9663
  test_verif_scale3.linked3.o           balancer_ingress                      success        115244       845499          8636         2141
  test_verif_scale2.linked3.o           balancer_ingress                      success         77688       773445          3048          788
  pyperf600.linked3.o                   on_event                              success       2079872       624585         30335        30241
  pyperf600_nounroll.linked3.o          on_event                              success        353972       568128         37101         2115
  strobemeta.linked3.o                  on_event                              success        455230       557149         15915        13537
  test_verif_scale1.linked3.o           balancer_ingress                      success         89880       554754          8636         2141
  strobemeta_nounroll2.linked3.o        on_event                              success        433906       501725         17087         1912
  loop6.linked3.o                       trace_virtqueue_add_sgs               success        282205       398057          8717          919
  loop1.linked3.o                       nested_loops                          success        125630       361349          5504         5504
  pyperf180.linked3.o                   on_event                              success       2511740       160398         11470        11446
  pyperf100.linked3.o                   on_event                              success        744329        87681          6213         6191
  test_cls_redirect.linked3.o           cls_redirect                          success         54087        78925          4782          903
  strobemeta_subprogs.linked3.o         on_event                              success         57898        65420          1954          403
  test_cls_redirect_subprogs.linked3.o  cls_redirect                          success         54522        64965          4619          958
  strobemeta_nounroll1.linked3.o        on_event                              success         43313        57240          1757          382
  pyperf50.linked3.o                    on_event                              success        194355        46378          3263         3241
  profiler2.linked3.o                   tracepoint__syscalls__sys_enter_kill  success         23869        43372          1423          542
  pyperf_subprogs.linked3.o             on_event                              success         29179        36358          2499         2499
  profiler1.linked3.o                   tracepoint__syscalls__sys_enter_kill  success         13052        27036          1946          936
  profiler3.linked3.o                   tracepoint__syscalls__sys_enter_kill  success         21023        26016          2186          915
  profiler2.linked3.o                   kprobe__vfs_link                      success          5255        13896           303          271
  profiler1.linked3.o                   kprobe__vfs_link                      success          7792        12687          1042         1041
  profiler3.linked3.o                   kprobe__vfs_link                      success          7332        10601           865          865
  profiler2.linked3.o                   kprobe_ret__do_filp_open              success          3417         8900           216          199
  profiler2.linked3.o                   kprobe__vfs_symlink                   success          3548         8775           203          186
  pyperf_global.linked3.o               on_event                              success         10007         7563           520          520
  profiler3.linked3.o                   kprobe_ret__do_filp_open              success          4708         6464           532          532
  profiler1.linked3.o                   kprobe_ret__do_filp_open              success          3090         6445           508          508
  profiler3.linked3.o                   kprobe__vfs_symlink                   success          4477         6358           521          521
  profiler1.linked3.o                   kprobe__vfs_symlink                   success          3381         6347           507          507
  profiler2.linked3.o                   raw_tracepoint__sched_process_exec    success          2464         5874           292          189
  profiler3.linked3.o                   raw_tracepoint__sched_process_exec    success          2677         4363           397          283
  profiler2.linked3.o                   kprobe__proc_sys_write                success          1800         4355           143          138
  profiler1.linked3.o                   raw_tracepoint__sched_process_exec    success          1649         4019           333          240
  pyperf600_bpf_loop.linked3.o          on_event                              success          2711         3966           306          306
  profiler2.linked3.o                   raw_tracepoint__sched_process_exit    success          1234         3138            83           66
  profiler3.linked3.o                   kprobe__proc_sys_write                success          1755         2623           223          223
  profiler1.linked3.o                   kprobe__proc_sys_write                success          1222         2456           193          193
  loop2.linked3.o                       while_true                            success           608         1783            57           30
  profiler3.linked3.o                   raw_tracepoint__sched_process_exit    success           789         1680           146          146
  profiler1.linked3.o                   raw_tracepoint__sched_process_exit    success           592         1526           133          133
  strobemeta_bpf_loop.linked3.o         on_event                              success          1015         1512           106          106
  loop4.linked3.o                       combinations                          success           165          524            18           17
  profiler3.linked3.o                   raw_tracepoint__sched_process_fork    success           196          299            25           25
  profiler1.linked3.o                   raw_tracepoint__sched_process_fork    success           109          265            19           19
  profiler2.linked3.o                   raw_tracepoint__sched_process_fork    success           111          265            19           19
  loop5.linked3.o                       while_true                            success            47           84             9            9
  ------------------------------------  ------------------------------------  -------  ------------  -----------  ------------  -----------

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/.gitignore |   1 +
 tools/testing/selftests/bpf/Makefile   |   6 +-
 tools/testing/selftests/bpf/veristat.c | 541 +++++++++++++++++++++++++
 3 files changed, 547 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/veristat.c

diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
index 3a8cb2404ea6..3b288562963e 100644
--- a/tools/testing/selftests/bpf/.gitignore
+++ b/tools/testing/selftests/bpf/.gitignore
@@ -39,6 +39,7 @@ test_cpp
 /tools
 /runqslower
 /bench
+/veristat
 *.ko
 *.tmp
 xskxceiver
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index eecad99f1735..7a81dda8215f 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -82,7 +82,7 @@ TEST_PROGS_EXTENDED := with_addr.sh \
 TEST_GEN_PROGS_EXTENDED = test_sock_addr test_skb_cgroup_id_user \
 	flow_dissector_load test_flow_dissector test_tcp_check_syncookie_user \
 	test_lirc_mode2_user xdping test_cpp runqslower bench bpf_testmod.ko \
-	xskxceiver xdp_redirect_multi xdp_synproxy
+	xskxceiver xdp_redirect_multi xdp_synproxy veristat
 
 TEST_CUSTOM_PROGS = $(OUTPUT)/urandom_read
 
@@ -594,6 +594,10 @@ $(OUTPUT)/bench: $(OUTPUT)/bench.o \
 	$(call msg,BINARY,,$@)
 	$(Q)$(CC) $(CFLAGS) $(LDFLAGS) $(filter %.a %.o,$^) $(LDLIBS) -o $@
 
+$(OUTPUT)/veristat: $(OUTPUT)/veristat.o $(BPFOBJ)
+	$(call msg,BINARY,,$@)
+	$(Q)$(CC) $(CFLAGS) $(LDFLAGS) $(filter %.a %.o,$^) $(LDLIBS) -o $@
+
 EXTRA_CLEAN := $(TEST_CUSTOM_PROGS) $(SCRATCH_DIR) $(HOST_SCRATCH_DIR)	\
 	prog_tests/tests.h map_tests/tests.h verifier/tests.h		\
 	feature bpftool							\
diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
new file mode 100644
index 000000000000..133cf3bb8eda
--- /dev/null
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -0,0 +1,541 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+#define _GNU_SOURCE
+#include <argp.h>
+#include <string.h>
+#include <stdlib.h>
+#include <linux/compiler.h>
+#include <sched.h>
+#include <pthread.h>
+#include <dirent.h>
+#include <signal.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <sys/time.h>
+#include <sys/sysinfo.h>
+#include <sys/stat.h>
+#include <bpf/libbpf.h>
+
+enum stat_id {
+	VERDICT,
+	DURATION,
+	TOTAL_INSNS,
+	TOTAL_STATES,
+	PEAK_STATES,
+	MAX_STATES_PER_INSN,
+	MARK_READ_MAX_LEN,
+
+	FILE_NAME,
+	PROG_NAME,
+
+	ALL_STATS_CNT,
+	NUM_STATS_CNT = FILE_NAME - VERDICT,
+};
+
+struct verif_stats {
+	char *file_name;
+	char *prog_name;
+	
+	long stats[NUM_STATS_CNT];
+};
+
+struct stat_specs {
+	int spec_cnt;
+	enum stat_id ids[ALL_STATS_CNT];
+	bool asc[ALL_STATS_CNT];
+	int lens[ALL_STATS_CNT];
+};
+
+static struct env {
+	char **filenames;
+	int filename_cnt;
+	bool verbose;
+
+	struct verif_stats *prog_stats;
+	int prog_stat_cnt;
+
+	struct stat_specs output_spec;
+	struct stat_specs sort_spec;
+} env;
+
+static int libbpf_print_fn(enum libbpf_print_level level,
+		    const char *format, va_list args)
+{
+	if (!env.verbose)
+		return 0;
+	if (level == LIBBPF_DEBUG /* && !env.verbose */)
+		return 0;
+	return vfprintf(stderr, format, args);
+}
+
+const char *argp_program_version = "veristat";
+const char *argp_program_bug_address = "<bpf@vger.kernel.org>";
+const char argp_program_doc[] =
+"veristat    BPF verifier stats collection tool.\n"
+"\n"
+"USAGE: veristat <obj-file> [<obj-file>...]\n";
+
+static const struct argp_option opts[] = {
+	{ NULL, 'h', NULL, OPTION_HIDDEN, "Show the full help" },
+	{ "verbose", 'v', NULL, 0, "Verbose mode" },
+	{ "output", 'o', "SPEC", 0, "Specify output stats" },
+	{ "sort", 's', "SPEC", 0, "Specify sort order" },
+	{},
+};
+
+static int parse_stats(const char *stats_str, struct stat_specs *specs);
+
+static error_t parse_arg(int key, char *arg, struct argp_state *state)
+{
+	void *tmp;
+	int err;
+
+	switch (key) {
+	case 'h':
+		argp_state_help(state, stderr, ARGP_HELP_STD_HELP);
+		break;
+	case 'v':
+		env.verbose = true;
+		break;
+	case 'o':
+		err = parse_stats(arg, &env.output_spec);
+		if (err)
+			return err;
+		break;
+	case 's':
+		err = parse_stats(arg, &env.sort_spec);
+		if (err)
+			return err;
+		break;
+	case ARGP_KEY_ARG:
+		tmp = realloc(env.filenames, (env.filename_cnt + 1) * sizeof(*env.filenames));
+		if (!tmp)
+			return -ENOMEM;
+		env.filenames = tmp;
+		env.filenames[env.filename_cnt] = strdup(arg);
+		if (!env.filenames[env.filename_cnt])
+			return -ENOMEM;
+		env.filename_cnt++;
+		break;
+	default:
+		return ARGP_ERR_UNKNOWN;
+	}
+	return 0;
+}
+
+static const struct stat_specs default_output_spec = {
+	.spec_cnt = 7,
+	.ids = {
+		FILE_NAME, PROG_NAME, VERDICT, DURATION,
+		TOTAL_INSNS, TOTAL_STATES, PEAK_STATES,
+	},
+};
+
+static const struct stat_specs default_sort_spec = {
+	.spec_cnt = 2,
+	.ids = {
+		FILE_NAME, PROG_NAME,
+	},
+	.asc = { true, true, },
+};
+
+static struct stat_def {
+	const char *header;
+	const char *names[4];
+	bool asc_by_default;
+} stat_defs[] = {
+	[FILE_NAME] = { "File", {"file_name", "filename", "file"}, true /* asc */ },
+	[PROG_NAME] = { "Program", {"prog_name", "progname", "prog"}, true /* asc */ },
+	[VERDICT] = { "Verdict", {"verdict"}, true /* asc: failure, success */ },
+	[DURATION] = { "Duration, us", {"duration", "dur"}, },
+	[TOTAL_INSNS] = { "Total insns", {"total_insns", "insns"}, },
+	[TOTAL_STATES] = { "Total states", {"total_states", "states"}, },
+	[PEAK_STATES] = { "Peak states", {"peak_states"}, },
+	[MAX_STATES_PER_INSN] = { "Max states per insn", {"max_states_per_insn"}, },
+	[MARK_READ_MAX_LEN] = { "Max mark read length", {"max_mark_read_len", "mark_read"}, },
+};
+
+static int parse_stat(const char *stat_name, struct stat_specs *specs)
+{
+	int id, i;
+
+	if (specs->spec_cnt >= ARRAY_SIZE(specs->ids)) {
+		fprintf(stderr, "Can't specify more than %zd stats\n", ARRAY_SIZE(specs->ids));
+		return -E2BIG;
+	}
+
+	for (id = 0; id < ARRAY_SIZE(stat_defs); id++) {
+		struct stat_def *def = &stat_defs[id];
+
+		for (i = 0; i < ARRAY_SIZE(stat_defs[id].names); i++) {
+			if (!def->names[i] || strcmp(def->names[i], stat_name) != 0)
+				continue;
+
+			specs->ids[specs->spec_cnt] = id;
+			specs->asc[specs->spec_cnt] = def->asc_by_default;
+			specs->spec_cnt++;
+
+			return 0;
+		}
+	}
+
+	fprintf(stderr, "Unrecognized stat name '%s'\n", stat_name);
+	return -ESRCH;
+}
+
+static int parse_stats(const char *stats_str, struct stat_specs *specs)
+{
+	char *input, *state = NULL, *next;
+	int err;
+
+	input = strdup(stats_str);
+	if (!input)
+		return -ENOMEM;
+
+	while ((next = strtok_r(state ? NULL : input, ",", &state))) {
+		err = parse_stat(next, specs);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static char verif_log_buf[64 * 1024];
+
+static int parse_verif_log(const char *buf, size_t buf_sz, struct verif_stats *s)
+{
+	const char *next;
+	int pos;
+
+	for (pos = 0; buf[0]; buf = next) {
+		if (buf[0] == '\n')
+			buf++;
+		next = strchrnul(&buf[pos], '\n');
+
+		if (1 == sscanf(buf, "verification time %ld usec\n", &s->stats[DURATION]))
+			continue;
+		if (6 == sscanf(buf, "processed %ld insns (limit %*d) max_states_per_insn %ld total_states %ld peak_states %ld mark_read %ld",
+				&s->stats[TOTAL_INSNS],
+				&s->stats[MAX_STATES_PER_INSN],
+				&s->stats[TOTAL_STATES],
+				&s->stats[PEAK_STATES],
+				&s->stats[MARK_READ_MAX_LEN]))
+			continue;
+	}
+
+	return 0;
+}
+
+static int process_prog(const char *filename, struct bpf_object *obj, struct bpf_program *prog)
+{
+	const char *prog_name = bpf_program__name(prog);
+	size_t buf_sz = sizeof(verif_log_buf);
+	char *buf = verif_log_buf;
+	struct verif_stats *stats;
+	int err = 0;
+	void *tmp;
+
+	tmp = realloc(env.prog_stats, (env.prog_stat_cnt + 1) * sizeof(*env.prog_stats));
+	if (!tmp)
+		return -ENOMEM;
+	env.prog_stats = tmp;
+	stats = &env.prog_stats[env.prog_stat_cnt++];
+	memset(stats, 0, sizeof(*stats));
+
+	if (env.verbose) {
+		buf_sz = 16 * 1024 * 1024;
+		buf = malloc(buf_sz);
+		if (!buf)
+			return -ENOMEM;
+		bpf_program__set_log_buf(prog, buf, buf_sz);
+		bpf_program__set_log_level(prog, 1 | 4); /* stats + log */
+	} else {
+		bpf_program__set_log_buf(prog, buf, buf_sz);
+		bpf_program__set_log_level(prog, 4); /* only verifier stats */
+	}
+	verif_log_buf[0] = '\0';
+
+	err = bpf_object__load(obj);
+
+	stats->file_name = strdup(basename(filename));
+	stats->prog_name = strdup(bpf_program__name(prog));
+	stats->stats[VERDICT] = err == 0; /* 1 - success, 0 - failure */
+	parse_verif_log(buf, buf_sz, stats);
+
+	if (env.verbose) {
+		printf("PROCESSING %s/%s, DURATION US: %ld, VERDICT: %s, VERIFIER LOG:\n%s\n",
+		       filename, prog_name, stats->stats[DURATION],
+		       err ? "failure" : "success", buf);
+	}
+
+	if (verif_log_buf != buf)
+		free(buf);
+
+	return 0;
+};
+
+static int process_obj(const char *filename)
+{
+	struct bpf_object *obj = NULL, *tobj;
+	struct bpf_program *prog, *tprog, *lprog;
+	libbpf_print_fn_t old_libbpf_print_fn;
+	LIBBPF_OPTS(bpf_object_open_opts, opts);
+	int err = 0, prog_cnt = 0;
+
+	old_libbpf_print_fn = libbpf_set_print(libbpf_print_fn);
+
+	obj = bpf_object__open_file(filename, &opts);
+	if (!obj) {
+		err = -errno;
+		fprintf(stderr, "Failed to open '%s': %d\n", filename, err);
+		goto cleanup;
+	}
+
+	bpf_object__for_each_program(prog, obj) {
+		prog_cnt++;
+	}
+
+	if (prog_cnt == 1) {
+		prog = bpf_object__next_program(obj, NULL);
+		bpf_program__set_autoload(prog, true);
+		process_prog(filename, obj, prog);
+		bpf_object__close(obj);
+		goto cleanup;
+	}
+
+	bpf_object__for_each_program(prog, obj) {
+		const char *prog_name = bpf_program__name(prog);
+
+		tobj = bpf_object__open_file(filename, &opts);
+		if (!tobj) {
+			err = -errno;
+			fprintf(stderr, "Failed to open '%s': %d\n", filename, err);
+			goto cleanup;
+		}
+
+		bpf_object__for_each_program(tprog, tobj) {
+			const char *tprog_name = bpf_program__name(tprog);
+
+			if (strcmp(prog_name, tprog_name) == 0) {
+				bpf_program__set_autoload(tprog, true);
+				lprog = tprog;
+			} else {
+				bpf_program__set_autoload(tprog, false);
+			}
+		}
+
+		process_prog(filename, tobj, lprog);
+		bpf_object__close(tobj);
+	}
+
+cleanup:
+	libbpf_set_print(old_libbpf_print_fn);
+	return err;
+}
+
+static int cmp_stat(const struct verif_stats *s1, const struct verif_stats *s2,
+		    enum stat_id id, bool asc)
+{
+	int cmp = 0;
+
+	switch (id) {
+	case FILE_NAME:
+		cmp = strcmp(s1->file_name, s2->file_name);
+		break;
+	case PROG_NAME:
+		cmp = strcmp(s1->prog_name, s2->prog_name);
+		break;
+	case VERDICT:
+	case DURATION:
+	case TOTAL_INSNS:
+	case TOTAL_STATES:
+	case PEAK_STATES:
+	case MAX_STATES_PER_INSN:
+	case MARK_READ_MAX_LEN: {
+		long v1 = s1->stats[id];
+		long v2 = s2->stats[id];
+
+		if (v1 != v2)
+			cmp = v1 < v2 ? -1 : 1;
+		break;
+	}
+	default:
+		fprintf(stderr, "Unrecognized stat #%d\n", id);
+		exit(1);
+	}
+
+	return asc ? cmp : -cmp;
+}
+
+static int cmp_prog_stats(const void *v1, const void *v2)
+{
+	const struct verif_stats *s1 = v1, *s2 = v2;
+	int i, cmp;
+
+	for (i = 0; i < env.sort_spec.spec_cnt; i++) {
+		cmp = cmp_stat(s1, s2, env.sort_spec.ids[i], env.sort_spec.asc[i]);
+		if (cmp != 0)
+			return cmp;
+	}
+
+	return 0;
+}
+
+#define snappendf(dst, len, fmt, args...)					\
+	len += snprintf(dst + len,						\
+			      sizeof(dst) < len ? 0 : sizeof(dst) - len,	\
+			      fmt, ##args)
+
+#define HEADER_CHAR '-'
+#define COLUMN_SEP "  "
+
+static void output_headers(bool calc_len)
+{
+	int i, len;
+
+	for (i = 0; i < env.output_spec.spec_cnt; i++) {
+		int id = env.output_spec.ids[i];
+		int *max_len = &env.output_spec.lens[i];
+
+		if (calc_len) {
+			len = snprintf(NULL, 0, "%s", stat_defs[id].header);
+			if (len > *max_len)
+				*max_len = len;
+		} else {
+			printf("%s%-*s", i == 0 ? "" : COLUMN_SEP,  *max_len, stat_defs[id].header);
+		}
+	}
+
+	if (!calc_len)
+		printf("\n");
+}
+
+static void output_lines(void)
+{
+	int i, j, len;
+
+	for (i = 0; i < env.output_spec.spec_cnt; i++) {
+		len = env.output_spec.lens[i];
+
+		printf("%s", i == 0 ? "" : COLUMN_SEP);
+		for (j = 0; j < len; j++)
+			printf("%c", HEADER_CHAR);
+	}
+	printf("\n");
+}
+
+static void output_stats(const struct verif_stats *s, bool calc_len)
+{
+	int i;
+
+	for (i = 0; i < env.output_spec.spec_cnt; i++) {
+		int id = env.output_spec.ids[i];
+		int *max_len = &env.output_spec.lens[i], len;
+		const char *str = NULL;
+		long val = 0;
+
+		switch (id) {
+		case FILE_NAME:
+			str = s->file_name;
+			break;
+		case PROG_NAME:
+			str = s->prog_name;
+			break;
+		case VERDICT:
+			str = s->stats[VERDICT] ? "success" : "failure";
+			break;
+		case DURATION:
+		case TOTAL_INSNS:
+		case TOTAL_STATES:
+		case PEAK_STATES:
+		case MAX_STATES_PER_INSN:
+		case MARK_READ_MAX_LEN:
+			val = s->stats[id];
+			break;
+		default:
+			fprintf(stderr, "Unrecognized stat #%d\n", id);
+			exit(1);
+		}
+		
+		if (calc_len) {
+			if (str)
+				len = snprintf(NULL, 0, "%s", str);
+			else
+				len = snprintf(NULL, 0, "%ld", val);
+			if (len > *max_len)
+				*max_len = len;
+		} else {
+			if (str)
+				printf("%s%-*s", i == 0 ? "" : COLUMN_SEP, *max_len, str);
+			else
+				printf("%s%*ld", i == 0 ? "" : COLUMN_SEP,  *max_len, val);
+		}
+	}
+
+	if (!calc_len)
+		printf("\n");
+}
+
+int main(int argc, char **argv)
+{
+	static const struct argp argp = {
+		.options = opts,
+		.parser = parse_arg,
+		.doc = argp_program_doc,
+	};
+	int err = 0, i;
+
+	if (argp_parse(&argp, argc, argv, 0, NULL, NULL))
+		return 1;
+
+	if (env.filename_cnt == 0) {
+		fprintf(stderr, "Please provide path to BPF object file!\n");
+		argp_help(&argp, stderr, ARGP_HELP_USAGE, "veristat");
+		return 1;
+	}
+
+	if (env.output_spec.spec_cnt == 0)
+		env.output_spec = default_output_spec;
+	if (env.sort_spec.spec_cnt == 0)
+		env.sort_spec = default_sort_spec;
+
+	for (i = 0; i < env.filename_cnt; i++) {
+		err = process_obj(env.filenames[i]);
+		if (err) {
+			fprintf(stderr, "Failed to process '%s': %d\n", env.filenames[i], err);
+			goto cleanup;
+		}
+	}
+
+	qsort(env.prog_stats, env.prog_stat_cnt, sizeof(*env.prog_stats), cmp_prog_stats);
+
+	/* calculate column widths */
+	output_headers(true);
+	for (i = 0; i < env.prog_stat_cnt; i++) {
+		output_stats(&env.prog_stats[i], true);
+	}
+
+	/* actually output the table */
+	output_headers(false);
+	output_lines();
+	for (i = 0; i < env.prog_stat_cnt; i++) {
+		output_stats(&env.prog_stats[i], false);
+	}
+	output_lines();
+	printf("\n");
+
+	printf("Done. Processed %d object files, %d programs.\n",
+	       env.filename_cnt, env.prog_stat_cnt);
+
+cleanup:
+	for (i = 0; i < env.prog_stat_cnt; i++) {
+		free(env.prog_stats[i].file_name);
+		free(env.prog_stats[i].prog_name);
+	}
+	free(env.prog_stats);
+	for (i = 0; i < env.filename_cnt; i++)
+		free(env.filenames[i]);
+	free(env.filenames);
+	return -err;
+}
-- 
2.30.2

