Return-Path: <bpf+bounces-12494-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D6D7CD1A1
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 03:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03479281BFC
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 01:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C60CEDE;
	Wed, 18 Oct 2023 01:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vjWJMqVN"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CEA15A2
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 01:08:48 +0000 (UTC)
Received: from out-202.mta0.migadu.com (out-202.mta0.migadu.com [IPv6:2001:41d0:1004:224b::ca])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26288B0
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 18:08:47 -0700 (PDT)
Message-ID: <66f72518-f9d6-f19b-60a6-eff0f30c2590@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1697591325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zpO9FTXa+fhm6ZQzWsVc1/KbMEhxQzk0sUT4lhmZ+1I=;
	b=vjWJMqVNF3+XXR+J/pFcY+x87JUslzkbKINWb7jFPFjPy/yAgakVeHKc3KGuYtjMp8NoNB
	w8j5qhBtWo5Yy40+ScL3LyxgvuU3jxfE5YJ/tk+OsM326tXGuFLEoAgmz7ly56F6sE6Hf6
	8KvovsLmkS9+lC1NUq3nMrmVLCIjIVg=
Date: Tue, 17 Oct 2023 18:08:34 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 bpf-next 10/11] bpf: tcp: Make WS, SACK, ECN
 configurable from BPF SYN Cookie.
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
 <20231013220433.70792-11-kuniyu@amazon.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20231013220433.70792-11-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/13/23 3:04 PM, Kuniyuki Iwashima wrote:
> This patch allows BPF_SOCK_OPS_CHECK_SYNCOOKIE_CB hook to enable WScale,
> SACK, and ECN by passing corresponding flags to bpf_sock_ops.replylong[1].
> 
> The same flags are passed to BPF_SOCK_OPS_GEN_SYNCOOKIE_CB hook as
> bpf_sock_ops.args[1] so that the BPF prog need not parse the TCP header to
> check if WScale, SACK, ECN, and TS are available in SYN.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>   include/uapi/linux/bpf.h       | 18 ++++++++++++++++++
>   net/ipv4/syncookies.c          | 20 ++++++++++++++++++++
>   net/ipv4/tcp_input.c           | 11 +++++++++++
>   tools/include/uapi/linux/bpf.h | 18 ++++++++++++++++++
>   4 files changed, 67 insertions(+)
> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 24f673d88c0d..cdae4dd5d797 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -6869,6 +6869,7 @@ enum {
>   					 * option.
>   					 *
>   					 * args[0]: MSS
> +					 * args[1]: BPF_SYNCOOKIE_XXX
>   					 *
>   					 * replylong[0]: ISN
>   					 * replylong[1]: TS
> @@ -6883,6 +6884,7 @@ enum {
>   					 * args[1]: TS
>   					 *
>   					 * replylong[0]: MSS
> +					 * replylong[1]: BPF_SYNCOOKIE_XXX
>   					 */
>   };
>   
> @@ -6970,6 +6972,22 @@ enum {
>   						 */
>   };
>   
> +/* arg[1] value for BPF_SOCK_OPS_GEN_SYNCOOKIE_CB and
> + * replylong[1] for BPF_SOCK_OPS_CHECK_SYNCOOKIE_CB.
> + *
> + * MSB                                LSB
> + * | 31 ... | 6  | 5   | 4    | 3 2 1 0 |
> + * |    ... | TS | ECN | SACK | WScale  |
> + */
> +enum {
> +	/* 0xf is invalid thus means that SYN did not have WScale. */
> +	BPF_SYNCOOKIE_WSCALE_MASK	= (1 << 4) - 1,
> +	BPF_SYNCOOKIE_SACK		= (1 << 4),
> +	BPF_SYNCOOKIE_ECN		= (1 << 5),
> +	/* Only available for BPF_SOCK_OPS_GEN_SYNCOOKIE_CB to check if SYN has TS */
> +	BPF_SYNCOOKIE_TS		= (1 << 6),
> +};

This details should not be exposed to uapi (more below).

> +
>   struct bpf_perf_event_value {
>   	__u64 counter;
>   	__u64 enabled;
> diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
> index ff979cc314da..22353a9af52d 100644
> --- a/net/ipv4/syncookies.c
> +++ b/net/ipv4/syncookies.c
> @@ -286,6 +286,7 @@ int bpf_skops_cookie_check(struct sock *sk, struct request_sock *req, struct sk_
>   {
>   	struct bpf_sock_ops_kern sock_ops;
>   	struct net *net = sock_net(sk);
> +	u32 options;
>   
>   	if (tcp_opt->saw_tstamp) {
>   		if (!READ_ONCE(net->ipv4.sysctl_tcp_timestamps))
> @@ -309,6 +310,25 @@ int bpf_skops_cookie_check(struct sock *sk, struct request_sock *req, struct sk_
>   	if (!sock_ops.replylong[0])
>   		goto err;
>   
> +	options = sock_ops.replylong[1];
> +
> +	if ((options & BPF_SYNCOOKIE_WSCALE_MASK) != BPF_SYNCOOKIE_WSCALE_MASK) {
> +		if (!READ_ONCE(net->ipv4.sysctl_tcp_window_scaling))
> +			goto err;
> +
> +		tcp_opt->wscale_ok = 1;
> +		tcp_opt->snd_wscale = options & BPF_SYNCOOKIE_WSCALE_MASK;
> +	}
> +
> +	if (options & BPF_SYNCOOKIE_SACK) {
> +		if (!READ_ONCE(net->ipv4.sysctl_tcp_sack))
> +			goto err;
> +
> +		tcp_opt->sack_ok = 1;
> +	}
> +
> +	inet_rsk(req)->ecn_ok = options & BPF_SYNCOOKIE_ECN;
> +
>   	__NET_INC_STATS(sock_net(sk), LINUX_MIB_SYNCOOKIESRECV);
>   
>   	return sock_ops.replylong[0];
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index feb44bff29ef..483e2f36afe5 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -6970,14 +6970,25 @@ EXPORT_SYMBOL_GPL(tcp_get_syncookie_mss);
>   static int bpf_skops_cookie_init_sequence(struct sock *sk, struct request_sock *req,
>   					  struct sk_buff *skb, __u32 *isn)
>   {
> +	struct inet_request_sock *ireq = inet_rsk(req);
>   	struct bpf_sock_ops_kern sock_ops;
> +	u32 options;
>   	int ret;
>   
> +	options = ireq->wscale_ok ? ireq->snd_wscale : BPF_SYNCOOKIE_WSCALE_MASK;
> +	if (ireq->sack_ok)
> +		options |= BPF_SYNCOOKIE_SACK;
> +	if (ireq->ecn_ok)
> +		options |= BPF_SYNCOOKIE_ECN;
> +	if (ireq->tstamp_ok)
> +		options |= BPF_SYNCOOKIE_TS;

No need to set "options" (which becomes args[1]). sock_ops.sk is available to 
the bpf prog. The bpf prog can directly read it. The recent AF_UNIX bpf support 
could be a reference on how the bpf_cast_to_kern_ctx() and bpf_rdonly_cast() are 
used.

https://lore.kernel.org/bpf/20231011185113.140426-10-daan.j.demeyer@gmail.com/

> +
>   	memset(&sock_ops, 0, offsetof(struct bpf_sock_ops_kern, temp));
>   
>   	sock_ops.op = BPF_SOCK_OPS_GEN_SYNCOOKIE_CB;
>   	sock_ops.sk = req_to_sk(req);
>   	sock_ops.args[0] = req->mss;
> +	sock_ops.args[1] = options;
>   
>   	bpf_skops_init_skb(&sock_ops, skb, tcp_hdrlen(skb));
>   
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index 24f673d88c0d..cdae4dd5d797 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -6869,6 +6869,7 @@ enum {
>   					 * option.
>   					 *
>   					 * args[0]: MSS
> +					 * args[1]: BPF_SYNCOOKIE_XXX
>   					 *
>   					 * replylong[0]: ISN
>   					 * replylong[1]: TS
> @@ -6883,6 +6884,7 @@ enum {
>   					 * args[1]: TS
>   					 *
>   					 * replylong[0]: MSS
> +					 * replylong[1]: BPF_SYNCOOKIE_XXX
>   					 */
>   };
>   
> @@ -6970,6 +6972,22 @@ enum {
>   						 */
>   };
>   
> +/* arg[1] value for BPF_SOCK_OPS_GEN_SYNCOOKIE_CB and
> + * replylong[1] for BPF_SOCK_OPS_CHECK_SYNCOOKIE_CB.
> + *
> + * MSB                                LSB
> + * | 31 ... | 6  | 5   | 4    | 3 2 1 0 |
> + * |    ... | TS | ECN | SACK | WScale  |
> + */
> +enum {
> +	/* 0xf is invalid thus means that SYN did not have WScale. */
> +	BPF_SYNCOOKIE_WSCALE_MASK	= (1 << 4) - 1,
> +	BPF_SYNCOOKIE_SACK		= (1 << 4),
> +	BPF_SYNCOOKIE_ECN		= (1 << 5),
> +	/* Only available for BPF_SOCK_OPS_GEN_SYNCOOKIE_CB to check if SYN has TS */
> +	BPF_SYNCOOKIE_TS		= (1 << 6),
> +};
> +
>   struct bpf_perf_event_value {
>   	__u64 counter;
>   	__u64 enabled;


