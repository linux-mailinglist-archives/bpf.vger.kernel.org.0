Return-Path: <bpf+bounces-22082-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BCABF856495
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 14:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FF06B2AFE0
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 13:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80BF812FF72;
	Thu, 15 Feb 2024 13:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bSnYTc6u"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9BF12BE8D
	for <bpf@vger.kernel.org>; Thu, 15 Feb 2024 13:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708003605; cv=none; b=F28IAvRoyATLJOWi+F/BHrAj5B+N25QM4TB92OFOMVbL90UF1meYP66auiZEOXjoTX+XB7h8XSjoJ29hSFRcduWXCWOce2Th+6zuYYAMyGnk11nYeNLrrNaK6U+Hk7FbFgN93oFLJitJAaTDECNfU6OCrjvkSCBasnUDIqpeDvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708003605; c=relaxed/simple;
	bh=7WA3XHLMFKhdbspeydhiJXmgmQ3pp9zijHtxzQQc1iw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IiHZqOe931nP/JW0J0knsYik6lq0jqLHTJqkJDdMC3SLRXJOIayuIyZVDU2wqWFZAOEqTOFECWHr/nMlIN3et6bvj479hrASie5ZeiE6Bb8DAYCLcTZR+ZVgJAHA9FA7nrLL4dS8gvvdHDeb08rdov5Z/Q8rSOUBspOLqpwYFf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bSnYTc6u; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708003602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bIIW9lTPNrP13OJ/aTfa3Gowpk1DCuaoFBbweL99mOE=;
	b=bSnYTc6uSKjj23eATepT+GLO+YDmeycQD7RVw0K6TKN0Qmp+AMmvvBpVuDU+gQx3OgRmoc
	TDa1V6+6PaF0mhFwkorzjow28MEt6ybz6Rph2jkDQ7g8PNGqdGi866Y39wLoPkVySnTVNR
	51rSWu4qFDmK5ZEzgdfOXYhTQ7kPygE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-mB4Zg97LPryd3UJ5hHb2PQ-1; Thu, 15 Feb 2024 08:26:40 -0500
X-MC-Unique: mB4Zg97LPryd3UJ5hHb2PQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a3d7cd58ae2so48876566b.1
        for <bpf@vger.kernel.org>; Thu, 15 Feb 2024 05:26:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708003600; x=1708608400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bIIW9lTPNrP13OJ/aTfa3Gowpk1DCuaoFBbweL99mOE=;
        b=bE0+chh49eJkluQeXL7LVgVM7HMiSVP1vWxDy+6wsYw/hMaXdzD5Vi6+LJnRxePtuG
         jWExnozhvvzteOi6GhcHp1SFWQDFGogTG2D0NfikOnO7MaYiPHL2MOMrmjM59i2JcRSB
         PQQbRWr/vEd7KLSAJHzDfSIig2GBLFMUPanu2/b4+1HTy0UlJri3vVPe3ES8RqI0aTNf
         soCkWqzo8fCTCjNes7C0hXN3c7TDUjWdXto/Dcfg7/kJeu5l+0cIFOiyX9XL3Deiaugh
         ncnhDQ12Fayee6fOzof/f9ncodJELEWgqrhcNOwuVI4WoaP319ulfYABYvZzT1aH1esL
         J0fw==
X-Forwarded-Encrypted: i=1; AJvYcCUrigIrF9VoGIQrQsxsFlJMIzV1Ofsud61j3KztL8Hk+eu+LiKexZwePbMH58Yge5EbAr5Ymm3gl5BzZssi5thrl0db
X-Gm-Message-State: AOJu0YzX77BOEkszEXlPc+nCroDCwaF1cY6qkpmKr+VTNhU+T5SawcwX
	pU7QWmjZiFl15HYDI8hrVFdw0U+ZPCFYbhFoXSjcR8cMFegn5N2OUXmk184aRZdoTK9ghBHZKE3
	KYn3BHlNebVCLnV3A9+TT9BnPNSfjI971m22OsidLK+qPMKqFvQ==
X-Received: by 2002:a17:906:ca56:b0:a38:9590:cde8 with SMTP id jx22-20020a170906ca5600b00a389590cde8mr1516024ejb.73.1708003599772;
        Thu, 15 Feb 2024 05:26:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEKYPsuoPIqzesQq2jztNW0ZYlrQYfLyusrO/TcBvKVuXNEBD1TliDBZZ+iqDd8LoU92urZ4Q==
X-Received: by 2002:a17:906:ca56:b0:a38:9590:cde8 with SMTP id jx22-20020a170906ca5600b00a389590cde8mr1516006ejb.73.1708003599414;
        Thu, 15 Feb 2024 05:26:39 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id hd15-20020a170907968f00b00a3d62948fadsm548652ejc.173.2024.02.15.05.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 05:26:39 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 5BC3A10F59BB; Thu, 15 Feb 2024 14:26:38 +0100 (CET)
