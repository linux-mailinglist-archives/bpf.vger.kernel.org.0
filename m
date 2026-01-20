Return-Path: <bpf+bounces-79622-lists+bpf=lfdr.de@vger.kernel.org>
Delivered-To: lists+bpf@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGDuCBWqb2lUEwAAu9opvQ
	(envelope-from <bpf+bounces-79622-lists+bpf=lfdr.de@vger.kernel.org>)
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 17:15:17 +0100
X-Original-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2D447338
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 17:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2F84474A8AB
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 14:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FCF44D682;
	Tue, 20 Jan 2026 14:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u9VUZEQv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bCMEs+2v"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171D8429819;
	Tue, 20 Jan 2026 14:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768918245; cv=none; b=VgzZbo8ARduLlw5NZ5ICCSvVg97RGr/F4Sr62xejXwkDjNJSR7wd90HeliI01ciTv+G1e3IoEyf2+c4p3LuZPOyIyN62xYt21QsJbi3DvBIF9df9kmGqaSvU9ubB1LWJpQ4dtTEsk/BQ2KUadRCdHQvEi/wgsRpUpMhZLIDNwAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768918245; c=relaxed/simple;
	bh=0gJHssghFK1RP90RiI7zuAI2Lb2IlxOeNNJyTLHYHUk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WGBiEV3OXarkvN6MidWjt3Vgs7Qn6PInulQ5i5Uk6cyUwpZ2y6smBBPcwjRk23kY9i1590+AcrRMOHpq+t4ZShDqQMZhnICfdVP0wz87+aHyCzhnZqlVexAexP5zBherAEFiz9DJc75k9HDinxSwYX/oWt9qeNVqZgCbf5sstys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=u9VUZEQv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bCMEs+2v; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768918241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eOQ8GS3W1MRmodMZgFABkywgFvGKyZPfH1LFL9LoMGY=;
	b=u9VUZEQvWoxHjLBauY8z7HF1TLbuASKHVU93cqLptNcuHLrklRwLfzT96BGKyCwEhnqwLD
	1ZMX/t8cShhT5EtRl90vpDEW3zSszuDu9SS+IGQxTaid54xyPdRLXjLhXKXnfoVy7zNps4
	UutIKbGn7oBe7iBRWgJhbxyp2+kRRhx8c+GmV9BPNsWYOdONd1/fDg0usC1OKEejawa+7u
	7nMQlCflqh1qJaAs144JmX61u23sFBcl+f2xF9ad3PRtsyLVtvzi7T+vZuWC1qPxluQ8+8
	RHEFgpi41jpUbU1BL8pr8O80cRkvtBeolCykT/0mn99+fRhinykiD9iPgPeN/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768918241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eOQ8GS3W1MRmodMZgFABkywgFvGKyZPfH1LFL9LoMGY=;
	b=bCMEs+2vw0GkQWixlwb7IbDDFfOdljaTfGnEqezEY+kbXmb6O17EBN8n+ne5vDNAvKdX3e
	ug6xk5IBRC7RNMAA==
