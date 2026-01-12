Return-Path: <bpf+bounces-78528-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 437AFD11226
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 09:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 47BB33004406
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 08:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7EF33ADB5;
	Mon, 12 Jan 2026 08:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9v6Menq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98689320A0B
	for <bpf@vger.kernel.org>; Mon, 12 Jan 2026 08:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768205440; cv=none; b=slnPWYxIRE+IbjzqNuVzwuCUQ6qfFCppwlYiXq8tzim8GBhqbOVttngMK9toFMOGLXBSx+ps4rlEJizHxbL90zm2+zCKaOPAuxJuRM3lvNGzWnr2uPgVBdM/lIztMhJx6bcd47jAHmMj/7BAZuSGcLGV3vqS6DPyfG+VtpkSrSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768205440; c=relaxed/simple;
	bh=2mlWvWV/cLm9pXTMD9rlFdUFCqPL5CYpRdOfrX9MadM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z9m2W9zp98JSaFo/kGJEa2IkQ3d7mkLnRfKtc2iXGUekytLbUJ7Eq8qcPOZ76r+DwpOj6Mvrx2BkzVc/e6S3xLF4tpMgsQYvNUKBYGauQp/LoAQx2orD3/aPak29MwRsUcvLto5/oKDPBhqxrxF2OqbmL+CW017V1OJLTZd6UeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b9v6Menq; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-42fbc305882so3193289f8f.0
        for <bpf@vger.kernel.org>; Mon, 12 Jan 2026 00:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768205437; x=1768810237; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n8nHhnAdAl4QaHXuoxZzEkdL8Xq20WXC5u/VaaPl79w=;
        b=b9v6MenqZjun3PnfPoBU0+wttDL566M2FnqJWYkhNTaCj+wD5nPHUnxKTZzrePSY9o
         CcqJ7kiGEhVUtvmMYNarwSs26F5gqQir14SLV5M9ybSWGVqpnw8uoLs0V3pX/SLB8KtP
         vosMsVLBCT1U3eYbYKVTyCf231SJOgpNBbV13XJNzC89RWn+tnDydemNv3juZmzx8S+N
         sd9qygzle6EJNN5kDCRd2bi5fZDPY/aennFrrlFfic+/dIHL83Wrlk3+SC6kBn+jgag6
         cK5TRRaRHyrcB3UK2PrLO30LoiiXd0CTzxjIs6cqwAz5lvNWJGGqg5nPXAmkaj6pc5aW
         KeRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768205437; x=1768810237;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n8nHhnAdAl4QaHXuoxZzEkdL8Xq20WXC5u/VaaPl79w=;
        b=TGSyi0PJu90I4jmfd8EWB4NbvzQVAZDMZ03N0Qw3MdaETkFhh0TC7S5YuaTn6yNiLq
         PRR1ArbO7gpaPCyLtaYaacELPDlyL3HLTVfApt2TMSw2qkYbpsfhkCrLMZ6YV6l16nE9
         LRmoFwyAMCRvXU9XnvyAIGTc0L6YsMhoLwC8AKy9AjwnM9zcyPwdynYAcoCYoUTtySi1
         0tRe1AhSFUAl7GoidK1OEVgwhdycS/idwtUC2nAvyZPiklNvDdgyUkG28oTaLCw/7QgW
         HxMvoRwvFfHK5BckxLc10aDjP+oggCZK16tUfowvE2Oq8kvd61G0ADqE60qX0YrCN6ba
         YoeA==
X-Gm-Message-State: AOJu0YzDgw0VO+pATZDYCwZQPyN4PeHP3/bMFWbc0cpK1UiT6jJycnvZ
	9t1emOJ9qIKS7y5dbH2wd/BE/WQJoBB7oPEdH+DDK4dpVTEK8M2wfqt2okWFEuU/OE66104M39D
	H/UrxmmSoHuFVg0KoQqtxR8yuk1gxy00=
X-Gm-Gg: AY/fxX6A/GruILI25jglmrh6B+LCJvtN+vN8Hu2tnPgOZ3cZOB+oklNOkDGhKPZeFbd
	hqSw6013zYoxmdvfXZ2IDTbrgqebnjqfIyZNqXI1cSaUu34snBNTlC+WqcFMOkSXllKSuAdUG0r
	iSQRdCo5OEwz5GSDfp4qQaUOU1TNtE63Tk/79j2pMiPRehOcZafaLWPm6ZORXYWhoqjOw+AVnUY
	ndCa2mAeBILsC41MdHzd6kfvn3NySrGOINGv7ey8fo5C6Bup86Ewcexzcuaf5xXKxwduCPJwzgh
	Dl3T5nJuoi9H9kRLnDDBOOU5NwgFeQ==
