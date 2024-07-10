Return-Path: <bpf+bounces-34440-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5343B92D891
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 20:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A863281E80
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 18:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851C819A282;
	Wed, 10 Jul 2024 18:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="aSrxsnfq"
X-Original-To: bpf@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazolkn19011072.outbound.protection.outlook.com [52.103.32.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F692198A32;
	Wed, 10 Jul 2024 18:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720637042; cv=fail; b=HLwew9V3NDZUqT7XgJcY1Ed2HBlHwCJs68pZjrc32a4fcLMa9CNsdH0rJvvpe3ucu/M3dyH8cdwbPeNagjWj3UkbEsPS8ibnh7YySHkRR+nc9V/p/scp4xh+xDX3ih3yor73sq2DLnGTSYm4sLosVAXsX9D29YZr2TNuOOb+Xm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720637042; c=relaxed/simple;
	bh=BBkzFBSDzlPXi+C+Y/6QYa8rH+OnlA5s9vjc7e8K27Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=thsJkByD88B+GVgavoKILrudjY+fAnvkTfa8hyTUvtpI+/cxGcViUGgPlL6kK4QE2Z0gjkj7nmAX0gA2JulZDvJoBg//OaMlEIP9aSlhLP53UGkLwtHMlz/J4dPgsRZZGt7HSNArChqozBH4gqB5v84PIaib6+1Di3yfcfIl4Fw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=aSrxsnfq; arc=fail smtp.client-ip=52.103.32.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PPdMDFadxtiOUqBaKkdBmdPuRrhojzz02hxn548iZIbl/i0d8ZkVPVzrtiXomA5pcDZyOhX9R17SRnyHQyMt86Z5nelKW/6Fxm02FqDL4m8jqAXnRN8qg4LPNR3wrhSZmSfGV7iWFVDXs7eEayhgDVK7jlQmqMVy6x95CoCzn+WfFGnHV2ByApzK2jJ7tt9dF4qPMLcocCLwhse2dTtZjAJKmVAdK/i6gIcUku1Kju+tdUmCEpTGa+T9XgKwNa5DOpsQe/7trMpPb4+zQGn1duremfRvPTJGQCeqyLvq86YPo2xqQLEa/bwnOnAAWU501r+S4cFbN2wqmZA14PvtNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K/ImEdVd8bLZVZuiwbSUIP9BiNKop478/SCug29q27Y=;
 b=BHHtAy5aiHztD/JV6uKHAqqcIfZqdwyc3q21M16STtemmhDAKNrs39D1R4b/gnx5fO/1lLBhB+9YPZbQjtGiDkD2eaJ6H802I5/dwyxVsJBMuSnVW2NiaWQJw2e1TaqATjF3kfm+hHuk6LXtXVPGruu2qSdEBIU3lYgm5QAEpOX1qsmx9jw4ZviUiStMYnzJ0a4zrMDnCv3cUZlddSHXWULINYTg8kb/Aqvs8c0Fq1egKTJHXaOHPdTnZT4FrF7ed3BZA4ZWDgA7FiBHpczprrbOAN52varkkPm85dS295oG2woJpe3M2JBrQIKf0iyG0ztJTVM18dUhuyvDtx/Yyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K/ImEdVd8bLZVZuiwbSUIP9BiNKop478/SCug29q27Y=;
 b=aSrxsnfqm19sUkRnwpRT4aC+Qof3Trm5Q5SahSlikIm5ZMgm4VcLkeQEt/3cXNwaQrhM1PDDZesTXEEBHuiTVbUHceCnozZWv0hLXFB/4aark7cS4KbSBjPQLijUWiInz+rk41AxN1u1x/VeH0QxRUu1DPK9kisIjs91rDNX82NJIHxRo4XFbzDJnZrvVkF82WQdvLEjzgskRhtddOF+W78Y4rRk21GF6KoAQZ5Q3lJlymJD3/eUUdtwMMfFJVM8dUAE95Ap+Vv2RiCaJu01oI/s+LXTIAKxeFGVuS12xyEwmC65lSfY6aNYsPETjgn2s2a11jJssiPyu1BDXEiCLw==
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
 by AS8PR03MB9935.eurprd03.prod.outlook.com (2603:10a6:20b:628::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 18:43:56 +0000
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7]) by AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7%6]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 18:43:56 +0000
From: Juntong Deng <juntong.deng@outlook.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	andrii@kernel.org,
	avagin@gmail.com,
	snorcht@gmail.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 14/16] selftests/crib: Add test for getting basic information of the process
Date: Wed, 10 Jul 2024 19:40:58 +0100
Message-ID:
 <AM6PR03MB58483361B65AE11809514FB999A42@AM6PR03MB5848.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240710184100.297261-1-juntong.deng@outlook.com>
References: <20240710184100.297261-1-juntong.deng@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [kl5V/14AD11JL9JVU91637orERWo+t9t]
X-ClientProxiedBy: SI2PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:195::14) To AM6PR03MB5848.eurprd03.prod.outlook.com
 (2603:10a6:20b:e4::10)
X-Microsoft-Original-Message-ID:
 <20240710184100.297261-15-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5848:EE_|AS8PR03MB9935:EE_
