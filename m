Return-Path: <bpf+bounces-16294-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BF77FF912
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 19:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1E792817DD
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 18:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346A7584EF;
	Thu, 30 Nov 2023 18:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="h7EerN8f";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CE3/bb8J"
X-Original-To: bpf@vger.kernel.org
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5A710FA;
	Thu, 30 Nov 2023 10:08:32 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 5D7ED5C0322;
	Thu, 30 Nov 2023 13:08:32 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 30 Nov 2023 13:08:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1701367712; x=1701454112; bh=9z
	3uJU+Hi5KH4UzL0oER4ME1Qi2Yb8XEo51IkVsy0gY=; b=h7EerN8faAB17E4ILq
	ZIZVbEY7zPwMtiNqL2KIdPC9eagTZEgzm1MtW6RiyDbu0Jt6tJz5v4Vqt67JQWJm
	FHsW1qP2+rm009mZs+fYUm3BlLQMPt2Ceb1oPyxSY3/XIlGLa8SHIq66GUmZ4VyG
	/NkkkdrOqbYrixunq0lkNLiTJfgEn+gvy0kLZHD7iNi5orSWrqifnbqphAIW2r8f
	fet5UVQcjA1AMlIDRK8Y/VYBxiggVSU12MmEYKU/cpL1pgj1BTuXl9dBwD2ma/su
	c6PG6TGY6/Xl6us3bidZOo6H7Ygsf8BFywiDb7ph9aFSAMqQYu2c9aH77Hhvq0k/
	djZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701367712; x=1701454112; bh=9z3uJU+Hi5KH4
	UzL0oER4ME1Qi2Yb8XEo51IkVsy0gY=; b=CE3/bb8JRXoF06z43ggo3eodWcMzd
	HlX0VKnvWJUESTOkKajLpoJEdjGIwQcEsJQKThxKQpl0gHBzQyz15UPlACHC1p1n
	fnPWnEVuPnnMGxegaTxPY+au30ACoNvhWldsZ9llrpIYtfba9oHCg8P7RW/e0KrW
	nkzI6lOD4YCijiDqn8PYMR/MDv0IZ7CPAm6vmY3+dnhlj5hNnh85hjLUXKovwh6Z
	oz6IHw4yciXKz0CrDIYArk/Y/8t9Mj9dM9DVNIWpgR5MLbwxRjJBBg7abrMbvDhr
	Py+QtrCTxChTcxWRScpgBFR8clfSd24QwSL+wICnAafFY1wvVH2gPO4DA==
X-ME-Sender: <xms:ns9oZQDrZkfxa-EWqNR_fOBJJ4_NcKpy3YKWyvXSTvnLHBw344-DqA>
    <xme:ns9oZSgr6sn6oBVKWs0MYPJgfbIIlzjxAskQW8g7RiA9j1-QwH6s5zNtcS8oNwjkr
    sEgYkSRDbsLzWqSew>
X-ME-Received: <xmr:ns9oZTmousuvPPHhp9ehWOMKyGbm6kFD-HSwgIWRk5n0j-Zy4JTHE2QETyn7gpam0_WN-Uf7Eiq-GIW1gJ8ciwRNGisP5OEyfV9zZYM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeijedguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdefhedmnecujfgurhepff
    fhvfevuffkfhggtggujgesthdtsfdttddtvdenucfhrhhomhepffgrnhhivghlucgiuhcu
    oegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpeefffeffefhtdefgf
    fgleevueekgfeltdefleevgffhjeefveekkeejhfdtveevudenucffohhmrghinhepqhgv
    mhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:ns9oZWxCDDmnepTWR5WAfJtsI6hXfhvlcxyNzyoNfYhSCaQqdO_ttQ>
    <xmx:ns9oZVQUuW0okS6jqNtfyZ77RtufopI2FB1atZOClv_Cl---yILM-Q>
    <xmx:ns9oZRa8ZxbHz2m3kTSF2ubUUmEeqcnjw1QnCxQ4fxtmDiflX8jEKA>
    <xmx:oM9oZULs-FkcSj14zxnBm7rJr3LzNRgrpCsiDkMOXqNgifNGqQcRHA>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Nov 2023 13:08:29 -0500 (EST)
