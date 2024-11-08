Return-Path: <bpf+bounces-44396-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 071B19C26E9
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 22:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B44F11F2221E
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 21:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E661E22F3;
	Fri,  8 Nov 2024 21:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sXXV1reo"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED8F233D92
	for <bpf@vger.kernel.org>; Fri,  8 Nov 2024 21:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731100103; cv=none; b=eptfwC64kJXmrUXfyFPJPVAn25j1qDB9+VYITqR+7M7qLfgWNq2FknsJtXsWNiSmdUi+gFxTpvWqOhG0/mTQbiQyIlAdCyEOrvDXQOeO8s+Gxz6LOMRNKrtU6yBXItDdv50fWJ/PoSO+X2kPlYRPGR55CwegcMrGf8I+RcguItk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731100103; c=relaxed/simple;
	bh=JjIgWMnQyToPodUFYA4g0djq+fKAypzUgrehtbL2raE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=LSJThlp238dzzxGLNPcUffZj8VS9/8mtgvrMeSdlsAfLO3/3AfS27jFiJm91K4DlIojnsvo6PPUa9a2gynecKHTD+/DjoL8sWLp/prNklcNcIkMnrDl+jEdO5ayBsS+5AOvl8w5WcwaUWTgVrHUNP/kuI/uWeSUxcLcXrcMdqZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sXXV1reo; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <55fc6114-7e64-4b65-86d2-92cfd1e9e92f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731100099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=otUs9kZ/bOaxVccuA7V597M98+y5StW+4hKm15T+i3I=;
	b=sXXV1reoq9dG6hwzK6bU+TqYuSMjPi7YxkhYq9uHi1G9eFxnvK1w1l3jowKWdR1ygGCaNt
	ea8+0DSPtNKhP5RdEUyZNAAcDA1AJG0YmY3IlhMCD8yTsxaSFHL4RBgJVmWquI3fN507jJ
	ihz6Q99W3lEF1v/HaScZcu8BizPpYaE=
Date: Fri, 8 Nov 2024 13:07:57 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf] bpf: fix recursive lock when verdict program return
 SK_PASS
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: mrpre <mrpre@163.com>, John Fastabend <john.fastabend@gmail.com>,
 Jakub Sitnicki <jakub@cloudflare.com>
Cc: edumazet@google.com, davem@davemloft.net, dsahern@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 bpf <bpf@vger.kernel.org>, linux-kernel@vger.kernel.org,
 Vincent Whitchurch <vincent.whitchurch@datadoghq.com>
References: <20241106124431.5583-1-mrpre@163.com>
 <2939664d-e38d-4ac4-b8cf-3ef60c5fd5c6@linux.dev>
Content-Language: en-US
In-Reply-To: <2939664d-e38d-4ac4-b8cf-3ef60c5fd5c6@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 11/8/24 1:03 PM, Martin KaFai Lau wrote:
> On 11/6/24 4:44 AM, mrpre wrote:
>> When the stream_verdict program returns SK_PASS, it places the received skb
>> into its own receive queue, but a recursive lock eventually occurs, leading
>> to an operating system deadlock. This issue has been present since v6.9.
>>
>> '''
>> sk_psock_strp_data_ready
>>      write_lock_bh(&sk->sk_callback_lock)
>>      strp_data_ready
>>        strp_read_sock
>>          read_sock -> tcp_read_sock
>>            strp_recv
>>              cb.rcv_msg -> sk_psock_strp_read
>>                # now stream_verdict return SK_PASS without peer sock assign
>>                __SK_PASS = sk_psock_map_verd(SK_PASS, NULL)
>>                sk_psock_verdict_apply
>>                  sk_psock_skb_ingress_self
>>                    sk_psock_skb_ingress_enqueue
>>                      sk_psock_data_ready
>>                        read_lock_bh(&sk->sk_callback_lock) <= dead lock
>>
>> '''
>>
>> This topic has been discussed before, but it has not been fixed.
>> Previous discussion:
>> https://lore.kernel.org/all/6684a5864ec86_403d20898@john.notmuch
> 
> Is the selftest included in this link still useful to reproduce this bug?
> If yes, please include that also.
> 
>>
>> Fixes: 6648e613226e ("bpf, skmsg: Fix NULL pointer dereference in 
>> sk_psock_skb_ingress_enqueue")
>> Reported-by: Vincent Whitchurch <vincent.whitchurch@datadoghq.com>
>> Signed-off-by: Jiayuan Chen <mrpre@163.com>
> 
> Please also use the real name in the author (i.e. the email sender). The patch 
> needs a real author name also. I had manually fixed one of your earlier 
> lock_sock fix before applying.

and the bpf mailing list address has a typo in the original patch email... I 
fixed that in this reply.

> 
> pw-bot: cr
> 
>> Signed-off-by: John Fastabend <john.fastabend@gmail.com>
> 
> The patch and the earlier discussion make sense to me.
> John and JakubS, please help to take another look in the next respin.
> 
> 


