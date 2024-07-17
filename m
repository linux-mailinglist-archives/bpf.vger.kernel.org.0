Return-Path: <bpf+bounces-34950-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95ABE933D97
	for <lists+bpf@lfdr.de>; Wed, 17 Jul 2024 15:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B7E52832E9
	for <lists+bpf@lfdr.de>; Wed, 17 Jul 2024 13:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F61180A6D;
	Wed, 17 Jul 2024 13:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KDPGw7YR"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24CE17E907
	for <bpf@vger.kernel.org>; Wed, 17 Jul 2024 13:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721222901; cv=none; b=OzzQYcJOE4my1+0e8X3oOqjKqmSpFnzc1EaDmOMr3K2rJ+2RSj/Qqef95JgO1GGspNqh5ezgZ1E+Zz+bGTLsE/QZRo6v+JAZAvIMQxg0Ew6fITIOpfdszGgq6yGS2iJdhujgqewzyiow4cYOhe/u5kFp7pZJmx8tWifYzjRbna8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721222901; c=relaxed/simple;
	bh=i5fDdDHEtX7vNR12mFEKIETqZ0WT4Yxwoz5sgAv+nGc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fvv68OTRsWqeBs4y7tuuYizWVZlq4REnyDoJOVy/0rUMhKDjA+bXm/mmHFZN9IpXzPjHjhWn5vb2luW0U+W+0h7N/f6hfMuFk2cuSfikAWFxQk04+VR4N2HqJMfnqEi2TGkaUFqAxLb4ieas9kLe0gGnaOSYo/nYXM6iAvveQrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KDPGw7YR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721222896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ItohwBK9euwv/uwdzmdFu/crsWLVAK5HqaVyEtkiNe8=;
	b=KDPGw7YRmN3Ys2Q8Si8vbLi3McK5ysqjXkDJKXiXH5lWEiTSdF6DkZ1AlUKnijAlapnaWu
	xBKJtBqOPoecbRWP9XjQ2HuX9yNiUcixOniuBFZRhg8YMtg9B3rRAvfu8JSMk26RYTvhiD
	QjutrRmZeAWCUdrRwjME7MYltQip3tg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-h7XAfG5yOHava9MlOpv7YA-1; Wed, 17 Jul 2024 09:28:14 -0400
X-MC-Unique: h7XAfG5yOHava9MlOpv7YA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-36831873b39so452633f8f.1
        for <bpf@vger.kernel.org>; Wed, 17 Jul 2024 06:28:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721222892; x=1721827692;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ItohwBK9euwv/uwdzmdFu/crsWLVAK5HqaVyEtkiNe8=;
        b=IZPAEvBjmeb1Qom9EDpdcZWoFjsrYMOFB64E0sXmEO9kzOx7pI73sTnLPqJ5BiQUY8
         Tx5dR1Ky11yQZtFDdIKli2I6YzFu8yGXyg4AlxZZM74l+GvQu2V8akFBareqO/ifn5D1
         ygu280A059tg/zr8gvob8/24k4gUcAa6Xca+Ne9SSNF8L0e9GfkeoIcimCvoqFbIfX5c
         HvaOTawAEEl7IwQFLwsXMs8U//oYwCoJ2wHgC2lHkLqAxWdATdJDi9QVjY2Rw65whCuv
         ROZMl1lxDvDsMFXwxuCF2E7nHxZCOt3CkYogjqpMh3SyVsZVlxu22HCSE+Eqvk+fgxyl
         248A==
X-Gm-Message-State: AOJu0Yz0ZBn+eFjg2eg5HjsujdxtSh1dAHqgiL9TLVxVA1YhgS6S+3VU
	K4GeuiOtO5Nz7aMaEksaYpLV4P5vJkN8anFTn2Y8BfyBeX4msDqmMOPMVRW70GmxzQ540u7igYE
	Gqk7XrQsAjEv2TcO7uUkGjylFL6KbwXj7816tOH7kJyOLeblVZg==
X-Received: by 2002:a05:6000:d90:b0:368:3194:8a85 with SMTP id ffacd0b85a97d-36831948efamr1354444f8f.7.1721222892511;
        Wed, 17 Jul 2024 06:28:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpTaAUfRVNU5Xu+qR1JE/9Bc1YiuNYvppU3YdvKcMCaYdPaRWowG53BU48+Swh1yPrb+brsQ==
X-Received: by 2002:a05:6000:d90:b0:368:3194:8a85 with SMTP id ffacd0b85a97d-36831948efamr1354427f8f.7.1721222892139;
        Wed, 17 Jul 2024 06:28:12 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680db04731sm11642192f8f.112.2024.07.17.06.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 06:28:11 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 42675145D491; Wed, 17 Jul 2024 15:28:11 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Martin KaFai Lau <martin.lau@linux.dev>, Michal Switala
 <michal.switala@infogain.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, revest@google.com,
 syzbot+cca39e6e84a367a7e6f6@syzkaller.appspotmail.com,
 alexei.starovoitov@gmail.com
Subject: Re: [PATCH] bpf: Ensure BPF programs testing skb context
 initialization
In-Reply-To: <250854fc-ce22-4866-95f9-d61f6653af64@linux.dev>
References: <CAADnVQJPzya3VkAajv02yMEnQLWtXKsHuzjZ1vQ6R19N_BZkTQ@mail.gmail.com>
 <20240715181339.2489649-1-michal.switala@infogain.com>
 <250854fc-ce22-4866-95f9-d61f6653af64@linux.dev>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 17 Jul 2024 15:28:11 +0200
Message-ID: <87y160407o.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Martin KaFai Lau <martin.lau@linux.dev> writes:

> On 7/15/24 11:13 AM, Michal Switala wrote:
>
>  >> Reported-by: syzbot+cca39e6e84a367a7e6f6@syzkaller.appspotmail.com
>  >> Closes: https://syzkaller.appspot.com/bug?extid=cca39e6e84a367a7e6f6
>  >> Link: https://lore.kernel.org/all/000000000000b95d41061cbf302a@google.com/
>  >
>  > Something doesn't add up.
>  > This syzbot report is about:
>  >
>  > dev_map_enqueue+0x31/0x3e0 kernel/bpf/devmap.c:539
>  > __xdp_do_redirect_frame net/core/filter.c:4397 [inline]
>  > bpf_prog_test_run_xdp
>  >
>  > why you're fixing bpf_prog_test_run_skb ?
>
>
> [ Please keep the relevant email context in the reply ]
>
>
>> The reproducer calls the methods bpf_prog_test_run_xdp and
>> bpf_prog_test_run_skb. Both lead to the invocation of dev_map_enqueue, in the
>
> The syzbot report is triggering from the bpf_prog_test_run_xdp. I agree with 
> Alexei that fixing the bpf_prog_test_run_skb does not make sense. At least I 
> don't see how dev_map_enqueue can be used from bpf_prog_test_run_skb.

Me neither.

> It looks very similar to 
> https://lore.kernel.org/bpf/000000000000f6531b061494e696@google.com/. It has 
> been fixed in commit 5bcf0dcbf906 ("xdp: use flags field to disambiguate 
> broadcast redirect")
>
> I tried the C repro. I can reproduce in the bpf tree also which should have the 
> fix. I cannot reproduce in the bpf-next though.
>
> Cc Toke who knows more details here.

Hmm, yeah, it does look kinda similar. Do you mean that the C repro from
this new report triggers the crash for you on the current -bpf tree?

-Toke


