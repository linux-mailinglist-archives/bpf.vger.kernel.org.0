Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D32D5A8987
	for <lists+bpf@lfdr.de>; Thu,  1 Sep 2022 01:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbiHaXgb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 31 Aug 2022 19:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiHaXg2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 31 Aug 2022 19:36:28 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E448074CE3
        for <bpf@vger.kernel.org>; Wed, 31 Aug 2022 16:36:26 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-33dc390f26cso213093337b3.9
        for <bpf@vger.kernel.org>; Wed, 31 Aug 2022 16:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc;
        bh=VaByuzhJankFGZiQxtLDloOuxZ+4RAkEa0Hn8j+xjk4=;
        b=UmOFbboo0moRGuDzQYkEFke2q1Wq9cfhp7Ayj264uLzZl+VVc3Hf7I2IxsyTfqQuUy
         Jn+85JD6Eb+XHWG7fbcumTtkhT5BnKAVX+ASUItkizQUvtYyJCk2yOCfygEBSxhuhkmn
         kYzwmFlynfMdtAiof2/NSNOVBEIrMxnYxRC6ojFBuRnxzc5Auj+J2FDdZUVawMqg4EiT
         OcA167+26ozkOISbe2FwrKAbNmmwlV2ug2oGpE1i6Vf3uGOMvLhkHVq7bb5KPB3pIlrB
         BqLYHHjd/KpvyIlVdE56NG7bF9+Crlk0aX80L50C9fwLCyXdH9A8sMdD9HXIY1yWFPjh
         GA2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc;
        bh=VaByuzhJankFGZiQxtLDloOuxZ+4RAkEa0Hn8j+xjk4=;
        b=5vMd2CSRZrW+/V5wNSNUJIW2puDYt3G/uMq0xQrU+5yZFNPlNUIEQY8fFm8CPvV0kL
         JAXmt782+6ACTOYwsck4k7G2SM1WY0sLRuAs0bkmc+89IenrlrWxVstyEte5Xd/PMo+n
         GKPXanyiLWez7PMQD799VRAAWhE7jTj/r/Xi+/W/+MW0tOXy8iqGg5fgBFWysdLGXTMI
         7iNckeevao0A43nN1RYe/r+6fptcfaFOoSmAf+YgGdQlWUkUGwgSbroYg55GAjSdrCmd
         /Hi4n7qkW/BxJvNEBQMurf2gNgrTGwwqoejnV8P8NSaqEkK1g7RAnTUDKn1BwPiCVEVd
         TJww==
X-Gm-Message-State: ACgBeo0rksMgCvJo0XLbCxzfXcHwKVntKusX4LifoXV67/i12tm6/CAD
        5JD+AzIh3+13aGIx5x0Li+OcutXklVFWleuPE1Q6mJQDk98uE5otgJIWU45H7OCMuFKvzNVJ9vw
        z+uJfJjM5cKsZ9K/phS42uoE7JRxrY1N+87UMCLhmFSSavh67ARVnGcGql1rNEPgj6g==
X-Google-Smtp-Source: AA6agR7VVCnqelqBzzhfbUwS9Q0e4q7cHDOI6O/h6xYOuJ+1dsHQLHo/QPiVKcVensdA/2gLL3UB2iypEmvnmEI=
X-Received: from dolcetriade.mtv.corp.google.com ([2620:15c:124:202:4c0d:334b:3a5e:e46a])
 (user=harshmodi job=sendgmr) by 2002:a25:2c8:0:b0:695:feaa:871f with SMTP id
 191-20020a2502c8000000b00695feaa871fmr18127858ybc.471.1661988986149; Wed, 31
 Aug 2022 16:36:26 -0700 (PDT)
Date:   Wed, 31 Aug 2022 16:36:15 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220831233615.2288256-1-harshmodi@google.com>
Subject: [PATCH bpf-next] bpf: Add bpf_[skb|xdp]_packet_hash.
From:   Harsh Modi <harshmodi@google.com>
To:     bpf@vger.kernel.org
Cc:     harshmodi@google.com, sdf@google.com, ast@kernel.org,
        haoluo@google.com, joannelkoong@gmail.com, quentin@isovalent.com,
        joe@cilium.io
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

