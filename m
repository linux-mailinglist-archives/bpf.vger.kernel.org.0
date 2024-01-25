Return-Path: <bpf+bounces-20354-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C75B883CF8E
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 23:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67930B20D8F
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 22:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F97111B6;
	Thu, 25 Jan 2024 22:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="fjgNPb1k"
X-Original-To: bpf@vger.kernel.org
Received: from mx07lb.world4you.com (mx07lb.world4you.com [81.19.149.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E29711185;
	Thu, 25 Jan 2024 22:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706222697; cv=none; b=T2Na/5xZKmpsqk1GD/MnsxwWugz3AfcCjSLBWj7mv5C0jpXRl/2Katx/MoKWOb8Msp2K1zsRAoPm1zXd0DZLYJVyIdP8e4PMbFgPkTTzdUHZaRgoCwSO7T8MuGYLvd1SYeKcPOga+a6/jM5Q7vbpDg0SmXd0l13tsJ9W8Ye1rlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706222697; c=relaxed/simple;
	bh=mu300rQScOKkio8Mf2THNoDHU3+wIHUglcmCOY1wbj4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FsVQaSE6wU2Dwq7HOlUiocNlO+XDHtcGMlnr1FhInGxJE4izEfIHGLkOVmpoxUovJr/A19khm+wVqsS6fuRYUIVRTfVeBXNuFU7UE77zssyGVdLtIh9CgNMMWPfM7/rKLHKM0ciC0F8lFJ1KjhpFFOOW4KAnj5G12KcZsTszoVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=fjgNPb1k; arc=none smtp.client-ip=81.19.149.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=NeiUlbZNbRqE8MzxdONDlFkXjRIeAJLMSda+xK9MwfM=; b=fjgNPb1kts3MQ42h+vOHuuM/9L
	uhNDOc9apVvgM5F8QOwLjhBaxww91uhkz9t7WmZKD9+gCrnGVY+8524gMP3Y4QoGyRZ31ZtulS10q
	pMy51u3OJX+2Y2kF1sBa6ctbNBIWS3USX4fbgXnO9WgRpdIEZ0/RKtBoen/qjg/+2hnA=;
Received: from [88.117.59.234] (helo=[10.0.0.160])
	by mx07lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1rT7bl-00086f-1O;
	Thu, 25 Jan 2024 22:50:01 +0100
Message-ID: <4fe10d68-e48c-446f-96f7-157b85b1a6fb@engleder-embedded.com>
Date: Thu, 25 Jan 2024 22:50:00 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] tsnep: Fix XDP_RING_NEED_WAKEUP for empty fill
 ring
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 bjorn@kernel.org, magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
 jonathan.lemon@gmail.com
References: <20240123200918.61219-1-gerhard@engleder-embedded.com>
 <20240123200918.61219-3-gerhard@engleder-embedded.com>
 <41a9cd95c940aeb418f45a1d4e3ff4b0e8f62d5a.camel@redhat.com>
Content-Language: en-US
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <41a9cd95c940aeb418f45a1d4e3ff4b0e8f62d5a.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes

On 25.01.24 12:06, Paolo Abeni wrote:
> On Tue, 2024-01-23 at 21:09 +0100, Gerhard Engleder wrote:
>> +	if (xsk_uses_need_wakeup(rx->xsk_pool)) {
>> +		int desc_available = tsnep_rx_desc_available(rx);
>> +
>> +		if (desc_available)
>> +			xsk_set_rx_need_wakeup(rx->xsk_pool);
>> +		else
>> +			xsk_clear_rx_need_wakeup(rx->xsk_pool);
>> +	}
>>   }
>>   
>>   static bool tsnep_pending(struct tsnep_queue *queue)
> 
> The patch LGTM, but there is a very similar chunk of code in
> tsnep_rx_poll_zc(). You should consider a net-next follow-up
> consolidating the code in a common helper.

I will do. Thanks!