Date: Tue, 20 Jan 2026 15:10:34 +0100
Subject: [PATCH net-next v2 4/4] net: uapi: Provide an UAPI definition of
 'struct sockaddr'
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260120-uapi-sockaddr-v2-4-63c319111cf6@linutronix.de>
References: <20260120-uapi-sockaddr-v2-0-63c319111cf6@linutronix.de>
In-Reply-To: <20260120-uapi-sockaddr-v2-0-63c319111cf6@linutronix.de>
To: Eric Dumazet <edumazet@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, 
 =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
 linux-kselftest@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-security-module@vger.kernel.org, bpf@vger.kernel.org, 
 libc-alpha@sourceware.org, Carlos O'Donell <carlos@redhat.com>, 
 Adhemerval Zanella <adhemerval.zanella@linaro.org>, 
 Rich Felker <dalias@libc.org>, klibc@zytor.com, 
 Florian Weimer <fweimer@redhat.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768918237; l=3848;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=0gJHssghFK1RP90RiI7zuAI2Lb2IlxOeNNJyTLHYHUk=;
 b=Y77GKxsdWINbT9W4Kz+9AEDonn7gqGaLn3W9iGuqEOx5FCQ40NeQXBIqjtdlLcussEkSDha7x
 jGi3PaNWeKJBIq6QM1Pw24wmuBRULo1gD0tfU5AR7dmZpMH2ugb7SDS
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79622-lists,bpf=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[google.com,redhat.com,davemloft.net,kernel.org,digikod.net,iogearbox.net,gmail.com,fomichev.me,linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[41];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[linutronix.de,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomas.weissschuh@linutronix.de,bpf@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TAGGED_RCPT(0.00)[bpf];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:email,linutronix.de:dkim,linutronix.de:mid,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: BF2D447338
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Various UAPI headers reference 'struct sockaddr'. Currently the
definition of this struct is pulled in from the libc header
sys/socket.h. This is problematic as it introduces a dependency
on a full userspace toolchain.

Instead expose a custom but compatible definition of 'struct sockaddr'
in the UAPI headers. It is guarded by the libc compatibility
infrastructure to avoid potential conflicts.

The compatibility symbol won't be supported by glibc right away,
but right now __UAPI_DEF_IF_IFNAMSIZ is not supported either,
so including the libc headers before the UAPI headers is broken anyways.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 include/linux/socket.h           | 10 ----------
 include/uapi/linux/if.h          |  4 ----
 include/uapi/linux/libc-compat.h | 12 ++++++++++++
 include/uapi/linux/socket.h      | 14 ++++++++++++++
 4 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/include/linux/socket.h b/include/linux/socket.h
index ec715ad4bf25..8363d4e0a044 100644
--- a/include/linux/socket.h
+++ b/include/linux/socket.h
@@ -28,16 +28,6 @@ extern void socket_seq_show(struct seq_file *seq);
 
 typedef __kernel_sa_family_t	sa_family_t;
 
-/*
- *	1003.1g requires sa_family_t and that sa_data is char.
- */
-
-/* Deprecated for in-kernel use. Use struct sockaddr_unsized instead. */
-struct sockaddr {
-	sa_family_t	sa_family;	/* address family, AF_xxx	*/
-	char		sa_data[14];	/* 14 bytes of protocol address	*/
-};
-
 /**
  * struct sockaddr_unsized - Unspecified size sockaddr for callbacks
  * @sa_family: Address family (AF_UNIX, AF_INET, AF_INET6, etc.)
diff --git a/include/uapi/linux/if.h b/include/uapi/linux/if.h
index 797ba2c1562a..a4bc54196a07 100644
--- a/include/uapi/linux/if.h
+++ b/include/uapi/linux/if.h
@@ -25,10 +25,6 @@
 #include <linux/socket.h>		/* for "struct sockaddr" et al	*/
 #include <linux/compiler.h>		/* for "__user" et al           */
 
-#ifndef __KERNEL__
-#include <sys/socket.h>			/* for struct sockaddr.		*/
-#endif
-
 #if __UAPI_DEF_IF_IFNAMSIZ
 #define	IFNAMSIZ	16
 #endif /* __UAPI_DEF_IF_IFNAMSIZ */
diff --git a/include/uapi/linux/libc-compat.h b/include/uapi/linux/libc-compat.h
index 0eca95ccb41e..13a06ce4e825 100644
--- a/include/uapi/linux/libc-compat.h
+++ b/include/uapi/linux/libc-compat.h
@@ -140,6 +140,13 @@
 
 #endif /* _NETINET_IN_H */
 
+/* Definitions for socket.h */
+#if defined(_SYS_SOCKET_H)
+#define __UAPI_DEF_SOCKADDR		0
+#else
+#define __UAPI_DEF_SOCKADDR		1
+#endif
+
 /* Definitions for xattr.h */
 #if defined(_SYS_XATTR_H)
 #define __UAPI_DEF_XATTR		0
@@ -221,6 +228,11 @@
 #define __UAPI_DEF_IP6_MTUINFO		1
 #endif
 
+/* Definitions for socket.h */
+#ifndef __UAPI_DEF_SOCKADDR
+#define __UAPI_DEF_SOCKADDR		1
+#endif
+
 /* Definitions for xattr.h */
 #ifndef __UAPI_DEF_XATTR
 #define __UAPI_DEF_XATTR		1
diff --git a/include/uapi/linux/socket.h b/include/uapi/linux/socket.h
index d3fcd3b5ec53..35d7d5f4b1a8 100644
--- a/include/uapi/linux/socket.h
+++ b/include/uapi/linux/socket.h
@@ -2,6 +2,8 @@
 #ifndef _UAPI_LINUX_SOCKET_H
 #define _UAPI_LINUX_SOCKET_H
 
+#include <linux/libc-compat.h>          /* for compatibility with glibc */
+
 /*
  * Desired design of maximum size and alignment (see RFC2553)
  */
@@ -26,6 +28,18 @@ struct __kernel_sockaddr_storage {
 	};
 };
 
+/*
+ *	1003.1g requires sa_family_t and that sa_data is char.
+ */
+
+/* Deprecated for in-kernel use. Use struct sockaddr_unsized instead. */
+#if __UAPI_DEF_SOCKADDR
+struct sockaddr {
+	__kernel_sa_family_t	sa_family;	/* address family, AF_xxx	*/
+	char			sa_data[14];	/* 14 bytes of protocol address	*/
+};
+#endif /* __UAPI_DEF_SOCKADDR */
+
 #define SOCK_SNDBUF_LOCK	1
 #define SOCK_RCVBUF_LOCK	2
 

-- 
2.52.0


