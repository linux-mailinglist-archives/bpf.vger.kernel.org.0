Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1CC45F2157
	for <lists+bpf@lfdr.de>; Sun,  2 Oct 2022 07:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbiJBFMD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 2 Oct 2022 01:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiJBFMC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 2 Oct 2022 01:12:02 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29DAF5072D
        for <bpf@vger.kernel.org>; Sat,  1 Oct 2022 22:12:00 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2924QxvY023435
        for <bpf@vger.kernel.org>; Sat, 1 Oct 2022 22:12:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=ju9MP98ZdEdShx8B+KXp7cQoi4AkD78vjC3EhwwUtZw=;
 b=hLQSzEfscf4HvsJOBGf7PISmo+lQgCH7KNRFS/SGgQ1E9amCDC6HvJwJHIS4/trsDbrO
 VjDf8MTZUN6J3IDTtzuXaww9Dv+7VLXk8dXvj8ec9NGSqQYc/7brTDiC9iufpSbhu+6Z
 fABHXijec0Wg01rfYrON+eh7DnYOtFxFYOU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jxmv4b45n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sat, 01 Oct 2022 22:11:59 -0700
Received: from twshared13315.14.prn3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 1 Oct 2022 22:11:58 -0700
Received: by devbig150.prn5.facebook.com (Postfix, from userid 187975)
        id 30E3910F44C82; Sat,  1 Oct 2022 22:11:50 -0700 (PDT)
From:   Jie Meng <jmeng@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
        <daniel@iogearbox.net>
CC:     Jie Meng <jmeng@fb.com>
Subject: [PATCH bpf-next v4 0/3] bpf,x64: Use BMI2 for shifts
Date:   Sat, 1 Oct 2022 22:11:40 -0700
Message-ID: <20221002051143.831029-1-jmeng@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220927185801.1824838-1-jmeng@fb.com>
References: <20220927185801.1824838-1-jmeng@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: JgUYdH-U6sTiZW3ZVBZqQoa__YRnllNW
X-Proofpoint-ORIG-GUID: JgUYdH-U6sTiZW3ZVBZqQoa__YRnllNW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-01_15,2022-09-29_03,2022-06-22_01
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
v3 -> v4:
- Fixed a regression when BMI2 isn't available

Jie Meng (3):
  bpf,x64: avoid unnecessary instructions when shift dest is ecx
  bpf,x64: use shrx/sarx/shlx when available
  bpf: add selftests for lsh, rsh, arsh with reg operand

 arch/x86/net/bpf_jit_comp.c                | 89 +++++++++++++++++++---
 tools/testing/selftests/bpf/verifier/jit.c | 24 ++++++
 2 files changed, 101 insertions(+), 12 deletions(-)

--=20
2.30.2

