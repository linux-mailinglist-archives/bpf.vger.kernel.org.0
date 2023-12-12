Return-Path: <bpf+bounces-17478-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65ED580E1E8
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 03:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12E562827E2
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 02:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB17635;
	Tue, 12 Dec 2023 02:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nVigoiXO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D79268C
	for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 18:32:49 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40c2d50bfbfso24391735e9.0
        for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 18:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702348340; x=1702953140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oqxt9UpM3lXEQA9Ql/9MZ7PSiBm36QeDH3GLKGuDpKA=;
        b=nVigoiXOQAU+TUEVozvMSl+sna8SJZmbh4OoIIDyVEBR3QY7xnp77KFgxekZXWDkBN
         tRhv04+ccfEOS99Cb8stqKaSt5GvY23hesluVkjhjEX5ICVbKjUDB33rEB67NTLUUpjR
         Jg9j/+b/RcV/GT3OiR3iMV3yRXsKb1GoG7kKeyllHWwIf1u67LqqRjCkMVsgY+1sOg4N
         CRXzOOSV5omHe6EhsJZLzqdgk7/DbZNQemxJ5MOZ2nbp3W7oSZ+rFgxzgMS6bQsMyqvj
         xQfqtFSOpPy/fKHKzyr0FsIScaoJ8Vc0fxxPS/5EHCfT/ChO/jxjCE2hAO1UXs+va+R3
         GfTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702348340; x=1702953140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oqxt9UpM3lXEQA9Ql/9MZ7PSiBm36QeDH3GLKGuDpKA=;
        b=PkSCiu14LcWpSS2s1u8QBwf7DEw/ED5oQzjR31cWxo/ZOPQhmjCgZYqQylsGwc/wsp
         tajD7HsP6inDAdmkDA0o1+v9/7KMzEZ/n06TaxOmHyX+zB54NwDp0vpaC5pLRlyFQhP8
         RJkO+oIgneJMlMYT+znIMKC8mqdOsw2H47y6qXHQN+19rL4owP8uBcvSSfDMIIu6Huz8
         gl9KTK4DNfYae0z45ne7S8BCQCR9qdbO7U6hDPjU2ZE/WXH8u6q9WXo+iWLRzZIkkqvu
         t3lIhbyDcvSOF7f9U0QV6pQetQ9UgHCRbCKLRhmE0CKU3UQ0R+ynyB1dkpG7srR72cqV
         yHVA==
X-Gm-Message-State: AOJu0Yxi4Nz8jfB8tgRzg93gMwNEocE7B3Xm8wXJ15zGlVjFGFWkLia8
	R0SG1AZPHDCKpim5XgK2jTmd/xd6tD4=
X-Google-Smtp-Source: AGHT+IEIkgKglFHV6nuHuBoE6qvejl+RsIgDB7k3M93t2DutSWl2jUxcNDjEUEL2tXf3Yxw0nFEd9g==
X-Received: by 2002:a05:600c:1910:b0:40c:2654:5704 with SMTP id j16-20020a05600c191000b0040c26545704mr2720719wmq.20.1702348339706;
        Mon, 11 Dec 2023 18:32:19 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id e12-20020adfe38c000000b003332fa77a0fsm9659900wrm.21.2023.12.11.18.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 18:32:19 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	quentin@isovalent.com,
	alan.maguire@oracle.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [RFC v2 1/3] bpf: Mark virtual BPF context structures as preserve_static_offset
Date: Tue, 12 Dec 2023 04:31:34 +0200
Message-ID: <20231212023136.7021-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231212023136.7021-1-eddyz87@gmail.com>
References: <20231212023136.7021-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add __attribute__((preserve_static_offset)) for the following BPF
related structures:
- __sk_buff (*)
- bpf_cgroup_dev_ctx (*)
- bpf_nf_ctx
- bpf_perf_event_data (*)
- bpf_raw_tracepoint_args
- bpf_sk_lookup (*)
- bpf_sock (*)
- bpf_sock_addr (*)
- bpf_sock_ops (*)
- bpf_sockopt (*)
- bpf_sysctl (*)
- sk_msg_md (*)
- sk_reuseport_md (*)
- xdp_md (*)

