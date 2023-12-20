Return-Path: <bpf+bounces-18381-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFEDE819FDB
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 14:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66E4B1F228B6
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 13:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D8D34569;
	Wed, 20 Dec 2023 13:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="emQfkZEA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0915636AED
	for <bpf@vger.kernel.org>; Wed, 20 Dec 2023 13:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a2331e7058aso525275066b.2
        for <bpf@vger.kernel.org>; Wed, 20 Dec 2023 05:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703079264; x=1703684064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eekmmOvsRvN29JgWFiEZxo+yj4o/fAvOvFvAoDaBH7Y=;
        b=emQfkZEAiUZzB4k0YRLiE9aeNYw9Jvg/XUMc3YIUWOtPFarO63z5s3paBf0ODKMj4C
         F5wwc/jP9E79JeZ5cQx54QA0Qqr/J+ssyz2eKS43aSY4lOnOQJ/oMlU8szKGeh8UWTw8
         JhT2IHZx79M71BCqDgBamzK5jlAVYXAGJaHlKv0EQz4PKRBLcpqHWD/Lu9oWnStb6Jpm
         +7uwrnFs6hDUebjqKcJINDGQSq5nJetqLO0eJT5BcX9OAWp4QCuHeNufgtAVwwok5Ugh
         9RHAFP53BYXPdWQfeW+oLhK6iNs5uwr29R+srO492mogh+6tJCIxaQfbvCi9x7wTAQyU
         3szQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703079264; x=1703684064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eekmmOvsRvN29JgWFiEZxo+yj4o/fAvOvFvAoDaBH7Y=;
        b=tWo0ggclty/hpEoTtvivR71wr+LrSDK4xWWkh+Nvwj0dDC5g/Qb7/BUQR05Yn3rfHi
         OHaW+yMqBKZT69AHKGBnu1KFTaLwqLI26akqqHAN6M8MnrSmtTNITB9Knen/d2+NAB3g
         7pSy5BojgO6QHXbrd2IW7hubvghzUPIvGZcmjBS7B+SdbtR0EOw8WXvVW3fqxUbLxIp1
         OCUxxBFdDxQZXQzGmmsSodTAJSrHbI7mg3x/+hV9I2o7ufMUy+5WtMkzZwZzwRmtc+KU
         M2Vjklp1m2vTcbbS3ZpX9ye2GX6PlFddKvUe1ZY2IuyevnyXOP8nGbJJa0h5qXlCtOv7
         kv8Q==
X-Gm-Message-State: AOJu0Yw/4612scYzboNLyxMY1eVok76ju+kP278TBv5kmFZWzD+63U7a
	803aRsGWr5h2gg9Zq3RACvhlv9MKf+g=
X-Google-Smtp-Source: AGHT+IGvlObYDaBFjkY6Vq+KXBRk3k1RkK772QkN+0MKlNEtlYY41AXDQhoEEeePRpFi+vEqPw8itw==
X-Received: by 2002:a17:907:9702:b0:a26:85ec:f185 with SMTP id jg2-20020a170907970200b00a2685ecf185mr925306ejc.117.1703079263608;
        Wed, 20 Dec 2023 05:34:23 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id vs4-20020a170907a58400b00a22fb8901c4sm9951032ejc.12.2023.12.20.05.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 05:34:23 -0800 (PST)
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
Subject: [RFC v3 1/3] bpf: Mark virtual BPF context structures as preserve_static_offset
Date: Wed, 20 Dec 2023 15:34:09 +0200
Message-ID: <20231220133411.22978-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231220133411.22978-1-eddyz87@gmail.com>
References: <20231220133411.22978-1-eddyz87@gmail.com>
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

Attribute __attribute__((btf_decl_tag("preserve_static_offset")))
would be used as a marker for bpftool to emit preserve_static_offset
attribute when vmlinux.h is generated from BTF.

Type 'pt_regs' is not handled yet.

