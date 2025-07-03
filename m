Return-Path: <bpf+bounces-62325-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6964AF8125
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 21:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 358ED169701
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 19:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59EF4298CA3;
	Thu,  3 Jul 2025 19:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="udqrnOIZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FE91D5CE5
	for <bpf@vger.kernel.org>; Thu,  3 Jul 2025 19:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751569960; cv=none; b=IG0tUr0yDpeznyIPf7qVt3HVfhMAZhrRCiEEGO04emc+0IGlAku8A8P0EwhZdCxzrmP8BsMOP6/Pm9yb0i6c8sSHdKccxwLKWPWjwQSssRqc7p81BwMjEnxLeBEXzvtuqMYfLOWl1503S+Ox3+iIrVI0BmXbA/8l3ogM3vFosEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751569960; c=relaxed/simple;
	bh=5zk04lPeismEExHWoRzSbc5jiM9EQgCMXfunYhjSaGY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QWTwAKQGdQKPJPKX7ecMQhJxQza91pVr5BVuYsrocP2ywsNp2MmRHHnh74ku3byedq72S5w3DGCJ12iWiGHPBY+2fdxf2F1poxAYwtzcwwWwf2vHGbYpZpZo56L9up4TxZe/oQSazdlNUgjwyNeUYNyVQTCqFIbPextIVNGRdu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=udqrnOIZ; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-70e1d8c2dc2so1341887b3.3
        for <bpf@vger.kernel.org>; Thu, 03 Jul 2025 12:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1751569957; x=1752174757; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yGr+QYPuCU6aBQe4Ez0c6TWIoWQDu43cxjMrZGVFhGo=;
        b=udqrnOIZ8El2Ao8wyheMOanfExINfH5m9beGJv1W++YVCN+EaZ27FfszJMTmqvh3AE
         cAK4h3Z2NheSmoz0wm0f5ugLWOLbIRHypwEasoCpik5h0ErOQUDylqnHikAENj6EaGFV
         YR6oHBSwmAn/aSyXM/ha7t/RBVfElv4k48fj/XRCRkNR2owB0oOiiQwW1xBXUg+9t9Rt
         e2hOjoBkpP2d5kYr1QRjtTw91kTlip4eH1m2vGOIZB60CdGC/XLzEtxM7qAsvZZ9RTG5
         VxJmj4o2/gLlht9FbQUUp3az8/1KXhJE5zwzDCFFrnGGzEXDjLf4qqjAK8HnzhtCKWwq
         mH0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751569957; x=1752174757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yGr+QYPuCU6aBQe4Ez0c6TWIoWQDu43cxjMrZGVFhGo=;
        b=iYZRvdAXow53od23JDWng8MQtvVXgEyhORHbXNRgynbdQl8iWEwIwkRZ6VVSQ3V+y1
         GsfJBJmfScTf1hfHNsNvZLdzIH6pRmQmCKq3+oPhGDyYRnrM1pdoqXUqXZ/Kf+jkDHpX
         RqXUaPhcV8LF7sG/9vQeF1z0yfr4s2ypP6az6zs3onH0LS7aZ2/2S8rfHK2PnTOCVrTL
         3EhXmxQRKJ5zIkBPXCwsRoRNw6ZwyKQQ4pXULgglu6iRKNdP0oJd3vMi2Px/0dWDfYpP
         E4OU0qD1FTT760bkSgz9mELBEfrl00uekRlL/8RMk3rXCZ7ZdPpt3T7j/tahiAY+mtTG
         ncQA==
X-Gm-Message-State: AOJu0Yxfgk6nJhuyXwC8czet3Xocv5AXtO7eSOgq09fiWyhWMIe9lX1w
	hqFoEZR+WFxwMi9gIF+xcWUYA2TCskDH1Fjpd5fdyAHfSpHIlbSFhN7XnZa5wKZoqvT2e4XcXi5
	CE8jLJogdnT8virWcZbF5X7TUGyeiQYgzrEwxGl1K4g==
X-Gm-Gg: ASbGncs9vcJPW3HJNBLhzF9zBnNOgmiROLaXzJxH/C/yRcngOPCmaqt2HMc6AKG0ihu
	uPWgf6bAddob+/lj+gjzQPZlKZ2wkSokCA4UI1CRSk9XJFOnN0zqrQX95FYGOQn6WPcMRcmyA7C
	x69tI9Qw0+9+48OTSu+fi52Xl61Yy+mzb/yvlbDE0DNpWV
