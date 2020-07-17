Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6DBC223977
	for <lists+bpf@lfdr.de>; Fri, 17 Jul 2020 12:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbgGQKgT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Jul 2020 06:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726665AbgGQKf5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Jul 2020 06:35:57 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6092AC061755
        for <bpf@vger.kernel.org>; Fri, 17 Jul 2020 03:35:57 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id y13so5749392lfe.9
        for <bpf@vger.kernel.org>; Fri, 17 Jul 2020 03:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B0ReOo3p1K7oQdDbS0TDhngQwbmCubp5h/vccC9mTaw=;
        b=sUaOelIWtPMVUBt+/sqBS6k6rSErSKJi8Ajd7J5qC0G24AjReC7GOTGcW4j8pX3X6P
         zFZi4eYSkf4ICbJvGARwzotLhVC/ffGhHiTuO3GZ+HAX47oeZmuJjcbiwIwgnMoCgvMZ
         dX8081wfis5YkblyLHjc8zQTwB88n6bWvkZHg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B0ReOo3p1K7oQdDbS0TDhngQwbmCubp5h/vccC9mTaw=;
        b=FJj8YHxsZnoSPskduYrBRnm+dSjTwCZaaPFxNw5z8lullYNITcisEBf6n9loHRjgmi
         pAPU5PtTNcYnZWWBx+C+E+HlWet/BN3WyM28Y/t+nByP+OCC1GCEOSNf87IccA9J3x1l
         YJMWYU7zP9w2IvD6IpQJNYvIn/HvIi/0H4Ov2Y9UJNu6kxX2QiwP3lAherWow9/dUsKe
         HV+EkFtJSYys0t4NLOOHt3eZyKn6h13T9JRaiGJdaW1dKaf4ImCJLG6XP36nsL+dCq2w
         Qs3tu1GiG1TSCbZLO1d1WNETOvDkt9UDinnpaFoJfC2rGo0VoZ+7AFk8Mw1J1cu3tp2z
         LVNQ==
X-Gm-Message-State: AOAM533AqGuvHdxvSZ6WIvvDibTp/SeJRhUpKEqSh4rlXTHJOK6dBMbr
        yh5vcuf32XWTqtNTaA8O+OncviZvZT7ilA==
X-Google-Smtp-Source: ABdhPJz2J9WV+5ZiAMJ/HCks+J4/C/arStuyLRjL1BlcUreG3wwMAYR1ScngCei8vhGzYLeRZQf45w==
X-Received: by 2002:a19:c1d1:: with SMTP id r200mr4352532lff.102.1594982155460;
        Fri, 17 Jul 2020 03:35:55 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id l14sm1785809lfj.13.2020.07.17.03.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 03:35:54 -0700 (PDT)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, kernel-team@cloudflare.com,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>
Subject: [PATCH bpf-next v5 11/15] bpf: Sync linux/bpf.h to tools/
Date:   Fri, 17 Jul 2020 12:35:32 +0200
Message-Id: <20200717103536.397595-12-jakub@cloudflare.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200717103536.397595-1-jakub@cloudflare.com>
References: <20200717103536.397595-1-jakub@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Newly added program, context type and helper is used by tests in a
subsequent patch. Synchronize the header file.

Acked-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---

