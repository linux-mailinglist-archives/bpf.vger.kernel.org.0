Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0DB22F6302
	for <lists+bpf@lfdr.de>; Thu, 14 Jan 2021 15:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725961AbhANOYZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jan 2021 09:24:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbhANOYY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jan 2021 09:24:24 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79BD3C061574;
        Thu, 14 Jan 2021 06:23:44 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id x126so3421516pfc.7;
        Thu, 14 Jan 2021 06:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u429sj6w0ggj+oerUHboyj5VfZvaM/kq7mBHAogvXQ0=;
        b=OZcAWvVL/e5w1kb2sN0OTPBFQCiwxtbpL5xiEnHbujyrfYEuY/8D/0G6DsqTyRw2A8
         wG6x/hjF7Bitba1Hj3fHPjXftl3TZ8dIMnN+d3EfF/ebVYcl2m3dWcc1bEaHA/xlkp0e
         Chr5ER1eHE2IihifCSF6WyAd9WrJR83kPfrXV8uR67UDHFcF6J8W/YCOT8qfNvV5bDXG
         R9PR8LdsE+BUZsGh1ggO8KfTSqoWSy8LZ0c+ZXzELzOyj0UFaWd8uOms9RRCC/cWgVRi
         s5jnQq3zJitxolX2KkGxuuu97ihaMA9A9NXgc03cGBj/gwGtH4bxVy4CkOohARkRt0TU
         EEGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u429sj6w0ggj+oerUHboyj5VfZvaM/kq7mBHAogvXQ0=;
        b=o+zjwNmSVX+gdxU/Kt5vZGr+XcQ1NCWjIbP1DAoDXM4Myy/oxTp6/HCz0jrwNNHMCZ
         nIXsph7V6qgCr3jvqVGjmixxLmaqCPXDqnBuw05GJk0waQsBSl1kvOFFvfkYiy6wQsMC
         J4O0Ob7drED40b3CQ+yukWQLHFH0atVxgsREyvrCFul/gclFlab8ZoB9sBsVoUR6Cc35
         tvw0yWX0m570465V+5Djrk4uHkwq3+OerOCZwGCAnkmd9T5Tp+WbFMEDPPRmdWS62oGl
         XIJr8S/srBbZ9f8Byn2F/FhmNEkH5+clzWBlkfKjmxm3z7U31bSXYPI4//80ra+J2lrx
         6TQw==
X-Gm-Message-State: AOAM530MgvsSiBCz2aOaxLp6Qo6EQrR6da60lYthozyLW6/g4pUI2RN0
        jH/L4AUCG9fgSeX4TkfTFqpCY6C072uP4utJ
X-Google-Smtp-Source: ABdhPJxg3rtMLHyoVDDs7rlVEeZl5wb6qYIqib1Qx8v4nuoUEsx25LMUyr9H97tUgRyPIUkPAhUZ/Q==
X-Received: by 2002:a63:4404:: with SMTP id r4mr7756243pga.149.1610634223734;
        Thu, 14 Jan 2021 06:23:43 -0800 (PST)
Received: from Leo-laptop-t470s.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id t206sm5601827pgb.84.2021.01.14.06.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 06:23:43 -0800 (PST)
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
        Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv14 bpf-next 0/6] xdp: add a new helper for dev map multicast support
Date:   Thu, 14 Jan 2021 22:23:15 +0800
Message-Id: <20210114142321.2594697-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201221123505.1962185-1-liuhangbin@gmail.com>
References: <20201221123505.1962185-1-liuhangbin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch is for xdp multicast support. which has been discussed before[0],
The goal is to be able to implement an OVS-like data plane in XDP, i.e.,
a software switch that can forward XDP frames to multiple ports.

To achieve this, an application needs to specify a group of interfaces
to forward a packet to. It is also common to want to exclude one or more
physical interfaces from the forwarding operation - e.g., to forward a
packet to all interfaces in the multicast group except the interface it
arrived on. While this could be done simply by adding more groups, this
quickly leads to a combinatorial explosion in the number of groups an
application has to maintain.

