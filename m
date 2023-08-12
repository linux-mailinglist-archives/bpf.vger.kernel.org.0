Return-Path: <bpf+bounces-7654-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 106E2779F1E
	for <lists+bpf@lfdr.de>; Sat, 12 Aug 2023 12:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 390641C20340
	for <lists+bpf@lfdr.de>; Sat, 12 Aug 2023 10:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0677A1FCA;
	Sat, 12 Aug 2023 10:49:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF371370
	for <bpf@vger.kernel.org>; Sat, 12 Aug 2023 10:49:19 +0000 (UTC)
Received: from frasgout11.his.huawei.com (unknown [14.137.139.23])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE83D3593;
	Sat, 12 Aug 2023 03:48:44 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4RNHCZ4v8gz9yydv;
	Sat, 12 Aug 2023 18:36:58 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwBXC7scY9dkThi9AA--.8440S9;
	Sat, 12 Aug 2023 11:48:13 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: corbet@lwn.net,
	zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	bpf@vger.kernel.org,
	jarkko@kernel.org,
	pbrobinson@gmail.com,
	zbyszek@in.waw.pl,
	hch@lst.de,
	mjg59@srcf.ucam.org,
	pmatilai@redhat.com,
	jannh@google.com,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH v2 07/13] ima: Add digest_cache policy keyword
Date: Sat, 12 Aug 2023 12:46:10 +0200
Message-Id: <20230812104616.2190095-8-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230812104616.2190095-1-roberto.sassu@huaweicloud.com>
References: <20230812104616.2190095-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwBXC7scY9dkThi9AA--.8440S9
X-Coremail-Antispam: 1UD129KBjvJXoW3CrWruw17uFyrAr15trW8WFg_yoWkCF17pa
	yvg3WUCr48ZryS9r1xAay29r4FgrWfta1UA398X342yanxXr10vw1fJr13AFy5ArW5CF92
	yF1Ygr4DuF4jvaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBvb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrV
	C2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE
	7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20x
	vY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I
	3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIx
	AIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI
	42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z2
	80aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UZo7tUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAHBF1jj5KVZQAEsV
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
	PDS_RDNS_DYNAMIC_FP,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,
	RCVD_IN_MSPIKE_L3,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_NONE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Roberto Sassu <roberto.sassu@huawei.com>

Add the digest_cache policy keyword, to enable the use of the digest cache
for specific IMA actions and purpose. At the moment, the digest cache can
be used for measurement and appraisal of file content. They are reflected
respectively with the new flags DIGEST_CACHE_MEASURE and
DIGEST_CACHE_APPRAISE_CONTENT.

Depending on the IMA action of the parsed rule, the new flags are set in
the digest_cache_mask variable and passed back to process_measurement(), so
that the latter can determine whether or not it can use the digest cache.

The digest cache cannot be used for measurement on the default PCR. It
cannot also be used for appraisal together with the other appraisal methods
(imasig, sigv3, modsig).

Also, currently, the digest cache cannot be used to measure/appraise digest
lists. This functionality will be added in the future.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 Documentation/ABI/testing/ima_policy  |  5 ++-
 security/integrity/ima/ima.h          |  6 ++-
 security/integrity/ima/ima_api.c      |  6 ++-
 security/integrity/ima/ima_appraise.c |  2 +-
 security/integrity/ima/ima_main.c     |  8 ++--
 security/integrity/ima/ima_policy.c   | 56 ++++++++++++++++++++++++++-
 6 files changed, 71 insertions(+), 12 deletions(-)

diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
index 14d92c687ef..7792e65b35c 100644
--- a/Documentation/ABI/testing/ima_policy
+++ b/Documentation/ABI/testing/ima_policy
@@ -29,7 +29,7 @@ Description:
 				 [obj_user=] [obj_role=] [obj_type=]]
 			option:	[digest_type=] [template=] [permit_directio]
 				[appraise_type=] [appraise_flag=]
-				[appraise_algos=] [keyrings=]
+				[appraise_algos=] [keyrings=] [digest_cache=]
 		  base:
 			func:= [BPRM_CHECK][MMAP_CHECK][CREDS_CHECK][FILE_CHECK][MODULE_CHECK]
 				[FIRMWARE_CHECK]
@@ -77,6 +77,9 @@ Description:
 			For example, "sha256,sha512" to only accept to appraise
 			files where the security.ima xattr was hashed with one
 			of these two algorithms.
