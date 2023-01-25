Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 423B967BC68
	for <lists+bpf@lfdr.de>; Wed, 25 Jan 2023 21:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235870AbjAYUQa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Jan 2023 15:16:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235861AbjAYUQ3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Jan 2023 15:16:29 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631C71EFC0
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 12:16:28 -0800 (PST)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30PJ5j9C025441
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 12:16:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=s2048-2021-q4;
 bh=iNCcPlsxF8l0fHaHPd10E5Yoary3s/6tJzvtQhZARwo=;
 b=FwWqgLTN3YaFX5dFKSza1r+SJiyH1s/SJZ2NfznWzymg6cHXvSdidp5w79jZVTdnLFY2
 FdGXOYZdX2h07BMYGnKgp8z4OQ7bQemPdhln+ec3dfgVdgOGFXjigKpyezxxd3kNx0Ty
 hzUTAnHOzLCgYwtp9BmmGjgsKdJuq1IOXcWEU9Vku+Pk6PCkVL9TJ60gYnRVM2/QjFxP
 vIHOOK2kFAU8mH3XGLym+p+DneqhhkmbjWuxzdF+NeX/HAwI+hF58ksIaw9x5+qluzlg
 Mc3S2Tk7IcsZA7espK/RoD8uZuLL1FDoggMUCrOzq4ZBWtfSXFeWoPCeHQy/SAox5XZr kg== 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3nb7mbj2xj-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 12:16:28 -0800
Received: from twshared26225.38.frc1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 25 Jan 2023 12:16:27 -0800
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id E9A1A37B6C8F; Wed, 25 Jan 2023 12:16:23 -0800 (PST)
From:   Kui-Feng Lee <kuifeng@meta.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <martin.lau@linux.dev>,
        <song@kernel.org>, <kernel-team@meta.com>
CC:     Kui-Feng Lee <kuifeng@meta.com>
Subject: [PATCH bpf-next v3 0/2] Enable bpf_setsockopt() on ktls enabled sockets.
Date:   Wed, 25 Jan 2023 12:16:06 -0800
Message-ID: <20230125201608.908230-1-kuifeng@meta.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 50NrRtjljVHaJM3LZIYOI28EY3SvMLm-
X-Proofpoint-ORIG-GUID: 50NrRtjljVHaJM3LZIYOI28EY3SvMLm-
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-25_13,2023-01-25_01,2022-06-22_01
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

The major differences form v2 are:
 - Add a read() call to make sure that the FIN has arrived.
 - Remove the dependency on other test's header.

The major differences from v1 are:
 - Test with a IPv6 connect as well.
 - Use ASSERT_OK()

v2: https://lore.kernel.org/bpf/20230124181220.2871611-1-kuifeng@meta.com/
v1: https://lore.kernel.org/bpf/20230121025716.3039933-1-kuifeng@meta.com/

Kui-Feng Lee (2):
  bpf: Check the protocol of a sock to agree the calls to
    bpf_setsockopt().
  selftests/bpf: Calls bpf_setsockopt() on a ktls enabled socket.

 net/core/filter.c                             |  2 +-
 .../selftests/bpf/prog_tests/setget_sockopt.c | 73 +++++++++++++++++++
 .../selftests/bpf/progs/setget_sockopt.c      |  8 ++
 3 files changed, 82 insertions(+), 1 deletion(-)

--=20
2.30.2

