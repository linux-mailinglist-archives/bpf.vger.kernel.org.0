Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6655E1A4857
	for <lists+bpf@lfdr.de>; Fri, 10 Apr 2020 18:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgDJQV7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Apr 2020 12:21:59 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:57333 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726203AbgDJQV6 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 10 Apr 2020 12:21:58 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id AED1648C;
        Fri, 10 Apr 2020 12:21:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 10 Apr 2020 12:21:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jibi.io; h=from
        :to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=mesmtp; bh=T13M6WxkQEF6ehiEYttI+O+
        MmaX6SjGo7cGwyjGYaFo=; b=s30Y2fy1WQw6Mw3q41aNZzje93/kiO87uJZZxr4
        N7h5UM48m6jALEAPYhcSbFgH+GlLxrHISTObAqg9Sz5h+zaikZgl76wKqImsxSa2
        Mt6KnDX6sKZS1rcmcgYe5GeBeQAiIjXj0f243Y0jvyhfMhFQzrK/icplPU84ZRXZ
        YmLI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=T13M6WxkQEF6ehiEY
        ttI+O+MmaX6SjGo7cGwyjGYaFo=; b=0EVsD7WgERLHOahFDL0VXbCwbX0AHXbuW
        XHqX982IZue6ThKVSbUIlegHpxNwBJLIPqz0ptd8cgsdCYygqntEHlVlQSozjMAe
        9NeMEmujgJSj0fnYbboP8RDYQ38ptAekDMjgE8iHzxlX1280yiEKUCEP6hP4cCI+
        FVo+RivN1xXNvXhlaIoSYKuFG3d78uMeI8Y9Y0jMAjb+Od8v3WWKD1n7MtdFzlqg
        Ik4kTX4YuVkR7oYyYeBIuXWmOUgSCy2p0W1PZC3HCxV4sw6fQ45FvdVk+URFYxNR
        6K2niQKup9ClXH6e1/dT3GPeHrjx4bwwBm/PGFq4OT7iPW2SArKjQ==
X-ME-Sender: <xms:Jp2QXvQB1R96_TC-AO3BYeVYDLK-oA8Jw8e25dBUE0b1cEIKX4ev_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrvddvgddutddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomhepifhilhgsvghrthhouceuvghrthhinhcuoehmvgesjhhisghirdhi
    oheqnecukfhppedvrddvfeegrddufedurddvheenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmvgesjhhisghirdhioh
X-ME-Proxy: <xmx:Jp2QXiM3szPKW_W6XvI1DCBbQNiEvyRxIDm-pgKghIYtgzQ2bKcL1g>
    <xmx:Jp2QXv0yjwT76aCApbaJFSAJ33AyHKmXgQPHrnNqr8M36GR5nrReNw>
    <xmx:Jp2QXjhJr9PSI4y2yTGKDDE1V7VNeeXKSJfYr7_BotWFpOrXggigDw>
    <xmx:Jp2QXoK4SX_9mbGQFVfIyDix-tyqEJhqpSBfiUNmFKo4XBe--YX4-w>
Received: from apathy.lan (2-234-131-25.ip223.fastwebnet.it [2.234.131.25])
        by mail.messagingengine.com (Postfix) with ESMTPA id BD6EA328005D;
        Fri, 10 Apr 2020 12:21:56 -0400 (EDT)
From:   Gilberto Bertin <me@jibi.io>
To:     bpf@vger.kernel.org, jasowang@redhat.com
Cc:     Gilberto Bertin <me@jibi.io>
Subject: [PATCH 0/1] Pass correct tun device's RX queue number to XDP program
Date:   Fri, 10 Apr 2020 18:20:58 +0200
Message-Id: <20200410162059.15438-1-me@jibi.io>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

I'm trying to run XDP on top of a tun device in multi queue mode as that allows
me to easily play on my laptop with an interface that supports multiple queues.

