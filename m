Return-Path: <bpf+bounces-334-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB906FF423
	for <lists+bpf@lfdr.de>; Thu, 11 May 2023 16:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C5E81C20F14
	for <lists+bpf@lfdr.de>; Thu, 11 May 2023 14:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57AFA1D2AF;
	Thu, 11 May 2023 14:26:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2545A1F922
	for <bpf@vger.kernel.org>; Thu, 11 May 2023 14:26:44 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9115411619;
	Thu, 11 May 2023 07:26:33 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-965d2749e2eso1257311366b.1;
        Thu, 11 May 2023 07:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1683815192; x=1686407192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BpxDj8P/CkXIcvSdZuhR1VFy2f2KQ0RPAwIQ63hDnKo=;
        b=RrYgmHxo5etwhT/+56sn3wE+KundDALBLWMxxqFJp+4r6+BTti+1ZxLbgDew+kmFlL
         pn/3qFjmvgSICpbTr+Fq1fxorBJQy5Np9CWnI9jBGMxm80Z+heymVUqQABFxloaznsFn
         eVeM+4yc6W6z96vt/QyUokeQEonko22mVp6rlKchpnHE6IF1RHtDxtIvnzHoNpHUt5sm
         r2BZGkurhW1sCfWyZtAoU4KgJYjlG5dX7T3hTYtRq56B5tyUO+hSWbKuHCAM+Nea92qA
         m5pCPubDAsuXkvWrB/3/cGPoz1p5DjAsNtajIyUEuXkZFoBouCCAcLqomM67QSs++9ze
         bJnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683815192; x=1686407192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BpxDj8P/CkXIcvSdZuhR1VFy2f2KQ0RPAwIQ63hDnKo=;
        b=OsQz+6feCRphc+/Z4i76pww8Mw/0VdFOvI8jtNAd6Bs3fdWvqLxztOFD0FvsLuLPB4
         C5N5hodpD6+4VX6NyaLN0JSl15SyD03hbOcXLAnTXnJQCWfAZcjyjpk2OWBZnpJBfcqZ
         rxRWD95GqKg7eIW9HWGpx2KvTmZFsKbSUyaveNynNSZyEAZP5iW/25IKusSWyIv4qPpn
         Pdy2eGx+tY1tidwfx5eAnLC7X9iwMgO0qNWxNMx4TCJKPFfy99ZOKGbt8iVCqcPqn4Hy
         R+zYSJyNd8jzWaiXw5PiR8HmO3R1saF1AhAf0y7XicMjQ3PrLDNBuj3uF3bpIehejjDC
         UdJg==
X-Gm-Message-State: AC+VfDzUQyzs8txj5er/7yLVwQlYnuF9pP0FFub2OACYELDwKm7PZE2h
	nNczhtqTMOUYRWboE+fq+xo+uUQuL8q/Vw==
X-Google-Smtp-Source: ACHHUZ7eCmCMkYkYy/6MHZgHwVFpy27psg/GEnt8JKbUqISu8hg0QqDHwoN4CFU7NHOTQ+SSQgG7FA==
X-Received: by 2002:a17:906:eec9:b0:94f:73db:b390 with SMTP id wu9-20020a170906eec900b0094f73dbb390mr16686831ejb.65.1683815191760;
        Thu, 11 May 2023 07:26:31 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-008-180-228.77.8.pool.telefonica.de. [77.8.180.228])
        by smtp.gmail.com with ESMTPSA id hf15-20020a1709072c4f00b0094f58a85bc5sm4056647ejc.180.2023.05.11.07.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 07:26:31 -0700 (PDT)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@vger.kernel.org
Cc: Serge Hallyn <serge@hallyn.com>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v4 2/9] capability: add any wrapper to test for multiple caps with exactly one audit message
Date: Thu, 11 May 2023 16:25:25 +0200
Message-Id: <20230511142535.732324-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230511142535.732324-1-cgzones@googlemail.com>
References: <20230511142535.732324-1-cgzones@googlemail.com>
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

Add the interfaces `capable_any()` and `ns_capable_any()` as an
alternative to multiple `capable()`/`ns_capable()` calls, like
`capable_any(CAP_SYS_NICE, CAP_SYS_ADMIN)` instead of
`capable(CAP_SYS_NICE) || capable(CAP_SYS_ADMIN)`.

`capable_any()`/`ns_capable_any()` will in particular generate exactly
one audit message, either for the left most capability in effect or, if
the task has none, the first one.

This is especially helpful with regard to SELinux, where each audit
message about a not allowed capability request will create a denial
message.  Using this new wrapper with the least invasive capability as
left most argument (e.g. CAP_SYS_NICE before CAP_SYS_ADMIN) enables
policy writers to only grant the least invasive one for the particular
subject instead of both.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v4:
   Use CAP_OPT_NODENYAUDIT via added ns_capable_nodenyaudit()
v3:
   - rename to capable_any()
   - fix typo in function documentation
   - add ns_capable_any()
v2:
   avoid varargs and fix to two capabilities; capable_or3() can be added
   later if needed
