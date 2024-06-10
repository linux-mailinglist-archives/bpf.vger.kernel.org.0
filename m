Return-Path: <bpf+bounces-31728-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D79A3902748
	for <lists+bpf@lfdr.de>; Mon, 10 Jun 2024 18:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B39B281945
	for <lists+bpf@lfdr.de>; Mon, 10 Jun 2024 16:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D226149C7C;
	Mon, 10 Jun 2024 16:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0ByqorSj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tyx90Pd1"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AE712DDBF;
	Mon, 10 Jun 2024 16:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718038220; cv=none; b=aC3G35f3z1ipj0JXLDOA9623thb0vDpepYv7mUZp068pzap0XKg2drUnQR+uAOiz0l1yV02VjOKyWGtUlE6ufq7g+ZhJIAfBOQQSgyZ1zPzf+0aposX0yHkbr8CUuV82KATGRHvSAmdWQzYYPbzPfEybUMYNOspegqtsbLnLbZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718038220; c=relaxed/simple;
	bh=2Pysp2MIMTNGwRVr9lAmW3t1K3ysiVl+gKSN5E4c1WY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D+zUc2w/JjrwnxZL+hI9NX9PmJIpM3uHUzfMbm2bk7KfIfsMEzVqge7ei84WdisUCGSCrykXvQ6mrEmoE/KVpEyd6Ob2c628wuLtwoLsBpmMcyhNOmB6qbh3zopXfOwF4YWOUNKe5qIwKq6+j0+TXaYIx6Ht6v2kAQ2M1q21oB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0ByqorSj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tyx90Pd1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 10 Jun 2024 18:50:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718038216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZUG8qT1jsbNQmFGMO0jjotiUr6xGaSvGZ7FTw1KrNLE=;
	b=0ByqorSjazMn8M2XIEnEhO48pkpn9COrv/EkcBqZwsLeJqnRm4+408sO1yGSdxDymrtYRw
	RlznT1rpxRT2KvWzDHwTgIS7EoqHsn+JSyNuO0XRxjhQO2y7mcznORbUkj7ItFk9PRaULt
	DvrQyGM4mVnb7ii8JP+bEl4F/xtOTFYmjE+i1ACssWSPfcouxzgGClq1ynEc40YZEgd5tt
	M8QRJ4cE/tD2iqE+a6iym0IhGq5uARoSfpO9ULNgXQFZ0Qt34jrblh5wMU1kcuu+x9BNsC
	Koc3CQvFChHC4OqgkR2js6gbOLoAX3ea+4JpYXciGpnnFS3ru5CvOCzFs7h95Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718038216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZUG8qT1jsbNQmFGMO0jjotiUr6xGaSvGZ7FTw1KrNLE=;
	b=tyx90Pd14x/Bvtq0Buh0VU7Pp4BJaXnt7eyfGHvApZgLFw6vHD+QX2jjH/0cbGqK+EgTIx
	Rb42yDJC1c1L/VBg==
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
Message-ID: <20240610165014.uWp_yZuW@linutronix.de>
References: <20240607070427.1379327-1-bigeasy@linutronix.de>
 <20240607070427.1379327-15-bigeasy@linutronix.de>
 <045e3716-3c3a-4238-b38a-3616c8974e2c@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <045e3716-3c3a-4238-b38a-3616c8974e2c@kernel.org>

On 2024-06-07 13:51:25 [+0200], Jesper Dangaard Brouer wrote:
> The memset can be further optimized as it currently clears 64 bytes, but
> it only need to clear 40 bytes, see pahole below.
>=20
> Replace memset with something like:
>  memset(&bpf_net_ctx->ri, 0, offsetof(struct bpf_net_context, ri.nh));
>=20
> This is an optimization, because with 64 bytes this result in a rep-stos
> (repeated string store operation) that on Intel touch CPU-flags (to be
> IRQ safe) which is slow, while clearing 40 bytes doesn't cause compiler
> to use this instruction, which is faster.  Memset benchmarked with [1]

I've been playing along with this and have to say that "rep stosq" is
roughly 3x slower vs "movq" for 64 bytes on all x86 I've been looking
at.
For gcc the stosq vs movq depends on the CPU settings. The generic uses
movq up to 40 bytes, skylake uses movq even for 64bytes. clang=E2=80=A6
This could be tuned via -mmemset-strategy=3Dlibcall:64:align,rep_8byte:-1:a=
lign

I folded this into the last two patches:

diff --git a/include/linux/filter.h b/include/linux/filter.h
index d2b4260d9d0be..1588d208f1348 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -744,27 +744,40 @@ struct bpf_redirect_info {
 	struct bpf_nh_params nh;
 };
