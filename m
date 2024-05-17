Return-Path: <bpf+bounces-29892-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C9F8C7F58
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 02:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3FB71C215D7
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 00:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A568811;
	Fri, 17 May 2024 00:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OOV7SulO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709DB622;
	Fri, 17 May 2024 00:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715907294; cv=none; b=k6X4ROvT9ziMKwrZ2PDUgwrd2T0gRN2iyStZbPs3k25nV2Q4/ukJJXGvKi8E4SAWu81bGnOhatlFk8Fz+GuBCCd1QwXZt5E2W8Ne0NxWM4CJjRVnNu35aJLDkOM71sDt+h7MNzukpKlkkmXahViB7UHiCicDI+dAKshlS+a7x2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715907294; c=relaxed/simple;
	bh=UAIcd30cXHefmQT2SQNuiEm9engN/e9rnfU4XOL1Efs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xt8ey4UOE39hD6Vodp8j8QXIzXRO2GPm408/PMryBtSg9/61R5HsiRCrzc0sCPlCxWbWrpsYHufDD0iuHkK7Hc957ttJW367F6PKlMsWwfwj8E1SnbcjeqFhvQpEs7jl5wMtVoMhaLcEX5N0Qx0n+y3KouV4FZt8+SKpqhH5TR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OOV7SulO; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-61e0c1ec7e2so84580787b3.0;
        Thu, 16 May 2024 17:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715907292; x=1716512092; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=94+V3BHkFRnVmTbioW6W0jCvkmP7uhYCcSgy2G+MKUs=;
        b=OOV7SulOwnClvMFgl01p9+LKfq1KXkLI1+KRczELzzxO07eT7d5f7zqxzNrWfZL4lR
         8CRbF4+xT1GhS7gZGFDeW+CvFDJKoGj8MiNfh9Gv8BnhWPpVvkY/ORIu6ufpT+Vo8Nhx
         ZMwb/2Fwqu3eRHRbf/xFJHgCWG2ByBUDuasx9d7fFBUZqGJQysnuntlkcFXfWX6SWMJy
         R1XGauIC/0qgkMxogT2HYCwBSEQnSks0qcgCtCgUZbiBDdAavJ1+AxgaG4gkddI6ahEZ
         TmGh4j+dDdkuzIHyPeZRDIqhp2FcmZbOfkxjJBRmWKwbFxwDe3EPEO7vbXQ3oRNOMXWe
         6w4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715907292; x=1716512092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=94+V3BHkFRnVmTbioW6W0jCvkmP7uhYCcSgy2G+MKUs=;
        b=R9SOIfd/SJlvXrANez2UYil+ar4hu9rIak+/dXUBWOQWvTHN9lchGfP7/Xo74VZCr7
         Al13nkrVihRdvouM1n1GhYvP2YMuTTuq91k0pz7zNEGaBfeQUpHvVe7U99kSpXRN+Nm6
         UngCnzRH34zO8wT5gbFjBzZH29MxjD6N6QPsF4Fwn78kO7T53BobnDo+4G41mbgbrcVD
         2HoKBpCyzQnztFTHih5ftaCrNoA5BEy+90Zv/L86l+HsL46MjDCRPhqP45ZwpBawh9TE
         OAuq4VzbgKCxz8qBekpB3UP13Hd/GOFc5VVSduQrUhcCnZthQS7MlvP2Jzx40zmaozaA
         HjmQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7e/hLBGHZZMPGPE7CE0YqVxswsX3egofCzpy7QX57U21wcZuPogMLxkkc9/+LR84R/9FPUhrjzniMdQXb+zQ+Ijxkrbdb/8cOPrmQ/oNw7MuVYDwvbETng+1N
X-Gm-Message-State: AOJu0YxYL+HQxOvKAkGCP7jxb1Qa/tDTQ3QeRHSGYdd9zAhRbO0Vj+zL
	vGtl3cMR/i6Yw5Z9Ai2J2es6dx6rtVzL4LvEl4E+ctOKYd4WbWhPVoLYr6B82qGQGgCMtEuoxO2
	J6n0sbZmAsslZJ7NcBa9NJ1YAbOYb0w==
X-Google-Smtp-Source: AGHT+IHhm3MkVB6Zjr3XBf6fbXhguDmi5GZZYmOQG13Imx+RUqcJbO8UaeBDva2m9OnsDayAQhM5aX/t+CH+Z2kx9rE=
X-Received: by 2002:a25:ce0c:0:b0:df4:449d:e09f with SMTP id
 3f1490d57ef6-df4449de233mr3591081276.23.1715907292437; Thu, 16 May 2024
 17:54:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510192412.3297104-1-amery.hung@bytedance.com>
 <20240510192412.3297104-3-amery.hung@bytedance.com> <b2486867-0fee-4972-ad71-7b54e8a5d2b6@gmail.com>
 <CAMB2axN3XwSmvk2eC9OnaUk5QvXS6sLVv148NrepkbtjCixVwg@mail.gmail.com>
 <CAMB2axMG2Pr11-O8ZRh3=T-4VqUmfoKQ7=ukQxK3rHONaTXypQ@mail.gmail.com> <184079b1-1ad0-414d-b8ff-179b5525c439@linux.dev>
