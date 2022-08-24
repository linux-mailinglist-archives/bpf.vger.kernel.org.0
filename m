Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6E059F202
	for <lists+bpf@lfdr.de>; Wed, 24 Aug 2022 05:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233472AbiHXDUv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Aug 2022 23:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233798AbiHXDUr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Aug 2022 23:20:47 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812E67F081
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 20:20:44 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MCBCB1VckzGpp9;
        Wed, 24 Aug 2022 11:19:02 +0800 (CST)
Received: from CHINA (10.175.102.38) by canpemm500009.china.huawei.com
 (7.192.105.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 24 Aug
 2022 11:20:41 +0800
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
Subject: [PATCH bpf-next v2] bpftool: implement perf attach command
Date:   Wed, 24 Aug 2022 03:38:37 +0000
Message-ID: <20220824033837.458197-1-weiyongjun1@huawei.com>
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

This patch introduces a new bpftool command: perf attach,
which used to attaching/pinning tracepoints programs.

  bpftool perf attach PROG TP_NAME FILE

It will attach bpf program PROG to tracepoint TP_NAME and
pin tracepoint program as FILE, FILE must be located in
bpffs mount.

For example,
  $ bpftool prog load mtd-mchp23k256.o /sys/fs/bpf/test_prog

  $ bpftool prog
  510: raw_tracepoint_writable  name mtd_mchp23k256  tag 2e13281b1f781bf3  gpl
        loaded_at 2022-08-24T02:50:06+0000  uid 0
        xlated 960B  not jited  memlock 4096B  map_ids 439,437,440
        btf_id 740
  $ bpftool perf attach id 510 spi_transfer_writeable /sys/fs/bpf/test_perf

  $ bpftool link show
  74: raw_tracepoint  prog 510
        tp 'spi_transfer_writeable'

The implementation a BPF based backend for mchp23k256 mtd mockup
device.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
v1 -> v2: switch to extend perf command instead add new one
v1: https://patchwork.kernel.org/project/netdevbpf/patch/20220816151725.153343-1-weiyongjun1@huawei.com/
---
 .../bpftool/Documentation/bpftool-perf.rst    | 11 ++-
 tools/bpf/bpftool/perf.c                      | 67 ++++++++++++++++++-
 2 files changed, 76 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-perf.rst b/tools/bpf/bpftool/Documentation/bpftool-perf.rst
index 5fea633a82f1..085c8dcfb9aa 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-perf.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-perf.rst
@@ -19,12 +19,13 @@ SYNOPSIS
 	*OPTIONS* := { |COMMON_OPTIONS| }
 
 	*COMMANDS* :=
-	{ **show** | **list** | **help** }
+	{ **show** | **list** | **help** | **attach** }
 
 PERF COMMANDS
 =============
 
 |	**bpftool** **perf** { **show** | **list** }
+|	**bpftool** **perf** **attach** *PROG* *TP_NAME* *FILE*
 |	**bpftool** **perf help**
 
 DESCRIPTION
@@ -39,6 +40,14 @@ DESCRIPTION
 		  or a kernel virtual address.
 		  The attachment point for u[ret]probe is the file name and the file offset.
 
+	**bpftool perf attach PROG TP_NAME FILE**
+		  Attach bpf program *PROG* to tracepoint *TP_NAME* and pin
+		  program *PROG* as *FILE*.
+
+		  Note: *FILE* must be located in *bpffs* mount. It must not
+		  contain a dot character ('.'), which is reserved for future
+		  extensions of *bpffs*.
+
 	**bpftool perf help**
 		  Print short help message.
 
diff --git a/tools/bpf/bpftool/perf.c b/tools/bpf/bpftool/perf.c
index 226ec2c39052..9149ba960784 100644
--- a/tools/bpf/bpftool/perf.c
+++ b/tools/bpf/bpftool/perf.c
@@ -233,8 +233,9 @@ static int do_show(int argc, char **argv)
 static int do_help(int argc, char **argv)
 {
 	fprintf(stderr,
-		"Usage: %1$s %2$s { show | list }\n"
+		"Usage: %1$s %2$s { show | list | attach }\n"
 		"       %1$s %2$s help }\n"
+		"       %1$s %2$s attach PROG TP_NAME FILE\n"
 		"\n"
 		"       " HELP_SPEC_OPTIONS " }\n"
 		"",
@@ -243,10 +244,74 @@ static int do_help(int argc, char **argv)
 	return 0;
 }
 
+static enum bpf_prog_type get_prog_type(int progfd)
+{
+	struct bpf_prog_info info = {};
+	__u32 len = sizeof(info);
+
+	if (bpf_obj_get_info_by_fd(progfd, &info, &len))
+		return BPF_PROG_TYPE_UNSPEC;
+
+	return info.type;
+}
+
+static int do_attach(int argc, char **argv)
+{
+	enum bpf_prog_type prog_type;
+	char *tp_name, *path;
+	int err, progfd, pfd;
+
+	if (!REQ_ARGS(4))
+		return -EINVAL;
+
+	progfd = prog_parse_fd(&argc, &argv);
+	if (progfd < 0)
+		return progfd;
+
+	if (!REQ_ARGS(2)) {
+		err = -EINVAL;
+		goto out_close;
+	}
+
+	tp_name = GET_ARG();
+	path = GET_ARG();
+
+	prog_type = get_prog_type(progfd);
+	switch (prog_type) {
+	case BPF_PROG_TYPE_RAW_TRACEPOINT:
+	case BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE:
+		pfd = bpf_raw_tracepoint_open(tp_name, progfd);
+		if (pfd < 0) {
+			printf("failed to attach to raw tracepoint '%s'\n",
+			       tp_name);
+			err = pfd;
+			goto out_close;
+		}
+		break;
+	default:
+		printf("invalid program type %s\n",
+		       libbpf_bpf_prog_type_str(prog_type));
+		err = -EINVAL;
+		goto out_close;
+	}
+
+	err = do_pin_fd(pfd, path);
+	if (err) {
+		close(pfd);
+		goto out_close;
+	}
+
+	return 0;
+
+out_close:
+	return err;
+}
+
 static const struct cmd cmds[] = {
 	{ "show",	do_show },
 	{ "list",	do_show },
 	{ "help",	do_help },
+	{ "attach",	do_attach },
 	{ 0 }
 };
 
-- 
2.34.1