eBPF currently does not have a good way to support more advanced
checksums like crc32c checksums. A bpf helper that allows users
to hash packet data from eBPF will use this.

Currently, it only supports crc32c, however, additional support for
new hashes can be supported by adding an additional enum and
implementing the corresponding code in net/core/filter.c.

Signed-off-by: Harsh Modi <harshmodi@google.com>
---
 include/net/xdp.h                             |   3 +
 include/uapi/linux/bpf.h                      |  33 ++++
 net/core/filter.c                             | 100 +++++++++++
 net/core/xdp.c                                |  51 ++++++
 scripts/bpf_doc.py                            |   2 +
 tools/include/uapi/linux/bpf.h                |  33 ++++
 .../selftests/bpf/prog_tests/packet_hash.c    | 159 ++++++++++++++++++
 .../testing/selftests/bpf/progs/packet_hash.c | 125 ++++++++++++++
 8 files changed, 506 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/packet_hash.c
 create mode 100644 tools/testing/selftests/bpf/progs/packet_hash.c

diff --git a/include/net/xdp.h b/include/net/xdp.h
index 04c852c7a77f..cbfec47e391d 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -407,6 +407,9 @@ struct netdev_bpf;
 void xdp_attachment_setup(struct xdp_attachment_info *info,
 			  struct netdev_bpf *bpf);
 
