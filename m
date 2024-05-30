Return-Path: <bpf+bounces-30903-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E312F8D45B8
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 09:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1963BB24376
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 07:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8B43DABF0;
	Thu, 30 May 2024 07:05:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D697A3DABE7
	for <bpf@vger.kernel.org>; Thu, 30 May 2024 07:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717052720; cv=none; b=o5EF9VWEBhHWr0x988L771dG0+mqiwUvgF5LWNnqNQi+yyep1Dr9K2aqKoi4Eo3WQHOCBD3WRT+Hsol/2b3hfkp5TJydQ5Mbr0hLVTZ7bGiPXiTaqKBqGGF0wRl5JVFqG37N/wlJIdEbqQlydU4e29mwntfKjvf8SN7pA0RDi0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717052720; c=relaxed/simple;
	bh=TVF+NrZQxUp+Pq3vzuTOpANXKoBaHBE3hJ6lPibgd8s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rglk1nGGGzAWkBASOSFiwD99hKf7vrlYfzNneGyr9XgjPqrujMN+aMkNKZMa67D+/3oTuhMHGiwSMgZK606uAmi5s0DZsb4A5hNVYWJTsgVh81UkN+LnS6zvJmc0h33Iwj/A0ePL7XUG/HSxmNMmVCPtiGaSDNdB4KJ2T1cYTpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=meta.com; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44U6h5Mh030596
	for <bpf@vger.kernel.org>; Thu, 30 May 2024 00:05:18 -0700
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3yemec02c2-16
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 30 May 2024 00:05:18 -0700
Received: from twshared33736.33.frc3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Thu, 30 May 2024 07:05:07 +0000
Received: by devbig1475.frc2.facebook.com (Postfix, from userid 460691)
	id B4CFC5DFFBFB; Thu, 30 May 2024 00:04:52 -0700 (PDT)
From: <thinker.li@gmail.com>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <martin.lau@linux.dev>,
        <kernel-team@meta.com>, <andrii@kernel.org>, <sinquersw@gmail.com>,
        <kuifeng@meta.com>, <thinker.li@gmail.com>
Subject: [PATCH bpf-next v7 4/8] bpf: export bpf_link_inc_not_zero.
Date: Wed, 29 May 2024 23:59:42 -0700
Message-ID: <20240530065946.979330-5-thinker.li@gmail.com>
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
X-Proofpoint-GUID: 0FF6mbDHAWgnGgJfUWLM_jliS-RppN4n
X-Proofpoint-ORIG-GUID: 0FF6mbDHAWgnGgJfUWLM_jliS-RppN4n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-30_04,2024-05-28_01,2024-05-17_01

From: Kui-Feng Lee <thinker.li@gmail.com>

bpf_link_inc_not_zero() will be used by kernel modules.  We will use it i=
n
bpf_testmod.c later.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 include/linux/bpf.h  | 6 ++++++
 kernel/bpf/syscall.c | 3 ++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 5eb61120e4f5..a834f4b761bc 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2334,6 +2334,7 @@ int bpf_link_prime(struct bpf_link *link, struct bp=
f_link_primer *primer);
 int bpf_link_settle(struct bpf_link_primer *primer);
 void bpf_link_cleanup(struct bpf_link_primer *primer);
 void bpf_link_inc(struct bpf_link *link);
+struct bpf_link *bpf_link_inc_not_zero(struct bpf_link *link);
 void bpf_link_put(struct bpf_link *link);
 int bpf_link_new_fd(struct bpf_link *link);
 struct bpf_link *bpf_link_get_from_fd(u32 ufd);
@@ -2705,6 +2706,11 @@ static inline void bpf_link_inc(struct bpf_link *l=
ink)
 {
 }
=20
+static inline struct bpf_link *bpf_link_inc_not_zero(struct bpf_link *li=
nk)
+{
+	return NULL;
+}
+
 static inline void bpf_link_put(struct bpf_link *link)
 {
 }
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 81efa1944942..5070fa20d05c 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5437,10 +5437,11 @@ static int link_detach(union bpf_attr *attr)
 	return ret;
 }
=20
-static struct bpf_link *bpf_link_inc_not_zero(struct bpf_link *link)
+struct bpf_link *bpf_link_inc_not_zero(struct bpf_link *link)
 {
 	return atomic64_fetch_add_unless(&link->refcnt, 1, 0) ? link : ERR_PTR(=
-ENOENT);
 }
+EXPORT_SYMBOL(bpf_link_inc_not_zero);
=20
 struct bpf_link *bpf_link_by_id(u32 id)
 {
--=20
2.43.0


