Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 126EF446BED
	for <lists+bpf@lfdr.de>; Sat,  6 Nov 2021 02:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbhKFBmz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Nov 2021 21:42:55 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:35054 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229816AbhKFBmy (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 5 Nov 2021 21:42:54 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A5Mxc9m005054
        for <bpf@vger.kernel.org>; Fri, 5 Nov 2021 18:40:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=Xn9Kh/GquhY+8q5oo9ykxxv/3AfhfFX+C+XOejPkAOo=;
 b=dPVVbQD3gGiS0tXjIz3tPkNITS64U2YNwvbxsQ5NX9lbruFIE1qJ+9jNc7v4nmksdnmg
 jWMOOPyDinRuTTxdo2zGXl4T2Rh/72Wn9caOvzzVOXvscx1iPq6IcTKb2BVKbTpjgiJ4
 DSbuoUdUFi06CTQQufgJK9hO71lHgisOszk= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3c56mtmc5t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 05 Nov 2021 18:40:13 -0700
Received: from intmgw001.37.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 5 Nov 2021 18:40:12 -0700
Received: by devbig005.ftw2.facebook.com (Postfix, from userid 6611)
        id CE55F1F57C28; Fri,  5 Nov 2021 18:40:07 -0700 (PDT)
From:   Martin KaFai Lau <kafai@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Yonghong Song <yhs@fb.com>
Subject: [PATCH bpf 0/2] bpf: Fix out-of-bound issue when jit-ing bpf_pseudo_func
Date:   Fri, 5 Nov 2021 18:40:07 -0700
Message-ID: <20211106014007.650366-1-kafai@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: pkwy2b2dfxp0n6FYtnjqdWz5z_hmHktU
X-Proofpoint-ORIG-GUID: pkwy2b2dfxp0n6FYtnjqdWz5z_hmHktU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-05_03,2021-11-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 mlxlogscore=569 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111060006
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This set fixes an out-of-bound access issue when jit-ing the
bpf_pseudo_func insn (i.e. ld_imm64 with src_reg =3D=3D BPF_PSEUDO_FUNC)

Martin KaFai Lau (2):
  bpf: Stop caching subprog index in the bpf_pseudo_func insn
  bpf: selftest: Trigger a DCE on the whole subprog

 include/linux/bpf.h                           |  6 +++
 kernel/bpf/core.c                             |  7 ++++
 kernel/bpf/verifier.c                         | 37 +++++++------------
 .../bpf/progs/for_each_array_map_elem.c       | 12 ++++++
 4 files changed, 39 insertions(+), 23 deletions(-)

--=20
2.30.2

