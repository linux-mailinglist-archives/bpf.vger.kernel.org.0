Return-Path: <bpf+bounces-31919-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98266905098
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2024 12:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DBCE1C20C2C
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2024 10:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AF816F0CF;
	Wed, 12 Jun 2024 10:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IDpjaBA8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rkHwJMlc"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549F916EC0E;
	Wed, 12 Jun 2024 10:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718188978; cv=none; b=sKsOo4JXrJjJnJiRXunlqIlY3+rRrx8Hchhu4qtD6WTAfyZ5N/muCU8XTrWQvZ8766r7XJeZ38nOXlVNUEf3UDN0I6oNWM1zpBfx3kL/e4TNrfPg86qei+6FlalA03DFOfJO1xyQwhUX2lPTNXoo81I9ZR80vNFIrcjhx1ebfdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718188978; c=relaxed/simple;
	bh=x0irVHea9xJBnbsbAv4Kh560yicrGm3RLgdBbtzUyl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dX7g4PoJLYy6zgcGsSS4bz6fYm/0vyg1hTi8I7BmRgSJDrKHtjCyzCEI2UVSWaGqRx1QkS+bMe2vA/qZJtxh/kmJQE42cXl0IUk+V2j+Qkz5OiX04aBW+Aq0Hu2swLLgkPJOQgliN91DRAst2gmsIw5KI5Zp9IzEHX4v7DOchKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IDpjaBA8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rkHwJMlc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 12 Jun 2024 12:42:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718188973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=btdOPFQFwTkICHYO1/SoS8iTZ/W/Xt2/b1M+VRqmDTM=;
	b=IDpjaBA81cwQHdCuUa6AsYhHFMJfKS66w1BzngfRChyyzRsuf1C7gUDC1H4T64izBar7Vo
	3qpLLECGiwGfco+3yOh7lwhloytYJvZ8YjzX26zWCTLsOD6DV4b1ktoIdy4BAPZDM6ZMNM
	UhJTB26hppPQ3ypcHcSNhwZAwBW0Gj5H4ZNQ66ZLC4MVpG9kwGcE3WL/JgfZ4nkr6B20tj
	M1J31nbbvSBhD1arW6+O4bAiDmKgIq7durXJ20MUONT9VIkkUWcraDAGUUri2HHn8mr4Mj
	t27i6+WPxHho/IviSahXeBdnBdrZ2XFMihFVD/BDWbalfCgP91kmCl20RFOv4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718188973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=btdOPFQFwTkICHYO1/SoS8iTZ/W/Xt2/b1M+VRqmDTM=;
	b=rkHwJMlcGcVjifPlUIsNT1RgwpVmOs1VR/JmIAvZ8a0kz1iIbmBjQ6EguIfz7TD28Ug6DA
	4BXb03RjqhRAsQAA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Subject: Re: [PATCH v5 net-next 14/15] net: Reference bpf_redirect_info via
 task_struct on PREEMPT_RT.
Message-ID: <20240612104251.DDjnpfnq@linutronix.de>
References: <20240607070427.1379327-1-bigeasy@linutronix.de>
 <20240607070427.1379327-15-bigeasy@linutronix.de>
 <045e3716-3c3a-4238-b38a-3616c8974e2c@kernel.org>
 <20240610165014.uWp_yZuW@linutronix.de>
 <18328cc2-c135-4b69-8c5f-cd45998e970f@kernel.org>
 <20240611083918.fJTJJtBu@linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240611083918.fJTJJtBu@linutronix.de>

