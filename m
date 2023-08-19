Return-Path: <bpf+bounces-8123-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC307818E3
	for <lists+bpf@lfdr.de>; Sat, 19 Aug 2023 12:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C6311C209D0
	for <lists+bpf@lfdr.de>; Sat, 19 Aug 2023 10:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213BC4C75;
	Sat, 19 Aug 2023 10:39:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1934A12;
	Sat, 19 Aug 2023 10:39:58 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B7A6260A2;
	Sat, 19 Aug 2023 02:26:00 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.56])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RSYDx1wSrzFqjQ;
	Sat, 19 Aug 2023 17:22:57 +0800 (CST)
Received: from [10.174.176.93] (10.174.176.93) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Sat, 19 Aug 2023 17:25:57 +0800
Message-ID: <9a37736d-960e-a3bb-4dd8-ac54045ca38f@huawei.com>
Date: Sat, 19 Aug 2023 17:25:56 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
From: "liujian (CE)" <liujian56@huawei.com>
Subject: Re: [PATCH bpf-next v2 1/7] bpf, sockmap: add BPF_F_PERMANENTLY flag
 for skmsg redirect
To: John Fastabend <john.fastabend@gmail.com>, <jakub@cloudflare.com>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
	<martin.lau@linux.dev>, <song@kernel.org>, <yonghong.song@linux.dev>,
	<kpsingh@kernel.org>, <sdf@google.com>, <haoluo@google.com>,
	<jolsa@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <dsahern@kernel.org>
CC: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>
References: <20230811093237.3024459-1-liujian56@huawei.com>
 <20230811093237.3024459-2-liujian56@huawei.com>
 <64ddba9e1df57_32c0720898@john.notmuch>
In-Reply-To: <64ddba9e1df57_32c0720898@john.notmuch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.93]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023/8/17 14:13, John Fastabend wrote:
> Liu Jian wrote:
>> If the sockmap msg redirection function is used only to forward packets
>> and no other operation, the execution result of the BPF_SK_MSG_VERDICT
>> program is the same each time. In this case, the BPF program only needs to
>> be run once. Add BPF_F_PERMANENTLY flag to bpf_msg_redirect_map() and
>> bpf_msg_redirect_hash() to implement this ability.
>>
> 
> I like the use case. Did you consider using
> 
>   long bpf_msg_apply_bytes(struct sk_msg_buff *msg, u32 bytes)
> 
> This could be set to UINT32_MAX and then the BPF prog would only be run
> every 0xfffffff bytes.
> 
I didn't realize that this feature could be used for this, and I thought 
it should have the same effect. Thanks John.
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
> 
> I suspect comparing against
> 
>    bpf_msg_redirect_hash(...)
>    bpf_msg_apply_bytes(msg, UINT32_MAX)
> 
> the diff will be rather small. I agree the API is nicer though to simply
Yes, it should have the same effect and looks good to me.
> set the flag. Its too bad we didn't think to add a forever to apply_bytes.
> I would prefer this API for example,
> 
>    bpf_msg_redirect_hash(...)
>    bpf_msg_apply_bytes(msg, 0, PERMANENT);
> 
What do you mean by this? Should I post another version for this?
> Given we have apply_bytes is it still useful to have a PERMANENT flag
> in your use case? Here we would just reset to UNINT32_MAX if we reached
> max bytes.
> 
If apply_bytes is set to UNINT32_MAX, the number of times that the bpf 
program runs should be small enough to meet my needs.
>>
>> Signed-off-by: Liu Jian <liujian56@huawei.com>
>> ---
>>   include/linux/skmsg.h          |  1 +
>>   include/uapi/linux/bpf.h       |  7 +++++--
>>   net/core/skmsg.c               |  1 +
>>   net/core/sock_map.c            |  4 ++--
>>   net/ipv4/tcp_bpf.c             | 21 +++++++++++++++------
>>   tools/include/uapi/linux/bpf.h |  7 +++++--
>>   6 files changed, 29 insertions(+), 12 deletions(-)
> 
> [...]
> 
>>   
>> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
>> index 70da85200695..cf622ea4f018 100644
>> --- a/tools/include/uapi/linux/bpf.h
>> +++ b/tools/include/uapi/linux/bpf.h
>> @@ -3004,7 +3004,8 @@ union bpf_attr {
>>    * 		egress interfaces can be used for redirection. The
>>    * 		**BPF_F_INGRESS** value in *flags* is used to make the
>>    * 		distinction (ingress path is selected if the flag is present,
>> - * 		egress path otherwise). This is the only flag supported for now.
>> + * 		egress path otherwise). The **BPF_F_PERMANENTLY** value in
>> + *		*flags* is used to indicates whether the eBPF result is permanent.
> 
> We at least need to document what happens if PERMANENTLY and apply_bytes are
> used together.
> 
>>    * 	Return
>>    * 		**SK_PASS** on success, or **SK_DROP** on error.
>>    *
> 

