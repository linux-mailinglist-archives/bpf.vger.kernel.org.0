Return-Path: <bpf+bounces-12290-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A067CA8CE
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 15:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5EC51C20B11
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 13:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F7D27725;
	Mon, 16 Oct 2023 13:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="daGl9owa"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC7520B22;
	Mon, 16 Oct 2023 13:05:44 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E50A2;
	Mon, 16 Oct 2023 06:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=jk87Z9G5kk27ySxNjcyJeHPOT/DN888+nmzgX3iZ9tk=; b=daGl9owagA2pILDaXsPx1ieG4D
	9tnaqJU9QyeLGQAayi8z3+kaObKTQV1KQNAl5OM+f1V/ID95B5EseNnsnOCF/gWdCi0uvUQPDqKv2
	vS8W/OzTWPgIHZEK0pcrcjWYU69+fQt2ESHdCyxY9Le7YsGF9xTIc7VfAoiFCAZD9PA4lA4CRvRRG
	2EH3viv7wtghsYUXdZrzl8zXZwoqJUPkap55SBn+nbNbKh/IMOwipTAaa/EYZteMIHE/ghX/1VQkb
	PbF71vg2bB7A/gClYjwbmyBQxtVJgs5R8gvORk1h8Q4xtEA6rlb9lq/mWCZCARuup8Y8wgRSKqdtg
	AkmdO6Aw==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qsNHi-000GY1-Lz; Mon, 16 Oct 2023 15:05:26 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qsNHh-000OO0-VE; Mon, 16 Oct 2023 15:05:25 +0200
Subject: Re: [PATCH v1 bpf-next 00/11] bpf: tcp: Add SYN Cookie
 generation/validation SOCK_OPS hooks.
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 David Ahern <dsahern@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org
References: <20231013220433.70792-1-kuniyu@amazon.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <0611984e-aea2-7eb5-af3e-e0635ca3b7ba@iogearbox.net>
Date: Mon, 16 Oct 2023 15:05:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231013220433.70792-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27063/Mon Oct 16 10:02:17 2023)
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/14/23 12:04 AM, Kuniyuki Iwashima wrote:
> Under SYN Flood, the TCP stack generates SYN Cookie to remain stateless
> for the connection request until a valid ACK is responded to the SYN+ACK.
> 
> The cookie contains two kinds of host-specific bits, a timestamp and
> secrets, so only can it be validated by the generator.  It means SYN
> Cookie consumes network resources between the client and the server;
> intermediate nodes must remember which nodes to route ACK for the cookie.
> 
> SYN Proxy reduces such unwanted resource allocation by handling 3WHS at
> the edge network.  After SYN Proxy completes 3WHS, it forwards SYN to the
> backend server and completes another 3WHS.  However, since the server's
> ISN differs from the cookie, the proxy must manage the ISN mappings and
> fix up SEQ/ACK numbers in every packet for each connection.  If a proxy
> node is down, all the connections through it are also down.  Keeping a
> state at proxy is painful from that perspective.
> 
> At AWS, we use a dirty hack to build truly stateless SYN Proxy at scale.
> Our SYN Proxy consists of the front proxy layer and the backend kernel
> module.  (See slides of netconf [0], p6 - p15)
> 
> The cookie that SYN Proxy generates differs from the kernel's cookie in
> that it contains a secret (called rolling salt) (i) shared by all the proxy
> nodes so that any node can validate ACK and (ii) updated periodically so
> that old cookies cannot be validated.  Also, ISN contains WScale, SACK, and
> ECN, not in TS val.  This is not to sacrifice any connection quality, where
> some customers turn off the timestamp option due to retro CVE.
> 
> After 3WHS, the proxy restores SYN and forwards it and ACK to the backend
> server.  Our kernel module works at Netfilter input/output hooks and first
> feeds SYN to the TCP stack to initiate 3WHS.  When the module is triggered
> for SYN+ACK, it looks up the corresponding request socket and overwrites
> tcp_rsk(req)->snt_isn with the proxy's cookie.  Then, the module can
> complete 3WHS with the original ACK as is.
> 
> This way, our SYN Proxy does not manage the ISN mappings and can stay
> stateless.  It's working very well for high-bandwidth services like
> multiple Tbps, but we are looking for a way to drop the dirty hack and
> further optimise the sequences.
> 
> If we could validate an arbitrary SYN Cookie on the backend server with
> BPF, the proxy would need not restore SYN nor pass it.  After validating
> ACK, the proxy node just needs to forward it, and then the server can do
> the lightweight validation (e.g. check if ACK came from proxy nodes, etc)
> and create a connection from the ACK.
> 
> This series adds two SOCK_OPS hooks to generate and validate arbitrary
> SYN Cookie.  Each hook is invoked if BPF_SOCK_OPS_SYNCOOKIE_CB_FLAG is
> set to the listening socket in advance by bpf_sock_ops_cb_flags_set().
> 
> The user interface looks like this:
> 
>    BPF_SOCK_OPS_GEN_SYNCOOKIE_CB
> 
>      input
>      |- bpf_sock_ops.sk           : 4-tuple
>      |- bpf_sock_ops.skb          : TCP header
>      |- bpf_sock_ops.args[0]      : MSS
>      `- bpf_sock_ops.args[1]      : BPF_SYNCOOKIE_XXX flags
> 
>      output
>      |- bpf_sock_ops.replylong[0] : ISN (SYN Cookie) ------.
>      `- bpf_sock_ops.replylong[1] : TS value -----------.  |
>                                                         |  |
>    BPF_SOCK_OPS_CHECK_SYNCOOKIE_CB                      |  |
>                                                         |  |
>      input                                              |  |
>      |- bpf_sock_ops.sk           : 4-tuple             |  |
>      |- bpf_sock_ops.skb          : TCP header          |  |
>      |- bpf_sock_ops.args[0]      : ISN (SYN Cookie) <-----'
>      `- bpf_sock_ops.args[1]      : TS value <----------'
> 
>      output
>      |- bpf_sock_ops.replylong[0] : MSS
>      `- bpf_sock_ops.replylong[1] : BPF_SYNCOOKIE_XXX flags
> 
> To establish a connection from SYN Cookie, BPF_SOCK_OPS_CHECK_SYNCOOKIE_CB
> hook must set a valid MSS to bpf_sock_ops.replylong[0], meaning that
> BPF_SOCK_OPS_GEN_SYNCOOKIE_CB hook must encode MSS to ISN or TS val to be
> restored in the validation hook.
> 
> If WScale, SACK, and ECN are detected to be available in SYN packet, the
> corresponding flags are passed to args[0] of BPF_SOCK_OPS_GEN_SYNCOOKIE_CB
> so that bpf prog need not parse the TCP header.  The same flags can be set
> to replylong[0] of BPF_SOCK_OPS_CHECK_SYNCOOKIE_CB to enable each feature
> on the connection.
> 
> For details, please see each patch.  Here's an overview:
> 
>    patch 1 - 4 : Misc cleanup
>    patch 5, 6  : Add SOCK_OPS hook (only ISN is available here)
>    patch 7, 8  : Make TS val available as the second cookie storage
>    patch 9, 10 : Make WScale, SACK, and ECN configurable from ACK
>    patch 11    : selftest, need some help from BPF experts...
> 
> [0]: https://netdev.bots.linux.dev/netconf/2023/kuniyuki.pdf

