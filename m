Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24BEC2A7405
	for <lists+bpf@lfdr.de>; Thu,  5 Nov 2020 01:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387863AbgKEAwB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Nov 2020 19:52:01 -0500
Received: from sonic305-28.consmr.mail.ne1.yahoo.com ([66.163.185.154]:40523
        "EHLO sonic305-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387843AbgKEAwA (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 4 Nov 2020 19:52:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1604537517; bh=Qo1Gfl7M/gEtL7nMaHAd4NMxP4V8Uuw/OZ3CtHIgtCI=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=mFBxHsmk1vID+ioQGDfHX7lFwHvngyQtQluXaZhLpqxmsCQWAstLQJckJpRn6pi/6tbS033cn/mEUAKVTLyOvT3eQ7KdfT9s1tilDhxPeFHqMJ6trOmft4ClzodvB1fzO11bxPTB9rdok465E39ReMXiq1faPGx/rtBsO4O95vY3/i4RsdcoFF3oCkGEY9atSVswMDWzpHdqj1w+qyxpgGwSbF8MvqDHzyXdes8p1ZuRfbQzYxagEeHhZf0WRcd5klWM/dFk/rl3coSf+G9SMeqn9I/aR95EcIHt7SExvXuWu04NDGX5jaa1jzdx80mCDr9ilEUb7j2BGAKtFcanmg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1604537517; bh=Rf7+smlUAsKrGIJGmQuBaowT6zrVYB9pKp+tXGvMAsa=; h=From:To:Subject:Date; b=t2+wgxY5ffzQMA7Jw/vLk5kWRxsvErTOAxCM9HOG/uW5bPC0BTPhGqkOTfirGBPhhxdjmHMiL0zIn5Zx2rQGsLs1xWV/fZCuidwJzNoA2OZGpHstTfBXzztElwQsUAXncu0Y8P4QIazZOQjVZfuQ+zylFuuCGxlrIZnheN0T3raVQgwTg/ckuwA5XMCOSxUythDAHuVkqKjI+Z8xd1ehCK5lLtESZ33BVzVB+xl8DXjsjGQqzYjwUP80AHD5OaO1KuVl4GJgtgA/gdcMxFSG6Ub529FoSgMgWcvfqKYfPBPrAMfh0w5T9uKd8W5M55cUUCZTxh1VyF85rYbjiWjEMw==
X-YMail-OSG: qo4IqgUVM1mJ0KqLrA7Qo52.g0PtsNsK6W5VNZkqj.1g0WfoQNo.cia1ip.X3ie
 3utIzmsdOyWLICw5vtV3mlnuSZXXol8qqHG3208qzXp86TL3.OpmJA4jy3QYe2z2LtOnSR7sO5ui
 QaJhPhTho8uGwT8IoyZEkiiuHxtvwHXztnuvassa1Wkbealm4IZnv92PDtFx65i.pvTUbZpAA0aS
 hxywYyPYgHAnoOs7rMMyqpDwky0a0hvcpRWbKh1s4w8dHdNuWKCWb9wTZ2OvdVkKyUGN3NNI2Mqr
 gOGzpYFrvmCDzS.aEkYrnfM.L6VwQ06257ckAsqRlpNXbmerE51BpEtaTNm22OJ5sxhLyZpwh0ti
 SgTGoYwEAOcBJmQB2NkGxxp73t1B5MGRKT7yc9nKi1zzUVBPrSLUD5svJLcPoA64_F5akzeXxTVf
 0n0NthCw61j3KhgD84yBlOojxs8Vs1s23QDOr_EyfaGEq13IxvIPjV41julwxl30tDmmDuqKPr1H
 Mt9tOvozF_kbqyJ7rlHBNWZZiawP9FfpgZhX4k4J9XVjhq1eshhzPIBddwBDXKalh46d9jbeZXnt
 vHPlGL_icM8U52rZxX2W6AB2liop2p7Wcxk4kd_NlokxvqOT4TtR4qDtiDFbuyJbpn3jiKHXoVRd
 36CWe8jpyCZlg_qv.1SC2ydu2tesOdWE_Y7TNghFmg8Uq6kCAXD4QFaY4PtOIbNWOzcjI8PaQ09Y
 3TiJQDrH9ElsecbgGSLyEv0wFU3fiyM0BMMdmybTzDoCRAydYdwKXD1Ga8hxBoiUX1IZ.JVpxvML
 pnd4A3Yt7deK_KVZ_vwW9cA26ZR20fpeYsfbXeop42B3jL6NWuumxuXU6nVMNbsNjYZZMJc65xpt
 bULNkVuh3ALKhOFZroR.98Ozeiw0TTVoalyIuzX5VYfBZWx6kXDyLJDP3fHKT7yxEXXnWTEuU76X
 ieUAi95M3VZZApFu90ij9r5_WVIRdN01kfqUwjjIJ2SCwZgUsoK6issan1SDNRx2MmzSTSk45u0A
 sC5_OmCouw2oe6DBKoUTAqEj3yTGzS6pLAPhgC7wPD6rPwqYfTR8Ut6z2DclNNFDbSlPS5FcTFBu
 nlSdVpPwYUjU3JSo5knRFPiLsXUeZITu87WCi54BTIzUwcg3ORaBaY5NF3xVVgsnwyaplZ8xvIkd
 jNX.v7vadAPWBtLHuNBNIIswz_WIhzfnA5CI4M16oZfnt4EcB.Lv.Jo4S6tpUfx5dlO6Ptv_ngqD
 kVnZ8rPj..qzykkSmFc5UQg_LAT5lbv1FDpJKvwjadF88OX03VRpSHge6IsbSLDyClBVSFuRACyT
 JqmVRy9buT72LBvyWRiV73YmL2a1dLdFqQBq3BfX02a_Y.K_WHLhGAauare_uMVpQkWzDBmfvvpy
 EdgqQqNSJEfSJ.xXSs4csaafsu6zmEJKu5zS4iUFONOJQS_f.Ck75jHSD8iJ8ODKqYAAQxIGZHVZ
 yTW0Kf3zLBkG4odBqGZtDFIIljotFuMUoHWoGMBR.dOuBZqdmfCClASLy6gpOuSPNGp8.Ptw5KPP
 JzTN_w6avl9EDmzsVm19ntsilTh4RGXspSJrRRZ725jLkRbHNo.S_dlcLyWAER_V4K2Dn7INjjsq
 ToTWql5lXu45BWyhwQRTpVc4nPTEHgdB_4X2TsYznbV4T8.wi1k.OfH0Rtj7UbyUiX0_NL0baWLQ
 D1tG7g8wNNrxEbrS6TSKg7H0a9ge3MiCCWoYcUyllm.M.3cI1.y1UtjxgTZHPRFUoQXOosCMZdij
 jXJElUUh1UCJcOuLxfKicbY8i3W91STg5TV9r.biOnQHdwak6QbfzCqnLUliSot17YyZYF0iPM34
 AIG32sQGGPbuLozEAMzhJiDAW6Rbh682_lTJOdUYo3R507HdC2pOaHRCJYTC51Qqddc6jt7zZ8gl
 OMDn_Q.qI0wXEYtYT19J4cxQrKAoqHpmH42Sbdoxzg_iHmaF8MxH5TuSVxDjYUDih9PmwRnJcHS1
 qA54MiMwtI.ssnbNSZmQiLVUAII5Qq.5dxJ3nqdYDEvuk4vubbm5Rbzhq0fzq8Yqdkpy.o8DVPuL
 tfr.pgzX6z2qhLdKs6yZ2.xQZfqOkxH.evXUs.HYsCdJ3jBBl3w8mqj2KJm2wbaoaabwVIvDqFsn
 P4Bz7sA8mPZR.6t57ZgTtfo2P2hvKHqZQcuRpf_c1wq7lwTYFqLKnDKf3fmUm0C4i3eNeRwO08nj
 K4QBuneJF8o13.qnY_2IevgY078YOXtpiphMrMNZIzEIoGhRf8VEr3d.ErGhFGHr_EdmS23Yj4S_
 4QJHoqksPWyn2pxuEMmdRZmJYZS9K1biKWP0ICLYTEMvcA91TLOlKJG7.FdW8zqoLCLsXOBbtQmw
 mEX6oFkVVEoA5iJItbdNbrOXnijfxozbDQMYH8zRz770shF_OAewukg3n185hJAzNs4D4nm1ELEo
 aeYiPdjCi582beD0dbGu_UDo2_CPLT3.Sb0a4iVh3kERmtH2oUU1cYbrD1reWNf9rEpjUv0ayH90
 Y8TJEtF3RtJPkhoBp2YLdKDX61e27L2BVE7m22MAFEbBw2WPfeYjeQC3nD0iJf3GV8Qdw0aaFexD
 y_9KxCQs.jqTMAcvRDs8vwVQBxaLex3aqXW4y5mzpWbp8wM.kzzzNikb37IZPux3xzyOa19zJreC
 BE_YcVK.nuIxVXPxyyFpGdMdPkd.uLByxJ_95XzOHKemsTreQkEKSkxK7ChiilCb_iiPUg_.urkG
 Z5hPsgA_AE.9uEAcSdP1cform8WErBFlZSB2rGT3ZUJGIwGkYflgF3tS1kUke9HZLBU8nXPWCUEE
 Sz4hM8qYHEHVueVU4q0i4P8GljyBmmHXTV9GCZ9VWXHCxugCxgUhLAcBZ.13IjBemGREq8yw7WXA
 qo6Zn02.VaxjiuNq1N0y2dWUxsIKk9dUrYBZrjpRbih0jdkKzVpnleZykeVkPCpgkfbINODpWH._
 okr_GTOo0PHC1SrHyoNiuksvkzmOcvQJcTAsCXXYfqZ_mR4srIInw_vdazVMGNNekIAlcQdkovYP
 7ckFeahSpXfW1bzIp0X9QJxrEVCvUSSqjNHDOIzUZM5eKgoLlceQAOw.WKXPgKuJ.7Oc5ZR537Yr
 RxQp6WnaoK51Pr..aLqj4XUJQ_Vb2yX9mhy5W_KZMn7ehXZ5hxFYTrnRfvzHMDnQ6tmw9ccDrasZ
 wR5v8al27zs7Ir_F67o4iZbT0dlJ1p7ywwBcCa6DxYXQgQn4mBOi0Rs7dEFIctAr2ZPEqpVuuKUi
 kFpBS7P_DpqH_Syfzn17JhU9lJj1QkcCLSAi8sgA4uLCxKZOrALuUNhrg1HbcTaYdJxie9IixmJh
 UWCEHZDLFmVeJV0W7pRsDE2Y4XnjtW.Z5C_RhkFjYXMigpMkO0LWtjuq3OOskMM7oS.25czlZPc1
 Rfl18pZS4
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Thu, 5 Nov 2020 00:51:57 +0000
Received: by smtp421.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID b3fc0268bd2da9109c33fc0f65d30824;
          Thu, 05 Nov 2020 00:51:51 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH v22 02/23] LSM: Create and manage the lsmblob data structure.
