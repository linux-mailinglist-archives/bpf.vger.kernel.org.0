Return-Path: <bpf+bounces-20318-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A74FF83C07B
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 12:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22C6A1F22BD7
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 11:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4E94EB52;
	Thu, 25 Jan 2024 11:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ieBxRKOy"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB80E604A4
	for <bpf@vger.kernel.org>; Thu, 25 Jan 2024 11:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706180795; cv=none; b=N/ciRc7cyVh15WePc4EAF/oPhbHHdp1HiViwP3BoKwyAQGWxVztPyoPwHuz3i69jFJQVRToa10906a/NGFzsNGrXYy+4sgolXRINVTysapxOzCywOYL98iUQnPt57vMqKctagBBHw5CNDZuNRxkVdsauqRHPnGIdfZ+tO3JVk8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706180795; c=relaxed/simple;
	bh=ZJk0xpPMa3t2mYdKWt7MDzWgv3yHSzopPAA3GNGemRY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=raXtxwm+YEPE/g9yK4JXi+xaYTslDIPeIxETeLUoyS7nzZs4aiSacPZZBkjhj66YtbpU79Ewsk/v+k2HNhdPQ4O0rFmmdD7ZgXOBzMOLPgmRcIsmIH82PLC/lJ0H0flstFJTBV9U5vgTrhpUcI7UXn67iJF6aMAS3/7FZBWyuxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ieBxRKOy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706180792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kxzMdo5QLZghYmzpfczCGRvpkbC6Ut7EEG0GYUfBWIQ=;
	b=ieBxRKOyGIvfVnj8iMFLE9X+GXhyxy2m4nx7ua5zWRK+lSrHN3X0lCS55d8yupPG+soq6u
	dZIr1HXPQbiXVu0LC7HS8KSGYBknUdRxjyK89KuwWpEYRwp6jjliFQE5oq4+RPcCiiuCoA
	tLN4V7uen0ngcxJaQWOjnMbNAS+ZD+A=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-r5T33P46MrCfcAaKXRsdJQ-1; Thu, 25 Jan 2024 06:06:31 -0500
X-MC-Unique: r5T33P46MrCfcAaKXRsdJQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40e4cb5349eso17524035e9.0
        for <bpf@vger.kernel.org>; Thu, 25 Jan 2024 03:06:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706180790; x=1706785590;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kxzMdo5QLZghYmzpfczCGRvpkbC6Ut7EEG0GYUfBWIQ=;
        b=iTHMzzWW337rbN0T6HwumRHPv16EjbeDgCvt5exaZM081y3aUSzhv04KQXOcNo+4Iv
         A3POr8pmlXAXgxmyL0ZQFo9Vm4R3Gbir6CVnMZZRD1DgcJfM8AVjrljjqn1ullOWU0OP
         koYT+siyviSW3l6iOSGBmanUJdouEwDMaaTJMbaBMNFLZ0Wh3eFDye8BTlXz84Kmpau9
         1z3LwLNCr5g4Vp/XVTuW/bV1WIWwJIYsIX+CkJttaiO1h+Ls6bnswn7tGk0tqhobI8wZ
         KIAPA2kDzzvc8wMYsJAUrWm52Q2R8oP6+49NGS3LypuuLY6kBBM4/PqtZVurAJSh7XV0
         dRcA==
X-Gm-Message-State: AOJu0Ywod+scIT7GvBMIBFOyBLuaCVlWtQ29chj7DlL3uJsBHpnLt8AO
	Euw4oR8Vub8NOlZyAIGXiCVWOyxcexppzWVaDkYUpkm6EO9ykJ8mCFj4oiTb99qCfXi6fapsjUP
	EzdaMMB58QAWgZ6BFV0zq36iMk24gDbMBR87hcArLKXXuPtKvSQ==
X-Received: by 2002:adf:b350:0:b0:337:c50c:27d7 with SMTP id k16-20020adfb350000000b00337c50c27d7mr1058459wrd.7.1706180790239;
        Thu, 25 Jan 2024 03:06:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH0uvGSo9klS9hJy5VwC070zN5LlPahX+RNQo9/G8Bqs9hKEY2jKWPo/WCiSnreJ+wqPK6Z+w==
X-Received: by 2002:adf:b350:0:b0:337:c50c:27d7 with SMTP id k16-20020adfb350000000b00337c50c27d7mr1058439wrd.7.1706180789856;
        Thu, 25 Jan 2024 03:06:29 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-244-75.dyn.eolo.it. [146.241.244.75])
        by smtp.gmail.com with ESMTPSA id e7-20020a5d65c7000000b00337d6db207dsm16998584wrw.30.2024.01.25.03.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 03:06:29 -0800 (PST)
Message-ID: <41a9cd95c940aeb418f45a1d4e3ff4b0e8f62d5a.camel@redhat.com>
Subject: Re: [PATCH net 2/2] tsnep: Fix XDP_RING_NEED_WAKEUP for empty fill
 ring
From: Paolo Abeni <pabeni@redhat.com>
To: Gerhard Engleder <gerhard@engleder-embedded.com>,
 netdev@vger.kernel.org,  bpf@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 bjorn@kernel.org,  magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
  jonathan.lemon@gmail.com
Date: Thu, 25 Jan 2024 12:06:28 +0100
In-Reply-To: <20240123200918.61219-3-gerhard@engleder-embedded.com>
References: <20240123200918.61219-1-gerhard@engleder-embedded.com>
	 <20240123200918.61219-3-gerhard@engleder-embedded.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-01-23 at 21:09 +0100, Gerhard Engleder wrote:
> The fill ring of the XDP socket may contain not enough buffers to
> completey fill the RX queue during socket creation. In this case the
> flag XDP_RING_NEED_WAKEUP is not set as this flag is only set if the RX
> queue is not completely filled during polling.
>=20
> Set XDP_RING_NEED_WAKEUP flag also if RX queue is not completely filled
> during XDP socket creation.
>=20
> Fixes: 3fc2333933fd ("tsnep: Add XDP socket zero-copy RX support")
> Signed-off-by: Gerhard Engleder <gerhard@engleder-embedded.com>
> ---
>  drivers/net/ethernet/engleder/tsnep_main.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/engleder/tsnep_main.c b/drivers/net/eth=
ernet/engleder/tsnep_main.c
> index d380a407e175..ae0b8b37b9bf 100644
> --- a/drivers/net/ethernet/engleder/tsnep_main.c
> +++ b/drivers/net/ethernet/engleder/tsnep_main.c
> @@ -1764,6 +1764,19 @@ static void tsnep_rx_reopen_xsk(struct tsnep_rx *r=
x)
>  			allocated--;
>  		}
>  	}
> +
> +	/* set need wakeup flag immediately if ring is not filled completely,
> +	 * first polling would be too late as need wakeup signalisation would
> +	 * be delayed for an indefinite time
> +	 */
> +	if (xsk_uses_need_wakeup(rx->xsk_pool)) {
> +		int desc_available =3D tsnep_rx_desc_available(rx);
> +
> +		if (desc_available)
> +			xsk_set_rx_need_wakeup(rx->xsk_pool);
> +		else
> +			xsk_clear_rx_need_wakeup(rx->xsk_pool);
> +	}
>  }
> =20
>  static bool tsnep_pending(struct tsnep_queue *queue)

The patch LGTM, but there is a very similar chunk of code in
tsnep_rx_poll_zc(). You should consider a net-next follow-up
consolidating the code in a common helper.

Cheers,

Paolo


