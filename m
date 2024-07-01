Return-Path: <bpf+bounces-33468-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2A891D9AA
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 10:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE21C284EEC
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 08:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38CC4823AF;
	Mon,  1 Jul 2024 08:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="gggtZFLp"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1BA5C614;
	Mon,  1 Jul 2024 08:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719821241; cv=none; b=NWdlkrTBVfP50yqvE0MBp3bPtr2L50b5fMrnHpF1MbVrHZTxhbfy5vDTSmZONR/D9NizgjqqAMSEtkvXUcaroL/tHVlboGAtcsF2qY0bGwAFMGv9KAICYetrxVHhcfEwbKdGWDV8tQfuqL4iNN3rN3K1rmTMikm6iecxL8RL5dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719821241; c=relaxed/simple;
	bh=3Hc856aw6bOsK5L6t5DfLT5e5XmQ/CuZmw2ejIUUYEA=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=jhKHyWa3JYzVaimD2hTXrIkeDkRYhK/WUt2AlgHZYC5aqbV9n82dKqL7Y7+7Bs4k69biHtwhd+TGfC3GrtuDH9v9nWjsE8mb5kSGfVp9nJ3LeUyQsxSQ1Te3NliwUQ+6DxhMXWuE5OOiPXw9yhNzZESKToCNmJX7cZYEAhkflzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=gggtZFLp; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=oV5oBHh63yqsNcaUQykIzDCbVVZ2xyc88O0Bf7a/ij0=; b=gggtZFLp2+HZPqox1UWEeL2pxr
	xFpcB+L7OrVbzVQcM+f4/qANPcj0IVJxyBaEk3fAMdufonyr70WCPB/lC4IJ211qgECfGUlqaU4R+
	7+5zt2OxvMPP100jyD6xMcQP4Qgqs/KVTPItaeyHUfuSUiFQqIvJL3NiI0CIym0WrdjH9faGEuZsn
	XL8Cgl9uTz3NmykB7fB7ahDOPwPPhnqubUETFh2tuo3LDAPS+4E73I0UzeavH5zQBryLKuNcxEtp6
	GlXK7RK3M8Qt2FhSVr8U2p7GiqFD94p+SsDrBNZ3kch9ZwL2FrzysIumCnwUyXNVWhwREKh1BsswR
	vwMK/1YQ==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1sOC45-000ClF-BH; Mon, 01 Jul 2024 10:07:09 +0200
Received: from [178.197.249.41] (helo=linux.home)
	by sslproxy03.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1sOC43-000FAQ-3A;
	Mon, 01 Jul 2024 10:07:08 +0200
Subject: Re: [PATCH v5 bpf-next 3/3] selftests/bpf: Add selftest for
 bpf_xdp_flow_lookup kfunc
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: bpf@vger.kernel.org, pablo@netfilter.org, kadlec@netfilter.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netfilter-devel@vger.kernel.org, netdev@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
 lorenzo.bianconi@redhat.com, toke@redhat.com, fw@strlen.de, hawk@kernel.org,
 horms@kernel.org, donhunte@redhat.com, memxor@gmail.com
References: <cover.1718379122.git.lorenzo@kernel.org>
 <6472c7a775f6a329d16352092071fda8676c2809.1718379122.git.lorenzo@kernel.org>
 <89bd0cd7-ed01-a343-d873-dc0c6d2810f2@iogearbox.net>
 <ZoBqijOJi2JVcHDB@lore-desk>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <66efa6eb-ed16-57b3-f490-8b3b4e6243f1@iogearbox.net>
Date: Mon, 1 Jul 2024 10:07:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZoBqijOJi2JVcHDB@lore-desk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27322/Sun Jun 30 10:36:30 2024)

On 6/29/24 10:11 PM, Lorenzo Bianconi wrote:
>> On 6/14/24 5:40 PM, Lorenzo Bianconi wrote:
>> [...]
>>> +void test_xdp_flowtable(void)
>>> +{
>>> +	struct xdp_flowtable *skel = NULL;
>>> +	struct nstoken *tok = NULL;
>>> +	int iifindex, stats_fd;
>>> +	__u32 value, key = 0;
>>> +	struct bpf_link *link;
>>> +
>>> +	if (SYS_NOFAIL("nft -v")) {
>>> +		fprintf(stdout, "Missing required nft tool\n");
>>> +		test__skip();
>>> +		return;
>>
>> Bit unfortunate that upstream CI skips the test case at the moment:
> 
> yep, we are missing nft utility there.

Ok, not a blocker imho, but if you could work with Manu to get this
enabled in the CI, that would be great so that the test can actually
run.

Thanks,
Daniel

