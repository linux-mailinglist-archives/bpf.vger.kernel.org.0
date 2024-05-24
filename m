Return-Path: <bpf+bounces-30472-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7DD8CE1A2
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 09:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8171A1C21436
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 07:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0042128833;
	Fri, 24 May 2024 07:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YuH9WpJ/"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC76744C6E
	for <bpf@vger.kernel.org>; Fri, 24 May 2024 07:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716536434; cv=none; b=IJQ+eB3hvfVFZ0Bxcf5YHZ3km960ONlghV/H/9fBQw/CkZU6Egp65csJFXZ2DdX6k9bm6YkGpMhFIiXvwsW2ZDOCgeD9xgly+IA7ns2/nRMG8wYkPShqoojXDSmyQ/DYMQqb8XZuNrnksLdgBpABl/kGU4fGK3cudzgOiRaBVrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716536434; c=relaxed/simple;
	bh=uDApB2sBoWNej78QnwtNqovj3jCcnafsZDj6UZmkjDE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EnDb719PvLnGxKCK0PaRNTRVsz9zxJPQlrorDhplsxW/kXqheb4f3MW6RBFTgfmYY9B0pxCI1oJjn5FmMpxJdsYvutYzqAeV7FcB002sp45mIuYDQZwmUWGgU0rxNMdJI/wFlca3MSOVHO2CRMbyfAf0dPq8cPFBOjWbdUIzgV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YuH9WpJ/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716536431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QC+x7qGvdd/KkPuiGiAWLgKm0EHNJBKe9oxmIoIWc34=;
	b=YuH9WpJ/vgZBjog4s+DEjhTu0T4v6P58hWHD6So/0A8hFrJvHO2CL9J2fVjghgFCAEXtTC
	w02PnGN5+vu+7KPwpmBDrK5NfkRLGnD8ixNBNybQjOA+EM7pFXwcfEL+UEugktIy5BXjrM
	0Z0utv0hmPdBqrCKVdoDk61/GrAiPDM=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-uE4xgo0DOG66nqAqhdRdnA-1; Fri, 24 May 2024 03:40:29 -0400
X-MC-Unique: uE4xgo0DOG66nqAqhdRdnA-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6ab9ce5ad80so6932496d6.0
        for <bpf@vger.kernel.org>; Fri, 24 May 2024 00:40:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716536429; x=1717141229;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QC+x7qGvdd/KkPuiGiAWLgKm0EHNJBKe9oxmIoIWc34=;
        b=szkQLGOJ8+X/w+mwcfKwNsKpQV5dm2r0l70MRrZc1omNEAFkLstWJCtevvAlWdQdBD
         TaUfOfnTUsMDhBv94onyUyhsqaH5VIZT0KKQqeqrNt4qfcBpugCRiEEL6KUZYowJ+xxJ
         /JRej1xnNbWmNjzWxoDJ6+Mh+HX8Ql3nyKeg1PaFAl7FseLTkwTb+P2qsCZw/tESfjYv
         zZ9M4QQ7i+9ql+i2rqUPfOZ/DCyGzIurU+4CoMajP08vdTh0ebJsi/KjlsgrfynDsWw6
         FwPQsRzrJS5C1Hn6okDQt6U+HpRrgcnPFUK0LXnnO2ulfa5iHxh/DwYNWMzoW++QjJC6
         najQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyvW4CD1SwD3aoZw3ngv6e0DF4nCNbQB+9DQhYOWvBFV2Yv2mFEB1MrVwUgh3ASq7GWIumYHkociHn/TYjzmnOUCSL
X-Gm-Message-State: AOJu0Yw2HrETLa6lFW0BrzcYf33z9KesdilOj4hnTRpRM8GDMj4APOHN
	J8IaMuVZkGdTEiV1QBaUQ99t7Vsw8tLM/bK+vklrgKgl66DIn2jlmCaOJrS76weAtvRqU4Js7rQ
	FOkNRf49ItFzkwJVgKHI6+EXX4e8BD2LG0KcuwhZ0EX7hNpOOOQ==