Date:   Wed,  4 Nov 2020 16:49:03 -0800
Message-Id: <20201105004924.11651-3-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201105004924.11651-1-casey@schaufler-ca.com>
References: <20201105004924.11651-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When more than one security module is exporting data to
audit and networking sub-systems a single 32 bit integer
is no longer sufficient to represent the data. Add a
structure to be used instead.

The lsmblob structure is currently an array of
u32 "secids". There is an entry for each of the
security modules built into the system that would
use secids if active. The system assigns the module
a "slot" when it registers hooks. If modules are
compiled in but not registered there will be unused
slots.

A new lsm_id structure, which contains the name
of the LSM and its slot number, is created. There
is an instance for each LSM, which assigns the name
and passes it to the infrastructure to set the slot.

The audit rules data is expanded to use an array of
security module data rather than a single instance.
Because IMA uses the audit rule functions it is
affected as well.

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
Acked-by: Paul Moore <paul@paul-moore.com>
Acked-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Cc: <bpf@vger.kernel.org>
---
 include/linux/audit.h               |  4 +-
 include/linux/lsm_hooks.h           | 12 ++++-
 include/linux/security.h            | 67 +++++++++++++++++++++++++--
 kernel/auditfilter.c                | 24 +++++-----
 kernel/auditsc.c                    | 12 ++---
 security/apparmor/lsm.c             |  7 ++-
 security/bpf/hooks.c                | 12 ++++-
 security/commoncap.c                |  7 ++-
 security/integrity/ima/ima_policy.c | 40 +++++++++++-----
 security/loadpin/loadpin.c          |  8 +++-
 security/lockdown/lockdown.c        |  7 ++-
 security/safesetid/lsm.c            |  8 +++-
 security/security.c                 | 72 ++++++++++++++++++++++++-----
 security/selinux/hooks.c            |  8 +++-
 security/smack/smack_lsm.c          |  7 ++-
 security/tomoyo/tomoyo.c            |  8 +++-
 security/yama/yama_lsm.c            |  7 ++-
 17 files changed, 254 insertions(+), 56 deletions(-)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index b3d859831a31..ba1cd38d601b 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -11,6 +11,7 @@
 
 #include <linux/sched.h>
 #include <linux/ptrace.h>