In-Reply-To: <184079b1-1ad0-414d-b8ff-179b5525c439@linux.dev>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 16 May 2024 17:54:41 -0700
Message-ID: <CAMB2axOyfLoyicoNwJ=hdoNzZYQk67XVxQ4qrjZe4zLMZrz1xQ@mail.gmail.com>
Subject: Re: [RFC PATCH v8 02/20] selftests/bpf: Test referenced kptr
 arguments of struct_ops programs
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Kui-Feng Lee <sinquersw@gmail.com>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	yangpeihao@sjtu.edu.cn, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@kernel.org, toke@redhat.com, jhs@mojatatu.com, jiri@resnulli.us, 
	sdf@google.com, xiyou.wangcong@gmail.com, yepeilin.cs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2024 at 4:45=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 5/16/24 4:14 PM, Amery Hung wrote:
> > I thought about patch 1-4 a bit more after the discussion in LSFMMBPF a=
nd
> > I think we should keep what "ref_acquried" does, but maybe rename it to
> > "ref_moved".
> >
> > We discussed the lifecycle of skb in qdisc and changes to struct_ops an=
d
> > bpf semantics. In short, At the beginning of .enqueue, the kernel passe=
s
> > the ownership of an skb to a qdisc. We do not increase the reference co=
unt
> > of skb since this is an ownership transfer, not kernel and qdisc both
> > holding references to the skb. (The counterexample can be found in RFC =
v7.
> > See how weird skb release kfuncs look[0]). The skb should be either
> > enqueued or dropped. Then, in .dequeue, an skb will be removed from the
> > queue and the ownership will be returned to the kernel.
> >
> > Referenced kptr in bpf already carries the semantic of ownership. Thus,
> > what we need here is to enable struct_ops programs to get a referenced
> > kptr from the argument and returning referenced kptr (achieved via patc=
h
> > 1-4).
> >
> > Proper handling of referenced objects is important for safety reasons.
> > In the case of bpf qdisc, there are three problematic situations as lis=
ted
> > below, and referenced kptr has taken care of (1) and (2).
> >
> > (1) .enqueue not enqueueing nor dropping the skb, causing reference lea=
k
> >
> > (2) .dequeue making up an invalid skb ptr and returning to kernel
> >
> > (3) If bpf qdisc operators can duplicate skb references, multiple
> >      references to the same skb can be present. If we enqueue these
> >      references to a collection and dequeue one, since skb->dev will be
> >      restored after the skb is removed from the collection, other skb i=
n
> >      the collection will then have invalid skb->rbnode as "dev" and "rb=
node"
> >      share the same memory.
> >
> > A discussion point was about introducing and enforcing a unique referen=
ce
> > semantic (PTR_UNIQUE) to mitigate (3). After giving it more thoughts, I
> > think we should keep "ref_acquired", and be careful about kernel-side
> > implementation that could return referenced kptr. Taking a step back, (=
3)
> > is only problematic because I made an assumption that the kfunc only
> > increases the reference count of skb (i.e., skb_get()). It could have b=
een
> > done safely using skb_copy() or maybe pskb_copy(). In other words, it i=
s a
> > kernel implementation issue, and not a verifier issue. Besides, the
> > verifier has no knowledge about what a kfunc with KF_ACQUIRE does
> > internally whatsoever.
> >
> > In v8, we try to do this safely by only allowing reading "ref_acquired"=
-
> > annotated argument once. Since the argument passed to struct_ops never
> > changes when during a single invocation, it will always be referencing =
the
> > same kernel object. Therefore, reading more than once and returning
> > mulitple references shouldn't be allowed. Maybe "ref_moved" is a more
> > precise annotation label, hinting that the ownership is transferred.
>
> The part that no skb acquire kfunc should be available to the qdisc struc=
t_ops
> prog is understood. I think it just needs to clarify the commit message a=
nd
> remove the "It must be released and cannot be acquired more than once" pa=
rt.
>

Got it. I will improve the clarity of the commit message.

In addition, I will also remove "struct_ops_ref_acquire_dup_ref.c" as
whether duplicate references can be acquired through kfunc is out of
scope (should be taken care of by struct_ops implementer). Actually,
this testcase should load the and it does load...

As for the name, do you have any thoughts?

Thanks,
Amery

>
> >
> > [0] https://lore.kernel.org/netdev/2d31261b245828d09d2f80e0953e911a9c38=
573a.1705432850.git.amery.hung@bytedance.com/
>

