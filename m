Return-Path: <bpf+bounces-44855-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F289C9160
	for <lists+bpf@lfdr.de>; Thu, 14 Nov 2024 19:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BD16B45EEC
	for <lists+bpf@lfdr.de>; Thu, 14 Nov 2024 17:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9262418756A;
	Thu, 14 Nov 2024 17:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RApiu4jl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A3B17BED0
	for <bpf@vger.kernel.org>; Thu, 14 Nov 2024 17:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731604055; cv=none; b=DjDKtYfp1BYO0sqyIv1BH1//IiOTBi2FIAo8lP4upH9Jb28bHmWEw+ImLdLLIGXEzhOaRVMo5kzTkqqVSJ1PvBj68IttF5XypM4KP7ET/2rxDQNiGYaEU/BJzzQXaiJhoB5+gbnwFwG2eVFlPlFULB6jLnfiuG6sw/K/WZgPT3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731604055; c=relaxed/simple;
	bh=FAuZYrXT/nfT1f8q2wcZtGxsGiHjz0T/HV/jpAHYgQo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hUYW4kO3tRIHYuSg5C+hIMs4RCa8STlYsn4TaTTqZQuUHfchPFnkx3Z4aFVF8lh7H0h6icjlk60kB9zy8Bn1gt/jCLUiYc+x2H+OzUNL9BBfU25FEA/lQ6h0zDinVfGq/5BRXEUeNn0vU2VqCOHKHUKJfseBreExNXgZm3m7kVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RApiu4jl; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-290d8d53893so349442fac.2
        for <bpf@vger.kernel.org>; Thu, 14 Nov 2024 09:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731604050; x=1732208850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QQjTPMGs+IVUcwo37dJkcLgqGYh4HTmeCBHREpLVAcY=;
        b=RApiu4jlGiYHr9bGeo/IAivGU6XPifm7NtvEaIEhfDTRqeG5WpLmJSQnsUHI3tP6+n
         IGcmPI3hRaZVDo3+R+mLHAhOpHlqbNDnxCN12Gaa1gdMAP0Hs2bEdt/jzS7YSsBqjZ/T
         J5fL8G3eY7ICerjERay5YTsICX7sN9pIsxE+kNGZQsK+dhvDhU0WvgJX58zRX1qJYwrJ
         L2WPKMId3BtB2uzbjEcBVuzikzrcWoeo8HU7wBCe0Mrrhdj69IWOCv5IiLxBNIPJVm+g
         sasLrXp5KbjOZyUjmChOVpdhixmbOg6Mj2JxMRdszzYtH7mgPUbgLqgZ/RrFSdvDy9Zx
         r29w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731604050; x=1732208850;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QQjTPMGs+IVUcwo37dJkcLgqGYh4HTmeCBHREpLVAcY=;
        b=VSA2YRE7CXa/AuHc23L1DuU4q4edT2G2YSPTzphSILZsnVlHJkdowTbPSsEl0Dl08C
         ExFiRF76faRbTrtQDVk5nZFB9HXpT39m9KHW1A7PiG4M0oQ0YH9bV/Z1CVv88rgIEEov
         x4G38Msh34mTImSDnzX/ZGfMiptEujAxLBweTCcBL0jIx28bd2vaejS2yepF6rYvykX+
         FIbbM9BOc9vL1vhOAEUsE2HL5PnSx/zpJZMRaNNasvADPJYasuQzJVVrPhzErNE7k2Zy
         mKryJvmHrYaotlln4cJEncYLoSQbuBBVT19SxvN+7bO6GSHG3BonON0AarvMDQjET5vl
         zNbw==
X-Gm-Message-State: AOJu0YyMNZn1mddxOuaCATr6DewPgSYMId+ueuTrunTpsX1kft68untU
	+HQ3uVru8Aw1+12ETAXkPODJl4yuC9FycktV4fXcB9OO8miuFEQrQ9NrL3Ev
X-Google-Smtp-Source: AGHT+IEJpp5A/ADumgYlwQJK3vpr6bn269LQgXrSAfnm9oB92k3Ea///et6tUtHesBdNM/EewMClVg==
X-Received: by 2002:a05:6871:b09:b0:287:b4c7:b6dc with SMTP id 586e51a60fabf-29560134014mr22374264fac.22.1731604049553;
        Thu, 14 Nov 2024 09:07:29 -0800 (PST)
Received: from localhost (fwdproxy-atn-018.fbsv.net. [2a03:2880:10ff:12::face:b00c])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71a6eb75313sm501486a34.69.2024.11.14.09.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 09:07:28 -0800 (PST)
From: Ryan Wilson <ryantimwilson@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net
Cc: ryantimwilson@meta.com
Subject: [PATCH bpf-next] bpf: Add multi-prog support for XDP BPF programs
Date: Thu, 14 Nov 2024 09:07:21 -0800
Message-ID: <20241114170721.3939099-1-ryantimwilson@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, network devices only support a single XDP program. However,
there are use cases for multiple XDP programs per device. For example,
at Meta, we have XDP programs for firewalls, DDOS and logging that must
all run in a specific order. To work around the lack of multi-program
support, a single daemon loads all programs and uses bpf_tail_call()
in a loop to jump to each program contained in a BPF map.

This patch proposes allowing multiple XDP programs per device based
on the mprog API from the below commit:

