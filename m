Return-Path: <bpf+bounces-68546-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CED2B5A1E5
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 22:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E76858366D
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 20:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1828E2E0905;
	Tue, 16 Sep 2025 20:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iRiQ8XFq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BD71E7C2E
	for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 20:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758053362; cv=none; b=EKsmIM/uCnUjsIUOuiwONZADUtQX3tkJ28NIJUGOtNy8Vktb2Q8ufrYzUzT2v0lvOH3lB0+LgDJnBdqXWwUDdb2A+whaRdOSE3zMVfXVopJeIvz18YhvgWkv5s7/DzDVMUg1Ty8BvmEZaXreq6/PjtorIuDst+Gg5APtouDVf6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758053362; c=relaxed/simple;
	bh=kFMNafmfpSpgGAMegJTxMGxKwyKl73WNu0BJuqEEnpQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UBX37YUau5gxCum36wV0Q43pI4EFOK7+PA9Y8wnRhSk8cJ8oag2VmwmWjmZFmeXlzslFIMWxLBnNKF81HtwBPxvtcePbQS+PmSIyWig9TWlUGED+tb7QR4Q6GGKq2munOSM4MCO3aJp9POlSxB3nsBOlTBINBl6+f/PhA2Nxh2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iRiQ8XFq; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-62f1987d49fso2833013a12.2
        for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 13:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758053358; x=1758658158; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OwgDuv73wPWihlcYppSUjd2n6CEiy9nRrnJYOKb/aJ0=;
        b=iRiQ8XFqcLfR5wzsB920brG6/P/TCQr8vc/cmq2cszDOGWyQRrHiWB4S8WYxoi//5p
         am7Nr3IlaVRszskv2aAlGVZPA0YyGokvaPBxa/VGORfy2AtBx8kZsNVmr/DEFWGhyPWv
         zizocyvrj3DWZogjHeQVK9Iyg9G/OZx/1wWr/1HSENGgOW2eDkzRvdeXicK+er6theA1
         SPC5p5VGpTk8sUuc5M3K+jiGbMhFicJht6lMrufEsNxshp2sCtDBKPM3pMvyq66Jebi5
         Tip2ZzzS4mFR5Q8faI/9Ea/b2skYGLhlO45/5hoCKo8DHkhbx/ERBT8Q7Xe2y7w1ojrM
         ciQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758053358; x=1758658158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OwgDuv73wPWihlcYppSUjd2n6CEiy9nRrnJYOKb/aJ0=;
        b=g5dzJqmuS3ZdkZ8W17Z2NvWRTKod1oBMEvqUx9BfpPlfGHP3EoOllKrJeNZfruPsOt
         jkJFp+iiJo58CZYtPZU8DgPJE5NjMvZSSLOQXmBFw6vu9iCMJXt1abbpLTnguE70iG28
         WCzkhiSgfYHWzLoRQa6hsnyIwUZbpKi2CScxEhnSKjM8u7t3QYkLVEPoIO07jQvyG23L
         Wyl24qTc4n+O4IQeHrScF8dJUIiU9Q2jRrhHenla1RkRAORBp95nUdvq78nU1go3ocXA
         c0Y6V7wz+XQS0nekWeb98mg1sqq6sXK/jREIyPnLWQUwMJlFUqJj+5SvhdgU19+K06DD
         IwPw==
X-Gm-Message-State: AOJu0YypAC2wZHFeCJp/ecBeIqkAUE2d2CV1hqJflj2Qir8NRlP7bnfx
	KSnsWAexyo02A17ZGV2FgONYzbYXoafocwvPM+lpkZO+T9+HSyhS3FNAijPu4/uFRAHpUqFYzt9
	f4uuVsJBfE7DpGZI6EhGApnqchFoOMuM=
X-Gm-Gg: ASbGnctuKNHSFqpB3qK/MyIqOyTZVOw4V4H73TXoAJTIrZP3ylV3AwNJ3Ne2HQa0Zrl
	kt3N4JK5DhUZdRc1TaszDG9yrf4gSwUypOwdNOV/t04uJmi8KJy2tj2vU/5rq7yaro/yN+q7UKl
	FRZGRHICxkTCf4g0yzpkQLuuEGMpTWcQQSLv1Qrt+hbTGwQzkjZ9ROaiadXIN77TomOT/5WfOgN
	qNDL8Snf/cXwryQzWve
