Return-Path: <bpf+bounces-64375-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E393B11EDA
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 14:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 768A45A49B6
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 12:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB542EBDF0;
	Fri, 25 Jul 2025 12:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QdDbm3CW"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83D02EBDED
	for <bpf@vger.kernel.org>; Fri, 25 Jul 2025 12:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753447194; cv=none; b=Sy/OEWbUUry3HxoiBvR5srBlSqNDV2ZpLEZ5T03kbnDW7iHju0v1Nlimdtt3T0ZeztRgeHUMWwBnzXOI7sD4Cd2+7nh+3r0ZHKiEBXWbnl8jDYxmAVNYtbfegTfy2/NgytUTMh6n7C8BeqG8K0/3Ju13yhoxcyIhwAfUPIEE8wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753447194; c=relaxed/simple;
	bh=i/KYaBfaLvEZNkxu3mUqox5mOLv9vYdSv7n5YIOWW18=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p9WJffFfUAB7JdgLhFy/lRMAfHJycb81z3RGM5vh5nYOdYIYncpREE1TxwBRiEf6L5XvHddg/4lHJsdX6V2f2M4Y5rpTfJwcxg+yDe/GrNbVzFhzkT5zD4UcHEAOj4BuuULF5pJWT2pHiKrOXDYXxdIb+3MasypLVD/AnpAADEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QdDbm3CW; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8d987133-0e22-4aa8-bf2e-57ef105c8db8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753447188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UyXNdV5tH0+VzIEOaMeJdhwhayXenr6RyT1W6ZYXDcU=;
	b=QdDbm3CWvaF+MYJyZTJq6QOwJhfeSn9b0mfI5aUftha4Niq0kYMXjeQBbfmhGdUpfFKst+
	VjA/+yb5Rl29xy8Y6psafvceG2efKY51w7qTocs3km7qeXdHOx9JGdMaNLeFwqHoR4Ahie
	+KZ2i3tzAQTbsqafhMXpUITrgAQlLHo=
Date: Fri, 25 Jul 2025 20:38:54 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] sfc: handle NULL returned by xdp_convert_buff_to_frame()
Content-Language: en-US
To: Edward Cree <ecree@amd.com>, Paolo Abeni <pabeni@redhat.com>,
 Chenyuan Yang <chenyuan0y@gmail.com>, ecree.xilinx@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, lorenzo@kernel.org
Cc: netdev@vger.kernel.org, linux-net-drivers@amd.com, bpf@vger.kernel.org,
 zzjas98@gmail.com
References: <20250723003203.1238480-1-chenyuan0y@gmail.com>
 <045d1ff5-bb20-481d-a067-0a42345ab83d@redhat.com>
 <de14f60e-b1f0-432c-80b4-a2f0453e0fe2@amd.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kunwu Chan <kunwu.chan@linux.dev>
In-Reply-To: <de14f60e-b1f0-432c-80b4-a2f0453e0fe2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2025/7/25 18:11, Edward Cree wrote:
> On 7/24/25 10:57, Paolo Abeni wrote:
>> On 7/23/25 2:32 AM, Chenyuan Yang wrote:
>>> The xdp_convert_buff_to_frame() function can return NULL when there is
>>> insufficient headroom in the buffer to store the xdp_frame structure
>>> or when the driver didn't reserve enough tailroom for skb_shared_info.
>> AFAIC the sfc driver reserves both enough headroom and tailroom, but
>> this is after ebpf run, which in turn could consume enough headroom to
>> cause a failure, so I think this makes sense.
> Your reasoning seems plausible to me.
> However, I think the error path ought to more closely follow the existing
>   error cases in logging a ratelimited message and calling the tracepoint.
> I think the cleanest way to do this would be:
> 	if (unlikely(!xdpf))
> 		err = -ENOBUFS;
> 	else
> 		err = efx_xdp_tx_buffers(efx, 1, &xdpf, true);
>   so that it can make use of the existing failure path.
> Adding the check to efx_xdp_tx_buffers() is also an option.
>
> -ed
>
Hi Chenyuan,

THX for addressing this edge case. I concur with Edward's suggestion to 
integrate this with the existing error handling flow. This will ensure:
Consistent observability (ratelimited logs + tracepoints)
Centralized resource cleanup
Clear error type differentiation via -ENOBUFS

Proposed refinement:

diff
  case XDP_TX:
      /* Buffer ownership passes to tx on success. */
      xdpf = xdp_convert_buff_to_frame(&xdp);
+    if (unlikely(!xdpf)) {
+        err = -ENOBUFS;
+    } else {
+        err = efx_siena_xdp_tx_buffers(efx, 1, &xdpf, true);
+    }

-    err = efx_siena_xdp_tx_buffers(efx, 1, &xdpf, true);
      if (unlikely(err != 1)) {
          efx_siena_free_rx_buffers(rx_queue, rx_buf, 1);
          if (net_ratelimit())
              netif_err(efx, rx_err, efx->net_dev,
-                  "XDP TX failed (%d)\n", err);
+                  "XDP TX failed (%d)%s\n", err,
+                  err == -ENOBUFS ? " [frame conversion]" : "");
          channel->n_rx_xdp_bad_drops++;
-        trace_xdp_exception(efx->net_dev, xdp_prog, xdp_act);
+        if (err != -ENOBUFS)
+            trace_xdp_exception(efx->net_dev, xdp_prog, xdp_act);
      } else {
          channel->n_rx_xdp_tx++;
      }
      break;


-- Thanks, TAO. --- “Life finds a way.”

