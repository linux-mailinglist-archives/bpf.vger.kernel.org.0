Return-Path: <bpf+bounces-31195-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0687C8D82FF
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 14:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 354421C21278
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 12:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A7C12C554;
	Mon,  3 Jun 2024 12:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=david-bauer.net header.i=@david-bauer.net header.b="KBXegAQJ"
X-Original-To: bpf@vger.kernel.org
Received: from perseus.uberspace.de (perseus.uberspace.de [95.143.172.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C84C12C52E
	for <bpf@vger.kernel.org>; Mon,  3 Jun 2024 12:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.172.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717419363; cv=none; b=PlZmTA1sCDzLD/tW/yHVtBtuyYM60F4G3HTD5Q654WhU4LQnuaJThaqst9Ua3OldOo1Xaa4mwrZ35su8/WB3ZAVBFIXGn1ORQagH+T/wLg3QwzgjENO5Z5N0VVkmlc8vmqgAN9GtEcnQi2pOHGryNOAWk66cbAN18IAO1hrOdOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717419363; c=relaxed/simple;
	bh=+7sr3QxfhNoWxuNn1t2yX0rvSmA4G8LYQ28H9HbpGZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B8ssjNlaIzNvJYlLfjffJ8I29YuH4YQrLYb3D92lg4zDilBlM51M3Qaa0EdcPxkSsYf75SgEiaVWiSM8urcMWOn14OfeDMOLEk0ltEBz8x+Eax71T1Wrd4DmeJnmex3JGWEGi+Et6Ui4lr5exW4ss1VR5LKSDES7kLQLz9xVgwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=david-bauer.net; spf=pass smtp.mailfrom=david-bauer.net; dkim=pass (4096-bit key) header.d=david-bauer.net header.i=@david-bauer.net header.b=KBXegAQJ; arc=none smtp.client-ip=95.143.172.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=david-bauer.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=david-bauer.net
Received: (qmail 8953 invoked by uid 988); 3 Jun 2024 12:49:16 -0000
Authentication-Results: perseus.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
	by perseus.uberspace.de (Haraka/3.0.1) with ESMTPSA; Mon, 03 Jun 2024 14:49:16 +0200
Message-ID: <a42ed416-3623-4c14-a20f-43f9a7c487ae@david-bauer.net>
Date: Mon, 3 Jun 2024 14:49:15 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net] vxlan: Fix regression when dropping packets due to
 invalid src addresses
To: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
 Nikolay Aleksandrov <razor@blackwall.org>,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20240603085926.7918-1-daniel@iogearbox.net>
Content-Language: en-US
From: David Bauer <mail@david-bauer.net>
Autocrypt: addr=mail@david-bauer.net; keydata=
 xjMEZgynMBYJKwYBBAHaRw8BAQdA+32xE63/l6uaRAU+fPDToCtlZtYJhzI/dt3I6VxixXnN
 IkRhdmlkIEJhdWVyIDxtYWlsQGRhdmlkLWJhdWVyLm5ldD7CjwQTFggANxYhBLPGu7DmE/84
 Uyu0uW0x5c9UngunBQJmDKcwBQkFo5qAAhsDBAsJCAcFFQgJCgsFFgIDAQAACgkQbTHlz1Se
 C6eKAwEA8B6TGkUMw8X7Kv3JdBIoDqJG9+fZuuwlmFsRrdyDyHkBAPtLydDdancCVWNucImJ
 GSk+M80qzgemqIBjFXW0CZYPzjgEZgynMBIKKwYBBAGXVQEFAQEHQPIm0qo7519c7VUOTAUD
 4OR6mZJXFJDJBprBfnXZUlY4AwEIB8J+BBgWCAAmFiEEs8a7sOYT/zhTK7S5bTHlz1SeC6cF
 AmYMpzAFCQWjmoACGwwACgkQbTHlz1SeC6fP2AD8CduoErEo6JePUdZXwZ1e58+lAeXOLLvC
 2kj1OiLjqK4BANoZuHf/ku8ARYjUdIEgfgOzMX/OdYvn0HiaoEfMg7oB
In-Reply-To: <20240603085926.7918-1-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Bar: ---
X-Rspamd-Report: BAYES_HAM(-2.99017) XM_UA_NO_VERSION(0.01) MIME_GOOD(-0.1)
X-Rspamd-Score: -3.08017
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=david-bauer.net; s=uberspace;
	h=from:to:cc:subject:date;
	bh=+7sr3QxfhNoWxuNn1t2yX0rvSmA4G8LYQ28H9HbpGZI=;
	b=KBXegAQJQ8YNd+00GLk4JqsQDIw61n1KqOOlZ9QL7z4TnxuNNj3JOkSQUZ5jOZatV1Qnvj2Gxq
	Y67wjm32vKqyW0LSDeAYu9NSL2Qzq1gMCcqvasyJ6oYYbcd/H0ba5uZszaP546NYH+qO0dmPRthL
	q7zEyjNaYA86HvHHwRWp1bFMXQ8hcgG7yTeG0enXdx7yGEhlpHlEpnhODcUS4yP/kZTGG5qfl8Ub
	e9kSM8jj12kGkEd5dWXHCDNGmiYHR6SrqbBI7HDbUmn/IOnmRQ24exd1DDekBlCnv3fhwo6e3ic3
	vythOh9OUufecP82aIkBcLG2E/w8pd7b3Y9nRKa9Js7s7PNhikJp/U0cfSbZEojorpDn8gvpQcai
	LI4GXD+3ssoRSuPEjRjQOSi1F7xF6uQVAgmi/YHvC2OrIbdijoEGj/V6wrqFTPkK9Rh8YuLqpn24
	6ZMXAxwH5g/ZkOw2+lGl7bpvculSoi5O48eXXuedu/kXynnxvzgoWGTDpmbWFfhtnCL6SBjxemgi
	PA6aqpnxG/lVrPFtHfM7/p4DzKR5vMUuNtlQx1LLQtWK2bXgmG5PjlhmSfpl0Ghf3ybT2CLrxmrf
	9TFL6pQqcnOLSdyN5BrcDutq2SHsYSqkCQ7BfVVkywyRkiLKOPHNFYV39Ket4sJ0KGlNsR62lHdC
	E=



On 6/3/24 10:59, Daniel Borkmann wrote:
> Commit f58f45c1e5b9 ("vxlan: drop packets from invalid src-address")
> has recently been added to vxlan mainly in the context of source
> address snooping/learning so that when it is enabled, an entry in the
> FDB is not being created for an invalid address for the corresponding
> tunnel endpoint.
> 
> Before commit f58f45c1e5b9 vxlan was similarly behaving as geneve in
> that it passed through whichever macs were set in the L2 header. It
> turns out that this change in behavior breaks setups, for example,
> Cilium with netkit in L3 mode for Pods as well as tunnel mode has been
> passing before the change in f58f45c1e5b9 for both vxlan and geneve.
> After mentioned change it is only passing for geneve as in case of
> vxlan packets are dropped due to vxlan_set_mac() returning false as
> source and destination macs are zero which for E/W traffic via tunnel
> is totally fine.
> 
> Fix it by only opting into the is_valid_ether_addr() check in
> vxlan_set_mac() when in fact source address snooping/learning is
> actually enabled in vxlan. This is done by moving the check into
> vxlan_snoop(). With this change, the Cilium connectivity test suite
> passes again for both tunnel flavors.
> 
> Fixes: f58f45c1e5b9 ("vxlan: drop packets from invalid src-address")
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: David Bauer <mail@david-bauer.net>
> Cc: Ido Schimmel <idosch@nvidia.com>
> Cc: Nikolay Aleksandrov <razor@blackwall.org>
> Cc: Martin KaFai Lau <martin.lau@kernel.org>

Reviewed-by: David Bauer <mail@david-bauer.net>

Best
David