=20
+enum bpf_ctx_init_type {
+	bpf_ctx_ri_init,
+	bpf_ctx_cpu_map_init,
+	bpf_ctx_dev_map_init,
+	bpf_ctx_xsk_map_init,
+};
+
 struct bpf_net_context {
 	struct bpf_redirect_info ri;
 	struct list_head cpu_map_flush_list;
 	struct list_head dev_map_flush_list;
 	struct list_head xskmap_map_flush_list;
+	unsigned int flags;
 };
=20
+static inline bool bpf_net_ctx_need_init(struct bpf_net_context *bpf_net_c=
tx,
+					 enum bpf_ctx_init_type flag)
+{
+	return !(bpf_net_ctx->flags & (1 << flag));
+}
+
+static inline bool bpf_net_ctx_set_flag(struct bpf_net_context *bpf_net_ct=
x,
+					enum bpf_ctx_init_type flag)
+{
+	return bpf_net_ctx->flags |=3D 1 << flag;
+}
+
 static inline struct bpf_net_context *bpf_net_ctx_set(struct bpf_net_conte=
xt *bpf_net_ctx)
 {
 	struct task_struct *tsk =3D current;
=20
 	if (tsk->bpf_net_context !=3D NULL)
 		return NULL;
-	memset(&bpf_net_ctx->ri, 0, sizeof(bpf_net_ctx->ri));
-
-	if (IS_ENABLED(CONFIG_BPF_SYSCALL)) {
-		INIT_LIST_HEAD(&bpf_net_ctx->cpu_map_flush_list);
-		INIT_LIST_HEAD(&bpf_net_ctx->dev_map_flush_list);
-	}
-	if (IS_ENABLED(CONFIG_XDP_SOCKETS))
-		INIT_LIST_HEAD(&bpf_net_ctx->xskmap_map_flush_list);
+	bpf_net_ctx->flags =3D 0;
=20
 	tsk->bpf_net_context =3D bpf_net_ctx;
 	return bpf_net_ctx;
@@ -785,6 +798,11 @@ static inline struct bpf_redirect_info *bpf_net_ctx_ge=
t_ri(void)
 {
 	struct bpf_net_context *bpf_net_ctx =3D bpf_net_ctx_get();
=20
+	if (bpf_net_ctx_need_init(bpf_net_ctx, bpf_ctx_ri_init)) {
+		memset(&bpf_net_ctx->ri, 0, offsetof(struct bpf_net_context, ri.nh));
+		bpf_net_ctx_set_flag(bpf_net_ctx, bpf_ctx_ri_init);
+	}
+
 	return &bpf_net_ctx->ri;
 }
=20
@@ -792,6 +810,11 @@ static inline struct list_head *bpf_net_ctx_get_cpu_ma=
p_flush_list(void)
 {
 	struct bpf_net_context *bpf_net_ctx =3D bpf_net_ctx_get();
=20
+	if (bpf_net_ctx_need_init(bpf_net_ctx, bpf_ctx_cpu_map_init)) {
+		INIT_LIST_HEAD(&bpf_net_ctx->cpu_map_flush_list);
+		bpf_net_ctx_set_flag(bpf_net_ctx, bpf_ctx_cpu_map_init);
+	}
+
 	return &bpf_net_ctx->cpu_map_flush_list;
 }
=20
@@ -799,6 +822,11 @@ static inline struct list_head *bpf_net_ctx_get_dev_fl=
ush_list(void)
 {
 	struct bpf_net_context *bpf_net_ctx =3D bpf_net_ctx_get();
=20
+	if (bpf_net_ctx_need_init(bpf_net_ctx, bpf_ctx_dev_map_init)) {
+		INIT_LIST_HEAD(&bpf_net_ctx->dev_map_flush_list);
+		bpf_net_ctx_set_flag(bpf_net_ctx, bpf_ctx_dev_map_init);
+	}
+
 	return &bpf_net_ctx->dev_map_flush_list;
 }
=20
@@ -806,6 +834,11 @@ static inline struct list_head *bpf_net_ctx_get_xskmap=
_flush_list(void)
 {
 	struct bpf_net_context *bpf_net_ctx =3D bpf_net_ctx_get();
=20
+	if (bpf_net_ctx_need_init(bpf_net_ctx, bpf_ctx_xsk_map_init)) {
+		INIT_LIST_HEAD(&bpf_net_ctx->xskmap_map_flush_list);
+		bpf_net_ctx_set_flag(bpf_net_ctx, bpf_ctx_xsk_map_init);
+	}
+
 	return &bpf_net_ctx->xskmap_map_flush_list;
 }
=20

Sebastian

