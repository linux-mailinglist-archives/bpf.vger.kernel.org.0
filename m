Return-Path: <bpf+bounces-17061-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 381C88096E7
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 01:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B09E1C20C32
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 00:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0390641;
	Fri,  8 Dec 2023 00:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IdV7Mw6I"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65561BC7
	for <bpf@vger.kernel.org>; Thu,  7 Dec 2023 16:05:51 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40c317723a8so4126175e9.3
        for <bpf@vger.kernel.org>; Thu, 07 Dec 2023 16:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701993950; x=1702598750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jrfS17JyIXMdqIDGH+wbH7f7qlX1YCYE1xJKLOhq1Gc=;
        b=IdV7Mw6ICpXtQkLxzDQKQj2TPHp3oGv4P/PdKL6LLScCuzj/s0iyl5XyyltW9i5Tsf
         qplwbb+fo1ivYRopdhiwb4+hWPNODsxRIHY4Us7o8husQTmrAAhX0Lzx+3fjpQZzHK2J
         oxh0QvJXoB2pVrLe3ptNS6JAIl+YbDHkoHDJjGldDDHs48ckMi+OJWYmhUhzqY/51XUu
         crMaNDZLsMaCa2aHVWi69brukEBQXBegfisAU5Y2W+QbekHaF3zZ+M6A5S8aOrOqzpRP
         wK9X/78Xs3firZhylUzKHHTcvLpG2J0lDQKmryqww/AeoMAawNWcTTeY4CxRFGBXItZ7
         fmjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701993950; x=1702598750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jrfS17JyIXMdqIDGH+wbH7f7qlX1YCYE1xJKLOhq1Gc=;
        b=TS2CtlLT5gXSvA31KLVQu6YmNnG31YcC/FJuaXEZrPY2dXhbExYHUYtL5Cm6q+9oMm
         +o6MAVJPduMoUj+vWJux9kTloU1j/VMO97gODGwbcVGyophnTfhgWw6xUjoty5uTDXKZ
         g+JlY32YoZHjuXQWmSwTC2SFa9jKwcYLqFg93TkU5cBmh5+70phvEMMTLqKfG2egXur/
         aJZt1tbrP1WVo7A1Gj+tASmTtAuD78BgmZMdYJjGvY3DsnYoXj+mPDbChXYbiCQ+6s4m
         uhIa2DhO5UA58C3zgW8awwSzOn4BmcNN6F8HCU3TzJoA+l196gwotbQmwRqMWK7ICInP
         qyyg==
X-Gm-Message-State: AOJu0Ywd+ClmNVvXlUBnAi6UpDzCkfOoLpu+JWJLP1Qzik1B/IbcjCeG
	IPCnT9CjXDXTpNFTyDhVB4Zw+EyZjb9RKQ==
X-Google-Smtp-Source: AGHT+IFOYckOipM/gt688RDbP5YMzy8IYKL3K/xLHoX/9JhdcbLFFcoGU23xqdlM2zZ7ykcrwpP5FQ==
X-Received: by 2002:a7b:ce94:0:b0:408:575e:f24f with SMTP id q20-20020a7bce94000000b00408575ef24fmr2179428wmj.28.1701993949815;
        Thu, 07 Dec 2023 16:05:49 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id g12-20020a05600c310c00b00406408dc788sm3279155wmo.44.2023.12.07.16.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 16:05:49 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	jose.marchesi@oracle.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 1/1] bpf: Mark virtual BPF context structures as preserve_static_offset
Date: Fri,  8 Dec 2023 02:05:31 +0200
Message-ID: <20231208000531.19179-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231208000531.19179-1-eddyz87@gmail.com>
References: <20231208000531.19179-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add __attribute__((preserve_static_offset)) for the following BPF
related structures:
- __sk_buff
- bpf_cgroup_dev_ctx
- bpf_perf_event_data
- bpf_sk_lookup
- bpf_sock
- bpf_sock_addr
- bpf_sock_ops
- bpf_sockopt
- bpf_sysctl
- sk_msg_md
- sk_reuseport_md
- xdp_md

Access to these structures is rewritten by BPF verifier.
(See verifier.c:convert_ctx_access).
The rewrite requires that offsets used in access to fields of these
structures are constant values. __attribute__((preserve_static_offset))
is a hint to clang that ensures that constant offsets are used.
(See https://reviews.llvm.org/D133361 for details).

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/uapi/linux/bpf.h                  | 28 ++++++++++++++---------
 include/uapi/linux/bpf_perf_event.h       |  8 ++++++-
 tools/include/uapi/linux/bpf.h            | 28 ++++++++++++++---------
 tools/include/uapi/linux/bpf_perf_event.h |  8 ++++++-
 4 files changed, 48 insertions(+), 24 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index e0545201b55f..75eee56ed732 100644
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
@@ -7034,7 +7040,7 @@ struct bpf_cgroup_dev_ctx {
 	__u32 access_type;
 	__u32 major;
 	__u32 minor;
-};
+} __bpf_ctx;
 
 struct bpf_raw_tracepoint_args {
 	__u64 args[0];
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
diff --git a/include/uapi/linux/bpf_perf_event.h b/include/uapi/linux/bpf_perf_event.h
index eb1b9d21250c..cf614ddf0381 100644
--- a/include/uapi/linux/bpf_perf_event.h
+++ b/include/uapi/linux/bpf_perf_event.h
@@ -10,10 +10,16 @@
 
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
 
 #endif /* _UAPI__LINUX_BPF_PERF_EVENT_H__ */
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index e0545201b55f..75eee56ed732 100644
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
@@ -7034,7 +7040,7 @@ struct bpf_cgroup_dev_ctx {
 	__u32 access_type;
 	__u32 major;
 	__u32 minor;
-};
+} __bpf_ctx;
 
 struct bpf_raw_tracepoint_args {
 	__u64 args[0];
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
diff --git a/tools/include/uapi/linux/bpf_perf_event.h b/tools/include/uapi/linux/bpf_perf_event.h
index eb1b9d21250c..cf614ddf0381 100644
--- a/tools/include/uapi/linux/bpf_perf_event.h
+++ b/tools/include/uapi/linux/bpf_perf_event.h
@@ -10,10 +10,16 @@
 
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
 
 #endif /* _UAPI__LINUX_BPF_PERF_EVENT_H__ */
-- 
2.42.1


