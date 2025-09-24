Return-Path: <bpf+bounces-69493-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C62B97D8D
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 02:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B43619C7F6B
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 00:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECECE4A23;
	Wed, 24 Sep 2025 00:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CMq8Undl"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386E91C27
	for <bpf@vger.kernel.org>; Wed, 24 Sep 2025 00:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758672633; cv=none; b=BUfjmDVmIONW9khNOIplQkj9CZbhDfG5o+wK3l9c7bPqtYQV5+Px5xq4YVJr4P7LK6yIULSxsDEGsjCnj2XsGfaH/K/ncBhOJ3GHZLqnz2WAgLuVWXgetCigloW8gQJD6cW25cSZAvE3KZY81l07N+G+If6jAfnBZJnG9XLKA0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758672633; c=relaxed/simple;
	bh=Pcd65BB6YzzC2GQkZ7MdrsO+cOu5pnryfUtmIt5+SCw=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=lN68oLhomyASkt3XUDH1JmGgbGW224bgVXZ7EZCeyV5IOCoVzJymxp8dgQr+v0ljGlFdxav60dhHUb89/vgJSRc3kzuusA91fhqVveLjNvL5K0Y5IKf+yOtlm79kpP/5RkCclahrxMd75RHGtvFIcIoHsEyiUyvbtzFORQVTaeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CMq8Undl; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758672624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N7wjLUW6pApITJViVOTQ1n77IP/KhQwV4kS2IDqvpqw=;
	b=CMq8Undl3kLmVyrD1vEHp1mo0G7XEsnzJCwXueKrC7LnByNtgLn5NFmKX0/Pe2TyYXaYrz
	6/APFzbZSJhH3WGNvxwBqhCE5ribiVmeEbaAHs/hJBuu8uBplciO9BQg+WNBAlrY9gjoYw
	gfWTB2Mr6SwrqtmyrxINztQQXW5dkZY=
Date: Wed, 24 Sep 2025 00:10:22 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Zqiang" <qiang.zhang@linux.dev>
Message-ID: <91810f6e76fb2e97b0519c9442f1877e1de223fa@linux.dev>
TLS-Required: No
Subject: Re: [PATCH 23/34] srcu: Create an srcu_expedite_current() function
To: "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org,
 "Paul E. McKenney" <paulmck@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Alexei Starovoitov" <ast@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, bpf@vger.kernel.org
In-Reply-To: <20250923142036.112290-23-paulmck@kernel.org>
References: <580ea2de-799a-4ddc-bde9-c16f3fb1e6e7@paulmck-laptop>
 <20250923142036.112290-23-paulmck@kernel.org>
X-Migadu-Flow: FLOW_OUT

