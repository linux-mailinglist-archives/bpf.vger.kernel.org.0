Return-Path: <bpf+bounces-36505-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D27B2949A27
	for <lists+bpf@lfdr.de>; Tue,  6 Aug 2024 23:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 010151C21ACF
	for <lists+bpf@lfdr.de>; Tue,  6 Aug 2024 21:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6787158DD0;
	Tue,  6 Aug 2024 21:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="srRxFPex"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECDF77F08
	for <bpf@vger.kernel.org>; Tue,  6 Aug 2024 21:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722979634; cv=none; b=hYp/Ro+5XMKlhr/1M/c8BkY6Ao//K7AxAt4ooOF8douJalFkkxVC7FS21JpfsD1wr/G+JEMYJqpDyqBbspukcUQTlR7Mpgyz1N42LgTRGzzqdWTx9Ip6LfrD9BJncwnAbOTOgwuLqmLFZovb4wLpTOKMu+nnIvdBCyXefNBGJ+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722979634; c=relaxed/simple;
	bh=SfOPYFP3voWcIGkgUKCd/eWPVNuhjbF14reASxRkd1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mou7VNSNvN9Yfc3ANbdhEI3hhQT9lRdGXXQ8tGTCycBOTpIrxH8biaen+W3jEzX2VlTM+3hTU2z+6XTCHJQHzH5uD/J586k/mKg4agexiBcI1vZt5usNieidtxgQns9dskcqqHLEenUJ7U7F7kDRP2iUg8Afbh8wo6fLwju0MO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=srRxFPex; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ce11fbd3-1e72-4fc8-94c9-c1e7566339bb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722979628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uvLlul5K9yQMqokwA8PlELJYYVxVzcYjXyz+UMPY0QY=;
	b=srRxFPexv+Jada1dyaEhi+03Yp2OxZ3nuMe1K58FVQpsQdN2TZGdQiSV3xjqmWzmfEDUO3
	Rw/VpqazhdBJUapcq5vYbYWZO3UwdY9P8L1aqgDZnmYP6PWbUq0vuW6/YLQaVEjSHqXgeD
	6KXiovGLggkc+hIUUWjaXf8gkKLrXYs=
Date: Tue, 6 Aug 2024 14:27:00 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/3] selftests/bpf: add tests for
 TCP_BPF_SOCK_OPS_CB_FLAGS
To: Alan Maguire <alan.maguire@oracle.com>
Cc: ast@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 edumazet@google.com, bpf@vger.kernel.org
References: <20240802152929.2695863-1-alan.maguire@oracle.com>
 <20240802152929.2695863-3-alan.maguire@oracle.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240802152929.2695863-3-alan.maguire@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/2/24 8:29 AM, Alan Maguire wrote:
> Add tests to set/get TCP sockopt TCP_BPF_SOCK_OPS_CB_FLAGS via
> bpf_setsockopt() and also add a cgroup/setsockopt program that
> catches setsockopt() for this option and uses bpf_setsockopt()
> to set it.  The latter allows us to support modifying sockops
> cb flags on a per-socket basis via setsockopt() without adding
> support into core setsockopt() itself.
> 
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>   .../selftests/bpf/prog_tests/setget_sockopt.c | 11 ++++++
>   .../selftests/bpf/progs/setget_sockopt.c      | 37 +++++++++++++++++--
>   2 files changed, 45 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/setget_sockopt.c b/tools/testing/selftests/bpf/prog_tests/setget_sockopt.c
> index 7d4a9b3d3722..b9c54217a489 100644
> --- a/tools/testing/selftests/bpf/prog_tests/setget_sockopt.c
> +++ b/tools/testing/selftests/bpf/prog_tests/setget_sockopt.c
> @@ -42,6 +42,7 @@ static int create_netns(void)
>   static void test_tcp(int family)
>   {
>   	struct setget_sockopt__bss *bss = skel->bss;
> +	int cb_flags = BPF_SOCK_OPS_STATE_CB_FLAG | BPF_SOCK_OPS_RTO_CB_FLAG;
>   	int sfd, cfd;
>   
>   	memset(bss, 0, sizeof(*bss));
> @@ -56,6 +57,9 @@ static void test_tcp(int family)
>   		close(sfd);
>   		return;
>   	}
> +	ASSERT_EQ(setsockopt(sfd, SOL_TCP, TCP_BPF_SOCK_OPS_CB_FLAGS,
> +			     &cb_flags, sizeof(cb_flags)),
> +		  0, "setsockopt cb_flags");

The sfd here is the listen fd. The setsockopt here is after the connection is 
established and the connection won't be affected by this setsockopt...

I don't think this test belongs to test_tcp() here, more on this below...

