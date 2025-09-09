Return-Path: <bpf+bounces-67842-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2182B4A086
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 06:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9711B3A919D
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 04:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86AF2DFA38;
	Tue,  9 Sep 2025 04:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b2hgDOnl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99CD2773DC
	for <bpf@vger.kernel.org>; Tue,  9 Sep 2025 04:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757391307; cv=none; b=DXf7kDqdfIPPmMqhYpaZvBSvJ2yJuWBeRvc0rBzOndcjt0PNNj4XLidAsFuggwPy/xcmAqWczWuPT7cym8V+tnV+UJIvbNWKVFbe7uyfkRxgTMdj4b5ZzFHksoYla1JEdI64Am+jCkesOHlIZ44PQExxkRvzX72qct4d+xpNVJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757391307; c=relaxed/simple;
	bh=T2tOjaNsv0sxCt0MzK4+J0G0zThMDBkt9P5jwpy/gAI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HVDRpyRPaq760Oppa+O5LdONyAamBuvdECkHfOxaeF9TTr94hzHdR5VCp4yyCYWxCFFZjAwaOYjc6GmYdHeUduDOqTBHs7X/WggP0mblO+Lkb1LNc5xgcnQ8b1pZ1JX7aNc2fdhb3efQJv4vQFNMPEoNSvs25ognG8HjYGKOC+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b2hgDOnl; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so4594062b3a.1
        for <bpf@vger.kernel.org>; Mon, 08 Sep 2025 21:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757391304; x=1757996104; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/bGVOhMok1Qcr9HQrTMnEab/uTJVWxFpIW1I/ejMUXM=;
        b=b2hgDOnljRR/fsFb/dN9s+DQD376CkVE8DUmIyCw35Pj5UbYcN4Tyx3/RbZDxyRW27
         GOcDpioePQY2CgIF+9jm6554cBYydMUZseBC9J4KQhOcztOOB7Kt/2KdcGXLsWPYL3nA
         fS5dA2nvR9xel3bqPTB0llsK79DyCX/3fm60p5jmPPhhH+1dsx8Bw1UFQVdmfxNAtxVz
         1cu/LKd6mIE+Q481MQ/tVzVN0pB++vaxwgDHhPU9m13rhBIvqZj81a3pF7iXIskeZGVM
         ZVVXDbMuESwlosVUXavXmIrb+u5day1JiYyAIV7n46vd6OWgfM3K9ysJv2F6yFzkamWZ
         4h+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757391304; x=1757996104;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/bGVOhMok1Qcr9HQrTMnEab/uTJVWxFpIW1I/ejMUXM=;
        b=oB2miIgGkaJBPxLOUvP5tZEe2Nxe5x7lpml4ECfzEfj2y1tnR2W24VmquhEYXR/ojb
         w6iTdEVaaKX8PfwRg+J4fvmDmcjFrIJO1NmByWxw5h4r29uKxKJJoFWrEd/X2TikbaPY
         lZCCWm4bOvWKBJVf5mL/OMkBiXBdLjCVQxDaV4Tr5hjRKjlO5kT2MEB/pjIONzHkuGWV
         Gtjb1xz/dXIrh9iC7790vRaBKNZ0C9QaKvMGmiLvdIXw8wRu8LPC8dBybgLaP60eab35
         RVr2CTPIVC4KjaX7ihVz8k/m4gLWPTAVvNTw5YcPr58o6L1EiJxi4P9+S7InjPUhPCi6
         lxZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlsy+rvy2sB+WqAImaajB/m3wCGnxCOYWUImSn8VVZWeNnBOj9gM7rKYeNAjp0PhBECzY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8f1d8/ziGwRUqwLPOc3We4V2Jb8MO9zl2PwlF82d4Y8yPiqR8
	mGkDw6NNe7H3ZGsq05xg+dAvRZrEz60kauWeqZ+Rq1kOD77C+t3EflnC