Note: !defined(__cplusplus) is necessary only to make
tools/testing/selftests/bpf/test_cpp.cpp selftest compile:
this test includes bpf.h and is compiled as C++.
Without !defined(__cplusplus) the following error message
is reported: "error: 'btf_decl_tag' attribute ignored".

Apparently, when compiling C++, clang's implementation of
__has_attribute returns true for attributes declared as COnly.
This is possibly incorrect [1], but even if fixed in newer clang
versions would be necessary for backwards compatibility.

[0] https://clang.llvm.org/docs/AttributeReference.html#preserve-static-offset
[1] https://discourse.llvm.org/t/when-compiling-c-has-attribute-returns-1-for-attributes-declared-as-conly-in-attr-td/

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/net/netfilter/nf_bpf_link.h       | 12 +++++++-
 include/uapi/linux/bpf.h                  | 34 +++++++++++++++--------
 include/uapi/linux/bpf_perf_event.h       | 12 +++++++-
 tools/include/uapi/linux/bpf.h            | 34 +++++++++++++++--------
 tools/include/uapi/linux/bpf_perf_event.h | 12 +++++++-
 5 files changed, 77 insertions(+), 27 deletions(-)

diff --git a/include/net/netfilter/nf_bpf_link.h b/include/net/netfilter/nf_bpf_link.h
index 6c984b0ea838..7308efd4454f 100644
--- a/include/net/netfilter/nf_bpf_link.h
+++ b/include/net/netfilter/nf_bpf_link.h
@@ -1,9 +1,17 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
+#if __has_attribute(preserve_static_offset) && defined(__bpf__)
+#define __bpf_ctx __attribute__((preserve_static_offset))
+#elif __has_attribute(btf_decl_tag) && !defined(__cplusplus)
+#define __bpf_ctx __attribute__((btf_decl_tag(("preserve_static_offset"))))
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
@@ -13,3 +21,5 @@ static inline int bpf_nf_link_attach(const union bpf_attr *attr, struct bpf_prog
 	return -EOPNOTSUPP;
 }
 #endif
+
+#undef __bpf_ctx
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index e0545201b55f..351c39842b7b 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -69,6 +69,14 @@ enum {
 /* BPF has 10 general purpose 64-bit registers and stack frame. */
 #define MAX_BPF_REG	__MAX_BPF_REG
 
+#if __has_attribute(preserve_static_offset) && defined(__bpf__)
+#define __bpf_ctx __attribute__((preserve_static_offset))
+#elif __has_attribute(btf_decl_tag) && !defined(__cplusplus)
+#define __bpf_ctx __attribute__((btf_decl_tag(("preserve_static_offset"))))
+#else
+#define __bpf_ctx
+#endif
+
 struct bpf_insn {
 	__u8	code;		/* opcode */
 	__u8	dst_reg:4;	/* dest register */
@@ -6190,7 +6198,7 @@ struct __sk_buff {
 	__u8  tstamp_type;
 	__u32 :24;		/* Padding, future use. */
 	__u64 hwtstamp;
-};
+} __bpf_ctx;
 
 struct bpf_tunnel_key {
 	__u32 tunnel_id;
@@ -6271,7 +6279,7 @@ struct bpf_sock {
 	__u32 dst_ip6[4];
 	__u32 state;
 	__s32 rx_queue_mapping;
-};
+} __bpf_ctx;
 
 struct bpf_tcp_sock {
 	__u32 snd_cwnd;		/* Sending congestion window		*/
@@ -6379,7 +6387,7 @@ struct xdp_md {
 	__u32 rx_queue_index;  /* rxq->queue_index  */
 
 	__u32 egress_ifindex;  /* txq->dev->ifindex */
-};
+} __bpf_ctx;
 
 /* DEVMAP map-value layout
  *
@@ -6429,7 +6437,7 @@ struct sk_msg_md {
 	__u32 size;		/* Total size of sk_msg */
 
 	__bpf_md_ptr(struct bpf_sock *, sk); /* current socket */
-};
+} __bpf_ctx;
 
 struct sk_reuseport_md {
 	/*
@@ -6468,7 +6476,7 @@ struct sk_reuseport_md {
 	 */
 	__bpf_md_ptr(struct bpf_sock *, sk);
 	__bpf_md_ptr(struct bpf_sock *, migrating_sk);
-};
+} __bpf_ctx;
 
 #define BPF_TAG_SIZE	8
 
