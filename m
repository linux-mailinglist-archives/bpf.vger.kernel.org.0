Return-Path: <bpf+bounces-5502-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 591A575B43F
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 18:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 627BB1C21505
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 16:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6CC1DDD0;
	Thu, 20 Jul 2023 16:32:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8FA1DDC6
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 16:32:15 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB0E1BF2
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 09:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689870733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C96oWrbX6n5TlLE7O7XWEwueAW9U6q6ni5+a3A4c/ko=;
	b=Fzq5VeX/oNAV8SeegD62Oz6UsNbchnkDAQwHTKXo8TCtgPT+3sdAw4buZxR9Fw7nYLMGEh
	2lhZddf/wEn8fXi1DeICIxiDteHx1b16WTziR5VmqbTfrmXJ0FUm+INWxu3675Rm+TmcOe
	8dERwSv4IzuFN6I9ho8Liv1ynZ7Q4OA=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-649-TP5rCbtOO8Oz4kDb2HxfDg-1; Thu, 20 Jul 2023 12:32:11 -0400
X-MC-Unique: TP5rCbtOO8Oz4kDb2HxfDg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3FC5B1C05EA8;
	Thu, 20 Jul 2023 16:32:08 +0000 (UTC)
Received: from vschneid.remote.csb (unknown [10.42.28.48])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C8AC440C206F;
	Thu, 20 Jul 2023 16:31:49 +0000 (UTC)
From: Valentin Schneider <vschneid@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-mm@kvack.org,
	bpf@vger.kernel.org,
	x86@kernel.org,
	rcu@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Wanpeng Li <wanpengli@tencent.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>,
	Kees Cook <keescook@chromium.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Juerg Haefliger <juerg.haefliger@canonical.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Nadav Amit <namit@vmware.com>,
	Dan Carpenter <error27@gmail.com>,
	Chuang Wang <nashuiliang@gmail.com>,
	Yang Jihong <yangjihong1@huawei.com>,
	Petr Mladek <pmladek@suse.com>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Song Liu <song@kernel.org>,
	Julian Pidancet <julian.pidancet@oracle.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Dionna Glaze <dionnaglaze@google.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Juri Lelli <juri.lelli@redhat.com>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Yair Podemsky <ypodemsk@redhat.com>
Subject: [RFC PATCH v2 02/20] tracing/filters: Enable filtering a cpumask field by another cpumask
Date: Thu, 20 Jul 2023 17:30:38 +0100
Message-Id: <20230720163056.2564824-3-vschneid@redhat.com>
In-Reply-To: <20230720163056.2564824-1-vschneid@redhat.com>
References: <20230720163056.2564824-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The recently introduced ipi_send_cpumask trace event contains a cpumask
field, but it currently cannot be used in filter expressions.

Make event filtering aware of cpumask fields, and allow these to be
filtered by a user-provided cpumask.

The user-provided cpumask is to be given in cpulist format and wrapped as:
"CPUS{$cpulist}". The use of curly braces instead of parentheses is to
prevent predicate_parse() from parsing the contents of CPUS{...} as a
full-fledged predicate subexpression.

This enables e.g.:

