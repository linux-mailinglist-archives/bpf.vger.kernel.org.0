Return-Path: <bpf+bounces-72330-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B79C0E5C7
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 15:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C68BB462261
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 14:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7653730C358;
	Mon, 27 Oct 2025 14:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zy55zd0r"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5672A3074B4
	for <bpf@vger.kernel.org>; Mon, 27 Oct 2025 14:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761574204; cv=none; b=HSb1qOy26GpK0NUmNQ51UtPwdr5I4aAhwruvce5TbGl+0IooDqZUcaM1QPSjDpli5b58Q2ZgIDLHeQ5vsCyQrBqdEQewNN8074+4yBWjFgAwLBN3y+GwxfNzx5rG/I87acB6izPUZ0e/J83iZeeupaRxSAa+kkHvRasmhqB1jck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761574204; c=relaxed/simple;
	bh=c/b2hszdNWSGGPiPsuah9rJlkGjrnvDUJKdwp/b90Ko=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dI/VE/gcxqlGWtm6dlklmJibItkydyaVW64xQbV/0ltfMdVjg9xOgrVLWot0NjtfMRzq0DMBR/CNn9VUifIYaHtSwqNMhHu5keyNCLMAMJkoUlU0dK6uHfIar4LfZzxPPETRJG3C/iMcAqILb2P/YySHYQK5DA3zdr8VWYU6GO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zy55zd0r; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761574201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tg2geA8p0sRFySSG2RXc6meVS/0ic9dT0/zE/JSRh8I=;
	b=Zy55zd0rtdwQ1hiNfZr65SBxqiWPI+h4682gGyGW3deELznEhQO2zt/orJfsjJiBDdCxzR
	BbR4yczmFX/5MqVigP+UFtlI+mZJC0jLnjfP8VERdnhBFCCS4w3nWI6yGwxekFTlCYIMwW
	q9WtUgJRnWnDizdoBce/7dX36QEyrmE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-l7iD4a7VMGe68pC-zDexkA-1; Mon, 27 Oct 2025 10:09:59 -0400
X-MC-Unique: l7iD4a7VMGe68pC-zDexkA-1
X-Mimecast-MFC-AGG-ID: l7iD4a7VMGe68pC-zDexkA_1761574198
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b6d4025a85dso640590866b.0
        for <bpf@vger.kernel.org>; Mon, 27 Oct 2025 07:09:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761574198; x=1762178998;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tg2geA8p0sRFySSG2RXc6meVS/0ic9dT0/zE/JSRh8I=;
        b=QUM3J0HkXHXnDe/WvOaZH30wLZ5e7/TD8zf5HW50YGHPudoN+4fbJ/OsCj7ErGW82I
         thTgvPut/AwInr2ITVuV0amjF04foW2E2p8oNc8+ySUZZ7N7PDdOw7YeH6xRmmFVEGBJ
         mN2bDBNAqSH5AE4kBwGQAjcvngzqOtlE2tGAZjamPnOC6RCq/7Ng01xpM7o8ON/3Ilzy
         lOam8KkqqlkrYGv5EoO4ovDqW7bvqtPU3vKNU+ei3C+l3wBTh9CixRJWqAE13raV1YS4
         hghNMnuttB0HV/aX1feTQyY4YtRX0k3phomymDMaxlMLl8jkxP/vjbpQ+kdXM3sTKzGz
         J2KQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGa0IQIhttj+HQO1Z2mIJJCb0ESNsH5DbAOD9T/GLweZHwhSHlpf+pm6rGw5aZm/ZlTdY=@vger.kernel.org
X-Gm-Message-State: AOJu0YymW7RWHYLlUK5/TmTBllVaEdzxnN7gmPDTgOJn0mXQbI4uTC7I
	updv0WBBJvWpuPQMmyTZxeg7CJc/romVOf+g3rEF2UeZ8YLapPwtTWhVcwc3v8Rl7w4QmuIRpM4
	6QYpnRtXrDuiK2ZNTHuLCApJVTUWbJBX3rwm441IIF7JhhdiLyNkR3g==
X-Gm-Gg: ASbGncuNjibojQPPlbdFhyj0Vw8lYLOZmAoSNZVVdcLu2Jbg6t/H0TvxpV7RNdGVVW8
	veD3o1p57hajCiGcZRzSpJEycSdNkmS1P7CAQXsayQTXToyvEsYMOE6sbrxpOPemi7VQRsU1KlT
	OD17Es72hBagHmqcOap8fIiraTm1aVVoHG3o1vQlv19wVpXPqMPdvmk2VDiye3yFkGIuSS/mtGj
	6SRHJlMqYX0kzd5I4voDl+bS7CmJ8eq/vlcugVp3Nj296PODFOI1kqEvOOAaXcjxnIYnoaFJTtb
	/1lBDeCJFJnV14XHSc6Vq2SKN4hf9ZfDjNuWbLfLXGeC/wotzzt2S8dSpzMSHWoXIzwy5n3IhZq
	PFVEZjQXlXh/k+LFNm1vXWTkJDQ==
X-Received: by 2002:a17:907:3f1a:b0:b6d:5dbb:a1e1 with SMTP id a640c23a62f3a-b6db9bb910dmr24255966b.5.1761574198266;
        Mon, 27 Oct 2025 07:09:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/8knjSLXa1SdW98PmeawgWUwZqKG1Ot41zd6Wf0XrBei7Us98gOZPV8rEuLQW16NT4hMD4g==
