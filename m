Return-Path: <bpf+bounces-55514-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD96A82218
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 12:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D27471BA50D5
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 10:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1308825E46F;
	Wed,  9 Apr 2025 10:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="URr6BBK3"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A3E25D8ED
	for <bpf@vger.kernel.org>; Wed,  9 Apr 2025 10:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744194602; cv=none; b=qKP63caiTQw2g3eKLIHtJyt/FL+diAQVE4yKwQhi8jiHXGW2iBzsnE2tl+S37Yf8kWCxlxhVzXdS+PHHqs/0Ba21+XOXcvv1PuE+d1CYePPEb+vs0OgP95CCv3yfnMt9fzAnOrylq7P9t6kiapEqYFSv2XEcop7JKaFELVnGfS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744194602; c=relaxed/simple;
	bh=WQk83JuPuQX2fSNl/OKOGc35+sSgfnC9FLi+eV/1Z4A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mDk13b+E4ru+0X8/LUNjXKPj3fJN13Dp7f39k5XxYBRYkof9uP/KmqyP1soJ8fV9VKLGKVqf9BlwnIoO8hXfV0DtO1S/nCm/ln2t3yzNBAQooTBJhADb6+yIXLsin/NWU9dFYIzggRIh+baw+i9HEonvFDyM8B9d23fOvd5bfT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=URr6BBK3; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744194596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tVjoel3accGTvriYfDQCUCAxB4fdnEejpHrDGJrVaco=;
	b=URr6BBK36GF8FRT9ASyYKMCuY2UJLHSxLZu4gdJzyjDDmhSvKVSruxFiPU64s3ACJIP+vr
	A8QaJ+YG9O447840kX6fdKi+j8V7tSZKg+qx2hkfTC6YOKa8IRz4jZnU0ePs117q9KWUfd
	26m7vdffmeNppHNYwAbukuQ1kg+Nf8s=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: mrpre@163.com,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
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
	Jakub Sitnicki <jakub@cloudflare.com>,
	Steven Rostedt <rostedt@goodmis.org>,
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
Subject: [PATCH bpf-next v1] bpf, sockmap: Introduce tracing capability for sockmap
Date: Wed,  9 Apr 2025 18:29:33 +0800
Message-ID: <20250409102937.15632-1-jiayuan.chen@linux.dev>
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

Introduce tracing capability for sockmap, similar to XDP, to trace the
execution results of BPF programs without modifying the programs
themselves, similar to the existing trace_xdp_redirect{_map}.

It is crucial for debugging BPF programs, especially in production
environments.

Additionally, a header file was added to bpf_trace.h to automatically
generate tracepoints.

Test results:
$ echo "1" > /sys/kernel/tracing/events/sockmap/enable

skb:
sockmap_redirect: sk=00000000d3266a8d, type=skb, family=2, protocol=6, \
prog_id=73, length=256, action=PASS

msg:
sockmap_redirect: sk=00000000528c7614, type=msg, family=2, protocol=6, \
prog_id=185, length=5, action=REDIRECT

tls:
sockmap_redirect: sk=00000000d04d2224, type=skb, family=2, protocol=6, \
prog_id=143, length=35, action=PASS

strparser:
sockmap_skb_strp_parse: sk=00000000ecab0b30, family=2, protocol=6, \
prog_id=170, size=5

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 MAINTAINERS                    |  1 +
 include/linux/bpf_trace.h      |  2 +-
 include/trace/events/sockmap.h | 89 ++++++++++++++++++++++++++++++++++
 net/core/skmsg.c               |  6 +++
 4 files changed, 97 insertions(+), 1 deletion(-)
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
index ddf896abcfb6..896346fb2b46 100644
--- a/include/linux/bpf_trace.h
+++ b/include/linux/bpf_trace.h
@@ -3,5 +3,5 @@
 #define __LINUX_BPF_TRACE_H__
 
 #include <trace/events/xdp.h>
-
+#include <trace/events/sockmap.h>
 #endif /* __LINUX_BPF_TRACE_H__ */