Access to structures marked with (*) is rewritten by BPF verifier.
(See verifier.c:convert_ctx_access). The rewrite requires that offsets
used in access to fields of these structures are constant values.
For the rest of the structures verifier just disallows access
via modified context pointer in the following code path:

  check_mem_access
    check_ptr_off_reg
      __check_ptr_off_reg
        if (!fixed_off_ok && reg->off)
          "dereference of modified %s ptr R%d off=%d disallowed\n"

Attribute preserve_static_offset [0] is a hint to clang that
ensures that constant offsets are used.

Type 'pt_regs' is not handled yet.

[0] https://clang.llvm.org/docs/AttributeReference.html#preserve-static-offset

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/net/netfilter/nf_bpf_link.h       | 10 ++++++-
 include/uapi/linux/bpf.h                  | 32 ++++++++++++++---------
 include/uapi/linux/bpf_perf_event.h       | 10 ++++++-
 tools/include/uapi/linux/bpf.h            | 32 ++++++++++++++---------
 tools/include/uapi/linux/bpf_perf_event.h | 10 ++++++-
 5 files changed, 67 insertions(+), 27 deletions(-)

diff --git a/include/net/netfilter/nf_bpf_link.h b/include/net/netfilter/nf_bpf_link.h
index 6c984b0ea838..e5555b1ac55d 100644
--- a/include/net/netfilter/nf_bpf_link.h
+++ b/include/net/netfilter/nf_bpf_link.h
@@ -1,9 +1,15 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
+#if __has_attribute(preserve_static_offset) && defined(__bpf__)
+#define __bpf_ctx __attribute__((preserve_static_offset))
+#else
+#define __bpf_ctx
+#endif
+
 struct bpf_nf_ctx {
 	const struct nf_hook_state *state;
 	struct sk_buff *skb;
-};
+} __bpf_ctx;
 
 #if IS_ENABLED(CONFIG_NETFILTER_BPF_LINK)
 int bpf_nf_link_attach(const union bpf_attr *attr, struct bpf_prog *prog);
@@ -13,3 +19,5 @@ static inline int bpf_nf_link_attach(const union bpf_attr *attr, struct bpf_prog
 	return -EOPNOTSUPP;
 }
 #endif
+
+#undef __bpf_ctx
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index e0545201b55f..f533301de5e4 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -69,6 +69,12 @@ enum {
 /* BPF has 10 general purpose 64-bit registers and stack frame. */
 #define MAX_BPF_REG	__MAX_BPF_REG
 
+#if __has_attribute(preserve_static_offset) && defined(__bpf__)
+#define __bpf_ctx __attribute__((preserve_static_offset))
+#else
+#define __bpf_ctx
+#endif
+
 struct bpf_insn {
 	__u8	code;		/* opcode */
 	__u8	dst_reg:4;	/* dest register */
@@ -6190,7 +6196,7 @@ struct __sk_buff {
 	__u8  tstamp_type;
 	__u32 :24;		/* Padding, future use. */
 	__u64 hwtstamp;
-};
+} __bpf_ctx;
 
 struct bpf_tunnel_key {
 	__u32 tunnel_id;
@@ -6271,7 +6277,7 @@ struct bpf_sock {
 	__u32 dst_ip6[4];
 	__u32 state;
 	__s32 rx_queue_mapping;
-};
+} __bpf_ctx;
 
 struct bpf_tcp_sock {
 	__u32 snd_cwnd;		/* Sending congestion window		*/
@@ -6379,7 +6385,7 @@ struct xdp_md {
 	__u32 rx_queue_index;  /* rxq->queue_index  */
 
 	__u32 egress_ifindex;  /* txq->dev->ifindex */
-};
+} __bpf_ctx;
 
 /* DEVMAP map-value layout
  *
@@ -6429,7 +6435,7 @@ struct sk_msg_md {
 	__u32 size;		/* Total size of sk_msg */
 
 	__bpf_md_ptr(struct bpf_sock *, sk); /* current socket */
-};
+} __bpf_ctx;
 
 struct sk_reuseport_md {
 	/*
@@ -6468,7 +6474,7 @@ struct sk_reuseport_md {
 	 */
 	__bpf_md_ptr(struct bpf_sock *, sk);
 	__bpf_md_ptr(struct bpf_sock *, migrating_sk);
-};
+} __bpf_ctx;
 
 #define BPF_TAG_SIZE	8
 
