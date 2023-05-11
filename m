Return-Path: <bpf+bounces-333-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3CE6FF41B
	for <lists+bpf@lfdr.de>; Thu, 11 May 2023 16:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57BA21C20EB4
	for <lists+bpf@lfdr.de>; Thu, 11 May 2023 14:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38101D2A8;
	Thu, 11 May 2023 14:26:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB891F922
	for <bpf@vger.kernel.org>; Thu, 11 May 2023 14:26:43 +0000 (UTC)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D8CF11600;
	Thu, 11 May 2023 07:26:32 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-50b383222f7so12957097a12.3;
        Thu, 11 May 2023 07:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1683815191; x=1686407191;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FfHvJaE373FwPkBo+MbvKKH9vrJm6j2m01pppMLR2Fs=;
        b=n9Y7Em7SkB9orYrAbcCUvQXxkKi727MiQdFajf4HlIYSHX2PG9dMO34uyKqJrZ5cit
         i4+wO58Ror05WSxbokgiqseHvrBbqqie2cxX7KTFU071x1BQhSh+2dEnOHgunVWzaPOO
         IQvNEKYfRGf05i3DNDX88Njr55+onoL6F2nnpPjanz16zRSjfQdZj6yyRVqiQrzImILd
         Z/OWXk2gkmISUByuBUlZnuNGfbmO4N9WHTkesGj3dEgnTkcJmbXkIqjAHdpjSzgn8YLm
         wTv3jqTgBm+oKURueLWtI94wjqxO2TmC1YXk9er+4EojpU1xst3Cr6Jg+XEtf2oScBgM
         odyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683815191; x=1686407191;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FfHvJaE373FwPkBo+MbvKKH9vrJm6j2m01pppMLR2Fs=;
        b=l9eaLf5Zu+DvpscGeB6yQrBViffhtwaRVI2YX+Izny+pezvhT7zBj7pmBFtBYB70Wv
         ylUFhwVfCbdk9rX7V04m/N8747AoAPf56lfzUXxh7YHY4pCZHz1crkyu0G00CxbjlFDJ
         emgTYKddD4GXNssnFQbvfxw/OJWi5kLEjK6PGVdhtMdL403gvIWPgtJKZrFHmWRJx/j8
         k8F3NoCB7lraMg6c3mT3+LXw3Sm6LS9Leeu1Pyt2nBsOtLLAYZiUgYWpFUrp7Bs3OLZJ
         Ml1PlDcLplxvu8hq3lNEzdtcYa74mpebOf3G+Pf/HyHDCJDqQeWiNSfR961IPz/V5+tW
         +hQw==
X-Gm-Message-State: AC+VfDwOa1LydRGbHSNmP9YW/CWzf+wGyU4ycosvmVHI5oGQk6vEvnS9
	JnN2bmQgW63dq797dKEos36qjCx6TMY9og==
X-Google-Smtp-Source: ACHHUZ5y1zkVgoN4BZ0TJw5mvRpA0PrhNACP4gefsO5AZ+PYeLklJn3cCj9SPGF8TNfMkgAfKB6DEQ==
X-Received: by 2002:a17:907:a46:b0:94f:2b80:f3b4 with SMTP id be6-20020a1709070a4600b0094f2b80f3b4mr17315061ejc.69.1683815190662;
        Thu, 11 May 2023 07:26:30 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-008-180-228.77.8.pool.telefonica.de. [77.8.180.228])
        by smtp.gmail.com with ESMTPSA id hf15-20020a1709072c4f00b0094f58a85bc5sm4056647ejc.180.2023.05.11.07.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 07:26:29 -0700 (PDT)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>,
	John Johansen <john.johansen@canonical.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Eric Paris <eparis@parisplace.org>,
	Christian Brauner <brauner@kernel.org>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Dave Chinner <dchinner@redhat.com>,
	Nathan Lynch <nathanl@linux.ibm.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Micah Morton <mortonm@chromium.org>,
	Frederick Lawler <fred@cloudflare.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	linux-kernel@vger.kernel.org,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v4 1/9] capability: introduce new capable flag NODENYAUDIT
