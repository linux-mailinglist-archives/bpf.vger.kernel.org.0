Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09170631614
	for <lists+bpf@lfdr.de>; Sun, 20 Nov 2022 20:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiKTTyh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 20 Nov 2022 14:54:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiKTTyg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 20 Nov 2022 14:54:36 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED503EE02
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 11:54:35 -0800 (PST)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 2AKFORDj031703
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 11:54:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=ER+Gl/R8MkBpY+ShDzHspE1TnpAqnz5dKqo8F0cOJSU=;
 b=dPh6dTZEDSVUEUeZyCG2Gd3Yn0J0vLbyk0+jQNFCiCLSvtLaUkQAiws3ZH6hUHZncz/w
 mcUjtF28pDizfCpsp5wSldwnxlW/aO0TaZo8Wrvk/gH/v5FwrvtWVirJCUTDYF2IWdeD
 dG7FSFgWBm8+B+uaFyK1YCY0oKOZpjcIBCo= 
Received: from maileast.thefacebook.com ([163.114.130.8])
        by m0001303.ppops.net (PPS) with ESMTPS id 3kxuq08eww-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 11:54:35 -0800
Received: from twshared3131.02.ash7.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 20 Nov 2022 11:54:34 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id A518612774411; Sun, 20 Nov 2022 11:54:21 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        <kernel-team@fb.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v4 0/4] bpf: Implement two type cast kfuncs
Date:   Sun, 20 Nov 2022 11:54:21 -0800
Message-ID: <20221120195421.3112414-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: D5E3_0MsDFveyT1WKP5FW2PNz8EBxXs2
X-Proofpoint-GUID: D5E3_0MsDFveyT1WKP5FW2PNz8EBxXs2
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-20_13,2022-11-18_01,2022-06-22_01
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currenty, a non-tracing bpf program typically has a single 'context' argume=
nt
with predefined uapi struct type. Following these uapi struct, user is able
to access other fields defined in uapi header. Inside the kernel, the
user-seen 'context' argument is replaced with 'kernel context' (or 'kctx'
in short) which can access more information than what uapi header provides.
To access other info not in uapi header, people typically do two things:
  (1). extend uapi to access more fields rooted from 'context'.
  (2). use bpf_probe_read_kernl() helper to read particular field based on
    kctx.
Using (1) needs uapi change and using (2) makes code more complex since
direct memory access is not allowed.

There are already a few instances trying to access more information from
kctx:
  . trying to access some fields from perf_event kctx ([1]).
  . trying to access some fields from xdp kctx ([2]).

This patch set tried to allow direct memory access for kctx fields
by introducing bpf_cast_to_kern_ctx() kfunc.

Martin mentioned a use case like type casting below:
  #define skb_shinfo(SKB) ((struct skb_shared_info *)(skb_end_pointer(SKB)))
basically a 'unsigned char *" casted to 'struct skb_shared_info *'. This pa=
tch
set tries to support such a use case as well with bpf_rdonly_cast().

For the patch series, Patch 1 added support for a kfunc available to all
prog types. Patch 2 added bpf_cast_to_kern_ctx() kfunc. Patch 3 added
bpf_rdonly_cast() kfunc. Patch 4 added a few positive and negative tests.

  [1] https://lore.kernel.org/bpf/ad15b398-9069-4a0e-48cb-4bb651ec3088@meta=
.com/
  [2] https://lore.kernel.org/bpf/20221109215242.1279993-1-john.fastabend@g=
mail.com/

Changelog:
  v3 -> v4:
    - remove unnecessary bpf_ctx_convert.t error checking
    - add and use meta.ret_btf_id instead of meta.arg_constant.value for
      bpf_cast_to_kern_ctx().
    - add PTR_TRUSTED to the return PTR_TO_BTF_ID type for bpf_cast_to_kern=
_ctx().
  v2 -> v3:
    - rebase on top of bpf-next (for merging conflicts)
    - add the selftest to s390x deny list
  rfcv1 -> v2:
    - break original one kfunc into two.
    - add missing error checks and error logs.
    - adapt to the new conventions in
      https://lore.kernel.org/all/20221118015614.2013203-1-memxor@gmail.com/
      for example, with __ign and __k suffix.
    - added support in fixup_kfunc_call() to replace kfunc calls with a sin=
gle mov.

Yonghong Song (4):
  bpf: Add support for kfunc set with common btf_ids
  bpf: Add a kfunc to type cast from bpf uapi ctx to kernel ctx
  bpf: Add a kfunc for generic type cast
  bpf: Add type cast unit tests

 include/linux/btf.h                           |   5 +
 kernel/bpf/btf.c                              |  28 +++++
 kernel/bpf/helpers.c                          |  24 +++-
 kernel/bpf/verifier.c                         |  46 ++++++-
 tools/testing/selftests/bpf/DENYLIST.s390x    |   1 +
 .../selftests/bpf/prog_tests/type_cast.c      | 114 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/type_cast.c |  83 +++++++++++++
 7 files changed, 299 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/type_cast.c
 create mode 100644 tools/testing/selftests/bpf/progs/type_cast.c

--=20
2.30.2

