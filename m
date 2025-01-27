Return-Path: <bpf+bounces-49911-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C780A201E3
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 00:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AE743A1DE6
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2025 23:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1401DEFE8;
	Mon, 27 Jan 2025 23:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LAj94sC8"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE6A1DEFE0
	for <bpf@vger.kernel.org>; Mon, 27 Jan 2025 23:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738021772; cv=none; b=lZjCZnE8jI3MHaW9luxShuhC3yjlPHjLWOs687mhH4QHXA2RrC60rbyYeDBrM1ncOh+lUfhirIHvYifXGK5lSO8YnmCoH5UDTgAMVi83hNhBgrUBeF9QdoKVHHOtwc4+xiG36CvmFiDLEhcm/X7jAEp7Jmqy79524Hx8d1Jlsqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738021772; c=relaxed/simple;
	bh=Wug4EIeroYZndVC7OL5mnL3RcMhWzGB8loZOhEODuWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h7MLcwMPS6h7UjT9p+gStqPXK9nN42qDFX8BeizyNiT7UdlgOwoAm9qFtJXHyS17n3duWN1pcEinkkTxOyMdO3+YaHVJHVtm1VD/w49hshKeDjR77bQaNQYrGbL0CtCGn6DTF2ycrQ2nCUsynJmI2kNgIYDur6PWW7JWblGBpZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LAj94sC8; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <29073a9e-23ea-49c2-b0ad-d33bd3ea8974@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738021758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Cf8t8KvGnVwEnZDGe23gVm6BJc7rV7hvjPh/EJvHtE=;
	b=LAj94sC8tFbOOEha7UpKHkhk6QrKQ94hhVLYOTb2Q7C9DsHISMpGXU7lGGAlKXblNuayL8
	KUaiyed3OE/mHNbsEh2DAqCaVJEpI1lkbpzfQFxsUFMQqkiQD73Bh4CusFY6L7O/ATFABm
	UCuMWqEwj4JiuijC0blpAIFNsQOYf/g=
Date: Mon, 27 Jan 2025 15:49:11 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH net-next v6 13/13] bpf: add simple bpf tests in the tx
 path for so_timestamping feature
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
 willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, horms@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org
References: <20250121012901.87763-1-kerneljasonxing@gmail.com>
 <20250121012901.87763-14-kerneljasonxing@gmail.com>
 <564d8d62-3148-41a1-ae08-ed4ad08996d3@linux.dev>
 <CAL+tcoCpJESydmRXp9ASeXYjFkjOyXn+dF+7dYa0Ek6DdnMHKw@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAL+tcoCpJESydmRXp9ASeXYjFkjOyXn+dF+7dYa0Ek6DdnMHKw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/24/25 7:42 PM, Jason Xing wrote:
>> Please also add some details on how the UDP BPF_SOCK_OPS_TS_TCP_SND_CB (or to be
>> renamed to BPF_SOCK_OPS_TS_SND_CB ?) will look like. It is the only callback
>> that I don't have a clear idea for UDP.
> I think I will rename it as you said. But I wonder if I can add more
> details about UDP after this series gets merged which should not be
> too late. After this series, I will carefully consider and test how we
> use for UDP type.

Not asking for a full UDP implementation, having this set staying with TCP is 
ok. We have pretty clear idea on all the new TS_*_CB will work in UDP except the 
TS_SND_CB.

I am asking at least a description on where this SND hook will be in UDP and how 
the delay will be measured from the udp_sendmsg(). I haven't looked, so the 
question. It is better to get some visibility first instead of scrambling to 
change it after landing to -next.

