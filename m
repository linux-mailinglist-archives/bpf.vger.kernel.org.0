Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 692C23F161B
	for <lists+bpf@lfdr.de>; Thu, 19 Aug 2021 11:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbhHSJ1t (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Aug 2021 05:27:49 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:19146 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229448AbhHSJ1t (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 19 Aug 2021 05:27:49 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17J9PVIE024181
        for <bpf@vger.kernel.org>; Thu, 19 Aug 2021 02:27:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=O6uvQ9EiodPLJJ63u5SRyu8eNdFypp1rd9Rd60ekGXA=;
 b=i+FZNwVqiiujl/GZjSVJMbqkJkCUIJjfJbxFlaYzk3QaRPwHPl0C5uHdpxAbX2qqBd1h
 86ZkkH0qb28sBN4Praw1QD+gQ/khy+DI4SlIaMP5btU8jJxUokYseOZvuyioGGwkO4Y2
 trYpBX2KVzxRAeje7z//coM9WISsLkNTt6g= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3agw6uyxvt-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 19 Aug 2021 02:27:13 -0700
Received: from intmgw001.25.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 19 Aug 2021 02:27:11 -0700
Received: by devbig030.frc3.facebook.com (Postfix, from userid 158236)
        id A01A95607A91; Thu, 19 Aug 2021 02:24:22 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 0/1] Refactor cgroup_bpf internals to use more specific attach_type
Date:   Thu, 19 Aug 2021 02:24:19 -0700
Message-ID: <20210819092420.1984861-1-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: FbuzxW2EdIG2ISBhDSyqn87kmVL4MJJO
X-Proofpoint-ORIG-GUID: FbuzxW2EdIG2ISBhDSyqn87kmVL4MJJO
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-19_03:2021-08-17,2021-08-19 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=263
 impostorscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 adultscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108190053
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

v1->v2: Address Daniel's comments
	* Reverse xmas tree ordering for def changes
	* Helper macro to reduce to_cgroup_bpf_attach_type boilerplate
		* checkpatch.pl complains: "ERROR: Macros with complex values should
		be enclosed in parentheses". Found some existing macros (do 'git grep
		"define case"') which get same complaint. Think it's fine to keep
		as-is since it's immediately undef'd.
	* Remove CG_BPF_ prefix from cgroup_bpf_attach_type
		* Although I agree that the prefix is redundant, the de-prefixed
		names feel a bit too 'general' given the internal use of the enum.
		e.g. when someone sees CGROUP_INET6_BIND it's not obvious that it
		should only be used in certain ways internally.
		* Don't feel strongly about this, just my thoughts as a noob to the
		internals.
	* Rebase onto latest bpf-next/master
		* No significant conflicts, some small boilerplate adjustments
		needed to catch up to Andrii's "bpf: Refactor BPF_PROG_RUN_ARRAY
		family of macros into functions" change

Dave Marchevsky (1):
  bpf: migrate cgroup_bpf to internal cgroup_bpf_attach_type enum

 include/linux/bpf-cgroup.h     | 183 ++++++++++++++++++++++-----------
 include/uapi/linux/bpf.h       |   2 +-
 kernel/bpf/cgroup.c            | 156 ++++++++++++++++------------
 net/ipv4/af_inet.c             |   6 +-
 net/ipv4/udp.c                 |   2 +-
 net/ipv6/af_inet6.c            |   6 +-
 net/ipv6/udp.c                 |   2 +-
 tools/include/uapi/linux/bpf.h |   2 +-
 8 files changed, 227 insertions(+), 132 deletions(-)

--=20
2.30.2

