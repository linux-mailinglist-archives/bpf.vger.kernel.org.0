Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA3B95F7EA9
	for <lists+bpf@lfdr.de>; Fri,  7 Oct 2022 22:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbiJGUY2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 Oct 2022 16:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbiJGUYY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 Oct 2022 16:24:24 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52F6125873
        for <bpf@vger.kernel.org>; Fri,  7 Oct 2022 13:24:19 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 297I56fA032285
        for <bpf@vger.kernel.org>; Fri, 7 Oct 2022 13:24:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=adXRTikNeiTb6m0/k6WMynwD8DFq9+o1eqLBIQKU/S4=;
 b=dCwUnSQI2VbUGSiueWXIKFKeiYWSMboBozYfnWwMFhENYlDTtfV2/LfvgAMnBZBIIdSD
 ysUoY/lZy2jqXqF/IoX4USK5dpdRyROCw6UqPE3F6NxnIy3d10d43nGje6iOhpGYsUhE
 cF6OIKQ6bn7ZUmNyZQnR+a2lLpgYdiDUHTM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3k1tp758s7-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 07 Oct 2022 13:24:18 -0700
Received: from twshared20183.05.prn5.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 7 Oct 2022 13:24:16 -0700
Received: by devbig150.prn5.facebook.com (Postfix, from userid 187975)
        id 726C91142F71E; Fri,  7 Oct 2022 13:24:13 -0700 (PDT)
From:   Jie Meng <jmeng@fb.com>
To:     <kpsingh@kernel.org>, <bpf@vger.kernel.org>, <ast@kernel.org>,
        <andrii@kernel.org>, <daniel@iogearbox.net>
CC:     Jie Meng <jmeng@fb.com>
Subject: [PATCH bpf-next v5 0/3] bpf,x64: Use BMI2 for shifts
Date:   Fri, 7 Oct 2022 13:23:46 -0700
Message-ID: <20221007202348.1118830-1-jmeng@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CACYkzJ7gz8Y0JXgfs2vKG5nF98iS+UdqpM9Vk0OOnSfYvMdK4g@mail.gmail.com>
References: <CACYkzJ7gz8Y0JXgfs2vKG5nF98iS+UdqpM9Vk0OOnSfYvMdK4g@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 5cQ20rdbCZ0emF1_Y9iv56sbKHav83kp
X-Proofpoint-ORIG-GUID: 5cQ20rdbCZ0emF1_Y9iv56sbKHav83kp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-07_04,2022-10-07_01,2022-06-22_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

With baseline x64 instruction set, shift count can only be an immediate
or in %cl. The implicit dependency on %cl makes it necessary to shuffle
registers around and/or add push/pop operations.

BMI2 provides shift instructions that can use any general register as
the shift count, saving us instructions and a few bytes in most cases.

Suboptimal codegen when %ecx is source and/or destination is also
addressed and unnecessary instructions are removed.

test_progs: Summary: 267/1340 PASSED, 25 SKIPPED, 0 FAILED
test_progs-no_alu32: Summary: 267/1333 PASSED, 26 SKIPPED, 0 FAILED
test_verifier: Summary: 1367 PASSED, 636 SKIPPED, 0 FAILED (same result
 with or without BMI2)
test_maps: OK, 0 SKIPPED
lib/test_bpf:
  test_bpf: Summary: 1026 PASSED, 0 FAILED, [1014/1014 JIT'ed]
  test_bpf: test_tail_calls: Summary: 10 PASSED, 0 FAILED, [10/10 JIT'ed]
  test_bpf: test_skb_segment: Summary: 2 PASSED, 0 FAILED

---
v4 -> v5:
- More comments regarding instruction encoding
v3 -> v4:
- Fixed a regression when BMI2 isn't available

Jie Meng (3):
  bpf,x64: avoid unnecessary instructions when shift dest is ecx
  bpf,x64: use shrx/sarx/shlx when available
  bpf: add selftests for lsh, rsh, arsh with reg operand

 arch/x86/net/bpf_jit_comp.c                | 106 ++++++++++++++++++---
 tools/testing/selftests/bpf/verifier/jit.c |  24 +++++
 2 files changed, 118 insertions(+), 12 deletions(-)

--=20
2.30.2

