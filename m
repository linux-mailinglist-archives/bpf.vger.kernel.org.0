Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D60324E2F82
	for <lists+bpf@lfdr.de>; Mon, 21 Mar 2022 19:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245712AbiCUSBs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 21 Mar 2022 14:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351922AbiCUSBq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Mar 2022 14:01:46 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A0A5BD02
        for <bpf@vger.kernel.org>; Mon, 21 Mar 2022 11:00:20 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22LEDqp7030804
        for <bpf@vger.kernel.org>; Mon, 21 Mar 2022 11:00:19 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3extxgt30b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 21 Mar 2022 11:00:19 -0700
Received: from twshared10432.40.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 21 Mar 2022 11:00:18 -0700
Received: by devbig932.frc1.facebook.com (Postfix, from userid 4523)
        id 7D54A2DBF26B; Mon, 21 Mar 2022 11:00:12 -0700 (PDT)
From:   Song Liu <song@kernel.org>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <kernel-team@fb.com>, Song Liu <song@kernel.org>
Subject: [PATCH bpf-next 0/2] fixes for bpf_prog_pack
Date:   Mon, 21 Mar 2022 11:00:07 -0700
Message-ID: <20220321180009.1944482-1-song@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: mg2p8_SX1jh_k4b7IS-gIrCpjXVj158W
X-Proofpoint-GUID: mg2p8_SX1jh_k4b7IS-gIrCpjXVj158W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-21_07,2022-03-21_01,2022-02-23_01
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Two fixes for issues reported by syzbot and kernel test robot.

Song Liu (2):
  bpf: fix bpf_prog_pack for multi-node setup
  bpf: fix bpf_prog_pack when PMU_SIZE is not defined

 kernel/bpf/core.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

--
2.30.2
