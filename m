Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 347054B2900
	for <lists+bpf@lfdr.de>; Fri, 11 Feb 2022 16:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243420AbiBKPVC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Feb 2022 10:21:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349128AbiBKPVB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Feb 2022 10:21:01 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDABCE1
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 07:21:00 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 21BEf49U028438
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 07:20:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=J0x3nGFEQi5YbuaFVX/hXBulSHBaXCqQGqJcFufljIE=;
 b=mzrwunzyEDuQBbLee328J8Y/gSFPzJuNQZnI7nGBCyjbwh0shJjHJsLS0hgvrBpwzlhe
 NgxXtaZJ2870VhC/UZnNiaH/4mjHAcpYV1DrwM35QM+R83o6tpIBCvwL+yzBgcZq8YuB
 jlFnVc2b4dT4xHfFl7OVGsGoiHoLZAurkyU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net (PPS) with ESMTPS id 3e5882xdbn-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 07:20:59 -0800
Received: from twshared12416.02.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 11 Feb 2022 07:20:57 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 49EA8640F492; Fri, 11 Feb 2022 07:20:54 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: [PATCH bpf v2 0/2] bpf: fix a bpf_timer initialization issue
Date:   Fri, 11 Feb 2022 07:20:54 -0800
Message-ID: <20220211152054.1584283-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ZcPiIxxyPd9qhvzW-dbcRkVkVrShAMsa
X-Proofpoint-GUID: ZcPiIxxyPd9qhvzW-dbcRkVkVrShAMsa
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-11_05,2022-02-11_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 bulkscore=0
 mlxlogscore=391 priorityscore=1501 spamscore=0 lowpriorityscore=0
 impostorscore=0 mlxscore=0 suspectscore=0 malwarescore=0 adultscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202110084
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
  v1 -> v2:
    . add Fixes tag for patch #1
    . rebase against bpf tree

Yonghong Song (2):
  bpf: fix a bpf_timer initialization issue
  bpf: emit bpf_timer in vmlinux BTF

 include/linux/bpf.h  | 6 ++----
 kernel/bpf/helpers.c | 2 ++
 2 files changed, 4 insertions(+), 4 deletions(-)

--=20
2.30.2