Commit 053c8e1f235d ("bpf: Add generic attach/detach/query API for
multi-progs")

This patch adds support for multi-progs for generic XDP and the tunnel
driver, as it shares many APIs with generic XDP. Each driver can be
migrated by:
1. Return 0 for command = XDP_QUERY_MPROG_SUPPORT
2. Codemod xdp.prog -> xdp.array in driver code
3. Run programs with bpf_mprog_run_xdp()
4. Change bpf_prog_put() to bpf_mprog_array_put()

Note non-migrated driver are currently backwards compatible. They will
receive a single program object but attachment will fail if user tries
to attach multiple BPF programs.

Note this patch is more complex than its TCX counterpart

Commit e420bed02507 ("bpf: Add fd-based tcx multi-prog infra with
link support")

This is because XDP program attachment/detachment is done via BPF links and
netlink socket unlike bpf_prog_attach() syscall. We only add multi-progs
support for BPF links in this commit but ensure the netlink socket is
backwards compatible with single program attachment/detachment/queries.

Unlike TCX, each driver needs to own a reference to the BPF programs it
runs. Thus, we introduce struct bpf_mprog_array to copy from
bpf_mprog_entry owned by the network device. The BPF driver then will
release the array via bpf_mprog_array_put() which will decrement each
BPF program refcount and free the array memory.

Furthermore, we typically set the BPF multi-prog flags via
link_create.flags e.g. BPF_F_BEFORE. However, there are already XDP_*
flags set via link_create.flags e.g. XDP_FLAGS_SKB_MODE. For example,
BPF_F_REPLACE and XDP_FLAGS_DRV_MODE both have the same value. Thus to
allow for setting both XDP_* mode and BPF_* multi-prog flags when using
BPF links, we introduce link_create.xdp.flags for setting BPF_* flags
specifically. However, feedback is needed on this approach to make sure
its compatible with libbpf.

Note I am in the process of verifying no/minimal performance overhead
for a real driver but I am sending this patch for feedback on the overall
approach.

Signed-off-by: Ryan Wilson <ryantimwilson@gmail.com>
---
 drivers/net/tun.c                             |  54 +--
 include/linux/bpf_mprog.h                     |  72 +++
 include/linux/netdevice.h                     |  23 +-
 include/linux/skbuff.h                        |   3 +-
 include/net/xdp.h                             |  94 ++++
 include/uapi/linux/bpf.h                      |  12 +
 net/core/dev.c                                | 422 ++++++++++++++----
 net/core/rtnetlink.c                          |  16 +-
 net/core/skbuff.c                             |  11 +-
 .../selftests/bpf/prog_tests/xdp_link.c       |  15 +-
 10 files changed, 571 insertions(+), 151 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 9a0f6eb32016..f747ccf2eda7 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -207,7 +207,7 @@ struct tun_struct {
 	u32 flow_count;
 	u32 rx_batched;
 	atomic_long_t rx_frame_errors;
-	struct bpf_prog __rcu *xdp_prog;
+	struct bpf_mprog_array __rcu *xdp_array;
 	struct tun_prog __rcu *steering_prog;
 	struct tun_prog __rcu *filter_prog;
 	struct ethtool_link_ksettings link_ksettings;
@@ -826,7 +826,7 @@ static int tun_attach(struct tun_struct *tun, struct file *file,
 		tun_napi_init(tun, tfile, napi, napi_frags);
 	}
 
-	if (rtnl_dereference(tun->xdp_prog))
+	if (rtnl_dereference(tun->xdp_array))
 		sock_set_flag(&tfile->sk, SOCK_XDP);
 
 	/* device is allowed to go away first, so no need to hold extra
@@ -1188,28 +1188,28 @@ tun_net_get_stats64(struct net_device *dev, struct rtnl_link_stats64 *stats)
 		(unsigned long)atomic_long_read(&tun->rx_frame_errors);
 }
 
-static int tun_xdp_set(struct net_device *dev, struct bpf_prog *prog,
+static int tun_xdp_set(struct net_device *dev, struct bpf_mprog_array *arr,
 		       struct netlink_ext_ack *extack)
 {
 	struct tun_struct *tun = netdev_priv(dev);
 	struct tun_file *tfile;
-	struct bpf_prog *old_prog;
+	struct bpf_mprog_array *old_arr;
 	int i;
 
-	old_prog = rtnl_dereference(tun->xdp_prog);
-	rcu_assign_pointer(tun->xdp_prog, prog);
-	if (old_prog)
-		bpf_prog_put(old_prog);
+	old_arr = rtnl_dereference(tun->xdp_array);
+	rcu_assign_pointer(tun->xdp_array, arr);
+	if (old_arr)
+		bpf_mprog_array_put(old_arr);
 
 	for (i = 0; i < tun->numqueues; i++) {
 		tfile = rtnl_dereference(tun->tfiles[i]);
-		if (prog)
+		if (arr)
 			sock_set_flag(&tfile->sk, SOCK_XDP);
 		else
 			sock_reset_flag(&tfile->sk, SOCK_XDP);
 	}
 	list_for_each_entry(tfile, &tun->disabled, next) {
-		if (prog)
+		if (arr)
 			sock_set_flag(&tfile->sk, SOCK_XDP);
 		else
 			sock_reset_flag(&tfile->sk, SOCK_XDP);
@@ -1222,7 +1222,9 @@ static int tun_xdp(struct net_device *dev, struct netdev_bpf *xdp)
 {
 	switch (xdp->command) {
 	case XDP_SETUP_PROG:
-		return tun_xdp_set(dev, xdp->prog, xdp->extack);
+		return tun_xdp_set(dev, xdp->arr, xdp->extack);
+	case XDP_QUERY_MPROG_SUPPORT:
+		return 0;
 	default:
 		return -EINVAL;
 	}
@@ -1663,6 +1665,7 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 {
 	struct page_frag *alloc_frag = &current->task_frag;
 	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
+	struct bpf_mprog_array *xdp_array;
 	struct bpf_prog *xdp_prog;
 	int buflen = SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
 	char *buf;
@@ -1671,8 +1674,8 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 	int err = 0;
 
 	rcu_read_lock();
-	xdp_prog = rcu_dereference(tun->xdp_prog);
-	if (xdp_prog)
+	xdp_array = rcu_dereference(tun->xdp_array);
+	if (xdp_array)
 		pad += XDP_PACKET_HEADROOM;
 	buflen += SKB_DATA_ALIGN(len + pad);
 	rcu_read_unlock();
@@ -1692,7 +1695,7 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 	 * of xdp_prog above, this should be rare and for simplicity
 	 * we do XDP on skb in case the headroom is not enough.
 	 */
-	if (hdr->gso_type || !xdp_prog) {
+	if (hdr->gso_type || !xdp_array) {
 		*skb_xdp = 1;
 		return __tun_build_skb(tfile, alloc_frag, buf, buflen, len,
 				       pad);
@@ -1703,15 +1706,15 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 	local_bh_disable();
 	rcu_read_lock();
 	bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
-	xdp_prog = rcu_dereference(tun->xdp_prog);
-	if (xdp_prog) {
+	xdp_array = rcu_dereference(tun->xdp_array);
+	if (xdp_array) {
 		struct xdp_buff xdp;
 		u32 act;
 
 		xdp_init_buff(&xdp, buflen, &tfile->xdp_rxq);
 		xdp_prepare_buff(&xdp, buf, pad, len, false);
 
-		act = bpf_prog_run_xdp(xdp_prog, &xdp);
+		act = bpf_mprog_run_xdp(xdp_array, &xdp, &xdp_prog);
 		if (act == XDP_REDIRECT || act == XDP_TX) {
 			get_page(alloc_frag->page);
 			alloc_frag->offset += buflen;
@@ -1919,14 +1922,14 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 	skb_record_rx_queue(skb, tfile->queue_index);
 
 	if (skb_xdp) {
-		struct bpf_prog *xdp_prog;
+		struct bpf_mprog_array *xdp_array;
 		int ret;
 
 		local_bh_disable();
 		rcu_read_lock();
-		xdp_prog = rcu_dereference(tun->xdp_prog);
-		if (xdp_prog) {
-			ret = do_xdp_generic(xdp_prog, &skb);
+		xdp_array = rcu_dereference(tun->xdp_array);
+		if (xdp_array) {
+			ret = do_xdp_generic(xdp_array, &skb);
 			if (ret != XDP_PASS) {
 				rcu_read_unlock();
 				local_bh_enable();
@@ -2447,6 +2450,7 @@ static int tun_xdp_one(struct tun_struct *tun,
 	unsigned int datasize = xdp->data_end - xdp->data;
 	struct tun_xdp_hdr *hdr = xdp->data_hard_start;
 	struct virtio_net_hdr *gso = &hdr->gso;
+	struct bpf_mprog_array *xdp_array;
 	struct bpf_prog *xdp_prog;
 	struct sk_buff *skb = NULL;
 	struct sk_buff_head *queue;
@@ -2459,8 +2463,8 @@ static int tun_xdp_one(struct tun_struct *tun,
 	if (unlikely(datasize < ETH_HLEN))
 		return -EINVAL;
 
-	xdp_prog = rcu_dereference(tun->xdp_prog);
-	if (xdp_prog) {
+	xdp_array = rcu_dereference(tun->xdp_array);
+	if (xdp_array) {
 		if (gso->gso_type) {
 			skb_xdp = true;
 			goto build;
@@ -2469,7 +2473,7 @@ static int tun_xdp_one(struct tun_struct *tun,
 		xdp_init_buff(xdp, buflen, &tfile->xdp_rxq);
 		xdp_set_data_meta_invalid(xdp);
 
-		act = bpf_prog_run_xdp(xdp_prog, xdp);
+		act = bpf_mprog_run_xdp(xdp_array, xdp, &xdp_prog);
 		ret = tun_xdp_act(tun, xdp_prog, xdp, act);
 		if (ret < 0) {
 			put_page(virt_to_head_page(xdp->data));
@@ -2520,7 +2524,7 @@ static int tun_xdp_one(struct tun_struct *tun,
 	skb_record_rx_queue(skb, tfile->queue_index);
 
 	if (skb_xdp) {
-		ret = do_xdp_generic(xdp_prog, &skb);
+		ret = do_xdp_generic(xdp_array, &skb);
 		if (ret != XDP_PASS) {
 			ret = 0;
 			goto out;
diff --git a/include/linux/bpf_mprog.h b/include/linux/bpf_mprog.h
index 929225f7b095..0d014d7eaaa5 100644
--- a/include/linux/bpf_mprog.h
+++ b/include/linux/bpf_mprog.h
@@ -110,6 +110,35 @@
  *
  * The READ_ONCE()/WRITE_ONCE() pairing for bpf_mprog_fp's prog access is for
  * the replacement case where we don't swap the bpf_mprog_entry.
+ *
+ * However, there are cases where multiple BPF programs must be co-owned with
+ * other modules e.g. netdevice and drivers both hold their own RCU protected
+ * pointers to BPF programs. Moreover, drivers may fail to detach multiple
+ * BPF programs while netdevice may successfully detach the program. To deal
+ * with these cases, we copy the fast-path BPF programs via bpf_mprog_array.
+ * For example, while attaching an XDP program:
+ *
+ *   struct bpf_mprog_entry *entry, *entry_new;
+ *   struct bpf_mprog_array *arr;
+ *   int ret;
+ *
+ *   // bpf_mprog user-side lock
+ *   // fetch active @entry from attach location
+ *   [...]
+ *   ret = bpf_mprog_attach(entry, &entry_new, [...]);
+ *   if (!ret) {
+ *       if (entry != entry_new) {
+ *           // allocate BPF program array
+ *           bpf_mprog_array_init(arr, entry);
+ *           // send BPF program array to xdp driver
+ *           synchronize_rcu();
+ *       }
+ *       bpf_mprog_commit(entry);
+ *   } else {
+ *       // error path, bail out, propagate @ret
+ *   }
+ *   // bpf_mprog user-side unlock
+ *
  */
 
 #define bpf_mprog_foreach_tuple(entry, fp, cp, t)			\
@@ -155,6 +184,11 @@ struct bpf_tuple {
 	struct bpf_link *link;
 };
 
+struct bpf_mprog_array {
+	struct bpf_mprog_fp fp_items[BPF_MPROG_MAX];
+	struct rcu_head rcu;
+};
+
 static inline struct bpf_mprog_entry *
 bpf_mprog_peer(const struct bpf_mprog_entry *entry)
 {
@@ -212,6 +246,16 @@ static inline bool bpf_mprog_exists(struct bpf_mprog_entry *entry,
 	return false;
 }
 
+static inline struct bpf_prog *bpf_mprog_head(struct bpf_mprog_entry *entry)
+{
+	const struct bpf_mprog_fp *fp;
+	struct bpf_prog *tmp;
+
+	bpf_mprog_foreach_prog(entry, fp, tmp)
+		return tmp;
+	return NULL;
+}
+
 static inline void bpf_mprog_mark_for_release(struct bpf_mprog_entry *entry,
 					      struct bpf_tuple *tuple)
 {
@@ -335,9 +379,37 @@ static inline bool bpf_mprog_supported(enum bpf_prog_type type)
 {
 	switch (type) {
 	case BPF_PROG_TYPE_SCHED_CLS:
+	case BPF_PROG_TYPE_XDP:
 		return true;
 	default:
 		return false;
 	}
 }
+
+static inline void bpf_mprog_array_init(struct bpf_mprog_array *arr,
+					struct bpf_mprog_entry *src)
+{
+	const struct bpf_mprog_fp *fp;
+	struct bpf_prog *tmp;
+
+	BUILD_BUG_ON(sizeof(arr->fp_items[0]) > sizeof(u64));
+
+	memset(arr, 0, sizeof(*arr));
+	memcpy(arr->fp_items, src->fp_items, sizeof(src->fp_items));
+
+	bpf_mprog_foreach_prog(arr, fp, tmp) {
+		bpf_prog_inc(tmp);
+	}
+}
+
+static inline void bpf_mprog_array_put(struct bpf_mprog_array *arr)
+{
+	const struct bpf_mprog_fp *fp;
+	struct bpf_prog *tmp;
+
+	bpf_mprog_foreach_prog(arr, fp, tmp) {
+		bpf_prog_put(tmp);
+	}
+	kfree_rcu(arr, rcu);
+}
 #endif /* __BPF_MPROG_H */
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 8896705ccd63..a5b2e10cc965 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -932,13 +932,16 @@ enum bpf_netdev_command {
 	BPF_OFFLOAD_MAP_ALLOC,
 	BPF_OFFLOAD_MAP_FREE,
 	XDP_SETUP_XSK_POOL,
+	/* Queries whether multi-programs are supported by driver. Returns 0
+	 * for yes, < 0 for no. Requires no arguments.
+	 */
+	XDP_QUERY_MPROG_SUPPORT,
 };
 
 struct bpf_prog_offload_ops;
 struct netlink_ext_ack;
 struct xdp_umem;
 struct xdp_dev_bulk_queue;
-struct bpf_xdp_link;
 
 enum bpf_xdp_mode {
 	XDP_MODE_SKB = 0,
@@ -947,18 +950,16 @@ enum bpf_xdp_mode {
 	__MAX_XDP_MODE
 };
 
-struct bpf_xdp_entity {
-	struct bpf_prog *prog;
-	struct bpf_xdp_link *link;
-};
-
 struct netdev_bpf {
 	enum bpf_netdev_command command;
 	union {
 		/* XDP_SETUP_PROG */
 		struct {
 			u32 flags;
-			struct bpf_prog *prog;
+			union {
+				struct bpf_prog *prog;
+				struct bpf_mprog_array *arr;
+			};
 			struct netlink_ext_ack *extack;
 		};
 		/* BPF_OFFLOAD_MAP_ALLOC, BPF_OFFLOAD_MAP_FREE */
@@ -2069,7 +2070,7 @@ struct net_device {
 
 	/* RX read-mostly hotpath */
 	__cacheline_group_begin(net_device_read_rx);
-	struct bpf_prog __rcu	*xdp_prog;
+	struct bpf_mprog_array __rcu	*xdp_array;
 	struct list_head	ptype_specific;
 	int			ifindex;
 	unsigned int		real_num_rx_queues;
@@ -2378,7 +2379,7 @@ struct net_device {
 	struct ethtool_netdev_state *ethtool;
 
 	/* protected by rtnl_lock */
-	struct bpf_xdp_entity	xdp_state[__MAX_XDP_MODE];
+	struct bpf_mprog_entry __rcu	*xdp_state[__MAX_XDP_MODE];
 
 	u8 dev_addr_shadow[MAX_ADDR_LEN];
 	netdevice_tracker	linkwatch_dev_tracker;
@@ -2417,7 +2418,7 @@ struct net_device {
 
 static inline bool netif_elide_gro(const struct net_device *dev)
 {
-	if (!(dev->features & NETIF_F_GRO) || dev->xdp_prog)
+	if (!(dev->features & NETIF_F_GRO) || dev->xdp_array)
 		return true;
 	return false;
 }
@@ -3886,7 +3887,7 @@ static inline void dev_consume_skb_any(struct sk_buff *skb)
 u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
 			     struct bpf_prog *xdp_prog);
 void generic_xdp_tx(struct sk_buff *skb, struct bpf_prog *xdp_prog);
-int do_xdp_generic(struct bpf_prog *xdp_prog, struct sk_buff **pskb);
+int do_xdp_generic(struct bpf_mprog_array *xdp_array, struct sk_buff **pskb);
 int netif_rx(struct sk_buff *skb);
 int __netif_rx(struct sk_buff *skb);
 
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 39f1d16f3628..016d75b1f75b 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -21,6 +21,7 @@
 #include <linux/refcount.h>
 
 #include <linux/atomic.h>
+#include <linux/bpf_mprog.h>
 #include <asm/types.h>
 #include <linux/spinlock.h>
 #include <net/checksum.h>
@@ -3589,7 +3590,7 @@ static inline netmem_ref skb_frag_netmem(const skb_frag_t *frag)
 int skb_pp_cow_data(struct page_pool *pool, struct sk_buff **pskb,
 		    unsigned int headroom);
 int skb_cow_data_for_xdp(struct page_pool *pool, struct sk_buff **pskb,
-			 struct bpf_prog *prog);
+			 struct bpf_mprog_array *arr);
 
 /**
  * skb_frag_address - gets the address of the data contained in a paged fragment
diff --git a/include/net/xdp.h b/include/net/xdp.h
index e6770dd40c91..33ed4a740687 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -7,6 +7,7 @@
 #define __LINUX_NET_XDP_H__
 
 #include <linux/bitfield.h>
+#include <linux/bpf_mprog.h>
 #include <linux/filter.h>
 #include <linux/netdevice.h>
 #include <linux/skbuff.h> /* skb_shared_info */
@@ -520,4 +521,97 @@ static __always_inline u32 bpf_prog_run_xdp(const struct bpf_prog *prog,
 
 	return act;
 }
+
+static __always_inline u32 bpf_mprog_run_xdp(const struct bpf_mprog_array *arr,
+					     struct xdp_buff *xdp,
+					     struct bpf_prog **prog)
+{
+	const struct bpf_mprog_fp *fp;
+	u32 act = XDP_PASS;
+
+	/* prog returns the program that returned the first non-pass XDP action.
+	 * If all programs return XDP_PASS, it returns the last program in the
+	 * array.
+	 */
+	bpf_mprog_foreach_prog(arr, fp, *prog) {
+		act = bpf_prog_run_xdp(*prog, xdp);
+		if (act != XDP_PASS)
+			break;
+	}
+	return act;
+}
+
+struct bpf_xdp_entry {
+	struct bpf_mprog_bundle bundle;
+	struct rcu_head rcu;
+};
+
+static inline struct bpf_xdp_entry *xdp_entry(struct bpf_mprog_entry *entry)
+{
+	struct bpf_mprog_bundle *bundle = entry->parent;
+
+	return container_of(bundle, struct bpf_xdp_entry, bundle);
+}
+
+static inline void
+xdp_entry_update(struct net_device *dev, struct bpf_mprog_entry *entry,
+		 enum bpf_xdp_mode mode)
+{
+	ASSERT_RTNL();
+	rcu_assign_pointer(dev->xdp_state[mode], entry);
+}
+
+static inline void xdp_entry_sync(void)
+{
+	/* bpf_mprog_entry got a/b swapped, therefore ensure that
+	 * there are no inflight users on the old one anymore.
+	 */
+	synchronize_rcu();
+}
+
+static inline struct bpf_mprog_entry *
+xdp_entry_fetch(struct net_device *dev, enum bpf_xdp_mode mode)
+{
+	ASSERT_RTNL();
+	return rcu_dereference_rtnl(dev->xdp_state[mode]);
+}
+
+static inline struct bpf_mprog_entry *xdp_entry_create_cb(void)
+{
+	struct bpf_xdp_entry *xdp = kzalloc(sizeof(*xdp), GFP_KERNEL);
+
+	if (xdp) {
+		bpf_mprog_bundle_init(&xdp->bundle);
+		return &xdp->bundle.a;
+	}
+	return NULL;
+}
+
+#define xdp_entry_create(...)	alloc_hooks(xdp_entry_create_cb(__VA_ARGS__))
+
+static inline void xdp_entry_free(struct bpf_mprog_entry *entry)
+{
+	kfree_rcu(xdp_entry(entry), rcu);
+}
+
+static inline struct bpf_mprog_entry *
+xdp_entry_fetch_or_create(struct net_device *dev, enum bpf_xdp_mode mode, bool *created)
+{
+	struct bpf_mprog_entry *entry = xdp_entry_fetch(dev, mode);
+
+	*created = false;
+	if (!entry) {
+		entry = xdp_entry_create();
+		if (!entry)
+			return NULL;
+		*created = true;
+	}
+	return entry;
+}
+
+static inline bool xdp_entry_is_active(struct bpf_mprog_entry *entry)
+{
+	ASSERT_RTNL();
+	return bpf_mprog_total(entry);
+}
 #endif /* __LINUX_NET_XDP_H__ */
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 4162afc6b5d0..5a0ad33e6d94 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1763,6 +1763,18 @@ union bpf_attr {
 				};
 				__u64		expected_revision;
 			} tcx;
+			struct {
+				union {
+					__u32	relative_fd;
+					__u32	relative_id;
+				};
+				/* link_create.flags contains XDP_* flags. This
+				 * field contains BPF_* flags. Field cannot be
+				 * the same since XDP_* and BPF_* enums overlap.
+				 */
+				__u32		flags;
+				__u64		expected_revision;
+			} xdp;
 			struct {
 				__aligned_u64	path;
 				__aligned_u64	offsets;
diff --git a/net/core/dev.c b/net/core/dev.c
index ea5fbcd133ae..120c2c1aa1ce 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4924,8 +4924,9 @@ static struct netdev_rx_queue *netif_get_rxqueue(struct sk_buff *skb)
 	return rxqueue;
 }
 
-u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
-			     struct bpf_prog *xdp_prog)
+static u32 bpf_mprog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
+				     struct bpf_mprog_array *xdp_array,
+				     struct bpf_prog **xdp_prog)
 {
 	void *orig_data, *orig_data_end, *hard_start;
 	struct netdev_rx_queue *rxqueue;
@@ -4964,7 +4965,10 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
 	orig_bcast = is_multicast_ether_addr_64bits(eth->h_dest);
 	orig_eth_type = eth->h_proto;
 
-	act = bpf_prog_run_xdp(xdp_prog, xdp);
+	if (xdp_array)
+		act = bpf_mprog_run_xdp(xdp_array, xdp, xdp_prog);
+	else
+		act = bpf_prog_run_xdp(*xdp_prog, xdp);
 
 	/* check if bpf_xdp_adjust_head was used */
 	off = xdp->data - orig_data;
@@ -5026,13 +5030,19 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
 	return act;
 }
 
+u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
+			     struct bpf_prog *xdp_prog)
+{
+	return bpf_mprog_run_generic_xdp(skb, xdp, NULL, &xdp_prog);
+}
+
 static int
-netif_skb_check_for_xdp(struct sk_buff **pskb, struct bpf_prog *prog)
+netif_skb_check_for_xdp(struct sk_buff **pskb, struct bpf_mprog_array *arr)
 {
 	struct sk_buff *skb = *pskb;
 	int err, hroom, troom;
 
-	if (!skb_cow_data_for_xdp(this_cpu_read(system_page_pool), pskb, prog))
+	if (!skb_cow_data_for_xdp(this_cpu_read(system_page_pool), pskb, arr))
 		return 0;
 
 	/* In case we have to go down the path and also linearize,
@@ -5051,7 +5061,8 @@ netif_skb_check_for_xdp(struct sk_buff **pskb, struct bpf_prog *prog)
 
 static u32 netif_receive_generic_xdp(struct sk_buff **pskb,
 				     struct xdp_buff *xdp,
-				     struct bpf_prog *xdp_prog)
+				     struct bpf_mprog_array *xdp_array,
+				     struct bpf_prog **xdp_prog)
 {
 	struct sk_buff *skb = *pskb;
 	u32 mac_len, act = XDP_DROP;
@@ -5071,23 +5082,23 @@ static u32 netif_receive_generic_xdp(struct sk_buff **pskb,
 
 	if (skb_cloned(skb) || skb_is_nonlinear(skb) ||
 	    skb_headroom(skb) < XDP_PACKET_HEADROOM) {
-		if (netif_skb_check_for_xdp(pskb, xdp_prog))
+		if (netif_skb_check_for_xdp(pskb, xdp_array))
 			goto do_drop;
 	}
 
 	__skb_pull(*pskb, mac_len);
 
-	act = bpf_prog_run_generic_xdp(*pskb, xdp, xdp_prog);
+	act = bpf_mprog_run_generic_xdp(*pskb, xdp, xdp_array, xdp_prog);
 	switch (act) {
 	case XDP_REDIRECT:
 	case XDP_TX:
 	case XDP_PASS:
 		break;
 	default:
-		bpf_warn_invalid_xdp_action((*pskb)->dev, xdp_prog, act);
+		bpf_warn_invalid_xdp_action((*pskb)->dev, *xdp_prog, act);
 		fallthrough;
 	case XDP_ABORTED:
-		trace_xdp_exception((*pskb)->dev, xdp_prog, act);
+		trace_xdp_exception((*pskb)->dev, *xdp_prog, act);
 		fallthrough;
 	case XDP_DROP:
 	do_drop:
@@ -5129,17 +5140,18 @@ void generic_xdp_tx(struct sk_buff *skb, struct bpf_prog *xdp_prog)
 
 static DEFINE_STATIC_KEY_FALSE(generic_xdp_needed_key);
 
-int do_xdp_generic(struct bpf_prog *xdp_prog, struct sk_buff **pskb)
+int do_xdp_generic(struct bpf_mprog_array *xdp_array, struct sk_buff **pskb)
 {
 	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
+	struct bpf_prog *xdp_prog;
 
-	if (xdp_prog) {
+	if (xdp_array) {
 		struct xdp_buff xdp;
 		u32 act;
 		int err;
 
 		bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
-		act = netif_receive_generic_xdp(pskb, &xdp, xdp_prog);
+		act = netif_receive_generic_xdp(pskb, &xdp, xdp_array, &xdp_prog);
 		if (act != XDP_PASS) {
 			switch (act) {
 			case XDP_REDIRECT:
@@ -5483,7 +5495,7 @@ static int __netif_receive_skb_core(struct sk_buff **pskb, bool pfmemalloc,
 		int ret2;
 
 		migrate_disable();
-		ret2 = do_xdp_generic(rcu_dereference(skb->dev->xdp_prog),
+		ret2 = do_xdp_generic(rcu_dereference(skb->dev->xdp_array),
 				      &skb);
 		migrate_enable();
 
@@ -5813,15 +5825,16 @@ static void __netif_receive_skb_list(struct list_head *head)
 
 static int generic_xdp_install(struct net_device *dev, struct netdev_bpf *xdp)
 {
-	struct bpf_prog *old = rtnl_dereference(dev->xdp_prog);
-	struct bpf_prog *new = xdp->prog;
+	struct bpf_mprog_array *old, *new;
 	int ret = 0;
 
 	switch (xdp->command) {
 	case XDP_SETUP_PROG:
-		rcu_assign_pointer(dev->xdp_prog, new);
+		old = rtnl_dereference(dev->xdp_array);
+		new = xdp->arr;
+		rcu_assign_pointer(dev->xdp_array, new);
 		if (old)
-			bpf_prog_put(old);
+			bpf_mprog_array_put(old);
 
 		if (old && !new) {
 			static_branch_dec(&generic_xdp_needed_key);
@@ -5831,6 +5844,8 @@ static int generic_xdp_install(struct net_device *dev, struct netdev_bpf *xdp)
 			dev_disable_gro_hw(dev);
 		}
 		break;
+	case XDP_QUERY_MPROG_SUPPORT:
+		return 0;
 
 	default:
 		ret = -EINVAL;
@@ -9320,6 +9335,11 @@ struct bpf_xdp_link {
 	int flags;
 };
 
+static inline struct bpf_xdp_link *xdp_link(const struct bpf_link *link)
+{
+	return container_of(link, struct bpf_xdp_link, link);
+}
+
 static enum bpf_xdp_mode dev_xdp_mode(struct net_device *dev, u32 flags)
 {
 	if (flags & XDP_FLAGS_HW_MODE)
@@ -9344,20 +9364,43 @@ static bpf_op_t dev_xdp_bpf_op(struct net_device *dev, enum bpf_xdp_mode mode)
 	}
 }
 
-static struct bpf_xdp_link *dev_xdp_link(struct net_device *dev,
-					 enum bpf_xdp_mode mode)
+static bool dev_xdp_has_link(struct net_device *dev, enum bpf_xdp_mode mode)
 {
-	return dev->xdp_state[mode].link;
+	struct bpf_mprog_entry *entry = xdp_entry_fetch(dev, mode);
+	struct bpf_tuple tuple = {};
+	struct bpf_mprog_fp *fp;
+	struct bpf_mprog_cp *cp;
+
+	if (entry)
+		bpf_mprog_foreach_tuple(entry, fp, cp, tuple)
+			if (tuple.link)
+				return true;
+	return false;
 }
 
-static struct bpf_prog *dev_xdp_prog(struct net_device *dev,
-				     enum bpf_xdp_mode mode)
+static bool dev_xdp_has_any_prog(struct net_device *dev, enum bpf_xdp_mode mode)
 {
-	struct bpf_xdp_link *link = dev_xdp_link(dev, mode);
+	struct bpf_mprog_entry *entry = xdp_entry_fetch(dev, mode);
 
-	if (link)
-		return link->link.prog;
-	return dev->xdp_state[mode].prog;
+	return entry ? xdp_entry_is_active(entry) : false;
+}
+
+static bool dev_xdp_has_prog(struct net_device *dev, enum bpf_xdp_mode mode, struct bpf_prog *prog)
+{
+	struct bpf_mprog_entry *entry = xdp_entry_fetch(dev, mode);
+
+	/* Special case for NULL program, in which case we check if no programs are attached. */
+	if (!prog)
+		return !entry || !xdp_entry_is_active(entry);
+
+	return entry ? bpf_mprog_exists(entry, prog) : false;
+}
+
+static int dev_xdp_prog_mode_count(struct net_device *dev, enum bpf_xdp_mode mode)
+{
+	struct bpf_mprog_entry *entry = xdp_entry_fetch(dev, mode);
+
+	return entry ? bpf_mprog_total(entry) : 0;
 }
 
 u8 dev_xdp_prog_count(struct net_device *dev)
@@ -9366,7 +9409,7 @@ u8 dev_xdp_prog_count(struct net_device *dev)
 	int i;
 
 	for (i = 0; i < __MAX_XDP_MODE; i++)
-		if (dev->xdp_state[i].prog || dev->xdp_state[i].link)
+		if (dev->xdp_state[i] && xdp_entry_is_active(dev->xdp_state[i]))
 			count++;
 	return count;
 }
@@ -9388,29 +9431,49 @@ EXPORT_SYMBOL_GPL(dev_xdp_propagate);
 
 u32 dev_xdp_prog_id(struct net_device *dev, enum bpf_xdp_mode mode)
 {
-	struct bpf_prog *prog = dev_xdp_prog(dev, mode);
+	struct bpf_mprog_entry *entry = xdp_entry_fetch(dev, mode);
+	struct bpf_prog *prog;
 
-	return prog ? prog->aux->id : 0;
+	/* Legacy function required for netlink socket. Return the first ID
+	 * in the mprog array, otherwise 0.
+	 */
+	if (entry) {
+		prog = bpf_mprog_head(entry);
+		if (prog)
+			return prog->aux->id;
+	}
+	return 0;
 }
 
-static void dev_xdp_set_link(struct net_device *dev, enum bpf_xdp_mode mode,
-			     struct bpf_xdp_link *link)
+static bool dev_xdp_supports_mprog(struct net_device *dev, enum bpf_xdp_mode mode,
+				   bpf_op_t bpf_op)
 {
-	dev->xdp_state[mode].link = link;
-	dev->xdp_state[mode].prog = NULL;
+	struct netdev_bpf xdp;
+
+	memset(&xdp, 0, sizeof(xdp));
+	xdp.command = XDP_QUERY_MPROG_SUPPORT;
+	/* Returns 0 if mprog is supported, != 0 otherwise. */
+	return !bpf_op(dev, &xdp);
 }
 
-static void dev_xdp_set_prog(struct net_device *dev, enum bpf_xdp_mode mode,
-			     struct bpf_prog *prog)
+static int bpf_mprog_array_from_entry(struct bpf_mprog_entry *entry,
+				      struct bpf_mprog_array **arr)
 {
-	dev->xdp_state[mode].link = NULL;
-	dev->xdp_state[mode].prog = prog;
+	*arr = kzalloc(sizeof(**arr), GFP_KERNEL);
+	if (!*arr)
+		return -ENOMEM;
+	bpf_mprog_array_init(*arr, entry);
+	return 0;
 }
 
 static int dev_xdp_install(struct net_device *dev, enum bpf_xdp_mode mode,
 			   bpf_op_t bpf_op, struct netlink_ext_ack *extack,
-			   u32 flags, struct bpf_prog *prog)
+			   u32 flags, struct bpf_mprog_entry *entry,
+			   struct bpf_prog *nprog, struct bpf_prog *oprog)
 {
+	const bool supports_mprog = dev_xdp_supports_mprog(dev, mode, bpf_op);
+	struct bpf_mprog_array *arr = NULL;
+	struct bpf_prog *prog = NULL;
 	struct netdev_bpf xdp;
 	int err;
 
@@ -9419,75 +9482,102 @@ static int dev_xdp_install(struct net_device *dev, enum bpf_xdp_mode mode,
 		return -EBUSY;
 	}
 
+	if (!supports_mprog && entry && bpf_mprog_total(entry) > 1) {
+		NL_SET_ERR_MSG(extack, "Underlying driver does not support multiple XDP programs");
+		return -EOPNOTSUPP;
+	}
+
+	if (supports_mprog) {
+		if (entry && xdp_entry_is_active(entry)) {
+			err = bpf_mprog_array_from_entry(entry, &arr);
+			if (err)
+				return err;
+		}
+	} else {
+		prog = nprog;
+	}
+
 	memset(&xdp, 0, sizeof(xdp));
 	xdp.command = mode == XDP_MODE_HW ? XDP_SETUP_PROG_HW : XDP_SETUP_PROG;
 	xdp.extack = extack;
 	xdp.flags = flags;
-	xdp.prog = prog;
+	if (arr)
+		xdp.arr = arr;
+	if (prog)
+		xdp.prog = prog;
 
 	/* Drivers assume refcnt is already incremented (i.e, prog pointer is
 	 * "moved" into driver), so they don't increment it on their own, but
 	 * they do decrement refcnt when program is detached or replaced.
 	 * Given net_device also owns link/prog, we need to bump refcnt here
 	 * to prevent drivers from underflowing it.
+	 *
+	 * Don't do this for arrays since refcount is initialized in
+	 * bpf_mprog_array_init().
 	 */
 	if (prog)
 		bpf_prog_inc(prog);
 	err = bpf_op(dev, &xdp);
 	if (err) {
+		if (arr)
+			bpf_mprog_array_put(arr);
 		if (prog)
 			bpf_prog_put(prog);
 		return err;
 	}
 
 	if (mode != XDP_MODE_HW)
-		bpf_prog_change_xdp(dev_xdp_prog(dev, mode), prog);
+		bpf_prog_change_xdp(oprog, nprog);
 
 	return 0;
 }
 
 static void dev_xdp_uninstall(struct net_device *dev)
 {
-	struct bpf_xdp_link *link;
-	struct bpf_prog *prog;
+	struct bpf_mprog_entry *entry, *entry_new = NULL;
+	struct bpf_tuple tuple = {};
+	struct bpf_mprog_fp *fp;
+	struct bpf_mprog_cp *cp;
 	enum bpf_xdp_mode mode;
 	bpf_op_t bpf_op;
 
 	ASSERT_RTNL();
 
 	for (mode = XDP_MODE_SKB; mode < __MAX_XDP_MODE; mode++) {
-		prog = dev_xdp_prog(dev, mode);
-		if (!prog)
+		entry = xdp_entry_fetch(dev, mode);
+		if (!entry)
 			continue;
 
 		bpf_op = dev_xdp_bpf_op(dev, mode);
 		if (!bpf_op)
 			continue;
 
-		WARN_ON(dev_xdp_install(dev, mode, bpf_op, NULL, 0, NULL));
+		WARN_ON(dev_xdp_install(dev, mode, bpf_op, NULL, 0, NULL, NULL, NULL));
 
-		/* auto-detach link from net device */
-		link = dev_xdp_link(dev, mode);
-		if (link)
-			link->dev = NULL;
-		else
-			bpf_prog_put(prog);
+		bpf_mprog_clear_all(entry, &entry_new);
+		xdp_entry_update(dev, entry_new, mode);
+		xdp_entry_sync();
+
+		bpf_mprog_foreach_tuple(entry, fp, cp, tuple) {
+			if (tuple.link)
+				xdp_link(tuple.link)->dev = NULL;
+			else
+				bpf_prog_put(tuple.prog);
+		}
 
-		dev_xdp_set_link(dev, mode, NULL);
+		bpf_mprog_commit(entry);
+		xdp_entry_free(entry);
 	}
 }
 
-static int dev_xdp_attach(struct net_device *dev, struct netlink_ext_ack *extack,
-			  struct bpf_xdp_link *link, struct bpf_prog *new_prog,
-			  struct bpf_prog *old_prog, u32 flags)
+static int verify_dev_xdp_attach(struct net_device *dev, struct netlink_ext_ack *extack,
+				 struct bpf_xdp_link *link, struct bpf_prog *new_prog,
+				 struct bpf_prog *old_prog, u32 flags)
 {
 	unsigned int num_modes = hweight32(flags & XDP_FLAGS_MODES);
-	struct bpf_prog *cur_prog;
 	struct net_device *upper;
 	struct list_head *iter;
 	enum bpf_xdp_mode mode;
-	bpf_op_t bpf_op;
-	int err;
 
 	ASSERT_RTNL();
 
@@ -9517,8 +9607,12 @@ static int dev_xdp_attach(struct net_device *dev, struct netlink_ext_ack *extack
 	}
 
 	mode = dev_xdp_mode(dev, flags);
-	/* can't replace attached link */
-	if (dev_xdp_link(dev, mode)) {
+	if (!link && dev_xdp_prog_mode_count(dev, mode) > 1) {
+		NL_SET_ERR_MSG(extack, "Netlink does not support multiple XDP programs");
+		return -EOPNOTSUPP;
+	}
+	/* netlink socket can't replace attached link */
+	if (!link && dev_xdp_has_link(dev, mode)) {
 		NL_SET_ERR_MSG(extack, "Can't replace active BPF XDP link");
 		return -EBUSY;
 	}
@@ -9531,13 +9625,12 @@ static int dev_xdp_attach(struct net_device *dev, struct netlink_ext_ack *extack
 		}
 	}
 
-	cur_prog = dev_xdp_prog(dev, mode);
-	/* can't replace attached prog with link */
-	if (link && cur_prog) {
+	/* attached links can't replace netlink socket */
+	if (link && dev_xdp_has_any_prog(dev, mode) && !dev_xdp_has_link(dev, mode)) {
 		NL_SET_ERR_MSG(extack, "Can't replace active XDP program with BPF link");
 		return -EBUSY;
 	}
-	if ((flags & XDP_FLAGS_REPLACE) && cur_prog != old_prog) {
+	if ((flags & XDP_FLAGS_REPLACE) && !dev_xdp_has_prog(dev, mode, old_prog)) {
 		NL_SET_ERR_MSG(extack, "Active program does not match expected");
 		return -EEXIST;
 	}
@@ -9551,11 +9644,11 @@ static int dev_xdp_attach(struct net_device *dev, struct netlink_ext_ack *extack
 		enum bpf_xdp_mode other_mode = mode == XDP_MODE_SKB
 					       ? XDP_MODE_DRV : XDP_MODE_SKB;
 
-		if ((flags & XDP_FLAGS_UPDATE_IF_NOEXIST) && cur_prog) {
+		if ((flags & XDP_FLAGS_UPDATE_IF_NOEXIST) && dev_xdp_has_any_prog(dev, mode)) {
 			NL_SET_ERR_MSG(extack, "XDP program already attached");
 			return -EBUSY;
 		}
-		if (!offload && dev_xdp_prog(dev, other_mode)) {
+		if (!offload && dev_xdp_has_any_prog(dev, other_mode)) {
 			NL_SET_ERR_MSG(extack, "Native and generic XDP can't be active at the same time");
 			return -EEXIST;
 		}
@@ -9577,52 +9670,165 @@ static int dev_xdp_attach(struct net_device *dev, struct netlink_ext_ack *extack
 		}
 	}
 
-	/* don't call drivers if the effective program didn't change */
-	if (new_prog != cur_prog) {
-		bpf_op = dev_xdp_bpf_op(dev, mode);
-		if (!bpf_op) {
-			NL_SET_ERR_MSG(extack, "Underlying driver does not support XDP in native mode");
-			return -EOPNOTSUPP;
-		}
+	return 0;
+}
 
-		err = dev_xdp_install(dev, mode, bpf_op, extack, flags, new_prog);
-		if (err)
-			return err;
+static int dev_xdp_attach_netlink(struct net_device *dev, struct netlink_ext_ack *extack,
+				  struct bpf_prog *new_prog, struct bpf_prog *old_prog,
+				  u32 flags)
+{
+	struct bpf_mprog_entry *entry, *entry_new;
+	struct bpf_prog *cur_prog;
+	enum bpf_xdp_mode mode;
+	bpf_op_t bpf_op;
+	int err;
+	bool created;
+
+	ASSERT_RTNL();
+
+	err = verify_dev_xdp_attach(dev, extack, NULL, new_prog, old_prog, flags);
+	if (err)
+		return err;
+
+	mode = dev_xdp_mode(dev, flags);
+	bpf_op = dev_xdp_bpf_op(dev, mode);
+	if (!bpf_op) {
+		NL_SET_ERR_MSG(extack, "Underlying driver does not support XDP in native mode");
+		return -EOPNOTSUPP;
 	}
 
-	if (link)
-		dev_xdp_set_link(dev, mode, link);
+	entry = xdp_entry_fetch_or_create(dev, mode, &created);
+	if (!entry)
+		return -ENOMEM;
+
+	/* Netlink does not support mprog and this is validated in verify_dev_xdp_attach(). */
+	cur_prog = bpf_mprog_head(entry);
+
+	/* If no new program to attach or current program to detach, there's nothing to do. */
+	if (!cur_prog && !new_prog)
+		return 0;
+
+	if (new_prog)
+		/* Insert new program or replace existing one. */
+		err = bpf_mprog_attach(entry, &entry_new, new_prog,
+				       NULL,
+				       cur_prog,
+				       cur_prog ? BPF_F_REPLACE | BPF_F_ID : 0,
+				       cur_prog ? cur_prog->aux->id : 0,
+				       0);
 	else
-		dev_xdp_set_prog(dev, mode, new_prog);
-	if (cur_prog)
-		bpf_prog_put(cur_prog);
+		/* Detach old program. */
+		err = bpf_mprog_detach(entry, &entry_new, cur_prog, NULL, 0, 0, 0);
 
-	return 0;
+	if (!xdp_entry_is_active(entry_new))
+		entry_new = NULL;
+
+	/* Don't call drivers if the effective program didn't change. */
+	if (new_prog != cur_prog) {
+		err = dev_xdp_install(dev, mode, bpf_op, extack, flags, entry_new, new_prog,
+				      cur_prog);
+		if (err)
+			goto out;
+	}
+
+	if (entry != entry_new) {
+		xdp_entry_update(dev, entry_new, mode);
+		xdp_entry_sync();
+	}
+	bpf_mprog_commit(entry);
+	if (!entry_new)
+		xdp_entry_free(entry);
+
+out:
+	if (err && created)
+		xdp_entry_free(entry);
+	return err;
 }
 
 static int dev_xdp_attach_link(struct net_device *dev,
 			       struct netlink_ext_ack *extack,
-			       struct bpf_xdp_link *link)
-{
-	return dev_xdp_attach(dev, extack, link, NULL, NULL, link->flags);
+			       struct bpf_xdp_link *link,
+			       u32 bpf_flags,
+			       u32 id_or_fd,
+			       u64 revision)
+{
+	int flags = link->flags;
+	struct bpf_prog *prog = link->link.prog;
+	struct bpf_mprog_entry *entry, *entry_new;
+	enum bpf_xdp_mode mode;
+	bpf_op_t bpf_op;
+	int err;
+	bool created;
+
+	ASSERT_RTNL();
+
+	err = verify_dev_xdp_attach(dev, extack, link, NULL, NULL, flags);
+	if (err)
+		return err;
+
+	mode = dev_xdp_mode(dev, flags);
+	bpf_op = dev_xdp_bpf_op(dev, mode);
+	if (!bpf_op) {
+		NL_SET_ERR_MSG(extack, "Underlying driver does not support XDP in native mode");
+		return -EOPNOTSUPP;
+	}
+
+	entry = xdp_entry_fetch_or_create(dev, mode, &created);
+	if (!entry)
+		return -ENOMEM;
+
+	err = bpf_mprog_attach(entry, &entry_new, prog, &link->link, NULL, bpf_flags,
+			       id_or_fd,
+			       revision);
+	if (err)
+		goto out;
+
+	/* Attachment via link always installs a new program so always call the driver. */
+	err = dev_xdp_install(dev, mode, bpf_op, extack, flags, entry_new, prog, NULL);
+	if (err)
+		goto out;
+
+	if (entry != entry_new) {
+		xdp_entry_update(dev, entry_new, mode);
+		xdp_entry_sync();
+	}
+	bpf_mprog_commit(entry);
+
+out:
+	if (err && created)
+		xdp_entry_free(entry);
+	return err;
 }
 
 static int dev_xdp_detach_link(struct net_device *dev,
-			       struct netlink_ext_ack *extack,
-			       struct bpf_xdp_link *link)
+			       struct bpf_xdp_link *xdp_link)
 {
+	struct bpf_link *link = &xdp_link->link;
+	struct bpf_mprog_entry *entry, *entry_new = NULL;
 	enum bpf_xdp_mode mode;
 	bpf_op_t bpf_op;
+	int ret;
 
 	ASSERT_RTNL();
 
-	mode = dev_xdp_mode(dev, link->flags);
-	if (dev_xdp_link(dev, mode) != link)
-		return -EINVAL;
+	mode = dev_xdp_mode(dev, xdp_link->flags);
+	entry = xdp_entry_fetch(dev, mode);
+	if (!entry)
+		return -ENOENT;
 
+	ret = bpf_mprog_detach(entry, &entry_new, link->prog, link, 0, 0, 0);
+	if (ret)
+		return ret;
+
+	if (!xdp_entry_is_active(entry_new))
+		entry_new = NULL;
 	bpf_op = dev_xdp_bpf_op(dev, mode);
-	WARN_ON(dev_xdp_install(dev, mode, bpf_op, NULL, 0, NULL));
-	dev_xdp_set_link(dev, mode, NULL);
+	WARN_ON(dev_xdp_install(dev, mode, bpf_op, NULL, 0, entry_new, NULL, link->prog));
+	xdp_entry_update(dev, entry_new, mode);
+	xdp_entry_sync();
+	bpf_mprog_commit(entry);
+	if (!entry_new)
+		xdp_entry_free(entry);
 	return 0;
 }
 
@@ -9636,7 +9842,7 @@ static void bpf_xdp_link_release(struct bpf_link *link)
 	 * already NULL, in which case link was already auto-detached
 	 */
 	if (xdp_link->dev) {
-		WARN_ON(dev_xdp_detach_link(xdp_link->dev, NULL, xdp_link));
+		WARN_ON(dev_xdp_detach_link(xdp_link->dev, xdp_link));
 		xdp_link->dev = NULL;
 	}
 
@@ -9689,6 +9895,7 @@ static int bpf_xdp_link_update(struct bpf_link *link, struct bpf_prog *new_prog,
 			       struct bpf_prog *old_prog)
 {
 	struct bpf_xdp_link *xdp_link = container_of(link, struct bpf_xdp_link, link);
+	struct bpf_mprog_entry *entry, *entry_new;
 	enum bpf_xdp_mode mode;
 	bpf_op_t bpf_op;
 	int err = 0;
@@ -9719,16 +9926,34 @@ static int bpf_xdp_link_update(struct bpf_link *link, struct bpf_prog *new_prog,
 	}
 
 	mode = dev_xdp_mode(xdp_link->dev, xdp_link->flags);
+
+	entry = xdp_entry_fetch(xdp_link->dev, mode);
+	if (!entry) {
+		err = -ENOENT;
+		goto out_unlock;
+	}
+
+	err = bpf_mprog_attach(entry, &entry_new, new_prog, link, old_prog,
+			       BPF_F_REPLACE | BPF_F_ID,
+			       link->prog->aux->id, 0);
+	if (err)
+		goto out_unlock;
+
+	WARN_ON_ONCE(entry != entry_new);
+
 	bpf_op = dev_xdp_bpf_op(xdp_link->dev, mode);
 	err = dev_xdp_install(xdp_link->dev, mode, bpf_op, NULL,
-			      xdp_link->flags, new_prog);
+			      xdp_link->flags, entry_new, new_prog, old_prog);
 	if (err)
 		goto out_unlock;
 
 	old_prog = xchg(&link->prog, new_prog);
 	bpf_prog_put(old_prog);
+	bpf_mprog_commit(entry);
 
 out_unlock:
+	if (err && new_prog)
+		bpf_prog_put(new_prog);
 	rtnl_unlock();
 	return err;
 }
@@ -9774,7 +9999,10 @@ int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 		goto unlock;
 	}
 
-	err = dev_xdp_attach_link(dev, &extack, link);
+	err = dev_xdp_attach_link(dev, &extack, link,
+				  attr->link_create.xdp.flags,
+				  attr->link_create.xdp.relative_fd,
+				  attr->link_create.xdp.expected_revision);
 	rtnl_unlock();
 
 	if (err) {
@@ -9833,7 +10061,7 @@ int dev_change_xdp_fd(struct net_device *dev, struct netlink_ext_ack *extack,
 		}
 	}
 
-	err = dev_xdp_attach(dev, extack, NULL, new_prog, old_prog, flags);
+	err = dev_xdp_attach_netlink(dev, extack, new_prog, old_prog, flags);
 
 err_out:
 	if (err && new_prog)
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index e30e7ea0207d..359fb289e2f8 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -40,6 +40,7 @@
 
 #include <linux/uaccess.h>
 
+#include <linux/bpf_mprog.h>
 #include <linux/inet.h>
 #include <linux/netdevice.h>
 #include <net/ip.h>
@@ -1505,13 +1506,20 @@ static int rtnl_fill_link_ifmap(struct sk_buff *skb,
 
 static u32 rtnl_xdp_prog_skb(struct net_device *dev)
 {
-	const struct bpf_prog *generic_xdp_prog;
+	const struct bpf_mprog_array *generic_xdp_array;
 	u32 res = 0;
 
 	rcu_read_lock();
-	generic_xdp_prog = rcu_dereference(dev->xdp_prog);
-	if (generic_xdp_prog)
-		res = generic_xdp_prog->aux->id;
+	generic_xdp_array = rcu_dereference(dev->xdp_array);
+	if (generic_xdp_array) {
+		const struct bpf_mprog_fp *fp;
+		struct bpf_prog *tmp;
+
+		bpf_mprog_foreach_prog(generic_xdp_array, fp, tmp) {
+			res = tmp->aux->id;
+			break;
+		}
+	}
 	rcu_read_unlock();
 
 	return res;
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 74149dc4ee31..f307c8969318 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1009,10 +1009,15 @@ int skb_pp_cow_data(struct page_pool *pool, struct sk_buff **pskb,
 EXPORT_SYMBOL(skb_pp_cow_data);
 
 int skb_cow_data_for_xdp(struct page_pool *pool, struct sk_buff **pskb,
-			 struct bpf_prog *prog)
+			 struct bpf_mprog_array *arr)
 {
-	if (!prog->aux->xdp_has_frags)
-		return -EINVAL;
+	const struct bpf_mprog_fp *fp;
+	struct bpf_prog *prog;
+
+	bpf_mprog_foreach_prog(arr, fp, prog) {
+		if (!prog->aux->xdp_has_frags)
+			return -EINVAL;
+	}
 
 	return skb_pp_cow_data(pool, pskb, XDP_PACKET_HEADROOM);
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_link.c b/tools/testing/selftests/bpf/prog_tests/xdp_link.c
index e7e9f3c22edf..d9e31bc2182a 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_link.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_link.c
@@ -93,22 +93,17 @@ void serial_test_xdp_link(void)
 	if (!ASSERT_ERR(err, "prog_detach_fail"))
 		goto cleanup;
 
-	/* BPF link is not allowed to replace another BPF link */
+	/* Multiple BPF links are supported for XDP */
 	link = bpf_program__attach_xdp(skel2->progs.xdp_handler, IFINDEX_LO);
-	if (!ASSERT_ERR_PTR(link, "link_attach_should_fail")) {
-		bpf_link__destroy(link);
+	if (!ASSERT_OK_PTR(link, "link_attach"))
 		goto cleanup;
-	}
+	skel2->links.xdp_handler = link;
 
+	/* Detach previous link */
 	bpf_link__destroy(skel1->links.xdp_handler);
 	skel1->links.xdp_handler = NULL;
 
-	/* new link attach should succeed */
-	link = bpf_program__attach_xdp(skel2->progs.xdp_handler, IFINDEX_LO);
-	if (!ASSERT_OK_PTR(link, "link_attach"))
-		goto cleanup;
-	skel2->links.xdp_handler = link;
-
+	/* Verify program ID now points to current link */
 	err = bpf_xdp_query_id(IFINDEX_LO, 0, &id0);
 	if (!ASSERT_OK(err, "id2_check_err") || !ASSERT_EQ(id0, id2, "id2_check_val"))
 		goto cleanup;
-- 
2.43.5


