Return-Path: <bpf+bounces-55713-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E900A857CD
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 11:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED6234A5822
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 09:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E5F29AB0A;
	Fri, 11 Apr 2025 09:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="i9Dfdnbj"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84915298994
	for <bpf@vger.kernel.org>; Fri, 11 Apr 2025 09:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744363041; cv=none; b=RTdxBKT9vniqz6R3VsSFt3tc9gdA4fsTaSy/9je/Je2UnxB6wH0iakCD0p0pdIc8hgxP+ZdL53raxTxZEZg0qMQ5/F8ryhS8dhd7AjfthO1RloPVyGspZY/D3ISEA5j36Y6KVqtXT42H91joMI90s2Xs9GUwttDq9MKhHoNY/sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744363041; c=relaxed/simple;
	bh=waTV4W4W4Y7WAqy8/VrjgUu6ulw5og4Qi7BkKhrhQGA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BI6+HNvCdpjyzPQLA9WjUPAvMQSI5rUEnE5bOGS9rQxv/Atyj0xlBWnf0ai+zGnbY7ybVW9UStyWLmdZz/iUgIBg+NBaVuACgxmzSTrVfeaQhswSA3Dw+j6/csZWF/CSUvERgXqQU1i1GrShaaVvi0WQ3tYjMYT7SBkF2nZSdMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=i9Dfdnbj; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744363024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Mpa79OmJSgJ5vTxFFXbdRGzlB9MZL+A6yTIZNihZ5xI=;
	b=i9DfdnbjhiWGlUnfMzG2swUTEHm8EB6o9vhMUcYyLi+M3Pos0UH2Fxi7E0ySAPEfoczTAw
	oWcP8wtQ7rGmeFUcrG2ssXuKuTvw1Cn6sKTQHul7/VB2/9zTkXEuRa/8qloqP6ezEolQal
	EpnKEVqJnRn2x13vlF5NshhYiziV1og=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: mrpre@163.com,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2] bpf, sockmap: Introduce tracing capability for sockmap
Date: Fri, 11 Apr 2025 17:16:30 +0800
Message-ID: <20250411091634.336371-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Sockmap has the same high-performance forwarding capability as XDP, but
operates at Layer 7.

Introduce tracing capability for sockmap, to trace the execution results
of BPF programs without modifying the programs themselves, similar to
the existing trace_xdp_redirect{_map}.

It is crucial for debugging sockmap programs, especially in production
environments.

Additionally, the new header file has to be added to bpf_trace.h to
automatically generate tracepoints.

Test results:
$ echo "1" > /sys/kernel/tracing/events/sockmap/enable

msg/skb:
'''
sockmap_redirect: sk=000000000ec02a93, netns=4026531840, inode=318, \
family=2, protocol=6, prog_id=59, len=8192, type=msg, action=REDIRECT, \
redirect_type=ingress

sockmap_redirect: sk=00000000d5d9c931, netns=4026531840, inode=64731, \
family=2, protocol=6, prog_id=91, len=8221, type=skb, action=REDIRECT, \
redirect_type=egress

sockmap_redirect: sk=00000000106fc281, netns=4026531840, inode=64729, \
family=2, protocol=6, prog_id=94, len=8192, type=msg, action=PASS, \
redirect_type=none
'''

strparser:
'''
sockmap_strparser: sk=00000000f15fc1c8, netns=4026531840, inode=52396, \
family=2, protocol=6, prog_id=143, in_len=1000, full_len=10
'''

Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
Suggested-by: Cong Wang <xiyou.wangcong@gmail.com>
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

---
v1 -> v2: Print more valuable information as suggested by the maintainer.
---
 MAINTAINERS                    |   1 +
 include/linux/bpf_trace.h      |   1 +
 include/trace/events/sockmap.h | 158 +++++++++++++++++++++++++++++++++
 net/core/skmsg.c               |   6 ++
 4 files changed, 166 insertions(+)
 create mode 100644 include/trace/events/sockmap.h

diff --git a/MAINTAINERS b/MAINTAINERS
index a7a1d121a83e..578e16d86853 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4420,6 +4420,7 @@ L:	netdev@vger.kernel.org
 L:	bpf@vger.kernel.org
 S:	Maintained
 F:	include/linux/skmsg.h
+F:	include/trace/events/sockmap.h
 F:	net/core/skmsg.c
 F:	net/core/sock_map.c
 F:	net/ipv4/tcp_bpf.c
diff --git a/include/linux/bpf_trace.h b/include/linux/bpf_trace.h
index ddf896abcfb6..d559be0a79c5 100644
--- a/include/linux/bpf_trace.h
+++ b/include/linux/bpf_trace.h
@@ -3,5 +3,6 @@
 #define __LINUX_BPF_TRACE_H__
 
 #include <trace/events/xdp.h>
