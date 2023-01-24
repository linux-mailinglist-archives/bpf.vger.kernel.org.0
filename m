Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6EA267A0F3
	for <lists+bpf@lfdr.de>; Tue, 24 Jan 2023 19:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbjAXSNF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Jan 2023 13:13:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjAXSNE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Jan 2023 13:13:04 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D3A18A9C
        for <bpf@vger.kernel.org>; Tue, 24 Jan 2023 10:13:03 -0800 (PST)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30OE2YSn011818
        for <bpf@vger.kernel.org>; Tue, 24 Jan 2023 10:13:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=s2048-2021-q4;
 bh=y9ISzXhCdEyIw9m+27mqV9M83GHTpDrK/cMQ72sV/jk=;
 b=MZZEenjTfYWF6Z8k7aliSqB4NGu4Ge9AeVADWSzd07WgmG/usSXK/HsI0cPLWi9KHoWj
 GrJcwaTNlI3O+MKX7seOIyqXm3vOXjJKa5uCiQDswzq/rV4vALXsyfNoiTOCAu6gg4Jj
 h3vC40ANnPyneNYVTGIZ4FxydIqwOr4Fpq/p5GtrWpzJ7KpXKfJmCxtO3j3cDlWdvj0G
 MvqlXM/ANZNjQaAvT+lrutfAYVaMqeDvjbzx2sWuv2vMPO5RClIBzYroJEifFdWuaCut
 HcfqB6FzbefMkfnu8rmsZaa10fiipDcZsXxgsLsU0BfefeXoXwsXZUsb7477+V/LVbxN 8g== 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3na4dubyst-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 24 Jan 2023 10:13:03 -0800
Received: from ash-exhub204.TheFacebook.com (2620:10d:c0a8:83::4) by
 ash-exhub101.TheFacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 24 Jan 2023 10:13:00 -0800
Received: from twshared25601.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.6; Tue, 24 Jan 2023 10:13:00 -0800
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id 5C9283645D8B; Tue, 24 Jan 2023 10:12:32 -0800 (PST)
From:   Kui-Feng Lee <kuifeng@meta.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <martin.lau@linux.dev>,
        <song@kernel.org>, <kernel-team@meta.com>
CC:     Kui-Feng Lee <kuifeng@meta.com>
Subject: [PATCH bpf-next v2 0/2] Enable bpf_setsockopt() on ktls enabled sockets.
Date:   Tue, 24 Jan 2023 10:12:18 -0800
Message-ID: <20230124181220.2871611-1-kuifeng@meta.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 4QSQGamDREL7ILR--crWL4YlRtiFi_uB
X-Proofpoint-GUID: 4QSQGamDREL7ILR--crWL4YlRtiFi_uB
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-24_13,2023-01-24_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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

The major differences from v1 are:
 - Test with a IPv6 connect as well.
 - Use ASSERT_OK()

v1: https://lore.kernel.org/bpf/20230121025716.3039933-1-kuifeng@meta.com/

Kui-Feng Lee (2):
  bpf: Check the protocol of a sock to agree the calls to
    bpf_setsockopt().
  selftests/bpf: Calls bpf_setsockopt() on a ktls enabled socket.

 net/core/filter.c                             |  2 +-
 .../selftests/bpf/prog_tests/setget_sockopt.c | 70 +++++++++++++++++++
 .../selftests/bpf/progs/setget_sockopt.c      |  8 +++
 3 files changed, 79 insertions(+), 1 deletion(-)

--=20
2.30.2

