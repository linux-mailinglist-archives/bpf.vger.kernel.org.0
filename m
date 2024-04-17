Return-Path: <bpf+bounces-27074-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C54D8A8EF5
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 00:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37874281A8C
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 22:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03A781ADA;
	Wed, 17 Apr 2024 22:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="q2xfxFNB"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D147F47D
	for <bpf@vger.kernel.org>; Wed, 17 Apr 2024 22:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713394152; cv=none; b=JGnIHT/+65tyu7fEXqbr9ucFLEeBxV1ffQUtoS4hOXBKtW/rvQ+duqsFVAtLANchcsrBK2kp1vpyKKGalagE9SGh/9zqdvDiKApUUklNl3e1nCYcrE1ADLqxKTFcFCWwWMeXPmlmUYWsV8BW8vQwfl7iQVFQ3IcWcuQk1cbMfso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713394152; c=relaxed/simple;
	bh=CU4SUV/tAacMmxINxQPyDkH06nmMCSP9U+W+vrpSaZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sYArBwT8x9/VpyAVzPPLmhOh2O/iON20D+BMoCuivWcIiMD6tD0BajfrGprtyJHUIs/Z0u1T49qVRuaISD5Nx+BkcT96lL3wfqBoNgEHSDcXOMqWU6/uHe1HDcJP6TtUEVRKyl6utgKphKOj6hvt5/c7CIuA8MUWaNAU/z0KRUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=q2xfxFNB; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <152f00e2-8f60-4f39-8ab4-fdab1b0bc01a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713394147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bucH0Erc8Q5A/z6/UWqfD8pwxfQz7cToeD3wwtpAcrs=;
	b=q2xfxFNBtP+SY+acb0XsxDrmxuCY0OM2oDFFE/GMBRJSPLecC/31LRN7DugtTKRsHDkZS4
	zTNAH9Bq0M4B02DbZ7GqNePYzZ6HnnRyjyqw35nOHH4uPVyYIMKaebB8L+fpaHPMj1wQ51
	9uoh8Bbgg1qcH9jcJv7TU9oF7pctXlM=
Date: Wed, 17 Apr 2024 15:48:55 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: add sacked flag in BPF_SOCK_OPS_RETRANS_CB
To: Eric Dumazet <edumazet@google.com>, Philo Lu <lulie@linux.alibaba.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, dsahern@kernel.org,
 laoar.shao@gmail.com, xuanzhuo@linux.alibaba.com, fred.cc@alibaba-inc.com
References: <20240417124622.35333-1-lulie@linux.alibaba.com>
 <CANn89iLWMhAOq0R7N3utrXdro_zTmp=9cs8a7_eviNcTK-_5+w@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CANn89iLWMhAOq0R7N3utrXdro_zTmp=9cs8a7_eviNcTK-_5+w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 4/17/24 6:11 AM, Eric Dumazet wrote:
> On Wed, Apr 17, 2024 at 2:46 PM Philo Lu <lulie@linux.alibaba.com> wrote:
>>
>> Add TCP_SKB_CB(skb)->sacked as the 4th arg of sockops passed to bpf
>> program. Then we can get the retransmission efficiency by counting skbs
>> w/ and w/o TCPCB_EVER_RETRANS mark. And for this purpose, sacked
>> updating is moved after the BPF_SOCK_OPS_RETRANS_CB hook.
>>
>> Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
> 
> This might be a naive question, but how the bpf program know what is the meaning
> of each bit ?
> 
> Are they exposed already, and how future changes in TCP stack could
> break old bpf programs ?
> 
> #define TCPCB_SACKED_ACKED 0x01 /* SKB ACK'd by a SACK block */
> #define TCPCB_SACKED_RETRANS 0x02 /* SKB retransmitted */
> #define TCPCB_LOST 0x04 /* SKB is lost */
> #define TCPCB_TAGBITS 0x07 /* All tag bits */
> #define TCPCB_REPAIRED 0x10 /* SKB repaired (no skb_mstamp_ns) */
> #define TCPCB_EVER_RETRANS 0x80 /* Ever retransmitted frame */
> #define TCPCB_RETRANS (TCPCB_SACKED_RETRANS|TCPCB_EVER_RETRANS| \
> TCPCB_REPAIRED)

I think it is the best to use the trace_tcp_retransmit_skb() tracepoint instead.

iiuc the use case, moving the "TCP_SKB_CB(skb)->sacked |= TCPCB_EVER_RETRANS;" 
after the tracepoint should have similar effect.

If the TCPCB_* is moved to a enum, it will be included in the "vmlinux.h" that 
the bpf prog can use and no need to expose them in uapi.


