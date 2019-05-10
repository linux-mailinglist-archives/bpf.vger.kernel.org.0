Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8E8F19F93
	for <lists+bpf@lfdr.de>; Fri, 10 May 2019 16:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbfEJOvp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 May 2019 10:51:45 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39831 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727497AbfEJOvo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 May 2019 10:51:44 -0400
Received: by mail-wm1-f65.google.com with SMTP id n25so7771483wmk.4
        for <bpf@vger.kernel.org>; Fri, 10 May 2019 07:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+IUrU0HbHrpGdy/7krlh/fE3iwWu7P+Dj/LIBD0TCto=;
        b=LySJhNneq3KYgwhN58ZFnSggLsKGyyDsRnrZ2oysf3dSwqBg6kzHFNFPOadd13on0q
         eYSam0/V+SQNL8gz+s88/im0Qu1UL8U2TyacaIZZCoA5i3hpu0NQ7iHeO68V7niYyTJG
         3IhtVUx2hJCPcsLM4m1xVqIPUPz2E6ZpbEuuK9c7yllCfK61TBp3gFqrcod4mzkBLEui
         aPGLlS68AXFSYlHxbeLMB/JEpnFfH+ooR4o2Pqomgh5q63J/F+HKfvIUaKpTjNl1CmQU
         LsVufQTcXhPvL84bAsoFUzTA67pzBjtuKBeifU0/5txdM5R77b4TVZoB8tDIFTVg5SLj
         ybBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+IUrU0HbHrpGdy/7krlh/fE3iwWu7P+Dj/LIBD0TCto=;
        b=FY8R2AnGuaw++wsTFlh56lehnXD1bOOm7Xrp7U3lqI9FRWjTRc399U+rUa7HeHdwQ5
         p/Xg/RCQNoK50KeiV94jgc07zQZwcNw9uhJxsw+RItgrFiiJHb4WlDchU97BQH9WJLqs
         GpsDbhJKDUeRIsgs67Os5IYBGOtviI+l/yx8UvVXnIr0vuDuJu2abzoR2eTjhhCEApRh
         6l4og9hgcXAvoqoxWHITLKUeGdXotgdMQw2LbESukkRbvkIuKEDsPfv8vwdmaYDuBzVS
         eQkluwisDRhk0NLR+jCJDNjtMESyTjBLP0vM3jUy+VOoT75A5Cuuq6olmWKL5vYgXlNR
         la6w==
X-Gm-Message-State: APjAAAUNTsLArnBi/rNHV+LNtcmvg8yMoZsk+iKQhizytinhLjGsFMMQ
        Df6/rAXjZsFOxvG4s2Rox0XpxQ==
X-Google-Smtp-Source: APXvYqx9kAToLnO+avIYmMZOgXUR8sPIhAfSD52JGDHX/yqD8QoHSxz225AN0RBGeHXqUMkyPJB5iA==
X-Received: by 2002:a1c:b4d4:: with SMTP id d203mr7150078wmf.34.1557499902576;
        Fri, 10 May 2019 07:51:42 -0700 (PDT)
Received: from reblochon.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id p17sm7561027wrg.92.2019.05.10.07.51.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 07:51:41 -0700 (PDT)
From:   Quentin Monnet <quentin.monnet@netronome.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Yonghong Song <yhs@fb.com>
Subject: [PATCH bpf 3/4] bpf: fix minor issues in documentation for BPF helpers.
Date:   Fri, 10 May 2019 15:51:24 +0100
Message-Id: <20190510145125.8416-4-quentin.monnet@netronome.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20190510145125.8416-1-quentin.monnet@netronome.com>
References: <20190510145125.8416-1-quentin.monnet@netronome.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This commit brings many minor fixes to the documentation for BPF helper
functions. Mostly, this is limited to formatting fixes and improvements.
In particular, fix broken formatting for bpf_skb_adjust_room().

Besides formatting, replace the mention of "bpf_fullsock()" (that is not
associated with any function or type exposed to the user) in the
description of bpf_sk_storage_get() by "full socket".