While testing it I found an issue: regardless of the the tun fd (i.e. RX queue)
I'm writing packets to, the XDP program thinks all packets are coming from RX
queue 0.

I'd like to propose a fix for that (see next mail) but let me first share some
context.

Here's what I'm using to setup a tun device with multiple RX/TX queues and write
some test packets into all of its RX queues:

        struct ifreq ifr = {
                .ifr_flags = IFF_TAP | IFF_NO_PI | IFF_MULTI_QUEUE, .ifr_name = "mytun0"
        };

        int fds[4];
        for (int i = 0; i < 4; i++) {
                if ((fds[i] = open("/dev/net/tun", O_RDWR)) < 0)
                        return -1;
                if (ioctl(fds[i], TUNSETIFF, (void *)&ifr))
                        return -1;
        }

	while (1) {
		for (int i = 0 ; i < 4; i++)
			write(fds[i], "\x12\x34\x56\x78\x90\xab\x12\x34\x56\x67\x90\xab\x08\x00", 14);
		sleep(2);
	}

Next I reproduced the problem with this XDP program attached to the tun device
created with the previous code snippet:

        $ cat xdp_kern.c
        #include <linux/bpf.h>
        #include <bpf_helpers.h>

        SEC("prog")
        unsigned int xdp_prog(struct xdp_md *xdp) {
                bpf_printk("rx queue: %d\n", xdp->rx_queue_index);
                return XDP_PASS;
        }

        char _license[] SEC("license") = "GPL";

        $ sudo ip link set dev mytun0 xdpdrv obj ./xdp_kern.o

        $ sudo bpftool prog tracelog
                   a.out-22189 [003] .... 14444.594609: 0: rx queue: 0
                   a.out-22189 [003] .... 14444.594645: 0: rx queue: 0
                   a.out-22189 [003] .... 14444.594653: 0: rx queue: 0
                   a.out-22189 [003] .... 14444.594661: 0: rx queue: 0

Here the XDP program is reporting all packets coming from RX queue 0 when they
should have been coming from RX queues 0..3.

After looking into the tun driver I ended up writing this stap script which
reveals the issue:

        $ cat rx_queue.stap
        probe kernel.function("tun_get_user") {
                printf("tun_get_user(): tfile->xdp_rxq.queue_index: %d\n", $tfile->xdp_rxq->queue_index);
        }

        probe kernel.function("netif_receive_generic_xdp") {
                printf("netif_receive_generic_xdp(): skb->queue_mapping: %d\n", $skb->queue_mapping);
                printf("\n");
        }

        $ sudo stap ./rx_queue.stap
        tun_get_user(): tfile->xdp_rxq.queue_index: 0
        netif_receive_generic_xdp(): skb->queue_mapping: 0

        tun_get_user(): tfile->xdp_rxq.queue_index: 1
        netif_receive_generic_xdp(): skb->queue_mapping: 0

        tun_get_user(): tfile->xdp_rxq.queue_index: 2
        netif_receive_generic_xdp(): skb->queue_mapping: 0

        tun_get_user(): tfile->xdp_rxq.queue_index: 3
        netif_receive_generic_xdp(): skb->queue_mapping: 0

It looks like the tun driver (specifically tun_get_user()) is not passing
correctly the information about the RX queue to do_xdp_generic().

Setting the queue_mapping field in the skb with skb_record_rx_queue() seems to
fix the issue.

Same test with the patched kernel:
        sudo bpftool prog tracelog
                   a.out-791   [004] ....  4826.499356: 0: rx queue: 0
                   a.out-791   [004] ....  4826.499532: 0: rx queue: 1
                   a.out-791   [004] ....  4826.499541: 0: rx queue: 2
                   a.out-791   [004] ....  4826.499549: 0: rx queue: 3

While at it, I also fixed tun_xdp_one(), which was calling skb_record_rx_queue()
after invoking do_xdp_generic().

Gilberto Bertin (1):
  net: tun: record RX queue in skb before do_xdp_generic()

 drivers/net/tun.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.20.1

