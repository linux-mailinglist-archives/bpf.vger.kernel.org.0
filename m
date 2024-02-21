Return-Path: <bpf+bounces-22363-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5245885CD7F
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 02:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C59F11F247C3
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 01:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A4120E6;
	Wed, 21 Feb 2024 01:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="ya7xmQFp"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC17E5684
	for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 01:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708479100; cv=none; b=KV2TfAXrJ/f5zwb3FCrn+K+Bb+HcWyVzSHojnWVTFw2ZE0Aj0iMt5/lkiKWHscwgHHMEhCixFlUfvytWHVD6Ij+icVV971zKmKknEO+Eg55JWfD4OUeX0Sih6y//wjBgVkMrnx/auTiUtlZZ+75ZWh8lcCoBunqWqV02wE/p1Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708479100; c=relaxed/simple;
	bh=fhbfkIN5wAhNc9HTeKolpxP5Ornlg+oQJDYS6W/CqDo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=O4mixFYF/P+WhmL68Np2tPjNwdMO+eexozo43+agO5HN37wbWsgH+f0Hph8SnpHkpQ97wJh8YVz7UTUJ3OTDwkbj/G2zApgoqS7A8bPGalR5zTWxrWz5L/Hox6IStZbQMbRL7YjWVS2Z1DTxh5iB/pINh7VI0Gf0wVGuBd8bV08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=ya7xmQFp; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Received: from pps.filterd (m0354655.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41KK7HY2027620;
	Wed, 21 Feb 2024 01:01:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=default; bh=HBBOaU1zE
	82xQnhq8k1L4btrIhfz2uvaYV8xuG2OX6Y=; b=ya7xmQFpc33v7mgYRHtity2XX
	v54mN5r7QWxukCinYYk7O+/m8R0nwM1G5lBHvJ/pk8eRvnUAt+Fsb6kX36ly/9Ur
	nGqZFM0Z9c+l2E5oWZrOrBQ+kIh4jDayVsm93wowXDc/LA9CAzebcTN9esBjqQtg
	qh6CgYB0oyYHwgQ4vyh7PwLJLMeYeX1SAoOPjhjv6VJtvJoKFC+loxn5NXDNQCWn
	rNtTHuMxqGEG47Lf7nT1/FCs6iDz/wXszJIZpv+cmDzbFRZX3f+cCAL2WZv2yfv1
	zytaviEgELOO/M9936rtaUOAQ8025f3ttvn2MP0yNeotCXPwvgY+IJUoFrMtA==
Received: from 04wpexch06.crowdstrike.sys (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 3wd21t8kpy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 01:01:46 +0000 (GMT)
Received: from LL-556NGK3.crowdstrike.sys (10.100.11.122) by
 04wpexch06.crowdstrike.sys (10.100.11.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 21 Feb 2024 01:01:44 +0000
From: Martin Kelly <martin.kelly@crowdstrike.com>
To: <bpf@vger.kernel.org>
CC: Yonghong Song <yonghong.song@linux.dev>,
        Alexei Starovoitov
	<ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko
	<andrii@kernel.org>,
        Martin Kelly <martin.kelly@crowdstrike.com>
Subject: [PATCH bpf] libbpf: clarify batch lookup semantics
Date: Tue, 20 Feb 2024 17:00:57 -0800
Message-ID: <20240221010057.1061333-1-martin.kelly@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: 04WPEXCH12.crowdstrike.sys (10.100.11.116) To
 04wpexch06.crowdstrike.sys (10.100.11.99)
X-Disclaimer: USA
X-Proofpoint-ORIG-GUID: qMWw5PaowjtWkghwoKEDNzalhFZtd4J9
X-Proofpoint-GUID: qMWw5PaowjtWkghwoKEDNzalhFZtd4J9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=756 phishscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 malwarescore=0 mlxscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402210006

The batch lookup APIs copy key memory into out_batch, which is then
supplied in later calls to in_batch. Thus both parameters need to point
to memory large enough to hold a single key (other than an initial NULL
in_batch). For many maps, keys are pointer sized or less, but for larger
maps, it's important to point to a larger block of memory to avoid
memory corruption.

Document these semantics to clarify the API.

Signed-off-by: Martin Kelly <martin.kelly@crowdstrike.com>
---
 include/uapi/linux/bpf.h |  5 ++++-
 tools/lib/bpf/bpf.h      | 15 ++++++++++-----
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index d96708380e52..dae613b8778a 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -617,7 +617,10 @@ union bpf_iter_link_info {
  *		to NULL to begin the batched operation. After each subsequent
  *		**BPF_MAP_LOOKUP_BATCH**, the caller should pass the resultant
  *		*out_batch* as the *in_batch* for the next operation to
- *		continue iteration from the current point.
+ *		continue iteration from the current point. Both *in_batch* and
+ *		*out_batch* must point to memory large enough to hold a key,
+ *		except for maps of type **BPF_MAP_TYPE_HASH**, for which batch
+ *		parameters must be at least 4 bytes wide regardless of key size.
  *
  *		The *keys* and *values* are output parameters which must point
  *		to memory large enough to hold *count* items based on the key
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index ab2570d28aec..c7e918ab0a60 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -190,10 +190,13 @@ LIBBPF_API int bpf_map_delete_batch(int fd, const void *keys,
 /**
  * @brief **bpf_map_lookup_batch()** allows for batch lookup of BPF map elements.
  *
- * The parameter *in_batch* is the address of the first element in the batch to read.
- * *out_batch* is an output parameter that should be passed as *in_batch* to subsequent
- * calls to **bpf_map_lookup_batch()**. NULL can be passed for *in_batch* to indicate
- * that the batched lookup starts from the beginning of the map.
+ * The parameter *in_batch* is the address of the first element in the batch to
+ * read. *out_batch* is an output parameter that should be passed as *in_batch*
+ * to subsequent calls to **bpf_map_lookup_batch()**. NULL can be passed for
+ * *in_batch* to indicate that the batched lookup starts from the beginning of
+ * the map. Both *in_batch* and *out_batch* must point to memory large enough to
+ * hold a single key, except for maps of type **BPF_MAP_TYPE_HASH**, for which
+ * the memory pointed to must be at least 4 bytes wide regardless of key size.
  *
  * The *keys* and *values* are output parameters which must point to memory large enough to
  * hold *count* items based on the key and value size of the map *map_fd*. The *keys*
@@ -226,7 +229,9 @@ LIBBPF_API int bpf_map_lookup_batch(int fd, void *in_batch, void *out_batch,
  *
  * @param fd BPF map file descriptor
  * @param in_batch address of the first element in batch to read, can pass NULL to
- * get address of the first element in *out_batch*
+ * get address of the first element in *out_batch*. If not NULL, must be large
+ * enough to hold a key. For **BPF_MAP_TYPE_HASH**, must be large enough to hold
+ * 4 bytes.
  * @param out_batch output parameter that should be passed to next call as *in_batch*
  * @param keys pointer to an array of *count* keys
  * @param values pointer to an array large enough for *count* values
-- 
2.34.1


