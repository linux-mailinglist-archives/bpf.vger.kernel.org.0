Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0764AE436
	for <lists+bpf@lfdr.de>; Tue,  8 Feb 2022 23:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbiBHW0u convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 8 Feb 2022 17:26:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387415AbiBHWXz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Feb 2022 17:23:55 -0500
X-Greylist: delayed 1048 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 08 Feb 2022 14:22:48 PST
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930E9C03E95C
        for <bpf@vger.kernel.org>; Tue,  8 Feb 2022 14:22:48 -0800 (PST)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 218M0uas027070
        for <bpf@vger.kernel.org>; Tue, 8 Feb 2022 14:05:30 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net (PPS) with ESMTPS id 3e30xsvq21-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 08 Feb 2022 14:05:29 -0800
Received: from twshared12416.02.ash9.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 8 Feb 2022 14:05:28 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id E553829B2C796; Tue,  8 Feb 2022 14:05:13 -0800 (PST)
From:   Song Liu <song@kernel.org>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <kernel-team@fb.com>, Song Liu <song@kernel.org>
Subject: [PATCH bpf-next 0/2] fix bpf_prog_pack build errors
Date:   Tue, 8 Feb 2022 14:05:07 -0800
Message-ID: <20220208220509.4180389-1-song@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 5NSt7rH2C0vO3uu__DbTOIfJbsh9aebp
X-Proofpoint-GUID: 5NSt7rH2C0vO3uu__DbTOIfJbsh9aebp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-08_06,2022-02-07_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 mlxlogscore=528 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202080129
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

Fix build errors reported by kernel test robot.

Song Liu (2):
  bpf: fix leftover header->pages in sparc and powerpc code.
  bpf: fix bpf_prog_pack build HPAGE_PMD_SIZE

 arch/powerpc/net/bpf_jit_comp.c  | 2 +-
 arch/sparc/net/bpf_jit_comp_64.c | 2 +-
 kernel/bpf/core.c                | 4 ++++
 3 files changed, 6 insertions(+), 2 deletions(-)

--
2.30.2
