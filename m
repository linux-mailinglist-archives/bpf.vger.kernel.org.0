Return-Path: <bpf+bounces-64577-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FF7B145BA
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 03:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74F4C1AA1F02
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 01:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8711DFDAB;
	Tue, 29 Jul 2025 01:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WgE/WML7"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD68F1D8A0A
	for <bpf@vger.kernel.org>; Tue, 29 Jul 2025 01:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753752130; cv=none; b=MIP8KPvRfYGDxnTSdhh2q48j9l8gwQYYv7gEv6//adzWbqsQ+1wCwBw0LWsBjvQ1qjvSdYhCkVn7N+ic7qPJSPJdMrOMmEA3F9AS48MKNfH1yM+q+K8Hg1GbDUIDR+wgbing5C/HcfzMOxme1t0TI3Ie9UTcSOE+cCRpdyhTvdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753752130; c=relaxed/simple;
	bh=IyWVg6fv6jorhhnIZt/1wvfudukMy1aGNscDyyEBtYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qiFcvGO1uoLmKVMX6Jr6PLpuWTWzW1zfynmomAucjRi6DeBKF9yRHV0D/Kh1pQKsFOBUCpxNh8CTk43rAInVDvVpjgC9klFOByGx9GUNiKvJvfl1klVf+U2/PyDMbNlPFOKXsK52LpaX3Nk+oQAVrwzLJ1/IwVD0DS1BlFWwxCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WgE/WML7; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b36532a2-506b-4ba5-b6a3-a089386a190e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753752116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GWpYFOkLsYnJ9p2ZFvtVNIwL5tEHltSN8BWwkp1apnw=;
	b=WgE/WML74rD1+eaiOmDCUACg4lRY0yiI97gO1U4BTY+WlYmnjBk9GHu9qMOaIEi7E9661E
	S6cdKz7drn5/cAPiiOk2+WOqIqzMlsmvrqZ57k2/fAFBTZcCx12xuwzV1XRIYMfDmU4xlF
	Y08DWk+rPUj6rmDlY7FOadBKFtCNm+s=
Date: Mon, 28 Jul 2025 18:21:50 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 0/4] bpf: add icmp_send_unreach kfunc
To: Mahe Tardy <mahe.tardy@gmail.com>
Cc: alexei.starovoitov@gmail.com, andrii@kernel.org, ast@kernel.org,
 bpf@vger.kernel.org, coreteam@netfilter.org, daniel@iogearbox.net,
 fw@strlen.de, john.fastabend@gmail.com, netdev@vger.kernel.org,
 netfilter-devel@vger.kernel.org, oe-kbuild-all@lists.linux.dev,
 pablo@netfilter.org, lkp@intel.com
References: <202507270940.kXGmRbg5-lkp@intel.com>
 <20250728094345.46132-1-mahe.tardy@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250728094345.46132-1-mahe.tardy@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/28/25 2:43 AM, Mahe Tardy wrote:
> Hello,
> 
> This is v3 of adding the icmp_send_unreach kfunc, as suggested during
> LSF/MM/BPF 2025[^1]. The goal is to allow cgroup_skb programs to
> actively reject east-west traffic, similarly to what is possible to do
> with netfilter reject target.
> 
> The first step to implement this is using ICMP control messages, with
> the ICMP_DEST_UNREACH type with various code ICMP_NET_UNREACH,
> ICMP_HOST_UNREACH, ICMP_PROT_UNREACH, etc. This is easier to implement
> than a TCP RST reply and will already hint the client TCP stack to abort
> the connection and not retry extensively.
> 
> Note that this is different than the sock_destroy kfunc, that along
> calls tcp_abort and thus sends a reset, destroying the underlying
> socket.
> 
> Caveats of this kfunc design are that a cgroup_skb program can call this
> function N times, thus send N ICMP unreach control messages and that the
> program can return from the BPF filter with SK_PASS leading to a
> potential confusing situation where the TCP connection was established
> while the client received ICMP_DEST_UNREACH messages.
> 
> Another more sophisticated design idea would be for the kfunc to set the
> kernel to send an ICMP_HOST_UNREACH control message with the appropriate
> code when the cgroup_skb program terminates with SK_DROP. Creating a new
> 'SK_REJECT' return code for cgroup_skb program was generally rejected
> and would be too limited for other program types support.
> 
> We should bear in mind that we want to add a TCP reset kfunc next and
> also could extend this kfunc to other program types if wanted.

Some high level questions.

Which other program types do you need this kfunc to send icmp and the future tcp 
rst?

This cover letter mentioned sending icmp unreach is easier than sending tcp rst. 
What problems do you see in sending tcp rst?


