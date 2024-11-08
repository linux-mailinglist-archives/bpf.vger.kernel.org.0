Return-Path: <bpf+bounces-44308-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 044FE9C12DC
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 01:02:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 275281C22740
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 00:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8823C28F7;
	Fri,  8 Nov 2024 00:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="c4zLCZ4F"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C5418D
	for <bpf@vger.kernel.org>; Fri,  8 Nov 2024 00:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731024150; cv=none; b=CR12Rep5jjOpR7gv1G2huJVNC17CrsAHdLASkptlDL8zvaF77Cpa4Jd1wQ6gp38qf2jG5SiwmvGk3GPfpZeUm2CuOf0veMLpFuGMric56ffi2dU0rO1KuXSpfVXlX1M/dRSmJdRWhO5Ao8Q/FxZS2RPWfJ+63FenM7vE7PvVRS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731024150; c=relaxed/simple;
	bh=2MG9//RGDvIRpUHiW6s38hbiGw2pARbllLQUrUn/NSk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=srT9iYiaP8cZzcLXRl2dobmnzEi9aLSNq9OCoNbX11+cbvlFs46kIzGbD9XXDi2xzZX47Oa/m4qrO2VX8LCQs8oCngPCNfb4BD4aWmwQ0mFfX6GAIjceCo+gFfgnSR+eQmVE0Ar4VsELsfdroLdzlnfkrIIGAMd5tMeI9WyOdAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=c4zLCZ4F; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-460ace055d8so9826551cf.1
        for <bpf@vger.kernel.org>; Thu, 07 Nov 2024 16:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1731024146; x=1731628946; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9JHLVzplk+fSvzu6Q2t8SmBivUJYy0aGjGNOZjNnsGM=;
        b=c4zLCZ4FwW0uNan18rsJ30kpP5mkZtC88zvXy/gXmzNzuStwHag8yuJ/tc7CFmWBZc
         +xlPUjKsr4//N9y4fv3Misk121FLmp1T5VAZmWPsTMdEEdEkJlfhuGZ3Gha8DjFFKXSl
         WZ19tQWkerFc853LXsL10gBK52j20bCQEVQsrskbC8qwdFYVKCO6Ke1ZC2sVN2ZVQUOR
         jbgYfpUTceDtT9eVWY+gGtjuH6XCqDhBfZSa7u/njyT6/mmKIf1ywA2FSOJsb4PtxQxL
         97P80DS7PcTfUo6boTWouOEgguV4PLbGik66JyWqY4eNCo4sWS6Et3tATb5wD8sMYB1x
         6MLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731024146; x=1731628946;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9JHLVzplk+fSvzu6Q2t8SmBivUJYy0aGjGNOZjNnsGM=;
        b=Y0bJy6KKuyx4vVVQH8C1nl3UUUXNKVLFsAMar6a4RBptaxiH5MxGITlKZRifyDpLsb
         lz5guN0XxKj2CaX0+55PUN2CK4TSi5/1kuXvpKIm7B1jBaWuhX4Ty8LOqdyBavXlbNJf
         p6FgZ8lQAxu/fOv7gA1l5f9WQSohC0Ffg21E+LHdz9/DpPxLEDqJrX4J5AwjXpYmRBKf
         P+Q4ag37y1s7YapdBnbl5+C9VCe36l1+uxlTaNOHrlPo/fLZ4KxB/7vEGW1unO/wd/vc
         T4mDzqXPcEvV5qExivy8sRG/sTbs62ocF20gLVQY6QE5BujSEnCSSSXsXKdm2DaMspvR
         P1tg==
X-Gm-Message-State: AOJu0YxgtxZaQSyIzGG+HjJb23UKl/mt86anGOsiMhcyhuu5icRo5DHH
	JDQwQQE5PurrZX88hVKAEmtJrjf860nrBuXLUSaAB559Q0aXymAIxTEWY/ISCqvjN/iwFyAiR7U
	k
