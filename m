Return-Path: <bpf+bounces-60810-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 663B1ADC9EC
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 13:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13301177A7B
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 11:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C782DF3E1;
	Tue, 17 Jun 2025 11:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gy30+hvU"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A8E249F9
	for <bpf@vger.kernel.org>; Tue, 17 Jun 2025 11:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750161047; cv=none; b=LcPmgP6pAIA0rChhzB/Z4yyqdCCiY94nY9UOjhWdme56xXGNg0o6ofN2n3TZaviqSPUVqoW167OPveihwAmyze8JNSx1dhxIbKVlmPFePHq1wapuaZzVXX2vlxL7DDXUd3zgofNQcdmEsLQ+qHYj/96hjRNxyGhWj/rbqAiNZ4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750161047; c=relaxed/simple;
	bh=CMEvHtovuOnGIc1rTZGMc9rVeZZhQF3JXBIvA0rIwko=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kDeQEti6exhnbkGciN9N15qE9AS7Y0P+dHGtyHtXxAek8GbuIepfRYHvmWg95aQYkjStZ3WfqdqOpPOpE0n67a7OGjVqIV90JqYGdr+OT9kXfBBmaJ2Z0mvKyf7zYH4u1mo13Ok7WfzxR+tuhq1rp/45ZCpyh3ofTBqsaZZ12/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gy30+hvU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750161044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n6S7kglB5eHzSexcMtlRWN6miYn5xNKkF2nKI45AFNk=;
	b=Gy30+hvUflEOIR6BgJ4tM0MyAO+BL2iPbFepJ3esUBg9MBRa0vQ/nZA8q8Ab7oDWgw0XkN
	Lq12kv2GPajCU1Dhu+0UiTlcxdWg2VaxVj6XyEytVKnQjr3fWKnnHFCifL70xTHYKt6vbf
	6yqub/uVn7v8jHCQdqaim6NguUMr7KE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-rHASmSSSPGO46x4E97D33Q-1; Tue, 17 Jun 2025 07:50:42 -0400
X-MC-Unique: rHASmSSSPGO46x4E97D33Q-1
X-Mimecast-MFC-AGG-ID: rHASmSSSPGO46x4E97D33Q_1750161042
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ade5b98537dso633928266b.2
        for <bpf@vger.kernel.org>; Tue, 17 Jun 2025 04:50:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750161042; x=1750765842;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n6S7kglB5eHzSexcMtlRWN6miYn5xNKkF2nKI45AFNk=;
        b=UZ+KT3vtHgy1mTeVOcCKxejmqBKeyNX5KqUexrG9OVxe0v/huSoICkkHjMZmtCCYG5
         duSQNu+jvJm5RBkmiqd3tH8aL8dye/mCnJOhyn6uNq75QZ+hWTlWbgfDSXUTO4bIJJ3a
         RPNFirbXsFcGaqLig+l+BYX5nGc98XqnE2p7wAG030uuRtosjAFmPsPuuGlj8LHdN5e1
         adfeAXTJOCPnlOaK++IdM9QJaOxsHWausDL1kkRKz8ydp0eM/hCJOwYnTP+rxHcpao0U
         /gw7X7URNRYI4OffJo6qFsXctPZLx1rW49qdPW/Qez6gChMH2iRtaRQEW+zSYNE9QLZA
         RCbA==
X-Forwarded-Encrypted: i=1; AJvYcCU955UjgqZqzvo3wh9HMZkUODr1izHqCNkZsS8o0kpkWOtLKuseW16WPXb0v1EhTY7WR44=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbi26sTlany59HtcvEfWoTVu0cYX9cetkYD2T+PvROVkXZ81FP
	30vS0XNzp1CVUFr6nfvabsgAzGFkQPCHt+gwu0Va59eWuzL6t04akrjZCiYMWEKKPsJ+b+51Vpi
	jn1jQpWN8dSBNCZaZ+ze4PNqMjesvBYC5uvcZx68OOFqUnFznfqZjIg==
X-Gm-Gg: ASbGncthw54fiQwGb2OCdnzbnIf64mu4SvrdPUpa0mrSvS1dl1QOyEXDmq8uT5XvOK5
	ddgGyC2BBtAfj8e9CjNBEzIuGZN3S0SjUwq0PUwqJI8ZVJ58hXu3owVcxuDF6MIOaHE9FYgNaLo
	okNH9kIMw1GsTVjCGez3xRkKf/0+coHS/QOgxolORfQRrCQZkMsJvemPbkw4/DR7eweFAqJIZ7Q
	mrK0YWhU7/TjhebRGXNE1z9SHjGFr4zF7VE/5mwUEO78RvIlwQUrd/4PnDjrQ4p21+h+1/k/SPn
	sxOLtuXD6jPfM+4iiSkn4jqN9fG1+EBvTZAP2f3rGhQCDWQ=
X-Received: by 2002:a17:906:c109:b0:ad8:a41a:3cca with SMTP id a640c23a62f3a-adfad436e2emr1281445666b.14.1750161041620;
        Tue, 17 Jun 2025 04:50:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZGGf4xaqQr7bhH8IugHrJ1wzKfrOGGVQIis8pzSmJlubBKNCwyp888GTQnKMFW9Adq6XhqA==
