Return-Path: <bpf+bounces-11301-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 547B47B7231
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 22:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id CB576281320
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 20:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA2D3CD1A;
	Tue,  3 Oct 2023 20:05:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D028C3B797
	for <bpf@vger.kernel.org>; Tue,  3 Oct 2023 20:05:03 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3B7AB
	for <bpf@vger.kernel.org>; Tue,  3 Oct 2023 13:05:01 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 393JPwpr027688
	for <bpf@vger.kernel.org>; Tue, 3 Oct 2023 13:05:00 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3tg7c23syd-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 03 Oct 2023 13:05:00 -0700
Received: from twshared29562.14.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 3 Oct 2023 13:04:57 -0700
Received: by devbig932.frc1.facebook.com (Postfix, from userid 4523)
	id 655082562E56D; Tue,  3 Oct 2023 13:04:53 -0700 (PDT)
From: Song Liu <song@kernel.org>
To: <bpf@vger.kernel.org>
CC: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <martin.lau@kernel.org>, <kernel-team@meta.com>,
        Song Liu <song@kernel.org>, Tejun Heo <tj@kernel.org>
Subject: [PATCH bpf-next] bpf: Avoid unnecessary -EBUSY from htab_lock_bucket
Date: Tue, 3 Oct 2023 13:04:34 -0700
Message-ID: <20231003200434.3154797-1-song@kernel.org>
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
X-Proofpoint-GUID: pb00e5K4EJHSphSuIbDUaWc7MfTbInox
X-Proofpoint-ORIG-GUID: pb00e5K4EJHSphSuIbDUaWc7MfTbInox
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-03_17,2023-10-02_01,2023-05-22_02
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

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Song Liu <song@kernel.org>
---
 kernel/bpf/hashtab.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index a8c7e1c5abfa..347af4476662 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -155,13 +155,15 @@ static inline int htab_lock_bucket(const struct bpf=
_htab *htab,
 	hash =3D hash & min_t(u32, HASHTAB_MAP_LOCK_MASK, htab->n_buckets - 1);
=20
 	preempt_disable();
+	local_irq_save(flags);
 	if (unlikely(__this_cpu_inc_return(*(htab->map_locked[hash])) !=3D 1)) =
{
 		__this_cpu_dec(*(htab->map_locked[hash]));
+		local_irq_restore(flags);
 		preempt_enable();
 		return -EBUSY;
 	}
=20
-	raw_spin_lock_irqsave(&b->raw_lock, flags);
+	raw_spin_lock(&b->raw_lock);
 	*pflags =3D flags;
=20
 	return 0;
--=20
2.34.1