X-Google-Smtp-Source: AGHT+IE16mkFJKOM+UYMHKJ+xXAGCdoxHpEChKkBovuwExlvIWljbPf2YHP6Lfspclv8pfBc1LD7ew==
X-Received: by 2002:ac8:594e:0:b0:461:1c54:5bcd with SMTP id d75a77b69052e-46309339b1emr11277051cf.13.1731024145805;
        Thu, 07 Nov 2024 16:02:25 -0800 (PST)
Received: from [10.73.215.90] ([72.29.204.230])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-462ff4671f6sm13410171cf.39.2024.11.07.16.02.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2024 16:02:24 -0800 (PST)
Message-ID: <67a0fb14-f791-4499-8751-01bbbd1cafcb@bytedance.com>
Date: Thu, 7 Nov 2024 16:02:19 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] [Patch bpf 2/2] selftests/bpf: Add a BPF selftest for
 bpf_skb_change_tail()
To: Cong Wang <xiyou.wangcong@gmail.com>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, Cong Wang <cong.wang@bytedance.com>,
 John Fastabend <john.fastabend@gmail.com>,
 Daniel Borkmann <daniel@iogearbox.net>
References: <20241107034141.250815-1-xiyou.wangcong@gmail.com>
 <20241107034141.250815-2-xiyou.wangcong@gmail.com>
