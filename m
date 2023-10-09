Return-Path: <bpf+bounces-11767-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 202F27BEBD8
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 22:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8280F281EA6
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 20:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B93738DD7;
	Mon,  9 Oct 2023 20:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QUJV1fR4"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C6D200A5
	for <bpf@vger.kernel.org>; Mon,  9 Oct 2023 20:43:45 +0000 (UTC)
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0162EAC
	for <bpf@vger.kernel.org>; Mon,  9 Oct 2023 13:43:42 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id 71dfb90a1353d-49abb53648aso1697122e0c.0
        for <bpf@vger.kernel.org>; Mon, 09 Oct 2023 13:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696884222; x=1697489022; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a1Q2avVq5QItelbkdP/2a0pizJfAtgC8i9cOgEjp1cc=;
        b=QUJV1fR4KQjObSq9jmIJJMI3GkUAIFuAY3iNTOWiKyu4AvA/qMbOSawF31ofM1Mh0Z
         kM8ykqqf6hm4xoWnMGY4rWEbT5K3V2iVp6kAeSGYjhnL15kMW8ILHhPoRe5JsDfStybh
         jiM/55F7IYaLoQOz16fx3Wu0lI7yN/kZxZAiR0uvmqd/sW4m/FdS5/tYFuuigPeRGEUO
         3JQLkkl48VumBVAqhY9lKvuePAifna9XZRNYLPjJcRX6lLMcVFmIzZU9mBfGbb9Y2Rgx
         YWiY+/s8LbxRUXNcGps+WjaYkp23jt5TkMVbQbM5ZpNGo/uHj9UUWcClZCZubl4Wgz2l
         NSHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696884222; x=1697489022;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a1Q2avVq5QItelbkdP/2a0pizJfAtgC8i9cOgEjp1cc=;
        b=UT3xmAcEVNSE8TFd0CIaK2qVCo/v2M9HRQVCY4MIzjWHOZGJcaSQUDEYCfNSUhuH3+
         aUNEUTrynagbOGAeJTIYa5r2uXa203jHmwZxhKtuvZ0bsUiCz9hMB33XUQssLSeg+WWe
         PLYPaM/9GZJ0bhbkiCuFqzD5D55deeSUev53Kg3qpv9RpCQb6s3E6bgCzSFEkj0LggtY
         dxUa0gY40noY59UA7ACGsXBxcGiss8K3XVGuaX73jUMtQMrlO7jwll4wE+ovxvHxZ/LS
         XxFB214qgq7VzPgnA9l6pH2gLAz/e+SxMLg68ASQq0XJ0SK4JqUkk4nh3CrfwR2JGdTu
         ZQ7A==
X-Gm-Message-State: AOJu0Yw7bMfAhk77SD5p9TOQTkDrCL8SpuTg8gp/wCosRWQZlovafh9w
	5rAafEdfxiGqhJmoVqfnD0TI9ZTVFsp6Yvs8jThjPQ==
X-Google-Smtp-Source: AGHT+IGByqF8zTglgAy8227/8j/6ySKnYIPR9pqmJk9ubPlBV5437+rsR2VF7AP7owOMYOCyELQIAlCZ8lqszM9s1vE=
X-Received: by 2002:a1f:49c3:0:b0:4a0:8a35:6686 with SMTP id
 w186-20020a1f49c3000000b004a08a356686mr2269163vka.11.1696884221806; Mon, 09
 Oct 2023 13:43:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231009130122.946357448@linuxfoundation.org>
In-Reply-To: <20231009130122.946357448@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 10 Oct 2023 02:13:30 +0530
Message-ID: <CA+G9fYvWCf4fYuQsVLu0NdN+=W73bW1hr1hiokajktNzPFyYtA@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/162] 6.1.57-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 9 Oct 2023 at 18:46, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.57 release.
> There are 162 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 11 Oct 2023 13:00:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.57-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


The following kernel warnings were noticed several times on arm x15 devices
running stable-rc 6.1.57-rc1 while running  selftests: net: mptcp_connect.sh
and netfilter: nft_fib.sh.

The possible unsafe locking scenario detected.

FYI,
Stable-rc/ linux.6.1.y kernel running stable/ linux.6.5.y selftest in this case.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

