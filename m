Return-Path: <bpf+bounces-8078-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1D4780F22
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 17:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9298A28245A
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 15:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B7C19897;
	Fri, 18 Aug 2023 15:26:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6010E18C21
	for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 15:26:24 +0000 (UTC)
Received: from out-5.mta1.migadu.com (out-5.mta1.migadu.com [IPv6:2001:41d0:203:375::5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3189D3C3D
	for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 08:26:22 -0700 (PDT)
Message-ID: <a1a18bec-e694-9a51-9d88-753baf0e6d2b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1692372380; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rpOkpEVZn5CL5W7EAycreIplkq31utU1vc2qT8RLF0I=;
	b=eBSx5X1E+DVJxnvdttP+6LGiobNZ2bXieBHa4SYqjjpROll57ltjQHcGaqQuIsY2HRil/w
	H4f++ByqLdjgVDSFB1I2rb2uicMilticELsV3OLADKQ70uGWAuPiZHzEWRH4CGdc4JfiOB
	7MMqkNOEj6wpi9+abF+K/C+jZFB5YIg=
Date: Fri, 18 Aug 2023 08:26:06 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next v14 1/4] bpf: Add update_socket_protocol hook
Content-Language: en-US
To: Geliang Tang <geliang.tang@suse.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Florent Revest <revest@chromium.org>, Brendan Jackman
 <jackmanb@chromium.org>, Matthieu Baerts <matthieu.baerts@tessares.net>,
 Mat Martineau <martineau@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 John Johansen <john.johansen@canonical.com>, Paul Moore
 <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>,
 Eric Paris <eparis@parisplace.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <cover.1692147782.git.geliang.tang@suse.com>
 <ac84be00f97072a46f8a72b4e2be46cbb7fa5053.1692147782.git.geliang.tang@suse.com>
 <20230818082417.GA20274@bogon>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20230818082417.GA20274@bogon>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/18/23 1:24 AM, Geliang Tang wrote:
> On Wed, Aug 16, 2023 at 09:11:56AM +0800, Geliang Tang wrote:
>> Add a hook named update_socket_protocol in __sys_socket(), for bpf
>> progs to attach to and update socket protocol. One user case is to
>> force legacy TCP apps to create and use MPTCP sockets instead of
>> TCP ones.
>>
>> Define a fmod_ret set named bpf_mptcp_fmodret_ids, add the hook
>> update_socket_protocol into this set, and register it in
>> bpf_mptcp_kfunc_init().
>>
>> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/79
>> Acked-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>> Acked-by: Yonghong Song <yonghong.song@linux.dev>
>> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
>> ---
>>   net/mptcp/bpf.c | 15 +++++++++++++++
>>   net/socket.c    | 26 +++++++++++++++++++++++++-
>>   2 files changed, 40 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
>> index 5a0a84ad94af..8a16672b94e2 100644
>> --- a/net/mptcp/bpf.c
>> +++ b/net/mptcp/bpf.c
>> @@ -19,3 +19,18 @@ struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *sk)
>>   
>>   	return NULL;
>>   }
>> +
>> +BTF_SET8_START(bpf_mptcp_fmodret_ids)
>> +BTF_ID_FLAGS(func, update_socket_protocol)
>> +BTF_SET8_END(bpf_mptcp_fmodret_ids)
>> +
>> +static const struct btf_kfunc_id_set bpf_mptcp_fmodret_set = {
>> +	.owner = THIS_MODULE,
>> +	.set   = &bpf_mptcp_fmodret_ids,
>> +};
>> +
>> +static int __init bpf_mptcp_kfunc_init(void)
>> +{
>> +	return register_btf_fmodret_id_set(&bpf_mptcp_fmodret_set);
>> +}
>> +late_initcall(bpf_mptcp_kfunc_init);
>> diff --git a/net/socket.c b/net/socket.c
>> index 5d4e37595e9a..fdb5233bf560 100644
>> --- a/net/socket.c
>> +++ b/net/socket.c
>> @@ -1657,12 +1657,36 @@ struct file *__sys_socket_file(int family, int type, int protocol)
>>   	return sock_alloc_file(sock, flags, NULL);
>>   }
>>   
>> +/*	A hook for bpf progs to attach to and update socket protocol.
>> + *
>> + *	A static noinline declaration here could cause the compiler to
>> + *	optimize away the function. A global noinline declaration will
>> + *	keep the definition, but may optimize away the callsite.
>> + *	Therefore, __weak is needed to ensure that the call is still
>> + *	emitted, by telling the compiler that we don't know what the
>> + *	function might eventually be.
>> + *
>> + *	__diag_* below are needed to dismiss the missing prototype warning.
>> + */
>> +
>> +__diag_push();
>> +__diag_ignore_all("-Wmissing-prototypes",
>> +		  "A fmod_ret entry point for BPF programs");
> 
> Hi Martin & Yonghong,
> 
> I got a sparse warning for this new added 'update_socket_protocol':
> 
>   > touch net/socket.c && make C=1 net/socket.o
> 
>   net/socket.c:1676:21: warning: symbol 'update_socket_protocol' was not declared. Should it be static?

This is a sparse warning. Let us ignore it for now. We already have
__diag_ignore for missing prototypes in the above, but sparse won't 
recognize them. Also, 'static' is conflict with '__weak' attribute,
and we cannot remove '__weak' attribute.

> 
> What should I do to fix it, or should I just leave it here? Please give
> me some suggestions.
> 
> Thanks,
> -Geliang
> 
>> +
>> +__weak noinline int update_socket_protocol(int family, int type, int protocol)
>> +{
>> +	return protocol;
>> +}
>> +
>> +__diag_pop();
>> +
>>   int __sys_socket(int family, int type, int protocol)
>>   {
>>   	struct socket *sock;
>>   	int flags;
>>   
>> -	sock = __sys_socket_create(family, type, protocol);
>> +	sock = __sys_socket_create(family, type,
>> +				   update_socket_protocol(family, type, protocol));
>>   	if (IS_ERR(sock))
>>   		return PTR_ERR(sock);
>>   
>> -- 
>> 2.35.3
>>
> 

