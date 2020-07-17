Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 045A5224350
	for <lists+bpf@lfdr.de>; Fri, 17 Jul 2020 20:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbgGQSrN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Jul 2020 14:47:13 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:31670 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728103AbgGQSrM (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 17 Jul 2020 14:47:12 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06HIYaBC025407
        for <bpf@vger.kernel.org>; Fri, 17 Jul 2020 11:47:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=1PZwPd90O5NnMdPnysaJrwBMIuoVWVgTGWu5QvT08+U=;
 b=fpSD0tcURducxmnSmpAk3HqRi42DacsXaHDlahNNF+rT2200y1x4C4ON5yKi2phOqr0/
 FyXYPyXTSZd2U8FkJZs5tICOZ1b1LYWNZFI6hwcmyxrGUwLrzx5rx5luZTMDF3FF7qDQ
 71t8zsJuubJ47pclVor/VUqq8pUnwnV/UZY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 32au0anntc-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 17 Jul 2020 11:47:11 -0700
Received: from intmgw004.03.ash8.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 17 Jul 2020 11:47:09 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 2B7583704BBE; Fri, 17 Jul 2020 11:47:06 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jiri Olsa <jolsa@kernel.org>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 0/2] compute bpf_skc_to_*() helper socket btf ids at build time
Date:   Fri, 17 Jul 2020 11:47:06 -0700
Message-ID: <20200717184706.3476992-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-17_09:2020-07-17,2020-07-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0 phishscore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 suspectscore=8 mlxlogscore=822 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007170130
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Commit af7ec1383361 ("bpf: Add bpf_skc_to_tcp6_sock() helper")
computed btf ids for a list of sockets at runtime when vmlinux_btf
is available. Commit 5a2798ab32ba
("bpf: Add BTF_ID_LIST/BTF_ID/BTF_ID_UNUSED macros") added support
to calculate btf_ids during linux build time. Patch #2
replaced runtime mechanism with new build-time btf_id computation
mechanism. Patch #1 also fixed a minor issue to use "static" instead
of "extern" for variable declaration to conform to actual
variable scope.

Yonghong Song (2):
  bpf: change var type of BTF_ID_LIST to static
  bpf: compute bpf_skc_to_*() helper socket btf ids at build time

 include/linux/bpf.h           |  4 ---
 include/linux/btf_ids.h       |  2 +-
 kernel/bpf/btf.c              |  1 -
 net/core/filter.c             | 49 +++++++++++++----------------------
 tools/include/linux/btf_ids.h |  2 +-
 5 files changed, 20 insertions(+), 38 deletions(-)

--=20
2.24.1

