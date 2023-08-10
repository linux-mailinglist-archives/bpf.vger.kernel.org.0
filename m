Return-Path: <bpf+bounces-7440-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F056777594
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 12:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D33E61C20E37
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 10:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94CF21F172;
	Thu, 10 Aug 2023 10:16:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FFE1EA92
	for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 10:16:33 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7A683
	for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 03:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691662590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3g4MYlV9c76TpDpFrtoeRWOaaTNsy7O5xl7sNT1UeGY=;
	b=YC020XI4XppKQuSTeaMOVteOVUnG9ArYn+X0i1IMb3h1EAo5GT1osvzsCAtfaNo91TV2z3
	A4qVc45XbtX4YBF7e9BqY/WFwNbqpyPtDwaNCu0HUnwWbHd+Ok7fIJRbR2/GWNTJ6hiHSA
	tssuW/h+wzX/g0wPtYxSqAXBBUJ6Aro=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-iPBPdfLUN3KngeujTKMsIw-1; Thu, 10 Aug 2023 06:16:29 -0400
X-MC-Unique: iPBPdfLUN3KngeujTKMsIw-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-50daa85e940so568807a12.0
        for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 03:16:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691662588; x=1692267388;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3g4MYlV9c76TpDpFrtoeRWOaaTNsy7O5xl7sNT1UeGY=;
        b=Y1Iwpf+9o5x3nEBX4iYYqaJCZrp8IaMM5bQl0qeSA8zNLMJscsk98q0CkxZqJSGIOT
         0QD4T7exQyCOraKsgKCBBa/l61f4Gx1QfHNVEhIkc4LM0Spz/f32nqYm8Rl7+qbT/tNi
         Acm1A8J2gRVCNDsBU7qo72menyyGJOu3SIrYouuGL+XigzYu7B4JZ6VlXMCJqDHDWe7O
         LFGC8ek+W4NGv+c23fOodEQjcUnipSqmIhJkXnTmqM0GonvrPHyVudPt4StUcgffs2FT
         p/lOZ0QWKGePrevC8DKHKuZVNBHyhqpHEX/WIP7dgKzfz7kMKUatSSSvGHBXNlT4P35m
         VgLQ==
X-Gm-Message-State: AOJu0YzWAYHdoeMWGV1fkoCcFvSNu2JCl2HK2ofSvWNAuoBNp/uwzFhS
	8PSn7gqcwKPcQG3AIYYHkUG8eaKbAPGQGTQmipT6pUF0btunJbO6a/IqLtni+hTvN9y2dKsYyEB
	aevjq1hw+GCYh
X-Received: by 2002:a17:907:7856:b0:99c:180a:ea61 with SMTP id lb22-20020a170907785600b0099c180aea61mr1555828ejc.32.1691662588317;
        Thu, 10 Aug 2023 03:16:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7imgOwBehMDtK5zFzF5zWgHpCvwi/z7Q7Fv3EqBMxz76NVAIMMScPuBMMs24VuIge8kuAeQ==
X-Received: by 2002:a17:907:7856:b0:99c:180a:ea61 with SMTP id lb22-20020a170907785600b0099c180aea61mr1555806ejc.32.1691662587775;
        Thu, 10 Aug 2023 03:16:27 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id d2-20020a170906640200b0099d0c0bb92bsm722592ejm.80.2023.08.10.03.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 03:16:27 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 8013CD3B807; Thu, 10 Aug 2023 12:16:26 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, Jakub
 Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn.topel@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Song
 Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, Yonghong Song
 <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Jiri Olsa
 <jolsa@kernel.org>, houtao1@huawei.com
Subject: Re: [RFC PATCH bpf-next 1/2] bpf, cpumap: Use queue_rcu_work() to
 remove unnecessary rcu_barrier()
In-Reply-To: <20230728023030.1906124-2-houtao@huaweicloud.com>
References: <20230728023030.1906124-1-houtao@huaweicloud.com>
 <20230728023030.1906124-2-houtao@huaweicloud.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 10 Aug 2023 12:16:26 +0200
Message-ID: <87il9nfbid.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hou Tao <houtao@huaweicloud.com> writes:

> From: Hou Tao <houtao1@huawei.com>
>
> As for now __cpu_map_entry_replace() uses call_rcu() to wait for the
> inflight xdp program and NAPI poll to exit the RCU read critical
> section, and then launch kworker cpu_map_kthread_stop() to call
> kthread_stop() to handle all pending xdp frames or skbs.
>
> But it is unnecessary to use rcu_barrier() in cpu_map_kthread_stop() to
> wait for the completion of __cpu_map_entry_free(), because rcu_barrier()
> will wait for all pending RCU callbacks and cpu_map_kthread_stop() only
> needs to wait for the completion of a specific __cpu_map_entry_free().
>
> So use queue_rcu_work() to replace call_rcu(), schedule_work() and
> rcu_barrier(). queue_rcu_work() will queue a __cpu_map_entry_free()
> kworker after a RCU grace period. Because __cpu_map_entry_free() is
> running in a kworker context, so it is OK to do all of these freeing
> procedures include kthread_stop() in it.
>
> After the update, there is no need to do reference-counting for
> bpf_cpu_map_entry, because bpf_cpu_map_entry is freed directly in
> __cpu_map_entry_free(), so just remove it.
>
> Signed-off-by: Hou Tao <houtao1@huawei.com>

