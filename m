Return-Path: <bpf+bounces-78882-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15834D1E99E
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 12:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C830430F49AC
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 11:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A365399A54;
	Wed, 14 Jan 2026 11:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BpGURl9H";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="S25VXouS"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A3C396B8F
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 11:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768391407; cv=none; b=JE9jpVQMq4A3Qq42gar7dZcuUfaagSyj+QX5UEgspu8vDOCk/Sv9XquCYgt2sffOWKwpK/V0qIag2en617um6jmCGYVyWdXtwZRaoNLFTHETI8U9mzKw4TjPLobeXxtFDzzxxRh/ENyeIQKxgXeDKovI0CtkJS55LkqxIJjcatk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768391407; c=relaxed/simple;
	bh=UtKOf3/Ud2MKlYgnqMe/64gZ7wIz9Cjsm2A2iZSp4m4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Q+OlWlfuD3+iUvaoePTr0bKv9HdVPZOOD1vMp9+AGktyMNLFcDo7kLPGO3YMokT9JZbKC1ep3UHj7ooxuPa6tQy2siPMBgBg7QMIAmM+7xn2hbDcMw04Omb9udo0OCIWjvGPvyMEW31FzKVPlenono4Q1jT1GqcdFyt6ULUlbrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BpGURl9H; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=S25VXouS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768391403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q8uX03BZl5AjAdWG8Y9fY1QPxmLXeoAmQaAzEsbqKH8=;
	b=BpGURl9H+VWGUzBzXZpdz2X2LK3mv94Yn3K6+MssSKUSnswnwM0QiVH0G9DcaFSqB2rtPO
	fUt1s+S7sRz84vqvsfGivHzDBVx+9djiboP6oQl0gSUxmL+aI0v+S/ESZWI93uHWumilWJ
	Zkt7xbNuCRvFrlEx+nr7g6tW4iveZq0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-jr9yhr1JOVaDpmmOPKa0rw-1; Wed, 14 Jan 2026 06:50:02 -0500
X-MC-Unique: jr9yhr1JOVaDpmmOPKa0rw-1
X-Mimecast-MFC-AGG-ID: jr9yhr1JOVaDpmmOPKa0rw_1768391402
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-64b735f514dso10709609a12.3
        for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 03:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768391401; x=1768996201; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=q8uX03BZl5AjAdWG8Y9fY1QPxmLXeoAmQaAzEsbqKH8=;
        b=S25VXouSyxBbwa293SNB/yOE5a2zByfoZcGbBWXRtwh006CQX0OCpY3sI2m5AmHV2T
         IO1wjOwVUKng+845UMeyHO6ZMFNOyfYf4Oqhzp7V8rKuLb89vMfXfRMKAd0+BCumSvQG
         n/cosn7kK5vXEIToASao05HijQlFXipA/Gcz7pMUItiSeE0K1uO9CNT06jfMZvegSlyH
         mUtHhCNQCbgL5u19Mh7I295ufbpKqIkKNBHI6xTzTDHNzuNHvIA3X1VCMiOS/hj5BGob
         lCGbjhvLeNHMtc6ckjzlwRv5k9XfRVHDEnPew2cQkp2C4cnvNNhVMTNVJeuRYnV/Pz2Y
         Ezcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768391401; x=1768996201;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q8uX03BZl5AjAdWG8Y9fY1QPxmLXeoAmQaAzEsbqKH8=;
        b=luwoZI5N81CXXgfRVShfz7YawmzHvBtgb0BscDb1QP/L/uf82HZxwgn7Us16gNNfUO
         /0V8+1xYkxf51KaA5IHgff/B7CFompPOV+C+Mxfm04+UdP7Yev3Im/WCN+n0UUhA3WLj
         aelYFXBKDw7oSixewJTSWFvLnpouDvcD0AUbOgZ7re46H+XPa0X0tpNVESuHJL9YHfrv
         2k0IPlW28tDoFJfMdTBjZr09Nic+71wBlvvnXzxIu6jbCDSXEi5Te2u4MJ7IJeHisKEC
         BP0UPsRmM6EKwhtE7SLi9gtjwMgSptWu3/WK2X58yFqKVIGULP3V4wnmmP9PrM4MT1V8
         C+FQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJ6QIxKa3+wzy7eVXmdUT5E+BXFeLovOM4KVDbefqjcVxf12YKi8A1mX0vqblPEVovpoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3qDYOohJmWqia7zHyobjeagx/1crYd746roV/BU5uQYHw6LV4
	OibiZhkLjvS2ZeOyP91zcKo0PYbS2ky7+LCb278Hgufl1JqqimN9Tq8Sos2pSFZiP49WCbqYNI8
	KvySqnV7yqeAiDW93rUC0f1eirq482EXFID4sAqJzidKzqqloDXHSUw==
