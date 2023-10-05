Return-Path: <bpf+bounces-11438-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 489AE7B9D79
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 15:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 438F7B209ED
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 13:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A286224D6;
	Thu,  5 Oct 2023 13:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7911F60C
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 13:45:32 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7DA28123
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 06:45:31 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 3950CaE4025726
	for <bpf@vger.kernel.org>; Wed, 4 Oct 2023 20:24:09 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 3th7gma7m3-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 04 Oct 2023 20:24:09 -0700
Received: from twshared27355.37.frc1.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 4 Oct 2023 20:24:07 -0700
Received: by devbig932.frc1.facebook.com (Postfix, from userid 4523)
	id D4FCD2576602D; Wed,  4 Oct 2023 20:23:55 -0700 (PDT)
From: Song Liu <song@kernel.org>
To: <bpf@vger.kernel.org>
CC: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <martin.lau@kernel.org>, <kernel-team@meta.com>,
        Song Liu <song@kernel.org>, Tejun Heo <tj@kernel.org>
Subject: [PATCH v3 bpf-next] bpf: Avoid unnecessary -EBUSY from htab_lock_bucket
Date: Wed, 4 Oct 2023 20:23:50 -0700
Message-ID: <20231005032350.1877318-1-song@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: IRBa_xTQ0vjOMafR_GhsjcIFwN_U2oe3
X-Proofpoint-ORIG-GUID: IRBa_xTQ0vjOMafR_GhsjcIFwN_U2oe3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_13,2023-10-02_01,2023-05-22_02
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

htab_lock_bucket uses the following logic to avoid recursion:

1. preempt_disable();
2. check percpu counter htab->map_locked[hash] for recursion;
   2.1. if map_lock[hash] is already taken, return -BUSY;
3. raw_spin_lock_irqsave();

However, if an IRQ hits between 2 and 3, BPF programs attached to the IRQ
logic will not able to access the same hash of the hashtab and get -EBUSY=
.
This -EBUSY is not really necessary. Fix it by disabling IRQ before
checking map_locked:

1. preempt_disable();
2. local_irq_save();
3. check percpu counter htab->map_locked[hash] for recursion;
   3.1. if map_lock[hash] is already taken, return -BUSY;
4. raw_spin_lock().

Similarly, use raw_spin_unlock() and local_irq_restore() in
htab_unlock_bucket().

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Song Liu <song@kernel.org>

---
Changes in v3:
1. Use raw_local_irq_* APIs instead.

Changes in v2:
1. Use raw_spin_unlock() and local_irq_restore() in htab_unlock_bucket().
   (Andrii)
---
 kernel/bpf/hashtab.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index a8c7e1c5abfa..74c8d1b41dd5 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -155,13 +155,15 @@ static inline int htab_lock_bucket(const struct bpf=
_htab *htab,
 	hash =3D hash & min_t(u32, HASHTAB_MAP_LOCK_MASK, htab->n_buckets - 1);
=20
 	preempt_disable();
+	raw_local_irq_save(flags);
 	if (unlikely(__this_cpu_inc_return(*(htab->map_locked[hash])) !=3D 1)) =
{
 		__this_cpu_dec(*(htab->map_locked[hash]));
+		raw_local_irq_restore(flags);
 		preempt_enable();
 		return -EBUSY;
 	}
=20
-	raw_spin_lock_irqsave(&b->raw_lock, flags);
+	raw_spin_lock(&b->raw_lock);
 	*pflags =3D flags;
=20
 	return 0;
@@ -172,8 +174,9 @@ static inline void htab_unlock_bucket(const struct bp=
f_htab *htab,
 				      unsigned long flags)
 {
 	hash =3D hash & min_t(u32, HASHTAB_MAP_LOCK_MASK, htab->n_buckets - 1);
-	raw_spin_unlock_irqrestore(&b->raw_lock, flags);
+	raw_spin_unlock(&b->raw_lock);
 	__this_cpu_dec(*(htab->map_locked[hash]));
+	raw_local_irq_restore(flags);
 	preempt_enable();
 }
=20
--=20
2.34.1


