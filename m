Return-Path: <bpf+bounces-55266-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D7CA7B063
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 23:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 361811880812
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 21:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A47F1FF1A1;
	Thu,  3 Apr 2025 20:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OS2Df7Ja"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6097A1FECBA;
	Thu,  3 Apr 2025 20:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743712525; cv=none; b=NBoXhQkMW1zWsSs2qVT7wTW1pdAHsO1ocIUSli9D6VcHLf0PWXldggkcR1/U7HgsYqGRuf0jvi/o9hOBIaBHcWMSgyBbZqcckcvmzJv/4n82w7x1uolTNnKH/7/6xJyCmlJcWL5ZHfV5rHCpa1PA+XT2/T7RLw8Z9PrP+ewibQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743712525; c=relaxed/simple;
	bh=/Wr+De8aYTAPyPrxtzWeHutGqhqMA3Y8gKZr6gv9Nyk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PzLmIUzPraS4LkqtiY1DeirhXUIz+q2BDh7tnymMM0bsRWPWYTI6bZNLzG8/kRAbgjlH7DEBQisPjbtr/6h1ksb7jfIN/VcO07ivjrSd9m3Fj/nSFUjj4lxKpEQHYflALAXySXvTURDl0+66fRb3W5B8abOiKuHbWiQvQBz6B+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OS2Df7Ja; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43cebe06e9eso8640165e9.3;
        Thu, 03 Apr 2025 13:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743712521; x=1744317321; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Wr+De8aYTAPyPrxtzWeHutGqhqMA3Y8gKZr6gv9Nyk=;
        b=OS2Df7JajUg7XB3wpMMyYZWCYzFxK1TFTeew1CsOlefwdjQFc0vjiNXf3rUBjoVPQU
         jCi8J+nne1iADvo0TYwgKREbWRTI0a8RqyJu3D5lYV2UyEIM06VemIPsrkGVtxcRZ+JL
         b9YQ1ItC5oc9nkwjcq8f34Hq19ejKGWfsW4PUOjR78ks7F96454yQ9XxCNciRxSbY24R
         L8HfYZJ6w4acy5k7o1IZrqJNlyIgu5JQf2+eNmIeK/VNlu+xRoWKohQkaqgt3wa+FFwH
         d7SVKrsyhP2bC2KZDpMiCWrnb5Px7MgmFGfam/Y5lnHSAoTz+PNxkop5s81LBYrEWeIA
         i+8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743712521; x=1744317321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Wr+De8aYTAPyPrxtzWeHutGqhqMA3Y8gKZr6gv9Nyk=;
        b=IV/QVBVH5qdPbHMS2rDxv07XGU4cXyjmw8P5LyEftcEaerfCzxMj/+hKoCzbJW4Jl0
         JfC0pglHrtw5oc/FMs+HNW+5Ft4X3VCFTmILA2ZZ3CuzWUzVO0ed1IROeo66Wpd1oOO0
         IUEwSGTw3U6jVIhDphkccvdC6jCeRlavIgDe6FE7Zxc0MtZsZJQwkMXfRXIjUHlU591N
         hPBXFjtD2qZBBwgzEaqB0owVTrXb30DUVPFVwzQGiwWYxfh46u46wjIWpry/he7gU+ck
         t2jfdsgNL3K8OhpkPsJP+LmChcVSFc+QINxrDGPeVUPtEhc/rJcUZFvtBvTIaY+km4Ms
         wlfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuA+xTKaufsRtRInInPQ3zdlbuCO27xxmXQmawGqmQquwD17Fh292GvEiC/tDn2+Jkn3I=@vger.kernel.org, AJvYcCXxtVR7WFsKnEL+iJq98WF2iM18v02DS8k7QXCSB5KRJ7ENdLgiykxjt7olMNBybZ2R7x8t+FOd@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd0Tisb3U4oKxAVzwOVkbFcn5jPvFagpHSXoTSutEZ/5ddsllf
	deDYpEXHDE1JlhP0WSfNIdwRxPXruYi1KH6N9ITiRvcvliRNHOIC4jZJt5sXPq9+tCOmqWPSbAY
	cqsSs5Q3Nsz21DE+XiUal2WQMIsc=
