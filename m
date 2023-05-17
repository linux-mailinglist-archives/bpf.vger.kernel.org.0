Return-Path: <bpf+bounces-795-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3443706DFF
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 18:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A3F628176F
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 16:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6E91EA8E;
	Wed, 17 May 2023 16:20:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C418A111A1
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 16:20:33 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274F5DDAE
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 09:20:11 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34HE4G4N002745;
	Wed, 17 May 2023 16:19:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=65/ojX8W20BsEMJPLMxOCt3jn0zOEtP1h6ILbVKL14Y=;
 b=PUssdrRTQ9Ovc7hnSkgGMMdPX5N4tQDJbMM+f+x3+PrLogmBWjhjjJXnMPHp7u0+xlUd
 MoapLyjh1r1wkYN8gez0ZrBLgtzrlsQffQ1H+bPcESZ9EcJJ1a/e9/oWUMFDSXHBVaeX
 j3CB5icTZT8f/mJNEutyc4Qc9uCnTm7vrk9aloP0wyEREgs5TifAOOmKsEOZihOjtgmw
 ceGZj/NWiXSPk2VpFsmy8qTKzccnuYZydwkdPWcrm7tLlFJ+sVUZc4wpqdxkycy4t6Jo
 9g4COZSQq2zyFSD842o5fbZQ9iYhILJo97CF/5g5PEiuMpqvnp6pPWIw6D/efczrJQVS yw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj0ye5xum-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 May 2023 16:19:13 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34HFKNsM004223;
	Wed, 17 May 2023 16:19:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qj10bx0yx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 May 2023 16:19:12 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34HGHdXH034295;
	Wed, 17 May 2023 16:19:11 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-213-201.vpn.oracle.com [10.175.213.201])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3qj10bwyb5-6;
	Wed, 17 May 2023 16:19:11 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org, ast@kernel.org, jolsa@kernel.org, yhs@fb.com,
        andrii@kernel.org
Cc: daniel@iogearbox.net, laoar.shao@gmail.com, martin.lau@linux.dev,
        song@kernel.org, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC dwarves 5/6] btf_encoder: store ELF function representations sorted by name _and_ address
Date: Wed, 17 May 2023 17:16:47 +0100
Message-Id: <20230517161648.17582-6-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230517161648.17582-1-alan.maguire@oracle.com>
References: <20230517161648.17582-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-17_02,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305170133
X-Proofpoint-ORIG-GUID: 10Zt7O1QTFJP2y_cDPSHHWt1QY78yZA7
X-Proofpoint-GUID: 10Zt7O1QTFJP2y_cDPSHHWt1QY78yZA7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

By making sorting function for our ELF function list match on
both name and function, we ensure that the set of ELF functions
includes multiple copies for functions which have multiple instances
across CUs.  For example, cpumask_weight has 22 instances in
System.map/kallsyms:

ffffffff8103b530 t cpumask_weight
ffffffff8103e300 t cpumask_weight
ffffffff81040d30 t cpumask_weight
ffffffff8104fa00 t cpumask_weight
ffffffff81064300 t cpumask_weight
ffffffff81082ba0 t cpumask_weight
ffffffff81084f50 t cpumask_weight
ffffffff810a4ad0 t cpumask_weight
ffffffff810bb740 t cpumask_weight
ffffffff8110a6c0 t cpumask_weight
ffffffff81118ab0 t cpumask_weight
ffffffff81129b50 t cpumask_weight
ffffffff81137dc0 t cpumask_weight
ffffffff811aead0 t cpumask_weight
ffffffff811d6800 t cpumask_weight
ffffffff811e1370 t cpumask_weight
ffffffff812fae80 t cpumask_weight
ffffffff81375c50 t cpumask_weight
ffffffff81634b60 t cpumask_weight
ffffffff817ba540 t cpumask_weight
ffffffff819abf30 t cpumask_weight
ffffffff81a7cb60 t cpumask_weight

With ELF representations for each address, and DWARF info about
addresses (low_pc) we can match DWARF with ELF accurately.
The result for the BTF representation is that we end up with
a single de-duped function:

[9287] FUNC 'cpumask_weight' type_id=9286 linkage=static

...and 22 DECL_TAGs for each address that point at it:

