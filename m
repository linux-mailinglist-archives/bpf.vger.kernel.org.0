Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC2D4D2D78
	for <lists+bpf@lfdr.de>; Wed,  9 Mar 2022 11:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbiCIKzI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Mar 2022 05:55:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231702AbiCIKzG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Mar 2022 05:55:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9070710A7F7
        for <bpf@vger.kernel.org>; Wed,  9 Mar 2022 02:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646823237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KlrsLGaknEi5BGoEBGri/90EA2ghplPo0MbCfWSH05U=;
        b=OI+EmU3vFsJq0k4ddwAxT794xMF7HtzNawxiSxSwQUAUd4OPF7ACLncewupDY/78e7IxDE
        ANbg17y3UlwrMO5V8xFRFRTB/+luW4c19cmpwsMnRDGAI53vMt/hc20IThKa+LoG5rLP+m
        NBJbxADF7G0xsixQbBfM+wSUVpJAZ8k=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-17-4m3NHHCyN0GXriGngE15kw-1; Wed, 09 Mar 2022 05:53:54 -0500
X-MC-Unique: 4m3NHHCyN0GXriGngE15kw-1
Received: by mail-ej1-f69.google.com with SMTP id m12-20020a1709062acc00b006cfc98179e2so1099974eje.6
        for <bpf@vger.kernel.org>; Wed, 09 Mar 2022 02:53:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KlrsLGaknEi5BGoEBGri/90EA2ghplPo0MbCfWSH05U=;
        b=BKSOP162WOWgP9WTVwywM/ZzvLZFfuCpqLbvAfxU/V9EfN9P6sStJudeOVpkwGkF2U
         Ku6ju0yWBeGD7mm4QK3YYqwYnfR1/7o1vkhmM0KHHaP99vFaSlvv+mJS0vIgWhUVqtGk
         yyuXRCuQDWRVEr1j/QrUVuVV8ImiFK46wq9KWrAr5OL4JmSwRnllluwHeBYp0rFQ2DZB
         Gp6dAeq60TbglcR/pQeQ5DjPO7+zuL65eaCLm806LsFZhb4pDv3Qbq1IwNtU8qfXnLaX
         3RB0uHlzgnXyLukgvXFcdWDxWnMEaKERWxExiJxEeuomPKDRfxtCQsliJv6jHZDBwsr4
         xRNQ==
X-Gm-Message-State: AOAM533q6rKrYo6DZYIEB0RjS8wPIUbCKXpLIGTPbxuuk3MQAMGMQEV7
        xtKozmIqyeuniQI8BIV1B76dOQ0C0ay71radvmz2daFyw+MDSXTmEMKPud0eGpkyLXx+4z0l2El
        s5dq1cO/mmTd9
X-Received: by 2002:a50:d592:0:b0:415:e599:4166 with SMTP id v18-20020a50d592000000b00415e5994166mr20183593edi.195.1646823231587;
        Wed, 09 Mar 2022 02:53:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJynh+UHAGsXRdvTJekn+kif0rDyv4UcVnbBtLomfHNgsBLQIxHaNQxOPHLsBdEYNyDI+YuGmA==
X-Received: by 2002:a50:d592:0:b0:415:e599:4166 with SMTP id v18-20020a50d592000000b00415e5994166mr20183449edi.195.1646823229217;
        Wed, 09 Mar 2022 02:53:49 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id w15-20020a056402268f00b00416474fbb42sm641684edd.19.2022.03.09.02.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 02:53:48 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id EE662192AA7; Wed,  9 Mar 2022 11:53:47 +0100 (CET)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>
Cc:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH bpf-next v11 1/5] bpf: Add "live packet" mode for XDP in BPF_PROG_RUN
Date:   Wed,  9 Mar 2022 11:53:42 +0100
Message-Id: <20220309105346.100053-2-toke@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220309105346.100053-1-toke@redhat.com>
References: <20220309105346.100053-1-toke@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This adds support for running XDP programs through BPF_PROG_RUN in a mode
that enables live packet processing of the resulting frames. Previous uses
of BPF_PROG_RUN for XDP returned the XDP program return code and the
modified packet data to userspace, which is useful for unit testing of XDP
programs.