diff --git a/include/trace/events/sockmap.h b/include/trace/events/sockmap.h
new file mode 100644
index 000000000000..2a69b011e88f
--- /dev/null
+++ b/include/trace/events/sockmap.h
@@ -0,0 +1,89 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM sockmap
+
+#if !defined(_TRACE_SOCKMAP_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_SOCKMAP_H
+
+#include <linux/filter.h>
+#include <linux/tracepoint.h>
+#include <linux/bpf.h>
+#include <linux/skmsg.h>
+
+TRACE_DEFINE_ENUM(__SK_DROP);
+TRACE_DEFINE_ENUM(__SK_PASS);
+TRACE_DEFINE_ENUM(__SK_REDIRECT);
+TRACE_DEFINE_ENUM(__SK_NONE);
+
+#define show_act(x) \
+	__print_symbolic(x, \
+		{ __SK_DROP,		"DROP" }, \
+		{ __SK_PASS,		"PASS" }, \
+		{ __SK_REDIRECT,	"REDIRECT" }, \
+		{ __SK_NONE,		"NONE" })
+
+#define trace_sockmap_skmsg_redirect(sk, prog, msg, act)	\
+	trace_sockmap_redirect((sk), "msg", (prog), (msg)->sg.size, (act))
+
+#define trace_sockmap_skb_redirect(sk, prog, skb, act)		\
+	trace_sockmap_redirect((sk), "skb", (prog), (skb)->len, (act))
+
+TRACE_EVENT(sockmap_redirect,
+	    TP_PROTO(const struct sock *sk, const char *type,
+		     const struct bpf_prog *prog, int length, int act),
+	    TP_ARGS(sk, type, prog, length, act),
+
+	TP_STRUCT__entry(
+		__field(const void *, sk)
+		__field(const char *, type)
+		__field(__u16, family)
+		__field(__u16, protocol)
+		__field(int, prog_id)
+		__field(int, length)
+		__field(int, act)
+	),
+
+	TP_fast_assign(
+		__entry->sk		= sk;
+		__entry->type		= type;
+		__entry->family		= sk->sk_family;
+		__entry->protocol	= sk->sk_protocol;
+		__entry->prog_id	= prog->aux->id;
+		__entry->length		= length;
+		__entry->act		= act;
+	),
+
+	TP_printk("sk=%p, type=%s, family=%d, protocol=%d, prog_id=%d, length=%d, action=%s",
+		  __entry->sk, __entry->type, __entry->family, __entry->protocol,
+		  __entry->prog_id, __entry->length,
+		  show_act(__entry->act))
+);
+
+TRACE_EVENT(sockmap_skb_strp_parse,
+	    TP_PROTO(const struct sock *sk, const struct bpf_prog *prog,
+		     int size),
+	    TP_ARGS(sk, prog, size),
+
+	TP_STRUCT__entry(
+		__field(const void *, sk)
+		__field(__u16, family)
+		__field(__u16, protocol)
+		__field(int, prog_id)
+		__field(int, size)
+	),
+
+	TP_fast_assign(
+		__entry->sk		= sk;
+		__entry->family		= sk->sk_family;
+		__entry->protocol	= sk->sk_protocol;
+		__entry->prog_id	= prog->aux->id;
+		__entry->size		= size;
+	),
+
+	TP_printk("sk=%p, family=%d, protocol=%d, prog_id=%d, size=%d",
+		  __entry->sk, __entry->family, __entry->protocol,
+		  __entry->prog_id, __entry->size)
+);
+#endif /* _TRACE_SOCKMAP_H */
+
+#include <trace/define_trace.h>
diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 0ddc4c718833..9fb948f3b1eb 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -9,6 +9,7 @@
 #include <net/tcp.h>
 #include <net/tls.h>
 #include <trace/events/sock.h>
+#include <trace/events/sockmap.h>
 
 static bool sk_msg_try_coalesce_ok(struct sk_msg *msg, int elem_first_coalesce)
 {
@@ -904,6 +905,7 @@ int sk_psock_msg_verdict(struct sock *sk, struct sk_psock *psock,
 		sock_hold(psock->sk_redir);
 	}
 out:
+	trace_sockmap_skmsg_redirect(sk, prog, msg, ret);
 	rcu_read_unlock();
 	return ret;
 }
@@ -975,6 +977,7 @@ int sk_psock_tls_strp_read(struct sk_psock *psock, struct sk_buff *skb)
 		ret = bpf_prog_run_pin_on_cpu(prog, skb);
 		ret = sk_psock_map_verd(ret, skb_bpf_redirect_fetch(skb));
 		skb->sk = NULL;
+		trace_sockmap_skb_redirect(psock->sk, prog, skb, ret);
 	}
 	sk_psock_tls_verdict_apply(skb, psock, ret);
 	rcu_read_unlock();
@@ -1084,6 +1087,7 @@ static void sk_psock_strp_read(struct strparser *strp, struct sk_buff *skb)
 		skb_bpf_set_strparser(skb);
 		ret = sk_psock_map_verd(ret, skb_bpf_redirect_fetch(skb));
 		skb->sk = NULL;
+		trace_sockmap_skb_redirect(sk, prog, skb, ret);
 	}
 	sk_psock_verdict_apply(psock, skb, ret);
 out:
@@ -1107,6 +1111,7 @@ static int sk_psock_strp_parse(struct strparser *strp, struct sk_buff *skb)
 		skb->sk = psock->sk;
 		ret = bpf_prog_run_pin_on_cpu(prog, skb);
 		skb->sk = NULL;
+		trace_sockmap_skb_strp_parse(psock->sk, prog, ret);
 	}
 	rcu_read_unlock();
 	return ret;
@@ -1211,6 +1216,7 @@ static int sk_psock_verdict_recv(struct sock *sk, struct sk_buff *skb)
 		skb_bpf_redirect_clear(skb);
 		ret = bpf_prog_run_pin_on_cpu(prog, skb);
 		ret = sk_psock_map_verd(ret, skb_bpf_redirect_fetch(skb));
+		trace_sockmap_skb_redirect(psock->sk, prog, skb, ret);
 	}
 	ret = sk_psock_verdict_apply(psock, skb, ret);
 	if (ret < 0)
-- 
2.47.1


