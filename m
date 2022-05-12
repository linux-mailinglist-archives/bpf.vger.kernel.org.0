Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4D0D5244C9
	for <lists+bpf@lfdr.de>; Thu, 12 May 2022 07:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244100AbiELFSK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 May 2022 01:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349587AbiELFSH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 May 2022 01:18:07 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8C516D13D
        for <bpf@vger.kernel.org>; Wed, 11 May 2022 22:18:06 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24BMwjso012872
        for <bpf@vger.kernel.org>; Wed, 11 May 2022 22:18:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=BpSYOXyg6wnT7RS6o6SrXwZrXLpUQf9GZTa0R/0RJu4=;
 b=rQHvzAO7WiIH2pVsi/UWyDtDrx28BXozm+JQNTfwPkIYIKZemhx0klAZBSeQkrVC1Vlp
 ryLcykiVOhGFbJjtcg0zorkXGUeN4F/v5uFwSxvtZMTUys55/cGIReeS6P5BAxbY/zkR
 uPNfRVRdN+DxKY9oCWZSMCHrGBB+n6BJ7Bg= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fyx8paq6k-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 11 May 2022 22:18:05 -0700
Received: from twshared29473.14.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 11 May 2022 22:18:03 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 864C4A2FE41B; Wed, 11 May 2022 22:17:59 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <dwarves@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH dwarves v2 1/2] libbpf: Sync with latest libbpf repo
Date:   Wed, 11 May 2022 22:17:59 -0700
Message-ID: <20220512051759.2652236-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: ofusDmItOw0Hy8MJ2z730p_N8iUI-5wh
X-Proofpoint-ORIG-GUID: ofusDmItOw0Hy8MJ2z730p_N8iUI-5wh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-11_07,2022-05-11_01,2022-02-23_01
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Sync up to commit 87dff0a2c775 (vmtest: allow building foreign debian roo=
tfs).

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 lib/bpf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bpf b/lib/bpf
index 393a058..87dff0a 160000
--- a/lib/bpf
+++ b/lib/bpf
@@ -1 +1 @@
-Subproject commit 393a058d061d49d5c3055fa9eefafb4c0c31ccc3
+Subproject commit 87dff0a2c775c5943ca9233e69c81a25f2ed1a77
--=20
2.30.2