Notes:
    v4:
    - Update after changes to bpf.h in earlier patch.
    
    v3:
    - Update after changes to bpf.h in earlier patch.
    
    v2:
    - Update after changes to bpf.h in earlier patch.

 tools/include/uapi/linux/bpf.h | 77 ++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 7ac3992dacfe..54d0c886e3ba 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -189,6 +189,7 @@ enum bpf_prog_type {
 	BPF_PROG_TYPE_STRUCT_OPS,
 	BPF_PROG_TYPE_EXT,
 	BPF_PROG_TYPE_LSM,
+	BPF_PROG_TYPE_SK_LOOKUP,
 };
 
 enum bpf_attach_type {
@@ -228,6 +229,7 @@ enum bpf_attach_type {
 	BPF_XDP_DEVMAP,
 	BPF_CGROUP_INET_SOCK_RELEASE,
 	BPF_XDP_CPUMAP,
+	BPF_SK_LOOKUP,
 	__MAX_BPF_ATTACH_TYPE
 };
 
@@ -3069,6 +3071,10 @@ union bpf_attr {
  *
  * long bpf_sk_assign(struct sk_buff *skb, struct bpf_sock *sk, u64 flags)
  *	Description
+ *		Helper is overloaded depending on BPF program type. This
+ *		description applies to **BPF_PROG_TYPE_SCHED_CLS** and
+ *		**BPF_PROG_TYPE_SCHED_ACT** programs.
+ *
  *		Assign the *sk* to the *skb*. When combined with appropriate
  *		routing configuration to receive the packet towards the socket,
  *		will cause *skb* to be delivered to the specified socket.
@@ -3094,6 +3100,56 @@ union bpf_attr {
  *		**-ESOCKTNOSUPPORT** if the socket type is not supported
  *		(reuseport).
  *
+ * long bpf_sk_assign(struct bpf_sk_lookup *ctx, struct bpf_sock *sk, u64 flags)
+ *	Description
+ *		Helper is overloaded depending on BPF program type. This
+ *		description applies to **BPF_PROG_TYPE_SK_LOOKUP** programs.
+ *
+ *		Select the *sk* as a result of a socket lookup.
+ *
+ *		For the operation to succeed passed socket must be compatible
+ *		with the packet description provided by the *ctx* object.
+ *
+ *		L4 protocol (**IPPROTO_TCP** or **IPPROTO_UDP**) must
+ *		be an exact match. While IP family (**AF_INET** or
+ *		**AF_INET6**) must be compatible, that is IPv6 sockets
+ *		that are not v6-only can be selected for IPv4 packets.
+ *
+ *		Only TCP listeners and UDP unconnected sockets can be
+ *		selected. *sk* can also be NULL to reset any previous
+ *		selection.
+ *
+ *		*flags* argument can combination of following values:
+ *
+ *		* **BPF_SK_LOOKUP_F_REPLACE** to override the previous
+ *		  socket selection, potentially done by a BPF program
+ *		  that ran before us.
+ *
+ *		* **BPF_SK_LOOKUP_F_NO_REUSEPORT** to skip
+ *		  load-balancing within reuseport group for the socket
+ *		  being selected.
+ *
+ *		On success *ctx->sk* will point to the selected socket.
+ *
+ *	Return
+ *		0 on success, or a negative errno in case of failure.
+ *
+ *		* **-EAFNOSUPPORT** if socket family (*sk->family*) is
+ *		  not compatible with packet family (*ctx->family*).
+ *
+ *		* **-EEXIST** if socket has been already selected,
+ *		  potentially by another program, and
+ *		  **BPF_SK_LOOKUP_F_REPLACE** flag was not specified.
+ *
+ *		* **-EINVAL** if unsupported flags were specified.
+ *
+ *		* **-EPROTOTYPE** if socket L4 protocol
+ *		  (*sk->protocol*) doesn't match packet protocol
+ *		  (*ctx->protocol*).
+ *
+ *		* **-ESOCKTNOSUPPORT** if socket is not in allowed
+ *		  state (TCP listening or UDP unconnected).
+ *
  * u64 bpf_ktime_get_boot_ns(void)
  * 	Description
  * 		Return the time elapsed since system boot, in nanoseconds.
@@ -3607,6 +3663,12 @@ enum {
 	BPF_RINGBUF_HDR_SZ		= 8,
 };
 
+/* BPF_FUNC_sk_assign flags in bpf_sk_lookup context. */
+enum {
+	BPF_SK_LOOKUP_F_REPLACE		= (1ULL << 0),
+	BPF_SK_LOOKUP_F_NO_REUSEPORT	= (1ULL << 1),
+};
+
 /* Mode for BPF_FUNC_skb_adjust_room helper. */
 enum bpf_adj_room_mode {
 	BPF_ADJ_ROOM_NET,
@@ -4349,4 +4411,19 @@ struct bpf_pidns_info {
 	__u32 pid;
 	__u32 tgid;
 };
+
+/* User accessible data for SK_LOOKUP programs. Add new fields at the end. */
+struct bpf_sk_lookup {
+	__bpf_md_ptr(struct bpf_sock *, sk); /* Selected socket */
+
+	__u32 family;		/* Protocol family (AF_INET, AF_INET6) */
+	__u32 protocol;		/* IP protocol (IPPROTO_TCP, IPPROTO_UDP) */
+	__u32 remote_ip4;	/* Network byte order */
+	__u32 remote_ip6[4];	/* Network byte order */
+	__u32 remote_port;	/* Network byte order */
+	__u32 local_ip4;	/* Network byte order */
+	__u32 local_ip6[4];	/* Network byte order */
+	__u32 local_port;	/* Host byte order */
+};
+
 #endif /* _UAPI__LINUX_BPF_H__ */
-- 
2.25.4