@@ -6678,7 +6684,7 @@ struct bpf_sock_addr {
 				 * Stored in network byte order.
 				 */
 	__bpf_md_ptr(struct bpf_sock *, sk);
-};
+} __bpf_ctx;
 
 /* User bpf_sock_ops struct to access socket values and specify request ops
  * and their replies.
@@ -6761,7 +6767,7 @@ struct bpf_sock_ops {
 				 * been written yet.
 				 */
 	__u64 skb_hwtstamp;
-};
+} __bpf_ctx;
 
 /* Definitions for bpf_sock_ops_cb_flags */
 enum {
@@ -7034,11 +7040,11 @@ struct bpf_cgroup_dev_ctx {
 	__u32 access_type;
 	__u32 major;
 	__u32 minor;
-};
+} __bpf_ctx;
 
 struct bpf_raw_tracepoint_args {
 	__u64 args[0];
-};
+} __bpf_ctx;
 
 /* DIRECT:  Skip the FIB rules and go to FIB table associated with device
  * OUTPUT:  Do lookup from egress perspective; default is ingress
@@ -7245,7 +7251,7 @@ struct bpf_sysctl {
 	__u32	file_pos;	/* Sysctl file position to read from, write to.
 				 * Allows 1,2,4-byte read an 4-byte write.
 				 */
-};
+} __bpf_ctx;
 
 struct bpf_sockopt {
 	__bpf_md_ptr(struct bpf_sock *, sk);
@@ -7256,7 +7262,7 @@ struct bpf_sockopt {
 	__s32	optname;
 	__s32	optlen;
 	__s32	retval;
-};
+} __bpf_ctx;
 
 struct bpf_pidns_info {
 	__u32 pid;
@@ -7280,7 +7286,7 @@ struct bpf_sk_lookup {
 	__u32 local_ip6[4];	/* Network byte order */
 	__u32 local_port;	/* Host byte order */
 	__u32 ingress_ifindex;		/* The arriving interface. Determined by inet_iif. */
-};
+} __bpf_ctx;
 
 /*
  * struct btf_ptr is used for typed pointer representation; the
@@ -7406,4 +7412,6 @@ struct bpf_iter_num {
 	__u64 __opaque[1];
 } __attribute__((aligned(8)));
 
+#undef __bpf_ctx
+
 #endif /* _UAPI__LINUX_BPF_H__ */
diff --git a/include/uapi/linux/bpf_perf_event.h b/include/uapi/linux/bpf_perf_event.h
index eb1b9d21250c..608e366877fc 100644
--- a/include/uapi/linux/bpf_perf_event.h
+++ b/include/uapi/linux/bpf_perf_event.h
@@ -10,10 +10,18 @@
 
 #include <asm/bpf_perf_event.h>
 
+#if __has_attribute(preserve_static_offset) && defined(__bpf__)
+#define __bpf_ctx __attribute__((preserve_static_offset))
+#else
+#define __bpf_ctx
+#endif
+
 struct bpf_perf_event_data {
 	bpf_user_pt_regs_t regs;
 	__u64 sample_period;
 	__u64 addr;
-};
+} __bpf_ctx;
+
+#undef __bpf_ctx
 
 #endif /* _UAPI__LINUX_BPF_PERF_EVENT_H__ */
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index e0545201b55f..f533301de5e4 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -69,6 +69,12 @@ enum {
 /* BPF has 10 general purpose 64-bit registers and stack frame. */
 #define MAX_BPF_REG	__MAX_BPF_REG
 
+#if __has_attribute(preserve_static_offset) && defined(__bpf__)
+#define __bpf_ctx __attribute__((preserve_static_offset))
+#else
+#define __bpf_ctx
+#endif
+
 struct bpf_insn {
 	__u8	code;		/* opcode */
 	__u8	dst_reg:4;	/* dest register */
@@ -6190,7 +6196,7 @@ struct __sk_buff {
 	__u8  tstamp_type;
 	__u32 :24;		/* Padding, future use. */
 	__u64 hwtstamp;
-};
+} __bpf_ctx;
 
 struct bpf_tunnel_key {
 	__u32 tunnel_id;
@@ -6271,7 +6277,7 @@ struct bpf_sock {
 	__u32 dst_ip6[4];
 	__u32 state;
 	__s32 rx_queue_mapping;
-};
+} __bpf_ctx;
 
 struct bpf_tcp_sock {
 	__u32 snd_cwnd;		/* Sending congestion window		*/
@@ -6379,7 +6385,7 @@ struct xdp_md {
 	__u32 rx_queue_index;  /* rxq->queue_index  */
 
 	__u32 egress_ifindex;  /* txq->dev->ifindex */
-};
+} __bpf_ctx;
 
 /* DEVMAP map-value layout
  *
@@ -6429,7 +6435,7 @@ struct sk_msg_md {
 	__u32 size;		/* Total size of sk_msg */
 
 	__bpf_md_ptr(struct bpf_sock *, sk); /* current socket */
-};
+} __bpf_ctx;
 
 struct sk_reuseport_md {
 	/*
@@ -6468,7 +6474,7 @@ struct sk_reuseport_md {
 	 */
 	__bpf_md_ptr(struct bpf_sock *, sk);
 	__bpf_md_ptr(struct bpf_sock *, migrating_sk);
-};
+} __bpf_ctx;
 
 #define BPF_TAG_SIZE	8
 
