Return-Path: <bpf+bounces-75343-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 538C2C80FC3
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 15:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B5773345757
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 14:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62DD30F52C;
	Mon, 24 Nov 2025 14:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BWoOOJLX"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6608B3043BD
	for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 14:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763994272; cv=none; b=kc3K29KGrn9aPA0DUjVz2EtHho1X67Aoc6GG7vF9KNqbuss4mRGcS2Ywr/p+/f4nKRfLdZKfV6ZnG78gnqG5SN/OMy54aWE2z0yos2A/MvhTEc26RfomQy7PDOAZJGjbFinu7jC3eltODdPXHyFquwnFWNytwaJyQyObpnxgfAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763994272; c=relaxed/simple;
	bh=HopjOyG0yLSJ8H+vj0g0gPLWne0fYbdJ7c/qNICipdY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DLoULmZ1lFagNXsIa3ut2SFq6RsuPvZh8YEGq3jbRmu1SDQd5L8aGa6Jeewifp7dPkLqEv679k9zd3r2s5XS3LaqKh/uS1yE1NRjBWWVWWYKuVJG9JMXbzvFZ0oZ/e78Rr+4zvWrmsQWOGq5Ht3cLPkpGhAHRfl+ylLOtXzjiaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BWoOOJLX; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5a633862-ae0e-43ba-8da6-0f03efd01bde@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763994258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qeiYgrXnmUsYEngedEc4LRUzDKY1yGdvKClr67ha3/A=;
	b=BWoOOJLXEfTp9oNy8Vs/hkx+lOu7wJ/edsodeHAB4HPCtx+Tlp/6gzTEPZr3RgvhB2bPff
	Yw2mfFUh6/wlqgoLbeBLMePKs+UiRWKlj2mWWBB1k7X7QcvfjMQHtsfDFZU1kCrcVRLoL5
	MYsccu9PgW7SX5X7I36qJYwDi/TXQVg=
Date: Mon, 24 Nov 2025 22:23:53 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v10 8/8] selftests/bpf: Add cases to test
 BPF_F_CPU and BPF_F_ALL_CPUS flags
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jiri Olsa <jolsa@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 Song Liu <song@kernel.org>, Eduard <eddyz87@gmail.com>,
 Daniel Xu <dxu@dxuuu.xyz>, =?UTF-8?Q?Daniel_M=C3=BCller?= <deso@posteo.net>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Shuah Khan <shuah@kernel.org>, Jason Xing <kerneljasonxing@gmail.com>,
 Tao Chen <chen.dylane@linux.dev>, Willem de Bruijn <willemb@google.com>,
 Paul Chaignon <paul.chaignon@gmail.com>,
 Anton Protopopov <a.s.protopopov@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Mykyta Yatsenko <yatsenko@meta.com>, Tobias Klauser <tklauser@distanz.ch>,
 kernel-patches-bot@fb.com, LKML <linux-kernel@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
References: <20251117162033.6296-1-leon.hwang@linux.dev>
 <20251117162033.6296-9-leon.hwang@linux.dev>
 <CAADnVQLARr69Qv9EfwWkpudXLZNb21zYd86aPux_Fv3UAsrLGw@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAADnVQLARr69Qv9EfwWkpudXLZNb21zYd86aPux_Fv3UAsrLGw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/11/22 10:34, Alexei Starovoitov wrote:
> On Mon, Nov 17, 2025 at 8:22 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>

[...]

>> +
>> +                       /* lookup then check value on CPUs */
>> +                       for (j = 0; j < nr_cpus; j++) {
>> +                               flags = (u64)j << 32 | BPF_F_CPU;
>> +                               err = bpf_map__lookup_elem(map, keys + i * key_sz, key_sz, values,
>> +                                                          value_sz, flags);
>> +                               if (!ASSERT_OK(err, "bpf_map__lookup_elem specified cpu"))
>> +                                       goto out;
>> +                               if (!ASSERT_EQ(values[0], j != cpu ? 0 : value,
>> +                                              "bpf_map__lookup_elem value on specified cpu"))
>> +                                       goto out;
> 
> I was about to apply it, but noticed that the test is unstable.
> It fails 1 out of 10 for me in the above line.
> test_percpu_map_op_cpu_flag:PASS:bpf_map_lookup_batch value on
> specified cpu 0 nsec
> test_percpu_map_op_cpu_flag:FAIL:bpf_map_lookup_batch value on
> specified cpu unexpected bpf_map_lookup_batch value on specified cpu:
> actual 0 != expected 3735929054
> #261/15  percpu_alloc/cpu_flag_lru_percpu_hash:FAIL
> #261     percpu_alloc:FAIL
> 
> Please investigate what is going on.
> 

I was able to reproduce the failure on a 16-core VM.

It appears to be caused by LRU eviction. When I increased max_entries of
the lru_percpu_hash map to libbpf_num_possible_cpus(), the issue no
longer reproduced.

I'll need to spend more time investigating the exact eviction behavior
and why it shows up intermittently in this test.

Thanks,
Leon