X-Google-Smtp-Source: AGHT+IGLX6WgZ55nA1z61tH5iRrAXfjTywBRFCUyhrTMbF14vHI60rSvqhJFYNBSWJmUrclMzk0IpeSElIXY+ZiL1ck=
X-Received: by 2002:a05:6000:2891:b0:42f:9f18:8f40 with SMTP id
 ffacd0b85a97d-432c3760ac4mr20602366f8f.42.1768205436709; Mon, 12 Jan 2026
 00:10:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107-timer_nolock-v3-0-740d3ec3e5f9@meta.com> <20260107-timer_nolock-v3-5-740d3ec3e5f9@meta.com>
In-Reply-To: <20260107-timer_nolock-v3-5-740d3ec3e5f9@meta.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 12 Jan 2026 09:10:00 +0100
X-Gm-Features: AZwV_QgTXkyS-F6Kvd76qfh9zjeyJEAPyVc6YtGZvul7aexe18ozybo94pIqLgs
Message-ID: <CAP01T751GMc9X25fmzCkn7U335o8VmB-oUnaLEtU=GC_GRkLTg@mail.gmail.com>
Subject: Re: [PATCH RFC v3 05/10] bpf: Enable bpf timer and workqueue use in NMI
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 7 Jan 2026 at 18:49, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com> wrote:
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
>  * Remove bpf_spin_lock from struct bpf_async_kern. Replace locked
>    operations with atomic cmpxchg() for initialization and xchg() for
>    cancel and free.
>  * Add per-async irq_work to defer NMI-unsafe operations (hrtimer_start,
>    hrtimer_try_to_cancel, schedule_work) from NMI to softirq context.
>  * Use the lock-free mpmc_cell (added in the previous commit) to pass
>    operation commands (start/cancel/free) along with their parameters
>    (nsec, mode) from NMI-safe callers to the irq_work handler.
>  * Add reference counting to bpf_async_cb to ensure the object stays
>    alive until all scheduled irq_work completes and the timer/work
>    callback finishes.
>  * Move bpf_prog_put() to RCU callback to handle races between
>    set_callback() and cancel_and_free().
>
> This enables BPF programs attached to NMI-context hooks (perf
> events) to use timers and workqueues for deferred processing.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  [...]
>
> -BPF_CALL_3(bpf_timer_start, struct bpf_async_kern *, timer, u64, nsecs, u64, flags)
> +BPF_CALL_3(bpf_timer_start, struct bpf_async_kern *, async, u64, nsecs, u64, flags)
>  {
>         struct bpf_hrtimer *t;
> -       int ret = 0;
> -       enum hrtimer_mode mode;
> +       u32 mode;
>
> -       if (in_nmi())
> -               return -EOPNOTSUPP;
>         if (flags & ~(BPF_F_TIMER_ABS | BPF_F_TIMER_CPU_PIN))
>                 return -EINVAL;
> -       __bpf_spin_lock_irqsave(&timer->lock);
> -       t = timer->timer;
> -       if (!t || !t->cb.prog) {
> -               ret = -EINVAL;
> -               goto out;
> -       }
> +
> +       guard(rcu)();
> +
> +       t = async->timer;
> +       if (!t || !t->cb.prog)

Read of t->cb.prog also needs READ_ONCE().

> +               return -EINVAL;
>
>         if (flags & BPF_F_TIMER_ABS)
>                 mode = HRTIMER_MODE_ABS_SOFT;
> @@ -1420,10 +1495,7 @@ BPF_CALL_3(bpf_timer_start, struct bpf_async_kern *, timer, u64, nsecs, u64, fla
>         if (flags & BPF_F_TIMER_CPU_PIN)
>                 mode |= HRTIMER_MODE_PINNED;
>
> -       hrtimer_start(&t->timer, ns_to_ktime(nsecs), mode);
> -out:
> -       __bpf_spin_unlock_irqrestore(&timer->lock);
> -       return ret;
> +       return bpf_async_schedule_op(&t->cb, BPF_ASYNC_START, nsecs, mode);
>  }
>
>  [...]

