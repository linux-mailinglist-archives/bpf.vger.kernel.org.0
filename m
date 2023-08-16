Return-Path: <bpf+bounces-7900-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F4D777E38B
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 16:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90FCA1C2107C
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 14:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FD4125D2;
	Wed, 16 Aug 2023 14:27:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A929111A4;
	Wed, 16 Aug 2023 14:27:21 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CC72705;
	Wed, 16 Aug 2023 07:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=12sOJIm+x6ia2Tol/RQD3pz06O8YQaOp4XAGIcYNGak=; b=MyKeOwO48f7aS0xKZYq2oCE+XL
	O3p7bUIx8p1CkTKg72k5dzwt6hCMwQzY8UeEIfAGFp2uOQF9uiIGHwy6qFaRwBO6ktGkV6HjRWG+F
	XXJMZfxo0RqVLpBFJ5rUdSctbOshpvw/OjkqTdONTBp6uz8mb3aioSQXOIW+XR1thxttIAO74qOPv
	0AJd4k62UObsQCUKq64TWyCOGJaCDISEQ6HHRBeAjxYdLBlFpNf6A/kL6ZMNr3J7uILL9kAIRnOPW
	wo0RZ8nzWDIrdBh4Ks6EyYnpPsukH2bxkSgymFQbua8+CewhucqAB32vtTE/eBoOOVHE6U2iOBL/w
	1g1lqsJw==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qWHUS-000JaR-K5; Wed, 16 Aug 2023 16:27:16 +0200
Received: from [85.1.206.226] (helo=pc-102.home)
	by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qWHUR-000Vt1-8R; Wed, 16 Aug 2023 16:27:15 +0200
Subject: Re: [PATCH v5 bpf 0/4] lwt: fix return values of BPF ops
To: Yan Zhai <yan@cloudflare.com>, bpf@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
 Thomas Graf <tgraf@suug.ch>, Jordan Griege <jgriege@cloudflare.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 stable@vger.kernel.org
References: <cover.1692153515.git.yan@cloudflare.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <9ac9d459-9bc3-bcee-b912-3ab66d2a7fe7@iogearbox.net>
Date: Wed, 16 Aug 2023 16:27:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <cover.1692153515.git.yan@cloudflare.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/27002/Wed Aug 16 09:38:26 2023)
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Yan,

On 8/16/23 4:54 AM, Yan Zhai wrote:
> lwt xmit hook does not expect positive return values in function
> ip_finish_output2 and ip6_finish_output. However, BPF programs can
> directly return positive statuses such like NET_XMIT_DROP, NET_RX_DROP,
> and etc to the caller. Such return values would make the kernel continue
> processing already freed skbs and eventually panic.
> 
> This set fixes the return values from BPF ops to unexpected continue
> processing, and checks strictly on the correct continue condition for
> future proof. In addition, add missing selftests for BPF_REDIRECT
> and BPF_REROUTE cases for BPF-CI.
> 
> v4: https://lore.kernel.org/bpf/ZMD1sFTW8SFiex+x@debian.debian/T/
> v3: https://lore.kernel.org/bpf/cover.1690255889.git.yan@cloudflare.com/
> v2: https://lore.kernel.org/netdev/ZLdY6JkWRccunvu0@debian.debian/
> v1: https://lore.kernel.org/bpf/ZLbYdpWC8zt9EJtq@debian.debian/
> 
> changes since v4:
>   * fixed same error on BPF_REROUTE path
>   * re-implemented selftests under BPF-CI requirement

BPF CI failed: https://github.com/kernel-patches/bpf/actions/runs/5874202507/job/15929012788

Looks like due to dummy device issue. Either you might need to add this to
the tools/testing/selftests/bpf/config* or perhaps just use veth instead for
link_err dev.

Error from the above link:

Notice: Success: 370/3177, Skipped: 21, Failed: 2
Error: #131 lwt_redirect
   Error: #131 lwt_redirect
   test_lwt_redirect:PASS:pthread_create 0 nsec