X-Gm-Gg: ASbGncvxlFdnpKoWEbRKfWnl/zchN1ccvVPUBDjtblRzxtkmbbdhHEOenccPnxQnF3V
	WBuuLAApsvp4mXZEw7tyr9Dagp23qAp3VA2M9CJ8q/oUxjQ+Nh9K6zM+YHpFPHsUdQk1ePAtDxv
	XZgBdbKDdY2bxmCFQPDDhp5MjVp8ytWtzwvCcoe5nQmQ==
X-Google-Smtp-Source: AGHT+IEIo0arv2FrOFFQjtalHYTnun5hmCjMio+8gW+CtIMdtp5L+XkccqOdcnnjtpmS3LegJ67paXSeq1yD3j5e0/M=
X-Received: by 2002:a05:600c:1d86:b0:43d:934:ea97 with SMTP id
 5b1f17b1804b1-43ecfa35fd6mr3783355e9.27.1743712521511; Thu, 03 Apr 2025
 13:35:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250403083956.13946-1-justin.iurman@uliege.be>
 <Z-62MSCyMsqtMW1N@mini-arch> <cb0df409-ebbf-4970-b10c-4ea9f863ff00@uliege.be>
In-Reply-To: <cb0df409-ebbf-4970-b10c-4ea9f863ff00@uliege.be>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 3 Apr 2025 13:35:10 -0700
X-Gm-Features: ATxdqUFfG_KTUPwWMYOrHRjOO3sypxV6hn2k5bGj-_5jN1n54OV_NlNnc2Y-uVI
Message-ID: <CAADnVQLiM5MA3Xyrkqmubku6751ZPrDk6v-HmC1jnOaL47=t+g@mail.gmail.com>
Subject: Re: [PATCH net] net: lwtunnel: disable preemption when required
To: Justin Iurman <justin.iurman@uliege.be>, Sebastian Sewior <bigeasy@linutronix.de>
Cc: Stanislav Fomichev <stfomichev@gmail.com>, Network Development <netdev@vger.kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 3, 2025 at 12:08=E2=80=AFPM Justin Iurman <justin.iurman@uliege=
.be> wrote:
>
> On 4/3/25 18:24, Stanislav Fomichev wrote:
> > On 04/03, Justin Iurman wrote:
> >> In lwtunnel_{input|output|xmit}(), dev_xmit_recursion() may be called =
in
> >> preemptible scope for PREEMPT kernels. This patch disables preemption
> >> before calling dev_xmit_recursion(). Preemption is re-enabled only at
> >> the end, since we must ensure the same CPU is used for both
> >> dev_xmit_recursion_inc() and dev_xmit_recursion_dec() (and any other
> >> recursion levels in some cases) in order to maintain valid per-cpu
> >> counters.
> >
> > Dummy question: CONFIG_PREEMPT_RT uses current->net_xmit.recursion to
> > track the recursion. Any reason not to do it in the generic PREEMPT cas=
e?
>
> I'd say PREEMPT_RT is a different beast. IMO, softirqs can be
> preempted/migrated in RT kernels, which is not true for non-RT kernels.
> Maybe RT kernels could use __this_cpu_* instead of "current" though, but
> it would be less trivial. For example, see commit ecefbc09e8ee ("net:
> softnet_data: Make xmit per task.") on why it makes sense to use
> "current" in RT kernels. I guess the opposite as you suggest (i.e.,
> non-RT kernels using "current") would be technically possible, but there
> must be a reason it is defined the way it is... so probably incorrect or
> inefficient?

Stating the obvious...
Sebastian did a lot of work removing preempt_disable from the networking
stack.
We're certainly not adding them back.
This patch is no go.

