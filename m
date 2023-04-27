Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69DF16F0E96
	for <lists+bpf@lfdr.de>; Fri, 28 Apr 2023 00:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344344AbjD0Wx4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Apr 2023 18:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjD0Wxz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Apr 2023 18:53:55 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A75E76
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 15:53:53 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33RIQKOF020961
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 15:53:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=s2048-2021-q4;
 bh=TjG936k41tISvL3uf4B6rr2dc3cb09SaaiGhVp1y55A=;
 b=PX7T8qEKkwhav/5GYFR3DUzd8pW8zT2Hb6GGbT4CBOF6UKpFIRta6fZr8XeopuCn7DQt
 fxOtF4KDdDpojrlyXNxq1ibQVJq204t0s0S6SLi9GDjRcyPWyuDoq4C6SjBTIUdfo/B5
 d7K4a5ZBepH1jWCqa+u013mq17hOLJeVc8MnLPm0P27LcvfhgVnjS48CPU4DFx/RLU7B
 8Igqco4IfhOh2md8VhimRTg6L/LHV2YJS33My1dUqRysbUnvl4bmL+CEzu3GbJrIX0YU
 TXrzP6W5/Yk5jlXJIjgGB30T15ePjXY4JO50iZmZ15q+xfQQ0uRvDK7fjp7+XY/UYTIv rg== 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3q7cst8wr4-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 15:53:53 -0700
Received: from twshared29091.48.prn1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 27 Apr 2023 15:53:51 -0700
Received: by devvm5710.vll0.facebook.com (Postfix, from userid 624576)
        id 0D0A92D1987D; Thu, 27 Apr 2023 15:53:38 -0700 (PDT)
From:   Stephen Veiss <sveiss@meta.com>
To:     <bpf@vger.kernel.org>, Mykola Lysenko <mykolal@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>
CC:     Yonghong Song <yhs@meta.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Stephen Veiss <sveiss@meta.com>
Subject: [PATCH bpf-next v2 0/2] selftests/bpf: test_progs can read test lists from file
Date:   Thu, 27 Apr 2023 15:53:31 -0700
Message-ID: <20230427225333.3506052-1-sveiss@meta.com>
X-Mailer: git-send-email 2.34.1
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: F4AS03maFxqBgfUDH6DNHXQFh2xdz_0Z
X-Proofpoint-GUID: F4AS03maFxqBgfUDH6DNHXQFh2xdz_0Z
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-27_09,2023-04-27_01,2023-02-09_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

BPF selftests have ALLOWLIST and DENYLIST files, used to control which
tests are run in CI. These files are currently parsed by a shell
script. [1]

This patchset allows those files to be specified directly on the
test_progs command line (eg, as -a @ALLOWLIST).

This also fixes a bug in the existing test filter code causing
unnecessary duplicate top-level test filter entries to be created.

[1] https://github.com/kernel-patches/vmtest/blob/57feb460047b69f891cf4afe3=
cc860794a2ced17/ci/vmtest/run_selftests.sh#L21-L27

---

v2:
 - error handling style changes per reviewer comments
 - fdopen return value checking in test_parse_test_list_file

v1:
 https://lore.kernel.org/bpf/20230425225401.1075796-1-sveiss@meta.com/

Stephen Veiss (2):
  selftests/bpf: extract insert_test from parse_test_list
  selftests/bpf: test_progs can read test lists from file

 .../selftests/bpf/prog_tests/arg_parsing.c    |  68 ++++++
 tools/testing/selftests/bpf/test_progs.c      |  37 ++-
 tools/testing/selftests/bpf/testing_helpers.c | 225 ++++++++++++------
 tools/testing/selftests/bpf/testing_helpers.h |   3 +
 4 files changed, 249 insertions(+), 84 deletions(-)


base-commit: b580dac290822cfcbe741c0aa59c41c3fda398a8
--=20
2.34.1

