Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 684984DA78B
	for <lists+bpf@lfdr.de>; Wed, 16 Mar 2022 02:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347548AbiCPBuH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Mar 2022 21:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236455AbiCPBuG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Mar 2022 21:50:06 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA23955BEA
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 18:48:52 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22FNkfro008445
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 18:48:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=oGvbSS2+PujNG/ErEt2D6LUGbCd+y2QCR4QjvwXxA0c=;
 b=FXMtA55ii0NEbto4rr8Q/hF6/eC8DvdpTUfE3BqbDeXAj56pkf/TEMXPDSb2m8ATQglX
 UDH7Qg5D6qZDFssyqWyS7cBoK9zm2ngA4zfCsqGX1MBVqJ1RVDVYdw2sRXJF08Hg6au5
 GWhR9W8xV6Ot2xewKiG1HL1SZXz0k10ijS0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3etac8bgc8-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 18:48:52 -0700
Received: from twshared29473.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 15 Mar 2022 18:48:51 -0700
Received: by devbig933.frc1.facebook.com (Postfix, from userid 6611)
        id B24342103F6A; Tue, 15 Mar 2022 18:48:41 -0700 (PDT)
From:   Martin KaFai Lau <kafai@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 0/3] Remove libcap dependency from bpf selftests
Date:   Tue, 15 Mar 2022 18:48:41 -0700
Message-ID: <20220316014841.2255248-1-kafai@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: UuF8awuS8RSl6b3eeZlhJPHhklCiM-aA
X-Proofpoint-ORIG-GUID: UuF8awuS8RSl6b3eeZlhJPHhklCiM-aA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-15_11,2022-03-15_01,2022-02-23_01
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

After upgrading to the newer libcap (>=3D 2.60),
the libcap commit aca076443591 ("Make cap_t operations thread safe.")
added a "__u8 mutex;" to the "struct _cap_struct".  It caused a few byte
shift that breaks the assumption made in the "struct libcap" definition
in test_verifier.c.

This set is to remove the libcap dependency from the bpf selftests.

Martin KaFai Lau (3):
  bpf: selftests: Add helpers to directly use the capget and capset
    syscall
  bpf: selftests: Remove libcap usage from test_verifier
  bpf: selftests: Remove libcap usage from test_progs

 tools/testing/selftests/bpf/Makefile          |  8 +-
 tools/testing/selftests/bpf/cap_helpers.c     | 68 ++++++++++++++
 tools/testing/selftests/bpf/cap_helpers.h     | 10 +++
 .../selftests/bpf/prog_tests/bind_perm.c      | 45 ++--------
 tools/testing/selftests/bpf/test_verifier.c   | 89 ++++++-------------
 5 files changed, 118 insertions(+), 102 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/cap_helpers.c
 create mode 100644 tools/testing/selftests/bpf/cap_helpers.h

--=20
2.30.2

