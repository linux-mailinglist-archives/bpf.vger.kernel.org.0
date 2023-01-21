Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32257676336
	for <lists+bpf@lfdr.de>; Sat, 21 Jan 2023 03:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjAUC5d (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Jan 2023 21:57:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjAUC5c (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 21:57:32 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D560F7CCE8
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 18:57:31 -0800 (PST)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30L2T2GM031309
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 18:57:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=mtVO8ga4Jqs1eGQcEbb09tl1VPjhJDBLl45yw8VCR2U=;
 b=JZBS7d/sV6EDVBHih5X60BZFbWzWWF6ZoDHQcg/GXBl9dAxvuXwCvpI7WbONGrvkzLYZ
 Ipf1vM7yKOvB9L0egJgQX1fmM96p90ejHIBPS0uSgoiQ6DMBmsojaD1iw6p+3xJwQuUa
 MpgU3dlnddEokpSyJ+Qb751sfSroJuULGD3yZAvj+8j7Zg8W6JA3jSZyph81XfZ+w2l3
 Jppzmqnb4IbAXEWdTO1LN7YoJu2388dQ0x6HxB54C899+m5ozwhhrr8ZDLyHxsWzZttS
 FOVi42fWMXaNxBzM0uhyx6s28aiPJKZJ3N38BnkkWDAc3M9csM2iMwdYt/z6fza/Npr4 3A== 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3n870m035j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 18:57:30 -0800
Received: from twshared16996.15.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 20 Jan 2023 18:57:28 -0800
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id 82D0331A622E; Fri, 20 Jan 2023 18:57:18 -0800 (PST)
From:   Kui-Feng Lee <kuifeng@meta.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
        <song@kernel.org>, <kernel-team@meta.com>
CC:     Kui-Feng Lee <kuifeng@meta.com>
Subject: [PATCH bpf-next 0/2] Enable bpf_setsockopt() on ktls enabled sockets.
Date:   Fri, 20 Jan 2023 18:57:14 -0800
Message-ID: <20230121025716.3039933-1-kuifeng@meta.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: l3acXHP7rPVkNoLPmQIFa8DuD4U18PgQ
X-Proofpoint-ORIG-GUID: l3acXHP7rPVkNoLPmQIFa8DuD4U18PgQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_13,2023-01-20_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patchset implements a change to bpf_setsockopt() which allows
ktls enabled sockets to be used with the SOL_TCP level. This is
necessary as when ktls is enabled, it changes the function pointer of
setsockopt of the socket, which bpf_setsockopt() checks in order to
make sure that the socket is a TCP socket. Checking sk_protocol
instead of the function pointer will ensure that bpf_setsockopt() with
the SOL_TCP level still works on sockets with ktls enabled.

Kui-Feng Lee (2):
  bpf: Check the protocol of a sock to agree the calls to
    bpf_setsockopt().
  selftests/bpf: Calls bpf_setsockopt() on a ktls enabled socket.

 net/core/filter.c                             |  2 +-
 .../selftests/bpf/prog_tests/setget_sockopt.c | 71 +++++++++++++++++++
 .../selftests/bpf/progs/setget_sockopt.c      |  8 +++
 3 files changed, 80 insertions(+), 1 deletion(-)

--=20
2.30.2