Content-Language: en-US
From: Zijian Zhang <zijianzhang@bytedance.com>
In-Reply-To: <20241107034141.250815-2-xiyou.wangcong@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/6/24 7:41 PM, Cong Wang wrote:
> From: Cong Wang <cong.wang@bytedance.com>
> 
> As requested by Daniel, we need to add a selftest to cover
> bpf_skb_change_tail() cases in skb_verdict. Here we test trimming,
> growing and error cases, and validate its expected return values.
> 
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Zijian Zhang <zijianzhang@bytedance.com>
> Signed-off-by: Cong Wang <cong.wang@bytedance.com>
> ---
>   .../selftests/bpf/prog_tests/sockmap_basic.c  | 51 +++++++++++++++++++
>   .../bpf/progs/test_sockmap_change_tail.c      | 40 +++++++++++++++
>   2 files changed, 91 insertions(+)
>   create mode 100644 tools/testing/selftests/bpf/progs/test_sockmap_change_tail.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> index 82bfb266741c..fe735fced836 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> @@ -12,6 +12,7 @@
>   #include "test_sockmap_progs_query.skel.h"
>   #include "test_sockmap_pass_prog.skel.h"
>   #include "test_sockmap_drop_prog.skel.h"
> +#include "test_sockmap_change_tail.skel.h"
>   #include "bpf_iter_sockmap.skel.h"
>   
>   #include "sockmap_helpers.h"
> @@ -562,6 +563,54 @@ static void test_sockmap_skb_verdict_fionread(bool pass_prog)
>   		test_sockmap_drop_prog__destroy(drop);
>   }
>   
> +static void test_sockmap_skb_verdict_change_tail(void)
> +{
> +	struct test_sockmap_change_tail *skel;
> +	int err, map, verdict;
> +	int c1, p1, sent, recvd;
> +	int zero = 0;
> +	char b[3];
> +
> +	skel = test_sockmap_change_tail__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "open_and_load"))
> +		return;
> +	verdict = bpf_program__fd(skel->progs.prog_skb_verdict);
> +	map = bpf_map__fd(skel->maps.sock_map_rx);
> +
> +	err = bpf_prog_attach(verdict, map, BPF_SK_SKB_STREAM_VERDICT, 0);
> +	if (!ASSERT_OK(err, "bpf_prog_attach"))
> +		goto out;
> +	err = create_pair(AF_INET, SOCK_STREAM, &c1, &p1);
> +	if (!ASSERT_OK(err, "create_pair()"))
> +		goto out;
> +	err = bpf_map_update_elem(map, &zero, &c1, BPF_NOEXIST);
> +	if (!ASSERT_OK(err, "bpf_map_update_elem(c1)"))
> +		goto out_close;
> +	sent = xsend(p1, "Tr", 2, 0);
> +	ASSERT_EQ(sent, 2, "xsend(p1)");
> +	recvd = recv(c1, b, 2, 0);
> +	ASSERT_EQ(recvd, 1, "recv(c1)");
> +	ASSERT_EQ(skel->data->change_tail_ret, 0, "change_tail_ret");
> +
> +	sent = xsend(p1, "G", 1, 0);
> +	ASSERT_EQ(sent, 1, "xsend(p1)");
> +	recvd = recv(c1, b, 2, 0);
> +	ASSERT_EQ(recvd, 2, "recv(c1)");
> +	ASSERT_EQ(skel->data->change_tail_ret, 0, "change_tail_ret");
> +
> +	sent = xsend(p1, "E", 1, 0);
> +	ASSERT_EQ(sent, 1, "xsend(p1)");
> +	recvd = recv(c1, b, 1, 0);
> +	ASSERT_EQ(recvd, 1, "recv(c1)");
> +	ASSERT_EQ(skel->data->change_tail_ret, -EINVAL, "change_tail_ret");
> +
> +out_close:
> +	close(c1);
> +	close(p1);
> +out:
> +	test_sockmap_change_tail__destroy(skel);
> +}
> +
>   static void test_sockmap_skb_verdict_peek_helper(int map)
>   {
>   	int err, c1, p1, zero = 0, sent, recvd, avail;
> @@ -927,6 +976,8 @@ void test_sockmap_basic(void)
>   		test_sockmap_skb_verdict_fionread(true);
>   	if (test__start_subtest("sockmap skb_verdict fionread on drop"))
>   		test_sockmap_skb_verdict_fionread(false);
> +	if (test__start_subtest("sockmap skb_verdict change tail"))
> +		test_sockmap_skb_verdict_change_tail();
>   	if (test__start_subtest("sockmap skb_verdict msg_f_peek"))
>   		test_sockmap_skb_verdict_peek();
>   	if (test__start_subtest("sockmap skb_verdict msg_f_peek with link"))
> diff --git a/tools/testing/selftests/bpf/progs/test_sockmap_change_tail.c b/tools/testing/selftests/bpf/progs/test_sockmap_change_tail.c
> new file mode 100644
> index 000000000000..2796dd8545eb
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_sockmap_change_tail.c
> @@ -0,0 +1,40 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2024 ByteDance */
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_SOCKMAP);
> +	__uint(max_entries, 1);
> +	__type(key, int);
> +	__type(value, int);
> +} sock_map_rx SEC(".maps");
> +
> +long change_tail_ret = 1;
> +
> +SEC("sk_skb")
> +int prog_skb_verdict(struct __sk_buff *skb)
> +{
> +	char *data, *data_end;
> +
> +	bpf_skb_pull_data(skb, 1);
> +	data = (char *)(unsigned long)skb->data;
> +	data_end = (char *)(unsigned long)skb->data_end;
> +
> +	if (data + 1 > data_end)
> +		return SK_PASS;
> +
> +	if (data[0] == 'T') { /* Trim the packet */
> +		change_tail_ret = bpf_skb_change_tail(skb, skb->len - 1, 0);
> +		return SK_PASS;
> +	} else if (data[0] == 'G') { /* Grow the packet */
> +		change_tail_ret = bpf_skb_change_tail(skb, skb->len + 1, 0);
> +		return SK_PASS;
> +	} else if (data[0] == 'E') { /* Error */
> +		change_tail_ret = bpf_skb_change_tail(skb, 65535, 0);
> +		return SK_PASS;
> +	}
> +	return SK_PASS;
> +}
> +
> +char _license[] SEC("license") = "GPL";

LGTM!

I think it will be better if the test could also cover the case you
indicated in the first patch, where skb_transport_offset is a negative
value.

Thanks,
Zijian


