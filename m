Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5992104823
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2019 02:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725842AbfKUBk2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Nov 2019 20:40:28 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:7312 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725819AbfKUBk2 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 20 Nov 2019 20:40:28 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAL1csRw030828
        for <bpf@vger.kernel.org>; Wed, 20 Nov 2019 17:40:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=vJBPodXGMlqbzLbO8ru+kxIqoEaqLhd+HFnm755xyKA=;
 b=qWJASvEZggSku8eGrQrAXFuEiXyMSaC196f4hudgN4fcQtNJEcMcD41W1tEOCmjAtcrl
 Mujeqs/Osmb93ueQiXQXSONMzIMHz7EOGJw94Gab8eWYBqJU7us9j8eucojnfVKedNJR
 MsDqaY3i2m7YbtNDDYrtCpIGSmD2qmRIZ3o= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2wda3vad25-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 20 Nov 2019 17:40:26 -0800
Received: from 2401:db00:12:909f:face:0:3:0 (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Wed, 20 Nov 2019 17:40:25 -0800
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 849773703208; Wed, 20 Nov 2019 17:40:24 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 0/2] bpf: provide better register bounds after jmp32 instructions
Date:   Wed, 20 Nov 2019 17:40:24 -0800
Message-ID: <20191121014024.1700638-1-yhs@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-20_08:2019-11-20,2019-11-20 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 adultscore=0
 mlxlogscore=438 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 suspectscore=13 bulkscore=0 clxscore=1015 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911210012
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

With latest llvm, bpf selftest test_progs, which has +alu32 enabled, failed for
strobemeta.o and a few other subtests. The reason is due to that
verifier did not provide better var_off.mask after jmp32 instructions.
This patch set addressed this issue and after the fix, test_progs passed
with alu32.

Patch #1 provided detailed explanation of the problem and the fix.
Patch #2 added three tests in test_verifier.

Yonghong Song (2):
  bpf: provide better register bounds after jmp32 instructions
  tools/bpf: add verifier tests for better jmp32 register bounds

 kernel/bpf/verifier.c                        | 32 +++++++-
 tools/testing/selftests/bpf/verifier/jmp32.c | 83 ++++++++++++++++++++
 2 files changed, 111 insertions(+), 4 deletions(-)

-- 
2.17.1

