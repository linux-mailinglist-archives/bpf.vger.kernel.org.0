Return-Path: <bpf+bounces-20067-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6915A838680
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 06:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDF191F26728
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 05:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581FF1FD7;
	Tue, 23 Jan 2024 05:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nSX/5YyP"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE52E1FB2
	for <bpf@vger.kernel.org>; Tue, 23 Jan 2024 05:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705986148; cv=none; b=fINcE6yqyXEOks/+jbZbTZK1rZr4UUqPZg1hQCC2ByvpuCIt37aE98tzkguGXWrm49Gu1xnLXha7ONP3eXb0gIrODBEhibThvfu8rIV2WR2GXIxlGAKKfJsg+aEJL42X6U+aiUKA6IbdmzOkLYoJgV/NcLQ95+0PUq+7uVOa/EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705986148; c=relaxed/simple;
	bh=g58aHxhDREZbRfLOY7JXUQ55EvDy61Z+FpAMyBQbg6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iZbdkn8jatFbGnWkr9lRwl1slOV+0b13k7vA8nK7jdMaphxkWQajnGJIq8EnBfy5O9EnDaLu9WxQ75fvg6w6CQ1AIksPg6u60rRgXa0IyrmGYd7abnJTFP6lLecRefA/0NZBlFxZbnFERlCthxAvw4peHGQfnZOa1OxN+Vmkp/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nSX/5YyP; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <791f4b62-3ea3-4bd6-a9a0-7f84022c9eb4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705986144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s2rcWRVVZlZBBni8HH0SvWCPKWTj+RzDuFkQt8AzlI4=;
	b=nSX/5YyPyMN4sHHc8LYdgm10P/SAnvrFYWsKqNPQeis9ZpQSNfEUvCytZ3iG2O00UDbnGB
	UgjQJgAIN68z2jiyTTeTrw88e/9FjXberMpgsJEoy21ulyZK508PjevhztQlMrwMoKBR0q
	24NMRdaj5qNIkgng4YKBgNAUjaRWkTs=
Date: Mon, 22 Jan 2024 21:02:19 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 bpf-next 1/2] selftests/bpf: Fix the flaky
 tc_redirect_dtime test
Content-Language: en-GB
To: Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@meta.com
References: <20240120060518.3604920-1-martin.lau@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240120060518.3604920-1-martin.lau@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 1/19/24 10:05 PM, Martin KaFai Lau wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
>
> BPF CI has been reporting the tc_redirect_dtime test failing
> from time to time:
>
> test_inet_dtime:PASS:setns src 0 nsec
> (network_helpers.c:253: errno: No route to host) Failed to connect to server
> close_netns:PASS:setns 0 nsec
> test_inet_dtime:FAIL:connect_to_fd unexpected connect_to_fd: actual -1 < expected 0
> test_tcp_clear_dtime:PASS:tcp ip6 clear dtime ingress_fwdns_p100 0 nsec
>
> The connect_to_fd failure (EHOSTUNREACH) is from the
> test_tcp_clear_dtime() test and it is the very first IPv6 traffic
> after setting up all the links, addresses, and routes.
>
> The symptom is this first connect() is always slow. In my setup, it
> could take ~3s.
>
> After some tracing and tcpdump, the slowness is mostly spent in
> the neighbor solicitation in the "ns_fwd" namespace while
> the "ns_src" and "ns_dst" are fine.
>
> I forced the kernel to drop the neighbor solicitation messages.
> I can then reproduce EHOSTUNREACH. What actually happen could be:
> - the neighbor advertisement came back a little slow.
> - the "ns_fwd" namespace concluded a neighbor discovery failure
>    and triggered the ndisc_error_report() => ip6_link_failure() =>
>    icmpv6_send(skb, ICMPV6_DEST_UNREACH, ICMPV6_ADDR_UNREACH, 0)
> - the client's connect() reports EHOSTUNREACH after receiving
>    the ICMPV6_DEST_UNREACH message.
>
> The neigh table of both "ns_src" and "ns_dst" namespace has already
> been manually populated but not the "ns_fwd" namespace. This patch

I tried one experiment which comments out manual population of neigh mac address
like below:

diff --git a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
index 518f143c5b0f..feb477366393 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
+++ b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
@@ -241,14 +241,14 @@ static int netns_setup_links_and_routes(struct netns_setup_result *result)
         SYS(fail, "ip route add " IP4_DST "/32 dev src scope global");
         SYS(fail, "ip route add " IP4_NET "/16 dev src scope global");
         SYS(fail, "ip route add " IP6_DST "/128 dev src scope global");
-
+#if 0
         if (result->dev_mode == MODE_VETH) {
                 SYS(fail, "ip neigh add " IP4_DST " dev src lladdr %s",
                     src_fwd_addr);
                 SYS(fail, "ip neigh add " IP6_DST " dev src lladdr %s",
                     src_fwd_addr);
         }
-
+#endif
         close_netns(nstoken);
  
         /** setup in 'fwd' namespace */
@@ -284,12 +284,12 @@ static int netns_setup_links_and_routes(struct netns_setup_result *result)
         SYS(fail, "ip route add " IP4_SRC "/32 dev dst scope global");
         SYS(fail, "ip route add " IP4_NET "/16 dev dst scope global");
         SYS(fail, "ip route add " IP6_SRC "/128 dev dst scope global");
