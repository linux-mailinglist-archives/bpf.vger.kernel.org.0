Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3D91D3E6A
	for <lists+bpf@lfdr.de>; Thu, 14 May 2020 22:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729167AbgENUEW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 May 2020 16:04:22 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:9384 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727835AbgENUEW (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 14 May 2020 16:04:22 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04EK1gKw000652
        for <bpf@vger.kernel.org>; Thu, 14 May 2020 13:04:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=xNEMGpazQZkGrM+X/Z7npQaDEFFPsQ034Y4ro/SGNUM=;
 b=F3xLyrq6ho7Fhj6GM6z/JPwlbjNz5oCSDV0iHrIYDASLJ6No6hwe34eTa0oHtW6ri7qf
 oJFjW0VqQJC0a6wliK5DBGAgZ7/U5e18spme2rFjinWp+nChjbzgo2jSrMG7C6+zFQZN
 e6hEYvH95ujcrgb0SxZAPGt8kAoVWM7ijQ0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3100xbdgaq-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 14 May 2020 13:04:22 -0700
Received: from intmgw002.41.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Thu, 14 May 2020 13:04:04 -0700
Received: by dev082.prn2.facebook.com (Postfix, from userid 572249)
        id 0452637009C6; Thu, 14 May 2020 13:04:02 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrey Ignatov <rdna@fb.com>
Smtp-Origin-Hostname: dev082.prn2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Andrey Ignatov <rdna@fb.com>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <yhs@fb.com>, <kernel-team@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v3 bpf-next 0/5] bpf: sk lookup, cgroup id helpers in cgroup skb
Date:   Thu, 14 May 2020 13:03:44 -0700
Message-ID: <cover.1589486450.git.rdna@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-14_07:2020-05-14,2020-05-14 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 cotscore=-2147483648 mlxscore=0 suspectscore=13 lowpriorityscore=0
 impostorscore=0 bulkscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 adultscore=0 mlxlogscore=971 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005140177
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

v2->v3:
- better documentation for bpf_sk_cgroup_id in uapi (Yonghong Song)
- save/restore errno in network helpers (Yonghong Song)
- cleanup leftover after switching selftest to skeleton (Yonghong Song)
- switch from map to skel->bss in selftest (Yonghong Song)

v1->v2:
- switch selftests to skeleton.

This patch set allows a bunch of existing sk lookup and skb cgroup id
helpers, and adds two new bpf_sk_{,ancestor_}cgroup_id helpers to be used
in cgroup skb programs.

It fills the gap to cover a use-case to apply intra-host cgroup-bpf netwo=
rk
policy based on a source cgroup a packet comes from.

For example, there can be multiple containers A, B, C running on a host.
Every such container runs in its own cgroup that can have multiple
sub-cgroups. But all these containers can share some IP addresses.

At the same time container A wants to have a policy for a server S runnin=
g
in it so that only clients from this same container can connect to S, but
not from other containers (such as B, C). Source IP address can't be used
to decide whether to allow or deny a packet, but it looks reasonable to
filter by cgroup id.

The patch set allows to implement the following policy:
* when an ingress packet comes to container's cgroup, lookup peer (client=
)
  socket this packet comes from;
* having peer socket, get its cgroup id;
* compare peer cgroup id with self cgroup id and allow packet only if the=
y
  match, i.e. it comes from same cgroup;
* the "sub-cgroup" part of the story can be addressed by getting not dire=
ct
  cgroup id of the peer socket, but ancestor cgroup id on specified level=
,
  similar to existing "ancestor" flavors of cgroup id helpers.

A newly introduced selftest implements such a policy in its basic form to
provide a better idea on the use-case.

Patch 1 allows existing sk lookup helpers in cgroup skb.
Patch 2 allows skb_ancestor_cgroup_id in cgrou skb.
Patch 3 introduces two new helpers to get cgroup id of socket.
Patch 4 extends network helpers to use them in the next patch.
Patch 5 adds selftest / example of use-case.


Andrey Ignatov (5):
  bpf: Allow sk lookup helpers in cgroup skb
  bpf: Allow skb_ancestor_cgroup_id helper in cgroup skb
  bpf: Introduce bpf_sk_{,ancestor_}cgroup_id helpers
  selftests/bpf: Add connect_fd_to_fd, connect_wait net helpers
  selftests/bpf: Test for sk helpers in cgroup skb

 include/uapi/linux/bpf.h                      | 36 ++++++-
 net/core/filter.c                             | 70 +++++++++++--
 tools/include/uapi/linux/bpf.h                | 36 ++++++-
 tools/testing/selftests/bpf/network_helpers.c | 74 +++++++++++---
 tools/testing/selftests/bpf/network_helpers.h |  2 +
 .../bpf/prog_tests/cgroup_skb_sk_lookup.c     | 95 ++++++++++++++++++
 .../bpf/progs/cgroup_skb_sk_lookup_kern.c     | 97 +++++++++++++++++++
 7 files changed, 386 insertions(+), 24 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_skb_sk_=
lookup.c
 create mode 100644 tools/testing/selftests/bpf/progs/cgroup_skb_sk_looku=
p_kern.c

--=20
2.24.1

