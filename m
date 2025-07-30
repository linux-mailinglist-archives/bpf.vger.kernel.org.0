Return-Path: <bpf+bounces-64691-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF15BB159B4
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 09:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99849175B06
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 07:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F1C28FFE5;
	Wed, 30 Jul 2025 07:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aU7PY2Ak"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BE535953
	for <bpf@vger.kernel.org>; Wed, 30 Jul 2025 07:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753861127; cv=none; b=kbp24HrG0HdmML/uSwluI2ClsqKf56oK2QAPFXMAkAruSlr1J6B4InLt1NoN5T6fq1Fyqh2xuquPzdjB7Jc+Ms1HzLw5f2If3W5FETTsIVXIMpbQaqomvI8lUPYHrrZd7i+/yKEvhjYIEn4xanpmEZFE7IgKuADG/H92qrbl3l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753861127; c=relaxed/simple;
	bh=h7jIvo3oBpFJTxJeqGtcO58heYhHZbJ7NLsydcxpTyE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZkfcN6LXVMX8XxpTELDcoDH1rjuxRwzzSBakxR7iuRdGKyHX8z/V2QhDjBSBj4f0t9aDiHs2mrmfqYPf4iC7es47kXScGDdhapi7Pt3h+8UiJzsyL18GIKwMgZXkD8tpgDDhKLCBfSANhDwZs442vMdjfmEgyaK8JKUl+zsfHNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aU7PY2Ak; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0b43ded0-701c-475b-99af-72612a8afc3d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753861122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Po4ue1cXy37/7/gAauR9DhGJcWlPu0T+MCiLfbuelR0=;
	b=aU7PY2AkkgzPaF77XfS8NH8hS4R0k9q2e0FSwx8SW3u1xKTJSoEczngVpqkqRrhLzO/Ylk
	RAJbSKdU7xs4+ADrOPayPIAQEaUrsL/ZcvUwujfbgXZom5d7zXYAWsHBDrR7vMldwRUSjM
	GXmrFHymkBBojgP923bJ2mc4Eol1sME=
Date: Wed, 30 Jul 2025 15:38:00 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] sfc: handle NULL returned by xdp_convert_buff_to_frame()
To: Edward Cree <ecree.xilinx@gmail.com>, Edward Cree <ecree@amd.com>,
 Paolo Abeni <pabeni@redhat.com>, Chenyuan Yang <chenyuan0y@gmail.com>,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, lorenzo@kernel.org
Cc: netdev@vger.kernel.org, linux-net-drivers@amd.com, bpf@vger.kernel.org,
 zzjas98@gmail.com
References: <20250723003203.1238480-1-chenyuan0y@gmail.com>
 <045d1ff5-bb20-481d-a067-0a42345ab83d@redhat.com>
 <de14f60e-b1f0-432c-80b4-a2f0453e0fe2@amd.com>
 <8d987133-0e22-4aa8-bf2e-57ef105c8db8@linux.dev>
 <4169cfd4-2231-417f-b091-d8fa2f73f176@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kunwu Chan <kunwu.chan@linux.dev>
In-Reply-To: <4169cfd4-2231-417f-b091-d8fa2f73f176@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2025/7/28 22:28, Edward Cree wrote:
> On 25/07/2025 13:38, Kunwu Chan wrote:
>> Proposed refinement:
> ...
>>           if (net_ratelimit())
>>               netif_err(efx, rx_err, efx->net_dev,
>> -                  "XDP TX failed (%d)\n", err);
>> +                  "XDP TX failed (%d)%s\n", err,
>> +                  err == -ENOBUFS ? " [frame conversion]" : "");
> Unnecessary, since efx_xdp_tx_buffers() never returns ENOBUFS.

You're correct that efx_siena_xdp_tx_buffers() never returns -ENOBUFS,

and xdp_convert_buff_to_frame() returns NULL on failure.

Whether we need a log to distinguish where the errors come from?

  +   if (unlikely(!xdpf))

  +          err = -ENOBUFS;

  +   else

  +      err = efx_xdp_tx_buffers(efx, 1, &xdpf, true);

  -    err = efx_siena_xdp_tx_buffers(efx, 1, &xdpf, true);
       if (unlikely(err != 1)) {
           efx_siena_free_rx_buffers(rx_queue, rx_buf, 1);
           if (net_ratelimit())
               netif_err(efx, rx_err, efx->net_dev,
-                  "XDP TX failed (%d)\n", err);
+                  "XDP TX failed (%d)%s\n", err,
+                  err == -ENOBUFS ? " [xdp_convert_buff_to_frame]" : 
"efx_siena_xdp_tx_buffers");

Just a personal thought.


>
>>           channel->n_rx_xdp_bad_drops++;
>> -        trace_xdp_exception(efx->net_dev, xdp_prog, xdp_act);
>> +        if (err != -ENOBUFS)
>> +            trace_xdp_exception(efx->net_dev, xdp_prog, xdp_act);
> Why prevent the tracepoint in this case??
You're correct, my mistake.

-- 
Thanks,
        TAO.
---
“Life finds a way.”