@@ -6678,7 +6686,7 @@ struct bpf_sock_addr {
 				 * Stored in network byte order.
 				 */
 	__bpf_md_ptr(struct bpf_sock *, sk);
-};
+} __bpf_ctx;
 
 /* User bpf_sock_ops struct to access socket values and specify request ops
  * and their replies.
@@ -6761,7 +6769,7 @@ struct bpf_sock_ops {
 				 * been written yet.
 				 */
 	__u64 skb_hwtstamp;
-};
+} __bpf_ctx;
 
 /* Definitions for bpf_sock_ops_cb_flags */
 enum {
@@ -7034,11 +7042,11 @@ struct bpf_cgroup_dev_ctx {
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
@@ -7245,7 +7253,7 @@ struct bpf_sysctl {
 	__u32	file_pos;	/* Sysctl file position to read from, write to.
 				 * Allows 1,2,4-byte read an 4-byte write.
 				 */
-};
+} __bpf_ctx;
 
 struct bpf_sockopt {
 	__bpf_md_ptr(struct bpf_sock *, sk);
@@ -7256,7 +7264,7 @@ struct bpf_sockopt {
 	__s32	optname;
 	__s32	optlen;
 	__s32	retval;
-};
+} __bpf_ctx;
 
 struct bpf_pidns_info {
 	__u32 pid;
@@ -7280,7 +7288,7 @@ struct bpf_sk_lookup {
 	__u32 local_ip6[4];	/* Network byte order */
 	__u32 local_port;	/* Host byte order */
 	__u32 ingress_ifindex;		/* The arriving interface. Determined by inet_iif. */
-};
+} __bpf_ctx;
 
 /*
  * struct btf_ptr is used for typed pointer representation; the
@@ -7406,4 +7414,6 @@ struct bpf_iter_num {
 	__u64 __opaque[1];
 } __attribute__((aligned(8)));
 
+#undef __bpf_ctx
+
 #endif /* _UAPI__LINUX_BPF_H__ */
diff --git a/include/uapi/linux/bpf_perf_event.h b/include/uapi/linux/bpf_perf_event.h
index eb1b9d21250c..4f3f1e906f96 100644
--- a/include/uapi/linux/bpf_perf_event.h
+++ b/include/uapi/linux/bpf_perf_event.h
@@ -10,10 +10,20 @@
 
 #include <asm/bpf_perf_event.h>
 
+#if __has_attribute(preserve_static_offset) && defined(__bpf__)
+#define __bpf_ctx __attribute__((preserve_static_offset))
+#elif __has_attribute(btf_decl_tag) && !defined(__cplusplus)
+#define __bpf_ctx __attribute__((btf_decl_tag(("preserve_static_offset"))))
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
index e0545201b55f..351c39842b7b 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -69,6 +69,14 @@ enum {
 /* BPF has 10 general purpose 64-bit registers and stack frame. */
 #define MAX_BPF_REG	__MAX_BPF_REG
 
+#if __has_attribute(preserve_static_offset) && defined(__bpf__)
+#define __bpf_ctx __attribute__((preserve_static_offset))
+#elif __has_attribute(btf_decl_tag) && !defined(__cplusplus)
+#define __bpf_ctx __attribute__((btf_decl_tag(("preserve_static_offset"))))
+#else
+#define __bpf_ctx
+#endif
+
 struct bpf_insn {
 	__u8	code;		/* opcode */
 	__u8	dst_reg:4;	/* dest register */
@@ -6190,7 +6198,7 @@ struct __sk_buff {
 	__u8  tstamp_type;
 	__u32 :24;		/* Padding, future use. */
 	__u64 hwtstamp;
-};
+} __bpf_ctx;
 
 struct bpf_tunnel_key {
 	__u32 tunnel_id;
@@ -6271,7 +6279,7 @@ struct bpf_sock {
 	__u32 dst_ip6[4];
 	__u32 state;
 	__s32 rx_queue_mapping;
-};
+} __bpf_ctx;
 
 struct bpf_tcp_sock {
 	__u32 snd_cwnd;		/* Sending congestion window		*/
@@ -6379,7 +6387,7 @@ struct xdp_md {
 	__u32 rx_queue_index;  /* rxq->queue_index  */
 
 	__u32 egress_ifindex;  /* txq->dev->ifindex */
-};
+} __bpf_ctx;
 
 /* DEVMAP map-value layout
  *
@@ -6429,7 +6437,7 @@ struct sk_msg_md {
 	__u32 size;		/* Total size of sk_msg */
 
 	__bpf_md_ptr(struct bpf_sock *, sk); /* current socket */
-};
+} __bpf_ctx;
 
 struct sk_reuseport_md {
 	/*
@@ -6468,7 +6476,7 @@ struct sk_reuseport_md {
 	 */
 	__bpf_md_ptr(struct bpf_sock *, sk);
 	__bpf_md_ptr(struct bpf_sock *, migrating_sk);
-};
+} __bpf_ctx;
 
 #define BPF_TAG_SIZE	8
 
