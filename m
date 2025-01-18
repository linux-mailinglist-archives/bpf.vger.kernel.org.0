Return-Path: <bpf+bounces-49246-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01378A15B04
	for <lists+bpf@lfdr.de>; Sat, 18 Jan 2025 03:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CDB43A97A5
	for <lists+bpf@lfdr.de>; Sat, 18 Jan 2025 02:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18D9DF59;
	Sat, 18 Jan 2025 02:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uGxo3V/A"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CB53211
	for <bpf@vger.kernel.org>; Sat, 18 Jan 2025 02:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737166538; cv=none; b=kmdw9YWtmQgWfjkyjIuK5dgpi86sDdGsB+obpN3BgfKNwoCIJywfm2vTWpUBeIlq9vydcEWNnpDRs0TWk0OnIo9hiyBcRg3EXFiG5JLfDejR6UAZP+tefSdogMcTTh4dScjYwGFDx5yZ57yTR+RDG4mmj/DNh0NQYEuxLX8uQmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737166538; c=relaxed/simple;
	bh=bLHwHzBJQsONui/k9EBc0HTK9xIzdxrCOYe2bL+iCtE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ax8tGSb/gStRGS3ynVeOaB2/nyg/jOuUAO+TlvLYCooBkRMYIDblQ5L2d6qY/K7tfP2BvX6oyBUyuRlDypFkhI7ZDjcOIeEBRwRG7Y1UO3qA1rHz6YcNHt90jgEMlTJoK1WRNdCzwn7NN46u/SyBzTWMenMeGO1wfIJcWzQgOZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uGxo3V/A; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <35e2c693-244f-4d55-88f3-99e1ed1e2745@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737166534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J/Ny+ux2Nts//ag9xqjBiWq8B++rW5Mi4vVd0rGR2/w=;
	b=uGxo3V/Ahqc2B3BNggVqEIIHWl8tHWNhBn+6RgaU+DsKzkSHtvE3/GTiU1jfUDbEe7qECZ
	mm9Z9ycp0qm9BbAYmeYjWnxULJ6U8zF8GgQb0aD9iG0/KDn75squjUJolLV4p4QMRTQSab
	AiUyKkgakPD6SHIEotDUMDVXq9jhljU=
Date: Fri, 17 Jan 2025 18:15:26 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v5 05/15] net-timestamp: add strict check in some
 BPF calls
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
 willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, horms@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org
References: <20250112113748.73504-1-kerneljasonxing@gmail.com>
 <20250112113748.73504-6-kerneljasonxing@gmail.com>
 <ca852e76-2627-4e07-8005-34168271bf12@linux.dev>
 <CAL+tcoAY9jeOmZjVqG=7=FxOdXevvOXroTosaE8QpG2bYbFE_Q@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <CAL+tcoAY9jeOmZjVqG=7=FxOdXevvOXroTosaE8QpG2bYbFE_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/15/25 3:32 PM, Jason Xing wrote:
>> +static bool is_locked_tcp_sock_ops(struct bpf_sock_ops_kern *bpf_sock)
>> +{
>> +       return bpf_sock->op <= BPF_SOCK_OPS_WRITE_HDR_OPT_CB;
> 
> I wonder if I can use the code snippets in the previous reply in this
> thread, only checking if we are in the timestamping callback?
> +#define BPF_SOCK_OPTS_TS               (BPF_SOCK_OPS_TS_SCHED_OPT_CB | \
> +                                        BPF_SOCK_OPS_TS_SW_OPT_CB | \
> +                                        BPF_SOCK_OPS_TS_ACK_OPT_CB | \
> +                                        BPF_SOCK_OPS_TS_TCP_SND_CB)

Note that BPF_SOCK_OPS_*_CB is not a bit.

My understanding is it is a blacklist. Please correct me if I miss-interpret the 
intention.

> 
> Then other developers won't worry too much whether they will cause
> some safety problems. If not, they will/must add callbacks earlier
> than BPF_SOCK_OPS_WRITE_HDR_OPT_CB.

It can't be added earlier because it is in uapi. If the future new cb is safe to 
use these helpers, then it needs to adjust the BPF_SOCK_OPS_WRITE_HDR_OPT_CB 
check. is_locked_tcp_sock_ops() is a whitelist. The worst is someone will 
discover the helpers are not usable in the new cb, so no safety issue.

If forgot to adjust the blacklist and the new cb should not use the helpers, 
then it is a safety issue.

Anyhow, I don't have a strong opinion here. I did think about checking the new 
TS callback instead. I went with the simplest way in the code and also 
considering the BPF_SOCK_OPS_TS_*_CB is only introduced starting from patch 7.