To avoid the combinatorial explosion, we propose to include the ability
to specify an "exclude group" as part of the forwarding operation. This
needs to be a group (instead of just a single port index), because there
may have multi interfaces you want to exclude.

Thus, the logical forwarding operation becomes a "set difference"
operation, i.e. "forward to all ports in group A that are not also in
group B". This series implements such an operation using device maps to
represent the groups. This means that the XDP program specifies two
device maps, one containing the list of netdevs to redirect to, and the
other containing the exclude list.

To achieve this, I re-implement a new helper bpf_redirect_map_multi()
to accept two maps, the forwarding map and exclude map. If user
don't want to use exclude map and just want simply stop redirecting back
to ingress device, they can use flag BPF_F_EXCLUDE_INGRESS.

The 1st patch is Jesper's run devmap xdp_prog later in bulking step.
The 2st patch add a new bpf arg to allow NULL map pointer.
The 3rd patch add the new bpf_redirect_map_multi() helper.
The 4-6 patches are for usage sample and testing purpose.

I did same perf tests with the following topo:

---------------------             ---------------------
| Host A (i40e 10G) |  ---------- | eno1(i40e 10G)    |
---------------------             |                   |
                                  |   Host B          |
---------------------             |                   |
| Host C (i40e 10G) |  ---------- | eno2(i40e 10G)    |
---------------------    vlan2    |          -------- |
                                  | veth1 -- | veth0| |
                                  |          -------- |
                                  --------------------|
On Host A:
# pktgen/pktgen_sample03_burst_single_flow.sh -i eno1 -d $dst_ip -m $dst_mac -s 64

On Host B(Intel(R) Xeon(R) CPU E5-2690 v3 @ 2.60GHz, 128G Memory):
Use xdp_redirect_map and xdp_redirect_map_multi in samples/bpf for testing.
The veth0 in netns load dummy drop program. The forward_map max_entries in
xdp_redirect_map_multi is modify to 4.

Here is the perf result with 5.10 rc6:

The are about +/- 0.1M deviation for native testing
Version             | Test                                    | Generic | Native | Native + 2nd
5.10 rc6            | xdp_redirect_map        i40e->i40e      |    2.0M |   9.1M |  8.0M
5.10 rc6            | xdp_redirect_map        i40e->veth      |    1.7M |  11.0M |  9.7M
5.10 rc6 + patch1   | xdp_redirect_map        i40e->i40e      |    2.0M |   9.5M |  7.5M
5.10 rc6 + patch1   | xdp_redirect_map        i40e->veth      |    1.7M |  11.6M |  9.1M
5.10 rc6 + patch1-6 | xdp_redirect_map        i40e->i40e      |    2.0M |   9.5M |  7.5M
5.10 rc6 + patch1-6 | xdp_redirect_map        i40e->veth      |    1.7M |  11.6M |  9.1M
5.10 rc6 + patch1-6 | xdp_redirect_map_multi  i40e->i40e      |    1.7M |   7.8M |  6.4M
5.10 rc6 + patch1-6 | xdp_redirect_map_multi  i40e->veth      |    1.4M |   9.3M |  7.5M
5.10 rc6 + patch1-6 | xdp_redirect_map_multi  i40e->i40e+veth |    1.0M |   3.2M |  2.7M

Last but not least, thanks a lot to Toke, Jesper, Jiri and Eelco for
suggestions and help on implementation.

[0] https://xdp-project.net/#Handling-multicast

v14:
No code update, just rebase the code on latest bpf-next

v13:
Pass in xdp_prog through __xdp_enqueue() for patch 01. Update related
code in patch 03.

v12:
Add Jesper's xdp_prog patch, rebase my works on this and latest bpf-next
Add 2nd xdp_prog test on the sample and selftests.

v11:
Fix bpf_redirect_map_multi() helper description typo.
Add loop limit for devmap_get_next_obj() and dev_map_redirect_multi().