X-Google-Smtp-Source: AGHT+IFgA2/lt582shPhXgM0G6UNRqs0b5rDft+89CSQBmTIgBK/jAinuxHTgmmf9O36TkC1kyXMjIyLv+H9IY4rFsg=
X-Received: by 2002:a05:6402:46c1:b0:627:d1af:8c66 with SMTP id
 4fb4d7f45d1cf-62ed823f049mr17631801a12.5.1758053357738; Tue, 16 Sep 2025
 13:09:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915201820.248977-1-mykyta.yatsenko5@gmail.com> <20250915201820.248977-8-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250915201820.248977-8-mykyta.yatsenko5@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 16 Sep 2025 22:08:41 +0200
X-Gm-Features: AS18NWB7fCequ0PDq5EWpNon3u2hG_GPU65dHePcZPTn_BxdwVu5hBk9VMo_DA4
Message-ID: <CAP01T75XvsSe81L9Kis4jjra+uaqx+ummgcuoF7+s5iBy9CtZQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 7/8] bpf: task work scheduling kfuncs
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 15 Sept 2025 at 22:18, Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Implementation of the new bpf_task_work_schedule kfuncs, that let a BPF
> program schedule task_work callbacks for a target task:
>  * bpf_task_work_schedule_signal() - schedules with TWA_SIGNAL
>  * bpf_task_work_schedule_resume() - schedules with TWA_RESUME
>
> Each map value should embed a struct bpf_task_work, which the kernel
> side pairs with struct bpf_task_work_kern, containing a pointer to
> struct bpf_task_work_ctx, that maintains metadata relevant for the
> concrete callback scheduling.
>
> A small state machine and refcounting scheme ensures safe reuse and
> teardown. State transitions:
>     _______________________________
>     |                             |
>     v                             |
> [standby] ---> [pending] --> [scheduling] --> [scheduled]
>     ^                             |________________|_________
>     |                                                       |
>     |                                                       v
>     |                                                   [running]
>     |_______________________________________________________|
>
> All states may transition into FREED state:
> [pending] [scheduling] [scheduled] [running] [standby] -> [freed]
>
> A FREED terminal state coordinates with map-value
> deletion (bpf_task_work_cancel_and_free()).
>
> Scheduling itself is deferred via irq_work to keep the kfunc callable
> from NMI context.
>
> Lifetime is guarded with refcount_t + RCU Tasks Trace.
>
> Main components:
>  * struct bpf_task_work_context =E2=80=93 Metadata and state management p=
er task
> work.
>  * enum bpf_task_work_state =E2=80=93 A state machine to serialize work
>  scheduling and execution.
>  * bpf_task_work_schedule() =E2=80=93 The central helper that initiates
> scheduling.
>  * bpf_task_work_acquire_ctx() - Attempts to take ownership of the contex=
t,
>  pointed by passed struct bpf_task_work, allocates new context if none
>  exists yet.
>  * bpf_task_work_callback() =E2=80=93 Invoked when the actual task_work r=
uns.
>  * bpf_task_work_irq() =E2=80=93 An intermediate step (runs in softirq co=
ntext)
> to enqueue task work.
>  * bpf_task_work_cancel_and_free() =E2=80=93 Cleanup for deleted BPF map =
entries.
>
> Flow of successful task work scheduling
>  1) bpf_task_work_schedule_* is called from BPF code.
>  2) Transition state from STANDBY to PENDING, mark context as owned by
>  this task work scheduler
>  3) irq_work_queue() schedules bpf_task_work_irq().
>  4) Transition state from PENDING to SCHEDULING.
>  5) bpf_task_work_irq() attempts task_work_add(). If successful, state
>  transitions to SCHEDULED.
>  6) Task work calls bpf_task_work_callback(), which transition state to
>  RUNNING.
>  7) BPF callback is executed
>  8) Context is cleaned up, refcounts released, context state set back to
>  STANDBY.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> Reviewed-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

> [...]