$ trace-cmd record -e 'ipi_send_cpumask' -f 'cpumask & CPUS{2,4,6,8-32}'

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 include/linux/trace_events.h       |  1 +
 kernel/trace/trace_events_filter.c | 97 +++++++++++++++++++++++++++++-
 2 files changed, 96 insertions(+), 2 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 3930e676436c9..302be73918336 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -807,6 +807,7 @@ enum {
 	FILTER_RDYN_STRING,
 	FILTER_PTR_STRING,
 	FILTER_TRACE_FN,
+	FILTER_CPUMASK,
 	FILTER_COMM,
 	FILTER_CPU,
 	FILTER_STACKTRACE,
diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 91fc9990107f1..cb1863dfa280b 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -64,6 +64,7 @@ enum filter_pred_fn {
 	FILTER_PRED_FN_PCHAR_USER,
 	FILTER_PRED_FN_PCHAR,
 	FILTER_PRED_FN_CPU,
+	FILTER_PRED_FN_CPUMASK,
 	FILTER_PRED_FN_FUNCTION,
 	FILTER_PRED_FN_,
 	FILTER_PRED_TEST_VISITED,
@@ -71,6 +72,7 @@ enum filter_pred_fn {
 
 struct filter_pred {
 	struct regex		*regex;
+	struct cpumask          *mask;
 	unsigned short		*ops;
 	struct ftrace_event_field *field;
 	u64			val;
@@ -94,6 +96,8 @@ struct filter_pred {
 	C(TOO_MANY_OPEN,	"Too many '('"),			\
 	C(TOO_MANY_CLOSE,	"Too few '('"),				\
 	C(MISSING_QUOTE,	"Missing matching quote"),		\
+	C(MISSING_BRACE_OPEN,   "Missing '{'"),				\
+	C(MISSING_BRACE_CLOSE,  "Missing '}'"),				\
 	C(OPERAND_TOO_LONG,	"Operand too long"),			\
 	C(EXPECT_STRING,	"Expecting string field"),		\
 	C(EXPECT_DIGIT,		"Expecting numeric field"),		\
@@ -103,6 +107,7 @@ struct filter_pred {
 	C(BAD_SUBSYS_FILTER,	"Couldn't find or set field in one of a subsystem's events"), \
 	C(TOO_MANY_PREDS,	"Too many terms in predicate expression"), \
 	C(INVALID_FILTER,	"Meaningless filter expression"),	\
+	C(INVALID_CPULIST,	"Invalid cpulist"),	\
 	C(IP_FIELD_ONLY,	"Only 'ip' field is supported for function trace"), \
 	C(INVALID_VALUE,	"Invalid value (did you forget quotes)?"), \
 	C(NO_FUNCTION,		"Function not found"),			\
@@ -190,6 +195,7 @@ static void free_predicate(struct filter_pred *pred)
 {
 	if (pred) {
 		kfree(pred->regex);
+		kfree(pred->mask);
 		kfree(pred);
 	}
 }
@@ -877,6 +883,26 @@ static int filter_pred_cpu(struct filter_pred *pred, void *event)
 	}
 }
 
+/* Filter predicate for cpumask field vs user-provided cpumask */
+static int filter_pred_cpumask(struct filter_pred *pred, void *event)
+{
+	u32 item = *(u32 *)(event + pred->offset);
+	int loc = item & 0xffff;
+	const struct cpumask *mask = (event + loc);
+	const struct cpumask *cmp = pred->mask;
+
+	switch (pred->op) {
+	case OP_EQ:
+		return cpumask_equal(mask, cmp);
+	case OP_NE:
+		return !cpumask_equal(mask, cmp);
+	case OP_BAND:
+		return cpumask_intersects(mask, cmp);
+	default:
+		return 0;
+	}
+}
+
 /* Filter predicate for COMM. */
 static int filter_pred_comm(struct filter_pred *pred, void *event)
 {
@@ -1244,8 +1270,12 @@ static void filter_free_subsystem_filters(struct trace_subsystem_dir *dir,
 
 int filter_assign_type(const char *type)
 {
-	if (strstr(type, "__data_loc") && strstr(type, "char"))
-		return FILTER_DYN_STRING;
+	if (strstr(type, "__data_loc")) {
+		if (strstr(type, "char"))
+			return FILTER_DYN_STRING;
+		if (strstr(type, "cpumask_t"))
+			return FILTER_CPUMASK;
+		}
 
 	if (strstr(type, "__rel_loc") && strstr(type, "char"))
 		return FILTER_RDYN_STRING;
@@ -1357,6 +1387,8 @@ static int filter_pred_fn_call(struct filter_pred *pred, void *event)
 		return filter_pred_pchar(pred, event);
 	case FILTER_PRED_FN_CPU:
 		return filter_pred_cpu(pred, event);
+	case FILTER_PRED_FN_CPUMASK:
+		return filter_pred_cpumask(pred, event);
 	case FILTER_PRED_FN_FUNCTION:
 		return filter_pred_function(pred, event);
 	case FILTER_PRED_TEST_VISITED:
@@ -1568,6 +1600,67 @@ static int parse_pred(const char *str, void *data,
 		strncpy(pred->regex->pattern, str + s, len);
 		pred->regex->pattern[len] = 0;
 
+	} else if (!strncmp(str + i, "CPUS", 4)) {
+		unsigned int maskstart;
+		char *tmp;
+
+		switch (field->filter_type) {
+		case FILTER_CPUMASK:
+			break;
+		default:
+			parse_error(pe, FILT_ERR_ILLEGAL_FIELD_OP, pos + i);
+			goto err_free;
+		}
+
+		switch (op) {
+		case OP_EQ:
+		case OP_NE:
+		case OP_BAND:
+			break;
+		default:
+			parse_error(pe, FILT_ERR_ILLEGAL_FIELD_OP, pos + i);
+			goto err_free;
+		}
+
+		/* Skip CPUS */
+		i += 4;
+		if (str[i++] != '{') {
+			parse_error(pe, FILT_ERR_MISSING_BRACE_OPEN, pos + i);
+			goto err_free;
+		}
+		maskstart = i;
+
+		/* Walk the cpulist until closing } */
+		for (; str[i] && str[i] != '}'; i++);
+		if (str[i] != '}') {
+			parse_error(pe, FILT_ERR_MISSING_BRACE_CLOSE, pos + i);
+			goto err_free;
+		}
+
+		if (maskstart == i) {
+			parse_error(pe, FILT_ERR_INVALID_CPULIST, pos + i);
+			goto err_free;
+		}
+
+		/* Copy the cpulist between { and } */
+		tmp = kmalloc((i - maskstart) + 1, GFP_KERNEL);
+		strscpy(tmp, str + maskstart, (i - maskstart) + 1);
+
+		pred->mask = kzalloc(cpumask_size(), GFP_KERNEL);
+		if (!pred->mask)
+			goto err_mem;
+
+		/* Now parse it */
+		if (cpulist_parse(tmp, pred->mask)) {
+			parse_error(pe, FILT_ERR_INVALID_CPULIST, pos + i);
+			goto err_free;
+		}
+
+		/* Move along */
+		i++;
+		if (field->filter_type == FILTER_CPUMASK)
+			pred->fn_num = FILTER_PRED_FN_CPUMASK;
+
 	/* This is either a string, or an integer */
 	} else if (str[i] == '\'' || str[i] == '"') {
 		char q = str[i];
-- 
2.31.1


