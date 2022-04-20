Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 329BA507D95
	for <lists+bpf@lfdr.de>; Wed, 20 Apr 2022 02:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346126AbiDTAZg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Apr 2022 20:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbiDTAZf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Apr 2022 20:25:35 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 700852ED7F
        for <bpf@vger.kernel.org>; Tue, 19 Apr 2022 17:22:51 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 23JMJEVK011745
        for <bpf@vger.kernel.org>; Tue, 19 Apr 2022 17:22:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=a+37SnlEJQyI+SZmrCyUy+yLnFH8Q3gwYciumFrmm8w=;
 b=ifs9ha+mU0x0a5mr6rNK7kNR0gY6g1HhdS6Ca3gjJIRorp06LHuuiWfrP4E8DXecMAye
 kA/VoBVpEb2XNhuQbOyocmR042czxFNEADS6JdmRi5iQcB6HBY8MWTYamFlpkxVPPg7S
 nugWrSgINixgsL5cFEbtUzot9QLFiYDsbaU= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fhn50xxs5-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 19 Apr 2022 17:22:50 -0700
Received: from twshared5730.23.frc3.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 19 Apr 2022 17:22:15 -0700
Received: by devbig030.frc3.facebook.com (Postfix, from userid 158236)
        id 7FE7610F66462; Tue, 19 Apr 2022 17:22:00 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        KP Singh <kpsingh@kernel.org>, Tejun Heo <tj@kernel.org>,
        <kernel-team@fb.com>, Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH bpf-next 3/3] bpf: Remove duplicate define in bpf_local_storage.h
Date:   Tue, 19 Apr 2022 17:21:43 -0700
Message-ID: <20220420002143.1096548-4-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220420002143.1096548-1-davemarchevsky@fb.com>
References: <20220420002143.1096548-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: jd9VpfXD4YIVkB03KuUminEoJDoyaH8i
X-Proofpoint-ORIG-GUID: jd9VpfXD4YIVkB03KuUminEoJDoyaH8i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-19_08,2022-04-15_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

BPF_LOCAL_STORAGE_CACHE_SIZE is defined elsewhere in the same header.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 include/linux/bpf_local_storage.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_=
storage.h
index d87405a1b65d..a5e4c220fc0d 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -104,8 +104,6 @@ struct bpf_local_storage {
 	container_of((_SDATA), struct bpf_local_storage_elem, sdata)
 #define SDATA(_SELEM) (&(_SELEM)->sdata)
=20
-#define BPF_LOCAL_STORAGE_CACHE_SIZE	16
-
 struct bpf_local_storage_cache {
 	spinlock_t idx_lock;
 	u64 idx_usage_counts[BPF_LOCAL_STORAGE_CACHE_SIZE];
--=20
2.30.2

