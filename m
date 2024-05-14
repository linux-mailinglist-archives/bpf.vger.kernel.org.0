Return-Path: <bpf+bounces-29691-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8338C5526
	for <lists+bpf@lfdr.de>; Tue, 14 May 2024 13:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0C0B1F21B12
	for <lists+bpf@lfdr.de>; Tue, 14 May 2024 11:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF43757E8;
	Tue, 14 May 2024 11:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SjtYa0WS"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4FB74E10
	for <bpf@vger.kernel.org>; Tue, 14 May 2024 11:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715687689; cv=none; b=XXhqOMouCazu0R498TxNBm1F10+zWgjJd7zy3TItNCR+/8BdNgnl+5FcziuXXc0JZOucu1Z+r59QwfhinXu1YnrCgMoh3MJ6ecviZ7fALqh1T4huoJYjq4wB2WcIaUQ14XC2Zsaqjezzq5WluzAttWANrPGuooCILchuHE+VQ7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715687689; c=relaxed/simple;
	bh=nnJX6P3EkP1dyPUxV/tx9bKRjnghvW7CbEGyGDRSCGA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BkQc5hhINVUK9WBDjJROmV5LBjPJAO/XuUhAIINm0mj1FEM5UVrdXjYYK4z5qnntmZWJIMWi4pSTat5tZgADT5l41kP6Ra3P/5pzZ1H4Mtn1hcP+vw1GzLkGzjgGbfohwrDeJ+L62Z7IQ3AyXJPt4W8c0SvtPothbiB76FBhNec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SjtYa0WS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715687687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZmVpbn0AeBjsEQpU86fpJTQEpZN0TMYC3p/NPKB9WEU=;
	b=SjtYa0WS11NpdK8ejag5exS2/aM1XyhjtQMHy8ih9ulfOy0LZIlUjzv2iRfhayXN1wgh+F
	d4qs1yiZWAwXi5DVQuE7wfk5xkDuPBFtsbyz0hWL7C94WcIALZy0GWl8LlctpfA2Pb2kzj
	3WtPJnkgxMu3Z0LZhzf1gGfXHrmRcLs=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-bfgNxpuqPIe_nEAisCtClg-1; Tue, 14 May 2024 07:54:45 -0400
X-MC-Unique: bfgNxpuqPIe_nEAisCtClg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a599dbd2b6aso318069166b.2
        for <bpf@vger.kernel.org>; Tue, 14 May 2024 04:54:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715687684; x=1716292484;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZmVpbn0AeBjsEQpU86fpJTQEpZN0TMYC3p/NPKB9WEU=;
        b=pV1YVdWPLFVm9/TFKBcgjtWPcSHc57ZZ/gAoyM6SUzjTrHtnZVL+W2r8PNZH7k4hCf
         PeYmWz0skOIm7jNLTnqnXVUWjpyil5K9XaeI7Nb3qSqspVru2JkWQqshbJpxeeohCiCI
         Y9i3a4fBQEiPoWhAbjy5VwIj2upP8/9XUQYMGjYdFIIB166WRx6Qk80DMivtSjufT2W2
         S01xUD9gIrTXKnvo0RprqOJePKdXNALGyKxItUu3JRJTby59BVAVkovv1dzllDpVkeFD
         7wjrQZYfM0Dfrw1k2W5IwD5nIpguC+qbm4rbgdiHrc2n/UKlw9ioZ5bwAfsMPNMrQv3E
         m8ng==
X-Forwarded-Encrypted: i=1; AJvYcCWMly79/LrTwkfVCEtPD+srMEWazLkB99ZXCxiw+Qv+J9+ULnEtVfjTvxAcMu2eGmzBKotXZZy7dAUIvHpXJ1Gwbr5F
X-Gm-Message-State: AOJu0YyhvRqRMGOqJmHN1+XcTPqgGAaszsu8BgJtzsM8b7FZieL4sJ4T
	qSxI8c5kTAYsYS+NTtW1nA3D4RE0rJ45X48fdopbc4G711b7gyWHZrX6kwYXWkfcJJWJSBXVmL/
	bbaqmeJLs2rMyEeFoDNIoJhIhAOvr2jS213YlOxSJTc3YNVzdsg==
X-Received: by 2002:a17:906:f1cd:b0:a59:af54:1651 with SMTP id a640c23a62f3a-a5a2d641977mr770408966b.57.1715687684502;
        Tue, 14 May 2024 04:54:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDjLdVyLdxEuxHEe+hgxcQWw/qN8QsStaUE90DA4xueTt2WHN4fQhw5JMZD6CMDc+VjV8qZA==