X-MS-Office365-Filtering-Correlation-Id: a5b541f3-81a8-4352-575f-08dca1104120
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|19110799003|461199028|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	Bu8Wdsj+OH3Eg3FlLCG3C1vsaU72ygsx3rhebrXXhF05sZhauRDpQy6+3r5jt8vFL855VnXpEYXhYAn0bYnR8THU9t/P023Fyyg96xnmQ/kr+DGgmLho8yNqgkvtoFAzj1YLqEMp4xEx0UbYPh0F8mxCnsJiAEov68fA+J3HJgM3AHukf70GG3Jqzv9eTiV7nRSphNhxT7pNhwNksHNW3oDOL9NYdTAO5Bm1rzUEmuoyO0uLxVwWWgf6+XyeOojpObhOhReK53evuJwE9bumYVd2rsRcighWiR/Y1sGH5vhiIbh5DfaAHdwAB8ZQhT6dm2LRgzRqYxAApD/PKvCJmFDmRXhzILJsZHNJhsE6qA3ah1N77PMNJ66vBD37lykAMZP0++qIDcrz4fnL5HPvJklTfuFPILbnCm9syQzOO8fvjthdnjO/5mfCujevEEh0bXM3PHk1vEIcNlfdPZVyWuTapX28JyqCV2ShEbFCLI0lQADG2aVZBYY8cPWlkP6OJdaA2i22SQSEoGVROyCh2TyvlIpbcIkDbnKqMbPZjYrpPx7g8bAz//izm+ie/9ijap7vkREfNu5pCp5uEHLuPy3IU0MRF47syDfUrxjgvPpruzXb97x7ooRNQ31RNmIZRE3GjxYsJpYsNZuqcSUCMA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?P8eFJV/80Ma9sOnuMJT0APVHQc7NkWKZiLXISBVfziIQE1KF6BS9MUnQkiGe?=
 =?us-ascii?Q?sxjHFHNklDYZze04cmRyOuO1B2pvk7QMO18j+Ij8l6IKZrin1+DpGjmERQqQ?=
 =?us-ascii?Q?4Giq1Oizf61B0AX1JxpWrJKdvGkgABqR8+VL/aLeWC5yfwhDoKSBf1Pyhyfe?=
 =?us-ascii?Q?TbGE503qMbK1bGlWOuckYtCyE/C31Bl2dX6UhQ1K/OVZFIUsBDCwlNdbrgzJ?=
 =?us-ascii?Q?CJXLzuMnE3ipQYej6w/6/cAaOWiSstA1EwFA9kPooCOGfBMrHA1Pyj+D0jHD?=
 =?us-ascii?Q?aZzRcH2WfR9Bp2gxxYVRatdI+IsFEeT4Vh34f+G84LHDpt43V5iPgQl4JhVk?=
 =?us-ascii?Q?hla4Bj0tX8MNG13JQsd6mX8lt8tJW6kfbe6dfwIYpYgtE/fxbRELg8jfZUtc?=
 =?us-ascii?Q?AWWfK+IJFwwZ3wDQRoCTd1htPuuQxGZoZjHcphST321GqjG5+Qt1Fo8yDcCk?=
 =?us-ascii?Q?a7kjQTMyrae245lVLaA75SIFvE8UeFSI2kwHrsogF0JNo3h+iW4hAecu1pgB?=
 =?us-ascii?Q?rQQeep6ofr5CNEu9N4W+EbUh4tMrWP9c6ogOJzj7jFop/0KAdWoDAzF/jnfc?=
 =?us-ascii?Q?7XnJWH2p3/pI6VlMLorCNxrIF7LqvFTP1E6zekVBy095lnxI+0s2HHUgxhnv?=
 =?us-ascii?Q?ux6da/504ikkOk5PSQMQmcrcFMQQ0Z82xcA21jxFdYwcSeIgA5Hu7ymfPXYL?=
 =?us-ascii?Q?MF3RYfkgvAIbtGq2s5QW+9wl6t3rsZ/sB5dheRRGD15PFB/ahLuItq9bZi7O?=
 =?us-ascii?Q?XmzGWmvDM/p+Ajxs0cblW1jF0crnVYzYzqZ2HO70fELW2dtWwaebsbCTCdJ7?=
 =?us-ascii?Q?Czb1QBgdKjjsPiXkOeHBZ0FBIwg9FO9XhgH3NMgSiKOIh9Epx9RENpksUI5q?=
 =?us-ascii?Q?jPGIN6tGAY3+tQKTVuezAuwZ49+CSB6EDUoPPmcSuHn4cfRrZeyzZAZF0Uy9?=
 =?us-ascii?Q?z0ycyyLPORbNPaDo5bNl5p13SU/Ppsiy5vVcO2HQNj6CLGsWe6KHMLhgZahO?=
 =?us-ascii?Q?nt5wIvwevfpjPDzHPC+kK4VpMD9mSOdkhcHVb1PvrscYWm0OBMbijrymIW6p?=
 =?us-ascii?Q?AAYASKOZU+99GhRVgd38lFwglXksbUVdLmXfXH69UNaKtWzv7zBN5RjVz1jK?=
 =?us-ascii?Q?PbaBbv4cgKrHcbkB1FFNJkDEzHXhic2RCsmx6NIemw0BABky0Tr5KdGGu4hd?=
 =?us-ascii?Q?lrRB8y7ixxq8psuRVUGg3Nf9H4dJzwS/RR3/5Y+PKNf6iIIrtQoaTWb5KcQ?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5b541f3-81a8-4352-575f-08dca1104120
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5848.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 18:43:56.8364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB9935

In this test, the basic information of the process is obtained through
CRIB, including priority, comm, address space, all VMAs, etc.

The process information obtained through CRIB will be compared with the
process information obtained through procfs to verify the correctness of
the information.

In addition, the performance of CRIB and procfs will be compared in this
test, usually CRIB takes only 20-30% of the time of procfs.