+#include <linux/security.h>
 #include <uapi/linux/audit.h>
 #include <uapi/linux/netfilter/nf_tables.h>
 
@@ -65,8 +66,9 @@ struct audit_field {
 		kuid_t			uid;
 		kgid_t			gid;
 		struct {
+			bool		lsm_isset;
 			char		*lsm_str;
-			void		*lsm_rule;
+			void		*lsm_rules[LSMBLOB_ENTRIES];
 		};
 	};
 	u32				op;
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index d8f492ed6ebf..fe9203f15993 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1545,6 +1545,14 @@ struct security_hook_heads {
 	#undef LSM_HOOK
 } __randomize_layout;
 
+/*
+ * Information that identifies a security module.
+ */
+struct lsm_id {
+	const char	*lsm;	/* Name of the LSM */
+	int		slot;	/* Slot in lsmblob if one is allocated */
+};
+
 /*
  * Security module hook list structure.
  * For use with generic list macros for common operations.
@@ -1553,7 +1561,7 @@ struct security_hook_list {
 	struct hlist_node		list;
 	struct hlist_head		*head;
 	union security_list_options	hook;
-	char				*lsm;
+	struct lsm_id			*lsmid;
 } __randomize_layout;
 
 /*
@@ -1588,7 +1596,7 @@ extern struct security_hook_heads security_hook_heads;
 extern char *lsm_names;
 
 extern void security_add_hooks(struct security_hook_list *hooks, int count,
-				char *lsm);
+			       struct lsm_id *lsmid);
 
 #define LSM_FLAG_LEGACY_MAJOR	BIT(0)
 #define LSM_FLAG_EXCLUSIVE	BIT(1)
diff --git a/include/linux/security.h b/include/linux/security.h
index bc2725491560..fdb6e95c98e8 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -132,6 +132,65 @@ enum lockdown_reason {
 
 extern const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1];
 
+/*
+ * Data exported by the security modules
+ *
+ * Any LSM that provides secid or secctx based hooks must be included.
+ */
+#define LSMBLOB_ENTRIES ( \
+	(IS_ENABLED(CONFIG_SECURITY_SELINUX) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_SECURITY_SMACK) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_SECURITY_APPARMOR) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_BPF_LSM) ? 1 : 0))
+
+struct lsmblob {
+	u32     secid[LSMBLOB_ENTRIES];
+};
+
+#define LSMBLOB_INVALID		-1	/* Not a valid LSM slot number */
+#define LSMBLOB_NEEDED		-2	/* Slot requested on initialization */
+#define LSMBLOB_NOT_NEEDED	-3	/* Slot not requested */
+
+/**
+ * lsmblob_init - initialize an lsmblob structure.
+ * @blob: Pointer to the data to initialize
+ * @secid: The initial secid value
+ *
+ * Set all secid for all modules to the specified value.
+ */
+static inline void lsmblob_init(struct lsmblob *blob, u32 secid)
+{
+	int i;
+
+	for (i = 0; i < LSMBLOB_ENTRIES; i++)
+		blob->secid[i] = secid;
+}
+
+/**
+ * lsmblob_is_set - report if there is an value in the lsmblob
+ * @blob: Pointer to the exported LSM data
+ *
+ * Returns true if there is a secid set, false otherwise
+ */
+static inline bool lsmblob_is_set(struct lsmblob *blob)
+{
+	struct lsmblob empty = {};
+
+	return !!memcmp(blob, &empty, sizeof(*blob));
+}
+
+/**
+ * lsmblob_equal - report if the two lsmblob's are equal
+ * @bloba: Pointer to one LSM data
+ * @blobb: Pointer to the other LSM data
+ *
+ * Returns true if all entries in the two are equal, false otherwise
+ */
+static inline bool lsmblob_equal(struct lsmblob *bloba, struct lsmblob *blobb)
+{
+	return !memcmp(bloba, blobb, sizeof(*bloba));
+}
+
 /* These functions are in security/commoncap.c */
 extern int cap_capable(const struct cred *cred, struct user_namespace *ns,
 		       int cap, unsigned int opts);