X-Received: by 2002:a05:6214:5506:b0:6aa:c84c:4c14 with SMTP id 6a1803df08f44-6abbbc8ef26mr14096386d6.18.1716536429072;
        Fri, 24 May 2024 00:40:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnbXi3j/Kbu4U2wRe8Zu8DyQCP9b22RXB0paASnQc76ecopF7MlTcvhlcQrOtkTKe3OsusUg==
X-Received: by 2002:a05:6214:5506:b0:6aa:c84c:4c14 with SMTP id 6a1803df08f44-6abbbc8ef26mr14096146d6.18.1716536428587;
        Fri, 24 May 2024 00:40:28 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ac163187c5sm4856636d6.122.2024.05.24.00.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 00:40:28 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id EB60212F787D; Fri, 24 May 2024 09:40:20 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Martin KaFai Lau <martin.lau@linux.dev>, Amery Hung <ameryhung@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, yangpeihao@sjtu.edu.cn,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
 sinquersw@gmail.com, jhs@mojatatu.com, jiri@resnulli.us, sdf@google.com,
 xiyou.wangcong@gmail.com, yepeilin.cs@gmail.com
Subject: Re: [RFC PATCH v8 18/20] selftests: Add a bpf fq qdisc to selftest
In-Reply-To: <6ad06909-7ef4-4f8c-be97-fe5c73bc14a3@linux.dev>
References: <20240510192412.3297104-1-amery.hung@bytedance.com>
 <20240510192412.3297104-19-amery.hung@bytedance.com>
 <6ad06909-7ef4-4f8c-be97-fe5c73bc14a3@linux.dev>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 24 May 2024 09:40:20 +0200
Message-ID: <87fru7ody3.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Martin KaFai Lau <martin.lau@linux.dev> writes:

> [ ... ]
>
>> +SEC("struct_ops/bpf_fq_dequeue")
>> +struct sk_buff *BPF_PROG(bpf_fq_dequeue, struct Qdisc *sch)
>> +{
>> +	struct dequeue_nonprio_ctx cb_ctx = {};
>> +	struct sk_buff *skb = NULL;
>> +
>> +	skb = fq_dequeue_prio();
>> +	if (skb) {
>> +		bpf_skb_set_dev(skb, sch);
>> +		return skb;
>> +	}
>> +
>> +	ktime_cache = dequeue_now = bpf_ktime_get_ns();
>> +	fq_check_throttled();
>> +	bpf_loop(q_plimit, fq_dequeue_nonprio_flows, &cb_ctx, 0);
>> +
>> +	skb = get_stashed_skb();
>> +
>> +	if (skb) {
>> +		bpf_skb_set_dev(skb, sch);
>> +		return skb;
>> +	}
>> +
>> +	if (cb_ctx.expire)
>> +		bpf_qdisc_watchdog_schedule(sch, cb_ctx.expire, q_timer_slack);
>> +
>> +	return NULL;
>> +}
>
> The enqueue and dequeue are using the bpf map (e.g. arraymap) or global var 
> (also an arraymap). Potentially, the map can be shared by different qdisc 
> instances (sch) and they could be attached to different net devices also. Not 
> sure if there is potentail issue? e.g. the bpf_fq_reset below.
> or a bpf prog dequeue a skb with a different skb->dev.

I think behaviour like this is potentially quite interesting and will
allow some neat optimisations (skipping a redirect to a different
interface and just directly enqueueing it to a different place comes to
mind). However, as you point out it may lead to weird things like a
mismatched skb->dev, so if we allow this we should make sure that the
kernel will disallow (or fix) such behaviour. I'm not sure how difficult
that is; for instance, I *think* the mismatched skb->dev can lead to
bugs, but I'm not quite sure.

So maybe it's better to disallow "crossing over" like this, and relax
that restriction later if/when we have a concrete use case?

-Toke


