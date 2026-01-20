Return-Path: <bpf+bounces-79674-lists+bpf=lfdr.de@vger.kernel.org>
Delivered-To: lists+bpf@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPuABUbTb2mgMQAAu9opvQ
	(envelope-from <bpf+bounces-79674-lists+bpf=lfdr.de@vger.kernel.org>)
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 20:11:02 +0100
X-Original-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8AF4A0F6
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 20:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CF715805D8B
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 18:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECFF426D16;
	Tue, 20 Jan 2026 18:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IAYLdAYD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C211426D06
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 18:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768933901; cv=pass; b=cEHIt+LVKBdABEMoBqgc8kjeozaaum1zbFoDvpYLHMkFV+ZHCFDsqPT6RNVq4aupHIqG7zVsEPHJyQVk/20IjQd8xZl+z2Kx6ElNurNEQsfexySTADVAgYTlozDUAf5Tco7D0VVrlwOB6JZjTDdgQVhfR43k3z81Mv9Wq02B/tY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768933901; c=relaxed/simple;
	bh=h/PJnVBz67MtBzfdJLauGFi7JW4wW/3HKkPSBtDx3nw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U1ACn62gNdPBdoRM+O/0uUA3CEIzr6+/+VGCwE+qzuVy73YCJAApd+Vk8ygMyIGF9NZUt8V7bOUQIaIlJX9w4iuPRauRbXcUpiLQGtLF5U9RZQaVv5ew0MlqKWUVALSsNvT97AoEbnmwL3kMixTU8VYY5G2rv20EofryjGUMDF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IAYLdAYD; arc=pass smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-bc17d39ccd2so2314746a12.3
        for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 10:31:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768933898; cv=none;
        d=google.com; s=arc-20240605;
        b=GUh1dS5GptFfiGovq7l4OztRk3+dURqXP5SzKxs6cgZ0lDwvNUbUf9Jz6FqK6w/Nhi
         r4ml8qA6l7SS23/l6L2v/mqHd9rymD04DtVEuT64R4kkBgk6NT1QfohymVbxHOtOm/k1
         9FsTICyecKPI6xObW0zlG+I8kvLD1Ke0SdDg39+O8wkPwwnq32/HQMI/SmwnKbOKYtOU
         tpAV4RkPZjuEJ6//3WKsIxGCLj+gjTKJ8WRfx6t9KlMaeAOGBf0KzHlu0h6x0WsAxA56
         ai1s7XUsD6OPV93/cgWmXtSJoh/xfdHDkPNwyaTZDmiOETQLODlv1O2V8we/amLcnQD8
         0XwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FYFIDedOB3I3T1M4rc/baX5dobqKc/ZhE+F3xQZPdLw=;
        fh=be3ZzmqAIbRlSghzgFcEfYPfCYPMzDKw5fMGW4LljfE=;
        b=gtlCGGRuDgEgdYBQXTJ5P8b0NSDDomYM9I9hx8sXc4+2DHSvFYzxiz4QoyL9l6Xc6g
         dM2mLG2ZJl2cAgnmMIhsxVfwc7fcqaqQDOTSM51XtVz/ynqkUIg3ZujRpzyGGer0/VSW
         sDmgvH/vzeq8rqTySoxeL6UcjiaSsTAKYDxNPErLqipzxdCSpjTfZKCxpaN/vR7GXkzK
         RZPP8hvxOkKJ8L07vH+O59dX1b4Dz0HF8YTBMeC0FfkQu8B3xsWUiWZhaHfg5T/oKlHv
         XL0lzQ/IEfRqftpb2vkQAYpCrRTjjCpcEm4GC8wqaTtR6Ek0vp+yRkO7RJYTZlAdGe3Z
         B/GA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768933898; x=1769538698; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FYFIDedOB3I3T1M4rc/baX5dobqKc/ZhE+F3xQZPdLw=;
        b=IAYLdAYDMBTpvl25+RRqwWt9/NJldnXR7dLGyY8u8Cra0jBLVDJrC8dXvUl2s7gmVj
         NqDJMrk2HJFbkNyfoH2iW7d4SNX1suZCu11NbP7hSOYK0DS71gsNti4uUHtts78iFlWp
         eZKrBQj66l6SClfH7PzUZ6Ynme9G4fg3ZAtqsYe2mhKub/33VffgPfTOmpezKzynHGhx
         Gg8ElroJ1tz9X8UFTCo8swKJD8K+fVxVdcN+Xa0SOK0QnznoNsd9MLdz6cwFmWr7u0uR
         Xnmdk3ShvzuyjfmNPaFGFhn7NtSpwAx7kPIivHmyBZA1x7x9nl+h2BrpgGw+fYpJRcpP
         XhEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768933898; x=1769538698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FYFIDedOB3I3T1M4rc/baX5dobqKc/ZhE+F3xQZPdLw=;
        b=RPSMgBQiA3DEC5usfC5qqFoRsaQ10/aog2sW2AT6fAYDJf8pshjlwXqBxCQ3zHgU1p
         l4KBlRXUxMvfQ1HovLw7K7H1nsrCSq75SalRN7jYB/9+zjTqN6Hz6naVfmw3f+NQUXDU
         DPgOPkAzQxl3Py1bFhGlV0tThy0ftArf/ZmvUbOlRLvEzC8n6zmXktFr9vGYBKlMTSrU
         UKRzFoEUsdSACKg7KgS1PvgRFW/Z3Te+FF0zUvPFQt5bs6MAlhJJPBw0XshL8hKvn3T4
         bKOsEaMmmpFPL5k4tDbPvRm+BepcQXtSBY56YdrZqrsTRz/0dws7I+/2aV5JulRpNt5o
         kQCA==
