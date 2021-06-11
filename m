Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D95D23A383C
	for <lists+bpf@lfdr.de>; Fri, 11 Jun 2021 02:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbhFKAI6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Jun 2021 20:08:58 -0400
Received: from sonic314-27.consmr.mail.ne1.yahoo.com ([66.163.189.153]:38839
        "EHLO sonic314-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230265AbhFKAI5 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 10 Jun 2021 20:08:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1623370020; bh=QnaoMOY8J+eKImHubkn5ypq+GKjDtd1cKYZJ/5/bNss=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=hPxTbhR6l21xyUaWckimmbV79L83kLQcS5kXvqX6Xq9/da9wroqRb4a0qe1nS8AdzcKcn8ScAZSKXa0+bUreadtCArfw5K0yzEPROyD6LLMvImznGaa74cNC9GneEwaD2EzQx0/EtChnZcFj1+Ptm4Bwthuj+D9mdhwyv5LHEuu6ctODvAiM7YHOFVVMpAByR7lY5e2ivRlarIOD34rWJ+j1MwBcUTT2wJzKeOMQv9AWFVd/iMCbuKkffy/CsmBydpIv6GaOOuzWRUEJ4NnVwDCAtgDomtb7x6+NjG1ils1A7CDbbCbHIu429p1TOnbSRCjDKygRcs81nVISyOQJWg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1623370020; bh=f0Ytu5Y4Of4TLAKP9F36wsY/TMAKreR7qh/sB6iNrnc=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=dZw45uiN8eoRA4hbuvbbGQ93P4qF+ggOBOphXySZ+BdVmR7QsRru3syaC26ZuZ9RGNQzkfiqbei62Wy8XTKb5VbJaxX7Il9K7bXnMQ0RYkCj3YA5fSfQmQUnjebJmAawSH7QEoeKoDAzCRA7u44Z/2PvrGPDExYAiXbJF31Bc5iYJaZ7xQUA07QoEC+teKF6qw2DhjohbVuTsvNPs3Yi9gEb+GY20e7X2MwoXwb1nv6oz81wSiQK3aCpAWkRRtlNL/TU6lSxjd0LroxqnH/inZ2PysVZoaF1d5ZKuE19f4Vhs3g55WGsTJFhWif6nPo1Pf7HldUpsp1prO4HH5MdKQ==
X-YMail-OSG: GB4B5j4VM1n02r1TB8u4lofDQ2gbaAvlPgAAkHeiLffuOLE2wbUbmSHWYWgEKKM
 ofEbsZ0Xe9Ohu32QcQM4CxjaC8814_pZa7nIQEZzKJIe7QhZe7YzeufkEx2huM._tcDcbJZvJipJ
 s.I6lnCDeabjpZHauOhhhvaUkKQZWZdNbJAIj3nqWyZCJZ36RWKygSwwM7zQdKT8wKu2WGe9DOdM
 ML_tRw7er8aaOZkeqEisS_l4MGQ1MfFpf_qlHvdCnvK0thX2hnvaMiKIjOHt2RQ9YqKDwqWSXfAS
 cYwxsBeur5jbbxAwcRCDHo2tXJ9qof_MBMGtNt2GBe5OTOxC7byx3FG_lKgiAXD2og8vTyOzyzhF
 fP6Shc.RC980T77ylusx0I.76hQVgjRZAhQWTmp9q8IEZ6IRDMhOO6P9P1YKer444q0lLUw_McqR
 mKRU4tUrKg6FATUbmRX1YAz15OeD8ocU4QmrUiYHgKHopP2_TKnp.Y_3.Eu5Q_aNtEKVN9vkKMLz
 I.gMrvs0n_ymJkSs0WKcJcD8uDkmWFzLOhFAQDrRy0VS9yTi7a0_j9rNGih.1WvJgTFvCqSOPMbZ
 PI3ahnucMfn9ZhIRvhTnVeNa2W7uhOX5jHjt_iw8ZFS13NJ1ozYtA8efSOgsvdACk.aaZA.ZfV4l
 ooR27pCkoRwleoB6nUzgKZqkwmkbCVwZ6xeXUpx3816ZlrP5u5jDC0vgl2AOifaGFH2Z8RrXP75q
 AjXD.YDMIOfG5no4wSXthXYxPH5Xs5GsfBnrOCpScEkGOO86FB67DVBzcooAoyECTxmUYf1l8qZO
 Lh3hnqAl_sqQBxFuPDVLgEIDnX_6A7GoQeJn6VtAUeYkmVVdu14zWWkAUYgwgfGstM1Wn62DteNz
 pn2DcuzwMYznvnuyifDNFyPsrPhO9sG.M05XZVt99ftSWVkNrjwYxsDPFwQdTk3UCX6Eq64_1UZW
 x4XioNmbOSSGyBkao8.gS_tMsNF4t.g2hhVlbkQjRvuUJYAleadHaHy.YNAFeKzeh5qADjg7Fbmg
 KLzPZetjmCA47pc042J.C_xl3npss_aa914N5aOOVTA0QHUbcs4KU29chdC9WYcrHIboSqnt795e
 Qh4Y0cXG4EKLxiT6ISOLWF05DW_K_QhJakVj_z8qzFp1w1u_nTAuQksnM71RES3mmxBQ00oPwdgv
 09w2H6LXGcVSzI9ti5IO2ksTqtR3lNF1QGh_b_.sUT72TTbmoI2WVJJIsl6tAi.DMxiyFQslNWw2
 Cs6BkG7o4mR9.9grtN3erdQtPzIT1aSZdsnz0J5goHG1fnfAALjr_kkiOn1QiOdbiH_RzKuL8bNa
 33.Kt7.PUgWtNhPfVfZXwNZGzbbbwTJdSO0_kxjiYD2iCypHSlb027JcKCKrP3sTEHBJ_TXUr6_Q
 unWoupZB_YUxOR9ZozoeJBpI18hvDej05kH8teAjgIfcjO7Od.j1OlLOIJoPw.zFfKaI8r8vzsQ_
 9ArHEr3d.eExDuxOOqL0Yf1hSplo3S5xsrA5epAyjZQ5Wk7VjcXIgEgvU7CbCEqmFT0VElkTONT1
 jzSUMhzsya96XBiqGZhcbnpwow8O7v900W8ySj_s.ww84nDk7EOnSFC9MjFVqhzZVZ2IGXGzqheY
 aRQmmKTXkOK_EWEkXLrimZdJyMNEVSGe49PB1VLMX6glFT2VG46fR_aP4o8vPSJYEK3hv129Hgw7
 3vApjQiMe1wXCcOZmCJSXTYnvApEN4XXlsph5vrh9kNMuHL1k47IPNqW1qk5K6R2qXhuDDLR1ymw
 IpS1W6IX00LGBNJJLd.DiIuBlEHG3QsNgL.4sJHwZeCGPeyOpu2QKBGXdUDfwoI8SkUri9sdKkAn
 PkQQzWVYrFD9DKheulrIteI3scBKozDSpLhdst0jkIN2X42dBGM8mCmPlM2arCUd9Ft9j82fGXWw
 B99AEzyERxKbrYUwFqI_zbZUDVMrhGgNsDuTDudD8qGd0zGpSRKEMfskIcZVq_gS8XzuBLQSvHsk
 tPS3TqhK14p798EW8kKv_lAUR8mMsB_FV94K5mTRChV6W57RERdsCWKn26iI8wN5LZvGuSibvjCS
 krTf4LP55hps_HQGTtxUdYfg0Lswl0JkTJbxFjuLBJ7SVok3GcH62S.e0miE7iiODVu3jr3y2X6I
 XItvklhzA3O1_qqW9A2w_Ju0FHwf0hN5BJwNyRzsfv0gQwC2OfCJWVDHUvCsjPHlh3YupO98XebX
 nE_SZZ0QllCkOdcj8EnYiX_8jp_xQvpQzwdSpgWq4KT.8H9Uu0QuyCgrxqG07K7CRLDxgWXLQG5a
 57LP_d790YwM17iuF2Yo69jju.juXQaYKAeOJOlwVrla.fy4G_w4Ko68qKLNlcqEs9kUjNCM3Cg7
 ruLXlGhy3Q_3IRHTTl_lJk4iLei50TaYWoSEKYCc_Ou6MCznnmIOei.CrsBB9.RQvjMQ68c.Yk31
 gKKolonJSC0sIphc8IIIkDPo8LdugOe9pXTQiJ5xJEOW1nxHKXjoTlTWT6Muld9TALSONND3.4vM
 SzkaWkljv6luTNIjReBsel6WXNcxWewvY565_3yMDdHqaLQEQavUm0bg_yedc3qd8WpAnMtnn.nX
 oBxGtJoTjq5TecSfnKw_mugPxG_BWpGNf8Dx9kSBq14HzIMzu.ytp8rl4hnuUOTGgoB.r8k_qrW1
 FT5KLWFVp7MMVB95gV0u4jOvWnK3DmlkpfUtvLoyQyUW2icQfSazqLvr.Ez0ujtgsnOa69ZmaZAY
 _3vxqmoInwZ.I.fhTLtD9BItexUyLK_mbA.aOa4nS_4ejs9ArMQEogCx3uhN.PEwiGR4G.Z.mSD3
 LOivea.kKlZjOe8cUdlXVVdqMTCC81a5gZlhtV7n6WG9RAvp_djlL.GdeV1JKrAcsEJ4CvS1Nit0
 uac6SQvFqiTkTZMJAvc.Sh9Xd3JSeBNlGz2kvx77EGs9AfMbCz24BkDrqMp9afW9wGp5VV5eJMm1
 kPfoVD2RkBcAVNYtwd1GMyFlOqEZIyKxLj6GNTENbwlW8GbeBgTvZV2lodEXy3Eca471C7HYNZjX
 ArvNy0ZiDlgfoN_109l3KM5gC1uzLXtMLjrM4MsFB.vK8D92_XstOZ6fkisYos7IIEq2N3FUqcGa
 dHcz3c81kLM_XrdI-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Fri, 11 Jun 2021 00:07:00 +0000
Received: by kubenode547.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID def83d2a249c950bfe73876fdab09eba;
          Fri, 11 Jun 2021 00:06:56 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH v27 02/25] LSM: Add the lsmblob data structure.
