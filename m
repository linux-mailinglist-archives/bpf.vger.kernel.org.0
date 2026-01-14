Return-Path: <bpf+bounces-78892-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F065D1ECB4
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 13:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D301C301FF4A
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 12:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C04A396B91;
	Wed, 14 Jan 2026 12:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="OPWt0T5P"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com [209.85.210.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C9C389E1F
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 12:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768393989; cv=none; b=TEeQnDJ0RwodSeodP5l306vqeXcfzYCl4PBqj+aXz4624yb+rFN38p07s1UIFhR037W25KLAC/6vaGwb21DEXV5EmhcVBCWiO2xWQiOFKEqJzI1THgW+7r3oSVYbZ5gYe/MW6QzUNkBDN48VS2RDzmu1Au9ir32BkpTF1bKapWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768393989; c=relaxed/simple;
	bh=agxatYm5mUbN++KbSQ9n748/3c6GkMV4Ub9NYi5fR9k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pZlWDQF3x1HxabJ51rpVVSnLFcTVALzm1FiyNiH63WsBpGRJoj30WqaZrCk+9gnLTX2iV4BN+pjFvkMDut5jQ0zs9AMF8MuKQPMyiT6Ga20WrPNyHdD/F7MZ/+5o9uekRGUISrQwMl+XLZeZW3a1yiMoRUYpQ1/82cZNltlLvXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=OPWt0T5P; arc=none smtp.client-ip=209.85.210.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ot1-f67.google.com with SMTP id 46e09a7af769-7c95936e43cso3329911a34.0
        for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 04:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1768393986; x=1768998786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W/79JQOY2vgvGddRC2TVOlm5nKGEv4fVyeyaPqhKG7U=;
        b=OPWt0T5PNVJSyu0HLdsVezlHTiUL7hIUxXyd980iPwDtaEl5yHRywAS5IyBh6TCXIo
         ni2ZjaBanCu9XFGHYSZtq7ZLb2De/VOqF3PUKVnVJ/6kN4BgxhcftEc/7WTFRpKG/8D4
         VczpN6kNNThmV3Dzix/KBWl/lxaINyoNUTRqwWUrd5tZ0c161IZomu0AI4FAH3jcD+ns
         yB7WGeGtk7RhM8XUIjfRiOUSFVWf7/xsRa2yyf4cFfzmJZ+bwPNkoeamjoTU0BU+TEqY
         NOLazlf4eY+5NBR1K/dN719m1+FFeBdAjIgqDhcenmN5ZuzkeYdTbEmXxNX6H0lBIIbA
         WxmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768393986; x=1768998786;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=W/79JQOY2vgvGddRC2TVOlm5nKGEv4fVyeyaPqhKG7U=;
        b=Kvic5k5Oc0favd8r6QStyH8O7xlTtVULcSomBgZugtBEXlQWrKkrfdmbLeqoc3WVVw
         LMp1ptVd4NHKuXVfhx6+ggMRFI+7rnQE+1+RVOLkx/h1m0Nzk9iwy3Ft7mp4GcFJuJkY
         O2iAdgviy+ytEQxETqF0ue5J8SdcKoJZ6F1K4IO0PDei9atHPWIN39ar8LfQVXF3izFM
         FA1B8q+05SEdjYjXB3tco8CigViOg5QWNgYrC4jx96PLG+HayE9i/dd/d+qtvEhqtlUR
         iBMgWa9QMxGKHJYqhK8SFhm9FkgmuTJ2oovlWSjOnLalJRxsAdUiRQy6ukTxv/SKS38v
         wl6A==
X-Forwarded-Encrypted: i=1; AJvYcCXjLfsaiG+TogsQSZoEoUYOpsD1Vn0NrZtfIefOf1cn1m9HIucgXyCpmenTmt3FikwNR40=@vger.kernel.org
X-Gm-Message-State: AOJu0YywGKQ+Ee9i1fmZOsU/YsZOsojKpDLFkjeKPA9GEoL5wPrt56z8
	GRjzLYoQ9Ybi1bkx8LKszQCNU3XhUAab+2ePXiVsMiDYpe+QEkRCd4G96mlDH3Ra29I=
X-Gm-Gg: AY/fxX60VGViQWHAVVOImSa4q98mdoRFkthk9jIXM9+BJHo1E55tbyhlSKAwSayeggc
	kLTDNLNyiJQi2GZlj6ccnbIUMNtakVgLl1kC12lRtasXJ6IBbuz7NM5iTwfz3+fIsIgpJWunUWD
	T11aBD9Cb0Oa57J7ykLGCZICs6EhKOBg3Tj3RlfmUaOimmyanYiJrL9Qprihzpw/ULEHT8UE9Yc
	pusJG52uFqwmT+JHSodKfLz4epGbF0pi1Pq7aU6gO5p03j8AsdlK9Aca+u8KgVeeXJ7I9uKoAfw
	knMXISUwYq0ZliqTujNrkN6ickYyF9PhQ635o2EVYm6FxzTGHhZ/MQFLY9RwHBUPqNDaiKrRZjd
	LhtN8e0bojj492K6wjTV1SIf4r5vnBBMi7K9DEG5wpGzJipdKvGLYpaf138A4ktlqP1iqpDZHsI
	aikdw=
X-Received: by 2002:a05:6808:318d:b0:450:471:b9ba with SMTP id 5614622812f47-45c714302ddmr1785761b6e.14.1768393986332;
        Wed, 14 Jan 2026 04:33:06 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:bd])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ce478d9c17sm18199756a34.22.2026.01.14.04.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 04:33:05 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,  Alexei Starovoitov
 <ast@kernel.org>,  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni
 <pabeni@redhat.com>,  netdev@vger.kernel.org,  "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Simon Horman
 <horms@kernel.org>,  Michael Chan <michael.chan@broadcom.com>,  Pavan
 Chebbi <pavan.chebbi@broadcom.com>,  Andrew Lunn <andrew+netdev@lunn.ch>,
  Tony Nguyen <anthony.l.nguyen@intel.com>,  Przemek Kitszel
 <przemyslaw.kitszel@intel.com>,  Saeed Mahameed <saeedm@nvidia.com>,  Leon
 Romanovsky <leon@kernel.org>,  Tariq Toukan <tariqt@nvidia.com>,  Mark
 Bloch <mbloch@nvidia.com>,  Daniel Borkmann <daniel@iogearbox.net>,  John
 Fastabend <john.fastabend@gmail.com>,  Stanislav Fomichev
 <sdf@fomichev.me>,  intel-wired-lan@lists.osuosl.org,
  bpf@vger.kernel.org,  kernel-team@cloudflare.com,  Jesse Brandeburg
 <jbrandeburg@cloudflare.com>,  Willem Ferguson <wferguson@cloudflare.com>,
  Arthur Fabre <arthur@arthurfabre.com>
