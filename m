Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A81699FE9
	for <lists+bpf@lfdr.de>; Thu, 16 Feb 2023 23:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjBPW4R (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Feb 2023 17:56:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjBPW4Q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Feb 2023 17:56:16 -0500
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E43F38EA8
        for <bpf@vger.kernel.org>; Thu, 16 Feb 2023 14:56:15 -0800 (PST)
Received: by devvm15675.prn0.facebook.com (Postfix, from userid 115148)
        id 2FF9A6A5C7F2; Thu, 16 Feb 2023 14:56:02 -0800 (PST)
From:   Joanne Koong <joannelkoong@gmail.com>
To:     bpf@vger.kernel.org
Cc:     martin.lau@kernel.org, andrii@kernel.org, memxor@gmail.com,
        ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        kernel-team@fb.com, Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH v10 bpf-next 0/9] Add skb + xdp dynptrs
Date:   Thu, 16 Feb 2023 14:55:15 -0800
Message-Id: <20230216225524.1192789-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=1.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,HELO_MISC_IP,NML_ADSP_CUSTOM_MED,
        RDNS_DYNAMIC,SPF_HELO_PASS,SPF_SOFTFAIL,SPOOFED_FREEMAIL,
        SPOOF_GMAIL_MID,TVD_RCVD_IP autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
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
vs. with dynptrs, there is no noticeable difference. Patch 9 contains mor=
e
details as well as examples of how to use skb and xdp dynptrs.

[0]
https://lore.kernel.org/bpf/20220523210712.3641569-1-joannelkoong@gmail.c=
om/

--
Changelog:

v9 =3D https://lore.kernel.org/bpf/20230127191703.3864860-1-joannelkoong@=
gmail.com/
v9 -> v10:
    * Add bpf_dynptr_slice and bpf_dynptr_slice_rdwr interface
    * Add some more tests
    * Split up patchset into more parts to make it easier to review

v8 =3D https://lore.kernel.org/bpf/20230126233439.3739120-1-joannelkoong@=
gmail.com/
v8 -> v9:
    * Fix dynptr_get_type() to check non-stack dynptrs=20

v7 =3D https://lore.kernel.org/bpf/20221021011510.1890852-1-joannelkoong@=
gmail.com/
v7 -> v8:
    * Change helpers to kfuncs
    * Add 2 new patches (1/5 and 2/5)

v6 =3D https://lore.kernel.org/bpf/20220907183129.745846-1-joannelkoong@g=
mail.com/
v6 -> v7
    * Change bpf_dynptr_data() to return read-only data slices if the skb=
 prog
      is read-only (Martin)
    * Add test "skb_invalid_write" to test that writes to rd-only data sl=
ices
      are rejected

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

Joanne Koong (9):
  bpf: Support "sk_buff" and "xdp_buff" as valid kfunc arg types
  bpf: Refactor process_dynptr_func
  bpf: Allow initializing dynptrs in kfuncs
  bpf: Define no-ops for externally called bpf dynptr functions
  bpf: Refactor verifier dynptr into get_dynptr_arg_reg
  bpf: Add skb dynptrs
  bpf: Add xdp dynptrs
  bpf: Add bpf_dynptr_slice and bpf_dynptr_slice_rdwr
  selftests/bpf: tests for using dynptrs to parse skb and xdp buffers

 include/linux/bpf.h                           |  95 +-
 include/linux/bpf_verifier.h                  |   3 -
 include/linux/filter.h                        |  46 +
 include/uapi/linux/bpf.h                      |  18 +-
 kernel/bpf/btf.c                              |  22 +
 kernel/bpf/helpers.c                          | 174 +++-
 kernel/bpf/verifier.c                         | 365 +++++--
 net/core/filter.c                             | 108 +-
 tools/include/uapi/linux/bpf.h                |  18 +-
 .../selftests/bpf/prog_tests/cls_redirect.c   |  25 +
 .../testing/selftests/bpf/prog_tests/dynptr.c |  69 +-
 .../selftests/bpf/prog_tests/l4lb_all.c       |   2 +
 .../bpf/prog_tests/parse_tcp_hdr_opt.c        |  93 ++
 .../selftests/bpf/prog_tests/xdp_attach.c     |  11 +-
 .../testing/selftests/bpf/progs/dynptr_fail.c | 274 ++++-
 .../selftests/bpf/progs/dynptr_success.c      |  51 +-
 .../bpf/progs/test_cls_redirect_dynptr.c      | 975 ++++++++++++++++++
 .../bpf/progs/test_l4lb_noinline_dynptr.c     | 486 +++++++++
 .../bpf/progs/test_parse_tcp_hdr_opt.c        | 119 +++
 .../bpf/progs/test_parse_tcp_hdr_opt_dynptr.c | 118 +++
 .../selftests/bpf/progs/test_xdp_dynptr.c     | 257 +++++
 .../selftests/bpf/test_tcp_hdr_options.h      |   1 +
 22 files changed, 3151 insertions(+), 179 deletions(-)
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

