Return-Path: <bpf+bounces-79457-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2045D3AB9B
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 15:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B13283008982
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 14:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFA337BE78;
	Mon, 19 Jan 2026 14:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="Wj1gh4QG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FB6359710
	for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 14:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768832505; cv=none; b=TBrQDu06aOZThF0qR6TKA3cxFphxXmcTgYlQNKHorR/YW68q7FWFVg7W0yM4aPKiuHW0ViYB/4OyGPPjM3hXDZqWgXn/j9iZjjJtYQdHBwKjaOBLAkZsREUNuAImttXnLltLl1mvGSyu438oaTZVweIP2O/DhAJbDSzUeki3D00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768832505; c=relaxed/simple;
	bh=eUscMd11fUzX2cc6bInocUYE06/GBO7n5whFK4x/iyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ned9dXyhLZXfMWRllyONAjTeSnT2H8yUP+E5M/tnNZgpFAAX4YkIihyPpJXysHz7saP85FdVUpspa67VdHkI4tGmMQFBO3i9Y7IiTzxkn1kc19qIKgxpPMSFWOGBwI+s9X98VTO+b0vrbcqprMFsxfoRaLTcDJSWde2X+GyjWeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=Wj1gh4QG; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-480142406b3so21375755e9.1
        for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 06:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1768832502; x=1769437302; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7E7gxSK7pfoztFG+T4kpjsWfYYsLocKrXFy/WiuFtSQ=;
        b=Wj1gh4QGjmiaDprsg3tg1JLMg2zrthU67ofu3/zmVXPsHb6+nEe8MwlBzgtgXDD/ct
         cuLI3k/Vc2YpSwKpqTq0a9spqqbo0MDb8XqtfofaHkcggx7bfbpCDO59BX7HFG6TDWY+
         u6NvA519xXcZjBuj4cfJJT6lqLRISgJ6/G/nCIOufwzhwLO9hJmIEIpvAlP8dc8RWwzy
         XcVsDDM4YaQpiL4zZ6BnORydqPYLaETtMULgBSN0wc3laVmiX0KSI55QA+eAmwWuA0tf
         R2J62/JM7zE3TRRUiCd/J+Ra1alJYx58DEngFZECF0rHo4ollz/q/bafwFqSIG0Eoaro
         a3hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768832502; x=1769437302;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7E7gxSK7pfoztFG+T4kpjsWfYYsLocKrXFy/WiuFtSQ=;
        b=epyXLIcGEKzTYpWwuAfpQoFm1neLSRkNSnaiO67yRiO15uLb/GDEAB/OfHzv0wFvc5
         WuHNOsLt/NERklHVY4R6r5XVfsQClthTfMFgsh4DIOjxWjUvleC2AlRkQmsN27TVXGBp
         rEyAeaIWtx02hSpYXvCIKFtmBlxyl/h7kxzbtHa5h0r+Kf0tI6qOMgaDLvpvntEGOVx9
         MMEaJfb4S8WDUDlLPRK+sMI0AwOpeCVIA4pwyTnFNgTVEm2mOFUBkJT2lPZ7ciDtPW9V
         mOLhHh7HYJPgRMXLB7bLochKBSIiaMF1lgGHS2gaGshlxeM5Usm7Igjf46w5K280mOdj
         6KmQ==
X-Gm-Message-State: AOJu0YxRGejMmYgm93O1oAeRqWaifA0i231cNMN9h19oX1INv+PS8yqJ
	a8GWPq80GOhAFVsFSD9wKvkOfQEdJyH6c5sA5J11cQ0Vi+KwAFZJxPOFpGA8CR0wnys=
X-Gm-Gg: AY/fxX6Vd7QlXcOkImoqwhmhfI7xqy3nqOZZzLlNOF+1EyzskR1w4GT1NZ6xPPJntus
	2CE6Mtjzpn7v3HQ9Mi+gkCKriPOdX4scTBE5EXU7MEQc6v2pYD9LUIadZtnOLe5QQodjqA8O/wl
	vPFwB2YnE/Kwcxiqoh0rjBZxBXXjiVEbh53KGz/ORq902VgGTKM+IYH/bElTJ1FZ+R+dqs3ZJGQ
	cI72TE9DEaXcOL6db1RJEZm+dUj6+FHrWKbrHP1Wxavq1JLyXKRpUnMf3oJyXZ5W2O15fT+6aqa
	YTbXsU6bPwc/vBLY4Tlyk9t2h5/mapMDb4epWf7GKyvKXMX5QD9SO8CLnUEFje4PHBg0XAZKjex
	dObfkkiwuVYZzsxBKEIjHnkwLl4IiS4vkeOsjc8LUJk+HNy9ao0BgMNp/lynr7jS2t8pD1dkUdJ
	uS9F4xTTZ+WqAc71C2gsZCTGMUTTDsRI6e9HIjmvxOv7IcIxPKI9q34KFVKbP2D7YmeWabIw==
X-Received: by 2002:a05:600c:3d8b:b0:479:2a09:9262 with SMTP id 5b1f17b1804b1-4801e30b49emr118719455e9.9.1768832502135;
        Mon, 19 Jan 2026 06:21:42 -0800 (PST)
Received: from [192.168.0.161] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f4b2755absm312840825e9.15.2026.01.19.06.21.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jan 2026 06:21:41 -0800 (PST)
Message-ID: <25e26e82-f7d1-421e-b7af-766d99654fcf@blackwall.org>
Date: Mon, 19 Jan 2026 16:21:40 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 07/16] xsk: Extend xsk_rcv_check validation
To: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, dw@davidwei.uk,
 toke@redhat.com, yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20260115082603.219152-1-daniel@iogearbox.net>
 <20260115082603.219152-8-daniel@iogearbox.net>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260115082603.219152-8-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/01/2026 10:25, Daniel Borkmann wrote:
> xsk_rcv_check tests for inbound packets to see whether they match
> the bound AF_XDP socket. Refactor the test into a small helper
> xsk_dev_queue_valid and move the validation against xs->dev and
> xs->queue_id there.
> 
> The fast-path case stays in place and allows for quick return in
> xsk_dev_queue_valid. If it fails, the validation is extended to
> check whether the AF_XDP socket is bound against a leased queue,
> and if the case then the test is redone.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Co-developed-by: David Wei <dw@davidwei.uk>
> Signed-off-by: David Wei <dw@davidwei.uk>
> ---
>   net/xdp/xsk.c | 29 ++++++++++++++++++++++++++---
>   1 file changed, 26 insertions(+), 3 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


