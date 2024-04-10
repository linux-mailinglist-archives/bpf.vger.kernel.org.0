Return-Path: <bpf+bounces-26430-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3887189F954
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 16:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD6A4289835
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 14:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3AD16DEC3;
	Wed, 10 Apr 2024 14:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="SknUkxTk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0BE16D312
	for <bpf@vger.kernel.org>; Wed, 10 Apr 2024 14:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712757716; cv=none; b=V4Rv9PFbRRNf/K3qH6FQ6bin+hfJPSZRsJiZzZKuIIGqf3nlSTNj1SW9qTJbcEnMf4VM9lrBjyxGorwACaRZXzHJYgQKZQMwK01YJdeLhk22huSIcub3LQ5pHDx66tKvq1TtrybLUxcmpHHTO6xPQ4ar207tD31V+uGbj0ijDHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712757716; c=relaxed/simple;
	bh=0YCUGjyGLg15c6bE1TKu3Ebd8pGQTHU/LsK6uo7g7+4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OB3UVbvYf2Va70oqL0FO8AnUl23YwxDBOA3n7r5JBrUZcgso1/HGSt1EDM7+58XOeEQwAZyDPElU9TA6wWQgtCvG1sFYIGKziD8LyIR4vN9CXQE6FoSgeKs8iA2/O0hyHfcKgMs9BDNudzl/AwPDXqLsQKUFBgg023RRwBqoXus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=SknUkxTk; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-78a2a97c296so391150785a.2
        for <bpf@vger.kernel.org>; Wed, 10 Apr 2024 07:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1712757712; x=1713362512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6wd1CABGiIton5eI7q0xSCGTeGTLaFN+AYLoB+USX1g=;
        b=SknUkxTkIjxpPaiERuIrYlySwahDyGy5yi2pPSwX2KXRB5enjfpuaz7fNZq3vFvOU+
         gIpdW4u4gZ9rG/WjHJMkU25swLNDLFwsnkc13uIrqyy0OQT5fOTAi+2TOx1R2Qx17jXr
         bsU5OU8sjvlyxqblBHs7BXLgd57DlXXh0SYpLlKKvtlT0vDBbcAbyBzOUJkdJDIe8kaA
         0Je+qLC5P07ueHGGvDEqqdBOMht6FvbstpNUAbmQXECo3V9lz0OrCoCRsmMgCgtvJ01f
         BXS8kIZbQd6Lhej7LGn4buyX7IdXt1A/WiRpuOl3JOGfWAVA6QhVAEznG+dQrJbUmiwD
         b2OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712757712; x=1713362512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6wd1CABGiIton5eI7q0xSCGTeGTLaFN+AYLoB+USX1g=;
        b=e6uXeRwtj0fPS9UR0itbjjgQtGGzWqYqqtcHDrzu1dCfCeU/1BfFcwxhIVTogL5Ceu
         sfGV533eQIzoisgBMZ13ledSbes9LgoX9UjhrWX7zdzg1gEFW2S/5mlNu6IkJRZjPSBW
         nwYz4M1oosuoCShpZn1f4ByhwYPe7KNl7HrXUmMRshpR/5QJWZ/7EWVmikAfbvrxt5UJ
         72NpCgKrE5WDlELC+XDpY7mYQfECaK7S6P9V4v++ChecK4AcOH2Sjh7Dz12DvxdGCgdV
         LunOid30IKV8zebs783wyBHe/ecyUhHMx+332APtuoyBn4Np2uMrfmFQ+j9IuCRTbwK1
         cmoA==
X-Forwarded-Encrypted: i=1; AJvYcCUMbnKjVax1ZZe171DZnBiccyNF1YHKR1FEPQwzr1HHjnQPaTv+EQ39cFDOjOpWds2l0+QGMOfYRruGS9B4xMs7to0T
X-Gm-Message-State: AOJu0YzSXcMnD+E8TqYv4KsE2lJ53iT5uAXWo+mgX8tBQ9Ph+zfQH0XU
	nptSH/47dynPx0ggADm70kJFqHj9tTrXgFzm/e7bH6sQjwuBJbKd0nsOsl8TPw==
X-Google-Smtp-Source: AGHT+IEsZI3i/pNc7VbG6e/ZVuznxBcuBlXokuWJhuJTTMUtmoiMlz9Lc/dbSVvGiB9zzJrugQ9ltw==
X-Received: by 2002:a05:620a:b1a:b0:78d:7474:9b50 with SMTP id t26-20020a05620a0b1a00b0078d74749b50mr3166367qkg.39.1712757712183;
        Wed, 10 Apr 2024 07:01:52 -0700 (PDT)
Received: from majuu.waya (bras-base-kntaon1621w-grc-19-174-94-28-98.dsl.bell.ca. [174.94.28.98])
        by smtp.gmail.com with ESMTPSA id t30-20020a05620a035e00b0078d74f1d3c8sm1345173qkm.110.2024.04.10.07.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 07:01:51 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: deb.chatterjee@intel.com,
	anjali.singhai@intel.com,
	namrata.limaye@intel.com,
	tom@sipanda.io,
	mleitner@redhat.com,
	Mahesh.Shirshyad@amd.com,
	tomasz.osinski@intel.com,
	jiri@resnulli.us,
	xiyou.wangcong@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vladbu@nvidia.com,
	horms@kernel.org,
	khalidm@nvidia.com,
	toke@redhat.com,
	victor@mojatatu.com,
	pctammela@mojatatu.com,
	bpf@vger.kernel.org
Subject: [PATCH net-next v16  06/15] p4tc: add P4 data types
Date: Wed, 10 Apr 2024 10:01:32 -0400
Message-Id: <20240410140141.495384-7-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240410140141.495384-1-jhs@mojatatu.com>
References: <20240410140141.495384-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Introduce abstraction that represents P4 data types.
This also introduces the Kconfig and Makefile which later patches use.
Numeric types could be little, host or big endian definitions. The abstraction
also supports defining:

a) bitstrings using P4 annotations that look like "bit<X>" where X
   is the number of bits defined in a type

b) bitslices such that one can define in P4 as bit<8>[0-3] and
   bit<16>[4-9]. A 4-bit slice from bits 0-3 and a 6-bit slice from bits
   4-9 respectively.

c) speacialized types like dev (which stands for a netdev), key, etc

Each type has a bitsize, a name (for debugging purposes), an ID and
methods/ops. The P4 types will be used by externs, dynamic actions, packet
headers and other parts of P4TC.

Each type has four ops:

- validate_p4t: Which validates if a given value of a specific type
  meets valid boundary conditions.