+#include <trace/events/sockmap.h>
 
 #endif /* __LINUX_BPF_TRACE_H__ */
diff --git a/include/trace/events/sockmap.h b/include/trace/events/sockmap.h
new file mode 100644
index 000000000000..79784e8d5866
--- /dev/null
+++ b/include/trace/events/sockmap.h
@@ -0,0 +1,158 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM sockmap
+
+#if !defined(_TRACE_SOCKMAP_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_SOCKMAP_H
+
+#include <linux/tracepoint.h>
+#include <linux/bpf.h>
+#include <linux/skmsg.h>
+
+#ifndef __TRACE_SOCKMAP_HELPER_ONCE_ONLY
+#define __TRACE_SOCKMAP_HELPER_ONCE_ONLY
+
+enum sockmap_direct_type {
+	SOCKMAP_REDIR_NONE	= 0,
+	SOCKMAP_REDIR_INGRESS,
+	SOCKMAP_REDIR_EGRESS,
+};
+
+enum sockmap_data_type {
+	SOCKMAP_MSG		= 0,
+	SOCKMAP_SKB,
+};
+
+#endif /* end __TRACE_SOCKMAP_HELPER_ONCE_ONLY */
+
+TRACE_DEFINE_ENUM(SOCKMAP_MSG);
+TRACE_DEFINE_ENUM(SOCKMAP_SKB);
+TRACE_DEFINE_ENUM(SOCKMAP_REDIR_NONE);
+TRACE_DEFINE_ENUM(SOCKMAP_REDIR_INGRESS);
+TRACE_DEFINE_ENUM(SOCKMAP_REDIR_EGRESS);
+
+TRACE_DEFINE_ENUM(__SK_DROP);
+TRACE_DEFINE_ENUM(__SK_PASS);
+TRACE_DEFINE_ENUM(__SK_REDIRECT);
+TRACE_DEFINE_ENUM(__SK_NONE);
+
+#define show_redirect_type(x)					\
+	__print_symbolic(x,					\
+		{ SOCKMAP_REDIR_NONE,		"none" },	\
+		{ SOCKMAP_REDIR_INGRESS,	"ingress" },	\
+		{ SOCKMAP_REDIR_EGRESS,		"egress" })
+
+#define show_act(x)						\
+	__print_symbolic(x,					\
+		{ __SK_DROP,			"DROP" },	\
+		{ __SK_PASS,			"PASS" },	\
+		{ __SK_REDIRECT,		"REDIRECT" },	\
+		{ __SK_NONE,			"NONE" })
+
+#define show_data_type(x)					\
+	__print_symbolic(x,					\
+		{ SOCKMAP_MSG,			"msg" },	\
+		{ SOCKMAP_SKB,			"skb" })
+
+#define trace_sockmap_skmsg_redirect(sk, prog, msg, act)	\
+	trace_sockmap_redirect((sk), SOCKMAP_MSG, (prog),	\
+			       (msg)->sg.size, (act),		\
+			       sk_msg_to_ingress(msg))
+
+#define trace_sockmap_skb_redirect(sk, prog, skb, act)		\
+	trace_sockmap_redirect((sk), SOCKMAP_SKB, (prog),	\
+			       (skb)->len, (act),		\
+			       skb_bpf_ingress(skb))
+
+#define trace_sockmap_skb_strp_parse(sk, prog, skb, ret)	\
+	trace_sockmap_strparser((sk), (prog), (skb)->len, (ret))
+
+TRACE_EVENT(sockmap_redirect,
+
+	TP_PROTO(const struct sock *sk, enum sockmap_data_type type,
+		 const struct bpf_prog *prog, int len, int act,
+		 bool ingress),
+
+	TP_ARGS(sk, type, prog, len, act, ingress),
+
+	TP_STRUCT__entry(
+		__field(const void *, sk)
+		__field(unsigned long, ino)
+		__field(unsigned int, netns_ino)
+		__field(__u16, family)
+		__field(__u16, protocol)
+		__field(int, prog_id)
+		__field(int, len)
+		__field(int, act)
+		__field(enum sockmap_data_type, type)
+		__field(enum sockmap_direct_type, redir)
+	),
+
+	TP_fast_assign(
+		/* 'redir' is undefined if action is not REDIRECT */
+		enum sockmap_direct_type redir = SOCKMAP_REDIR_NONE;
+
+		if (act == __SK_REDIRECT) {
+			if (ingress)
+				redir = SOCKMAP_REDIR_INGRESS;
+			else
+				redir = SOCKMAP_REDIR_EGRESS;
+		}
+		__entry->sk		= sk;
+		__entry->ino		= sock_i_ino((struct sock *)sk);
+		__entry->netns_ino	= sock_net(sk)->ns.inum;
+		__entry->type		= type;
+		__entry->family		= sk->sk_family;
+		__entry->protocol	= sk->sk_protocol;
+		__entry->prog_id	= prog->aux->id;
+		__entry->len		= len;
+		__entry->act		= act;
+		__entry->redir		= redir;
+	),
+
+	TP_printk("sk=%p, netns=%u, inode=%lu, family=%u, protocol=%u,"
+		  " prog_id=%d, len=%d, type=%s, action=%s, redirect_type=%s",
+		  __entry->sk, __entry->netns_ino, __entry->ino,
+		  __entry->family, __entry->protocol, __entry->prog_id,
+		  __entry->len, show_data_type(__entry->type),
+		  show_act(__entry->act), show_redirect_type(__entry->redir))
+);
+
+TRACE_EVENT(sockmap_strparser,
+
+	TP_PROTO(const struct sock *sk, const struct bpf_prog *prog,
+		 int in_len, int full_len),
+
+	TP_ARGS(sk, prog, in_len, full_len),
+
+	TP_STRUCT__entry(
+		__field(const void *, sk)
+		__field(unsigned long, ino)
+		__field(unsigned int, netns_ino)
+		__field(__u16, family)
+		__field(__u16, protocol)
+		__field(int, prog_id)
+		__field(int, in_len)
+		__field(int, full_len)
+	),
+
+	TP_fast_assign(
+		__entry->sk		= sk;
+		__entry->ino		= sock_i_ino((struct sock *)sk);
+		__entry->netns_ino	= sock_net(sk)->ns.inum;
+		__entry->family		= sk->sk_family;
+		__entry->protocol	= sk->sk_protocol;
+		__entry->prog_id	= prog->aux->id;
+		__entry->in_len		= in_len;
+		__entry->full_len	= full_len;
+	),
+
+	TP_printk("sk=%p, netns=%u, inode=%lu, family=%u, protocol=%u,"
+		  " prog_id=%d, in_len=%d, full_len=%d",
+		  __entry->sk, __entry->netns_ino, __entry->ino,
+		  __entry->family, __entry->protocol, __entry->prog_id,
+		  __entry->in_len, __entry->full_len)
+);
+#endif /* _TRACE_SOCKMAP_H */
+
+#include <trace/define_trace.h>
diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 276934673066..517596efafa8 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -9,6 +9,7 @@
 #include <net/tcp.h>
 #include <net/tls.h>
 #include <trace/events/sock.h>
