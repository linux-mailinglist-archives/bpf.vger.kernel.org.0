Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B159F6E9283
	for <lists+bpf@lfdr.de>; Thu, 20 Apr 2023 13:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234450AbjDTL10 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Apr 2023 07:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233978AbjDTL0x (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Apr 2023 07:26:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DBE42719;
        Thu, 20 Apr 2023 04:26:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6989961447;
        Thu, 20 Apr 2023 11:26:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1085BC433EF;
        Thu, 20 Apr 2023 11:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681989975;
        bh=aC110ozSeexrUJwUkn4Q50y4G7ef2ogpaAd5AZhlho8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fd98j1IQ+sg8xT8xsXFWObFJ7rT3GEWIguNDDhebb36Ihk+/sXYJ1E8s4/g92QXA1
         0CJy0dNWHRd4UrFVOqPbe8tHkpk8NaR7g8sy6POh8JQLRBWtnD19FOIBxG5B8lUvi9
         5lfWa/fbjNIPVYmdGcGWv2cZpOZhjh5ci3WVx/Dq0/uzPK14bMDBuf1eyjzHuQzq+G
         fHLQWtRZBO2ZMuPzONHHxlExdbU0FLGafYGYeQk+ixN35VPFqAQF83oDpOPwrElGvS
         9mOjtdmlKF9N0xq1zSdYRre4lWFpe8CbPDUUXqbt4sQFIIhv2f10w1pzxKWNGwCu3W
         ovqEbscZ2+qrQ==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     linux-trace-kernel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        mhiramat@kernel.org, Florent Revest <revest@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org
Subject: [PATCH v5 4/9] tracing/probes: Add tracepoint support on fprobe_event
Date:   Thu, 20 Apr 2023 20:26:10 +0900
Message-ID:  <168198997089.1795549.1009510263722958117.stgit@mhiramat.roam.corp.google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
In-Reply-To:  <168198993129.1795549.8306571027057356176.stgit@mhiramat.roam.corp.google.com>
References:  <168198993129.1795549.8306571027057356176.stgit@mhiramat.roam.corp.google.com>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Allow fprobe_event to trace raw tracepoints so that user can trace
tracepoints which don't have traceevent wrappers. This new event is
always available if fprobe event is enabled since the tracepoint is
disabled, trace-event and dynamic event is also not available.

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

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 include/linux/tracepoint-defs.h |    1 
 include/linux/tracepoint.h      |    5 ++
 kernel/trace/trace.c            |    1 
 kernel/trace/trace_eprobe.c     |    2 -
 kernel/trace/trace_fprobe.c     |  129 +++++++++++++++++++++++++++++++++++++--
 kernel/trace/trace_probe.c      |   15 +++--
 kernel/trace/trace_probe.h      |   14 ++++
 7 files changed, 152 insertions(+), 15 deletions(-)

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
index 6811e43c1b5c..37196aaf8930 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -303,6 +303,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 	__section("__tracepoints_strings") = #_name;			\
 	extern struct static_call_key STATIC_CALL_KEY(tp_func_##_name);	\
 	int __traceiter_##_name(void *__data, proto);			\
+	void __probestub_##_name(void *, proto);			\
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
index 4d7d5708d3cd..9da9c979faa3 100644
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
index 9dcc320b1158..8cf581568a14 100644
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
@@ -689,6 +698,21 @@ static int __register_trace_fprobe(struct trace_fprobe *tf)
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
@@ -699,6 +723,12 @@ static void __unregister_trace_fprobe(struct trace_fprobe *tf)
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
 
@@ -762,7 +792,8 @@ static int append_trace_fprobe(struct trace_fprobe *tf, struct trace_fprobe *to)
 {
 	int ret;
 
-	if (trace_fprobe_is_return(tf) != trace_fprobe_is_return(to)) {
+	if (trace_fprobe_is_return(tf) != trace_fprobe_is_return(to) ||
+	    trace_fprobe_is_tracepoint(tf) != trace_fprobe_is_tracepoint(to)) {
 		trace_probe_log_set_index(0);
 		trace_probe_log_err(0, DIFF_PROBE_TYPE);
 		return -EEXIST;
@@ -832,6 +863,58 @@ static int register_trace_fprobe(struct trace_fprobe *tf)
 	return ret;
 }
 
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
+struct tracepoint *find_tracepoint(const char *tp_name)
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
@@ -840,6 +923,8 @@ static int __trace_fprobe_create(int argc, const char *argv[])
 	 *      f[:[GRP/][EVENT]] [MOD:]KSYM [FETCHARGS]
 	 *  - Add fexit probe:
 	 *      f[N][:[GRP/][EVENT]] [MOD:]KSYM%return [FETCHARGS]
+	 *  - Add tracepoint probe:
+	 *      t[:[GRP/][EVENT]] TRACEPOINT [FETCHARGS]
 	 *
 	 * Fetch args:
 	 *  $retval	: fetch return value
@@ -865,10 +950,16 @@ static int __trace_fprobe_create(int argc, const char *argv[])
 	char buf[MAX_EVENT_NAME_LEN];
 	char gbuf[MAX_EVENT_NAME_LEN];
 	unsigned int flags = TPARG_FL_KERNEL;
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
@@ -902,14 +993,14 @@ static int __trace_fprobe_create(int argc, const char *argv[])
 
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
@@ -926,6 +1017,8 @@ static int __trace_fprobe_create(int argc, const char *argv[])
 	flags |= TPARG_FL_FENTRY;
 	if (is_return)
 		flags |= TPARG_FL_RETURN;
+	if (is_tracepoint)
+		flags |= TPARG_FL_TPOINT;
 
 	trace_probe_log_set_index(0);
 	if (event) {
@@ -937,8 +1030,11 @@ static int __trace_fprobe_create(int argc, const char *argv[])
 
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
@@ -952,6 +1048,18 @@ static int __trace_fprobe_create(int argc, const char *argv[])
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
@@ -1011,7 +1119,10 @@ static int trace_fprobe_show(struct seq_file *m, struct dyn_event *ev)
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
@@ -1068,6 +1179,10 @@ static __init int init_fprobe_trace_early(void)
 	if (ret)
 		return ret;
 
+	ret = register_tracepoint_module_notifier(&tracepoint_module_nb);
+	if (ret)
+		return ret;
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
index a2ee6d336bd8..6b23206068f7 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -360,10 +360,19 @@ int trace_probe_print_args(struct trace_seq *s, struct probe_arg *args, int nr_a
 #define TPARG_FL_RETURN BIT(0)
 #define TPARG_FL_KERNEL BIT(1)
 #define TPARG_FL_FENTRY BIT(2)
-#define TPARG_FL_TPOINT BIT(3)
+#define TPARG_FL_TEVENT BIT(3)
 #define TPARG_FL_USER   BIT(4)
 #define TPARG_FL_FPROBE BIT(5)
-#define TPARG_FL_MASK	GENMASK(5, 0)
+#define TPARG_FL_TPOINT BIT(6)
+#define TPARG_FL_MASK	GENMASK(6, 0)
+
+static inline bool tparg_is_function_entry(unsigned int flags)
+{
+	/* Tracpoint probe is also function entry */
+	unsigned int mask = TPARG_FL_MASK & ~TPARG_FL_TPOINT;
+
+	return (flags & mask) == (TPARG_FL_KERNEL | TPARG_FL_FENTRY);
+}
 
 extern int traceprobe_parse_probe_arg(struct trace_probe *tp, int i,
 				const char *argv, unsigned int flags);
@@ -410,6 +419,7 @@ extern int traceprobe_define_arg_fields(struct trace_event_call *event_call,
 	C(MAXACT_TOO_BIG,	"Maxactive is too big"),		\
 	C(BAD_PROBE_ADDR,	"Invalid probed address or symbol"),	\
 	C(BAD_RETPROBE,		"Retprobe address must be an function entry"), \
+	C(NO_TRACEPOINT,	"Tracepoint is not found"),		\
 	C(BAD_ADDR_SUFFIX,	"Invalid probed address suffix"), \
 	C(NO_GROUP_NAME,	"Group name is not specified"),		\
 	C(GROUP_TOO_LONG,	"Group name is too long"),		\