- create_bitops: Which, given a bitsize, bitstart and bitend allocates and
  returns a mask and a shift value. For example, if we have type
  bit<8>[3-3] meaning bitstart = 3 and bitend = 3, we'll create a mask
  which would only give us the fourth bit of a bit8 value, that is, 0x08.
  Since we are interested in the fourth bit, the bit shift value will be 3.
  This is also useful if an "irregular" bitsize is used, for example,
  bit24. In that case bitstart = 0 and bitend = 23. Shift will be 0 and
  the mask will be 0xFFFFFF00 if the machine is big endian.

- host_read : Which reads the value of a given type and transforms it to
  host order (if needed)

- host_write : Which writes a provided host order value and transforms it
  to the type's native order (if needed)

Co-developed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Reviewed-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Acked-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 include/net/p4tc_types.h    |   89 +++
 include/uapi/linux/p4tc.h   |   33 +
 net/sched/Kconfig           |   11 +
 net/sched/Makefile          |    2 +
 net/sched/p4tc/Makefile     |    3 +
 net/sched/p4tc/p4tc_types.c | 1213 +++++++++++++++++++++++++++++++++++
 6 files changed, 1351 insertions(+)
 create mode 100644 include/net/p4tc_types.h
 create mode 100644 include/uapi/linux/p4tc.h
 create mode 100644 net/sched/p4tc/Makefile
 create mode 100644 net/sched/p4tc/p4tc_types.c

diff --git a/include/net/p4tc_types.h b/include/net/p4tc_types.h
new file mode 100644
index 000000000000..9b6937969d42
--- /dev/null
+++ b/include/net/p4tc_types.h
@@ -0,0 +1,89 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __NET_P4TYPES_H
+#define __NET_P4TYPES_H
+
+#include <linux/netlink.h>
+#include <linux/pkt_cls.h>
+#include <linux/types.h>
+
+#include <uapi/linux/p4tc.h>
+
+#define P4TC_T_MAX_BITSZ 512
+
+struct p4tc_type_mask_shift {
+	void *mask;
+	u8 shift;
+};
+
+struct p4tc_type;
+struct p4tc_type_ops {
+	int (*validate_p4t)(struct p4tc_type *container, void *value,
+			    u16 startbit, u16 endbit,
+			    struct netlink_ext_ack *extack);
+	struct p4tc_type_mask_shift *(*create_bitops)(u16 bitsz, u16 bitstart,
+						      u16 bitend,
+						      struct netlink_ext_ack *extack);
+	void (*host_read)(struct p4tc_type *container,
+			  struct p4tc_type_mask_shift *mask_shift, void *sval,
+			  void *dval);
+	void (*host_write)(struct p4tc_type *container,
+			   struct p4tc_type_mask_shift *mask_shift, void *sval,
+			   void *dval);
+};
+
+#define P4TC_T_MAX_STR_SZ 32
+struct p4tc_type {
+	char name[P4TC_T_MAX_STR_SZ];
+	const struct p4tc_type_ops *ops;
+	size_t container_bitsz;
+	size_t bitsz;
+	int typeid;
+};
+
+struct p4tc_type *p4type_find_byid(int id);
+bool p4tc_is_type_unsigned_he(int typeid);
+bool p4tc_is_type_numeric(int typeid);
+
+void p4t_copy(struct p4tc_type_mask_shift *dst_mask_shift,
+	      struct p4tc_type *dst_t, void *dstv,
+	      struct p4tc_type_mask_shift *src_mask_shift,
+	      struct p4tc_type *src_t, void *srcv);
+int p4t_cmp(struct p4tc_type_mask_shift *dst_mask_shift,
+	    struct p4tc_type *dst_t, void *dstv,
+	    struct p4tc_type_mask_shift *src_mask_shift,
+	    struct p4tc_type *src_t, void *srcv);
+void p4t_release(struct p4tc_type_mask_shift *mask_shift);
+
+int p4tc_register_types(void);
+void p4tc_unregister_types(void);
+
+#ifdef CONFIG_RETPOLINE
+void __p4tc_type_host_read(const struct p4tc_type_ops *ops,
+			   struct p4tc_type *container,
+			   struct p4tc_type_mask_shift *mask_shift, void *sval,
+			   void *dval);
+void __p4tc_type_host_write(const struct p4tc_type_ops *ops,
+			    struct p4tc_type *container,
+			    struct p4tc_type_mask_shift *mask_shift, void *sval,
+			    void *dval);
+#else
+static inline void
+__p4tc_type_host_read(const struct p4tc_type_ops *ops,
+		      struct p4tc_type *container,
+		      struct p4tc_type_mask_shift *mask_shift,
+		      void *sval, void *dval)
+{
+	return ops->host_read(container, mask_shift, sval, dval);
+}
+
+static inline void
+__p4tc_type_host_write(const struct p4tc_type_ops *ops,
+		       struct p4tc_type *container,
+		       struct p4tc_type_mask_shift *mask_shift,
+		       void *sval, void *dval)
+{
+	return ops->host_write(container, mask_shift, sval, dval);
+}
+#endif
+
+#endif
diff --git a/include/uapi/linux/p4tc.h b/include/uapi/linux/p4tc.h
new file mode 100644
index 000000000000..0133947c5b69
--- /dev/null
+++ b/include/uapi/linux/p4tc.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef __LINUX_P4TC_H
+#define __LINUX_P4TC_H
+
+#define P4TC_MAX_KEYSZ 512
+
+enum {
+	P4TC_T_UNSPEC,
+	P4TC_T_U8,
+	P4TC_T_U16,
+	P4TC_T_U32,
+	P4TC_T_U64,
+	P4TC_T_STRING,
+	P4TC_T_S8,
+	P4TC_T_S16,
+	P4TC_T_S32,
+	P4TC_T_S64,
+	P4TC_T_MACADDR,
+	P4TC_T_IPV4ADDR,
+	P4TC_T_BE16,
+	P4TC_T_BE32,
+	P4TC_T_BE64,
+	P4TC_T_U128,
+	P4TC_T_S128,
+	P4TC_T_BOOL,
+	P4TC_T_DEV,
+	P4TC_T_KEY,
+	__P4TC_T_MAX,
+};
+
+#define P4TC_T_MAX (__P4TC_T_MAX - 1)
+
+#endif
diff --git a/net/sched/Kconfig b/net/sched/Kconfig
index 8180d0c12fce..5dbae579bda8 100644
--- a/net/sched/Kconfig
+++ b/net/sched/Kconfig
@@ -675,6 +675,17 @@ config NET_EMATCH_IPT
 	  To compile this code as a module, choose M here: the
 	  module will be called em_ipt.
 