+#include <trace/events/sockmap.h>
 
 static bool sk_msg_try_coalesce_ok(struct sk_msg *msg, int elem_first_coalesce)
 {
@@ -910,6 +911,7 @@ int sk_psock_msg_verdict(struct sock *sk, struct sk_psock *psock,
 		sock_hold(psock->sk_redir);
 	}
 out:
+	trace_sockmap_skmsg_redirect(sk, prog, msg, ret);
 	rcu_read_unlock();
 	return ret;
 }
@@ -981,6 +983,7 @@ int sk_psock_tls_strp_read(struct sk_psock *psock, struct sk_buff *skb)
 		ret = bpf_prog_run_pin_on_cpu(prog, skb);
 		ret = sk_psock_map_verd(ret, skb_bpf_redirect_fetch(skb));
 		skb->sk = NULL;
+		trace_sockmap_skb_redirect(psock->sk, prog, skb, ret);
 	}
 	sk_psock_tls_verdict_apply(skb, psock, ret);
 	rcu_read_unlock();
@@ -1090,6 +1093,7 @@ static void sk_psock_strp_read(struct strparser *strp, struct sk_buff *skb)
 		skb_bpf_set_strparser(skb);
 		ret = sk_psock_map_verd(ret, skb_bpf_redirect_fetch(skb));
 		skb->sk = NULL;
+		trace_sockmap_skb_redirect(sk, prog, skb, ret);
 	}
 	sk_psock_verdict_apply(psock, skb, ret);
 out:
@@ -1113,6 +1117,7 @@ static int sk_psock_strp_parse(struct strparser *strp, struct sk_buff *skb)
 		skb->sk = psock->sk;
 		ret = bpf_prog_run_pin_on_cpu(prog, skb);
 		skb->sk = NULL;
+		trace_sockmap_skb_strp_parse(psock->sk, prog, skb, ret);
 	}
 	rcu_read_unlock();
 	return ret;
@@ -1217,6 +1222,7 @@ static int sk_psock_verdict_recv(struct sock *sk, struct sk_buff *skb)
 		skb_bpf_redirect_clear(skb);
 		ret = bpf_prog_run_pin_on_cpu(prog, skb);
 		ret = sk_psock_map_verd(ret, skb_bpf_redirect_fetch(skb));
+		trace_sockmap_skb_redirect(psock->sk, prog, skb, ret);
 	}
 	ret = sk_psock_verdict_apply(psock, skb, ret);
 	if (ret < 0)
-- 
2.47.1


