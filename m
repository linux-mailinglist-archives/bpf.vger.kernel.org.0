Return-Path: <bpf+bounces-43896-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECA49BBA47
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 17:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3D4A1F2272C
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 16:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715FC1C4A27;
	Mon,  4 Nov 2024 16:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BmKkL13n"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534E71C3306
	for <bpf@vger.kernel.org>; Mon,  4 Nov 2024 16:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730737351; cv=none; b=LsAAETSmJ6ikDmuZgCJfmV3b5Sh/euXouR9svWfwwpV9MXRp0mnO3rg6Mt7BVmucPnAb5PE2LtGgeG5skTLCEWExSSAcVjH706JyZjffpzdoPJahmsfqDNZYTu6gmHyhhYkDPUaFvO8LtvsfUl4Dl0GwHMcL50BaL6J//LSVGIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730737351; c=relaxed/simple;
	bh=IQeGnFrlKcJMyxCdPHDpA8uwABSsBIQVxA+KFfNERGI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E3kb3yJKeO74WmSQ9OZFe4hkkb0VbaFV8b4j9U71S1oLlXZebo7wKy0Ju+VfBOcoBNoiv63wlI9+CswsoaeIUysG8UsGkfOGAzK2DN09h42KadQjs1z0y3RWL/7cXT6sXGSSs0wjvJhq4ohBLHk+679VvhnpH6conhdBcU8Mlhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BmKkL13n; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730737346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DDAuBted5dLeURKBGQFzMNRty5vbrd8/225x2WxUwFs=;
	b=BmKkL13nDSr0zQXMumytMngyk1VKHhO26//HxoAY4CNDWZ9EMVyx2nH6Xpdg8rJ4Lb6tv0
	5MKclcTLkA2xNV3vH/JYsCW/5HRYZ/1tlrZpP7m3NjfQzP5yOg4lY6wOdFD5Viztdt42LW
	eCQdGPxKqyFIM3NzuD2r7KNfl4P+eQg=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-SHGe1_rlOQup0vgQFM_exw-1; Mon, 04 Nov 2024 11:22:24 -0500
X-MC-Unique: SHGe1_rlOQup0vgQFM_exw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a9a1e429a8fso363947366b.0
        for <bpf@vger.kernel.org>; Mon, 04 Nov 2024 08:22:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730737343; x=1731342143;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DDAuBted5dLeURKBGQFzMNRty5vbrd8/225x2WxUwFs=;
        b=UG4Gd1e9vLclJoPuYwg5RXJpk+cXFzp4Q9+6AOWLS62Qhs9WMGBJ3wymKhDagMKW2g
         ugDENX98dX8PNLm7Bu0mXPe5hIAsoi3yO8KShx/ZbBxMVPP7UBNU627GuRgC/KWGLkiV
         JLcU9LLMWAkMptuS5LOEAgbyw9rLC7ACKyTKc3LGB8lG9n2e0xyasjtweqGJl7d2GYEo
         tSUWIanfV+RlpHDiPXqPwTxogS/3QAT2KYTh3mqYBl6Iyl0TmVQdzIUOn0F1KlzxPT6M
         UHXFcwX36DmujGrZpvHUNbHTHJ3c/Cwcic16/bBTLD9VYmLS5gx7B8BKfgmFExAint5x
         zxuA==
X-Forwarded-Encrypted: i=1; AJvYcCWyvRR2i/9ScEWsbVAw5AGIyXz39y3hYbjV2znqkdCGMKqUxXAK44pMIf2aaVHvKF4nXpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAwLlHTF13Ud4ZANuF9cgMFRE7egddRjuO0OrTNKs4P59r2zp5
	Lp2RyyveEyhc3iTYQSDykcLob+XcaX0sx+Ok0cMXQxU8M5qFE6+7qeK4SLUZVx3Ti/Rf7aRfdWZ
	HXzwh750bjdYRS+ziP6Lvqovg46XSdZXYvmue868Zl14m+LJsCA==
X-Received: by 2002:a17:907:1c85:b0:a9a:1f38:e736 with SMTP id a640c23a62f3a-a9e654fb423mr1309266566b.31.1730737343238;
        Mon, 04 Nov 2024 08:22:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHOiR6QMYgQdW4+mshnrfOWBlpQZoTzVQuyXvd/zEM+yk9iclHiooZDENzVV+mOV9mrs3qrAQ==
X-Received: by 2002:a17:907:1c85:b0:a9a:1f38:e736 with SMTP id a640c23a62f3a-a9e654fb423mr1309263966b.31.1730737342768;
        Mon, 04 Nov 2024 08:22:22 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb16d9ef8sm1803866b.70.2024.11.04.08.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 08:22:22 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 4EE44164C05D; Mon, 04 Nov 2024 17:22:21 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, Andrii
 Nakryiko <andrii@kernel.org>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>,
 Magnus Karlsson <magnus.karlsson@intel.com>,
 nex.sw.ncis.osdt.itp.upstreaming@intel.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 09/18] page_pool: allow mixing PPs within
 one bulk
In-Reply-To: <1c32ebcd-ae94-42fb-9b18-726da532161f@intel.com>
References: <20241030165201.442301-1-aleksander.lobakin@intel.com>
 <20241030165201.442301-10-aleksander.lobakin@intel.com>
 <87ldy39k2g.fsf@toke.dk> <1c32ebcd-ae94-42fb-9b18-726da532161f@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 04 Nov 2024 17:22:21 +0100
Message-ID: <87y11z7yv6.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexander Lobakin <aleksander.lobakin@intel.com> writes:

> From: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> Date: Fri, 01 Nov 2024 14:09:59 +0100
>
>> Alexander Lobakin <aleksander.lobakin@intel.com> writes:
>>=20
>>> The main reason for this change was to allow mixing pages from different
>>> &page_pools within one &xdp_buff/&xdp_frame. Why not?
>>> Adjust xdp_return_frame_bulk() and page_pool_put_page_bulk(), so that
>>> they won't be tied to a particular pool. Let the latter create a
>>> separate bulk of pages which's PP is different and flush it recursively.
>>> This greatly optimizes xdp_return_frame_bulk(): no more hashtable
>>> lookups. Also make xdp_flush_frame_bulk() inline, as it's just one if +
>>> function call + one u32 read, not worth extending the call ladder.
>>>
>>> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
>>=20
>> Neat idea, but one comment, see below:
>
> [...]
>
>>> +	if (sub.count)
>>> +		page_pool_put_page_bulk(sub.q, sub.count, true);
>>> +
>>=20
>> In the worst case here, this function can recursively call itself
>> XDP_BULK_QUEUE_SIZE (=3D16) times. Which will blow ~2.5k of stack size,
>> and lots of function call overhead. I'm not saying this level of
>> recursion is likely to happen today, but who knows about future uses? So
>> why not make it iterative instead of recursive (same basic idea, but
>> some kind of 'goto begin', or loop, instead of the recursive call)?
>
> Oh, great idea!
> I was also unsure about the recursion here. Initially, I wanted header
> split frames, which usually have linear/header part from one PP and
> frag/payload part from second PP, to be efficiently recycled in bulks.
> Currently, it's not possible, as a bulk will look like [1, 2, 1, 2, ...]
> IOW will be flush every frame.
> But I realize the recursion is not really optimal here, just the first
> that came to my mind. I'll give you Suggested-by here (or
> Co-developed-by?), really liked your approach :>

Sure, co-developed-by SGTM :)

-Toke


