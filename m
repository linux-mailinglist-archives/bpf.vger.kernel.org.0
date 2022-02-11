Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9534B2C30
	for <lists+bpf@lfdr.de>; Fri, 11 Feb 2022 18:57:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbiBKR5K (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Feb 2022 12:57:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234778AbiBKR5K (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Feb 2022 12:57:10 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29FE2CF5
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 09:57:09 -0800 (PST)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21BF1Vf2018278
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 09:57:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=FDwIX/aUas3HtPUH6At/buj79ipvQLwxkOgQOFt/A+A=;
 b=ZN++e1qF/5LvedMl7vh6YtP+EAxLmWRCbgLrlKUcZALyCAFZzozWdFAgyWp9b54HfuTq
 FUbLf1OIbUiLDgsEZvugQXQ/Das90ciF0q9KqaMZBO59UYnW+NUMNkBICeanli3jJV/h
 7/ufnY5Qr5pMA0zPiuo2yezqkr8+Y+33DTw= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e592upx7f-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 09:57:08 -0800
Received: from twshared29821.14.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 11 Feb 2022 09:57:03 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id B6EEE642163E; Fri, 11 Feb 2022 09:56:55 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: [PATCH bpf v3 0/2] bpf: fix a bpf_timer initialization issue
Date:   Fri, 11 Feb 2022 09:56:55 -0800
Message-ID: <20220211175655.2426903-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
Content-Type: text/plain; charset="UTF-8"
X-FB-Internal: Safe
X-Proofpoint-GUID: b_XDvz39SqOs9WplnYosgI3xjY730bgZ
X-Proofpoint-ORIG-GUID: b_XDvz39SqOs9WplnYosgI3xjY730bgZ
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-11_05,2022-02-11_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 malwarescore=0
 suspectscore=0 bulkscore=0 mlxlogscore=449 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 spamscore=0 impostorscore=0
 phishscore=0 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202110096
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