@@ -1833,8 +1892,8 @@ static inline int security_key_getsecurity(struct key *key, char **_buffer)
 #ifdef CONFIG_SECURITY
 int security_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule);
 int security_audit_rule_known(struct audit_krule *krule);
-int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule);
-void security_audit_rule_free(void *lsmrule);
+int security_audit_rule_match(u32 secid, u32 field, u32 op, void **lsmrule);
+void security_audit_rule_free(void **lsmrule);
 
 #else
 
@@ -1850,12 +1909,12 @@ static inline int security_audit_rule_known(struct audit_krule *krule)
 }
 
 static inline int security_audit_rule_match(u32 secid, u32 field, u32 op,
-					    void *lsmrule)
+					    void **lsmrule)
 {
 	return 0;
 }
 
-static inline void security_audit_rule_free(void *lsmrule)
+static inline void security_audit_rule_free(void **lsmrule)
 { }
 
 #endif /* CONFIG_SECURITY */
diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index 333b3bcfc545..45da229f9f1f 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -74,7 +74,7 @@ static void audit_free_lsm_field(struct audit_field *f)
 	case AUDIT_OBJ_LEV_LOW:
 	case AUDIT_OBJ_LEV_HIGH:
 		kfree(f->lsm_str);
-		security_audit_rule_free(f->lsm_rule);
+		security_audit_rule_free(f->lsm_rules);
 	}
 }
 
@@ -519,9 +519,10 @@ static struct audit_entry *audit_data_to_entry(struct audit_rule_data *data,
 				goto exit_free;
 			}
 			entry->rule.buflen += f_val;
+			f->lsm_isset = true;
 			f->lsm_str = str;
 			err = security_audit_rule_init(f->type, f->op, str,
-						       (void **)&f->lsm_rule);
+						       f->lsm_rules);
 			/* Keep currently invalid fields around in case they
 			 * become valid after a policy reload. */
 			if (err == -EINVAL) {
@@ -774,7 +775,7 @@ static int audit_compare_rule(struct audit_krule *a, struct audit_krule *b)
 	return 0;
 }
 
-/* Duplicate LSM field information.  The lsm_rule is opaque, so must be
+/* Duplicate LSM field information.  The lsm_rules is opaque, so must be
  * re-initialized. */
 static inline int audit_dupe_lsm_field(struct audit_field *df,
 					   struct audit_field *sf)
