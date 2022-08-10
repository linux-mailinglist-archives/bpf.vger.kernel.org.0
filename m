Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5050158E407
	for <lists+bpf@lfdr.de>; Wed, 10 Aug 2022 02:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbiHJAUr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Aug 2022 20:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiHJAUj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 20:20:39 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E5EC48;
        Tue,  9 Aug 2022 17:20:36 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 94BA55C02F0;
        Tue,  9 Aug 2022 20:20:34 -0400 (EDT)
Received: from imap42 ([10.202.2.92])
  by compute2.internal (MEProxy); Tue, 09 Aug 2022 20:20:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1660090834; x=1660177234; bh=JJXnYXScrO
        NTr0QnytBFq2JW9kKGkCqeaX23Leur64w=; b=deMUUoGI9GyzbpJZ2qZaNNaqia
        PEv88jyoyUcckPD/knKkeJ5bd/E/VKHginf9hEU9k+cbw/S9hYElOxpQo0nvoSRC
        nQ13t2baRPfUf9/M/BNOz20wBaJoDwBrOF/9D9XEOWi+bXo6gvUJ9QDqTisTJR5E
        7NUSP2uqSbEkxXCB8ZxnJSkuHKcJNKD9LA2m9ymwoUC0ys+zuNJYBgE5goz+SRmg
        u74JVIw6u6cgKqP3BkRKVewJTB7n+YGwnbcbbP34mf0Uye99+Rt+7ZQQBDOdBB0D
        BpuX+TG+8VHFB9+POyT1nSg6Jf4GJeyEnAXX62UOuRh7id3bPO8MTSXrAMeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1660090834; x=1660177234; bh=JJXnYXScrONTr0QnytBFq2JW9kKG
        kCqeaX23Leur64w=; b=Ha04nrJz4DH9sleMdvxuF2B2Na0468dFVg5fAK4O3Viq
        rk3LJh3rMSp9jH0qa82OCfUuZxmXbbZEO5LYfJE8CrTEMF+3qEsicwqqb6MMqsA0
        6bGxMCzfg7hah91I93jRFLFp29CKzeZ54TMiZyWtnyObcNj1Ed7bzAGxSIqeRNvx
        +Zas3FTLBA2tYSs0svf25u5g8Bf8KEE9kIyKbABFVVCTNm5X5ONPfLG9ADaaDY0O
        yubYDTR7VMvSGoa82yTOM4glBSIeaBeNF0Blnq1gE1VxS07varm/tdebcn8XAaoB
        bLByx3Hu2YCXo60oAPVuJxIPDHFuCKURIi6V02xNyw==
X-ME-Sender: <xms:0vnyYoeLVRENpMw11BH7ieWgSPC4qTN4i6L5fzgBS_rwpEEjHFVwvA>
    <xme:0vnyYqPOMTe5pREHtqTWqgzydfilAaTx3UMeIMwqXw0N6IldtLj90EOAJeC-qrxok
    xiRxeYw7MIkzNqsfQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeguddgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlfeehmdenucfjughrpefofgggkfgjfhffhffvvefutgesthdtredt
    reertdenucfhrhhomhepfdffrghnihgvlhcuighufdcuoegugihusegugihuuhhurdighi
    iiqeenucggtffrrghtthgvrhhnpedtudehudfhveduieeikeejudeljeffuddtieffieel
    jedtudehhfekheehuedvkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:0vnyYpjFfw-dM8ZvefI9qo0wFRir16KwkVun2Hp5LSd3O1NIlLzKbw>
    <xmx:0vnyYt8d8aGy9_ztZljOaYl-vBvkXLEYOK02Wn4D5NLpQiNthMNj6Q>
    <xmx:0vnyYkvWV7ybhzuHCSOpvhhhxg6Bva9BQ1Bpz23vLfch4vomtAi_4w>
    <xmx:0vnyYgKJedoeMgy4jUvfFkeYokKHhinkwwNj2eeXJf3s6WKXwLB3Dw>
Feedback-ID: i6a694271:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 5B8D8BC0075; Tue,  9 Aug 2022 20:20:34 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-811-gb808317eab-fm-20220801.001-gb808317e
Mime-Version: 1.0
Message-Id: <a2c064c4-4dd6-4f36-a00f-d1fab9e56bd4@www.fastmail.com>
In-Reply-To: <37649bee-5eb3-93a2-ac57-56eb375ef8cd@iogearbox.net>
References: <cover.1660062725.git.dxu@dxuuu.xyz>
 <6436220efacfa99f343ffc451e3d5dc8b7f31f05.1660062725.git.dxu@dxuuu.xyz>
 <37649bee-5eb3-93a2-ac57-56eb375ef8cd@iogearbox.net>
