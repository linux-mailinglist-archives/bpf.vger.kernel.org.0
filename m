Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E86565819E8
	for <lists+bpf@lfdr.de>; Tue, 26 Jul 2022 20:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239606AbiGZSr6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Jul 2022 14:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbiGZSr5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Jul 2022 14:47:57 -0400
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847933341F
        for <bpf@vger.kernel.org>; Tue, 26 Jul 2022 11:47:56 -0700 (PDT)
Received: by devbig010.atn6.facebook.com (Postfix, from userid 115148)
        id D3436F834E7E; Tue, 26 Jul 2022 11:47:42 -0700 (PDT)
From:   Joanne Koong <joannelkoong@gmail.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, ast@kernel.org,
        Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH bpf-next v1 0/3] Add skb + xdp dynptrs
Date:   Tue, 26 Jul 2022 11:47:03 -0700
Message-Id: <20220726184706.954822-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=1.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,RDNS_DYNAMIC,
        SPF_HELO_PASS,SPF_SOFTFAIL,SPOOFED_FREEMAIL,SPOOF_GMAIL_MID,
        TVD_RCVD_IP autolearn=no autolearn_force=no version=3.4.6
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
vs. with dynptrs, there is no noticeable difference (see patch 3 for more
details).

[0] https://lore.kernel.org/bpf/20220523210712.3641569-1-joannelkoong@gma=
il.com/

Joanne Koong (3):
  bpf: Add skb dynptrs
  bpf: Add xdp dynptrs
  selftests/bpf: tests for using dynptrs to parse skb and xdp buffers

 include/linux/bpf.h                           |  14 ++-
 include/linux/filter.h                        |   7 ++
 include/uapi/linux/bpf.h                      |  58 ++++++++-
 kernel/bpf/helpers.c                          |  64 +++++++++-
 kernel/bpf/verifier.c                         |  48 +++++++-
 net/core/filter.c                             |  99 +++++++++++++--
 tools/include/uapi/linux/bpf.h                |  58 ++++++++-
 .../testing/selftests/bpf/prog_tests/dynptr.c |  85 ++++++++++---
 .../selftests/bpf/prog_tests/dynptr_xdp.c     |  49 ++++++++
 .../testing/selftests/bpf/progs/dynptr_fail.c |  76 ++++++++++++
 .../selftests/bpf/progs/dynptr_success.c      |  32 +++++
 .../selftests/bpf/progs/test_dynptr_xdp.c     | 115 ++++++++++++++++++
 .../selftests/bpf/progs/test_l4lb_noinline.c  |  71 +++++------
 tools/testing/selftests/bpf/progs/test_xdp.c  |  95 +++++++--------
 .../selftests/bpf/test_tcp_hdr_options.h      |   1 +
 15 files changed, 741 insertions(+), 131 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/dynptr_xdp.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_dynptr_xdp.c

--=20
2.30.2

