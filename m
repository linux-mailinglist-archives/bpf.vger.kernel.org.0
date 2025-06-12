Return-Path: <bpf+bounces-60427-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3986AD6545
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 03:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B3333ACAF4
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 01:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C928185B67;
	Thu, 12 Jun 2025 01:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="n6vZ/Eby"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A06217A2EA
	for <bpf@vger.kernel.org>; Thu, 12 Jun 2025 01:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749693206; cv=none; b=asHAIJKUv4zGWD69Sfv+gcVmXk08uI0rareayjkflh+yQ7kRb3GxC1nTmFrRPp3QhTTxeX5UK3UuLaSZMRG0/eFVragDU3NHtmgjPh+qIjQgjuC6fT5NSLdhPcZn/PHSUUX8TYTGEQmx41Ab10VfdqhZbTRws0+GOPP/EmRbJQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749693206; c=relaxed/simple;
	bh=XUHFYDabnW/sHUi4pscxPhWfq7LxDpuoSHs19JJ5lGg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hYzuMgiZLl6vxnT8ew7B8TaIZhE2QWBWo8IOYUraD034ad88MPj8yw/fXGNG6fDPi4BJ1D2IjE8ozheo3kCC+2t0kjsC33GVbfnklCd9Ay4gYT9hZlWONU1AjUwL/G9qygVljw+NUeN6defNKAHxYTDHkv0TtLdAPfmleap97iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=n6vZ/Eby; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <cb376d96-6fa0-40b9-8e63-a567a283ef1e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749693202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3qKRdm4W8ugxJ7b78QUE79WzrwBWhUsmmEj+/+jlVG8=;
	b=n6vZ/EbyfbQsFFNodhdS01Ozvxo9riLFwa9nz5Rlbk47NJptp8Bvb9VDMXavLml0OW/04U
	mZCSXHix8pDvfFrI9swbw+k9whtInlqOpZcLjHdAMk/wUud/UKpTDSJZjT5Gd2cEDZn2Tc
	ouKS+5YNss8+ySjt4SqBoCi2ghDkzsY=
Date: Wed, 11 Jun 2025 18:53:16 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/3] bpf: Fix an issue in
 bpf_prog_test_run_xdp when page size greater than 4K
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
References: <20250611171519.2033193-1-yonghong.song@linux.dev>
 <20250611171524.2033657-1-yonghong.song@linux.dev>
 <CAADnVQL3mBq_45EZcjFQeNMAeJXzT=TMAQo+1XpTcZxWLrTdkg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQL3mBq_45EZcjFQeNMAeJXzT=TMAQo+1XpTcZxWLrTdkg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 6/11/25 12:24 PM, Alexei Starovoitov wrote:
> On Wed, Jun 11, 2025 at 10:15 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>> The bpf selftest xdp_adjust_tail/xdp_adjust_frags_tail_grow failed on
>> arm64 with 64KB page:
>>     xdp_adjust_tail/xdp_adjust_frags_tail_grow:FAIL
>>
>> In bpf_prog_test_run_xdp(), the xdp->frame_sz is set to 4K, but later on
>> when constructing frags, with 64K page size, the frag data_len could
>> be more than 4K. This will cause problems in bpf_xdp_frags_increase_tail().
>>
>> To fix the failure, the xdp->frame_sz is set to be PAGE_SIZE so kernel
>> can test different page size properly. With the kernel change, the user
>> space and bpf prog needs adjustment. Currently, the MAX_SKB_FRAGS default
>> value is 17, so for 4K page, the maximum packet size will be less than 68K.
>> To test 64K page, a bigger maximum packet size than 68K is desired. So two
>> different functions are implemented for subtest xdp_adjust_frags_tail_grow.
>> Depending on different page size, different data input/output sizes are used
>> to adapt with different page size.
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   net/bpf/test_run.c                            |  2 +-
>>   .../bpf/prog_tests/xdp_adjust_tail.c          | 95 +++++++++++++++++--
>>   .../bpf/progs/test_xdp_adjust_tail_grow.c     |  8 +-
>>   3 files changed, 96 insertions(+), 9 deletions(-)
>>
>> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
>> index aaf13a7d58ed..9728dbd4c66c 100644
>> --- a/net/bpf/test_run.c
>> +++ b/net/bpf/test_run.c
>> @@ -1255,7 +1255,7 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
>>                  headroom -= ctx->data;
>>          }
>>
>> -       max_data_sz = 4096 - headroom - tailroom;
>> +       max_data_sz = PAGE_SIZE - headroom - tailroom;
>>          if (size > max_data_sz) {
>>                  /* disallow live data mode for jumbo frames */
>>                  if (do_live)
>> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c b/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c
>> index e361129402a1..133bde28a489 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c
>> @@ -37,21 +37,25 @@ static void test_xdp_adjust_tail_shrink(void)
>>          bpf_object__close(obj);
>>   }
>>
>> -static void test_xdp_adjust_tail_grow(void)
>> +static void test_xdp_adjust_tail_grow(bool is_64k_pagesize)
>>   {
>>          const char *file = "./test_xdp_adjust_tail_grow.bpf.o";
>>          struct bpf_object *obj;
>> -       char buf[4096]; /* avoid segfault: large buf to hold grow results */
>> +       char buf[8192]; /* avoid segfault: large buf to hold grow results */
>>          __u32 expect_sz;
>>          int err, prog_fd;
>>          LIBBPF_OPTS(bpf_test_run_opts, topts,
>>                  .data_in = &pkt_v4,
>> -               .data_size_in = sizeof(pkt_v4),
>>                  .data_out = buf,
>>                  .data_size_out = sizeof(buf),
>>                  .repeat = 1,
>>          );
>>
>> +       if (is_64k_pagesize)
>> +               topts.data_size_in = sizeof(pkt_v4) - 1;
>> +       else
>> +               topts.data_size_in = sizeof(pkt_v4);
> Please add a comment that magic data size is a special
> signal to bpf prog:

Ok, will add a comment to explain this.

>
>>          if (data_len == 54) { /* sizeof(pkt_v4) */
>> -               offset = 4096; /* test too large offset */
>> +               offset = 4096; /* test too large offset, 4k page size */
>> +       } else if (data_len == 53) { /* sizeof(pkt_v4) - 1 */
>> +               offset = 65536; /* test too large offset, 64k page size */
>>          } else if (data_len == 74) { /* sizeof(pkt_v6) */
>>                  offset = 40;
> and comment about 90000, 90001 sizes.

Ack as well.



