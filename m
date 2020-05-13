Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA7501D1B73
	for <lists+bpf@lfdr.de>; Wed, 13 May 2020 18:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732437AbgEMQpj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 May 2020 12:45:39 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:36000 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728068AbgEMQpi (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 13 May 2020 12:45:38 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04DGfTpj012307
        for <bpf@vger.kernel.org>; Wed, 13 May 2020 09:45:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=nAu5QgAEiUz4HPAlLECKDoz+ZCsb2USnzCuQjR2gOqk=;
 b=JHODZX+9RHs8MqAtkfnhCQbujtgbsjQ9c2iJ58Xnc2/80jdPN6SKSpNCFsVA9OUyMeJi
 npJ681TEIMPOSwNsnYYWjLg//5syhEIlUYGbmq6w4vRcPARjwGOqy4uLds0atWmRA/CC
 jgqL9YQoBmn2KyqR11ZorEBZo0KsVnU5paI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3100xb5wj7-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 13 May 2020 09:45:38 -0700
Received: from intmgw003.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Wed, 13 May 2020 09:45:37 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 62F7F37008F3; Wed, 13 May 2020 09:45:25 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf 0/2] bpf: enforce returning 0 for fentry/fexit programs
Date:   Wed, 13 May 2020 09:45:25 -0700
Message-ID: <20200513164525.2500605-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-13_07:2020-05-13,2020-05-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 cotscore=-2147483648 mlxscore=0 suspectscore=13 lowpriorityscore=0
 impostorscore=0 bulkscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 adultscore=0 mlxlogscore=310 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005130146
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently, tracing fentry/fexit program return value can be anything,
and these return values are actually ignored by trampoline codes.
Let us force return value to be 0 to avoid confusion and allow
possible future extension. Patch #1 is the kernel change and
Patch #2 fixed the selftest.

Yonghong Song (2):
  bpf: enforce returning 0 for fentry/fexit progs
  selftests/bpf: enforce returning 0 for fentry/fexit programs

 kernel/bpf/verifier.c                             | 7 +++++++
 tools/testing/selftests/bpf/progs/test_overhead.c | 4 ++--
 2 files changed, 9 insertions(+), 2 deletions(-)

--=20
2.24.1

