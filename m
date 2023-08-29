Return-Path: <bpf+bounces-8925-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E324478C98F
	for <lists+bpf@lfdr.de>; Tue, 29 Aug 2023 18:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2076E1C20A42
	for <lists+bpf@lfdr.de>; Tue, 29 Aug 2023 16:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F212A17FFD;
	Tue, 29 Aug 2023 16:22:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9A814F6D;
	Tue, 29 Aug 2023 16:22:51 +0000 (UTC)
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 280661A6;
	Tue, 29 Aug 2023 09:22:50 -0700 (PDT)
Received: from [192.168.100.7] (unknown [39.34.186.40])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 139646607236;
	Tue, 29 Aug 2023 17:22:43 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1693326168;
	bh=Xq5jz8HdbMocWJzAMFiYi0flLRLw9RkQ3+TdhDp1Xw8=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=HElLb0ShqTSds9x9QyH3BVnv+nr4AQ4MOkSwM6NSfBWfdjpzHFOfKzkJ8uP/Bolqp
	 ARo7CWT0BYhlVSN3usf9qHWiWDmMj2DceMvMJp8MmJwe3CDXiK1nP8QMIWdD0Y6NMf
	 Gz+umklaNPL4c3TRkb//MlKr0iVKHM4CLocNndnWceAF3uUnc1NxMabmN2nU14LOyR
	 QCD/cCfFQbHfEX9NJyNx9e4Kq3V6zpWdnZpKJYrihnF+7UYrIQ+2tPq3mLd4/WHbNA
	 bEtbqM72dzMi7j5XgEUDE0CJlc9QRSGJiYS4kPIB3JZmKbQWvxTK/i7+MgWvyPROfd
	 Vu63Kk42IIUDQ==
Message-ID: <ef489936-9413-4a01-a3f0-eebadfb64ff9@collabora.com>
Date: Tue, 29 Aug 2023 21:22:39 +0500
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 syzbot <syzbot+de6565462ab540f50e47@syzkaller.appspotmail.com>,
 bpf@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
 jacob.e.keller@intel.com, jiri@nvidia.com, kuba@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 syzkaller-bugs@googlegroups.com, fishgylk@gmail.com, bagasdotme@gmail.com
Subject: Re: [syzbot] [net?] WARNING in inet_sock_destruct (4)
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>
References: <00000000000010353a05fecceea0@google.com>
 <6144228a-799f-4de3-8483-b7add903df0c@collabora.com>
 <CANn89iJiBp9t69Y3htwGGb=pTWhjFQPxKPD1E6uSFks5NrgctA@mail.gmail.com>
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <CANn89iJiBp9t69Y3htwGGb=pTWhjFQPxKPD1E6uSFks5NrgctA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Eric,