X-Received: by 2002:a17:907:3f1a:b0:b6d:5dbb:a1e1 with SMTP id a640c23a62f3a-b6db9bb910dmr24253566b.5.1761574197854;
        Mon, 27 Oct 2025 07:09:57 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d8536cd11sm770722766b.31.2025.10.27.07.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 07:09:57 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 1F6EE2EAA54; Mon, 27 Oct 2025 15:09:56 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org,
 makita.toshiaki@lab.ntt.co.jp
Cc: Eric Dumazet <eric.dumazet@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, ihor.solodrai@linux.dev, toshiaki.makita1@gmail.com,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@cloudflare.com
Subject: Re: [PATCH net V1 1/3] veth: enable dev_watchdog for detecting
 stalled TXQs
In-Reply-To: <b6d13746-7921-4825-97cc-7136cdccafde@kernel.org>
References: <176123150256.2281302.7000617032469740443.stgit@firesoul>
 <176123157173.2281302.7040578942230212638.stgit@firesoul>
 <877bwkfmgr.fsf@toke.dk> <b6d13746-7921-4825-97cc-7136cdccafde@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 27 Oct 2025 15:09:56 +0100
Message-ID: <87v7k0e8qz.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jesper Dangaard Brouer <hawk@kernel.org> writes:

> On 24/10/2025 15.39, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Jesper Dangaard Brouer <hawk@kernel.org> writes:
>>=20
>>> The changes introduced in commit dc82a33297fc ("veth: apply qdisc
>>> backpressure on full ptr_ring to reduce TX drops") have been found to c=
ause
>>> a race condition in production environments.
>>>
>>> Under specific circumstances, observed exclusively on ARM64 (aarch64)
>>> systems with Ampere Altra Max CPUs, a transmit queue (TXQ) can become
>>> permanently stalled. This happens when the race condition leads to the =
TXQ
>>> entering the QUEUE_STATE_DRV_XOFF state without a corresponding queue w=
ake-up,
>>> preventing the attached qdisc from dequeueing packets and causing the
>>> network link to halt.
>>>
>>> As a first step towards resolving this issue, this patch introduces a
>>> failsafe mechanism. It enables the net device watchdog by setting a tim=
eout
>>> value and implements the .ndo_tx_timeout callback.
>>>
>>> If a TXQ stalls, the watchdog will trigger the veth_tx_timeout() functi=
on,
>>> which logs a warning and calls netif_tx_wake_queue() to unstall the que=
ue
>>> and allow traffic to resume.
>>>
>>> The log message will look like this:
>>>
>>>   veth42: NETDEV WATCHDOG: CPU: 34: transmit queue 0 timed out 5393 ms
>>>   veth42: veth backpressure stalled(n:1) TXQ(0) re-enable
>>>
>>> This provides a necessary recovery mechanism while the underlying race
>>> condition is investigated further. Subsequent patches will address the =
root
>>> cause and add more robust state handling in ndo_open/ndo_stop.
>>>
>>> Fixes: dc82a33297fc ("veth: apply qdisc backpressure on full ptr_ring t=
o reduce TX drops")
>>> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
>>> ---
>>>   drivers/net/veth.c |   16 +++++++++++++++-
>>>   1 file changed, 15 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
>>> index a3046142cb8e..7b1a9805b270 100644
>>> --- a/drivers/net/veth.c
>>> +++ b/drivers/net/veth.c
>>> @@ -959,8 +959,10 @@ static int veth_xdp_rcv(struct veth_rq *rq, int bu=
dget,
>>>   	rq->stats.vs.xdp_packets +=3D done;
>>>   	u64_stats_update_end(&rq->stats.syncp);
>>>=20=20=20
>>> -	if (peer_txq && unlikely(netif_tx_queue_stopped(peer_txq)))
>>> +	if (peer_txq && unlikely(netif_tx_queue_stopped(peer_txq))) {
>>> +		txq_trans_cond_update(peer_txq);
>>>   		netif_tx_wake_queue(peer_txq);
>>> +	}
>>=20
>> Hmm, seems a bit weird that this call to txq_trans_cond_update() is only
>> in veth_xdp_recv(). Shouldn't there (also?) be one in veth_xmit()?
>>=20
>
> The veth_xmit() call (indirectly) *do* update the txq_trans start
> timestamp, but only for return code NET_RX_SUCCESS / NETDEV_TX_OK.
> As .ndo_start_xmit =3D veth_xmit and netdev_start_xmit[1] will call
> txq_trans_update on NETDEV_TX_OK.

Ah, right; didn't think of checking the caller, thanks for the pointer :)

> This call to txq_trans_cond_update() isn't strictly necessary, as
> veth_xmit() call will update it later, and the netif_tx_stop_queue()
> call also updates trans_start.
>
> I primarily added it because other drivers that use BQL have their
> helper functions update txq_trans.  As I see the veth implementation as
> a simplified BQL, that we hopefully can extend to become more dynamic
> like BQL.
>
> Do you prefer that I remove this?  (call to txq_trans_cond_update)

Hmm, don't we need it for the XDP path? I.e., if there's no traffic
other than XDP_REDIRECT traffic, ndo_start_xmit() will not get called,
so we need some way other to keep the watchdog from firing, I think?

-Toke


