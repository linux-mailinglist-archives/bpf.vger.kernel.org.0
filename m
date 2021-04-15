Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC72360B11
	for <lists+bpf@lfdr.de>; Thu, 15 Apr 2021 15:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233186AbhDONyB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Apr 2021 09:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233059AbhDONyA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Apr 2021 09:54:00 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039BAC061574;
        Thu, 15 Apr 2021 06:53:37 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id p16so8136252plf.12;
        Thu, 15 Apr 2021 06:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wJRegN5GQuH5b9gAz36NB95gQyRO3U7EOZr5gw35MIw=;
        b=MR/LD/TvTdYKM8tDwNz85uYaYZOZLlXxKWr5piX7M+jSs3YtW5BS3oybQSLGom7bxh
         ttRFntHyUDJHoHFM2KKJc3XfSGUT5FPLcQ6JZwtPF3aHSxSe6nWNakY+t5YjJZMfh3YM
         IiVg44tTq6wNyKUYCrHPnRuEpUF94ME30Z6cUC8nheUSgf85pT4SCQm8imXvDfPxmDvR
         kXQPRzWKVcuk83zPtiXS06ww4NUH+2O7WIPVvZqeOWvI3KlPt8X8mzLNwGEPGj6Lbi4s
         xXCjAEzIQ53Gnwhx+yRQ/ahKBXsOfV68SNmbK3Yd6tWzF169nrLNI/2QQAsqmjBsUp5H
         zHRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wJRegN5GQuH5b9gAz36NB95gQyRO3U7EOZr5gw35MIw=;
        b=BjvBqKWwNCLVUA/idjGS0K8OwapMibu+s90UePFfrNzZblxS5JW2dfz1VK4oqDMama
         /jvqqIEgrF/dA0a5k44kIiYKTw0k4xthjSdp2fTWOdxXuunADti9NFm/ZsFmKTFuPNIl
         aBSwnpr8YgKuBUkwHa8R3Vtq5k3YePmgJgBPwJTNkCFUeOjuehUwdwl1cDxCCFnTjl5e
         6qCIrDQmHblUx2dx2b+U5KB3Ls4dZtMp/ds5cy7X07S4S6v4viHJHScfnHawNNfgUV71
         q68hty947g+mykwcdu8lNYhCDYkRIHobsqv2FAKUeor0k8emAQFGxIX/+MA8oABd0iJL
         FYog==
X-Gm-Message-State: AOAM533XIsR0aNFqOIA4IumPa2vWVztFZgDCfS1fi6PSOjb+Fa/5E9B3
        7DlhymZQgTk4aScjlQCIWyuYn0IIThc=
X-Google-Smtp-Source: ABdhPJxu4OlVrgIOw/QyM7bnbGcZT+IvNaZ/B0kOfmir6YJ3wNWceJhBIPenshyywCmMyb/2uYFVIA==
X-Received: by 2002:a17:90a:17a3:: with SMTP id q32mr4100552pja.224.1618494816267;
        Thu, 15 Apr 2021 06:53:36 -0700 (PDT)
Received: from Leo-laptop-t470s.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id h16sm2324868pfo.191.2021.04.15.06.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 06:53:35 -0700 (PDT)
From:   Hangbin Liu <liuhangbin@gmail.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jiri Benc <jbenc@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Eelco Chaudron <echaudro@redhat.com>, ast@kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        David Ahern <dsahern@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv8 bpf-next 0/4] xdp: extend xdp_redirect_map with broadcast support
Date:   Thu, 15 Apr 2021 21:53:16 +0800
Message-Id: <20210415135320.4084595-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

This patchset is a new implementation for XDP multicast support based
on my previous 2 maps implementation[1]. The reason is that Daniel think
the exclude map implementation is missing proper bond support in XDP
context. And there is a plan to add native XDP bonding support. Adding a
exclude map in the helper also increase the complex of verifier and has
draw back of performace.

The new implementation just add two new flags BPF_F_BROADCAST and
BPF_F_EXCLUDE_INGRESS to extend xdp_redirect_map for broadcast support.

With BPF_F_BROADCAST the packet will be broadcasted to all the interfaces
in the map. with BPF_F_EXCLUDE_INGRESS the ingress interface will be
excluded when do broadcasting.

The patchv7 link is here[2].

[1] https://lore.kernel.org/bpf/20210223125809.1376577-1-liuhangbin@gmail.com
[2] https://lore.kernel.org/bpf/20210414122610.4037085-1-liuhangbin@gmail.com

v8: use hlist_for_each_entry_rcu() when looping the devmap hash ojbs
v7: No need to free xdpf in dev_map_enqueue_clone() if xdpf_clone failed.
v6: Fix a skb leak in the error path for generic XDP
v5: Just walk the map directly to get interfaces as get_next_key() of devmap
    hash may restart looping from the first key if the device get removed.
    After update the performace has improved 10% compired with v4.
v4: Fix flags never cleared issue in patch 02. Update selftest to cover this.
v3: Rebase the code based on latest bpf-next
v2: fix flag renaming issue in patch 02

Hangbin Liu (3):
  xdp: extend xdp_redirect_map with broadcast support
  sample/bpf: add xdp_redirect_map_multi for redirect_map broadcast test
  selftests/bpf: add xdp_redirect_multi test

Jesper Dangaard Brouer (1):
  bpf: run devmap xdp_prog on flush instead of bulk enqueue

 include/linux/bpf.h                           |  20 ++
 include/linux/filter.h                        |  18 +-
 include/net/xdp.h                             |   1 +
 include/uapi/linux/bpf.h                      |  17 +-
 kernel/bpf/cpumap.c                           |   3 +-
 kernel/bpf/devmap.c                           | 304 +++++++++++++++---
 net/core/filter.c                             |  33 +-
 net/core/xdp.c                                |  29 ++
 net/xdp/xskmap.c                              |   3 +-
 samples/bpf/Makefile                          |   3 +
 samples/bpf/xdp_redirect_map_multi_kern.c     |  87 +++++
 samples/bpf/xdp_redirect_map_multi_user.c     | 302 +++++++++++++++++
 tools/include/uapi/linux/bpf.h                |  17 +-
 tools/testing/selftests/bpf/Makefile          |   3 +-
 .../bpf/progs/xdp_redirect_multi_kern.c       |  99 ++++++
 .../selftests/bpf/test_xdp_redirect_multi.sh  | 205 ++++++++++++
 .../selftests/bpf/xdp_redirect_multi.c        | 236 ++++++++++++++
 17 files changed, 1316 insertions(+), 64 deletions(-)
 create mode 100644 samples/bpf/xdp_redirect_map_multi_kern.c
 create mode 100644 samples/bpf/xdp_redirect_map_multi_user.c
 create mode 100644 tools/testing/selftests/bpf/progs/xdp_redirect_multi_kern.c
 create mode 100755 tools/testing/selftests/bpf/test_xdp_redirect_multi.sh
 create mode 100644 tools/testing/selftests/bpf/xdp_redirect_multi.c

-- 
2.26.3

