Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C94794CAC7C
	for <lists+bpf@lfdr.de>; Wed,  2 Mar 2022 18:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244267AbiCBRwX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 2 Mar 2022 12:52:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244029AbiCBRwW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Mar 2022 12:52:22 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D322BA76A
        for <bpf@vger.kernel.org>; Wed,  2 Mar 2022 09:51:39 -0800 (PST)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 222HZKx7032673
        for <bpf@vger.kernel.org>; Wed, 2 Mar 2022 09:51:39 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ej7jguhuv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 02 Mar 2022 09:51:39 -0800
Received: from twshared1433.06.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 2 Mar 2022 09:51:37 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id D80202B5420BC; Wed,  2 Mar 2022 09:51:30 -0800 (PST)
From:   Song Liu <song@kernel.org>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <kernel-team@fb.com>, Song Liu <song@kernel.org>
Subject: [PATCH v2 bpf-next 0/2] fixes for bpf_prog_pack
Date:   Wed, 2 Mar 2022 09:51:24 -0800
Message-ID: <20220302175126.247459-1-song@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: pzX-gFligQbiJDJf4U5waCovKCz4LMKQ
X-Proofpoint-ORIG-GUID: pzX-gFligQbiJDJf4U5waCovKCz4LMKQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-02_12,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 adultscore=0
 mlxlogscore=343 mlxscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 malwarescore=0
 impostorscore=0 clxscore=1015 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2203020077
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

Changes v1 => v2:
1. Rephrase comments in 2/2. (Yonghong)

Two fixes for bpf_prog_pack.

Song Liu (2):
  x86: disable HAVE_ARCH_HUGE_VMALLOC on 32-bit x86
  bpf, x86: set header->size properly before freeing it

 arch/x86/Kconfig            | 2 +-
 arch/x86/net/bpf_jit_comp.c | 5 ++++-
 kernel/bpf/core.c           | 9 ++++++---
 3 files changed, 11 insertions(+), 5 deletions(-)

--
2.30.2
