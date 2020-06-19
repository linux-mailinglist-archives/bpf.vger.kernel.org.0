Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A008201C75
	for <lists+bpf@lfdr.de>; Fri, 19 Jun 2020 22:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390062AbgFSUdd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Jun 2020 16:33:33 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:39814 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390017AbgFSUdb (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 19 Jun 2020 16:33:31 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05JKRts0001171
        for <bpf@vger.kernel.org>; Fri, 19 Jun 2020 13:33:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=Qr3SS62EFtrrsz38d8FDcS3ucWUmH2rUXXocejazyFY=;
 b=GV91mStf9RbGrwjB9jbvHpNFs4WOuaMefjRNN0pw9SsYVjQwA6VpqoipKeEYrdwuZxzG
 7H4ruag+3QTMsPQjQAdD/7ykjdJjEWS1QO+yKPB6/ozK0Auux11Yyf2zguz0Nn18xzi5
 GhPfoJiid2p2BR9JuWvdWr8BKmSILbnuUF0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 31s31erf5t-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 19 Jun 2020 13:33:30 -0700
Received: from intmgw002.08.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 19 Jun 2020 13:33:28 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 9265E2EC31BC; Fri, 19 Jun 2020 13:30:38 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devbig012.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>, Hao Luo <haoluo@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Quentin Monnet <quentin@isovalent.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v2 bpf-next 5/9] tools/bpftool: minimize bootstrap bpftool
Date:   Fri, 19 Jun 2020 13:30:21 -0700
Message-ID: <20200619203026.78267-6-andriin@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200619203026.78267-1-andriin@fb.com>
References: <20200619203026.78267-1-andriin@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-19_21:2020-06-19,2020-06-19 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 suspectscore=8 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 cotscore=-2147483648 bulkscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006190145
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Build minimal "bootstrap mode" bpftool to enable skeleton (and, later,
vmlinux.h generation), instead of building almost complete, but slightly
different (w/o skeletons, etc) bpftool to bootstrap complete bpftool buil=
d.

Current approach doesn't scale well (engineering-wise) when adding more B=
PF
programs to bpftool and other complicated functionality, as it requires
constant adjusting of the code to work in both bootstrapped mode and norm=
al
mode.

So it's better to build only minimal bpftool version that supports only B=
PF
skeleton code generation and BTF-to-C conversion. Thankfully, this is qui=
te
easy to accomplish due to internal modularity of bpftool commands. This w=
ill
also allow to keep adding new functionality to bpftool in general, withou=
t the
need to care about bootstrap mode for those new parts of bpftool.

Reviewed-by: Quentin Monnet <quentin@isovalent.com>
Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/bpf/bpftool/.gitignore |  2 +-
 tools/bpf/bpftool/Makefile   | 30 +++++++++++++-----------------
 tools/bpf/bpftool/main.c     | 11 +++++++++--
 tools/bpf/bpftool/main.h     | 27 +++++++++++++++------------
 4 files changed, 38 insertions(+), 32 deletions(-)

diff --git a/tools/bpf/bpftool/.gitignore b/tools/bpf/bpftool/.gitignore
index 26cde83e1ca3..ce721adf3161 100644
--- a/tools/bpf/bpftool/.gitignore
+++ b/tools/bpf/bpftool/.gitignore
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 *.d
-/_bpftool
+/bpftool-bootstrap
 /bpftool
 bpftool*.8
 bpf-helpers.*
diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index 9e85f101be85..eec2da4d45d2 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -116,40 +116,36 @@ CFLAGS +=3D -DHAVE_LIBBFD_SUPPORT
 SRCS +=3D $(BFD_SRCS)
 endif
=20
+BPFTOOL_BOOTSTRAP :=3D $(if $(OUTPUT),$(OUTPUT)bpftool-bootstrap,./bpfto=
ol-bootstrap)
+
+BOOTSTRAP_OBJS =3D $(addprefix $(OUTPUT),main.o common.o json_writer.o g=
en.o btf.o)
 OBJS =3D $(patsubst %.c,$(OUTPUT)%.o,$(SRCS)) $(OUTPUT)disasm.o
-_OBJS =3D $(filter-out $(OUTPUT)prog.o,$(OBJS)) $(OUTPUT)_prog.o
=20
-ifeq ($(feature-clang-bpf-global-var),1)
-	__OBJS =3D $(OBJS)
-else
-	__OBJS =3D $(_OBJS)
+ifneq ($(feature-clang-bpf-global-var),1)
+	CFLAGS +=3D -DBPFTOOL_WITHOUT_SKELETONS
 endif
=20
-$(OUTPUT)_prog.o: prog.c
-	$(QUIET_CC)$(CC) $(CFLAGS) -c -MMD -DBPFTOOL_WITHOUT_SKELETONS -o $@ $<
-
-$(OUTPUT)_bpftool: $(_OBJS) $(LIBBPF)
-	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $(_OBJS) $(LIBS)
-
 skeleton/profiler.bpf.o: skeleton/profiler.bpf.c $(LIBBPF)
 	$(QUIET_CLANG)$(CLANG) \
 		-I$(srctree)/tools/include/uapi/ \
 		-I$(LIBBPF_PATH) -I$(srctree)/tools/lib \
 		-g -O2 -target bpf -c $< -o $@
