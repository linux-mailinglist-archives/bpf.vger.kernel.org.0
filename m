Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 817F65322C4
	for <lists+bpf@lfdr.de>; Tue, 24 May 2022 07:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233697AbiEXF6X convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 24 May 2022 01:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232870AbiEXF6W (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 May 2022 01:58:22 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5BB12D1E9
        for <bpf@vger.kernel.org>; Mon, 23 May 2022 22:58:21 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24NKGs6h003894
        for <bpf@vger.kernel.org>; Mon, 23 May 2022 22:58:21 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3g6v4k6dkf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 23 May 2022 22:58:21 -0700
Received: from twshared31479.05.prn5.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 23 May 2022 22:58:20 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id E368A1A53FCB6; Mon, 23 May 2022 22:58:15 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <mhiramat@kernel.org>, <bpf@vger.kernel.org>, <ast@kernel.org>
CC:     <rihams@fb.com>, <jolsa@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH] BUG: demonstration of uprobe/uretprobe corrupted stack traces
Date:   Mon, 23 May 2022 22:57:48 -0700
Message-ID: <20220524055748.4064533-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: KT7dbLEysWh2lhCZuRVdcwdsAUQA4SXv
X-Proofpoint-GUID: KT7dbLEysWh2lhCZuRVdcwdsAUQA4SXv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-24_01,2022-05-23_01,2022-02-23_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Masami,

We've got reports about partially corrupt stack traces when being captured from
uretprobes. Trying the simplest repro seems to confirm that something is not
quite right here. I'll try to debug it a bit more this week, but I was hoping
for you to take a look as well, if you get a chance.

Simple repro built on top of BPF selftests.

  $ sudo ./test_progs -a uprobe_autoattach -v
  ...
  FN ADDR 0x55fde0 - 0x55fdef
  UPROBE SZ 40 (CNT 5)       URETPROBE SZ 40 (CNT 5)
  UPROBE 0x55fde0           URETPROBE 0x55ffd4
  UPROBE 0x584653           URETPROBE 0x584653
  UPROBE 0x585cc9           URETPROBE 0x585cc9
  UPROBE 0x7fa9a31eaca3     URETPROBE 0x7fa9a31eaca3
  UPROBE 0x5541f689495641d7 URETPROBE 0x5541f689495641d7
  ...
  #203     uprobe_autoattach:OK
  Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED

There seem to be two distinct problems.

1. Last two entries for both uprobe and uretprobe stacks are not user-space
addressed (0x7fa9a31eaca3) and the very last one doesn't even look like a valid
address (0x5541f689495641d7).

2. Looking at first entry for UPROBE vs URETPROBE, you can see that uprobe
one's is correct and points exactly to the beginning of autoattach_trigger_func
(0x55fde0) as expected, but uretprobe entry (0x55ffd4) is way out of
autoattach_trigger_func (which is just 15 bytes long and ends at 0x55fdef).
Using addr2line it shows that it points to:

  0x000000000055ffd4: test_uprobe_autoattach at /data/users/andriin/linux/tools/testing/selftests/bpf/prog_tests/uprobe_autoattach.c:33

Which is a valid function and location to which autoattach_trigger_func()
should return (see objdump snippet below), but from uretprobe I'd imagine that
we are going to get address within traced user function (that is 0x55fde0 -
0x55fdef range), not the return address in a parent function.

     55ffc4:       89 83 3c 08 00 00       mov    %eax,0x83c(%rbx)
     55ffca:       8b 45 e8                mov    -0x18(%rbp),%eax
     55ffcd:       89 c7                   mov    %eax,%edi
     55ffcf:       e8 0c fe ff ff          call   55fde0 <autoattach_trigger_func>
-->  55ffd4:       89 45 a8                mov    %eax,-0x58(%rbp)
     55ffd7:       ba ef fd 55 00          mov    $0x55fdef,%edx

Both issues above seem unexpected, can you please see if I have some wrong
assumptions here?

