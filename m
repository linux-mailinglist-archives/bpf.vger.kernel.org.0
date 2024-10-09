Return-Path: <bpf+bounces-41376-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F4C99654E
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 11:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8893D1C2238F
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 09:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D672618A6BE;
	Wed,  9 Oct 2024 09:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YQdJEygQ"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6C43BB48
	for <bpf@vger.kernel.org>; Wed,  9 Oct 2024 09:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728466095; cv=none; b=UezLUcdSoS3tCCR9jEK/yEd83pGREPQF+vJMjNaCCiIwa6dPKzrNQsOQsD93bR0cr5Lvax0yNW8ua8utQrh4aqdFJ7Ok35T3kCMdqU90ZmiR5iFE3ZrN2ItFD19mPOxJGrm4mbR/EYdYXKL89rBiEWOxrXgPmltvJxn7k5W90Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728466095; c=relaxed/simple;
	bh=sx51YovYY+cL5qWcSId/bu5DEBDJ/ePdApc0HMuxh0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AsShfM0T7V1BOiTAFSEDOQ9ZvHwpisNLkdzyZi72Lnj36b5lx3VQHMiBgu2OsOHGpiHzKik8hq7vZbFyCLxne8QhJD0vlNkK6cYiM7xcf1Jq2PUSfV4O0RNIUOGH9DqkUXaehbTYUas+Xu6ghdA64ZzpFnKH7Mv+W2n3DKP8EUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YQdJEygQ; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6b10ed31-c53f-4f99-9c23-e1ba34aa0905@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728466084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E2qoaaOFEUDWFmSzGO46vgJA6ZdovMV1TgTsrkE+qKs=;
	b=YQdJEygQEWDPcJWW7a8+rPwZRBjnNis8yNE9P08c4oU0kxM1y8rTSaxprPZa/Ecw1SCpbe
	sQ1plAdhxX8hUWS/e5AnIbkksQRamogecnRRi1LIYfk/3csKi3W+/+ac/5hXAxETaoYf85
	+Y6q5kUIWVAd93UszyowMLhdLbxNTmo=
Date: Wed, 9 Oct 2024 10:27:59 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 0/9] net-timestamp: bpf extension to equip
 applications transparently
To: Jason Xing <kerneljasonxing@gmail.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemb@google.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
References: <20241008095109.99918-1-kerneljasonxing@gmail.com>
 <67057d89796b_1a41992944c@willemb.c.googlers.com.notmuch>
 <CAL+tcoBGQZWZr3PU4Chn1YiN8XO_2UXGOh3yxbvymvojH3r13g@mail.gmail.com>
 <CAL+tcoC48XCmc3G7Xpb_0=maD1Gi0OLkNbUp4ugwtj69ANPaAw@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <CAL+tcoC48XCmc3G7Xpb_0=maD1Gi0OLkNbUp4ugwtj69ANPaAw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 09/10/2024 02:05, Jason Xing wrote:
> On Wed, Oct 9, 2024 at 7:22 AM Jason Xing <kerneljasonxing@gmail.com> wrote:
>>
>> On Wed, Oct 9, 2024 at 2:44 AM Willem de Bruijn
>> <willemdebruijn.kernel@gmail.com> wrote:
>>>
>>> Jason Xing wrote:
>>>> From: Jason Xing <kernelxing@tencent.com>
>>>>
>>>> A few weeks ago, I planned to extend SO_TIMESTMAMPING feature by using
>>>> tracepoint to print information (say, tstamp) so that we can
>>>> transparently equip applications with this feature and require no
>>>> modification in user side.
>>>>
>>>> Later, we discussed at netconf and agreed that we can use bpf for better
>>>> extension, which is mainly suggested by John Fastabend and Willem de
>>>> Bruijn. Many thanks here! So I post this series to see if we have a
>>>> better solution to extend.
>>>>
>>>> This approach relies on existing SO_TIMESTAMPING feature, for tx path,
>>>> users only needs to pass certain flags through bpf program to make sure
>>>> the last skb from each sendmsg() has timestamp related controlled flag.
>>>> For rx path, we have to use bpf_setsockopt() to set the sk->sk_tsflags
>>>> and wait for the moment when recvmsg() is called.
>>>
>>> As you mention, overall I am very supportive of having a way to add
>>> timestamping by adminstrators, without having to rebuild applications.
>>> BPF hooks seem to be the right place for this.
>>>
>>> There is existing kprobe/kretprobe/kfunc support. Supporting
>>> SO_TIMESTAMPING directly may be useful due to its targeted feature
>>> set, and correlation between measurements for the same data in the
>>> stream.
>>>
>>>> After this series, we could step by step implement more advanced
>>>> functions/flags already in SO_TIMESTAMPING feature for bpf extension.
>>>
>>> My main implementation concern is where this API overlaps with the
>>> existing user API, and how they might conflict. A few questions in the
>>> patches.
>>
>> Agreed. That's also what I'm concerned about. So I decided to ask for
>> related experts' help.
>>
>> How to deal with it without interfering with the existing apps in the
>> right way is the key problem.
> 
> What I try to implement is let the bpf program have the highest
> precedence. It's similar to RTO min, see the commit as an example:
> 
> commit f086edef71be7174a16c1ed67ac65a085cda28b1
> Author: Kevin Yang <yyd@google.com>
> Date:   Mon Jun 3 21:30:54 2024 +0000
> 
>      tcp: add sysctl_tcp_rto_min_us
> 
>      Adding a sysctl knob to allow user to specify a default
>      rto_min at socket init time, other than using the hard
>      coded 200ms default rto_min.
> 
>      Note that the rto_min route option has the highest precedence
>      for configuring this setting, followed by the TCP_BPF_RTO_MIN
>      socket option, followed by the tcp_rto_min_us sysctl.
> 
> It includes three cases, 1) route option, 2) bpf option, 3) sysctl.
> The first priority can override others. It doesn't have a good
> chance/point to restore the icsk_rto_min field if users want to
> shutdown the bpf program because it is set in
> bpf_sol_tcp_setsockopt().

rto_min example is slightly different. With tcp_rto_min the doesn't
expect any data to come back to user space while for timestamping the
app may be confused directly by providing more data, or by not providing
expected data. I believe some hint about requestor of the data is needed
here. It will also help to solve the problem of populating sk_err_queue
mentioned by Martin.