+			digest_cache:= [content]
+			"content" means that the digest cache is used only
+			for file content measurement and/or appraisal.
 
 		  default policy:
 			# PROC_SUPER_MAGIC
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 3aef3d8fb57..f8f91d5c04a 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -260,7 +260,8 @@ int ima_get_action(struct mnt_idmap *idmap, struct inode *inode,
 		   const struct cred *cred, u32 secid, int mask,
 		   enum ima_hooks func, int *pcr,
 		   struct ima_template_desc **template_desc,
-		   const char *func_data, unsigned int *allowed_algos);
+		   const char *func_data, unsigned int *allowed_algos,
+		   u64 *digest_cache_mask);
 int ima_must_measure(struct inode *inode, int mask, enum ima_hooks func);
 int ima_collect_measurement(struct integrity_iint_cache *iint,
 			    struct file *file, void *buf, loff_t size,
@@ -291,7 +292,8 @@ int ima_match_policy(struct mnt_idmap *idmap, struct inode *inode,
 		     const struct cred *cred, u32 secid, enum ima_hooks func,
 		     int mask, int flags, int *pcr,
 		     struct ima_template_desc **template_desc,
-		     const char *func_data, unsigned int *allowed_algos);
+		     const char *func_data, unsigned int *allowed_algos,
+		     u64 *digest_cache_mask);
 void ima_init_policy(void);
 void ima_update_policy(void);
 void ima_update_policy_flags(void);
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index 452e80b541e..c591b093bb5 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -173,6 +173,7 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
  * @template_desc: pointer filled in if matched measure policy sets template=
  * @func_data: func specific data, may be NULL
  * @allowed_algos: allowlist of hash algorithms for the IMA xattr
+ * @digest_cache_mask: For which actions and purpose the digest cache is usable
  *
  * The policy is defined in terms of keypairs:
  *		subj=, obj=, type=, func=, mask=, fsmagic=
@@ -190,7 +191,8 @@ int ima_get_action(struct mnt_idmap *idmap, struct inode *inode,
 		   const struct cred *cred, u32 secid, int mask,
 		   enum ima_hooks func, int *pcr,
 		   struct ima_template_desc **template_desc,
-		   const char *func_data, unsigned int *allowed_algos)
+		   const char *func_data, unsigned int *allowed_algos,
+		   u64 *digest_cache_mask)
 {
 	int flags = IMA_MEASURE | IMA_AUDIT | IMA_APPRAISE | IMA_HASH;
 
@@ -198,7 +200,7 @@ int ima_get_action(struct mnt_idmap *idmap, struct inode *inode,
 
 	return ima_match_policy(idmap, inode, cred, secid, func, mask,
 				flags, pcr, template_desc, func_data,
-				allowed_algos);
+				allowed_algos, digest_cache_mask);
 }
 
 static bool ima_get_verity_digest(struct integrity_iint_cache *iint,
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 491c1aca0b1..10dbafdae3d 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -81,7 +81,7 @@ int ima_must_appraise(struct mnt_idmap *idmap, struct inode *inode,
 	security_current_getsecid_subj(&secid);
 	return ima_match_policy(idmap, inode, current_cred(), secid,
 				func, mask, IMA_APPRAISE | IMA_HASH, NULL,
-				NULL, NULL, NULL);
+				NULL, NULL, NULL, NULL);
 }
 
 static int ima_fix_xattr(struct dentry *dentry,
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 81abdc8b233..4fdfc399fa6 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -231,7 +231,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	 */
 	action = ima_get_action(file_mnt_idmap(file), inode, cred, secid,
 				mask, func, &pcr, &template_desc, NULL,
-				&allowed_algos);
+				&allowed_algos, NULL);
 	violation_check = ((func == FILE_CHECK || func == MMAP_CHECK ||
 			    func == MMAP_CHECK_REQPROT) &&
 			   (ima_policy_flag & IMA_MEASURE));
@@ -473,11 +473,11 @@ int ima_file_mprotect(struct vm_area_struct *vma, unsigned long prot)
 	inode = file_inode(vma->vm_file);
 	action = ima_get_action(file_mnt_idmap(vma->vm_file), inode,
 				current_cred(), secid, MAY_EXEC, MMAP_CHECK,
-				&pcr, &template, NULL, NULL);
+				&pcr, &template, NULL, NULL, NULL);
 	action |= ima_get_action(file_mnt_idmap(vma->vm_file), inode,
 				 current_cred(), secid, MAY_EXEC,
 				 MMAP_CHECK_REQPROT, &pcr, &template, NULL,
-				 NULL);
+				 NULL, NULL);
 
 	/* Is the mmap'ed file in policy? */
 	if (!(action & (IMA_MEASURE | IMA_APPRAISE_SUBMASK)))
