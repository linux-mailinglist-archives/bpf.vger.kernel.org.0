Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B87531D26A9
	for <lists+bpf@lfdr.de>; Thu, 14 May 2020 07:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725794AbgENFcJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 May 2020 01:32:09 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:61518 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725788AbgENFcJ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 14 May 2020 01:32:09 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04E5VXNi023910
        for <bpf@vger.kernel.org>; Wed, 13 May 2020 22:32:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=4emg6zeNlEYCugisjsN3MvkhB1qjupEQJ5rvBh3YJy0=;
 b=Sj/VbS2M6jPAlJL9VU47mv0Z0hRVMrjCmcUv9aqyPzSfRN7qu14cEpwxu+I3Qtu/7pRa
 gwjxhAT8IPVfXzatktRuSl5mm59nEUhaaBUyb2/Md+QrDMzlJD3EBuatbLbgTfzFXD9t
 LA4jFqHsl8u/JNKfUaKSd8Bi1wyxEu785HY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3100xb9aph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 13 May 2020 22:32:08 -0700
Received: from intmgw001.03.ash8.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Wed, 13 May 2020 22:32:08 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id C53123702424; Wed, 13 May 2020 22:32:05 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf v2 0/2] bpf: enforce returning 0 for fentry/fexit programs
Date:   Wed, 13 May 2020 22:32:05 -0700
Message-ID: <20200514053205.1298315-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-13_09:2020-05-13,2020-05-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 cotscore=-2147483648 mlxscore=0 suspectscore=13 lowpriorityscore=0
 impostorscore=0 bulkscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 adultscore=0 mlxlogscore=263 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005140049
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

Changelog:
 v1 -> v2:
   - explicitly specify expected return value ranges for all
     attach types of the tracing programs. Any unspecified attach
     type will return an error. This will force any future
     tracing attach_type to be explicit about its return value
     range (Andrii).

Yonghong Song (2):
  bpf: enforce returning 0 for fentry/fexit progs
  selftests/bpf: enforce returning 0 for fentry/fexit programs

 kernel/bpf/verifier.c                          | 18 ++++++++++++++++++
 .../selftests/bpf/progs/test_overhead.c        |  4 ++--
 2 files changed, 20 insertions(+), 2 deletions(-)

--=20
2.24.1