Date: Thu, 11 May 2023 16:25:24 +0200
Message-Id: <20230511142535.732324-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Introduce a new capable flag, CAP_OPT_NODENYAUDIT, to not generate
an audit event if the requested capability is not granted.  This will be
used in a new capable_any() functionality to reduce the number of
necessary capable calls.

Handle the flag accordingly in AppArmor and SELinux.

Suggested-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 include/linux/security.h       |  2 ++
 security/apparmor/capability.c |  8 +++++---
 security/selinux/hooks.c       | 14 ++++++++------
 3 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index e2734e9e44d5..629c775ec297 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -67,6 +67,8 @@ struct watch_notification;
 #define CAP_OPT_NOAUDIT BIT(1)
 /* If capable is being called by a setid function */
 #define CAP_OPT_INSETID BIT(2)
+/* If capable should audit the security request for authorized requests only */
+#define CAP_OPT_NODENYAUDIT BIT(3)
 
 /* LSM Agnostic defines for security_sb_set_mnt_opts() flags */
 #define SECURITY_LSM_NATIVE_LABELS	1
diff --git a/security/apparmor/capability.c b/security/apparmor/capability.c
index 326a51838ef2..98120dd62ca7 100644
--- a/security/apparmor/capability.c
+++ b/security/apparmor/capability.c
@@ -108,7 +108,8 @@ static int audit_caps(struct common_audit_data *sa, struct aa_profile *profile,
  * profile_capable - test if profile allows use of capability @cap
  * @profile: profile being enforced    (NOT NULL, NOT unconfined)
  * @cap: capability to test if allowed
- * @opts: CAP_OPT_NOAUDIT bit determines whether audit record is generated
+ * @opts: CAP_OPT_NOAUDIT/CAP_OPT_NODENYAUDIT bit determines whether audit
+ *	record is generated
  * @sa: audit data (MAY BE NULL indicating no auditing)
  *
  * Returns: 0 if allowed else -EPERM
@@ -126,7 +127,7 @@ static int profile_capable(struct aa_profile *profile, int cap,
 	else
 		error = -EPERM;
 
-	if (opts & CAP_OPT_NOAUDIT) {
+	if ((opts & CAP_OPT_NOAUDIT) || ((opts & CAP_OPT_NODENYAUDIT) && error)) {
 		if (!COMPLAIN_MODE(profile))
 			return error;
 		/* audit the cap request in complain mode but note that it
@@ -142,7 +143,8 @@ static int profile_capable(struct aa_profile *profile, int cap,
  * aa_capable - test permission to use capability
  * @label: label being tested for capability (NOT NULL)
  * @cap: capability to be tested
- * @opts: CAP_OPT_NOAUDIT bit determines whether audit record is generated
+ * @opts: CAP_OPT_NOAUDIT/CAP_OPT_NODENYAUDIT bit determines whether audit
+ *	record is generated
  *
  * Look up capability in profile capability set.
  *
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 79b4890e9936..0730edf2f5f1 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1571,7 +1571,7 @@ static int cred_has_capability(const struct cred *cred,
 	u16 sclass;
 	u32 sid = cred_sid(cred);
 	u32 av = CAP_TO_MASK(cap);
-	int rc;
+	int rc, rc2;
 
 	ad.type = LSM_AUDIT_DATA_CAP;
 	ad.u.cap = cap;
@@ -1590,11 +1590,13 @@ static int cred_has_capability(const struct cred *cred,
 	}
 
 	rc = avc_has_perm_noaudit(sid, sid, sclass, av, 0, &avd);
-	if (!(opts & CAP_OPT_NOAUDIT)) {
-		int rc2 = avc_audit(sid, sid, sclass, av, &avd, rc, &ad);
-		if (rc2)
-			return rc2;
-	}
+	if ((opts & CAP_OPT_NOAUDIT) || ((opts & CAP_OPT_NODENYAUDIT) && rc))
+		return rc;
+
+	rc2 = avc_audit(sid, sid, sclass, av, &avd, rc, &ad);
+	if (rc2)
+		return rc2;
+
 	return rc;
 }
 
-- 
2.40.1


