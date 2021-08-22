Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2178B3F3F24
	for <lists+bpf@lfdr.de>; Sun, 22 Aug 2021 13:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbhHVL7q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 22 Aug 2021 07:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbhHVL7q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 22 Aug 2021 07:59:46 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4FBC061575
        for <bpf@vger.kernel.org>; Sun, 22 Aug 2021 04:59:04 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id s3so9283485edd.11
        for <bpf@vger.kernel.org>; Sun, 22 Aug 2021 04:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rTcttb0oRubPcSA3PFaGaTX551G+NYW0Pq0tAVMxstc=;
        b=VAEB6MnNCyXFF0u2dR+4hVXL3PfNE2d+zGO3cxsZNYn0XCy7Hn1aGyxSvkebJOxpfk
         niZ7QSbM2CnPhlpCud7uqYpwwMe0ZPYuz+p65+JmOuhLj8OszJ4RBtcwwDhurp3omJhg
         AT8G5g8Up8I/pvxuvrOBOHUWhqbtGS1549kDP+NvZP2gwo0Marb2Kd0owQiHVQgNhZRO
         ySTNWIzMmzUu7viKuXZ1Rj0GixtDc5zNlZ2oURJ2qlKIrhDue3rSwvvKgQ3fJWYNYT9A
         VOugHniWBvIv0j6CsUTTRqRUlHfg8wSt4a2DWcPjwQHtW0nkv0DUs5MwCbvPiZNDK7dE
         WoTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rTcttb0oRubPcSA3PFaGaTX551G+NYW0Pq0tAVMxstc=;
        b=AZThVdGE/tekFLjuGwN4nI1sb4HsVCZ3JnF0ZlAPgtc73G97mj8DtL6jhJGJVXohVI
         ZnjghFcwC+ikUcT39FGB4kCAZbYN6BrkQD+LQWNi+CJKx4G9MFiYUMwljL+iZvXEU1wD
         RvG75Ae8aEM9JPTQCLoCF2BTgjp9rwPhpNN/xacKpxful7t7q6h/I/2rlu8EVhB/EWhq
         DCpsHAOA8047QUthXXdge2+PW0QUdUv0ViplavD6qE6o5f4xD77vn/ca7nKGpEvk1sKG
         DvzP6tzGmeLxOzFeyEnqNOH0/XgvK+HF2bygy9i8dMhA7ER1Vs9WCJoQJ0fR5Yoy/dyz
         q5+Q==
X-Gm-Message-State: AOAM531EjQFGjILZD9xonI0gHbp6WdTcHT9cJBHIRlDOALCsGowtRENh
        xTj+wBfU46/VXqfWSfbhflLoxZWfwUc3/A==
X-Google-Smtp-Source: ABdhPJxQlmMwd1PFzhRkcqkWYdzzZHcNTPlmIrBxKYgeTWPram6HkE8erOCT7mNzs5CwJsIXvyAquA==
X-Received: by 2002:a05:6402:8ce:: with SMTP id d14mr32073341edz.228.1629633542163;
        Sun, 22 Aug 2021 04:59:02 -0700 (PDT)
Received: from riversong.fontana.family (host-79-20-93-131.retail.telecomitalia.it. [79.20.93.131])
        by smtp.gmail.com with ESMTPSA id s24sm7147120edq.56.2021.08.22.04.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 04:59:01 -0700 (PDT)
From:   Lorenzo Fontana <fontanalorenz@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Quentin Monnet <quentin@isovalent.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Lorenzo Fontana <fontanalorenz@gmail.com>
Subject: [PATCH bpf-next] bpf: add helpers documentation about GPL compatibility
Date:   Sun, 22 Aug 2021 13:59:00 +0200
Message-Id: <20210822115900.26815-1-fontanalorenz@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When writing BPF programs one might refer to the man page
to lookup helpers. When you do so, however you don't have
a way to immediately know if you can use the helper
based on your program licensing requirements.

This patch adds a specific line in the man bpf-helpers
to show that information straight away.