From: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next 2/3] bpf: test_run: Use system page pool for XDP live frame mode
Date: Thu, 15 Feb 2024 14:26:31 +0100
Message-ID: <20240215132634.474055-3-toke@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240215132634.474055-1-toke@redhat.com>
References: <20240215132634.474055-1-toke@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The BPF_TEST_RUN code in XDP live frame mode creates a new page pool
each time it is called and uses that to allocate the frames used for the
XDP run. This works well if the syscall is used with a high repetitions
number, as it allows for efficient page recycling. However, if used with
a small number of repetitions, the overhead of creating and tearing down
the page pool is significant, and can even lead to system stalls if the
syscall is called in a tight loop.

Now that we have a persistent system page pool instance, it becomes
pretty straight forward to change the test_run code to use it. The only
wrinkle is that we can no longer rely on a custom page init callback
from page_pool itself; instead, we change the test_run code to write a
random cookie value to the beginning of the page as an indicator that
the page has been initialised and can be re-used without copying the
initial data again.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 net/bpf/test_run.c | 134 ++++++++++++++++++++++-----------------------
 1 file changed, 66 insertions(+), 68 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index dfd919374017..c742869a0612 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -94,10 +94,14 @@ static bool bpf_test_timer_continue(struct bpf_test_timer *t, int iterations,
 }
 
 /* We put this struct at the head of each page with a context and frame
- * initialised when the page is allocated, so we don't have to do this on each
- * repetition of the test run.
+ * initialised the first time a given page is used, saving the memcpy() of the
+ * data on subsequent repetition of the test run. The cookie value is used to
+ * mark the page data the first time we initialise it so we can skip it the next
+ * time we see that page.
  */
