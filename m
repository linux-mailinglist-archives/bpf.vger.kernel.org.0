Return-Path: <bpf+bounces-2282-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A82272A730
	for <lists+bpf@lfdr.de>; Sat, 10 Jun 2023 02:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 791961C21199
	for <lists+bpf@lfdr.de>; Sat, 10 Jun 2023 00:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4741139C;
	Sat, 10 Jun 2023 00:58:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DE71119
	for <bpf@vger.kernel.org>; Sat, 10 Jun 2023 00:58:48 +0000 (UTC)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD3826AD
	for <bpf@vger.kernel.org>; Fri,  9 Jun 2023 17:58:45 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-75eb918116aso200668085a.3
        for <bpf@vger.kernel.org>; Fri, 09 Jun 2023 17:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1686358724; x=1688950724;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2cTgA2QhKCUmFzlxsj9JpU4bWG7UYDuiM5WyYDPIkg4=;
        b=dLF7z+tZblaKj8qNrPX91Y7xjsg+J5JkLmiZYvjhDAXHtXewod39Dz83gAjfKdwWNt
         YQkx7tRWBTLL9HOucP6hTOnK134IGM8NSI2eF0IrjfochR1UMseQwUeZPoJGou56FT5p
         GhjlIKASDPw7MoZ47M31OxTpwpdGJsXToAtCtMaFfTVHL1+7jiY7rEmhsrYakDRN2r1c
         BAO7cFSt6UXTpfo73gWG5JjedCC2o6wD8GiNDdUHmXr+AV8LhOVaUeNcDMfHL+SRlMR7
         fYrPc0ZDQqAJWP51llTEpj9IeD+KgBhI8QmBUCU/uHLFs4H9rlej/tdhDAWqtLSq8ZR4
         9/lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686358724; x=1688950724;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2cTgA2QhKCUmFzlxsj9JpU4bWG7UYDuiM5WyYDPIkg4=;
        b=NCJo2DaK/GPyOu17OEWb3hzmmN3tPeG773c7gn404OxrvFuHJViKhaKLbFRaY1JpKF
         iQgUGFKiYy6RvlVEqOfooL9u5p8HT7EUi5c11fB5gWT68jbK9/X63B6TRixf+n6paN5j
         TZHuxWCSxW0ahuDd9wmK6y7eC0EApwqZC9zUHYFfmMp0Z0PsCA2q7lKOShQx3M1rKpe9
         pXirEdtyNUpMBPHmGCNZ1wZ2u5ynTq8bzsomLqAMul6ZsnoBANATYB2kRvmr7Pb2xAWU
         zGe4NZvUBaTdMGP08NupaKUQCWcSMxXEbjNVmQywHZmYR/35/uGo0OLN4h+nWzoi0Z8B
         XL5w==
X-Gm-Message-State: AC+VfDyUQpt9T5ihp0QNweSp865ZLK8yOaz9iE2lgu87IkF6mR6OGOw3
	kTM9TIIAPG2IcE95P8MU9bus+w==
X-Google-Smtp-Source: ACHHUZ4DIKu/OkJPy4kwhELFjDDLWpbuMdjS71pxQJMVpAWexe24zJlanlGVriRGhgfyXb7TPnKF/g==
X-Received: by 2002:ad4:5aee:0:b0:626:2527:54a6 with SMTP id c14-20020ad45aee000000b00626252754a6mr3741754qvh.8.1686358724421;
        Fri, 09 Jun 2023 17:58:44 -0700 (PDT)
Received: from [172.17.0.4] ([130.44.212.126])
        by smtp.gmail.com with ESMTPSA id x17-20020a0ce251000000b00606750abaf9sm1504075qvl.136.2023.06.09.17.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 17:58:44 -0700 (PDT)
From: Bobby Eshleman <bobby.eshleman@bytedance.com>
Subject: [PATCH RFC net-next v4 0/8] virtio/vsock: support datagrams
Date: Sat, 10 Jun 2023 00:58:27 +0000
Message-Id: <20230413-b4-vsock-dgram-v4-0-0cebbb2ae899@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALPKg2QC/3WOQQrCMBBFryKzdiSmMUVXguAB3EoXSTq2QZpIE
 kJL6d1Nu3Dn8s3/nzczRAqWIlx2MwTKNlrvCoj9DkyvXEdo28LAGa+YOFaoBebozRvbLqgBKy1
 JK6mkoBOUkVaRUAflTL/OHCV0NKY1+gR62XFzPeFxv623X94U6G1MPkzbL5lvtX/azJEhq8/G1
 IZIcrrqKVFbtHQwfoBmWZYvssY4TtwAAAA=
To: Stefan Hajnoczi <stefanha@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryantan@vmware.com>, 
 Vishnu Dasa <vdasa@vmware.com>, 
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, 
 Simon Horman <simon.horman@corigine.com>, 
 Krasnov Arseniy <oxffffaa@gmail.com>, kvm@vger.kernel.org, 
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 bpf@vger.kernel.org, Bobby Eshleman <bobby.eshleman@bytedance.com>, 
 Jiang Wang <jiang.wang@bytedance.com>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hey all!

