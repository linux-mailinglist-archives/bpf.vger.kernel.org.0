Return-Path: <bpf+bounces-30638-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6A68CFDE0
	for <lists+bpf@lfdr.de>; Mon, 27 May 2024 12:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1E2E1F24658
	for <lists+bpf@lfdr.de>; Mon, 27 May 2024 10:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34D513AA51;
	Mon, 27 May 2024 10:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cDUT4JpK"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC558830
	for <bpf@vger.kernel.org>; Mon, 27 May 2024 10:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716804547; cv=none; b=O2Ex1jX/M7oKk2DArcW3o1j1grM/aBLDAHb0pCJcXWdvnGOkX9CuwmJu0avxFO0r3Kyoo0FgL6lst3uTKm/ODmqwEenn5BjwC70OkPZ2fPJ7Yv2Pnd1/GncS0RaaR6VRlV6ArghBtae8koPZLoIdRZI9F3nSW71AJFuH1+2fPU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716804547; c=relaxed/simple;
	bh=24i1icgCqIm/LqDImedZx4ia4O6w7c8WgVNOrUyaMbY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hz60VVVczspsbzPLVghMOjELKf1bJ9jiubqhlfUt1vGkxC8Lmh0hUYqH5sergYgBKFxnqm8VoQHbirbIC+kEl4hAwGQ5EH/rKL6x6FYStUJ7crReKLS2tdRVXEhtT1Xc4gC8Qfq1KHp2ohpJwmb/dqCVezSwf3/6pSY5TsxN2M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cDUT4JpK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716804544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=24i1icgCqIm/LqDImedZx4ia4O6w7c8WgVNOrUyaMbY=;
	b=cDUT4JpK1lZO/ec6Ae3J1fFqV/36E5L5L+PpNX30m6rvu0AHKbKpyn8Y78YYvuB1rZd8q/
	zmaLedRzMDLLA2PfoZub5J97rM+r/FQNwWEzkc8Nq/VAapFRPA9v4Qm+n4rTRpf9AqQk29
	TVZW1neiVPAHhm/24HcTvwBknJnQUAQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-d58G1KErNK-Awj6OkN3DAw-1; Mon, 27 May 2024 06:09:03 -0400
X-MC-Unique: d58G1KErNK-Awj6OkN3DAw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42113d7adafso6552305e9.3
        for <bpf@vger.kernel.org>; Mon, 27 May 2024 03:09:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716804542; x=1717409342;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=24i1icgCqIm/LqDImedZx4ia4O6w7c8WgVNOrUyaMbY=;
        b=H97kv3+tpnq3X82q+Lyp87x3mXjWkNTmz9LakDuKVVuYg1eHVrfwEBPvFbGPncTdLq
         j/ufJvCFc25W+eGItfqSiIiri5osSGZ177LWf54WuOtWCBb6Wp3Qy/ioXrYdJ82FyOm0
         S+mhsMzitc9jkVPmj2/xck9uDl7rMflZl1qkv03W6zACQyjvj3PtpEi6nTgIgwro0ha9
         H/bu/odXDLZLVdyOh5HbxlIMjvI31IzwdLzvQr+7IJCtaFurRP4x11TqE/LTjFwtTvGL
         BJeyOHyJMKc0pfgRTjURO6Buxs59vKi597lhV947IhdUfvXFBFXYmLZAfsn/nNl3iiBk
         YK9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUItJCzI3A8dcwaVLzlvVC6HJeblIBydLxnp2k6/itEg3QFKUmQGaUMSEPk6VUi3Eyk7BD5AFB9lfc0d8Rzvv00h/NE
X-Gm-Message-State: AOJu0Yx7+sG3F1a5KHtZHyKDSCI84kBIWEymb8GP8Bi+V5f171AJnAcf
	tEk2TpN1LUB4yC+YIq6SF3l6HATIfTlyMqIJ/atARZEhTgzAIZbFRZtRcSKlf9ryC+DgMrzqeNi
	YxWSwpnQHgoXGYKG5ap4tH65OVTwBIpujXD0Ui9FnyYUnM1JzfQ==
