Return-Path: <bpf+bounces-67680-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C84FB47CDD
	for <lists+bpf@lfdr.de>; Sun,  7 Sep 2025 20:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 508193B4EE8
	for <lists+bpf@lfdr.de>; Sun,  7 Sep 2025 18:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF26B2868A2;
	Sun,  7 Sep 2025 18:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sag5Aaw/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF30E552;
	Sun,  7 Sep 2025 18:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757269844; cv=none; b=CRNIleZD8fCdAV18fnWfxuBXxcntB8drx4Gxdia7G89NeD4YuRz6QYF5n9zGIM4I5k8mVS0BGqF/Xut7RIsT549kRMs3vy6NQfGMPQV4WuPUkZvfIh/2nvTBcxcjwR4RG9FKILMsGXDNB90ayr6UoD4JeZrAXeFnVm1vWu2ygeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757269844; c=relaxed/simple;
	bh=Wbjo9bYsJfKZ1AIQi+fpgDdYDDPkKY3z+a/9TuVEM94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k+BNhQBLD8mAOjw/phQeo0zaTv13U0hWRvxJqoI5GeMpJSIV+j1RCXdMP0DfKCCRVqmOfCUntfAJL4kx231lQmz8LXMz8QxHhRZX1VQQ6M49O2qBR7P1Pg5UMEEtVB+mnfpiTV60QlfBO+YmmEGw6mAwvlnI3awBHy/uCSBeP1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sag5Aaw/; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45de3c2253eso3273185e9.1;
        Sun, 07 Sep 2025 11:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757269841; x=1757874641; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tGsc3oCIjnwBLHYjUtrXhIo0J84Fy5O5evDQ7QUWjGM=;
        b=Sag5Aaw/tUzCEGtTx7JrKp+cu9ORdMe4NaFzfp0eJuXo3BzYWswCn6CoCsfLLAmEoH
         X1rvCqCJITC3fB9U+K7Wb6QBRaYYVnxdDO2zwQ6pg0+JyhDiP3xkyS/h1e4/8wXIopl6
         MMj2PD+d1RrWEqvNFPoT9Xz1SspY19/lpSsnn/RKtOj65vmIMmSQjJCiH78P7hdc8YoS
         raLpWU/wH005/5Udu4CSI5rc+ybsg99hPW6wJHBomaV3B8whmw+NjjZVnD5qy23LzLZ5
         1WwuswVwuzI4rEZZ7qqfxypfL7oDqbk46m9vNUiIsLWP9kSQ0wTQTsfWb9xDxk79kFMg
         0h4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757269841; x=1757874641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tGsc3oCIjnwBLHYjUtrXhIo0J84Fy5O5evDQ7QUWjGM=;
        b=vBsmDXK1dapg3JcZ5NXGpNbsT81XVVMzVIivUh3xfKwaDSqCbcV3RTEmrF80sTCxVj
         5UIT/f0F/GGmseBuMDp+9GAi/fbvM1SYy97pRxlZjMlvKjOFjvJAiRq6VaBSLqdq59xq
         seQ4DG+wMNiZuCebHNshAChWb9PH825aQ99zbk26ZW41nDr3fn0ZLvuvZ2Ub5PUSVBRT
         wO8zi/zw7/CcMz3pwfZdRh9a9seE0uCszYezXShqTBFgdPfazgqKuLGqGG7BljtmLcd0
         frmadndtdTHk8FVCi5CpT2grr2cYR6osrM6AEcf4V3gM1QZToIJbMR7fLXqhgxS33aeE
         ZPcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpF2VhS0u/ag0IOdj8WGoQ3H/nLHS43MwWrGBMTYk8Pc6YVNPZ/9glmjS0nSLqTubBezA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6WYUdDK9/eHdLues/Z1QTPyRkYymihEsixcdCIE/0d1p2vfqx
	SfrwsIOEceREKFkKK6hytwM5yRyLp7oxKdgXyq2Cmgl+S0FPqTMdS6Y/599418No17UGcM1XMXP
	XFb1rZRPYWsZICF0VwVR4FrO+KXcbv7Y=
