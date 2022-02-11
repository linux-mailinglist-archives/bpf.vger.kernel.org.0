Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCE14B2E03
	for <lists+bpf@lfdr.de>; Fri, 11 Feb 2022 20:50:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240391AbiBKTtx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Feb 2022 14:49:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236065AbiBKTtx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Feb 2022 14:49:53 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA162A1
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 11:49:52 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21BIBbMg015515
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 11:49:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=C1JTz0/BEd3LeTr8ldUN1r3Ki8xhYEL1FULYbfwEsow=;
 b=B3sU8itOArKcJAAh/mg/SrSvBa+1oq66s/gVWmkHsSTlD8HO6TeVDogaXRb5AYDMxLIv
 CBSZjyUAnT0W3S5BVHJyyQY+n/7HfhaNF4gxktosdFgZn2KBqYI1Pkmq0TqhCd7wYzVN
 tVJcPKRV3MSJVadT8h121sxNXPqlQlAWgiE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e5vv4gnsn-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 11:49:51 -0800
Received: from twshared11487.23.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 11 Feb 2022 11:49:49 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 3DBB86430119; Fri, 11 Feb 2022 11:49:43 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: [PATCH bpf v4 0/2] bpf: fix a bpf_timer initialization issue
Date:   Fri, 11 Feb 2022 11:49:43 -0800
Message-ID: <20220211194943.3141324-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
Content-Type: text/plain; charset="UTF-8"
X-FB-Internal: Safe
X-Proofpoint-ORIG-GUID: 2Ii_l-7rgwbQwBGyIWL0CIvDEkCy6EKy
X-Proofpoint-GUID: 2Ii_l-7rgwbQwBGyIWL0CIvDEkCy6EKy
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-11_05,2022-02-11_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 clxscore=1015
 spamscore=0 malwarescore=0 mlxscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 mlxlogscore=330 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202110104
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

Changelog:
  v3 -> v4:
    . move header file in patch #1 to avoid bpf-next merge conflict
  v2 -> v3:
    . switch patch #1 and patch #2 for better bisecting
  v1 -> v2:
    . add Fixes tag for patch #1
    . rebase against bpf tree

Yonghong Song (2):
  bpf: emit bpf_timer in vmlinux BTF
  bpf: fix a bpf_timer initialization issue

 include/linux/bpf.h  | 6 ++----
 kernel/bpf/helpers.c | 2 ++
 2 files changed, 4 insertions(+), 4 deletions(-)

--=20
2.30.2

