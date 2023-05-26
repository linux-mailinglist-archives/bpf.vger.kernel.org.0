Return-Path: <bpf+bounces-1273-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB32711EC3
	for <lists+bpf@lfdr.de>; Fri, 26 May 2023 06:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E5971C20F41
	for <lists+bpf@lfdr.de>; Fri, 26 May 2023 04:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9AC210D;
	Fri, 26 May 2023 04:18:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EAB23C8
	for <bpf@vger.kernel.org>; Fri, 26 May 2023 04:18:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CF01C4339C;
	Fri, 26 May 2023 04:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685074724;
	bh=+8yCKChwwWBHMSVvVV6UmCLFaRX1QVr7N8efXNLMNhw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eMRRZTkdjqaG+MYv5PUfIb46Y8UFEoGP+NzPp3aR25zLXsz1XYLoMVrn1TggzUSAs
	 LGPWODN0+rJ364t4a4aPGg744T+Jhvtpra44FBgKn+HmmySY0TsynoY0+LmBcR+j8H
	 TOZ3EKwu3YiwUAIbe0AbjlsUlilzp7BibKWw57Uw7hvqZuwSMWEcdnsjUjleWPUP8u
	 GFG1M/YDt7n7e13avqH98q6wN9eq+2ReVCs7OA/WMKv3ItuPkWtlG2tdRW87H4H9zQ
	 8A7FiIdXDfhxj8dWJi9dYf5WB6QM3SA94skeWcvE3XgVyihHV/P3PjzSb0vJMGTq4w
	 47g+KUs6Nu+Iw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	mhiramat@kernel.org,
	Florent Revest <revest@chromium.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	bpf@vger.kernel.org,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH v13 05/12] tracing/probes: Add tracepoint support on fprobe_events
Date: Fri, 26 May 2023 12:18:38 +0800
Message-ID:  <168507471874.913472.17214624519622959593.stgit@mhiramat.roam.corp.google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
In-Reply-To:  <168507466597.913472.10572827237387849017.stgit@mhiramat.roam.corp.google.com>
References:  <168507466597.913472.10572827237387849017.stgit@mhiramat.roam.corp.google.com>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Allow fprobe_events to trace raw tracepoints so that user can trace
tracepoints which don't have traceevent wrappers. This new event is
always available if the fprobe_events is enabled (thus no kconfig),
because the fprobe_events depends on the trace-event and traceporint.

e.g.
 # echo 't sched_overutilized_tp' >> dynamic_events
 # echo 't 9p_client_req' >> dynamic_events
 # cat dynamic_events
t:tracepoints/sched_overutilized_tp sched_overutilized_tp
t:tracepoints/_9p_client_req 9p_client_req

The event name is based on the tracepoint name, but if it is started
with digit character, an underscore '_' will be added.

NOTE: to avoid further confusion, this renames TPARG_FL_TPOINT to
TPARG_FL_TEVENT because this flag is used for eprobe (trace-event probe).
And reuse TPARG_FL_TPOINT for this raw tracepoint probe.

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202305020453.afTJ3VVp-lkp@intel.com/
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
Changes in v13:
 - Add a comment about new flags.
Changes in v9.1:
 - Fix !CONFIG_MODULES case.
Changes in v6:
 - Update description
 - Make find_tracepoint() static.
 - Fix some checkpatches warnings.
---
 include/linux/tracepoint-defs.h |    1 
 include/linux/tracepoint.h      |    5 +
 kernel/trace/trace.c            |    1 
 kernel/trace/trace_eprobe.c     |    2 -
 kernel/trace/trace_fprobe.c     |  134 +++++++++++++++++++++++++++++++++++++--
 kernel/trace/trace_probe.c      |   15 +++-
 kernel/trace/trace_probe.h      |   15 +++-
 7 files changed, 157 insertions(+), 16 deletions(-)

