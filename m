Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A656E8E6C
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2019 18:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728754AbfJ2RkY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Oct 2019 13:40:24 -0400
Received: from smtp-sh.infomaniak.ch ([128.65.195.4]:55764 "EHLO
        smtp-sh.infomaniak.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfJ2RkY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Oct 2019 13:40:24 -0400
Received: from smtp8.infomaniak.ch (smtp8.infomaniak.ch [83.166.132.38])
        by smtp-sh.infomaniak.ch (8.14.5/8.14.5) with ESMTP id x9THFO07006023
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Oct 2019 18:15:24 +0100
Received: from localhost (ns3096276.ip-94-23-54.eu [94.23.54.103])
        (authenticated bits=0)
        by smtp8.infomaniak.ch (8.14.5/8.14.5) with ESMTP id x9THFNGc168214;
        Tue, 29 Oct 2019 18:15:23 +0100
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
Subject: [PATCH bpf-next v11 2/7] landlock: Add the management of domains
Date:   Tue, 29 Oct 2019 18:15:00 +0100
Message-Id: <20191029171505.6650-3-mic@digikod.net>
X-Mailer: git-send-email 2.24.0.rc1
In-Reply-To: <20191029171505.6650-1-mic@digikod.net>
References: <20191029171505.6650-1-mic@digikod.net>
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

Changes since v10:
* rename files and names to clearly define a domain
* create a standalone patch to ease review
---
 security/landlock/Makefile        |   3 +-
 security/landlock/common.h        |  38 +++++
 security/landlock/domain_manage.c | 265 ++++++++++++++++++++++++++++++
 security/landlock/domain_manage.h |  23 +++
 4 files changed, 328 insertions(+), 1 deletion(-)
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
index 000000000000..c955b9c95c84
--- /dev/null
+++ b/security/landlock/domain_manage.c
@@ -0,0 +1,265 @@
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
+static void put_landlock_prog_list(struct landlock_prog_list *prog_list)
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
+			put_landlock_prog_list(domain->programs[i]);
+		kfree(domain);
+	}
+}
+
+static struct landlock_domain *new_landlock_domain(void)
+{
+	struct landlock_domain *domain;
+
+	/* array filled with NULL values */
+	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
+	if (!domain)
+		return ERR_PTR(-ENOMEM);
+	refcount_set(&domain->usage, 1);
+	return domain;
+}
+
+/**
+ * store_landlock_prog - prepend and deduplicate a Landlock prog_list
+ *
+ * Prepend @prog to @init_domain while ignoring @prog if they are already in
+ * @ref_domain.  Whatever is the result of this function call, you can call
+ * bpf_prog_put(@prog) after.
+ *
+ * @init_domain: empty domain to prepend to
+ * @ref_domain: domain to check for duplicate programs
+ * @prog: program to prepend
+ *
+ * Return -errno on error or 0 if @prog was successfully stored.
+ */
+static int store_landlock_prog(struct landlock_domain *init_domain,
+		const struct landlock_domain *ref_domain,
+		struct bpf_prog *prog)
+{
+	struct landlock_prog_list *tmp_list = NULL;
+	int err;
+	size_t hook;
+	enum landlock_hook_type last_type;
+	struct bpf_prog *new = prog;
+
+	/* allocate all the memory we need */
+	struct landlock_prog_list *new_list;
+
+	last_type = get_hook_type(new);
+
+	/* ignore duplicate programs */
+	if (ref_domain) {
+		struct landlock_prog_list *ref;
+
+		hook = get_hook_index(get_hook_type(new));
+		for (ref = ref_domain->programs[hook]; ref;
+				ref = ref->prev) {
+			if (ref->prog == new)
+				return -EINVAL;
+		}
+	}
+
+	new = bpf_prog_inc(new);
+	if (IS_ERR(new)) {
+		err = PTR_ERR(new);
+		goto put_tmp_list;
+	}
+	new_list = kzalloc(sizeof(*new_list), GFP_KERNEL);
+	if (!new_list) {
+		bpf_prog_put(new);
+		err = -ENOMEM;
+		goto put_tmp_list;
+	}
+	/* ignore Landlock types in this tmp_list */
+	new_list->prog = new;
+	new_list->prev = tmp_list;
+	refcount_set(&new_list->usage, 1);
+	tmp_list = new_list;
+
+	if (!tmp_list)
+		/* inform user space that this program was already added */
+		return -EEXIST;
+
+	/* properly store the list (without error cases) */
+	while (tmp_list) {
+		struct landlock_prog_list *new_list;
+
+		new_list = tmp_list;
+		tmp_list = tmp_list->prev;
+		/* do not increment the previous prog list usage */
+		hook = get_hook_index(get_hook_type(new_list->prog));
+		new_list->prev = init_domain->programs[hook];
+		/* no need to add from the last program to the first because
+		 * each of them are a different Landlock type */
+		smp_store_release(&init_domain->programs[hook], new_list);
+	}
+	return 0;
+
+put_tmp_list:
+	put_landlock_prog_list(tmp_list);
+	return err;
+}
+
+/* limit Landlock programs set to 256KB */
+#define LANDLOCK_PROGRAMS_MAX_PAGES (1 << 6)
+
+/**
+ * landlock_prepend_prog - attach a Landlock prog_list to @current_domain
+ *
+ * Whatever is the result of this function call, you can call
+ * bpf_prog_put(@prog) after.
+ *
+ * @current_domain: landlock_domain pointer, must be (RCU-)locked (if needed)
+ *                  to prevent a concurrent put/free. This pointer must not be
+ *                  freed after the call.
+ * @prog: non-NULL Landlock prog_list to prepend to @current_domain. @prog will
+ *        be owned by landlock_prepend_prog() and freed if an error happened.
+ *
+ * Return @current_domain or a new pointer when OK. Return a pointer error
+ * otherwise.
+ */
+struct landlock_domain *landlock_prepend_prog(
+		struct landlock_domain *current_domain,
+		struct bpf_prog *prog)
+{
+	struct landlock_domain *new_domain = current_domain;
+	unsigned long pages;
+	int err;
+	size_t i;
+	struct landlock_domain tmp_domain = {};
+
+	if (prog->type != BPF_PROG_TYPE_LANDLOCK_HOOK)
+		return ERR_PTR(-EINVAL);
+
+	/* validate memory size allocation */
+	pages = prog->pages;
+	if (current_domain) {
+		size_t i;
+
+		for (i = 0; i < ARRAY_SIZE(current_domain->programs); i++) {
+			struct landlock_prog_list *walker_p;
+
+			for (walker_p = current_domain->programs[i];
+					walker_p; walker_p = walker_p->prev)
+				pages += walker_p->prog->pages;
+		}
+		/* count a struct landlock_domain if we need to allocate one */
+		if (refcount_read(&current_domain->usage) != 1)
+			pages += round_up(sizeof(*current_domain), PAGE_SIZE)
+				/ PAGE_SIZE;
+	}
+	if (pages > LANDLOCK_PROGRAMS_MAX_PAGES)
+		return ERR_PTR(-E2BIG);
+
+	/* ensure early that we can allocate enough memory for the new
+	 * prog_lists */
+	err = store_landlock_prog(&tmp_domain, current_domain, prog);
+	if (err)
+		return ERR_PTR(err);
+
+	/*
+	 * Each task_struct points to an array of prog list pointers.  These
+	 * tables are duplicated when additions are made (which means each
+	 * table needs to be refcounted for the processes using it). When a new
+	 * table is created, all the refcounters on the prog_list are bumped
+	 * (to track each table that references the prog). When a new prog is
+	 * added, it's just prepended to the list for the new table to point
+	 * at.
+	 *
+	 * Manage all the possible errors before this step to not uselessly
+	 * duplicate current_domain and avoid a rollback.
+	 */
+	if (!new_domain) {
+		/*
+		 * If there is no Landlock domain used by the current task,
+		 * then create a new one.
+		 */
+		new_domain = new_landlock_domain();
+		if (IS_ERR(new_domain))
+			goto put_tmp_lists;
+	} else if (refcount_read(&current_domain->usage) > 1) {
+		/*
+		 * If the current task is not the sole user of its Landlock
+		 * domain, then duplicate it.
+		 */
+		new_domain = new_landlock_domain();
+		if (IS_ERR(new_domain))
+			goto put_tmp_lists;
+		for (i = 0; i < ARRAY_SIZE(new_domain->programs); i++) {
+			new_domain->programs[i] =
+				READ_ONCE(current_domain->programs[i]);
+			if (new_domain->programs[i])
+				refcount_inc(&new_domain->programs[i]->usage);
+		}
+
+		/*
+		 * Landlock domain from the current task will not be freed here
+		 * because the usage is strictly greater than 1. It is only
+		 * prevented to be freed by another task thanks to the caller
+		 * of landlock_prepend_prog() which should be locked if needed.
+		 */
+		landlock_put_domain(current_domain);
+	}
+
+	/* prepend tmp_domain to new_domain */
+	for (i = 0; i < ARRAY_SIZE(tmp_domain.programs); i++) {
+		/* get the last new list */
+		struct landlock_prog_list *last_list =
+			tmp_domain.programs[i];
+
+		if (last_list) {
+			while (last_list->prev)
+				last_list = last_list->prev;
+			/* no need to increment usage (pointer replacement) */
+			last_list->prev = new_domain->programs[i];
+			new_domain->programs[i] = tmp_domain.programs[i];
+		}
+	}
+	return new_domain;
+
+put_tmp_lists:
+	for (i = 0; i < ARRAY_SIZE(tmp_domain.programs); i++)
+		put_landlock_prog_list(tmp_domain.programs[i]);
+	return new_domain;
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

