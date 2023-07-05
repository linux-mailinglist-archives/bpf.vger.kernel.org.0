Return-Path: <bpf+bounces-4092-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36952748B4D
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 20:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 656091C20B9C
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 18:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A09914282;
	Wed,  5 Jul 2023 18:15:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0754A134A7
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 18:15:52 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BEBB1985
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 11:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688580949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cr2h91iK1BhRzl41+qr9b8AIAdoW4uuXRZNrsLrfkns=;
	b=b+OYW+BXhwoGj/X27Y79LkB/g9Jbat2JjemWKHAZ3w03oLSIsefgjEiwWMNBv1HtDhsx4I
	89fOPmjmTDq1PVKuBOt50rHdmpd/mRz6Zw4AohRRqf9q+pB4D8A8aJTP4kkmDiR5MTYsbU
	rv0I9+co2x3HvVcZyTF3eXpWhhpzJ1A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-638-Nhv5uZDOOuONs0L1KaIvxQ-1; Wed, 05 Jul 2023 14:15:46 -0400
X-MC-Unique: Nhv5uZDOOuONs0L1KaIvxQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5FD79800C7F;
	Wed,  5 Jul 2023 18:15:44 +0000 (UTC)
Received: from vschneid.remote.csb (unknown [10.42.28.164])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0565A18EB4;
	Wed,  5 Jul 2023 18:15:37 +0000 (UTC)
From: Valentin Schneider <vschneid@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-mm@kvack.org,
	bpf@vger.kernel.org,
	x86@kernel.org
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
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
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
Subject: [RFC PATCH 01/14] tracing/filters: Dynamically allocate filter_pred.regex
Date: Wed,  5 Jul 2023 19:12:43 +0100
Message-Id: <20230705181256.3539027-2-vschneid@redhat.com>
In-Reply-To: <20230705181256.3539027-1-vschneid@redhat.com>
References: <20230705181256.3539027-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Every predicate allocation includes a MAX_FILTER_STR_VAL (256) char array
in the regex field, even if the predicate function does not use the field.

A later commit will introduce a dynamically allocated cpumask to struct
filter_pred, which will require a dedicated freeing function. Bite the
bullet and make filter_pred.regex dynamically allocated.

While at it, reorder the fields of filter_pred to fill in the byte
holes. The struct now fits on a single cacheline.

No change in behaviour intended.

