Return-Path: <bpf+bounces-3803-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 901E8743D43
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 16:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46FF71C20B6A
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 14:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD78F156FD;
	Fri, 30 Jun 2023 14:12:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F31D16400;
	Fri, 30 Jun 2023 14:12:49 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CEC0199;
	Fri, 30 Jun 2023 07:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=xqTUSUVR5co5hEvsqn4eGHORphveEcWdSiP/Xmkeios=; b=SIsDx2hsdjAJr2myGh+rhXmB/v
	cBiDmnfjD51WuL7vFW98cBU1vsH6dAs4jCmIM93rqa8bOLYea3njbuLJDG61S1UKkTMoBjphsiDkj
	RCoGDFJy3YOumQ7BQtq27849RZWVG1JJz4CSXG81ASODXrGtl+xPvBhYTNacHjuGm/xUb2ZfziErR
	L9VIcgd2cTKtOQQtyWdBmP5fZVgRA6TwiKTglqPGkJGiaE5tqOEpZBS2kyf1TiiLRelEmXP4MCsNw
	adykk16ZFq1wTq2qRXC5ahIOxUm313ciJk2iBYxsD1TGCPtvlAc1PTsxuhRZ966OOr9FQq6m8oB+B
	+XwZAjpA==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qFErZ-0001rn-Gf; Fri, 30 Jun 2023 16:12:41 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qFErY-000KwP-Rf; Fri, 30 Jun 2023 16:12:40 +0200
Subject: Re: [PATCH bpf-next v4 1/2] net: bpf: Check SKB ownership against
 full socket.
To: Kui-Feng Lee <thinker.li@gmail.com>, bpf@vger.kernel.org, ast@kernel.org,
 martin.lau@linux.dev, song@kernel.org, kernel-team@meta.com,
 andrii@kernel.org, yhs@fb.com, kpsingh@kernel.org, shuah@kernel.org,
 john.fastabend@gmail.com, sdf@google.com, mykolal@fb.com,
 linux-kselftest@vger.kernel.org, jolsa@kernel.org, haoluo@google.com,
 netdev@vger.kernel.org
Cc: Kui-Feng Lee <kuifeng@meta.com>
References: <20230624014600.576756-1-kuifeng@meta.com>
 <20230624014600.576756-2-kuifeng@meta.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <6b4a9ce3-249a-03c1-df4f-d637d3cc9b7c@iogearbox.net>