Date:   Thu, 10 Jun 2021 17:04:12 -0700
Message-Id: <20210611000435.36398-3-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210611000435.36398-1-casey@schaufler-ca.com>
References: <20210611000435.36398-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: linux-audit@redhat.com
Cc: linux-security-module@vger.kernel.org
Cc: selinux@vger.kernel.org
To: Mimi Zohar <zohar@linux.ibm.com>
To: Mickaël Salaün <mic@linux.microsoft.com>
---
 include/linux/audit.h               |  4 +-
 include/linux/lsm_hooks.h           | 12 ++++-
 include/linux/security.h            | 67 ++++++++++++++++++++++++--
 kernel/auditfilter.c                | 24 +++++-----
 kernel/auditsc.c                    | 13 +++--
 security/apparmor/lsm.c             |  7 ++-
 security/bpf/hooks.c                | 12 ++++-
 security/commoncap.c                |  7 ++-
 security/integrity/ima/ima_policy.c | 40 +++++++++++-----
 security/landlock/cred.c            |  2 +-
 security/landlock/fs.c              |  2 +-
 security/landlock/ptrace.c          |  2 +-
 security/landlock/setup.c           |  5 ++
 security/landlock/setup.h           |  1 +
 security/loadpin/loadpin.c          |  8 +++-
 security/lockdown/lockdown.c        |  7 ++-
 security/safesetid/lsm.c            |  8 +++-
 security/security.c                 | 74 ++++++++++++++++++++++++-----
 security/selinux/hooks.c            |  8 +++-
 security/smack/smack_lsm.c          |  7 ++-
 security/tomoyo/tomoyo.c            |  8 +++-
 security/yama/yama_lsm.c            |  7 ++-
 22 files changed, 265 insertions(+), 60 deletions(-)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index 82b7c1116a85..418a485af114 100644
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
index afd3b16875b0..c61a16f0a5bc 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1570,6 +1570,14 @@ struct security_hook_heads {
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
@@ -1578,7 +1586,7 @@ struct security_hook_list {
 	struct hlist_node		list;
 	struct hlist_head		*head;
 	union security_list_options	hook;
-	char				*lsm;
+	struct lsm_id			*lsmid;
 } __randomize_layout;
 
 /*
@@ -1614,7 +1622,7 @@ extern struct security_hook_heads security_hook_heads;
 extern char *lsm_names;
 
 extern void security_add_hooks(struct security_hook_list *hooks, int count,
-				char *lsm);
+			       struct lsm_id *lsmid);
 
 #define LSM_FLAG_LEGACY_MAJOR	BIT(0)
 #define LSM_FLAG_EXCLUSIVE	BIT(1)
diff --git a/include/linux/security.h b/include/linux/security.h
index 06f7c50ce77f..62588bc522ba 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -133,6 +133,65 @@ enum lockdown_reason {
 
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
+ * lsmblob_init - initialize an lsmblob structure
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
@@ -1881,8 +1940,8 @@ static inline int security_key_getsecurity(struct key *key, char **_buffer)
 #ifdef CONFIG_SECURITY
 int security_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule);
 int security_audit_rule_known(struct audit_krule *krule);
-int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule);
-void security_audit_rule_free(void *lsmrule);
+int security_audit_rule_match(u32 secid, u32 field, u32 op, void **lsmrule);
+void security_audit_rule_free(void **lsmrule);
 
 #else
 
@@ -1898,12 +1957,12 @@ static inline int security_audit_rule_known(struct audit_krule *krule)
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
index db2c6b59dfc3..a2340e81cfa7 100644
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
@@ -1358,11 +1359,12 @@ int audit_filter(int msgtype, unsigned int listtype)
 			case AUDIT_SUBJ_TYPE:
 			case AUDIT_SUBJ_SEN:
 			case AUDIT_SUBJ_CLR:
-				if (f->lsm_rule) {
+				if (f->lsm_isset) {
 					security_task_getsecid_subj(current,
 								    &sid);
 					result = security_audit_rule_match(sid,
-						   f->type, f->op, f->lsm_rule);
+						   f->type, f->op,
+						   f->lsm_rules);
 				}
 				break;
 			case AUDIT_EXE:
@@ -1389,7 +1391,7 @@ int audit_filter(int msgtype, unsigned int listtype)
 	return ret;
 }
 
-static int update_lsm_rule(struct audit_krule *r)
+static int update_lsm_rules(struct audit_krule *r)
 {
 	struct audit_entry *entry = container_of(r, struct audit_entry, rule);
 	struct audit_entry *nentry;
@@ -1421,7 +1423,7 @@ static int update_lsm_rule(struct audit_krule *r)
 	return err;
 }
 
-/* This function will re-initialize the lsm_rule field of all applicable rules.
+/* This function will re-initialize the lsm_rules field of all applicable rules.
  * It will traverse the filter lists serarching for rules that contain LSM
  * specific filter fields.  When such a rule is found, it is copied, the
  * LSM field is re-initialized, and the old rule is replaced with the
@@ -1436,7 +1438,7 @@ int audit_update_lsm_rules(void)
 
 	for (i = 0; i < AUDIT_NR_FILTERS; i++) {
 		list_for_each_entry_safe(r, n, &audit_rules_list[i], list) {
-			int res = update_lsm_rule(r);
+			int res = update_lsm_rules(r);
 			if (!err)
 				err = res;
 		}
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 175ef6f3ea4e..392afe3e2fd6 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -665,14 +665,13 @@ static int audit_filter_rules(struct task_struct *tsk,
 			   match for now to avoid losing information that
 			   may be wanted.   An error message will also be
 			   logged upon error */
-			if (f->lsm_rule) {
+			if (f->lsm_isset) {
 				if (need_sid) {
 					security_task_getsecid_subj(tsk, &sid);
 					need_sid = 0;
 				}
 				result = security_audit_rule_match(sid, f->type,
-								   f->op,
-								   f->lsm_rule);
+							f->op, f->lsm_rules);
 			}
 			break;
 		case AUDIT_OBJ_USER:
@@ -682,21 +681,21 @@ static int audit_filter_rules(struct task_struct *tsk,
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
@@ -707,7 +706,7 @@ static int audit_filter_rules(struct task_struct *tsk,
 					break;
 				if (security_audit_rule_match(ctx->ipc.osid,
 							      f->type, f->op,
-							      f->lsm_rule))
+							      f->lsm_rules))
 					++result;
 			}
 			break;
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 4113516fb62e..392e25940d1f 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1161,6 +1161,11 @@ struct lsm_blob_sizes apparmor_blob_sizes __lsm_ro_after_init = {
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
@@ -1862,7 +1867,7 @@ static int __init apparmor_init(void)
 		goto buffers_out;
 	}
 	security_add_hooks(apparmor_hooks, ARRAY_SIZE(apparmor_hooks),
-				"apparmor");
+				&apparmor_lsmid);
 
 	/* Report that AppArmor successfully initialized */
 	apparmor_initialized = 1;
diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
index e5971fa74fd7..7a58fe9ab8c4 100644
--- a/security/bpf/hooks.c
+++ b/security/bpf/hooks.c
@@ -15,9 +15,19 @@ static struct security_hook_list bpf_lsm_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(task_free, bpf_task_storage_free),
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
index 3f810d37b71b..628685cf20e3 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -1443,6 +1443,11 @@ int cap_mmap_file(struct file *file, unsigned long reqprot,
 
 #ifdef CONFIG_SECURITY
 
+static struct lsm_id capability_lsmid __lsm_ro_after_init = {
+	.lsm  = "capability",
+	.slot = LSMBLOB_NOT_NEEDED
+};
+
 static struct security_hook_list capability_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(capable, cap_capable),
 	LSM_HOOK_INIT(settime, cap_settime),
@@ -1467,7 +1472,7 @@ static struct security_hook_list capability_hooks[] __lsm_ro_after_init = {
 static int __init capability_init(void)
 {
 	security_add_hooks(capability_hooks, ARRAY_SIZE(capability_hooks),
-				"capability");
+			   &capability_lsmid);
 	return 0;
 }
 
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index fd5d46e511f1..5c40677e881c 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -80,7 +80,7 @@ struct ima_rule_entry {
 	bool (*fowner_op)(kuid_t, kuid_t); /* uid_eq(), uid_gt(), uid_lt() */
 	int pcr;
 	struct {
-		void *rule;	/* LSM file metadata specific */
+		void *rules[LSMBLOB_ENTRIES]; /* LSM file metadata specific */
 		char *args_p;	/* audit value */
 		int type;	/* audit type */
 	} lsm[MAX_LSM_RULES];
@@ -90,6 +90,22 @@ struct ima_rule_entry {
 	struct ima_template_desc *template;
 };
 
+/**
+ * ima_lsm_isset - Is a rule set for any of the active security modules
+ * @rules: The set of IMA rules to check
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
@@ -335,9 +351,11 @@ static void ima_free_rule_opt_list(struct ima_rule_opt_list *opt_list)
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
@@ -388,8 +406,8 @@ static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
 
 		ima_filter_rule_init(nentry->lsm[i].type, Audit_equal,
 				     nentry->lsm[i].args_p,
-				     &nentry->lsm[i].rule);
-		if (!nentry->lsm[i].rule)
+				     &nentry->lsm[i].rules[0]);
+		if (!ima_lsm_isset(nentry->lsm[i].rules))
 			pr_warn("rule for LSM \'%s\' is undefined\n",
 				nentry->lsm[i].args_p);
 	}
@@ -578,7 +596,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
 		int rc = 0;
 		u32 osid;
 
-		if (!rule->lsm[i].rule) {
+		if (!ima_lsm_isset(rule->lsm[i].rules)) {
 			if (!rule->lsm[i].args_p)
 				continue;
 			else
@@ -591,14 +609,14 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
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
 			break;
 		default:
 			break;
@@ -994,7 +1012,7 @@ static int ima_lsm_rule_init(struct ima_rule_entry *entry,
 {
 	int result;
 
-	if (entry->lsm[lsm_rule].rule)
+	if (ima_lsm_isset(entry->lsm[lsm_rule].rules))
 		return -EINVAL;
 
 	entry->lsm[lsm_rule].args_p = match_strdup(args);
@@ -1004,8 +1022,8 @@ static int ima_lsm_rule_init(struct ima_rule_entry *entry,
 	entry->lsm[lsm_rule].type = audit_type;
 	result = ima_filter_rule_init(entry->lsm[lsm_rule].type, Audit_equal,
 				      entry->lsm[lsm_rule].args_p,
-				      &entry->lsm[lsm_rule].rule);
-	if (!entry->lsm[lsm_rule].rule) {
+				      &entry->lsm[lsm_rule].rules[0]);
+	if (!ima_lsm_isset(entry->lsm[lsm_rule].rules)) {
 		pr_warn("rule for LSM \'%s\' is undefined\n",
 			entry->lsm[lsm_rule].args_p);
 
@@ -1812,7 +1830,7 @@ int ima_policy_show(struct seq_file *m, void *v)
 	}
 
 	for (i = 0; i < MAX_LSM_RULES; i++) {
-		if (entry->lsm[i].rule) {
+		if (ima_lsm_isset(entry->lsm[i].rules)) {
 			switch (i) {
 			case LSM_OBJ_USER:
 				seq_printf(m, pt(Opt_obj_user),
diff --git a/security/landlock/cred.c b/security/landlock/cred.c
index 6725af24c684..56b121d65436 100644
--- a/security/landlock/cred.c
+++ b/security/landlock/cred.c
@@ -42,5 +42,5 @@ static struct security_hook_list landlock_hooks[] __lsm_ro_after_init = {
 __init void landlock_add_cred_hooks(void)
 {
 	security_add_hooks(landlock_hooks, ARRAY_SIZE(landlock_hooks),
-			LANDLOCK_NAME);
+			&landlock_lsmid);
 }
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 97b8e421f617..319e90e9290c 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -688,5 +688,5 @@ static struct security_hook_list landlock_hooks[] __lsm_ro_after_init = {
 __init void landlock_add_fs_hooks(void)
 {
 	security_add_hooks(landlock_hooks, ARRAY_SIZE(landlock_hooks),
-			LANDLOCK_NAME);
+			&landlock_lsmid);
 }
diff --git a/security/landlock/ptrace.c b/security/landlock/ptrace.c
index f55b82446de2..54ccf55a077a 100644
--- a/security/landlock/ptrace.c
+++ b/security/landlock/ptrace.c
@@ -116,5 +116,5 @@ static struct security_hook_list landlock_hooks[] __lsm_ro_after_init = {
 __init void landlock_add_ptrace_hooks(void)
 {
 	security_add_hooks(landlock_hooks, ARRAY_SIZE(landlock_hooks),
-			LANDLOCK_NAME);
+			&landlock_lsmid);
 }
diff --git a/security/landlock/setup.c b/security/landlock/setup.c
index f8e8e980454c..759e00b9436c 100644
--- a/security/landlock/setup.c
+++ b/security/landlock/setup.c
@@ -23,6 +23,11 @@ struct lsm_blob_sizes landlock_blob_sizes __lsm_ro_after_init = {
 	.lbs_superblock = sizeof(struct landlock_superblock_security),
 };
 
+struct lsm_id landlock_lsmid __lsm_ro_after_init = {
+	.lsm = LANDLOCK_NAME,
+	.slot = LSMBLOB_NOT_NEEDED,
+};
+
 static int __init landlock_init(void)
 {
 	landlock_add_cred_hooks();
diff --git a/security/landlock/setup.h b/security/landlock/setup.h
index 1daffab1ab4b..38bce5b172dc 100644
--- a/security/landlock/setup.h
+++ b/security/landlock/setup.h
@@ -14,5 +14,6 @@
 extern bool landlock_initialized;
 
 extern struct lsm_blob_sizes landlock_blob_sizes;
+extern struct lsm_id landlock_lsmid;
 
 #endif /* _SECURITY_LANDLOCK_SETUP_H */
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
index 1079c6d54784..a2a2f462a821 100644
--- a/security/safesetid/lsm.c
+++ b/security/safesetid/lsm.c
@@ -241,6 +241,11 @@ static int safesetid_task_fix_setgid(struct cred *new,
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
@@ -250,7 +255,8 @@ static struct security_hook_list safesetid_security_hooks[] = {
 static int __init safesetid_security_init(void)
 {
 	security_add_hooks(safesetid_security_hooks,
-			   ARRAY_SIZE(safesetid_security_hooks), "safesetid");
+			   ARRAY_SIZE(safesetid_security_hooks),
+			   &safesetid_lsmid);
 
 	/* Report that SafeSetID successfully initialized */
 	safesetid_initialized = 1;
diff --git a/security/security.c b/security/security.c
index e12a7c463468..473b49971aab 100644
--- a/security/security.c
+++ b/security/security.c
@@ -344,6 +344,7 @@ static void __init ordered_lsm_init(void)
 	init_debug("sock blob size       = %d\n", blob_sizes.lbs_sock);
 	init_debug("superblock blob size = %d\n", blob_sizes.lbs_superblock);
 	init_debug("task blob size       = %d\n", blob_sizes.lbs_task);
+	init_debug("lsmblob size         = %zu\n", sizeof(struct lsmblob));
 
 	/*
 	 * Create any kmem_caches needed for blobs
@@ -471,21 +472,38 @@ static int lsm_append(const char *new, char **result)
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
+ * @lsmid: the identification information for the security module
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
 
+	WARN_ON(!lsmid->slot || !lsmid->lsm);
+
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
 
@@ -494,7 +512,7 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
 	 * and fix this up afterwards.
 	 */
 	if (slab_is_available()) {
-		if (lsm_append(lsm, &lsm_names) < 0)
+		if (lsm_append(lsmid->lsm, &lsm_names) < 0)
 			panic("%s - Cannot get early memory.\n", __func__);
 	}
 }
@@ -2070,7 +2088,7 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
 	struct security_hook_list *hp;
 
 	hlist_for_each_entry(hp, &security_hook_heads.getprocattr, list) {
-		if (lsm != NULL && strcmp(lsm, hp->lsm))
+		if (lsm != NULL && strcmp(lsm, hp->lsmid->lsm))
 			continue;
 		return hp->hook.getprocattr(p, name, value);
 	}
@@ -2083,7 +2101,7 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
 	struct security_hook_list *hp;
 
 	hlist_for_each_entry(hp, &security_hook_heads.setprocattr, list) {
-		if (lsm != NULL && strcmp(lsm, hp->lsm))
+		if (lsm != NULL && strcmp(lsm, hp->lsmid->lsm))
 			continue;
 		return hp->hook.setprocattr(name, value, size);
 	}
@@ -2576,7 +2594,24 @@ int security_key_getsecurity(struct key *key, char **_buffer)
 
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
@@ -2584,14 +2619,31 @@ int security_audit_rule_known(struct audit_krule *krule)
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
index 84ddcec6322e..0133b142e938 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7111,6 +7111,11 @@ static int selinux_perf_event_write(struct perf_event *event)
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
@@ -7424,7 +7429,8 @@ static __init int selinux_init(void)
 
 	hashtab_cache_init();
 
-	security_add_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks), "selinux");
+	security_add_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks),
+			   &selinux_lsmid);
 
 	if (avc_add_callback(selinux_netcache_avc_callback, AVC_CALLBACK_RESET))
 		panic("SELinux: Unable to register AVC netcache callback\n");
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 1ee0bf1493f6..5c10ad27be37 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4694,6 +4694,11 @@ struct lsm_blob_sizes smack_blob_sizes __lsm_ro_after_init = {
 	.lbs_superblock = sizeof(struct superblock_smack),
 };
 
+static struct lsm_id smack_lsmid __lsm_ro_after_init = {
+	.lsm  = "smack",
+	.slot = LSMBLOB_NEEDED
+};
+
 static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(ptrace_access_check, smack_ptrace_access_check),
 	LSM_HOOK_INIT(ptrace_traceme, smack_ptrace_traceme),
@@ -4893,7 +4898,7 @@ static __init int smack_init(void)
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
2.29.2