@@ -6678,7 +6684,7 @@ struct bpf_sock_addr {
 				 * Stored in network byte order.
 				 */
 	__bpf_md_ptr(struct bpf_sock *, sk);
-};
+} __bpf_ctx;
 
 /* User bpf_sock_ops struct to access socket values and specify request ops
  * and their replies.
@@ -6761,7 +6767,7 @@ struct bpf_sock_ops {
 				 * been written yet.
 				 */
 	__u64 skb_hwtstamp;
-};
+} __bpf_ctx;
 
 /* Definitions for bpf_sock_ops_cb_flags */
 enum {
@@ -7034,11 +7040,11 @@ struct bpf_cgroup_dev_ctx {
 	__u32 access_type;
 	__u32 major;
 	__u32 minor;
-};
+} __bpf_ctx;
 
 struct bpf_raw_tracepoint_args {
 	__u64 args[0];
-};
+} __bpf_ctx;
 
 /* DIRECT:  Skip the FIB rules and go to FIB table associated with device
  * OUTPUT:  Do lookup from egress perspective; default is ingress
@@ -7245,7 +7251,7 @@ struct bpf_sysctl {
 	__u32	file_pos;	/* Sysctl file position to read from, write to.
 				 * Allows 1,2,4-byte read an 4-byte write.
 				 */
-};
+} __bpf_ctx;
 
 struct bpf_sockopt {
 	__bpf_md_ptr(struct bpf_sock *, sk);
@@ -7256,7 +7262,7 @@ struct bpf_sockopt {
 	__s32	optname;
 	__s32	optlen;
 	__s32	retval;
-};
+} __bpf_ctx;
 
 struct bpf_pidns_info {
 	__u32 pid;
@@ -7280,7 +7286,7 @@ struct bpf_sk_lookup {
 	__u32 local_ip6[4];	/* Network byte order */
 	__u32 local_port;	/* Host byte order */
 	__u32 ingress_ifindex;		/* The arriving interface. Determined by inet_iif. */
-};
+} __bpf_ctx;
 
 /*
  * struct btf_ptr is used for typed pointer representation; the
@@ -7406,4 +7412,6 @@ struct bpf_iter_num {
 	__u64 __opaque[1];
 } __attribute__((aligned(8)));
 
+#undef __bpf_ctx
+
 #endif /* _UAPI__LINUX_BPF_H__ */
diff --git a/tools/include/uapi/linux/bpf_perf_event.h b/tools/include/uapi/linux/bpf_perf_event.h
index eb1b9d21250c..608e366877fc 100644
--- a/tools/include/uapi/linux/bpf_perf_event.h
+++ b/tools/include/uapi/linux/bpf_perf_event.h
@@ -10,10 +10,18 @@
 
 #include <asm/bpf_perf_event.h>
 
+#if __has_attribute(preserve_static_offset) && defined(__bpf__)
+#define __bpf_ctx __attribute__((preserve_static_offset))
+#else
+#define __bpf_ctx
+#endif
+
 struct bpf_perf_event_data {
 	bpf_user_pt_regs_t regs;
 	__u64 sample_period;
 	__u64 addr;
-};
+} __bpf_ctx;
+
+#undef __bpf_ctx
 
 #endif /* _UAPI__LINUX_BPF_PERF_EVENT_H__ */
-- 
2.42.1


