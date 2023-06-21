Return-Path: <bpf+bounces-3047-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CAAC738C84
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 19:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46A1C1C20F85
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 17:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9B519BA5;
	Wed, 21 Jun 2023 17:02:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C03519BA1
	for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 17:02:49 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47131120
	for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 10:02:47 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-56ff81be091so86286207b3.0
        for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 10:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687366966; x=1689958966;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FFau3rCjgBYfdrd4tyecw+C9r18qZygu//gOk0flpYQ=;
        b=YGjduLoERQQMuPSo1cZtoXl4BLnCbh1UCp1qVQP3im0g0fJbTLlPNogjUD5HOpN3n7
         UmFUIf8uT2icvFeCb7sishpGvhEf/lwxTou8wpLPvqrcmiwRB2zlc0IyVneLopc9O7kk
         uahjIexi3qArm/nnSKDoiNes4F0In6/zU+EdydY6BL88wto0yHeD6Ca1/BZo5H72I/nu
         HI7KBKu9TV7CV32mJWV5sAYFFiOgY2qDmO2RcdOJSfN4xxKCBAfplk/Z9j+WOmsxVFoX
         D7DKEERzwXybQZUhLI6JYzdKn4PwLRsJHNU797HlrAEiLRrV/XjJTPFQWGMVmHwAxYO9
         VwaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687366966; x=1689958966;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FFau3rCjgBYfdrd4tyecw+C9r18qZygu//gOk0flpYQ=;
        b=G1EumbcxcJHZl+VYL9vZl40LHEK8UYtMd89ikr826qmss6dUAYESGnA9xkEt354NPC
         4Lr9f6dDjJ6JjIoElhqk5gRViDpQZqDykSYKxq99I23gn8zjbdkmWBUZO4XT3hsIZj1L
         MjOjcIORokQzqA5TmEftiA0v1OjGk87e1R0kfl6E44DWlEwVDEl3OoaOoFLVhk6DR4DQ
         t6d3I2QhnBt+gMMZ3O2W5xg98xbswDST7srOdNXlBCWkZHcHyd6qjLCES4OwqW1nNEFy
         HUW/oT8Sr66MlqT1xraV1mT+z2/1pz6AuuapRfufrRkASzMXlwsZI3lCMFjpcThkDL4j
         KFIQ==
X-Gm-Message-State: AC+VfDyiIZo9aFNDSEHp31WIItM4kSnczAtJGdCxFvAFbX10XZXiO5zn
	oK1GxBTCqmS3v7ZqXxyf60BX2DgqQXWN67vP80UHqi8qCD9271ksZTJime+wRv1KihD2d9WdiNo
	oQS2NE/GyFlIB9bFVIg2V9b1I9cWNwz0+jJUI/Ktjkh2fhO47Ew==
X-Google-Smtp-Source: ACHHUZ7VGNbxGxKugstDwiOmh22Zunr5ER6sYPcB66gE7U+3ah2kFaRiKfY4mrkx8Gs25dLJ+rxmzLo=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a81:b710:0:b0:565:9f59:664f with SMTP id
 v16-20020a81b710000000b005659f59664fmr6699750ywh.6.1687366966479; Wed, 21 Jun
 2023 10:02:46 -0700 (PDT)
Date: Wed, 21 Jun 2023 10:02:33 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230621170244.1283336-1-sdf@google.com>
Subject: [RFC bpf-next v2 00/11] bpf: Netdev TX metadata
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	toke@kernel.org, willemb@google.com, dsahern@kernel.org, 
	magnus.karlsson@intel.com, bjorn@kernel.org, maciej.fijalkowski@intel.com, 
	brouer@redhat.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--- Changes since RFC v1 ---

- Support passing metadata via XSK
  - Showcase how to consume this metadata at TX in the selftests
- Sample untested mlx5 implementation
- Simplify attach/detach story with simple global fentry (Alexei)
- Add 'return 0' in xdp_metadata selftest (Willem)
- Add missing 'sizeof(*ip6h)' in xdp_hw_metadata selftest (Willem)
- Document 'timestamp' argument of kfunc (Simon)
- Not relevant due to attach/detach rework:
  - s/devtx_sb/devtx_submit/ in netdev (Willem)
  - s/devtx_cp/devtx_complete/ in netdev (Willem)
  - Document 'devtx_complete' and 'devtx_submit' in netdev (Simon)
  - Add devtx_sb/devtx_cp forward declaration (Simon)
  - Add missing __rcu/rcu_dereference annotations (Simon)

v1: https://lore.kernel.org/bpf/CAJ8uoz2zOHpBRfKhN97eR0VWipBTxnh=R9G57Z2UUujX4JzneQ@mail.gmail.com/T/#md354573364f75a8598e443dd51114b4feb4c3714

--- Use cases ---

The goal of this series is to add two new standard-ish places
in the transmit path:

1. Right before the packet is transmitted (with access to TX
   descriptors)
2. Right after the packet is actually transmitted and we've received the
   completion (again, with access to TX completion descriptors)

Accessing TX descriptors unlocks the following use-cases:

