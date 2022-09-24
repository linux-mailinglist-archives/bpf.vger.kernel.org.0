Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 497005E86C7
	for <lists+bpf@lfdr.de>; Sat, 24 Sep 2022 02:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbiIXAdR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Sep 2022 20:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiIXAdQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Sep 2022 20:33:16 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F89E722C
        for <bpf@vger.kernel.org>; Fri, 23 Sep 2022 17:33:15 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28NM8xRf004592
        for <bpf@vger.kernel.org>; Fri, 23 Sep 2022 17:33:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=Lr1uV4cW85qn3rglK8UsBuhA/eEIW6/QjhJsQXMZzqA=;
 b=f7KPYuaZM22ttEilqIaZ1DbagXUyd7+9uQZUUr2tG9Bn9lioyM+p+xPBBiblBueOF1gr
 mpQ+7FZmazUC6oLFbcSkzAwfUYSBXSfqyjrwG52vpBSYveEA5cKaIsdStqydUK1Yq3PV
 5kf7Dsf3UwoyHMMQAF3EwZi55DxaBe2xJsU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jsb1pwcxu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 23 Sep 2022 17:33:15 -0700
Received: from twshared13579.04.prn5.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 23 Sep 2022 17:33:13 -0700
Received: by devbig150.prn5.facebook.com (Postfix, from userid 187975)
        id E0EC01082E402; Fri, 23 Sep 2022 17:33:07 -0700 (PDT)
From:   Jie Meng <jmeng@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
        <daniel@iogearbox.net>
CC:     Jie Meng <jmeng@fb.com>
Subject: [PATCH bpf-next v2 0/2] bpf,x64: Use BMI2 for shifts
Date:   Fri, 23 Sep 2022 17:32:09 -0700
Message-ID: <20220924003211.775483-1-jmeng@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <a6d54d1e-f525-0351-18bd-647ea3d4814f@iogearbox.net>
References: <a6d54d1e-f525-0351-18bd-647ea3d4814f@iogearbox.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: jaQWTAkFG1XU72CMu4hP3d3jIYPmL2vZ
X-Proofpoint-ORIG-GUID: jaQWTAkFG1XU72CMu4hP3d3jIYPmL2vZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-23_10,2022-09-22_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
the shift count, saving us instructions and bytes in most cases.

test_progs: Summary: 267/1340 PASSED, 25 SKIPPED, 0 FAILED
test_progs-no_alu32: Summary: 267/1333 PASSED, 26 SKIPPED, 0 FAILED
test_verifier: Summary: 1367 PASSED, 636 SKIPPED, 0 FAILED
test_maps: OK, 0 SKIPPED
lib/test_bpf:
  test_bpf: Summary: 1026 PASSED, 0 FAILED, [1014/1014 JIT'ed]
  test_bpf: test_tail_calls: Summary: 10 PASSED, 0 FAILED, [10/10 JIT'ed]
  test_bpf: test_skb_segment: Summary: 2 PASSED, 0 FAILED

Jie Meng (2):
  bpf,x64: use shrx/sarx/shlx when available
  bpf: Add selftests for lsh, rsh, arsh with reg operand

 arch/x86/net/bpf_jit_comp.c                | 53 ++++++++++++++++++++++
 tools/testing/selftests/bpf/verifier/jit.c | 22 +++++++++
 2 files changed, 75 insertions(+)

--=20
2.30.2

