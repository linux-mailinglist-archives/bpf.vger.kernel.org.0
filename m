Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2703615662
	for <lists+bpf@lfdr.de>; Wed,  2 Nov 2022 01:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiKBAFi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Nov 2022 20:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiKBAFe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Nov 2022 20:05:34 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3D9F5BA
        for <bpf@vger.kernel.org>; Tue,  1 Nov 2022 17:05:32 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id v17so12030205plo.1
        for <bpf@vger.kernel.org>; Tue, 01 Nov 2022 17:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cuVXQ624vpOpv5WpUPiuVbtqN8onXUHTVR60ityXaOQ=;
        b=Tsy9m8npTjmDupXu0OBqWqh1PciY7iXCu2s59aHZRD2y1AncgedCFok9x4glQ/uwDl
         9kGEdQf1VMErlwKcXPVP2vP4ExtQl8B0hzH2NrMayfy8dANnfZX6RmJ2X9mi/0y88KyH
         0FJhEHzF0CulXUHUSo5CsK8azLcifw6p61GsU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cuVXQ624vpOpv5WpUPiuVbtqN8onXUHTVR60ityXaOQ=;
        b=bD/uPgqEPQT27JOTzvc2nqaCsSl9rafF9axSX105VLUbTBkx9aa1dQHzP9RYteYBeZ
         PPMVnxEYCo0TkNk7nQYdVr6+59jG/KTrqAmceC7lCSJyfjKegGNF5lESSueZEKOkJ0sr
         UxTomOcODTdc1Fbhz+TxdgQV8j5Bsc2Banw+wh4o+Lo1UhZ2cyyzYO6oQ5xpw2KsLM+0
         /89B3hFoYhx3cYB0oXBJ9MWc6YlCaOC9cSspmx05F4IOZKO/q7Hah8DyJDGHbV0tZBKK
         u6D2NZZ3tl+m0dvEK9Mod6X0C1YeRVeCFJPRpe2Vqf/lL+NCpR7hIDnMdvRwgCa5zvJ6
         1zjg==
X-Gm-Message-State: ACrzQf1dE/JLypGFrWNKkbzhxJr7nBS5+/TQZCZE0QXByovyqkxODUSU
        eKDCfBF2wdnJwUxKW+AkpJrRZg==
X-Google-Smtp-Source: AMsMyM4thNRM2kVgmbLTsty16zasvGgVs8JD0z75bKSSCBnPeXbfdnZNS8rHACHDDiJ4ghOkk8jWFQ==
X-Received: by 2002:a17:90a:5b03:b0:213:e4bc:fbf4 with SMTP id o3-20020a17090a5b0300b00213e4bcfbf4mr13148522pji.74.1667347531901;
        Tue, 01 Nov 2022 17:05:31 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a14-20020aa7970e000000b0056b6c7a17c6sm7299754pfg.12.2022.11.01.17.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 17:05:31 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Kees Cook <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH v2] LSM: Better reporting of actual LSMs at boot
