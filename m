Return-Path: <bpf+bounces-11480-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01ED77BAB64
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 22:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 00C3C282239
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 20:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021F941E45;
	Thu,  5 Oct 2023 20:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lambda.lt header.i=@lambda.lt header.b="dKEECoC2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z+g+Mp1n"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8454176D;
	Thu,  5 Oct 2023 20:20:29 +0000 (UTC)
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8BD298;
	Thu,  5 Oct 2023 13:20:27 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 558585C04D2;
	Thu,  5 Oct 2023 16:20:27 -0400 (EDT)
Received: from imap43 ([10.202.2.93])
  by compute6.internal (MEProxy); Thu, 05 Oct 2023 16:20:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lambda.lt; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1696537227; x=1696623627; bh=7q
	DwL5nQoNfO0uEcE4w1PDX0y9Y5YfF15iKr60JbeoE=; b=dKEECoC2+XpmQ6lcqD
	i9SKP6srKUnYeRZ8upjjaHP0Ucer7KruKDBtv3ThiLGlZyqwFtj8qQW2sspJRVdg
	m0K+Gki8hMZ1OS8uWC8u/i+jE/fzjc+mG/kRClrAAaAd+s194doBbAZfSal0cYO5
	SUPyIf0tEIpDdLoimVgzZ5giCSn2PInSMhBpai2Q/9srGVCdU13VrzdpTwA08zv8
	qRLm+zQIUB20kFAsCZpNj0sadidu+jBvDgPUZlVgndcpY5Wr5M+WZKejTuSSphDN
	S/DqBXOcXQkGrVIn5Bnrcm8EfBCc8Gr1Iia6XQ+wbDikNZ9JFVn/hTbl0wwrhM3d
	z1sQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1696537227; x=1696623627; bh=7qDwL5nQoNfO0
	uEcE4w1PDX0y9Y5YfF15iKr60JbeoE=; b=Z+g+Mp1nFFjO88sGUV336Sli5beE0
	nlpKPDjDORGOPNTXBs1PX7Tl6KoRVXXt31FxR7Eo+oaakvg9bC5IeouTDhwQa1IT
	sW1AYf/Ap3qPIucw8Qt9DDc4w4jzm4+YdgI1WWb3R+8HomAouXLyV8ithm21l7cm
	26nK79fnQymQXvzLYPpxJ32ct+S2M1nFJHB9nUnGQiiGPKCgGhBuWYsFOonB5iGF
	4AHGUNobkdjwaIXcPEcsq0r/w94X0AIrSWZlcLyjSYdga3tMxO/tRclTvH+zuB/A
	B9FfQlpvkn3skYmz5kQC5bQZ5cMw+JixQiP1B2xOQnHYOP81j+5ESNVFg==
X-ME-Sender: <xms:ixofZb6qHtDZsRKvPdzVyYCiEXaePUWy9MxD2SbgV4wubGUnOaIjDg>
    <xme:ixofZQ6Dk53hPqI8blKfP8lpZXjARKh9HpnDIVC6Zgp4rRyzP1xi3Pa23qK7fNb_L
    pUJVwnbPahdLb9usrc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrgeeggddugeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpeforghr
    thihnhgrshcuoehmsehlrghmsggurgdrlhhtqeenucggtffrrghtthgvrhhnpeduueekje
    effeejvdeitdevgfekjeegfeduueffveeikeeifeelffevieefueduieenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmsehlrghmsggurgdrlh
    ht
X-ME-Proxy: <xmx:ixofZSe51YuPqRnbr5nPocQEye3f7sPsTiSFvCMUudljLPBszwAoHg>
    <xmx:ixofZcJLMFXVxWhT6XEShNOXiPaqOtvjY-fVttrb2e-CsV1X_MrbPw>
    <xmx:ixofZfJRvPhDCjdkVznIZ53DQ6Cgkgem0RAk-Ww91v5M9UMzenP36A>
    <xmx:ixofZWXr8OmmUDZVylqANLFsFtiYfXMyA1vCD6JYKraWEsIv4Va5dA>
Feedback-ID: i215944fb:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 0D7F82D42D87; Thu,  5 Oct 2023 16:20:27 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-958-g1b1b911df8-fm-20230927.002-g1b1b911d
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <203643c3-4ea5-40a8-bd74-d4bde8deba2d@app.fastmail.com>
In-Reply-To: <4f49a99a-bd46-ef77-036c-81b308f2ee92@linux.dev>
References: <20231003071013.824623-1-m@lambda.lt>
 <20231003071013.824623-3-m@lambda.lt>
 <4f49a99a-bd46-ef77-036c-81b308f2ee92@linux.dev>
Date: Thu, 05 Oct 2023 22:19:48 +0200
From: Martynas <m@lambda.lt>
To: "Martin KaFai Lau" <martin.lau@linux.dev>
Cc: "Daniel Borkmann" <daniel@iogearbox.net>, netdev <netdev@vger.kernel.org>,
 "Nikolay Aleksandrov" <razor@blackwall.org>, bpf@vger.kernel.org