@@ -788,9 +789,9 @@ static inline int audit_dupe_lsm_field(struct audit_field *df,
 		return -ENOMEM;
 	df->lsm_str = lsm_str;
 
-	/* our own (refreshed) copy of lsm_rule */
+	/* our own (refreshed) copy of lsm_rules */
 	ret = security_audit_rule_init(df->type, df->op, df->lsm_str,
-				       (void **)&df->lsm_rule);
+				       df->lsm_rules);
 	/* Keep currently invalid fields around in case they
 	 * become valid after a policy reload. */
 	if (ret == -EINVAL) {
@@ -842,7 +843,7 @@ struct audit_entry *audit_dupe_rule(struct audit_krule *old)
 	new->tree = old->tree;
 	memcpy(new->fields, old->fields, sizeof(struct audit_field) * fcount);
 
-	/* deep copy this information, updating the lsm_rule fields, because
+	/* deep copy this information, updating the lsm_rules fields, because
 	 * the originals will all be freed when the old rule is freed. */
 	for (i = 0; i < fcount; i++) {
 		switch (new->fields[i].type) {
@@ -1358,10 +1359,11 @@ int audit_filter(int msgtype, unsigned int listtype)
 			case AUDIT_SUBJ_TYPE:
 			case AUDIT_SUBJ_SEN:
 			case AUDIT_SUBJ_CLR:
-				if (f->lsm_rule) {
+				if (f->lsm_isset) {
 					security_task_getsecid(current, &sid);
 					result = security_audit_rule_match(sid,
-						   f->type, f->op, f->lsm_rule);
+						   f->type, f->op,
+						   f->lsm_rules);
 				}
 				break;
 			case AUDIT_EXE:
@@ -1388,7 +1390,7 @@ int audit_filter(int msgtype, unsigned int listtype)
 	return ret;
 }
 
-static int update_lsm_rule(struct audit_krule *r)
+static int update_lsm_rules(struct audit_krule *r)
 {
 	struct audit_entry *entry = container_of(r, struct audit_entry, rule);
 	struct audit_entry *nentry;
@@ -1420,7 +1422,7 @@ static int update_lsm_rule(struct audit_krule *r)
 	return err;
 }
 
-/* This function will re-initialize the lsm_rule field of all applicable rules.
+/* This function will re-initialize the lsm_rules field of all applicable rules.
  * It will traverse the filter lists serarching for rules that contain LSM
  * specific filter fields.  When such a rule is found, it is copied, the
  * LSM field is re-initialized, and the old rule is replaced with the
@@ -1435,7 +1437,7 @@ int audit_update_lsm_rules(void)
 
 	for (i = 0; i < AUDIT_NR_FILTERS; i++) {
 		list_for_each_entry_safe(r, n, &audit_rules_list[i], list) {
-			int res = update_lsm_rule(r);
+			int res = update_lsm_rules(r);
 			if (!err)
 				err = res;
 		}
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 8dba8f0983b5..16e3430f7d07 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -667,14 +667,14 @@ static int audit_filter_rules(struct task_struct *tsk,
 			   match for now to avoid losing information that
 			   may be wanted.   An error message will also be
 			   logged upon error */
-			if (f->lsm_rule) {
+			if (f->lsm_isset) {
 				if (need_sid) {
 					security_task_getsecid(tsk, &sid);
 					need_sid = 0;
 				}
 				result = security_audit_rule_match(sid, f->type,
 								   f->op,
-								   f->lsm_rule);
+								   f->lsm_rules);
 			}
 			break;
 		case AUDIT_OBJ_USER:
@@ -684,21 +684,21 @@ static int audit_filter_rules(struct task_struct *tsk,
 		case AUDIT_OBJ_LEV_HIGH:
 			/* The above note for AUDIT_SUBJ_USER...AUDIT_SUBJ_CLR
 			   also applies here */
-			if (f->lsm_rule) {
+			if (f->lsm_isset) {
 				/* Find files that match */
 				if (name) {
 					result = security_audit_rule_match(
 								name->osid,
 								f->type,
 								f->op,
-								f->lsm_rule);
+								f->lsm_rules);
 				} else if (ctx) {
 					list_for_each_entry(n, &ctx->names_list, list) {
 						if (security_audit_rule_match(
 								n->osid,
 								f->type,
 								f->op,
-								f->lsm_rule)) {
+								f->lsm_rules)) {
 							++result;
 							break;
 						}
@@ -709,7 +709,7 @@ static int audit_filter_rules(struct task_struct *tsk,
 					break;
 				if (security_audit_rule_match(ctx->ipc.osid,
 							      f->type, f->op,
-							      f->lsm_rule))
+							      f->lsm_rules))
 					++result;
 			}
 			break;
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index f1c365905d5e..432915c1d427 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1152,6 +1152,11 @@ struct lsm_blob_sizes apparmor_blob_sizes __lsm_ro_after_init = {
 	.lbs_sock = sizeof(struct aa_sk_ctx),
 };
 
+static struct lsm_id apparmor_lsmid __lsm_ro_after_init = {
+	.lsm  = "apparmor",
+	.slot = LSMBLOB_NEEDED
+};
+
 static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(ptrace_access_check, apparmor_ptrace_access_check),
 	LSM_HOOK_INIT(ptrace_traceme, apparmor_ptrace_traceme),
@@ -1852,7 +1857,7 @@ static int __init apparmor_init(void)
 		goto buffers_out;
 	}
 	security_add_hooks(apparmor_hooks, ARRAY_SIZE(apparmor_hooks),
-				"apparmor");
+				&apparmor_lsmid);
 
 	/* Report that AppArmor successfully initialized */
 	apparmor_initialized = 1;
diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
index 788667d582ae..a1a5032a4d87 100644
--- a/security/bpf/hooks.c
+++ b/security/bpf/hooks.c
@@ -14,9 +14,19 @@ static struct security_hook_list bpf_lsm_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(inode_free_security, bpf_inode_storage_free),
 };
 
+/*
+ * slot has to be LSMBLOB_NEEDED because some of the hooks
+ * supplied by this module require a slot.
+ */
+struct lsm_id bpf_lsmid __lsm_ro_after_init = {
+	.lsm = "bpf",
+	.slot = LSMBLOB_NEEDED
+};
+
 static int __init bpf_lsm_init(void)
 {
-	security_add_hooks(bpf_lsm_hooks, ARRAY_SIZE(bpf_lsm_hooks), "bpf");
+	security_add_hooks(bpf_lsm_hooks, ARRAY_SIZE(bpf_lsm_hooks),
+			   &bpf_lsmid);
 	pr_info("LSM support for eBPF active\n");
 	return 0;
 }
