Return-Path: <bpf+bounces-28164-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A328B646A
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 23:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A79A28154D
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 21:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0B9181CF9;
	Mon, 29 Apr 2024 21:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="mY35Ux28"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37E0181CE1;
	Mon, 29 Apr 2024 21:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714425490; cv=none; b=ThuPxXnIHF0rdiCQ0qIVJSUDrC2UaiBNOzy9jLRHEX5wZ7pPTerKCRfFBfaWjE6bEGzp+CbjBoXURphOvcNXOn9zy78X99PaRNACguTae9kojSINRVhsyoArqyeQJlcrTf87FNiNFl0f0TxifLwmMvuyoywDOGuX4UR89WNkZ64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714425490; c=relaxed/simple;
	bh=Y40YJgGC9bzAP4rPt/6nXx9ttt0Mma/zB+bYAHHcA5Y=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=t2ck4Os2shqTa2/2r5OfJ6CKtwwKJ2TsOKveUNub9sKIaVT7uDJbdzkD+kUHzTUEx8FcS8/ufxh7aRt79APFkuo+ro/n5celt9GPIHXfsAeOFygbRyaArMroLSo7BQbw7VuXNy7y/Hb86UnmiE3cvmXoVI2z2qxg9wGJ8B2cmeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=mY35Ux28; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=GBcSRXrIbN5ppfuE9I4mOD41eAds0UlUcMYleADEdTk=; b=mY35Ux286LTU8BU4NPTHXJg1YA
	uxBtU3DT7PYrRpV97HYPut+lsCawjmQEcalWz/aZABK9k3vOMr6PvpgW5LzxgUnjoIwftRJkYJseV
	ynprCZ1GMb/bLbBIael7MdOwKitNcjk74prXe6XBOaZEp9E4RFuV02ByoKYpnJLUfByAPHSDS2tT9
	+wQlaBQ6jxep6IdnIrDc+t2XpdqwTOQ1latOfGpDRJkHkHfTqFGHZhF9LWQ2IBwqPeQwMgNFHzuK4
	HLA0krTnmBSGQdAoAyMln4/L2Udpnsp2GRyQKWOlDuG2e0ef+ljX9pdDm2HUlbb8j2jxKXj1kIVul
	Dd3gRqng==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1s1YND-000C1H-4n; Mon, 29 Apr 2024 23:17:56 +0200
Received: from [178.197.249.41] (helo=linux.home)
	by sslproxy06.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1s1YNo-00HXdP-0T;
	Mon, 29 Apr 2024 23:17:56 +0200
Subject: Re: linux-next: manual merge of the bpf-next tree with the net tree
To: Jakub Kicinski <kuba@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 David Miller <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Puranjay Mohan <puranjay12@gmail.com>, Puranjay Mohan <puranjay@kernel.org>
References: <20240429114939.210328b0@canb.auug.org.au>
 <20240429115643.7df77e08@kernel.org>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <9f6f6d23-269b-bdff-89ad-7e31223a47e9@iogearbox.net>
Date: Mon, 29 Apr 2024 23:17:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240429115643.7df77e08@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27260/Mon Apr 29 10:23:47 2024)

On 4/29/24 8:56 PM, Jakub Kicinski wrote:
> On Mon, 29 Apr 2024 11:49:39 +1000 Stephen Rothwell wrote:
>>   +u64 __weak bpf_arch_uaddress_limit(void)
>>   +{
>>   +#if defined(CONFIG_64BIT) && defined(CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE)
>>   +	return TASK_SIZE;
>>   +#else
>>   +	return 0;
>>   +#endif
>>   +}
>>   +
>> + bool __weak bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena)
>> + {
>> + 	return false;
>> + }
> 
> Thanks! FTR I plan to used the inverse order, if that matters..

Yeap, that looks cleaner, same for the signature in the header given the others
prefixed with bpf_jit_supports_*.

Thanks,
Daniel