Subject: Re: [PATCH bpf v2 2/2] selftests/bpf: Add BPF_FIB_LOOKUP_SET_SRC tests
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On Thu, Oct 5, 2023, at 12:02 AM, Martin KaFai Lau wrote:
> On 10/3/23 12:10 AM, Martynas Pumputis wrote:
>> This patch extends the existing fib_lookup test suite by adding two test
>> cases (for each IP family):
>> 
>> * Test source IP selection when default route is used.
>
> It will be helpful to reword "default route". I was looking in the patch for a 
> new route addition like "default via xxx". I think the test is reusing the 
> existing prefix route "/24" and "/64".  This is to test the address selection 
> from the dev.
>

Yep, I will change to that.

>> * Test source IP selection when an IP route has a preferred src IP addr.
>> 
>> Signed-off-by: Martynas Pumputis <m@lambda.lt>
>> ---
>>   .../selftests/bpf/prog_tests/fib_lookup.c     | 76 +++++++++++++++++--
>>   1 file changed, 70 insertions(+), 6 deletions(-)
>> 
>> diff --git a/tools/testing/selftests/bpf/prog_tests/fib_lookup.c b/tools/testing/selftests/bpf/prog_tests/fib_lookup.c
>> index 2fd05649bad1..1b0ab1dbd4f1 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/fib_lookup.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/fib_lookup.c
>> @@ -11,9 +11,13 @@
>>   
>>   #define NS_TEST			"fib_lookup_ns"
>>   #define IPV6_IFACE_ADDR		"face::face"
>> +#define IPV6_IFACE_ADDR_SEC	"cafe::cafe"
>
> SEC stands for secondary?
>

Yep, for secondary. IPV6_IFACE_ADDR_SECONDARY felt a bit too long.

