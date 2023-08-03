Return-Path: <bpf+bounces-6857-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8F076EBBD
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 16:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28122281235
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 14:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99FEB200B6;
	Thu,  3 Aug 2023 14:05:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640993D8E
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 14:05:39 +0000 (UTC)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8637E4691
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 07:05:10 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1bb119be881so8683675ad.3
        for <bpf@vger.kernel.org>; Thu, 03 Aug 2023 07:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691071509; x=1691676309;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J/VvNs2uIhcAZTPecrKiR+txw4pz0J1IGRiFLglW3T0=;
        b=OSwzcoDOq6NERRdYfrPstK+ZW351dEAa5g+Y+deWGFfvYUWuFhETUOJ6o5tgWGLxIA
         659j09hFeGeYePE5RSp+EnmNsHkgmwExFqo5Br7jFBwlYxOCQZhSYTbkvfUfRN5BGrlo
         Tvb482xPMVsWjkdwPdZlrz8IjfAy9oM/2NC3GPrzALV7jsWdPLhgd5BvCMCZZCLHbiCE
         rbT12hRqWHh+n7ipPcPcRP9PmiqAAYZ824/aA734gUAFUzK1jfBqrypj1dBeHvEr5Taq
         R62qFsHHxo9AHuZfiTFwD5qCDcVwLGyS1XAk+BK8mIuvri2TP07hrYnX82BW4vniF6mc
         ogjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691071509; x=1691676309;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J/VvNs2uIhcAZTPecrKiR+txw4pz0J1IGRiFLglW3T0=;
        b=BPY/ADT8kYNQDjIYUqi37vhTBDBNa/CjlG2vILW3N0TUkJ4UkU3dtZPjVET6TzdynY
         WDCQlK2zMTeWDfmOtvj17r7rbE01HzqZVUsXVXkf0MHiv+ci8VRPGtP1ZYEyFT3fo6BO
         +irkEsJHDkdP8EV8oL3+0cAKVy24Rmhp43aZnuL8ir86GSjkp5Ydjkek6rf+aWRd2B1m
         Jv5e84dvAwRijkuEHSPLsvqSz4RG8CYFXf7EioCtetV/lrKZNBOxLhpaSRU6ga/7PQhR
         AqV+oCaV+ZBqyZzrBA5e1D+fzpFopyttFRovSJ8C0akYzwjzUzIr4JvbkuworDrAoSHg
         4VrQ==
X-Gm-Message-State: ABy/qLbLMwYG3RjDI7sg41C844MW1igI/mjSVCWjfLCL32ZNBN8y6rSY
	qyzU78tw8L18N6zHXYrN88BkvA==
X-Google-Smtp-Source: APBJJlGjmh5nZx44eAfVvPko4njP8rCceoAQXT0fdnZpAfb/mDC9I9WOJMn4Ls7LzubcPSEu0YgK6A==
X-Received: by 2002:a17:902:8207:b0:1b9:ebe9:5f01 with SMTP id x7-20020a170902820700b001b9ebe95f01mr19539395pln.19.1691071508775;
        Thu, 03 Aug 2023 07:05:08 -0700 (PDT)
Received: from C02FG34NMD6R.bytedance.net ([2001:c10:ff04:0:1000::8])
        by smtp.gmail.com with ESMTPSA id ji11-20020a170903324b00b001b8a897cd26sm14367485plb.195.2023.08.03.07.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 07:05:08 -0700 (PDT)
From: "huangjie.albert" <huangjie.albert@bytedance.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: "huangjie.albert" <huangjie.albert@bytedance.com>,
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
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list),
	bpf@vger.kernel.org (open list:XDP (eXpress Data Path))
Subject: [RFC Optimizing veth xsk performance 00/10]
Date: Thu,  3 Aug 2023 22:04:26 +0800
Message-Id: <20230803140441.53596-1-huangjie.albert@bytedance.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=yes
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

AF_XDP is a kernel bypass technology that can greatly improve performance.
However, for virtual devices like veth, even with the use of AF_XDP sockets,
there are still many additional software paths that consume CPU resources. 
This patch series focuses on optimizing the performance of AF_XDP sockets 
for veth virtual devices. Patches 1 to 4 mainly involve preparatory work. 
Patch 5 introduces tx queue and tx napi for packet transmission, while 
patch 9 primarily implements zero-copy, and patch 10 adds support for 
batch sending of IPv4 UDP packets. These optimizations significantly reduce 
the software path and support checksum offload.

I tested those feature with
A typical topology is shown below:
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

after set default route、snat、dnat. we can have a tests
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
iperf3 -c 192.168.156.88 -p 6002 -l 1300 -b 60G -u
recv:(veth1)
iperf3 -s -p 6002

performance:
performance:(test weth libxdp lib)
UDP                              : 250 Kpps (with 100% cpu)
AF_XDP   no  zerocopy + no batch : 480 Kpps (with ksoftirqd 100% cpu)
AF_XDP  with zerocopy + no batch : 540 Kpps (with ksoftirqd 100% cpu)
AF_XDP  with  batch  +  zerocopy : 1.5 Mpps (with ksoftirqd 15% cpu)

With af_xdp batch, the libxdp user-space program reaches a bottleneck.
Therefore, the softirq did not reach the limit.

This is just an RFC patch series, and some code details still need 
further consideration. Please review this proposal.

thanks!

huangjie.albert (10):
  veth: Implement ethtool's get_ringparam() callback
  xsk: add dma_check_skip for  skipping dma check
  veth: add support for send queue
  xsk: add xsk_tx_completed_addr function
  veth: use send queue tx napi to xmit xsk tx desc
  veth: add ndo_xsk_wakeup callback for veth
  sk_buff: add destructor_arg_xsk_pool for zero copy
  xdp: add xdp_mem_type MEM_TYPE_XSK_BUFF_POOL_TX
  veth: support zero copy for af xdp
  veth: af_xdp tx batch support for ipv4 udp

 drivers/net/veth.c          | 729 +++++++++++++++++++++++++++++++++++-
 include/linux/skbuff.h      |   1 +
 include/net/xdp.h           |   1 +
 include/net/xdp_sock_drv.h  |   1 +
 include/net/xsk_buff_pool.h |   1 +
 net/xdp/xsk.c               |   6 +
 net/xdp/xsk_buff_pool.c     |   3 +-
 net/xdp/xsk_queue.h         |  11 +
 8 files changed, 751 insertions(+), 2 deletions(-)

-- 
2.20.1


