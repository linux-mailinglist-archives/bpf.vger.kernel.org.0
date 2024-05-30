Return-Path: <bpf+bounces-30897-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DB38D45AD
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 09:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1F6A1F22D29
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 07:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F1715CD57;
	Thu, 30 May 2024 07:00:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50963143727
	for <bpf@vger.kernel.org>; Thu, 30 May 2024 07:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717052419; cv=none; b=bTXWD4vsplnzQdHy7OMMARLHGNcfm6A+rLliD/IY5a6A5TIysv91V7wDwu3y5cPnukl7WHxs3v/xfNwvXe70LdQSVFToaPDRWKqj4tSXcIV/pjAvG54gVfiZNaNs8G1iuqwWvSSqEti+YUlCRIJEhZb2PdH0EuYEl0EFIdJFfWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717052419; c=relaxed/simple;
	bh=9QLmlGAU7ehEfMueAEgzAqYagkKekQ+i33u5L8FQj9s=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=nfxWZKQoJqNwHQOSLTtZgw0LBMrm1AGDGjOSxImhKuD9BCdhBo6r3NwzwZOpVXxuZvjb5+fz650fIHFhdltCrO3Qh+vxHc/E7TT/XjvU4xVx5WDaAhCKj4zMhSykYsN2vBb3Uu/kjs93FS5Phh+tuqTUjwGeVBwOjkNA0zqf5Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=meta.com; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44U3oLgD028619
	for <bpf@vger.kernel.org>; Thu, 30 May 2024 00:00:17 -0700
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3yehw5gn52-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 30 May 2024 00:00:17 -0700
Received: from twshared20758.33.frc3.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Thu, 30 May 2024 07:00:14 +0000
Received: by devbig1475.frc2.facebook.com (Postfix, from userid 460691)
	id 8CC645DFF36E; Thu, 30 May 2024 00:00:00 -0700 (PDT)
From: <thinker.li@gmail.com>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <martin.lau@linux.dev>,
        <kernel-team@meta.com>, <andrii@kernel.org>, <sinquersw@gmail.com>,
        <kuifeng@meta.com>, <thinker.li@gmail.com>
Subject: [PATCH bpf-next v7 0/8] Notify user space when a struct_ops object is detached/unregistered
Date: Wed, 29 May 2024 23:59:38 -0700
Message-ID: <20240530065946.979330-1-thinker.li@gmail.com>
X-Mailer: git-send-email 2.43.0
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: J99BSIJoR2rz7IZNQMAbvTeZNEyvrOUs
X-Proofpoint-GUID: J99BSIJoR2rz7IZNQMAbvTeZNEyvrOUs
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-30_04,2024-05-28_01,2024-05-17_01

From: Kui-Feng Lee <kuifeng@meta.com>

The subsystems managing struct_ops objects may need to detach a
struct_ops object due to errors or other reasons. It would be useful
to notify user space programs so that error recovery or logging can be
carried out.

This patch set enables the detach feature for struct_ops links and
send an event to epoll when a link is detached.  Subsystems could call
link->ops->detach() to detach a link and notify user space programs
through epoll.

The signatures of callback functions in "struct bpf_struct_ops" have
been changed as well to pass an extra link argument to
subsystems. Subsystems could detach the links received from reg() and
update() callbacks if there is. This also provides a way that
subsystems can distinguish registrations for an object that has been
registered multiple times for several links.

However, bpf struct_ops maps without BPF_F_LINK have no any link.
Subsystems will receive NULL link pointer for this case.

---
Changes from v6:

 - Fix the missing header at patch 5.

 - Move RCU_INIT_POINTER() back to its original position.

Changes from v5:

 - Change the commit title of the patch for bpftool.

Changes from v4:

 - Change error code for bpf_struct_ops_map_link_update()

 - Always return 0 for bpf_struct_ops_map_link_detach()

 - Hold update_mutex in bpf_struct_ops_link_create()

 - Add a separated instance of file_operations for links supporting
    poll.

 - Fix bpftool for bpf_link_fops_poll.

Changes from v3:

 - Add a comment to explain why holding update_mutex is not necessary
    in bpf_struct_ops_link_create()

 - Use rcu_access_pointer() in bpf_struct_ops_map_link_poll().

Changes from v2:

 - Rephrased commit logs and comments.

 - Addressed some mistakes from patch splitting.

 - Replace mutex with spinlock in bpf_testmod.c to address lockdep
    Splat and simplify the implementation.

 - Fix an argument passing to rcu_dereference_protected().

Changes from v1:

 - Pass a link to reg, unreg, and update callbacks.

 - Provide a function to detach a link from underlying subsystems.

 - Add a kfunc to mimic detachments from subsystems, and provide a
    flexible way to control when to do detachments.

 - Add two tests to detach a link from the subsystem after the refcount
    of the link drops to zero.

v6: https://lore.kernel.org/bpf/20240524223036.318800-1-thinker.li@gmail.co=
m/
v5: https://lore.kernel.org/all/20240523230848.2022072-1-thinker.li@gmail.c=
om/
v4: https://lore.kernel.org/all/20240521225121.770930-1-thinker.li@gmail.co=
m/
v3: https://lore.kernel.org/all/20240510002942.1253354-1-thinker.li@gmail.c=
om/
v2: https://lore.kernel.org/all/20240507055600.2382627-1-thinker.li@gmail.c=
om/
v1: https://lore.kernel.org/all/20240429213609.487820-1-thinker.li@gmail.co=
m/


Kui-Feng Lee (8):
  bpf: pass bpf_struct_ops_link to callbacks in bpf_struct_ops.
  bpf: enable detaching links of struct_ops objects.
  bpf: support epoll from bpf struct_ops links.
  bpf: export bpf_link_inc_not_zero.
  selftests/bpf: test struct_ops with epoll
  selftests/bpf: detach a struct_ops link from the subsystem managing
    it.
  selftests/bpf: make sure bpf_testmod handling racing link destroying
    well.
  bpftool: Change pid_iter.bpf.c to comply with the change of
    bpf_link_fops.

 include/linux/bpf.h                           |  13 +-
 kernel/bpf/bpf_struct_ops.c                   |  72 ++++++--
 kernel/bpf/syscall.c                          |  34 +++-
 net/bpf/bpf_dummy_struct_ops.c                |   4 +-
 net/ipv4/bpf_tcp_ca.c                         |   6 +-
 tools/bpf/bpftool/skeleton/pid_iter.bpf.c     |   7 +-
 .../bpf/bpf_test_no_cfi/bpf_test_no_cfi.c     |   4 +-
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  48 ++++-
 .../bpf/bpf_testmod/bpf_testmod_kfunc.h       |   1 +
 .../bpf/prog_tests/test_struct_ops_module.c   | 168 ++++++++++++++++++
 .../selftests/bpf/progs/struct_ops_detach.c   |  17 ++
 11 files changed, 344 insertions(+), 30 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_detach.c

--=20
2.43.0