The kfree()'s were patched via Coccinelle:
  @@
  struct filter_pred *pred;
  @@

  -kfree(pred);
  +free_predicate(pred);

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 kernel/trace/trace_events_filter.c | 62 ++++++++++++++++++------------
 1 file changed, 37 insertions(+), 25 deletions(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 1dad64267878c..d999a218fe833 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -70,15 +70,15 @@ enum filter_pred_fn {
 };
 
 struct filter_pred {
-	enum filter_pred_fn 	fn_num;
-	u64 			val;
-	u64 			val2;
-	struct regex		regex;
+	struct regex		*regex;
 	unsigned short		*ops;
 	struct ftrace_event_field *field;
-	int 			offset;
+	u64			val;
+	u64			val2;
+	enum filter_pred_fn	fn_num;
+	int			offset;
 	int			not;
-	int 			op;
+	int			op;
 };
 
 /*
@@ -186,6 +186,12 @@ enum {
 	PROCESS_OR	= 4,
 };
 
+static void free_predicate(struct filter_pred *pred)
+{
+	kfree(pred->regex);
+	kfree(pred);
+}
+
 /*
  * Without going into a formal proof, this explains the method that is used in
  * parsing the logical expressions.
@@ -623,7 +629,7 @@ predicate_parse(const char *str, int nr_parens, int nr_preds,
 	kfree(inverts);
 	if (prog_stack) {
 		for (i = 0; prog_stack[i].pred; i++)
-			kfree(prog_stack[i].pred);
+			free_predicate(prog_stack[i].pred);
 		kfree(prog_stack);
 	}
 	return ERR_PTR(ret);
@@ -750,7 +756,7 @@ static int filter_pred_string(struct filter_pred *pred, void *event)
 	char *addr = (char *)(event + pred->offset);
 	int cmp, match;
 
-	cmp = pred->regex.match(addr, &pred->regex, pred->regex.field_len);
+	cmp = pred->regex->match(addr, pred->regex, pred->regex->field_len);
 
 	match = cmp ^ pred->not;
 
@@ -763,7 +769,7 @@ static __always_inline int filter_pchar(struct filter_pred *pred, char *str)
 	int len;
 
 	len = strlen(str) + 1;	/* including tailing '\0' */
-	cmp = pred->regex.match(str, &pred->regex, len);
+	cmp = pred->regex->match(str, pred->regex, len);
 
 	match = cmp ^ pred->not;
 
@@ -813,7 +819,7 @@ static int filter_pred_strloc(struct filter_pred *pred, void *event)
 	char *addr = (char *)(event + str_loc);
 	int cmp, match;
 
-	cmp = pred->regex.match(addr, &pred->regex, str_len);
+	cmp = pred->regex->match(addr, pred->regex, str_len);
 
 	match = cmp ^ pred->not;
 
@@ -836,7 +842,7 @@ static int filter_pred_strrelloc(struct filter_pred *pred, void *event)
 	char *addr = (char *)(&item[1]) + str_loc;
 	int cmp, match;
 
-	cmp = pred->regex.match(addr, &pred->regex, str_len);
+	cmp = pred->regex->match(addr, pred->regex, str_len);
 
 	match = cmp ^ pred->not;
 
@@ -874,7 +880,7 @@ static int filter_pred_comm(struct filter_pred *pred, void *event)
 {
 	int cmp;
 
-	cmp = pred->regex.match(current->comm, &pred->regex,
+	cmp = pred->regex->match(current->comm, pred->regex,
 				TASK_COMM_LEN);
 	return cmp ^ pred->not;
 }
@@ -1004,7 +1010,7 @@ enum regex_type filter_parse_regex(char *buff, int len, char **search, int *not)
 
 static void filter_build_regex(struct filter_pred *pred)
 {
-	struct regex *r = &pred->regex;
+	struct regex *r = pred->regex;
 	char *search;
 	enum regex_type type = MATCH_FULL;
 
@@ -1169,7 +1175,7 @@ static void free_prog(struct event_filter *filter)
 		return;
 
 	for (i = 0; prog[i].pred; i++)
-		kfree(prog[i].pred);
+		free_predicate(prog[i].pred);
 	kfree(prog);
 }
 
@@ -1553,9 +1559,12 @@ static int parse_pred(const char *str, void *data,
 			goto err_free;
 		}
 
-		pred->regex.len = len;
-		strncpy(pred->regex.pattern, str + s, len);
-		pred->regex.pattern[len] = 0;
+		pred->regex = kzalloc(sizeof(*pred->regex), GFP_KERNEL);
+		if (!pred->regex)
+			goto err_mem;
+		pred->regex->len = len;
+		strncpy(pred->regex->pattern, str + s, len);
+		pred->regex->pattern[len] = 0;
 
 	/* This is either a string, or an integer */
 	} else if (str[i] == '\'' || str[i] == '"') {
@@ -1597,9 +1606,12 @@ static int parse_pred(const char *str, void *data,
 			goto err_free;
 		}
 
-		pred->regex.len = len;
-		strncpy(pred->regex.pattern, str + s, len);
-		pred->regex.pattern[len] = 0;
+		pred->regex = kzalloc(sizeof(*pred->regex), GFP_KERNEL);
+		if (!pred->regex)
+			goto err_mem;
+		pred->regex->len = len;
+		strncpy(pred->regex->pattern, str + s, len);
+		pred->regex->pattern[len] = 0;
 
 		filter_build_regex(pred);
 
@@ -1608,7 +1620,7 @@ static int parse_pred(const char *str, void *data,
 
 		} else if (field->filter_type == FILTER_STATIC_STRING) {
 			pred->fn_num = FILTER_PRED_FN_STRING;
-			pred->regex.field_len = field->size;
+			pred->regex->field_len = field->size;
 
 		} else if (field->filter_type == FILTER_DYN_STRING) {
 			pred->fn_num = FILTER_PRED_FN_STRLOC;
@@ -1691,10 +1703,10 @@ static int parse_pred(const char *str, void *data,
 	return i;
 
 err_free:
-	kfree(pred);
+	free_predicate(pred);
 	return -EINVAL;
 err_mem:
-	kfree(pred);
+	free_predicate(pred);
 	return -ENOMEM;
 }
 
@@ -2287,8 +2299,8 @@ static int ftrace_function_set_filter_pred(struct filter_pred *pred,
 		return ret;
 
 	return __ftrace_function_set_filter(pred->op == OP_EQ,
-					    pred->regex.pattern,
-					    pred->regex.len,
+					    pred->regex->pattern,
+					    pred->regex->len,
 					    data);
 }
 
-- 
2.31.1


