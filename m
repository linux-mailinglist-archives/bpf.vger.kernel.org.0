Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B05D24B1F67
	for <lists+bpf@lfdr.de>; Fri, 11 Feb 2022 08:39:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbiBKHjP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Feb 2022 02:39:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238209AbiBKHjO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Feb 2022 02:39:14 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4AECF4
        for <bpf@vger.kernel.org>; Thu, 10 Feb 2022 23:39:14 -0800 (PST)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21ANrScM001885
        for <bpf@vger.kernel.org>; Thu, 10 Feb 2022 23:39:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=hRkcrAGOm0+yX/6VfuY6zy1tVfbSOTS6aX8m2opmO+I=;
 b=Sr0tCvYjTbkTKCZMnkCPTRbbdigeVxriF069ZwCAX1yODcgFYE4s9Ck5JluOo/AR5ATe
 oiwzp1NYHkzeMsHVai8/3t50pnVvMvUtMaN93PbYWq+k8lNJYFVqI+IM1BfXGZaWCyoi
 RA7GClaiqHtBemn1ufV2fqBuDGdwnloINW8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e54v662vb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 10 Feb 2022 23:39:14 -0800
Received: from twshared7500.02.ash7.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 10 Feb 2022 23:39:13 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 451B363DB620; Thu, 10 Feb 2022 23:39:03 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: [PATCH bpf 0/2] bpf: fix a bpf_timer initialization issue
Date:   Thu, 10 Feb 2022 23:39:03 -0800
Message-ID: <20220211073903.3455193-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: FP_ZdPyER-5keqaJ7m5RgdbX_oZlbHOx
X-Proofpoint-GUID: FP_ZdPyER-5keqaJ7m5RgdbX_oZlbHOx
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-11_02,2022-02-09_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 mlxlogscore=343
 mlxscore=0 priorityscore=1501 malwarescore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202110043
X-FB-Internal: deliver
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The patch [1] exposed a bpf_timer initialization bug in function
check_and_init_map_value(). With bug fix here, the patch [1]
can be applied with all selftests passed. Please see individual
patches for fix details.

  [1] https://lore.kernel.org/bpf/20220209070324.1093182-2-memxor@gmail.com/

Yonghong Song (2):
  bpf: fix a bpf_timer initialization issue
  bpf: emit bpf_timer in vmlinux BTF

 include/linux/bpf.h  | 6 ++----
 kernel/bpf/helpers.c | 2 ++
 2 files changed, 4 insertions(+), 4 deletions(-)

--=20
2.30.2

