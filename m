Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1321471A4
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2020 20:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbgAWTSV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jan 2020 14:18:21 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:61406 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728709AbgAWTSV (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 23 Jan 2020 14:18:21 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00NJDH1d032534
        for <bpf@vger.kernel.org>; Thu, 23 Jan 2020 11:18:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=pdXWqgXmR8uu0ybWhfNjUE3HOoligeSDyH2SXn9b5ko=;
 b=e/Q1RuxmLZXQB4cYM3I47YVt4FHo34Yj8uB21OGYTH0ZyaROdEz1GJGTmCJVCaWbxNrL
 CKh8WsHeUu54f6PGt/zKPkH8phtNEzZXX6tlrxda5J2o94XDliYakHtLxB7kd/kK1y2Q
 Q+lQkpLMy+Op/paxDsHLRY0/NSSOx/FDysk= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 2xpu215ukn-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 23 Jan 2020 11:18:20 -0800
Received: from intmgw001.06.prn3.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 23 Jan 2020 11:18:19 -0800
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 7536037029A3; Thu, 23 Jan 2020 11:18:15 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 0/2] bpf: improve verifier handling for 32bit signed compare operations
Date:   Thu, 23 Jan 2020 11:18:15 -0800
Message-ID: <20200123191815.1364298-1-yhs@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-23_11:2020-01-23,2020-01-23 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 suspectscore=1 adultscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=730 phishscore=0 malwarescore=0 clxscore=1015 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001230144
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Commit b7a0d65d80a0 ("bpf, testing: Workaround a verifier failure
for test_progs") worked around a verifier failure where the
register is copied to another later refined register, but the
original register is used after refinement. The pattern
looks like:
   call ...
   w1 = w0
   w1 += -1
   if w1 > 6 goto -24
   w0 += w8
   ...
Register "w1" is refined, but "w0" is used later without taking
advantage of new "w1" range, and eventually leading verifier to
reject the program.

Instead of complicating verifier for such analysis,
llvm patch https://reviews.llvm.org/D72787 added a phase to
undo some original optimization and produces the code like below:
  call ...
  if w0 s< 0x1 goto pc-22
  if w0 s> 0x7 goto pc-23
  w0 += w8
  ...
Current verifier still rejects the above code. This patch
intends to enhance verifier to handle the above pattern.

Note that the verifier is able to handle the case at non-alu32 mode,
  call ...
  if r0 s< 0x1 goto pc-22
  if r0 s> 0x7 goto pc-23
  r0 += r8
So the problem as described in
  https://lore.kernel.org/netdev/871019a0-71f8-c26d-0ae8-c7fd8c8867fc@fb.com/
can be resolved with just compiler change.

The implementation in this patch set is just to cater the above pattern
or similar to the above pattern. If you have some cases where the compiler
generates a copy of register to refine but still use the original register
later, please let me know, we could improve llvm/kernel to accommodate
your use case.

Yonghong Song (2):
  bpf: improve verifier handling for 32bit signed compare operations
  selftests/bpf: add selftests for verifier handling 32bit signed
    compares

 include/linux/bpf_verifier.h                  |  2 +
 kernel/bpf/verifier.c                         | 73 +++++++++++++++---
 .../selftests/bpf/progs/test_sysctl_loop1.c   |  5 +-
 tools/testing/selftests/bpf/verifier/jmp32.c  | 76 +++++++++++++++++++
 4 files changed, 142 insertions(+), 14 deletions(-)

-- 
2.17.1