- Setting device hints at TX: XDP/AF_XDP might use these new hooks to
use device offloads. The existing case implements TX timestamp.
- Observability: global per-netdev hooks can be used for tracing
the packets and exploring completion descriptors for all sorts of
device errors.

Accessing TX descriptors also means that the hooks have to be called
from the drivers.

The hooks are a light-weight alternative to XDP at egress and currently
don't provide any packet modification abilities. However, eventually,
can expose new kfuncs to operate on the packet (or, rather, the actual
descriptors; for performance sake).

--- UAPI ---

The hooks are implemented in a HID-BPF style. Meaning they don't
expose any UAPI and are implemented as tracing programs that call
a bunch of kfuncs. The attach/detach operation happen via regular
global fentry points. Network namespace and ifindex are exposed
to allow filtering out particular netdev.

--- skb vs xdp ---

The hooks operate on a new light-weight devtx_frame which contains:
- data
- len
- metadata_len
- sinfo (frags)
- netdev

This should allow us to have a unified (from BPF POW) place at TX
and not be super-taxing (we need to copy 2 pointers + len to the stack
for each invocation).

--- TODO ---

Things that I'm planning to do for the non-RFC series:
- have some real device support to verify xdp_hw_metadata works
  - performance numbers with/without feature enabled (Toke)
- freplace
- explore dynptr (Toke)
- Documentation/networking/xdp-rx-metadata.rst - like documentation

--- CC ---

CC'ing people only on the cover letter. Hopefully can find the rest via
lore.

Cc: toke@kernel.org
Cc: willemb@google.com
Cc: dsahern@kernel.org
Cc: john.fastabend@gmail.com
Cc: magnus.karlsson@intel.com
Cc: bjorn@kernel.org
Cc: maciej.fijalkowski@intel.com
Cc: brouer@redhat.com
Cc: netdev@vger.kernel.org

Stanislav Fomichev (11):
  bpf: Rename some xdp-metadata functions into dev-bound
  bpf: Resolve single typedef when walking structs
  xsk: Support XDP_TX_METADATA_LEN
  bpf: Implement devtx hook points
  bpf: Implement devtx timestamp kfunc
  net: veth: Implement devtx timestamp kfuncs
  selftests/xsk: Support XDP_TX_METADATA_LEN
  selftests/bpf: Add helper to query current netns cookie
  selftests/bpf: Extend xdp_metadata with devtx kfuncs
  selftests/bpf: Extend xdp_hw_metadata with devtx kfuncs
  net/mlx5e: Support TX timestamp metadata

 MAINTAINERS                                   |   2 +
 .../net/ethernet/mellanox/mlx5/core/en/txrx.h |  11 +
 .../net/ethernet/mellanox/mlx5/core/en/xdp.c  |  96 ++++++++-
 .../net/ethernet/mellanox/mlx5/core/en/xdp.h  |   9 +-
 .../ethernet/mellanox/mlx5/core/en/xsk/tx.c   |   3 +
 .../net/ethernet/mellanox/mlx5/core/en_tx.c   |  16 ++
 .../net/ethernet/mellanox/mlx5/core/main.c    |  26 ++-
 drivers/net/veth.c                            | 116 +++++++++-
 include/linux/netdevice.h                     |   4 +
 include/net/devtx.h                           |  71 +++++++
 include/net/offload.h                         |  38 ++++
 include/net/xdp.h                             |  18 +-
 include/net/xdp_sock.h                        |   1 +
 include/net/xsk_buff_pool.h                   |   1 +
 include/uapi/linux/if_xdp.h                   |   1 +
 kernel/bpf/btf.c                              |   2 +
 kernel/bpf/offload.c                          |  49 ++++-
 kernel/bpf/verifier.c                         |   4 +-
 net/core/Makefile                             |   1 +
 net/core/dev.c                                |   1 +
 net/core/devtx.c                              | 149 +++++++++++++
 net/core/xdp.c                                |  20 +-
 net/xdp/xsk.c                                 |  31 ++-
 net/xdp/xsk_buff_pool.c                       |   1 +
 net/xdp/xsk_queue.h                           |   7 +-
 tools/testing/selftests/bpf/network_helpers.c |  21 ++
 tools/testing/selftests/bpf/network_helpers.h |   1 +
 .../selftests/bpf/prog_tests/xdp_metadata.c   |  62 +++++-
 .../selftests/bpf/progs/xdp_hw_metadata.c     | 107 ++++++++++
 .../selftests/bpf/progs/xdp_metadata.c        | 118 +++++++++++
 tools/testing/selftests/bpf/xdp_hw_metadata.c | 198 ++++++++++++++++--
 tools/testing/selftests/bpf/xdp_metadata.h    |  14 ++
 tools/testing/selftests/bpf/xsk.c             |  17 ++
 tools/testing/selftests/bpf/xsk.h             |   1 +
 34 files changed, 1142 insertions(+), 75 deletions(-)
 create mode 100644 include/net/devtx.h
 create mode 100644 include/net/offload.h
 create mode 100644 net/core/devtx.c

-- 
2.41.0.162.gfafddb0af9-goog