Error: #131/1 lwt_redirect/lwt_redirect_normal
   Error: #131/1 lwt_redirect/lwt_redirect_normal
   test_lwt_redirect_run:PASS:netns_create 0 nsec
   open_netns:PASS:malloc token 0 nsec
   open_netns:PASS:open /proc/self/ns/net 0 nsec
   open_netns:PASS:open netns fd 0 nsec
   open_netns:PASS:setns 0 nsec
   test_lwt_redirect_run:PASS:setns 0 nsec
   open_tuntap:PASS:open(/dev/net/tun) 0 nsec
   open_tuntap:PASS:ioctl(TUNSETIFF) 0 nsec
   open_tuntap:PASS:fcntl(O_NONBLOCK) 0 nsec
   setup_redirect_target:PASS:open_tuntap 0 nsec
   setup_redirect_target:PASS:if_nametoindex 0 nsec
   setup_redirect_target:FAIL:ip link add link_err type dummy unexpected error: 512 (errno 0)
   test_lwt_redirect_normal:FAIL:setup_redirect_target unexpected setup_redirect_target: actual -1 < expected 0
   close_netns:PASS:setns 0 nsec
Error: #131/2 lwt_redirect/lwt_redirect_normal_nomac
   Error: #131/2 lwt_redirect/lwt_redirect_normal_nomac
   test_lwt_redirect_run:PASS:netns_create 0 nsec
   open_netns:PASS:malloc token 0 nsec
   open_netns:PASS:open /proc/self/ns/net 0 nsec
   open_netns:PASS:open netns fd 0 nsec
   open_netns:PASS:setns 0 nsec
   test_lwt_redirect_run:PASS:setns 0 nsec
   open_tuntap:PASS:open(/dev/net/tun) 0 nsec
   open_tuntap:PASS:ioctl(TUNSETIFF) 0 nsec
   open_tuntap:PASS:fcntl(O_NONBLOCK) 0 nsec
   setup_redirect_target:PASS:open_tuntap 0 nsec
   setup_redirect_target:PASS:if_nametoindex 0 nsec
   setup_redirect_target:FAIL:ip link add link_err type dummy unexpected error: 512 (errno 0)
   test_lwt_redirect_normal_nomac:FAIL:setup_redirect_target unexpected setup_redirect_target: actual -1 < expected 0
   close_netns:PASS:setns 0 nsec
Error: #131/3 lwt_redirect/lwt_redirect_dev_down
   Error: #131/3 lwt_redirect/lwt_redirect_dev_down
   test_lwt_redirect_run:PASS:netns_create 0 nsec
   open_netns:PASS:malloc token 0 nsec
   open_netns:PASS:open /proc/self/ns/net 0 nsec
   open_netns:PASS:open netns fd 0 nsec
   open_netns:PASS:setns 0 nsec
   test_lwt_redirect_run:PASS:setns 0 nsec
   open_tuntap:PASS:open(/dev/net/tun) 0 nsec
   open_tuntap:PASS:ioctl(TUNSETIFF) 0 nsec
   open_tuntap:PASS:fcntl(O_NONBLOCK) 0 nsec
   setup_redirect_target:PASS:open_tuntap 0 nsec
   setup_redirect_target:PASS:if_nametoindex 0 nsec
   setup_redirect_target:FAIL:ip link add link_err type dummy unexpected error: 512 (errno 0)
   __test_lwt_redirect_dev_down:FAIL:setup_redirect_target unexpected setup_redirect_target: actual -1 < expected 0
   close_netns:PASS:setns 0 nsec
Error: #131/4 lwt_redirect/lwt_redirect_dev_down_nomac
   Error: #131/4 lwt_redirect/lwt_redirect_dev_down_nomac
   test_lwt_redirect_run:PASS:netns_create 0 nsec
   open_netns:PASS:malloc token 0 nsec
   open_netns:PASS:open /proc/self/ns/net 0 nsec
   open_netns:PASS:open netns fd 0 nsec
   open_netns:PASS:setns 0 nsec
   test_lwt_redirect_run:PASS:setns 0 nsec
   open_tuntap:PASS:open(/dev/net/tun) 0 nsec
   open_tuntap:PASS:ioctl(TUNSETIFF) 0 nsec
   open_tuntap:PASS:fcntl(O_NONBLOCK) 0 nsec
   setup_redirect_target:PASS:open_tuntap 0 nsec
   setup_redirect_target:PASS:if_nametoindex 0 nsec
   setup_redirect_target:FAIL:ip link add link_err type dummy unexpected error: 512 (errno 0)
   __test_lwt_redirect_dev_down:FAIL:setup_redirect_target unexpected setup_redirect_target: actual -1 < expected 0
   close_netns:PASS:setns 0 nsec
