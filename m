Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 053821E67CD
	for <lists+bpf@lfdr.de>; Thu, 28 May 2020 18:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405190AbgE1QvI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 May 2020 12:51:08 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:56412 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405162AbgE1QvG (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 28 May 2020 12:51:06 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04SGp1OM010702
        for <bpf@vger.kernel.org>; Thu, 28 May 2020 09:51:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=3TIaWLg1bxvMy7zEauPdf8o8sNn+GfmcY2E9sap/3mg=;
 b=nC7zDXfqQy7pX2afPHrTVcBYThClkIep0mh3BFl8Oegsg018vQL0yFfMQoGKGRfDgSgX
 2W55sJmLzsihcA9f/e3XL4OvVRf4HnMK0gSoC9mSGAm0ynAsmEKVALGcXGVeBM+nM9xu
 y9szVNLHn3o07oTXJ3NIFzk9dtzl1hLwa74= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 31ag6rgmxv-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 28 May 2020 09:51:05 -0700
Received: from intmgw002.08.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 28 May 2020 09:50:52 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 3778137053B1; Thu, 28 May 2020 09:50:43 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf 0/2] bpf: fix a verifier issue when assigning 32bit reg states to 64bit ones
Date:   Thu, 28 May 2020 09:50:43 -0700
Message-ID: <20200528165043.1568623-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-28_03:2020-05-28,2020-05-28 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0 mlxscore=0
 suspectscore=13 spamscore=0 mlxlogscore=412 lowpriorityscore=0
 cotscore=-2147483648 clxscore=1015 impostorscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005280117
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Commit 3f50f132d840 ("bpf: Verifier, do explicit ALU32 bounds tracking")
added 32bit register states to verifier for explicit ALU32 bounds
tracking. When assigning 32bit register states to 64bit register states,
if 32bit register is a constant value of 0, the 64bit register smax_val
will get U32_MAX(0xffffFFFF). Such an inprecise information may impact
downward verification. Patch #1 has detailed explanation of the program
and how to fix it. Patch #2 provides a verifier test to cover the change.

Yonghong Song (2):
  bpf: fix a verifier issue when assigning 32bit reg states to 64bit
  tools/bpf: add a verifier test for assigning 32bit reg states to 64bit

 kernel/bpf/verifier.c                         |  3 +++
 tools/testing/selftests/bpf/verifier/bounds.c | 22 +++++++++++++++++++
 2 files changed, 25 insertions(+)

--=20
2.24.1