X-Received: by 2002:a17:906:f1cd:b0:a59:af54:1651 with SMTP id a640c23a62f3a-a5a2d641977mr770406366b.57.1715687683960;
        Tue, 14 May 2024 04:54:43 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a8883344bsm49361266b.9.2024.05.14.04.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 04:54:43 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 0834F12F64B5; Tue, 14 May 2024 13:54:43 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Jesper Dangaard
 Brouer <hawk@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, LKML
 <linux-kernel@vger.kernel.org>, Network Development
 <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Boqun
 Feng <boqun.feng@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, Eric
 Dumazet <edumazet@google.com>, Frederic Weisbecker <frederic@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Thomas
 Gleixner <tglx@linutronix.de>, Waiman Long <longman@redhat.com>, Will
 Deacon <will@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Hao
 Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Stanislav Fomichev
 <sdf@google.com>, Yonghong Song <yonghong.song@linux.dev>, bpf
 <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next 14/15 v2] net: Reference bpf_redirect_info via
 task_struct on PREEMPT_RT.
In-Reply-To: <20240510162121.f-tvqcyf@linutronix.de>
References: <20240503182957.1042122-1-bigeasy@linutronix.de>
 <20240503182957.1042122-15-bigeasy@linutronix.de> <87y18mohhp.fsf@toke.dk>
 <CAADnVQJkiwaYXUo+LyKoV96VFFCFL0VY5Jgpuv_0oypksrnciA@mail.gmail.com>
 <20240507123636.cTnT7TvU@linutronix.de>
 <93062ce7-8dfa-48a9-a4ad-24c5a3993b41@kernel.org>
 <20240510162121.f-tvqcyf@linutronix.de>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 14 May 2024 13:54:43 +0200
Message-ID: <87le4cd2ws.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

