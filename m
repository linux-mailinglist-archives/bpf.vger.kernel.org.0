Return-Path: <bpf+bounces-14626-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9DC7E7250
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 20:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77D211F21988
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 19:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7CDE36AFB;
	Thu,  9 Nov 2023 19:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hlzJzuz2"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DD136AF6
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 19:29:29 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9C93ABA
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 11:29:28 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40859c466efso8664205e9.3
        for <bpf@vger.kernel.org>; Thu, 09 Nov 2023 11:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699558167; x=1700162967; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ttr7Vp9LTH2JYKKc505OAI3ZAivY5iJ1Ddj7oxgjoKk=;
        b=hlzJzuz2E77LOPnyunydkwDHF1/eVriBw8mSKoJP3lURbQe5ZL2d4ro/zf97yPDDKF
         QUSfrANTC0s4zqz5/MXNtmpxJnsKzFaoOsGL2kgZPAZKKEwrkhpIfT3TrDS2hWspfG1n
         xFLpo8Gh5xaDSzhus2rxCeoPYK8zpTYMdaK7Mvgv3UrAI2YbrHbSH4z/Ab6Tp7ncekrq
         7gi2AIpRgZ+oSwos3f1T+00uRLoiL4U4DzIscUlMEeraTnI9mSntvvInFUXa3ekMu1Mn
         lFhB3MfWxjlEM9V/SzqdH5+EP+wf6ZsFp+HJ6/JFIJ8ME6dYElOqRwtlBWOXLhzE8jWf
         mBTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699558167; x=1700162967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ttr7Vp9LTH2JYKKc505OAI3ZAivY5iJ1Ddj7oxgjoKk=;
        b=QUJZtIDAR/rw22kT2B14df6J+X6VHDT5RCFe7v/bUU0YieyMNV4s47hL1NMFU/gWda
         sQToZ64eE9Mo+647gjrmGJcp7cM4FHRhJ83Esdd++6p3x9wWm540fIDu60cn6XfQxv0l
         144sSEPtXprf937lpyLmiiVwf9ZNlZcE1XuhJ6k2WjIoS8obth8Jc6Fs+HJyy7RdpUX/
         l3w/WmRs+Mnzt3e6Iq8MyIRJtJOxxF2WW1RTSRYZxtL3b+JfmBSlZ9/y1mlv0lW12tHh
         XupDGuT4/v3iV4ZFsXGw3GKERkqxVmKbsjURmc2vMTiq2tdBzGKW/XrBquqWha8i3vPM
         EWyQ==
X-Gm-Message-State: AOJu0YwH34F0AyI1e7UIluVdBT72/qc6NSR6w4cOyn5spPBEue/Wyas+
	x7Y2En7AxXfUqfoxmE5Wy++GpzpBX+p5z2jrnJ8=
X-Google-Smtp-Source: AGHT+IGOQ2FOEAzR1+Mt1XRidFzeP27C+J2aeZ8wqpKpsCuBSUnlqf9l9SBx2O+QkGi0QvyHotWpERBB2MpBHiFuEIs=
X-Received: by 2002:a05:6000:1882:b0:32d:b2cf:8ccd with SMTP id
 a2-20020a056000188200b0032db2cf8ccdmr5395841wri.47.1699558166920; Thu, 09 Nov
 2023 11:29:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231031050324.1107444-1-andrii@kernel.org> <20231031050324.1107444-2-andrii@kernel.org>
 <43f0d9f7219b74bfaff14b6496902f1056847de7.camel@gmail.com>
 <CAADnVQL6_o9z3z1=8o7qGNzAD8vKMZ+OetcYYy-1huxGfCJToA@mail.gmail.com> <CAEf4BzaA12xjXm8KZNB1mkVDOTtVDQDDWF4nYQtQ2qRYoTip3A@mail.gmail.com>
In-Reply-To: <CAEf4BzaA12xjXm8KZNB1mkVDOTtVDQDDWF4nYQtQ2qRYoTip3A@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 9 Nov 2023 11:29:15 -0800
Message-ID: <CAADnVQLGn4vRuZLqTm_t_9ff3t=Hsugr0j47YLThhPsnpNrs_Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/7] bpf: use common jump (instruction) history
 across all states
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 9, 2023 at 9:28=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
>
> If we ever break DFS property, we can easily change this. Or we can
> even have a hybrid: as long as traversal preserves DFS property, we
> use global shared history, but we can also optionally clone and have
> our own history if necessary. It's a matter of adding optional
> potentially NULL pointer to "local history". All this is very nicely
> hidden away from "normal" code.

If we can "easily change this" then let's make it last and optional patch.
So we can revert in the future when we need to take non-DFS path.

> But again, let's look at data first. I'll get back with numbers soon.

Sure. I think memory increase due to more tracking is ok.
I suspect it won't cause 2x increase. Likely few %.
The last time I checked the main memory hog is states stashed for pruning.

