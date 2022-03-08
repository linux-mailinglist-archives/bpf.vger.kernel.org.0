Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1F784D2222
	for <lists+bpf@lfdr.de>; Tue,  8 Mar 2022 21:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239634AbiCHUG2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Mar 2022 15:06:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239451AbiCHUG1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Mar 2022 15:06:27 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB0C4A3E9
        for <bpf@vger.kernel.org>; Tue,  8 Mar 2022 12:05:30 -0800 (PST)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 228IopX1006462
        for <bpf@vger.kernel.org>; Tue, 8 Mar 2022 12:05:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=+TeWKKpm1gR3qMpT9AqlMKybLjlcEnZbyqVKr52+9nY=;
 b=Thj/xRkpECCCy9svaqP22PhEgoi9RZbHRsSfX0BmL0DXl8zLr6lte1x9qWwENN6veWN9
 //PPw5s0OKGP24UQjZTTNLYPfu1EDLGoWDhtG2p03IK2sguZxeIdPMcwZIELEaVjOTGK
 8y/+J8OnbJkJcx9J4IaPD1vYSIIz7oLiPQc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ep4b2m9tm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 08 Mar 2022 12:05:29 -0800
Received: from twshared29473.14.frc2.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 8 Mar 2022 12:05:28 -0800
Received: by devvm4897.frc0.facebook.com (Postfix, from userid 537053)
        id 0E5173EBB6E9; Tue,  8 Mar 2022 12:05:16 -0800 (PST)
From:   Mykola Lysenko <mykolal@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
        <daniel@iogearbox.net>
CC:     <yhs@fb.com>, Mykola Lysenko <mykolal@fb.com>
Subject: [PATCH v4 bpf-next 0/3] BPF test_progs tests improvement
Date:   Tue, 8 Mar 2022 12:04:46 -0800
Message-ID: <20220308200449.1757478-1-mykolal@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: My1dtFk21z8qisg2rVHAg7zJJQxEGQAA
X-Proofpoint-GUID: My1dtFk21z8qisg2rVHAg7zJJQxEGQAA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-08_08,2022-03-04_01,2022-02-23_01
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

First patch reduces the sample_freq to 1000 to ensure test will
work even when kernel.perf_event_max_sample_rate was reduced to 1000.

Patches for send_signal and find_vma tune the test implementation to
make sure needed thread is scheduled. Also, both tests will finish as
soon as possible after the test condition is met.

Mykola Lysenko (3):
  Improve perf related BPF tests (sample_freq issue)
  Improve send_signal BPF test stability
  Improve stability of find_vma BPF test

 .../selftests/bpf/prog_tests/bpf_cookie.c       |  2 +-
 .../testing/selftests/bpf/prog_tests/find_vma.c | 13 ++++++++++---
 .../selftests/bpf/prog_tests/perf_branches.c    |  4 ++--
 .../selftests/bpf/prog_tests/perf_link.c        |  2 +-
 .../selftests/bpf/prog_tests/send_signal.c      | 17 ++++++++++-------
 .../selftests/bpf/progs/test_send_signal_kern.c |  2 +-
 6 files changed, 25 insertions(+), 15 deletions(-)

--=20
2.30.2