Date: Thu, 30 Nov 2023 11:08:28 -0700
From: Daniel Xu <dxu@dxuuu.xyz>
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	coreteam@netfilter.org, netfilter-devel@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org
Subject: Re: [PATCH net] net/netfilter: bpf: fix bad registration on nf_defrag
Message-ID: <jyuh3mrw2x4ev53trb7spctljr62fyrjqpgkgbh7ng4tfhimxm@kalweu7l5gbk>
References: <1701329003-14564-1-git-send-email-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1701329003-14564-1-git-send-email-alibuda@linux.alibaba.com>

On Thu, Nov 30, 2023 at 03:23:23PM +0800, D. Wythe wrote:
> From: "D. Wythe" <alibuda@linux.alibaba.com>
> 
> We should pass a pointer to global_hook to the get_proto_defrag_hook()
> instead of its value, since the passed value won't be updated even if
> the request module was loaded successfully.
> 
> Log:
> 
> [   54.915713] nf_defrag_ipv4 has bad registration

Gah, I really thought I had tested this codepath.

> [   54.915779] WARNING: CPU: 3 PID: 6323 at net/netfilter/nf_bpf_link.c:62 get_proto_defrag_hook+0x137/0x160
> [   54.915835] CPU: 3 PID: 6323 Comm: fentry Kdump: loaded Tainted: G            E      6.7.0-rc2+ #35
> [   54.915839] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.15.0-0-g2dd4b9b3f840-prebuilt.qemu.org 04/01/2014
> [   54.915841] RIP: 0010:get_proto_defrag_hook+0x137/0x160
> [   54.915844] Code: 4f 8c e8 2c cf 68 ff 80 3d db 83 9a 01 00 0f 85 74 ff ff ff 48 89 ee 48 c7 c7 8f 12 4f 8c c6 05 c4 83 9a 01 01 e8 09 ee 5f ff <0f> 0b e9 57 ff ff ff 49 8b 3c 24 4c 63 e5 e8 36 28 6c ff 4c 89 e0
> [   54.915849] RSP: 0018:ffffb676003fbdb0 EFLAGS: 00010286
> [   54.915852] RAX: 0000000000000023 RBX: ffff9596503d5600 RCX: ffff95996fce08c8
> [   54.915854] RDX: 00000000ffffffd8 RSI: 0000000000000027 RDI: ffff95996fce08c0
> [   54.915855] RBP: ffffffff8c4f12de R08: 0000000000000000 R09: 00000000fffeffff
> [   54.915859] R10: ffffb676003fbc70 R11: ffffffff8d363ae8 R12: 0000000000000000
> [   54.915861] R13: ffffffff8e1f75c0 R14: ffffb676003c9000 R15: 00007ffd15e78ef0
> [   54.915864] FS:  00007fb6e9cab740(0000) GS:ffff95996fcc0000(0000) knlGS:0000000000000000
> [   54.915867] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   54.915868] CR2: 00007ffd15e75c40 CR3: 0000000101e62006 CR4: 0000000000360ef0
> [   54.915870] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   54.915871] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [   54.915873] Call Trace:
> [   54.915891]  <TASK>
> [   54.915894]  ? __warn+0x84/0x140
> [   54.915905]  ? get_proto_defrag_hook+0x137/0x160
> [   54.915908]  ? __report_bug+0xea/0x100
> [   54.915925]  ? report_bug+0x2b/0x80
> [   54.915928]  ? handle_bug+0x3c/0x70
> [   54.915939]  ? exc_invalid_op+0x18/0x70
> [   54.915942]  ? asm_exc_invalid_op+0x1a/0x20
> [   54.915948]  ? get_proto_defrag_hook+0x137/0x160
> [   54.915950]  bpf_nf_link_attach+0x1eb/0x240
> [   54.915953]  link_create+0x173/0x290
> [   54.915969]  __sys_bpf+0x588/0x8f0
> [   54.915974]  __x64_sys_bpf+0x20/0x30
> [   54.915977]  do_syscall_64+0x45/0xf0
> [   54.915989]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
> [   54.915998] RIP: 0033:0x7fb6e9daa51d
> [   54.916001] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 2b 89 0c 00 f7 d8 64 89 01 48
> [   54.916003] RSP: 002b:00007ffd15e78ed8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
> [   54.916006] RAX: ffffffffffffffda RBX: 00007ffd15e78fc0 RCX: 00007fb6e9daa51d
> [   54.916007] RDX: 0000000000000040 RSI: 00007ffd15e78ef0 RDI: 000000000000001c
> [   54.916009] RBP: 000000000000002d R08: 00007fb6e9e73a60 R09: 0000000000000001
> [   54.916010] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000006
> [   54.916012] R13: 0000000000000006 R14: 0000000000000000 R15: 0000000000000000
> [   54.916014]  </TASK>
> [   54.916015] ---[ end trace 0000000000000000 ]---
> 
> Fixes: 91721c2d02d3 ("netfilter: bpf: Support BPF_F_NETFILTER_IP_DEFRAG in netfilter link")
> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
> ---
>  net/netfilter/nf_bpf_link.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/net/netfilter/nf_bpf_link.c b/net/netfilter/nf_bpf_link.c
> index e502ec0..0e4beae 100644
> --- a/net/netfilter/nf_bpf_link.c
> +++ b/net/netfilter/nf_bpf_link.c
> @@ -31,7 +31,7 @@ struct bpf_nf_link {
>  #if IS_ENABLED(CONFIG_NF_DEFRAG_IPV4) || IS_ENABLED(CONFIG_NF_DEFRAG_IPV6)
>  static const struct nf_defrag_hook *
>  get_proto_defrag_hook(struct bpf_nf_link *link,
> -		      const struct nf_defrag_hook __rcu *global_hook,
> +		      const struct nf_defrag_hook __rcu **ptr_global_hook,
>  		      const char *mod)
>  {
>  	const struct nf_defrag_hook *hook;
> @@ -39,7 +39,7 @@ struct bpf_nf_link {
>  
>  	/* RCU protects us from races against module unloading */
>  	rcu_read_lock();
> -	hook = rcu_dereference(global_hook);
> +	hook = rcu_dereference(*ptr_global_hook);
>  	if (!hook) {
>  		rcu_read_unlock();
>  		err = request_module(mod);
> @@ -47,7 +47,7 @@ struct bpf_nf_link {
>  			return ERR_PTR(err < 0 ? err : -EINVAL);
>  
>  		rcu_read_lock();
> -		hook = rcu_dereference(global_hook);
> +		hook = rcu_dereference(*ptr_global_hook);
>  	}
>  
>  	if (hook && try_module_get(hook->owner)) {
> @@ -78,7 +78,7 @@ static int bpf_nf_enable_defrag(struct bpf_nf_link *link)
>  	switch (link->hook_ops.pf) {
>  #if IS_ENABLED(CONFIG_NF_DEFRAG_IPV4)
>  	case NFPROTO_IPV4:
> -		hook = get_proto_defrag_hook(link, nf_defrag_v4_hook, "nf_defrag_ipv4");
> +		hook = get_proto_defrag_hook(link, &nf_defrag_v4_hook, "nf_defrag_ipv4");
>  		if (IS_ERR(hook))
>  			return PTR_ERR(hook);
>  
> @@ -87,7 +87,7 @@ static int bpf_nf_enable_defrag(struct bpf_nf_link *link)
>  #endif
>  #if IS_ENABLED(CONFIG_NF_DEFRAG_IPV6)
>  	case NFPROTO_IPV6:
> -		hook = get_proto_defrag_hook(link, nf_defrag_v6_hook, "nf_defrag_ipv6");
> +		hook = get_proto_defrag_hook(link, &nf_defrag_v6_hook, "nf_defrag_ipv6");
>  		if (IS_ERR(hook))
>  			return PTR_ERR(hook);
>  
> -- 
> 1.8.3.1
> 

I think I've convinced myself this is right.

Acked-by: Daniel Xu <dxu@dxuuu.xyz>

