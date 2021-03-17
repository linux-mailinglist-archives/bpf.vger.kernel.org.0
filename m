Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 278F033E77E
	for <lists+bpf@lfdr.de>; Wed, 17 Mar 2021 04:14:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbhCQDNg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 16 Mar 2021 23:13:36 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:51672 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229608AbhCQDNO (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 16 Mar 2021 23:13:14 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 12H34Jt9009199
        for <bpf@vger.kernel.org>; Tue, 16 Mar 2021 20:13:13 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 37ah40ygjp-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 16 Mar 2021 20:13:13 -0700
Received: from intmgw002.25.frc3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 16 Mar 2021 20:13:12 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id D83042ED23D6; Tue, 16 Mar 2021 20:13:07 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v2 bpf-next 4/4] bpftool: treat compilation warnings as errors
Date:   Tue, 16 Mar 2021 20:12:57 -0700
Message-ID: <20210317031257.846314-5-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210317031257.846314-1-andrii@kernel.org>
References: <20210317031257.846314-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-16_09:2021-03-16,2021-03-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 mlxlogscore=999 priorityscore=1501 suspectscore=0 malwarescore=0
 bulkscore=0 impostorscore=0 adultscore=0 spamscore=0 clxscore=1015
 mlxscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2103170024
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Make bpftool compilation stricter and treat all compilation warnings as errors.

Depending on libbfd version on the system, jit_disasm.c might trigger the
following compilation warning-turned-error:

jit_disasm.c: In function ‘disasm_print_insn’:
jit_disasm.c:121:29: error: assignment discards ‘const’ qualifier from pointer
target type [-Werror=discarded-qualifiers]
   info.disassembler_options = disassembler_options;
                                ^

This was fixed in libbfd, but older versions of the library are still widely
used. So disable -Wdiscarded-qualifiers for that particular line of code.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/bpf/bpftool/Makefile     | 3 ++-
 tools/bpf/bpftool/jit_disasm.c | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index b3073ae84018..59de954faaf5 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -56,7 +56,8 @@ prefix ?= /usr/local
 bash_compdir ?= /usr/share/bash-completion/completions
 
 CFLAGS += -O2
-CFLAGS += -W -Wall -Wextra -Wno-unused-parameter -Wno-missing-field-initializers
+CFLAGS += -W -Wall -Wextra -Werror
+CFLAGS += -Wno-unused-parameter -Wno-missing-field-initializers
 CFLAGS += $(filter-out -Wswitch-enum -Wnested-externs,$(EXTRA_WARNINGS))
 CFLAGS += -DPACKAGE='"bpftool"' -D__EXPORTED_HEADERS__ \
 	-I$(if $(OUTPUT),$(OUTPUT),.) \
diff --git a/tools/bpf/bpftool/jit_disasm.c b/tools/bpf/bpftool/jit_disasm.c
index e7e7eee9f172..20083fbed5c2 100644
--- a/tools/bpf/bpftool/jit_disasm.c
+++ b/tools/bpf/bpftool/jit_disasm.c
@@ -118,7 +118,10 @@ void disasm_print_insn(unsigned char *image, ssize_t len, int opcodes,
 	info.arch = bfd_get_arch(bfdf);
 	info.mach = bfd_get_mach(bfdf);
 	if (disassembler_options)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wdiscarded-qualifiers"
 		info.disassembler_options = disassembler_options;
+#pragma GCC diagnostic pop
 	info.buffer = image;
 	info.buffer_length = len;
 
-- 
2.30.2