Date: Fri, 30 Jun 2023 16:12:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230624014600.576756-2-kuifeng@meta.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26955/Fri Jun 30 09:29:09 2023)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 6/24/23 3:45 AM, Kui-Feng Lee wrote:
> Check SKB ownership of an SKB against full sockets instead of request_sock.
> 
> The filters were called only if an SKB is owned by the sock that the SKB is
> sent out through.  In another words, skb->sk should point to the sock that
> it is sending through its egress.  However, the filters would miss SYN/ACK
> SKBs that they are owned by a request_sock but sent through the listener
> sock, that is the socket listening incoming connections.
> 
> However, the listener socket is also the full socket of the request socket.
> We should use the full socket as the owner socket of an SKB instead.
> 
> What is the ownership check for?
> ====================================
> 
> BPF_CGROUP_RUN_PROG_INET_EGRESS() checked sk == skb->sk to ensure the
> ownership of an SKB. Alexei referred to a mailing list conversation that
> took place a few years ago. [1] In that conversation, Daniel Borkmann
> stated that:
> 
>      Wouldn't that mean however, when you go through stacked devices that
>      you'd run the same eBPF cgroup program for skb->sk multiple times?
> 
> According to what Daniel said, the ownership check mentioned earlier
> presumably prevents multiple calls of egress filters caused by an skb.
> 
> A test that reproduce this scenario shows that the BPF cgroup egress
> programs can be called multiple times for one SKB if this ownership
> check is not there.  So, we can not just remove this check.
> 
> Test Stacked Devices
> =======================
> 
> We use L2TP to build an environment of stacked devices. L2TP (Layer 2
> Tunneling Protocol) is a tunneling protocol used to support virtual private
> networks (VPNs). It relays encapsulated packets; for example in UDP, to its
> peer by using a socket.
> 
> Using L2TP, packets are first sent through the IP stack and should then
> arrive at an L2TP device. The device will expand its SKB header to
> encapsulate the packet. The SKB will be sent back to the IP stack using the
> socket that was made for the L2TP session. After that, the routing process
> will occur once more, but this time for a new destination.
> 
> We changed tools/testing/selftests/net/l2tp.sh to set up a test environment
> using L2TP.  The run_ping() function in l2tp.sh is where the main change
> occurred.
> 
>      run_ping()
>      {
>          local desc="$1"
> 
>          sleep 10
>          run_cmd host-1 ${ping6} -s 227 -c 4 -i 10 -I fc00:101::1
>          fc00:101::2
>          log_test $? 0 "IPv6 route through L2TP tunnel ${desc}"
>          sleep 10
> 
>      }
> 
> The test will use L2TP devices to send PING messages. These messages will
> have a message size of 227 bytes as a special label to distinguish them.
> This is not an ideal solution, but works.
> 
> During the execution of the test script, bpftrace was attached to
> ip6_finish_output() and l2tp_xmit_skb(). BPF
> 
>      bpftrace -e '
>        kfunc:ip6_finish_output {
>          time("%H:%M:%S: ");
>          printf("ip6_finish_output skb=%p skb->len=%d cgroup=%p sk=%p
>                  skb->sk=%p\n", args->skb, args->skb->len,
>                 args->sk->sk_cgrp_data.cgroup, args->sk, args->skb->sk); }
>        kfunc:l2tp_xmit_skb {
>          time("%H:%M:%S: ");
>          printf("l2tp_xmit_skb skb=%p sk=%p\n", args->skb,
> 	       args->session->tunnel->sock); }'
> 
> The following is part of the output messages printed by bpftrace.
> 
>      16:35:20: ip6_finish_output skb=0xffff888103d8e600 skb->len=275
>                cgroup=0xffff88810741f800 sk=0xffff888105f3b900
>                skb->sk=0xffff888105f3b900
> 
>      16:35:20: l2tp_xmit_skb skb=0xffff888103d8e600 sk=0xffff888103dd6300
> 
>      16:35:20: ip6_finish_output skb=0xffff888103d8e600 skb->len=337
>                cgroup=0xffff88810741f800 sk=0xffff888103dd6300
>                skb->sk=0xffff888105f3b900
> 
>      16:35:20: ip6_finish_output skb=0xffff888103d8e600 skb->len=337
>                cgroup=(nil) sk=(nil) skb->sk=(nil)
> 
>      16:35:20: ip6_finish_output skb=0xffff888103d8e000 skb->len=275
>                cgroup=0xffffffff837741d0 sk=0xffff888101fe0000
>                skb->sk=0xffff888101fe0000
> 
>      16:35:20: l2tp_xmit_skb skb=0xffff888103d8e000 sk=0xffff888103483180
> 
>      16:35:20: ip6_finish_output skb=0xffff888103d8e000 skb->len=337
>                cgroup=0xffff88810741f800 sk=0xffff888103483180
>                skb->sk=0xffff888101fe0000
> 
>      16:35:20: ip6_finish_output skb=0xffff888103d8e000 skb->len=337
>                cgroup=(nil) sk=(nil) skb->sk=(nil)
> 
> The first four entries describe a PING message that was sent using the ping
> command, whereas the following four entries describe the response received.
> Multiple sockets are used to send one skb, including the socket used by the
> L2TP session. This can be observed.
> 
> Based on this information, it seems that the ownership check is designed to
> avoid multiple calls of egress filters caused by a single skb.

Thanks for this investigation and adding these details to the commit log,
this is very useful to keep for the archive. I did some minor formatting
and pushed it out to bpf-next.