Subject: Re: [Intel-wired-lan] [PATCH net-next 00/10] Call skb_metadata_set
 when skb->data points past metadata
In-Reply-To: <878qe01kii.fsf@toke.dk> ("Toke =?utf-8?Q?H=C3=B8iland-J?=
 =?utf-8?Q?=C3=B8rgensen=22's?= message of
	"Wed, 14 Jan 2026 12:49:57 +0100")
References: <20260110-skb-meta-fixup-skb_metadata_set-calls-v1-0-1047878ed1b0@cloudflare.com>
	<20260112190856.3ff91f8d@kernel.org>
	<36deb505-1c82-4339-bb44-f72f9eacb0ac@redhat.com>
	<bd29d196-5854-4a0c-a78c-e4869a59b91f@kernel.org>
	<87wm1luusg.fsf@cloudflare.com> <878qe01kii.fsf@toke.dk>
Date: Wed, 14 Jan 2026 13:33:03 +0100
Message-ID: <87ecnsv0g0.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026 at 12:49 PM +01, Toke H=C3=B8iland-J=C3=B8rgensen wrot=
e:
> Jakub Sitnicki via Intel-wired-lan <intel-wired-lan@osuosl.org> writes:
>
>> On Tue, Jan 13, 2026 at 07:52 PM +01, Jesper Dangaard Brouer wrote:
>>> *BUT* this patchset isn't doing that. To me it looks like a cleanup
>>> patchset that simply makes it consistent when skb_metadata_set() called.
>>> Selling it as a pre-requirement for doing copy later seems fishy.
>>=20=20
>> Fair point on the framing. The interface cleanup is useful on its own -
>> I should have presented it that way rather than tying it to future work.
>>
>>> Instead of blindly copying XDP data_meta area into a single SKB
>>> extension.  What if we make it the responsibility of the TC-ingress BPF-
>>> hook to understand the data_meta format and via (kfunc) helpers
>>> transfer/create the SKB extension that it deems relevant.
>>> Would this be an acceptable approach that makes it easier to propagate
>>> metadata deeper in netstack?
>>
>> I think you and Jakub are actually proposing the same thing.
>>=20=20
>> If we can access a buffer tied to an skb extension from BPF, this could
>> act as skb-local storage and solves the problem (with some operational
>> overhead to set up TC on ingress).
>>=20=20
>> I'd also like to get Alexei's take on this. We had a discussion before
>> about not wanting to maintain two different storage areas for skb
>> metadata.
>>=20=20
>> That was one of two reasons why we abandoned Arthur's patches and why I
>> tried to make the existing headroom-backed metadata area work.
>>=20=20
>> But perhaps I misunderstood the earlier discussion. Alexei's point may
>> have been that we don't want another *headroom-backed* metadata area
>> accessible from XDP, because we already have that.
>>=20=20
>> Looks like we have two options on the table:
>>=20=20
>> Option A) Headroom-backed metadata
>>   - Use existing skb metadata area
>>   - Patch skb_push/pull call sites to preserve it
>>=20=20
>> Option B) Extension-backed metadata
>>   - Store metadata in skb extension from BPF
>>   - TC BPF copies/extracts what it needs from headroom-metadata
>>=20=20
>> Or is there an Option C I'm missing?
>
> Not sure if it's really an option C, but would it be possible to
> consolidate them using verifier tricks? I.e., the data_meta field in the
> __sk_buff struct is really a virtual pointer that the verifier rewrites
> to loading an actual pointer from struct bpf_skb_data_end in skb->cb. So
> in principle this could be loaded from an skb extension instead with the
> BPF programs being none the wiser.
>
> There's the additional wrinkle that the end of the data_meta pointer is
> compared to the 'data' start pointer to check for overflow, which
> wouldn't work anymore. Not sure if there's a way to make the verifier
> rewrite those checks in a compatible way, or if this is even a path we
> want to go down. But it would be a pretty neat way to make the whole
> thing transparent and backwards compatible, I think :)

I gave it a shot when working on [1]. Here's the challenge:

1) Keep the skb->data_meta + N <=3D skb->data checks working

This is what guarantees that your BPF program won't access memory
outside of the metadata area. So you can't rewrite the skb->data_meta
pseudo-pointer load. This means you must...

2) Patch the skb->data_meta pointer dereference after the check

Since deref happens at some unknown point after the skb->data_meta
pointer load, you may no longer have the context pointer in any of the
registers.

You might be able to hack it by spilling the context pointer to the
stack in the prologue, like I've seen bpf_qdisc does. But that I haven't
tried.

In general, I view it as a seconary issue since you can use a BPF dynptr
to access the skb metadata. It was exactly for that reason - to hide the
fact where the metadata is actually located.

> Other than that, I like the extention-backed metadata idea!

That's what I'm going to work on. I look at it as an skb local storage
backed by an skb extension.

If the user wants to transfer the contents of the skb metadata into
local storage, they can. But the extra allocation is their decision.

[1] https://lore.kernel.org/r/20260110-skb-meta-fixup-skb_metadata_set-call=
s-v1-0-1047878ed1b0@cloudflare.com

