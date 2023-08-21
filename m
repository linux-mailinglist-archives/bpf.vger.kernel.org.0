Return-Path: <bpf+bounces-8173-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8C77830F0
	for <lists+bpf@lfdr.de>; Mon, 21 Aug 2023 21:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5F26280EA7
	for <lists+bpf@lfdr.de>; Mon, 21 Aug 2023 19:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18401170C;
	Mon, 21 Aug 2023 19:33:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B355D5684
	for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 19:33:37 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D865199
	for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 12:33:36 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37LJ9tge016647
	for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 12:33:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=nKn3ObyA89nGztuGCeD7108KeUo9BwPh6j527USvn8w=;
 b=Vl2nF4QktbiYa1llf3lf4HoKNJCpciWmf/4NGnGMQVtfb1F/IJnAf30NjMr7p1TfP+1J
 zCuzrUZ45hpB0WjQq9TsvF17Qy2X1ygOEaHYrhlJ/1aDTAVPGWma4fMCWUAe2dXxD+px
 aF20VtftWhg+BRdcjOyyd1VSAvBT1zk4O34= 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3sjujxxmxp-15
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 12:33:35 -0700
Received: from twshared29562.14.frc2.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 21 Aug 2023 12:33:23 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
	id C31512302404A; Mon, 21 Aug 2023 12:33:17 -0700 (PDT)
From: Dave Marchevsky <davemarchevsky@fb.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann
	<daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
	<martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>, <yonghong.song@linux.dev>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH v2 bpf-next 3/7] bpf: Use bpf_mem_free_rcu when bpf_obj_dropping refcounted nodes
Date: Mon, 21 Aug 2023 12:33:07 -0700
Message-ID: <20230821193311.3290257-4-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230821193311.3290257-1-davemarchevsky@fb.com>
References: <20230821193311.3290257-1-davemarchevsky@fb.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: iEjWVOCmgOojyl3g6NRV1N_fdh6lZlJA
X-Proofpoint-ORIG-GUID: iEjWVOCmgOojyl3g6NRV1N_fdh6lZlJA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-21_08,2023-08-18_01,2023-05-22_02
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This is the final fix for the use-after-free scenario described in
commit 7793fc3babe9 ("bpf: Make bpf_refcount_acquire fallible for
non-owning refs"). That commit, by virtue of changing
bpf_refcount_acquire's refcount_inc to a refcount_inc_not_zero, fixed
the "refcount incr on 0" splat. The not_zero check in
refcount_inc_not_zero, though, still occurs on memory that could have
been free'd and reused, so the commit didn't properly fix the root
cause.

This patch actually fixes the issue by free'ing using the recently-added
bpf_mem_free_rcu, which ensures that the memory is not reused until
RCU grace period has elapsed. If that has happened then
there are no non-owning references alive that point to the
recently-free'd memory, so it can be safely reused.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/helpers.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index eb91cae0612a..945a85e25ac5 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1913,7 +1913,11 @@ void __bpf_obj_drop_impl(void *p, const struct btf=
_record *rec)
=20
 	if (rec)
 		bpf_obj_free_fields(rec, p);
-	bpf_mem_free(&bpf_global_ma, p);
+
+	if (rec && rec->refcount_off >=3D 0)
+		bpf_mem_free_rcu(&bpf_global_ma, p);
+	else
+		bpf_mem_free(&bpf_global_ma, p);
 }
=20
 __bpf_kfunc void bpf_obj_drop_impl(void *p__alloc, void *meta__ign)
--=20
2.34.1