Date:   Tue,  1 Nov 2022 17:05:29 -0700
Message-Id: <20221102000525.gonna.409-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9926; h=from:subject:message-id; bh=kZwUboFI6xY3ME1TuZ7jpR+eXtpFQgpd3UFOC6zDCC8=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjYbRINx2jUZN0H8eTWklIhlM/9pM6rK/KTpPON6/C HJuKaOeJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY2G0SAAKCRCJcvTf3G3AJuqeD/ 0e8ovhl3MImBFBYrn6pENMnghZ2D+C6KEPrSIMzXZ3+3NMqPDDPqm41g0C1is6hgK3HAm+xO1rmfhi LO95UYvOQR/wqo+yiRZRbhpfqu6DtWx+C52cU/QQDmF4lVKWW5SKwN8Aq9T4557z7go+ohqPkA3Ok9 4+OQezotV085w7Lmz3vScM1liTOCDqSCEOm3CwyNkmAcSyX4kR4vQvX/MPpTtWQuYO6wtRF/1fHHHS jAgrj5hWC/7DSQEl+OGf/L/dGZjTM3auI7bjSiZz0l/4sIYI0dOm8y+MvC898ocR5GkXkm5s+QjX4M 9NrVAyYMobHeCSnbaOxxoJFMy7clKFDZLCJ4/Fxt14XeHspnFIvVIXkwlGGroefZ4p0BQuXkqGkdUU fWOavrd87Wec/zbrHt5D4JT0jCs5ctLQUoT0sA34zAy6bK1Ij/zVWVmClHdnbIv+QjrGAGRVzjrKK1 exRwASXDFweuoXDfK81uz1hUWsJWcXorQLIyU5i2kngCJYjsfYY49fKh7yWxrgL/x2vddFJRUeAqtp 10qHYfSBM5srPdieAvTdwS9kxcEAVirDsaNPQOIu4XSdsuTsrC1YLqz5RfG+mYZYUV7KPQQYMxB9pe 4MlimfJMX76QgHMIV4nkubA8iFpRbI+aHFuFBEb8K02J2n5EP40Pffw+scwQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Enhance the details reported by "lsm.debug" in several ways:

- report contents of "security="
- report contents of "CONFIG_LSM"
- report contents of "lsm="
- report any early LSM details
- whitespace-align the output of similar phases for easier visual parsing
- change "disabled" to more accurate "skipped"
- explain what "skipped" and "ignored" mean in a parenthetical

Upgrade the "security= is ignored" warning from pr_info to pr_warn,
and include full arguments list to make the cause even more clear.

Replace static "Security Framework initializing" pr_info with specific
list of the resulting order of enabled LSMs.

For example, if the kernel is built with:

CONFIG_SECURITY_SELINUX=y
CONFIG_SECURITY_APPARMOR=y
CONFIG_SECURITY_LOADPIN=y
CONFIG_SECURITY_YAMA=y
CONFIG_SECURITY_SAFESETID=y
CONFIG_SECURITY_LOCKDOWN_LSM=y
CONFIG_SECURITY_LANDLOCK=y
CONFIG_INTEGRITY=y
CONFIG_BPF_LSM=y
CONFIG_DEFAULT_SECURITY_APPARMOR=y
CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor,bpf"

Booting without options will show:

LSM: initializing lsm=lockdown,capability,landlock,yama,loadpin,safesetid,integrity,selinux,bpf
landlock: Up and running.
Yama: becoming mindful.
LoadPin: ready to pin (currently not enforcing)
SELinux:  Initializing.
LSM support for eBPF active

Boot with "lsm.debug" will show:

LSM: legacy security= *unspecified*
LSM: CONFIG_LSM=landlock,lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor,bpf
LSM: boot arg lsm= *unspecified*
LSM:   early started: lockdown (enabled)
LSM:   first ordered: capability (enabled)
LSM: builtin ordered: landlock (enabled)
LSM: builtin ignored: lockdown (not built into kernel)
LSM: builtin ordered: yama (enabled)
LSM: builtin ordered: loadpin (enabled)
LSM: builtin ordered: safesetid (enabled)
LSM: builtin ordered: integrity (enabled)
LSM: builtin ordered: selinux (enabled)
LSM: builtin ignored: smack (not built into kernel)
LSM: builtin ignored: tomoyo (not built into kernel)
LSM: builtin ordered: apparmor (enabled)
LSM: builtin ordered: bpf (enabled)
LSM: exclusive chosen:   selinux
LSM: exclusive disabled: apparmor
LSM: initializing lsm=lockdown,capability,landlock,yama,loadpin,safesetid,integrity,selinux,bpf
LSM: cred blob size       = 32
LSM: file blob size       = 16
LSM: inode blob size      = 72
LSM: ipc blob size        = 8
LSM: msg_msg blob size    = 4
LSM: superblock blob size = 80
LSM: task blob size       = 8
LSM: initializing capability
LSM: initializing landlock
landlock: Up and running.
LSM: initializing yama
Yama: becoming mindful.
LSM: initializing loadpin
LoadPin: ready to pin (currently not enforcing)
LSM: initializing safesetid
LSM: initializing integrity
LSM: initializing selinux
SELinux:  Initializing.
LSM: initializing bpf
LSM support for eBPF active