Thanks in advance for taking a look!

Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Riham Selim <rihams@fb.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/Makefile               |  3 ++-
 .../selftests/bpf/prog_tests/uprobe_autoattach.c   | 14 ++++++++++++++
 .../selftests/bpf/progs/test_uprobe_autoattach.c   | 11 +++++++++++
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 2d3c8c8f558a..0d3109c8d8d5 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -23,7 +23,8 @@ BPF_GCC		?= $(shell command -v bpf-gcc;)
 SAN_CFLAGS	?=
 CFLAGS += -g -O0 -rdynamic -Wall -Werror $(GENFLAGS) $(SAN_CFLAGS)	\
 	  -I$(CURDIR) -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR)		\
-	  -I$(TOOLSINCDIR) -I$(APIDIR) -I$(OUTPUT)
+	  -I$(TOOLSINCDIR) -I$(APIDIR) -I$(OUTPUT) -fno-omit-frame-pointer
+
 LDFLAGS += $(SAN_CFLAGS)
 LDLIBS += -lelf -lz -lrt -lpthread
 
diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_autoattach.c b/tools/testing/selftests/bpf/prog_tests/uprobe_autoattach.c
index 35b87c7ba5be..c0fbe4d240be 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_autoattach.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_autoattach.c
@@ -10,6 +10,7 @@ static noinline int autoattach_trigger_func(int arg)
 	asm volatile ("");
 	return arg + 1;
 }
+static noinline int autoattach_trigger_func_post(int arg) { return 0; }
 
 void test_uprobe_autoattach(void)
 {
@@ -17,6 +18,7 @@ void test_uprobe_autoattach(void)
 	int trigger_val = 100, trigger_ret;
 	size_t malloc_sz = 1;
 	char *mem;
+	int i;
 
 	skel = test_uprobe_autoattach__open_and_load();
 	if (!ASSERT_OK_PTR(skel, "skel_open"))
@@ -30,6 +32,18 @@ void test_uprobe_autoattach(void)
 	/* trigger & validate uprobe & uretprobe */
 	trigger_ret = autoattach_trigger_func(trigger_val);
 
+	printf("FN ADDR %p - %p\n", autoattach_trigger_func, autoattach_trigger_func_post);
+	printf("UPROBE SZ %d (CNT %d)      URETPROBE SZ %d (CNT %d)\n",
+		skel->bss->uprobe_stack_sz,
+		skel->bss->uprobe_stack_sz / 8,
+		skel->bss->uretprobe_stack_sz,
+		skel->bss->uretprobe_stack_sz / 8);
+	for (i = 0; i < skel->bss->uprobe_stack_sz / 8; i++) {
+		printf("UPROBE %-18p URETPROBE %-18p\n",
+			(void *)skel->bss->uprobe_stack[i],
+			(void *)skel->bss->uretprobe_stack[i]);
+	}
+
 	skel->bss->test_pid = getpid();
 
 	/* trigger & validate shared library u[ret]probes attached by name */
diff --git a/tools/testing/selftests/bpf/progs/test_uprobe_autoattach.c b/tools/testing/selftests/bpf/progs/test_uprobe_autoattach.c
index ab75522e2eeb..f630f83b4426 100644
--- a/tools/testing/selftests/bpf/progs/test_uprobe_autoattach.c
+++ b/tools/testing/selftests/bpf/progs/test_uprobe_autoattach.c
@@ -27,11 +27,19 @@ int handle_uprobe_noautoattach(struct pt_regs *ctx)
 	return 0;
 }
 
+__u64 uprobe_stack[128];
+__u64 uretprobe_stack[128];
+int uprobe_stack_sz, uretprobe_stack_sz;
+
 SEC("uprobe//proc/self/exe:autoattach_trigger_func")
 int handle_uprobe_byname(struct pt_regs *ctx)
 {
 	uprobe_byname_parm1 = PT_REGS_PARM1_CORE(ctx);
 	uprobe_byname_ran = 1;
+
+	uprobe_stack_sz = bpf_get_stack(ctx,
+					uprobe_stack, sizeof(uprobe_stack),
+					BPF_F_USER_STACK);
 	return 0;
 }
 
@@ -40,6 +48,9 @@ int handle_uretprobe_byname(struct pt_regs *ctx)
 {
 	uretprobe_byname_rc = PT_REGS_RC_CORE(ctx);
 	uretprobe_byname_ran = 2;
+	uretprobe_stack_sz = bpf_get_stack(ctx,
+					   uretprobe_stack, sizeof(uretprobe_stack),
+					   BPF_F_USER_STACK);
 	return 0;
 }
 
-- 
2.30.2

