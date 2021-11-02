Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6571344273D
	for <lists+bpf@lfdr.de>; Tue,  2 Nov 2021 07:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbhKBGsJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Nov 2021 02:48:09 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:23326 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229970AbhKBGsJ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 2 Nov 2021 02:48:09 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A1IoiCZ014028
        for <bpf@vger.kernel.org>; Mon, 1 Nov 2021 23:45:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=7jlE7/S581kuX7juwYIKL+ZzlVxO9v+N3aagY/CkB14=;
 b=h9oqAei4xpxGUrKM+rc+2+/mqJJzrSHwl3AV7KFoJFCwrWuMhDLi4bd5NoW4T11r5sSM
 NflUpHR4xAOUIGSsK1INwI5kakE/kWSdfvts3Zyzib1El17hB5X6Z2G5OXEfG0FzMp5G
 jGhBPpR+d9XxdRvylwicJbDcyx9LWNdtNp8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3c2nv9kesm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 01 Nov 2021 23:45:34 -0700
Received: from intmgw006.03.ash8.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 1 Nov 2021 23:45:33 -0700
Received: by devbig005.ftw2.facebook.com (Postfix, from userid 6611)
        id 312FA1C6689B; Mon,  1 Nov 2021 23:45:29 -0700 (PDT)
From:   Martin KaFai Lau <kafai@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Yonghong Song <yhs@fb.com>
Subject: [PATCH bpf-next 0/2] bpf: Allow doing stack read with size larger than the earlier spilled reg
Date:   Mon, 1 Nov 2021 23:45:28 -0700
Message-ID: <20211102064528.315637-1-kafai@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: TIUTrOufWvJ6jkFWXKgYqL81EopZR8bc
X-Proofpoint-GUID: TIUTrOufWvJ6jkFWXKgYqL81EopZR8bc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-02_05,2021-11-01_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 mlxlogscore=732 spamscore=0
 impostorscore=0 mlxscore=0 suspectscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111020037
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This set fixes an issue that the verifier rejects a u64 stack read
after an earlier u32 scalar spill.  It is caused by the earlier commit
that allows tracking the spilled u32 scalar reg.

Martin KaFai Lau (2):
  bpf: Do not reject when the stack read size is different from the
    tracked scalar size
  bpf: selftest: verifier test on refill from a smaller spill

 kernel/bpf/verifier.c                          | 18 ++++++------------
 .../selftests/bpf/verifier/spill_fill.c        | 17 +++++++++++++++++
 2 files changed, 23 insertions(+), 12 deletions(-)

--=20
2.30.2

