Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDB83FADCD
	for <lists+bpf@lfdr.de>; Sun, 29 Aug 2021 20:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235876AbhH2Sh2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 29 Aug 2021 14:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235821AbhH2ShZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 29 Aug 2021 14:37:25 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5670C061796
        for <bpf@vger.kernel.org>; Sun, 29 Aug 2021 11:36:32 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id q17so18242450edv.2
        for <bpf@vger.kernel.org>; Sun, 29 Aug 2021 11:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ubique-spb-ru.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lgPBX8DJcpzG1tNIR4pZXKeW3o+9OosjfV8Ncn2PRCA=;
        b=yBMcWkkURGU1+zM6TKPAId8lLIb7LvZXif5bChzOAuS6T4pz1q98iBg5gjWPpsdgUi
         KcbGIo3IzWliStRs0iqnUMOXHq3ZWAmrERvY1L0yXWWYPb4tQ/wiotbc7QNgnm0IHx5d
         1jvQcetfum8Fmahzw+Dz7yrYW7u/anj8TNWTibaNG+aG0iIfMSMpH6wcXp0U7TqqEH20
         oop4TlUh8ErCSt3sxSLiWER7Rx9lNvgTut0xW8Mu7pQFJmxsNuZ6ELkmOjCD0429+aBq
         YTy5aFOMjc6i/fUJ6NYGw9XlSTQ67AOSUGrWA10s8A0rm1CcozbKx/6rk+6udNBqFYxM
         /HAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lgPBX8DJcpzG1tNIR4pZXKeW3o+9OosjfV8Ncn2PRCA=;
        b=DDmuDFRJygtRz5/se1xjZj3g3pLzBOeQMs2jPnQlYtviMVIdGfaDPrWrs8sFWA35+D
         DCAXMxP2K3CjPbwTuR1pdHMsQWSPhV1dXxtgcz/N/qmKUztYq3y2Pb+SFyvP88JwQ5N3
         w5H3ofs7cOv1nnusyW6ctVqgfWvaYmRjn6U4gWtoI7MjOiGkjEmpjtmB84+hN1EbeGH7
         fwmek48B5zwXssWhpdSmwPp6VjieCtM29S04KBI/n3kWxIyIQ+WpP4E68vhzd0GXlOzH
         4W+WUiDVKJ+M8kPvx8GJquss/838Ri78ACv+lKIpNrJhcZwJ6fvJXsQ1h/MZkP1Ivy0Q
         QkmA==
X-Gm-Message-State: AOAM533YUoUexi8Zvgl2/YgsPe4p6PlzVR+5YHQZmJvpSGzEkGPzUH7c
        010dUH7liJR7ZBg40aDJyhm2TcnnLqZKzE08Rd4=
X-Google-Smtp-Source: ABdhPJzAmGn/fpoAPtln59mJMBHa9thCYwwpV1i3El6h9F4TmNFPSTUqMye7XLNBnk+iDj0w4nHNLg==
X-Received: by 2002:a05:6402:2792:: with SMTP id b18mr5445400ede.173.1630262191415;
        Sun, 29 Aug 2021 11:36:31 -0700 (PDT)
Received: from localhost ([154.21.15.43])
        by smtp.gmail.com with ESMTPSA id p8sm5710384ejo.2.2021.08.29.11.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Aug 2021 11:36:31 -0700 (PDT)
From:   Dmitrii Banshchikov <me@ubique.spb.ru>
To:     bpf@vger.kernel.org
Cc:     Dmitrii Banshchikov <me@ubique.spb.ru>, ast@kernel.org,
        davem@davemloft.net, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        netdev@vger.kernel.org, rdna@fb.com
Subject: [PATCH bpf-next v2 03/13] tools: Add bpfilter usermode helper header
Date:   Sun, 29 Aug 2021 22:35:58 +0400
Message-Id: <20210829183608.2297877-4-me@ubique.spb.ru>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210829183608.2297877-1-me@ubique.spb.ru>
References: <20210829183608.2297877-1-me@ubique.spb.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The header will be used in bpfilter usermode helper test infrastructure.

Signed-off-by: Dmitrii Banshchikov <me@ubique.spb.ru>
---
 tools/include/uapi/linux/bpfilter.h | 178 ++++++++++++++++++++++++++++
 1 file changed, 178 insertions(+)
 create mode 100644 tools/include/uapi/linux/bpfilter.h

