Return-Path: <bpf+bounces-5352-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7327D759CDB
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 19:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A55C51C210B8
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 17:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA206156EC;
	Wed, 19 Jul 2023 17:54:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1DC111A9;
	Wed, 19 Jul 2023 17:54:30 +0000 (UTC)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC181FD6;
	Wed, 19 Jul 2023 10:54:28 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6689430d803so4910776b3a.0;
        Wed, 19 Jul 2023 10:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689789267; x=1692381267;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Aq63cH+2vWN8r8GoAJjjf2fe/B2RX+r8sebdEn2unOs=;
        b=pSoRDtjZW7frQqGuqZe4D2dXoCnJ8htyLwG2TzC6Y5P8DeY+oLtVDMcNUKKtrOSh/U
         OUP0w6jckw2YAxm597QpF+0yKFel6r5jxnWjIa8Y4MYzOiS8d0pVKWxG/LxMfxYcGx+v
         nABzZ4deKE9BnZqprPUCJLuu8jIpW7ny2vuqiS2DtOxm57rCxgRHftt4Vx6dvuJ5gjtm
         G+c28aXEQ5G0uiWrJ0Ri+5B1Ao8JfoMUN8j1UTYq6WdonvwNKH2G7tUPJnsSLuwo3I/R
         MzujDOJzBi+2MSvsFoE9paQci0MrC8+ckkgBNDyk15FCIiblpIcr7zHPXHHhT3mjx3Q2
         1srw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689789267; x=1692381267;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Aq63cH+2vWN8r8GoAJjjf2fe/B2RX+r8sebdEn2unOs=;
        b=AZjKlaDfNjoT6XiwlS4R+g1ufcZGrbdpXSEIyiHXcxTSRWPNPvcPdqk2YUc/TQGQOC
         Au19wPvZfEk2VG+9ob53VsZahjC/u1PRO/zJVXqAEoA2LzCSumBjeeV2gjhtYBwZkuo2
         28xbKk3eh2VPjd/bGlN7F5lpdykMzhA80ayWau+0G4baN3Pes6BSGpAsuPsPGoh2Mxa0
         U5oBNz/QCk8eEz3VgJcTe89h2YPONTTN5w9MciAOa8cd2ENamztKzjS8zoPuCgWtXANB
         uBhjT8VwdqXU1le1kD1Lb/0dsNOAECe7sNopQHO6657PmR3/nfL0DYLpnt8vWoaVtCP4
         5x6g==
X-Gm-Message-State: ABy/qLY2jegZmek8aark4T0oXrW2GTf9UZt57EnvQ86CVFPX6Cv+HnXF
	QEHm6aBI+M0t5VP/QniI+24=
X-Google-Smtp-Source: APBJJlHflSdKC22chEMPeiQo9UuM7vlhKqe6ELmG3+UT3axhPj/Zxrtk3YcBMeFkwb0eem5uqHCzcw==
X-Received: by 2002:a05:6a00:2d0b:b0:65b:351a:e70a with SMTP id fa11-20020a056a002d0b00b0065b351ae70amr3029612pfb.29.1689789267469;
        Wed, 19 Jul 2023 10:54:27 -0700 (PDT)
Received: from macbook-pro-8.dhcp.thefacebook.com ([2620:10d:c090:500::4:8907])
        by smtp.gmail.com with ESMTPSA id g7-20020aa78747000000b00682af93093dsm3533813pfo.45.2023.07.19.10.54.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 19 Jul 2023 10:54:26 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: davem@davemloft.net
Cc: kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	daniel@iogearbox.net,
	andrii@kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	kernel-team@fb.com
Subject: pull-request: bpf-next 2023-07-19
Date: Wed, 19 Jul 2023 10:54:24 -0700
Message-Id: <20230719175424.75717-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi David, hi Jakub, hi Paolo, hi Eric,

The following pull-request contains BPF updates for your *net-next* tree.

We've added 45 non-merge commits during the last 3 day(s) which contain
a total of 71 files changed, 7808 insertions(+), 592 deletions(-).

The main changes are:

1) multi-buffer support in AF_XDP, from Maciej Fijalkowski, Magnus Karlsson, Tirthendu Sarkar.

2) BPF link support for tc BPF programs, from Daniel Borkmann.

3) Enable bpf_map_sum_elem_count kfunc for all program types, from Anton Protopopov.

4) Add 'owner' field to bpf_rb_node to fix races in shared ownership, Dave Marchevsky.

5) Prevent potential skb_header_pointer() misuse, from Alexei Starovoitov.

