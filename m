Return-Path: <bpf+bounces-30904-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A14C28D45B9
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 09:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0886FB242F2
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 07:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56BF13DAC0B;
	Thu, 30 May 2024 07:05:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74E33DABE9
	for <bpf@vger.kernel.org>; Thu, 30 May 2024 07:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717052721; cv=none; b=FoTR5dJtB5IabCeYfZPDhdBkpm3XVmGq064fZFNReT5d9zlazCSPQBsbybqTf2ur8BRSpYsGdZ8YHYokxO6fIcX26una3gtEnbOcgnf5nOnHWj7nRA7iqlNq8TlgcAj3xouBRmdEmXxrjP9S4gl2U/PE2QaXifOm1+CXmu5Wx5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717052721; c=relaxed/simple;
	bh=WVXsfo+0MMmwetykiU97iWudixnfvvqIPccbd87tvmI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X910Vpo6SD+ycWvwgORuChSiwGe9OyAbhUme1Jfk1dfYXTxoE3onMF3OyciUleiF9Zwsk/9k5DiXMHLrkv8SIy19E4GCPRr4vDLhhy2ScKiHjNTiiLiS7DK/NVjDTdkezQ6QrPflRM2m8WcnGHFjP9OtWc/T+xTwmkTrlZQHUOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=meta.com; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44U6hAv0030654
	for <bpf@vger.kernel.org>; Thu, 30 May 2024 00:05:19 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3yemec02cb-13
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 30 May 2024 00:05:18 -0700
Received: from twshared18280.38.frc1.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Thu, 30 May 2024 07:05:05 +0000
Received: by devbig1475.frc2.facebook.com (Postfix, from userid 460691)
	id DDB585DFFC0F; Thu, 30 May 2024 00:04:54 -0700 (PDT)
From: <thinker.li@gmail.com>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <martin.lau@linux.dev>,
        <kernel-team@meta.com>, <andrii@kernel.org>, <sinquersw@gmail.com>,
        <kuifeng@meta.com>, <thinker.li@gmail.com>
CC: Quentin Monnet <qmo@kernel.org>
Subject: [PATCH bpf-next v7 8/8] bpftool: Change pid_iter.bpf.c to comply with the change of bpf_link_fops.
Date: Wed, 29 May 2024 23:59:46 -0700
Message-ID: <20240530065946.979330-9-thinker.li@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240530065946.979330-1-thinker.li@gmail.com>
References: <20240530065946.979330-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: g7KyfYNWvwD-sQGvov0tSzE2wDHFt9d_
X-Proofpoint-ORIG-GUID: g7KyfYNWvwD-sQGvov0tSzE2wDHFt9d_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-30_04,2024-05-28_01,2024-05-17_01

From: Kui-Feng Lee <thinker.li@gmail.com>

To support epoll, a new instance of file_operations, bpf_link_fops_poll,
has been added for links that support epoll. The pid_iter.bpf.c checks
f_ops for links and other BPF objects. The check should fail for struct_o=
ps
links without this patch.

Acked-by: Quentin Monnet <qmo@kernel.org>
Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 tools/bpf/bpftool/skeleton/pid_iter.bpf.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/skeleton/pid_iter.bpf.c b/tools/bpf/bpftoo=
l/skeleton/pid_iter.bpf.c
index 7bdbcac3cf62..948dde25034e 100644
--- a/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
+++ b/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
@@ -29,6 +29,7 @@ enum bpf_link_type___local {
 };
=20
 extern const void bpf_link_fops __ksym;
+extern const void bpf_link_fops_poll __ksym __weak;
 extern const void bpf_map_fops __ksym;
 extern const void bpf_prog_fops __ksym;
 extern const void btf_fops __ksym;
@@ -84,7 +85,11 @@ int iter(struct bpf_iter__task_file *ctx)
 		fops =3D &btf_fops;
 		break;
 	case BPF_OBJ_LINK:
-		fops =3D &bpf_link_fops;
+		if (&bpf_link_fops_poll &&
+		    file->f_op =3D=3D &bpf_link_fops_poll)
+			fops =3D &bpf_link_fops_poll;
+		else
+			fops =3D &bpf_link_fops;
 		break;
 	default:
 		return 0;
--=20
2.43.0


