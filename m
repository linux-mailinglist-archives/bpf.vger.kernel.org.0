Return-Path: <bpf+bounces-69804-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2651EBA289C
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 08:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9EAF62690A
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 06:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE22A27B323;
	Fri, 26 Sep 2025 06:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="n9pzeObF"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901071E50E;
	Fri, 26 Sep 2025 06:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758868789; cv=none; b=dBREFsXW5ttq6vCsBXDu9puaADAoJc1kDj3tP0TzO6PIORpwQ8Jwr/hptfqaUc2tZgBwRF4G4WqBaG7OljcfyrtoIiSP+7o9X7p64BNvBuNX2ab3yn1kkZTlyiThtR/uAW3v6HneY2vRGJ7GzNGPyPQAtwBOZ85ev554+zd6iR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758868789; c=relaxed/simple;
	bh=Cpbap+PDFOu/VEl1phJ1AaBhj44ckD2ndve8aVh1LpU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mD9UwgwOm9rTPsvSp/jsTgTiq1qLSV57o1zhRpLSm8/2Q4nW8I4nm2UsAvzWypRk6KRTX7IY22kGzaq1+yfFDIwAylt30Szk44OL6ixkLUt4AovBmVV8g5P4CUkrzF0ukfKWMfsdp7JT8r67J3nI0UouWt0bUBFO8V5K78N3bNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=n9pzeObF; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 845691A0FD1;
	Fri, 26 Sep 2025 06:39:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3ED3D606B5;
	Fri, 26 Sep 2025 06:39:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 399E8102F1866;
	Fri, 26 Sep 2025 08:39:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758868781; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=14z+TiK5hRCFldcX29BYnmuev1AbaddAl5M7Wwnpuio=;
	b=n9pzeObFQGhOsimHXI/Q2R5MmFDVYe7YeGAJUjDx9YdIooVqxZIhHuO1nD/e/D5hraeNp0
	4n3HB4/ok//4cT5x1rXCethF0MoQSXvAOTMh3XgJaICaksphflgl2S987lxWSGeBYUALC/
	zGTj31yB5SXNaOJhUi6sDbAFLmyGCaEAY+4X4F9UGTrJ0UiRT0s6HXcfLIdyKhI+yu1Ygz
	Nq6dd9KrpXLOuNRZad4GOY7vJkFHoO9GGg8ElYQArHy8U7aY/S5e6lpduNBGTPG0oNfMpF
	yj+KGv1qTYUPutnWbWxcJ0OtEWNthQSTNTNCEEtgR3DzfJhNeAY6Ur3DelHtOQ==
Message-ID: <fd600cd5-062e-4806-9e8e-b7f6aacad242@bootlin.com>
Date: Fri, 26 Sep 2025 08:39:28 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 04/15] selftests/bpf: test_xsk: fix memory
 leak in testapp_stats_rx_dropped()
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Magnus Karlsson <magnus.karlsson@intel.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Alexis Lothore <alexis.lothore@bootlin.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250924-xsk-v4-0-20e57537b876@bootlin.com>
 <20250924-xsk-v4-4-20e57537b876@bootlin.com> <aNVEiTJywHNJeEzL@boxer>
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Content-Language: en-US
In-Reply-To: <aNVEiTJywHNJeEzL@boxer>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Maciej,

On 9/25/25 3:32 PM, Maciej Fijalkowski wrote:
> On Wed, Sep 24, 2025 at 04:49:39PM +0200, Bastien Curutchet (eBPF Foundation) wrote:
>> testapp_stats_rx_dropped() generates pkt_stream twice. The last
>> generated is released by pkt_stream_restore_default() at the end of the
>> test but we lose the pointer of the first pkt_stream.
>>
>> Release the 'middle' pkt_stream when it's getting replaced to prevent
>> memory leaks.
>>
>> Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
>> ---
>>   tools/testing/selftests/bpf/test_xsk.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/tools/testing/selftests/bpf/test_xsk.c b/tools/testing/selftests/bpf/test_xsk.c
>> index 8d7c38eb32ca3537cb019f120c3350ebd9f8c6bc..eb18288ea1e4aa1c9337d16333b7174ecaed0999 100644
>> --- a/tools/testing/selftests/bpf/test_xsk.c
>> +++ b/tools/testing/selftests/bpf/test_xsk.c
>> @@ -536,6 +536,13 @@ static void pkt_stream_receive_half(struct test_spec *test)
>>   	struct pkt_stream *pkt_stream = test->ifobj_tx->xsk->pkt_stream;
>>   	u32 i;
>>   
>> +	if (test->ifobj_rx->xsk->pkt_stream != test->rx_pkt_stream_default)
>> +		/* Packet stream has already been replaced so we have to release this one.
>> +		 * The newly created one will be freed by the restore_default() at the
>> +		 * end of the test
>> +		 */
>> +		pkt_stream_delete(test->ifobj_rx->xsk->pkt_stream);
> 
> I don't see why this one is not addressed within test case
> (testapp_stats_rx_dropped()) and other fix is (testapp_xdp_shared_umem()).
> 

pkt_stream_receive_half() can be used by other tests. I thought it would 
be more convenient for people writing testapp_*() functions if they 
didn't have to worry about releasing these kind of pointer themselves.

The same approach can't be used in testapp_xdp_shared_umem(), because we 
need to wait for the test to complete before releasing the pointers.


-- 
Bastien Curutchet, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