kselftest: Running tests in net/mptcp
TAP version 13
1..7
# timeout set to 1200
# selftests: net/mptcp: mptcp_connect.sh
[   80.093261] IPv6: ADDRCONF(NETDEV_CHANGE): ns1eth2: link becomes ready
[   80.449707] IPv6: ADDRCONF(NETDEV_CHANGE): ns2eth3: link becomes ready
[   80.770538] IPv6: ADDRCONF(NETDEV_CHANGE): ns2eth1: link becomes ready
[   80.826141] IPv6: ADDRCONF(NETDEV_CHANGE): ns4eth3: link becomes ready
[   80.833465] IPv6: ADDRCONF(NETDEV_CHANGE): ns3eth4: link becomes ready
# INFO: set ns4-64ac7c08-UbLqmM dev ns4eth3: ethtool -K  gso off
# Created /tmp/tmp.de3ILrgEEm (size 375836 /tmp/tmp.de3ILrgEEm)
containing data sent by client
# Created /tmp/tmp.YGH83JN29o (size 8315932 /tmp/tmp.YGH83JN29o)
containing data sent by server
# New MPTCP socket can be blocked via sysctl [ OK ]
# INFO: validating network environment with pings
[   82.468353]
[   82.469848] ================================
[   82.474151] WARNING: inconsistent lock state
[   82.478454] 6.1.57-rc1 #1 Not tainted
[   82.482116] --------------------------------
[   82.486419] inconsistent {IN-SOFTIRQ-W} -> {SOFTIRQ-ON-R} usage.
[   82.492431] ping/1924 [HC0[0]:SC0[0]:HE1:SE1] takes:
[   82.497436] c9a58224 (&n->lock){++-?}-{2:2}, at: rt6_score_route+0xd8/0x1e0
[   82.504455] {IN-SOFTIRQ-W} state was registered at:
[   82.509368]   _raw_write_lock_bh+0x48/0x58
[   82.513488]   __neigh_update+0x74/0xe48
[   82.517333]   neigh_update+0x24/0x2c
[   82.520935]   ndisc_rcv+0x4c4/0x1440
[   82.524536]   icmpv6_rcv+0x604/0x810
[   82.528137]   ip6_protocol_deliver_rcu+0x9c/0x9ac
[   82.532867]   ip6_input_finish+0xa0/0x18c
[   82.536895]   ip6_mc_input+0x148/0x3d0
[   82.540679]   __netif_receive_skb_one_core+0x58/0x74
[   82.545654]   process_backlog+0x138/0x300
[   82.549713]   __napi_poll+0x34/0x258
[   82.553283]   net_rx_action+0x160/0x350
[   82.557159]   __do_softirq+0x1b8/0x4dc
[   82.560913]   call_with_stack+0x18/0x20
[   82.564788]   do_softirq+0xb0/0xb4
[   82.568206]   __local_bh_enable_ip+0x180/0x1b8
[   82.572662]   __dev_queue_xmit+0x3bc/0x12d0
[   82.576873]   ip6_finish_output2+0x178/0xb80
[   82.581176]   ip6_finish_output+0x1c8/0x48c
[   82.585388]   ndisc_send_skb+0x4d8/0x8c0
[   82.589324]   addrconf_dad_completed+0xd8/0x3b0
[   82.593872]   addrconf_dad_work+0x208/0x56c
[   82.598083]   process_one_work+0x26c/0x6a0
[   82.602203]   worker_thread+0x60/0x4e8
[   82.605987]   kthread+0xfc/0x11c
[   82.609222]   ret_from_fork+0x14/0x28
[   82.612915] irq event stamp: 18041
[   82.616333] hardirqs last  enabled at (18041): [<c035a990>]
__local_bh_enable_ip+0xcc/0x1b8
[   82.624725] hardirqs last disabled at (18039): [<c035aa0c>]
__local_bh_enable_ip+0x148/0x1b8
[   82.633178] softirqs last  enabled at (18040): [<c14fc510>]
ip6_datagram_connect+0x20/0x44
[   82.641510] softirqs last disabled at (18038): [<c1306cc8>]
lock_sock_nested+0x4c/0x7c
[   82.649475]
[   82.649475] other info that might help us debug this:
[   82.656036]  Possible unsafe locking scenario:
[   82.656036]
[   82.661956]        CPU0
[   82.664428]        ----
[   82.666870]   lock(&n->lock);
[   82.669860]   <Interrupt>
[   82.672485]     lock(&n->lock);
[   82.675659]
[   82.675659]  *** DEADLOCK ***
[   82.675659]
[   82.681610] 4 locks held by ping/1924:
[   82.685363]  #0: c9ab0110 (sk_lock-AF_INET6){+.+.}-{0:0}, at:
ip6_datagram_connect+0x20/0x44
[   82.693878]  #1: c24a62f8 (rcu_read_lock){....}-{1:2}, at:
ip6_route_output_flags+0x0/0x1f4
[   82.702301]  #2: c24a62f8 (rcu_read_lock){....}-{1:2}, at:
ip6_pol_route+0x60/0x718
[   82.709991]  #3: c24a62f8 (rcu_read_lock){....}-{1:2}, at:
rt6_score_route+0x78/0x1e0
[   82.717895]
[   82.717895] stack backtrace:
[   82.722259] CPU: 1 PID: 1924 Comm: ping Not tainted 6.1.57-rc1 #1
[   82.728393] Hardware name: Generic DRA74X (Flattened Device Tree)
[   82.734527]  unwind_backtrace from show_stack+0x18/0x1c
[   82.739776]  show_stack from dump_stack_lvl+0x58/0x70
[   82.744873]  dump_stack_lvl from mark_lock.part.0+0xb74/0x128c
[   82.750732]  mark_lock.part.0 from __lock_acquire+0x3d8/0x2aa4
[   82.756591]  __lock_acquire from lock_acquire+0x110/0x334
[   82.762023]  lock_acquire from _raw_read_lock+0x64/0x74
[   82.767272]  _raw_read_lock from rt6_score_route+0xd8/0x1e0
[   82.772888]  rt6_score_route from find_match.part.0+0x6c/0x4d4
[   82.778747]  find_match.part.0 from __find_rr_leaf+0xb8/0x430
[   82.784515]  __find_rr_leaf from fib6_table_lookup+0x234/0x46c
[   82.790405]  fib6_table_lookup from ip6_pol_route+0xd0/0x718
[   82.796081]  ip6_pol_route from ip6_pol_route_output+0x2c/0x34
[   82.801940]  ip6_pol_route_output from fib6_rule_lookup+0xb4/0x1e4
[   82.808166]  fib6_rule_lookup from ip6_route_output_flags_noref+0xbc/0x110
[   82.815063]  ip6_route_output_flags_noref from
ip6_route_output_flags+0x78/0x1f4
[   82.822509]  ip6_route_output_flags from ip6_dst_lookup_tail+0xa8/0x7b0
[   82.829162]  ip6_dst_lookup_tail from ip6_dst_lookup_flow+0x40/0x90
[   82.835479]  ip6_dst_lookup_flow from ip6_datagram_dst_update+0x18c/0x3d4
[   82.842315]  ip6_datagram_dst_update from __ip6_datagram_connect+0x234/0x4b0
[   82.849395]  __ip6_datagram_connect from ip6_datagram_connect+0x30/0x44
[   82.856048]  ip6_datagram_connect from __sys_connect+0xc4/0xd8
[   82.861907]  __sys_connect from ret_fast_syscall+0x0/0x1c
[   82.867340] Exception stack(0xf0441fa8 to 0xf0441ff0)
[   82.872436] 1fa0:                   004e2208 004e0208 00000006
004e2524 0000001c 00000001
[   82.880645] 1fc0: 004e2208 004e0208 bec08828 0000011b 004e3544
00000000 00000006 00000000
[   82.888854] 1fe0: 0000011b bec08778 b6efe83b b6e67616
# INFO: Using loss of 0.16% delay 24 ms reorder 96% 19% with delay 6ms
on ns3eth4
...
# ns1 TCP   -> ns1 (dead:beef:1::1:10053) MPTCP (duration   242ms) [ OK ]
# INFO: TFO not supported by the kernel: SKIP
# INFO: test tproxy ipv4
# ns1 MPTCP -> ns2 (10.0.3.1:20000      ) MPTCP (duration   412ms) [ OK ]
# PASS: tproxy ipv4
# INFO: test tproxy ipv6
# ns1 MPTCP -> ns2 (dead:beef:3::1:20000) MPTCP (duration   323ms) [ OK ]
# PASS: tproxy ipv6
# INFO: disconnect
# ns1 MPTCP -> ns1 (10.0.1.1:20001      ) MPTCP (duration   198ms) [ OK ]
# ns1 MPTCP -> ns1 (10.0.1.1:20002      ) TCP  (duration    91ms) [ OK ]
# ns1 TCP   -> ns1 (10.0.1.1:20003      ) MPTCP (duration    88ms) [ OK ]
# ns1 MPTCP -> ns1 (dead:beef:1::1:20004) MPTCP (duration   147ms) [ OK ]
# ns1 MPTCP -> ns1 (dead:beef:1::1:20005) TCP  (duration    95ms) [ OK ]
# ns1 TCP   -> ns1 (dead:beef:1::1:20006) MPTCP (duration    83ms) [ OK ]
# Time: 88 seconds
ok 1 selftests: net/mptcp: mptcp_connect.sh