diff --git a/tools/include/uapi/linux/bpfilter.h b/tools/include/uapi/linux/bpfilter.h
new file mode 100644
index 000000000000..31a24264c224
--- /dev/null
+++ b/tools/include/uapi/linux/bpfilter.h
@@ -0,0 +1,178 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI_LINUX_BPFILTER_H
+#define _UAPI_LINUX_BPFILTER_H
+
+#include <linux/if.h>
+#include <linux/const.h>
+
+#define BPFILTER_STANDARD_TARGET        ""
+#define BPFILTER_ERROR_TARGET           "ERROR"
+
+
+#define BPFILTER_ALIGN(__X) __ALIGN_KERNEL(__X, __alignof__(__u64))
+
+enum {
+	BPFILTER_IPT_SO_SET_REPLACE = 64,
+	BPFILTER_IPT_SO_SET_ADD_COUNTERS = 65,
+	BPFILTER_IPT_SET_MAX,
+};
+
+enum {
+	BPFILTER_IPT_SO_GET_INFO = 64,
+	BPFILTER_IPT_SO_GET_ENTRIES = 65,
+	BPFILTER_IPT_SO_GET_REVISION_MATCH = 66,
+	BPFILTER_IPT_SO_GET_REVISION_TARGET = 67,
+	BPFILTER_IPT_GET_MAX,
+};
+
+enum {
+	BPFILTER_XT_TABLE_MAXNAMELEN = 32,
+	BPFILTER_FUNCTION_MAXNAMELEN = 30,
+	BPFILTER_EXTENSION_MAXNAMELEN = 29,
+};
+
+enum {
+	BPFILTER_NF_DROP = 0,
+	BPFILTER_NF_ACCEPT = 1,
+	BPFILTER_NF_STOLEN = 2,
+	BPFILTER_NF_QUEUE = 3,
+	BPFILTER_NF_REPEAT = 4,
+	BPFILTER_NF_STOP = 5,
+	BPFILTER_NF_MAX_VERDICT = BPFILTER_NF_STOP,
+	BPFILTER_RETURN = (-BPFILTER_NF_REPEAT - 1),
+};
+
+enum {
+	BPFILTER_INET_HOOK_PRE_ROUTING = 0,
+	BPFILTER_INET_HOOK_LOCAL_IN = 1,
+	BPFILTER_INET_HOOK_FORWARD = 2,
+	BPFILTER_INET_HOOK_LOCAL_OUT = 3,
+	BPFILTER_INET_HOOK_POST_ROUTING = 4,
+	BPFILTER_INET_HOOK_MAX,
+};
+
+enum {
+	BPFILTER_IPT_F_MASK = 0x03,
+	BPFILTER_IPT_INV_MASK = 0x7f
+};
+
+struct bpfilter_ipt_match {
+	union {
+		struct {
+			__u16 match_size;
+			char name[BPFILTER_EXTENSION_MAXNAMELEN];
+			__u8 revision;
+		} user;
+		struct {
+			__u16 match_size;
+			void *match;
+		} kernel;
+		__u16 match_size;
+	} u;
+	unsigned char data[0];
+};
+
+struct bpfilter_ipt_target {
+	union {
+		struct {
+			__u16 target_size;
+			char name[BPFILTER_EXTENSION_MAXNAMELEN];
+			__u8 revision;
+		} user;
+		struct {
+			__u16 target_size;
+			void *target;
+		} kernel;
+		__u16 target_size;
+	} u;
+	unsigned char data[0];
+};
+
+struct bpfilter_ipt_standard_target {
+	struct bpfilter_ipt_target target;
+	int verdict;
+};
+
+struct bpfilter_ipt_error_target {
+	struct bpfilter_ipt_target target;
+	char error_name[BPFILTER_FUNCTION_MAXNAMELEN];
+};
+
+struct bpfilter_ipt_get_info {
+	char name[BPFILTER_XT_TABLE_MAXNAMELEN];
+	__u32 valid_hooks;
+	__u32 hook_entry[BPFILTER_INET_HOOK_MAX];
+	__u32 underflow[BPFILTER_INET_HOOK_MAX];
+	__u32 num_entries;
+	__u32 size;
+};
+
+struct bpfilter_ipt_counters {
+	__u64 packet_cnt;
+	__u64 byte_cnt;
+};
+
+struct bpfilter_ipt_counters_info {
+	char name[BPFILTER_XT_TABLE_MAXNAMELEN];
+	__u32 num_counters;
+	struct bpfilter_ipt_counters counters[0];
+};
+
+struct bpfilter_ipt_get_revision {
+	char name[BPFILTER_EXTENSION_MAXNAMELEN];
+	__u8 revision;
+};
+
+struct bpfilter_ipt_ip {
+	__u32 src;
+	__u32 dst;
+	__u32 src_mask;
+	__u32 dst_mask;
+	char in_iface[IFNAMSIZ];
+	char out_iface[IFNAMSIZ];
+	__u8 in_iface_mask[IFNAMSIZ];
+	__u8 out_iface_mask[IFNAMSIZ];
+	__u16 protocol;
+	__u8 flags;
+	__u8 invflags;
+};
+
+struct bpfilter_ipt_entry {
+	struct bpfilter_ipt_ip ip;
+	__u32 bfcache;
+	__u16 target_offset;
+	__u16 next_offset;
+	__u32 comefrom;
+	struct bpfilter_ipt_counters counters;
+	__u8 elems[0];
+};
+
+struct bpfilter_ipt_standard_entry {
+	struct bpfilter_ipt_entry entry;
+	struct bpfilter_ipt_standard_target target;
+};
+
+struct bpfilter_ipt_error_entry {
+	struct bpfilter_ipt_entry entry;
+	struct bpfilter_ipt_error_target target;
+};
+
+struct bpfilter_ipt_get_entries {
+	char name[BPFILTER_XT_TABLE_MAXNAMELEN];
+	__u32 size;
+	struct bpfilter_ipt_entry entries[0];
+};
+
+struct bpfilter_ipt_replace {
+	char name[BPFILTER_XT_TABLE_MAXNAMELEN];
+	__u32 valid_hooks;
+	__u32 num_entries;
+	__u32 size;
+	__u32 hook_entry[BPFILTER_INET_HOOK_MAX];
+	__u32 underflow[BPFILTER_INET_HOOK_MAX];
+	__u32 num_counters;
+	struct bpfilter_ipt_counters *cntrs;
+	struct bpfilter_ipt_entry entries[0];
+};
+
+#endif /* _UAPI_LINUX_BPFILTER_H */
-- 
2.25.1