@@ -958,7 +958,7 @@ int process_buffer_measurement(struct mnt_idmap *idmap,
 		security_current_getsecid_subj(&secid);
 		action = ima_get_action(idmap, inode, current_cred(),
 					secid, 0, func, &pcr, &template,
-					func_data, NULL);
+					func_data, NULL, NULL);
 		if (!(action & IMA_MEASURE) && !digest)
 			return -ENOENT;
 	}
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index b32c83d8a72..8583479112d 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -122,6 +122,7 @@ struct ima_rule_entry {
 	struct ima_rule_opt_list *keyrings; /* Measure keys added to these keyrings */
 	struct ima_rule_opt_list *label; /* Measure data grouped under this label */
 	struct ima_template_desc *template;
+	u64 digest_cache_mask;	/* For which actions and purpose the digest cache is usable */
 };
 
 /*
@@ -726,6 +727,7 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
  * @template_desc: the template that should be used for this rule
  * @func_data: func specific data, may be NULL
  * @allowed_algos: allowlist of hash algorithms for the IMA xattr
+ * @digest_cache_mask: For which actions and purpose the digest cache is usable
  *
  * Measure decision based on func/mask/fsmagic and LSM(subj/obj/type)
  * conditions.
@@ -738,7 +740,8 @@ int ima_match_policy(struct mnt_idmap *idmap, struct inode *inode,
 		     const struct cred *cred, u32 secid, enum ima_hooks func,
 		     int mask, int flags, int *pcr,
 		     struct ima_template_desc **template_desc,
-		     const char *func_data, unsigned int *allowed_algos)
+		     const char *func_data, unsigned int *allowed_algos,
+		     u64 *digest_cache_mask)
 {
 	struct ima_rule_entry *entry;
 	int action = 0, actmask = flags | (flags << 1);
@@ -783,6 +786,9 @@ int ima_match_policy(struct mnt_idmap *idmap, struct inode *inode,
 		if (template_desc && entry->template)
 			*template_desc = entry->template;
 
+		if (digest_cache_mask)
+			*digest_cache_mask |= entry->digest_cache_mask;
+
 		if (!actmask)
 			break;
 	}
@@ -1073,7 +1079,7 @@ enum policy_opt {
 	Opt_digest_type,
 	Opt_appraise_type, Opt_appraise_flag, Opt_appraise_algos,
 	Opt_permit_directio, Opt_pcr, Opt_template, Opt_keyrings,
-	Opt_label, Opt_err
+	Opt_label, Opt_digest_cache, Opt_err
 };
 
 static const match_table_t policy_tokens = {
@@ -1122,6 +1128,7 @@ static const match_table_t policy_tokens = {
 	{Opt_template, "template=%s"},
 	{Opt_keyrings, "keyrings=%s"},
 	{Opt_label, "label=%s"},
+	{Opt_digest_cache, "digest_cache=%s"},
 	{Opt_err, NULL}
 };
 
@@ -1886,6 +1893,26 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 						 &(template_desc->num_fields));
 			entry->template = template_desc;
 			break;
+		case Opt_digest_cache:
+			ima_log_string(ab, "template", args[0].from);
+
+			result = -EINVAL;
+
+			if (!strcmp(args[0].from, "content")) {
+				switch (entry->action) {
+				case MEASURE:
+					entry->digest_cache_mask |= DIGEST_CACHE_MEASURE;
+					result = 0;
+					break;
+				case APPRAISE:
+					entry->digest_cache_mask |= DIGEST_CACHE_APPRAISE_CONTENT;
+					result = 0;
+					break;
+				default:
+					break;
+				}
+			}
+			break;
 		case Opt_err:
 			ima_log_string(ab, "UNKNOWN", p);
 			result = -EINVAL;
@@ -1912,6 +1939,28 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 				     "verity rules should include d-ngv2");
 	}
 
+	/* New-style measurements with digest cache cannot be on default PCR. */
+	if (entry->action == MEASURE &&
+	    (entry->digest_cache_mask & DIGEST_CACHE_MEASURE)) {
+		if (!(entry->flags & IMA_PCR) ||
+		    entry->pcr == CONFIG_IMA_MEASURE_PCR_IDX)
+			result = -EINVAL;
+	}
+
+	/* Digest cache should not conflict with other appraisal methods. */
+	if (entry->action == APPRAISE &&
+	    (entry->digest_cache_mask & DIGEST_CACHE_APPRAISE_CONTENT)) {
+		if ((entry->flags & IMA_DIGSIG_REQUIRED) ||
+		    (entry->flags & IMA_VERITY_REQUIRED) ||
+		    (entry->flags & IMA_MODSIG_ALLOWED))
+			result = -EINVAL;
+	}
+
+	/* Digest cache cannot be used to measure/appraise digest lists. */
+	if ((entry->flags & IMA_FUNC) && entry->func == DIGEST_LIST_CHECK &&
+	    entry->digest_cache_mask)
+		result = -EINVAL;
+
 	audit_log_format(ab, "res=%d", !result);
 	audit_log_end(ab);
 	return result;
@@ -2278,6 +2327,9 @@ int ima_policy_show(struct seq_file *m, void *v)
 		seq_puts(m, "appraise_flag=check_blacklist ");
 	if (entry->flags & IMA_PERMIT_DIRECTIO)
 		seq_puts(m, "permit_directio ");
+	if ((entry->digest_cache_mask & DIGEST_CACHE_MEASURE) ||
+	    (entry->digest_cache_mask & DIGEST_CACHE_APPRAISE_CONTENT))
+		seq_puts(m, "digest_cache=content ");
 	rcu_read_unlock();
 	seq_puts(m, "\n");
 	return 0;
-- 
2.34.1


