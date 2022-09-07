Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7905B0C8B
	for <lists+bpf@lfdr.de>; Wed,  7 Sep 2022 20:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbiIGSf5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Sep 2022 14:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiIGSf4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Sep 2022 14:35:56 -0400
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A53BD0B2
        for <bpf@vger.kernel.org>; Wed,  7 Sep 2022 11:35:54 -0700 (PDT)
Received: by devbig010.atn6.facebook.com (Postfix, from userid 115148)
        id 61C0F116DA0E3; Wed,  7 Sep 2022 11:32:47 -0700 (PDT)
From:   Joanne Koong <joannelkoong@gmail.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, ast@kernel.org,
        martin.lau@kernel.org, kuba@kernel.org, memxor@gmail.com,
        toke@redhat.com, netdev@vger.kernel.org, kernel-team@fb.com,
        Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH bpf-next v6 0/3] Add skb + xdp dynptrs
Date:   Wed,  7 Sep 2022 11:31:26 -0700
Message-Id: <20220907183129.745846-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=3.3 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,RDNS_DYNAMIC,
        SPF_HELO_PASS,SPF_SOFTFAIL,SPOOFED_FREEMAIL,SPOOF_GMAIL_MID,
        TVD_RCVD_IP,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patchset is the 2nd in the dynptr series. The 1st can be found here =
[0].

This patchset adds skb and xdp type dynptrs, which have two main benefits=
 for
packet parsing:
    * allowing operations on sizes that are not statically known at
      compile-time (eg variable-sized accesses).
    * more ergonomic and less brittle iteration through data (eg does not=
 need
      manual if checking for being within bounds of data_end)

When comparing the differences in runtime for packet parsing without dynp=
trs
vs. with dynptrs for the more simple cases, there is no noticeable differ=
ence.
For the more complex cases where lengths are non-statically known at comp=
ile
time, there can be a significant speed-up when using dynptrs (eg a 2x spe=
ed up
for cls redirection). Patch 3 contains more details as well as examples o=
f how
to use skb and xdp dynptrs.

[0] https://lore.kernel.org/bpf/20220523210712.3641569-1-joannelkoong@gma=
il.com/

--
Changelog:

v5 =3D https://lore.kernel.org/bpf/20220831183224.3754305-1-joannelkoong@=
gmail.com/
v5 -> v6
    * Address kernel test robot errors by static inlining

v4 =3D https://lore.kernel.org/bpf/20220822235649.2218031-1-joannelkoong@=
gmail.com/
v4 -> v5
    * Address kernel test robot errors for configs w/out CONFIG_NET set
    * For data slices, return PTR_TO_MEM instead of PTR_TO_PACKET (Kumar)
    * Split selftests into subtests (Andrii)
    * Remove insn patching. Use rdonly and rdwr protos for dynptr skb
      construction (Andrii)
    * bpf_dynptr_data() returns NULL for rd-only dynptrs. There will be a
      separate bpf_dynptr_data_rdonly() added later (Andrii and Kumar)

v3 =3D https://lore.kernel.org/bpf/20220822193442.657638-1-joannelkoong@g=
mail.com/
v3 -> v4
    * Forgot to commit --amend the kernel test robot error fixups

v2 =3D https://lore.kernel.org/bpf/20220811230501.2632393-1-joannelkoong@=
gmail.com/
v2 -> v3
    * Fix kernel test robot build test errors

v1 =3D https://lore.kernel.org/bpf/20220726184706.954822-1-joannelkoong@g=
mail.com/
v1 -> v2
  * Return data slices to rd-only skb dynptrs (Martin)
  * bpf_dynptr_write allows writes to frags for skb dynptrs, but always
    invalidates associated data slices (Martin)
  * Use switch casing instead of ifs (Andrii)
  * Use 0xFD for experimental kind number in the selftest (Zvi)
  * Put selftest conversions w/ dynptrs into new files (Alexei)
  * Add new selftest "test_cls_redirect_dynptr.c"=20

Joanne Koong (3):
  bpf: Add skb dynptrs
  bpf: Add xdp dynptrs
  selftests/bpf: tests for using dynptrs to parse skb and xdp buffers

 include/linux/bpf.h                           |  86 +-
 include/linux/filter.h                        |  38 +
 include/uapi/linux/bpf.h                      |  62 +-
 kernel/bpf/helpers.c                          |  83 +-
 kernel/bpf/verifier.c                         |  96 +-
 net/core/filter.c                             | 118 ++-
 tools/include/uapi/linux/bpf.h                |  62 +-
 .../selftests/bpf/prog_tests/cls_redirect.c   |  25 +
 .../testing/selftests/bpf/prog_tests/dynptr.c |  73 +-
 .../selftests/bpf/prog_tests/l4lb_all.c       |   2 +
 .../bpf/prog_tests/parse_tcp_hdr_opt.c        |  93 ++
 .../selftests/bpf/prog_tests/xdp_attach.c     |  11 +-
 .../testing/selftests/bpf/progs/dynptr_fail.c |  92 ++
 .../selftests/bpf/progs/dynptr_success.c      |  32 +
 .../bpf/progs/test_cls_redirect_dynptr.c      | 968 ++++++++++++++++++
 .../bpf/progs/test_l4lb_noinline_dynptr.c     | 469 +++++++++
 .../bpf/progs/test_parse_tcp_hdr_opt.c        | 119 +++
 .../bpf/progs/test_parse_tcp_hdr_opt_dynptr.c | 110 ++
 .../selftests/bpf/progs/test_xdp_dynptr.c     | 235 +++++
 .../selftests/bpf/test_tcp_hdr_options.h      |   1 +
 20 files changed, 2689 insertions(+), 86 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/parse_tcp_hdr_=
opt.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_cls_redirect_d=
ynptr.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_l4lb_noinline_=
dynptr.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_parse_tcp_hdr_=
opt.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_parse_tcp_hdr_=
opt_dynptr.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_xdp_dynptr.c

--=20
2.30.2

