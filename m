Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCDC1057F3
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2019 18:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfKURGy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Nov 2019 12:06:54 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:30260 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726852AbfKURGy (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 21 Nov 2019 12:06:54 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xALGxMab012686
        for <bpf@vger.kernel.org>; Thu, 21 Nov 2019 09:06:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=ft9QxCDREU14cjNCJUaPRddwW+bWylheT82fHCvvhKM=;
 b=nDxJAQ6/OUZNG2LX2UDNBMsHxMJBx5ZfQX/xeML2g06ISkmztTDpObaAIX0pOhnT/GXU
 YoR3pDuItVmhS+nY1qt5H4FN1/pWbPuOlEVQJrbvMlGbdZAKdNnnYNiZXlVyMcEdizmp
 JYCfntPj8pcoy+vQO9DbSnUJLqoWfDYTpBI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2wdjuvf5n3-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 21 Nov 2019 09:06:53 -0800
Received: from 2401:db00:30:6012:face:0:17:0 (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 21 Nov 2019 09:06:51 -0800
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 7CE6B3701AEC; Thu, 21 Nov 2019 09:06:50 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next v2 0/2] bpf: provide better register bounds after jmp32 instructions
Date:   Thu, 21 Nov 2019 09:06:50 -0800
Message-ID: <20191121170650.448973-1-yhs@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-21_04:2019-11-21,2019-11-21 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=13
 mlxlogscore=467 mlxscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911210148
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

Changelog:
  v1 -> v2:
    - do not directly manipulate tnum.{value,mask} in __reg_bound_offset32(),
      using tnum_lshift/tnum_rshift functions instead
    - do __reg_bound_offset32() after regular 64bit __reg_bound_offset()
      since the latter may give a better upper 32bit var_off, which can
      be inherited by __reg_bound_offset32().

Yonghong Song (2):
  bpf: provide better register bounds after jmp32 instructions
  tools/bpf: add verifier tests for better jmp32 register bounds

 kernel/bpf/verifier.c                        | 19 +++++
 tools/testing/selftests/bpf/verifier/jmp32.c | 83 ++++++++++++++++++++
 2 files changed, 102 insertions(+)

-- 
2.17.1