-
+#if 0
         if (result->dev_mode == MODE_VETH) {
                 SYS(fail, "ip neigh add " IP4_SRC " dev dst lladdr " MAC_DST_FWD);
                 SYS(fail, "ip neigh add " IP6_SRC " dev dst lladdr " MAC_DST_FWD);
         }
-
+#endif
         close_netns(nstoken);
  
         return 0;

And I can 100% reliably trigger the following error:

$ ./test_progs -t tc_redirect
...
All error logs:
test_tc_redirect:PASS:pthread_create 0 nsec
netns_setup_namespaces:PASS:ip netns add ns_src 0 nsec
netns_setup_namespaces:PASS:ip netns add ns_fwd 0 nsec
netns_setup_namespaces:PASS:ip netns add ns_dst 0 nsec
test_tc_redirect_run_tests:PASS:setup namespaces 0 nsec
...
test_tcp:PASS:setns dst 0 nsec
test_tcp:PASS:listen 0 nsec
close_netns:PASS:setns 0 nsec
open_netns:PASS:malloc token 0 nsec
open_netns:PASS:open /proc/self/ns/net 0 nsec
open_netns:PASS:open netns fd 0 nsec
open_netns:PASS:setns 0 nsec
test_tcp:PASS:setns src 0 nsec
(network_helpers.c:253: errno: Operation now in progress) Failed to connect to server
test_tcp:FAIL:connect_to_fd unexpected connect_to_fd: actual -1 < expected 0
close_netns:PASS:setns 0 nsec
test_ping:FAIL:ip netns exec ns_src ping -i 0.2 -c 3 -w 10 -q 172.16.2.100 > /dev/null unexpected error: 256 (errno 115)
...
open_netns:PASS:setns 0 nsec
test_tcp:PASS:setns src 0 nsec
(network_helpers.c:253: errno: Operation now in progress) Failed to connect to server
test_tcp:FAIL:connect_to_fd unexpected connect_to_fd: actual -1 < expected 0
close_netns:PASS:setns 0 nsec
test_ping:FAIL:ip netns exec ns_src ping6 -i 0.2 -c 3 -w 10 -q 0::2:dead:beef:cafe > /dev/null unexpected error: 256 (errno 115)
close_netns:PASS:setns 0 nsec

The error message:
   (network_helpers.c:253: errno: Operation now in progress) Failed to connect to server
not exactly the same but very similar to the failure observed in CI:
   (network_helpers.c:253: errno: No route to host) Failed to connect to server

The above error 'Operation now in progress' may indicate some slowness in the kernel
which caused the test failure, with or without my above hack.

> fixes it by manually populating the neigh table also in the "ns_fwd"
> namespace.
>
> Although the namespace configuration part had been existed before
> the tc_redirect_dtime test, still Fixes-tagging the patch when
> the tc_redirect_dtime test was added since it is the only test
> hitting it so far.
>
> Fixes: c803475fd8dd ("bpf: selftests: test skb->tstamp in redirect_neigh")
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> ---
>   tools/testing/selftests/bpf/prog_tests/tc_redirect.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
> index 518f143c5b0f..610887157fd8 100644
> --- a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
> +++ b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
> @@ -188,6 +188,7 @@ static int netns_setup_links_and_routes(struct netns_setup_result *result)
>   {
>   	struct nstoken *nstoken = NULL;
>   	char src_fwd_addr[IFADDR_STR_LEN+1] = {};
> +	char src_addr[IFADDR_STR_LEN + 1] = {};
>   	int err;
>   
>   	if (result->dev_mode == MODE_VETH) {
> @@ -208,6 +209,9 @@ static int netns_setup_links_and_routes(struct netns_setup_result *result)
>   	if (get_ifaddr("src_fwd", src_fwd_addr))
>   		goto fail;
>   
> +	if (get_ifaddr("src", src_addr))
> +		goto fail;
> +
>   	result->ifindex_src = if_nametoindex("src");
>   	if (!ASSERT_GT(result->ifindex_src, 0, "ifindex_src"))
>   		goto fail;
> @@ -270,6 +274,13 @@ static int netns_setup_links_and_routes(struct netns_setup_result *result)
>   	SYS(fail, "ip route add " IP4_DST "/32 dev dst_fwd scope global");
>   	SYS(fail, "ip route add " IP6_DST "/128 dev dst_fwd scope global");
>   
> +	if (result->dev_mode == MODE_VETH) {
> +		SYS(fail, "ip neigh add " IP4_SRC " dev src_fwd lladdr %s", src_addr);
> +		SYS(fail, "ip neigh add " IP6_SRC " dev src_fwd lladdr %s", src_addr);
> +		SYS(fail, "ip neigh add " IP4_DST " dev dst_fwd lladdr %s", MAC_DST);
> +		SYS(fail, "ip neigh add " IP6_DST " dev dst_fwd lladdr %s", MAC_DST);
> +	}
> +
>   	close_netns(nstoken);
>   
>   	/** setup in 'dst' namespace */

