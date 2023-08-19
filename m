Return-Path: <bpf+bounces-8124-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7DA77818EE
	for <lists+bpf@lfdr.de>; Sat, 19 Aug 2023 12:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1442B1C2099B
	for <lists+bpf@lfdr.de>; Sat, 19 Aug 2023 10:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F149B5C89;
	Sat, 19 Aug 2023 10:40:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18F31113;
	Sat, 19 Aug 2023 10:40:06 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 138E527D3C;
	Sat, 19 Aug 2023 02:32:49 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.53])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RSYNn6FMvzFqZH;
	Sat, 19 Aug 2023 17:29:45 +0800 (CST)
Received: from [10.174.176.93] (10.174.176.93) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Sat, 19 Aug 2023 17:32:45 +0800
Message-ID: <d9c98d8c-0c43-f532-6e0f-b8a19b9a7b8e@huawei.com>
Date: Sat, 19 Aug 2023 17:32:45 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH bpf-next v2 1/7] bpf, sockmap: add BPF_F_PERMANENTLY flag
 for skmsg redirect
To: Ferenc Fejes <fejes@inf.elte.hu>, <john.fastabend@gmail.com>,
	<jakub@cloudflare.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<andrii@kernel.org>, <martin.lau@linux.dev>, <song@kernel.org>,
	<yonghong.song@linux.dev>, <kpsingh@kernel.org>, <sdf@google.com>,
	<haoluo@google.com>, <jolsa@kernel.org>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<dsahern@kernel.org>
CC: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>
References: <20230811093237.3024459-1-liujian56@huawei.com>
 <20230811093237.3024459-2-liujian56@huawei.com>
 <c1ba1a3235464b8306a22c050225332fa3929a10.camel@inf.elte.hu>