diff --git a/security/commoncap.c b/security/commoncap.c
index 59bf3c1674c8..959a9f96b7f1 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -1341,6 +1341,11 @@ int cap_mmap_file(struct file *file, unsigned long reqprot,
 
 #ifdef CONFIG_SECURITY
 
+static struct lsm_id capability_lsmid __lsm_ro_after_init = {
+	.lsm  = "capability",
+	.slot = LSMBLOB_NOT_NEEDED
+};
+
 static struct security_hook_list capability_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(capable, cap_capable),
 	LSM_HOOK_INIT(settime, cap_settime),
@@ -1365,7 +1370,7 @@ static struct security_hook_list capability_hooks[] __lsm_ro_after_init = {
 static int __init capability_init(void)
 {
 	security_add_hooks(capability_hooks, ARRAY_SIZE(capability_hooks),
-				"capability");
+			   &capability_lsmid);
 	return 0;
 }
 
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 9b5adeaa47fc..cd393aaa17d5 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -79,7 +79,7 @@ struct ima_rule_entry {
 	bool (*fowner_op)(kuid_t, kuid_t); /* uid_eq(), uid_gt(), uid_lt() */
 	int pcr;
 	struct {
-		void *rule;	/* LSM file metadata specific */
+		void *rules[LSMBLOB_ENTRIES]; /* LSM file metadata specific */
 		char *args_p;	/* audit value */
 		int type;	/* audit type */
 	} lsm[MAX_LSM_RULES];
@@ -88,6 +88,22 @@ struct ima_rule_entry {
 	struct ima_template_desc *template;
 };
 
+/**
+ * ima_lsm_isset - Is a rule set for any of the active security modules
+ * @rules: The set of IMA rules to check.
+ *
+ * If a rule is set for any LSM return true, otherwise return false.
+ */
+static inline bool ima_lsm_isset(void *rules[])
+{
+	int i;
+
+	for (i = 0; i < LSMBLOB_ENTRIES; i++)
+		if (rules[i])
+			return true;
+	return false;
+}
+
 /*
  * Without LSM specific knowledge, the default policy can only be
  * written in terms of .action, .func, .mask, .fsmagic, .uid, and .fowner
@@ -326,9 +342,11 @@ static void ima_free_rule_opt_list(struct ima_rule_opt_list *opt_list)
 static void ima_lsm_free_rule(struct ima_rule_entry *entry)
 {
 	int i;
+	int r;
 
 	for (i = 0; i < MAX_LSM_RULES; i++) {
-		ima_filter_rule_free(entry->lsm[i].rule);
+		for (r = 0; r < LSMBLOB_ENTRIES; r++)
+			ima_filter_rule_free(entry->lsm[i].rules[r]);
 		kfree(entry->lsm[i].args_p);
 	}
 }
@@ -379,8 +397,8 @@ static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
 
 		ima_filter_rule_init(nentry->lsm[i].type, Audit_equal,
 				     nentry->lsm[i].args_p,
-				     &nentry->lsm[i].rule);
-		if (!nentry->lsm[i].rule)
+				     &nentry->lsm[i].rules[0]);
+		if (!ima_lsm_isset(nentry->lsm[i].rules))
 			pr_warn("rule for LSM \'%s\' is undefined\n",
 				nentry->lsm[i].args_p);
 	}
@@ -545,7 +563,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 		int rc = 0;
 		u32 osid;
 
-		if (!rule->lsm[i].rule) {
+		if (!ima_lsm_isset(rule->lsm[i].rules)) {
 			if (!rule->lsm[i].args_p)
 				continue;
 			else
@@ -558,14 +576,14 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 			security_inode_getsecid(inode, &osid);
 			rc = ima_filter_rule_match(osid, rule->lsm[i].type,
 						   Audit_equal,
-						   rule->lsm[i].rule);
+						   rule->lsm[i].rules);
 			break;
 		case LSM_SUBJ_USER:
 		case LSM_SUBJ_ROLE:
 		case LSM_SUBJ_TYPE:
 			rc = ima_filter_rule_match(secid, rule->lsm[i].type,
 						   Audit_equal,
-						   rule->lsm[i].rule);
+						   rule->lsm[i].rules);
 		default:
 			break;
 		}
@@ -952,7 +970,7 @@ static int ima_lsm_rule_init(struct ima_rule_entry *entry,
 {
 	int result;
 
-	if (entry->lsm[lsm_rule].rule)
+	if (ima_lsm_isset(entry->lsm[lsm_rule].rules))
 		return -EINVAL;
 
 	entry->lsm[lsm_rule].args_p = match_strdup(args);
@@ -962,8 +980,8 @@ static int ima_lsm_rule_init(struct ima_rule_entry *entry,
 	entry->lsm[lsm_rule].type = audit_type;
 	result = ima_filter_rule_init(entry->lsm[lsm_rule].type, Audit_equal,
 				      entry->lsm[lsm_rule].args_p,
-				      &entry->lsm[lsm_rule].rule);
-	if (!entry->lsm[lsm_rule].rule) {
+				      &entry->lsm[lsm_rule].rules[0]);
+	if (!ima_lsm_isset(entry->lsm[lsm_rule].rules)) {
 		pr_warn("rule for LSM \'%s\' is undefined\n",
 			entry->lsm[lsm_rule].args_p);
 
@@ -1733,7 +1751,7 @@ int ima_policy_show(struct seq_file *m, void *v)
 	}
 
 	for (i = 0; i < MAX_LSM_RULES; i++) {
-		if (entry->lsm[i].rule) {
+		if (ima_lsm_isset(entry->lsm[i].rules)) {
 			switch (i) {
 			case LSM_OBJ_USER:
 				seq_printf(m, pt(Opt_obj_user),
diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
index b12f7d986b1e..b569f3bc170b 100644
--- a/security/loadpin/loadpin.c
+++ b/security/loadpin/loadpin.c
@@ -192,6 +192,11 @@ static int loadpin_load_data(enum kernel_load_data_id id, bool contents)
 	return loadpin_read_file(NULL, (enum kernel_read_file_id) id, contents);
 }
 
+static struct lsm_id loadpin_lsmid __lsm_ro_after_init = {
+	.lsm  = "loadpin",
+	.slot = LSMBLOB_NOT_NEEDED
+};
+
 static struct security_hook_list loadpin_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(sb_free_security, loadpin_sb_free_security),
 	LSM_HOOK_INIT(kernel_read_file, loadpin_read_file),
@@ -239,7 +244,8 @@ static int __init loadpin_init(void)
 	pr_info("ready to pin (currently %senforcing)\n",
 		enforce ? "" : "not ");
 	parse_exclude();
-	security_add_hooks(loadpin_hooks, ARRAY_SIZE(loadpin_hooks), "loadpin");
+	security_add_hooks(loadpin_hooks, ARRAY_SIZE(loadpin_hooks),
+			   &loadpin_lsmid);
 	return 0;
 }
 
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 87cbdc64d272..4e24ea3f7b7e 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -75,6 +75,11 @@ static struct security_hook_list lockdown_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(locked_down, lockdown_is_locked_down),
 };
 
+static struct lsm_id lockdown_lsmid __lsm_ro_after_init = {
+	.lsm = "lockdown",
+	.slot = LSMBLOB_NOT_NEEDED
+};
+
 static int __init lockdown_lsm_init(void)
 {
 #if defined(CONFIG_LOCK_DOWN_KERNEL_FORCE_INTEGRITY)
@@ -83,7 +88,7 @@ static int __init lockdown_lsm_init(void)
 	lock_kernel_down("Kernel configuration", LOCKDOWN_CONFIDENTIALITY_MAX);
 #endif
 	security_add_hooks(lockdown_hooks, ARRAY_SIZE(lockdown_hooks),
-			   "lockdown");
+			   &lockdown_lsmid);
 	return 0;
 }
 
diff --git a/security/safesetid/lsm.c b/security/safesetid/lsm.c
index 8a176b6adbe5..7c7ac9bfe5cd 100644
--- a/security/safesetid/lsm.c
+++ b/security/safesetid/lsm.c
@@ -244,6 +244,11 @@ static int safesetid_task_fix_setgid(struct cred *new,
 	return -EACCES;
 }
 
+static struct lsm_id safesetid_lsmid __lsm_ro_after_init = {
+	.lsm  = "safesetid",
+	.slot = LSMBLOB_NOT_NEEDED
+};
+
 static struct security_hook_list safesetid_security_hooks[] = {
 	LSM_HOOK_INIT(task_fix_setuid, safesetid_task_fix_setuid),
 	LSM_HOOK_INIT(task_fix_setgid, safesetid_task_fix_setgid),
@@ -253,7 +258,8 @@ static struct security_hook_list safesetid_security_hooks[] = {
 static int __init safesetid_security_init(void)
 {
 	security_add_hooks(safesetid_security_hooks,
-			   ARRAY_SIZE(safesetid_security_hooks), "safesetid");
+			   ARRAY_SIZE(safesetid_security_hooks),
+			   &safesetid_lsmid);
 
 	/* Report that SafeSetID successfully initialized */
 	safesetid_initialized = 1;
diff --git a/security/security.c b/security/security.c
index 5da8b3643680..d01363cb0082 100644
--- a/security/security.c
+++ b/security/security.c
@@ -341,6 +341,7 @@ static void __init ordered_lsm_init(void)
 	init_debug("msg_msg blob size  = %d\n", blob_sizes.lbs_msg_msg);
 	init_debug("sock blob size     = %d\n", blob_sizes.lbs_sock);
 	init_debug("task blob size     = %d\n", blob_sizes.lbs_task);
+	init_debug("lsmblob size       = %zu\n", sizeof(struct lsmblob));
 
 	/*
 	 * Create any kmem_caches needed for blobs
@@ -468,21 +469,36 @@ static int lsm_append(const char *new, char **result)
 	return 0;
 }
 
+/*
+ * Current index to use while initializing the lsmblob secid list.
+ */
+static int lsm_slot __lsm_ro_after_init;
+
 /**
  * security_add_hooks - Add a modules hooks to the hook lists.
  * @hooks: the hooks to add
  * @count: the number of hooks to add
- * @lsm: the name of the security module
+ * @lsmid: the the identification information for the security module
  *
  * Each LSM has to register its hooks with the infrastructure.
+ * If the LSM is using hooks that export secids allocate a slot
+ * for it in the lsmblob.
  */
 void __init security_add_hooks(struct security_hook_list *hooks, int count,
-				char *lsm)
+			       struct lsm_id *lsmid)
 {
 	int i;
 
+	if (lsmid->slot == LSMBLOB_NEEDED) {
+		if (lsm_slot >= LSMBLOB_ENTRIES)
+			panic("%s Too many LSMs registered.\n", __func__);
+		lsmid->slot = lsm_slot++;
+		init_debug("%s assigned lsmblob slot %d\n", lsmid->lsm,
+			   lsmid->slot);
+	}
+
 	for (i = 0; i < count; i++) {
-		hooks[i].lsm = lsm;
+		hooks[i].lsmid = lsmid;
 		hlist_add_tail_rcu(&hooks[i].list, hooks[i].head);
 	}
 
@@ -491,7 +507,7 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
 	 * and fix this up afterwards.
 	 */
 	if (slab_is_available()) {
-		if (lsm_append(lsm, &lsm_names) < 0)
+		if (lsm_append(lsmid->lsm, &lsm_names) < 0)
 			panic("%s - Cannot get early memory.\n", __func__);
 	}
 }
@@ -2005,7 +2021,7 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
 	struct security_hook_list *hp;
 
 	hlist_for_each_entry(hp, &security_hook_heads.getprocattr, list) {
-		if (lsm != NULL && strcmp(lsm, hp->lsm))
+		if (lsm != NULL && strcmp(lsm, hp->lsmid->lsm))
 			continue;
 		return hp->hook.getprocattr(p, name, value);
 	}
@@ -2018,7 +2034,7 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
 	struct security_hook_list *hp;
 
 	hlist_for_each_entry(hp, &security_hook_heads.setprocattr, list) {
-		if (lsm != NULL && strcmp(lsm, hp->lsm))
+		if (lsm != NULL && strcmp(lsm, hp->lsmid->lsm))
 			continue;
 		return hp->hook.setprocattr(name, value, size);
 	}
@@ -2510,7 +2526,24 @@ int security_key_getsecurity(struct key *key, char **_buffer)
 
 int security_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule)
 {
-	return call_int_hook(audit_rule_init, 0, field, op, rulestr, lsmrule);
+	struct security_hook_list *hp;
+	bool one_is_good = false;
+	int rc = 0;
+	int trc;
+
+	hlist_for_each_entry(hp, &security_hook_heads.audit_rule_init, list) {
+		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
+			continue;
+		trc = hp->hook.audit_rule_init(field, op, rulestr,
+					       &lsmrule[hp->lsmid->slot]);
+		if (trc == 0)
+			one_is_good = true;
+		else
+			rc = trc;
+	}
+	if (one_is_good)
+		return 0;
+	return rc;
 }
 
 int security_audit_rule_known(struct audit_krule *krule)
