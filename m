Return-Path: <bpf+bounces-7247-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6512773E88
	for <lists+bpf@lfdr.de>; Tue,  8 Aug 2023 18:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 616EB2814F7
	for <lists+bpf@lfdr.de>; Tue,  8 Aug 2023 16:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B4914A8E;
	Tue,  8 Aug 2023 16:32:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D581DA36;
	Tue,  8 Aug 2023 16:32:04 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A19530A49;
	Tue,  8 Aug 2023 09:31:51 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.55])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RKvyB3v3szrSP3;
	Tue,  8 Aug 2023 22:02:10 +0800 (CST)
Received: from [10.174.176.93] (10.174.176.93) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 22:03:20 +0800
Message-ID: <1f172347-4ed1-a571-18e9-9c5d951f213c@huawei.com>
Date: Tue, 8 Aug 2023 22:02:58 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH bpf-next] bpf, sockmap: add BPF_F_PERMANENTLY flag for
 skmsg redirect
To: Jakub Sitnicki <jakub@cloudflare.com>
CC: <john.fastabend@gmail.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<andrii@kernel.org>, <martin.lau@linux.dev>, <song@kernel.org>,
	<yonghong.song@linux.dev>, <kpsingh@kernel.org>, <sdf@google.com>,
	<haoluo@google.com>, <jolsa@kernel.org>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<dsahern@kernel.org>, <netdev@vger.kernel.org>, <bpf@vger.kernel.org>
References: <20230805094254.1082999-1-liujian56@huawei.com>
 <87sf8xwslw.fsf@cloudflare.com>
From: "liujian (CE)" <liujian56@huawei.com>
In-Reply-To: <87sf8xwslw.fsf@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.93]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023/8/5 20:51, Jakub Sitnicki wrote:
> On Sat, Aug 05, 2023 at 05:42 PM +08, Liu Jian wrote:
>> If the sockmap msg redirection function is used only to forward packets
>> and no other operation, the execution result of the BPF_SK_MSG_VERDICT
>> program is the same each time. In this case, the BPF program only needs to
>> be run once. Add BPF_F_PERMANENTLY flag to bpf_msg_redirect_map() and
>> bpf_msg_redirect_hash() to implement this ability.
>>
>> Then we can enable this function in the bpf program as follows:
>> bpf_msg_redirect_hash(xx, xx, xx, BPF_F_INGRESS | BPF_F_PERMANENTLY);
>>
>> Test results using netperf  TCP_STREAM mode:
>> for i in 1 64 128 512 1k 2k 32k 64k 100k 500k 1m;then
>> netperf -T 1,2 -t TCP_STREAM -H 127.0.0.1 -l 20 -- -m $i -s 100m,100m -S 100m,100m
>> done
>>
>> before:
>> 3.84 246.52 496.89 1885.03 3415.29 6375.03 40749.09 48764.40 51611.34 55678.26 55992.78
>> after:
>> 4.43 279.20 555.82 2080.79 3870.70 7105.44 41836.41 49709.75 51861.56 55211.00 54566.85
>>
>> Signed-off-by: Liu Jian <liujian56@huawei.com>
>> ---
> 
> Interesting idea. Potentially opens up the way to redirect without
> fallback to backlog thread in the future. If we know the target, then we
> can propagate backpressure.
> 
> If we go this route, we will need tests. selftests/test_sockmap would
> need to be extended, and we will also need some unit tests in test_progs
> for corner cases. Corner cases to cover that come to mind: redirect to
> self, redirect target socket closed.
Thanks. I will add some tests in v2.
> 
> I'm out next week, so won't be able to give it a proper review.