+config NET_P4TC
+	bool "P4TC support"
+	select NET_CLS_ACT
+	help
+	  Say Y here if you want to use P4 features on top of TC.
+	  P4 is an open source,  domain-specific programming language for
+	  specifying data plane behavior. By enabling P4TC you will be able to
+	  write a P4 program, use a P4 compiler that supports P4TC backend to
+	  generate all needed artificats, which when loaded allow you to
+	  introduce a new kernel datapath that can be controlled via TC.
+
 config NET_CLS_ACT
 	bool "Actions"
 	select NET_CLS
diff --git a/net/sched/Makefile b/net/sched/Makefile
index 82c3f78ca486..581f9dd69032 100644
--- a/net/sched/Makefile
+++ b/net/sched/Makefile
@@ -81,3 +81,5 @@ obj-$(CONFIG_NET_EMATCH_TEXT)	+= em_text.o
 obj-$(CONFIG_NET_EMATCH_CANID)	+= em_canid.o
 obj-$(CONFIG_NET_EMATCH_IPSET)	+= em_ipset.o
 obj-$(CONFIG_NET_EMATCH_IPT)	+= em_ipt.o
+
+obj-$(CONFIG_NET_P4TC)		+= p4tc/
diff --git a/net/sched/p4tc/Makefile b/net/sched/p4tc/Makefile
new file mode 100644
index 000000000000..dd1358c9e802
--- /dev/null
+++ b/net/sched/p4tc/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-y := p4tc_types.o
diff --git a/net/sched/p4tc/p4tc_types.c b/net/sched/p4tc/p4tc_types.c
new file mode 100644
index 000000000000..bc4850153302
--- /dev/null
+++ b/net/sched/p4tc/p4tc_types.c
@@ -0,0 +1,1213 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * net/sched/p4tc/p4tc_types.c -  P4 datatypes
+ * Copyright (c) 2022-2024, Mojatatu Networks
+ * Copyright (c) 2022-2024, Intel Corporation.
+ * Authors:     Jamal Hadi Salim <jhs@mojatatu.com>
+ *              Victor Nogueira <victor@mojatatu.com>
+ *              Pedro Tammela <pctammela@mojatatu.com>
+ */
+
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/errno.h>
+#include <linux/skbuff.h>
+#include <linux/rtnetlink.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <net/net_namespace.h>
+#include <net/netlink.h>
+#include <net/pkt_sched.h>
+#include <net/pkt_cls.h>
+#include <net/act_api.h>
+#include <net/p4tc_types.h>
+#include <linux/etherdevice.h>
+
+static DEFINE_IDR(p4tc_types_idr);
+
+static void p4tc_types_put(void)
+{
+	unsigned long tmp, typeid;
+	struct p4tc_type *type;
+
+	idr_for_each_entry_ul(&p4tc_types_idr, type, tmp, typeid) {
+		idr_remove(&p4tc_types_idr, typeid);
+		kfree(type);
+	}
+}
+
+struct p4tc_type *p4type_find_byid(int typeid)
+{
+	return idr_find(&p4tc_types_idr, typeid);
+}
+
+static struct p4tc_type *p4type_find_byname(const char *name)
+{
+	unsigned long tmp, typeid;
+	struct p4tc_type *type;
+
+	idr_for_each_entry_ul(&p4tc_types_idr, type, tmp, typeid) {
+		if (!strncmp(type->name, name, P4TC_T_MAX_STR_SZ))
+			return type;
+	}
+
+	return NULL;
+}
+
+static bool p4tc_is_type_unsigned_be(int typeid)
+{
+	switch (typeid) {
+	case P4TC_T_BE16:
+	case P4TC_T_BE32:
+	case P4TC_T_BE64:
+		return true;
+	default:
+		return false;
+	}
+}
+
+bool p4tc_is_type_unsigned_he(int typeid)
+{
+	switch (typeid) {
+	case P4TC_T_U8:
+	case P4TC_T_U16:
+	case P4TC_T_U32:
+	case P4TC_T_U64:
+	case P4TC_T_U128:
+	case P4TC_T_BOOL:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool p4tc_is_type_unsigned(int typeid)
+{
+	return p4tc_is_type_unsigned_he(typeid) ||
+		p4tc_is_type_unsigned_be(typeid);
+}
+
+static bool p4tc_is_type_signed(int typeid)
+{
+	switch (typeid) {
+	case P4TC_T_S8:
+	case P4TC_T_S16:
+	case P4TC_T_S32:
+	case P4TC_T_S64:
+	case P4TC_T_S128:
+		return true;
+	default:
+		return false;
+	}
+}
+
+bool p4tc_is_type_numeric(int typeid)
+{
+	return p4tc_is_type_unsigned(typeid) ||
+		p4tc_is_type_signed(typeid);
+}
+
+void p4t_copy(struct p4tc_type_mask_shift *dst_mask_shift,
+	      struct p4tc_type *dst_t, void *dstv,
+	      struct p4tc_type_mask_shift *src_mask_shift,
+	      struct p4tc_type *src_t, void *srcv)
+{
+	u64 readval[BITS_TO_U64(P4TC_MAX_KEYSZ)] = {0};
+	const struct p4tc_type_ops *srco, *dsto;
+
+	dsto = dst_t->ops;
+	srco = src_t->ops;
+
+	__p4tc_type_host_read(srco, src_t, src_mask_shift, srcv,
+			      &readval);
+	__p4tc_type_host_write(dsto, dst_t, dst_mask_shift, &readval,
+			       dstv);
+}
+
+int p4t_cmp(struct p4tc_type_mask_shift *dst_mask_shift,
+	    struct p4tc_type *dst_t, void *dstv,
+	    struct p4tc_type_mask_shift *src_mask_shift,
+	    struct p4tc_type *src_t, void *srcv)
+{
+	u64 a[BITS_TO_U64(P4TC_MAX_KEYSZ)] = {0};
+	u64 b[BITS_TO_U64(P4TC_MAX_KEYSZ)] = {0};
+	const struct p4tc_type_ops *srco, *dsto;
+
+	dsto = dst_t->ops;
+	srco = src_t->ops;
+
+	__p4tc_type_host_read(dsto, dst_t, dst_mask_shift, dstv, a);
+	__p4tc_type_host_read(srco, src_t, src_mask_shift, srcv, b);
+
+	return memcmp(a, b, sizeof(a));
+}
+
+void p4t_release(struct p4tc_type_mask_shift *mask_shift)
+{
+	kfree(mask_shift->mask);
+	kfree(mask_shift);
+}
+
+static int p4t_validate_bitpos(u16 bitstart, u16 bitend, u16 maxbitstart,
+			       u16 maxbitend, struct netlink_ext_ack *extack)
+{
+	if (bitstart > maxbitstart) {
+		NL_SET_ERR_MSG_MOD(extack, "bitstart too high");
+		return -EINVAL;
+	}
+
+	if (bitend > maxbitend) {
+		NL_SET_ERR_MSG_MOD(extack, "bitend too high");
+		return -EINVAL;
+	}
+
+	if (bitstart > bitend) {
+		NL_SET_ERR_MSG_MOD(extack, "bitstart > bitend");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int p4t_validate_bitpos_signed(u16 bitstart, u16 bitend, u16 maxbitend,
+				      struct netlink_ext_ack *extack)
+{
+	if (bitstart != 0 || bitend != maxbitend) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Bit slices are not allowed for signed integers");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int p4t_u32_validate(struct p4tc_type *container, void *value,
+			    u16 bitstart, u16 bitend,
+			    struct netlink_ext_ack *extack)
+{
+	u32 container_maxsz = U32_MAX;
+	u32 *val = value;
+	size_t maxval;
+	int ret;
+
+	ret = p4t_validate_bitpos(bitstart, bitend, 31, 31, extack);
+	if (ret < 0)
+		return ret;
+
+	maxval = GENMASK(bitend, 0);
+	if (val && (*val > container_maxsz || *val > maxval)) {
+		NL_SET_ERR_MSG_MOD(extack, "U32 value out of range");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static struct p4tc_type_mask_shift *
+p4t_u32_bitops(u16 bitsiz, u16 bitstart, u16 bitend,
+	       struct netlink_ext_ack *extack)
+{
+	struct p4tc_type_mask_shift *mask_shift;
+	u32 mask = GENMASK(bitend, bitstart);
+	u32 *cmask;
+
+	mask_shift = kzalloc(sizeof(*mask_shift), GFP_KERNEL_ACCOUNT);
+	if (!mask_shift)
+		return ERR_PTR(-ENOMEM);
+
+	cmask = kzalloc(sizeof(u32), GFP_KERNEL_ACCOUNT);
+	if (!cmask) {
+		kfree(mask_shift);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	*cmask = mask;
+
+	mask_shift->mask = cmask;
+	mask_shift->shift = bitstart;
+
+	return mask_shift;
+}
+
+static void p4t_u32_write(struct p4tc_type *container,
+			  struct p4tc_type_mask_shift *mask_shift, void *sval,
+			  void *dval)
+{
+	u32 maskedst = 0;
+	u32 *dst = dval;
+	u32 *src = sval;
+	u8 shift = 0;
+
+	if (mask_shift) {
+		u32 *dmask = mask_shift->mask;
+
+		maskedst = *dst & ~*dmask;
+		shift = mask_shift->shift;
+	}
+
+	*dst = maskedst | (*src << shift);
+}
+
+static void p4t_u32_hread(struct p4tc_type *container,
+			  struct p4tc_type_mask_shift *mask_shift, void *sval,
+			  void *dval)
+{
+	u32 *dst = dval;
+	u32 *src = sval;
+
+	if (mask_shift) {
+		u32 *smask = mask_shift->mask;
+		u8 shift = mask_shift->shift;
+
+		*dst = (*src & *smask) >> shift;
+	} else {
+		*dst = *src;
+	}
+}
+
+static int p4t_s32_validate(struct p4tc_type *container, void *value,
+			    u16 bitstart, u16 bitend,
+			    struct netlink_ext_ack *extack)
+{
+	return p4t_validate_bitpos_signed(bitstart, bitend, 31, extack);
+}
+
+static void p4t_s32_hread(struct p4tc_type *container,
+			  struct p4tc_type_mask_shift *mask_shift, void *sval,
+			  void *dval)
+{
+	s32 *dst = dval;
+	s32 *src = sval;
+
+	*dst = *src;
+}
+
+static void p4t_s32_write(struct p4tc_type *container,
+			  struct p4tc_type_mask_shift *mask_shift, void *sval,
+			  void *dval)
+{
+	s32 *dst = dval;
+	s32 *src = sval;
+
+	*dst = *src;
+}
+
+static int p4t_s64_validate(struct p4tc_type *container, void *value,
+			    u16 bitstart, u16 bitend,
+			    struct netlink_ext_ack *extack)
+{
+	return p4t_validate_bitpos_signed(bitstart, bitend, 63, extack);
+}
+
+static void p4t_s64_hread(struct p4tc_type *container,
+			  struct p4tc_type_mask_shift *mask_shift, void *sval,
+			  void *dval)
+{
+	s64 *dst = dval;
+	s64 *src = sval;
+
+	*dst = *src;
+}
+
+static void p4t_s64_write(struct p4tc_type *container,
+			  struct p4tc_type_mask_shift *mask_shift, void *sval,
+			  void *dval)
+{
+	s64 *dst = dval;
+	s64 *src = sval;
+
+	*dst = *src;
+}
+
+static int p4t_be32_validate(struct p4tc_type *container, void *value,
+			     u16 bitstart, u16 bitend,
+			     struct netlink_ext_ack *extack)
+{
+	__be32 *val_u32 = value;
+	__u32 val = 0;
+	size_t maxval;
+	int ret;
+
+	ret = p4t_validate_bitpos(bitstart, bitend, 31, 31, extack);
+	if (ret < 0)
+		return ret;
+
+	if (value)
+		val = be32_to_cpu(*val_u32);
+
+	maxval = GENMASK(bitend, 0);
+	if (val && val > maxval) {
+		NL_SET_ERR_MSG_FMT_MOD(extack,
+				       "BE32 value %u out of range: (0 - %zu)",
+				       val, maxval);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void p4t_be32_hread(struct p4tc_type *container,
+			   struct p4tc_type_mask_shift *mask_shift, void *sval,
+			   void *dval)
+{
+	__be32 *src = sval;
+	u32 *dst = dval;
+
+	*dst = be32_to_cpu(*src);
+}
+
+static void p4t_be32_write(struct p4tc_type *container,
+			   struct p4tc_type_mask_shift *mask_shift, void *sval,
+			   void *dval)
+{
+	__be32 *dst = dval;
+	u32 *src = sval;
+
+	*dst = cpu_to_be32(*src);
+}
+
+static void p4t_be64_hread(struct p4tc_type *container,
+			   struct p4tc_type_mask_shift *mask_shift, void *sval,
+			   void *dval)
+{
+	__be64 *src = sval;
+	u64 *dst = dval;
+
+	*dst = be64_to_cpu(*src);
+}
+
+static void p4t_be64_write(struct p4tc_type *container,
+			   struct p4tc_type_mask_shift *mask_shift, void *sval,
+			   void *dval)
+{
+	__be64 *dst = dval;
+	u64 *src = sval;
+
+	*dst = cpu_to_be64(*src);
+}
+
+static int p4t_u16_validate(struct p4tc_type *container, void *value,
+			    u16 bitstart, u16 bitend,
+			    struct netlink_ext_ack *extack)
+{
+	u16 *val = value;
+	u16 maxval;
+	int ret;
+
+	ret = p4t_validate_bitpos(bitstart, bitend, 15, 15, extack);
+	if (ret < 0)
+		return ret;
+
+	maxval = GENMASK(bitend, 0);
+	if (val && *val > maxval) {
+		NL_SET_ERR_MSG_FMT_MOD(extack,
+				       "U16 value %u out of range: (0 - %u)",
+				       *val, maxval);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static struct p4tc_type_mask_shift *
+p4t_u16_bitops(u16 bitsiz, u16 bitstart, u16 bitend,
+	       struct netlink_ext_ack *extack)
+{
+	struct p4tc_type_mask_shift *mask_shift;
+	u16 mask = GENMASK(bitend, bitstart);
+	u16 *cmask;
+
+	mask_shift = kzalloc(sizeof(*mask_shift), GFP_KERNEL_ACCOUNT);
+	if (!mask_shift)
+		return ERR_PTR(-ENOMEM);
+
+	cmask = kzalloc(sizeof(u16), GFP_KERNEL_ACCOUNT);
+	if (!cmask) {
+		kfree(mask_shift);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	*cmask = mask;
+
+	mask_shift->mask = cmask;
+	mask_shift->shift = bitstart;
+
+	return mask_shift;
+}
+
+static void p4t_u16_write(struct p4tc_type *container,
+			  struct p4tc_type_mask_shift *mask_shift, void *sval,
+			  void *dval)
+{
+	u16 maskedst = 0;
+	u16 *dst = dval;
+	u16 *src = sval;
+	u8 shift = 0;
+
+	if (mask_shift) {
+		u16 *dmask = mask_shift->mask;
+
+		maskedst = *dst & ~*dmask;
+		shift = mask_shift->shift;
+	}
+
+	*dst = maskedst | (*src << shift);
+}
+
+static void p4t_u16_hread(struct p4tc_type *container,
+			  struct p4tc_type_mask_shift *mask_shift, void *sval,
+			  void *dval)
+{
+	u16 *dst = dval;
+	u16 *src = sval;
+
+	if (mask_shift) {
+		u16 *smask = mask_shift->mask;
+		u8 shift = mask_shift->shift;
+
+		*dst = (*src & *smask) >> shift;
+	} else {
+		*dst = *src;
+	}
+}
+
+static int p4t_s16_validate(struct p4tc_type *container, void *value,
+			    u16 bitstart, u16 bitend,
+			    struct netlink_ext_ack *extack)
+{
+	return p4t_validate_bitpos_signed(bitstart, bitend, 15, extack);
+}
+
+static void p4t_s16_hread(struct p4tc_type *container,
+			  struct p4tc_type_mask_shift *mask_shift, void *sval,
+			  void *dval)
+{
+	s16 *dst = dval;
+	s16 *src = sval;
+
+	*dst = *src;
+}
+
+static void p4t_s16_write(struct p4tc_type *container,
+			  struct p4tc_type_mask_shift *mask_shift, void *sval,
+			  void *dval)
+{
+	s16 *dst = dval;
+	s16 *src = sval;
+
+	*src = *dst;
+}
+
+static int p4t_be16_validate(struct p4tc_type *container, void *value,
+			     u16 bitstart, u16 bitend,
+			     struct netlink_ext_ack *extack)
+{
+	__be16 *val_u16 = value;
+	size_t maxval;
+	u16 val = 0;
+	int ret;
+
+	ret = p4t_validate_bitpos(bitstart, bitend, 15, 15, extack);
+	if (ret < 0)
+		return ret;
+
+	if (value)
+		val = be16_to_cpu(*val_u16);
+
+	maxval = GENMASK(bitend, 0);
+	if (val && val > maxval) {
+		NL_SET_ERR_MSG_FMT_MOD(extack,
+				       "BE16 value %u out of range: (0 - %zu)",
+				       val, maxval);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void p4t_be16_hread(struct p4tc_type *container,
+			   struct p4tc_type_mask_shift *mask_shift, void *sval,
+			   void *dval)
+{
+	__be16 *src = sval;
+	u16 *dst = dval;
+
+	*dst = be16_to_cpu(*src);
+}
+
+static void p4t_be16_write(struct p4tc_type *container,
+			   struct p4tc_type_mask_shift *mask_shift, void *sval,
+			   void *dval)
+{
+	__be16 *dst = dval;
+	u16 *src = sval;
+
+	*dst = cpu_to_be16(*src);
+}
+
+static int p4t_u8_validate(struct p4tc_type *container, void *value,
+			   u16 bitstart, u16 bitend,
+			   struct netlink_ext_ack *extack)
+{
+	u8 *val = value;
+	u8 maxval;
+	int ret;
+
+	ret = p4t_validate_bitpos(bitstart, bitend, 7, 7, extack);
+	if (ret < 0)
+		return ret;
+
+	maxval = GENMASK(bitend, 0);
+	if (val && *val > maxval) {
+		NL_SET_ERR_MSG_FMT_MOD(extack,
+				       "U8 value %u out of range (0 - %u)",
+				       *val, maxval);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static struct p4tc_type_mask_shift *
+p4t_u8_bitops(u16 bitsiz, u16 bitstart, u16 bitend,
+	      struct netlink_ext_ack *extack)
+{
+	struct p4tc_type_mask_shift *mask_shift;
+	u8 mask = GENMASK(bitend, bitstart);
+	u8 *cmask;
+
+	mask_shift = kzalloc(sizeof(*mask_shift), GFP_KERNEL_ACCOUNT);
+	if (!mask_shift)
+		return ERR_PTR(-ENOMEM);
+
+	cmask = kzalloc(sizeof(u8), GFP_KERNEL_ACCOUNT);
+	if (!cmask) {
+		kfree(mask_shift);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	*cmask = mask;
+
+	mask_shift->mask = cmask;
+	mask_shift->shift = bitstart;
+
+	return mask_shift;
+}
+
+static void p4t_u8_write(struct p4tc_type *container,
+			 struct p4tc_type_mask_shift *mask_shift, void *sval,
+			 void *dval)
+{
+	u8 maskedst = 0;
+	u8 *dst = dval;
+	u8 *src = sval;
+	u8 shift = 0;
+
+	if (mask_shift) {
+		u8 *dmask = (u8 *)mask_shift->mask;
+
+		maskedst = *dst & ~*dmask;
+		shift = mask_shift->shift;
+	}
+
+	*dst = maskedst | (*src << shift);
+}
+
+static void p4t_u8_hread(struct p4tc_type *container,
+			 struct p4tc_type_mask_shift *mask_shift, void *sval,
+			 void *dval)
+{
+	u8 *dst = dval;
+	u8 *src = sval;
+
+	if (mask_shift) {
+		u8 *smask = mask_shift->mask;
+		u8 shift = mask_shift->shift;
+
+		*dst = (*src & *smask) >> shift;
+	} else {
+		*dst = *src;
+	}
+}
+
+static int p4t_s8_validate(struct p4tc_type *container, void *value,
+			   u16 bitstart, u16 bitend,
+			   struct netlink_ext_ack *extack)
+{
+	return p4t_validate_bitpos_signed(bitstart, bitend, 7, extack);
+}
+
+static void p4t_s8_hread(struct p4tc_type *container,
+			 struct p4tc_type_mask_shift *mask_shift, void *sval,
+			 void *dval)
+{
+	s8 *dst = dval;
+	s8 *src = sval;
+
+	*dst = *src;
+}
+
+static void p4t_s8_write(struct p4tc_type *container,
+			 struct p4tc_type_mask_shift *mask_shift, void *sval,
+			 void *dval)
+{
+	s8 *dst = dval;
+	s8 *src = sval;
+
+	*dst = *src;
+}
+
+static int p4t_u64_validate(struct p4tc_type *container, void *value,
+			    u16 bitstart, u16 bitend,
+			    struct netlink_ext_ack *extack)
+{
+	u64 *val = value;
+	u64 maxval;
+	int ret;
+
+	ret = p4t_validate_bitpos(bitstart, bitend, 63, 63, extack);
+	if (ret < 0)
+		return ret;
+
+	maxval = GENMASK_ULL(bitend, 0);
+	if (val && *val > maxval) {
+		NL_SET_ERR_MSG_FMT_MOD(extack,
+				       "U64 value %llu out of range: (0 - %llu)",
+				       *val, maxval);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static struct p4tc_type_mask_shift *
+p4t_u64_bitops(u16 bitsiz, u16 bitstart, u16 bitend,
+	       struct netlink_ext_ack *extack)
+{
+	struct p4tc_type_mask_shift *mask_shift;
+	u64 mask = GENMASK(bitend, bitstart);
+	u64 *cmask;
+
+	mask_shift = kzalloc(sizeof(*mask_shift), GFP_KERNEL_ACCOUNT);
+	if (!mask_shift)
+		return ERR_PTR(-ENOMEM);
+
+	cmask = kzalloc(sizeof(u64), GFP_KERNEL_ACCOUNT);
+	if (!cmask) {
+		kfree(mask_shift);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	*cmask = mask;
+
+	mask_shift->mask = cmask;
+	mask_shift->shift = bitstart;
+
+	return mask_shift;
+}
+
+static void p4t_u64_write(struct p4tc_type *container,
+			  struct p4tc_type_mask_shift *mask_shift, void *sval,
+			  void *dval)
+{
+	u64 maskedst = 0;
+	u64 *dst = dval;
+	u64 *src = sval;
+	u8 shift = 0;
+
+	if (mask_shift) {
+		u64 *dmask = (u64 *)mask_shift->mask;
+
+		maskedst = *dst & ~*dmask;
+		shift = mask_shift->shift;
+	}
+
+	*dst = maskedst | (*src << shift);
+}
+
+static void p4t_u64_hread(struct p4tc_type *container,
+			  struct p4tc_type_mask_shift *mask_shift, void *sval,
+			  void *dval)
+{
+	u64 *dst = dval;
+	u64 *src = sval;
+
+	if (mask_shift) {
+		u64 *smask = mask_shift->mask;
+		u8 shift = mask_shift->shift;
+
+		*dst = (*src & *smask) >> shift;
+	} else {
+		*dst = *src;
+	}
+}
+
+/* As of now, we are not allowing bitops for u128 */
+static int p4t_u128_validate(struct p4tc_type *container, void *value,
+			     u16 bitstart, u16 bitend,
+			     struct netlink_ext_ack *extack)
+{
+	if (bitstart != 0 || bitend != 127) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Only valid bit type larger than bit64 is bit128");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void p4t_u128_hread(struct p4tc_type *container,
+			   struct p4tc_type_mask_shift *mask_shift, void *sval,
+			   void *dval)
+{
+	memcpy(sval, dval, sizeof(__u64) * 2);
+}
+
+static void p4t_u128_write(struct p4tc_type *container,
+			   struct p4tc_type_mask_shift *mask_shift, void *sval,
+			   void *dval)
+{
+	memcpy(sval, dval, sizeof(__u64) * 2);
+}
+
+static int p4t_s128_validate(struct p4tc_type *container, void *value,
+			     u16 bitstart, u16 bitend,
+			     struct netlink_ext_ack *extack)
+{
+	return p4t_validate_bitpos_signed(bitstart, bitend, 127, extack);
+}
+
+static void p4t_s128_hread(struct p4tc_type *container,
+			   struct p4tc_type_mask_shift *mask_shift, void *sval,
+			   void *dval)
+{
+	memcpy(sval, dval, sizeof(__u64) * 2);
+}
+
+static void p4t_s128_write(struct p4tc_type *container,
+			   struct p4tc_type_mask_shift *mask_shift, void *sval,
+			   void *dval)
+{
+	memcpy(sval, dval, sizeof(__u64) * 2);
+}
+
+static int p4t_string_validate(struct p4tc_type *container, void *value,
+			       u16 bitstart, u16 bitend,
+			       struct netlink_ext_ack *extack)
+{
+	if (bitstart != 0 || bitend >= P4TC_T_MAX_STR_SZ) {
+		NL_SET_ERR_MSG_FMT_MOD(extack,
+				       "String size must be at most %u\n",
+				       P4TC_T_MAX_STR_SZ);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void p4t_string_hread(struct p4tc_type *container,
+			     struct p4tc_type_mask_shift *mask_shift,
+			     void *sval, void *dval)
+{
+	strscpy(sval, dval, P4TC_T_MAX_STR_SZ);
+}
+
+static void p4t_string_write(struct p4tc_type *container,
+			     struct p4tc_type_mask_shift *mask_shift,
+			     void *sval, void *dval)
+{
+	strscpy(sval, dval, P4TC_T_MAX_STR_SZ);
+}
+
+static int p4t_ipv4_validate(struct p4tc_type *container, void *value,
+			     u16 bitstart, u16 bitend,
+			     struct netlink_ext_ack *extack)
+{
+	/* Not allowing bit-slices for now */
+	if (bitstart != 0 || bitend != 31) {
+		NL_SET_ERR_MSG_MOD(extack, "Invalid bitstart or bitend");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int p4t_mac_validate(struct p4tc_type *container, void *value,
+			    u16 bitstart, u16 bitend,
+			    struct netlink_ext_ack *extack)
+{
+	if (bitstart != 0 || bitend != 47) {
+		NL_SET_ERR_MSG_MOD(extack, "Invalid bitstart or bitend");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int p4t_dev_validate(struct p4tc_type *container, void *value,
+			    u16 bitstart, u16 bitend,
+			    struct netlink_ext_ack *extack)
+{
+	if (bitstart != 0 || bitend != 31) {
+		NL_SET_ERR_MSG_MOD(extack, "Invalid start or endbit values");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void p4t_dev_write(struct p4tc_type *container,
+			  struct p4tc_type_mask_shift *mask_shift, void *sval,
+			  void *dval)
+{
+	u32 *src = sval;
+	u32 *dst = dval;
+
+	*dst = *src;
+}
+
+static void p4t_dev_hread(struct p4tc_type *container,
+			  struct p4tc_type_mask_shift *mask_shift, void *sval,
+			  void *dval)
+{
+	u32 *src = sval;
+	u32 *dst = dval;
+
+	*dst = *src;
+}
+
+static void p4t_key_hread(struct p4tc_type *container,
+			  struct p4tc_type_mask_shift *mask_shift, void *sval,
+			  void *dval)
+{
+	memcpy(dval, sval, BITS_TO_BYTES(container->bitsz));
+}
+
+static void p4t_key_write(struct p4tc_type *container,
+			  struct p4tc_type_mask_shift *mask_shift, void *sval,
+			  void *dval)
+{
+	memcpy(dval, sval, BITS_TO_BYTES(container->bitsz));
+}
+
+static int p4t_key_validate(struct p4tc_type *container, void *value,
+			    u16 bitstart, u16 bitend,
+			    struct netlink_ext_ack *extack)
+{
+	if (p4t_validate_bitpos(bitstart, bitend, 0, P4TC_MAX_KEYSZ, extack))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int p4t_bool_validate(struct p4tc_type *container, void *value,
+			     u16 bitstart, u16 bitend,
+			     struct netlink_ext_ack *extack)
+{
+	int ret;
+
+	ret = p4t_validate_bitpos(bitstart, bitend, 7, 7, extack);
+	if (ret < 0)
+		return ret;
+
+	return -EINVAL;
+}
+
+static void p4t_bool_hread(struct p4tc_type *container,
+			   struct p4tc_type_mask_shift *mask_shift, void *sval,
+			   void *dval)
+{
+	bool *dst = dval;
+	bool *src = sval;
+
+	*dst = *src;
+}
+
+static void p4t_bool_write(struct p4tc_type *container,
+			   struct p4tc_type_mask_shift *mask_shift, void *sval,
+			   void *dval)
+{
+	bool *dst = dval;
+	bool *src = sval;
+
+	*dst = *src;
+}
+
+static const struct p4tc_type_ops u8_ops = {
+	.validate_p4t = p4t_u8_validate,
+	.create_bitops = p4t_u8_bitops,
+	.host_read = p4t_u8_hread,
+	.host_write = p4t_u8_write,
+};
+
+static const struct p4tc_type_ops u16_ops = {
+	.validate_p4t = p4t_u16_validate,
+	.create_bitops = p4t_u16_bitops,
+	.host_read = p4t_u16_hread,
+	.host_write = p4t_u16_write,
+};
+
+static const struct p4tc_type_ops u32_ops = {
+	.validate_p4t = p4t_u32_validate,
+	.create_bitops = p4t_u32_bitops,
+	.host_read = p4t_u32_hread,
+	.host_write = p4t_u32_write,
+};
+
+static const struct p4tc_type_ops u64_ops = {
+	.validate_p4t = p4t_u64_validate,
+	.create_bitops = p4t_u64_bitops,
+	.host_read = p4t_u64_hread,
+	.host_write = p4t_u64_write,
+};
+
+static const struct p4tc_type_ops u128_ops = {
+	.validate_p4t = p4t_u128_validate,
+	.host_read = p4t_u128_hread,
+	.host_write = p4t_u128_write,
+};
+
+static const struct p4tc_type_ops s8_ops = {
+	.validate_p4t = p4t_s8_validate,
+	.host_read = p4t_s8_hread,
+	.host_write = p4t_s8_write,
+};
+
+static const struct p4tc_type_ops s16_ops = {
+	.validate_p4t = p4t_s16_validate,
+	.host_read = p4t_s16_hread,
+	.host_write = p4t_s16_write,
+};
+
+static const struct p4tc_type_ops s32_ops = {
+	.validate_p4t = p4t_s32_validate,
+	.host_read = p4t_s32_hread,
+	.host_write = p4t_s32_write,
+};
+
+static const struct p4tc_type_ops s64_ops = {
+	.validate_p4t = p4t_s64_validate,
+	.host_read = p4t_s64_hread,
+	.host_write = p4t_s64_write,
+};
+
+static const struct p4tc_type_ops s128_ops = {
+	.validate_p4t = p4t_s128_validate,
+	.host_read = p4t_s128_hread,
+	.host_write = p4t_s128_write,
+};
+
+static const struct p4tc_type_ops be16_ops = {
+	.validate_p4t = p4t_be16_validate,
+	.create_bitops = p4t_u16_bitops,
+	.host_read = p4t_be16_hread,
+	.host_write = p4t_be16_write,
+};
+
+static const struct p4tc_type_ops be32_ops = {
+	.validate_p4t = p4t_be32_validate,
+	.create_bitops = p4t_u32_bitops,
+	.host_read = p4t_be32_hread,
+	.host_write = p4t_be32_write,
+};
+
+static const struct p4tc_type_ops be64_ops = {
+	.validate_p4t = p4t_u64_validate,
+	.host_read = p4t_be64_hread,
+	.host_write = p4t_be64_write,
+};
+
+static const struct p4tc_type_ops string_ops = {
+	.validate_p4t = p4t_string_validate,
+	.host_read = p4t_string_hread,
+	.host_write = p4t_string_write,
+};
+
+static const struct p4tc_type_ops mac_ops = {
+	.validate_p4t = p4t_mac_validate,
+	.create_bitops = p4t_u64_bitops,
+	.host_read = p4t_u64_hread,
+	.host_write = p4t_u64_write,
+};
+
+static const struct p4tc_type_ops ipv4_ops = {
+	.validate_p4t = p4t_ipv4_validate,
+	.host_read = p4t_be32_hread,
+	.host_write = p4t_be32_write,
+};
+
+static const struct p4tc_type_ops bool_ops = {
+	.validate_p4t = p4t_bool_validate,
+	.host_read = p4t_bool_hread,
+	.host_write = p4t_bool_write,
+};
+
+static const struct p4tc_type_ops dev_ops = {
+	.validate_p4t = p4t_dev_validate,
+	.host_read = p4t_dev_hread,
+	.host_write = p4t_dev_write,
+};
+
+static const struct p4tc_type_ops key_ops = {
+	.validate_p4t = p4t_key_validate,
+	.host_read = p4t_key_hread,
+	.host_write = p4t_key_write,
+};
+
+#ifdef CONFIG_RETPOLINE
+void __p4tc_type_host_read(const struct p4tc_type_ops *ops,
+			   struct p4tc_type *container,
+			   struct p4tc_type_mask_shift *mask_shift, void *sval,
+			   void *dval)
+{
+	#define HREAD(cops) \
+	do { \
+		if (ops == &(cops)) \
+			return (cops).host_read(container, mask_shift, sval, \
+						dval); \
+	} while (0)
+
+	HREAD(u8_ops);
+	HREAD(u16_ops);
+	HREAD(u32_ops);
+	HREAD(u64_ops);
+	HREAD(u128_ops);
+	HREAD(s8_ops);
+	HREAD(s16_ops);
+	HREAD(s32_ops);
+	HREAD(be16_ops);
+	HREAD(be32_ops);
+	HREAD(mac_ops);
+	HREAD(ipv4_ops);
+	HREAD(bool_ops);
+	HREAD(dev_ops);
+	HREAD(key_ops);
+
+#undef HREAD
+
+	return ops->host_read(container, mask_shift, sval, dval);
+}
+
+void __p4tc_type_host_write(const struct p4tc_type_ops *ops,
+			    struct p4tc_type *container,
+			    struct p4tc_type_mask_shift *mask_shift, void *sval,
+			    void *dval)
+{
+	#define HWRITE(cops) \
+	do { \
+		if (ops == &(cops)) \
+			return (cops).host_write(container, mask_shift, sval, \
+						 dval); \
+	} while (0)
+
+	HWRITE(u8_ops);
+	HWRITE(u16_ops);
+	HWRITE(u32_ops);
+	HWRITE(u64_ops);
+	HWRITE(u128_ops);
+	HWRITE(s16_ops);
+	HWRITE(s32_ops);
+	HWRITE(be16_ops);
+	HWRITE(be32_ops);
+	HWRITE(mac_ops);
+	HWRITE(ipv4_ops);
+	HWRITE(bool_ops);
+	HWRITE(dev_ops);
+	HWRITE(key_ops);
+
+#undef HWRITE
+
+	return ops->host_write(container, mask_shift, sval, dval);
+}
+#endif
+
+static int ___p4tc_register_type(int typeid, size_t bitsz,
+				 size_t container_bitsz,
+				 const char *t_name,
+				 const struct p4tc_type_ops *ops)
+{
+	struct p4tc_type *type;
+	int err;
+
+	if (typeid > P4TC_T_MAX)
+		return -EINVAL;
+
+	if (p4type_find_byid(typeid) || p4type_find_byname(t_name))
+		return -EEXIST;
+
+	if (bitsz > P4TC_T_MAX_BITSZ)
+		return -E2BIG;
+
+	if (container_bitsz > P4TC_T_MAX_BITSZ)
+		return -E2BIG;
+
+	type = kzalloc(sizeof(*type), GFP_ATOMIC);
+	if (!type)
+		return -ENOMEM;
+
+	err = idr_alloc_u32(&p4tc_types_idr, type, &typeid, typeid, GFP_ATOMIC);
+	if (err < 0)
+		return err;
+
+	strscpy(type->name, t_name, P4TC_T_MAX_STR_SZ);
+	type->typeid = typeid;
+	type->bitsz = bitsz;
+	type->container_bitsz = container_bitsz;
+	type->ops = ops;
+
+	return 0;
+}
+
+static int __p4tc_register_type(int typeid, size_t bitsz,
+				size_t container_bitsz,
+				const char *t_name,
+				const struct p4tc_type_ops *ops)
+{
+	if (___p4tc_register_type(typeid, bitsz, container_bitsz, t_name, ops) <
+	    0) {
+		pr_err("Unable to allocate p4 type %s\n", t_name);
+		p4tc_types_put();
+		return -1;
+	}
+
+	return 0;
+}
+
+#define p4tc_register_type(...)                            \
+	do {                                               \
+		if (__p4tc_register_type(__VA_ARGS__) < 0) \
+			return -1;                         \
+	} while (0)
+
+int p4tc_register_types(void)
+{
+	p4tc_register_type(P4TC_T_U8, 8, 8, "u8", &u8_ops);
+	p4tc_register_type(P4TC_T_U16, 16, 16, "u16", &u16_ops);
+	p4tc_register_type(P4TC_T_U32, 32, 32, "u32", &u32_ops);
+	p4tc_register_type(P4TC_T_U64, 64, 64, "u64", &u64_ops);
+	p4tc_register_type(P4TC_T_U128, 128, 128, "u128", &u128_ops);
+	p4tc_register_type(P4TC_T_S8, 8, 8, "s8", &s8_ops);
+	p4tc_register_type(P4TC_T_BE16, 16, 16, "be16", &be16_ops);
+	p4tc_register_type(P4TC_T_BE32, 32, 32, "be32", &be32_ops);
+	p4tc_register_type(P4TC_T_BE64, 64, 64, "be64", &be64_ops);
+	p4tc_register_type(P4TC_T_S16, 16, 16, "s16", &s16_ops);
+	p4tc_register_type(P4TC_T_S32, 32, 32, "s32", &s32_ops);
+	p4tc_register_type(P4TC_T_S64, 64, 64, "s64", &s64_ops);
+	p4tc_register_type(P4TC_T_S128, 128, 128, "s128", &s128_ops);
+	p4tc_register_type(P4TC_T_STRING, P4TC_T_MAX_STR_SZ * 4,
+			   P4TC_T_MAX_STR_SZ * 4, "string", &string_ops);
+	p4tc_register_type(P4TC_T_MACADDR, 48, 64, "mac", &mac_ops);
+	p4tc_register_type(P4TC_T_IPV4ADDR, 32, 32, "ipv4", &ipv4_ops);
+	p4tc_register_type(P4TC_T_BOOL, 32, 32, "bool", &bool_ops);
+	p4tc_register_type(P4TC_T_DEV, 32, 32, "dev", &dev_ops);
+	p4tc_register_type(P4TC_T_KEY, P4TC_MAX_KEYSZ, P4TC_MAX_KEYSZ, "key",
+			   &key_ops);
+
+	return 0;
+}
+
+void p4tc_unregister_types(void)
+{
+	p4tc_types_put();
+}
-- 
2.34.1


