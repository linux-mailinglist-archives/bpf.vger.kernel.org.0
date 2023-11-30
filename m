Return-Path: <bpf+bounces-16261-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7FB7FF0F7
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 14:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC40228213E
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 13:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A6548782;
	Thu, 30 Nov 2023 13:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OIqgaj4W"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2EA11AD
	for <bpf@vger.kernel.org>; Thu, 30 Nov 2023 05:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701352553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DGrL90Etrr9V73ll7rDSIVqdC8n1ownVWJtUzMBU8oo=;
	b=OIqgaj4WNrFFSgWg1QXP/C80sF7WUZeyrxSwDMVOkqPq3XDva570D9Tgxlvv4+mPJ+umU8
	OJl7agIEAdz7mDGHlTxFmP/A/1eUgLwsleCUVV/B8st6nnuEjQG07oOHj1G2tcvgqTZvTC
	ZWvR5W2yugenxC63c++AOvubkMiXF0w=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-EXvOLX48OQWdlUMcuPH0wg-1; Thu, 30 Nov 2023 08:55:52 -0500
X-MC-Unique: EXvOLX48OQWdlUMcuPH0wg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a1867751573so137332666b.1
        for <bpf@vger.kernel.org>; Thu, 30 Nov 2023 05:55:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701352551; x=1701957351;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DGrL90Etrr9V73ll7rDSIVqdC8n1ownVWJtUzMBU8oo=;
        b=dbJRdy81bQytMNGS002MA36GIkB7A+Dd3pOwQwa49XYopXTy2wdnUP+x19l3Dtsiqg
         JathAdvHZpPm1KXztHFvrXCoX6g71zdqW8KcTy/OR/cB6WR5NKDR4fHcHu5P2kDTDm8d
         TjmZP8Js3LyQALkmZvT6XnmLD677AWisoJ0HtUR9d7S3ASSJd6u+BnVBXtWM6cnnZU9y
         2Tb0EMevhRQYlvc0xrvfMPYOQL4ItoDIhdxDVWGZHssWz/OviiwbGcLxIgUkLrS85gbI
         YyvvDlprQTFWWIByf52L/PpkLKpgkUk7cnzewNwU3DkRT0/U1wGsMbzlXAuQPu5JuTLY
         l7iA==
X-Gm-Message-State: AOJu0YysLvYvp+hqp3pZUjIQysHEi42fw+E8knjVZpq0Vr/g+NX8p3xd
	dkZwpyQMBsm4ZD0WiJeHZVH2w0FLoYIWAImt+7MGFGeISpqwjjxkO+hgLk/owfH4mqnMKn7rNdK
	EGyAAwP+vq3hd
X-Received: by 2002:a17:906:2096:b0:a18:d028:1cce with SMTP id 22-20020a170906209600b00a18d0281ccemr1182186ejq.35.1701352551493;
        Thu, 30 Nov 2023 05:55:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHg3ne5YwP5WnJehuvdpfEMr2u2ALVAAGZQb8Dpga9/0bhigqzGIOq/KC7JDEHBRCT8qDexjg==
X-Received: by 2002:a17:906:2096:b0:a18:d028:1cce with SMTP id 22-20020a170906209600b00a18d0281ccemr1182160ejq.35.1701352551161;
        Thu, 30 Nov 2023 05:55:51 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 13-20020a170906100d00b009b2ca104988sm698612ejm.98.2023.11.30.05.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 05:55:50 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 6FF9BF784AC; Thu, 30 Nov 2023 14:55:50 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Daniel Borkmann <daniel@iogearbox.net>, Edward Cree
 <ecree.xilinx@gmail.com>, Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Yan Zhai <yan@cloudflare.com>, Stanislav Fomichev <sdf@google.com>,
 Netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, kernel-team <kernel-team@cloudflare.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric
 Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>,
 Jakub Sitnicki <jakub@cloudflare.com>
Subject: Re: Does skb_metadata_differs really need to stop GRO aggregation?
In-Reply-To: <1ff5c528-79a8-fbb7-8083-668ca5086ecf@iogearbox.net>
References: <92a355bd-7105-4a17-9543-ba2d8ae36a37@kernel.org>
 <21d05784-3cd7-4050-b66f-bad3eab73f4e@kernel.org>
 <7f48dc04-080d-f7e1-5e01-598a1ace2d37@iogearbox.net>
 <87fs0qj61x.fsf@toke.dk> <0b0c6538-92a5-3041-bc48-d7286f1b873b@gmail.com>
 <87plzsi5wj.fsf@toke.dk>
 <1ff5c528-79a8-fbb7-8083-668ca5086ecf@iogearbox.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 30 Nov 2023 14:55:50 +0100
Message-ID: <871qc72vmh.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Daniel Borkmann <daniel@iogearbox.net> writes:

> On 11/29/23 10:52 PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Edward Cree <ecree.xilinx@gmail.com> writes:
>>> On 28/11/2023 14:39, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>> I'm not quite sure what should be the semantics of that, though. I.e.,
>>>> if you are trying to aggregate two packets that have the flag set, whi=
ch
>>>> packet do you take the value from? What if only one packet has the flag
>
> It would probably make sense if both packets have it set.

Right, so "aggregate only if both packets have the flag set, keeping the
metadata area from the first packet", then?

>>>> set? Or should we instead have a "metadata_xdp_only" flag that just
>>>> prevents the skb metadata field from being set entirely?
>
> What would be the use case compared to resetting meta data right before
> we return with XDP_PASS?

I was thinking it could save a call to xdp_adjust_meta() to reset it
back to zero before PASSing the packet. But okay, that may be of
marginal utility.

>>> Sounds like what's actually needed is bpf progs inside the GRO engine
>>>   to implement the metadata "protocol" prepare and coalesce callbacks?
>>=20
>> Hmm, yes, I guess that would be the most general solution :)
>
> Feels like a potential good fit, agree, although for just solving the
> above sth not requiring extra BPF might be nice as well.

Yeah, I agree that just the flag makes sense on its own.

-Toke


