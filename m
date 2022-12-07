Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B18A964631B
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 22:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbiLGVNd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 16:13:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiLGVNa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 16:13:30 -0500
X-Greylist: delayed 989 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 07 Dec 2022 13:13:26 PST
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F3C11A1A
        for <bpf@vger.kernel.org>; Wed,  7 Dec 2022 13:13:26 -0800 (PST)
Received: by devvm15675.prn0.facebook.com (Postfix, from userid 115148)
        id E1181135537B; Wed,  7 Dec 2022 12:56:43 -0800 (PST)
From:   Joanne Koong <joannelkoong@gmail.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, kernel-team@meta.com, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH v2 bpf-next 0/6] Dynptr convenience helpers
Date:   Wed,  7 Dec 2022 12:55:31 -0800
Message-Id: <20221207205537.860248-1-joannelkoong@gmail.com>
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

This patchset is the 3rd in the dynptr series. The 1st can be found here =
[0]
and the 2nd can be found here [1].

In this patchset, the following convenience helpers are added for interac=
ting
with bpf dynamic pointers:

    * bpf_dynptr_data_rdonly
    * bpf_dynptr_trim
    * bpf_dynptr_advance
    * bpf_dynptr_is_null
    * bpf_dynptr_is_rdonly
    * bpf_dynptr_get_size
    * bpf_dynptr_get_offset
    * bpf_dynptr_clone
    * bpf_dynptr_iterator

Querying dynptr information is abstracted to helper functions instead of =
directly
exposing bpf_dynptr internals because this avoids imposing restrictions o=
n the
dynptr struct in the case of any future modifications, as well as consoli=
dates
any logic for parsing the fields to one place.

In the future, some of these convenience helper calls will be inlined.

Please note that this patchset will be rebased on top of dynptr refactori=
ng/fixes
once that is landed upstream.

[0] https://lore.kernel.org/bpf/20220523210712.3641569-1-joannelkoong@gma=
il.com/
[1] https://lore.kernel.org/bpf/20221021011510.1890852-1-joannelkoong@gma=
il.com/


v1 -> v2:
v1: https://lore.kernel.org/bpf/20220908000254.3079129-1-joannelkoong@gma=
il.com/
* Drop patch adding "bpf_dynptr_data_rdonly"
* Add offset arg for bpf_dynptr_clone, to advance offset for cloned dynpt=
r
* bpf_dynptr_iterator operates on a cloned dynptr instead of the original=
 (Kumar,Andrii) =20

Joanne Koong (6):
  bpf: Add bpf_dynptr_trim and bpf_dynptr_advance
  bpf: Add bpf_dynptr_is_null and bpf_dynptr_is_rdonly
  bpf: Add bpf_dynptr_get_size and bpf_dynptr_get_offset
  bpf: Add bpf_dynptr_clone
  bpf: Add bpf_dynptr_iterator
  selftests/bpf: Tests for dynptr convenience helpers

 include/linux/bpf.h                           |   2 +-
 include/uapi/linux/bpf.h                      | 114 ++++
 kernel/bpf/helpers.c                          | 218 ++++++-
 kernel/bpf/verifier.c                         | 205 +++++--
 kernel/trace/bpf_trace.c                      |   4 +-
 scripts/bpf_doc.py                            |   3 +
 tools/include/uapi/linux/bpf.h                | 114 ++++
 .../testing/selftests/bpf/prog_tests/dynptr.c |  31 +
 .../testing/selftests/bpf/progs/dynptr_fail.c | 439 ++++++++++++++
 .../selftests/bpf/progs/dynptr_success.c      | 534 +++++++++++++++++-
 10 files changed, 1601 insertions(+), 63 deletions(-)

--=20
2.30.2