9288] DECL_TAG 'address=0xffffffff8103b530' type_id=9287 component_idx=-1
[9623] DECL_TAG 'address=0xffffffff8103e300' type_id=9287 component_idx=-1
[9829] DECL_TAG 'address=0xffffffff81040d30' type_id=9287 component_idx=-1
[11609] DECL_TAG 'address=0xffffffff8104fa00' type_id=9287 component_idx=-1
[13299] DECL_TAG 'address=0xffffffff81064300' type_id=9287 component_idx=-1
[15704] DECL_TAG 'address=0xffffffff81082ba0' type_id=9287 component_idx=-1
[15731] DECL_TAG 'address=0xffffffff81084f50' type_id=9287 component_idx=-1
[18582] DECL_TAG 'address=0xffffffff810a4ad0' type_id=9287 component_idx=-1
[20234] DECL_TAG 'address=0xffffffff810bb740' type_id=9287 component_idx=-1
[25384] DECL_TAG 'address=0xffffffff8110a6c0' type_id=9287 component_idx=-1
[25798] DECL_TAG 'address=0xffffffff81118ab0' type_id=9287 component_idx=-1
[26285] DECL_TAG 'address=0xffffffff81129b50' type_id=9287 component_idx=-1
[27040] DECL_TAG 'address=0xffffffff81137dc0' type_id=9287 component_idx=-1
[32900] DECL_TAG 'address=0xffffffff811aead0' type_id=9287 component_idx=-1
[35059] DECL_TAG 'address=0xffffffff811d6800' type_id=9287 component_idx=-1
[35353] DECL_TAG 'address=0xffffffff811e1370' type_id=9287 component_idx=-1
[48934] DECL_TAG 'address=0xffffffff812fae80' type_id=9287 component_idx=-1
[54476] DECL_TAG 'address=0xffffffff81375c50' type_id=9287 component_idx=-1
[87772] DECL_TAG 'address=0xffffffff81634b60' type_id=9287 component_idx=-1
[108841] DECL_TAG 'address=0xffffffff817ba540' type_id=9287 component_idx=-1
[132557] DECL_TAG 'address=0xffffffff819abf30' type_id=9287 component_idx=-1
[143689] DECL_TAG 'address=0xffffffff81a7cb60' type_id=9287 component_idx=-1

Consider another case where the same name - wakeup_show() - is
used for two different function signatures:

From kernel/irq/irqdesc.c

static ssize_t wakeup_show(struct kobject *kobj,
 			   struct kobj_attribute *attr, char *buf)

...and from drivers/base/power/sysfs.c

static ssize_t wakeup_show(struct device *dev, struct device_attribute *attr,
                           char *buf);

We see both defined in BTF, along with the addresses that
tell us which is which:

[28472] FUNC 'wakeup_show' type_id=11214 linkage=static

specifies

[11214] FUNC_PROTO '(anon)' ret_type_id=76 vlen=3
        'kobj' type_id=877
        'attr' type_id=11200
        'buf' type_id=56

...and has declaration tag

[28473] DECL_TAG 'address=0xffffffff8115eab0' type_id=28472 component_idx=-1

which identifies

ffffffff8115eab0 t wakeup_show

...as the function with the first signature.

Similarly,

[114375] FUNC 'wakeup_show' type_id=4750 linkage=static

[4750] FUNC_PROTO '(anon)' ret_type_id=76 vlen=3
        'dev' type_id=1488
        'attr' type_id=3909
        'buf' type_id=56
...and

[114376] DECL_TAG 'address=0xffffffff8181eac0' type_id=114375 component_idx=-1

...tell us that

ffffffff8181eac0 t wakeup_show

...has the second signature.  So we can accommodate multiple
functions with conflicting signatures in BTF, since we have
added extra info to map from function description in BTF
to address.

In total for vmlinux 52006 DECL_TAGs are added, and these add
2MB to the BTF representation.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 btf_encoder.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 3bd0fe0..315053d 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -988,13 +988,25 @@ static int functions_cmp(const void *_a, const void *_b)
 {
 	const struct elf_function *a = _a;
 	const struct elf_function *b = _b;
+	int ret;
 
 	/* if search key allows prefix match, verify target has matching
 	 * prefix len and prefix matches.
 	 */
 	if (a->prefixlen && a->prefixlen == b->prefixlen)
-		return strncmp(a->name, b->name, b->prefixlen);
-	return strcmp(a->name, b->name);
+		ret = strncmp(a->name, b->name, b->prefixlen);
+	else
+		ret = strcmp(a->name, b->name);
+
+	if (ret || !b->addr)
+		return ret;
+
+	/* secondarily sort/search by address. */
+	if (a->addr < b->addr)
+		return -1;
+	if (a->addr > b->addr)
+		return 1;
+	return 0;
 }
 
 #ifndef max
@@ -1044,9 +1056,11 @@ static int btf_encoder__collect_function(struct btf_encoder *encoder, GElf_Sym *
 }
 
 static struct elf_function *btf_encoder__find_function(const struct btf_encoder *encoder,
-						       const char *name, size_t prefixlen)
+						       struct function *fn, size_t prefixlen)
 {
-	struct elf_function key = { .name = name, .prefixlen = prefixlen };
+	struct elf_function key = { .name = function__name(fn),
+				    .addr = fn->low_pc,
+				    .prefixlen = prefixlen };
 
 	return bsearch(&key, encoder->functions.entries, encoder->functions.cnt, sizeof(key), functions_cmp);
 }
@@ -1846,7 +1860,7 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
 				continue;
 
 			/* prefer exact function name match... */
-			func = btf_encoder__find_function(encoder, name, 0);
+			func = btf_encoder__find_function(encoder, fn, 0);
 			if (func) {
 				if (func->generated)
 					continue;
@@ -1863,7 +1877,7 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
 				 * it does not have optimized-out parameters
 				 * in any cu.
 				 */
-				func = btf_encoder__find_function(encoder, name,
+				func = btf_encoder__find_function(encoder, fn,
 								  strlen(name));
 				if (func) {
 					save = true;
-- 
2.31.1


