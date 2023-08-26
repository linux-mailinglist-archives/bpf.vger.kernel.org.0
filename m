Return-Path: <bpf+bounces-8744-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40644789658
	for <lists+bpf@lfdr.de>; Sat, 26 Aug 2023 13:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7B2928197F
	for <lists+bpf@lfdr.de>; Sat, 26 Aug 2023 11:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17AB5D538;
	Sat, 26 Aug 2023 11:53:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A802F30;
	Sat, 26 Aug 2023 11:53:35 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3649E1BDA;
	Sat, 26 Aug 2023 04:53:33 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.55])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RXwCd50b1z1L9JZ;
	Sat, 26 Aug 2023 19:51:57 +0800 (CST)
Received: from [10.174.176.93] (10.174.176.93) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Sat, 26 Aug 2023 19:53:30 +0800
Message-ID: <5fb05d9c-b7bf-365f-c4cf-8b754da0223c@huawei.com>
Date: Sat, 26 Aug 2023 19:53:29 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH bpf-next v3 1/7] bpf, sockmap: add BPF_F_PERMANENT flag
 for skmsg redirect
To: Jakub Sitnicki <jakub@cloudflare.com>
CC: <john.fastabend@gmail.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<andrii@kernel.org>, <martin.lau@linux.dev>, <song@kernel.org>,
	<yonghong.song@linux.dev>, <kpsingh@kernel.org>, <sdf@google.com>,
	<haoluo@google.com>, <jolsa@kernel.org>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<dsahern@kernel.org>, <netdev@vger.kernel.org>, <bpf@vger.kernel.org>
References: <20230824143959.1134019-1-liujian56@huawei.com>
 <20230824143959.1134019-2-liujian56@huawei.com>
 <87r0nr5j0a.fsf@cloudflare.com>