From: "liujian (CE)" <liujian56@huawei.com>
In-Reply-To: <c1ba1a3235464b8306a22c050225332fa3929a10.camel@inf.elte.hu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.93]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023/8/17 20:05, Ferenc Fejes wrote:
> Hi Liu!
> 
> On Fri, 2023-08-11 at 17:32 +0800, Liu Jian wrote:
>> If the sockmap msg redirection function is used only to forward
>> packets
>> and no other operation, the execution result of the
>> BPF_SK_MSG_VERDICT
>> program is the same each time. In this case, the BPF program only
>> needs to
>> be run once. Add BPF_F_PERMANENTLY flag to bpf_msg_redirect_map() and
>> bpf_msg_redirect_hash() to implement this ability.
> 
> Did you considered other names for this flag e.g. BPF_F_SPLICED or
> BPF_F_PIPED?
> 
Yes, it's all ok for me.
> BTW good addition, makes sense for the skb case too.
> 
Yes, I had planned to modify bpf_sk_redirect_map/hash() if this patch 
can be incorporated into the mainline. However, John proposed an 
existing solution for this patch, and this patch should not be needed. 
I'll post the changes to bpf_sk_redirect_map/hash() separately later?
Hi, John, do you have any suggestions?
>>
>> Then we can enable this function in the bpf program as follows:
>> bpf_msg_redirect_hash(xx, xx, xx, BPF_F_INGRESS | BPF_F_PERMANENTLY);
>>
>> Test results using netperf  TCP_STREAM mode:
>> for i in 1 64 128 512 1k 2k 32k 64k 100k 500k 1m;then
>> netperf -T 1,2 -t TCP_STREAM -H 127.0.0.1 -l 20 -- -m $i -s 100m,100m
>> -S 100m,100m
>> done
>>
>> before:
>> 3.84 246.52 496.89 1885.03 3415.29 6375.03 40749.09 48764.40 51611.34
>> 55678.26 55992.78
>> after:
>> 4.43 279.20 555.82 2080.79 3870.70 7105.44 41836.41 49709.75 51861.56
>> 55211.00 54566.85
>>
>> Signed-off-by: Liu Jian <liujian56@huawei.com>
>> ---
>>   include/linux/skmsg.h          |  1 +
>>   include/uapi/linux/bpf.h       |  7 +++++--
>>   net/core/skmsg.c               |  1 +
>>   net/core/sock_map.c            |  4 ++--
>>   net/ipv4/tcp_bpf.c             | 21 +++++++++++++++------
>>   tools/include/uapi/linux/bpf.h |  7 +++++--
>>   6 files changed, 29 insertions(+), 12 deletions(-)
>>
>> diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
>> index 054d7911bfc9..b2da9c432f52 100644
>> --- a/include/linux/skmsg.h
>> +++ b/include/linux/skmsg.h
>> @@ -82,6 +82,7 @@ struct sk_psock {
>>   	u32				cork_bytes;
>>   	u32				eval;
>>   	bool				redir_ingress; /* undefined
>> if sk_redir is null */
>> +	bool				eval_permanently;
>>   	struct sk_msg			*cork;
>>   	struct sk_psock_progs		progs;
>>   #if IS_ENABLED(CONFIG_BPF_STREAM_PARSER)
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index 70da85200695..cf622ea4f018 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -3004,7 +3004,8 @@ union bpf_attr {
>>    * 		egress interfaces can be used for redirection. The
>>    * 		**BPF_F_INGRESS** value in *flags* is used to make
>> the
>>    * 		distinction (ingress path is selected if the flag is
>> present,
>> - * 		egress path otherwise). This is the only flag
>> supported for now.
>> + * 		egress path otherwise). The **BPF_F_PERMANENTLY**
>> value in
>> + *		*flags* is used to indicates whether the eBPF result
>> is permanent.
>>    * 	Return
>>    * 		**SK_PASS** on success, or **SK_DROP** on error.
>>    *
>> @@ -3276,7 +3277,8 @@ union bpf_attr {
>>    *		egress interfaces can be used for redirection. The
>>    *		**BPF_F_INGRESS** value in *flags* is used to make
>> the
>>    *		distinction (ingress path is selected if the flag is
>> present,
>> - *		egress path otherwise). This is the only flag
>> supported for now.
>> + *		egress path otherwise). The **BPF_F_PERMANENTLY**
>> value in
>> + *		*flags* is used to indicates whether the eBPF result
>> is permanent.
>>    *	Return
>>    *		**SK_PASS** on success, or **SK_DROP** on error.
>>    *
>> @@ -5872,6 +5874,7 @@ enum {
>>   /* BPF_FUNC_clone_redirect and BPF_FUNC_redirect flags. */
>>   enum {
>>   	BPF_F_INGRESS			= (1ULL << 0),
>> +	BPF_F_PERMANENTLY		= (1ULL << 1),
>>   };
>>   
>>   /* BPF_FUNC_skb_set_tunnel_key and BPF_FUNC_skb_get_tunnel_key
>> flags. */
>> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
>> index a29508e1ff35..b2bf9b5c4252 100644
>> --- a/net/core/skmsg.c
>> +++ b/net/core/skmsg.c
>> @@ -875,6 +875,7 @@ int sk_psock_msg_verdict(struct sock *sk, struct
>> sk_psock *psock,
>>   	ret = bpf_prog_run_pin_on_cpu(prog, msg);
>>   	ret = sk_psock_map_verd(ret, msg->sk_redir);
>>   	psock->apply_bytes = msg->apply_bytes;
>> +	psock->eval_permanently = msg->flags & BPF_F_PERMANENTLY;
>>   	if (ret == __SK_REDIRECT) {
>>   		if (psock->sk_redir) {
>>   			sock_put(psock->sk_redir);
>> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
>> index 08ab108206bf..6a0c90be7f4f 100644
>> --- a/net/core/sock_map.c
>> +++ b/net/core/sock_map.c
>> @@ -662,7 +662,7 @@ BPF_CALL_4(bpf_msg_redirect_map, struct sk_msg *,
>> msg,
>>   {
>>   	struct sock *sk;
>>   
>> -	if (unlikely(flags & ~(BPF_F_INGRESS)))
>> +	if (unlikely(flags & ~(BPF_F_INGRESS | BPF_F_PERMANENTLY)))
>>   		return SK_DROP;
>>   
>>   	sk = __sock_map_lookup_elem(map, key);
>> @@ -1261,7 +1261,7 @@ BPF_CALL_4(bpf_msg_redirect_hash, struct sk_msg
>> *, msg,
>>   {
>>   	struct sock *sk;
>>   
>> -	if (unlikely(flags & ~(BPF_F_INGRESS)))
>> +	if (unlikely(flags & ~(BPF_F_INGRESS | BPF_F_PERMANENTLY)))
>>   		return SK_DROP;
>>   
>>   	sk = __sock_hash_lookup_elem(map, key);
>> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
>> index 81f0dff69e0b..36cf2b0fa6f8 100644
>> --- a/net/ipv4/tcp_bpf.c
>> +++ b/net/ipv4/tcp_bpf.c
>> @@ -419,8 +419,10 @@ static int tcp_bpf_send_verdict(struct sock *sk,
>> struct sk_psock *psock,
>>   		if (!psock->apply_bytes) {
>>   			/* Clean up before releasing the sock lock.
>> */
>>   			eval = psock->eval;
>> -			psock->eval = __SK_NONE;
>> -			psock->sk_redir = NULL;
>> +			if (!psock->eval_permanently) {
>> +				psock->eval = __SK_NONE;
>> +				psock->sk_redir = NULL;
>> +			}
>>   		}
>>   		if (psock->cork) {
>>   			cork = true;
>> @@ -433,9 +435,15 @@ static int tcp_bpf_send_verdict(struct sock *sk,
>> struct sk_psock *psock,
>>   		ret = tcp_bpf_sendmsg_redir(sk_redir, redir_ingress,
>>   					    msg, tosend, flags);
>>   		sent = origsize - msg->sg.size;
>> +		/* disable the ability when something wrong */
>> +		if (unlikely(ret < 0))
>> +			psock->eval_permanently = 0;
>>   
>> -		if (eval == __SK_REDIRECT)
>> +		if (!psock->eval_permanently && eval ==
>> __SK_REDIRECT) {
>>   			sock_put(sk_redir);
>> +			psock->sk_redir = NULL;
>> +			psock->eval = __SK_NONE;
>> +		}
>>   
>>   		lock_sock(sk);
>>   		if (unlikely(ret < 0)) {
>> @@ -460,8 +468,8 @@ static int tcp_bpf_send_verdict(struct sock *sk,
>> struct sk_psock *psock,
>>   	}
>>   
>>   	if (likely(!ret)) {
>> -		if (!psock->apply_bytes) {
>> -			psock->eval =  __SK_NONE;
>> +		if (!psock->apply_bytes && !psock->eval_permanently)
>> {
>> +			psock->eval = __SK_NONE;
>>   			if (psock->sk_redir) {
>>   				sock_put(psock->sk_redir);
>>   				psock->sk_redir = NULL;
>> @@ -540,7 +548,8 @@ static int tcp_bpf_sendmsg(struct sock *sk,
>> struct msghdr *msg, size_t size)
>>   			if (psock->cork_bytes && !enospc)
>>   				goto out_err;
>>   			/* All cork bytes are accounted, rerun the
>> prog. */
>> -			psock->eval = __SK_NONE;
>> +			if (!psock->eval_permanently)
>> +				psock->eval = __SK_NONE;
>>   			psock->cork_bytes = 0;
>>   		}
>>   
>> diff --git a/tools/include/uapi/linux/bpf.h
>> b/tools/include/uapi/linux/bpf.h
>> index 70da85200695..cf622ea4f018 100644
>> --- a/tools/include/uapi/linux/bpf.h
>> +++ b/tools/include/uapi/linux/bpf.h
>> @@ -3004,7 +3004,8 @@ union bpf_attr {
>>    * 		egress interfaces can be used for redirection. The
>>    * 		**BPF_F_INGRESS** value in *flags* is used to make
>> the
>>    * 		distinction (ingress path is selected if the flag is
>> present,
>> - * 		egress path otherwise). This is the only flag
>> supported for now.
>> + * 		egress path otherwise). The **BPF_F_PERMANENTLY**
>> value in
>> + *		*flags* is used to indicates whether the eBPF result
>> is permanent.
>>    * 	Return
>>    * 		**SK_PASS** on success, or **SK_DROP** on error.
>>    *
>> @@ -3276,7 +3277,8 @@ union bpf_attr {
>>    *		egress interfaces can be used for redirection. The
>>    *		**BPF_F_INGRESS** value in *flags* is used to make
>> the
>>    *		distinction (ingress path is selected if the flag is
>> present,
>> - *		egress path otherwise). This is the only flag
>> supported for now.
>> + *		egress path otherwise). The **BPF_F_PERMANENTLY**
>> value in
>> + *		*flags* is used to indicates whether the eBPF result
>> is permanent.
>>    *	Return
>>    *		**SK_PASS** on success, or **SK_DROP** on error.
>>    *
>> @@ -5872,6 +5874,7 @@ enum {
>>   /* BPF_FUNC_clone_redirect and BPF_FUNC_redirect flags. */
>>   enum {
>>   	BPF_F_INGRESS			= (1ULL << 0),
>> +	BPF_F_PERMANENTLY		= (1ULL << 1),
>>   };
>>   
>>   /* BPF_FUNC_skb_set_tunnel_key and BPF_FUNC_skb_get_tunnel_key
>> flags. */
> 
> Ferenc
> 

