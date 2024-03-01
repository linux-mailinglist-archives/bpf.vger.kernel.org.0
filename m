Return-Path: <bpf+bounces-23138-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7B886E134
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 13:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A866283AFC
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 12:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2993CF63;
	Fri,  1 Mar 2024 12:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ki/APkJq"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E5033CD0;
	Fri,  1 Mar 2024 12:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709296879; cv=none; b=uvrEsb6x6uJzdHl5Roxi9NGmv0C43rruUz7uXSe7k8VJ0Wlnt5JR/IrDeeIbPAMtcGZYTzE0Pjy744PPrtysWkMHeKKYKo2NaE75L/mb/MPG697iQ2xPmS823hNZ0OGpz9uH7ZttRMK0XALu5AC+FkF4BAN1GBupuBDMPbVeX6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709296879; c=relaxed/simple;
	bh=69onZc66xrLRSD3WoR+/WOMKzOxHL7TXZv4ExZMuNk8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JVzz0X0ujevWQ0EQNLAIHYGAL4fcT0NZVkdmTO/nKm190oVrXLeuAs1S8pfai6+sluaGLOzgGZb/qFOpCzsZhNlTqDM+IiGCxoFNvCIwExJtcj7gK/Fzbi37Lf0vK/jxUXr0t2Xl9UIqYajSBflzWm/SOciluZVV88ui6kWYaZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ki/APkJq; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42194huA008252;
	Fri, 1 Mar 2024 12:41:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=lq7kmBtUzU0NA4rp5KvxjlrcWodwjmXVQdynPSQTg7Y=;
 b=ki/APkJqtOfhI5rIwWMEjNGOZyrfHCl+3Qh3Tb9kvOg7xO6TmraaeAF6NyhJ/uly4g+f
 UuZAYio0DojjTGhSbqA9RcnES9IUUJKUmElXM/7PlS+94TaW+CRvaIgbY1Uq3TW+rKCG
 iEpcolZPM+pA4V7TZXnHM5H9E4d84kara7/u23E1nbN5r6gX4fvtlExIbroGLD9vZ2Km
 SQJw8MMX55hJXVKwLoHWIQSpyYPG2jP0MUwOa7s61Qr2q1oYz2D8LuXKdHGjUCAAahsE
 VcwD8j6fEecRctFlWADR5aHw7XXeCpoXvhkd2RuDenIfYx1w7N+36Z9sYiYhR0wOwjOg eA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf90vgs3y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Mar 2024 12:41:11 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 421BQSKQ009594;
	Fri, 1 Mar 2024 12:41:09 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wjrqmrn96-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Mar 2024 12:41:09 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 421Cef8P021741;
	Fri, 1 Mar 2024 12:41:09 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-184-138.vpn.oracle.com [10.175.184.138])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3wjrqmrn83-1;
	Fri, 01 Mar 2024 12:41:09 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@redhat.com
Cc: dwarves@vger.kernel.org, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>,
        John Hubbard <jhubbard@nvidia.com>, Jiri Olsa <olsajiri@gmail.com>
Subject: [PATCH dwarves] btf_encoder: dynamically allocate the vars array for percpu variables
Date: Fri,  1 Mar 2024 12:41:06 +0000
Message-Id: <20240301124106.735693-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-01_12,2024-03-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 spamscore=0 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403010106
X-Proofpoint-GUID: s2bF-R6fGuRUSs4chM6FQNzDiWQYqW8V
X-Proofpoint-ORIG-GUID: s2bF-R6fGuRUSs4chM6FQNzDiWQYqW8V

Use consistent method across allocating function and per-cpu variable
representations, based around (re)allocating the arrays based on demand.
This avoids issues where the number of per-CPU variables exceeds the
hardcoded limit.

Reported-by: John Hubbard <jhubbard@nvidia.com>
Suggested-by: Jiri Olsa <olsajiri@gmail.com>
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Tested-by: John Hubbard <jhubbard@nvidia.com>
---
 btf_encoder.c | 38 +++++++++++++++++++++++++++++---------
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index fd04008..a43d702 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -50,8 +50,6 @@ struct elf_function {
 	struct btf_encoder_state state;
 };
 
-#define MAX_PERCPU_VAR_CNT 4096
-
 struct var_info {
 	uint64_t    addr;
 	const char *name;
@@ -80,8 +78,9 @@ struct btf_encoder {
 			  is_rel;
 	uint32_t	  array_index_id;
 	struct {
-		struct var_info vars[MAX_PERCPU_VAR_CNT];
+		struct var_info *vars;
 		int		var_cnt;
+		int		allocated;
 		uint32_t	shndx;
 		uint64_t	base_addr;
 		uint64_t	sec_sz;
@@ -983,6 +982,16 @@ static int functions_cmp(const void *_a, const void *_b)
 #define max(x, y) ((x) < (y) ? (y) : (x))
 #endif
 
+static void *reallocarray_grow(void *ptr, int *nmemb, size_t size)
+{
+	int new_nmemb = max(1000, *nmemb * 3 / 2);
+	void *new = realloc(ptr, new_nmemb * size);
+
+	if (new)
+		*nmemb = new_nmemb;
+	return new;
+}
+
 static int btf_encoder__collect_function(struct btf_encoder *encoder, GElf_Sym *sym)
 {
 	struct elf_function *new;
@@ -995,8 +1004,9 @@ static int btf_encoder__collect_function(struct btf_encoder *encoder, GElf_Sym *
 		return 0;
 
 	if (encoder->functions.cnt == encoder->functions.allocated) {
-		encoder->functions.allocated = max(1000, encoder->functions.allocated * 3 / 2);
-		new = realloc(encoder->functions.entries, encoder->functions.allocated * sizeof(*encoder->functions.entries));
+		new = reallocarray_grow(encoder->functions.entries,
+					&encoder->functions.allocated,
+					sizeof(*encoder->functions.entries));
 		if (!new) {
 			/*
 			 * The cleanup - delete_functions is called
@@ -1439,10 +1449,17 @@ static int btf_encoder__collect_percpu_var(struct btf_encoder *encoder, GElf_Sym
 	if (!encoder->is_rel)
 		addr -= encoder->percpu.base_addr;
 
-	if (encoder->percpu.var_cnt == MAX_PERCPU_VAR_CNT) {
-		fprintf(stderr, "Reached the limit of per-CPU variables: %d\n",
-			MAX_PERCPU_VAR_CNT);
-		return -1;
+	if (encoder->percpu.var_cnt == encoder->percpu.allocated) {
+		struct var_info *new;
+
+		new = reallocarray_grow(encoder->percpu.vars,
+					&encoder->percpu.allocated,
+					sizeof(*encoder->percpu.vars));
+		if (!new) {
+			fprintf(stderr, "Failed to allocate memory for variables\n");
+			return -1;
+		}
+		encoder->percpu.vars = new;
 	}
 	encoder->percpu.vars[encoder->percpu.var_cnt].addr = addr;
 	encoder->percpu.vars[encoder->percpu.var_cnt].sz = size;
@@ -1720,6 +1737,9 @@ void btf_encoder__delete(struct btf_encoder *encoder)
 	encoder->functions.allocated = encoder->functions.cnt = 0;
 	free(encoder->functions.entries);
 	encoder->functions.entries = NULL;
+	encoder->percpu.allocated = encoder->percpu.var_cnt = 0;
+	free(encoder->percpu.vars);
+	encoder->percpu.vars = NULL;
 
 	free(encoder);
 }
-- 
2.39.3