On 8/29/23 8:19 PM, Eric Dumazet wrote:
> On Tue, Aug 29, 2023 at 2:44 PM Muhammad Usama Anjum
> <usama.anjum@collabora.com> wrote:
>>
>> On 6/23/23 7:36 PM, syzbot wrote:
>>> Hello,
>>>
>>> syzbot found the following issue on:
>>>
>>> HEAD commit: 45a3e24f65e9 Linux 6.4-rc7
>>> git tree: upstream
>>> console output: https://syzkaller.appspot.com/x/log.txt?x=160cc82f280000
>>> kernel config: https://syzkaller.appspot.com/x/.config?x=2cbd298d0aff1140
>>> dashboard link: https://syzkaller.appspot.com/bug?extid=de6565462ab540f50e47
>>> compiler: gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
>>> syz repro: https://syzkaller.appspot.com/x/repro.syz?x=160aacb7280000
>>> C reproducer: https://syzkaller.appspot.com/x/repro.c?x=17c115d3280000
>>>
>>> Downloadable assets:
>>> disk image: https://storage.googleapis.com/syzbot-assets/c09bcd4ec365/disk-45a3e24f.raw.xz
>>> vmlinux: https://storage.googleapis.com/syzbot-assets/03549b639718/vmlinux-45a3e24f.xz
>>> kernel image: https://storage.googleapis.com/syzbot-assets/91f203e5f63e/bzImage-45a3e24f.xz
>>>
>>> The issue was bisected to:
>>>
>>> commit 565b4824c39fa335cba2028a09d7beb7112f3c9a
>>> Author: Jiri Pirko <jiri@nvidia.com>
>>> Date: Mon Feb 6 09:41:51 2023 +0000
>>>
>>> devlink: change port event netdev notifier from per-net to global
>>>
>>> bisection log: https://syzkaller.appspot.com/x/bisect.txt?x=110a1a5b280000
>>> final oops: https://syzkaller.appspot.com/x/report.txt?x=130a1a5b280000
>>> console output: https://syzkaller.appspot.com/x/log.txt?x=150a1a5b280000
>>>
>>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>>> Reported-by: syzbot+de6565462ab540f50e47@syzkaller.appspotmail.com
>>> Fixes: 565b4824c39f ("devlink: change port event netdev notifier from per-net to global")
>>>
>>> ------------[ cut here ]------------
>>> WARNING: CPU: 0 PID: 5025 at net/ipv4/af_inet.c:154 inet_sock_destruct+0x6df/0x8a0 net/ipv4/af_inet.c:154
>> This same warning has been spotted and reported:
>> https://bugzilla.kernel.org/show_bug.cgi?id=217555
>>
>> Syzbot has found the same warning on 4.14, 5.15, 6.1, 6.5-rc and latest
>> mainline (1c59d383390f9) kernels. The provided reproducers (such as
>> https://syzkaller.appspot.com/text?tag=ReproC&x=15a10e8aa80000) are
>> reproducing the same warnings on multicore (at least 2 CPUs) qemu instance.
> 
> Can you test the following fix ?
Just tested the fix on 1c59d383390f9, it didn't fix the warning.

Please let me know if you need help in testing more.

> Thanks.
> 
> diff --git a/net/dccp/ipv6.c b/net/dccp/ipv6.c
> index 25816e790527dbd6ff55ffb94762b5974e8144aa..1085357b30c9a0d4bf7a578cebf3eeddec953632
> 100644
> --- a/net/dccp/ipv6.c
> +++ b/net/dccp/ipv6.c
> @@ -377,8 +377,13 @@ static int dccp_v6_conn_request(struct sock *sk,
> struct sk_buff *skb)
>         if (ipv6_opt_accepted(sk, skb, IP6CB(skb)) ||
>             np->rxopt.bits.rxinfo || np->rxopt.bits.rxoinfo ||
>             np->rxopt.bits.rxhlim || np->rxopt.bits.rxohlim) {
> +               /* Only initialize ireq->pktops once.
> +                * We must take a refcount on skb because ireq->pktops
> +                * could be consumed immediately.
> +                */
>                 refcount_inc(&skb->users);
> -               ireq->pktopts = skb;
> +               if (cmpxchg(&ireq->pktopts, NULL, skb))
> +                       refcount_dec(&skb->users);
>         }
>         ireq->ir_iif = READ_ONCE(sk->sk_bound_dev_if);
> 
> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> index 6e86721e1cdbb8d47b754a2675f6ab1643c7342c..d45aa267473c4ab817cfda06966a536718b50a53
> 100644
> --- a/net/ipv6/tcp_ipv6.c
> +++ b/net/ipv6/tcp_ipv6.c
> @@ -798,8 +798,13 @@ static void tcp_v6_init_req(struct request_sock *req,
>              np->rxopt.bits.rxinfo ||
>              np->rxopt.bits.rxoinfo || np->rxopt.bits.rxhlim ||
>              np->rxopt.bits.rxohlim || np->repflow)) {
> +               /* Only initialize ireq->pktops once.
> +                * We must take a refcount on skb because ireq->pktops
> +                * could be consumed immediately.
> +                */
>                 refcount_inc(&skb->users);
> -               ireq->pktopts = skb;
> +               if (cmpxchg(&ireq->pktopts, NULL, skb))
> +                       refcount_dec(&skb->users);
>         }
>  }

-- 
BR,
Muhammad Usama Anjum

