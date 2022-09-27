Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69DEB5ECC80
	for <lists+bpf@lfdr.de>; Tue, 27 Sep 2022 20:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiI0S66 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Sep 2022 14:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbiI0S6w (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Sep 2022 14:58:52 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DD21DCC43
        for <bpf@vger.kernel.org>; Tue, 27 Sep 2022 11:58:49 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28RE5sUm031882
        for <bpf@vger.kernel.org>; Tue, 27 Sep 2022 11:58:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=s07Qm9XgOr9IC6DJH0ohHFCXZxybbuXb7FfBdbOICtE=;
 b=cV4byS6L81EWBAXBW0rrcNxcMOHKlXsaRjT+Dc1+okrWrh9ciIIh1wusY5AlFLXJCJsX
 ISaxuyrzQlaLQ8NSOGk/5/9sPKsOruxwKO/ZBX+pl3mRAKwG9TrTWLCvKhktbLikifJ+
 nM5g7S26o7ZGY2p6E4JhAt3EhxSS2oNuSiY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3juntgxjg7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 27 Sep 2022 11:58:49 -0700
Received: from snc-exhub201.TheFacebook.com (2620:10d:c085:21d::7) by
 snc-exhub103.TheFacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 27 Sep 2022 11:58:48 -0700
Received: from twshared15978.04.prn5.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 27 Sep 2022 11:58:48 -0700
Received: by devbig150.prn5.facebook.com (Postfix, from userid 187975)
        id BF25810B4B671; Tue, 27 Sep 2022 11:58:34 -0700 (PDT)
From:   Jie Meng <jmeng@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
        <daniel@iogearbox.net>
CC:     Jie Meng <jmeng@fb.com>
Subject: [PATCH bpf-next v3 0/3] bpf,x64: Use BMI2 for shifts
Date:   Tue, 27 Sep 2022 11:57:58 -0700
Message-ID: <20220927185801.1824838-1-jmeng@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <7437e1cb-325c-fc86-37f6-3422c085007d@iogearbox.net>
References: <7437e1cb-325c-fc86-37f6-3422c085007d@iogearbox.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: POq34VJdJ8WLSlBDkvCEHHH6RpsDzg6_
X-Proofpoint-GUID: POq34VJdJ8WLSlBDkvCEHHH6RpsDzg6_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-27_09,2022-09-27_01,2022-06-22_01
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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

Jie Meng (3):
  bpf,x64: avoid unnecessary instructions when shift dest is ecx
  bpf,x64: use shrx/sarx/shlx when available
  bpf: add selftests for lsh, rsh, arsh with reg operand

 arch/x86/net/bpf_jit_comp.c                | 94 ++++++++++++++++++----
 tools/testing/selftests/bpf/verifier/jit.c | 24 ++++++
 2 files changed, 104 insertions(+), 14 deletions(-)

--=20
2.30.2

