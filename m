Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 152B21CE322
	for <lists+bpf@lfdr.de>; Mon, 11 May 2020 20:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731267AbgEKSwp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 May 2020 14:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731259AbgEKSwm (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 11 May 2020 14:52:42 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C7FC05BD0F
        for <bpf@vger.kernel.org>; Mon, 11 May 2020 11:52:42 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id e16so12314320wra.7
        for <bpf@vger.kernel.org>; Mon, 11 May 2020 11:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iEWx9NWx+iVvT9c6guWm8v93q5pJBOFsw45aCQnsS2o=;
        b=rn9QDejRxWjnube88IJ1I3sbEoNxPlyuucXwVnCkOZgg9RkXLuvr7TGmSgEHVKuANK
         6Y7JHBUdhy0+RH/UGWesc5+Xrram+wNJ317SJpSKLoPWDyntoGw1QIwSMDaZis35Koyw
         AO+/jt8kRwv4jYC/msXrrh7EZipfhyBnubOLQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iEWx9NWx+iVvT9c6guWm8v93q5pJBOFsw45aCQnsS2o=;
        b=kvnL7owHtI66G79u40dj/Ya0skBsgkbyj5ydDX6IWsiVVkQElnfYv4y760n2pq3GrL
         arPPpGaOcilBub9hewfxqcf/v23ahlBi67V0JehPd/BAosv1QThgVATzR95nLNZCvHbo
         x/uK8efsVAlXC0ly+4tBjCsYZndnIldKjPKM7IEypg/KAJN75Y2ubS6ciLBFXKK42iVC
         D8vVw+7kNy4nQbN1xi6SA4lIgiXa6XAVKQVjyhLBltWnvyifwsGntTibxXulQRGpuOhr
         F9pd1A2uTjYTERzdMpbN4Ht/0j8caitIeXw5U0s8JsJgYkbkIa6sVitZGU4+SHdavZZj
         z1vQ==
X-Gm-Message-State: AGi0Pub3IWhQxeVAm9dFIBoKlm2IvHyfOEQIPQhDXbj4bBXo6/5fXH7O
        BCnA/F/5cxhgf+e4h16QiTiL6w==
X-Google-Smtp-Source: APiQypJ73bJM6PxpUfbG6vXTcl6G+xrXXy2TvCHqmviDyjTl9bjH8b6e9lMIZDGJyzVjqqHwrXyYpg==
X-Received: by 2002:a5d:42c9:: with SMTP id t9mr21231809wrr.246.1589223160772;
        Mon, 11 May 2020 11:52:40 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id 88sm19716885wrq.77.2020.05.11.11.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 11:52:40 -0700 (PDT)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     dccp@vger.kernel.org, kernel-team@cloudflare.com,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Gerrit Renker <gerrit@erg.abdn.ac.uk>,
        Jakub Kicinski <kuba@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf-next v2 13/17] bpf: Sync linux/bpf.h to tools/
Date:   Mon, 11 May 2020 20:52:14 +0200
Message-Id: <20200511185218.1422406-14-jakub@cloudflare.com>
X-Mailer: git-send-email 2.25.3
In-Reply-To: <20200511185218.1422406-1-jakub@cloudflare.com>
References: <20200511185218.1422406-1-jakub@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Newly added program, context type and helper is used by tests in a
subsequent patch. Synchronize the header file.

Reviewed-by: Lorenz Bauer <lmb@cloudflare.com>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---

Notes:
    v2:
    - Update after changes to bpf.h in earlier patch.

 tools/include/uapi/linux/bpf.h | 52 ++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 9d1932e23cec..03edf4ec7b7e 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -188,6 +188,7 @@ enum bpf_prog_type {
 	BPF_PROG_TYPE_STRUCT_OPS,
 	BPF_PROG_TYPE_EXT,
 	BPF_PROG_TYPE_LSM,
+	BPF_PROG_TYPE_SK_LOOKUP,
 };
 
 enum bpf_attach_type {
@@ -220,6 +221,7 @@ enum bpf_attach_type {
 	BPF_MODIFY_RETURN,
 	BPF_LSM_MAC,
 	BPF_TRACE_ITER,
+	BPF_SK_LOOKUP,
 	__MAX_BPF_ATTACH_TYPE
 };
 
@@ -3050,6 +3052,10 @@ union bpf_attr {
  *
  * int bpf_sk_assign(struct sk_buff *skb, struct bpf_sock *sk, u64 flags)
  *	Description
+ *		Helper is overloaded depending on BPF program type. This
+ *		description applies to **BPF_PROG_TYPE_SCHED_CLS** and
+ *		**BPF_PROG_TYPE_SCHED_ACT** programs.
+ *
  *		Assign the *sk* to the *skb*. When combined with appropriate
  *		routing configuration to receive the packet towards the socket,
  *		will cause *skb* to be delivered to the specified socket.
@@ -3070,6 +3076,38 @@ union bpf_attr {
  *					call from outside of TC ingress.
  *		* **-ESOCKTNOSUPPORT**	Socket type not supported (reuseport).
  *
+ * int bpf_sk_assign(struct bpf_sk_lookup *ctx, struct bpf_sock *sk, u64 flags)
+ *	Description
+ *		Helper is overloaded depending on BPF program type. This
+ *		description applies to **BPF_PROG_TYPE_SK_LOOKUP** programs.
+ *
+ *		Select the *sk* as a result of a socket lookup.
+ *
+ *		For the operation to succeed passed socket must be compatible
+ *		with the packet description provided by the *ctx* object.
+ *
+ *		L4 protocol (*IPPROTO_TCP* or *IPPROTO_UDP*) must be an exact
+ *		match. While IP family (*AF_INET* or *AF_INET6*) must be
+ *		compatible, that is IPv6 sockets that are not v6-only can be
+ *		selected for IPv4 packets.
+ *
+ *		Only TCP listeners and UDP sockets, that is sockets which have
+ *		*SOCK_RCU_FREE* flag set, can be selected.
+ *
+ *		The *flags* argument must be zero.
+ *	Return
+ *		0 on success, or a negative errno in case of failure.
+ *
+ *		**-EAFNOSUPPORT** is socket family (*sk->family*) is not
+ *		compatible with packet family (*ctx->family*).
+ *
+ *		**-EINVAL** if unsupported flags were specified.
+ *
+ *		**-EPROTOTYPE** if socket L4 protocol (*sk->protocol*) doesn't
+ *		match packet protocol (*ctx->protocol*).
+ *
+ *		**-ESOCKTNOSUPPORT** if socket does not use RCU freeing.
+ *
  * u64 bpf_ktime_get_boot_ns(void)
  * 	Description
  * 		Return the time elapsed since system boot, in nanoseconds.
@@ -4058,4 +4096,18 @@ struct bpf_pidns_info {
 	__u32 pid;
 	__u32 tgid;
 };
+
+/* User accessible data for SK_LOOKUP programs. Add new fields at the end. */
+struct bpf_sk_lookup {
+	__u32 family;		/* Protocol family (AF_INET, AF_INET6) */
+	__u32 protocol;		/* IP protocol (IPPROTO_TCP, IPPROTO_UDP) */
+	/* IP addresses allow 1,2,4-byte read and are in network byte order. */
+	__u32 remote_ip4;
+	__u32 remote_ip6[4];
+	__u32 remote_port;	/* network byte order */
+	__u32 local_ip4;
+	__u32 local_ip6[4];
+	__u32 local_port;	/* host byte order */
+};
+
 #endif /* _UAPI__LINUX_BPF_H__ */
-- 
2.25.3

