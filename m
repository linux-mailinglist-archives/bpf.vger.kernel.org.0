Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3601FFEE1
	for <lists+bpf@lfdr.de>; Fri, 19 Jun 2020 01:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726001AbgFRXqi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Jun 2020 19:46:38 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:50414 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726981AbgFRXqh (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 18 Jun 2020 19:46:37 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05INdwh7022436
        for <bpf@vger.kernel.org>; Thu, 18 Jun 2020 16:46:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=Psjs5/QBQrNaMWW/3QCxi5Ex0OzZ6al15KHkyqYYXA0=;
 b=f7/JMEisNJzK0L8COzE3G1lySiOC3gKX3rX7mfarUXnSSoT0rhA6OyfiKD/M+JANg6rP
 niyvBxqoxK0238AFmsgUE44U7KpsKI7Cd+1BPl2zpAbdfKPDgvLEAd2lktXCppfiYZUy
 XvXIdFIXgLxcBOnWM+dKcn+an7/wZHuFuNM= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 31q653pyq3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 18 Jun 2020 16:46:36 -0700
Received: from intmgw002.03.ash8.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 18 Jun 2020 16:46:35 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 7B2B83704C19; Thu, 18 Jun 2020 16:46:31 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 0/2] bpf: avoid verifier failure for 32bit pointer arithmetic
Date:   Thu, 18 Jun 2020 16:46:31 -0700
Message-ID: <20200618234631.3321026-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-18_21:2020-06-18,2020-06-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 priorityscore=1501 impostorscore=0 cotscore=-2147483648 suspectscore=13
 spamscore=0 lowpriorityscore=0 mlxscore=0 phishscore=0 bulkscore=0
 adultscore=0 mlxlogscore=404 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006180182
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch set tried to fix a verifier failure
related to 32bit pointer arithmetic. Please see Patch #1
for the failure case and how to fix it in verifier.
Patch #2 added two test_verifier subtests to cover
the verifier change.

Yonghong Song (2):
  bpf: avoid verifier failure for 32bit pointer arithmetic
  tools/bpf: add verifier tests for 32bit pointer/scalar arithmetic

 kernel/bpf/verifier.c                         |  5 +++
 .../selftests/bpf/verifier/value_ptr_arith.c  | 38 +++++++++++++++++++
 2 files changed, 43 insertions(+)

--=20
2.24.1