And some examples of how the lsm.debug ordering report changes...

With "lsm.debug security=selinux":

LSM: legacy security=selinux
LSM: CONFIG_LSM=landlock,lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor,bpf
LSM: boot arg lsm= *unspecified*
LSM:   early started: lockdown (enabled)
LSM:   first ordered: capability (enabled)
LSM: security=selinux disabled: apparmor (only one legacy major LSM)
LSM: builtin ordered: landlock (enabled)
LSM: builtin ignored: lockdown (not built into kernel)
LSM: builtin ordered: yama (enabled)
LSM: builtin ordered: loadpin (enabled)
LSM: builtin ordered: safesetid (enabled)
LSM: builtin ordered: integrity (enabled)
LSM: builtin ordered: selinux (enabled)
LSM: builtin ignored: smack (not built into kernel)
LSM: builtin ignored: tomoyo (not built into kernel)
LSM: builtin ordered: apparmor (disabled)
LSM: builtin ordered: bpf (enabled)
LSM: exclusive chosen:   selinux
LSM: initializing lsm=lockdown,capability,landlock,yama,loadpin,safesetid,integrity,selinux,bpf

With "lsm.debug lsm=integrity,selinux,loadpin,crabability,bpf,loadpin,loadpin":

LSM: legacy security= *unspecified*
LSM: CONFIG_LSM=landlock,lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor,bpf
LSM: boot arg lsm=integrity,selinux,loadpin,capability,bpf,loadpin,loadpin
LSM:   early started: lockdown (enabled)
LSM:   first ordered: capability (enabled)
LSM: cmdline ordered: integrity (enabled)
LSM: cmdline ordered: selinux (enabled)
LSM: cmdline ordered: loadpin (enabled)
LSM: cmdline ignored: crabability (not built into kernel)
LSM: cmdline ordered: bpf (enabled)
LSM: cmdline skipped: apparmor (not in requested order)
LSM: cmdline skipped: yama (not in requested order)
LSM: cmdline skipped: safesetid (not in requested order)
LSM: cmdline skipped: landlock (not in requested order)
LSM: exclusive chosen:   selinux
LSM: initializing lsm=lockdown,capability,integrity,selinux,loadpin,bpf

Cc: Paul Moore <paul@paul-moore.com>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-security-module@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v2: en/dis-enabled expanded, example output in commit log, use pr_cont.
v1: https://lore.kernel.org/lkml/20221018064825.never.323-kees@kernel.org/
---
 security/security.c | 45 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 36 insertions(+), 9 deletions(-)

diff --git a/security/security.c b/security/security.c
index 79d82cb6e469..abceabda103d 100644
--- a/security/security.c
+++ b/security/security.c
@@ -161,8 +161,8 @@ static void __init append_ordered_lsm(struct lsm_info *lsm, const char *from)
 		lsm->enabled = &lsm_enabled_true;
 	ordered_lsms[last_lsm++] = lsm;
 
-	init_debug("%s ordering: %s (%sabled)\n", from, lsm->name,
-		   is_enabled(lsm) ? "en" : "dis");
+	init_debug("%s ordered: %s (%s)\n", from, lsm->name,
+		   is_enabled(lsm) ? "enabled" : "disabled");
 }
 
 /* Is an LSM allowed to be initialized? */
@@ -224,7 +224,7 @@ static void __init prepare_lsm(struct lsm_info *lsm)
 	if (enabled) {
 		if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && !exclusive) {
 			exclusive = lsm;
-			init_debug("exclusive chosen: %s\n", lsm->name);
+			init_debug("exclusive chosen:   %s\n", lsm->name);
 		}
 
 		lsm_set_blob_sizes(lsm->blobs);
@@ -252,7 +252,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 	/* LSM_ORDER_FIRST is always first. */
 	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
 		if (lsm->order == LSM_ORDER_FIRST)