X-Google-Smtp-Source: AGHT+IEgCvCQG/ph3B5diJujpK8URiItLEoMRbf+kZb2LQVHXPNOz2N3UJLGhsx3VMzyfWkhOXZ0sLsHHOidzI/Q2R4=
X-Received: by 2002:a05:690c:4c08:b0:712:d946:788e with SMTP id
 00721157ae682-7164d2c9f9fmr108824677b3.14.1751569956890; Thu, 03 Jul 2025
 12:12:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702031737.407548-1-memxor@gmail.com> <20250702031737.407548-9-memxor@gmail.com>
In-Reply-To: <20250702031737.407548-9-memxor@gmail.com>
From: Emil Tsalapatis <emil@etsalapatis.com>
Date: Thu, 3 Jul 2025 15:12:26 -0400
X-Gm-Features: Ac12FXy8GteWvlR8I6lLI-D2pP_VrGnDMr5xr3dfSZLESbTXoEiAXctqMLgj8Bc
Message-ID: <CABFh=a7HLpea7ZhUbdMArLGRvAB+-defjV2V1Ko3Ba1Ttgty-A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 08/12] bpf: Report rqspinlock
 deadlocks/timeout to BPF stderr
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Barret Rhoden <brho@google.com>, Matt Bobrowski <mattbobrowski@google.com>, kkd@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 1, 2025 at 11:17=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> Begin reporting rqspinlock deadlocks and timeout to BPF program's
> stderr.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  kernel/bpf/rqspinlock.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> diff --git a/kernel/bpf/rqspinlock.c b/kernel/bpf/rqspinlock.c
> index 338305c8852c..5ab354d55d82 100644
> --- a/kernel/bpf/rqspinlock.c
> +++ b/kernel/bpf/rqspinlock.c
> @@ -666,6 +666,27 @@ EXPORT_SYMBOL_GPL(resilient_queued_spin_lock_slowpat=
h);
>
>  __bpf_kfunc_start_defs();
>
> +static void bpf_prog_report_rqspinlock_violation(const char *str, void *=
lock, bool irqsave)
> +{
> +       struct rqspinlock_held *rqh =3D this_cpu_ptr(&rqspinlock_held_loc=
ks);
> +       struct bpf_stream_stage ss;
> +       struct bpf_prog *prog;
> +
> +       prog =3D bpf_prog_find_from_stack();
> +       if (!prog)
> +               return;
> +       bpf_stream_stage(ss, prog, BPF_STDERR, ({
> +               bpf_stream_printk(ss, "ERROR: %s for bpf_res_spin_lock%s\=
n", str, irqsave ? "_irqsave" : "");
> +               bpf_stream_printk(ss, "Attempted lock   =3D 0x%px\n", loc=
k);
> +               bpf_stream_printk(ss, "Total held locks =3D %d\n", rqh->c=
nt);
> +               for (int i =3D 0; i < min(RES_NR_HELD, rqh->cnt); i++)
> +                       bpf_stream_printk(ss, "Held lock[%2d] =3D 0x%px\n=
", i, rqh->locks[i]);
> +               bpf_stream_dump_stack(ss);
> +       }));
> +}
> +
> +#define REPORT_STR(ret) ({ (ret) =3D=3D -ETIMEDOUT ? "Timeout detected" =
: "AA or ABBA deadlock detected"; })
> +
>  __bpf_kfunc int bpf_res_spin_lock(struct bpf_res_spin_lock *lock)
>  {
>         int ret;
> @@ -676,6 +697,7 @@ __bpf_kfunc int bpf_res_spin_lock(struct bpf_res_spin=
_lock *lock)
>         preempt_disable();
>         ret =3D res_spin_lock((rqspinlock_t *)lock);
>         if (unlikely(ret)) {
> +               bpf_prog_report_rqspinlock_violation(REPORT_STR(ret), loc=
k, false);
>                 preempt_enable();
>                 return ret;
>         }
> @@ -698,6 +720,7 @@ __bpf_kfunc int bpf_res_spin_lock_irqsave(struct bpf_=
res_spin_lock *lock, unsign
>         local_irq_save(flags);
>         ret =3D res_spin_lock((rqspinlock_t *)lock);
>         if (unlikely(ret)) {
> +               bpf_prog_report_rqspinlock_violation(REPORT_STR(ret), loc=
k, true);
>                 local_irq_restore(flags);
>                 preempt_enable();
>                 return ret;
> --
> 2.47.1
>

