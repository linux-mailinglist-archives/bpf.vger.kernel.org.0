Return-Path: <bpf+bounces-12386-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC0E7CBA64
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 07:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50E17B21163
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 05:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EBDDC2D3;
	Tue, 17 Oct 2023 05:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ThmOeqLP"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644AAC2C1
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 05:53:27 +0000 (UTC)
Received: from out-195.mta0.migadu.com (out-195.mta0.migadu.com [IPv6:2001:41d0:1004:224b::c3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3FBE107
	for <bpf@vger.kernel.org>; Mon, 16 Oct 2023 22:53:25 -0700 (PDT)
Message-ID: <9666242b-d899-c428-55bd-14f724cc4ffd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1697522003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gav1QVjqUN4yqflEWQ6On0xLHhhoAVNXR/XTuzPjPWg=;
	b=ThmOeqLPj7ARlMMBukujDXrjMWD8iP5Jthk7FXzYS1d1PDtd8kIPkxlWhMGiCG/e7kQm+g
	Y0iUePPuP2AVtxttNgcudBAXaOujwhSjZv0FXIpMUNUniL43BW8GL9YGS/deBXx64LTkVp
	biJIqSt5iBt9i9D93rW2EJJ5qAW2bIk=
Date: Mon, 16 Oct 2023 22:53:15 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 bpf-next 00/11] bpf: tcp: Add SYN Cookie
 generation/validation SOCK_OPS hooks.
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
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20231013220433.70792-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/13/23 3:04 PM, Kuniyuki Iwashima wrote:
> Under SYN Flood, the TCP stack generates SYN Cookie to remain stateless
> After 3WHS, the proxy restores SYN and forwards it and ACK to the backend
> server.  Our kernel module works at Netfilter input/output hooks and first
> feeds SYN to the TCP stack to initiate 3WHS.  When the module is triggered
> for SYN+ACK, it looks up the corresponding request socket and overwrites
> tcp_rsk(req)->snt_isn with the proxy's cookie.  Then, the module can
> complete 3WHS with the original ACK as is.

Does the current kernel module also use the timestamp bits differently? 
(something like patch 8 and patch 10 trying to do)

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

I cannot reprod the issue. Commented in patch 11.

I only scanned through the high level of the patchset. will take a closer look. 
Thanks.


> 
> [0]: https://netdev.bots.linux.dev/netconf/2023/kuniyuki.pdf