Signed-off-by: Quentin Monnet <quentin.monnet@netronome.com>
Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>
---
 include/uapi/linux/bpf.h | 103 +++++++++++++++++++++++++----------------------
 1 file changed, 54 insertions(+), 49 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 989ef6b1c269..63e0cf66f01a 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1518,18 +1518,18 @@ union bpf_attr {
  *		* **BPF_F_ADJ_ROOM_FIXED_GSO**: Do not adjust gso_size.
  *		  Adjusting mss in this way is not allowed for datagrams.
  *
- *		* **BPF_F_ADJ_ROOM_ENCAP_L3_IPV4 **:
- *		* **BPF_F_ADJ_ROOM_ENCAP_L3_IPV6 **:
+ *		* **BPF_F_ADJ_ROOM_ENCAP_L3_IPV4**,
+ *		  **BPF_F_ADJ_ROOM_ENCAP_L3_IPV6**:
  *		  Any new space is reserved to hold a tunnel header.
  *		  Configure skb offsets and other fields accordingly.
  *
- *		* **BPF_F_ADJ_ROOM_ENCAP_L4_GRE **:
- *		* **BPF_F_ADJ_ROOM_ENCAP_L4_UDP **:
+ *		* **BPF_F_ADJ_ROOM_ENCAP_L4_GRE**,
+ *		  **BPF_F_ADJ_ROOM_ENCAP_L4_UDP**:
  *		  Use with ENCAP_L3 flags to further specify the tunnel type.
  *
- *		* **BPF_F_ADJ_ROOM_ENCAP_L2(len) **:
+ *		* **BPF_F_ADJ_ROOM_ENCAP_L2**\ (*len*):
  *		  Use with ENCAP_L3/L4 flags to further specify the tunnel
- *		  type; **len** is the length of the inner MAC header.
+ *		  type; *len* is the length of the inner MAC header.
  *
  * 		A call to this helper is susceptible to change the underlying
  * 		packet buffer. Therefore, at load time, all checks on pointers
@@ -2061,16 +2061,16 @@ union bpf_attr {
  *		**BPF_LWT_ENCAP_IP**
  *			IP encapsulation (GRE/GUE/IPIP/etc). The outer header
  *			must be IPv4 or IPv6, followed by zero or more
- *			additional headers, up to LWT_BPF_MAX_HEADROOM total
- *			bytes in all prepended headers. Please note that
- *			if skb_is_gso(skb) is true, no more than two headers
- *			can be prepended, and the inner header, if present,
- *			should be either GRE or UDP/GUE.
+ *			additional headers, up to **LWT_BPF_MAX_HEADROOM**
+ *			total bytes in all prepended headers. Please note that
+ *			if **skb_is_gso**\ (*skb*) is true, no more than two
+ *			headers can be prepended, and the inner header, if
+ *			present, should be either GRE or UDP/GUE.
  *
- *		BPF_LWT_ENCAP_SEG6*** types can be called by bpf programs of
- *		type BPF_PROG_TYPE_LWT_IN; BPF_LWT_ENCAP_IP type can be called
- *		by bpf programs of types BPF_PROG_TYPE_LWT_IN and
- *		BPF_PROG_TYPE_LWT_XMIT.
+ *		**BPF_LWT_ENCAP_SEG6**\ \* types can be called by BPF programs
+ *		of type **BPF_PROG_TYPE_LWT_IN**; **BPF_LWT_ENCAP_IP** type can
+ *		be called by bpf programs of types **BPF_PROG_TYPE_LWT_IN** and
+ *		**BPF_PROG_TYPE_LWT_XMIT**.
  *
  * 		A call to this helper is susceptible to change the underlying
  * 		packet buffer. Therefore, at load time, all checks on pointers
@@ -2126,11 +2126,11 @@ union bpf_attr {
  *			Type of *param*: **int**.
  *		**SEG6_LOCAL_ACTION_END_B6**
  *			End.B6 action: Endpoint bound to an SRv6 policy.
- *			Type of param: **struct ipv6_sr_hdr**.
+ *			Type of *param*: **struct ipv6_sr_hdr**.
  *		**SEG6_LOCAL_ACTION_END_B6_ENCAP**
  *			End.B6.Encap action: Endpoint bound to an SRv6
  *			encapsulation policy.
- *			Type of param: **struct ipv6_sr_hdr**.
+ *			Type of *param*: **struct ipv6_sr_hdr**.
  *
  * 		A call to this helper is susceptible to change the underlying
  * 		packet buffer. Therefore, at load time, all checks on pointers
@@ -2285,7 +2285,8 @@ union bpf_attr {
  *	Return
  *		Pointer to **struct bpf_sock**, or **NULL** in case of failure.
  *		For sockets with reuseport option, the **struct bpf_sock**
- *		result is from **reuse->socks**\ [] using the hash of the tuple.
+ *		result is from *reuse*\ **->socks**\ [] using the hash of the
+ *		tuple.
  *
  * struct bpf_sock *bpf_sk_lookup_udp(void *ctx, struct bpf_sock_tuple *tuple, u32 tuple_size, u64 netns, u64 flags)
  *	Description
@@ -2321,7 +2322,8 @@ union bpf_attr {
  *	Return
  *		Pointer to **struct bpf_sock**, or **NULL** in case of failure.
  *		For sockets with reuseport option, the **struct bpf_sock**
- *		result is from **reuse->socks**\ [] using the hash of the tuple.
+ *		result is from *reuse*\ **->socks**\ [] using the hash of the
+ *		tuple.
  *
  * int bpf_sk_release(struct bpf_sock *sock)
  *	Description
@@ -2490,31 +2492,34 @@ union bpf_attr {
  *		network namespace *netns*. The return value must be checked,
  *		and if non-**NULL**, released via **bpf_sk_release**\ ().
  *
- *		This function is identical to bpf_sk_lookup_tcp, except that it
- *		also returns timewait or request sockets. Use bpf_sk_fullsock
- *		or bpf_tcp_socket to access the full structure.
+ *		This function is identical to **bpf_sk_lookup_tcp**\ (), except
+ *		that it also returns timewait or request sockets. Use
+ *		**bpf_sk_fullsock**\ () or **bpf_tcp_sock**\ () to access the
+ *		full structure.
  *
  *		This helper is available only if the kernel was compiled with
  *		**CONFIG_NET** configuration option.
  *	Return
  *		Pointer to **struct bpf_sock**, or **NULL** in case of failure.
  *		For sockets with reuseport option, the **struct bpf_sock**
- *		result is from **reuse->socks**\ [] using the hash of the tuple.
+ *		result is from *reuse*\ **->socks**\ [] using the hash of the
+ *		tuple.
  *
  * int bpf_tcp_check_syncookie(struct bpf_sock *sk, void *iph, u32 iph_len, struct tcphdr *th, u32 th_len)
  * 	Description
- * 		Check whether iph and th contain a valid SYN cookie ACK for
- * 		the listening socket in sk.
+ * 		Check whether *iph* and *th* contain a valid SYN cookie ACK for
+ * 		the listening socket in *sk*.
  *
- * 		iph points to the start of the IPv4 or IPv6 header, while
- * 		iph_len contains sizeof(struct iphdr) or sizeof(struct ip6hdr).
+ * 		*iph* points to the start of the IPv4 or IPv6 header, while
+ * 		*iph_len* contains **sizeof**\ (**struct iphdr**) or
+ * 		**sizeof**\ (**struct ip6hdr**).
  *
- * 		th points to the start of the TCP header, while th_len contains
- * 		sizeof(struct tcphdr).
+ * 		*th* points to the start of the TCP header, while *th_len*
+ * 		contains **sizeof**\ (**struct tcphdr**).
  *
  * 	Return
- * 		0 if iph and th are a valid SYN cookie ACK, or a negative error
- * 		otherwise.
+ * 		0 if *iph* and *th* are a valid SYN cookie ACK, or a negative
+ * 		error otherwise.
  *
  * int bpf_sysctl_get_name(struct bpf_sysctl *ctx, char *buf, size_t buf_len, u64 flags)
  *	Description
@@ -2592,17 +2597,17 @@ union bpf_attr {
  *		and save the result in *res*.
  *
  *		The string may begin with an arbitrary amount of white space
- *		(as determined by isspace(3)) followed by a single optional '-'
- *		sign.
+ *		(as determined by **isspace**\ (3)) followed by a single
+ *		optional '**-**' sign.
  *
  *		Five least significant bits of *flags* encode base, other bits
  *		are currently unused.
  *
  *		Base must be either 8, 10, 16 or 0 to detect it automatically
- *		similar to user space strtol(3).
+ *		similar to user space **strtol**\ (3).
  *	Return
  *		Number of characters consumed on success. Must be positive but
- *		no more than buf_len.
+ *		no more than *buf_len*.
  *
  *		**-EINVAL** if no valid digits were found or unsupported base
  *		was provided.
@@ -2616,16 +2621,16 @@ union bpf_attr {
  *		given base and save the result in *res*.
  *
  *		The string may begin with an arbitrary amount of white space
- *		(as determined by isspace(3)).
+ *		(as determined by **isspace**\ (3)).
  *
  *		Five least significant bits of *flags* encode base, other bits
  *		are currently unused.
  *
  *		Base must be either 8, 10, 16 or 0 to detect it automatically
- *		similar to user space strtoul(3).
+ *		similar to user space **strtoul**\ (3).
  *	Return
  *		Number of characters consumed on success. Must be positive but
- *		no more than buf_len.
+ *		no more than *buf_len*.
  *
  *		**-EINVAL** if no valid digits were found or unsupported base
  *		was provided.
@@ -2634,26 +2639,26 @@ union bpf_attr {
  *
  * void *bpf_sk_storage_get(struct bpf_map *map, struct bpf_sock *sk, void *value, u64 flags)
  *	Description
- *		Get a bpf-local-storage from a sk.
+ *		Get a bpf-local-storage from a *sk*.
  *
  *		Logically, it could be thought of getting the value from
  *		a *map* with *sk* as the **key**.  From this
  *		perspective,  the usage is not much different from
- *		**bpf_map_lookup_elem(map, &sk)** except this
- *		helper enforces the key must be a **bpf_fullsock()**
- *		and the map must be a BPF_MAP_TYPE_SK_STORAGE also.
+ *		**bpf_map_lookup_elem**\ (*map*, **&**\ *sk*) except this
+ *		helper enforces the key must be a full socket and the map must
+ *		be a **BPF_MAP_TYPE_SK_STORAGE** also.
  *
  *		Underneath, the value is stored locally at *sk* instead of
- *		the map.  The *map* is used as the bpf-local-storage **type**.
- *		The bpf-local-storage **type** (i.e. the *map*) is searched
- *		against all bpf-local-storages residing at sk.
+ *		the *map*.  The *map* is used as the bpf-local-storage
+ *		"type". The bpf-local-storage "type" (i.e. the *map*) is
+ *		searched against all bpf-local-storages residing at *sk*.
  *
- *		An optional *flags* (BPF_SK_STORAGE_GET_F_CREATE) can be
+ *		An optional *flags* (**BPF_SK_STORAGE_GET_F_CREATE**) can be
  *		used such that a new bpf-local-storage will be
  *		created if one does not exist.  *value* can be used
- *		together with BPF_SK_STORAGE_GET_F_CREATE to specify
+ *		together with **BPF_SK_STORAGE_GET_F_CREATE** to specify
  *		the initial value of a bpf-local-storage.  If *value* is
- *		NULL, the new bpf-local-storage will be zero initialized.
+ *		**NULL**, the new bpf-local-storage will be zero initialized.
  *	Return
  *		A bpf-local-storage pointer is returned on success.
  *
@@ -2662,7 +2667,7 @@ union bpf_attr {
  *
  * int bpf_sk_storage_delete(struct bpf_map *map, struct bpf_sock *sk)
  *	Description
- *		Delete a bpf-local-storage from a sk.
+ *		Delete a bpf-local-storage from a *sk*.
  *	Return
  *		0 on success.
  *
-- 
2.14.1