@@ -6678,7 +6686,7 @@ struct bpf_sock_addr {
 				 * Stored in network byte order.
 				 */
 	__bpf_md_ptr(struct bpf_sock *, sk);
-};
+} __bpf_ctx;
 
 /* User bpf_sock_ops struct to access socket values and specify request ops
  * and their replies.
@@ -6761,7 +6769,7 @@ struct bpf_sock_ops {
 				 * been written yet.
 				 */
 	__u64 skb_hwtstamp;
-};
+} __bpf_ctx;
 
 /* Definitions for bpf_sock_ops_cb_flags */
 enum {
@@ -7034,11 +7042,11 @@ struct bpf_cgroup_dev_ctx {
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
@@ -7245,7 +7253,7 @@ struct bpf_sysctl {
 	__u32	file_pos;	/* Sysctl file position to read from, write to.
 				 * Allows 1,2,4-byte read an 4-byte write.
 				 */
-};
+} __bpf_ctx;
 
 struct bpf_sockopt {
 	__bpf_md_ptr(struct bpf_sock *, sk);
@@ -7256,7 +7264,7 @@ struct bpf_sockopt {
 	__s32	optname;
 	__s32	optlen;
 	__s32	retval;
-};
+} __bpf_ctx;
 
 struct bpf_pidns_info {
 	__u32 pid;
@@ -7280,7 +7288,7 @@ struct bpf_sk_lookup {
 	__u32 local_ip6[4];	/* Network byte order */
 	__u32 local_port;	/* Host byte order */
 	__u32 ingress_ifindex;		/* The arriving interface. Determined by inet_iif. */
-};
+} __bpf_ctx;
 
 /*
  * struct btf_ptr is used for typed pointer representation; the
@@ -7406,4 +7414,6 @@ struct bpf_iter_num {
 	__u64 __opaque[1];
 } __attribute__((aligned(8)));
 
+#undef __bpf_ctx
+
 #endif /* _UAPI__LINUX_BPF_H__ */
diff --git a/tools/include/uapi/linux/bpf_perf_event.h b/tools/include/uapi/linux/bpf_perf_event.h
index eb1b9d21250c..4f3f1e906f96 100644
--- a/tools/include/uapi/linux/bpf_perf_event.h
+++ b/tools/include/uapi/linux/bpf_perf_event.h
@@ -10,10 +10,20 @@
 
 #include <asm/bpf_perf_event.h>
 
+#if __has_attribute(preserve_static_offset) && defined(__bpf__)
+#define __bpf_ctx __attribute__((preserve_static_offset))
+#elif __has_attribute(btf_decl_tag) && !defined(__cplusplus)
+#define __bpf_ctx __attribute__((btf_decl_tag(("preserve_static_offset"))))
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


