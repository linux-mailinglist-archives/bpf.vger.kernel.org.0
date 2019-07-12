Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECE3D67424
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2019 19:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbfGLR0Q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Jul 2019 13:26:16 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:3800 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726930AbfGLR0P (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 12 Jul 2019 13:26:15 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6CHPcEt007875
        for <bpf@vger.kernel.org>; Fri, 12 Jul 2019 10:26:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=E0uT8TSaJHRajSk0BCGOnD7sPHtXFl/PqnT9GNqS9aI=;
 b=OATqlULVyC2jJwAaL7QUnkQ46YSkWmesBOimgzMH58aLmLlTNA1gyHXaDxVKGIqH4yJo
 5yRm2M38rJb5aDFUufiTlasD4K+sivCj2AryXQv0TLFxS6ESmG6ui/N9w+7yiUrVrWV/
 oHEbJ3mUiJyEi1+/JWAOJonGDRFnUDF4PmI= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2tpj7qtem0-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 12 Jul 2019 10:26:14 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Fri, 12 Jul 2019 10:26:12 -0700
Received: by dev101.prn2.facebook.com (Postfix, from userid 137359)
        id 4AE728614A9; Fri, 12 Jul 2019 10:26:11 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: dev101.prn2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>, <yhs@fb.com>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Martin KaFai Lau <kafai@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v3 bpf 1/3] bpf: fix BTF verifier size resolution logic
Date:   Fri, 12 Jul 2019 10:25:55 -0700
Message-ID: <20190712172557.4039121-2-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190712172557.4039121-1-andriin@fb.com>
References: <20190712172557.4039121-1-andriin@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-12_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=8 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907120177
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

BTF verifier has a size resolution bug which in some circumstances leads to
invalid size resolution for, e.g., TYPEDEF modifier.  This happens if we have
[1] PTR -> [2] TYPEDEF -> [3] ARRAY, in which case due to being in pointer
context ARRAY size won't be resolved (because for pointer it doesn't matter, so
it's a sink in pointer context), but it will be permanently remembered as zero
for TYPEDEF and TYPEDEF will be marked as RESOLVED. Eventually ARRAY size will
be resolved correctly, but TYPEDEF resolved_size won't be updated anymore.
This, subsequently, will lead to erroneous map creation failure, if that
TYPEDEF is specified as either key or value, as key_size/value_size won't
correspond to resolved size of TYPEDEF (kernel will believe it's zero).

Note, that if BTF was ordered as [1] ARRAY <- [2] TYPEDEF <- [3] PTR, this
won't be a problem, as by the time we get to TYPEDEF, ARRAY's size is already
calculated and stored.

This bug manifests itself in rejecting BTF-defined maps that use array
typedef as a value type:

typedef int array_t[16];

struct {
    __uint(type, BPF_MAP_TYPE_ARRAY);
    __type(value, array_t); /* i.e., array_t *value; */
} test_map SEC(".maps");

The fix consists on not relying on modifier's resolved_size and instead using
modifier's resolved_id (type ID for "concrete" type to which modifier
eventually resolves) and doing size determination for that resolved type. This
allow to preserve existing "early DFS termination" logic for PTR or
STRUCT_OR_ARRAY contexts, but still do correct size determination for modifier
types.

Fixes: eb3f595dab40 ("bpf: btf: Validate type reference")
Cc: Martin KaFai Lau <kafai@fb.com>
Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 kernel/bpf/btf.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 546ebee39e2a..5fcc7a17eb5a 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -1073,11 +1073,18 @@ const struct btf_type *btf_type_id_size(const struct btf *btf,
 				 !btf_type_is_var(size_type)))
 			return NULL;
 
-		size = btf->resolved_sizes[size_type_id];
 		size_type_id = btf->resolved_ids[size_type_id];
 		size_type = btf_type_by_id(btf, size_type_id);
 		if (btf_type_nosize_or_null(size_type))
 			return NULL;
+		else if (btf_type_has_size(size_type))
+			size = size_type->size;
+		else if (btf_type_is_array(size_type))
+			size = btf->resolved_sizes[size_type_id];
+		else if (btf_type_is_ptr(size_type))
+			size = sizeof(void *);
+		else
+			return NULL;
 	}
 
 	*type_id = size_type_id;
@@ -1602,7 +1609,6 @@ static int btf_modifier_resolve(struct btf_verifier_env *env,
 	const struct btf_type *next_type;
 	u32 next_type_id = t->type;
 	struct btf *btf = env->btf;
-	u32 next_type_size = 0;
 
 	next_type = btf_type_by_id(btf, next_type_id);
 	if (!next_type || btf_type_is_resolve_source_only(next_type)) {
@@ -1620,7 +1626,7 @@ static int btf_modifier_resolve(struct btf_verifier_env *env,
 	 * save us a few type-following when we use it later (e.g. in
 	 * pretty print).
 	 */
-	if (!btf_type_id_size(btf, &next_type_id, &next_type_size)) {
+	if (!btf_type_id_size(btf, &next_type_id, NULL)) {
 		if (env_type_is_resolved(env, next_type_id))
 			next_type = btf_type_id_resolve(btf, &next_type_id);
 
@@ -1633,7 +1639,7 @@ static int btf_modifier_resolve(struct btf_verifier_env *env,
 		}
 	}
 
-	env_stack_pop_resolved(env, next_type_id, next_type_size);
+	env_stack_pop_resolved(env, next_type_id, 0);
 
 	return 0;
 }
@@ -1645,7 +1651,6 @@ static int btf_var_resolve(struct btf_verifier_env *env,
 	const struct btf_type *t = v->t;
 	u32 next_type_id = t->type;
 	struct btf *btf = env->btf;
-	u32 next_type_size;
 
 	next_type = btf_type_by_id(btf, next_type_id);
 	if (!next_type || btf_type_is_resolve_source_only(next_type)) {
@@ -1675,12 +1680,12 @@ static int btf_var_resolve(struct btf_verifier_env *env,
 	 * forward types or similar that would resolve to size of
 	 * zero is allowed.
 	 */
-	if (!btf_type_id_size(btf, &next_type_id, &next_type_size)) {
+	if (!btf_type_id_size(btf, &next_type_id, NULL)) {
 		btf_verifier_log_type(env, v->t, "Invalid type_id");
 		return -EINVAL;
 	}
 
-	env_stack_pop_resolved(env, next_type_id, next_type_size);
+	env_stack_pop_resolved(env, next_type_id, 0);
 
 	return 0;
 }
-- 
2.17.1