And on other instance,

[   77.366607] kselftest: Running tests in netfilter
TAP version 13
1..14
# timeout set to 120
# selftests: netfilter: nft_fib.sh
# /dev/stdin:4:10-28: Error: Could not process rule: No such file or directory
#         fib saddr . iif oif missing counter log prefix
\"nsrouter-TgCmRmhz nft_rpfilter: \" drop
#         ^^^^^^^^^^^^^^^^^^^
# /dev/stdin:4:10-28: Error: Could not process rule: No such file or directory
#         fib saddr . iif oif missing counter log prefix
\"ns1-TgCmRmhz nft_rpfilter: \" drop
#         ^^^^^^^^^^^^^^^^^^^
# /dev/stdin:4:10-28: Error: Could not process rule: No such file or directory
#         fib saddr . iif oif missing counter log prefix
\"ns2-TgCmRmhz nft_rpfilter: \" drop
#         ^^^^^^^^^^^^^^^^^^^
[   79.492797] IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
[   79.567138] IPv6: ADDRCONF(NETDEV_CHANGE): veth1: link becomes ready
[   80.175903] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[   84.184631]
[   84.186157] ================================
[   84.190429] WARNING: inconsistent lock state
[   84.194732] 6.1.57-rc1 #1 Not tainted
[   84.198425] --------------------------------
[   84.202697] inconsistent {IN-SOFTIRQ-W} -> {SOFTIRQ-ON-R} usage.
[   84.208740] ping/582 [HC0[0]:SC0[0]:HE1:SE1] takes:
[   84.213653] c85b0e24 (&n->lock){++-?}-{2:2}, at: rt6_score_route+0xd8/0x1e0
[   84.220703] {IN-SOFTIRQ-W} state was registered at:
[   84.225616]   _raw_write_lock_bh+0x48/0x58
[   84.229736]   __neigh_update+0x74/0xe48
[   84.233612]   neigh_update+0x24/0x2c
[   84.237213]   ndisc_rcv+0x4c4/0x1440
[   84.240814]   icmpv6_rcv+0x604/0x810
[   84.244415]   ip6_protocol_deliver_rcu+0x9c/0x9ac
[   84.249145]   ip6_input_finish+0xa0/0x18c
[   84.253204]   ip6_mc_input+0x148/0x3d0
[   84.256958]   __netif_receive_skb_one_core+0x58/0x74
[   84.261962]   process_backlog+0x138/0x300
[   84.266021]   __napi_poll+0x34/0x258
[   84.269622]   net_rx_action+0x160/0x350
[   84.273468]   __do_softirq+0x1b8/0x4dc
[   84.277252]   call_with_stack+0x18/0x20
[   84.281127]   do_softirq+0xb0/0xb4
[   84.284545]   __local_bh_enable_ip+0x180/0x1b8
[   84.289001]   __dev_queue_xmit+0x3bc/0x12d0
[   84.293212]   ip6_finish_output2+0x178/0xb80
[   84.297515]   ip6_finish_output+0x1c8/0x48c
[   84.301727]   ndisc_send_skb+0x4d8/0x8c0
[   84.305694]   addrconf_dad_completed+0xd8/0x3b0
[   84.310241]   addrconf_dad_work+0x208/0x56c
[   84.314453]   process_one_work+0x26c/0x6a0
[   84.318572]   worker_thread+0x60/0x4e8
[   84.322357]   kthread+0xfc/0x11c
[   84.325622]   ret_from_fork+0x14/0x28
[   84.329315] irq event stamp: 18409
[   84.332733] hardirqs last  enabled at (18409): [<c0422f9c>]
ktime_get_real_ts64+0x208/0x22c
[   84.341125] hardirqs last disabled at (18408): [<c0422f68>]
ktime_get_real_ts64+0x1d4/0x22c
[   84.349517] softirqs last  enabled at (18368): [<c14e08a8>]
rawv6_sendmsg+0x780/0x14cc
[   84.357482] softirqs last disabled at (18366): [<c1306ea0>]
release_sock+0x20/0xa0
[   84.365112]
[   84.365112] other info that might help us debug this:
[   84.371673]  Possible unsafe locking scenario:
[   84.371673]
[   84.377624]        CPU0
[   84.380096]        ----
[   84.382537]   lock(&n->lock);
[   84.385528]   <Interrupt>
[   84.388183]     lock(&n->lock);
[   84.391326]
[   84.391326]  *** DEADLOCK ***
[   84.391326]
[   84.397277] 3 locks held by ping/582:
[   84.400970]  #0: c24a62f8 (rcu_read_lock){....}-{1:2}, at:
ip6_route_output_flags+0x0/0x1f4
[   84.409393]  #1: c24a62f8 (rcu_read_lock){....}-{1:2}, at:
ip6_pol_route+0x60/0x718
[   84.417114]  #2: c24a62f8 (rcu_read_lock){....}-{1:2}, at:
rt6_score_route+0x78/0x1e0
[   84.425048]
[   84.425048] stack backtrace:
[   84.429412] CPU: 0 PID: 582 Comm: ping Not tainted 6.1.57-rc1 #1
[   84.435455] Hardware name: Generic DRA74X (Flattened Device Tree)
[   84.441589]  unwind_backtrace from show_stack+0x18/0x1c
[   84.446868]  show_stack from dump_stack_lvl+0x58/0x70
[   84.451965]  dump_stack_lvl from mark_lock.part.0+0xb74/0x128c
[   84.457824]  mark_lock.part.0 from __lock_acquire+0x3d8/0x2aa4
[   84.463684]  __lock_acquire from lock_acquire+0x110/0x334
[   84.469116]  lock_acquire from _raw_read_lock+0x64/0x74
[   84.474395]  _raw_read_lock from rt6_score_route+0xd8/0x1e0
[   84.480010]  rt6_score_route from find_match.part.0+0x6c/0x4d4
[   84.485900]  find_match.part.0 from __find_rr_leaf+0xb8/0x430
[   84.491668]  __find_rr_leaf from fib6_table_lookup+0x234/0x46c
[   84.497528]  fib6_table_lookup from ip6_pol_route+0xd0/0x718
[   84.503234]  ip6_pol_route from ip6_pol_route_output+0x2c/0x34
[   84.509094]  ip6_pol_route_output from fib6_rule_lookup+0xb4/0x1e4
[   84.515319]  fib6_rule_lookup from ip6_route_output_flags_noref+0xbc/0x110
[   84.522247]  ip6_route_output_flags_noref from
ip6_route_output_flags+0x78/0x1f4
[   84.529693]  ip6_route_output_flags from ip6_dst_lookup_tail+0xa8/0x7b0
[   84.536346]  ip6_dst_lookup_tail from ip6_dst_lookup_flow+0x40/0x90
[   84.542663]  ip6_dst_lookup_flow from rawv6_sendmsg+0x3d0/0x14cc
[   84.548736]  rawv6_sendmsg from __sys_sendto+0xd8/0x128
[   84.553985]  __sys_sendto from ret_fast_syscall+0x0/0x1c
[   84.559326] Exception stack(0xf03e1fa8 to 0xf03e1ff0)
[   84.564422] 1fa0:                   004b247c 0000001c 00000006
004b5220 00000040 00000800
[   84.572662] 1fc0: 004b247c 0000001c 00000001 00000122 004b5220
004b3208 004b0208 beb36778
[   84.580871] 1fe0: 00000122 beb36608 b6e8ed91 b6df7616
# PASS: fib expression did not cause unwanted packet drops

Links,
 - https://lkft.validation.linaro.org/scheduler/job/6858069#L4022
 - https://lkft.validation.linaro.org/scheduler/job/6857530#L3070
 - https://lkft.validation.linaro.org/scheduler/job/6856378#L3074

metadata:
  git_ref: linux-6.1.y
  git_repo: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
  git_sha: 282079f8e40746cc342a7dd12654e3af7de01823
  git_describe: v6.1.56-163-g282079f8e407
  kernel_version: 6.1.57-rc1
  kernel-config:
    https://storage.tuxsuite.com/public/linaro/lkft/builds/2WWpUEO5ikJpR8NnchDG1NClaGf/config
  artifact-location:
    https://storage.tuxsuite.com/public/linaro/lkft/builds/2WWpUEO5ikJpR8NnchDG1NClaGf/
  toolchain: gcc-10


--
Linaro LKFT
https://lkft.linaro.org

