Return-Path: <bpf+bounces-9523-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74532798B13
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 18:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EDF8281B04
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 16:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F1013AFC;
	Fri,  8 Sep 2023 16:55:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145C115B6;
	Fri,  8 Sep 2023 16:55:00 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E85472127;
	Fri,  8 Sep 2023 09:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=GDHL6IiYPwNZcf6kx9XmN1cV8w5Fo1IlphxTAFnzyi8=; b=Ffn7pcrGsAElYPJfnJgg8aTLHE
	vrbCstXNgUUe11EYBb87O99syAnw75KwWGQLtRc2j+M7ceIZEJNz2de55pSNV7xFMXmeD9RFOTbJ9
	uevpsUfA/cgNL3wzWfYr4u+6RBmnKd8m8AHIQ9895F2BdAI7/7W+sfXb2nx7lR80PSPd2HLVjUwmH
	HT5EWihSVTNZ6bbxSXjORvxD2PGOB7oFaf4eeujhXyG3sSvI0dQpPtPtSpZfRyiOqo7g+S0cDgb8G
	e6AxTBhrTWrAHxNvJLT26TDp13wI8juoSXyy6OP2ecwwBpldLkR/tG4iXSwOVhS+53a3IhkAjAWUJ
	i+EUDAyg==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qeekZ-0004RB-SQ; Fri, 08 Sep 2023 18:54:32 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qeekZ-000Md4-Kb; Fri, 08 Sep 2023 18:54:31 +0200
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Make sure zero-len skbs
 aren't redirectable
To: Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org
References: <20221121180340.1983627-1-sdf@google.com>
 <20221121180340.1983627-2-sdf@google.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <2b84e81a-90f8-898f-d320-a29233ff37ad@iogearbox.net>
Date: Fri, 8 Sep 2023 18:54:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20221121180340.1983627-2-sdf@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/27025/Fri Sep  8 09:37:45 2023)
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Stan,

Do you have some cycles to look into the below?

On 11/21/22 7:03 PM, Stanislav Fomichev wrote:
> LWT_XMIT to test L3 case, TC to test L2 case.
> 
> v2:
> - s/veth_ifindex/ipip_ifindex/ in two places (Martin)
> - add comment about which condition triggers the rejection (Martin)
> 
> Signed-off-by: Stanislav Fomichev <sdf@google.com>
[...]
> +		/* ETH_HLEN+1-sized packet should be redirected. */
> +
> +		{
> +			.msg = "veth ETH_HLEN+1 packet ingress",
> +			.data_in = eth_hlen_pp,
> +			.data_size_in = sizeof(eth_hlen_pp),
> +			.ifindex = &veth_ifindex,
> +		},
[...]

This one is now failing in BPF CI on net/net-next ff after the veth driver changed
it's drop error code in [0] from NETDEV_TX_OK (0) to NET_XMIT_DROP (1) :

test_empty_skb:FAIL:ret: veth ETH_HLEN+1 packet ingress [redirect_egress] unexpected ret: veth ETH_HLEN+1 packet ingress [redirect_egress]: actual 1 != expected 0
test_empty_skb:PASS:err: veth ETH_HLEN+1 packet ingress [tc_redirect_ingress] 0 nsec
test_empty_skb:PASS:ret: veth ETH_HLEN+1 packet ingress [tc_redirect_ingress] 0 nsec
test_empty_skb:PASS:err: veth ETH_HLEN+1 packet ingress [tc_redirect_egress] 0 nsec
test_empty_skb:PASS:ret: veth ETH_HLEN+1 packet ingress [tc_redirect_egress] 0 nsec
test_empty_skb:PASS:err: ipip ETH_HLEN+1 packet ingress [redirect_ingress] 0 nsec
test_empty_skb:PASS:ret: ipip ETH_HLEN+1 packet ingress [redirect_ingress] 0 nsec
test_empty_skb:PASS:err: ipip ETH_HLEN+1 packet ingress [redirect_egress] 0 nsec
test_empty_skb:PASS:ret: ipip ETH_HLEN+1 packet ingress [redirect_egress] 0 nsec
test_empty_skb:PASS:err: ipip ETH_HLEN+1 packet ingress [tc_redirect_ingress] 0 nsec
test_empty_skb:PASS:ret: ipip ETH_HLEN+1 packet ingress [tc_redirect_ingress] 0 nsec
test_empty_skb:PASS:err: ipip ETH_HLEN+1 packet ingress [tc_redirect_egress] 0 nsec
test_empty_skb:PASS:ret: ipip ETH_HLEN+1 packet ingress [tc_redirect_egress] 0 nsec
close_netns:PASS:setns 0 nsec
#71      empty_skb:FAIL

The test was testing bpf_clone_redirect which is still okay, just that for the
xmit sides it propagates the error code now into ret and hence the assert fails.
Perhaps we would need to tweak the test case to test for 0 or 1 ... 0 in case
bpf_clone_redirect pushes to ingress, 1 in case it pushes to egress and reaches
veth..

Thanks,
Daniel

   [0] https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=151e887d8ff97e2e42110ffa1fb1e6a2128fb364

> +	};
> +
> +	SYS("ip netns add empty_skb");
> +	tok = open_netns("empty_skb");
> +	SYS("ip link add veth0 type veth peer veth1");
> +	SYS("ip link set dev veth0 up");
> +	SYS("ip link set dev veth1 up");
> +	SYS("ip addr add 10.0.0.1/8 dev veth0");
> +	SYS("ip addr add 10.0.0.2/8 dev veth1");
> +	veth_ifindex = if_nametoindex("veth0");
> +
> +	SYS("ip link add ipip0 type ipip local 10.0.0.1 remote 10.0.0.2");
> +	SYS("ip link set ipip0 up");
> +	SYS("ip addr add 192.168.1.1/16 dev ipip0");
> +	ipip_ifindex = if_nametoindex("ipip0");
> +
> +	bpf_obj = empty_skb__open_and_load();
> +	if (!ASSERT_OK_PTR(bpf_obj, "open skeleton"))
> +		goto out;
> +
> +	for (i = 0; i < ARRAY_SIZE(tests); i++) {
> +		bpf_object__for_each_program(prog, bpf_obj->obj) {
> +			char buf[128];
> +			bool at_tc = !strncmp(bpf_program__section_name(prog), "tc", 2);
> +
> +			tattr.data_in = tests[i].data_in;
> +			tattr.data_size_in = tests[i].data_size_in;
> +
> +			tattr.data_size_out = 0;
> +			bpf_obj->bss->ifindex = *tests[i].ifindex;
> +			bpf_obj->bss->ret = 0;
> +			err = bpf_prog_test_run_opts(bpf_program__fd(prog), &tattr);
> +			sprintf(buf, "err: %s [%s]", tests[i].msg, bpf_program__name(prog));
> +
> +			if (at_tc && tests[i].success_on_tc)
> +				ASSERT_GE(err, 0, buf);
> +			else
> +				ASSERT_EQ(err, tests[i].err, buf);
> +			sprintf(buf, "ret: %s [%s]", tests[i].msg, bpf_program__name(prog));
> +			if (at_tc && tests[i].success_on_tc)
> +				ASSERT_GE(bpf_obj->bss->ret, 0, buf);
> +			else
> +				ASSERT_EQ(bpf_obj->bss->ret, tests[i].ret, buf);