The existing BPF_PROG_RUN for XDP allows userspace to set the ingress
ifindex and RXQ number as part of the context object being passed to the
kernel. This patch reuses that code, but adds a new mode with different
semantics, which can be selected with the new BPF_F_TEST_XDP_LIVE_FRAMES
flag.

When running BPF_PROG_RUN in this mode, the XDP program return codes will
be honoured: returning XDP_PASS will result in the frame being injected
into the networking stack as if it came from the selected networking
interface, while returning XDP_TX and XDP_REDIRECT will result in the frame
being transmitted out that interface. XDP_TX is translated into an
XDP_REDIRECT operation to the same interface, since the real XDP_TX action
is only possible from within the network drivers themselves, not from the
process context where BPF_PROG_RUN is executed.

Internally, this new mode of operation creates a page pool instance while
setting up the test run, and feeds pages from that into the XDP program.
The setup cost of this is amortised over the number of repetitions
specified by userspace.

To support the performance testing use case, we further optimise the setup
step so that all pages in the pool are pre-initialised with the packet
data, and pre-computed context and xdp_frame objects stored at the start of
each page. This makes it possible to entirely avoid touching the page
content on each XDP program invocation, and enables sending up to 9
Mpps/core on my test box.

Because the data pages are recycled by the page pool, and the test runner
doesn't re-initialise them for each run, subsequent invocations of the XDP
program will see the packet data in the state it was after the last time it
ran on that particular page. This means that an XDP program that modifies
the packet before redirecting it has to be careful about which assumptions
it makes about the packet content, but that is only an issue for the most
naively written programs.

Enabling the new flag is only allowed when not setting ctx_out and data_out
in the test specification, since using it means frames will be redirected
somewhere else, so they can't be returned.