I think your analysis is correct, and this is a nice cleanup of what is
really a bit of an over-complicated cleanup flow - well done!

I have a few nits below, but with those feel free to resend as non-RFC
and add my:

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

> ---
>  kernel/bpf/cpumap.c | 93 +++++++++++----------------------------------
>  1 file changed, 23 insertions(+), 70 deletions(-)
>
> diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
> index 0a16e30b16ef..24f39c37526f 100644
> --- a/kernel/bpf/cpumap.c
> +++ b/kernel/bpf/cpumap.c
> @@ -67,10 +67,7 @@ struct bpf_cpu_map_entry {
>  	struct bpf_cpumap_val value;
>  	struct bpf_prog *prog;
>=20=20
> -	atomic_t refcnt; /* Control when this struct can be free'ed */
> -	struct rcu_head rcu;
> -
> -	struct work_struct kthread_stop_wq;
> +	struct rcu_work free_work;
>  };
>=20=20
>  struct bpf_cpu_map {
> @@ -115,11 +112,6 @@ static struct bpf_map *cpu_map_alloc(union bpf_attr =
*attr)
>  	return &cmap->map;
>  }
>=20=20
> -static void get_cpu_map_entry(struct bpf_cpu_map_entry *rcpu)
> -{
> -	atomic_inc(&rcpu->refcnt);
> -}
> -
>  static void __cpu_map_ring_cleanup(struct ptr_ring *ring)
>  {
>  	/* The tear-down procedure should have made sure that queue is
> @@ -134,43 +126,6 @@ static void __cpu_map_ring_cleanup(struct ptr_ring *=
ring)
>  			xdp_return_frame(xdpf);
>  }
>=20=20
> -static void put_cpu_map_entry(struct bpf_cpu_map_entry *rcpu)
> -{
> -	if (atomic_dec_and_test(&rcpu->refcnt)) {
> -		if (rcpu->prog)
> -			bpf_prog_put(rcpu->prog);
> -		/* The queue should be empty at this point */
> -		__cpu_map_ring_cleanup(rcpu->queue);
> -		ptr_ring_cleanup(rcpu->queue, NULL);
> -		kfree(rcpu->queue);
> -		kfree(rcpu);
> -	}
> -}
> -
> -/* called from workqueue, to workaround syscall using preempt_disable */
> -static void cpu_map_kthread_stop(struct work_struct *work)
> -{
> -	struct bpf_cpu_map_entry *rcpu;
> -	int err;
> -
> -	rcpu =3D container_of(work, struct bpf_cpu_map_entry, kthread_stop_wq);
> -
> -	/* Wait for flush in __cpu_map_entry_free(), via full RCU barrier,
> -	 * as it waits until all in-flight call_rcu() callbacks complete.
> -	 */
> -	rcu_barrier();
> -
> -	/* kthread_stop will wake_up_process and wait for it to complete */
> -	err =3D kthread_stop(rcpu->kthread);
> -	if (err) {
> -		/* kthread_stop may be called before cpu_map_kthread_run
> -		 * is executed, so we need to release the memory related
> -		 * to rcpu.
> -		 */
> -		put_cpu_map_entry(rcpu);
> -	}
> -}
> -
>  static void cpu_map_bpf_prog_run_skb(struct bpf_cpu_map_entry *rcpu,
>  				     struct list_head *listp,
>  				     struct xdp_cpumap_stats *stats)
> @@ -395,7 +350,6 @@ static int cpu_map_kthread_run(void *data)
>  	}
>  	__set_current_state(TASK_RUNNING);
>=20=20
> -	put_cpu_map_entry(rcpu);
>  	return 0;
>  }
>=20=20
> @@ -471,9 +425,6 @@ __cpu_map_entry_alloc(struct bpf_map *map, struct bpf=
_cpumap_val *value,
>  	if (IS_ERR(rcpu->kthread))
>  		goto free_prog;
>=20=20
> -	get_cpu_map_entry(rcpu); /* 1-refcnt for being in cmap->cpu_map[] */
> -	get_cpu_map_entry(rcpu); /* 1-refcnt for kthread */
> -
>  	/* Make sure kthread runs on a single CPU */
>  	kthread_bind(rcpu->kthread, cpu);
>  	wake_up_process(rcpu->kthread);
> @@ -494,7 +445,7 @@ __cpu_map_entry_alloc(struct bpf_map *map, struct bpf=
_cpumap_val *value,
>  	return NULL;
>  }
>=20=20
> -static void __cpu_map_entry_free(struct rcu_head *rcu)
> +static void __cpu_map_entry_free(struct work_struct *work)
>  {
>  	struct bpf_cpu_map_entry *rcpu;
>=20=20
> @@ -503,30 +454,33 @@ static void __cpu_map_entry_free(struct rcu_head *r=
cu)
>  	 * new packets and cannot change/set flush_needed that can
>  	 * find this entry.
>  	 */
> -	rcpu =3D container_of(rcu, struct bpf_cpu_map_entry, rcu);
> +	rcpu =3D container_of(to_rcu_work(work), struct bpf_cpu_map_entry, free=
_work);
>=20=20
>  	free_percpu(rcpu->bulkq);

Let's move this free down to the end along with the others.

> -	/* Cannot kthread_stop() here, last put free rcpu resources */
> -	put_cpu_map_entry(rcpu);
> +
> +	/* kthread_stop will wake_up_process and wait for it to complete */

Suggest adding to this comment: "cpu_map_kthread_run() makes sure the
pointer ring is empty before exiting."

> +	kthread_stop(rcpu->kthread);
> +
> +	if (rcpu->prog)
> +		bpf_prog_put(rcpu->prog);
> +	/* The queue should be empty at this point */
> +	__cpu_map_ring_cleanup(rcpu->queue);
> +	ptr_ring_cleanup(rcpu->queue, NULL);
> +	kfree(rcpu->queue);
> +	kfree(rcpu);
>  }
>=20=20
>  /* After xchg pointer to bpf_cpu_map_entry, use the call_rcu() to
> - * ensure any driver rcu critical sections have completed, but this
> - * does not guarantee a flush has happened yet. Because driver side
> - * rcu_read_lock/unlock only protects the running XDP program.  The
> - * atomic xchg and NULL-ptr check in __cpu_map_flush() makes sure a
> - * pending flush op doesn't fail.
> + * ensure both any driver rcu critical sections and xdp_do_flush()
> + * have completed.
>   *
>   * The bpf_cpu_map_entry is still used by the kthread, and there can
> - * still be pending packets (in queue and percpu bulkq).  A refcnt
> - * makes sure to last user (kthread_stop vs. call_rcu) free memory
> - * resources.
> + * still be pending packets (in queue and percpu bulkq).
>   *
> - * The rcu callback __cpu_map_entry_free flush remaining packets in
> - * percpu bulkq to queue.  Due to caller map_delete_elem() disable
> - * preemption, cannot call kthread_stop() to make sure queue is empty.
> - * Instead a work_queue is started for stopping kthread,
> - * cpu_map_kthread_stop, which waits for an RCU grace period before
> + * Due to caller map_delete_elem() is in RCU read critical section,
> + * cannot call kthread_stop() to make sure queue is empty. Instead
> + * a work_struct is started for stopping kthread,
> + * __cpu_map_entry_free, which waits for a RCU grace period before
>   * stopping kthread, emptying the queue.
>   */

I think the above comment is a bit too convoluted, still. I'd suggest
just replacing the whole thing with this:

/* After the xchg of the bpf_cpu_map_entry pointer, we need to make sure th=
e old
 * entry is no longer in use before freeing. We use queue_rcu_work() to call
 * __cpu_map_entry_free() in a separate workqueue after waiting for an RCU =
grace
 * period. This means that (a) all pending enqueue and flush operations have
 * completed (because or the RCU callback), and (b) we are in a workqueue
 * context where we can stop the kthread and wait for it to exit before fre=
eing
 * everything.
 */

>  static void __cpu_map_entry_replace(struct bpf_cpu_map *cmap,
> @@ -536,9 +490,8 @@ static void __cpu_map_entry_replace(struct bpf_cpu_ma=
p *cmap,
>=20=20
>  	old_rcpu =3D unrcu_pointer(xchg(&cmap->cpu_map[key_cpu], RCU_INITIALIZE=
R(rcpu)));
>  	if (old_rcpu) {
> -		call_rcu(&old_rcpu->rcu, __cpu_map_entry_free);
> -		INIT_WORK(&old_rcpu->kthread_stop_wq, cpu_map_kthread_stop);
> -		schedule_work(&old_rcpu->kthread_stop_wq);
> +		INIT_RCU_WORK(&old_rcpu->free_work, __cpu_map_entry_free);
> +		queue_rcu_work(system_wq, &old_rcpu->free_work);
>  	}
>  }
>=20=20
> --=20
> 2.29.2