X-Gm-Gg: ASbGncv1z2H26UHmZF0BzChjRrS4VHfHNpQoBPo5Pnr8VPNBTq4u8aR4yttoX124sAy
	9lx7h4T3A1/DZdnMmzlY3RRwXvSJZpHy8UKD1AW344S3XtoNZHi/dX7aepikqnxRG9Ql0R8uZ0K
	VitxDlERsucl3NHTxoV7AQdsB9VrrvSfS0oeoTWCBn36r+uAombnsLD5a6kklb0S88L7UVCuS4B
	TYHrBu/hp1mFcPN42AfILk0N6anpYVVr9HLHMD5yUytX0EC0Eu/0M0yjG+d21235LGxYMVbeDDM
	4KvhI33kixBNnKkY4z7jyq6A2+k0hcgWwO5yK7JkevE/MBOMTapEGk2CUdd/31dYYM5+ugKheYw
	5Yvdcc6RV2GDz6Xa6ji8TZjZNYSGz
X-Google-Smtp-Source: AGHT+IHwwfOxOCKOMrAOT37p7UPhYv8mtFtvJZZKGS5UvAbPjYCHyGXA3MHJeYUVXp9E2COcEOk4VA==
X-Received: by 2002:a05:6a21:3396:b0:247:55a7:695a with SMTP id adf61e73a8af0-2537be015b4mr14796111637.15.1757391304179;
        Mon, 08 Sep 2025 21:15:04 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd28ade38sm26996021a12.34.2025.09.08.21.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 21:15:03 -0700 (PDT)
Message-ID: <890c29d3e9c7bf8f5ca42f8078e7b427786b293e.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 6/7] bpf: task work scheduling kfuncs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com, memxor@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
Date: Mon, 08 Sep 2025 21:15:00 -0700
In-Reply-To: <CAEf4BzbVbCMiTKC8Zz96W16tKCU2cfiM2ULAA7B2ofb0hRZ6sw@mail.gmail.com>
References: <20250905164508.1489482-1-mykyta.yatsenko5@gmail.com>
	 <20250905164508.1489482-7-mykyta.yatsenko5@gmail.com>
	 <aa9dcf55f1ed26c140f83fdde8312304efb80099.camel@gmail.com>
	 <4330e66c-59c0-4d1f-8401-de13b54342e8@gmail.com>
	 <b727f3872d51c2b8cc622fb01cdc864a3336b9d8.camel@gmail.com>
	 <CAEf4BzbVbCMiTKC8Zz96W16tKCU2cfiM2ULAA7B2ofb0hRZ6sw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-09-08 at 23:42 -0400, Andrii Nakryiko wrote:
> On Mon, Sep 8, 2025 at 1:39=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
> >=20
> > On Mon, 2025-09-08 at 14:13 +0100, Mykyta Yatsenko wrote:
> >=20
> > [...]
> >=20
> > > > > +static void bpf_task_work_irq(struct irq_work *irq_work)
> > > > > +{
> > > > > + struct bpf_task_work_ctx *ctx =3D container_of(irq_work, struct=
 bpf_task_work_ctx, irq_work);
> > > > > + enum bpf_task_work_state state;
> > > > > + int err;
> > > > > +
> > > > > + guard(rcu_tasks_trace)();
> > > > > +
> > > > > + if (cmpxchg(&ctx->state, BPF_TW_PENDING, BPF_TW_SCHEDULING) !=
=3D BPF_TW_PENDING) {
> > > > > +         bpf_task_work_ctx_put(ctx);
> > > > > +         return;
> > > > > + }
> > > > Why are separate PENDING and SCHEDULING states needed?
> > > > Both indicate that the task had not been yet but is ready to be
> > > > submitted to task_work_add(). So, on a first glance it seems that
> > > > merging the two won't change the behaviour, what do I miss?
> >=20
> > > Yes, this is right, we may drop SCHEDULING state, it does not change =
any
> > > behavior compared to PENDING.
> > > The state check before task_work_add is needed anyway, so we won't
> > > remove much code here.
> > > I kept it just to be more consistent: with every state check we also
> > > transition state machine forward.
> >=20
> > Why is state check before task_work_add() mandatory?
> > You check for FREED in both branches of task_work_add(),
> > so there seem to be no issues with leaking ctx.
>=20
> Not really mandatory, but I think it is good to avoid even attempting
> to schedule task_work if the map element was already deleted?
> Technically, even that last FREED check in bpf_task_work_irq is not
> strictly necessary, we could have always let task_work callback
> execute and bail all the way there, but that seems too extreme (and
> task_work can be delayed by a lot for some special task states, I
> think).
>
> Also, keep in mind, this same state machine will be used for timers
> and wqs (at least we should try), and so, in general, being diligent
> about not doing doomed-to-be-failed-or-cancelled work is a good
> property.

Ack, thank you for explaining.

[...]

