Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF6463DC8F4
	for <lists+bpf@lfdr.de>; Sun,  1 Aug 2021 01:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbhGaXd2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 31 Jul 2021 19:33:28 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:47706 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229449AbhGaXd2 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 31 Jul 2021 19:33:28 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16VNEBPb004686
        for <bpf@vger.kernel.org>; Sat, 31 Jul 2021 16:33:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=HD3wSVNd3+9Z9Wo8mAqH6cUfUOmpG2rhej5gPge0ur4=;
 b=j6QFbyukE0LpjiZIyD6r4qaLc05TZ1T5FfWIZN9BHD3Uzyul9k/FYC7sXnKEf9pNARqg
 14eSoex4tFePTMYMgyclEOr4+fxRRer+Q3z+vLLVsTkIAX0/+wm2ffl/8iIrI4llV92c
 tG+j1yy3QoU/pN6VCfD2P/E9NGr0K69kXxY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3a54bxjbb8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sat, 31 Jul 2021 16:33:21 -0700
Received: from intmgw001.37.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 31 Jul 2021 16:33:20 -0700
Received: by devbig030.frc3.facebook.com (Postfix, from userid 158236)
        id 5ADFF4B6972B; Sat, 31 Jul 2021 16:31:03 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <netdev@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH bpf-next 0/1] Refactor cgroup_bpf internals to use more specific attach_type
Date:   Sat, 31 Jul 2021 16:30:55 -0700
Message-ID: <20210731233056.850105-1-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: nynvp4lprXKMeCSkAn6wEFr--lOsfOx9
X-Proofpoint-GUID: nynvp4lprXKMeCSkAn6wEFr--lOsfOx9
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-31_05:2021-07-30,2021-07-31 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=1 mlxscore=1 adultscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 clxscore=1015 mlxlogscore=206 impostorscore=0 spamscore=1
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107310136
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The cgroup_bpf struct has a few arrays (effective, progs, and flags) of
size MAX_BPF_ATTACH_TYPE. These are meant to separate progs by their
attach type, currently represented by the bpf_attach_type enum.

There are some bpf_attach_type values which are not valid attach types
for cgroup bpf programs. Programs with these attach types will never be
handled by cgroup_bpf_{attach,detach} and thus will never be held in
cgroup_bpf structs. Even if such programs did make it into their
reserved slot in those arrays, they would never be executed.

Accordingly we can migrate to a new internal cgroup_bpf-specific enum
for these arrays, saving some bytes per cgroup and making it more
obvious which BPF programs belong there. netns_bpf_attach_type is an
existing example of this pattern, let's do similar for cgroup_bpf.

Dave Marchevsky (1):
  bpf: migrate cgroup_bpf to internal cgroup_bpf_attach_type enum

 include/linux/bpf-cgroup.h     | 200 +++++++++++++++++++++++----------
 include/uapi/linux/bpf.h       |   2 +-
 kernel/bpf/cgroup.c            | 154 +++++++++++++++----------
 net/ipv4/af_inet.c             |   6 +-
 net/ipv4/udp.c                 |   2 +-
 net/ipv6/af_inet6.c            |   6 +-
 net/ipv6/udp.c                 |   2 +-
 tools/include/uapi/linux/bpf.h |   2 +-
 8 files changed, 243 insertions(+), 131 deletions(-)

--=20
2.30.2

