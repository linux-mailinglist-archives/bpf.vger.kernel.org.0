Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C214220FA3B
	for <lists+bpf@lfdr.de>; Tue, 30 Jun 2020 19:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387903AbgF3RMt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Jun 2020 13:12:49 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:30338 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729963AbgF3RMt (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 30 Jun 2020 13:12:49 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05UGJnuH019016
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2020 10:12:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=b81OFm+ELOAP5m/3+XF/7xTPC7BEzakWf9fUVoTTQ5M=;
 b=ri6BOR4/oDOHOB1hTH470KvEKWySw/mFnPbFvDtkexYrJLkGXq8Qiopnuv4HeL3HAZ2n
 H/VpNS8glGPh0NfPHPrKaC9707S8bRqdbUwgupBm0JzOJxX2lmWu+LbOoGAeduOpeU7r
 84YGGPOX/OcOs+J0bSHiEA09WjYAnOxESfc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 31x3xgwff3-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2020 10:12:48 -0700
Received: from intmgw003.08.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 30 Jun 2020 10:12:46 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 50EBD3702224; Tue, 30 Jun 2020 10:12:40 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf 0/2] bpf: fix an incorrect branch elimination by verifier
Date:   Tue, 30 Jun 2020 10:12:40 -0700
Message-ID: <20200630171240.2523628-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-06-30_06:2020-06-30,2020-06-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=1 mlxlogscore=963
 bulkscore=0 priorityscore=1501 mlxscore=0 impostorscore=0 spamscore=0
 clxscore=1015 cotscore=-2147483648 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006300116
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Wenbo reported an issue in [1] where a checking of null
pointer is evaluated as always false. In this particular
case, the program type is tp_btf and the pointer to
compare is a PTR_TO_BTF_ID.

As an illustration of original issue, consider the following
example:
 struct bpf_fentry_test_t {
     struct bpf_fentry_test_t *a;
 };
 int BPF_PROG(test8, struct bpf_fentry_test_t *arg)
 {
     if (arg->a =3D=3D 0)
         test8_result =3D 1;
     return 0;
 }
In the xlated byte code, "arg->a =3D=3D 0" condition is evaluted
always false and "test8_result =3D 1" is removed.

This is not right. Patch #1 shows why this happens and how to
fix it in verifier. Patch #2 added two subtests in test_progs
to catch such cases.

 [1]: https://lore.kernel.org/bpf/79dbb7c0-449d-83eb-5f4f-7af0cc269168@fb=
.com/T/

Yonghong Song (2):
  bpf: fix an incorrect branch elimination by verifier
  bpf: add tests for PTR_TO_BTF_ID vs. null comparison

 kernel/bpf/verifier.c                         |  3 +--
 net/bpf/test_run.c                            | 19 +++++++++++++++-
 .../selftests/bpf/prog_tests/fentry_fexit.c   |  2 +-
 .../testing/selftests/bpf/progs/fentry_test.c | 22 +++++++++++++++++++
 .../testing/selftests/bpf/progs/fexit_test.c  | 22 +++++++++++++++++++
 5 files changed, 64 insertions(+), 4 deletions(-)

--=20
2.24.1

