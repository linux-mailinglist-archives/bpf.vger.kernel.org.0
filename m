Return-Path: <bpf+bounces-68442-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4BAB586F6
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 23:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CDA61B25140
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 21:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C8F2C0F87;
	Mon, 15 Sep 2025 21:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LC4SiOp+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D863A29E114
	for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 21:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757973157; cv=none; b=eq9CPUeyctYDZTP3MyC1A1gIqT3jAsz24NO7StrQHUbJJXIFfsvB5NdGcLz3zDw4EbW6KwXlLYx0PU2rzuzgb/mKc1vPyWNund5ILKUnd3isJx72Vj4U+t7PIIVX5Nce3m444NOoUT1W0CoohAIKZKjb26cHdSOMWEgqduky5Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757973157; c=relaxed/simple;
	bh=OVYq/zTK/MJo8p+XGKg8GEVah/o0sf/Uyioik6cc99o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=edlO4AwmEoYh/RbV700fxXRNeTOTWxd+Ry71hjriUHID5k7IcX/kirw8R78EJn1ZB7Yb6fPAnNTQ6avadNEZeY2HQYsgs2NED3Y29cMxtXIDP1ATeKbnQyorpUoopvb2XEEpQ4vCg16Q4z6ijjnDh80rg2yhzD4LMu2Gdtlr8FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LC4SiOp+; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-32e64d54508so1444508a91.0
        for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 14:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757973155; x=1758577955; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Bmy68WaJMY2CpUy/xkhRt0jb6OfzRDq6Ee0t3we2+xU=;
        b=LC4SiOp+EKf8t3B/BNLm2WEPNBVy2xzd6qx9oVrWhBME02PrghXdYaPl1Ndj5NvFFj
         pbM+d10+u2YP3JVFvxCmeGktIt9AzwffJbFFaw/jB3OQS8tftmcPs7V1Kp0rFSkHCRYX
         cKoDkbSv/hiMioopHjyFWG9UkbIupQSA2QONWepcYDB1WjxX7ED52HxQXbpsdvsNGgmd
         66xTQ7nKtHyH6nVG1bRXSdZNN1X51SuAqqGAf4k2ddbeZCotgT5k3zBFbZ+llhZPXLX8
         Ho5ju77J4j9ti1VVw/Iv1NgaH4hqTT66PnrMrBXv72SxqG/91jQDCp+gDY5vyQNBQ+hS
         a4OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757973155; x=1758577955;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bmy68WaJMY2CpUy/xkhRt0jb6OfzRDq6Ee0t3we2+xU=;
        b=iLV4g0lYTIY0Pqc5jIOdBv3A9mV6YPzuCHfLQt1KALJEcPr1ez16gfDX7gjXeJDKef
         izrK3ITWrSYdMpMm4PcqfaJkN27/fgInfvN0OgEu1ZTXGqCm4r5aJCID9a9EROrdnDxq
         +Wp9JVQF22LMp/n01QVCGQN7CtXXClNT6xzx0MZ9Sa2Mzxw3RJs1J5TSGtpLlF1Q7ks1
         3TZqsgUWe4hwz6z2SbLs7hf+KHw5wz+YCWV35sO/X5e1gW+PRnUu2yo0Z5dHUk3WDAem
         8mbieiswGFf+IQ1dJADwRwm0o02RzL6rgotxrLsY/Aa2GhdBSbBobOXc2xnJxi4p8SDh
         KmoA==
X-Forwarded-Encrypted: i=1; AJvYcCVVFQljNmS/iiX2C/D5sy/yMB0t9lSEgOlXEtojDyPIQwrVwZ9uBeHN2uHO1GMq1PplRQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbWIOaHRIIkU0we3BFbJrkTmUXjotymLXtsRwzdYxoQ1dKFVZe
	v9FE0h1sxYd68nZFYw4CMChvRiRRiJE069kTnDdoVU3D4RtSnRX2pg5N