diff --git a/include/linux/tracepoint-defs.h b/include/linux/tracepoint-defs.h
index e7c2276be33e..4dc4955f0fbf 100644
--- a/include/linux/tracepoint-defs.h
+++ b/include/linux/tracepoint-defs.h
@@ -35,6 +35,7 @@ struct tracepoint {
 	struct static_call_key *static_call_key;
 	void *static_call_tramp;
 	void *iterator;
+	void *probestub;
 	int (*regfunc)(void);
 	void (*unregfunc)(void);
 	struct tracepoint_func __rcu *funcs;
diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 6811e43c1b5c..88c0ba623ee6 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -303,6 +303,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 	__section("__tracepoints_strings") = #_name;			\
 	extern struct static_call_key STATIC_CALL_KEY(tp_func_##_name);	\
 	int __traceiter_##_name(void *__data, proto);			\
+	void __probestub_##_name(void *__data, proto);			\
 	struct tracepoint __tracepoint_##_name	__used			\
 	__section("__tracepoints") = {					\
 		.name = __tpstrtab_##_name,				\
@@ -310,6 +311,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 		.static_call_key = &STATIC_CALL_KEY(tp_func_##_name),	\
 		.static_call_tramp = STATIC_CALL_TRAMP_ADDR(tp_func_##_name), \
 		.iterator = &__traceiter_##_name,			\
+		.probestub = &__probestub_##_name,			\
 		.regfunc = _reg,					\
 		.unregfunc = _unreg,					\
 		.funcs = NULL };					\
@@ -330,6 +332,9 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 		}							\
 		return 0;						\
 	}								\
+	void __probestub_##_name(void *__data, proto)			\
+	{								\
+	}								\
 	DEFINE_STATIC_CALL(tp_func_##_name, __traceiter_##_name);
 
 #define DEFINE_TRACE(name, proto, args)		\
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index d595cef93122..abcc2ca615e8 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5653,6 +5653,7 @@ static const char readme_msg[] =
 #endif
 #ifdef CONFIG_FPROBE_EVENTS
 	"\t           f[:[<group>/][<event>]] <func-name>[%return] [<args>]\n"
+	"\t           t[:[<group>/][<event>]] <tracepoint> [<args>]\n"
 #endif
 #ifdef CONFIG_HIST_TRIGGERS
 	"\t           s:[synthetic/]<event> <field> [<field>]\n"
diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index 67e854979d53..fd64cd5d5745 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -817,7 +817,7 @@ find_and_get_event(const char *system, const char *event_name)
 
 static int trace_eprobe_tp_update_arg(struct trace_eprobe *ep, const char *argv[], int i)
 {
-	unsigned int flags = TPARG_FL_KERNEL | TPARG_FL_TPOINT;
+	unsigned int flags = TPARG_FL_KERNEL | TPARG_FL_TEVENT;
 	int ret;
 
 	ret = traceprobe_parse_probe_arg(&ep->tp, i, argv[i], flags);
diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
index 48dbbc72b7dd..aa71ccb4205c 100644
--- a/kernel/trace/trace_fprobe.c
+++ b/kernel/trace/trace_fprobe.c
@@ -9,6 +9,7 @@
 #include <linux/module.h>
 #include <linux/rculist.h>
 #include <linux/security.h>
+#include <linux/tracepoint.h>
 #include <linux/uaccess.h>
 
 #include "trace_dynevent.h"
@@ -17,6 +18,7 @@
 #include "trace_probe_tmpl.h"
 
 #define FPROBE_EVENT_SYSTEM "fprobes"
+#define TRACEPOINT_EVENT_SYSTEM "tracepoints"
 #define RETHOOK_MAXACTIVE_MAX 4096
 
 static int trace_fprobe_create(const char *raw_command);
@@ -41,6 +43,8 @@ struct trace_fprobe {
 	struct dyn_event	devent;
 	struct fprobe		fp;
 	const char		*symbol;
+	struct tracepoint	*tpoint;
+	struct module		*mod;
 	struct trace_probe	tp;
 };
 
@@ -68,6 +72,11 @@ static bool trace_fprobe_is_return(struct trace_fprobe *tf)
 	return tf->fp.exit_handler != NULL;
 }
 
+static bool trace_fprobe_is_tracepoint(struct trace_fprobe *tf)
+{
+	return tf->tpoint != NULL;
+}
+
 static const char *trace_fprobe_symbol(struct trace_fprobe *tf)
 {
 	return tf->symbol ? tf->symbol : "unknown";
@@ -668,6 +677,21 @@ static int __register_trace_fprobe(struct trace_fprobe *tf)
 	else
 		tf->fp.flags |= FPROBE_FL_DISABLED;
 
+	if (trace_fprobe_is_tracepoint(tf)) {
+		struct tracepoint *tpoint = tf->tpoint;
+		unsigned long ip = (unsigned long)tpoint->probestub;
+		/*
+		 * Here, we do 2 steps to enable fprobe on a tracepoint.
+		 * At first, put __probestub_##TP function on the tracepoint
+		 * and put a fprobe on the stub function.
+		 */
+		ret = tracepoint_probe_register_prio_may_exist(tpoint,
+					tpoint->probestub, NULL, 0);
+		if (ret < 0)
+			return ret;
+		return register_fprobe_ips(&tf->fp, &ip, 1);
+	}
+
 	/* TODO: handle filter, nofilter or symbol list */
 	return register_fprobe(&tf->fp, tf->symbol, NULL);
 }
@@ -678,6 +702,12 @@ static void __unregister_trace_fprobe(struct trace_fprobe *tf)
 	if (trace_fprobe_is_registered(tf)) {
 		unregister_fprobe(&tf->fp);
 		memset(&tf->fp, 0, sizeof(tf->fp));
+		if (trace_fprobe_is_tracepoint(tf)) {
+			tracepoint_probe_unregister(tf->tpoint,
+					tf->tpoint->probestub, NULL);
+			tf->tpoint = NULL;
+			tf->mod = NULL;
+		}
 	}
 }
 
@@ -741,7 +771,8 @@ static int append_trace_fprobe(struct trace_fprobe *tf, struct trace_fprobe *to)
 {
 	int ret;
 
-	if (trace_fprobe_is_return(tf) != trace_fprobe_is_return(to)) {
+	if (trace_fprobe_is_return(tf) != trace_fprobe_is_return(to) ||
+	    trace_fprobe_is_tracepoint(tf) != trace_fprobe_is_tracepoint(to)) {
 		trace_probe_log_set_index(0);
 		trace_probe_log_err(0, DIFF_PROBE_TYPE);
 		return -EEXIST;
@@ -811,6 +842,60 @@ static int register_trace_fprobe(struct trace_fprobe *tf)
 	return ret;
 }
 
+#ifdef CONFIG_MODULES
+static int __tracepoint_probe_module_cb(struct notifier_block *self,
+					unsigned long val, void *data)
+{
+	struct tp_module *tp_mod = data;
+	struct trace_fprobe *tf;
+	struct dyn_event *pos;
+
+	if (val != MODULE_STATE_GOING)
+		return NOTIFY_DONE;
+
+	mutex_lock(&event_mutex);
+	for_each_trace_fprobe(tf, pos) {
+		if (tp_mod->mod == tf->mod) {
+			tracepoint_probe_unregister(tf->tpoint,
+					tf->tpoint->probestub, NULL);
+			tf->tpoint = NULL;
+			tf->mod = NULL;
+		}
+	}
+	mutex_unlock(&event_mutex);
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block tracepoint_module_nb = {
+	.notifier_call = __tracepoint_probe_module_cb,
+};
+#endif /* CONFIG_MODULES */
+
+struct __find_tracepoint_cb_data {
+	const char *tp_name;
+	struct tracepoint *tpoint;
+};
+
+static void __find_tracepoint_cb(struct tracepoint *tp, void *priv)
+{
+	struct __find_tracepoint_cb_data *data = priv;
+
+	if (!data->tpoint && !strcmp(data->tp_name, tp->name))
+		data->tpoint = tp;
+}
+
+static struct tracepoint *find_tracepoint(const char *tp_name)
+{
+	struct __find_tracepoint_cb_data data = {
+		.tp_name = tp_name,
+	};
+
+	for_each_kernel_tracepoint(__find_tracepoint_cb, &data);
+
+	return data.tpoint;
+}
+
 static int __trace_fprobe_create(int argc, const char *argv[])
 {
 	/*
@@ -819,6 +904,8 @@ static int __trace_fprobe_create(int argc, const char *argv[])
 	 *      f[:[GRP/][EVENT]] [MOD:]KSYM [FETCHARGS]
 	 *  - Add fexit probe:
 	 *      f[N][:[GRP/][EVENT]] [MOD:]KSYM%return [FETCHARGS]
+	 *  - Add tracepoint probe:
+	 *      t[:[GRP/][EVENT]] TRACEPOINT [FETCHARGS]
 	 *
 	 * Fetch args:
 	 *  $retval	: fetch return value
@@ -844,10 +931,16 @@ static int __trace_fprobe_create(int argc, const char *argv[])
 	char buf[MAX_EVENT_NAME_LEN];
 	char gbuf[MAX_EVENT_NAME_LEN];
 	unsigned int flags = TPARG_FL_KERNEL | TPARG_FL_FPROBE;
+	bool is_tracepoint = false;
 
-	if (argv[0][0] != 'f' || argc < 2)
+	if ((argv[0][0] != 'f' && argv[0][0] != 't') || argc < 2)
 		return -ECANCELED;
 
+	if (argv[0][0] == 't') {
+		is_tracepoint = true;
+		group = TRACEPOINT_EVENT_SYSTEM;
+	}
+
 	trace_probe_log_init("trace_fprobe", argc, argv);
 
 	event = strchr(&argv[0][1], ':');
@@ -881,14 +974,14 @@ static int __trace_fprobe_create(int argc, const char *argv[])
 
 	trace_probe_log_set_index(1);
 
-	/* a symbol specified */
+	/* a symbol(or tracepoint) must be specified */
 	symbol = kstrdup(argv[1], GFP_KERNEL);
 	if (!symbol)
 		return -ENOMEM;
 
 	tmp = strchr(symbol, '%');
 	if (tmp) {
-		if (!strcmp(tmp, "%return")) {
+		if (!is_tracepoint && !strcmp(tmp, "%return")) {
 			*tmp = '\0';
 			is_return = true;
 		} else {
@@ -907,6 +1000,9 @@ static int __trace_fprobe_create(int argc, const char *argv[])
 	else
 		flags |= TPARG_FL_FENTRY;
 
+	if (is_tracepoint)
+		flags |= TPARG_FL_TPOINT;
+
 	trace_probe_log_set_index(0);
 	if (event) {
 		ret = traceprobe_parse_event_name(&event, &group, gbuf,
@@ -917,8 +1013,11 @@ static int __trace_fprobe_create(int argc, const char *argv[])
 
 	if (!event) {
 		/* Make a new event name */
-		snprintf(buf, MAX_EVENT_NAME_LEN, "%s__%s", symbol,
-			 is_return ? "exit" : "entry");
+		if (is_tracepoint)
+			strscpy(buf, symbol, MAX_EVENT_NAME_LEN);
+		else
+			snprintf(buf, MAX_EVENT_NAME_LEN, "%s__%s", symbol,
+				 is_return ? "exit" : "entry");
 		sanitize_event_name(buf);
 		event = buf;
 	}
@@ -932,6 +1031,18 @@ static int __trace_fprobe_create(int argc, const char *argv[])
 		WARN_ON_ONCE(ret != -ENOMEM);
 		goto out;	/* We know tf is not allocated */
 	}
+
+	if (is_tracepoint) {
+		tf->tpoint = find_tracepoint(tf->symbol);
+		if (!tf->tpoint) {
+			trace_probe_log_set_index(1);
+			trace_probe_log_err(0, NO_TRACEPOINT);
+			goto parse_error;
+		}
+		tf->mod = __module_text_address(
+				(unsigned long)tf->tpoint->probestub);
+	}
+
 	argc -= 2; argv += 2;
 
 	/* parse arguments */
@@ -991,7 +1102,10 @@ static int trace_fprobe_show(struct seq_file *m, struct dyn_event *ev)
 	struct trace_fprobe *tf = to_trace_fprobe(ev);
 	int i;
 
-	seq_putc(m, 'f');
+	if (trace_fprobe_is_tracepoint(tf))
+		seq_putc(m, 't');
+	else
+		seq_putc(m, 'f');
 	if (trace_fprobe_is_return(tf) && tf->fp.nr_maxactive)
 		seq_printf(m, "%d", tf->fp.nr_maxactive);
 	seq_printf(m, ":%s/%s", trace_probe_group_name(&tf->tp),
@@ -1048,6 +1162,12 @@ static __init int init_fprobe_trace_early(void)
 	if (ret)
 		return ret;
 
+#ifdef CONFIG_MODULES
+	ret = register_tracepoint_module_notifier(&tracepoint_module_nb);
+	if (ret)
+		return ret;
+#endif
+
 	return 0;
 }
 core_initcall(init_fprobe_trace_early);
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 8646b097d56c..dffbed2ddae9 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -292,7 +292,7 @@ static int parse_probe_vars(char *arg, const struct fetch_type *t,
 	int ret = 0;
 	int len;
 
-	if (flags & TPARG_FL_TPOINT) {
+	if (flags & TPARG_FL_TEVENT) {
 		if (code->data)
 			return -EFAULT;
 		code->data = kstrdup(arg, GFP_KERNEL);
@@ -326,8 +326,7 @@ static int parse_probe_vars(char *arg, const struct fetch_type *t,
 	} else if (strcmp(arg, "comm") == 0 || strcmp(arg, "COMM") == 0) {
 		code->op = FETCH_OP_COMM;
 #ifdef CONFIG_HAVE_FUNCTION_ARG_ACCESS_API
-	} else if (((flags & TPARG_FL_MASK) ==
-		    (TPARG_FL_KERNEL | TPARG_FL_FENTRY)) &&
+	} else if (tparg_is_function_entry(flags) &&
 		   (len = str_has_prefix(arg, "arg"))) {
 		ret = kstrtoul(arg + len, 10, &param);
 		if (ret) {
@@ -338,6 +337,12 @@ static int parse_probe_vars(char *arg, const struct fetch_type *t,
 		}
 		code->op = FETCH_OP_ARG;
 		code->param = (unsigned int)param - 1;
+		/*
+		 * The tracepoint probe will probe a stub function, and the
+		 * first parameter of the stub is a dummy and should be ignored.
+		 */
+		if (flags & TPARG_FL_TPOINT)
+			code->param++;
 #endif
 	} else
 		goto inval_var;
@@ -393,7 +398,7 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
 		break;
 
 	case '%':	/* named register */
-		if (flags & (TPARG_FL_TPOINT | TPARG_FL_FPROBE)) {
+		if (flags & (TPARG_FL_TEVENT | TPARG_FL_FPROBE)) {
 			/* eprobe and fprobe do not handle registers */
 			trace_probe_log_err(offs, BAD_VAR);
 			break;
@@ -633,7 +638,7 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
 	 * Since $comm and immediate string can not be dereferenced,
 	 * we can find those by strcmp. But ignore for eprobes.
 	 */
-	if (!(flags & TPARG_FL_TPOINT) &&
+	if (!(flags & TPARG_FL_TEVENT) &&
 	    (strcmp(arg, "$comm") == 0 || strcmp(arg, "$COMM") == 0 ||
 	     strncmp(arg, "\\\"", 2) == 0)) {
 		/* The type of $comm must be "string", and not an array. */
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index cf146a7b7f81..7a0703c00a7d 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -359,16 +359,24 @@ int trace_probe_print_args(struct trace_seq *s, struct probe_arg *args, int nr_a
 
 /*
  * The flags used for parsing trace_probe arguments.
- * TPARG_FL_RETURN, TPARG_FL_FENTRY and TPARG_FL_TPOINT are mutually exclusive.
+ * TPARG_FL_RETURN, TPARG_FL_FENTRY and TPARG_FL_TEVENT are mutually exclusive.
  * TPARG_FL_KERNEL and TPARG_FL_USER are also mutually exclusive.
+ * TPARG_FL_FPROBE and TPARG_FL_TPOINT are optional but it should be with
+ * TPARG_FL_KERNEL.
  */
 #define TPARG_FL_RETURN BIT(0)
 #define TPARG_FL_KERNEL BIT(1)
 #define TPARG_FL_FENTRY BIT(2)
-#define TPARG_FL_TPOINT BIT(3)
+#define TPARG_FL_TEVENT BIT(3)
 #define TPARG_FL_USER   BIT(4)
 #define TPARG_FL_FPROBE BIT(5)
-#define TPARG_FL_MASK	GENMASK(4, 0)
+#define TPARG_FL_TPOINT BIT(6)
+#define TPARG_FL_LOC_MASK	GENMASK(4, 0)
+
+static inline bool tparg_is_function_entry(unsigned int flags)
+{
+	return (flags & TPARG_FL_LOC_MASK) == (TPARG_FL_KERNEL | TPARG_FL_FENTRY);
+}
 
 extern int traceprobe_parse_probe_arg(struct trace_probe *tp, int i,
 				const char *argv, unsigned int flags);
@@ -415,6 +423,7 @@ extern int traceprobe_define_arg_fields(struct trace_event_call *event_call,
 	C(MAXACT_TOO_BIG,	"Maxactive is too big"),		\
 	C(BAD_PROBE_ADDR,	"Invalid probed address or symbol"),	\
 	C(BAD_RETPROBE,		"Retprobe address must be an function entry"), \
+	C(NO_TRACEPOINT,	"Tracepoint is not found"),		\
 	C(BAD_ADDR_SUFFIX,	"Invalid probed address suffix"), \
 	C(NO_GROUP_NAME,	"Group name is not specified"),		\
 	C(GROUP_TOO_LONG,	"Group name is too long"),		\