Error: #131/5 lwt_redirect/lwt_redirect_dev_carrier_down
   Error: #131/5 lwt_redirect/lwt_redirect_dev_carrier_down
   test_lwt_redirect_run:PASS:netns_create 0 nsec
   open_netns:PASS:malloc token 0 nsec
   open_netns:PASS:open /proc/self/ns/net 0 nsec
   open_netns:PASS:open netns fd 0 nsec
   open_netns:PASS:setns 0 nsec
   test_lwt_redirect_run:PASS:setns 0 nsec
   open_tuntap:PASS:open(/dev/net/tun) 0 nsec
   open_tuntap:PASS:ioctl(TUNSETIFF) 0 nsec
   open_tuntap:PASS:fcntl(O_NONBLOCK) 0 nsec
   setup_redirect_target:PASS:open_tuntap 0 nsec
   setup_redirect_target:PASS:if_nametoindex 0 nsec
   setup_redirect_target:FAIL:ip link add link_err type dummy unexpected error: 512 (errno 0)
   test_lwt_redirect_dev_carrier_down:FAIL:setup_redirect_target unexpected setup_redirect_target: actual -1 < expected 0
   close_netns:PASS:setns 0 nsec
   test_lwt_redirect:PASS:pthread_join 0 nsec
Error: #132 lwt_reroute
   Error: #132 lwt_reroute
   test_lwt_reroute:PASS:pthread_create 0 nsec
Error: #132/1 lwt_reroute/lwt_reroute_normal_xmit
   Error: #132/1 lwt_reroute/lwt_reroute_normal_xmit
   test_lwt_reroute_run:PASS:netns_create 0 nsec
   open_netns:PASS:malloc token 0 nsec
   open_netns:PASS:open /proc/self/ns/net 0 nsec
   open_netns:PASS:open netns fd 0 nsec
   open_netns:PASS:setns 0 nsec
   test_lwt_reroute_run:PASS:setns 0 nsec
   open_tuntap:PASS:open(/dev/net/tun) 0 nsec
   open_tuntap:PASS:ioctl(TUNSETIFF) 0 nsec
   open_tuntap:PASS:fcntl(O_NONBLOCK) 0 nsec
   setup:PASS:open_tun 0 nsec
   setup:PASS:if_nametoindex 0 nsec
   setup:FAIL:ip link add link_err type dummy unexpected error: 512 (errno 0)
   test_lwt_reroute_normal_xmit:FAIL:setup_reroute unexpected setup_reroute: actual -1 < expected 0
   close_netns:PASS:setns 0 nsec
Error: #132/2 lwt_reroute/lwt_reroute_qdisc_dropped
   Error: #132/2 lwt_reroute/lwt_reroute_qdisc_dropped
   test_lwt_reroute_run:PASS:netns_create 0 nsec
   open_netns:PASS:malloc token 0 nsec
   open_netns:PASS:open /proc/self/ns/net 0 nsec
   open_netns:PASS:open netns fd 0 nsec
   open_netns:PASS:setns 0 nsec
   test_lwt_reroute_run:PASS:setns 0 nsec
   open_tuntap:PASS:open(/dev/net/tun) 0 nsec
   open_tuntap:PASS:ioctl(TUNSETIFF) 0 nsec
   open_tuntap:PASS:fcntl(O_NONBLOCK) 0 nsec
   setup:PASS:open_tun 0 nsec
   setup:PASS:if_nametoindex 0 nsec
   setup:FAIL:ip link add link_err type dummy unexpected error: 512 (errno 0)
   test_lwt_reroute_qdisc_dropped:FAIL:setup_reroute unexpected setup_reroute: actual -1 < expected 0
   close_netns:PASS:setns 0 nsec
   test_lwt_reroute:PASS:pthread_join 0 nsec
Test Results:
              bpftool: PASS
           test_progs: FAIL (returned 1)
             shutdown: CLEAN
Error: Process completed with exit code 1.

Thanks,
Daniel

