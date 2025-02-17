Return-Path: <bpf+bounces-51761-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9313A38A92
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 18:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46F523AE752
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 17:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4A3229B1C;
	Mon, 17 Feb 2025 17:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="i2JfOwoT"
X-Original-To: bpf@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazolkn19013066.outbound.protection.outlook.com [52.103.32.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AB321C9F1;
	Mon, 17 Feb 2025 17:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739813393; cv=fail; b=q5tGkwKIpOjnDrQFznEmfYx25mFS+ZAsVEQ/M7LIgLgeFkhtlmNLVU0U4qsiVf40nTDIQNMOm9D97Z4TuuHEnAIL1Wn7ybr1V9xfmnoFQPjY5b3f3npyQ7E7RNwn3D5EhRgVQVhpexRsU4LVzezcgjYVN2UTNJJOyyGnjj5M5Gc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739813393; c=relaxed/simple;
	bh=xVdRs7wh2ymh+3IV8Kl4HwVqaEMKIvNZnUVpdfSRGAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lif1B9u8LDvzngvicJ+ABWEZX5mTvK1GIV+NY2mVGX2+y2NzMycZQijVfodyPEj4WLeIfUtfFKOYqUZL/xs88oi7CelnVOxjAaYcoo452xEADIrYrkv7jJPzDL34Ao8r6jwbp3tm+qDzij8Vdbhc9fqW73sUUT4FiM+En0ttDYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=i2JfOwoT; arc=fail smtp.client-ip=52.103.32.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IorTRtmFRIhlguJ5slqXRODJC0xfzbaZjbS4BBvFjk/p9IQm7MOAVROT5Wn2+3CgAkucc8/n8oMELQYEUxNglwVI+3fIUtCnIWlJry3SvxGfn+eRdUJXfQL1fQew9EOwsqSXuCFDSDOcyWTN42s8H8pbuuH1x1tQfwhqteAvnwG94JqRyi8Nsnl3Wg/1lLDoSB9kkCiZnFzXsSFm51mLPv22U3vKesmG6acztzX3wfOn5CKOapkhfhDzEl5Xceo/zkUYio1z0QnqyN00tpWWLdBjRe/nBwWfJeoDSHJXjMBees4wTnnCLzjt0+m/m++ys+7Tt0RNxwUgQLdR793dQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6SxPd8xW+U2Z0veDEotp3KNIz10EIFTL9qxJCVoHTDI=;
 b=J9tGeWzBmqgdsmwQKMACUQy2G1GY/fzNuBv2r8OKRtr+6Ad56FYIqcUTuBtmW4nDKLxsTeIKemVd/vIOLKUHU0TwX74qjvoALWCJMQZHc2KyzgiQ0sSVekOJoO4gTPU2wipi/IOnI2c73kcVbGb6yPaeVvtO0hAeWFWycLKy6AwNGm2SX0wZhprUar6kJjapzA+Sy8eVFtKxYLVA2ZAMKg8eSD1wdNQJc6q8kP5JfBsJ9/v8nWebXKzUHBQjMC8NBzFox/RZvz7m0SU/MPz7tm8uWdagRtFqbnZrF7+eTfRW6d/pNofDJrmWFotE6M22iIhjSORy9jbhcs0mzPLBOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6SxPd8xW+U2Z0veDEotp3KNIz10EIFTL9qxJCVoHTDI=;
 b=i2JfOwoTy5Rhjy/RzCryNtF+9j8/M8hJ93RvdGwuQcjtsgVSb04kpsikWFVHmEBqNkSAU+zNo5ynGuUVFFyCvAtxAKGEwwZ18jSC/1voZYrM97aWm3GiP+128D0/pwjKY/X+VtuPq0JqLz/dddBiTgYeRjj0E+5JlA56zK2RRNDh1LHCrg4H1ADylO3zcjMphKep8xzyqiw44ZYfUdsRFYxN94XYz+RdDOGv+6DQ7GlFpWsELgrgrxW6oLqnEMCzzlTJZqBDKXBy2aj58Hwh8Ylf6VCMJtp/p15jiQgeIOQJOu5M05MyRXW9+rWfeOqZrnBqMp9ukqGx2mh0l+A90w==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by AS8PR03MB8665.eurprd03.prod.outlook.com (2603:10a6:20b:54b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Mon, 17 Feb
 2025 17:29:48 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%5]) with mapi id 15.20.8445.016; Mon, 17 Feb 2025
 17:29:48 +0000
