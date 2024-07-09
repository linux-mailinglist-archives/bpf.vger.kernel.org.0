Return-Path: <bpf+bounces-34281-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C83A92C411
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 21:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 155941F22B15
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 19:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314ED18560D;
	Tue,  9 Jul 2024 19:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="ky8UonBs"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21BA12DDAE;
	Tue,  9 Jul 2024 19:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720554513; cv=none; b=h8/6x4SAwjTI3UQR0hUVNdN0swMvh6HrgfprTlso7ZRLCbQg0RHVyaZxf/Wjkb3fj63CIPWd/aizqh6pT2wAdiv8iJL6vII9pGZMwtFqt5nxW+mlceRx2W9ZsPQ+ePM5JVP/RNJf3eUu6zzeJiusMW+oXaa713A4zjTc+E+dCCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720554513; c=relaxed/simple;
	bh=zmzwTSc1vI+xIpXkXuVVwJMeD2L95fyOwUdCdt1q1TQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=IUunkZRKjtT2yM8UGS96iNFNEcwDCDo3QeeE1VtFf3qfeXmjdc4pLFBL4kCbor1Mkp/4oW0zP3TI7uVhYfdylWzVTIDlivFZVGd5wJ3L3SkSagmUGP0DZZ+7GUG7fz25OpWwPvhg9bM0hRl8lFrwS8R3smIy9gH9WliuPQ1OU2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=ky8UonBs; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=WtHnPImDxDlgy3bT+dc6AxVGWZHTN6j8RwYWlnrGC0A=; b=ky8UonBsRku6BKRq7Yjpbj3GJF
	kBD+72CCRMW0uIJuwqnNSKE2I3qnt38x9JY/h0su1AKa7r9AahvlpRbl0MQmmZVqhUPcdlGbKVcHi
	0M5aMwssncV3TtpcbTnVtRmTqMkT1h7GgKKPTd57Q+PiWvgdRS07VBB69W529PvtObIrvEvrgQo2O
	AlhH4EFZZRCJtmP79BWvourqniZMu0ki9SZeX6xIQlG9/P4bfblUf5AQU/QLCCwsiK9lX7swtm4Ev
	CwC2QovKYRTWyjZODHlK0feHLeqlokawCHcrdKfCdzk1onR9QSCToEhEpXW0Rwh/uZyA35KXrED3v
	zI09Nwag==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1sRGp7-0000qk-M8; Tue, 09 Jul 2024 21:48:25 +0200
Received: from [178.197.248.35] (helo=linux.home)
	by sslproxy06.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1sRGp7-0001zr-0B;
	Tue, 09 Jul 2024 21:48:25 +0200
Subject: Re: [PATCH bpf 2/2] selftests/bpf: Extend tcx tests to cover late
 tcx_entry release
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: martin.lau@kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20240708133130.11609-1-daniel@iogearbox.net>
 <20240708133130.11609-2-daniel@iogearbox.net>
 <5434fdfe-e57b-479e-9fdd-0557ef74426b@linux.dev>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <622de5f5-13a3-e005-c11f-392f710adfe4@iogearbox.net>
Date: Tue, 9 Jul 2024 21:48:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <5434fdfe-e57b-479e-9fdd-0557ef74426b@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27331/Tue Jul  9 10:38:11 2024)

On 7/9/24 12:34 AM, Martin KaFai Lau wrote:
[...]
> It may be handy to be able to trigger rcu_barrier() to wait for the pending rcu callbacks to finish. Not sure if there is an existing way to do that without introducing a kfunc in bpf_testmod. Probably something to think about as an optimization.
> 
> Thanks for the fix and the test. Applied.

Thanks, I'll take a look if this is or can be cleanly exposed somehow.

>> +    ASSERT_OK(system("tc filter add dev foo ingress matchall action skbmod swap mac"), "add filter");
>> +cleanup:
>> +    ASSERT_OK(system("ip link del dev foo"), "del veth");
>> +    ASSERT_EQ(if_nametoindex("foo"), 0, "foo removed");
>> +    ASSERT_EQ(if_nametoindex("bar"), 0, "bar removed");
>> +}
>> +
>>   static void test_tc_links_dev_mixed(int target)
>>   {
>>       LIBBPF_OPTS(bpf_tc_opts, tc_opts, .handle = 1, .priority = 1);
> 
> 


