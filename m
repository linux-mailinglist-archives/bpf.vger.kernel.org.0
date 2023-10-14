Return-Path: <bpf+bounces-12223-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA747C9484
	for <lists+bpf@lfdr.de>; Sat, 14 Oct 2023 14:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 801981C209F8
	for <lists+bpf@lfdr.de>; Sat, 14 Oct 2023 12:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E47F125B0;
	Sat, 14 Oct 2023 12:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4FD1094B;
	Sat, 14 Oct 2023 12:05:16 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B084A2;
	Sat, 14 Oct 2023 05:05:14 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.54])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4S725g1FYxz1kv1H;
	Sat, 14 Oct 2023 20:01:11 +0800 (CST)
Received: from [10.174.176.93] (10.174.176.93) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Sat, 14 Oct 2023 20:05:11 +0800
Message-ID: <ef4882c0-b570-37a4-de37-c2ad251458d1@huawei.com>
Date: Sat, 14 Oct 2023 20:05:11 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
From: "liujian (CE)" <liujian56@huawei.com>
Subject: Re: [PATCH bpf-next v5 1/7] bpf, sockmap: add BPF_F_PERMANENT flag
 for skmsg redirect
To: John Fastabend <john.fastabend@gmail.com>, <jakub@cloudflare.com>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
	<martin.lau@linux.dev>, <song@kernel.org>, <yonghong.song@linux.dev>,
	<kpsingh@kernel.org>, <sdf@google.com>, <haoluo@google.com>,
	<jolsa@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <dsahern@kernel.org>
CC: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>
References: <20230927093013.1951659-1-liujian56@huawei.com>
 <20230927093013.1951659-2-liujian56@huawei.com>
 <651b982a1b22a_4fa3f20854@john.notmuch>
In-Reply-To: <651b982a1b22a_4fa3f20854@john.notmuch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.93]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023/10/3 12:27, John Fastabend wrote:
> Liu Jian wrote:
>> If the sockmap msg redirection function is used only to forward packets
>> and no other operation, the execution result of the BPF_SK_MSG_VERDICT
>> program is the same each time. In this case, the BPF program only needs to
>> be run once. Add BPF_F_PERMANENT flag to bpf_msg_redirect_map() and
>> bpf_msg_redirect_hash() to implement this ability.
>>
>> Then we can enable this function in the bpf program as follows:
>> bpf_msg_redirect_hash(xx, xx, xx, BPF_F_INGRESS | BPF_F_PERMANENT);
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
> First sorry for the delay I was thinking about this a bit. I decided it likely makes
> a lot of sense if you want to build an l7 load balancer where you just read some
> keys off an initial msg and then pin the rest of the connection to a specific
> backend or proxy socket, etc.
> 
>>   include/linux/skmsg.h          |  1 +
>>   include/uapi/linux/bpf.h       | 45 ++++++++++++++++++++++++++--------
>>   net/core/skmsg.c               |  6 ++++-
>>   net/core/sock_map.c            |  4 +--
>>   net/ipv4/tcp_bpf.c             | 12 +++++----
>>   tools/include/uapi/linux/bpf.h | 45 ++++++++++++++++++++++++++--------
>>   6 files changed, 85 insertions(+), 28 deletions(-)
>>
>> diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
>> index c1637515a8a4..acd7de85608b 100644
>> --- a/include/linux/skmsg.h
>> +++ b/include/linux/skmsg.h
>> @@ -83,6 +83,7 @@ struct sk_psock {
>>   	u32				cork_bytes;
>>   	u32				eval;
>>   	bool				redir_ingress; /* undefined if sk_redir is null */
>> +	bool				redir_permanent;
>>   	struct sk_msg			*cork;
>>   	struct sk_psock_progs		progs;
>>   #if IS_ENABLED(CONFIG_BPF_STREAM_PARSER)
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index 70bfa997e896..cec6c34f4486 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -3029,11 +3029,23 @@ union bpf_attr {
>>    * 		socket level. If the message *msg* is allowed to pass (i.e. if
>>    * 		the verdict eBPF program returns **SK_PASS**), redirect it to
>>    * 		the socket referenced by *map* (of type
>> - * 		**BPF_MAP_TYPE_SOCKMAP**) at index *key*. Both ingress and
>> - * 		egress interfaces can be used for redirection. The
>> - * 		**BPF_F_INGRESS** value in *flags* is used to make the
>> - * 		distinction (ingress path is selected if the flag is present,
>> - * 		egress path otherwise). This is the only flag supported for now.
>> + * 		**BPF_MAP_TYPE_SOCKMAP**) at index *key*.
>> + *
>> + *		The following *flags* are supported:
>> + *
>> + *		**BPF_F_INGRESS**
>> + *		        Both ingress and egress interfaces can be used for redirection.
>> + *		        The **BPF_F_INGRESS** value in *flags* is used to make the
>> + *		        distinction. Ingress path is selected if the flag is present,
>> + *		        egress path otherwise.
>> + *		**BPF_F_PERMANENT**
>> + *		        Indicates that redirect verdict and the target socket should be
>> + *		        remembered. The verdict program will not be run for subsequent
>> + *		        packets, unless an error occurs when forwarding packets.
> 
> Why clear it on error? The error is almost always because either the socket is
> being torn down or there is a memory ENOMEM error that is going to be kicked
> back to user.
Sorry, yes, you're right, I've changed the code, but forgot to change 
the help document. Have sent next version to fix this. Thank you~.
> 
> Is the idea that you can try anopther backend possibly by picking another socket
> out of the table? But, I'm not sure how that might work because you probably
> don't know that this is even the beginning of a msg block.
> 
> I'm wondering if I missed some other reason or if its just simpler to pass the
> error up the stack and keep the same sk_redir.
> 
> Thanks,
> John
> 