Acked-by: Martin KaFai Lau <kafai@fb.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 include/uapi/linux/bpf.h       |   3 +
 kernel/bpf/Kconfig             |   1 +
 kernel/bpf/syscall.c           |   2 +-
 net/bpf/test_run.c             | 334 +++++++++++++++++++++++++++++++--
 tools/include/uapi/linux/bpf.h |   3 +
 5 files changed, 328 insertions(+), 15 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 4eebea830613..bc23020b638d 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1232,6 +1232,8 @@ enum {
 
 /* If set, run the test on the cpu specified by bpf_attr.test.cpu */
 #define BPF_F_TEST_RUN_ON_CPU	(1U << 0)
+/* If set, XDP frames will be transmitted after processing */
+#define BPF_F_TEST_XDP_LIVE_FRAMES	(1U << 1)
 
 /* type for BPF_ENABLE_STATS */
 enum bpf_stats_type {
@@ -1393,6 +1395,7 @@ union bpf_attr {
 		__aligned_u64	ctx_out;
 		__u32		flags;
 		__u32		cpu;
+		__u32		batch_size;
 	} test;
 
 	struct { /* anonymous struct used by BPF_*_GET_*_ID */
diff --git a/kernel/bpf/Kconfig b/kernel/bpf/Kconfig
index c3cf0b86eeb2..d56ee177d5f8 100644
--- a/kernel/bpf/Kconfig
+++ b/kernel/bpf/Kconfig
@@ -30,6 +30,7 @@ config BPF_SYSCALL
 	select TASKS_TRACE_RCU
 	select BINARY_PRINTF
 	select NET_SOCK_MSG if NET
+	select PAGE_POOL if NET
 	default n
 	help
 	  Enable the bpf() system call that allows to manipulate BPF programs
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index db402ebc5570..9beb585be5a6 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3336,7 +3336,7 @@ static int bpf_prog_query(const union bpf_attr *attr,
 	}
 }
 
-#define BPF_PROG_TEST_RUN_LAST_FIELD test.cpu
+#define BPF_PROG_TEST_RUN_LAST_FIELD test.batch_size
 
 static int bpf_prog_test_run(const union bpf_attr *attr,
 			     union bpf_attr __user *uattr)
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index ba410b069824..25169908be4a 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -15,6 +15,7 @@
 #include <net/sock.h>
 #include <net/tcp.h>
 #include <net/net_namespace.h>
+#include <net/page_pool.h>
 #include <linux/error-injection.h>
 #include <linux/smp.h>
 #include <linux/sock_diag.h>
@@ -53,10 +54,11 @@ static void bpf_test_timer_leave(struct bpf_test_timer *t)
 	rcu_read_unlock();
 }
 
-static bool bpf_test_timer_continue(struct bpf_test_timer *t, u32 repeat, int *err, u32 *duration)
+static bool bpf_test_timer_continue(struct bpf_test_timer *t, int iterations,
+				    u32 repeat, int *err, u32 *duration)
 	__must_hold(rcu)
 {
-	t->i++;
+	t->i += iterations;
 	if (t->i >= repeat) {
 		/* We're done. */
 		t->time_spent += ktime_get_ns() - t->time_start;
@@ -88,6 +90,286 @@ static bool bpf_test_timer_continue(struct bpf_test_timer *t, u32 repeat, int *e
 	return false;
 }
 
+/* We put this struct at the head of each page with a context and frame
+ * initialised when the page is allocated, so we don't have to do this on each
+ * repetition of the test run.
+ */
+struct xdp_page_head {
+	struct xdp_buff orig_ctx;
+	struct xdp_buff ctx;
+	struct xdp_frame frm;
+	u8 data[];
+};
+
+struct xdp_test_data {
+	struct xdp_buff *orig_ctx;
+	struct xdp_rxq_info rxq;
+	struct net_device *dev;
+	struct page_pool *pp;
+	struct xdp_frame **frames;
+	struct sk_buff **skbs;
+	u32 batch_size;
+	u32 frame_cnt;
+};
+
+#define TEST_XDP_FRAME_SIZE (PAGE_SIZE - sizeof(struct xdp_page_head)	\
+			     - sizeof(struct skb_shared_info))
+#define TEST_XDP_MAX_BATCH 256
+
+static void xdp_test_run_init_page(struct page *page, void *arg)
+{
+	struct xdp_page_head *head = phys_to_virt(page_to_phys(page));
+	struct xdp_buff *new_ctx, *orig_ctx;
+	u32 headroom = XDP_PACKET_HEADROOM;
+	struct xdp_test_data *xdp = arg;
+	size_t frm_len, meta_len;
+	struct xdp_frame *frm;
+	void *data;
+
+	orig_ctx = xdp->orig_ctx;
+	frm_len = orig_ctx->data_end - orig_ctx->data_meta;
+	meta_len = orig_ctx->data - orig_ctx->data_meta;
+	headroom -= meta_len;
+
+	new_ctx = &head->ctx;
+	frm = &head->frm;
+	data = &head->data;
+	memcpy(data + headroom, orig_ctx->data_meta, frm_len);
+
+	xdp_init_buff(new_ctx, TEST_XDP_FRAME_SIZE, &xdp->rxq);
+	xdp_prepare_buff(new_ctx, data, headroom, frm_len, true);
+	new_ctx->data = new_ctx->data_meta + meta_len;
+
+	xdp_update_frame_from_buff(new_ctx, frm);
+	frm->mem = new_ctx->rxq->mem;
+
+	memcpy(&head->orig_ctx, new_ctx, sizeof(head->orig_ctx));
+}
+
+static int xdp_test_run_setup(struct xdp_test_data *xdp, struct xdp_buff *orig_ctx)
+{
+	struct xdp_mem_info mem = {};
+	struct page_pool *pp;
+	int err = -ENOMEM;
+	struct page_pool_params pp_params = {
+		.order = 0,
+		.flags = 0,
+		.pool_size = xdp->batch_size,
+		.nid = NUMA_NO_NODE,
+		.max_len = TEST_XDP_FRAME_SIZE,
+		.init_callback = xdp_test_run_init_page,
+		.init_arg = xdp,
+	};
+
+	xdp->frames = kvmalloc_array(xdp->batch_size, sizeof(void *), GFP_KERNEL);
+	if (!xdp->frames)
+		return -ENOMEM;
+
+	xdp->skbs = kvmalloc_array(xdp->batch_size, sizeof(void *), GFP_KERNEL);
+	if (!xdp->skbs)
+		goto err_skbs;
+
+	pp = page_pool_create(&pp_params);
+	if (IS_ERR(pp)) {
+		err = PTR_ERR(pp);
+		goto err_pp;
+	}
+
+	/* will copy 'mem.id' into pp->xdp_mem_id */
+	err = xdp_reg_mem_model(&mem, MEM_TYPE_PAGE_POOL, pp);
+	if (err)
+		goto err_mmodel;
+
+	xdp->pp = pp;
+
+	/* We create a 'fake' RXQ referencing the original dev, but with an
+	 * xdp_mem_info pointing to our page_pool
+	 */
+	xdp_rxq_info_reg(&xdp->rxq, orig_ctx->rxq->dev, 0, 0);
+	xdp->rxq.mem.type = MEM_TYPE_PAGE_POOL;
+	xdp->rxq.mem.id = pp->xdp_mem_id;
+	xdp->dev = orig_ctx->rxq->dev;
+	xdp->orig_ctx = orig_ctx;
+
+	return 0;
+
+err_mmodel:
+	page_pool_destroy(pp);
+err_pp:
+	kfree(xdp->skbs);
+err_skbs:
+	kfree(xdp->frames);
+	return err;
+}
+
+static void xdp_test_run_teardown(struct xdp_test_data *xdp)
+{
+	page_pool_destroy(xdp->pp);
+	kfree(xdp->frames);
+	kfree(xdp->skbs);
+}
+
+static bool ctx_was_changed(struct xdp_page_head *head)
+{
+	return head->orig_ctx.data != head->ctx.data ||
+		head->orig_ctx.data_meta != head->ctx.data_meta ||
+		head->orig_ctx.data_end != head->ctx.data_end;
+}
+
+static void reset_ctx(struct xdp_page_head *head)
+{
+	if (likely(!ctx_was_changed(head)))
+		return;
+
+	head->ctx.data = head->orig_ctx.data;
+	head->ctx.data_meta = head->orig_ctx.data_meta;
+	head->ctx.data_end = head->orig_ctx.data_end;
+	xdp_update_frame_from_buff(&head->ctx, &head->frm);
+}
+
+static int xdp_recv_frames(struct xdp_frame **frames, int nframes,
+			   struct sk_buff **skbs,
+			   struct net_device *dev)
+{
+	gfp_t gfp = __GFP_ZERO | GFP_ATOMIC;
+	int i, n;
+	LIST_HEAD(list);
+
+	n = kmem_cache_alloc_bulk(skbuff_head_cache, gfp, nframes, (void **)skbs);
+	if (unlikely(n == 0)) {
+		for (i = 0; i < nframes; i++)
+			xdp_return_frame(frames[i]);
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < nframes; i++) {
+		struct xdp_frame *xdpf = frames[i];
+		struct sk_buff *skb = skbs[i];
+
+		skb = __xdp_build_skb_from_frame(xdpf, skb, dev);
+		if (!skb) {
+			xdp_return_frame(xdpf);
+			continue;
+		}
+
+		list_add_tail(&skb->list, &list);
+	}
+	netif_receive_skb_list(&list);
+
+	return 0;
+}
+
+static int xdp_test_run_batch(struct xdp_test_data *xdp, struct bpf_prog *prog,
+			      u32 repeat)
+{
+	struct bpf_redirect_info *ri = this_cpu_ptr(&bpf_redirect_info);
+	int err = 0, act, ret, i, nframes = 0, batch_sz;
+	struct xdp_frame **frames = xdp->frames;
+	struct xdp_page_head *head;
+	struct xdp_frame *frm;
+	bool redirect = false;
+	struct xdp_buff *ctx;
+	struct page *page;
+
+	batch_sz = min_t(u32, repeat, xdp->batch_size);
+
+	local_bh_disable();
+	xdp_set_return_frame_no_direct();
+
+	for (i = 0; i < batch_sz; i++) {
+		page = page_pool_dev_alloc_pages(xdp->pp);
+		if (!page) {
+			err = -ENOMEM;
+			goto out;
+		}
+
+		head = phys_to_virt(page_to_phys(page));
+		reset_ctx(head);
+		ctx = &head->ctx;
+		frm = &head->frm;
+		xdp->frame_cnt++;
+
+		act = bpf_prog_run_xdp(prog, ctx);
+
+		/* if program changed pkt bounds we need to update the xdp_frame */
+		if (unlikely(ctx_was_changed(head))) {
+			ret = xdp_update_frame_from_buff(ctx, frm);
+			if (ret) {
+				xdp_return_buff(ctx);
+				continue;
+			}
+		}
+
+		switch (act) {
+		case XDP_TX:
+			/* we can't do a real XDP_TX since we're not in the
+			 * driver, so turn it into a REDIRECT back to the same
+			 * index
+			 */
+			ri->tgt_index = xdp->dev->ifindex;
+			ri->map_id = INT_MAX;
+			ri->map_type = BPF_MAP_TYPE_UNSPEC;
+			fallthrough;
+		case XDP_REDIRECT:
+			redirect = true;
+			ret = xdp_do_redirect_frame(xdp->dev, ctx, frm, prog);
+			if (ret)
+				xdp_return_buff(ctx);
+			break;
+		case XDP_PASS:
+			frames[nframes++] = frm;
+			break;
+		default:
+			bpf_warn_invalid_xdp_action(NULL, prog, act);
+			fallthrough;
+		case XDP_DROP:
+			xdp_return_buff(ctx);
+			break;
+		}
+	}
+
+out:
+	if (redirect)
+		xdp_do_flush();
+	if (nframes) {
+		ret = xdp_recv_frames(frames, nframes, xdp->skbs, xdp->dev);
+		if (ret)
+			err = ret;
+	}
+
+	xdp_clear_return_frame_no_direct();
+	local_bh_enable();
+	return err;
+}
+
+static int bpf_test_run_xdp_live(struct bpf_prog *prog, struct xdp_buff *ctx,
+				 u32 repeat, u32 batch_size, u32 *time)
+
+{
+	struct xdp_test_data xdp = { .batch_size = batch_size };
+	struct bpf_test_timer t = { .mode = NO_MIGRATE };
+	int ret;
+
+	if (!repeat)
+		repeat = 1;
+
+	ret = xdp_test_run_setup(&xdp, ctx);
+	if (ret)
+		return ret;
+
+	bpf_test_timer_enter(&t);
+	do {
+		xdp.frame_cnt = 0;
+		ret = xdp_test_run_batch(&xdp, prog, repeat - t.i);
+		if (unlikely(ret < 0))
+			break;
+	} while (bpf_test_timer_continue(&t, xdp.frame_cnt, repeat, &ret, time));
+	bpf_test_timer_leave(&t);
+
+	xdp_test_run_teardown(&xdp);
+	return ret;
+}
+
 static int bpf_test_run(struct bpf_prog *prog, void *ctx, u32 repeat,
 			u32 *retval, u32 *time, bool xdp)
 {
@@ -119,7 +401,7 @@ static int bpf_test_run(struct bpf_prog *prog, void *ctx, u32 repeat,
 			*retval = bpf_prog_run_xdp(prog, ctx);
 		else
 			*retval = bpf_prog_run(prog, ctx);
-	} while (bpf_test_timer_continue(&t, repeat, &ret, time));
+	} while (bpf_test_timer_continue(&t, 1, repeat, &ret, time));
 	bpf_reset_run_ctx(old_ctx);
 	bpf_test_timer_leave(&t);
 
@@ -446,7 +728,7 @@ int bpf_prog_test_run_tracing(struct bpf_prog *prog,
 	int b = 2, err = -EFAULT;
 	u32 retval = 0;
 
-	if (kattr->test.flags || kattr->test.cpu)
+	if (kattr->test.flags || kattr->test.cpu || kattr->test.batch_size)
 		return -EINVAL;
 
 	switch (prog->expected_attach_type) {
@@ -510,7 +792,7 @@ int bpf_prog_test_run_raw_tp(struct bpf_prog *prog,
 	/* doesn't support data_in/out, ctx_out, duration, or repeat */
 	if (kattr->test.data_in || kattr->test.data_out ||
 	    kattr->test.ctx_out || kattr->test.duration ||
-	    kattr->test.repeat)
+	    kattr->test.repeat || kattr->test.batch_size)
 		return -EINVAL;
 
 	if (ctx_size_in < prog->aux->max_ctx_offset ||
@@ -741,7 +1023,7 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 	void *data;
 	int ret;
 
-	if (kattr->test.flags || kattr->test.cpu)
+	if (kattr->test.flags || kattr->test.cpu || kattr->test.batch_size)
 		return -EINVAL;
 
 	data = bpf_test_init(kattr, kattr->test.data_size_in,
@@ -922,7 +1204,9 @@ static void xdp_convert_buff_to_md(struct xdp_buff *xdp, struct xdp_md *xdp_md)
 int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
 			  union bpf_attr __user *uattr)
 {
+	bool do_live = (kattr->test.flags & BPF_F_TEST_XDP_LIVE_FRAMES);
 	u32 tailroom = SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
+	u32 batch_size = kattr->test.batch_size;
 	u32 size = kattr->test.data_size_in;
 	u32 headroom = XDP_PACKET_HEADROOM;
 	u32 retval, duration, max_data_sz;
@@ -938,6 +1222,18 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
 	    prog->expected_attach_type == BPF_XDP_CPUMAP)
 		return -EINVAL;
 
+	if (kattr->test.flags & ~BPF_F_TEST_XDP_LIVE_FRAMES)
+		return -EINVAL;
+
+	if (do_live) {
+		if (!batch_size)
+			batch_size = NAPI_POLL_WEIGHT;
+		else if (batch_size > TEST_XDP_MAX_BATCH)
+			return -E2BIG;
+	} else if (batch_size) {
+		return -EINVAL;
+	}
+
 	ctx = bpf_ctx_init(kattr, sizeof(struct xdp_md));
 	if (IS_ERR(ctx))
 		return PTR_ERR(ctx);
@@ -946,14 +1242,20 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
 		/* There can't be user provided data before the meta data */
 		if (ctx->data_meta || ctx->data_end != size ||
 		    ctx->data > ctx->data_end ||
-		    unlikely(xdp_metalen_invalid(ctx->data)))
+		    unlikely(xdp_metalen_invalid(ctx->data)) ||
+		    (do_live && (kattr->test.data_out || kattr->test.ctx_out)))
 			goto free_ctx;
 		/* Meta data is allocated from the headroom */
 		headroom -= ctx->data;
 	}
 
 	max_data_sz = 4096 - headroom - tailroom;
-	size = min_t(u32, size, max_data_sz);
+	if (size > max_data_sz) {
+		/* disallow live data mode for jumbo frames */
+		if (do_live)
+			goto free_ctx;
+		size = max_data_sz;
+	}
 
 	data = bpf_test_init(kattr, size, max_data_sz, headroom, tailroom);
 	if (IS_ERR(data)) {
@@ -1011,7 +1313,10 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
 	if (repeat > 1)
 		bpf_prog_change_xdp(NULL, prog);
 
-	ret = bpf_test_run(prog, &xdp, repeat, &retval, &duration, true);
+	if (do_live)
+		ret = bpf_test_run_xdp_live(prog, &xdp, repeat, batch_size, &duration);
+	else
+		ret = bpf_test_run(prog, &xdp, repeat, &retval, &duration, true);
 	/* We convert the xdp_buff back to an xdp_md before checking the return
 	 * code so the reference count of any held netdevice will be decremented
 	 * even if the test run failed.
@@ -1073,7 +1378,7 @@ int bpf_prog_test_run_flow_dissector(struct bpf_prog *prog,
 	if (prog->type != BPF_PROG_TYPE_FLOW_DISSECTOR)
 		return -EINVAL;
 
-	if (kattr->test.flags || kattr->test.cpu)
+	if (kattr->test.flags || kattr->test.cpu || kattr->test.batch_size)
 		return -EINVAL;
 
 	if (size < ETH_HLEN)
@@ -1108,7 +1413,7 @@ int bpf_prog_test_run_flow_dissector(struct bpf_prog *prog,
 	do {
 		retval = bpf_flow_dissect(prog, &ctx, eth->h_proto, ETH_HLEN,
 					  size, flags);
-	} while (bpf_test_timer_continue(&t, repeat, &ret, &duration));
+	} while (bpf_test_timer_continue(&t, 1, repeat, &ret, &duration));
 	bpf_test_timer_leave(&t);
 
 	if (ret < 0)
@@ -1140,7 +1445,7 @@ int bpf_prog_test_run_sk_lookup(struct bpf_prog *prog, const union bpf_attr *kat
 	if (prog->type != BPF_PROG_TYPE_SK_LOOKUP)
 		return -EINVAL;
 
-	if (kattr->test.flags || kattr->test.cpu)
+	if (kattr->test.flags || kattr->test.cpu || kattr->test.batch_size)
 		return -EINVAL;
 
 	if (kattr->test.data_in || kattr->test.data_size_in || kattr->test.data_out ||
@@ -1203,7 +1508,7 @@ int bpf_prog_test_run_sk_lookup(struct bpf_prog *prog, const union bpf_attr *kat
 	do {
 		ctx.selected_sk = NULL;
 		retval = BPF_PROG_SK_LOOKUP_RUN_ARRAY(progs, ctx, bpf_prog_run);
-	} while (bpf_test_timer_continue(&t, repeat, &ret, &duration));
+	} while (bpf_test_timer_continue(&t, 1, repeat, &ret, &duration));
 	bpf_test_timer_leave(&t);
 
 	if (ret < 0)
@@ -1242,7 +1547,8 @@ int bpf_prog_test_run_syscall(struct bpf_prog *prog,
 	/* doesn't support data_in/out, ctx_out, duration, or repeat or flags */
 	if (kattr->test.data_in || kattr->test.data_out ||
 	    kattr->test.ctx_out || kattr->test.duration ||
-	    kattr->test.repeat || kattr->test.flags)
+	    kattr->test.repeat || kattr->test.flags ||
+	    kattr->test.batch_size)
 		return -EINVAL;
 
 	if (ctx_size_in < prog->aux->max_ctx_offset ||
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 4eebea830613..bc23020b638d 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1232,6 +1232,8 @@ enum {
 
 /* If set, run the test on the cpu specified by bpf_attr.test.cpu */
 #define BPF_F_TEST_RUN_ON_CPU	(1U << 0)
+/* If set, XDP frames will be transmitted after processing */
+#define BPF_F_TEST_XDP_LIVE_FRAMES	(1U << 1)
 
 /* type for BPF_ENABLE_STATS */
 enum bpf_stats_type {
@@ -1393,6 +1395,7 @@ union bpf_attr {
 		__aligned_u64	ctx_out;
 		__u32		flags;
 		__u32		cpu;
+		__u32		batch_size;
 	} test;
 
 	struct { /* anonymous struct used by BPF_*_GET_*_ID */
-- 
2.35.1

