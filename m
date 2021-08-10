Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59FD13E507F
	for <lists+bpf@lfdr.de>; Tue, 10 Aug 2021 03:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234936AbhHJBEs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Aug 2021 21:04:48 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:4300 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233683AbhHJBEr (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 9 Aug 2021 21:04:47 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 17A14QD8013480
        for <bpf@vger.kernel.org>; Mon, 9 Aug 2021 18:04:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=dFCsoSJwJIovvxd9pFKZGPG+pi7JC4/nLaTuso5Ajn8=;
 b=Vzfp7+xlVbRXXfv+I8Iktze3Uk9Y6Fp7hl5+ronJbMUPaNmhcWAPf5YpspuNuQAtQlDK
 4EiLV7WWRrYKuDdIVK7wIPctdho1aHUhSdWheoihPC+jSf2wpBARZmceX71C4GflM5pj
 Qs9P76DOrNRQTkItcyZJGdiecs0jxjXD38k= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 3ab6mmu7tm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 09 Aug 2021 18:04:26 -0700
Received: from intmgw001.37.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 9 Aug 2021 18:04:17 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 9CC755D4D86F; Mon,  9 Aug 2021 18:04:13 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>
Subject: [PATCH bpf] bpf: fix potentially incorrect results with bpf_get_local_storage()
Date:   Mon, 9 Aug 2021 18:04:13 -0700
Message-ID: <20210810010413.1976277-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: kcUNgLP0JmhfsYkyK0thutDMElGrhZCg
X-Proofpoint-ORIG-GUID: kcUNgLP0JmhfsYkyK0thutDMElGrhZCg
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-09_09:2021-08-06,2021-08-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 clxscore=1015 impostorscore=0 suspectscore=0 lowpriorityscore=0 mlxscore=0
 adultscore=0 priorityscore=1501 spamscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108100005
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Commit b910eaaaa4b8 ("bpf: Fix NULL pointer dereference in
bpf_get_local_storage() helper") fixed a bug for bpf_get_local_storage()
helper so different tasks won't mess up with each other's
percpu local storage.

The percpu data contains 8 slots so it can hold up to 8 contexts
(same or different tasks), for 8 different program runs,
at the same time. This in general is sufficient. But our internal
testing showed the following warning multiple times:

  warning: WARNING: CPU: 13 PID: 41661 at include/linux/bpf-cgroup.h:193
     __cgroup_bpf_run_filter_sock_ops+0x13e/0x180
  RIP: 0010:__cgroup_bpf_run_filter_sock_ops+0x13e/0x180
  <IRQ>
   tcp_call_bpf.constprop.99+0x93/0xc0
   tcp_conn_request+0x41e/0xa50
   ? tcp_rcv_state_process+0x203/0xe00
   tcp_rcv_state_process+0x203/0xe00
   ? sk_filter_trim_cap+0xbc/0x210
   ? tcp_v6_inbound_md5_hash.constprop.41+0x44/0x160
   tcp_v6_do_rcv+0x181/0x3e0
   tcp_v6_rcv+0xc65/0xcb0
   ip6_protocol_deliver_rcu+0xbd/0x450
   ip6_input_finish+0x11/0x20
   ip6_input+0xb5/0xc0
   ip6_sublist_rcv_finish+0x37/0x50
   ip6_sublist_rcv+0x1dc/0x270
   ipv6_list_rcv+0x113/0x140
   __netif_receive_skb_list_core+0x1a0/0x210
   netif_receive_skb_list_internal+0x186/0x2a0
   gro_normal_list.part.170+0x19/0x40
   napi_complete_done+0x65/0x150
   mlx5e_napi_poll+0x1ae/0x680
   __napi_poll+0x25/0x120
   net_rx_action+0x11e/0x280
   __do_softirq+0xbb/0x271
   irq_exit_rcu+0x97/0xa0
   common_interrupt+0x7f/0xa0
   </IRQ>
   asm_common_interrupt+0x1e/0x40
  RIP: 0010:bpf_prog_1835a9241238291a_tw_egress+0x5/0xbac
   ? __cgroup_bpf_run_filter_skb+0x378/0x4e0
   ? do_softirq+0x34/0x70
   ? ip6_finish_output2+0x266/0x590
   ? ip6_finish_output+0x66/0xa0
   ? ip6_output+0x6c/0x130
   ? ip6_xmit+0x279/0x550
   ? ip6_dst_check+0x61/0xd0
  ...

Using drgn to dump the percpu buffer contents showed that
on this cpu slot 0 is still available but
slots 1-7 are occupied and those tasks in slots 1-7 mostly don't exist
any more. So we might have issues in bpf_cgroup_storage_unset().

Further debugging confirmed that there is a bug in bpf_cgroup_storage_uns=
et().
Currently, it tries to unset "current" slot with searching from the start=
.
So the following sequence is possible:
  1. a task is running and claims slot 0
  2. running bpf program is done, and it checked slot "0" has the "task"
     and ready to reset it to NULL (not yet).
  3. an interrupt happens, another bpf program runs and it claims slot 1
     with the *same* task.
  4. the unset() in interrupt context releases slot 0 since it matches "t=
ask".
  5. interrupt is done, the task in process context reset slot 0.

At the end, slot 1 is not reset and the same process can continue to occu=
py
slots 2-7 and finally, when the above step 1-5 is repeated again, step 3 =
bpf program
won't be able to claim an empty slot and a warning will be issued.

To fix the issue, for unset() function, we should traverse from the last =
slot
to the first. This way, the above issue can be avoided.

The same reverse traversal should also be done in bpf_get_local_storage()=
 helper
itself. Otherwise, incorrect local storage may be returned to bpf program=
.

Cc: Roman Gushchin <guro@fb.com>
Fixes: b910eaaaa4b8 ("bpf: Fix NULL pointer dereference in bpf_get_local_=
storage() helper")
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 include/linux/bpf-cgroup.h | 4 ++--
 kernel/bpf/helpers.c       | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

This patch targets to bpf tree. In bpf-next,
Andrii's c7603cfa04e7 ("bpf: Add ambient BPF runtime context stored in cu=
rrent")
should have fixed the issue too. I also okay with backporting Andrii's pa=
tch
to bpf tree if it is viable.

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index 8b77d08d4b47..6c9b10d82c80 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -201,8 +201,8 @@ static inline void bpf_cgroup_storage_unset(void)
 {
 	int i;
=20
-	for (i =3D 0; i < BPF_CGROUP_STORAGE_NEST_MAX; i++) {
-		if (unlikely(this_cpu_read(bpf_cgroup_storage_info[i].task) !=3D curre=
nt))
+	for (i =3D BPF_CGROUP_STORAGE_NEST_MAX - 1; i >=3D 0; i--) {
+		if (likely(this_cpu_read(bpf_cgroup_storage_info[i].task) !=3D current=
))
 			continue;
=20
 		this_cpu_write(bpf_cgroup_storage_info[i].task, NULL);
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 62cf00383910..9b3f16eee21f 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -397,8 +397,8 @@ BPF_CALL_2(bpf_get_local_storage, struct bpf_map *, m=
ap, u64, flags)
 	void *ptr;
 	int i;
=20
-	for (i =3D 0; i < BPF_CGROUP_STORAGE_NEST_MAX; i++) {
-		if (unlikely(this_cpu_read(bpf_cgroup_storage_info[i].task) !=3D curre=
nt))
+	for (i =3D BPF_CGROUP_STORAGE_NEST_MAX - 1; i >=3D 0; i--) {
+		if (likely(this_cpu_read(bpf_cgroup_storage_info[i].task) !=3D current=
))
 			continue;
=20
 		storage =3D this_cpu_read(bpf_cgroup_storage_info[i].storage[stype]);
--=20
2.30.2

