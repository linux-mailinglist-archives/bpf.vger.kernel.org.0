Return-Path: <bpf+bounces-55263-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89044A7ACC1
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 21:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD3033B357E
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 19:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224FE280CF3;
	Thu,  3 Apr 2025 19:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="qM9zA1Ei"
X-Original-To: bpf@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AE7258CEC;
	Thu,  3 Apr 2025 19:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707298; cv=none; b=N5qt4KGwWL0O99ryb52lrjEMsXQfgUrubgtt+llSpnyO86eZyHVwNn3H5B6PCWHARGJFGlH7KFrIRaAQnF5JmzGngBSiLtC9iXqdmq3qKbWUgyxDDn5FLovCCt2KXJpeeco/63UrOhmWmcdqX3c1XSzc29e6bzH9XM2hFuoAq2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707298; c=relaxed/simple;
	bh=Wh5Ni6yEb9pzYvSxle13v0riTVmFQqhjt3k27dRwEqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BM0mon2wq3kziWhd6hkxUhDrQuF2pOYgUz0HMPWsKLbFC+MPN5Kb7yKJlEXm2cunPqgJMSQxJsmyslpEvYYTFUWuDOVRGnrFsPGEN+oDIcD6bdDlfP3eyEmQH1DR+V4WAzkkBfBAM5S19tclxo1OBS7LiKfN+m1YvRBfG+hjUGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=qM9zA1Ei; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from [192.168.1.58] (220.24-245-81.adsl-dyn.isp.belgacom.be [81.245.24.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 63D01200C241;
	Thu,  3 Apr 2025 21:08:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 63D01200C241
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1743707292;
	bh=KrNpRha9b/ZPtCbTWmlK4b+wJzbqizSsJUCYeP/vmhM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qM9zA1EiDlk+7qhQ8c6mnOQ1pr5QfQpd47HEslS4xQMoOsPV5T8d5YiGznPUP2E6d
	 /1A4Eg0M4CABN777HIiwuDICp9qnhSdsnNDggzYLM4bvtqxdvsGt8VK66gXwlti6MP
	 n8MlSINUJ5oF5oGD2s3oJEOWE5b8cOVV4ZGMqW5WGzUZ0LNGJ/CDN5IUGqcFg+sMlr
	 leiwED4EV8fMHHShsXYuhOnHHe03wQuH3M+dpu+Togus0hxfDkc2TvZAfN1q98SkzH
	 AIGk4+Ca7QNhQlOUXyuj9xW2AdUhLy2T8x3k7BGwXIgoso+roiSXe3q1sX23DlLy/a
	 M8oxqd7Z2DMgQ==
Message-ID: <cb0df409-ebbf-4970-b10c-4ea9f863ff00@uliege.be>
Date: Thu, 3 Apr 2025 21:08:12 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: lwtunnel: disable preemption when required
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, kuniyu@amazon.com,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf <bpf@vger.kernel.org>
References: <20250403083956.13946-1-justin.iurman@uliege.be>
 <Z-62MSCyMsqtMW1N@mini-arch>
Content-Language: en-US
From: Justin Iurman <justin.iurman@uliege.be>
In-Reply-To: <Z-62MSCyMsqtMW1N@mini-arch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/3/25 18:24, Stanislav Fomichev wrote:
> On 04/03, Justin Iurman wrote:
>> In lwtunnel_{input|output|xmit}(), dev_xmit_recursion() may be called in
>> preemptible scope for PREEMPT kernels. This patch disables preemption
>> before calling dev_xmit_recursion(). Preemption is re-enabled only at
>> the end, since we must ensure the same CPU is used for both
>> dev_xmit_recursion_inc() and dev_xmit_recursion_dec() (and any other
>> recursion levels in some cases) in order to maintain valid per-cpu
>> counters.
> 
> Dummy question: CONFIG_PREEMPT_RT uses current->net_xmit.recursion to
> track the recursion. Any reason not to do it in the generic PREEMPT case?

I'd say PREEMPT_RT is a different beast. IMO, softirqs can be 
preempted/migrated in RT kernels, which is not true for non-RT kernels. 
Maybe RT kernels could use __this_cpu_* instead of "current" though, but 
it would be less trivial. For example, see commit ecefbc09e8ee ("net: 
softnet_data: Make xmit per task.") on why it makes sense to use 
"current" in RT kernels. I guess the opposite as you suggest (i.e., 
non-RT kernels using "current") would be technically possible, but there 
must be a reason it is defined the way it is... so probably incorrect or 
inefficient?