X-Received: by 2002:a05:600c:138e:b0:41b:fa34:9e48 with SMTP id 5b1f17b1804b1-42108a99ea9mr80582425e9.30.1716804542247;
        Mon, 27 May 2024 03:09:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF46MLR1xgTvyNSsOonGW+IyREjsf7Dja3odnB9Qj15CzRLFqVZba935xFZQk8uG6wuks/Hrw==
X-Received: by 2002:a05:600c:138e:b0:41b:fa34:9e48 with SMTP id 5b1f17b1804b1-42108a99ea9mr80582125e9.30.1716804541736;
        Mon, 27 May 2024 03:09:01 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100f163a8sm136110825e9.13.2024.05.27.03.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 03:09:01 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id DD70E12F79BF; Mon, 27 May 2024 12:09:00 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Martin KaFai Lau <martin.lau@linux.dev>, Amery Hung <ameryhung@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, yangpeihao@sjtu.edu.cn,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
 sinquersw@gmail.com, jhs@mojatatu.com, jiri@resnulli.us, sdf@google.com,
 xiyou.wangcong@gmail.com, yepeilin.cs@gmail.com
Subject: Re: [RFC PATCH v8 18/20] selftests: Add a bpf fq qdisc to selftest
In-Reply-To: <d178f981-a4fe-443f-b8d0-4a86aaea026b@linux.dev>
References: <20240510192412.3297104-1-amery.hung@bytedance.com>
 <20240510192412.3297104-19-amery.hung@bytedance.com>
 <6ad06909-7ef4-4f8c-be97-fe5c73bc14a3@linux.dev> <87fru7ody3.fsf@toke.dk>
 <d178f981-a4fe-443f-b8d0-4a86aaea026b@linux.dev>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 27 May 2024 12:09:00 +0200
Message-ID: <87o78rh8hv.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Martin KaFai Lau <martin.lau@linux.dev> writes:

> On 5/24/24 12:40 AM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> I think behaviour like this is potentially quite interesting and will
>> allow some neat optimisations (skipping a redirect to a different
>> interface and just directly enqueueing it to a different place comes to
>
> hmm... I am not sure it is a good/safe optimization. From looking at
> skb_do_redirect, there are quite a few things bypassed from
> __dev_queue_xmit upto the final dequeue of the redirected dev. I don't
> know if all of them is not dev dependent.

There are certainly footguns, but as long as they are of the "break the
data path" variety and not the "immediately crash the kernel" variety
that may be OK. After all, you can already do plenty of convoluted
things with BPF that will break things. And glancing through the
redirect code, nothing immediately jumps out as something that will
definitely crash, AFAICT.

However, it does feel a bit risky, so I am also totally fine with
disallowing this until someone comes up with a concrete use case where
it would be beneficial :)

>> mind). However, as you point out it may lead to weird things like a
>> mismatched skb->dev, so if we allow this we should make sure that the
>> kernel will disallow (or fix) such behaviour.
>
> Have been thinking about the skb->dev "fix" but the thought is originally=
 for=20
> the bpf_skb_set_dev() use case in patch 14.
>
> Note that the struct_ops ".dequeue" is actually realized by a fentry tram=
poline=20
> (call it fentry ".dequeue"). May be using an extra fexit ".dequeue" here.=
 The=20
> fexit ".dequeue" will be called after the fentry ".dequeue". The fexit=20
> ".dequeue" has the function arguments (sch here that has the correct dev)=
 and=20
> the return value (skb) from the fentry ".dequeue". This will be an extra =
call=20
> (to the fexit ".dequeue") and very specific to this use case but may be t=
he less=20
> evil solution I can think of now...

That's an interesting idea, certainly! Relying on fexit functions
to do specific sanity checks/fixups after a BPF program has run
(enforcing/checking post-conditions, basically) does not seem totally
crazy to me, and may have other applications :)

-Toke


