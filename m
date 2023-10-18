Return-Path: <bpf+bounces-12492-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE427CD17B
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 02:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43CE4281834
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 00:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14A715A6;
	Wed, 18 Oct 2023 00:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="O2kQcg/F"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0AE63B
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 00:55:06 +0000 (UTC)
Received: from out-202.mta1.migadu.com (out-202.mta1.migadu.com [IPv6:2001:41d0:203:375::ca])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E74F7
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 17:55:04 -0700 (PDT)
Message-ID: <607fda5b-c976-60c0-7a51-4b7fc81cd567@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1697590502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gY1rh/KPbFdUyzt3PMI9zuFG9Mh2BCYeizZwZIT8+As=;
	b=O2kQcg/FIEORHnEVtCkn9dB7xjSEJsT1BNuPo0FQ2UzRsbWts7JI2+UF2AVO1GzgMVC9mT
	ohHwBIZ72IBdGs3KFXoxBtUIv3lsSPLDgqUuiDqavxA1ZUQxIaqHi/Ujh0fcnvU5uCOeQD
	BzryHyJJqfVT6XCNmrE7SDFEmTC8M9A=
Date: Tue, 17 Oct 2023 17:54:53 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 bpf-next 05/11] bpf: tcp: Add SYN Cookie generation
 SOCK_OPS hook.
Content-Language: en-US
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>
References: <20231013220433.70792-1-kuniyu@amazon.com>
 <20231013220433.70792-6-kuniyu@amazon.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20231013220433.70792-6-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/13/23 3:04 PM, Kuniyuki Iwashima wrote:
> This patch adds a new SOCK_OPS hook to generate arbitrary SYN Cookie.
> 
> When the kernel sends SYN Cookie to a client, the hook is invoked with
> bpf_sock_ops.op == BPF_SOCK_OPS_GEN_SYNCOOKIE_CB if the listener has
> BPF_SOCK_OPS_SYNCOOKIE_CB_FLAG set by bpf_sock_ops_cb_flags_set().
> 
> The BPF program can access the following information to encode into
> ISN:
> 
>    bpf_sock_ops.sk      : 4-tuple
>    bpf_sock_ops.skb     : TCP header
>    bpf_sock_ops.args[0] : MSS
> 
> The program must encode MSS and set it to bpf_sock_ops.replylong[0],
> which will be looped back to the paired hook added in the following
> patch.
> 
> Note that we do not call tcp_synq_overflow() so that the BPF program
> can set its own expiration period.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>   include/uapi/linux/bpf.h       | 18 +++++++++++++++-
>   net/ipv4/tcp_input.c           | 38 +++++++++++++++++++++++++++++++++-
>   tools/include/uapi/linux/bpf.h | 18 +++++++++++++++-
>   3 files changed, 71 insertions(+), 3 deletions(-)
> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 7ba61b75bc0e..d3cc530613c0 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -6738,8 +6738,17 @@ enum {
>   	 * options first before the BPF program does.
>   	 */
>   	BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG = (1<<6),
> +	/* Call bpf when the kernel generates SYN Cookie (ISN) for SYN+ACK.
> +	 *
> +	 * The bpf prog will be called to encode MSS into SYN Cookie with
> +	 * sock_ops->op == BPF_SOCK_OPS_GEN_SYNCOOKIE_CB.
> +	 *
> +	 * Please refer to the comment in BPF_SOCK_OPS_GEN_SYNCOOKIE_CB for
> +	 * input and output.
> +	 */
> +	BPF_SOCK_OPS_SYNCOOKIE_CB_FLAG = (1<<7),
>   /* Mask of all currently supported cb flags */
> -	BPF_SOCK_OPS_ALL_CB_FLAGS       = 0x7F,
> +	BPF_SOCK_OPS_ALL_CB_FLAGS       = 0xFF,
>   };
>   
>   /* List of known BPF sock_ops operators.
> @@ -6852,6 +6861,13 @@ enum {
>   					 * by the kernel or the
>   					 * earlier bpf-progs.
>   					 */
> +	BPF_SOCK_OPS_GEN_SYNCOOKIE_CB,	/* Generate SYN Cookie (ISN of
> +					 * SYN+ACK).
> +					 *
> +					 * args[0]: MSS
> +					 *
> +					 * replylong[0]: ISN
> +					 */
>   };
>   
>   /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 584825ddd0a0..c86a737e4fe6 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -6966,6 +6966,37 @@ u16 tcp_get_syncookie_mss(struct request_sock_ops *rsk_ops,
>   }
>   EXPORT_SYMBOL_GPL(tcp_get_syncookie_mss);
>   
> +#if IS_ENABLED(CONFIG_CGROUP_BPF) && IS_ENABLED(CONFIG_SYN_COOKIES)
> +static int bpf_skops_cookie_init_sequence(struct sock *sk, struct request_sock *req,
> +					  struct sk_buff *skb, __u32 *isn)
> +{
> +	struct bpf_sock_ops_kern sock_ops;
> +	int ret;
> +
> +	memset(&sock_ops, 0, offsetof(struct bpf_sock_ops_kern, temp));
> +
> +	sock_ops.op = BPF_SOCK_OPS_GEN_SYNCOOKIE_CB;
> +	sock_ops.sk = req_to_sk(req);
> +	sock_ops.args[0] = req->mss;
> +
> +	bpf_skops_init_skb(&sock_ops, skb, tcp_hdrlen(skb));
> +
> +	ret = BPF_CGROUP_RUN_PROG_SOCK_OPS_SK(&sock_ops, sk);
> +	if (ret)
> +		return ret;
> +
> +	*isn = sock_ops.replylong[0];

sock_ops.{replylong,reply} cannot be used. afaik, no existing sockops hook 
relies on {replylong,reply}. It is a union of args[4]. There could be a few 
skops bpf in the same cgrp and each of them will be run one after another. (eg. 
two skops progs want to generate cookie).

I don't prefer to extend the uapi 'struct bpf_sock_ops' and then the 
sock_ops_convert_ctx_access(). Adding member to the kernel 'struct 
bpf_sock_addr_kern' could still be considered if it is really needed.

One option is to add kfunc to allow the bpf prog to directly update the value of 
the kernel obj (e.g. tcp_rsk(req)->snt_isn here).

Also, we need to allow a bpf prog to selectively generate custom cookie for one 
SYN but fall-through to the kernel cookie for another SYN.


