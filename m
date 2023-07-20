Return-Path: <bpf+bounces-5505-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA72375B449
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 18:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CD96281DCF
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 16:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7BF19BBC;
	Thu, 20 Jul 2023 16:32:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F16523BDA
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 16:32:46 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658A41984
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 09:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689870763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=07XsHvqnmvZKa7o2IK/zebs5uLAhltI+FwSlNCiWefo=;
	b=UhxyuNI/Mr+vi2TzBjm+w56CG6oDBKHIVD3C4BLRVlso1FTlymPN3X4i9oVR8FNYtv3wae
	zSp7u7hzaQlWLXH9ZbZ4wUaGyeOFOurEBvZ9YZ6ncog5BIzdRMk4E5jFi7yGQ9eWYDm/gC
	wn/pDLBm8D60LoP9QO6PKJCese3czqw=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-171-KQfh-86JMfWenLLKyFLDqQ-1; Thu, 20 Jul 2023 12:32:41 -0400
X-MC-Unique: KQfh-86JMfWenLLKyFLDqQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A9EAF2812951;
	Thu, 20 Jul 2023 16:32:38 +0000 (UTC)
Received: from vschneid.remote.csb (unknown [10.42.28.48])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E955440C2070;
	Thu, 20 Jul 2023 16:32:30 +0000 (UTC)
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
Subject: [RFC PATCH v2 05/20] tracing/filters: Optimise cpumask vs cpumask filtering when user mask is a single CPU
Date: Thu, 20 Jul 2023 17:30:41 +0100
Message-Id: <20230720163056.2564824-6-vschneid@redhat.com>
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
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Steven noted that when the user-provided cpumask contains a single CPU,
then the filtering function can use a scalar as input instead of a
full-fledged cpumask.

Reuse do_filter_scalar_cpumask() when the input mask has a weight of one.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 kernel/trace/trace_events_filter.c | 35 +++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 3009d0c61b532..2fe65ddeb34ef 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -70,6 +70,7 @@ enum filter_pred_fn {
 	FILTER_PRED_FN_CPU,
 	FILTER_PRED_FN_CPU_CPUMASK,
 	FILTER_PRED_FN_CPUMASK,
+	FILTER_PRED_FN_CPUMASK_CPU,
 	FILTER_PRED_FN_FUNCTION,
 	FILTER_PRED_FN_,
 	FILTER_PRED_TEST_VISITED,
@@ -957,6 +958,22 @@ static int filter_pred_cpumask(struct filter_pred *pred, void *event)
 	return do_filter_cpumask(pred->op, mask, cmp);
 }
 
+/* Filter predicate for cpumask field vs user-provided scalar  */
+static int filter_pred_cpumask_cpu(struct filter_pred *pred, void *event)
+{
+	u32 item = *(u32 *)(event + pred->offset);
+	int loc = item & 0xffff;
+	const struct cpumask *mask = (event + loc);
+	unsigned int cpu = pred->val;
+
+	/*
+	 * This inverts the usual usage of the function (field is first element,
+	 * user parameter is second), but that's fine because the (scalar, mask)
+	 * operations used are symmetric.
+	 */
+	return do_filter_scalar_cpumask(pred->op, cpu, mask);
+}
+
 /* Filter predicate for COMM. */
 static int filter_pred_comm(struct filter_pred *pred, void *event)
 {
@@ -1453,6 +1470,8 @@ static int filter_pred_fn_call(struct filter_pred *pred, void *event)
 		return filter_pred_cpu_cpumask(pred, event);
 	case FILTER_PRED_FN_CPUMASK:
 		return filter_pred_cpumask(pred, event);
+	case FILTER_PRED_FN_CPUMASK_CPU:
+		return filter_pred_cpumask_cpu(pred, event);
 	case FILTER_PRED_FN_FUNCTION:
 		return filter_pred_function(pred, event);
 	case FILTER_PRED_TEST_VISITED:
@@ -1666,6 +1685,7 @@ static int parse_pred(const char *str, void *data,
 
 	} else if (!strncmp(str + i, "CPUS", 4)) {
 		unsigned int maskstart;
+		bool single;
 		char *tmp;
 
 		switch (field->filter_type) {
@@ -1724,8 +1744,21 @@ static int parse_pred(const char *str, void *data,
 
 		/* Move along */
 		i++;
+
+		/*
+		 * Optimisation: if the user-provided mask has a weight of one
+		 * then we can treat it as a scalar input.
+		 */
+		single = cpumask_weight(pred->mask) == 1;
+		if (single && field->filter_type == FILTER_CPUMASK) {
+			pred->val = cpumask_first(pred->mask);
+			kfree(pred->mask);
+		}
+
 		if (field->filter_type == FILTER_CPUMASK) {
-			pred->fn_num = FILTER_PRED_FN_CPUMASK;
+			pred->fn_num = single ?
+				FILTER_PRED_FN_CPUMASK_CPU :
+				FILTER_PRED_FN_CPUMASK;
 		} else if (field->filter_type == FILTER_CPU) {
 			pred->fn_num = FILTER_PRED_FN_CPU_CPUMASK;
 		} else {
-- 
2.31.1


