Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04CE364187A
	for <lists+bpf@lfdr.de>; Sat,  3 Dec 2022 19:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbiLCSqK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 3 Dec 2022 13:46:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbiLCSqJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 3 Dec 2022 13:46:09 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD34617E1E
        for <bpf@vger.kernel.org>; Sat,  3 Dec 2022 10:46:04 -0800 (PST)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B3BAWQW002698
        for <bpf@vger.kernel.org>; Sat, 3 Dec 2022 10:46:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=Z9WvXzK/+Oi5dBHEgsoI8cwkMIde4JrepZTCZFFaEQQ=;
 b=MgsClgMA0judgFPYhsWoz97XThL+6TCHyTZuIpwbP+3JXYXLwDgO/ROe0EIKMjorn3lS
 uz+CWdn4xSSaN9HfeCKLaCpM4ZtE1D1grpexgqOfQSnCC4F3nEvpfT4lb9SngsG2WTas
 9gtY3xKvLCzT15uLDKQ/Ijue7ZfviJ/i5do= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3m8560t5tq-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sat, 03 Dec 2022 10:46:03 -0800
Received: from twshared16963.27.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 3 Dec 2022 10:46:02 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 4F01F1320E68E; Sat,  3 Dec 2022 10:45:57 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v2 0/3] bpf: Handle MEM_RCU type properly
Date:   Sat, 3 Dec 2022 10:45:57 -0800
Message-ID: <20221203184557.476871-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: V6HAM56gGVNupvlWOCer-AXO5pBaBKoO
X-Proofpoint-ORIG-GUID: V6HAM56gGVNupvlWOCer-AXO5pBaBKoO
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-03_10,2022-12-01_01,2022-06-22_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Patch set [1] added rcu support for bpf programs. In [1], a rcu
pointer is considered to be trusted and not null. This is actually
not true in some cases. The rcu pointer could be null, and for non-null
rcu pointer, it may have reference count of 0. This small patch set
fixed this problem. Patch 1 is the kernel fix. Patch 2 adjusted
selftests properly. Patch 3 added documentation for newly-introduced
KF_RCU flag.

  [1] https://lore.kernel.org/all/20221124053201.2372298-1-yhs@fb.com/

Changelogs:
  v1 -> v2:
    - rcu ptr could be NULL.
    - non_null_rcu_ptr->rcu_field can be marked as MEM_RCU as well.
    - Adjust the code to avoid existing error message change.

Yonghong Song (3):
  bpf: Handle MEM_RCU type properly
  selftests/bpf: Fix rcu_read_lock test with new MEM_RCU semantics
  docs/bpf: Add KF_RCU documentation

 Documentation/bpf/kfuncs.rst                  |  9 +++
 include/linux/bpf_verifier.h                  |  2 +-
 include/linux/btf.h                           |  1 +
 kernel/bpf/helpers.c                          | 14 +++++
 kernel/bpf/verifier.c                         | 45 ++++++++++-----
 .../selftests/bpf/progs/rcu_read_lock.c       | 55 +++++++++++++++----
 6 files changed, 102 insertions(+), 24 deletions(-)

--=20
2.30.2