+
 struct xdp_page_head {
+	u64 cookie;
 	struct xdp_buff orig_ctx;
 	struct xdp_buff ctx;
 	union {
@@ -111,10 +115,9 @@ struct xdp_test_data {
 	struct xdp_buff *orig_ctx;
 	struct xdp_rxq_info rxq;
 	struct net_device *dev;
-	struct page_pool *pp;
 	struct xdp_frame **frames;
 	struct sk_buff **skbs;
-	struct xdp_mem_info mem;
+	u64 cookie;
 	u32 batch_size;
 	u32 frame_cnt;
 };
@@ -126,48 +129,9 @@ struct xdp_test_data {
 #define TEST_XDP_FRAME_SIZE (PAGE_SIZE - sizeof(struct xdp_page_head))
 #define TEST_XDP_MAX_BATCH 256
 
-static void xdp_test_run_init_page(struct page *page, void *arg)
-{
-	struct xdp_page_head *head = phys_to_virt(page_to_phys(page));
-	struct xdp_buff *new_ctx, *orig_ctx;
-	u32 headroom = XDP_PACKET_HEADROOM;
-	struct xdp_test_data *xdp = arg;
-	size_t frm_len, meta_len;
-	struct xdp_frame *frm;
-	void *data;
-
-	orig_ctx = xdp->orig_ctx;
-	frm_len = orig_ctx->data_end - orig_ctx->data_meta;
-	meta_len = orig_ctx->data - orig_ctx->data_meta;
-	headroom -= meta_len;
-
-	new_ctx = &head->ctx;
-	frm = head->frame;
-	data = head->data;
-	memcpy(data + headroom, orig_ctx->data_meta, frm_len);
-
-	xdp_init_buff(new_ctx, TEST_XDP_FRAME_SIZE, &xdp->rxq);
-	xdp_prepare_buff(new_ctx, data, headroom, frm_len, true);
-	new_ctx->data = new_ctx->data_meta + meta_len;
-
-	xdp_update_frame_from_buff(new_ctx, frm);
-	frm->mem = new_ctx->rxq->mem;
-
-	memcpy(&head->orig_ctx, new_ctx, sizeof(head->orig_ctx));
-}
-
 static int xdp_test_run_setup(struct xdp_test_data *xdp, struct xdp_buff *orig_ctx)
 {
-	struct page_pool *pp;
 	int err = -ENOMEM;
-	struct page_pool_params pp_params = {
-		.order = 0,
-		.flags = 0,
-		.pool_size = xdp->batch_size,
-		.nid = NUMA_NO_NODE,
-		.init_callback = xdp_test_run_init_page,
-		.init_arg = xdp,
-	};
 
 	xdp->frames = kvmalloc_array(xdp->batch_size, sizeof(void *), GFP_KERNEL);
 	if (!xdp->frames)
@@ -177,34 +141,21 @@ static int xdp_test_run_setup(struct xdp_test_data *xdp, struct xdp_buff *orig_c
 	if (!xdp->skbs)
 		goto err_skbs;
 
-	pp = page_pool_create(&pp_params);
-	if (IS_ERR(pp)) {
-		err = PTR_ERR(pp);
-		goto err_pp;
-	}
-
-	/* will copy 'mem.id' into pp->xdp_mem_id */
-	err = xdp_reg_mem_model(&xdp->mem, MEM_TYPE_PAGE_POOL, pp);
-	if (err)
-		goto err_mmodel;
-
-	xdp->pp = pp;
-
 	/* We create a 'fake' RXQ referencing the original dev, but with an
 	 * xdp_mem_info pointing to our page_pool
 	 */
 	xdp_rxq_info_reg(&xdp->rxq, orig_ctx->rxq->dev, 0, 0);
-	xdp->rxq.mem.type = MEM_TYPE_PAGE_POOL;
-	xdp->rxq.mem.id = pp->xdp_mem_id;
+	xdp->rxq.mem.type = MEM_TYPE_PAGE_POOL; /* mem id is set per-frame below */
 	xdp->dev = orig_ctx->rxq->dev;
 	xdp->orig_ctx = orig_ctx;
 
+	/* We need a random cookie for each run as pages can stick around
+	 * between runs in the system page pool
+	 */
+	get_random_bytes(&xdp->cookie, sizeof(xdp->cookie));
+
 	return 0;
 
-err_mmodel:
-	page_pool_destroy(pp);
-err_pp:
-	kvfree(xdp->skbs);
 err_skbs:
 	kvfree(xdp->frames);
 	return err;
@@ -212,8 +163,6 @@ static int xdp_test_run_setup(struct xdp_test_data *xdp, struct xdp_buff *orig_c
 
 static void xdp_test_run_teardown(struct xdp_test_data *xdp)
 {
-	xdp_unreg_mem_model(&xdp->mem);
-	page_pool_destroy(xdp->pp);
 	kfree(xdp->frames);
 	kfree(xdp->skbs);
 }
@@ -235,8 +184,12 @@ static bool ctx_was_changed(struct xdp_page_head *head)
 		head->orig_ctx.data_end != head->ctx.data_end;
 }
 
-static void reset_ctx(struct xdp_page_head *head)
+static void reset_ctx(struct xdp_page_head *head, struct xdp_test_data *xdp)
 {
+	/* mem id can change if we migrate CPUs between batches */
+	if (head->frame->mem.id != xdp->rxq.mem.id)
+		head->frame->mem.id = xdp->rxq.mem.id;
+
 	if (likely(!frame_was_changed(head) && !ctx_was_changed(head)))
 		return;
 
@@ -246,6 +199,48 @@ static void reset_ctx(struct xdp_page_head *head)
 	xdp_update_frame_from_buff(&head->ctx, head->frame);
 }
 
+static struct xdp_page_head *
+xdp_test_run_init_page(struct page *page, struct xdp_test_data *xdp)
+{
+	struct xdp_page_head *head = phys_to_virt(page_to_phys(page));
+	struct xdp_buff *new_ctx, *orig_ctx;
+	u32 headroom = XDP_PACKET_HEADROOM;
+	size_t frm_len, meta_len;
+	struct xdp_frame *frm;
+	void *data;
+
+	/* Optimise for the recycle case, which is the normal case when doing
+	 * high-repetition REDIRECTS to drivers that return frames.
+	 */
+	if (likely(head->cookie == xdp->cookie)) {
+		reset_ctx(head, xdp);
+		return head;
+	}
+
+	head->cookie = xdp->cookie;
+
+	orig_ctx = xdp->orig_ctx;
+	frm_len = orig_ctx->data_end - orig_ctx->data_meta;
+	meta_len = orig_ctx->data - orig_ctx->data_meta;
+	headroom -= meta_len;
+
+	new_ctx = &head->ctx;
+	frm = head->frame;
+	data = head->data;
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
+
+	return head;
+}
+
 static int xdp_recv_frames(struct xdp_frame **frames, int nframes,
 			   struct sk_buff **skbs,
 			   struct net_device *dev)
@@ -287,6 +282,7 @@ static int xdp_test_run_batch(struct xdp_test_data *xdp, struct bpf_prog *prog,
 	struct xdp_page_head *head;
 	struct xdp_frame *frm;
 	bool redirect = false;
+	struct page_pool *pp;
 	struct xdp_buff *ctx;
 	struct page *page;
 
@@ -295,15 +291,17 @@ static int xdp_test_run_batch(struct xdp_test_data *xdp, struct bpf_prog *prog,
 	local_bh_disable();
 	xdp_set_return_frame_no_direct();
 
+	pp = this_cpu_read(system_page_pool);
+	xdp->rxq.mem.id = pp->xdp_mem_id;
+
 	for (i = 0; i < batch_sz; i++) {
-		page = page_pool_dev_alloc_pages(xdp->pp);
+		page = page_pool_dev_alloc_pages(pp);
 		if (!page) {
 			err = -ENOMEM;
 			goto out;
 		}
 
-		head = phys_to_virt(page_to_phys(page));
-		reset_ctx(head);
+		head = xdp_test_run_init_page(page, xdp);
 		ctx = &head->ctx;
 		frm = head->frame;
 		xdp->frame_cnt++;
-- 
2.43.0