Fyi, just as quick feedback, this fails BPF CI selftests :

https://github.com/kernel-patches/bpf/actions/runs/6513838231/job/17694669376

Notice: Success: 427/3396, Skipped: 24, Failed: 1
Error: #274 tcpbpf_user
   Error: #274 tcpbpf_user
   test_tcpbpf_user:PASS:open and load skel 0 nsec
   test_tcpbpf_user:PASS:test__join_cgroup(/tcpbpf-user-test) 0 nsec
   test_tcpbpf_user:PASS:attach_cgroup(bpf_testcb) 0 nsec
   run_test:PASS:start_server 0 nsec
   run_test:PASS:connect_to_fd(listen_fd) 0 nsec
   run_test:PASS:accept(listen_fd) 0 nsec
   run_test:PASS:send(cli_fd) 0 nsec
   run_test:PASS:recv(accept_fd) 0 nsec
   run_test:PASS:send(accept_fd) 0 nsec
   run_test:PASS:recv(cli_fd) 0 nsec
   run_test:PASS:recv(cli_fd) for fin 0 nsec
   run_test:PASS:recv(accept_fd) for fin 0 nsec
   verify_result:PASS:event_map 0 nsec
   verify_result:PASS:bytes_received 0 nsec
   verify_result:PASS:bytes_acked 0 nsec
   verify_result:PASS:data_segs_in 0 nsec
   verify_result:PASS:data_segs_out 0 nsec
   verify_result:FAIL:bad_cb_test_rv unexpected bad_cb_test_rv: actual 0 != expected 128
   verify_result:PASS:good_cb_test_rv 0 nsec
   verify_result:PASS:num_listen 0 nsec
   verify_result:PASS:num_close_events 0 nsec
   verify_result:PASS:tcp_save_syn 0 nsec
   verify_result:PASS:tcp_saved_syn 0 nsec
   verify_result:PASS:window_clamp_client 0 nsec
   verify_result:PASS:window_clamp_server 0 nsec