This series introduces support for datagrams to virtio/vsock.

It is a spin-off (and smaller version) of this series from the summer:
  https://lore.kernel.org/all/cover.1660362668.git.bobby.eshleman@bytedance.com/

Please note that this is an RFC and should not be merged until
associated changes are made to the virtio specification, which will
follow after discussion from this series.

Another aside, the v4 of the series has only been mildly tested with a
run of tools/testing/vsock/vsock_test. Some code likely needs cleaning
up, but I'm hoping to get some of the design choices agreed upon before
spending too much time making it pretty.

This series first supports datagrams in a basic form for virtio, and
then optimizes the sendpath for all datagram transports.

The result is a very fast datagram communication protocol that
outperforms even UDP on multi-queue virtio-net w/ vhost on a variety
of multi-threaded workload samples.

For those that are curious, some summary data comparing UDP and VSOCK
DGRAM (N=5):

	vCPUS: 16
	virtio-net queues: 16
	payload size: 4KB
	Setup: bare metal + vm (non-nested)

	UDP: 287.59 MB/s
	VSOCK DGRAM: 509.2 MB/s

Some notes about the implementation...

This datagram implementation forces datagrams to self-throttle according
to the threshold set by sk_sndbuf. It behaves similar to the credits
used by streams in its effect on throughput and memory consumption, but
it is not influenced by the receiving socket as credits are.

The device drops packets silently.

As discussed previously, this series introduces datagrams and defers
fairness to future work. See discussion in v2 for more context around
datagrams, fairness, and this implementation.

Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
---
Changes in v4:
- style changes
  - vsock: use sk_vsock(vsk) in vsock_dgram_recvmsg instead of
    &sk->vsk
  - vsock: fix xmas tree declaration
  - vsock: fix spacing issues
  - virtio/vsock: virtio_transport_recv_dgram returns void because err
    unused
- sparse analysis warnings/errors
  - virtio/vsock: fix unitialized skerr on destroy
  - virtio/vsock: fix uninitialized err var on goto out
  - vsock: fix declarations that need static
  - vsock: fix __rcu annotation order
- bugs
  - vsock: fix null ptr in remote_info code
  - vsock/dgram: make transport_dgram a fallback instead of first
    priority
  - vsock: remove redundant rcu read lock acquire in getname()
- tests
  - add more tests (message bounds and more)
  - add vsock_dgram_bind() helper
  - add vsock_dgram_connect() helper

Changes in v3:
- Support multi-transport dgram, changing logic in connect/bind
  to support VMCI case
- Support per-pkt transport lookup for sendto() case
- Fix dgram_allow() implementation
- Fix dgram feature bit number (now it is 3)
- Fix binding so dgram and connectible (cid,port) spaces are
  non-overlapping
- RCU protect transport ptr so connect() calls never leave
  a lockless read of the transport and remote_addr are always
  in sync
- Link to v2: https://lore.kernel.org/r/20230413-b4-vsock-dgram-v2-0-079cc7cee62e@bytedance.com

---
Bobby Eshleman (7):
      vsock/dgram: generalize recvmsg and drop transport->dgram_dequeue
      vsock: refactor transport lookup code
      vsock: support multi-transport datagrams
      vsock: make vsock bind reusable
      virtio/vsock: add VIRTIO_VSOCK_F_DGRAM feature bit
      virtio/vsock: support dgrams
      vsock: Add lockless sendmsg() support

Jiang Wang (1):
      tests: add vsock dgram tests

 drivers/vhost/vsock.c                   |  44 ++-
 include/linux/virtio_vsock.h            |  13 +-
 include/net/af_vsock.h                  |  52 ++-
 include/uapi/linux/virtio_vsock.h       |   2 +
 net/vmw_vsock/af_vsock.c                | 616 ++++++++++++++++++++++++++------
 net/vmw_vsock/diag.c                    |  10 +-
 net/vmw_vsock/hyperv_transport.c        |  42 ++-
 net/vmw_vsock/virtio_transport.c        |  28 +-
 net/vmw_vsock/virtio_transport_common.c | 226 +++++++++---
 net/vmw_vsock/vmci_transport.c          | 152 ++++----
 net/vmw_vsock/vsock_bpf.c               |  10 +-
 net/vmw_vsock/vsock_loopback.c          |  13 +-
 tools/testing/vsock/util.c              | 141 +++++++-
 tools/testing/vsock/util.h              |   6 +
 tools/testing/vsock/vsock_test.c        | 432 ++++++++++++++++++++++
 15 files changed, 1533 insertions(+), 254 deletions(-)
---
base-commit: 28cfea989d6f55c3d10608eba2a2bae609c5bf3e
change-id: 20230413-b4-vsock-dgram-3b6eba6a64e5

Best regards,
-- 
Bobby Eshleman <bobby.eshleman@bytedance.com>