@@ -2518,14 +2551,31 @@ int security_audit_rule_known(struct audit_krule *krule)
 	return call_int_hook(audit_rule_known, 0, krule);
 }
 
-void security_audit_rule_free(void *lsmrule)
+void security_audit_rule_free(void **lsmrule)
 {
-	call_void_hook(audit_rule_free, lsmrule);
+	struct security_hook_list *hp;
+
+	hlist_for_each_entry(hp, &security_hook_heads.audit_rule_free, list) {
+		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
+			continue;
+		hp->hook.audit_rule_free(lsmrule[hp->lsmid->slot]);
+	}
 }
 
-int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule)
+int security_audit_rule_match(u32 secid, u32 field, u32 op, void **lsmrule)
 {
-	return call_int_hook(audit_rule_match, 0, secid, field, op, lsmrule);
+	struct security_hook_list *hp;
+	int rc;
+
+	hlist_for_each_entry(hp, &security_hook_heads.audit_rule_match, list) {
+		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
+			continue;
+		rc = hp->hook.audit_rule_match(secid, field, op,
+					       &lsmrule[hp->lsmid->slot]);
+		if (rc)
+			return rc;
+	}
+	return 0;
 }
 #endif /* CONFIG_AUDIT */
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 2748281a5cca..52a50d7ca534 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6933,6 +6933,11 @@ static int selinux_perf_event_write(struct perf_event *event)
 }
 #endif
 