On 2024-06-11 10:39:20 [+0200], To Jesper Dangaard Brouer wrote:
> On 2024-06-11 09:55:11 [+0200], Jesper Dangaard Brouer wrote:
> > >   struct bpf_net_context {
> > >   	struct bpf_redirect_info ri;
> > >   	struct list_head cpu_map_flush_list;
> > >   	struct list_head dev_map_flush_list;
> > >   	struct list_head xskmap_map_flush_list;
> > > +	unsigned int flags;
> > 
> > Why have yet another flags variable, when we already have two flags in
> > bpf_redirect_info ?
> 
> Ah you want to fold this into ri member including the status for the
> lists? Could try. It is splitted in order to delay the initialisation of
> the lists, too. We would need to be careful to not overwrite the
> flags if `ri' is initialized after the lists. That would be the case
> with CONFIG_DEBUG_NET=y and not doing redirect (the empty list check
> initializes that).

What about this:

------>8----------

diff --git a/include/linux/filter.h b/include/linux/filter.h
index d2b4260d9d0be..c0349522de8fb 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -733,15 +733,22 @@ struct bpf_nh_params {
 	};
 };
 
+/* flags for bpf_redirect_info kern_flags */
+#define BPF_RI_F_RF_NO_DIRECT	BIT(0)	/* no napi_direct on return_frame */
+#define BPF_RI_F_RI_INIT	BIT(1)
+#define BPF_RI_F_CPU_MAP_INIT	BIT(2)
+#define BPF_RI_F_DEV_MAP_INIT	BIT(3)
+#define BPF_RI_F_XSK_MAP_INIT	BIT(4)
+
 struct bpf_redirect_info {
 	u64 tgt_index;
 	void *tgt_value;
 	struct bpf_map *map;
 	u32 flags;
-	u32 kern_flags;
 	u32 map_id;
 	enum bpf_map_type map_type;
 	struct bpf_nh_params nh;
+	u32 kern_flags;
 };
 
 struct bpf_net_context {
@@ -757,14 +764,7 @@ static inline struct bpf_net_context *bpf_net_ctx_set(struct bpf_net_context *bp
 
 	if (tsk->bpf_net_context != NULL)
 		return NULL;
-	memset(&bpf_net_ctx->ri, 0, sizeof(bpf_net_ctx->ri));
-
-	if (IS_ENABLED(CONFIG_BPF_SYSCALL)) {
-		INIT_LIST_HEAD(&bpf_net_ctx->cpu_map_flush_list);
-		INIT_LIST_HEAD(&bpf_net_ctx->dev_map_flush_list);
-	}
-	if (IS_ENABLED(CONFIG_XDP_SOCKETS))
-		INIT_LIST_HEAD(&bpf_net_ctx->xskmap_map_flush_list);
+	bpf_net_ctx->ri.kern_flags = 0;
 
 	tsk->bpf_net_context = bpf_net_ctx;
 	return bpf_net_ctx;
@@ -785,6 +785,11 @@ static inline struct bpf_redirect_info *bpf_net_ctx_get_ri(void)
 {
 	struct bpf_net_context *bpf_net_ctx = bpf_net_ctx_get();
 
+	if (!(bpf_net_ctx->ri.kern_flags & BPF_RI_F_RI_INIT)) {
+		memset(&bpf_net_ctx->ri, 0, offsetof(struct bpf_net_context, ri.nh));
+		bpf_net_ctx->ri.kern_flags |= BPF_RI_F_RI_INIT;
+	}
+
 	return &bpf_net_ctx->ri;
 }
 
@@ -792,6 +797,11 @@ static inline struct list_head *bpf_net_ctx_get_cpu_map_flush_list(void)
 {
 	struct bpf_net_context *bpf_net_ctx = bpf_net_ctx_get();
 
+	if (!(bpf_net_ctx->ri.kern_flags & BPF_RI_F_CPU_MAP_INIT)) {
+		INIT_LIST_HEAD(&bpf_net_ctx->cpu_map_flush_list);
+		bpf_net_ctx->ri.kern_flags |= BPF_RI_F_CPU_MAP_INIT;
+	}
+
 	return &bpf_net_ctx->cpu_map_flush_list;
 }
 
@@ -799,6 +809,11 @@ static inline struct list_head *bpf_net_ctx_get_dev_flush_list(void)
 {
 	struct bpf_net_context *bpf_net_ctx = bpf_net_ctx_get();
 
+	if (!(bpf_net_ctx->ri.kern_flags & BPF_RI_F_DEV_MAP_INIT)) {
+		INIT_LIST_HEAD(&bpf_net_ctx->dev_map_flush_list);
+		bpf_net_ctx->ri.kern_flags |= BPF_RI_F_DEV_MAP_INIT;
+	}
+
 	return &bpf_net_ctx->dev_map_flush_list;
 }
 
@@ -806,12 +821,14 @@ static inline struct list_head *bpf_net_ctx_get_xskmap_flush_list(void)
 {
 	struct bpf_net_context *bpf_net_ctx = bpf_net_ctx_get();
 
+	if (!(bpf_net_ctx->ri.kern_flags & BPF_RI_F_XSK_MAP_INIT)) {
+		INIT_LIST_HEAD(&bpf_net_ctx->xskmap_map_flush_list);
+		bpf_net_ctx->ri.kern_flags |= BPF_RI_F_XSK_MAP_INIT;
+	}
+
 	return &bpf_net_ctx->xskmap_map_flush_list;
 }
 
-/* flags for bpf_redirect_info kern_flags */
-#define BPF_RI_F_RF_NO_DIRECT	BIT(0)	/* no napi_direct on return_frame */
-
 /* Compute the linear packet data range [data, data_end) which
  * will be accessed by various program types (cls_bpf, act_bpf,
  * lwt, ...). Subsystems allowing direct data access must (!)

------>8----------

Moving kern_flags to the end excludes it from the memset() and can be
re-used for the delayed initialisation.

Sebastian

