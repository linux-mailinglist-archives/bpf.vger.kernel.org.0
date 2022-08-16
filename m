Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C99595EAC
	for <lists+bpf@lfdr.de>; Tue, 16 Aug 2022 17:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbiHPPAO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Aug 2022 11:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236074AbiHPO7h (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Aug 2022 10:59:37 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8475D52DD9
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 07:59:22 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4M6Z3P0jqgzlW2X;
        Tue, 16 Aug 2022 22:56:17 +0800 (CST)
Received: from CHINA (10.175.102.38) by canpemm500009.china.huawei.com
 (7.192.105.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 16 Aug
 2022 22:59:19 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     <bpf@vger.kernel.org>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        Quentin Monnet <quentin@isovalent.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH bpf-next] bpftool: Add trace subcommand
Date:   Tue, 16 Aug 2022 15:17:25 +0000
Message-ID: <20220816151725.153343-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.102.38]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently, only one command is supported
  bpftool trace pin <bpf_prog.o> <path>

It will pin the trace bpf program in the object file <bpf_prog.o>
to the <path> where <path> should be on a bpffs mount.

For example,
  $ bpftool trace pin ./mtd_mchp23k256.o /sys/fs/bpf/mchp23k256

The implementation a BPF based backend for mockup mchp23k256 mtd
SPI device.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 .../bpftool/Documentation/bpftool-trace.rst   |  57 +++++++++
 tools/bpf/bpftool/Documentation/bpftool.rst   |   4 +-
 tools/bpf/bpftool/bash-completion/bpftool     |  13 ++
 tools/bpf/bpftool/main.c                      |   1 +
 tools/bpf/bpftool/main.h                      |   1 +
 tools/bpf/bpftool/trace.c                     | 120 ++++++++++++++++++
 6 files changed, 195 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-trace.rst b/tools/bpf/bpftool/Documentation/bpftool-trace.rst
new file mode 100644
index 000000000000..d44256f6a021
--- /dev/null
+++ b/tools/bpf/bpftool/Documentation/bpftool-trace.rst
@@ -0,0 +1,57 @@
+.. SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+
+============
+bpftool-trace
+============
+-------------------------------------------------------------------------------
+tool to create BPF tracepoints
+-------------------------------------------------------------------------------
+
+:Manual section: 8
+
+.. include:: substitutions.rst
+
+SYNOPSIS
+========
+
+	**bpftool** [*OPTIONS*] **trace** *COMMAND*
+
+	*OPTIONS* := { |COMMON_OPTIONS| }
+
+	*COMMANDS* := { **pin** | **help** }
+
+ITER COMMANDS
+===================
+
+|	**bpftool** **trace pin** *OBJ* *PATH*
+|	**bpftool** **trace help**
+|
+|	*OBJ* := /a/file/of/bpf_tp_target.o
+
+DESCRIPTION
+===========
+	**bpftool trace pin** *OBJ* *PATH*
+                  A bpf raw tracepoint allows a tracepoint to provide a safe
+                  buffer that can be read or written from a bpf program.
+
+		  The *pin* command attaches a bpf raw tracepoint from *OBJ*,
+		  and pin it to *PATH*. The *PATH* should be located
+		  in *bpffs* mount. It must not contain a dot
+		  character ('.'), which is reserved for future extensions
+		  of *bpffs*.
+
+	**bpftool trace help**
+		  Print short help message.
+
+OPTIONS
+=======
+	.. include:: common_options.rst
+
+EXAMPLES
+========
+**# bpftool trace pin bpf_mtd_chip_mockup.o /sys/fs/bpf/mtd_chip_mockup**
+
+::
+
+   Attach to the raw tracepoint from bpf_mtd_chip_mockup.o and pin it
+   to /sys/fs/bpf/mtd_chip_mockup
diff --git a/tools/bpf/bpftool/Documentation/bpftool.rst b/tools/bpf/bpftool/Documentation/bpftool.rst
index 6965c94dfdaf..aae13255a8cb 100644
--- a/tools/bpf/bpftool/Documentation/bpftool.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool.rst
@@ -21,7 +21,7 @@ SYNOPSIS
 	**bpftool** **version**
 
 	*OBJECT* := { **map** | **program** | **link** | **cgroup** | **perf** | **net** | **feature** |
-	**btf** | **gen** | **struct_ops** | **iter** }
+	**btf** | **gen** | **struct_ops** | **iter** | **trace** }
 
 	*OPTIONS* := { { **-V** | **--version** } | |COMMON_OPTIONS| }
 
@@ -50,6 +50,8 @@ SYNOPSIS
 
 	*ITER-COMMANDS* := { **pin** | **help** }
 
+	*TRACE-COMMANDS* := { **pin** | **help** }
+
 DESCRIPTION
 ===========
 	*bpftool* allows for inspection and simple modification of BPF objects
diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
index dc1641e3670e..1c0442ed7436 100644
--- a/tools/bpf/bpftool/bash-completion/bpftool
+++ b/tools/bpf/bpftool/bash-completion/bpftool
@@ -646,6 +646,19 @@ _bpftool()
                     ;;
             esac
             ;;