+static struct lsm_id selinux_lsmid __lsm_ro_after_init = {
+	.lsm  = "selinux",
+	.slot = LSMBLOB_NEEDED
+};
+
 /*
  * IMPORTANT NOTE: When adding new hooks, please be careful to keep this order:
  * 1. any hooks that don't belong to (2.) or (3.) below,
@@ -7244,7 +7249,8 @@ static __init int selinux_init(void)
 
 	hashtab_cache_init();
 
-	security_add_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks), "selinux");
+	security_add_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks),
+			   &selinux_lsmid);
 
 	if (avc_add_callback(selinux_netcache_avc_callback, AVC_CALLBACK_RESET))
 		panic("SELinux: Unable to register AVC netcache callback\n");
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index ca4a6c862732..f96be93d1a75 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4693,6 +4693,11 @@ struct lsm_blob_sizes smack_blob_sizes __lsm_ro_after_init = {
 	.lbs_sock = sizeof(struct socket_smack),
 };
 
+static struct lsm_id smack_lsmid __lsm_ro_after_init = {
+	.lsm  = "smack",
+	.slot = LSMBLOB_NEEDED
+};
+
 static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(ptrace_access_check, smack_ptrace_access_check),
 	LSM_HOOK_INIT(ptrace_traceme, smack_ptrace_traceme),
@@ -4892,7 +4897,7 @@ static __init int smack_init(void)
 	/*
 	 * Register with LSM
 	 */
-	security_add_hooks(smack_hooks, ARRAY_SIZE(smack_hooks), "smack");
+	security_add_hooks(smack_hooks, ARRAY_SIZE(smack_hooks), &smack_lsmid);
 	smack_enabled = 1;
 
 	pr_info("Smack:  Initializing.\n");
diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index 1f3cd432d830..22f62c67f2ec 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -523,6 +523,11 @@ static void tomoyo_task_free(struct task_struct *task)
 	}
 }
 
+static struct lsm_id tomoyo_lsmid __lsm_ro_after_init = {
+	.lsm  = "tomoyo",
+	.slot = LSMBLOB_NOT_NEEDED
+};
+
 /*
  * tomoyo_security_ops is a "struct security_operations" which is used for
  * registering TOMOYO.
@@ -575,7 +580,8 @@ static int __init tomoyo_init(void)
 	struct tomoyo_task *s = tomoyo_task(current);
 
 	/* register ourselves with the security framework */
-	security_add_hooks(tomoyo_hooks, ARRAY_SIZE(tomoyo_hooks), "tomoyo");
+	security_add_hooks(tomoyo_hooks, ARRAY_SIZE(tomoyo_hooks),
+			   &tomoyo_lsmid);
 	pr_info("TOMOYO Linux initialized\n");
 	s->domain_info = &tomoyo_kernel_domain;
 	atomic_inc(&tomoyo_kernel_domain.users);
diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
index 06e226166aab..a9639ea541f7 100644
--- a/security/yama/yama_lsm.c
+++ b/security/yama/yama_lsm.c
@@ -421,6 +421,11 @@ static int yama_ptrace_traceme(struct task_struct *parent)
 	return rc;
 }
 
+static struct lsm_id yama_lsmid __lsm_ro_after_init = {
+	.lsm  = "yama",
+	.slot = LSMBLOB_NOT_NEEDED
+};
+
 static struct security_hook_list yama_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(ptrace_access_check, yama_ptrace_access_check),
 	LSM_HOOK_INIT(ptrace_traceme, yama_ptrace_traceme),
@@ -477,7 +482,7 @@ static inline void yama_init_sysctl(void) { }
 static int __init yama_init(void)
 {
 	pr_info("Yama: becoming mindful.\n");
-	security_add_hooks(yama_hooks, ARRAY_SIZE(yama_hooks), "yama");
+	security_add_hooks(yama_hooks, ARRAY_SIZE(yama_hooks), &yama_lsmid);
 	yama_init_sysctl();
 	return 0;
 }
-- 
2.24.1