From: Juntong Deng <juntong.deng@outlook.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	memxor@gmail.com,
	snorcht@gmail.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH bpf-next 3/3] selftests/bpf: Add test case for demonstrating BPF debug mode.
Date: Mon, 17 Feb 2025 17:23:50 +0000
Message-ID:
 <AM6PR03MB5080AFB6039F40D3EA6568CB99FB2@AM6PR03MB5080.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <AM6PR03MB50804A5BF211E94A5DF8F66699FB2@AM6PR03MB5080.eurprd03.prod.outlook.com>
References: <AM6PR03MB50804A5BF211E94A5DF8F66699FB2@AM6PR03MB5080.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0024.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ae::19) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <20250217172350.56184-3-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|AS8PR03MB8665:EE_
X-MS-Office365-Filtering-Correlation-Id: 4df9cb48-1a8d-401e-1abe-08dd4f78ad9e
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|5072599009|8060799006|15080799006|461199028|3412199025|440099028|41001999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IrryblkVOJtyINkH2YExK/AE9nDJr9lw/AyRPgYJ9vGSGksXgonz2ySLBRYc?=
 =?us-ascii?Q?XJdN1OlueC/C57xP6jU5k/mVOAuFiHOh/UsP6PBNj/UcOtlo0LkvEK5VGmvb?=
 =?us-ascii?Q?yKd73w7zFfQ7/XQy/xqn4SyCeMJs0LesqS/fr1wuzWaMfpVOJxCaM3BIkcvu?=
 =?us-ascii?Q?pue+SPhyWU/gg7U+0kOuZm57X+D2CvHGUoX03gsx2m3+C1nAcqwWz1Y+z0wH?=
 =?us-ascii?Q?Om6aTU0MB+Yl7ZikEoj2OSfXoQECrXW07HltDDfczH41Y0WZhUfCQdU0acsX?=
 =?us-ascii?Q?eeD1re7WmKSasjslIlknVbizg+dnJP3X3QiZDAlhbP9g0u2cHvxCO9jembXb?=
 =?us-ascii?Q?+BnThi6bPF2uPts7PCkd2fZWZz+AW2XeRgOZbL+IWQd1Hvx5fRuqPA2Euu+Q?=
 =?us-ascii?Q?9MjbpcDyUITMCkN0uLKuYz5I2dye+Yx1GiLBJI/zgQnaktojoNQkNod4osjk?=
 =?us-ascii?Q?D9SZHI99U+osBPjdZUvPW84798oBKOCw3JUdUEBzuFVNpzFW9dH+T5Mk1OHV?=
 =?us-ascii?Q?wTYjRJz8s8vFpo0z1oE1L/s1j19HtReVIsY6QAcKxi9JubQkNZ8B/YCD99iu?=
 =?us-ascii?Q?oErG1cUtYglvFZGVEm7NU7IpES2CkQJQM5o9V7JrPNKltySUcb/IKzmbGxgm?=
 =?us-ascii?Q?cGTJ5XzONXheQ7anJ0XQ+Zv66X6EwXc6SEQ3BWcECX9c6qobfE2Bfs6GucAW?=
 =?us-ascii?Q?NYQdXaqgGyUVIOWudCBqCtVm5adlP8CzU/7iQA+T0S0gfMmiLC54KIvCN9Mw?=
 =?us-ascii?Q?LVBIy0o6y2f8oMRHXfmAnBpfwQ75MhU3V29lxZ4dfBAmi/QdF+ZV86kp3qFA?=
 =?us-ascii?Q?5pyP0GS4JI7iX/99dMoztUCJHdhsXtHXaTvkFG9+NZyApp3WNy32vp8pBtE/?=
 =?us-ascii?Q?JgnnjuqsKWwlpnpl0EX8wBpq3pY+ok11TY3qGRiu2mAOlWWf4eisr6UPwrUM?=
 =?us-ascii?Q?sc5sFmBcTIR9MEK97uEK22vzdMjV6hpDOJp8q1OqGj/gpIdLFc0Oef2sEkS4?=
 =?us-ascii?Q?kfrZ3yVpe4ZWse9qtXaI8rMr8dYyZ0+1WbRQ8JqGirlo3MwyL3VlOh/eiG4l?=
 =?us-ascii?Q?9SHr0AYw6Bq20krpxpCrAC70UKKnJA=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DE59tFUyY6Ki/tTgMKZ9V+l4ZTZHR6s7vAFTuLg2B+Bf83SFV1NNkqTnW0ch?=
 =?us-ascii?Q?SzOH0ZY3GXlWJqcv84x5eabvfpkBcdROvCilYH5jTtFXTRpoMysXqA5S0GAr?=
 =?us-ascii?Q?dsfdWc80x+N/QxTDgTG4eJOsBvVKdLg5aeCPrd52Rl72bUIgaznmHxF1onVC?=
 =?us-ascii?Q?U6GjUvoPvCh8X6cHveZwYnM9Fmt/y1y5l5Uw3WVf5/wlbUGwH+0DtDV3nZNp?=
 =?us-ascii?Q?oXOdixv7+uhz+nBgl7HIecYtnESLbhIV34NynDETCCBIlTX2qKg4WKBZ6aBq?=
 =?us-ascii?Q?fkzpEUbWy35vYSv+ZcGmUZP729tQt63Gm12XIElGbjHT99kfClGVlHx6Kbq+?=
 =?us-ascii?Q?ab3awqB8pxsL7vOtcGxYMa2o8vIW/E6RMw/LZAyJLOEAGbbCiixnTRqUo4m0?=
 =?us-ascii?Q?jN0CFZ5zGBv5KfmM10U/g+2hNVroFEGbZKJwL2lBsnacIpGg7RBa4A73lslj?=
 =?us-ascii?Q?Z3SP4CFivhly4mvR3glfK1Yv7VzZ57AAI1BRfspX5XRPQfpvLfuwnSDHjoYn?=
 =?us-ascii?Q?f9qYdCpnqK3MjWrg7GrG/yR+PxwmkEZNxs8btRTYBycYhx1E0iHz7JhG7uDd?=
 =?us-ascii?Q?5sIIoAnYj5B7+BOLofmoOByAa6BEUGB+xtDtn5YuefUX4OEjeryZER9ZQVtR?=
 =?us-ascii?Q?6OH1u0/rS6nWRvRcpPbSJ5JeyBlqpxEClYjcZqXbatee2zj0HuUesx8+jhB3?=
 =?us-ascii?Q?EgFoQgYqjQtG9d9CajSc79JDXBgMn7pvYJjAsF1stqcbdKpoRRhoY0/CwhfO?=
 =?us-ascii?Q?aSUu1eCRGCNVxrC7N0xkIIbAPXHBUq+O/lq2omkHYvAqDikNGZJU9fzSORNn?=
 =?us-ascii?Q?nD9fpou8+i00jzcehmmOvVhuHvgt8AmHFP+x0xqpgmpQ5TunLE2BUWro/1nD?=
 =?us-ascii?Q?Hr3QoVtIHnTeIV0JNwEghK+CkAmhHnGFlUcBUnOc2xIvF3JMiN7Tu3E6+q/F?=
 =?us-ascii?Q?9vZgWb1cSDhv/lZX8EgXuvy5RxLOz9E/o+WpW+Mki8OPhUyi1m4Cy5VuD1U9?=
 =?us-ascii?Q?T6CkB5YjBZtLmd80enMAaU9Vn9Lvv38pMkFjikMJ4XdfpyM53U+zEdTbIt4E?=
 =?us-ascii?Q?WvUIG5DahzsHvLbhyqnAE49bFb9+XQDAS0/5O50oIPAPDY38V1yfvSAMCVnN?=
 =?us-ascii?Q?UdBJFRypHIGt3ub7FmWLfqZc1amJ6VR9/0TgpN8ux5e0vHMFnCeyAJHTsNkg?=
 =?us-ascii?Q?I22wh52gjDeukpVQE1swYXHwp+PKDWGrotBkIB0ZmqH7+xrUKX/NYLK24JV5?=
 =?us-ascii?Q?4Ci4KWLLycQn1SEJX5I0?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4df9cb48-1a8d-401e-1abe-08dd4f78ad9e
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 17:29:48.6922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB8665

