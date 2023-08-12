Return-Path: <bpf+bounces-7655-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE78779F1F
	for <lists+bpf@lfdr.de>; Sat, 12 Aug 2023 12:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D93941C2089C
	for <lists+bpf@lfdr.de>; Sat, 12 Aug 2023 10:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900FF1FCA;
	Sat, 12 Aug 2023 10:49:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADCB370
	for <bpf@vger.kernel.org>; Sat, 12 Aug 2023 10:49:35 +0000 (UTC)
Received: from frasgout12.his.huawei.com (unknown [14.137.139.154])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4475A3A8F;
	Sat, 12 Aug 2023 03:48:57 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4RNH9M1rR3z9ygHK;
	Sat, 12 Aug 2023 18:35:03 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwBXC7scY9dkThi9AA--.8440S10;
	Sat, 12 Aug 2023 11:48:22 +0100 (CET)
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
Subject: [RFC][PATCH v2 08/13] ima: Use digest cache for measurement
Date: Sat, 12 Aug 2023 12:46:11 +0200
Message-Id: <20230812104616.2190095-9-roberto.sassu@huaweicloud.com>
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
X-CM-TRANSID:LxC2BwBXC7scY9dkThi9AA--.8440S10
X-Coremail-Antispam: 1UD129KBjvJXoW3Gr1rtFWfZrW8uFW7Aw1kZrb_yoWxJr1Upa
	9xuF1Fkrs5ZFyfCrn3A3W7Aa1S9rZ7tF4UGws8X34Skay3Xr10va1rAw129Fy5Jry5Xa4x
	ta1jgr4Uuw4jyaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAHBF1jj46UrwAAsF
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
	PDS_RDNS_DYNAMIC_FP,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,
	RCVD_IN_MSPIKE_L3,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_NONE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Roberto Sassu <roberto.sassu@huawei.com>

If a measure rule contains 'digest_cache=content', get the digest cache (if
available) associated to the file being measured.

AND the digest list mask from the IMA policy with the digest list mask of
the digest cache (set depending on the actions done on the digest lists),
to determine if the digest cache can be used for the measurement action.

If the digest cache is enabled, lookup the calculated digest of the file
being accessed and if found, pass the ANDed masks to
ima_store_measurement(). Otherwise, reset the mask to zero.

Finally, if the DIGEST_CACHE_MEASURE flag is set in the mask, mark the file
as measured for the supplied PCR (which cannot be the default one).

At the first digest list accessed, iterate over all digest lists in the
same directory, and measure them to make the PCR predictable. However,
don't parse those digest lists except the requested one, to avoid too much
memory pressure.

Skipping the measurement of cached digests causes less information to be
available to remote verifiers. In particular, they would know that a subset
or all files in the measured digest list could have been accessed, but they
won't know if and when.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima.h      |  3 ++-
 security/integrity/ima/ima_api.c  | 16 +++++++++++++++-
 security/integrity/ima/ima_main.c | 28 ++++++++++++++++++++++++++--
 3 files changed, 43 insertions(+), 4 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index f8f91d5c04a..bb75cc3d2fd 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -270,7 +270,8 @@ void ima_store_measurement(struct integrity_iint_cache *iint, struct file *file,
 			   const unsigned char *filename,
 			   struct evm_ima_xattr_data *xattr_value,
 			   int xattr_len, const struct modsig *modsig, int pcr,
-			   struct ima_template_desc *template_desc);
+			   struct ima_template_desc *template_desc,
+			   u64 digest_cache_mask);
 int process_buffer_measurement(struct mnt_idmap *idmap,
 			       struct inode *inode, const void *buf, int size,
 			       const char *eventname, enum ima_hooks func,
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index c591b093bb5..77b1ecff45a 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -339,7 +339,8 @@ void ima_store_measurement(struct integrity_iint_cache *iint,
 			   struct file *file, const unsigned char *filename,
 			   struct evm_ima_xattr_data *xattr_value,
 			   int xattr_len, const struct modsig *modsig, int pcr,
-			   struct ima_template_desc *template_desc)
+			   struct ima_template_desc *template_desc,
+			   u64 digest_cache_mask)
 {
 	static const char op[] = "add_template_measure";
 	static const char audit_cause[] = "ENOMEM";
@@ -363,6 +364,19 @@ void ima_store_measurement(struct integrity_iint_cache *iint,
 	if (iint->measured_pcrs & (0x1 << pcr) && !modsig)
 		return;
 
+	/*
+	 * If the file digest was found in the digest cache, the digest cache
+	 * is enabled for measurement, and the digest list was measured, mark
+	 * the file as measured, so that it does not appear in the measurement
+	 * list (known digest), and the same action is not repeated at the next
+	 * access.
+	 */
+	if (digest_cache_mask & DIGEST_CACHE_MEASURE) {
+		iint->flags |= IMA_MEASURED;
+		iint->measured_pcrs |= (0x1 << pcr);
+		return;
+	}
+
 	result = ima_alloc_init_template(&event_data, &entry, template_desc);
 	if (result < 0) {
 		integrity_audit_msg(AUDIT_INTEGRITY_PCR, inode, filename,
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 4fdfc399fa6..54d006fc490 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -221,6 +221,8 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	bool violation_check;
 	enum hash_algo hash_algo;
 	unsigned int allowed_algos = 0;
+	u64 digest_cache_mask = 0;
+	struct digest_cache *digest_cache = NULL;
 
 	if (!ima_policy_flag || !S_ISREG(inode->i_mode))
 		return 0;
@@ -231,7 +233,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	 */
 	action = ima_get_action(file_mnt_idmap(file), inode, cred, secid,
 				mask, func, &pcr, &template_desc, NULL,
-				&allowed_algos, NULL);
+				&allowed_algos, &digest_cache_mask);
 	violation_check = ((func == FILE_CHECK || func == MMAP_CHECK ||
 			    func == MMAP_CHECK_REQPROT) &&
 			   (ima_policy_flag & IMA_MEASURE));
@@ -263,6 +265,21 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	if (!action)
 		goto out;
 
+	if (digest_cache_mask) {
+		/*
+		 * Prefetch the digest lists to measure them in a deterministic
+		 * way, and make the PCR predictable.
+		 */
+		if (digest_cache_mask & DIGEST_CACHE_MEASURE)
+			digest_cache_iter_dir(file_dentry(file));
+
+		digest_cache = digest_cache_get(file_dentry(file), iint);
+		if (digest_cache)
+			digest_cache_mask &= digest_cache->mask;
+		else
+			digest_cache_mask = 0;
+	}
+
 	mutex_lock(&iint->mutex);
 
 	if (test_and_clear_bit(IMA_CHANGE_ATTR, &iint->atomic_flags))
@@ -349,10 +366,17 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	if (!pathbuf)	/* ima_rdwr_violation possibly pre-fetched */
 		pathname = ima_d_path(&file->f_path, &pathbuf, filename);
 
+	if (rc == 0 && digest_cache_mask) {
+		if (digest_cache_lookup(digest_cache, iint->ima_hash->digest,
+					iint->ima_hash->algo, pathname))
+			/* Reset the mask, the file digest was not found. */
+			digest_cache_mask = 0;
+	}
+
 	if (action & IMA_MEASURE)
 		ima_store_measurement(iint, file, pathname,
 				      xattr_value, xattr_len, modsig, pcr,
-				      template_desc);
+				      template_desc, digest_cache_mask);
 	if (rc == 0 && (action & IMA_APPRAISE_SUBMASK)) {
 		rc = ima_check_blacklist(iint, modsig, pcr);
 		if (rc != -EPERM) {
-- 
2.34.1


