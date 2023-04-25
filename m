Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 619866EEA70
	for <lists+bpf@lfdr.de>; Wed, 26 Apr 2023 00:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236155AbjDYWyx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Apr 2023 18:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234534AbjDYWyw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Apr 2023 18:54:52 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E612E58
        for <bpf@vger.kernel.org>; Tue, 25 Apr 2023 15:54:51 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33PLEv9T008743
        for <bpf@vger.kernel.org>; Tue, 25 Apr 2023 15:54:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=s2048-2021-q4;
 bh=uo3r7+i429rQA5+U+KaZ3tqZ+RXVoDnggHgAqg2Y4nA=;
 b=ARIp5uYCrbwScn8YMT1S1CZn/z8jCfjr6B/3dqVu/ykUgntLmSILizrXnddMbY9L1nJF
 8Ym2Q9Rooh+jdWf9Q5V9evuFUwE1xY+3xsyfzLQamlStq/2dQZijGHZgjN7iaywuMcoi
 XUCtMYuaWGzj4mOdSrQ3/m3PXqCBjmUkbTi2t3GIv7PrKOINQ/DFeP5CH99/qkJQ60wd
 4RuWqTvKU1kZ09UTSwWFAXf5IoqF4PZk03dPjwAN0yPfBdM31q702cHqY5YmlERAX2Ty
 hzWHrNDkbh4uLxszHHHL5Hv1TeVD9SmdDzKjW20aRdX39oTF07jAX0BnxQigD11bbWfe vg== 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3q66vn6yd5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 25 Apr 2023 15:54:51 -0700
Received: from twshared25760.37.frc1.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 25 Apr 2023 15:54:50 -0700
Received: by devvm5710.vll0.facebook.com (Postfix, from userid 624576)
        id 6B6592A344D8; Tue, 25 Apr 2023 15:54:35 -0700 (PDT)
From:   Stephen Veiss <sveiss@meta.com>
To:     <bpf@vger.kernel.org>
CC:     Stephen Veiss <sveiss@meta.com>
Subject: [PATCH bpf-next 0/2] selftests/bpf: test_progs can read test lists from file
Date:   Tue, 25 Apr 2023 15:53:59 -0700
Message-ID: <20230425225401.1075796-1-sveiss@meta.com>
X-Mailer: git-send-email 2.34.1
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: BFl8Cqd0irW_QBW0sZf4BOd4ueX4ju1n
X-Proofpoint-GUID: BFl8Cqd0irW_QBW0sZf4BOd4ueX4ju1n
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_08,2023-04-25_01,2023-02-09_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

BPF selftests have ALLOWLIST and DENYLIST files, used to control which
tests are run in CI. These files are currently parsed by a shell
script. [1]

This patchset allows those files to be specified directly on the
test_progs command line (eg, as -a @ALLOWLIST).=20

This also fixes a bug in the existing test filter code causing
unnecessary duplicate top-level test filter entries to be created.=20

Thanks,

Stephen

[1] https://github.com/kernel-patches/vmtest/blob/57feb460047b69f891cf4afe3=
cc860794a2ced17/ci/vmtest/run_selftests.sh#L21-L27

Stephen Veiss (2):
  selftests/bpf: extract insert_test from parse_test_list
  selftests/bpf: test_progs can read test lists from file

 .../selftests/bpf/prog_tests/arg_parsing.c    |  63 +++++
 tools/testing/selftests/bpf/test_progs.c      |  39 ++-
 tools/testing/selftests/bpf/testing_helpers.c | 225 ++++++++++++------
 tools/testing/selftests/bpf/testing_helpers.h |   3 +
 4 files changed, 249 insertions(+), 81 deletions(-)


base-commit: a0c109dcafb15b8bee187c49fb746779374f60f0
--=20
2.34.1

