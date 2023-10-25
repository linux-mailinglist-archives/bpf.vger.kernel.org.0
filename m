Return-Path: <bpf+bounces-13278-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F051D7D76F2
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 23:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50106B212B3
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 21:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5194C34CD9;
	Wed, 25 Oct 2023 21:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="dxjAuSPZ"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E323C347B3
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 21:41:36 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB40136
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 14:41:35 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 39PLfN7v016371
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 14:41:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=u1mwzOBOumnuoaozJun/EBkUPrOGhB2spOdav+s1e/U=;
 b=dxjAuSPZM7Hl+49hNbzqt7AQI/UUcbGP//KhEuojo2SkUqJwtkl7aStIy8/6mG0IF0na
 9QzWA7Qhj8pG8SVArKTR3wy++tfYn/z4ijCBlbeCrJcjUdjOLVW4bFXKS59nTvxm7YA8
 9VSIFOYfITu3OKYkNx4EP5YQ3d5CzuVrehk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 3ty54a36fj-12
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 14:41:34 -0700
Received: from twshared20079.02.ash8.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 25 Oct 2023 14:40:26 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
	id EC093264D46DA; Wed, 25 Oct 2023 14:40:12 -0700 (PDT)
From: Dave Marchevsky <davemarchevsky@fb.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann
	<daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
	<martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Dave Marchevsky
	<davemarchevsky@fb.com>
Subject: [PATCH v1 bpf-next 3/6] bpf: Use bpf_mem_free_rcu when bpf_obj_dropping non-refcounted nodes
Date: Wed, 25 Oct 2023 14:40:04 -0700
Message-ID: <20231025214007.2920506-4-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231025214007.2920506-1-davemarchevsky@fb.com>
References: <20231025214007.2920506-1-davemarchevsky@fb.com>
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: t4fZfKCY9fzm5ACbB9vqov80rTG-K47R
X-Proofpoint-GUID: t4fZfKCY9fzm5ACbB9vqov80rTG-K47R
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_11,2023-10-25_01,2023-05-22_02

The use of bpf_mem_free_rcu to free refcounted local kptrs was added
in commit 7e26cd12ad1c ("bpf: Use bpf_mem_free_rcu when
bpf_obj_dropping refcounted nodes"). In the cover letter for the
series containing that patch [0] I commented:

    Perhaps it makes sense to move to mem_free_rcu for _all_
    non-owning refs in the future, not just refcounted. This might
    allow custom non-owning ref lifetime + invalidation logic to be
    entirely subsumed by MEM_RCU handling. IMO this needs a bit more
    thought and should be tackled outside of a fix series, so it's not
    attempted here.

It's time to start moving in the "non-owning refs have MEM_RCU
lifetime" direction. As mentioned in that comment, using
bpf_mem_free_rcu for all local kptrs - not just refcounted - is
necessarily the first step towards that goal. This patch does so.

After this patch the memory pointed to by all local kptrs will not be
reused until RCU grace period elapses. The verifier's understanding of
non-owning ref validity and the clobbering logic it uses to enforce
that understanding are not changed here, that'll happen gradually in
future work, including further patches in the series.

  [0]: https://lore.kernel.org/all/20230821193311.3290257-1-davemarchevsky@=
fb.com/

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 kernel/bpf/helpers.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 6e1874cc9c13..9895c30f6810 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1932,10 +1932,7 @@ void __bpf_obj_drop_impl(void *p, const struct btf_r=
ecord *rec, bool percpu)
 		ma =3D &bpf_global_percpu_ma;
 	else
 		ma =3D &bpf_global_ma;
-	if (rec && rec->refcount_off >=3D 0)
-		bpf_mem_free_rcu(ma, p);
-	else
-		bpf_mem_free(ma, p);
+	bpf_mem_free_rcu(ma, p);
 }
=20
 __bpf_kfunc void bpf_obj_drop_impl(void *p__alloc, void *meta__ign)
--=20
2.34.1