X-Received: by 2002:a17:906:c109:b0:ad8:a41a:3cca with SMTP id a640c23a62f3a-adfad436e2emr1281440966b.14.1750161041107;
        Tue, 17 Jun 2025 04:50:41 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0109af268sm31140166b.172.2025.06.17.04.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 04:50:40 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 563C91AF70AB; Tue, 17 Jun 2025 13:50:39 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>, Stanislav Fomichev
 <stfomichev@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer
 <hawk@kernel.org>, bpf@vger.kernel.org, netdev@vger.kernel.org, Jakub
 Kicinski <kuba@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <borkmann@iogearbox.net>, Eric Dumazet <eric.dumazet@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 sdf@fomichev.me, kernel-team@cloudflare.com, arthur@arthurfabre.com,
 jakub@cloudflare.com, Magnus Karlsson <magnus.karlsson@intel.com>, Maciej
 Fijalkowski <maciej.fijalkowski@intel.com>
Subject: Re: [PATCH bpf-next V1 7/7] net: xdp: update documentation for
 xdp-rx-metadata.rst
In-Reply-To: <aFBI6msJQn4-LZsH@lore-desk>
References: <174897271826.1677018.9096866882347745168.stgit@firesoul>
 <174897279518.1677018.5982630277641723936.stgit@firesoul>
 <aEJWTPdaVmlIYyKC@mini-arch>
 <bf7209aa-8775-448d-a12e-3a30451dad22@iogearbox.net>
 <87plfbcq4m.fsf@toke.dk> <aEixEV-nZxb1yjyk@lore-rh-laptop>
 <aEj6nqH85uBe2IlW@mini-arch> <aFAQJKQ5wM-htTWN@lore-desk>
 <aFA8BzkbzHDQgDVD@mini-arch> <aFBI6msJQn4-LZsH@lore-desk>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 17 Jun 2025 13:50:39 +0200
Message-ID: <87h60e4meo.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lorenzo Bianconi <lorenzo@kernel.org> writes:

>> On 06/16, Lorenzo Bianconi wrote:
>> > On Jun 10, Stanislav Fomichev wrote:
>> > > On 06/11, Lorenzo Bianconi wrote:
>> > > > > Daniel Borkmann <daniel@iogearbox.net> writes:
>> > > > > 
>> > > > [...]
>> > > > > >> 
>> > > > > >> Why not have a new flag for bpf_redirect that transparently stores all
>> > > > > >> available metadata? If you care only about the redirect -> skb case.
>> > > > > >> Might give us more wiggle room in the future to make it work with
>> > > > > >> traits.
>> > > > > >
>> > > > > > Also q from my side: If I understand the proposal correctly, in order to fully
>> > > > > > populate an skb at some point, you have to call all the bpf_xdp_metadata_* kfuncs
>> > > > > > to collect the data from the driver descriptors (indirect call), and then yet
>> > > > > > again all equivalent bpf_xdp_store_rx_* kfuncs to re-store the data in struct
>> > > > > > xdp_rx_meta again. This seems rather costly and once you add more kfuncs with
>> > > > > > meta data aren't you better off switching to tc(x) directly so the driver can
>> > > > > > do all this natively? :/
>> > > > > 
>> > > > > I agree that the "one kfunc per metadata item" scales poorly. IIRC, the
>> > > > > hope was (back when we added the initial HW metadata support) that we
>> > > > > would be able to inline them to avoid the function call overhead.
>> > > > > 
>> > > > > That being said, even with half a dozen function calls, that's still a
>> > > > > lot less overhead from going all the way to TC(x). The goal of the use
>> > > > > case here is to do as little work as possible on the CPU that initially
>> > > > > receives the packet, instead moving the network stack processing (and
>> > > > > skb allocation) to a different CPU with cpumap.
>> > > > > 
>> > > > > So even if the *total* amount of work being done is a bit higher because
>> > > > > of the kfunc overhead, that can still be beneficial because it's split
>> > > > > between two (or more) CPUs.
>> > > > > 
>> > > > > I'm sure Jesper has some concrete benchmarks for this lying around
>> > > > > somewhere, hopefully he can share those :)
>> > > > 
>> > > > Another possible approach would be to have some utility functions (not kfuncs)
>> > > > used to 'store' the hw metadata in the xdp_frame that are executed in each
>> > > > driver codebase before performing XDP_REDIRECT. The downside of this approach
>> > > > is we need to parse the hw metadata twice if the eBPF program that is bounded
>> > > > to the NIC is consuming these info. What do you think?
>> > > 
>> > > That's the option I was asking about. I'm assuming we should be able
>> > > to reuse existing xmo metadata callbacks for this. We should be able
>> > > to hide it from the drivers also hopefully.
>> > 
>> > If we move the hw metadata 'store' operations to the driver codebase (running
>> > xmo metadata callbacks before performing XDP_REDIRECT), we will parse the hw
>> > metadata twice if we attach to the NIC an AF_XDP program consuming the hw
>> > metadata, right? One parsing is done by the AF_XDP hw metadata kfunc, and the
>> > second one would be performed by the native driver codebase.
>> 
>> The native driver codebase will parse the hw metadata only if the
>> bpf_redirect set some flag, so unless I'm missing something, there
>> should not be double parsing. (but it's all user controlled, so doesn't
>> sound like a problem?)
>
> I do not have a strong opinion about it, I guess it is fine, but I am not
> 100% sure if it fits in Jesper's use case.
> @Jesper: any input on it?

FWIW, one of the selling points of XDP is (IMO) that it allows you to
basically override any processing the stack does. I think this should
apply to hardware metadata as well (for instance, if the HW metadata
indicates that a packet is TCP, and XDP performs encapsulation before
PASSing it, the metadata should be overridden to reflect this).

So if the driver populates these fields natively, I think this should
either happen before the XDP program is run (so it can be overridden),
or it should check if the XDP program already set the values and leave
them be if so. Both of those obviously incur overhead; not sure which
would be more expensive, though...

-Toke