---
 include/linux/capability.h | 10 ++++++
 kernel/capability.c        | 70 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 80 insertions(+)

diff --git a/include/linux/capability.h b/include/linux/capability.h
index 0c356a517991..eeb958440656 100644
--- a/include/linux/capability.h
+++ b/include/linux/capability.h
@@ -146,7 +146,9 @@ extern bool has_capability_noaudit(struct task_struct *t, int cap);
 extern bool has_ns_capability_noaudit(struct task_struct *t,
 				      struct user_namespace *ns, int cap);
 extern bool capable(int cap);
+extern bool capable_any(int cap1, int cap2);
 extern bool ns_capable(struct user_namespace *ns, int cap);
+extern bool ns_capable_any(struct user_namespace *ns, int cap1, int cap2);
 extern bool ns_capable_noaudit(struct user_namespace *ns, int cap);
 extern bool ns_capable_setid(struct user_namespace *ns, int cap);
 #else
@@ -172,10 +174,18 @@ static inline bool capable(int cap)
 {
 	return true;
 }
+static inline bool capable_any(int cap1, int cap2)
+{
+	return true;
+}
 static inline bool ns_capable(struct user_namespace *ns, int cap)
 {
 	return true;
 }
+static inline bool ns_capable_any(struct user_namespace *ns, int cap1, int cap2)
+{
+	return true;
+}
 static inline bool ns_capable_noaudit(struct user_namespace *ns, int cap)
 {
 	return true;
diff --git a/kernel/capability.c b/kernel/capability.c
index 3e058f41df32..d50544063920 100644
--- a/kernel/capability.c
+++ b/kernel/capability.c
@@ -402,6 +402,23 @@ bool ns_capable_noaudit(struct user_namespace *ns, int cap)
 }
 EXPORT_SYMBOL(ns_capable_noaudit);
 
+/**
+ * ns_capable_nodenyaudit - Determine if the current task has a superior capability
+ * (unaudited when not authorized) in effect
+ * @ns:  The usernamespace we want the capability in
+ * @cap: The capability to be tested for
+ *
+ * Return true if the current task has the given superior capability currently
+ * available for use, false if not.
+ *
+ * This sets PF_SUPERPRIV on the task if the capability is available on the
+ * assumption that it's about to be used.
+ */
+static bool ns_capable_nodenyaudit(struct user_namespace *ns, int cap)
+{
+	return ns_capable_common(ns, cap, CAP_OPT_NODENYAUDIT);
+}
+
 /**
  * ns_capable_setid - Determine if the current task has a superior capability
  * in effect, while signalling that this check is being done from within a
@@ -421,6 +438,59 @@ bool ns_capable_setid(struct user_namespace *ns, int cap)
 }
 EXPORT_SYMBOL(ns_capable_setid);
 
+/**
+ * ns_capable_any - Determine if the current task has one of two superior capabilities in effect
+ * @ns:  The usernamespace we want the capability in
+ * @cap1: The capabilities to be tested for first
+ * @cap2: The capabilities to be tested for secondly
+ *
+ * Return true if the current task has at least one of the two given superior
+ * capabilities currently available for use, false if not.
+ *
+ * In contrast to or'ing capable() this call will create exactly one audit
+ * message, either for @cap1, if it is granted or both are not permitted,
+ * or @cap2, if it is granted while the other one is not.
+ *
+ * The capabilities should be ordered from least to most invasive, i.e. CAP_SYS_ADMIN last.
+ *
+ * This sets PF_SUPERPRIV on the task if the capability is available on the
+ * assumption that it's about to be used.
+ */
+bool ns_capable_any(struct user_namespace *ns, int cap1, int cap2)
+{
+	if (ns_capable_nodenyaudit(ns, cap1))
+		return true;
+
+	if (ns_capable_nodenyaudit(ns, cap2))
+		return true;
+
+	return ns_capable(ns, cap1);
+}
+EXPORT_SYMBOL(ns_capable_any);
+
+/**
+ * capable_any - Determine if the current task has one of two superior capabilities in effect
+ * @cap1: The capabilities to be tested for first
+ * @cap2: The capabilities to be tested for secondly
+ *
+ * Return true if the current task has at least one of the two given superior
+ * capabilities currently available for use, false if not.
+ *
+ * In contrast to or'ing capable() this call will create exactly one audit
+ * message, either for @cap1, if it is granted or both are not permitted,
+ * or @cap2, if it is granted while the other one is not.
+ *
+ * The capabilities should be ordered from least to most invasive, i.e. CAP_SYS_ADMIN last.
+ *
+ * This sets PF_SUPERPRIV on the task if the capability is available on the
+ * assumption that it's about to be used.
+ */
+bool capable_any(int cap1, int cap2)
+{
+	return ns_capable_any(&init_user_ns, cap1, cap2);
+}
+EXPORT_SYMBOL(capable_any);
+
 /**
  * capable - Determine if the current task has a superior capability in effect
  * @cap: The capability to be tested for
-- 
2.40.1


