Return-Path: <bpf+bounces-7211-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E46773790
	for <lists+bpf@lfdr.de>; Tue,  8 Aug 2023 05:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1A8E1C20E30
	for <lists+bpf@lfdr.de>; Tue,  8 Aug 2023 03:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59AAE1FBD;
	Tue,  8 Aug 2023 03:20:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3754C1C38
	for <bpf@vger.kernel.org>; Tue,  8 Aug 2023 03:20:19 +0000 (UTC)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6018E121
	for <bpf@vger.kernel.org>; Mon,  7 Aug 2023 20:20:17 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1bbf8cb694aso44608395ad.3
        for <bpf@vger.kernel.org>; Mon, 07 Aug 2023 20:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691464817; x=1692069617;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FElCe4GqO7dcEzUVLWub8fb5QZN0mdVSba+a7j3yTZw=;
        b=eXiUNr+hyR+wu45aflOHgSuIkLqkiZfIbqJp2zNY23KBnr50ICeGARr5j7xJZrrBSI
         APTX7radaR/RPrRIdsosSTPZbo+QFkMmR0X45+xHqX5LyW3UxZidiSW/rCTzv7j4foxa
         nsBp5vLvd6e6Fuszk4yej0lvXlULO/9oBlArWaa5MVsKrA0DmtzGx/bPX9PyEOzkSIgM
         87r0skMXjeF84QWHiawLb/yhoZt1F92Kvjtc/JHZf75yGNfC8NsIyC6bKtV23YtZT4Cj
         AzBwfOzF1MsKR2Io6LisMfrjIwvnJyHJ0GeKqLJXOfrZxJmLSe6E2lHyLGAcKf5mJyXe
         gRqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691464817; x=1692069617;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FElCe4GqO7dcEzUVLWub8fb5QZN0mdVSba+a7j3yTZw=;
        b=Vbq/INZeMiYvQww2VJVgw6KVl6SOARphEFtwT5/G/TMkeADrsVkl+Z945nJ4e/nAGb
         83HW+lalFbdGlRKwTn7y1OMUGm6tVsISQPET2Vjc1m8U32ar7bN3LtjvqbZksG9t9/ua
         QFoSfAmqKVGSrt8ODi3/6kI9YrEbAYYjR96x9iD/6dLTxhRraGjjv05hIJGetbcEUzLW
         KLmzBuOg07V9HQkkJPRLuyx9q6gX9Mvuu4VJOT+WSmph49t5Bm7+fu0t9yalwIWcvH4b
         +cJq3x4f1TBotiNtRuW49ltrPojx1omP52I3YJXKVb3jPbUjppoow1Cjaf3RqFRiOz/C
         MxKg==
X-Gm-Message-State: AOJu0YwAkTIF/lzy72yncuRY70qR6gwVXX1+dXtWBUO1sEoAtymmCRFm
	FQUohsOkSkkYNmIx/xMvvV/P+A==
X-Google-Smtp-Source: AGHT+IFqOD4Nzbm8yK6ZYb6nsp7T3mivWZRR4oI7qx3A/R5S+/NTbhq2dUJWH+bl5gd+Yv6htBrWng==
X-Received: by 2002:a17:902:d882:b0:1bc:5855:f108 with SMTP id b2-20020a170902d88200b001bc5855f108mr9933657plz.46.1691464816858;
        Mon, 07 Aug 2023 20:20:16 -0700 (PDT)
Received: from C02FG34NMD6R.bytedance.net ([2408:8656:30f8:e020::b])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c10d00b001b896686c78sm7675800pli.66.2023.08.07.20.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 20:20:16 -0700 (PDT)
From: Albert Huang <huangjie.albert@bytedance.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: Albert Huang <huangjie.albert@bytedance.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	Kees Cook <keescook@chromium.org>,
	Richard Gobert <richardbgobert@gmail.com>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:XDP (eXpress Data Path)" <bpf@vger.kernel.org>
