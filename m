Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A834EB54C
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2019 17:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729062AbfJaQru (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 31 Oct 2019 12:47:50 -0400
Received: from smtp-sh.infomaniak.ch ([128.65.195.4]:43376 "EHLO
        smtp-sh.infomaniak.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728572AbfJaQq6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 31 Oct 2019 12:46:58 -0400
Received: from smtp7.infomaniak.ch (smtp7.infomaniak.ch [83.166.132.30])
        by smtp-sh.infomaniak.ch (8.14.5/8.14.5) with ESMTP id x9VGj9uK031899
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Oct 2019 17:45:09 +0100
Received: from localhost (ns3096276.ip-94-23-54.eu [94.23.54.103])
        (authenticated bits=0)
        by smtp7.infomaniak.ch (8.14.5/8.14.5) with ESMTP id x9VGj8Gj028970;
        Thu, 31 Oct 2019 17:45:08 +0100
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Drysdale <drysdale@google.com>,
        Florent Revest <revest@chromium.org>,
        James Morris <jmorris@namei.org>, Jann Horn <jann@thejh.net>,
        John Johansen <john.johansen@canonical.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        KP Singh <kpsingh@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mickael.salaun@ssi.gouv.fr>,
        Paul Moore <paul@paul-moore.com>,
        Sargun Dhillon <sargun@sargun.me>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>, Tejun Heo <tj@kernel.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Tycho Andersen <tycho@tycho.ws>,
        Will Drewry <wad@chromium.org>, bpf@vger.kernel.org,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH bpf-next v12 2/7] landlock: Add the management of domains
Date:   Thu, 31 Oct 2019 17:44:40 +0100
Message-Id: <20191031164445.29426-3-mic@digikod.net>
X-Mailer: git-send-email 2.24.0.rc1
In-Reply-To: <20191031164445.29426-1-mic@digikod.net>
References: <20191031164445.29426-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Antivirus: Dr.Web (R) for Unix mail servers drweb plugin ver.6.0.2.8
X-Antivirus-Code: 0x100000
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

A Landlock domain is a set of eBPF programs.  There is a list for each
different program types that can be run on a specific Landlock hook
(e.g. ptrace).  A domain is tied to a set of subjects (i.e. tasks).  A
Landlock program should not try (nor be able) to infer which subject is
currently enforced, but to have a unique security policy for all
subjects tied to the same domain.  This make the reasoning much easier
and help avoid pitfalls.

The next commits tie a domain to a task's credentials thanks to
seccomp(2), but we could use cgroups or a security file-system to
enforce a sysadmin-defined policy .

Signed-off-by: Mickaël Salaün <mic@digikod.net>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: James Morris <jmorris@namei.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Serge E. Hallyn <serge@hallyn.com>
Cc: Will Drewry <wad@chromium.org>
---

Changes since v11:
* remove old code from previous refactoring (removing the program
  chaining concept) and simplify program prepending (reported by Serge
  E. Hallyn):
  * simplify landlock_prepend_prog() and merge it with
    store_landlock_prog()
  * add new_prog_list() and rework new_landlock_domain()
  * remove the extra page allocation checks, only rely on the eBPF
    program checks
* replace the -EINVAL for the duplicate program check with the -EEXIST

Changes since v10:
* rename files and names to clearly define a domain
* create a standalone patch to ease review
---
 security/landlock/Makefile        |   3 +-
 security/landlock/common.h        |  38 +++++++
 security/landlock/domain_manage.c | 173 ++++++++++++++++++++++++++++++
 security/landlock/domain_manage.h |  23 ++++
 4 files changed, 236 insertions(+), 1 deletion(-)
 create mode 100644 security/landlock/domain_manage.c
 create mode 100644 security/landlock/domain_manage.h

diff --git a/security/landlock/Makefile b/security/landlock/Makefile
index 682b798c6b76..dd5f70185778 100644
--- a/security/landlock/Makefile
+++ b/security/landlock/Makefile
@@ -1,4 +1,5 @@
 obj-$(CONFIG_SECURITY_LANDLOCK) := landlock.o
 
 landlock-y := \
-	bpf_verify.o bpf_ptrace.o
+	bpf_verify.o bpf_ptrace.o \
+	domain_manage.o
diff --git a/security/landlock/common.h b/security/landlock/common.h
index 0234c4bc4acd..fb2990eb5fb4 100644
--- a/security/landlock/common.h
+++ b/security/landlock/common.h
@@ -11,11 +11,49 @@
 
 #include <linux/bpf.h>
 #include <linux/filter.h>
+#include <linux/refcount.h>
 
 enum landlock_hook_type {
 	LANDLOCK_HOOK_PTRACE = 1,
 };
 
+#define _LANDLOCK_HOOK_LAST LANDLOCK_HOOK_PTRACE
+
+struct landlock_prog_list {
+	struct landlock_prog_list *prev;
+	struct bpf_prog *prog;
+	refcount_t usage;
+};
+
+/**
+ * struct landlock_domain - Landlock programs enforced on a set of tasks
+ *
+ * When prepending a new program, if &struct landlock_domain is shared with
+ * other tasks, then duplicate it and prepend the program to this new &struct
+ * landlock_domain.
+ *
+ * @usage: reference count to manage the object lifetime. When a task needs to
+ *	   add Landlock programs and if @usage is greater than 1, then the
+ *	   task must duplicate &struct landlock_domain to not change the
+ *	   children's programs as well.
+ * @programs: array of non-NULL &struct landlock_prog_list pointers
+ */
+struct landlock_domain {
+	struct landlock_prog_list *programs[_LANDLOCK_HOOK_LAST];
+	refcount_t usage;
+};
+
+/**
+ * get_hook_index - get an index for the programs of struct landlock_prog_set
+ *
+ * @type: a Landlock hook type
+ */
+static inline size_t get_hook_index(enum landlock_hook_type type)
+{
+	/* type ID > 0 for loaded programs */
+	return type - 1;
+}
+
 static inline enum landlock_hook_type get_hook_type(const struct bpf_prog *prog)
 {
 	switch (prog->expected_attach_type) {
diff --git a/security/landlock/domain_manage.c b/security/landlock/domain_manage.c
new file mode 100644
index 000000000000..8b7ce988a221
--- /dev/null
+++ b/security/landlock/domain_manage.c
@@ -0,0 +1,173 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Landlock LSM - domain management
+ *
+ * Copyright © 2016-2019 Mickaël Salaün <mic@digikod.net>
+ * Copyright © 2018-2019 ANSSI
+ */
+
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/refcount.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+
+#include "common.h"
+#include "domain_manage.h"
+
+void landlock_get_domain(struct landlock_domain *dom)
+{
+	if (!dom)
+		return;
+	refcount_inc(&dom->usage);
+}
+
+static void put_prog_list(struct landlock_prog_list *prog_list)
+{
+	struct landlock_prog_list *orig = prog_list;
+
+	/* clean up single-reference branches iteratively */
+	while (orig && refcount_dec_and_test(&orig->usage)) {
+		struct landlock_prog_list *freeme = orig;
+
+		if (orig->prog)
+			bpf_prog_put(orig->prog);
+		orig = orig->prev;
+		kfree(freeme);
+	}
+}
+
+void landlock_put_domain(struct landlock_domain *domain)
+{
+	if (domain && refcount_dec_and_test(&domain->usage)) {
+		size_t i;
+
+		for (i = 0; i < ARRAY_SIZE(domain->programs); i++)
+			put_prog_list(domain->programs[i]);
+		kfree(domain);
+	}
+}
+
+static struct landlock_prog_list *new_prog_list(struct bpf_prog *prog)
+{
+	struct landlock_prog_list *new_list;
+
+	if (WARN_ON(IS_ERR_OR_NULL(prog)))
+		return ERR_PTR(-EFAULT);
+	if (prog->type != BPF_PROG_TYPE_LANDLOCK_HOOK)
+		return ERR_PTR(-EINVAL);
+	prog = bpf_prog_inc(prog);
+	if (IS_ERR(prog))
+		return ERR_CAST(prog);
+	new_list = kzalloc(sizeof(*new_list), GFP_KERNEL);
+	if (!new_list) {
+		bpf_prog_put(prog);
+		return ERR_PTR(-ENOMEM);
+	}
+	new_list->prog = prog;
+	refcount_set(&new_list->usage, 1);
+	return new_list;
+}
+
+/* @prog can legitimately be NULL */
+static struct landlock_domain *new_landlock_domain(struct bpf_prog *prog)
+{
+	struct landlock_domain *new_domain;
+	struct landlock_prog_list *new_list;
+	size_t hook;
+
+	/* programs[] filled with NULL values */
+	new_domain = kzalloc(sizeof(*new_domain), GFP_KERNEL);
+	if (!new_domain)
+		return ERR_PTR(-ENOMEM);
+	refcount_set(&new_domain->usage, 1);
+	if (!prog)
+		return new_domain;
+	new_list = new_prog_list(prog);
+	if (IS_ERR(new_list)) {
+		kfree(new_domain);
+		return ERR_CAST(new_list);
+	}
+	hook = get_hook_index(get_hook_type(prog));
+	new_domain->programs[hook] = new_list;
+	return new_domain;
+}
+
+/**
+ * landlock_prepend_prog - attach a Landlock program to @current_domain
+ *
+ * Prepend @prog to @current_domain if @prog is not already in @current_domain.
+ *
+ * @current_domain: landlock_domain pointer which is garantee to not be
+ *                  modified elsewhere. This pointer should not be used nor
+ *                  put/freed after the call.
+ * @prog: non-NULL Landlock program to prepend to @current_domain. @prog will
+ *        be owned by landlock_prepend_prog(). You can then call
+ *        bpf_prog_put(@prog) after.
+ *
+ * Return @current_domain or a new pointer when OK. Return a pointer error
+ * otherwise.
+ */
+struct landlock_domain *landlock_prepend_prog(
+		struct landlock_domain *current_domain,
+		struct bpf_prog *prog)
+{
+	struct landlock_domain *oneref_domain;
+	struct landlock_prog_list *new_list, *walker;
+	size_t hook;
+
+	if (WARN_ON(!prog))
+		return ERR_PTR(-EFAULT);
+	if (prog->type != BPF_PROG_TYPE_LANDLOCK_HOOK)
+		return ERR_PTR(-EINVAL);
+
+	/*
+	 * Each domain contains an array of prog_list pointers.  If a domain is
+	 * used by more than one credential, then this domain is first
+	 * duplicated and then @prog is prepended to this new domain.  We then
+	 * have the garantee that a domain is immutable when shared, and it can
+	 * only be modified if it is referenced only once (by the modifier).
+	 */
+	if (!current_domain)
+		return new_landlock_domain(prog);
+
+	hook = get_hook_index(get_hook_type(prog));
+	/* check for similar program */
+	for (walker = current_domain->programs[hook]; walker;
+			walker = walker->prev) {
+		/* don't allow duplicate programs */
+		if (prog == walker->prog)
+			return ERR_PTR(-EEXIST);
+	}
+
+	new_list = new_prog_list(prog);
+	if (IS_ERR(new_list))
+		return ERR_CAST(new_list);
+
+	/* duplicate the domain if not referenced only once */
+	if (refcount_read(&current_domain->usage) == 1) {
+		oneref_domain = current_domain;
+	} else {
+		size_t i;
+
+		oneref_domain = new_landlock_domain(NULL);
+		if (IS_ERR(oneref_domain)) {
+			put_prog_list(new_list);
+			return oneref_domain;
+		}
+		for (i = 0; i < ARRAY_SIZE(oneref_domain->programs); i++) {
+			oneref_domain->programs[i] =
+				current_domain->programs[i];
+			if (oneref_domain->programs[i])
+				refcount_inc(&oneref_domain->programs[i]->usage);
+		}
+		landlock_put_domain(current_domain);
+		/* @current_domain may be a dangling pointer now */
+		current_domain = NULL;
+	}
+
+	/* no need to increment usage (pointer replacement) */
+	new_list->prev = oneref_domain->programs[hook];
+	oneref_domain->programs[hook] = new_list;
+	return oneref_domain;
+}
diff --git a/security/landlock/domain_manage.h b/security/landlock/domain_manage.h
new file mode 100644
index 000000000000..5b5b49f6e3e8
--- /dev/null
+++ b/security/landlock/domain_manage.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Landlock LSM - domain management headers
+ *
+ * Copyright © 2016-2019 Mickaël Salaün <mic@digikod.net>
+ * Copyright © 2018-2019 ANSSI
+ */
+
+#ifndef _SECURITY_LANDLOCK_DOMAIN_MANAGE_H
+#define _SECURITY_LANDLOCK_DOMAIN_MANAGE_H
+
+#include <linux/filter.h>
+
+#include "common.h"
+
+void landlock_get_domain(struct landlock_domain *dom);
+void landlock_put_domain(struct landlock_domain *dom);
+
+struct landlock_domain *landlock_prepend_prog(
+		struct landlock_domain *current_domain,
+		struct bpf_prog *prog);
+
+#endif /* _SECURITY_LANDLOCK_DOMAIN_MANAGE_H */
-- 
2.23.0