X-Gm-Message-State: AOJu0YzjkY54pWsPIrTb1Rbw+aOjvjAVCvFgtvoyfzoUF4pSBQb+ZOvf
	roG3mk5pvFA8WrAUCi+i61ohOYa/Z+FQ6OxdehUNxMNtuq2YrXG7+hrRK8NTcXL/l0fwTjJI4Ys
	3Tce+MlhJsaCWhPC8TuyS/UM9oIUndjk=
X-Gm-Gg: AZuq6aKknt4+xXTwQN2fQK3OreLEUJKhySRgd5TNTWcxZlIkvypDBCwIeTizxII2BH3
	OAvm5OaF8AuwnY5+C3PYzQToDeU4JvM7VrK/cNOIX79lJga1dJ77ebzVsDchbVy7ms6ZB1WSJE3
	Hd1Ws+JkfJptj0mnnLah5qBpilaSa1IqKgpHOuEhWHyc9xc6x11Wqp+2Jeilp72q+iXjH+dVNcg
	uuDpSw/rZEv9Dx5Qf0aR3Wnqn+l2F71jtt5uLoIc9D88pBxPzEn7zy5jp4vUq+/XxUmW7VFW39B
	sBcqejuPA8HIL0oabHUTSA==
X-Received: by 2002:a17:90b:4a0b:b0:34c:3cbc:db8e with SMTP id
 98e67ed59e1d1-352c4078cdemr2087146a91.25.1768933898027; Tue, 20 Jan 2026
 10:31:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120-timer_nolock-v6-0-670ffdd787b4@meta.com> <20260120-timer_nolock-v6-5-670ffdd787b4@meta.com>
In-Reply-To: <20260120-timer_nolock-v6-5-670ffdd787b4@meta.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 20 Jan 2026 10:31:25 -0800
X-Gm-Features: AZwV_QhcEhMHQwUMTBQI8pEREpaBiFGR4_YBcpFHfTYcKhHg3HnWWotQvLdEVrU
Message-ID: <CAEf4Bza1r4db3srwPYymSDC=ynhbZ-vsVJKshy8wGfnRhKkCmQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 05/10] bpf: Enable bpf timer and workqueue use
 in NMI
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, memxor@gmail.com, 
	eddyz87@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79674-lists,bpf=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,meta.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriinakryiko@gmail.com,bpf@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[bpf];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: AD8AF4A0F6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 7:59=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Refactor bpf timer and workqueue helpers to allow calling them from NMI
> context by making all operations lock-free and deferring NMI-unsafe
> work to irq_work.
>
> Previously, bpf_timer_start(), and bpf_wq_start()
> could not be called from NMI context because they acquired
> bpf_spin_lock and called hrtimer/schedule_work APIs directly. This
> patch removes these limitations.
>
> Key changes:
>  * Remove bpf_spin_lock from struct bpf_async_kern.
>  * Initialize/Destroy via setting/unsetting bpf_async_cb pointer
>    atomically.
>  * Add per-bpf_async_cb irq_work to defer NMI-unsafe
>    operations (hrtimer_start, hrtimer_try_to_cancel, schedule_work) from
>    NMI to softirq context.
>  * Use the lock-free seqcount_latch_t to pass operation
>    commands (start/cancel/free) and parameters
>    from NMI-safe callers to the irq_work handler.
>  * Add reference counting to bpf_async_cb to ensure the object stays
>    alive until all scheduled irq_work completes.
>  * Move bpf_prog_put() to RCU callback to handle races between
>    set_callback() and cancel_and_free().
>  * Modify cancel_and_free() path:
>    * Detach bpf_async_cb.
>    * Signal destruction to irq_work side via setting last_seq to
>      BPF_ASYNC_DESTROY.
>    * On receiving BPF_ASYNC_DESTROY, cancel timer/wq.
>  * Free bpf_async_cb on refcnt reaching 0, wait for both rcu and rcu
>    task trace grace periods before freeing the bpf_async_cb. Removed
>    unnecessary rcu locks, as kfunc/helper allways assumes rcu or rcu
>    task trace lock.
>
> This enables BPF programs attached to NMI-context hooks (perf
> events) to use timers and workqueues for deferred processing.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  kernel/bpf/helpers.c | 423 +++++++++++++++++++++++++++++----------------=
------
>  1 file changed, 240 insertions(+), 183 deletions(-)

