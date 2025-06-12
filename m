Return-Path: <bpf+bounces-60430-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9DBAD6561
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 03:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB16917AA38
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 01:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282D619DF9A;
	Thu, 12 Jun 2025 01:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QlJJRsdx"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A9619644B
	for <bpf@vger.kernel.org>; Thu, 12 Jun 2025 01:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749693558; cv=none; b=Nclrz3rLTFJM3AyPNC/BDe55ZsflCt+8YrSx/phpi0cd/DrFUbRqTi9t2U1EHqsn4mzJAgi/VD3mlqrTWy+vqspR2mClzEPxvgAX9P+Y9Lg36pUFco50hmOTizyAckt+fZULgS0FwwNkdEdwaG084xLb1yNrtY28Pz7+E/0Tq4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749693558; c=relaxed/simple;
	bh=G2pttsxMhhi3blG4Mv9Bzg6qPa6LeR95sFGBeTZhXZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tIbD3CZ3ULVb3bVqqlTMiGh+1WMp8n52RRmzmerX5KPr7smEqn8q4BoM7KTTV6hwIZcS3H0xeUGrvA5uX/afogvq5e/xjX1TGNHJRTZelYSofpd4INXtO6JEbyXt3Nb1eAhp3GtzGulz+Vg8dKkcaWOfw55v0JD20OMaDCXUeZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QlJJRsdx; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5fcbfcdb-0b00-4314-94a2-b538ea9815c2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749693554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GU3FOm67b5FXMMpnclPSQAFx5GjFcVkCWqgm9M3BixQ=;
	b=QlJJRsdxil/WWuTLFXJDZQGu1JlYdZgtGQCyKts3tr0DXGq9YcVdTMfFnk62i8K/mKNN49
	8qj6okmduBoHFYJQ+YqLpqLblmUGB4ao0u+1VR7sxp+Xx8xR2yHpAwc4DQzDtEpX/HNI+z
	py72aCr3/fphyLHtWKG4N2sj8JQ1dwA=
Date: Wed, 11 Jun 2025 18:59:02 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 2/3] selftests/bpf: Fix two net related test
 failures with 64K page size
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
References: <20250611171519.2033193-1-yonghong.song@linux.dev>
 <20250611171529.2034330-1-yonghong.song@linux.dev>
 <CAADnVQ+H+1eq3BqvCzeNwS=PZBXC7RAR3X6SkuSKC3CuEA88rg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQ+H+1eq3BqvCzeNwS=PZBXC7RAR3X6SkuSKC3CuEA88rg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 6/11/25 12:21 PM, Alexei Starovoitov wrote:
> On Wed, Jun 11, 2025 at 10:15 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>> When running BPF selftests on arm64 with a 64K page size, I encountered
>> the following two test failures:
>>    sockmap_basic/sockmap skb_verdict change tail:FAIL
>>    tc_change_tail:FAIL
>>
>> With further debugging, I identified the root cause in the following
>> kernel code within __bpf_skb_change_tail():
>>
>>      u32 max_len = BPF_SKB_MAX_LEN;
>>      u32 min_len = __bpf_skb_min_len(skb);
>>      int ret;
>>
>>      if (unlikely(flags || new_len > max_len || new_len < min_len))
>>          return -EINVAL;
>>
>> With a 4K page size, new_len = 65535 and max_len = 16064, the function
>> returns -EINVAL. However, With a 64K page size, max_len increases to
>> 261824, allowing execution to proceed further in the function. This is
>> because BPF_SKB_MAX_LEN scales with the page size and larger page sizes
>> result in higher max_len values.
>>
>> Updating the new_len parameter in both tests from 65535 to 256K (0x40000)
>> resolves the failures.
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   tools/testing/selftests/bpf/progs/test_sockmap_change_tail.c | 5 ++++-
>>   tools/testing/selftests/bpf/progs/test_tc_change_tail.c      | 5 ++++-
>>   2 files changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/testing/selftests/bpf/progs/test_sockmap_change_tail.c b/tools/testing/selftests/bpf/progs/test_sockmap_change_tail.c
>> index 2796dd8545eb..e4554ef05441 100644
>> --- a/tools/testing/selftests/bpf/progs/test_sockmap_change_tail.c
>> +++ b/tools/testing/selftests/bpf/progs/test_sockmap_change_tail.c
>> @@ -3,6 +3,9 @@
>>   #include <linux/bpf.h>
>>   #include <bpf/bpf_helpers.h>
>>
>> +#define PAGE_SIZE 65536 /* make it work on 64K page arches */
>> +#define BPF_SKB_MAX_LEN (PAGE_SIZE << 2)
>> +
>>   struct {
>>          __uint(type, BPF_MAP_TYPE_SOCKMAP);
>>          __uint(max_entries, 1);
>> @@ -31,7 +34,7 @@ int prog_skb_verdict(struct __sk_buff *skb)
>>                  change_tail_ret = bpf_skb_change_tail(skb, skb->len + 1, 0);
>>                  return SK_PASS;
>>          } else if (data[0] == 'E') { /* Error */
>> -               change_tail_ret = bpf_skb_change_tail(skb, 65535, 0);
>> +               change_tail_ret = bpf_skb_change_tail(skb, BPF_SKB_MAX_LEN, 0);
>>                  return SK_PASS;
>>          }
>>          return SK_PASS;
>> diff --git a/tools/testing/selftests/bpf/progs/test_tc_change_tail.c b/tools/testing/selftests/bpf/progs/test_tc_change_tail.c
>> index 28edafe803f0..47670bbd1766 100644
>> --- a/tools/testing/selftests/bpf/progs/test_tc_change_tail.c
>> +++ b/tools/testing/selftests/bpf/progs/test_tc_change_tail.c
>> @@ -7,6 +7,9 @@
>>   #include <linux/udp.h>
>>   #include <linux/pkt_cls.h>
>>
>> +#define PAGE_SIZE 65536 /* make it work on 64K page arches */
>> +#define BPF_SKB_MAX_LEN (PAGE_SIZE << 2)
> If you want it to match the kernel then let's use actual page size?
> See bpf_arena_common.h and
> #ifndef PAGE_SIZE
> #define PAGE_SIZE __PAGE_SIZE

LGTM. This will allow to use actual page size...