v10:
Rebase the code to latest bpf-next.
Update helper bpf_xdp_redirect_map_multi()
- No need to check map pointer as we will do the check in verifier.

v9:
Update helper bpf_xdp_redirect_map_multi()
- Use ARG_CONST_MAP_PTR_OR_NULL for helper arg2

v8:
a) Update function dev_in_exclude_map():
   - remove duplicate ex_map map_type check in
   - lookup the element in dev map by obj dev index directly instead
     of looping all the map

v7:
a) Fix helper flag check
b) Limit the *ex_map* to use DEVMAP_HASH only and update function
   dev_in_exclude_map() to get better performance.

v6: converted helper return types from int to long

v5:
a) Check devmap_get_next_key() return value.
b) Pass through flags to __bpf_tx_xdp_map() instead of bool value.
c) In function dev_map_enqueue_multi(), consume xdpf for the last
   obj instead of the first on.
d) Update helper description and code comments to explain that we
   use NULL target value to distinguish multicast and unicast
   forwarding.
e) Update memory model, memory id and frame_sz in xdpf_clone().
f) Split the tests from sample and add a bpf kernel selftest patch.

v4: Fix bpf_xdp_redirect_map_multi_proto arg2_type typo

v3: Based on Toke's suggestion, do the following update
a) Update bpf_redirect_map_multi() description in bpf.h.
b) Fix exclude_ifindex checking order in dev_in_exclude_map().
c) Fix one more xdpf clone in dev_map_enqueue_multi().
d) Go find next one in dev_map_enqueue_multi() if the interface is not
   able to forward instead of abort the whole loop.
e) Remove READ_ONCE/WRITE_ONCE for ex_map.

v2: Add new syscall bpf_xdp_redirect_map_multi() which could accept
include/exclude maps directly.

Hangbin Liu (5):
  bpf: add a new bpf argument type ARG_CONST_MAP_PTR_OR_NULL
  xdp: add a new helper for dev map multicast support
  sample/bpf: add xdp_redirect_map_multicast test
  selftests/bpf: Add verifier tests for bpf arg
    ARG_CONST_MAP_PTR_OR_NULL
  selftests/bpf: add xdp_redirect_multi test

Jesper Dangaard Brouer (1):
  bpf: run devmap xdp_prog on flush instead of bulk enqueue

 include/linux/bpf.h                           |  21 ++
 include/linux/filter.h                        |   1 +
 include/net/xdp.h                             |   1 +
 include/uapi/linux/bpf.h                      |  27 ++
 kernel/bpf/devmap.c                           | 235 +++++++++++---
 kernel/bpf/verifier.c                         |  16 +-
 net/core/filter.c                             | 118 ++++++-
 net/core/xdp.c                                |  29 ++
 samples/bpf/Makefile                          |   3 +
 samples/bpf/xdp_redirect_map_multi_kern.c     |  96 ++++++
 samples/bpf/xdp_redirect_map_multi_user.c     | 301 ++++++++++++++++++
 tools/include/uapi/linux/bpf.h                |  27 ++
 tools/testing/selftests/bpf/Makefile          |   3 +-
 .../bpf/progs/xdp_redirect_multi_kern.c       | 120 +++++++
 tools/testing/selftests/bpf/test_verifier.c   |  22 +-
 .../selftests/bpf/test_xdp_redirect_multi.sh  | 208 ++++++++++++
 .../testing/selftests/bpf/verifier/map_ptr.c  |  70 ++++
 .../selftests/bpf/xdp_redirect_multi.c        | 252 +++++++++++++++
 18 files changed, 1502 insertions(+), 48 deletions(-)
 create mode 100644 samples/bpf/xdp_redirect_map_multi_kern.c
 create mode 100644 samples/bpf/xdp_redirect_map_multi_user.c
 create mode 100644 tools/testing/selftests/bpf/progs/xdp_redirect_multi_kern.c
 create mode 100755 tools/testing/selftests/bpf/test_xdp_redirect_multi.sh
 create mode 100644 tools/testing/selftests/bpf/xdp_redirect_multi.c

-- 
2.26.2

