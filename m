Return-Path: <bpf+bounces-74945-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B0FC693CE
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 13:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 728122AA3F
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 12:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E45A350A21;
	Tue, 18 Nov 2025 12:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DzydCrSA";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="E0Kbg3Gc"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EB1314D03
	for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 12:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763467350; cv=none; b=GM983y7Uk97flRWq9H3EBsGru0SJZsrhAgjKOb2kjynA27dxFIsldr4BdqQUBA61wbeM+VSQYUeYzETuGcHxorP0OSMhw2Awz+VP7lsqXHQolER0cWxj6QGkdsKbN0W0dbNREP+OSUwH6RqyQyawBFGGmo8TDCSxfZ90OnUd184=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763467350; c=relaxed/simple;
	bh=WESiHmXnNlbdDWvUDg2JYyETEusd8ierS+wGRLf1eUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mktZPtUfwP7QSpRtzFkL21eGHL2rRbe+uC8Cz+6IprffG9GdJgrUYKGKU2mT5S3ibm1sDILiCWHRd7DEGSCBYcpFNUSGhY9zolrZd/CgCNtPUFkCAy8ua34U8eH0ax4Hy1g4wIFi0bgF4yS/mWzjcjNAR307GphY7eGOEpthgcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DzydCrSA; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=E0Kbg3Gc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763467347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c1i1D0Pw7oFyRhkqVPQdxod01xxz5lck/BaJyW2U7Kc=;
	b=DzydCrSALxKCMAu1SZI0AR/MCAgYGmYRytC3yOgZ66aXNGpA45vP8kzecZ7xs45GC+G9z4
	5Yss63XLg5aSGOxe42zMiJ0xg4HhNYBvlbH7fPXsH1fyy09SdrRG2Mj1Y0JqOkf27J7hFx
	dOUk1QBm2PRNbYT48QZPyJs7gAl4os0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587--A9aTyb9N32tIzA6CJ760w-1; Tue, 18 Nov 2025 07:02:25 -0500
X-MC-Unique: -A9aTyb9N32tIzA6CJ760w-1
X-Mimecast-MFC-AGG-ID: -A9aTyb9N32tIzA6CJ760w_1763467345
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-477a11d9e67so16123785e9.2
        for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 04:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763467344; x=1764072144; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c1i1D0Pw7oFyRhkqVPQdxod01xxz5lck/BaJyW2U7Kc=;
        b=E0Kbg3GcB0dKj4v2Ff5snuUYZuywDBnduS0yK16ebfoJo91N6Hya22k6cHPx90SZmN
         gmLcROhmKwfZtLNeKAH78C3l/BNokIQCUeKC5lwdMmfvPsCCj81DkEP3j2Y85y9Kni9r
         3ZwQrB6drltv7nu6JiXASxlPTgDHLMWJYtMrmT9VvgGHRxg+awZA+xhk6bWVDkr+DGMa
         eBALnrq6fM2ETp8LYUzM8tM+iyg4gkU7t/wjDC/mp5IlcglGS1Ub7kQBHyoyKWOKjDw6
         +gOOzmrf4wRfLkWI5EwanMs6PpM7ZuIOalvGJkUggEWAp2eP8j7hqf6Si99ywUVFUdOP
         nCEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763467344; x=1764072144;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c1i1D0Pw7oFyRhkqVPQdxod01xxz5lck/BaJyW2U7Kc=;
        b=B3n812i2ebGo5FjTylEvGylU2zBi+opqz68OcYqUtZ7XrxafkEA0RRlJuE1MHgydq/
         kyTjbHYnUbIGAiO8VWHHA+KWgZSTQ/m+tsYa92ms7xmtjIgoZzG0dbINlVh6rBqx5u3/
         myJ61euF7SiFZ7jsXOwGjKovfeo7iY8zDSjcjIFjofnnwZjjyVfMrAtJqEfCJSB4bKTj
         V+tyIdFCorOqnvDQ2sOHOKH+CuAxeauR/h/qKiYDfy3tVe3Md9akw9qLU+5A/vQKWmpc
         ctOlv3EntwK9UkZgtloneBSJlwmJy0O0eRPPJ+LVnjJKNpH7pKZLP7FfQxqi5G1Dfxxr
         fCtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVibTSyJqLpMWwMRfcEzo9PX9gdrtGwyO3z+WF4i6yMSUhJdHB517YSa0PDHy9AG56Avb0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZKM+hKgo+lcM+RI8cVsEgjVAVt936Rm8PH1ehAVp6QfGVhUea
	Fudy5q4IEz7R60CY5Z2SJe+QnVb6expo4sMiZwUD5DhAvn5cYhm2czoYMHdwRrejPO19HwTR8wr
	moYUksvAWccwmEgBCSj1VrVYi/zwKTO5H20XJSQo5tH9KH66q6OSNRA==