>   	close(sfd);
>   	close(cfd);
>   
> @@ -65,6 +69,8 @@ static void test_tcp(int family)
>   	ASSERT_EQ(bss->nr_passive, 1, "nr_passive");
>   	ASSERT_EQ(bss->nr_socket_post_create, 2, "nr_socket_post_create");
>   	ASSERT_EQ(bss->nr_binddev, 2, "nr_bind");
> +	ASSERT_GE(bss->nr_state, 1, "nr_state");
> +	ASSERT_EQ(bss->nr_setsockopt, 1, "nr_setsockopt");
>   }
>   
>   static void test_udp(int family)
> @@ -185,6 +191,11 @@ void test_setget_sockopt(void)
>   	if (!ASSERT_OK_PTR(skel->links.socket_post_create, "attach_cgroup"))
>   		goto done;
>   
> +	skel->links.tcp_setsockopt =
> +		bpf_program__attach_cgroup(skel->progs.tcp_setsockopt, cg_fd);
> +	if (!ASSERT_OK_PTR(skel->links.tcp_setsockopt, "attach_setsockopt"))
> +		goto done;
> +
>   	test_tcp(AF_INET6);
>   	test_tcp(AF_INET);
>   	test_udp(AF_INET6);
> diff --git a/tools/testing/selftests/bpf/progs/setget_sockopt.c b/tools/testing/selftests/bpf/progs/setget_sockopt.c
> index 60518aed1ffc..920af9e21e84 100644
> --- a/tools/testing/selftests/bpf/progs/setget_sockopt.c
> +++ b/tools/testing/selftests/bpf/progs/setget_sockopt.c
> @@ -20,6 +20,8 @@ int nr_connect;
>   int nr_binddev;
>   int nr_socket_post_create;
>   int nr_fin_wait1;
> +int nr_state;
> +int nr_setsockopt;
>   
>   struct sockopt_test {
>   	int opt;
> @@ -59,6 +61,8 @@ static const struct sockopt_test sol_tcp_tests[] = {
>   	{ .opt = TCP_THIN_LINEAR_TIMEOUTS, .flip = 1, },
>   	{ .opt = TCP_USER_TIMEOUT, .new = 123400, .expected = 123400, },
>   	{ .opt = TCP_NOTSENT_LOWAT, .new = 1314, .expected = 1314, },
> +	{ .opt = TCP_BPF_SOCK_OPS_CB_FLAGS, .new = BPF_SOCK_OPS_ALL_CB_FLAGS,
> +	  .expected = BPF_SOCK_OPS_ALL_CB_FLAGS, .restore = BPF_SOCK_OPS_STATE_CB_FLAG, },
>   	{ .opt = 0, },
>   };
>   
> @@ -124,6 +128,7 @@ static int bpf_test_sockopt_int(void *ctx, struct sock *sk,
>   
>   	if (bpf_setsockopt(ctx, level, opt, &new, sizeof(new)))
>   		return 1;
> +
>   	if (bpf_getsockopt(ctx, level, opt, &tmp, sizeof(tmp)) ||
>   	    tmp != expected)
>   		return 1;
> @@ -384,11 +389,14 @@ int skops_sockopt(struct bpf_sock_ops *skops)
>   		nr_passive += !(bpf_test_sockopt(skops, sk) ||
>   				test_tcp_maxseg(skops, sk) ||
>   				test_tcp_saved_syn(skops, sk));
> -		bpf_sock_ops_cb_flags_set(skops,
> -					  skops->bpf_sock_ops_cb_flags |
> -					  BPF_SOCK_OPS_STATE_CB_FLAG);
> +
> +		/* no need to set sockops cb flags here as sockopt
> +		 * tests and user-space originated setsockopt() will
> +		 * set flags to include BPF_SOCK_OPS_STATE_CB.
> +		 */

I don't think the "user-space originated..." comment is accruate here. The 
user-space originated setsockopt() from the above test_tcp() won't affect the 
passively established sk here. This took me a while to digest...

iiuc, the removed bpf_sock_ops_cb_flags_set() for the passive connection is now 
implicitly done (and hidden) in the newly added sol_tcp_tests[].restore.

How about keeping the explicit bpf_sock_ops_cb_flags_set() and removing the 
".restore".

The existing bpf_sock_ops_cb_flags_set() can be changed to 
bpf_setsockopt(TCP_BPF_SOCK_OPS_CB_FLAGS) if it helps to test if it is effective.

>   		break;
>   	case BPF_SOCK_OPS_STATE_CB:
> +		nr_state++;

How about removing the nr_state addition and adding a SEC("cgroup/getsockopt") 
bpf prog to test the getsockopt(TCP_BPF_SOCK_OPS_CB_FLAGS).

Create another test_nonstandard_opt() in prog_tests/setget_sockopt.c and 
separate it from the existing test_{tcp, udp...} which is mainly exercising 
set/getsockopt(sol_*_tests[]) on different hooks (right now it has 
lsm_cgroup/socket_post_create and sockops). It doesn't fit testing the user 
syscall set/getsockopt on the nonstandard_opt.