From: "liujian (CE)" <liujian56@huawei.com>
In-Reply-To: <87r0nr5j0a.fsf@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.93]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023/8/25 21:04, Jakub Sitnicki wrote:
> On Thu, Aug 24, 2023 at 10:39 PM +08, Liu Jian wrote:
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
>>   include/linux/skmsg.h          |  1 +
>>   include/uapi/linux/bpf.h       | 15 +++++++++++++--
>>   net/core/skmsg.c               |  5 +++++
>>   net/core/sock_map.c            |  4 ++--
>>   net/ipv4/tcp_bpf.c             | 18 +++++++++++++-----
>>   tools/include/uapi/linux/bpf.h | 15 +++++++++++++--
>>   6 files changed, 47 insertions(+), 11 deletions(-)
>>
>> diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
>> index 054d7911bfc9..2f4e9811ff85 100644
>> --- a/include/linux/skmsg.h
>> +++ b/include/linux/skmsg.h
>> @@ -82,6 +82,7 @@ struct sk_psock {
>>   	u32				cork_bytes;
>>   	u32				eval;
>>   	bool				redir_ingress; /* undefined if sk_redir is null */
>> +	bool				redir_permanent;
>>   	struct sk_msg			*cork;
>>   	struct sk_psock_progs		progs;
>>   #if IS_ENABLED(CONFIG_BPF_STREAM_PARSER)
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index 70da85200695..f4de1ba390b4 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -3004,7 +3004,12 @@ union bpf_attr {
>>    * 		egress interfaces can be used for redirection. The
>>    * 		**BPF_F_INGRESS** value in *flags* is used to make the
>>    * 		distinction (ingress path is selected if the flag is present,
>> - * 		egress path otherwise). This is the only flag supported for now.
>> + * 		egress path otherwise). The **BPF_F_PERMANENT** value in
>> + *		*flags* is used to indicates whether the eBPF result is
>> + *		permanently (please note that, BPF_F_PERMANENT does not work with
>> + *		msg_apply_bytes() and msg_cork_bytes(), if msg_apply_bytes() or
>> + *		msg_cork_bytes() is configured, the BPF_F_PERMANENT function is
>> + *		automatically disabled).
> 
> There are some grammar mistakes here we need to fix. Hint - I find it
> helpful to run the text through an online grammar checker or an AI
> chatbot when unsure.
> 
> Either way, let's reword so the flags are clearly listed out, since we
> now have two of them:
> 
> The following *flags* are supported:
> 
> **BPF_F_INGRESS**
>          Both ingress and egress interfaces can be used for redirection.
>          The **BPF_F_INGRESS** value in *flags* is used to make the
>          distinction. Ingress path is selected if the flag is present,
>          egress path otherwise.
> **BPF_F_PERMANENT**
>          Indicates that redirect verdict and the target socket should be
>          remembered. The verdict program will not be run for subsequent
>          packets, unless an error occurs when forwarding packets.
> 
>          **BPF_F_PERMANENT** cannot be use together with
>          **bpf_msg_apply_bytes**\ () and **bpf_msg_cork_bytes**\ (). If
>          either has been called, the **BPF_F_PERMANENT** flag is ignored.
> 
> 
Thanks a lot.
> Please check the formatting is correct with:
> 
> ./scripts/bpf_doc.py --filename include/uapi/linux/bpf.h \
>    | rst2man /dev/stdin | man /dev/stdin
> 
> That said, I'm not sure I like these semantics - flag being ignored
> under some circumstances. It leads to a silent failure.
> 
> If I've asked for a permanent redirect, but it is cannot work in my BPF
> program, I'd rather get an error from bpf_msg_redirect_map/hash(), than
> be surprised that it is getting executed for every packet and have to
> troubleshoot why.
> 
>>    * 	Return
>>    * 		**SK_PASS** on success, or **SK_DROP** on error.
>>    *
>> @@ -3276,7 +3281,12 @@ union bpf_attr {
>>    *		egress interfaces can be used for redirection. The
>>    *		**BPF_F_INGRESS** value in *flags* is used to make the
>>    *		distinction (ingress path is selected if the flag is present,
>> - *		egress path otherwise). This is the only flag supported for now.
>> + *		egress path otherwise). The **BPF_F_PERMANENT** value in
>> + *		*flags* is used to indicates whether the eBPF result is
>> + *		permanently (please note that, BPF_F_PERMANENT does not work with
>> + *		msg_apply_bytes() and msg_cork_bytes(), if msg_apply_bytes() or
>> + *		msg_cork_bytes() is configured, the BPF_F_PERMANENT function is
>> + *		automatically disabled).
>>    *	Return
>>    *		**SK_PASS** on success, or **SK_DROP** on error.
>>    *
>> @@ -5872,6 +5882,7 @@ enum {
>>   /* BPF_FUNC_clone_redirect and BPF_FUNC_redirect flags. */
>>   enum {
>>   	BPF_F_INGRESS			= (1ULL << 0),
>> +	BPF_F_PERMANENT			= (1ULL << 1),
>>   };
>>   
>>   /* BPF_FUNC_skb_set_tunnel_key and BPF_FUNC_skb_get_tunnel_key flags. */
>> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
>> index a29508e1ff35..df1443cf5fbd 100644
>> --- a/net/core/skmsg.c
>> +++ b/net/core/skmsg.c
>> @@ -885,6 +885,11 @@ int sk_psock_msg_verdict(struct sock *sk, struct sk_psock *psock,
>>   			goto out;
>>   		}
>>   		psock->redir_ingress = sk_msg_to_ingress(msg);
>> +		if (!msg->apply_bytes && !msg->cork_bytes)
>> +			psock->redir_permanent =
>> +				msg->flags & BPF_F_PERMANENT;
>> +		else
>> +			psock->redir_permanent = false;
> 
> Above can be rewritten as:
> 
> 		psock->redir_permanent = !msg->apply_bytes &&
> 					 !msg->cork_bytes &&
> 					 (msg->flags & BPF_F_PERMANENT);
> 
Will change it in v4. Thanks.

> But as I wrote earlier, I don't think it's a good idea to ignore the
> flag. We can detect this conflict at the time the bpf_msg_sk_redirect_*
> helper is called and return an error.
>
> Naturally that means that that bpf_msg_{cork,apply}_bytes helpers need
> to be adjusted to return an error if BPF_F_PERMANENT has been set.
OK. If so, is the configuration that is set first and has a higher priority?

> 
>>   		psock->sk_redir = msg->sk_redir;
>>   		sock_hold(psock->sk_redir);
>>   	}
>> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
>> index 08ab108206bf..35a361614f5e 100644
>> --- a/net/core/sock_map.c
>> +++ b/net/core/sock_map.c
>> @@ -662,7 +662,7 @@ BPF_CALL_4(bpf_msg_redirect_map, struct sk_msg *, msg,
>>   {
>>   	struct sock *sk;
>>   
>> -	if (unlikely(flags & ~(BPF_F_INGRESS)))
>> +	if (unlikely(flags & ~(BPF_F_INGRESS | BPF_F_PERMANENT)))
>>   		return SK_DROP;
>>   
>>   	sk = __sock_map_lookup_elem(map, key);
>> @@ -1261,7 +1261,7 @@ BPF_CALL_4(bpf_msg_redirect_hash, struct sk_msg *, msg,
>>   {
>>   	struct sock *sk;
>>   
>> -	if (unlikely(flags & ~(BPF_F_INGRESS)))
>> +	if (unlikely(flags & ~(BPF_F_INGRESS | BPF_F_PERMANENT)))
>>   		return SK_DROP;
>>   
>>   	sk = __sock_hash_lookup_elem(map, key);
>> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
>> index 81f0dff69e0b..b53e356562a6 100644
>> --- a/net/ipv4/tcp_bpf.c
>> +++ b/net/ipv4/tcp_bpf.c
>> @@ -419,8 +419,10 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
>>   		if (!psock->apply_bytes) {
>>   			/* Clean up before releasing the sock lock. */
>>   			eval = psock->eval;
>> -			psock->eval = __SK_NONE;
>> -			psock->sk_redir = NULL;
>> +			if (!psock->redir_permanent) {
>> +				psock->eval = __SK_NONE;
>> +				psock->sk_redir = NULL;
>> +			}
>>   		}
>>   		if (psock->cork) {
>>   			cork = true;
>> @@ -433,9 +435,15 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
>>   		ret = tcp_bpf_sendmsg_redir(sk_redir, redir_ingress,
>>   					    msg, tosend, flags);
>>   		sent = origsize - msg->sg.size;
>> +		/* disable the ability when something wrong */
>> +		if (unlikely(ret < 0))
>> +			psock->redir_permanent = 0;
>>   
>> -		if (eval == __SK_REDIRECT)
>> +		if (!psock->redir_permanent && eval == __SK_REDIRECT) {
> 
> I believe eval == __SK_REDIRECT is always true here, and the eval local
> variable is redundant. We will be in this switch branch only if
> psock->eval == __SK_REDIRECT. It's something we missed during the review
> of cd9733f5d75c ("tcp_bpf: Fix one concurrency problem in the
> tcp_bpf_send_verdict function").
> 
When apply_bytes is set, eval == __SK_REDIRECT is not true.
>>   			sock_put(sk_redir);
>> +			psock->sk_redir = NULL;
>> +			psock->eval = __SK_NONE;
>> +		}
>>   
>>   		lock_sock(sk);
>>   		if (unlikely(ret < 0)) {
>> @@ -460,8 +468,8 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
>>   	}
>>   
>>   	if (likely(!ret)) {
>> -		if (!psock->apply_bytes) {
>> -			psock->eval =  __SK_NONE;
>> +		if (!psock->apply_bytes && !psock->redir_permanent) {
>> +			psock->eval = __SK_NONE;
>>   			if (psock->sk_redir) {
>>   				sock_put(psock->sk_redir);
>>   				psock->sk_redir = NULL;
>> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
>> index 70da85200695..f4de1ba390b4 100644
>> --- a/tools/include/uapi/linux/bpf.h
>> +++ b/tools/include/uapi/linux/bpf.h
>> @@ -3004,7 +3004,12 @@ union bpf_attr {
>>    * 		egress interfaces can be used for redirection. The
>>    * 		**BPF_F_INGRESS** value in *flags* is used to make the
>>    * 		distinction (ingress path is selected if the flag is present,
>> - * 		egress path otherwise). This is the only flag supported for now.
>> + * 		egress path otherwise). The **BPF_F_PERMANENT** value in
>> + *		*flags* is used to indicates whether the eBPF result is
>> + *		permanently (please note that, BPF_F_PERMANENT does not work with
>> + *		msg_apply_bytes() and msg_cork_bytes(), if msg_apply_bytes() or
>> + *		msg_cork_bytes() is configured, the BPF_F_PERMANENT function is
>> + *		automatically disabled).
>>    * 	Return
>>    * 		**SK_PASS** on success, or **SK_DROP** on error.
>>    *
>> @@ -3276,7 +3281,12 @@ union bpf_attr {
>>    *		egress interfaces can be used for redirection. The
>>    *		**BPF_F_INGRESS** value in *flags* is used to make the
>>    *		distinction (ingress path is selected if the flag is present,
>> - *		egress path otherwise). This is the only flag supported for now.
>> + *		egress path otherwise). The **BPF_F_PERMANENT** value in
>> + *		*flags* is used to indicates whether the eBPF result is
>> + *		permanently (please note that, BPF_F_PERMANENT does not work with
>> + *		msg_apply_bytes() and msg_cork_bytes(), if msg_apply_bytes() or
>> + *		msg_cork_bytes() is configured, the BPF_F_PERMANENT function is
>> + *		automatically disabled).
>>    *	Return
>>    *		**SK_PASS** on success, or **SK_DROP** on error.
>>    *
>> @@ -5872,6 +5882,7 @@ enum {
>>   /* BPF_FUNC_clone_redirect and BPF_FUNC_redirect flags. */
>>   enum {
>>   	BPF_F_INGRESS			= (1ULL << 0),
>> +	BPF_F_PERMANENT			= (1ULL << 1),
>>   };
>>   
>>   /* BPF_FUNC_skb_set_tunnel_key and BPF_FUNC_skb_get_tunnel_key flags. */
> 

