Return-Path: <bpf+bounces-11407-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0247B970B
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 00:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id ECD47281C0A
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 22:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84507250E1;
	Wed,  4 Oct 2023 22:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EMYyu0wp"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0399D241EF
	for <bpf@vger.kernel.org>; Wed,  4 Oct 2023 22:02:55 +0000 (UTC)
Received: from out-210.mta1.migadu.com (out-210.mta1.migadu.com [IPv6:2001:41d0:203:375::d2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398CDC6
	for <bpf@vger.kernel.org>; Wed,  4 Oct 2023 15:02:54 -0700 (PDT)
Message-ID: <4f49a99a-bd46-ef77-036c-81b308f2ee92@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1696456972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VmMEOFVAoe9Oex49JoHSRTn1zjC/lcJvDaBEsDUxV58=;
	b=EMYyu0wpT8LbSK9x5RUwDOgKxu2dNIRdHhJEcBYrg6LPrYEKN+kIvGWyvNuYJYkElLk7Bh
	bUzQvrYTRUBilur0MpcNuUEiQh15ovhpW0ak4a8Srp7qp11yA5tQARDNDmg8CKHkTINd5c
	I1AEPPUq1jpazWcOpm9S/cEyRC79ALI=
Date: Wed, 4 Oct 2023 15:02:45 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v2 2/2] selftests/bpf: Add BPF_FIB_LOOKUP_SET_SRC
 tests
Content-Language: en-US
To: Martynas Pumputis <m@lambda.lt>
Cc: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 Nikolay Aleksandrov <razor@blackwall.org>, bpf@vger.kernel.org
References: <20231003071013.824623-1-m@lambda.lt>
 <20231003071013.824623-3-m@lambda.lt>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20231003071013.824623-3-m@lambda.lt>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/3/23 12:10 AM, Martynas Pumputis wrote:
> This patch extends the existing fib_lookup test suite by adding two test
> cases (for each IP family):
> 
> * Test source IP selection when default route is used.

It will be helpful to reword "default route". I was looking in the patch for a 
new route addition like "default via xxx". I think the test is reusing the 
existing prefix route "/24" and "/64".  This is to test the address selection 
from the dev.

> * Test source IP selection when an IP route has a preferred src IP addr.
> 
> Signed-off-by: Martynas Pumputis <m@lambda.lt>
> ---
>   .../selftests/bpf/prog_tests/fib_lookup.c     | 76 +++++++++++++++++--
>   1 file changed, 70 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/fib_lookup.c b/tools/testing/selftests/bpf/prog_tests/fib_lookup.c
> index 2fd05649bad1..1b0ab1dbd4f1 100644
> --- a/tools/testing/selftests/bpf/prog_tests/fib_lookup.c
> +++ b/tools/testing/selftests/bpf/prog_tests/fib_lookup.c
> @@ -11,9 +11,13 @@
>   
>   #define NS_TEST			"fib_lookup_ns"
>   #define IPV6_IFACE_ADDR		"face::face"
> +#define IPV6_IFACE_ADDR_SEC	"cafe::cafe"

SEC stands for secondary?

> +#define IPV6_ADDR_DST		"face::3"
>   #define IPV6_NUD_FAILED_ADDR	"face::1"
>   #define IPV6_NUD_STALE_ADDR	"face::2"
>   #define IPV4_IFACE_ADDR		"10.0.0.254"
> +#define IPV4_IFACE_ADDR_SEC	"10.1.0.254"
> +#define IPV4_ADDR_DST		"10.2.0.254"
>   #define IPV4_NUD_FAILED_ADDR	"10.0.0.1"
>   #define IPV4_NUD_STALE_ADDR	"10.0.0.2"
>   #define IPV4_TBID_ADDR		"172.0.0.254"
> @@ -31,6 +35,8 @@ struct fib_lookup_test {
>   	const char *desc;
>   	const char *daddr;
>   	int expected_ret;
> +	const char *expected_ipv4_src;
> +	const char *expected_ipv6_src;

Instead of two members, can it be one "expected_src" member which is v4/v6 
agnoastic (similar to the "daddr" above)? The logic needs to be a little smarter 
for one time but the future test additions will be easier and less error prone.

>   	int lookup_flags;
>   	__u32 tbid;
>   	__u8 dmac[6];
> @@ -69,6 +75,22 @@ static const struct fib_lookup_test tests[] = {
>   	  .daddr = IPV6_TBID_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
>   	  .lookup_flags = BPF_FIB_LOOKUP_DIRECT | BPF_FIB_LOOKUP_TBID, .tbid = 100,
>   	  .dmac = DMAC_INIT2, },
> +	{ .desc = "IPv4 set src addr",
> +	  .daddr = IPV4_NUD_FAILED_ADDR, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
> +	  .expected_ipv4_src = IPV4_IFACE_ADDR,
> +	  .lookup_flags = BPF_FIB_LOOKUP_SET_SRC | BPF_FIB_LOOKUP_SKIP_NEIGH, },
> +	{ .desc = "IPv6 set src addr",
> +	  .daddr = IPV6_NUD_FAILED_ADDR, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
> +	  .expected_ipv6_src = IPV6_IFACE_ADDR,
> +	  .lookup_flags = BPF_FIB_LOOKUP_SET_SRC | BPF_FIB_LOOKUP_SKIP_NEIGH, },
> +	{ .desc = "IPv4 set prefsrc addr from route",
> +	  .daddr = IPV4_ADDR_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
> +	  .expected_ipv4_src = IPV4_IFACE_ADDR_SEC,
> +	  .lookup_flags = BPF_FIB_LOOKUP_SET_SRC | BPF_FIB_LOOKUP_SKIP_NEIGH, },
> +	{ .desc = "IPv6 set prefsrc addr route",
> +	  .daddr = IPV6_ADDR_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
> +	  .expected_ipv6_src = IPV6_IFACE_ADDR_SEC,
> +	  .lookup_flags = BPF_FIB_LOOKUP_SET_SRC | BPF_FIB_LOOKUP_SKIP_NEIGH, },
>   };
>   
>   static int ifindex;
> @@ -97,6 +119,13 @@ static int setup_netns(void)
>   	SYS(fail, "ip neigh add %s dev veth1 nud failed", IPV4_NUD_FAILED_ADDR);
>   	SYS(fail, "ip neigh add %s dev veth1 lladdr %s nud stale", IPV4_NUD_STALE_ADDR, DMAC);
>   
> +	/* Setup for prefsrc IP addr selection */
> +	SYS(fail, "ip addr add %s/24 dev veth1", IPV4_IFACE_ADDR_SEC);
> +	SYS(fail, "ip route add %s/32 dev veth1 src %s", IPV4_ADDR_DST, IPV4_IFACE_ADDR_SEC);
> +
> +	SYS(fail, "ip addr add %s/64 dev veth1 nodad", IPV6_IFACE_ADDR_SEC);
> +	SYS(fail, "ip route add %s/128 dev veth1 src %s", IPV6_ADDR_DST, IPV6_IFACE_ADDR_SEC);
> +
>   	/* Setup for tbid lookup tests */
>   	SYS(fail, "ip addr add %s/24 dev veth2", IPV4_TBID_ADDR);
>   	SYS(fail, "ip route del %s/24 dev veth2", IPV4_TBID_NET);
> @@ -133,9 +162,12 @@ static int set_lookup_params(struct bpf_fib_lookup *params, const struct fib_loo
>   
>   	if (inet_pton(AF_INET6, test->daddr, params->ipv6_dst) == 1) {
>   		params->family = AF_INET6;
> -		ret = inet_pton(AF_INET6, IPV6_IFACE_ADDR, params->ipv6_src);
> -		if (!ASSERT_EQ(ret, 1, "inet_pton(IPV6_IFACE_ADDR)"))
> -			return -1;
> +		if (!(test->lookup_flags & BPF_FIB_LOOKUP_SET_SRC)) {
> +			ret = inet_pton(AF_INET6, IPV6_IFACE_ADDR, params->ipv6_src);
> +			if (!ASSERT_EQ(ret, 1, "inet_pton(IPV6_IFACE_ADDR)"))
> +				return -1;
> +		}
> +
>   		return 0;
>   	}
>   
> @@ -143,9 +175,12 @@ static int set_lookup_params(struct bpf_fib_lookup *params, const struct fib_loo
>   	if (!ASSERT_EQ(ret, 1, "convert IP[46] address"))
>   		return -1;
>   	params->family = AF_INET;
> -	ret = inet_pton(AF_INET, IPV4_IFACE_ADDR, &params->ipv4_src);
> -	if (!ASSERT_EQ(ret, 1, "inet_pton(IPV4_IFACE_ADDR)"))
> -		return -1;
> +
> +	if (!(test->lookup_flags & BPF_FIB_LOOKUP_SET_SRC)) {
> +		ret = inet_pton(AF_INET, IPV4_IFACE_ADDR, &params->ipv4_src);
> +		if (!ASSERT_EQ(ret, 1, "inet_pton(IPV4_IFACE_ADDR)"))
> +			return -1;
> +	}
>   
>   	return 0;
>   }
> @@ -207,6 +242,35 @@ void test_fib_lookup(void)
>   		ASSERT_EQ(skel->bss->fib_lookup_ret, tests[i].expected_ret,
>   			  "fib_lookup_ret");
>   
> +		if (tests[i].expected_ipv4_src) {
> +			__be32 expected_ipv4_src;
> +
> +			ret = inet_pton(AF_INET, tests[i].expected_ipv4_src,
> +					&expected_ipv4_src);
> +			ASSERT_EQ(ret, 1, "inet_pton(expected_ipv4_src)");
> +
> +			ASSERT_EQ(fib_params->ipv4_src, expected_ipv4_src,
> +			  "fib_lookup ipv4 src");
> +		}
> +		if (tests[i].expected_ipv6_src) {
> +			__u32 expected_ipv6_src[4];
> +
> +			ret = inet_pton(AF_INET6, tests[i].expected_ipv6_src,
> +					expected_ipv6_src);
> +			ASSERT_EQ(ret, 1, "inet_pton(expected_ipv6_src)");
> +
> +			ret = memcmp(expected_ipv6_src, fib_params->ipv6_src,
> +				     sizeof(fib_params->ipv6_src));
> +			if (!ASSERT_EQ(ret, 0, "fib_lookup ipv6 src")) {
> +				char src_ip6[64];
> +
> +				inet_ntop(AF_INET6, fib_params->ipv6_src, src_ip6,
> +					  sizeof(src_ip6));
> +				printf("ipv6 expected %s actual %s ",
> +				       tests[i].expected_ipv6_src, src_ip6);
> +			}
> +		}

nit. Move the v4/v6 expected_src comparison to a static function, potentially 
done in a v4/v6 agnostic way mentioned in the above expected_ipv[46]_src comment.


> +
>   		ret = memcmp(tests[i].dmac, fib_params->dmac, sizeof(tests[i].dmac));
>   		if (!ASSERT_EQ(ret, 0, "dmac not match")) {
>   			char expected[18], actual[18];