=20
-profiler.skel.h: $(OUTPUT)_bpftool skeleton/profiler.bpf.o
-	$(QUIET_GEN)$(OUTPUT)./_bpftool gen skeleton skeleton/profiler.bpf.o > =
$@
+profiler.skel.h: $(BPFTOOL_BOOTSTRAP) skeleton/profiler.bpf.o
+	$(QUIET_GEN)$(BPFTOOL_BOOTSTRAP) gen skeleton skeleton/profiler.bpf.o >=
 $@
=20
 $(OUTPUT)prog.o: prog.c profiler.skel.h
-	$(QUIET_CC)$(CC) $(CFLAGS) -c -MMD -o $@ $<
=20
 $(OUTPUT)disasm.o: $(srctree)/kernel/bpf/disasm.c
 	$(QUIET_CC)$(CC) $(CFLAGS) -c -MMD -o $@ $<
=20
 $(OUTPUT)feature.o: | zdep
=20
-$(OUTPUT)bpftool: $(__OBJS) $(LIBBPF)
-	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $(__OBJS) $(LIBS)
+$(BPFTOOL_BOOTSTRAP): $(BOOTSTRAP_OBJS) $(LIBBPF)
+	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $(BOOTSTRAP_OBJS) $(LIBS)
+
+$(OUTPUT)bpftool: $(OBJS) $(LIBBPF)
+	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $(OBJS) $(LIBS)
=20
 $(OUTPUT)%.o: %.c
 	$(QUIET_CC)$(CC) $(CFLAGS) -c -MMD -o $@ $<
@@ -157,7 +153,7 @@ $(OUTPUT)%.o: %.c
 clean: $(LIBBPF)-clean
 	$(call QUIET_CLEAN, bpftool)
 	$(Q)$(RM) -- $(OUTPUT)bpftool $(OUTPUT)*.o $(OUTPUT)*.d
-	$(Q)$(RM) -- $(OUTPUT)_bpftool profiler.skel.h skeleton/profiler.bpf.o
+	$(Q)$(RM) -- $(BPFTOOL_BOOTSTRAP) profiler.skel.h skeleton/profiler.bpf=
.o
 	$(Q)$(RM) -r -- $(OUTPUT)libbpf/
 	$(call QUIET_CLEAN, core-gen)
 	$(Q)$(RM) -- $(OUTPUT)FEATURE-DUMP.bpftool
diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
index 46bd716a9d86..bf4d7487552a 100644
--- a/tools/bpf/bpftool/main.c
+++ b/tools/bpf/bpftool/main.c
@@ -92,9 +92,16 @@ int cmd_select(const struct cmd *cmds, int argc, char =
**argv,
 	if (argc < 1 && cmds[0].func)
 		return cmds[0].func(argc, argv);
=20
-	for (i =3D 0; cmds[i].func; i++)
-		if (is_prefix(*argv, cmds[i].cmd))
+	for (i =3D 0; cmds[i].cmd; i++) {
+		if (is_prefix(*argv, cmds[i].cmd)) {
+			if (!cmds[i].func) {
+				p_err("command '%s' is not supported in bootstrap mode",
+				      cmds[i].cmd);
+				return -1;
+			}
 			return cmds[i].func(argc - 1, argv + 1);
+		}
+	}
=20
 	help(argc - 1, argv + 1);
=20
diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
index 4338ab9d86d4..aad7be74e8a7 100644
--- a/tools/bpf/bpftool/main.h
+++ b/tools/bpf/bpftool/main.h
@@ -194,19 +194,22 @@ int mount_bpffs_for_pin(const char *name);
 int do_pin_any(int argc, char **argv, int (*get_fd_by_id)(int *, char **=
*));
 int do_pin_fd(int fd, const char *name);
=20
-int do_prog(int argc, char **arg);
-int do_map(int argc, char **arg);
-int do_link(int argc, char **arg);
-int do_event_pipe(int argc, char **argv);
-int do_cgroup(int argc, char **arg);
-int do_perf(int argc, char **arg);
-int do_net(int argc, char **arg);
-int do_tracelog(int argc, char **arg);
-int do_feature(int argc, char **argv);
-int do_btf(int argc, char **argv);
+/* commands available in bootstrap mode */
 int do_gen(int argc, char **argv);
-int do_struct_ops(int argc, char **argv);
-int do_iter(int argc, char **argv);
+int do_btf(int argc, char **argv);
+
+/* non-bootstrap only commands */
+int do_prog(int argc, char **arg) __weak;
+int do_map(int argc, char **arg) __weak;
+int do_link(int argc, char **arg) __weak;
+int do_event_pipe(int argc, char **argv) __weak;
+int do_cgroup(int argc, char **arg) __weak;
+int do_perf(int argc, char **arg) __weak;
+int do_net(int argc, char **arg) __weak;
+int do_tracelog(int argc, char **arg) __weak;
+int do_feature(int argc, char **argv) __weak;
+int do_struct_ops(int argc, char **argv) __weak;
+int do_iter(int argc, char **argv) __weak;
=20
 int parse_u32_arg(int *argc, char ***argv, __u32 *val, const char *what)=
;
 int prog_parse_fd(int *argc, char ***argv);
--=20
2.24.1

