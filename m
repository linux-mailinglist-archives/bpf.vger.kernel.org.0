Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 976704B0679
	for <lists+bpf@lfdr.de>; Thu, 10 Feb 2022 07:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235381AbiBJGlf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 10 Feb 2022 01:41:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235373AbiBJGla (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Feb 2022 01:41:30 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B0E10AB
        for <bpf@vger.kernel.org>; Wed,  9 Feb 2022 22:41:31 -0800 (PST)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 219NYB50028660
        for <bpf@vger.kernel.org>; Wed, 9 Feb 2022 22:41:31 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e4h9fmp2j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 09 Feb 2022 22:41:31 -0800
Received: from twshared14630.35.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 9 Feb 2022 22:41:30 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 3D99729D423AF; Wed,  9 Feb 2022 22:41:15 -0800 (PST)
From:   Song Liu <song@kernel.org>
To:     <linux-mm@kvack.org>, <bpf@vger.kernel.org>,
        <netdev@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <kernel-team@fb.com>, <akpm@linux-foundation.org>,
        <eric.dumazet@gmail.com>, Song Liu <song@kernel.org>
Subject: [PATCH bpf-next 0/2] flexible size for bpf_prog_pack
Date:   Wed, 9 Feb 2022 22:41:06 -0800
Message-ID: <20220210064108.1095847-1-song@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ctn1mhYXVFFm4AEMtyJEyxLwiEerl3Ea
X-Proofpoint-GUID: ctn1mhYXVFFm4AEMtyJEyxLwiEerl3Ea
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-10_02,2022-02-09_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 impostorscore=0
 adultscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 phishscore=0
 suspectscore=0 spamscore=0 mlxscore=0 mlxlogscore=428 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202100034
X-FB-Internal: deliver
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

There are two issues with bpf_prog_pack:

(1) On NUMA systems, bpf_prog_pack need to be bigger
    (PMD_SIZE * num_online_nodes) to use huge pages.
(2) If the system doesn't support huge pages (nohugevmalloc in cmdline),
    allocating PMD_SIZE for bpf_prog_pack is a waste.

Address these issues with flexible bpf_prog_pack_size().

Song Liu (2):
  vmalloc: expose vmap_allow_huge via get_vmap_allow_huge()
  bpf: flexible size for bpf_prog_pack

 include/linux/vmalloc.h |  1 +
 kernel/bpf/core.c       | 47 +++++++++++++++++++++++------------------
 mm/vmalloc.c            |  5 +++++
 3 files changed, 33 insertions(+), 20 deletions(-)

--
2.30.2