+        trace)
+            case $command in
+                pin)
+                    _filedir
+                    return 0
+                    ;;
+                *)
+                    [[ $prev == $object ]] && \
+                        COMPREPLY=( $( compgen -W 'pin help' \
+                            -- "$cur" ) )
+                    ;;
+            esac
+            ;;
         map)
             local MAP_TYPE='id pinned name'
             case $command in
diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
index ccd7457f92bf..d24373f4e957 100644
--- a/tools/bpf/bpftool/main.c
+++ b/tools/bpf/bpftool/main.c
@@ -295,6 +295,7 @@ static const struct cmd cmds[] = {
 	{ "gen",	do_gen },
 	{ "struct_ops",	do_struct_ops },
 	{ "iter",	do_iter },
+	{ "trace",	do_trace },
 	{ "version",	do_version },
 	{ 0 }
 };
diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
index 5e5060c2ac04..7ff53de4f718 100644
--- a/tools/bpf/bpftool/main.h
+++ b/tools/bpf/bpftool/main.h
@@ -163,6 +163,7 @@ int do_tracelog(int argc, char **arg) __weak;
 int do_feature(int argc, char **argv) __weak;
 int do_struct_ops(int argc, char **argv) __weak;
 int do_iter(int argc, char **argv) __weak;
+int do_trace(int argc, char **arg) __weak;
 
 int parse_u32_arg(int *argc, char ***argv, __u32 *val, const char *what);
 int prog_parse_fd(int *argc, char ***argv);
diff --git a/tools/bpf/bpftool/trace.c b/tools/bpf/bpftool/trace.c
new file mode 100644
index 000000000000..08dd6e1d8f39
--- /dev/null
+++ b/tools/bpf/bpftool/trace.c
@@ -0,0 +1,120 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+// Copyright (C) 2022 Huawei Technologies Co., Ltd.
+
+#include <stdio.h>
+#include <unistd.h>
+#include <errno.h>
+#include <bpf/libbpf.h>
+
+#include "json_writer.h"
+#include "main.h"
+
+static bool is_trace_program_type(struct bpf_program *prog)
+{
+	enum bpf_prog_type trace_types[] = {
+		BPF_PROG_TYPE_RAW_TRACEPOINT,
+		BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE,
+	};
+	enum bpf_prog_type prog_type;
+	size_t i;
+
+	prog_type = bpf_program__type(prog);
+	for (i = 0; i < ARRAY_SIZE(trace_types); i++) {
+		if (prog_type == trace_types[i])
+			return true;
+	}
+
+	return false;
+}
+
+static int do_pin(int argc, char **argv)
+{
+	const char *objfile, *path;
+	struct bpf_program *prog;
+	struct bpf_object *obj;
+	struct bpf_link *link;
+	int err;
+
+	if (!REQ_ARGS(2))
+		usage();
+
+	objfile = GET_ARG();
+	path = GET_ARG();
+
+	obj = bpf_object__open(objfile);
+	err = libbpf_get_error(obj);
+	if (err) {
+		p_err("can't open objfile %s", objfile);
+		return err;
+	}
+
+	err = bpf_object__load(obj);
+	if (err) {
+		p_err("can't load objfile %s", objfile);
+		goto close_obj;
+	}
+
+	prog = bpf_object__next_program(obj, NULL);
+	if (!prog) {
+		p_err("can't find bpf program in objfile %s", objfile);
+		goto close_obj;
+	}
+
+	if (!is_trace_program_type(prog)) {
+		p_err("invalid bpf program type");
+		err = -EINVAL;
+		goto close_obj;
+	}
+
+	link = bpf_program__attach(prog);
+	err = libbpf_get_error(link);
+	if (err) {
+		p_err("can't attach program %s", bpf_program__name(prog));
+		goto close_obj;
+	}
+
+	err = mount_bpffs_for_pin(path);
+	if (err)
+		goto close_link;
+
+	err = bpf_link__pin(link, path);
+	if (err) {
+		p_err("pin failed for program %s to path %s",
+		      bpf_program__name(prog), path);
+		goto close_link;
+	}
+
+close_link:
+	bpf_link__destroy(link);
+close_obj:
+	bpf_object__close(obj);
+	return err;
+}
+
+static int do_help(int argc, char **argv)
+{
+	if (json_output) {
+		jsonw_null(json_wtr);
+		return 0;
+	}
+
+	fprintf(stderr,
+		"Usage: %1$s %2$s pin OBJ PATH\n"
+		"       %1$s %2$s help\n"
+		"\n"
+		"",
+		bin_name, "trace");
+
+	return 0;
+}
+
+static const struct cmd cmds[] = {
+	{ "help",	do_help },
+	{ "pin",	do_pin },
+	{ 0 }
+};
+
+int do_trace(int argc, char **argv)
+{
+	return cmd_select(cmds, argc, argv, do_help);
+}
-- 
2.34.1