X-Gm-Gg: AY/fxX5PpTDptsofYpVO1Y5nomUVk2RL/A36IsIvB9kBRHuEouWG44KqgM/meBzsdqA
	y/Dm43uzeTBAI/pZF4dtH/gfFO9bbBsiYDyaMcF5fnosFY12zUz1XzkQFUG9ClvG0YXZpEHxaUY
	uVkIYwe1/R078Hi7gjIOjwmSr68cZHVNKY3x3ekLW+7bx7WAk4n3JmcepncTBWWvTfwSfz3J05v
	pt7OzT8QIih/xQQY8iicaTHALC9hW8lvRWP+duUN4OeP25wT91+6SAKqQl7e7P9RHbDiGSri16o
	ldS7N/oKNHRpjflhnPmTEXHdCbI4Q4CYE4q3UinbJ7QndEMx4IUhn0V086BXDcpeEFNyuKY9yXr
	luNOF1jNCW6FuHEWVUyhThTlGZFg7BjcNTg==
X-Received: by 2002:a17:907:94c4:b0:b87:2d0f:d417 with SMTP id a640c23a62f3a-b8760fe0baamr179681566b.14.1768391401366;
        Wed, 14 Jan 2026 03:50:01 -0800 (PST)
X-Received: by 2002:a17:907:94c4:b0:b87:2d0f:d417 with SMTP id a640c23a62f3a-b8760fe0baamr179679266b.14.1768391400849;
        Wed, 14 Jan 2026 03:50:00 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b86ebfd007fsm1294372966b.31.2026.01.14.03.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 03:50:00 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id CA9A8408B76; Wed, 14 Jan 2026 12:49:57 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jakub Sitnicki <jakub@cloudflare.com>, Jesper Dangaard Brouer
 <hawk@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Jakub Kicinski
 <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, Michael
 Chan <michael.chan@broadcom.com>, Pavan Chebbi
 <pavan.chebbi@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Tony
 Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon
 Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
 <mbloch@nvidia.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, intel-wired-lan@lists.osuosl.org,
 bpf@vger.kernel.org, kernel-team@cloudflare.com, Jesse Brandeburg
 <jbrandeburg@cloudflare.com>, Willem Ferguson <wferguson@cloudflare.com>,
 Arthur Fabre <arthur@arthurfabre.com>
Subject: Re: [Intel-wired-lan] [PATCH net-next 00/10] Call skb_metadata_set
 when skb->data points past metadata
In-Reply-To: <87wm1luusg.fsf@cloudflare.com>
References: <20260110-skb-meta-fixup-skb_metadata_set-calls-v1-0-1047878ed1b0@cloudflare.com>
 <20260112190856.3ff91f8d@kernel.org>
 <36deb505-1c82-4339-bb44-f72f9eacb0ac@redhat.com>
 <bd29d196-5854-4a0c-a78c-e4869a59b91f@kernel.org>
 <87wm1luusg.fsf@cloudflare.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 14 Jan 2026 12:49:57 +0100
Message-ID: <878qe01kii.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Sitnicki via Intel-wired-lan <intel-wired-lan@osuosl.org> writes:

> On Tue, Jan 13, 2026 at 07:52 PM +01, Jesper Dangaard Brouer wrote:
>> *BUT* this patchset isn't doing that. To me it looks like a cleanup
>> patchset that simply makes it consistent when skb_metadata_set() called.
>> Selling it as a pre-requirement for doing copy later seems fishy.
>  
> Fair point on the framing. The interface cleanup is useful on its own -
> I should have presented it that way rather than tying it to future work.
>
>> Instead of blindly copying XDP data_meta area into a single SKB
>> extension.  What if we make it the responsibility of the TC-ingress BPF-
>> hook to understand the data_meta format and via (kfunc) helpers
>> transfer/create the SKB extension that it deems relevant.
>> Would this be an acceptable approach that makes it easier to propagate
>> metadata deeper in netstack?
>
> I think you and Jakub are actually proposing the same thing.
>  
> If we can access a buffer tied to an skb extension from BPF, this could
> act as skb-local storage and solves the problem (with some operational
> overhead to set up TC on ingress).
>  
> I'd also like to get Alexei's take on this. We had a discussion before
> about not wanting to maintain two different storage areas for skb
> metadata.
>  
> That was one of two reasons why we abandoned Arthur's patches and why I
> tried to make the existing headroom-backed metadata area work.
>  
> But perhaps I misunderstood the earlier discussion. Alexei's point may
> have been that we don't want another *headroom-backed* metadata area
> accessible from XDP, because we already have that.
>  
> Looks like we have two options on the table:
>  
> Option A) Headroom-backed metadata
>   - Use existing skb metadata area
>   - Patch skb_push/pull call sites to preserve it
>  
> Option B) Extension-backed metadata
>   - Store metadata in skb extension from BPF
>   - TC BPF copies/extracts what it needs from headroom-metadata
>  
> Or is there an Option C I'm missing?

Not sure if it's really an option C, but would it be possible to
consolidate them using verifier tricks? I.e., the data_meta field in the
__sk_buff struct is really a virtual pointer that the verifier rewrites
to loading an actual pointer from struct bpf_skb_data_end in skb->cb. So
in principle this could be loaded from an skb extension instead with the
BPF programs being none the wiser.

There's the additional wrinkle that the end of the data_meta pointer is
compared to the 'data' start pointer to check for overflow, which
wouldn't work anymore. Not sure if there's a way to make the verifier
rewrite those checks in a compatible way, or if this is even a path we
want to go down. But it would be a pretty neat way to make the whole
thing transparent and backwards compatible, I think :)

Other than that, I like the extention-backed metadata idea!

-Toke