X-Gm-Gg: ASbGncsBF2z+ytUkWiVczTkymZRgcknl6RWPsQuwKR9JtjBQsrAv0/PF76ZMMZVYokS
	pE5IXouoHAJ7t5/UYiRGuctmoq02PtWWfgIIOAGBnG92qlnqpLzewiyJocEJXjw4tG4HeFzSgKa
	VF/M66I8WAVSr/rD80r6fYhX2svWTZ9nR7oU+l8a/RJg98rGJFOjSxeS/grzCij8YN7Qteb8oVs
	5xeMQoDRl96bO1QT5wPWYLcMyaZHl2+8K5mNRlPZViuNNOAQbouyk+MmNDiExkAbjCkzv8FBRBQ
	6sZ5MxqBur1RaIiPi34IxfgEW8djqsFM/lx7RBd1gV/y95XVFSWe+PU984rAo4llQ2+0TnKiq8X
	L1CIzkcM0b/vw
X-Received: by 2002:a05:600c:6289:b0:46e:37fc:def0 with SMTP id 5b1f17b1804b1-4778fe62100mr150045915e9.9.1763467344576;
        Tue, 18 Nov 2025 04:02:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHIbPbD3fHl61Z9bqUbxf1dmLAfvuvlg8WHRxbMNqZy32h7ZBzMmci6k7t6kXMAsw9zXDp8Qw==
X-Received: by 2002:a05:600c:6289:b0:46e:37fc:def0 with SMTP id 5b1f17b1804b1-4778fe62100mr150045425e9.9.1763467343987;
        Tue, 18 Nov 2025 04:02:23 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.41])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4779fc42f25sm156990785e9.6.2025.11.18.04.02.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Nov 2025 04:02:23 -0800 (PST)
Message-ID: <d87782d4-567d-4753-8435-fd52cd5b88da@redhat.com>
Date: Tue, 18 Nov 2025 13:02:20 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 net-next 03/14] net: update commnets for
 SKB_GSO_TCP_ECN and SKB_GSO_TCP_ACCECN
To: chia-yu.chang@nokia-bell-labs.com, edumazet@google.com, parav@nvidia.com,
 linux-doc@vger.kernel.org, corbet@lwn.net, horms@kernel.org,
 dsahern@kernel.org, kuniyu@google.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com,
 kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch,
 donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
 ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
References: <20251114071345.10769-1-chia-yu.chang@nokia-bell-labs.com>
 <20251114071345.10769-4-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251114071345.10769-4-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Note: typo in the subj

On 11/14/25 8:13 AM, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> No functional changes.

Some real commit message is needed.

> 
> Co-developed-by: Ilpo Järvinen <ij@kernel.org>
> Signed-off-by: Ilpo Järvinen <ij@kernel.org>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> ---
> v6:
> - Update comments.
> ---
>  include/linux/skbuff.h | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index ff90281ddf90..e09455cee8e3 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -671,7 +671,13 @@ enum {
>  	/* This indicates the skb is from an untrusted source. */
>  	SKB_GSO_DODGY = 1 << 1,
>  
> -	/* This indicates the tcp segment has CWR set. */
> +	/* For Tx, this indicates the first TCP segment has CWR set, and any
> +	 * subsequent segment in the same skb has CWR cleared. This is not
> +	 * used on Rx except for virtio_net. However, because the connection
> +	 * to which the segment belongs is not tracked to use RFC3168 or
> +	 * Accurate ECN, and using RFC3168 ECN offload may corrupt AccECN
> +	 * signal of AccECN segments. Therefore, this cannot be used on Rx.

Stating both that is used by virtio_net and can not be used in the RX
path is a bit confusing. Random Contributor may be tempted from removing
ECN support from virtio_net

Please state explicitly:
- why it makes sense to use this in virtio_net
- this must not be used in the RX path _outside_ the virtio net driver

something alike:

/* For Tx, this indicates the first TCP segment has CWR set, and any
 * subsequent segment in the same skb has CWR cleared. However, because
 * the connection to which the segment belongs is not tracked to use
 * RFC3168 or Accurate ECN, and using RFC3168 ECN offload may corrupt
 * AccECN signal of AccECN segments. Therefore, this cannot be used on
 * Rx outside the virtio_net driver. Such exception exist due to
 * <reason>
 */

/P