Signed-off-by: Lorenzo Fontana <fontanalorenz@gmail.com>
---
 include/uapi/linux/bpf.h       | 336 +++++++++++++++++++++++++++++++++
 scripts/bpf_doc.py             |  34 +++-
 tools/include/uapi/linux/bpf.h | 336 +++++++++++++++++++++++++++++++++
 3 files changed, 704 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index c4f7892edb2b..2c03010024e3 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1512,6 +1512,8 @@ union bpf_attr {
  * 	Return
  * 		Map value associated to *key*, or **NULL** if no entry was
  * 		found.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_map_update_elem(struct bpf_map *map, const void *key, const void *value, u64 flags)
  * 	Description
@@ -1530,6 +1532,8 @@ union bpf_attr {
  * 		elements always exist), the helper would return an error.
  * 	Return
  * 		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_map_delete_elem(struct bpf_map *map, const void *key)
  * 	Description
@@ -1546,6 +1550,8 @@ union bpf_attr {
  * 		**bpf_probe_read_kernel**\ () instead.
  * 	Return
  * 		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * u64 bpf_ktime_get_ns(void)
  * 	Description
@@ -1554,6 +1560,8 @@ union bpf_attr {
  * 		See: **clock_gettime**\ (**CLOCK_MONOTONIC**)
  * 	Return
  * 		Current *ktime*.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_trace_printk(const char *fmt, u32 fmt_size, ...)
  * 	Description
@@ -1613,6 +1621,8 @@ union bpf_attr {
  * 	Return
  * 		The number of bytes written to the buffer, or a negative error
  * 		in case of failure.
+ * 	GPL Compatibility
+ * 		Required
  *
  * u32 bpf_get_prandom_u32(void)
  * 	Description
@@ -1625,6 +1635,8 @@ union bpf_attr {
  * 		cryptographically secure.
  * 	Return
  * 		A random 32-bit unsigned value.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * u32 bpf_get_smp_processor_id(void)
  * 	Description
@@ -1634,6 +1646,8 @@ union bpf_attr {
  * 		program.
  * 	Return
  * 		The SMP id of the processor running the program.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_skb_store_bytes(struct sk_buff *skb, u32 offset, const void *from, u32 len, u64 flags)
  * 	Description
@@ -1651,6 +1665,8 @@ union bpf_attr {
  * 		direct packet access.
  * 	Return
  * 		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_l3_csum_replace(struct sk_buff *skb, u32 offset, u64 from, u64 to, u64 size)
  * 	Description
@@ -1676,6 +1692,8 @@ union bpf_attr {
  * 		direct packet access.
  * 	Return
  * 		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_l4_csum_replace(struct sk_buff *skb, u32 offset, u64 from, u64 to, u64 flags)
  * 	Description
@@ -1708,6 +1726,8 @@ union bpf_attr {
  * 		direct packet access.
  * 	Return
  * 		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_tail_call(void *ctx, struct bpf_map *prog_array_map, u32 index)
  * 	Description
@@ -1739,6 +1759,8 @@ union bpf_attr {
  * 		which is currently set to 32.
  * 	Return
  * 		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_clone_redirect(struct sk_buff *skb, u32 ifindex, u64 flags)
  * 	Description
@@ -1763,6 +1785,8 @@ union bpf_attr {
  * 		direct packet access.
  * 	Return
  * 		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * u64 bpf_get_current_pid_tgid(void)
  * 	Return
@@ -1770,11 +1794,15 @@ union bpf_attr {
  * 		created as such:
  * 		*current_task*\ **->tgid << 32 \|**
  * 		*current_task*\ **->pid**.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * u64 bpf_get_current_uid_gid(void)
  * 	Return
  * 		A 64-bit integer containing the current GID and UID, and
  * 		created as such: *current_gid* **<< 32 \|** *current_uid*.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_get_current_comm(void *buf, u32 size_of_buf)
  * 	Description
@@ -1786,6 +1814,8 @@ union bpf_attr {
  * 		it is filled with zeroes.
  * 	Return
  * 		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * u32 bpf_get_cgroup_classid(struct sk_buff *skb)
  * 	Description
@@ -1812,6 +1842,8 @@ union bpf_attr {
  * 		"**y**" or to "**m**".
  * 	Return
  * 		The classid, or 0 for the default unconfigured classid.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_skb_vlan_push(struct sk_buff *skb, __be16 vlan_proto, u16 vlan_tci)
  * 	Description
@@ -1828,6 +1860,8 @@ union bpf_attr {
  * 		direct packet access.
  * 	Return
  * 		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_skb_vlan_pop(struct sk_buff *skb)
  * 	Description
@@ -1840,6 +1874,8 @@ union bpf_attr {
  * 		direct packet access.
  * 	Return
  * 		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_skb_get_tunnel_key(struct sk_buff *skb, struct bpf_tunnel_key *key, u32 size, u64 flags)
  * 	Description
@@ -1891,6 +1927,8 @@ union bpf_attr {
  * 		Geneve, GRE or IP in IP (IPIP).
  * 	Return
  * 		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_skb_set_tunnel_key(struct sk_buff *skb, struct bpf_tunnel_key *key, u32 size, u64 flags)
  * 	Description
@@ -1928,6 +1966,8 @@ union bpf_attr {
  * 		helper for additional information.
  * 	Return
  * 		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * u64 bpf_perf_event_read(struct bpf_map *map, u64 flags)
  * 	Description
@@ -1957,6 +1997,8 @@ union bpf_attr {
  * 	Return
  * 		The value of the perf event counter read from the map, or a
  * 		negative error code in case of failure.
+ * 	GPL Compatibility
+ * 		Required
  *
  * long bpf_redirect(u32 ifindex, u64 flags)
  * 	Description
@@ -1980,6 +2022,8 @@ union bpf_attr {
  * 		**XDP_ABORTED** on error. For other program types, the values
  * 		are **TC_ACT_REDIRECT** on success or **TC_ACT_SHOT** on
  * 		error.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * u32 bpf_get_route_realm(struct sk_buff *skb)
  * 	Description
@@ -2004,6 +2048,8 @@ union bpf_attr {
  * 	Return
  * 		The realm of the route for the packet associated to *skb*, or 0
  * 		if none was found.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_perf_event_output(void *ctx, struct bpf_map *map, u64 flags, void *data, u64 size)
  * 	Description
@@ -2049,6 +2095,8 @@ union bpf_attr {
  * 		* A combination of both.
  * 	Return
  * 		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Required
  *
  * long bpf_skb_load_bytes(const void *skb, u32 offset, void *to, u32 len)
  * 	Description
@@ -2066,6 +2114,8 @@ union bpf_attr {
  * 		at once from a packet into the eBPF stack.
  * 	Return
  * 		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_get_stackid(void *ctx, struct bpf_map *map, u64 flags)
  * 	Description
@@ -2108,6 +2158,8 @@ union bpf_attr {
  * 	Return
  * 		The positive or null stack id on success, or a negative error
  * 		in case of failure.
+ * 	GPL Compatibility
+ * 		Required
  *
  * s64 bpf_csum_diff(__be32 *from, u32 from_size, __be32 *to, u32 to_size, __wsum seed)
  * 	Description
@@ -2135,6 +2187,8 @@ union bpf_attr {
  * 	Return
  * 		The checksum result, or a negative error code in case of
  * 		failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_skb_get_tunnel_opt(struct sk_buff *skb, void *opt, u32 size)
  * 	Description
@@ -2153,6 +2207,8 @@ union bpf_attr {
  * 		headers.
  * 	Return
  * 		The size of the option data retrieved.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_skb_set_tunnel_opt(struct sk_buff *skb, void *opt, u32 size)
  * 	Description
@@ -2190,6 +2246,8 @@ union bpf_attr {
  * 		direct packet access.
  * 	Return
  * 		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_skb_change_type(struct sk_buff *skb, u32 type)
  * 	Description
@@ -2217,6 +2275,8 @@ union bpf_attr {
  * 			Send packet to someone else.
  * 	Return
  * 		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_skb_under_cgroup(struct sk_buff *skb, struct bpf_map *map, u32 index)
  * 	Description
@@ -2228,6 +2288,8 @@ union bpf_attr {
  * 		* 0, if the *skb* failed the cgroup2 descendant test.
  * 		* 1, if the *skb* succeeded the cgroup2 descendant test.
  * 		* A negative error code, if an error occurred.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * u32 bpf_get_hash_recalc(struct sk_buff *skb)
  * 	Description
@@ -2244,6 +2306,8 @@ union bpf_attr {
  * 		**bpf_get_hash_recalc**\ ().
  * 	Return
  * 		The 32-bit hash.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * u64 bpf_get_current_task(void)
  * 	Return
@@ -2267,6 +2331,8 @@ union bpf_attr {
  * 		logs.
  * 	Return
  * 		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Required
  *
  * long bpf_current_task_under_cgroup(struct bpf_map *map, u32 index)
  * 	Description
@@ -2279,6 +2345,8 @@ union bpf_attr {
  *		* 0, if current task belongs to the cgroup2.
  *		* 1, if current task does not belong to the cgroup2.
  * 		* A negative error code, if an error occurred.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_skb_change_tail(struct sk_buff *skb, u32 len, u64 flags)
  * 	Description
@@ -2303,6 +2371,8 @@ union bpf_attr {
  * 		direct packet access.
  * 	Return
  * 		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_skb_pull_data(struct sk_buff *skb, u32 len)
  * 	Description
@@ -2339,6 +2409,8 @@ union bpf_attr {
  * 		direct packet access.
  * 	Return
  * 		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * s64 bpf_csum_update(struct sk_buff *skb, __wsum csum)
  * 	Description
@@ -2351,6 +2423,8 @@ union bpf_attr {
  * 	Return
  * 		The checksum on success, or a negative error code in case of
  * 		failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * void bpf_set_hash_invalid(struct sk_buff *skb)
  * 	Description
@@ -2359,6 +2433,8 @@ union bpf_attr {
  * 		indicate that the hash is outdated and to trigger a
  * 		recalculation the next time the kernel tries to access this
  * 		hash or when the **bpf_get_hash_recalc**\ () helper is called.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_get_numa_node_id(void)
  * 	Description
@@ -2370,6 +2446,8 @@ union bpf_attr {
  * 		similarly to **bpf_get_smp_processor_id**\ ().
  * 	Return
  * 		The id of current NUMA node.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_skb_change_head(struct sk_buff *skb, u32 len, u64 flags)
  * 	Description
@@ -2391,6 +2469,8 @@ union bpf_attr {
  * 		direct packet access.
  * 	Return
  * 		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_xdp_adjust_head(struct xdp_buff *xdp_md, int delta)
  * 	Description
@@ -2406,6 +2486,8 @@ union bpf_attr {
  * 		direct packet access.
  * 	Return
  * 		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_probe_read_str(void *dst, u32 size, const void *unsafe_ptr)
  * 	Description
@@ -2419,6 +2501,8 @@ union bpf_attr {
  * 		On success, the strictly positive length of the string,
  * 		including the trailing NUL character. On error, a negative
  * 		value.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * u64 bpf_get_socket_cookie(struct sk_buff *skb)
  * 	Description
@@ -2432,6 +2516,8 @@ union bpf_attr {
  * 	Return
  * 		A 8-byte long unique number on success, or 0 if the socket
  * 		field is missing inside *skb*.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * u64 bpf_get_socket_cookie(struct bpf_sock_addr *ctx)
  * 	Description
@@ -2439,6 +2525,8 @@ union bpf_attr {
  * 		*skb*, but gets socket from **struct bpf_sock_addr** context.
  * 	Return
  * 		A 8-byte long unique number.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * u64 bpf_get_socket_cookie(struct bpf_sock_ops *ctx)
  * 	Description
@@ -2446,6 +2534,8 @@ union bpf_attr {
  * 		*skb*, but gets socket from **struct bpf_sock_ops** context.
  * 	Return
  * 		A 8-byte long unique number.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * u64 bpf_get_socket_cookie(struct sock *sk)
  * 	Description
@@ -2454,6 +2544,8 @@ union bpf_attr {
  * 		also works for sleepable programs.
  * 	Return
  * 		A 8-byte long unique number or 0 if *sk* is NULL.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * u32 bpf_get_socket_uid(struct sk_buff *skb)
  * 	Return
@@ -2469,6 +2561,8 @@ union bpf_attr {
  * 		to value *hash*.
  * 	Return
  * 		0
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_setsockopt(void *bpf_socket, int level, int optname, void *optval, int optlen)
  * 	Description
@@ -2500,6 +2594,8 @@ union bpf_attr {
  * 		* **IPPROTO_IPV6**, which supports *optname* **IPV6_TCLASS**.
  * 	Return
  * 		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_skb_adjust_room(struct sk_buff *skb, s32 len_diff, u32 mode, u64 flags)
  * 	Description
@@ -2550,6 +2646,8 @@ union bpf_attr {
  * 		direct packet access.
  * 	Return
  * 		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_redirect_map(struct bpf_map *map, u32 key, u64 flags)
  * 	Description
@@ -2575,6 +2673,8 @@ union bpf_attr {
  * 	Return
  * 		**XDP_REDIRECT** on success, or the value of the two lower bits
  * 		of the *flags* argument on error.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_sk_redirect_map(struct sk_buff *skb, struct bpf_map *map, u32 key, u64 flags)
  * 	Description
@@ -2586,6 +2686,8 @@ union bpf_attr {
  * 		egress path otherwise). This is the only flag supported for now.
  * 	Return
  * 		**SK_PASS** on success, or **SK_DROP** on error.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_sock_map_update(struct bpf_sock_ops *skops, struct bpf_map *map, void *key, u64 flags)
  * 	Description
@@ -2605,6 +2707,8 @@ union bpf_attr {
  * 		already attached to eBPF programs, this results in an error.
  * 	Return
  * 		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_xdp_adjust_meta(struct xdp_buff *xdp_md, int delta)
  * 	Description
@@ -2634,6 +2738,8 @@ union bpf_attr {
  * 		direct packet access.
  * 	Return
  * 		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_perf_event_read_value(struct bpf_map *map, u64 flags, struct bpf_perf_event_value *buf, u32 buf_size)
  * 	Description
@@ -2684,6 +2790,8 @@ union bpf_attr {
  * 		value and do the calculation inside the eBPF program.
  * 	Return
  * 		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Required
  *
  * long bpf_perf_prog_read_value(struct bpf_perf_event_data *ctx, struct bpf_perf_event_value *buf, u32 buf_size)
  * 	Description
@@ -2695,6 +2803,8 @@ union bpf_attr {
  * 		more details).
  * 	Return
  * 		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Required
  *
  * long bpf_getsockopt(void *bpf_socket, int level, int optname, void *optval, int optlen)
  * 	Description
@@ -2720,6 +2830,8 @@ union bpf_attr {
  * 		* **IPPROTO_IPV6**, which supports *optname* **IPV6_TCLASS**.
  * 	Return
  * 		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_override_return(struct pt_regs *regs, u64 rc)
  * 	Description
@@ -2745,6 +2857,8 @@ union bpf_attr {
  * 		x86 architecture is the only one to support this feature.
  * 	Return
  * 		0
+ * 	GPL Compatibility
+ * 		Required
  *
  * long bpf_sock_ops_cb_flags_set(struct bpf_sock_ops *bpf_sock, int argval)
  * 	Description
@@ -2789,6 +2903,8 @@ union bpf_attr {
  * 		otherwise, a positive number containing the bits that could not
  * 		be set is returned (which comes down to 0 if all bits were set
  * 		as required).
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_msg_redirect_map(struct sk_msg_buff *msg, struct bpf_map *map, u32 key, u64 flags)
  * 	Description
@@ -2803,6 +2919,8 @@ union bpf_attr {
  * 		egress path otherwise). This is the only flag supported for now.
  * 	Return
  * 		**SK_PASS** on success, or **SK_DROP** on error.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_msg_apply_bytes(struct sk_msg_buff *msg, u32 bytes)
  * 	Description
@@ -2837,6 +2955,8 @@ union bpf_attr {
  * 		being buffered for *bytes* and is sent as it is received.
  * 	Return
  * 		0
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_msg_cork_bytes(struct sk_msg_buff *msg, u32 bytes)
  * 	Description
@@ -2855,6 +2975,8 @@ union bpf_attr {
  * 		been accumulated.
  * 	Return
  * 		0
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_msg_pull_data(struct sk_msg_buff *msg, u32 start, u32 end, u64 flags)
  * 	Description
@@ -2886,6 +3008,8 @@ union bpf_attr {
  * 		be left at zero.
  * 	Return
  * 		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_bind(struct bpf_sock_addr *ctx, struct sockaddr *addr, int addr_len)
  * 	Description
@@ -2904,6 +3028,8 @@ union bpf_attr {
  * 		lead to degraded performance.
  * 	Return
  * 		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_xdp_adjust_tail(struct xdp_buff *xdp_md, int delta)
  * 	Description
@@ -2918,6 +3044,8 @@ union bpf_attr {
  * 		direct packet access.
  * 	Return
  * 		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_skb_get_xfrm_state(struct sk_buff *skb, u32 index, struct bpf_xfrm_state *xfrm_state, u32 size, u64 flags)
  * 	Description
@@ -2934,6 +3062,8 @@ union bpf_attr {
  * 		**CONFIG_XFRM** configuration option.
  * 	Return
  * 		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_get_stack(void *ctx, void *buf, u32 size, u64 flags)
  * 	Description
@@ -2967,6 +3097,8 @@ union bpf_attr {
  * 	Return
  * 		A non-negative value equal to or less than *size* on success,
  * 		or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Required
  *
  * long bpf_skb_load_bytes_relative(const void *skb, u32 offset, void *to, u32 len, u32 start_header)
  * 	Description
@@ -2989,6 +3121,8 @@ union bpf_attr {
  * 		is not available.
  * 	Return
  * 		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_fib_lookup(void *ctx, struct bpf_fib_lookup *params, int plen, u32 flags)
  *	Description
@@ -3023,6 +3157,8 @@ union bpf_attr {
  *
  *		If lookup fails with BPF_FIB_LKUP_RET_FRAG_NEEDED, then the MTU
  *		was exceeded and output params->mtu_result contains the MTU.
+ * 	GPL Compatibility
+ * 		Required
  *
  * long bpf_sock_hash_update(struct bpf_sock_ops *skops, struct bpf_map *map, void *key, u64 flags)
  *	Description
@@ -3042,6 +3178,8 @@ union bpf_attr {
  *		already attached to eBPF programs, this results in an error.
  *	Return
  *		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_msg_redirect_hash(struct sk_msg_buff *msg, struct bpf_map *map, void *key, u64 flags)
  *	Description
@@ -3056,6 +3194,8 @@ union bpf_attr {
  *		egress path otherwise). This is the only flag supported for now.
  *	Return
  *		**SK_PASS** on success, or **SK_DROP** on error.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_sk_redirect_hash(struct sk_buff *skb, struct bpf_map *map, void *key, u64 flags)
  *	Description
@@ -3070,6 +3210,8 @@ union bpf_attr {
  *		egress otherwise). This is the only flag supported for now.
  *	Return
  *		**SK_PASS** on success, or **SK_DROP** on error.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_lwt_push_encap(struct sk_buff *skb, u32 type, void *hdr, u32 len)
  *	Description
@@ -3107,6 +3249,8 @@ union bpf_attr {
  * 		direct packet access.
  *	Return
  * 		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_lwt_seg6_store_bytes(struct sk_buff *skb, u32 offset, const void *from, u32 len)
  *	Description
@@ -3122,6 +3266,8 @@ union bpf_attr {
  * 		direct packet access.
  *	Return
  * 		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_lwt_seg6_adjust_srh(struct sk_buff *skb, u32 offset, s32 delta)
  *	Description
@@ -3138,6 +3284,8 @@ union bpf_attr {
  * 		direct packet access.
  *	Return
  * 		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_lwt_seg6_action(struct sk_buff *skb, u32 action, void *param, u32 param_len)
  *	Description
@@ -3167,6 +3315,8 @@ union bpf_attr {
  * 		direct packet access.
  *	Return
  * 		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_rc_repeat(void *ctx)
  *	Description
@@ -3186,6 +3336,8 @@ union bpf_attr {
  *		"**y**".
  *	Return
  *		0
+ * 	GPL Compatibility
+ * 		Required
  *
  * long bpf_rc_keydown(void *ctx, u32 protocol, u64 scancode, u32 toggle)
  *	Description
@@ -3212,6 +3364,8 @@ union bpf_attr {
  *		"**y**".
  *	Return
  *		0
+ * 	GPL Compatibility
+ * 		Required
  *
  * u64 bpf_skb_cgroup_id(struct sk_buff *skb)
  * 	Description
@@ -3228,6 +3382,8 @@ union bpf_attr {
  * 		**CONFIG_SOCK_CGROUP_DATA** configuration option.
  * 	Return
  * 		The id is returned or 0 in case the id could not be retrieved.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * u64 bpf_get_current_cgroup_id(void)
  * 	Return
@@ -3251,6 +3407,8 @@ union bpf_attr {
  *		the shared data.
  *	Return
  *		A pointer to the local storage area.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_sk_select_reuseport(struct sk_reuseport_md *reuse, struct bpf_map *map, void *key, u64 flags)
  *	Description
@@ -3260,6 +3418,8 @@ union bpf_attr {
  *		request in the socket buffer.
  *	Return
  *		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * u64 bpf_skb_ancestor_cgroup_id(struct sk_buff *skb, int ancestor_level)
  *	Description
@@ -3278,6 +3438,8 @@ union bpf_attr {
  *		**bpf_skb_cgroup_id**\ ().
  *	Return
  *		The id is returned or 0 in case the id could not be retrieved.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * struct bpf_sock *bpf_sk_lookup_tcp(void *ctx, struct bpf_sock_tuple *tuple, u32 tuple_size, u64 netns, u64 flags)
  *	Description
@@ -3315,6 +3477,8 @@ union bpf_attr {
  *		For sockets with reuseport option, the **struct bpf_sock**
  *		result is from *reuse*\ **->socks**\ [] using the hash of the
  *		tuple.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * struct bpf_sock *bpf_sk_lookup_udp(void *ctx, struct bpf_sock_tuple *tuple, u32 tuple_size, u64 netns, u64 flags)
  *	Description
@@ -3352,6 +3516,8 @@ union bpf_attr {
  *		For sockets with reuseport option, the **struct bpf_sock**
  *		result is from *reuse*\ **->socks**\ [] using the hash of the
  *		tuple.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_sk_release(void *sock)
  *	Description
@@ -3360,6 +3526,8 @@ union bpf_attr {
  *		**bpf_sk_lookup_xxx**\ ().
  *	Return
  *		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_map_push_elem(struct bpf_map *map, const void *value, u64 flags)
  * 	Description
@@ -3370,6 +3538,8 @@ union bpf_attr {
  * 			removed to make room for this.
  * 	Return
  * 		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_map_pop_elem(struct bpf_map *map, void *value)
  * 	Description
@@ -3382,6 +3552,8 @@ union bpf_attr {
  * 		Get an element from *map* without removing it.
  * 	Return
  * 		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_msg_push_data(struct sk_msg_buff *msg, u32 start, u32 len, u64 flags)
  *	Description
@@ -3398,6 +3570,8 @@ union bpf_attr {
  *		error and BPF programs will need to handle them.
  *	Return
  *		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_msg_pop_data(struct sk_msg_buff *msg, u32 start, u32 len, u64 flags)
  *	Description
@@ -3410,6 +3584,8 @@ union bpf_attr {
  *		payload and/or *pop* value being to large.
  *	Return
  *		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_rc_pointer_rel(void *ctx, s32 rel_x, s32 rel_y)
  *	Description
@@ -3424,6 +3600,8 @@ union bpf_attr {
  *		"**y**".
  *	Return
  *		0
+ * 	GPL Compatibility
+ * 		Required
  *
  * long bpf_spin_lock(struct bpf_spin_lock *lock)
  *	Description
@@ -3472,6 +3650,8 @@ union bpf_attr {
  *		* **bpf_spin_lock** is not allowed in inner maps of map-in-map.
  *	Return
  *		0
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_spin_unlock(struct bpf_spin_lock *lock)
  *	Description
@@ -3479,6 +3659,8 @@ union bpf_attr {
  *		**bpf_spin_lock**\ (\ *lock*\ ).
  *	Return
  *		0
+ * 	GPL Compatibility
+ * 		Not required
  *
  * struct bpf_sock *bpf_sk_fullsock(struct bpf_sock *sk)
  *	Description
@@ -3487,6 +3669,8 @@ union bpf_attr {
  *	Return
  *		A **struct bpf_sock** pointer on success, or **NULL** in
  *		case of failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * struct bpf_tcp_sock *bpf_tcp_sock(struct bpf_sock *sk)
  *	Description
@@ -3495,6 +3679,8 @@ union bpf_attr {
  *	Return
  *		A **struct bpf_tcp_sock** pointer on success, or **NULL** in
  *		case of failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_skb_ecn_set_ce(struct sk_buff *skb)
  *	Description
@@ -3505,6 +3691,8 @@ union bpf_attr {
  *	Return
  *		1 if the **CE** flag is set (either by the current helper call
  *		or because it was already present), 0 if it is not set.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * struct bpf_sock *bpf_get_listener_sock(struct bpf_sock *sk)
  *	Description
@@ -3513,6 +3701,8 @@ union bpf_attr {
  *	Return
  *		A **struct bpf_sock** pointer on success, or **NULL** in
  *		case of failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * struct bpf_sock *bpf_skc_lookup_tcp(void *ctx, struct bpf_sock_tuple *tuple, u32 tuple_size, u64 netns, u64 flags)
  *	Description
@@ -3532,6 +3722,8 @@ union bpf_attr {
  *		For sockets with reuseport option, the **struct bpf_sock**
  *		result is from *reuse*\ **->socks**\ [] using the hash of the
  *		tuple.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_tcp_check_syncookie(void *sk, void *iph, u32 iph_len, struct tcphdr *th, u32 th_len)
  * 	Description
@@ -3547,6 +3739,8 @@ union bpf_attr {
  * 	Return
  * 		0 if *iph* and *th* are a valid SYN cookie ACK, or a negative
  * 		error otherwise.
+ * 	GPL Compatibility
+ * 		Required
  *
  * long bpf_sysctl_get_name(struct bpf_sysctl *ctx, char *buf, size_t buf_len, u64 flags)
  *	Description
@@ -3563,6 +3757,8 @@ union bpf_attr {
  *
  *		**-E2BIG** if the buffer wasn't big enough (*buf* will contain
  *		truncated name in this case).
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_sysctl_get_current_value(struct bpf_sysctl *ctx, char *buf, size_t buf_len)
  *	Description
@@ -3582,6 +3778,8 @@ union bpf_attr {
  *
  *		**-EINVAL** if current value was unavailable, e.g. because
  *		sysctl is uninitialized and read returns -EIO for it.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_sysctl_get_new_value(struct bpf_sysctl *ctx, char *buf, size_t buf_len)
  *	Description
@@ -3599,6 +3797,8 @@ union bpf_attr {
  *		truncated name in this case).
  *
  *		**-EINVAL** if sysctl is being read.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_sysctl_set_new_value(struct bpf_sysctl *ctx, const char *buf, size_t buf_len)
  *	Description
@@ -3616,6 +3816,8 @@ union bpf_attr {
  *		**-E2BIG** if the *buf_len* is too big.
  *
  *		**-EINVAL** if sysctl is being read.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_strtol(const char *buf, size_t buf_len, u64 flags, long *res)
  *	Description
@@ -3640,6 +3842,8 @@ union bpf_attr {
  *		was provided.
  *
  *		**-ERANGE** if resulting value was out of range.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_strtoul(const char *buf, size_t buf_len, u64 flags, unsigned long *res)
  *	Description
@@ -3663,6 +3867,8 @@ union bpf_attr {
  *		was provided.
  *
  *		**-ERANGE** if resulting value was out of range.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * void *bpf_sk_storage_get(struct bpf_map *map, void *sk, void *value, u64 flags)
  *	Description
@@ -3694,6 +3900,8 @@ union bpf_attr {
  *
  *		**NULL** if not found or there was an error in adding
  *		a new bpf-local-storage.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_sk_storage_delete(struct bpf_map *map, void *sk)
  *	Description
@@ -3703,6 +3911,8 @@ union bpf_attr {
  *
  *		**-ENOENT** if the bpf-local-storage cannot be found.
  *		**-EINVAL** if sk is not a fullsock (e.g. a request_sock).
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_send_signal(u32 sig)
  *	Description
@@ -3718,6 +3928,8 @@ union bpf_attr {
  *		**-EPERM** if no permission to send the *sig*.
  *
  *		**-EAGAIN** if bpf program can try again.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * s64 bpf_tcp_gen_syncookie(void *sk, void *iph, u32 iph_len, struct tcphdr *th, u32 th_len)
  *	Description
@@ -3744,6 +3956,8 @@ union bpf_attr {
  *		**-EOPNOTSUPP** kernel configuration does not enable SYN cookies
  *
  *		**-EPROTONOSUPPORT** IP packet version is not 4 or 6
+ * 	GPL Compatibility
+ * 		Required
  *
  * long bpf_skb_output(void *ctx, struct bpf_map *map, u64 flags, void *data, u64 size)
  * 	Description
@@ -3768,6 +3982,8 @@ union bpf_attr {
  * 		restricted to raw_tracepoint bpf programs.
  * 	Return
  * 		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Required
  *
  * long bpf_probe_read_user(void *dst, u32 size, const void *unsafe_ptr)
  * 	Description
@@ -3782,6 +3998,8 @@ union bpf_attr {
  * 		*unsafe_ptr* and store the data in *dst*.
  * 	Return
  * 		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Required
  *
  * long bpf_probe_read_user_str(void *dst, u32 size, const void *unsafe_ptr)
  * 	Description
@@ -3826,6 +4044,8 @@ union bpf_attr {
  * 		On success, the strictly positive length of the output string,
  * 		including the trailing NUL character. On error, a negative
  * 		value.
+ * 	GPL Compatibility
+ * 		Required
  *
  * long bpf_probe_read_kernel_str(void *dst, u32 size, const void *unsafe_ptr)
  * 	Description
@@ -3841,6 +4061,8 @@ union bpf_attr {
  *		*rcv_nxt* is the ack_seq to be sent out.
  *	Return
  *		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Required
  *
  * long bpf_send_signal_thread(u32 sig)
  *	Description
@@ -3855,12 +4077,16 @@ union bpf_attr {
  *		**-EPERM** if no permission to send the *sig*.
  *
  *		**-EAGAIN** if bpf program can try again.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * u64 bpf_jiffies64(void)
  *	Description
  *		Obtain the 64bit jiffies
  *	Return
  *		The 64 bit jiffies
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_read_branch_records(struct bpf_perf_event_data *ctx, void *buf, u32 size, u64 flags)
  *	Description
@@ -3880,6 +4106,8 @@ union bpf_attr {
  *		of **sizeof**\ (**struct perf_branch_entry**\ ).
  *
  *		**-ENOENT** if architecture does not support branch records.
+ * 	GPL Compatibility
+ * 		Required
  *
  * long bpf_get_ns_current_pid_tgid(u64 dev, u64 ino, struct bpf_pidns_info *nsdata, u32 size)
  *	Description
@@ -3892,6 +4120,8 @@ union bpf_attr {
  *              with nsfs of current task, or if dev conversion to dev_t lost high bits.
  *
  *		**-ENOENT** if pidns does not exists for the current task.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_xdp_output(void *ctx, struct bpf_map *map, u64 flags, void *data, u64 size)
  *	Description
@@ -3916,6 +4146,8 @@ union bpf_attr {
  *		restricted to raw_tracepoint bpf programs.
  *	Return
  *		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Required
  *
  * u64 bpf_get_netns_cookie(void *ctx)
  * 	Description
@@ -3929,6 +4161,8 @@ union bpf_attr {
  * 		namespaces instead of sockets.
  * 	Return
  * 		A 8-byte long opaque number.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * u64 bpf_get_current_ancestor_cgroup_id(int ancestor_level)
  * 	Description
@@ -3947,6 +4181,8 @@ union bpf_attr {
  * 		**bpf_get_current_cgroup_id**\ ().
  * 	Return
  * 		The id is returned or 0 in case the id could not be retrieved.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_sk_assign(struct sk_buff *skb, void *sk, u64 flags)
  *	Description
@@ -3978,6 +4214,8 @@ union bpf_attr {
  *
  *		**-ESOCKTNOSUPPORT** if the socket type is not supported
  *		(reuseport).
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_sk_assign(struct bpf_sk_lookup *ctx, struct bpf_sock *sk, u64 flags)
  *	Description
@@ -4028,6 +4266,8 @@ union bpf_attr {
  *
  *		* **-ESOCKTNOSUPPORT** if socket is not in allowed
  *		  state (TCP listening or UDP unconnected).
+ * 	GPL Compatibility
+ * 		Not required
  *
  * u64 bpf_ktime_get_boot_ns(void)
  * 	Description
@@ -4036,6 +4276,8 @@ union bpf_attr {
  * 		See: **clock_gettime**\ (**CLOCK_BOOTTIME**)
  * 	Return
  * 		Current *ktime*.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_seq_printf(struct seq_file *m, const char *fmt, u32 fmt_size, const void *data, u32 data_len)
  * 	Description
@@ -4065,6 +4307,8 @@ union bpf_attr {
  *		**-E2BIG** if *fmt* contains too many format specifiers.
  *
  *		**-EOVERFLOW** if an overflow happened: The same object will be tried again.
+ * 	GPL Compatibility
+ * 		Required
  *
  * long bpf_seq_write(struct seq_file *m, const void *data, u32 len)
  * 	Description
@@ -4075,6 +4319,8 @@ union bpf_attr {
  * 		0 on success, or a negative error in case of failure:
  *
  *		**-EOVERFLOW** if an overflow happened: The same object will be tried again.
+ * 	GPL Compatibility
+ * 		Required
  *
  * u64 bpf_sk_cgroup_id(void *sk)
  *	Description
@@ -4089,6 +4335,8 @@ union bpf_attr {
  *		the **CONFIG_SOCK_CGROUP_DATA** configuration option.
  *	Return
  *		The id is returned or 0 in case the id could not be retrieved.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * u64 bpf_sk_ancestor_cgroup_id(void *sk, int ancestor_level)
  *	Description
@@ -4107,6 +4355,8 @@ union bpf_attr {
  *		**bpf_sk_cgroup_id**\ ().
  *	Return
  *		The id is returned or 0 in case the id could not be retrieved.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_ringbuf_output(void *ringbuf, void *data, u64 size, u64 flags)
  * 	Description
@@ -4124,6 +4374,8 @@ union bpf_attr {
  * 		as it will process the newly added payload automatically.
  * 	Return
  * 		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * void *bpf_ringbuf_reserve(void *ringbuf, u64 size, u64 flags)
  * 	Description
@@ -4132,6 +4384,8 @@ union bpf_attr {
  * 	Return
  * 		Valid pointer with *size* bytes of memory available; NULL,
  * 		otherwise.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * void bpf_ringbuf_submit(void *data, u64 flags)
  * 	Description
@@ -4146,6 +4400,8 @@ union bpf_attr {
  * 		See 'bpf_ringbuf_output()' for the definition of adaptive notification.
  * 	Return
  * 		Nothing. Always succeeds.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * void bpf_ringbuf_discard(void *data, u64 flags)
  * 	Description
@@ -4160,6 +4416,8 @@ union bpf_attr {
  * 		See 'bpf_ringbuf_output()' for the definition of adaptive notification.
  * 	Return
  * 		Nothing. Always succeeds.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * u64 bpf_ringbuf_query(void *ringbuf, u64 flags)
  *	Description
@@ -4177,6 +4435,8 @@ union bpf_attr {
  *		calculation.
  *	Return
  *		Requested value, or 0, if *flags* are not recognized.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_csum_level(struct sk_buff *skb, u64 level)
  * 	Description
@@ -4209,36 +4469,48 @@ union bpf_attr {
  * 		case of **BPF_CSUM_LEVEL_QUERY**, the current skb->csum_level
  * 		is returned or the error code -EACCES in case the skb is not
  * 		subject to CHECKSUM_UNNECESSARY.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * struct tcp6_sock *bpf_skc_to_tcp6_sock(void *sk)
  *	Description
  *		Dynamically cast a *sk* pointer to a *tcp6_sock* pointer.
  *	Return
  *		*sk* if casting is valid, or **NULL** otherwise.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * struct tcp_sock *bpf_skc_to_tcp_sock(void *sk)
  *	Description
  *		Dynamically cast a *sk* pointer to a *tcp_sock* pointer.
  *	Return
  *		*sk* if casting is valid, or **NULL** otherwise.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * struct tcp_timewait_sock *bpf_skc_to_tcp_timewait_sock(void *sk)
  * 	Description
  *		Dynamically cast a *sk* pointer to a *tcp_timewait_sock* pointer.
  *	Return
  *		*sk* if casting is valid, or **NULL** otherwise.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * struct tcp_request_sock *bpf_skc_to_tcp_request_sock(void *sk)
  * 	Description
  *		Dynamically cast a *sk* pointer to a *tcp_request_sock* pointer.
  *	Return
  *		*sk* if casting is valid, or **NULL** otherwise.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * struct udp6_sock *bpf_skc_to_udp6_sock(void *sk)
  * 	Description
  *		Dynamically cast a *sk* pointer to a *udp6_sock* pointer.
  *	Return
  *		*sk* if casting is valid, or **NULL** otherwise.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_get_task_stack(struct task_struct *task, void *buf, u32 size, u64 flags)
  *	Description
@@ -4271,6 +4543,8 @@ union bpf_attr {
  *	Return
  *		A non-negative value equal to or less than *size* on success,
  *		or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_load_hdr_opt(struct bpf_sock_ops *skops, void *searchby_res, u32 len, u64 flags)
  *	Description
@@ -4334,6 +4608,8 @@ union bpf_attr {
  *
  *		**-EPERM** if the helper cannot be used under the current
  *		*skops*\ **->op**.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_store_hdr_opt(struct bpf_sock_ops *skops, const void *from, u32 len, u64 flags)
  *	Description
@@ -4367,6 +4643,8 @@ union bpf_attr {
  *
  *		**-EPERM** if the helper cannot be used under the current
  *		*skops*\ **->op**.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_reserve_hdr_opt(struct bpf_sock_ops *skops, u32 len, u64 flags)
  *	Description
@@ -4389,6 +4667,8 @@ union bpf_attr {
  *
  *		**-EPERM** if the helper cannot be used under the current
  *		*skops*\ **->op**.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * void *bpf_inode_storage_get(struct bpf_map *map, void *inode, void *value, u64 flags)
  *	Description
@@ -4425,6 +4705,8 @@ union bpf_attr {
  *		0 on success.
  *
  *		**-ENOENT** if the bpf_local_storage cannot be found.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_d_path(struct path *path, char *buf, u32 sz)
  *	Description
@@ -4437,6 +4719,8 @@ union bpf_attr {
  *		On success, the strictly positive length of the string,
  *		including the trailing NUL character. On error, a negative
  *		value.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_copy_from_user(void *dst, u32 size, const void *user_ptr)
  * 	Description
@@ -4444,6 +4728,8 @@ union bpf_attr {
  * 		the data in *dst*. This is a wrapper of **copy_from_user**\ ().
  * 	Return
  * 		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_snprintf_btf(char *str, u32 str_size, struct btf_ptr *ptr, u32 btf_ptr_size, u64 flags)
  *	Description
@@ -4480,6 +4766,8 @@ union bpf_attr {
  *		The number of bytes that were written (or would have been
  *		written if output had to be truncated due to string size),
  *		or a negative error in cases of failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_seq_printf_btf(struct seq_file *m, struct btf_ptr *ptr, u32 ptr_size, u64 flags)
  *	Description
@@ -4488,6 +4776,8 @@ union bpf_attr {
  *		*flags* are identical to those used for bpf_snprintf_btf.
  *	Return
  *		0 on success or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Required
  *
  * u64 bpf_skb_cgroup_classid(struct sk_buff *skb)
  * 	Description
@@ -4518,6 +4808,8 @@ union bpf_attr {
  * 	Return
  * 		The helper returns **TC_ACT_REDIRECT** on success or
  * 		**TC_ACT_SHOT** on error.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * void *bpf_per_cpu_ptr(const void *percpu_ptr, u32 cpu)
  *     Description
@@ -4535,6 +4827,8 @@ union bpf_attr {
  *     Return
  *             A pointer pointing to the kernel percpu variable on *cpu*, or
  *             NULL, if *cpu* is invalid.
+ *     GPL Compatibility
+ *             Not required
  *
  * void *bpf_this_cpu_ptr(const void *percpu_ptr)
  *	Description
@@ -4547,6 +4841,8 @@ union bpf_attr {
  *		never return NULL.
  *	Return
  *		A pointer pointing to the kernel percpu variable on this cpu.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_redirect_peer(u32 ifindex, u64 flags)
  * 	Description
@@ -4563,6 +4859,8 @@ union bpf_attr {
  * 	Return
  * 		The helper returns **TC_ACT_REDIRECT** on success or
  * 		**TC_ACT_SHOT** on error.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * void *bpf_task_storage_get(struct bpf_map *map, struct task_struct *task, void *value, u64 flags)
  *	Description
@@ -4591,6 +4889,8 @@ union bpf_attr {
  *
  *		**NULL** if not found or there was an error in adding
  *		a new bpf_local_storage.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_task_storage_delete(struct bpf_map *map, struct task_struct *task)
  *	Description
@@ -4599,6 +4899,8 @@ union bpf_attr {
  *		0 on success.
  *
  *		**-ENOENT** if the bpf_local_storage cannot be found.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * struct task_struct *bpf_get_current_task_btf(void)
  *	Description
@@ -4607,6 +4909,8 @@ union bpf_attr {
  *		*ARG_PTR_TO_BTF_ID* of type *task_struct*.
  *	Return
  *		Pointer to the current task.
+ * 	GPL Compatibility
+ * 		Required
  *
  * long bpf_bprm_opts_set(struct linux_binprm *bprm, u64 flags)
  *	Description
@@ -4617,6 +4921,8 @@ union bpf_attr {
  *		is cleared if the flag is not specified.
  *	Return
  *		**-EINVAL** if invalid *flags* are passed, zero otherwise.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * u64 bpf_ktime_get_coarse_ns(void)
  * 	Description
@@ -4627,6 +4933,8 @@ union bpf_attr {
  * 		See: **clock_gettime**\ (**CLOCK_MONOTONIC_COARSE**)
  * 	Return
  * 		Current *ktime*.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_ima_inode_hash(struct inode *inode, void *dst, u32 size)
  *	Description
@@ -4637,6 +4945,8 @@ union bpf_attr {
  *		The **hash_algo** is returned on success,
  *		**-EOPNOTSUP** if IMA is disabled or **-EINVAL** if
  *		invalid arguments are passed.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * struct socket *bpf_sock_from_file(struct file *file)
  *	Description
@@ -4645,6 +4955,8 @@ union bpf_attr {
  *	Return
  *		A pointer to a struct socket on success or NULL if the file is
  *		not a socket.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_check_mtu(void *ctx, u32 ifindex, u32 *mtu_len, s32 len_diff, u64 flags)
  *	Description
@@ -4712,6 +5024,8 @@ union bpf_attr {
  *
  *		* **BPF_MTU_CHK_RET_FRAG_NEEDED**
  *		* **BPF_MTU_CHK_RET_SEGS_TOOBIG**
+ * 	GPL Compatibility
+ * 		Required
  *
  * long bpf_for_each_map_elem(struct bpf_map *map, void *callback_fn, void *callback_ctx, u64 flags)
  *	Description
@@ -4741,6 +5055,8 @@ union bpf_attr {
  *	Return
  *		The number of traversed map elements for success, **-EINVAL** for
  *		invalid **flags**.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_snprintf(char *str, u32 str_size, const char *fmt, u64 *data, u32 data_len)
  *	Description
@@ -4768,24 +5084,32 @@ union bpf_attr {
  *		be zero-terminated except when **str_size** is 0.
  *
  *		Or **-EBUSY** if the per-CPU memory copy buffer is busy.
+ * 	GPL Compatibility
+ * 		Required
  *
  * long bpf_sys_bpf(u32 cmd, void *attr, u32 attr_size)
  * 	Description
  * 		Execute bpf syscall with given arguments.
  * 	Return
  * 		A syscall result.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_btf_find_by_name_kind(char *name, int name_sz, u32 kind, int flags)
  * 	Description
  * 		Find BTF type with given name and kind in vmlinux BTF or in module's BTFs.
  * 	Return
  * 		Returns btf_id and btf_obj_fd in lower and upper 32 bits.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_sys_close(u32 fd)
  * 	Description
  * 		Execute close syscall for given FD.
  * 	Return
  * 		A syscall result.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_timer_init(struct bpf_timer *timer, struct bpf_map *map, u64 flags)
  *	Description
@@ -4803,6 +5127,8 @@ union bpf_attr {
  *		The user space should either hold a file descriptor to a map with timers
  *		or pin such map in bpffs. When map is unpinned or file descriptor is
  *		closed all timers in the map will be cancelled and freed.
+ * 	GPL Compatibility
+ * 		Required
  *
  * long bpf_timer_set_callback(struct bpf_timer *timer, void *callback_fn)
  *	Description
@@ -4814,6 +5140,8 @@ union bpf_attr {
  *		The user space should either hold a file descriptor to a map with timers
  *		or pin such map in bpffs. When map is unpinned or file descriptor is
  *		closed all timers in the map will be cancelled and freed.
+ * 	GPL Compatibility
+ * 		Required
  *
  * long bpf_timer_start(struct bpf_timer *timer, u64 nsecs, u64 flags)
  *	Description
@@ -4840,6 +5168,8 @@ union bpf_attr {
  *		0 on success.
  *		**-EINVAL** if *timer* was not initialized with bpf_timer_init() earlier
  *		or invalid *flags* are passed.
+ * 	GPL Compatibility
+ * 		Required
  *
  * long bpf_timer_cancel(struct bpf_timer *timer)
  *	Description
@@ -4850,12 +5180,16 @@ union bpf_attr {
  *		**-EINVAL** if *timer* was not initialized with bpf_timer_init() earlier.
  *		**-EDEADLK** if callback_fn tried to call bpf_timer_cancel() on its
  *		own timer which would have led to a deadlock otherwise.
+ * 	GPL Compatibility
+ * 		Required
  *
  * u64 bpf_get_func_ip(void *ctx)
  * 	Description
  * 		Get address of the traced function (for tracing and kprobe programs).
  * 	Return
  * 		Address of the traced function.
+ * 	GPL Compatibility
+ * 		Required
  *
  * u64 bpf_get_attach_cookie(void *ctx)
  * 	Description
@@ -4871,6 +5205,8 @@ union bpf_attr {
  * 	Return
  *		Value specified by user at BPF link creation/attachment time
  *		or 0, if it was not specified.
+ * 	GPL Compatibility
+ * 		Not required
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
index 00ac7b79cddb..b27c3b8ee831 100755
--- a/scripts/bpf_doc.py
+++ b/scripts/bpf_doc.py
@@ -32,12 +32,14 @@ class APIElement(object):
     An object representing the description of an aspect of the eBPF API.
     @proto: prototype of the API symbol
     @desc: textual description of the symbol
+    @gpl: determine if this API element is GPL only
     @ret: (optional) description of any associated return value
     """
-    def __init__(self, proto='', desc='', ret=''):
+    def __init__(self, proto='', desc='', ret='', gpl=''):
         self.proto = proto
         self.desc = desc
         self.ret = ret
+        self.gpl = gpl
 
 
 class Helper(APIElement):
@@ -98,7 +100,8 @@ class HeaderParser(object):
         proto    = self.parse_proto()
         desc     = self.parse_desc()
         ret      = self.parse_ret()
-        return Helper(proto=proto, desc=desc, ret=ret)
+        gpl      = self.parse_gpl()
+        return Helper(proto=proto, desc=desc, ret=ret, gpl=gpl)
 
     def parse_symbol(self):
         p = re.compile(' \* ?(.+)$')
@@ -172,6 +175,29 @@ class HeaderParser(object):
                 else:
                     break
         return ret
+    
+    def parse_gpl(self):
+        p = re.compile(' \* ?(?:\t| {5,8})GPL Compatibility$')
+        capture = p.match(self.line)
+        if not capture:
+            # Helper can have empty GPL Compatilibity and we might be parsing another
+            # attribute: return but do not consume.
+            return ''
+        # GPL Compatibility can be several lines, some of them possibly empty, and it
+        # stops when another subsection title is met.
+        desc = ''
+        while True:
+            self.line = self.reader.readline()
+            if self.line == ' *\n':
+                desc += '\n'
+            else:
+                p = re.compile(' \* ?(?:\t| {5,8})(?:\t| {8})(.*)')
+                capture = p.match(self.line)
+                if capture:
+                    desc += capture.group(1) + '\n'
+                else:
+                    break
+        return desc
 
     def seek_to(self, target, help_message):
         self.reader.seek(0)
@@ -293,6 +319,10 @@ class PrinterRST(Printer):
             for line in elem.ret.rstrip().split('\n'):
                 print('{}{}'.format('\t\t' if line else '', line))
 
+        if (elem.gpl):
+            print('\tGPL Compatibility')
+            for line in elem.gpl.rstrip().split('\n'):
+                print('{}{}'.format('\t\t' if line else '', line))
         print('')
 
 
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index c4f7892edb2b..2c03010024e3 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1512,6 +1512,8 @@ union bpf_attr {
  * 	Return
  * 		Map value associated to *key*, or **NULL** if no entry was
  * 		found.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_map_update_elem(struct bpf_map *map, const void *key, const void *value, u64 flags)
  * 	Description
@@ -1530,6 +1532,8 @@ union bpf_attr {
  * 		elements always exist), the helper would return an error.
  * 	Return
  * 		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_map_delete_elem(struct bpf_map *map, const void *key)
  * 	Description
@@ -1546,6 +1550,8 @@ union bpf_attr {
  * 		**bpf_probe_read_kernel**\ () instead.
  * 	Return
  * 		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * u64 bpf_ktime_get_ns(void)
  * 	Description
@@ -1554,6 +1560,8 @@ union bpf_attr {
  * 		See: **clock_gettime**\ (**CLOCK_MONOTONIC**)
  * 	Return
  * 		Current *ktime*.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_trace_printk(const char *fmt, u32 fmt_size, ...)
  * 	Description
@@ -1613,6 +1621,8 @@ union bpf_attr {
  * 	Return
  * 		The number of bytes written to the buffer, or a negative error
  * 		in case of failure.
+ * 	GPL Compatibility
+ * 		Required
  *
  * u32 bpf_get_prandom_u32(void)
  * 	Description
@@ -1625,6 +1635,8 @@ union bpf_attr {
  * 		cryptographically secure.
  * 	Return
  * 		A random 32-bit unsigned value.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * u32 bpf_get_smp_processor_id(void)
  * 	Description
@@ -1634,6 +1646,8 @@ union bpf_attr {
  * 		program.
  * 	Return
  * 		The SMP id of the processor running the program.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_skb_store_bytes(struct sk_buff *skb, u32 offset, const void *from, u32 len, u64 flags)
  * 	Description
@@ -1651,6 +1665,8 @@ union bpf_attr {
  * 		direct packet access.
  * 	Return
  * 		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_l3_csum_replace(struct sk_buff *skb, u32 offset, u64 from, u64 to, u64 size)
  * 	Description
@@ -1676,6 +1692,8 @@ union bpf_attr {
  * 		direct packet access.
  * 	Return
  * 		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_l4_csum_replace(struct sk_buff *skb, u32 offset, u64 from, u64 to, u64 flags)
  * 	Description
@@ -1708,6 +1726,8 @@ union bpf_attr {
  * 		direct packet access.
  * 	Return
  * 		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_tail_call(void *ctx, struct bpf_map *prog_array_map, u32 index)
  * 	Description
@@ -1739,6 +1759,8 @@ union bpf_attr {
  * 		which is currently set to 32.
  * 	Return
  * 		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_clone_redirect(struct sk_buff *skb, u32 ifindex, u64 flags)
  * 	Description
@@ -1763,6 +1785,8 @@ union bpf_attr {
  * 		direct packet access.
  * 	Return
  * 		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * u64 bpf_get_current_pid_tgid(void)
  * 	Return
@@ -1770,11 +1794,15 @@ union bpf_attr {
  * 		created as such:
  * 		*current_task*\ **->tgid << 32 \|**
  * 		*current_task*\ **->pid**.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * u64 bpf_get_current_uid_gid(void)
  * 	Return
  * 		A 64-bit integer containing the current GID and UID, and
  * 		created as such: *current_gid* **<< 32 \|** *current_uid*.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_get_current_comm(void *buf, u32 size_of_buf)
  * 	Description
@@ -1786,6 +1814,8 @@ union bpf_attr {
  * 		it is filled with zeroes.
  * 	Return
  * 		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * u32 bpf_get_cgroup_classid(struct sk_buff *skb)
  * 	Description
@@ -1812,6 +1842,8 @@ union bpf_attr {
  * 		"**y**" or to "**m**".
  * 	Return
  * 		The classid, or 0 for the default unconfigured classid.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_skb_vlan_push(struct sk_buff *skb, __be16 vlan_proto, u16 vlan_tci)
  * 	Description
@@ -1828,6 +1860,8 @@ union bpf_attr {
  * 		direct packet access.
  * 	Return
  * 		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_skb_vlan_pop(struct sk_buff *skb)
  * 	Description
@@ -1840,6 +1874,8 @@ union bpf_attr {
  * 		direct packet access.
  * 	Return
  * 		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_skb_get_tunnel_key(struct sk_buff *skb, struct bpf_tunnel_key *key, u32 size, u64 flags)
  * 	Description
@@ -1891,6 +1927,8 @@ union bpf_attr {
  * 		Geneve, GRE or IP in IP (IPIP).
  * 	Return
  * 		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_skb_set_tunnel_key(struct sk_buff *skb, struct bpf_tunnel_key *key, u32 size, u64 flags)
  * 	Description
@@ -1928,6 +1966,8 @@ union bpf_attr {
  * 		helper for additional information.
  * 	Return
  * 		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * u64 bpf_perf_event_read(struct bpf_map *map, u64 flags)
  * 	Description
@@ -1957,6 +1997,8 @@ union bpf_attr {
  * 	Return
  * 		The value of the perf event counter read from the map, or a
  * 		negative error code in case of failure.
+ * 	GPL Compatibility
+ * 		Required
  *
  * long bpf_redirect(u32 ifindex, u64 flags)
  * 	Description
@@ -1980,6 +2022,8 @@ union bpf_attr {
  * 		**XDP_ABORTED** on error. For other program types, the values
  * 		are **TC_ACT_REDIRECT** on success or **TC_ACT_SHOT** on
  * 		error.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * u32 bpf_get_route_realm(struct sk_buff *skb)
  * 	Description
@@ -2004,6 +2048,8 @@ union bpf_attr {
  * 	Return
  * 		The realm of the route for the packet associated to *skb*, or 0
  * 		if none was found.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_perf_event_output(void *ctx, struct bpf_map *map, u64 flags, void *data, u64 size)
  * 	Description
@@ -2049,6 +2095,8 @@ union bpf_attr {
  * 		* A combination of both.
  * 	Return
  * 		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Required
  *
  * long bpf_skb_load_bytes(const void *skb, u32 offset, void *to, u32 len)
  * 	Description
@@ -2066,6 +2114,8 @@ union bpf_attr {
  * 		at once from a packet into the eBPF stack.
  * 	Return
  * 		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_get_stackid(void *ctx, struct bpf_map *map, u64 flags)
  * 	Description
@@ -2108,6 +2158,8 @@ union bpf_attr {
  * 	Return
  * 		The positive or null stack id on success, or a negative error
  * 		in case of failure.
+ * 	GPL Compatibility
+ * 		Required
  *
  * s64 bpf_csum_diff(__be32 *from, u32 from_size, __be32 *to, u32 to_size, __wsum seed)
  * 	Description
@@ -2135,6 +2187,8 @@ union bpf_attr {
  * 	Return
  * 		The checksum result, or a negative error code in case of
  * 		failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_skb_get_tunnel_opt(struct sk_buff *skb, void *opt, u32 size)
  * 	Description
@@ -2153,6 +2207,8 @@ union bpf_attr {
  * 		headers.
  * 	Return
  * 		The size of the option data retrieved.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_skb_set_tunnel_opt(struct sk_buff *skb, void *opt, u32 size)
  * 	Description
@@ -2190,6 +2246,8 @@ union bpf_attr {
  * 		direct packet access.
  * 	Return
  * 		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_skb_change_type(struct sk_buff *skb, u32 type)
  * 	Description
@@ -2217,6 +2275,8 @@ union bpf_attr {
  * 			Send packet to someone else.
  * 	Return
  * 		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_skb_under_cgroup(struct sk_buff *skb, struct bpf_map *map, u32 index)
  * 	Description
@@ -2228,6 +2288,8 @@ union bpf_attr {
  * 		* 0, if the *skb* failed the cgroup2 descendant test.
  * 		* 1, if the *skb* succeeded the cgroup2 descendant test.
  * 		* A negative error code, if an error occurred.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * u32 bpf_get_hash_recalc(struct sk_buff *skb)
  * 	Description
@@ -2244,6 +2306,8 @@ union bpf_attr {
  * 		**bpf_get_hash_recalc**\ ().
  * 	Return
  * 		The 32-bit hash.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * u64 bpf_get_current_task(void)
  * 	Return
@@ -2267,6 +2331,8 @@ union bpf_attr {
  * 		logs.
  * 	Return
  * 		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Required
  *
  * long bpf_current_task_under_cgroup(struct bpf_map *map, u32 index)
  * 	Description
@@ -2279,6 +2345,8 @@ union bpf_attr {
  *		* 0, if current task belongs to the cgroup2.
  *		* 1, if current task does not belong to the cgroup2.
  * 		* A negative error code, if an error occurred.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_skb_change_tail(struct sk_buff *skb, u32 len, u64 flags)
  * 	Description
@@ -2303,6 +2371,8 @@ union bpf_attr {
  * 		direct packet access.
  * 	Return
  * 		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_skb_pull_data(struct sk_buff *skb, u32 len)
  * 	Description
@@ -2339,6 +2409,8 @@ union bpf_attr {
  * 		direct packet access.
  * 	Return
  * 		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * s64 bpf_csum_update(struct sk_buff *skb, __wsum csum)
  * 	Description
@@ -2351,6 +2423,8 @@ union bpf_attr {
  * 	Return
  * 		The checksum on success, or a negative error code in case of
  * 		failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * void bpf_set_hash_invalid(struct sk_buff *skb)
  * 	Description
@@ -2359,6 +2433,8 @@ union bpf_attr {
  * 		indicate that the hash is outdated and to trigger a
  * 		recalculation the next time the kernel tries to access this
  * 		hash or when the **bpf_get_hash_recalc**\ () helper is called.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_get_numa_node_id(void)
  * 	Description
@@ -2370,6 +2446,8 @@ union bpf_attr {
  * 		similarly to **bpf_get_smp_processor_id**\ ().
  * 	Return
  * 		The id of current NUMA node.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_skb_change_head(struct sk_buff *skb, u32 len, u64 flags)
  * 	Description
@@ -2391,6 +2469,8 @@ union bpf_attr {
  * 		direct packet access.
  * 	Return
  * 		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_xdp_adjust_head(struct xdp_buff *xdp_md, int delta)
  * 	Description
@@ -2406,6 +2486,8 @@ union bpf_attr {
  * 		direct packet access.
  * 	Return
  * 		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_probe_read_str(void *dst, u32 size, const void *unsafe_ptr)
  * 	Description
@@ -2419,6 +2501,8 @@ union bpf_attr {
  * 		On success, the strictly positive length of the string,
  * 		including the trailing NUL character. On error, a negative
  * 		value.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * u64 bpf_get_socket_cookie(struct sk_buff *skb)
  * 	Description
@@ -2432,6 +2516,8 @@ union bpf_attr {
  * 	Return
  * 		A 8-byte long unique number on success, or 0 if the socket
  * 		field is missing inside *skb*.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * u64 bpf_get_socket_cookie(struct bpf_sock_addr *ctx)
  * 	Description
@@ -2439,6 +2525,8 @@ union bpf_attr {
  * 		*skb*, but gets socket from **struct bpf_sock_addr** context.
  * 	Return
  * 		A 8-byte long unique number.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * u64 bpf_get_socket_cookie(struct bpf_sock_ops *ctx)
  * 	Description
@@ -2446,6 +2534,8 @@ union bpf_attr {
  * 		*skb*, but gets socket from **struct bpf_sock_ops** context.
  * 	Return
  * 		A 8-byte long unique number.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * u64 bpf_get_socket_cookie(struct sock *sk)
  * 	Description
@@ -2454,6 +2544,8 @@ union bpf_attr {
  * 		also works for sleepable programs.
  * 	Return
  * 		A 8-byte long unique number or 0 if *sk* is NULL.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * u32 bpf_get_socket_uid(struct sk_buff *skb)
  * 	Return
@@ -2469,6 +2561,8 @@ union bpf_attr {
  * 		to value *hash*.
  * 	Return
  * 		0
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_setsockopt(void *bpf_socket, int level, int optname, void *optval, int optlen)
  * 	Description
@@ -2500,6 +2594,8 @@ union bpf_attr {
  * 		* **IPPROTO_IPV6**, which supports *optname* **IPV6_TCLASS**.
  * 	Return
  * 		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_skb_adjust_room(struct sk_buff *skb, s32 len_diff, u32 mode, u64 flags)
  * 	Description
@@ -2550,6 +2646,8 @@ union bpf_attr {
  * 		direct packet access.
  * 	Return
  * 		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_redirect_map(struct bpf_map *map, u32 key, u64 flags)
  * 	Description
@@ -2575,6 +2673,8 @@ union bpf_attr {
  * 	Return
  * 		**XDP_REDIRECT** on success, or the value of the two lower bits
  * 		of the *flags* argument on error.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_sk_redirect_map(struct sk_buff *skb, struct bpf_map *map, u32 key, u64 flags)
  * 	Description
@@ -2586,6 +2686,8 @@ union bpf_attr {
  * 		egress path otherwise). This is the only flag supported for now.
  * 	Return
  * 		**SK_PASS** on success, or **SK_DROP** on error.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_sock_map_update(struct bpf_sock_ops *skops, struct bpf_map *map, void *key, u64 flags)
  * 	Description
@@ -2605,6 +2707,8 @@ union bpf_attr {
  * 		already attached to eBPF programs, this results in an error.
  * 	Return
  * 		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_xdp_adjust_meta(struct xdp_buff *xdp_md, int delta)
  * 	Description
@@ -2634,6 +2738,8 @@ union bpf_attr {
  * 		direct packet access.
  * 	Return
  * 		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_perf_event_read_value(struct bpf_map *map, u64 flags, struct bpf_perf_event_value *buf, u32 buf_size)
  * 	Description
@@ -2684,6 +2790,8 @@ union bpf_attr {
  * 		value and do the calculation inside the eBPF program.
  * 	Return
  * 		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Required
  *
  * long bpf_perf_prog_read_value(struct bpf_perf_event_data *ctx, struct bpf_perf_event_value *buf, u32 buf_size)
  * 	Description
@@ -2695,6 +2803,8 @@ union bpf_attr {
  * 		more details).
  * 	Return
  * 		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Required
  *
  * long bpf_getsockopt(void *bpf_socket, int level, int optname, void *optval, int optlen)
  * 	Description
@@ -2720,6 +2830,8 @@ union bpf_attr {
  * 		* **IPPROTO_IPV6**, which supports *optname* **IPV6_TCLASS**.
  * 	Return
  * 		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_override_return(struct pt_regs *regs, u64 rc)
  * 	Description
@@ -2745,6 +2857,8 @@ union bpf_attr {
  * 		x86 architecture is the only one to support this feature.
  * 	Return
  * 		0
+ * 	GPL Compatibility
+ * 		Required
  *
  * long bpf_sock_ops_cb_flags_set(struct bpf_sock_ops *bpf_sock, int argval)
  * 	Description
@@ -2789,6 +2903,8 @@ union bpf_attr {
  * 		otherwise, a positive number containing the bits that could not
  * 		be set is returned (which comes down to 0 if all bits were set
  * 		as required).
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_msg_redirect_map(struct sk_msg_buff *msg, struct bpf_map *map, u32 key, u64 flags)
  * 	Description
@@ -2803,6 +2919,8 @@ union bpf_attr {
  * 		egress path otherwise). This is the only flag supported for now.
  * 	Return
  * 		**SK_PASS** on success, or **SK_DROP** on error.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_msg_apply_bytes(struct sk_msg_buff *msg, u32 bytes)
  * 	Description
@@ -2837,6 +2955,8 @@ union bpf_attr {
  * 		being buffered for *bytes* and is sent as it is received.
  * 	Return
  * 		0
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_msg_cork_bytes(struct sk_msg_buff *msg, u32 bytes)
  * 	Description
@@ -2855,6 +2975,8 @@ union bpf_attr {
  * 		been accumulated.
  * 	Return
  * 		0
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_msg_pull_data(struct sk_msg_buff *msg, u32 start, u32 end, u64 flags)
  * 	Description
@@ -2886,6 +3008,8 @@ union bpf_attr {
  * 		be left at zero.
  * 	Return
  * 		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_bind(struct bpf_sock_addr *ctx, struct sockaddr *addr, int addr_len)
  * 	Description
@@ -2904,6 +3028,8 @@ union bpf_attr {
  * 		lead to degraded performance.
  * 	Return
  * 		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_xdp_adjust_tail(struct xdp_buff *xdp_md, int delta)
  * 	Description
@@ -2918,6 +3044,8 @@ union bpf_attr {
  * 		direct packet access.
  * 	Return
  * 		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_skb_get_xfrm_state(struct sk_buff *skb, u32 index, struct bpf_xfrm_state *xfrm_state, u32 size, u64 flags)
  * 	Description
@@ -2934,6 +3062,8 @@ union bpf_attr {
  * 		**CONFIG_XFRM** configuration option.
  * 	Return
  * 		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_get_stack(void *ctx, void *buf, u32 size, u64 flags)
  * 	Description
@@ -2967,6 +3097,8 @@ union bpf_attr {
  * 	Return
  * 		A non-negative value equal to or less than *size* on success,
  * 		or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Required
  *
  * long bpf_skb_load_bytes_relative(const void *skb, u32 offset, void *to, u32 len, u32 start_header)
  * 	Description
@@ -2989,6 +3121,8 @@ union bpf_attr {
  * 		is not available.
  * 	Return
  * 		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_fib_lookup(void *ctx, struct bpf_fib_lookup *params, int plen, u32 flags)
  *	Description
@@ -3023,6 +3157,8 @@ union bpf_attr {
  *
  *		If lookup fails with BPF_FIB_LKUP_RET_FRAG_NEEDED, then the MTU
  *		was exceeded and output params->mtu_result contains the MTU.
+ * 	GPL Compatibility
+ * 		Required
  *
  * long bpf_sock_hash_update(struct bpf_sock_ops *skops, struct bpf_map *map, void *key, u64 flags)
  *	Description
@@ -3042,6 +3178,8 @@ union bpf_attr {
  *		already attached to eBPF programs, this results in an error.
  *	Return
  *		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_msg_redirect_hash(struct sk_msg_buff *msg, struct bpf_map *map, void *key, u64 flags)
  *	Description
@@ -3056,6 +3194,8 @@ union bpf_attr {
  *		egress path otherwise). This is the only flag supported for now.
  *	Return
  *		**SK_PASS** on success, or **SK_DROP** on error.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_sk_redirect_hash(struct sk_buff *skb, struct bpf_map *map, void *key, u64 flags)
  *	Description
@@ -3070,6 +3210,8 @@ union bpf_attr {
  *		egress otherwise). This is the only flag supported for now.
  *	Return
  *		**SK_PASS** on success, or **SK_DROP** on error.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_lwt_push_encap(struct sk_buff *skb, u32 type, void *hdr, u32 len)
  *	Description
@@ -3107,6 +3249,8 @@ union bpf_attr {
  * 		direct packet access.
  *	Return
  * 		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_lwt_seg6_store_bytes(struct sk_buff *skb, u32 offset, const void *from, u32 len)
  *	Description
@@ -3122,6 +3266,8 @@ union bpf_attr {
  * 		direct packet access.
  *	Return
  * 		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_lwt_seg6_adjust_srh(struct sk_buff *skb, u32 offset, s32 delta)
  *	Description
@@ -3138,6 +3284,8 @@ union bpf_attr {
  * 		direct packet access.
  *	Return
  * 		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_lwt_seg6_action(struct sk_buff *skb, u32 action, void *param, u32 param_len)
  *	Description
@@ -3167,6 +3315,8 @@ union bpf_attr {
  * 		direct packet access.
  *	Return
  * 		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_rc_repeat(void *ctx)
  *	Description
@@ -3186,6 +3336,8 @@ union bpf_attr {
  *		"**y**".
  *	Return
  *		0
+ * 	GPL Compatibility
+ * 		Required
  *
  * long bpf_rc_keydown(void *ctx, u32 protocol, u64 scancode, u32 toggle)
  *	Description
@@ -3212,6 +3364,8 @@ union bpf_attr {
  *		"**y**".
  *	Return
  *		0
+ * 	GPL Compatibility
+ * 		Required
  *
  * u64 bpf_skb_cgroup_id(struct sk_buff *skb)
  * 	Description
@@ -3228,6 +3382,8 @@ union bpf_attr {
  * 		**CONFIG_SOCK_CGROUP_DATA** configuration option.
  * 	Return
  * 		The id is returned or 0 in case the id could not be retrieved.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * u64 bpf_get_current_cgroup_id(void)
  * 	Return
@@ -3251,6 +3407,8 @@ union bpf_attr {
  *		the shared data.
  *	Return
  *		A pointer to the local storage area.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_sk_select_reuseport(struct sk_reuseport_md *reuse, struct bpf_map *map, void *key, u64 flags)
  *	Description
@@ -3260,6 +3418,8 @@ union bpf_attr {
  *		request in the socket buffer.
  *	Return
  *		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * u64 bpf_skb_ancestor_cgroup_id(struct sk_buff *skb, int ancestor_level)
  *	Description
@@ -3278,6 +3438,8 @@ union bpf_attr {
  *		**bpf_skb_cgroup_id**\ ().
  *	Return
  *		The id is returned or 0 in case the id could not be retrieved.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * struct bpf_sock *bpf_sk_lookup_tcp(void *ctx, struct bpf_sock_tuple *tuple, u32 tuple_size, u64 netns, u64 flags)
  *	Description
@@ -3315,6 +3477,8 @@ union bpf_attr {
  *		For sockets with reuseport option, the **struct bpf_sock**
  *		result is from *reuse*\ **->socks**\ [] using the hash of the
  *		tuple.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * struct bpf_sock *bpf_sk_lookup_udp(void *ctx, struct bpf_sock_tuple *tuple, u32 tuple_size, u64 netns, u64 flags)
  *	Description
@@ -3352,6 +3516,8 @@ union bpf_attr {
  *		For sockets with reuseport option, the **struct bpf_sock**
  *		result is from *reuse*\ **->socks**\ [] using the hash of the
  *		tuple.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_sk_release(void *sock)
  *	Description
@@ -3360,6 +3526,8 @@ union bpf_attr {
  *		**bpf_sk_lookup_xxx**\ ().
  *	Return
  *		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_map_push_elem(struct bpf_map *map, const void *value, u64 flags)
  * 	Description
@@ -3370,6 +3538,8 @@ union bpf_attr {
  * 			removed to make room for this.
  * 	Return
  * 		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_map_pop_elem(struct bpf_map *map, void *value)
  * 	Description
@@ -3382,6 +3552,8 @@ union bpf_attr {
  * 		Get an element from *map* without removing it.
  * 	Return
  * 		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_msg_push_data(struct sk_msg_buff *msg, u32 start, u32 len, u64 flags)
  *	Description
@@ -3398,6 +3570,8 @@ union bpf_attr {
  *		error and BPF programs will need to handle them.
  *	Return
  *		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_msg_pop_data(struct sk_msg_buff *msg, u32 start, u32 len, u64 flags)
  *	Description
@@ -3410,6 +3584,8 @@ union bpf_attr {
  *		payload and/or *pop* value being to large.
  *	Return
  *		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_rc_pointer_rel(void *ctx, s32 rel_x, s32 rel_y)
  *	Description
@@ -3424,6 +3600,8 @@ union bpf_attr {
  *		"**y**".
  *	Return
  *		0
+ * 	GPL Compatibility
+ * 		Required
  *
  * long bpf_spin_lock(struct bpf_spin_lock *lock)
  *	Description
@@ -3472,6 +3650,8 @@ union bpf_attr {
  *		* **bpf_spin_lock** is not allowed in inner maps of map-in-map.
  *	Return
  *		0
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_spin_unlock(struct bpf_spin_lock *lock)
  *	Description
@@ -3479,6 +3659,8 @@ union bpf_attr {
  *		**bpf_spin_lock**\ (\ *lock*\ ).
  *	Return
  *		0
+ * 	GPL Compatibility
+ * 		Not required
  *
  * struct bpf_sock *bpf_sk_fullsock(struct bpf_sock *sk)
  *	Description
@@ -3487,6 +3669,8 @@ union bpf_attr {
  *	Return
  *		A **struct bpf_sock** pointer on success, or **NULL** in
  *		case of failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * struct bpf_tcp_sock *bpf_tcp_sock(struct bpf_sock *sk)
  *	Description
@@ -3495,6 +3679,8 @@ union bpf_attr {
  *	Return
  *		A **struct bpf_tcp_sock** pointer on success, or **NULL** in
  *		case of failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_skb_ecn_set_ce(struct sk_buff *skb)
  *	Description
@@ -3505,6 +3691,8 @@ union bpf_attr {
  *	Return
  *		1 if the **CE** flag is set (either by the current helper call
  *		or because it was already present), 0 if it is not set.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * struct bpf_sock *bpf_get_listener_sock(struct bpf_sock *sk)
  *	Description
@@ -3513,6 +3701,8 @@ union bpf_attr {
  *	Return
  *		A **struct bpf_sock** pointer on success, or **NULL** in
  *		case of failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * struct bpf_sock *bpf_skc_lookup_tcp(void *ctx, struct bpf_sock_tuple *tuple, u32 tuple_size, u64 netns, u64 flags)
  *	Description
@@ -3532,6 +3722,8 @@ union bpf_attr {
  *		For sockets with reuseport option, the **struct bpf_sock**
  *		result is from *reuse*\ **->socks**\ [] using the hash of the
  *		tuple.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_tcp_check_syncookie(void *sk, void *iph, u32 iph_len, struct tcphdr *th, u32 th_len)
  * 	Description
@@ -3547,6 +3739,8 @@ union bpf_attr {
  * 	Return
  * 		0 if *iph* and *th* are a valid SYN cookie ACK, or a negative
  * 		error otherwise.
+ * 	GPL Compatibility
+ * 		Required
  *
  * long bpf_sysctl_get_name(struct bpf_sysctl *ctx, char *buf, size_t buf_len, u64 flags)
  *	Description
@@ -3563,6 +3757,8 @@ union bpf_attr {
  *
  *		**-E2BIG** if the buffer wasn't big enough (*buf* will contain
  *		truncated name in this case).
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_sysctl_get_current_value(struct bpf_sysctl *ctx, char *buf, size_t buf_len)
  *	Description
@@ -3582,6 +3778,8 @@ union bpf_attr {
  *
  *		**-EINVAL** if current value was unavailable, e.g. because
  *		sysctl is uninitialized and read returns -EIO for it.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_sysctl_get_new_value(struct bpf_sysctl *ctx, char *buf, size_t buf_len)
  *	Description
@@ -3599,6 +3797,8 @@ union bpf_attr {
  *		truncated name in this case).
  *
  *		**-EINVAL** if sysctl is being read.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_sysctl_set_new_value(struct bpf_sysctl *ctx, const char *buf, size_t buf_len)
  *	Description
@@ -3616,6 +3816,8 @@ union bpf_attr {
  *		**-E2BIG** if the *buf_len* is too big.
  *
  *		**-EINVAL** if sysctl is being read.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_strtol(const char *buf, size_t buf_len, u64 flags, long *res)
  *	Description
@@ -3640,6 +3842,8 @@ union bpf_attr {
  *		was provided.
  *
  *		**-ERANGE** if resulting value was out of range.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_strtoul(const char *buf, size_t buf_len, u64 flags, unsigned long *res)
  *	Description
@@ -3663,6 +3867,8 @@ union bpf_attr {
  *		was provided.
  *
  *		**-ERANGE** if resulting value was out of range.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * void *bpf_sk_storage_get(struct bpf_map *map, void *sk, void *value, u64 flags)
  *	Description
@@ -3694,6 +3900,8 @@ union bpf_attr {
  *
  *		**NULL** if not found or there was an error in adding
  *		a new bpf-local-storage.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_sk_storage_delete(struct bpf_map *map, void *sk)
  *	Description
@@ -3703,6 +3911,8 @@ union bpf_attr {
  *
  *		**-ENOENT** if the bpf-local-storage cannot be found.
  *		**-EINVAL** if sk is not a fullsock (e.g. a request_sock).
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_send_signal(u32 sig)
  *	Description
@@ -3718,6 +3928,8 @@ union bpf_attr {
  *		**-EPERM** if no permission to send the *sig*.
  *
  *		**-EAGAIN** if bpf program can try again.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * s64 bpf_tcp_gen_syncookie(void *sk, void *iph, u32 iph_len, struct tcphdr *th, u32 th_len)
  *	Description
@@ -3744,6 +3956,8 @@ union bpf_attr {
  *		**-EOPNOTSUPP** kernel configuration does not enable SYN cookies
  *
  *		**-EPROTONOSUPPORT** IP packet version is not 4 or 6
+ * 	GPL Compatibility
+ * 		Required
  *
  * long bpf_skb_output(void *ctx, struct bpf_map *map, u64 flags, void *data, u64 size)
  * 	Description
@@ -3768,6 +3982,8 @@ union bpf_attr {
  * 		restricted to raw_tracepoint bpf programs.
  * 	Return
  * 		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Required
  *
  * long bpf_probe_read_user(void *dst, u32 size, const void *unsafe_ptr)
  * 	Description
@@ -3782,6 +3998,8 @@ union bpf_attr {
  * 		*unsafe_ptr* and store the data in *dst*.
  * 	Return
  * 		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Required
  *
  * long bpf_probe_read_user_str(void *dst, u32 size, const void *unsafe_ptr)
  * 	Description
@@ -3826,6 +4044,8 @@ union bpf_attr {
  * 		On success, the strictly positive length of the output string,
  * 		including the trailing NUL character. On error, a negative
  * 		value.
+ * 	GPL Compatibility
+ * 		Required
  *
  * long bpf_probe_read_kernel_str(void *dst, u32 size, const void *unsafe_ptr)
  * 	Description
@@ -3841,6 +4061,8 @@ union bpf_attr {
  *		*rcv_nxt* is the ack_seq to be sent out.
  *	Return
  *		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Required
  *
  * long bpf_send_signal_thread(u32 sig)
  *	Description
@@ -3855,12 +4077,16 @@ union bpf_attr {
  *		**-EPERM** if no permission to send the *sig*.
  *
  *		**-EAGAIN** if bpf program can try again.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * u64 bpf_jiffies64(void)
  *	Description
  *		Obtain the 64bit jiffies
  *	Return
  *		The 64 bit jiffies
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_read_branch_records(struct bpf_perf_event_data *ctx, void *buf, u32 size, u64 flags)
  *	Description
@@ -3880,6 +4106,8 @@ union bpf_attr {
  *		of **sizeof**\ (**struct perf_branch_entry**\ ).
  *
  *		**-ENOENT** if architecture does not support branch records.
+ * 	GPL Compatibility
+ * 		Required
  *
  * long bpf_get_ns_current_pid_tgid(u64 dev, u64 ino, struct bpf_pidns_info *nsdata, u32 size)
  *	Description
@@ -3892,6 +4120,8 @@ union bpf_attr {
  *              with nsfs of current task, or if dev conversion to dev_t lost high bits.
  *
  *		**-ENOENT** if pidns does not exists for the current task.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_xdp_output(void *ctx, struct bpf_map *map, u64 flags, void *data, u64 size)
  *	Description
@@ -3916,6 +4146,8 @@ union bpf_attr {
  *		restricted to raw_tracepoint bpf programs.
  *	Return
  *		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Required
  *
  * u64 bpf_get_netns_cookie(void *ctx)
  * 	Description
@@ -3929,6 +4161,8 @@ union bpf_attr {
  * 		namespaces instead of sockets.
  * 	Return
  * 		A 8-byte long opaque number.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * u64 bpf_get_current_ancestor_cgroup_id(int ancestor_level)
  * 	Description
@@ -3947,6 +4181,8 @@ union bpf_attr {
  * 		**bpf_get_current_cgroup_id**\ ().
  * 	Return
  * 		The id is returned or 0 in case the id could not be retrieved.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_sk_assign(struct sk_buff *skb, void *sk, u64 flags)
  *	Description
@@ -3978,6 +4214,8 @@ union bpf_attr {
  *
  *		**-ESOCKTNOSUPPORT** if the socket type is not supported
  *		(reuseport).
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_sk_assign(struct bpf_sk_lookup *ctx, struct bpf_sock *sk, u64 flags)
  *	Description
@@ -4028,6 +4266,8 @@ union bpf_attr {
  *
  *		* **-ESOCKTNOSUPPORT** if socket is not in allowed
  *		  state (TCP listening or UDP unconnected).
+ * 	GPL Compatibility
+ * 		Not required
  *
  * u64 bpf_ktime_get_boot_ns(void)
  * 	Description
@@ -4036,6 +4276,8 @@ union bpf_attr {
  * 		See: **clock_gettime**\ (**CLOCK_BOOTTIME**)
  * 	Return
  * 		Current *ktime*.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_seq_printf(struct seq_file *m, const char *fmt, u32 fmt_size, const void *data, u32 data_len)
  * 	Description
@@ -4065,6 +4307,8 @@ union bpf_attr {
  *		**-E2BIG** if *fmt* contains too many format specifiers.
  *
  *		**-EOVERFLOW** if an overflow happened: The same object will be tried again.
+ * 	GPL Compatibility
+ * 		Required
  *
  * long bpf_seq_write(struct seq_file *m, const void *data, u32 len)
  * 	Description
@@ -4075,6 +4319,8 @@ union bpf_attr {
  * 		0 on success, or a negative error in case of failure:
  *
  *		**-EOVERFLOW** if an overflow happened: The same object will be tried again.
+ * 	GPL Compatibility
+ * 		Required
  *
  * u64 bpf_sk_cgroup_id(void *sk)
  *	Description
@@ -4089,6 +4335,8 @@ union bpf_attr {
  *		the **CONFIG_SOCK_CGROUP_DATA** configuration option.
  *	Return
  *		The id is returned or 0 in case the id could not be retrieved.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * u64 bpf_sk_ancestor_cgroup_id(void *sk, int ancestor_level)
  *	Description
@@ -4107,6 +4355,8 @@ union bpf_attr {
  *		**bpf_sk_cgroup_id**\ ().
  *	Return
  *		The id is returned or 0 in case the id could not be retrieved.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_ringbuf_output(void *ringbuf, void *data, u64 size, u64 flags)
  * 	Description
@@ -4124,6 +4374,8 @@ union bpf_attr {
  * 		as it will process the newly added payload automatically.
  * 	Return
  * 		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * void *bpf_ringbuf_reserve(void *ringbuf, u64 size, u64 flags)
  * 	Description
@@ -4132,6 +4384,8 @@ union bpf_attr {
  * 	Return
  * 		Valid pointer with *size* bytes of memory available; NULL,
  * 		otherwise.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * void bpf_ringbuf_submit(void *data, u64 flags)
  * 	Description
@@ -4146,6 +4400,8 @@ union bpf_attr {
  * 		See 'bpf_ringbuf_output()' for the definition of adaptive notification.
  * 	Return
  * 		Nothing. Always succeeds.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * void bpf_ringbuf_discard(void *data, u64 flags)
  * 	Description
@@ -4160,6 +4416,8 @@ union bpf_attr {
  * 		See 'bpf_ringbuf_output()' for the definition of adaptive notification.
  * 	Return
  * 		Nothing. Always succeeds.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * u64 bpf_ringbuf_query(void *ringbuf, u64 flags)
  *	Description
@@ -4177,6 +4435,8 @@ union bpf_attr {
  *		calculation.
  *	Return
  *		Requested value, or 0, if *flags* are not recognized.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_csum_level(struct sk_buff *skb, u64 level)
  * 	Description
@@ -4209,36 +4469,48 @@ union bpf_attr {
  * 		case of **BPF_CSUM_LEVEL_QUERY**, the current skb->csum_level
  * 		is returned or the error code -EACCES in case the skb is not
  * 		subject to CHECKSUM_UNNECESSARY.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * struct tcp6_sock *bpf_skc_to_tcp6_sock(void *sk)
  *	Description
  *		Dynamically cast a *sk* pointer to a *tcp6_sock* pointer.
  *	Return
  *		*sk* if casting is valid, or **NULL** otherwise.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * struct tcp_sock *bpf_skc_to_tcp_sock(void *sk)
  *	Description
  *		Dynamically cast a *sk* pointer to a *tcp_sock* pointer.
  *	Return
  *		*sk* if casting is valid, or **NULL** otherwise.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * struct tcp_timewait_sock *bpf_skc_to_tcp_timewait_sock(void *sk)
  * 	Description
  *		Dynamically cast a *sk* pointer to a *tcp_timewait_sock* pointer.
  *	Return
  *		*sk* if casting is valid, or **NULL** otherwise.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * struct tcp_request_sock *bpf_skc_to_tcp_request_sock(void *sk)
  * 	Description
  *		Dynamically cast a *sk* pointer to a *tcp_request_sock* pointer.
  *	Return
  *		*sk* if casting is valid, or **NULL** otherwise.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * struct udp6_sock *bpf_skc_to_udp6_sock(void *sk)
  * 	Description
  *		Dynamically cast a *sk* pointer to a *udp6_sock* pointer.
  *	Return
  *		*sk* if casting is valid, or **NULL** otherwise.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_get_task_stack(struct task_struct *task, void *buf, u32 size, u64 flags)
  *	Description
@@ -4271,6 +4543,8 @@ union bpf_attr {
  *	Return
  *		A non-negative value equal to or less than *size* on success,
  *		or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_load_hdr_opt(struct bpf_sock_ops *skops, void *searchby_res, u32 len, u64 flags)
  *	Description
@@ -4334,6 +4608,8 @@ union bpf_attr {
  *
  *		**-EPERM** if the helper cannot be used under the current
  *		*skops*\ **->op**.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_store_hdr_opt(struct bpf_sock_ops *skops, const void *from, u32 len, u64 flags)
  *	Description
@@ -4367,6 +4643,8 @@ union bpf_attr {
  *
  *		**-EPERM** if the helper cannot be used under the current
  *		*skops*\ **->op**.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_reserve_hdr_opt(struct bpf_sock_ops *skops, u32 len, u64 flags)
  *	Description
@@ -4389,6 +4667,8 @@ union bpf_attr {
  *
  *		**-EPERM** if the helper cannot be used under the current
  *		*skops*\ **->op**.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * void *bpf_inode_storage_get(struct bpf_map *map, void *inode, void *value, u64 flags)
  *	Description
@@ -4425,6 +4705,8 @@ union bpf_attr {
  *		0 on success.
  *
  *		**-ENOENT** if the bpf_local_storage cannot be found.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_d_path(struct path *path, char *buf, u32 sz)
  *	Description
@@ -4437,6 +4719,8 @@ union bpf_attr {
  *		On success, the strictly positive length of the string,
  *		including the trailing NUL character. On error, a negative
  *		value.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_copy_from_user(void *dst, u32 size, const void *user_ptr)
  * 	Description
@@ -4444,6 +4728,8 @@ union bpf_attr {
  * 		the data in *dst*. This is a wrapper of **copy_from_user**\ ().
  * 	Return
  * 		0 on success, or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_snprintf_btf(char *str, u32 str_size, struct btf_ptr *ptr, u32 btf_ptr_size, u64 flags)
  *	Description
@@ -4480,6 +4766,8 @@ union bpf_attr {
  *		The number of bytes that were written (or would have been
  *		written if output had to be truncated due to string size),
  *		or a negative error in cases of failure.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_seq_printf_btf(struct seq_file *m, struct btf_ptr *ptr, u32 ptr_size, u64 flags)
  *	Description
@@ -4488,6 +4776,8 @@ union bpf_attr {
  *		*flags* are identical to those used for bpf_snprintf_btf.
  *	Return
  *		0 on success or a negative error in case of failure.
+ * 	GPL Compatibility
+ * 		Required
  *
  * u64 bpf_skb_cgroup_classid(struct sk_buff *skb)
  * 	Description
@@ -4518,6 +4808,8 @@ union bpf_attr {
  * 	Return
  * 		The helper returns **TC_ACT_REDIRECT** on success or
  * 		**TC_ACT_SHOT** on error.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * void *bpf_per_cpu_ptr(const void *percpu_ptr, u32 cpu)
  *     Description
@@ -4535,6 +4827,8 @@ union bpf_attr {
  *     Return
  *             A pointer pointing to the kernel percpu variable on *cpu*, or
  *             NULL, if *cpu* is invalid.
+ *     GPL Compatibility
+ *             Not required
  *
  * void *bpf_this_cpu_ptr(const void *percpu_ptr)
  *	Description
@@ -4547,6 +4841,8 @@ union bpf_attr {
  *		never return NULL.
  *	Return
  *		A pointer pointing to the kernel percpu variable on this cpu.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_redirect_peer(u32 ifindex, u64 flags)
  * 	Description
@@ -4563,6 +4859,8 @@ union bpf_attr {
  * 	Return
  * 		The helper returns **TC_ACT_REDIRECT** on success or
  * 		**TC_ACT_SHOT** on error.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * void *bpf_task_storage_get(struct bpf_map *map, struct task_struct *task, void *value, u64 flags)
  *	Description
@@ -4591,6 +4889,8 @@ union bpf_attr {
  *
  *		**NULL** if not found or there was an error in adding
  *		a new bpf_local_storage.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_task_storage_delete(struct bpf_map *map, struct task_struct *task)
  *	Description
@@ -4599,6 +4899,8 @@ union bpf_attr {
  *		0 on success.
  *
  *		**-ENOENT** if the bpf_local_storage cannot be found.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * struct task_struct *bpf_get_current_task_btf(void)
  *	Description
@@ -4607,6 +4909,8 @@ union bpf_attr {
  *		*ARG_PTR_TO_BTF_ID* of type *task_struct*.
  *	Return
  *		Pointer to the current task.
+ * 	GPL Compatibility
+ * 		Required
  *
  * long bpf_bprm_opts_set(struct linux_binprm *bprm, u64 flags)
  *	Description
@@ -4617,6 +4921,8 @@ union bpf_attr {
  *		is cleared if the flag is not specified.
  *	Return
  *		**-EINVAL** if invalid *flags* are passed, zero otherwise.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * u64 bpf_ktime_get_coarse_ns(void)
  * 	Description
@@ -4627,6 +4933,8 @@ union bpf_attr {
  * 		See: **clock_gettime**\ (**CLOCK_MONOTONIC_COARSE**)
  * 	Return
  * 		Current *ktime*.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_ima_inode_hash(struct inode *inode, void *dst, u32 size)
  *	Description
@@ -4637,6 +4945,8 @@ union bpf_attr {
  *		The **hash_algo** is returned on success,
  *		**-EOPNOTSUP** if IMA is disabled or **-EINVAL** if
  *		invalid arguments are passed.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * struct socket *bpf_sock_from_file(struct file *file)
  *	Description
@@ -4645,6 +4955,8 @@ union bpf_attr {
  *	Return
  *		A pointer to a struct socket on success or NULL if the file is
  *		not a socket.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_check_mtu(void *ctx, u32 ifindex, u32 *mtu_len, s32 len_diff, u64 flags)
  *	Description
@@ -4712,6 +5024,8 @@ union bpf_attr {
  *
  *		* **BPF_MTU_CHK_RET_FRAG_NEEDED**
  *		* **BPF_MTU_CHK_RET_SEGS_TOOBIG**
+ * 	GPL Compatibility
+ * 		Required
  *
  * long bpf_for_each_map_elem(struct bpf_map *map, void *callback_fn, void *callback_ctx, u64 flags)
  *	Description
@@ -4741,6 +5055,8 @@ union bpf_attr {
  *	Return
  *		The number of traversed map elements for success, **-EINVAL** for
  *		invalid **flags**.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_snprintf(char *str, u32 str_size, const char *fmt, u64 *data, u32 data_len)
  *	Description
@@ -4768,24 +5084,32 @@ union bpf_attr {
  *		be zero-terminated except when **str_size** is 0.
  *
  *		Or **-EBUSY** if the per-CPU memory copy buffer is busy.
+ * 	GPL Compatibility
+ * 		Required
  *
  * long bpf_sys_bpf(u32 cmd, void *attr, u32 attr_size)
  * 	Description
  * 		Execute bpf syscall with given arguments.
  * 	Return
  * 		A syscall result.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_btf_find_by_name_kind(char *name, int name_sz, u32 kind, int flags)
  * 	Description
  * 		Find BTF type with given name and kind in vmlinux BTF or in module's BTFs.
  * 	Return
  * 		Returns btf_id and btf_obj_fd in lower and upper 32 bits.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_sys_close(u32 fd)
  * 	Description
  * 		Execute close syscall for given FD.
  * 	Return
  * 		A syscall result.
+ * 	GPL Compatibility
+ * 		Not required
  *
  * long bpf_timer_init(struct bpf_timer *timer, struct bpf_map *map, u64 flags)
  *	Description
@@ -4803,6 +5127,8 @@ union bpf_attr {
  *		The user space should either hold a file descriptor to a map with timers
  *		or pin such map in bpffs. When map is unpinned or file descriptor is
  *		closed all timers in the map will be cancelled and freed.
+ * 	GPL Compatibility
+ * 		Required
  *
  * long bpf_timer_set_callback(struct bpf_timer *timer, void *callback_fn)
  *	Description
@@ -4814,6 +5140,8 @@ union bpf_attr {
  *		The user space should either hold a file descriptor to a map with timers
  *		or pin such map in bpffs. When map is unpinned or file descriptor is
  *		closed all timers in the map will be cancelled and freed.
+ * 	GPL Compatibility
+ * 		Required
  *
  * long bpf_timer_start(struct bpf_timer *timer, u64 nsecs, u64 flags)
  *	Description
@@ -4840,6 +5168,8 @@ union bpf_attr {
  *		0 on success.
  *		**-EINVAL** if *timer* was not initialized with bpf_timer_init() earlier
  *		or invalid *flags* are passed.
+ * 	GPL Compatibility
+ * 		Required
  *
  * long bpf_timer_cancel(struct bpf_timer *timer)
  *	Description
@@ -4850,12 +5180,16 @@ union bpf_attr {
  *		**-EINVAL** if *timer* was not initialized with bpf_timer_init() earlier.
  *		**-EDEADLK** if callback_fn tried to call bpf_timer_cancel() on its
  *		own timer which would have led to a deadlock otherwise.
+ * 	GPL Compatibility
+ * 		Required
  *
  * u64 bpf_get_func_ip(void *ctx)
  * 	Description
  * 		Get address of the traced function (for tracing and kprobe programs).
  * 	Return
  * 		Address of the traced function.
+ * 	GPL Compatibility
+ * 		Required
  *
  * u64 bpf_get_attach_cookie(void *ctx)
  * 	Description
@@ -4871,6 +5205,8 @@ union bpf_attr {
  * 	Return
  *		Value specified by user at BPF link creation/attachment time
  *		or 0, if it was not specified.
+ * 	GPL Compatibility
+ * 		Not required
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
-- 
2.32.0