>=20
>=20This commit creates an srcu_expedite_current() function that expedite=
s
> the current (and possibly the next) SRCU grace period for the specified
> srcu_struct structure. This functionality will be inherited by RCU
> Tasks Trace courtesy of its mapping to SRCU fast.
>=20
>=20If the current SRCU grace period is already waiting, that wait will
> complete before the expediting takes effect. If there is no SRCU grace
> period in flight, this function might well create one.
>=20
>=20Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: <bpf@vger.kernel.org>
> ---
>  include/linux/srcutiny.h | 1 +
>  include/linux/srcutree.h | 8 ++++++
>  kernel/rcu/srcutree.c | 58 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 67 insertions(+)
>=20
>=20diff --git a/include/linux/srcutiny.h b/include/linux/srcutiny.h
> index 00e5f05288d5e7..941e8210479607 100644
> --- a/include/linux/srcutiny.h
> +++ b/include/linux/srcutiny.h
> @@ -104,6 +104,7 @@ static inline void srcu_barrier(struct srcu_struct =
*ssp)
>  synchronize_srcu(ssp);
>  }
>=20=20
>=20+static inline void srcu_expedite_current(struct srcu_struct *ssp) { =
}
>  #define srcu_check_read_flavor(ssp, read_flavor) do { } while (0)
>  #define srcu_check_read_flavor_force(ssp, read_flavor) do { } while (0=
)
>=20=20
>=20diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
> index 1adc58d2ab6425..4a5d1c0e7db361 100644
> --- a/include/linux/srcutree.h
> +++ b/include/linux/srcutree.h
> @@ -42,6 +42,8 @@ struct srcu_data {
>  struct timer_list delay_work; /* Delay for CB invoking */
>  struct work_struct work; /* Context for CB invoking. */
>  struct rcu_head srcu_barrier_head; /* For srcu_barrier() use. */
> + struct rcu_head srcu_ec_head; /* For srcu_expedite_current() use. */
> + int srcu_ec_state; /* State for srcu_expedite_current(). */
>  struct srcu_node *mynode; /* Leaf srcu_node. */
>  unsigned long grpmask; /* Mask for leaf srcu_node */
>  /* ->srcu_data_have_cbs[]. */
> @@ -135,6 +137,11 @@ struct srcu_struct {
>  #define SRCU_STATE_SCAN1 1
>  #define SRCU_STATE_SCAN2 2
>=20=20
>=20+/* Values for srcu_expedite_current() state (->srcu_ec_state). */
> +#define SRCU_EC_IDLE 0
> +#define SRCU_EC_PENDING 1
> +#define SRCU_EC_REPOST 2
> +
>  /*
>  * Values for initializing gp sequence fields. Higher values allow wrap=
 arounds to
>  * occur earlier.
> @@ -220,6 +227,7 @@ struct srcu_struct {
>  int __srcu_read_lock(struct srcu_struct *ssp) __acquires(ssp);
>  void synchronize_srcu_expedited(struct srcu_struct *ssp);
>  void srcu_barrier(struct srcu_struct *ssp);
> +void srcu_expedite_current(struct srcu_struct *ssp);
>  void srcu_torture_stats_print(struct srcu_struct *ssp, char *tt, char =
*tf);
>=20=20
>=20 // Converts a per-CPU pointer to an ->srcu_ctrs[] array element to t=
hat
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 1ff94b76d91f15..f2f11492e6936e 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -1688,6 +1688,64 @@ void srcu_barrier(struct srcu_struct *ssp)
>  }
>  EXPORT_SYMBOL_GPL(srcu_barrier);
>=20=20
>=20+/* Callback for srcu_expedite_current() usage. */
> +static void srcu_expedite_current_cb(struct rcu_head *rhp)
> +{
> + unsigned long flags;
> + bool needcb =3D false;
> + struct srcu_data *sdp =3D container_of(rhp, struct srcu_data, srcu_ec=
_head);
> +
> + spin_lock_irqsave_sdp_contention(sdp, &flags);
> + if (sdp->srcu_ec_state =3D=3D SRCU_EC_IDLE) {
> + WARN_ON_ONCE(1);
> + } else if (sdp->srcu_ec_state =3D=3D SRCU_EC_PENDING) {
> + sdp->srcu_ec_state =3D SRCU_EC_IDLE;
> + } else {
> + WARN_ON_ONCE(sdp->srcu_ec_state !=3D SRCU_EC_REPOST);
> + sdp->srcu_ec_state =3D SRCU_EC_PENDING;
> + needcb =3D true;
> + }
> + spin_unlock_irqrestore_rcu_node(sdp, flags);
> + // If needed, requeue ourselves as an expedited SRCU callback.
> + if (needcb)
> + __call_srcu(sdp->ssp, &sdp->srcu_ec_head, srcu_expedite_current_cb, f=
alse);
> +}
> +
> +/**
> + * srcu_expedite_current - Expedite the current SRCU grace period
> + * @ssp: srcu_struct to expedite.
> + *
> + * Cause the current SRCU grace period to become expedited. The grace
> + * period following the current one might also be expedited. If there =
is
> + * no current grace period, one might be created. If the current grace
> + * period is currently sleeping, that sleep will complete before exped=
iting
> + * will take effect.
> + */
> +void srcu_expedite_current(struct srcu_struct *ssp)
> +{
> + unsigned long flags;
> + bool needcb =3D false;
> + struct srcu_data *sdp;
> +
> + preempt_disable();
> + sdp =3D this_cpu_ptr(ssp->sda);
> + spin_lock_irqsave_sdp_contention(sdp, &flags);

For PREEMPT_RT kernels, a locking warnings may occur here.


> + if (sdp->srcu_ec_state =3D=3D SRCU_EC_IDLE) {
> + sdp->srcu_ec_state =3D SRCU_EC_PENDING;
> + needcb =3D true;
> + } else if (sdp->srcu_ec_state =3D=3D SRCU_EC_PENDING) {
> + sdp->srcu_ec_state =3D SRCU_EC_REPOST;
> + } else {
> + WARN_ON_ONCE(sdp->srcu_ec_state !=3D SRCU_EC_REPOST);
> + }
> + spin_unlock_irqrestore_rcu_node(sdp, flags);
> + // If needed, queue an expedited SRCU callback.
> + if (needcb)
> + __call_srcu(ssp, &sdp->srcu_ec_head, srcu_expedite_current_cb, false)=
;

The locking warnings may also occur in the __call_srcu().

Thanks
Zqiang

> + preempt_enable();
> +}
> +EXPORT_SYMBOL_GPL(srcu_expedite_current);
> +
>  /**
>  * srcu_batches_completed - return batches completed.
>  * @ssp: srcu_struct on which to report batch completion.
> --=20
>=202.40.1
>