>> +#define IPV6_ADDR_DST		"face::3"
>>   #define IPV6_NUD_FAILED_ADDR	"face::1"
>>   #define IPV6_NUD_STALE_ADDR	"face::2"
>>   #define IPV4_IFACE_ADDR		"10.0.0.254"
>> +#define IPV4_IFACE_ADDR_SEC	"10.1.0.254"
>> +#define IPV4_ADDR_DST		"10.2.0.254"
>>   #define IPV4_NUD_FAILED_ADDR	"10.0.0.1"
>>   #define IPV4_NUD_STALE_ADDR	"10.0.0.2"
>>   #define IPV4_TBID_ADDR		"172.0.0.254"
>> @@ -31,6 +35,8 @@ struct fib_lookup_test {
>>   	const char *desc;
>>   	const char *daddr;
>>   	int expected_ret;
>> +	const char *expected_ipv4_src;
>> +	const char *expected_ipv6_src;
>
> Instead of two members, can it be one "expected_src" member which is 
> v4/v6 
> agnoastic (similar to the "daddr" above)? The logic needs to be a 
> little smarter 
> for one time but the future test additions will be easier and less 
> error prone.
>

SGTM.

>>   	int lookup_flags;
>>   	__u32 tbid;
>>   	__u8 dmac[6];
>> @@ -69,6 +75,22 @@ static const struct fib_lookup_test tests[] = {
>>   	  .daddr = IPV6_TBID_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
>>   	  .lookup_flags = BPF_FIB_LOOKUP_DIRECT | BPF_FIB_LOOKUP_TBID, .tbid = 100,
>>   	  .dmac = DMAC_INIT2, },
>> +	{ .desc = "IPv4 set src addr",
>> +	  .daddr = IPV4_NUD_FAILED_ADDR, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
>> +	  .expected_ipv4_src = IPV4_IFACE_ADDR,
>> +	  .lookup_flags = BPF_FIB_LOOKUP_SET_SRC | BPF_FIB_LOOKUP_SKIP_NEIGH, },
>> +	{ .desc = "IPv6 set src addr",
>> +	  .daddr = IPV6_NUD_FAILED_ADDR, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
>> +	  .expected_ipv6_src = IPV6_IFACE_ADDR,
>> +	  .lookup_flags = BPF_FIB_LOOKUP_SET_SRC | BPF_FIB_LOOKUP_SKIP_NEIGH, },
>> +	{ .desc = "IPv4 set prefsrc addr from route",
>> +	  .daddr = IPV4_ADDR_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
>> +	  .expected_ipv4_src = IPV4_IFACE_ADDR_SEC,
>> +	  .lookup_flags = BPF_FIB_LOOKUP_SET_SRC | BPF_FIB_LOOKUP_SKIP_NEIGH, },
>> +	{ .desc = "IPv6 set prefsrc addr route",
>> +	  .daddr = IPV6_ADDR_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
>> +	  .expected_ipv6_src = IPV6_IFACE_ADDR_SEC,
>> +	  .lookup_flags = BPF_FIB_LOOKUP_SET_SRC | BPF_FIB_LOOKUP_SKIP_NEIGH, },
>>   };
>>   
>>   static int ifindex;
>> @@ -97,6 +119,13 @@ static int setup_netns(void)
>>   	SYS(fail, "ip neigh add %s dev veth1 nud failed", IPV4_NUD_FAILED_ADDR);
>>   	SYS(fail, "ip neigh add %s dev veth1 lladdr %s nud stale", IPV4_NUD_STALE_ADDR, DMAC);
>>   
>> +	/* Setup for prefsrc IP addr selection */
>> +	SYS(fail, "ip addr add %s/24 dev veth1", IPV4_IFACE_ADDR_SEC);
>> +	SYS(fail, "ip route add %s/32 dev veth1 src %s", IPV4_ADDR_DST, IPV4_IFACE_ADDR_SEC);
>> +
>> +	SYS(fail, "ip addr add %s/64 dev veth1 nodad", IPV6_IFACE_ADDR_SEC);
>> +	SYS(fail, "ip route add %s/128 dev veth1 src %s", IPV6_ADDR_DST, IPV6_IFACE_ADDR_SEC);
>> +
>>   	/* Setup for tbid lookup tests */
>>   	SYS(fail, "ip addr add %s/24 dev veth2", IPV4_TBID_ADDR);
>>   	SYS(fail, "ip route del %s/24 dev veth2", IPV4_TBID_NET);
>> @@ -133,9 +162,12 @@ static int set_lookup_params(struct bpf_fib_lookup *params, const struct fib_loo
>>   
>>   	if (inet_pton(AF_INET6, test->daddr, params->ipv6_dst) == 1) {
>>   		params->family = AF_INET6;
>> -		ret = inet_pton(AF_INET6, IPV6_IFACE_ADDR, params->ipv6_src);
>> -		if (!ASSERT_EQ(ret, 1, "inet_pton(IPV6_IFACE_ADDR)"))
>> -			return -1;
>> +		if (!(test->lookup_flags & BPF_FIB_LOOKUP_SET_SRC)) {
>> +			ret = inet_pton(AF_INET6, IPV6_IFACE_ADDR, params->ipv6_src);
>> +			if (!ASSERT_EQ(ret, 1, "inet_pton(IPV6_IFACE_ADDR)"))
>> +				return -1;
>> +		}
>> +
>>   		return 0;
>>   	}
>>   
>> @@ -143,9 +175,12 @@ static int set_lookup_params(struct bpf_fib_lookup *params, const struct fib_loo
>>   	if (!ASSERT_EQ(ret, 1, "convert IP[46] address"))
>>   		return -1;
>>   	params->family = AF_INET;
>> -	ret = inet_pton(AF_INET, IPV4_IFACE_ADDR, &params->ipv4_src);
>> -	if (!ASSERT_EQ(ret, 1, "inet_pton(IPV4_IFACE_ADDR)"))
>> -		return -1;
>> +
>> +	if (!(test->lookup_flags & BPF_FIB_LOOKUP_SET_SRC)) {
>> +		ret = inet_pton(AF_INET, IPV4_IFACE_ADDR, &params->ipv4_src);
>> +		if (!ASSERT_EQ(ret, 1, "inet_pton(IPV4_IFACE_ADDR)"))
>> +			return -1;
>> +	}
>>   
>>   	return 0;
>>   }
>> @@ -207,6 +242,35 @@ void test_fib_lookup(void)
>>   		ASSERT_EQ(skel->bss->fib_lookup_ret, tests[i].expected_ret,
>>   			  "fib_lookup_ret");
>>   
>> +		if (tests[i].expected_ipv4_src) {
>> +			__be32 expected_ipv4_src;
>> +
>> +			ret = inet_pton(AF_INET, tests[i].expected_ipv4_src,
>> +					&expected_ipv4_src);
>> +			ASSERT_EQ(ret, 1, "inet_pton(expected_ipv4_src)");
>> +
>> +			ASSERT_EQ(fib_params->ipv4_src, expected_ipv4_src,
>> +			  "fib_lookup ipv4 src");
>> +		}
>> +		if (tests[i].expected_ipv6_src) {
>> +			__u32 expected_ipv6_src[4];
>> +
>> +			ret = inet_pton(AF_INET6, tests[i].expected_ipv6_src,
>> +					expected_ipv6_src);
>> +			ASSERT_EQ(ret, 1, "inet_pton(expected_ipv6_src)");
>> +
>> +			ret = memcmp(expected_ipv6_src, fib_params->ipv6_src,
>> +				     sizeof(fib_params->ipv6_src));
>> +			if (!ASSERT_EQ(ret, 0, "fib_lookup ipv6 src")) {
>> +				char src_ip6[64];
>> +
>> +				inet_ntop(AF_INET6, fib_params->ipv6_src, src_ip6,
>> +					  sizeof(src_ip6));
>> +				printf("ipv6 expected %s actual %s ",
>> +				       tests[i].expected_ipv6_src, src_ip6);
>> +			}
>> +		}
>
> nit. Move the v4/v6 expected_src comparison to a static function, 
> potentially 
> done in a v4/v6 agnostic way mentioned in the above 
> expected_ipv[46]_src comment.
>
>

SGTM.

>> +
>>   		ret = memcmp(tests[i].dmac, fib_params->dmac, sizeof(tests[i].dmac));
>>   		if (!ASSERT_EQ(ret, 0, "dmac not match")) {
>>   			char expected[18], actual[18];