The following is an example of test results:
CRIB dump took 0.001349 seconds
PROC dump took 0.005516 seconds

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 tools/testing/selftests/crib/.gitignore       |   1 +
 tools/testing/selftests/crib/Makefile         | 136 +++++++
 tools/testing/selftests/crib/config           |   7 +
 .../selftests/crib/test_dump_task.bpf.c       | 125 +++++++
 tools/testing/selftests/crib/test_dump_task.c | 337 ++++++++++++++++++
 tools/testing/selftests/crib/test_dump_task.h |  90 +++++
 6 files changed, 696 insertions(+)
 create mode 100644 tools/testing/selftests/crib/.gitignore
 create mode 100644 tools/testing/selftests/crib/Makefile
 create mode 100644 tools/testing/selftests/crib/config
 create mode 100644 tools/testing/selftests/crib/test_dump_task.bpf.c
 create mode 100644 tools/testing/selftests/crib/test_dump_task.c
 create mode 100644 tools/testing/selftests/crib/test_dump_task.h

diff --git a/tools/testing/selftests/crib/.gitignore b/tools/testing/selftests/crib/.gitignore
new file mode 100644
index 000000000000..378eac25d311
--- /dev/null
+++ b/tools/testing/selftests/crib/.gitignore
@@ -0,0 +1 @@
+build
diff --git a/tools/testing/selftests/crib/Makefile b/tools/testing/selftests/crib/Makefile
new file mode 100644
index 000000000000..9d0553f1ff5c
--- /dev/null
+++ b/tools/testing/selftests/crib/Makefile
@@ -0,0 +1,136 @@
+# SPDX-License-Identifier: GPL-2.0
+include ../../../build/Build.include
+include ../../../scripts/Makefile.arch
+include ../../../scripts/Makefile.include
+include ../lib.mk
+
+CUR_DIR := $(abspath .)
+REPO_ROOT := $(abspath ../../../..)
+TOOLS_DIR := $(REPO_ROOT)/tools
+TOOLSINC_DIR := $(TOOLS_DIR)/include
+BPFTOOL_DIR := $(TOOLS_DIR)/bpf/bpftool
+UAPI_DIR := $(TOOLSINC_DIR)/uapi
+LIB_DIR := $(TOOLS_DIR)/lib
+LIBBPF_DIR := $(LIB_DIR)/bpf
+GEN_DIR := $(REPO_ROOT)/include/generated
+GEN_HDR := $(GEN_DIR)/autoconf.h
+
+OUTPUT_DIR := $(CUR_DIR)/build
+INCLUDE_DIR := $(OUTPUT_DIR)/include
+SBIN_DIR:= $(OUTPUT_DIR)/sbin
+OBJ_DIR := $(OUTPUT_DIR)/obj
+CRIBOBJ_DIR := $(OBJ_DIR)/crib
+LIBBPF_OUTPUT := $(OBJ_DIR)/libbpf/libbpf.a
+LIBBPF_OBJ_DIR := $(OBJ_DIR)/libbpf
+LIBBPF_OBJ := $(LIBBPF_OBJ_DIR)/libbpf.a
+
+DEFAULT_BPFTOOL := $(SBIN_DIR)/bpftool
+BPFTOOL ?= $(DEFAULT_BPFTOOL)
+
+VMLINUX_BTF_PATHS ?= ../../../../vmlinux					\
+		     /sys/kernel/btf/vmlinux					\
+		     /boot/vmlinux-$(shell uname -r)
+VMLINUX_BTF ?= $(abspath $(firstword $(wildcard $(VMLINUX_BTF_PATHS))))
+ifeq ($(VMLINUX_BTF),)
+$(error Cannot find a vmlinux for VMLINUX_BTF at any of "$(VMLINUX_BTF_PATHS)")
+endif
+
+ifneq ($(wildcard $(GEN_HDR)),)
+  GENFLAGS := -DHAVE_GENHDR
+endif
+
+CFLAGS += -g -O2 -rdynamic -pthread -Wall -Werror $(GENFLAGS)		\
+	  -I$(INCLUDE_DIR) -I$(GEN_DIR) -I$(LIB_DIR)			\
+	  -I$(TOOLSINC_DIR) -I$(UAPI_DIR) -I$(CUR_DIR)/include		\
+	  -Wno-unused-command-line-argument
+
+LDFLAGS = -lelf -lz
+
+IS_LITTLE_ENDIAN = $(shell $(CC) -dM -E - </dev/null |				\
+			grep 'define __BYTE_ORDER__ __ORDER_LITTLE_ENDIAN__')
+
+define get_sys_includes
+$(shell $(1) -v -E - </dev/null 2>&1 \
+	| sed -n '/<...> search starts here:/,/End of search list./{ s| \(/.*\)|-idirafter \1|p }') \
+$(shell $(1) -dM -E - </dev/null | grep '__riscv_xlen ' | awk '{printf("-D__riscv_xlen=%d -D__BITS_PER_LONG=%d", $$3, $$3)}')
+endef
+
+BPF_CFLAGS = -g -D__TARGET_ARCH_$(SRCARCH)				\
+	     $(if $(IS_LITTLE_ENDIAN),-mlittle-endian,-mbig-endian)	\
+	     -I$(CUR_DIR)/include -I$(CUR_DIR)/include/bpf-compat	\
+	     -I$(INCLUDE_DIR) -I$(UAPI_DIR) 				\
+	     -I$(REPO_ROOT)/include					\
+	     $(call get_sys_includes,$(CLANG))				\
+	     -Wall -Wno-compare-distinct-pointer-types			\
+	     -Wno-incompatible-function-pointer-types			\
+	     -O2 -mcpu=v3
+
+MAKE_DIRS := $(sort $(OBJ_DIR)/libbpf $(OBJ_DIR)/libbpf			\
+	     $(OBJ_DIR)/bpftool $(OBJ_DIR)/resolve_btfids		\
+	     $(INCLUDE_DIR) $(CRIBOBJ_DIR) $(SBIN_DIR))
+
+TEST_GEN_BPF_PROGS_SKEL := $(foreach prog,$(wildcard *.bpf.c),$(INCLUDE_DIR)/$(patsubst %.c,%.skel.h,$(prog)))
+
+TEST_GEN_PROGS := $(addprefix $(SBIN_DIR)/, $(basename $(filter-out $(wildcard *.bpf.c), $(wildcard *.c))))
+
+TEST_GEN_PROGS_OBJ := $(addsuffix .o,$(addprefix $(CRIBOBJ_DIR)/, $(notdir $(TEST_GEN_PROGS))))
+
+$(MAKE_DIRS):
+	$(call msg,MKDIR,,$@)
+	$(Q)mkdir -p $@
+
+$(LIBBPF_OBJ): $(wildcard $(LIBBPF_DIR)/*.[ch] $(LIBBPF_DIR)/Makefile)			\
+	       $(UAPI_DIR)/linux/bpf.h							\
+	       | $(OBJ_DIR)/libbpf
+	$(Q)$(MAKE) $(submake_extras) -C $(LIBBPF_DIR) OUTPUT=$(OBJ_DIR)/libbpf/	\
+		    EXTRA_CFLAGS='-g -O0 -fPIC'						\
+		    DESTDIR=$(OUTPUT_DIR) prefix= all install_headers
+
+$(DEFAULT_BPFTOOL): $(wildcard $(BPFTOOL_DIR)/*.[ch] $(BPFTOOL_DIR)/Makefile)	\
+		    $(LIBBPF_OUTPUT) | $(OBJ_DIR)/bpftool
+	$(Q)$(MAKE) $(submake_extras)  -C $(BPFTOOL_DIR)			\
+		    ARCH= CROSS_COMPILE= CC=$(HOSTCC) LD=$(HOSTLD)		\
+		    EXTRA_CFLAGS='-g -O0'					\
+		    OUTPUT=$(OBJ_DIR)/bpftool/					\
+		    LIBBPF_OUTPUT=$(OBJ_DIR)/libbpf/				\
+		    LIBBPF_DESTDIR=$(OUTPUT_DIR)/				\
+		    prefix= DESTDIR=$(OUTPUT_DIR)/ install-bin
+
+$(INCLUDE_DIR)/vmlinux.h: $(VMLINUX_BTF) $(BPFTOOL) | $(INCLUDE_DIR)
+ifeq ($(VMLINUX_H),)
+	$(call msg,GEN,,$@)
+	$(Q)$(BPFTOOL) btf dump file $(VMLINUX_BTF) format c > $@
+else
+	$(call msg,CP,,$@)
+	$(Q)cp "$(VMLINUX_H)" $@
+endif
+
+$(CRIBOBJ_DIR)/%.bpf.o: %.bpf.c %.h $(INCLUDE_DIR)/vmlinux.h | $(LIBBPF_OBJ) $(CRIBOBJ_DIR)
+	$(call msg,CLANG-BPF,,$(notdir $@))
+	$(Q)$(CLANG) $(BPF_CFLAGS) -target bpf -c $< -o $@
+
+$(INCLUDE_DIR)/%.bpf.skel.h: $(CRIBOBJ_DIR)/%.bpf.o $(INCLUDE_DIR)/vmlinux.h $(BPFTOOL) | $(INCLUDE_DIR)
+	$(call msg,GEN-SKEL,,$(notdir $@))
+	$(Q)$(BPFTOOL) gen skeleton $< > $@
+
+$(TEST_GEN_PROGS_OBJ): $(CRIBOBJ_DIR)/%.o: %.c %.h $(INCLUDE_DIR)/%.bpf.skel.h | $(CRIBOBJ_DIR)
+	$(call msg,CLANG,,$(notdir $@))
+	$(Q)$(CLANG) $(CFLAGS) -c $< -o $@
+
+$(TEST_GEN_PROGS): $(SBIN_DIR)/%: $(CRIBOBJ_DIR)/%.o $(LIBBPF_OBJ) | $(SBIN_DIR)
+	$(call msg,CLANG-LINK,,$(notdir $@))
+	$(Q)$(CLANG) $(CFLAGS) $(LDFLAGS) $^ -o $@
+
+override define CLEAN
+	rm -rf $(OUTPUT_DIR)
+endef
+
+all: $(TEST_GEN_PROGS)
+
+.PHONY: all clean help
+
+.DEFAULT_GOAL := all
+
+.DELETE_ON_ERROR:
+
+.SECONDARY:
diff --git a/tools/testing/selftests/crib/config b/tools/testing/selftests/crib/config
new file mode 100644
index 000000000000..61684f763df0
--- /dev/null
+++ b/tools/testing/selftests/crib/config
@@ -0,0 +1,7 @@
+CONFIG_BPF=y
+CONFIG_BPF_EVENTS=y
+CONFIG_BPF_JIT=y
+CONFIG_BPF_CRIB=y
+CONFIG_DEBUG_INFO_BTF=y
+CONFIG_IPV6=y
+CONFIG_NET=y
diff --git a/tools/testing/selftests/crib/test_dump_task.bpf.c b/tools/testing/selftests/crib/test_dump_task.bpf.c
new file mode 100644
index 000000000000..ee9843a79dac
--- /dev/null
+++ b/tools/testing/selftests/crib/test_dump_task.bpf.c
@@ -0,0 +1,125 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Author:
+ *	Juntong Deng <juntong.deng@outlook.com>
+ */
+
+#include "vmlinux.h"
+
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
+
+#include "test_dump_task.h"
+
+char LICENSE[] SEC("license") = "Dual BSD/GPL";
+
+struct {
+	__uint(type, BPF_MAP_TYPE_RINGBUF);
+	__uint(max_entries, 100000);
+} rb SEC(".maps");
+
+extern struct task_struct *bpf_task_from_vpid(pid_t vpid) __ksym;
+extern void bpf_task_release(struct task_struct *p) __ksym;
+
+extern int bpf_iter_task_vma_new(struct bpf_iter_task_vma *it,
+				 struct task_struct *task,
+				 unsigned long addr) __ksym;
+extern struct vm_area_struct *bpf_iter_task_vma_next(struct bpf_iter_task_vma *it) __ksym;
+extern void bpf_iter_task_vma_destroy(struct bpf_iter_task_vma *it) __ksym;
+
+SEC("crib")
+int dump_all_vma(struct prog_args *arg)
+{
+	int err = 0;
+
+	struct task_struct *task = bpf_task_from_vpid(arg->pid);
+	if (!task) {
+		err = -1;
+		goto error;
+	}
+
+	struct vm_area_struct *cur_vma;
+	struct bpf_iter_task_vma vma_it;
+
+	bpf_iter_task_vma_new(&vma_it, task, 0);
+	while ((cur_vma = bpf_iter_task_vma_next(&vma_it))) {
+		struct event_vma *e_vma = bpf_ringbuf_reserve(&rb, sizeof(struct event_vma), 0);
+		if (!e_vma) {
+			err = -2;
+			goto error_buf;
+		}
+
+		e_vma->hdr.type = EVENT_TYPE_VMA;
+		e_vma->vm_start = BPF_CORE_READ(cur_vma, vm_start);
+		e_vma->vm_end = BPF_CORE_READ(cur_vma, vm_end);
+		e_vma->vm_flags = BPF_CORE_READ(cur_vma, vm_flags);
+
+		if (cur_vma->vm_file)
+			e_vma->vm_pgoff = BPF_CORE_READ(cur_vma, vm_pgoff);
+
+		bpf_ringbuf_submit(e_vma, 0);
+	}
+
+error_buf:
+	bpf_iter_task_vma_destroy(&vma_it);
+	bpf_task_release(task);
+error:
+	return err;
+}
+
+SEC("crib")
+int dump_task_stat(struct prog_args *arg)
+{
+	int err = 0;
+
+	struct task_struct *task = bpf_task_from_vpid(arg->pid);
+	if (!task) {
+		err = -1;
+		goto error;
+	}
+
+	struct event_task *e_task = bpf_ringbuf_reserve(&rb, sizeof(struct event_task), 0);
+	if (!e_task) {
+		err = -2;
+		goto error_buf;
+	}
+
+	e_task->hdr.type = EVENT_TYPE_TASK;
+	e_task->pid = BPF_CORE_READ(task, pid);
+	e_task->prio = BPF_CORE_READ(task, prio);
+	e_task->policy = BPF_CORE_READ(task, policy);
+	e_task->flags = BPF_CORE_READ(task, flags);
+	e_task->exit_code = BPF_CORE_READ(task, exit_code);
+	BPF_CORE_READ_STR_INTO(&e_task->comm, task, comm);
+
+	bpf_ringbuf_submit(e_task, 0);
+
+	struct event_mm *e_mm = bpf_ringbuf_reserve(&rb, sizeof(struct event_mm), 0);
+	if (!e_mm) {
+		err = -2;
+		goto error_buf;
+	}
+
+	struct mm_struct *mm = BPF_CORE_READ(task, mm);
+	e_mm->hdr.type = EVENT_TYPE_MM;
+	e_mm->start_code = BPF_CORE_READ(mm, start_code);
+	e_mm->end_code = BPF_CORE_READ(mm, end_code);
+	e_mm->start_data = BPF_CORE_READ(mm, start_data);
+	e_mm->end_data = BPF_CORE_READ(mm, end_data);
+	e_mm->start_brk = BPF_CORE_READ(mm, start_brk);
+	e_mm->brk = BPF_CORE_READ(mm, brk);
+	e_mm->start_stack = BPF_CORE_READ(mm, start_stack);
+	e_mm->arg_start = BPF_CORE_READ(mm, arg_start);
+	e_mm->arg_end = BPF_CORE_READ(mm, arg_end);
+	e_mm->env_start = BPF_CORE_READ(mm, env_start);
+	e_mm->env_end = BPF_CORE_READ(mm, env_end);
+	e_mm->map_count = BPF_CORE_READ(mm, map_count);
+
+	bpf_ringbuf_submit(e_mm, 0);
+
+error_buf:
+	bpf_task_release(task);
+error:
+	return err;
+}
diff --git a/tools/testing/selftests/crib/test_dump_task.c b/tools/testing/selftests/crib/test_dump_task.c
new file mode 100644
index 000000000000..1b9f234ac292
--- /dev/null
+++ b/tools/testing/selftests/crib/test_dump_task.c
@@ -0,0 +1,337 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Author:
+ *	Juntong Deng <juntong.deng@outlook.com>
+ */
+
+#include <argp.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <time.h>
+#include <fcntl.h>
+#include <ctype.h>
+#include <bpf/libbpf.h>
+#include <bpf/bpf.h>
+#include <autoconf.h>
+
+#include "../kselftest_harness.h"
+
+#include "test_dump_task.h"
+#include "test_dump_task.bpf.skel.h"
+
+struct task {
+	int pid;
+	unsigned int flags;
+	int prio;
+	unsigned int policy;
+	int exit_code;
+	char comm[16];
+};
+
+struct mm {
+	unsigned long start_code;
+	unsigned long end_code;
+	unsigned long start_data;
+	unsigned long end_data;
+	unsigned long start_brk;
+	unsigned long brk;
+	unsigned long start_stack;
+	unsigned long arg_start;
+	unsigned long arg_end;
+	unsigned long env_start;
+	unsigned long env_end;
+	int map_count;
+};
+
+struct vma {
+	unsigned long vm_start;
+	unsigned long vm_end;
+	unsigned long vm_flags;
+	unsigned long vm_pgoff;
+};
+
+struct dump_info {
+	struct task task;
+	struct mm mm;
+	struct vma *vma;
+	unsigned int vma_count;
+};
+
+static int handle_vma_event(struct dump_info *info, struct event_vma *e_vma)
+{
+	struct vma *vma = &info->vma[info->vma_count];
+	vma->vm_start = e_vma->vm_start;
+	vma->vm_end = e_vma->vm_end;
+	vma->vm_flags = e_vma->vm_flags;
+	vma->vm_pgoff = e_vma->vm_pgoff;
+	info->vma_count++;
+	return 0;
+}
+
+static int handle_mm_event(struct dump_info *info, struct event_mm *e_mm)
+{
+	info->mm.start_code = e_mm->start_code;
+	info->mm.end_code = e_mm->end_code;
+	info->mm.start_data = e_mm->start_data;
+	info->mm.end_data = e_mm->end_data;
+	info->mm.start_brk = e_mm->start_brk;
+	info->mm.brk = e_mm->brk;
+	info->mm.start_stack = e_mm->start_stack;
+	info->mm.arg_start = e_mm->arg_start;
+	info->mm.arg_end = e_mm->arg_end;
+	info->mm.env_start = e_mm->env_start;
+	info->mm.env_end = e_mm->env_end;
+	info->mm.map_count = e_mm->map_count;
+	info->vma = (struct vma *)malloc(sizeof(struct vma) * e_mm->map_count);
+	info->vma_count = 0;
+	return 0;
+}
+
+static int handle_task_event(struct dump_info *info, struct event_task *e_task)
+{
+	info->task.pid = e_task->pid;
+	info->task.flags = e_task->flags;
+	info->task.prio = e_task->prio;
+	info->task.policy = e_task->policy;
+	info->task.exit_code = e_task->exit_code;
+	memcpy(info->task.comm, e_task->comm, sizeof(info->task.comm));
+	return 0;
+}
+
+static int handle_event(void *ctx, void *data, size_t data_sz)
+{
+	struct dump_info *info = (struct dump_info *)ctx;
+	const struct event_hdr *e_hdr = data;
+	int err = 0;
+
+	switch (e_hdr->type) {
+	case EVENT_TYPE_TASK:
+		handle_task_event(info, (struct event_task *)data);
+		break;
+	case EVENT_TYPE_VMA:
+		handle_vma_event(info, (struct event_vma *)data);
+		break;
+	case EVENT_TYPE_MM:
+		handle_mm_event(info, (struct event_mm *)data);
+		break;
+	default:
+		err = -1;
+		printf("Unknown event type!\n");
+		break;
+	}
+	return err;
+}
+
+static int dump_task_and_mm_struct_from_proc(struct dump_info *info)
+{
+	FILE *file = fopen("/proc/self/stat", "r");
+	if (!file)
+		return -1;
+
+	fscanf(file, "%d %s %*c %*d %*d %*d %*d %*d %u %*lu %*lu %*lu %*lu "
+		   "%*lu %*lu %*ld %*ld %d %*ld %*d %*d %*llu %*lu %*ld %*lu %lu %lu %lu "
+		   "%*lu %*lu %*lu %*lu %*lu %*lu %*lu %*lu %*lu %*d %*d %*u %u %*llu %*lu %*ld "
+		   "%lu %lu %lu %lu %lu %lu %lu %d",
+		   &info->task.pid, info->task.comm, &info->task.flags, &info->task.prio,
+		   &info->mm.start_code, &info->mm.end_code, &info->mm.start_stack,
+		   &info->task.policy, &info->mm.start_data, &info->mm.end_data,
+		   &info->mm.start_brk, &info->mm.arg_start, &info->mm.arg_end,
+		   &info->mm.env_start, &info->mm.env_end, &info->task.exit_code);
+
+	fclose(file);
+	return 0;
+}
+
+static void parse_vma_vmflags(char *buf, struct vma *vma)
+{
+	vma->vm_flags = 0;
+	char *token = strtok(buf, " ");
+	do {
+		if (!strncmp(token, "rd", 2))
+			vma->vm_flags |= VM_READ;
+		else if (!strncmp(token, "wr", 2))
+			vma->vm_flags |= VM_WRITE;
+		else if (!strncmp(token, "ex", 2))
+			vma->vm_flags |= VM_EXEC;
+		else if (!strncmp(token, "sh", 2))
+			vma->vm_flags |= VM_SHARED;
+		else if (!strncmp(token, "mr", 2))
+			vma->vm_flags |= VM_MAYREAD;
+		else if (!strncmp(token, "mw", 2))
+			vma->vm_flags |= VM_MAYWRITE;
+		else if (!strncmp(token, "me", 2))
+			vma->vm_flags |= VM_MAYEXEC;
+		else if (!strncmp(token, "ms", 2))
+			vma->vm_flags |= VM_MAYSHARE;
+		else if (!strncmp(token, "gd", 2))
+			vma->vm_flags |= VM_GROWSDOWN;
+		else if (!strncmp(token, "pf", 2))
+			vma->vm_flags |= VM_PFNMAP;
+		else if (!strncmp(token, "lo", 2))
+			vma->vm_flags |= VM_LOCKED;
+		else if (!strncmp(token, "io", 2))
+			vma->vm_flags |= VM_IO;
+		else if (!strncmp(token, "sr", 2))
+			vma->vm_flags |= VM_SEQ_READ;
+		else if (!strncmp(token, "rr", 2))
+			vma->vm_flags |= VM_RAND_READ;
+		else if (!strncmp(token, "dc", 2))
+			vma->vm_flags |= VM_DONTCOPY;
+		else if (!strncmp(token, "de", 2))
+			vma->vm_flags |= VM_DONTEXPAND;
+		else if (!strncmp(token, "lf", 2))
+			vma->vm_flags |= VM_LOCKONFAULT;
+		else if (!strncmp(token, "ac", 2))
+			vma->vm_flags |= VM_ACCOUNT;
+		else if (!strncmp(token, "nr", 2))
+			vma->vm_flags |= VM_NORESERVE;
+		else if (!strncmp(token, "ht", 2))
+			vma->vm_flags |= VM_HUGETLB;
+		else if (!strncmp(token, "sf", 2))
+			vma->vm_flags |= VM_SYNC;
+		else if (!strncmp(token, "ar", 2))
+			vma->vm_flags |= VM_ARCH_1;
+		else if (!strncmp(token, "wf", 2))
+			vma->vm_flags |= VM_WIPEONFORK;
+		else if (!strncmp(token, "dd", 2))
+			vma->vm_flags |= VM_DONTDUMP;
+		else if (!strncmp(token, "sd", 2))
+			vma->vm_flags |= VM_SOFTDIRTY;
+		else if (!strncmp(token, "mm", 2))
+			vma->vm_flags |= VM_MIXEDMAP;
+		else if (!strncmp(token, "hg", 2))
+			vma->vm_flags |= VM_HUGEPAGE;
+		else if (!strncmp(token, "nh", 2))
+			vma->vm_flags |= VM_NOHUGEPAGE;
+		else if (!strncmp(token, "mg", 2))
+			vma->vm_flags |= VM_MERGEABLE;
+		else if (!strncmp(token, "um", 2))
+			vma->vm_flags |= VM_UFFD_MISSING;
+		else if (!strncmp(token, "uw", 2))
+			vma->vm_flags |= VM_UFFD_WP;
+	}
+	while ((token = strtok(NULL, " ")) != NULL);
+}
+
+static int dump_vma_from_proc(struct dump_info *info)
+{
+	FILE *file = fopen("/proc/self/smaps", "r");
+	if (!file)
+		return -1;
+
+	char *line = NULL;
+	size_t len = 0;
+	ssize_t nread;
+	while ((nread = getline(&line, &len, file)) != -1) {
+		struct vma *vma = &info->vma[info->vma_count];
+		if (isupper(*line)) {
+			if (!strncmp(line, "VmFlags: ", 9)) {
+				parse_vma_vmflags(&line[9], vma);
+				info->vma_count++;
+			}
+		} else {
+			sscanf(line, "%lx-%lx %*c%*c%*c%*c %lx",
+			&vma->vm_start, &vma->vm_end, &vma->vm_pgoff);
+		}
+	}
+
+	fclose(file);
+	return 0;
+}
+
+static int check_dump_info_correctness(struct dump_info *crib_info, struct dump_info *proc_info)
+{
+	if (crib_info->task.pid != proc_info->task.pid ||
+		crib_info->task.flags != proc_info->task.flags ||
+		crib_info->task.prio - 100 != proc_info->task.prio ||
+		crib_info->task.policy != proc_info->task.policy ||
+		crib_info->task.exit_code != proc_info->task.exit_code ||
+		strncmp(crib_info->task.comm, proc_info->task.comm + 1,
+			strlen(crib_info->task.comm)))
+		return -1;
+
+	if (crib_info->mm.start_code != proc_info->mm.start_code ||
+		crib_info->mm.end_code != proc_info->mm.end_code ||
+		crib_info->mm.start_data != proc_info->mm.start_data ||
+		crib_info->mm.end_data != proc_info->mm.end_data ||
+		crib_info->mm.start_brk != proc_info->mm.start_brk ||
+		crib_info->mm.arg_start != proc_info->mm.arg_start ||
+		crib_info->mm.arg_end != proc_info->mm.arg_end ||
+		crib_info->mm.env_start != proc_info->mm.env_start ||
+		crib_info->mm.env_end != proc_info->mm.env_end ||
+		crib_info->mm.start_stack != proc_info->mm.start_stack)
+		return -1;
+
+	struct vma *crib_vma, *proc_vma;
+	for (int i = 0; i < crib_info->mm.map_count; i++) {
+		crib_vma = &crib_info->vma[i];
+		proc_vma = &proc_info->vma[i];
+		if (crib_vma->vm_start != proc_vma->vm_start ||
+			crib_vma->vm_end != proc_vma->vm_end ||
+			crib_vma->vm_flags != proc_vma->vm_flags ||
+			crib_vma->vm_pgoff << CONFIG_PAGE_SHIFT != proc_vma->vm_pgoff)
+			return -1;
+	}
+	return 0;
+}
+
+TEST(dump_task)
+{
+	struct prog_args args = {
+		.pid = getpid(),
+	};
+	ASSERT_GT(args.pid, 0);
+
+	DECLARE_LIBBPF_OPTS(bpf_test_run_opts, opts,
+		.ctx_in = &args,
+		.ctx_size_in = sizeof(args),
+	);
+
+	struct test_dump_task_bpf *skel = test_dump_task_bpf__open_and_load();
+	ASSERT_NE(skel, NULL);
+
+	int dump_task_stat_fd = bpf_program__fd(skel->progs.dump_task_stat);
+	ASSERT_GT(dump_task_stat_fd, 0);
+
+	int dump_all_vma_fd = bpf_program__fd(skel->progs.dump_all_vma);
+	ASSERT_GT(dump_all_vma_fd, 0);
+
+	struct dump_info crib_info, proc_info;
+	memset(&crib_info, 0, sizeof(struct dump_info));
+	memset(&proc_info, 0, sizeof(struct dump_info));
+
+	struct ring_buffer *rb = ring_buffer__new(bpf_map__fd(skel->maps.rb), handle_event,
+						  &crib_info, NULL);
+	ASSERT_NE(rb, NULL);
+
+	clock_t crib_begin = clock();
+
+	ASSERT_EQ(bpf_prog_test_run_opts(dump_task_stat_fd, &opts), 0);
+	ASSERT_EQ(bpf_prog_test_run_opts(dump_all_vma_fd, &opts), 0);
+
+	ASSERT_GT(ring_buffer__poll(rb, 100), 0);
+
+	clock_t crib_end = clock();
+
+	printf("CRIB dump took %f seconds\n", (double)(crib_end - crib_begin) / CLOCKS_PER_SEC);
+
+	clock_t proc_begin = clock();
+
+	proc_info.vma = (struct vma *)malloc(sizeof(struct vma) * (crib_info.mm.map_count + 1));
+	ASSERT_EQ(dump_task_and_mm_struct_from_proc(&proc_info), 0);
+	ASSERT_EQ(dump_vma_from_proc(&proc_info), 0);
+
+	clock_t proc_end = clock();
+
+	printf("PROC dump took %f seconds\n", (double)(proc_end - proc_begin) / CLOCKS_PER_SEC);
+
+	ASSERT_EQ(check_dump_info_correctness(&crib_info, &proc_info), 0);
+
+	free(crib_info.vma);
+	free(proc_info.vma);
+	ring_buffer__free(rb);
+	test_dump_task_bpf__destroy(skel);
+}
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/crib/test_dump_task.h b/tools/testing/selftests/crib/test_dump_task.h
new file mode 100644
index 000000000000..b3cf3df852bf
--- /dev/null
+++ b/tools/testing/selftests/crib/test_dump_task.h
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Author:
+ *	Juntong Deng <juntong.deng@outlook.com>
+ */
+
+#ifndef __TEST_DUMP_TASK_H
+#define __TEST_DUMP_TASK_H
+
+#define EVENT_TYPE_VMA	0
+#define EVENT_TYPE_TASK	1
+#define EVENT_TYPE_MM	2
+
+#define VM_READ		0x00000001
+#define VM_WRITE	0x00000002
+#define VM_EXEC		0x00000004
+#define VM_SHARED	0x00000008
+#define VM_MAYREAD	0x00000010
+#define VM_MAYWRITE	0x00000020
+#define VM_MAYEXEC	0x00000040
+#define VM_MAYSHARE	0x00000080
+#define VM_GROWSDOWN	0x00000100
+#define VM_UFFD_MISSING	0x00000200
+#define VM_MAYOVERLAY	0x00000200
+#define VM_PFNMAP	0x00000400
+#define VM_UFFD_WP	0x00001000
+#define VM_LOCKED	0x00002000
+#define VM_IO           0x00004000
+#define VM_SEQ_READ	0x00008000
+#define VM_RAND_READ	0x00010000
+#define VM_DONTCOPY	0x00020000
+#define VM_DONTEXPAND	0x00040000
+#define VM_LOCKONFAULT	0x00080000
+#define VM_ACCOUNT	0x00100000
+#define VM_NORESERVE	0x00200000
+#define VM_HUGETLB	0x00400000
+#define VM_SYNC		0x00800000
+#define VM_ARCH_1	0x01000000
+#define VM_WIPEONFORK	0x02000000
+#define VM_DONTDUMP	0x04000000
+#define VM_SOFTDIRTY	0x08000000
+#define VM_MIXEDMAP	0x10000000
+#define VM_HUGEPAGE	0x20000000
+#define VM_NOHUGEPAGE	0x40000000
+#define VM_MERGEABLE	0x80000000
+
+struct prog_args {
+	int pid;
+};
+
+struct event_hdr {
+	int type;
+	int subtype;
+};
+
+struct event_task {
+	struct event_hdr hdr;
+	int pid;
+	unsigned int flags;
+	int prio;
+	unsigned int policy;
+	int exit_code;
+	char comm[16];
+};
+
+struct event_vma {
+	struct event_hdr hdr;
+	unsigned long vm_start;
+	unsigned long vm_end;
+	unsigned long vm_flags;
+	unsigned long vm_pgoff;
+};
+
+struct event_mm {
+	struct event_hdr hdr;
+	unsigned long start_code;
+	unsigned long end_code;
+	unsigned long start_data;
+	unsigned long end_data;
+	unsigned long start_brk;
+	unsigned long brk;
+	unsigned long start_stack;
+	unsigned long arg_start;
+	unsigned long arg_end;
+	unsigned long env_start;
+	unsigned long env_end;
+	int map_count;
+};
+
+#endif /* __TEST_DUMP_TASK_H */
-- 
2.39.2


