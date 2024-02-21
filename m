Return-Path: <bpf+bounces-22462-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DF785E9EA
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 22:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D6E11F25136
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 21:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81496126F35;
	Wed, 21 Feb 2024 21:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="CYqkcZdU"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F7D2C18E
	for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 21:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708550370; cv=none; b=K6eG7dOmz6UszEz5Cco49pWgW8KtnG3xfJakf5v2/uUnfZo0CifMCkjnJloEdFSSiVpLHhiDsof4B788+oGflFw9ZPzGMZ7difYwgUS2QpIeN2GQglMQkahBGOw4cNu/o4hoqGNL3G9G8N+GcOZIY1DAsY0xmUOkfT4v1aO1Rrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708550370; c=relaxed/simple;
	bh=8C3BNSrY9tGf2us4pruiQp5mvDi/fCDH+6YTsiB260E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pENpSqKusx0jdmfqQuAUazH4L9XGv8dEihVvvH3QpjFQeGITMKvZ5fCJGlGKZZGP8DO5Kq/2ty1VEGr9+agH8EuFl9UU5NP5lVovigQe5xDwqtTWubno1bqeNndKGijwhVyAdfpBg2IbcB2D1T28h/sxFkv1CCb0fuStIjoFjOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=CYqkcZdU; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Received: from pps.filterd (m0354653.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41LJjpHW030081;
	Wed, 21 Feb 2024 21:19:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=default; bh=dkGexCVdQ
	qKlUe2yVYGaR24Indx7uyoOP+U6A/YAyiQ=; b=CYqkcZdUoo5dXV/arg2MZpErQ
	BGJJHxZwAhClXLDOmWGOgS1Xvg3OP9idPxv2+D6Im2yp4K0jC20Co4ljzUUqRvo0
	AwN0eqvJF6n1ShOueEgI0icJEOljwYa3uLSLO13k+ZoIHIEryU7rjNokkrjvOL1E
	STe/0oD+pWwFS1wdBQHiLWy1IJOvF/ls8qK4uL2jCGrIFoNCaXXbgxyVZQNWjHGB
	KuVUqEkANg6RFsOhbyhjySrJZEk/zXWx8T2HVHuDXkeLNaEZEjwc8Eow0DrwhesN
	rfpO4LUMk//XlsalzKnENyNWhV/pQfmsbJRRJRMYYKq4R8B36sBWWbdTK28oA==
Received: from 04wpexch06.crowdstrike.sys (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 3wdgqjh8kw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 21:19:06 +0000 (GMT)
Received: from LL-556NGK3.crowdstrike.sys (10.100.11.122) by
 04wpexch06.crowdstrike.sys (10.100.11.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 21 Feb 2024 21:19:04 +0000
From: Martin Kelly <martin.kelly@crowdstrike.com>
To: <bpf@vger.kernel.org>
CC: Yonghong Song <yonghong.song@linux.dev>,
        Alexei Starovoitov
	<ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko
	<andrii@kernel.org>,
        Martin Kelly <martin.kelly@crowdstrike.com>
Subject: [PATCH bpf-next v2] bpf: clarify batch lookup semantics
Date: Wed, 21 Feb 2024 13:18:38 -0800
Message-ID: <20240221211838.1241578-1-martin.kelly@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: 04wpexch04.crowdstrike.sys (10.100.11.94) To
 04wpexch06.crowdstrike.sys (10.100.11.99)
X-Disclaimer: USA
X-Proofpoint-GUID: EHUqAJ1bMxYIKT-eKbpoktqo1cWd0bQj
X-Proofpoint-ORIG-GUID: EHUqAJ1bMxYIKT-eKbpoktqo1cWd0bQj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-21_08,2024-02-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 phishscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 mlxscore=0 mlxlogscore=770 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2402210166

The batch lookup and lookup_and_delete APIs have two parameters,
in_batch and out_batch, to facilitate iterative
lookup/lookup_and_deletion operations for supported maps. Except NULL
for in_batch at the start of these two batch operations, both parameters
need to point to memory equal or larger than the respective map key
size, except for various hashmaps (hash, percpu_hash, lru_hash,
lru_percpu_hash) where the in_batch/out_batch memory size should be
at least 4 bytes.

Document these semantics to clarify the API.

Signed-off-by: Martin Kelly <martin.kelly@crowdstrike.com>
---
 include/uapi/linux/bpf.h       |  6 +++++-
 tools/include/uapi/linux/bpf.h |  6 +++++-
 tools/lib/bpf/bpf.h            | 17 ++++++++++++-----
 3 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index d96708380e52..d2e6c5fcec01 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -617,7 +617,11 @@ union bpf_iter_link_info {
  *		to NULL to begin the batched operation. After each subsequent
  *		**BPF_MAP_LOOKUP_BATCH**, the caller should pass the resultant
  *		*out_batch* as the *in_batch* for the next operation to
- *		continue iteration from the current point.
+ *		continue iteration from the current point. Both *in_batch* and
+ *		*out_batch* must point to memory large enough to hold a key,
+ *		except for maps of type **BPF_MAP_TYPE_{HASH, PERCPU_HASH,
+ *		LRU_HASH, LRU_PERCPU_HASH}**, for which batch parameters
+ *		must be at least 4 bytes wide regardless of key size.
  *
  *		The *keys* and *values* are output parameters which must point
  *		to memory large enough to hold *count* items based on the key
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index d96708380e52..d2e6c5fcec01 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -617,7 +617,11 @@ union bpf_iter_link_info {
  *		to NULL to begin the batched operation. After each subsequent
  *		**BPF_MAP_LOOKUP_BATCH**, the caller should pass the resultant
  *		*out_batch* as the *in_batch* for the next operation to
- *		continue iteration from the current point.
+ *		continue iteration from the current point. Both *in_batch* and
+ *		*out_batch* must point to memory large enough to hold a key,
+ *		except for maps of type **BPF_MAP_TYPE_{HASH, PERCPU_HASH,
+ *		LRU_HASH, LRU_PERCPU_HASH}**, for which batch parameters
+ *		must be at least 4 bytes wide regardless of key size.
  *
  *		The *keys* and *values* are output parameters which must point
  *		to memory large enough to hold *count* items based on the key
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index ab2570d28aec..df0db2f0cdb7 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -190,10 +190,14 @@ LIBBPF_API int bpf_map_delete_batch(int fd, const void *keys,
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
+ * hold a single key, except for maps of type **BPF_MAP_TYPE_{HASH, PERCPU_HASH,
+ * LRU_HASH, LRU_PERCPU_HASH}**, for which the memory size must be at
+ * least 4 bytes wide regardless of key size.
  *
  * The *keys* and *values* are output parameters which must point to memory large enough to
  * hold *count* items based on the key and value size of the map *map_fd*. The *keys*
@@ -226,7 +230,10 @@ LIBBPF_API int bpf_map_lookup_batch(int fd, void *in_batch, void *out_batch,
  *
  * @param fd BPF map file descriptor
  * @param in_batch address of the first element in batch to read, can pass NULL to
- * get address of the first element in *out_batch*
+ * get address of the first element in *out_batch*. If not NULL, must be large
+ * enough to hold a key. For **BPF_MAP_TYPE_{HASH, PERCPU_HASH, LRU_HASH,
+ * LRU_PERCPU_HASH}**, the memory size must be at least 4 bytes wide regardless
+ * of key size.
  * @param out_batch output parameter that should be passed to next call as *in_batch*
  * @param keys pointer to an array of *count* keys
  * @param values pointer to an array large enough for *count* values
-- 
2.34.1