I think we'll need another revision, but all the things I pointed out
below do not change the logic in any big way, so it would be great for
people that were following along but waited for the overall
implementation to stabilize to actually check the implementation now.
I think it's basically ready, hopefully the next revision will land,
so let's do another round of thorough reviews.


[...]

> +static int bpf_async_schedule_op(struct bpf_async_cb *cb, enum bpf_async=
_op op,
> +                                u64 nsec, u32 timer_mode)
> +{
> +       /* Acquire active writer */
> +       if (atomic_cmpxchg_acquire(&cb->writer, 0, 1))
> +               return -EBUSY;
> +
> +       write_seqcount_latch_begin(&cb->latch);
> +       cb->cmd[0].nsec =3D nsec;
> +       cb->cmd[0].mode =3D timer_mode;
> +       cb->cmd[0].op =3D op;
> +       write_seqcount_latch(&cb->latch);
> +       cb->cmd[1].nsec =3D nsec;
> +       cb->cmd[1].mode =3D timer_mode;
> +       cb->cmd[1].op =3D op;
> +       write_seqcount_latch_end(&cb->latch);
> +
> +       atomic_set_release(&cb->writer, 0);
> +
> +       if (!refcount_inc_not_zero(&cb->refcnt))
> +               return -EBUSY;

let's not do refcount bump unless we are going to schedule irq_work,
so move this after !in_nmi() check, and instead of
bpf_async_irq_worker() call only part of it that does the work, but
doesn't put the refcount. This will speed up common non-NMI case.

[...]

> +static int bpf_async_read_op(struct bpf_async_cb *cb, enum bpf_async_op =
*op,
> +                            u64 *nsec, u32 *flags)
> +{
> +       u32 seq, idx;
> +       s64 last_seq;
> +
> +       while (true) {
> +               last_seq =3D atomic64_read_acquire(&cb->last_seq);
> +               if (last_seq > U32_MAX) /* Check if terminal seq num has =
been set */

unlikely() seems to be warranted here to optimize (a little bit) a common c=
ase

> +                       return bpf_async_handle_terminal_seq(cb, last_seq=
, op);

why this helper function, it's called once. It's actually a
distraction, IMO, that this logic is split out. Can you please inline
it here?

> +
> +               seq =3D raw_read_seqcount_latch(&cb->latch);
> +
> +               /* Return -EBUSY if current seq is consumed by another re=
ader */
> +               if (seq =3D=3D last_seq)
> +                       return -EBUSY;

I'd drop this check, below atomic64_try_cmpxchg() should handle this
unlikely situation anyways, no?

> +
> +               idx =3D seq & 1;
> +               *nsec =3D cb->cmd[idx].nsec;

[...]

> -       ret =3D bpf_async_update_prog_callback(cb, callback_fn, prog);
> -out:
> -       __bpf_spin_unlock_irqrestore(&async->lock);
> -       return ret;
> +       cb =3D READ_ONCE(async->cb);
> +       if (!cb)
> +               return -EINVAL;
> +
> +       return bpf_async_update_prog_callback(cb, callback_fn, prog);

nit: if you end up with another revision, consider swapping callback
and prog arguments order, it doesn't make sense for callback (that
belongs to that prog) to be specified before the prog. Super minor,
but reads very backwards.

>  }
>
>  BPF_CALL_3(bpf_timer_set_callback, struct bpf_async_kern *, timer, void =
*, callback_fn,

[...]

> @@ -1536,79 +1617,75 @@ static const struct bpf_func_proto bpf_timer_canc=
el_proto =3D {
>         .arg1_type      =3D ARG_PTR_TO_TIMER,
>  };
>
> -static struct bpf_async_cb *__bpf_async_cancel_and_free(struct bpf_async=
_kern *async)
> +static void __bpf_async_cancel_and_free(struct bpf_async_kern *async)
>  {
>         struct bpf_async_cb *cb;
>
> -       /* Performance optimization: read async->cb without lock first. *=
/
> -       if (!READ_ONCE(async->cb))
> -               return NULL;
> -

I don't feel strongly about this, but I guess we could leave this
performance optimization in place without changing anything else, so
why not?

> -       __bpf_spin_lock_irqsave(&async->lock);
> -       /* re-read it under lock */
> -       cb =3D async->cb;
> +       cb =3D xchg(&async->cb, NULL);
>         if (!cb)
> -               goto out;
> -       bpf_async_update_prog_callback(cb, NULL, NULL);
> -       /* The subsequent bpf_timer_start/cancel() helpers won't be able =
to use
> -        * this timer, since it won't be initialized.
> -        */
> -       WRITE_ONCE(async->cb, NULL);
> -out:
> -       __bpf_spin_unlock_irqrestore(&async->lock);
> -       return cb;
> +               return;
> +
> +       atomic64_set(&cb->last_seq, BPF_ASYNC_DESTROY);
> +       /* Pass map's reference to irq_work callback */

I'd expand here, because it's subtle but important. Just to make it
very clear: we *attempt* to pass our initial map's reference to
irq_work callback, but if we fail to schedule it (meaning it is
already scheduled by someone else having their own ref), we have to
put that ref here.

It's important to have a noticeable comment here because refcounting
here looks asymmetrical (and thus broken at first sight), but it's
actually not.

But also, can't we do the same !in_nmi() optimization here as with
schedule_op above?

> +       if (!irq_work_queue(&cb->worker))
> +               bpf_async_refcount_put(cb);
>  }
>

[...]

> -       if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
> -               /* If the timer is running on other CPU, also use a kwork=
er to
> -                * wait for the completion of the timer instead of trying=
 to
> -                * acquire a sleepable lock in hrtimer_cancel() to wait f=
or its
> -                * completion.
> -                */
> -               if (hrtimer_try_to_cancel(&t->timer) >=3D 0)
> -                       call_rcu(&t->cb.rcu, bpf_async_cb_rcu_free);
> -               else
> -                       queue_work(system_dfl_wq, &t->cb.delete_work);
> -       } else {
> -               bpf_timer_delete_work(&t->cb.delete_work);
> +               switch (op) {
> +               case BPF_ASYNC_START:
> +                       hrtimer_start(&t->timer, ns_to_ktime(timer_nsec),=
 timer_mode);
> +                       break;
> +               case BPF_ASYNC_CANCEL:
> +                       hrtimer_try_to_cancel(&t->timer);

I think it's important to point out (in patch description) that we now
have asynchronous timer cancellation on cancel_and_free, and thus we
don't need all that hrtimer_running logic that you removed above (and
a huge comment accompanying it).

> +                       break;
> +               default:

Drop BPF_ASYNC_CANCEL_AND_FREE which we don't use anymore, and then
you won't need default (and compiler will complain if we add new
operation that isn't handled explicitly).

If that doesn't work for some reason, at least WARN_ON_ONCE() here.
This shouldn't ever happen, but if it does during development, we
better know about that.

> +                       break;
> +               }
> +               break;
> +       }
> +       case BPF_ASYNC_TYPE_WQ: {
> +               struct bpf_work *w =3D container_of(cb, struct bpf_work, =
cb);
> +
> +               switch (op) {
> +               case BPF_ASYNC_START:
> +                       schedule_work(&w->work);
> +                       break;
> +               case BPF_ASYNC_CANCEL:
> +                       /* Use non-blocking cancel, safe in irq_work cont=
ext.
> +                        * RCU grace period ensures callback completes be=
fore free.
> +                        */
> +                       cancel_work(&w->work);
> +                       break;
> +               default:

same as above

> +                       break;
> +               }
> +               break;
>         }
> +       }
> +}
> +
> +static void bpf_async_irq_worker(struct irq_work *work)
> +{
> +       struct bpf_async_cb *cb =3D container_of(work, struct bpf_async_c=
b, worker);
> +       u32 op, timer_mode;
> +       u64 nsec;
> +       int err;
> +
> +       err =3D bpf_async_read_op(cb, &op, &nsec, &timer_mode);
> +       if (err)
> +               goto out;
> +
> +       bpf_async_process_op(cb, op, nsec, timer_mode);

if you split read_op+process_op combo into a separate function, then
you won't need refcount manipulations outside of in_nmi context. Let's
do it.

> +
> +out:
> +       bpf_async_refcount_put(cb);
>  }
>
>  /*

[...]