+__wsum __xdp_checksum(struct xdp_buff *xdp, int offset, int len,
+		      __wsum csum, const struct skb_checksum_ops *ops);
+
 #define DEV_MAP_BULK_SIZE XDP_BULK_QUEUE_SIZE
 
 #endif /* __LINUX_NET_XDP_H__ */
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 962960a98835..c8313a13a948 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5386,6 +5386,25 @@ union bpf_attr {
  *	Return
  *		Current *ktime*.
  *
+ * int bpf_skb_packet_hash(struct sk_buff *skb, struct bpf_packet_hash_params *params, void *hash, u32 len)
+ *	Description
+ *		Hash the packet data based on the parameters set in *params*.
+ *		The hash will be set in *hash*. The value of *len* will be
+ *		dependent on the hash algorithm.
+ *		Currently only crc32c is supported.
+ *
+ *	Return
+ *		0 on success, or negative errno if there is an error.
+ *
+ * int bpf_xdp_packet_hash(struct xdp_buff *xdp, struct bpf_packet_hash_params *params, void *hash, u32 len)
+ *	Description
+ *		Hash the packet data based on the parameters set in *params*.
+ *		The hash will be set in *hash*. The value of *len* will be
+ *		dependent on the hash algorithm.
+ *		Currently only crc32c is supported.
+ *
+ *	Return
+ *		0 on success, or negative errno if there is an error.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5597,6 +5616,8 @@ union bpf_attr {
 	FN(tcp_raw_check_syncookie_ipv4),	\
 	FN(tcp_raw_check_syncookie_ipv6),	\
 	FN(ktime_get_tai_ns),		\
+	FN(skb_packet_hash),		\
+	FN(xdp_packet_hash),		\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
@@ -6920,4 +6941,16 @@ struct bpf_core_relo {
 	enum bpf_core_relo_kind kind;
 };
 
+enum bpf_hash {
+	BPF_HASH_UNSPEC = 0,
+	BPF_CRC32C,
+};
+
+struct bpf_packet_hash_params {
+	enum bpf_hash hash;
+	__u32 initial;
+	__u32 offset;
+	__u32 len;
+};
+
 #endif /* _UAPI__LINUX_BPF_H__ */
diff --git a/net/core/filter.c b/net/core/filter.c
index 63e25d8ce501..04dba97d8f1c 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -79,6 +79,8 @@
 #include <net/tls.h>
 #include <net/xdp.h>
 #include <net/mptcp.h>
+#include <linux/crc32c.h>
+#include <linux/crc32.h>
 
 static const struct bpf_func_proto *
 bpf_sk_base_func_proto(enum bpf_func_id func_id);
@@ -2079,6 +2081,63 @@ static const struct bpf_func_proto bpf_csum_level_proto = {
 	.arg2_type	= ARG_ANYTHING,
 };
 
+static inline __wsum crc32c_csum_update(const void *buff, int len, __wsum sum)
+{
+	/* This uses the crypto implementation of crc32c, which is either
+	 * implemented w/ hardware support or resolves to __crc32c_le().
+	 */
+	return (__force __wsum)crc32c((__force __u32)sum, buff, len);
+}
+
+static inline __wsum crc32c_csum_combine(__wsum csum, __wsum csum2, int offset, int len)
+{
+	return (__force __wsum)__crc32c_le_combine((__force __u32)csum,
+						   (__force __u32)csum2, len);
+}
+
+static const struct skb_checksum_ops crc32c_csum_ops = {
+	.update  = crc32c_csum_update,
+	.combine = crc32c_csum_combine,
+};
+
+BPF_CALL_4(bpf_skb_packet_hash, struct sk_buff*, skb, struct bpf_packet_hash_params*, params,
+	   void*, hash, __u32, len)
+{
+	if (unlikely(!params || !hash))
+		return -EINVAL;
+	if (unlikely(params->offset > 0xffff || params->len > 0xffff))
+		return -EFAULT;
+	if (unlikely(params->offset + params->len > skb->len))
+		return -ERANGE;
+	switch (params->hash) {
+	case BPF_CRC32C: {
+		__wsum crc;
+
+		if (len != 4)
+			return -EINVAL;
+
+		crc = __skb_checksum(skb, params->offset, params->len, params->initial,
+				     &crc32c_csum_ops);
+		*(__u32 *)hash = crc;
+		break;
+	}
+	default:
+		return -ENOTSUPP;
+	}
+	return 0;
+}
+
+static const struct bpf_func_proto bpf_skb_packet_hash_proto = {
+	.func		= bpf_skb_packet_hash,
+	.gpl_only	= true,
+	.pkt_access	= true,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_CTX,
+	.arg2_type	= ARG_PTR_TO_STACK,
+	.arg3_type	= ARG_PTR_TO_MEM,
+	.arg4_type	= ARG_CONST_SIZE,
+};
+
 static inline int __bpf_rx_skb(struct net_device *dev, struct sk_buff *skb)
 {
 	return dev_forward_skb_nomtu(dev, skb);
@@ -4102,6 +4161,43 @@ static const struct bpf_func_proto bpf_xdp_adjust_meta_proto = {
 	.arg2_type	= ARG_ANYTHING,
 };
 
+BPF_CALL_4(bpf_xdp_packet_hash, struct xdp_buff*, xdp, struct bpf_packet_hash_params*, params,
+	   void*, hash, __u32, len)
+{
+	if (unlikely(!params || !hash))
+		return -EINVAL;
+	if (unlikely(params->offset > 0xffff || params->len > 0xffff))
+		return -EFAULT;
+	if (unlikely(params->offset + params->len > xdp_get_buff_len(xdp)))
+		return -ERANGE;
+	switch (params->hash) {
+	case BPF_CRC32C: {
+		__wsum crc;
+
+		if (len != 4)
+			return -EINVAL;
+		crc = __xdp_checksum(xdp, params->offset, params->len, params->initial,
+				     &crc32c_csum_ops);
+		*(__u32 *)hash = crc;
+		break;
+	}
+	default:
+		return -ENOTSUPP;
+	}
+	return 0;
+}
+
+static const struct bpf_func_proto bpf_xdp_packet_hash_proto = {
+	.func		= bpf_xdp_packet_hash,
+	.gpl_only	= true,
+	.pkt_access	= true,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_CTX,
+	.arg2_type	= ARG_PTR_TO_STACK,
+	.arg3_type	= ARG_PTR_TO_MEM,
+	.arg4_type	= ARG_CONST_SIZE,
+};
+
 /* XDP_REDIRECT works by a three-step process, implemented in the functions
  * below:
  *
@@ -7843,6 +7939,8 @@ tc_cls_act_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_sk_storage_get_proto;
 	case BPF_FUNC_sk_storage_delete:
 		return &bpf_sk_storage_delete_proto;
+	case BPF_FUNC_skb_packet_hash:
+		return &bpf_skb_packet_hash_proto;
 #ifdef CONFIG_XFRM
 	case BPF_FUNC_skb_get_xfrm_state:
 		return &bpf_skb_get_xfrm_state_proto;
@@ -7926,6 +8024,8 @@ xdp_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_xdp_fib_lookup_proto;
 	case BPF_FUNC_check_mtu:
 		return &bpf_xdp_check_mtu_proto;
+	case BPF_FUNC_xdp_packet_hash:
+		return &bpf_xdp_packet_hash_proto;
 #ifdef CONFIG_INET
 	case BPF_FUNC_sk_lookup_udp:
 		return &bpf_xdp_sk_lookup_udp_proto;
diff --git a/net/core/xdp.c b/net/core/xdp.c
index 24420209bf0e..a7b4e3af3641 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -711,3 +711,54 @@ struct xdp_frame *xdpf_clone(struct xdp_frame *xdpf)
 
 	return nxdpf;
 }
+
+/* Checksum skb data. */
+__wsum __xdp_checksum(struct xdp_buff *xdp, int offset, int len,
+		      __wsum csum, const struct skb_checksum_ops *ops)
+{
+	skb_frag_t *next_frag, *end_frag;
+	struct skb_shared_info *sinfo;
+	int copy, pos = 0;
+	u8 *ptr_buf;
+	int ptr_len;
+
+	/* If offset + len is contained in the linear area, just checksum that */
+	if (likely(xdp->data_end - xdp->data >= offset + len)) {
+		csum = INDIRECT_CALL_1(ops->update, csum_partial_ext,
+				       xdp->data + offset, len, csum);
+		return csum;
+	}
+
+	/* Walk all the buffers and checksum them sequentially. */
+	sinfo = xdp_get_shared_info_from_buff(xdp);
+	end_frag = &sinfo->frags[sinfo->nr_frags];
+	next_frag = &sinfo->frags[0];
+
+	ptr_buf = xdp->data;
+	ptr_len = xdp->data_end - xdp->data;
+	copy = ptr_len;
+
+	while (len > 0) {
+		if (offset < ptr_len) {
+			__wsum csum2;
+
+			copy = min(len, ptr_len);
+			csum2 = INDIRECT_CALL_1(ops->update, csum_partial_ext,
+						ptr_buf + offset, copy, 0);
+			csum = INDIRECT_CALL_1(ops->combine, csum_block_add_ext,
+					       csum, csum2, pos, copy);
+			len -= copy;
+			pos += copy;
+		}
+		if (offset > 0)
+			offset -= copy;
+		ptr_buf = skb_frag_address(next_frag);
+		ptr_len = skb_frag_size(next_frag);
+		if (next_frag == end_frag)
+			break;
+		next_frag++;
+	}
+	WARN_ON(len);
+	return csum;
+}
+EXPORT_SYMBOL(__xdp_checksum);
diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
index d5c389df6045..c0aa87331d8e 100755
--- a/scripts/bpf_doc.py
+++ b/scripts/bpf_doc.py
@@ -640,6 +640,7 @@ class PrinterHelpers(Printer):
 
     type_fwds = [
             'struct bpf_fib_lookup',
+            'struct bpf_packet_hash_params',
             'struct bpf_sk_lookup',
             'struct bpf_perf_event_data',
             'struct bpf_perf_event_value',
@@ -697,6 +698,7 @@ class PrinterHelpers(Printer):
             '__wsum',
 
             'struct bpf_fib_lookup',
+            'struct bpf_packet_hash_params',
             'struct bpf_perf_event_data',
             'struct bpf_perf_event_value',
             'struct bpf_pidns_info',
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index f4ba82a1eace..5e53f6a57a24 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5386,6 +5386,25 @@ union bpf_attr {
  *	Return
  *		Current *ktime*.
  *
+ * int bpf_skb_packet_hash(struct sk_buff *skb, struct bpf_packet_hash_params *params, void *hash, u32 len)
+ *	Description
+ *		Hash the packet data based on the parameters set in *params*.
+ *		The hash will be set in *hash*. The value of *len* will be
+ *		dependent on the hash algorithm.
+ *		Currently only crc32c is supported.
+ *
+ *	Return
+ *		0 on success, or negative errno if there is an error.
+ *
+ * int bpf_xdp_packet_hash(struct xdp_buff *xdp, struct bpf_packet_hash_params *params, void *hash, u32 len)
+ *	Description
+ *		Hash the packet data based on the parameters set in *params*.
+ *		The hash will be set in *hash*. The value of *len* will be
+ *		dependent on the hash algorithm.
+ *		Currently only crc32c is supported.
+ *
+ *	Return
+ *		0 on success, or negative errno if there is an error.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5597,6 +5616,8 @@ union bpf_attr {
 	FN(tcp_raw_check_syncookie_ipv4),	\
 	FN(tcp_raw_check_syncookie_ipv6),	\
 	FN(ktime_get_tai_ns),		\
+	FN(skb_packet_hash),		\
+	FN(xdp_packet_hash),		\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
@@ -6920,4 +6941,16 @@ struct bpf_core_relo {
 	enum bpf_core_relo_kind kind;
 };
 
+enum bpf_hash {
+	BPF_HASH_UNSPEC = 0,
+	BPF_CRC32C,
+};
+
+struct bpf_packet_hash_params {
+	enum bpf_hash hash;
+	__u32 initial;	/* initial value of the hash */
+	__u32 offset;	/* packet offset */
+	__u32 len;	/* length of the packet to hash. */
+};
+
 #endif /* _UAPI__LINUX_BPF_H__ */
diff --git a/tools/testing/selftests/bpf/prog_tests/packet_hash.c b/tools/testing/selftests/bpf/prog_tests/packet_hash.c
new file mode 100644
index 000000000000..6ffef365a07f
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/packet_hash.c
@@ -0,0 +1,159 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include <network_helpers.h>
+#include <linux/pkt_cls.h>
+#include "packet_hash.skel.h"
+
+static unsigned int duration;
+
+static void test_xdp_crc32c(struct packet_hash *skel)
+{
+	char data[] = "abcdefg";
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.data_in = &data,
+		.data_size_in = sizeof(data)-1, /* omit trailing null char */
+		.data_out = &data,
+		.data_size_out = sizeof(data),
+		.repeat = 1,
+	);
+	int err;
+	__u32 csum;
+
+	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.xdp_hash), &topts);
+	duration = topts.duration;
+	if (CHECK(err || topts.retval != XDP_PASS, "bpf", "err %d errno %d retval %d\n",
+		  err, errno, topts.retval))
+		return;
+	csum = *(__u32 *)data;
+	ASSERT_EQ(csum, 0xE627F441, "csum");
+}
+
+static void test_xdp_crc32c_frags(struct packet_hash *skel)
+{
+	char *data = malloc(9000);
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.data_in = data,
+		.data_size_in = 9000,
+		.data_out = data,
+		.data_size_out = 9000,
+		.repeat = 1,
+	);
+	int err;
+	__u32 csum;
+
+	memset(data, 'a', 9000);
+	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.xdp_hash), &topts);
+	duration = topts.duration;
+	if (CHECK(err || topts.retval != XDP_PASS, "bpf", "err %d errno %d retval %d\n",
+		  err, errno, topts.retval))
+		goto out;
+	csum = *(__u32 *)data;
+	ASSERT_EQ(csum, 0xcb05ae48, "csum");
+out:
+	free(data);
+}
+
+#define ENOTSUPP	524
+static void test_xdp_crc32c_oob(struct packet_hash *skel)
+{
+	int rets[] = {EINVAL, ENOTSUPP, EFAULT, ERANGE, ERANGE};
+	int data[ARRAY_SIZE(rets)+1] = {0};
+	char buf[10] = {0};
+	int i = 0;
+	int err;
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.data_in = &data,
+		.data_size_in = sizeof(data)-1, /* omit trailing null char */
+		.data_out = &data,
+		.data_size_out = sizeof(data),
+		.repeat = 1,
+	);
+
+	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.xdp_hash_oob), &topts);
+	duration = topts.duration;
+	if (CHECK(err || topts.retval != 0, "bpf", "err %d errno %d retval %d\n",
+		  err, errno, topts.retval))
+		return;
+	for (i = 0; i < ARRAY_SIZE(rets); ++i) {
+		snprintf(buf, sizeof(buf), "ret[%d]", i);
+		ASSERT_EQ(data[i], -rets[i], buf);
+	}
+}
+
+static void test_skb_crc32c(struct packet_hash *skel)
+{
+	const int data_size = 1500;
+	char *data = calloc(1, data_size);
+	struct __sk_buff skb = { 0 };
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.data_in = data,
+		.data_size_in = data_size,
+		.data_out = data,
+		.data_size_out = data_size,
+		.ctx_in = &skb,
+		.ctx_size_in = sizeof(skb),
+	);
+	int err;
+	__u32 csum;
+
+	memset(data, 'a', data_size);
+	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.skb_hash), &topts);
+	duration = topts.duration;
+	if (CHECK(err || topts.retval != TC_ACT_OK, "bpf", "err %d errno %d retval %d\n",
+		  err, errno, topts.retval))
+		goto out;
+	csum = *(__u32 *)data;
+	ASSERT_EQ(csum, 0xd98287c1, "csum");
+out:
+	free(data);
+}
+
+static void test_skb_crc32c_oob(struct packet_hash *skel)
+{
+	int rets[] = {EINVAL, ENOTSUPP, EFAULT, ERANGE, ERANGE};
+	const int data_size = 1500;
+	int *data = calloc(1, data_size);
+	char buf[10] = {0};
+	struct __sk_buff skb = { 0 };
+	int err, i;
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.data_in = data,
+		.data_size_in = data_size,
+		.data_out = data,
+		.data_size_out = data_size,
+		.ctx_in = &skb,
+		.ctx_size_in = sizeof(skb),
+	);
+
+	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.skb_hash_oob), &topts);
+	duration = topts.duration;
+	if (CHECK(err || topts.retval != 0, "bpf", "err %d errno %d retval %d\n",
+		  err, errno, topts.retval))
+		return;
+	for (i = 0; i < ARRAY_SIZE(rets); ++i) {
+		snprintf(buf, sizeof(buf), "ret[%d]", i);
+		ASSERT_EQ(data[i], -rets[i], buf);
+	}
+}
+
+void test_packet_hash(void)
+{
+	struct packet_hash *skel;
+
+	skel = packet_hash__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "packet_hash__open_and_load"))
+		return;
+
+	if (test__start_subtest("xdp_crc32c"))
+		test_xdp_crc32c(skel);
+	if (test__start_subtest("xdp_crc32c_frags"))
+		test_xdp_crc32c_frags(skel);
+	if (test__start_subtest("xdp_crc32c_oob"))
+		test_xdp_crc32c_oob(skel);
+	if (test__start_subtest("skb_crc32c"))
+		test_skb_crc32c(skel);
+	if (test__start_subtest("skb_crc32c_oob"))
+		test_skb_crc32c_oob(skel);
+
+	packet_hash__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/packet_hash.c b/tools/testing/selftests/bpf/progs/packet_hash.c
new file mode 100644
index 000000000000..5acc97b6d156
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/packet_hash.c
@@ -0,0 +1,125 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <linux/pkt_cls.h>
+#include <bpf/bpf_helpers.h>
+
+SEC("xdp")
+int xdp_hash(struct xdp_md *xdp)
+{
+	struct bpf_packet_hash_params hashp = {
+		.hash = BPF_CRC32C,
+		.initial = ~0,
+		.offset = 0,
+		.len = bpf_xdp_get_buff_len(xdp),
+	};
+	__u32 hash = 0;
+	__u8 *data_end = (__u8 *)(void *)(long)xdp->data_end;
+	__u8 *data = (__u8 *)(void *)(long)xdp->data;
+
+	if (bpf_xdp_packet_hash(xdp, &hashp, &hash, sizeof(hash)) < 0)
+		return XDP_DROP;
+	data_end = (__u8 *)(void *)(long)xdp->data_end;
+	data = (__u8 *)(void *)(long)xdp->data;
+	if (data + sizeof(hash) > data_end)
+		return XDP_DROP;
+	*(__u32 *)data = hash ^ ~0;
+	return XDP_PASS;
+}
+
+SEC("xdp")
+int xdp_hash_oob(struct xdp_md *xdp)
+{
+	struct bpf_packet_hash_params hashp = {
+		.hash = BPF_CRC32C,
+		.initial = ~0,
+		.offset = 0,
+		.len = bpf_xdp_get_buff_len(xdp),
+	};
+	__u32 hash = 0;
+	__u8 *data_end = (__u8 *)(void *)(long)xdp->data_end;
+	__u8 *data = (__u8 *)(void *)(long)xdp->data;
+	int *ret = NULL;
+
+	if (data + (5 * sizeof(int)) >= data_end)
+		return -1;
+	ret = (int *)(void *)(long)xdp->data;
+	/* Generate EINVAL for output not being 4 bytes for a crc32c checksum */
+	*ret++ = bpf_xdp_packet_hash(xdp, &hashp, &hash, 1);
+
+	/* Try an unsupported hash algo for ENOTSUPP */
+	hashp.hash = BPF_HASH_UNSPEC;
+	*ret++ = bpf_xdp_packet_hash(xdp, &hashp, &hash, sizeof(hash));
+
+	/* Generate EFAULT for offset being over 0xffff */
+	hashp.offset = ~0;
+	*ret++ = bpf_xdp_packet_hash(xdp, &hashp, &hash, sizeof(hash));
+
+	/* Generate ERANGE for being over buf length */
+	hashp.offset = hashp.len + 1;
+	*ret++ = bpf_xdp_packet_hash(xdp, &hashp, &hash, sizeof(hash));
+	hashp.offset = 0;
+	hashp.len += 1;
+	*ret++ = bpf_xdp_packet_hash(xdp, &hashp, &hash, sizeof(hash));
+	return 0;
+}
+
+SEC("tc")
+int skb_hash(struct __sk_buff *skb)
+{
+	__u32 hash = 0;
+	__u8 *data_end = (__u8 *)(void *)(long)skb->data_end;
+	__u8 *data = (__u8 *)(void *)(long)skb->data;
+	struct bpf_packet_hash_params hashp = {
+		.hash = BPF_CRC32C,
+		.initial = ~0,
+		.offset = 0,
+		.len = data_end - data,
+	};
+
+	if (bpf_skb_packet_hash(skb, &hashp, &hash, sizeof(hash)) < 0)
+		return TC_ACT_SHOT;
+
+	if (data + sizeof(hash) > data_end)
+		return TC_ACT_SHOT;
+	*(__u32 *)data = hash ^ ~0;
+	return TC_ACT_OK;
+}
+
+SEC("tc")
+int skb_hash_oob(struct __sk_buff *skb)
+{
+	__u32 hash = 0;
+	__u8 *data_end = (__u8 *)(void *)(long)skb->data_end;
+	__u8 *data = (__u8 *)(void *)(long)skb->data;
+	struct bpf_packet_hash_params hashp = {
+		.hash = BPF_CRC32C,
+		.initial = ~0,
+		.offset = 0,
+		.len = data_end - data,
+	};
+	int *ret = NULL;
+
+	if (data + (5 * sizeof(int)) >= data_end)
+		return -1;
+	ret = (int *)(void *)(long)skb->data;
+	/* Generate EINVAL for output not being 4 bytes for a crc32c checksum */
+	*ret++ = bpf_skb_packet_hash(skb, &hashp, &hash, 1);
+
+	/* Try an unsupported hash algo for ENOTSUPP */
+	hashp.hash = BPF_HASH_UNSPEC;
+	*ret++ = bpf_skb_packet_hash(skb, &hashp, &hash, sizeof(hash));
+
+	/* Generate EFAULT for offset being over 0xffff */
+	hashp.offset = ~0;
+	*ret++ = bpf_skb_packet_hash(skb, &hashp, &hash, sizeof(hash));
+
+	/* Generate ERANGE for being over buf length */
+	hashp.offset = hashp.len + 1;
+	*ret++ = bpf_skb_packet_hash(skb, &hashp, &hash, sizeof(hash));
+	hashp.offset = 0;
+	hashp.len += 1;
+	*ret++ = bpf_skb_packet_hash(skb, &hashp, &hash, sizeof(hash));
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.37.2.672.g94769d06f0-goog