There should be no merge conflicts.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/for-netdev

Thanks a lot!

Also thanks to reporters, reviewers and testers of commits in this pull-request:

Andrii Nakryiko, Dan Carpenter, Jakub Kicinski, Quentin Monnet

----------------------------------------------------------------

The following changes since commit 60cc1f7d0605598b47ee3c0c2b4b6fbd4da50a06:

  Merge branch 'phy-at803x-support' (2023-07-17 10:15:14 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/for-netdev

for you to fetch changes up to 6f5a630d7c57cd79b1f526a95e757311e32d41e5:

  bpf, net: Introduce skb_pointer_if_linear(). (2023-07-19 10:27:33 -0700)

----------------------------------------------------------------
for-netdev

----------------------------------------------------------------
Alan Maguire (1):
      bpf: sync tools/ uapi header with

Alexei Starovoitov (5):
      Merge branch 'bpf-refcount-followups-2-owner-field'
      Merge branch 'allow-bpf_map_sum_elem_count-for-all-program-types'
      Merge branch 'xsk-multi-buffer-support'
      Merge branch 'bpf-link-support-for-tc-bpf-programs'
      bpf, net: Introduce skb_pointer_if_linear().

Anh Tuan Phan (1):
      samples/bpf: README: Update build dependencies required

Anton Protopopov (4):
      bpf: consider types listed in reg2btf_ids as trusted
      bpf: consider CONST_PTR_TO_MAP as trusted pointer to struct bpf_map
      bpf: make an argument const in the bpf_map_sum_elem_count kfunc
      bpf: allow any program to use the bpf_map_sum_elem_count kfunc

Daniel Borkmann (8):
      bpf: Add generic attach/detach/query API for multi-progs
      bpf: Add fd-based tcx multi-prog infra with link support
      libbpf: Add opts-based attach/detach/query API for tcx
      libbpf: Add link-based API for tcx
      libbpf: Add helper macro to clear opts structs
      bpftool: Extend net dump with tcx progs
      selftests/bpf: Add mprog API tests for BPF tcx opts
      selftests/bpf: Add mprog API tests for BPF tcx links

Dave Marchevsky (4):
      bpf: Introduce internal definitions for UAPI-opaque bpf_{rb,list}_node
      bpf: Add 'owner' field to bpf_{list,rb}_node
      selftests/bpf: Add rbtree test exercising race which 'owner' field prevents
      selftests/bpf: Disable newly-added 'owner' field test until refcount re-enabled

Geliang Tang (1):
      bpf: Drop useless btf_vmlinux in bpf_tcp_ca

Maciej Fijalkowski (8):
      xsk: prepare both copy and zero-copy modes to co-exist
      xsk: allow core/drivers to test EOP bit
      xsk: add new netlink attribute dedicated for ZC max frags
      xsk: support mbuf on ZC RX
      ice: xsk: add RX multi-buffer support
      xsk: support ZC Tx multi-buffer in batch API
      ice: xsk: Tx multi-buffer support
      selftests/xsk: reset NIC settings to default after running test suite

Magnus Karlsson (7):
      xsk: add multi-buffer documentation
      selftests/xsk: transmit and receive multi-buffer packets
      selftests/xsk: add basic multi-buffer test
      selftests/xsk: add unaligned mode test for multi-buffer
      selftests/xsk: add invalid descriptor test for multi-buffer
      selftests/xsk: add metadata copy test for multi-buff
      selftests/xsk: add test for too many frags

Menglong Dong (1):
      bpf, x86: initialize the variable "first_off" in save_args()

Tirthendu Sarkar (9):
      xsk: prepare 'options' in xdp_desc for multi-buffer use
      xsk: introduce XSK_USE_SG bind flag for xsk socket
      xsk: move xdp_buff's data length check to xsk_rcv_check
      xsk: add support for AF_XDP multi-buffer on Rx path
      xsk: introduce wrappers and helpers for supporting multi-buffer in Tx path
      xsk: add support for AF_XDP multi-buffer on Tx path
      xsk: discard zero length descriptors in Tx path
      i40e: xsk: add RX multi-buffer support
      i40e: xsk: add TX multi-buffer support

 Documentation/netlink/specs/netdev.yaml            |    6 +
 Documentation/networking/af_xdp.rst                |  211 +-
 MAINTAINERS                                        |    5 +-
 arch/x86/net/bpf_jit_comp.c                        |    2 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c        |    6 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c        |    4 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.h        |    2 +
 drivers/net/ethernet/intel/i40e/i40e_xsk.c         |  101 +-
 drivers/net/ethernet/intel/ice/ice_base.c          |    9 +-
 drivers/net/ethernet/intel/ice/ice_main.c          |    1 +
 drivers/net/ethernet/intel/ice/ice_xsk.c           |  221 +-
 include/linux/bpf.h                                |   12 +
 include/linux/bpf_mprog.h                          |  327 +++
 include/linux/btf_ids.h                            |    1 +
 include/linux/netdevice.h                          |   16 +-
 include/linux/skbuff.h                             |   14 +-
 include/net/sch_generic.h                          |    2 +-
 include/net/tcx.h                                  |  206 ++
 include/net/xdp_sock.h                             |    7 +
 include/net/xdp_sock_drv.h                         |   54 +
 include/net/xsk_buff_pool.h                        |    7 +
 include/uapi/linux/bpf.h                           |   72 +-
 include/uapi/linux/if_xdp.h                        |   13 +
 include/uapi/linux/netdev.h                        |    1 +
 kernel/bpf/Kconfig                                 |    1 +
 kernel/bpf/Makefile                                |    3 +-
 kernel/bpf/helpers.c                               |   55 +-
 kernel/bpf/map_iter.c                              |    7 +-
 kernel/bpf/mprog.c                                 |  445 ++++
 kernel/bpf/syscall.c                               |   82 +-
 kernel/bpf/tcx.c                                   |  348 +++
 kernel/bpf/verifier.c                              |   22 +-
 net/Kconfig                                        |    5 +
 net/core/dev.c                                     |  266 ++-
 net/core/filter.c                                  |   11 +-
 net/core/netdev-genl.c                             |    8 +
 net/ipv4/bpf_tcp_ca.c                              |    2 -
 net/sched/Kconfig                                  |    4 +-
 net/sched/sch_ingress.c                            |   61 +-
 net/xdp/xsk.c                                      |  365 +++-
 net/xdp/xsk_buff_pool.c                            |    7 +
 net/xdp/xsk_queue.h                                |   95 +-
 samples/bpf/README.rst                             |   14 +-
 tools/bpf/bpftool/Documentation/bpftool-net.rst    |   26 +-
 tools/bpf/bpftool/net.c                            |   98 +-
 tools/bpf/bpftool/netlink_dumper.h                 |    8 +
 tools/include/uapi/linux/bpf.h                     |   72 +-
 tools/include/uapi/linux/if_xdp.h                  |    9 +
 tools/include/uapi/linux/netdev.h                  |    1 +
 tools/lib/bpf/bpf.c                                |  127 +-
 tools/lib/bpf/bpf.h                                |   97 +-
 tools/lib/bpf/libbpf.c                             |   70 +-
 tools/lib/bpf/libbpf.h                             |   18 +-
 tools/lib/bpf/libbpf.map                           |    2 +
 tools/lib/bpf/libbpf_common.h                      |   16 +
 tools/lib/bpf/netlink.c                            |    5 +
 .../testing/selftests/bpf/prog_tests/linked_list.c |   78 +-
 .../selftests/bpf/prog_tests/refcounted_kptr.c     |    4 +
 .../testing/selftests/bpf/prog_tests/tc_helpers.h  |   72 +
 tools/testing/selftests/bpf/prog_tests/tc_links.c  | 1583 ++++++++++++++
 tools/testing/selftests/bpf/prog_tests/tc_opts.c   | 2239 ++++++++++++++++++++
 tools/testing/selftests/bpf/progs/map_ptr_kern.c   |    5 +
 .../testing/selftests/bpf/progs/refcounted_kptr.c  |   94 +-
 tools/testing/selftests/bpf/progs/test_tc_link.c   |   40 +
 tools/testing/selftests/bpf/progs/xsk_xdp_progs.c  |    6 +-
 tools/testing/selftests/bpf/test_xsk.sh            |    5 +
 tools/testing/selftests/bpf/xsk.c                  |  136 +-
 tools/testing/selftests/bpf/xsk.h                  |    2 +
 tools/testing/selftests/bpf/xsk_prereqs.sh         |    7 +
 tools/testing/selftests/bpf/xskxceiver.c           |  458 +++-
 tools/testing/selftests/bpf/xskxceiver.h           |   21 +-
 71 files changed, 7808 insertions(+), 592 deletions(-)
 create mode 100644 include/linux/bpf_mprog.h
 create mode 100644 include/net/tcx.h
 create mode 100644 kernel/bpf/mprog.c
 create mode 100644 kernel/bpf/tcx.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tc_helpers.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tc_links.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tc_opts.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_tc_link.c