Date:   Tue, 09 Aug 2022 18:20:14 -0600
From:   "Daniel Xu" <dxu@dxuuu.xyz>
To:     "Daniel Borkmann" <daniel@iogearbox.net>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "Alexei Starovoitov" <ast@kernel.org>,
        "Andrii Nakryiko" <andrii@kernel.org>,
        "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Add connmark read test
Content-Type: text/plain
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Daniel,

On Tue, Aug 9, 2022, at 3:14 PM, Daniel Borkmann wrote:
> Hi Daniel,
>
> On 8/9/22 6:34 PM, Daniel Xu wrote:
>> Test that the prog can read from the connection mark. This test is nice
>> because it ensures progs can interact with netfilter subsystem
>> correctly.
>> 
>> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
>> ---
>>   tools/testing/selftests/bpf/prog_tests/bpf_nf.c | 3 ++-
>>   tools/testing/selftests/bpf/progs/test_bpf_nf.c | 3 +++
>>   2 files changed, 5 insertions(+), 1 deletion(-)
>> 
>> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_nf.c b/tools/testing/selftests/bpf/prog_tests/bpf_nf.c
>> index 317978cac029..7232f6dcd252 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/bpf_nf.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_nf.c
>> @@ -44,7 +44,7 @@ static int connect_to_server(int srv_fd)
>>   
>>   static void test_bpf_nf_ct(int mode)
>>   {
>> -	const char *iptables = "iptables -t raw %s PREROUTING -j CT";
>> +	const char *iptables = "iptables -t raw %s PREROUTING -j CONNMARK --set-mark 42/0";
>>   	int srv_fd = -1, client_fd = -1, srv_client_fd = -1;
>>   	struct sockaddr_in peer_addr = {};
>>   	struct test_bpf_nf *skel;
>> @@ -114,6 +114,7 @@ static void test_bpf_nf_ct(int mode)
>>   	/* expected status is IPS_SEEN_REPLY */
>>   	ASSERT_EQ(skel->bss->test_status, 2, "Test for ct status update ");
>>   	ASSERT_EQ(skel->data->test_exist_lookup, 0, "Test existing connection lookup");
>> +	ASSERT_EQ(skel->bss->test_exist_lookup_mark, 43, "Test existing connection lookup ctmark");
>>   end:
>>   	if (srv_client_fd != -1)
>>   		close(srv_client_fd);
>> diff --git a/tools/testing/selftests/bpf/progs/test_bpf_nf.c b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
>> index 84e0fd479794..2722441850cc 100644
>> --- a/tools/testing/selftests/bpf/progs/test_bpf_nf.c
>> +++ b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
>> @@ -28,6 +28,7 @@ __be16 sport = 0;
>>   __be32 daddr = 0;
>>   __be16 dport = 0;
>>   int test_exist_lookup = -ENOENT;
>> +u32 test_exist_lookup_mark = 0;
>>   
>>   struct nf_conn;
>>   
>> @@ -174,6 +175,8 @@ nf_ct_test(struct nf_conn *(*lookup_fn)(void *, struct bpf_sock_tuple *, u32,
>>   		       sizeof(opts_def));
>>   	if (ct) {
>>   		test_exist_lookup = 0;
>> +		if (ct->mark == 42)
>> +			test_exist_lookup_mark = 43;
>
> Looks like CI failed here:
>
>    [...]
>    progs/test_bpf_nf.c:178:11: error: no member named 'mark' in 'struct 
> nf_conn'
>                    if (ct->mark == 42)
>                        ~~  ^
>    1 error generated.
>    make: *** [Makefile:521: 
> /tmp/runner/work/bpf/bpf/tools/testing/selftests/bpf/test_bpf_nf.o] 
> Error 1
>    make: *** Waiting for unfinished jobs....
>    Error: Process completed with exit code 2.
>
> Likely due to missing CONFIG_NF_CONNTRACK_MARK for the CI instance.

Originally (as stated in the cover letter) I thought the CI kconfig was hosted
somewhere else. Looking closer I see the kconfigs are checked into the
selftest tree.

I think the following should fix the CI. I'll send out a v3 tomorrow morning:

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index fabf0c014349..3fc46f9cfb22 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -50,9 +50,11 @@ CONFIG_NET_SCHED=y
 CONFIG_NETDEVSIM=m
 CONFIG_NETFILTER=y
 CONFIG_NETFILTER_SYNPROXY=y
+CONFIG_NETFILTER_XT_CONNMARK=y
 CONFIG_NETFILTER_XT_MATCH_STATE=y
 CONFIG_NETFILTER_XT_TARGET_CT=y
 CONFIG_NF_CONNTRACK=y
+CONFIG_NF_CONNTRACK_MARK=y
 CONFIG_NF_DEFRAG_IPV4=y
 CONFIG_NF_DEFRAG_IPV6=y
 CONFIG_RC_CORE=y

[...]

Thanks,
Daniel
