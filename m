Return-Path: <bpf+bounces-44387-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6DA19C25E4
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 20:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DBC81F21B3F
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 19:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3131BD9E2;
	Fri,  8 Nov 2024 19:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I4wGosdV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F4B1990B3
	for <bpf@vger.kernel.org>; Fri,  8 Nov 2024 19:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731095543; cv=none; b=pvY6PhOHSyTJjDRhDMaaWWOWrsI164Hs5R07CDhQfSxMhb+5UryyhVAZcW55Hos/llNUfRieNTLj0mTJ0SzKBSa4tguAvEgRVVBOriVW0C1P9dIn4AMXGq2P7u3Y21SQO9JZcNzmTD9NTF4uim1bdAXfKD2/50d/06//gScPpqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731095543; c=relaxed/simple;
	bh=6WYcPhEKDnTUXdOWGfaZmD2J/G3MDZFzrjIfPevK7p4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YkDMHvlopPYIBvyUPLxnlPbVHgYE/P3D6bPV8JZEXtslUBBKavZ12THcJ4McEGCBdeziX0oH1Q6VqxINikEJl92xSq1WQ8okj82pKUKWV1yBMXhUkUht6MeDQTmgAa3HPsEyNaGLgFpEnTTKlgJg4ZJvcbHD+RtwkvAPoJ3iNkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I4wGosdV; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43159c9f617so19957875e9.2
        for <bpf@vger.kernel.org>; Fri, 08 Nov 2024 11:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731095539; x=1731700339; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6WYcPhEKDnTUXdOWGfaZmD2J/G3MDZFzrjIfPevK7p4=;
        b=I4wGosdVs6WzPo9lHC72+pnSpeVN/yO/8kOmsDb3rL0to7w2vCVEYmEtO4vfugsoc1
         8bJhyBGf70YUUdDmmudxVhGj6tfLZyshConwP5PKu5iDUZI39s5H97iaLlbeL+XaBlv3
         EXCqVs4H22WRhZ/0ERVuyU/Pxd9gg4MQcdgjew7EkLICcje28G6Ua0GcbjomK4UNDs7z
         O1N5lHt2X+UASCvDJ3rj9eH4S50bTchZ1K69EJZuX9XX8K3vdZYk4ToVAxG8peujewG3
         6m3K8H60i2pTpXmdvR7VPbai3YAJDQu5OVVUeZsuLTsIbPwLyoG1aq3reJ1o+KGEeJXB
         m7XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731095539; x=1731700339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6WYcPhEKDnTUXdOWGfaZmD2J/G3MDZFzrjIfPevK7p4=;
        b=jWhJ5f6j+abuUoLEiLxOfFWdaQlPO3ADO8Xac0zXxAvynKVMlIIWfLIBOvI3/HC3uc
         Cw/SDYrQpq4lrddNNdVij56KccedzsZw1A0esIewjpSHnic21PrMsk0GUlFXy6ZHtlyy
         LwhSl1RHoQTYf9rMSMN04ubkxLhc0ShjlTHjmvPXY48JZ5JXYYx1ZNRieeka4aO2PALW
         8+AIN7hc1czCgVr7R/60WHm2un9hAMPlgK+lT8syDnHHFIbUGark5nOU6DHePpVH/v8o
         Ny7VWwDuTZhi2G0NgaX6Q56T/7+N+Rg+4HRQuHx2eXY5TBUQw9kjyUvKjvXhVoJl0pZv
         og1Q==
X-Forwarded-Encrypted: i=1; AJvYcCW2wdx6DQkasE69n+EDE0sfD/hC0umVQAALy6sT/7x9fAwenr479YSEp/vX0Eth/cXQxTI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1nMFMFI3cNhS6xmPAMRW/g61R7ar9CA9/SC1fc2yXENr0/MuF
	vYB7iYneg9bDnjNVupSMPGbxl+9PIy26cv+d/rAQX14Ru2zb3Ux448GUTB87vDzulZkE5z+Tpjv
	S6xXfkC2+VWFn6T/HRivXEhSolms=
X-Google-Smtp-Source: AGHT+IHd8720rMKZASlYkKEfWoO7c/He//JMJbCaJbzgS/dmbDK0bbjr9R5ndEiS3AOhwJRrNpdXuvuQ1rBzEDvdybM=
X-Received: by 2002:a05:600c:1c15:b0:42c:a580:71cf with SMTP id
 5b1f17b1804b1-432b751e27cmr33810965e9.30.1731095539313; Fri, 08 Nov 2024
 11:52:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106063542.357743-1-houtao@huaweicloud.com>
 <20241106084527.4gPrMnHt@linutronix.de> <892b3592-0896-7634-ed44-9ba610242eb3@huaweicloud.com>
In-Reply-To: <892b3592-0896-7634-ed44-9ba610242eb3@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 8 Nov 2024 11:52:07 -0800
Message-ID: <CAADnVQLPp2bGJQ_A4WS0sYM97xJFkQocK7t5pPN-mDVM=ZY4=A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/3] Fix lockdep warning for htab of map
To: Hou Tao <houtao@huaweicloud.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, bpf <bpf@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Hou Tao <houtao1@huawei.com>, 
	Xu Kuohai <xukuohai@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 1:49=E2=80=AFAM Hou Tao <houtao@huaweicloud.com> wro=
te:
>
> Hi,
>
> On 11/6/2024 4:45 PM, Sebastian Andrzej Siewior wrote:
> > On 2024-11-06 14:35:39 [+0800], Hou Tao wrote:
> >> From: Hou Tao <houtao1@huawei.com>
> >>
> >> Hi,
> > Hi Hou,
> >
> >> The patch set fixes a lockdep warning for htab of map. The
> >> warning is found when running test_maps. The warning occurs when
> >> htab_put_fd_value() attempts to acquire map_idr_lock to free the map i=
d
> >> of the inner map while already holding the bucket lock (raw_spinlock_t=
).
> >>
> >> The fix moves the invocation of free_htab_elem() after
> >> htab_unlock_bucket() and adds a test case to verify the solution. Plea=
se
> >> see the individual patches for details. Comments are always welcome.

The fix makes sense.
I manually resolved merge conflict and applied.

> > Thank you.
> >
> > Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> >
> > I've seen that you didn't move check_and_free_fields() out of the bucke=
t
> > locked section. Type BPF_TIMER does hrtimer_cancel() if the timer
> > happens to run on a remote CPU. On PREEMPT_RT this will acquire a
> > sleeping lock which is problematic due to the raw_spinlock_t.
> > Would it be okay, to cleanup the timer unconditionally via the
> > workqueue?
>
> Yes. The patch set still invokes check_and_free_fields() under the
> bucket lock when updating an existing element in a pre-allocated htab. I
> missed the hrtimer case. For the sleeping lock, you mean the
> cpu_base->softirq_expiry_lock in hrtimer_cancel_waiting_running(), right
> ? Instead of cancelling the timer in workqueue, maybe we could save the
> old value temporarily in the bucket lock, and try to free it outside of
> the bucket lock or disabling the extra_elems logic temporarily for the
> case ?

We definitely need to avoid spamming wq when cancelling timers.
wq may not be able to handle the volume.
Moving it outside of bucket lock is certainly better.