Subject: [RFC v3 Optimizing veth xsk performance 0/9]
Date: Tue,  8 Aug 2023 11:19:04 +0800
Message-Id: <20230808031913.46965-1-huangjie.albert@bytedance.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

AF_XDP is a kernel bypass technology that can greatly improve performance.
However,for virtual devices like veth,even with the use of AF_XDP sockets,
there are still many additional software paths that consume CPU resources. 
This patch series focuses on optimizing the performance of AF_XDP sockets 
for veth virtual devices. Patches 1 to 4 mainly involve preparatory work. 
Patch 5 introduces tx queue and tx napi for packet transmission, while 
patch 8 primarily implements batch sending for IPv4 UDP packets, and patch 9
add support for AF_XDP tx need_wakup feature. These optimizations significantly
reduce the software path and support checksum offload.

I tested those feature with
A typical topology is shown below:
client(send):                                        server:(recv)
veth<-->veth-peer                                    veth1-peer<--->veth1
  1       |                                                  |   7
          |2                                                6|
          |                                                  |
        bridge<------->eth0(mlnx5)- switch -eth1(mlnx5)<--->bridge1
                  3                    4                 5    
             (machine1)                              (machine2)    
AF_XDP socket is attach to veth and veth1. and send packets to physical NIC(eth0)
veth:(172.17.0.2/24)
bridge:(172.17.0.1/24)
eth0:(192.168.156.66/24)

eth1(172.17.0.2/24)
bridge1:(172.17.0.1/24)
eth0:(192.168.156.88/24)

after set default route\snat\dnat. we can have a tests
to get the performance results.

packets send from veth to veth1:
af_xdp test tool:
link:https://github.com/cclinuxer/libxudp
send:(veth)
./objs/xudpperf send --dst 192.168.156.88:6002 -l 1300
recv:(veth1)
./objs/xudpperf recv --src 172.17.0.2:6002

udp test tool:iperf3
send:(veth)
iperf3 -c 192.168.156.88 -p 6002 -l 1300 -b 0 -u
recv:(veth1)
iperf3 -s -p 6002

performance:
performance:(test weth libxudp lib)
UDP                              : 320 Kpps (with 100% cpu)
AF_XDP   no  zerocopy + no batch : 480 Kpps (with ksoftirqd 100% cpu)
AF_XDP  with  batch  +  zerocopy : 1.5 Mpps (with ksoftirqd 15% cpu)

With af_xdp batch, the libxudp user-space program reaches a bottleneck.
Therefore, the softirq did not reach the limit.

This is just an RFC patch series, and some code details still need 
further consideration. Please review this proposal.

v2->v3:
- fix build error find by kernel test robot.

v1->v2:
- all the patches pass checkpatch.pl test. suggested by Simon Horman.
- iperf3 tested with -b 0, update the test results. suggested by Paolo Abeni.
- refactor code to make code structure clearer.
- delete some useless code logic in the veth_xsk_tx_xmit function.
- add support for AF_XDP tx need_wakup feature.

Albert Huang (9):
  veth: Implement ethtool's get_ringparam() callback
  xsk: add dma_check_skip for skipping dma check
  veth: add support for send queue
  xsk: add xsk_tx_completed_addr function
  veth: use send queue tx napi to xmit xsk tx desc
  veth: add ndo_xsk_wakeup callback for veth
  sk_buff: add destructor_arg_xsk_pool for zero copy
  veth: af_xdp tx batch support for ipv4 udp
  veth: add support for AF_XDP tx need_wakup feature

 drivers/net/veth.c          | 679 +++++++++++++++++++++++++++++++++++-
 include/linux/skbuff.h      |   2 +
 include/net/xdp_sock_drv.h  |   5 +
 include/net/xsk_buff_pool.h |   1 +
 net/xdp/xsk.c               |   6 +
 net/xdp/xsk_buff_pool.c     |   3 +-
 net/xdp/xsk_queue.h         |  10 +
 7 files changed, 704 insertions(+), 2 deletions(-)

-- 
2.20.1


