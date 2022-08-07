Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E94EF58BC1B
	for <lists+bpf@lfdr.de>; Sun,  7 Aug 2022 19:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiHGRvW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 7 Aug 2022 13:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiHGRvW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 7 Aug 2022 13:51:22 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E1F5FC7
        for <bpf@vger.kernel.org>; Sun,  7 Aug 2022 10:51:21 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 277BZwnR020629
        for <bpf@vger.kernel.org>; Sun, 7 Aug 2022 10:51:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=jKXT+rVpBlqp2JXkelPuE/zZ2SMit7phbnJ39HbmL7o=;
 b=VwCsID8K+uiInzo9ivXRtS/CfX2DUKyNrA/iLzor9MJql6xZGVCDJPOVZ/Dme0ypuLGC
 4t8OB6c13J1U1ebxAd7vooV4QtbWZmqANDClDCxZ1kVpHwqiEa4Y1VI811znH5mASNRD
 Rbzp3OKYJQqQzMq/0mXD8Ie62GIvJg8RSEc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net (PPS) with ESMTPS id 3hskywdu0j-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 07 Aug 2022 10:51:20 -0700
Received: from twshared8442.02.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Sun, 7 Aug 2022 10:51:19 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 3D268DC75998; Sun,  7 Aug 2022 10:51:11 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH bpf-next 0/3] bpf: Perform necessary sign/zero extension for kfunc return values
Date:   Sun, 7 Aug 2022 10:51:11 -0700
Message-ID: <20220807175111.4178812-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: lk_cQXhUeqzKjjSAiW5ddFeSF0ujFczW
X-Proofpoint-ORIG-GUID: lk_cQXhUeqzKjjSAiW5ddFeSF0ujFczW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-07_11,2022-08-05_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Tejun reported a bpf program kfunc return value mis-handling which
may cause incorrect result. If the kfunc return value is boolean
or u8, the bpf program produce incorrect results.

The main reason is due to mismatch of return value expectation between
native architecture and bpf. For example, for x86_64, if a kfunc
returns a u8, the kfunc returns 64-bit %rax, the top 56 bits might
be garbage. This is okay if the caller is x86_64 as the caller can
use special instruction to access lower 8-bit register %al. But this
will cause a problem for bpf program since bpf program assumes
the whole r0 register should contain correct value.
This patch set fixed the issue by doing necessary zero/sign extension
for the kfunc return value to meet bpf requirement.

For the rest of patches, Patch 1 is a preparation patch. Patch 2
implemented kernel support to perform necessary zero/sign extension
for kfunc return value. Patch 3 added two tests, one with return type
u8 and another with s16.

Yonghong Song (3):
  bpf: Always return corresponding btf_type in __get_type_size()
  bpf: Perform necessary sign/zero extension for kfunc return values
  selftests/bpf: Add tests with u8/s16 kfunc return types

 include/linux/bpf.h                           |  2 ++
 kernel/bpf/btf.c                              | 18 +++++++---
 kernel/bpf/verifier.c                         | 35 +++++++++++++++++--
 net/bpf/test_run.c                            | 12 +++++++
 .../selftests/bpf/prog_tests/kfunc_call.c     | 10 ++++++
 .../selftests/bpf/progs/kfunc_call_test.c     | 32 +++++++++++++++++
 6 files changed, 102 insertions(+), 7 deletions(-)

--=20
2.30.2