X-Gm-Gg: ASbGncv96r6KNAGk4z8qYoBe7GvVvG8/kiehqT8r2r+y0lH4QLXmrWImDk1TgkgHSno
	tpz1WX2J+lOu2RIpOYoQQ0U9p/c8yEVBg2n8ifzQ7sj5j+rNfl2t3HsvpkzBr7SqC6RTSq150/b
	LHobRi+tpIA3rL5d8VhO0xrVWFt5URWIQN1Lw7wXHqE7XQIa5tiX7VN/D/S7wI0TlIv+hNLStbG
	r4h50ZCk9AunZqE66nNIaCTkGBwPoZrrRq2AbPDUn6zvioHLVHJdd4B41es7JSrn/T93Bd+BnUq
	R84EQ3O1TnT+vVjLMneqkP73Pfe60g9baDOhXQnbeoA24aEe+NHhwbG60xtElpp6mIuHPP6M1y7
	GsrqhyxdKHnUwpNk+vK2Ywl8dJt1qlLYAS8+2zJIgHzvRBw6Zo833xskP5ahubekkaHdMiw==
X-Google-Smtp-Source: AGHT+IGMW8g7mDbNO48Q/JBm6D3nvYuzVkF/3neR9WrAB0m+ETAtJwPiBFV+IoWi45kF8jb1sTlKmQ==
X-Received: by 2002:a17:90b:2dc7:b0:32b:9506:1780 with SMTP id 98e67ed59e1d1-32de4eb880dmr15282655a91.9.1757973155044;
        Mon, 15 Sep 2025 14:52:35 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:1da5:13e3:3878:69c5? ([2620:10d:c090:500::4:283f])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54a387cc5bsm12470037a12.27.2025.09.15.14.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 14:52:34 -0700 (PDT)
Message-ID: <ff4af621e5468144eb696169574e59fd24eb356c.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 7/8] bpf: task work scheduling kfuncs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Date: Mon, 15 Sep 2025 14:52:33 -0700
In-Reply-To: <20250915201820.248977-8-mykyta.yatsenko5@gmail.com>
References: <20250915201820.248977-1-mykyta.yatsenko5@gmail.com>
	 <20250915201820.248977-8-mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-09-15 at 21:18 +0100, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
>=20
> Implementation of the new bpf_task_work_schedule kfuncs, that let a BPF
> program schedule task_work callbacks for a target task:
>  * bpf_task_work_schedule_signal() - schedules with TWA_SIGNAL
>  * bpf_task_work_schedule_resume() - schedules with TWA_RESUME
>=20
> Each map value should embed a struct bpf_task_work, which the kernel
> side pairs with struct bpf_task_work_kern, containing a pointer to
> struct bpf_task_work_ctx, that maintains metadata relevant for the
> concrete callback scheduling.
>=20
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
>=20
> All states may transition into FREED state:
> [pending] [scheduling] [scheduled] [running] [standby] -> [freed]
>=20
> A FREED terminal state coordinates with map-value
> deletion (bpf_task_work_cancel_and_free()).
>=20
> Scheduling itself is deferred via irq_work to keep the kfunc callable
> from NMI context.
>=20
> Lifetime is guarded with refcount_t + RCU Tasks Trace.
>=20
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
>=20
> Flow of successful task work scheduling
>  1) bpf_task_work_schedule_* is called from BPF code.
>  2) Transition state from STANDBY to PENDING, mark context as owned by
>  this task work scheduler
>  3) irq_work_queue() schedules bpf_task_work_irq().
>  4) Transition state from PENDING to SCHEDULING.

Nit: having a comment explaining that this transition is a noop at the
     moment would have been useful, imo.

>  5) bpf_task_work_irq() attempts task_work_add(). If successful, state
>  transitions to SCHEDULED.
>  6) Task work calls bpf_task_work_callback(), which transition state to
>  RUNNING.
>  7) BPF callback is executed
>  8) Context is cleaned up, refcounts released, context state set back to
>  STANDBY.
>=20
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> Reviewed-by: Andrii Nakryiko <andrii@kernel.org>
> ---

fwiw, the implementation looks good to me.

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