-			append_ordered_lsm(lsm, "first");
+			append_ordered_lsm(lsm, "  first");
 	}
 
 	/* Process "security=", if given. */
@@ -270,7 +270,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 			if ((major->flags & LSM_FLAG_LEGACY_MAJOR) &&
 			    strcmp(major->name, chosen_major_lsm) != 0) {
 				set_enabled(major, false);
-				init_debug("security=%s disabled: %s\n",
+				init_debug("security=%s disabled: %s (only one legacy major LSM)\n",
 					   chosen_major_lsm, major->name);
 			}
 		}
@@ -291,7 +291,8 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 		}
 
 		if (!found)
-			init_debug("%s ignored: %s\n", origin, name);
+			init_debug("%s ignored: %s (not built into kernel)\n",
+				   origin, name);
 	}
 
 	/* Process "security=", if given. */
@@ -309,7 +310,8 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 		if (exists_ordered_lsm(lsm))
 			continue;
 		set_enabled(lsm, false);
-		init_debug("%s disabled: %s\n", origin, lsm->name);
+		init_debug("%s skipped: %s (not in requested order)\n",
+			   origin, lsm->name);
 	}
 
 	kfree(sep);
@@ -320,6 +322,24 @@ static void __init lsm_early_task(struct task_struct *task);
 
 static int lsm_append(const char *new, char **result);
 
+static void __init report_lsm_order(void)
+{
+	struct lsm_info **lsm, *early;
+	int first = 0;
+
+	pr_info("initializing lsm=");
+
+	/* Report each enabled LSM name, comma separated. */
+	for (early = __start_early_lsm_info; early < __end_early_lsm_info; early++)
+		if (is_enabled(early))
+			pr_cont("%s%s", first++ == 0 ? "" : ",", early->name);
+	for (lsm = ordered_lsms; *lsm; lsm++)
+		if (is_enabled(*lsm))
+			pr_cont("%s%s", first++ == 0 ? "" : ",", (*lsm)->name);
+
+	pr_cont("\n");
+}
+
 static void __init ordered_lsm_init(void)
 {
 	struct lsm_info **lsm;
@@ -329,7 +349,8 @@ static void __init ordered_lsm_init(void)
 
 	if (chosen_lsm_order) {
 		if (chosen_major_lsm) {
-			pr_info("security= is ignored because it is superseded by lsm=\n");
+			pr_warn("security=%s is ignored because it is superseded by lsm=%s\n",
+				chosen_major_lsm, chosen_lsm_order);
 			chosen_major_lsm = NULL;
 		}
 		ordered_lsm_parse(chosen_lsm_order, "cmdline");
@@ -339,6 +360,8 @@ static void __init ordered_lsm_init(void)
 	for (lsm = ordered_lsms; *lsm; lsm++)
 		prepare_lsm(*lsm);
 
+	report_lsm_order();
+
 	init_debug("cred blob size       = %d\n", blob_sizes.lbs_cred);
 	init_debug("file blob size       = %d\n", blob_sizes.lbs_file);
 	init_debug("inode blob size      = %d\n", blob_sizes.lbs_inode);
@@ -395,13 +418,17 @@ int __init security_init(void)
 {
 	struct lsm_info *lsm;
 
-	pr_info("Security Framework initializing\n");
+	init_debug("legacy security=%s\n", chosen_major_lsm ?: " *unspecified*");
+	init_debug("  CONFIG_LSM=%s\n", builtin_lsm_order);
+	init_debug("boot arg lsm=%s\n", chosen_lsm_order ?: " *unspecified*");
 
 	/*
 	 * Append the names of the early LSM modules now that kmalloc() is
 	 * available
 	 */
 	for (lsm = __start_early_lsm_info; lsm < __end_early_lsm_info; lsm++) {
+		init_debug("  early started: %s (%s)\n", lsm->name,
+			   is_enabled(lsm) ? "enabled" : "disabled");
 		if (lsm->enabled)
 			lsm_append(lsm->name, &lsm_names);
 	}
-- 
2.34.1