X-Gm-Gg: ASbGnctym7SyJ9L6sktSyN0a8ZYs1iqYl0VQyQAHks9t7lZxol4GM85UpLBtE8DbXVf
	0VWsR/OkgbY7M7BT8E5o8MQRDSDbT5p7RWX+pB59hNwZxQc7bs3FP/4tXVZZnEcHiFRt9+4Y8Bi
	Y9Z42OhhTXHn3wIDhW1VpsVwCx7pAtXcbJf+VB0NniaxPW62DEcEboCNRNnEjoWDbEPo74LhDDg
	wW7P3jmb9My8dGVm8wwDiSTCwMM8fS9TskrblithHH4IeU=
X-Google-Smtp-Source: AGHT+IFXAagIa/7sbAYIjqVKbFstJMAbjG5sgHYEO5hF9tmgYl6F+6743MpB6t6ez3zAVJU20gEC3Ysw95xMr1aHzQs=
X-Received: by 2002:a05:6000:2c0c:b0:3e7:468e:9327 with SMTP id
 ffacd0b85a97d-3e7468e96a8mr1565394f8f.2.1757269840482; Sun, 07 Sep 2025
 11:30:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905085309.94596-1-marco.crivellari@suse.com>
In-Reply-To: <20250905085309.94596-1-marco.crivellari@suse.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 7 Sep 2025 11:30:29 -0700
X-Gm-Features: AS18NWA9-XPOv5wZ0Q3KL3P9V1EV6O1dPhmQjLT2EmYXX4tCL7MpWxwR1ShcXlo
Message-ID: <CAADnVQJWCMSbjgV2T+FRLWZ4snjW95arkzNhKKZF6QPcMFDXQA@mail.gmail.com>
Subject: Re: [PATCH 0/3] bpf: replace wq users and add WQ_PERCPU to
 alloc_workqueue() users
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 1:53=E2=80=AFAM Marco Crivellari
<marco.crivellari@suse.com> wrote:
>
> =3D=3D=3D Plan and future plans =3D=3D=3D
>
> This patchset is the first stone on a refactoring needed in order to
> address the points aforementioned; it will have a positive impact also
> on the cpu isolation, in the long term, moving away percpu workqueue in
> favor to an unbound model.
>
> These are the main steps:
> 1)  API refactoring (that this patch is introducing)
>     -   Make more clear and uniform the system wq names, both per-cpu and
>         unbound. This to avoid any possible confusion on what should be
>         used.
>
>     -   Introduction of WQ_PERCPU: this flag is the complement of WQ_UNBO=
UND,
>         introduced in this patchset and used on all the callers that are =
not
>         currently using WQ_UNBOUND.
>
>         WQ_UNBOUND will be removed in a future release cycle.
>
>         Most users don't need to be per-cpu, because they don't have
>         locality requirements, because of that, a next future step will b=
e
>         make "unbound" the default behavior.
>
> 2)  Check who really needs to be per-cpu
>     -   Remove the WQ_PERCPU flag when is not strictly required.
>
> 3)  Add a new API (prefer local cpu)
>     -   There are users that don't require a local execution, like mentio=
ned
>         above; despite that, local execution yeld to performance gain.
>
>         This new API will prefer the local execution, without requiring i=
t.
>
> =3D=3D=3D Introduced Changes by this series =3D=3D=3D
>
> 1) [P 1-2] Replace use of system_wq and system_unbound_wq
>
>         system_wq is a per-CPU workqueue, but his name is not clear.
>         system_unbound_wq is to be used when locality is not required.
>
>         Because of that, system_wq has been renamed in system_percpu_wq, =
and
>         system_unbound_wq has been renamed in system_dfl_wq.
>
> 2) [P 3] add WQ_PERCPU to remaining alloc_workqueue() users
>
>         Every alloc_workqueue() caller should use one among WQ_PERCPU or
>         WQ_UNBOUND. This is actually enforced warning if both or none of =
them
>         are present at the same time.
>
>         WQ_UNBOUND will be removed in a next release cycle.
>
> =3D=3D=3D For Maintainers =3D=3D=3D
>
> There are prerequisites for this series, already merged in the master bra=
nch.

Everything makes sense.

Tejun,
please ack this set just to make sure it's all going as planned.