> The XDP redirect process is two staged:
> - bpf_prog_run_xdp() is invoked to run a eBPF program which inspects the
>   packet and makes decisions. While doing that, the per-CPU variable
>   bpf_redirect_info is used.
>
> - Afterwards xdp_do_redirect() is invoked and accesses bpf_redirect_info
>   and it may also access other per-CPU variables like xskmap_flush_list.
>
> At the very end of the NAPI callback, xdp_do_flush() is invoked which
> does not access bpf_redirect_info but will touch the individual per-CPU
> lists.
>
> The per-CPU variables are only used in the NAPI callback hence disabling
> bottom halves is the only protection mechanism. Users from preemptible
> context (like cpu_map_kthread_run()) explicitly disable bottom halves
> for protections reasons.
> Without locking in local_bh_disable() on PREEMPT_RT this data structure
> requires explicit locking.
>
> PREEMPT_RT has forced-threaded interrupts enabled and every
> NAPI-callback runs in a thread. If each thread has its own data
> structure then locking can be avoided.
>
> Create a struct bpf_net_context which contains struct bpf_redirect_info.
> Define the variable on stack, use bpf_net_ctx_set() to save a pointer to
> it. Use the __free() annotation to automatically reset the pointer once
> function returns.
> The bpf_net_ctx_set() may nest. For instance a function can be used from
> within NET_RX_SOFTIRQ/ net_rx_action which uses bpf_net_ctx_set() and
> NET_TX_SOFTIRQ which does not. Therefore only the first invocations
> updates the pointer.
> Use bpf_net_ctx_get_ri() as a wrapper to retrieve the current struct
> bpf_redirect_info.
>
> On PREEMPT_RT the pointer to bpf_net_context is saved task's
> task_struct. On non-PREEMPT_RT builds the pointer saved in a per-CPU
> variable (which is always NODE-local memory). Using always the
> bpf_net_context approach has the advantage that there is almost zero
> differences between PREEMPT_RT and non-PREEMPT_RT builds.
>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: Hao Luo <haoluo@google.com>
> Cc: Jesper Dangaard Brouer <hawk@kernel.org>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: KP Singh <kpsingh@kernel.org>
> Cc: Martin KaFai Lau <martin.lau@linux.dev>
> Cc: Song Liu <song@kernel.org>
> Cc: Stanislav Fomichev <sdf@google.com>
> Cc: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> Cc: Yonghong Song <yonghong.song@linux.dev>
> Cc: bpf@vger.kernel.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  include/linux/filter.h | 42 ++++++++++++++++++++++++++++++++-----
>  include/linux/sched.h  |  3 +++
>  kernel/bpf/cpumap.c    |  3 +++
>  kernel/fork.c          |  1 +
>  net/bpf/test_run.c     | 11 +++++++++-
>  net/core/dev.c         | 19 ++++++++++++++++-
>  net/core/filter.c      | 47 +++++++++++++++++++-----------------------
>  net/core/lwt_bpf.c     |  3 +++
>  8 files changed, 96 insertions(+), 33 deletions(-)
>
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index d5fea03cb6e61..6db5a68db6ee1 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -744,7 +744,39 @@ struct bpf_redirect_info {
>  	struct bpf_nh_params nh;
>  };
>=20=20
> -DECLARE_PER_CPU(struct bpf_redirect_info, bpf_redirect_info);
> +struct bpf_net_context {
> +	struct bpf_redirect_info ri;
> +};
> +
> +static inline struct bpf_net_context *bpf_net_ctx_set(struct bpf_net_con=
text *bpf_net_ctx)
> +{
> +	struct task_struct *tsk =3D current;
> +
> +	if (tsk->bpf_net_context !=3D NULL)
> +		return NULL;
> +	tsk->bpf_net_context =3D bpf_net_ctx;
> +	return bpf_net_ctx;
> +}
> +
> +static inline void bpf_net_ctx_clear(struct bpf_net_context *bpf_net_ctx)
> +{
> +	if (bpf_net_ctx)
> +		current->bpf_net_context =3D NULL;
> +}
> +
> +static inline struct bpf_net_context *bpf_net_ctx_get(void)
> +{
> +	return current->bpf_net_context;
> +}
> +
> +static inline struct bpf_redirect_info *bpf_net_ctx_get_ri(void)
> +{
> +	struct bpf_net_context *bpf_net_ctx =3D bpf_net_ctx_get();
> +
> +	return &bpf_net_ctx->ri;
> +}
> +
> +DEFINE_FREE(bpf_net_ctx_clear, struct bpf_net_context *, bpf_net_ctx_cle=
ar(_T));
>=20=20
>  /* flags for bpf_redirect_info kern_flags */
>  #define BPF_RI_F_RF_NO_DIRECT	BIT(0)	/* no napi_direct on return_frame */
> @@ -1021,21 +1053,21 @@ void bpf_clear_redirect_map(struct bpf_map *map);
>=20=20
>  static inline bool xdp_return_frame_no_direct(void)
>  {
> -	struct bpf_redirect_info *ri =3D this_cpu_ptr(&bpf_redirect_info);
> +	struct bpf_redirect_info *ri =3D bpf_net_ctx_get_ri();
>=20=20
>  	return ri->kern_flags & BPF_RI_F_RF_NO_DIRECT;
>  }
>=20=20
>  static inline void xdp_set_return_frame_no_direct(void)
>  {
> -	struct bpf_redirect_info *ri =3D this_cpu_ptr(&bpf_redirect_info);
> +	struct bpf_redirect_info *ri =3D bpf_net_ctx_get_ri();
>=20=20
>  	ri->kern_flags |=3D BPF_RI_F_RF_NO_DIRECT;
>  }
>=20=20
>  static inline void xdp_clear_return_frame_no_direct(void)
>  {
> -	struct bpf_redirect_info *ri =3D this_cpu_ptr(&bpf_redirect_info);
> +	struct bpf_redirect_info *ri =3D bpf_net_ctx_get_ri();
>=20=20
>  	ri->kern_flags &=3D ~BPF_RI_F_RF_NO_DIRECT;
>  }
> @@ -1591,7 +1623,7 @@ static __always_inline long __bpf_xdp_redirect_map(=
struct bpf_map *map, u64 inde
>  						   u64 flags, const u64 flag_mask,
>  						   void *lookup_elem(struct bpf_map *map, u32 key))
>  {
> -	struct bpf_redirect_info *ri =3D this_cpu_ptr(&bpf_redirect_info);
> +	struct bpf_redirect_info *ri =3D bpf_net_ctx_get_ri();
>  	const u64 action_mask =3D XDP_ABORTED | XDP_DROP | XDP_PASS | XDP_TX;
>=20=20
>  	/* Lower bits of the flags are used as return code on lookup failure */
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 6779d3b8f2578..cc9be45de6606 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -53,6 +53,7 @@ struct bio_list;
>  struct blk_plug;
>  struct bpf_local_storage;
>  struct bpf_run_ctx;
> +struct bpf_net_context;
>  struct capture_control;
>  struct cfs_rq;
>  struct fs_struct;
> @@ -1504,6 +1505,8 @@ struct task_struct {
>  	/* Used for BPF run context */
>  	struct bpf_run_ctx		*bpf_ctx;
>  #endif
> +	/* Used by BPF for per-TASK xdp storage */
> +	struct bpf_net_context		*bpf_net_context;

Okay, so if we are going the route of always putting this in 'current',
why not just embed the whole struct bpf_net_context inside task_struct,
instead of mucking about with the stack-allocated structures and
setting/clearing of pointers?

-Toke


