Return-Path: <bpf+bounces-13348-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 741367D883C
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 20:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 003A82820C6
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 18:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E823AC11;
	Thu, 26 Oct 2023 18:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ae94W2+r"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BC13A28F
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 18:27:40 +0000 (UTC)
X-Greylist: delayed 410 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 26 Oct 2023 11:27:38 PDT
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D801A7
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 11:27:38 -0700 (PDT)
Message-ID: <4693cb58-ab86-495f-838e-50464fe116ce@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1698344440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zdfz9dbBUnxK7CCnvyJwACcXErsLKbZ8wsFVwYqLJ+s=;
	b=Ae94W2+rYlVe/tLX3osTwITgp/E85oylSGm3WLKBjIy+cJABM6qbc1hAHCoWdxogkATXXT
	RQjHUhX3swK6XyQlYQmcMHGjMOS/AJLtIgP2NbKFfsRX9b028H500PzfV+rFvjmrpKB6q/
	Znw20+Ghv6azoOuevXL42O6pTSAAQeo=
Date: Thu, 26 Oct 2023 19:20:33 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/2] selftests: bpf: crypto skcipher algo
 selftests
Content-Language: en-US
To: Daniel Borkmann <daniel@iogearbox.net>, Vadim Fedorenko
 <vadfed@meta.com>, Martin KaFai Lau <martin.lau@linux.dev>,
 Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Mykola Lysenko <mykolal@fb.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20231026015938.276743-1-vadfed@meta.com>
 <20231026015938.276743-2-vadfed@meta.com>
 <d7f21ccf-a866-53e1-4de9-e1cc972edaed@iogearbox.net>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <d7f21ccf-a866-53e1-4de9-e1cc972edaed@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 26/10/2023 15:02, Daniel Borkmann wrote:
> On 10/26/23 3:59 AM, Vadim Fedorenko wrote:
>> Add simple tc hook selftests to show the way to work with new crypto
>> BPF API. Some weird structre and map are added to setup program to make
>> verifier happy about dynptr initialization from memory. Simple AES-ECB
>> algo is used to demonstrate encryption and decryption of fixed size
>> buffers.
>>
>> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
>> ---
>>   tools/testing/selftests/bpf/config            |   1 +
>>   .../selftests/bpf/prog_tests/crypto_sanity.c  | 129 +++++++++++++++
>>   .../selftests/bpf/progs/crypto_common.h       |  98 +++++++++++
>>   .../selftests/bpf/progs/crypto_sanity.c       | 154 ++++++++++++++++++
>>   4 files changed, 382 insertions(+)
>>   create mode 100644 
>> tools/testing/selftests/bpf/prog_tests/crypto_sanity.c
>>   create mode 100644 tools/testing/selftests/bpf/progs/crypto_common.h
>>   create mode 100644 tools/testing/selftests/bpf/progs/crypto_sanity.c
>>
>> diff --git a/tools/testing/selftests/bpf/config 
>> b/tools/testing/selftests/bpf/config
>> index 02dd4409200e..2a5d6339831b 100644
>> --- a/tools/testing/selftests/bpf/config
>> +++ b/tools/testing/selftests/bpf/config
>> @@ -14,6 +14,7 @@ CONFIG_CGROUP_BPF=y
>>   CONFIG_CRYPTO_HMAC=y
>>   CONFIG_CRYPTO_SHA256=y
>>   CONFIG_CRYPTO_USER_API_HASH=y
>> +CONFIG_CRYPTO_SKCIPHER=y
>>   CONFIG_DEBUG_INFO=y
>>   CONFIG_DEBUG_INFO_BTF=y
>>   CONFIG_DEBUG_INFO_DWARF4=y
> 
> Quick note: for upstream CI side, more config seems missing, see the GHA 
> failure:

Thanks for the signal, Daniel. Looks like CONFIG_CRYPTO_ECB is missing.
I'll adjust config for v2, but I'll wait a bit longer to get more
feedback

> https://github.com/kernel-patches/bpf/actions/runs/6654055344/job/18081734522
> 
> Notice: Success: 435/3403, Skipped: 32, Failed: 1
> Error: #64 crypto_sanity
>    Error: #64 crypto_sanity
>    test_crypto_sanity:PASS:skel open 0 nsec
>    test_crypto_sanity:PASS:ip netns add crypto_sanity_ns 0 nsec
>    test_crypto_sanity:PASS:ip -net crypto_sanity_ns -6 addr add 
> face::1/128 dev lo nodad 0 nsec
>    test_crypto_sanity:PASS:ip -net crypto_sanity_ns link set dev lo up 0 
> nsec
>    test_crypto_sanity:PASS:crypto_sanity__load 0 nsec
>    open_netns:PASS:malloc token 0 nsec
>    open_netns:PASS:open /proc/self/ns/net 0 nsec
>    open_netns:PASS:open netns fd 0 nsec
>    open_netns:PASS:setns 0 nsec
>    test_crypto_sanity:PASS:open_netns 0 nsec
>    test_crypto_sanity:PASS:if_nametoindex lo 0 nsec
>    test_crypto_sanity:PASS:crypto_sanity__attach 0 nsec
>    test_crypto_sanity:PASS:skb_crypto_setup fd 0 nsec
>    test_crypto_sanity:PASS:skb_crypto_setup 0 nsec
>    test_crypto_sanity:PASS:skb_crypto_setup retval 0 nsec
>    test_crypto_sanity:FAIL:skb_crypto_setup status unexpected error: -95 
> (errno 2)
>    libbpf: Kernel error message: Parent Qdisc doesn't exists
>    close_netns:PASS:setns 0 nsec
> Test Results:
>               bpftool: PASS
>   test_progs-no_alu32: FAIL (returned 1)
>              shutdown: CLEAN
> Error: Process completed with exit code 1.


