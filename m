Return-Path: <bpf+bounces-28830-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABD88BE4B9
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 15:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D1BD1C20912
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 13:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9A215ECC0;
	Tue,  7 May 2024 13:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fGvrhwSw"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5701515E7F1
	for <bpf@vger.kernel.org>; Tue,  7 May 2024 13:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715089858; cv=none; b=c0fq+uPgwUEY3I7EbP0ExZSz2EHA1Ce+3lhWmBvwD2Wd199A5eGMdBVOHJHUxtWEa1g6NiDCWwJc3IXKmzvEJtW4sJikjOEhnsCge7srgC941mpggzSVrZKJw2ATX0QJK4d1oxv8lyNFu4UPlJKVO1UfbXBryBlaOIZPXAMN0Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715089858; c=relaxed/simple;
	bh=TIJT24/Y/Kk/+RWnfVxsYYSG3i19tMA8dCXENC479kk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nyXc88t5kJGoD0sRp3stQpAH7HXQXsv7aM0QJX8vCKbaktwsvin+CdRl1v8e2bf36PWOYwBjInrQFEJhARx4uiBMxHd71b3RNwyDiSoKrdE/AbX3YrHZ/1Er9GpIh5J2vWYo5VtfCQTNSng269yVLYrYd15hWYQrOEuws2Q9cs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fGvrhwSw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715089856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xTODE9eHYN04ukhQbjsh3NfbLHwJO8ke2b2LYl5imOw=;
	b=fGvrhwSwIgesIuR9DNgmTr9Dzw8MGI4rVCm4Nx4IB7dBTx903NMsQ4KWMyNARrW6ycjglw
	Mge/hBpr3ql7ODXpCwfIKbLa+yF9145gbt67MmSfYAgofwDa4CHZdwumCoOYsZFoZKzAT+
	UiWBmrtmcZZyaEJWCS0w/0lNzu6hTzo=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-QM-3Mrx-PQmABEv07bpWdQ-1; Tue, 07 May 2024 09:50:52 -0400
X-MC-Unique: QM-3Mrx-PQmABEv07bpWdQ-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-516d46e1bafso1542816e87.2
        for <bpf@vger.kernel.org>; Tue, 07 May 2024 06:50:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715089851; x=1715694651;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xTODE9eHYN04ukhQbjsh3NfbLHwJO8ke2b2LYl5imOw=;
        b=X42m1AtVkNkLfQfLtwajlLM6elwAncdasjQ+Th8znKFHakBMWtVpGSfC7+avvOQ1v/
         VWwesqdydZh5WlPabjnuecXbvBFO0sOsHw9Bec/MvmFhGh1wTs6Nwu+Xf9APFH08pqku
         YmaOixISGjvKFCGveft4hnAB4YCfsfJo9Yu4wRnktiuwmKOZD55d6p8H8dPI4IEi6oT4
         IDAD++Qa9RvbT/cGXkpFS7yzUr5dXoT3X5UoTMF4xLPA8qYsqyU2ptCs2UiPH7pypevu
         oT5zdHKFx50cGGY0/wMi4/xDqQ4qvqz8mWoV0QiFPT5rMTvFME1sLXKv2KU42JrhQxVD
         WRwA==
X-Forwarded-Encrypted: i=1; AJvYcCX9t05zdXAfKGMf3DPpyGcs2zh4dvekxgmr/naTXNFGCblv0WNETL0z4B5PxlheAFrlPboniLt/Dth281h42g2m1kSn
X-Gm-Message-State: AOJu0YxoASd3W78NZ76GJMvqsw/qm232gRck5DyqXS14jC5kll40Y4+L
	t80lgJI2OL3vxHknXy1OgoHrsXDultAG1OTZptOd6XDIjozXAQki7GQjZ9TyJ1arsaACBzVJerg
	x2Gtpn4YSFux4u3pvIZDq/HjEwhMw3H9ZiWs9LAFDEV4XKgAIRw==
X-Received: by 2002:a05:6512:1588:b0:518:b283:1078 with SMTP id bp8-20020a056512158800b00518b2831078mr14091463lfb.26.1715089851216;
        Tue, 07 May 2024 06:50:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHv9UwS+EKurT0TjqicSwHazMqzSvX4nL5tG19yPraKVt7fxXPC1+UwQnvq4wdl4VKNZqfd2w==
X-Received: by 2002:a05:6512:1588:b0:518:b283:1078 with SMTP id bp8-20020a056512158800b00518b2831078mr14091422lfb.26.1715089850709;
        Tue, 07 May 2024 06:50:50 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id ek10-20020a056402370a00b00572033ec969sm6344723edb.60.2024.05.07.06.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 06:50:50 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 6C3FE1275DC8; Tue, 07 May 2024 15:50:49 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, "David S. Miller"
 <davem@davemloft.net>, Boqun Feng <boqun.feng@gmail.com>, Daniel Borkmann
 <daniel@iogearbox.net>, Eric Dumazet <edumazet@google.com>, Frederic
 Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@redhat.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Eduard
 Zingerman <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>, Jesper
 Dangaard Brouer <hawk@kernel.org>, Jiri Olsa <jolsa@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Yonghong Song
 <yonghong.song@linux.dev>, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 14/15] net: Reference bpf_redirect_info via
 task_struct on PREEMPT_RT.
In-Reply-To: <20240507105731.bjCHl0YH@linutronix.de>
References: <20240503182957.1042122-1-bigeasy@linutronix.de>
 <20240503182957.1042122-15-bigeasy@linutronix.de> <87y18mohhp.fsf@toke.dk>
 <20240507105731.bjCHl0YH@linutronix.de>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 07 May 2024 15:50:49 +0200
Message-ID: <874jb9ohmu.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

>> > +static inline struct bpf_redirect_info *bpf_net_ctx_get_ri(void)
>> > +{
>> > +	struct bpf_net_context *bpf_net_ctx = bpf_net_ctx_get();
>> > +
>> > +	if (!bpf_net_ctx)
>> > +		return NULL;
>> 
>> ... do we really need all the NULL checks?
>> 
>> (not just here, but in the code below as well).
>> 
>> I'm a little concerned that we are introducing a bunch of new branches
>> in the XDP hot path. Which is also why I'm asking for benchmarks :)
>
> We could hide the WARN behind CONFIG_DEBUG_NET. The only purpose is to
> see the backtrace where the context is missing. Having just an error
> somewhere will make it difficult to track.
>
> The NULL check is to avoid a crash if the context is missing. You could
> argue that this should be noticed in development and never hit
> production. If so, then we get the backtrace from NULL-pointer
> dereference and don't need the checks and WARN.

Yup, this (relying on the NULL deref) SGTM :)

-Toke