This patch adds test case for demonstrating BPF debug mode.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 tools/testing/selftests/bpf_debug/Makefile    | 136 ++++++++++++++++++
 tools/testing/selftests/bpf_debug/debug.bpf.c |  39 +++++
 tools/testing/selftests/bpf_debug/debug.c     |  24 ++++
 3 files changed, 199 insertions(+)
 create mode 100644 tools/testing/selftests/bpf_debug/Makefile
 create mode 100644 tools/testing/selftests/bpf_debug/debug.bpf.c
 create mode 100644 tools/testing/selftests/bpf_debug/debug.c

diff --git a/tools/testing/selftests/bpf_debug/Makefile b/tools/testing/selftests/bpf_debug/Makefile
new file mode 100644
index 000000000000..4afaf2407128
--- /dev/null
+++ b/tools/testing/selftests/bpf_debug/Makefile
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
+DEBUGOBJ_DIR := $(OBJ_DIR)/debug
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
+	     $(INCLUDE_DIR) $(DEBUGOBJ_DIR) $(SBIN_DIR))
+
+TEST_GEN_BPF_PROGS_SKEL := $(foreach prog,$(wildcard *.bpf.c),$(INCLUDE_DIR)/$(patsubst %.c,%.skel.h,$(prog)))
+
+TEST_GEN_PROGS := $(addprefix $(SBIN_DIR)/, $(basename $(filter-out $(wildcard *.bpf.c), $(wildcard *.c))))
+
+TEST_GEN_PROGS_OBJ := $(addsuffix .o,$(addprefix $(DEBUGOBJ_DIR)/, $(notdir $(TEST_GEN_PROGS))))
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
+$(DEBUGOBJ_DIR)/%.bpf.o: %.bpf.c $(INCLUDE_DIR)/vmlinux.h | $(LIBBPF_OBJ) $(DEBUGOBJ_DIR)
+	$(call msg,CLANG-BPF,,$(notdir $@))
+	$(Q)$(CLANG) $(BPF_CFLAGS) -target bpf -c $< -o $@
+
+$(INCLUDE_DIR)/%.bpf.skel.h: $(DEBUGOBJ_DIR)/%.bpf.o $(INCLUDE_DIR)/vmlinux.h $(BPFTOOL) | $(INCLUDE_DIR)
+	$(call msg,GEN-SKEL,,$(notdir $@))
+	$(Q)$(BPFTOOL) gen skeleton $< > $@
+
+$(TEST_GEN_PROGS_OBJ): $(DEBUGOBJ_DIR)/%.o: %.c $(INCLUDE_DIR)/%.bpf.skel.h | $(DEBUGOBJ_DIR)
+	$(call msg,CLANG,,$(notdir $@))
+	$(Q)$(CLANG) $(CFLAGS) -c $< -o $@
+
+$(TEST_GEN_PROGS): $(SBIN_DIR)/%: $(DEBUGOBJ_DIR)/%.o $(LIBBPF_OBJ) | $(SBIN_DIR)
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
diff --git a/tools/testing/selftests/bpf_debug/debug.bpf.c b/tools/testing/selftests/bpf_debug/debug.bpf.c
new file mode 100644
index 000000000000..8832cd0e584e
--- /dev/null
+++ b/tools/testing/selftests/bpf_debug/debug.bpf.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
+
+char LICENSE[] SEC("license") = "GPL";
+
+void bpf_task_release(struct task_struct *p) __ksym;
+struct task_struct *bpf_task_from_pid(s32 pid) __ksym;
+
+struct bpf_cpumask *bpf_cpumask_create(void) __ksym;
+void bpf_cpumask_release(struct bpf_cpumask *cpumask) __ksym;
+
+SEC("syscall")
+int test_debug_mode(void *arg)
+{
+	struct bpf_cpumask *cpumask;
+	struct task_struct *task;
+	struct bpf_iter_num it;
+	int *v, pid;
+
+	bpf_iter_num_new(&it, 1, 3);
+	while ((v = bpf_iter_num_next(&it))) {
+		task = bpf_task_from_pid(*v);
+		if (task) {
+			pid = BPF_CORE_READ(task, pid);
+			bpf_task_release(task);
+		}
+	}
+	bpf_iter_num_destroy(&it);
+
+	cpumask = bpf_cpumask_create();
+	if (cpumask)
+		bpf_cpumask_release(cpumask);
+
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf_debug/debug.c b/tools/testing/selftests/bpf_debug/debug.c
new file mode 100644
index 000000000000..1df7ccfeb26d
--- /dev/null
+++ b/tools/testing/selftests/bpf_debug/debug.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <stdio.h>
+#include <bpf/libbpf.h>
+#include <bpf/bpf.h>
+#include "debug.bpf.skel.h"
+
+int main(int argc, char **argv)
+{
+	LIBBPF_OPTS(bpf_object_open_opts, opts);
+	struct debug_bpf *skel;
+	int err, prog_fd;
+
+	opts.debug_mode = true;
+
+	skel = debug_bpf__open_opts(&opts);
+
+	err = debug_bpf__load(skel);
+	prog_fd = bpf_program__fd(skel->progs.test_debug_mode);
+	err = bpf_prog_test_run_opts(prog_fd, NULL);
+
+	debug_bpf__destroy(skel);
+	return err;
+}
-- 
2.39.5


