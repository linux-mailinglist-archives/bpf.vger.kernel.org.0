Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA33E4D2B53
	for <lists+bpf@lfdr.de>; Wed,  9 Mar 2022 10:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbiCIJF5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Mar 2022 04:05:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbiCIJF4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Mar 2022 04:05:56 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88FDF1480E6
        for <bpf@vger.kernel.org>; Wed,  9 Mar 2022 01:04:58 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 2298HZXI004330
        for <bpf@vger.kernel.org>; Wed, 9 Mar 2022 01:04:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=xbCSjE8I8jtg3yJ2VAGqCf6FSQ63tZ745Df3HXPwf4Q=;
 b=TPTXqY6NX7E/NuGm2NU2rLDZfYIkdX99y4Fg85A+KDc7VMkdaJtWPZuebtHlTY8kvr/W
 Rbo2ItvqQgMTvYw/A0/h0KGm2J7POZ0PHO+mt5Z4q4vzurPuVBKXbPKHstW3SSdnup+g
 B6UmkVm7RFOsWxG6DLSrCHGZnzqzDxvRu3c= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3eprkf85w9-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 09 Mar 2022 01:04:57 -0800
Received: from twshared13345.18.frc3.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 9 Mar 2022 01:04:56 -0800
Received: by devbig933.frc1.facebook.com (Postfix, from userid 6611)
        id 1315F1ADC5CD; Wed,  9 Mar 2022 01:04:44 -0800 (PST)
From:   Martin KaFai Lau <kafai@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        <netdev@vger.kernel.org>
Subject: [PATCH bpf-next 0/5] bpf: Follow up on bpf __sk_buff->tstamp
Date:   Wed, 9 Mar 2022 01:04:44 -0800
Message-ID: <20220309090444.3710464-1-kafai@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: mcVvRTpPeqBeLkMWvCbQB84Dwj652VYg
X-Proofpoint-ORIG-GUID: mcVvRTpPeqBeLkMWvCbQB84Dwj652VYg
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-09_04,2022-03-04_01,2022-02-23_01
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This set is a follow up on the bpf side based on discussion [0].

Patch 1 is to remove some skbuff macros that are used in bpf filter.c

Patch 2 and 3 are to simplify the bpf insn rewrite on __sk_buff->tstamp.

Patch 4 is to simplify the bpf uapi by modeling the __sk_buff->tstamp
and __sk_buff->tstamp_type (was delivery_time_type) the same as its kernel
counter part skb->tstamp and skb->mono_delivery_time.

Patch 5 is to adjust the bpf selftests due to changes in patch 4.

[0]: https://lore.kernel.org/bpf/419d994e-ff61-7c11-0ec7-11fefcb0186e@iogea=
rbox.net/

Martin KaFai Lau (5):
  bpf: net: Remove TC_AT_INGRESS_OFFSET and
    SKB_MONO_DELIVERY_TIME_OFFSET macro
  bpf: Simplify insn rewrite on BPF_READ __sk_buff->tstamp
  bpf: Simplify insn rewrite on BPF_WRITE __sk_buff->tstamp
  bpf: Remove BPF_SKB_DELIVERY_TIME_NONE and rename
    s/delivery_time_/tstamp_/
  bpf: selftests: Update tests after s/delivery_time/tstamp/ change in
    bpf.h

 include/linux/filter.h                        |   2 +-
 include/linux/skbuff.h                        |  10 +-
 include/uapi/linux/bpf.h                      |  40 +++---
 net/core/filter.c                             | 133 ++++++++----------
 tools/include/uapi/linux/bpf.h                |  40 +++---
 .../selftests/bpf/progs/test_tc_dtime.c       |  38 ++---
 6 files changed, 125 insertions(+), 138 deletions(-)

--=20
2.30.2

