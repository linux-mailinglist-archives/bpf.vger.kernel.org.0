Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5684920F826
	for <lists+bpf@lfdr.de>; Tue, 30 Jun 2020 17:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389347AbgF3PVj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Jun 2020 11:21:39 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:41074 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730017AbgF3PVj (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 30 Jun 2020 11:21:39 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05UFKi5j020568
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2020 08:21:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=79DW+AY1pvpDA6CMc72gmYJEflgUxY5S4rkR/g9Qhas=;
 b=WMy7ktzcfzaozsVAQlMjfG4JBj7TvBWSsSv+G03F8tvqlVi73yOIK2jlFpQMECRXDku4
 p3aM+A+2toVN6T/kP7/sq0S9KBKFl6nuumNkY1BDFpT8kfrOUU7SBEWGNWoo3zbg0d9W
 JuIGdA0TG5O1U+Z49RTenKuua2y5RxIG54U= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 31xpcntav6-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2020 08:21:38 -0700
Received: from intmgw004.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 30 Jun 2020 08:21:34 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 4E72C2EC2FB6; Tue, 30 Jun 2020 08:21:28 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devbig012.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v3 bpf-next 0/2] Make bpf_endian.h compatible with vmlinux.h
Date:   Tue, 30 Jun 2020 08:21:23 -0700
Message-ID: <20200630152125.3631920-1-andriin@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-06-30_06:2020-06-30,2020-06-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 spamscore=0
 impostorscore=0 bulkscore=0 cotscore=-2147483648 suspectscore=8
 priorityscore=1501 mlxlogscore=630 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006300112
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Change libbpf's bpf_endian.h header to be compatible when used with syste=
m
headers and when using just vmlinux.h. This is a frequent request for use=
rs
writing BPF CO-RE applications. Do this by re-implementing byte swap
compile-time macros. Also add simple tests validating correct results bot=
h for
byte-swapping built-ins and macros.

v2->v3:
- explicit zero-initialization of global variables (Daniel);

v1->v2:
- reimplement byte swapping macros (Alexei).

Andrii Nakryiko (2):
  libbpf: make bpf_endian co-exist with vmlinux.h
  selftests/bpf: add byte swapping selftest

 tools/lib/bpf/bpf_endian.h                    | 43 ++++++++++++---
 .../testing/selftests/bpf/prog_tests/endian.c | 53 +++++++++++++++++++
 .../testing/selftests/bpf/progs/test_endian.c | 37 +++++++++++++
 3 files changed, 125 insertions(+), 8 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/endian.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_endian.c

--=20
2.24.1

