Return-Path: <bpf+bounces-6331-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA1F7681A3
	for <lists+bpf@lfdr.de>; Sat, 29 Jul 2023 21:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0CE01C209D2
	for <lists+bpf@lfdr.de>; Sat, 29 Jul 2023 19:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361E7174E9;
	Sat, 29 Jul 2023 19:55:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892507C
	for <bpf@vger.kernel.org>; Sat, 29 Jul 2023 19:55:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA441C433C7;
	Sat, 29 Jul 2023 19:55:48 +0000 (UTC)
Date: Sat, 29 Jul 2023 15:55:47 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
 bpf@vger.kernel.org, x86@kernel.org, rcu@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Wanpeng Li <wanpengli@tencent.com>, Vitaly
 Kuznetsov <vkuznets@redhat.com>, Andy Lutomirski <luto@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, Frederic Weisbecker <frederic@kernel.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Neeraj Upadhyay
 <quic_neeraju@quicinc.com>, Joel Fernandes <joel@joelfernandes.org>, Josh
 Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, Andrew Morton
 <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, Christoph
 Hellwig <hch@infradead.org>, Lorenzo Stoakes <lstoakes@gmail.com>, Josh
 Poimboeuf <jpoimboe@kernel.org>, Jason Baron <jbaron@akamai.com>, Kees Cook
 <keescook@chromium.org>, Sami Tolvanen <samitolvanen@google.com>, Ard
 Biesheuvel <ardb@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, Juerg
 Haefliger <juerg.haefliger@canonical.com>, Nicolas Saenz Julienne
 <nsaenz@kernel.org>, "Kirill A. Shutemov"
 <kirill.shutemov@linux.intel.com>, Nadav Amit <namit@vmware.com>, Dan
 Carpenter <error27@gmail.com>, Chuang Wang <nashuiliang@gmail.com>, Yang
 Jihong <yangjihong1@huawei.com>, Petr Mladek <pmladek@suse.com>, "Jason A.
 Donenfeld" <Jason@zx2c4.com>, Song Liu <song@kernel.org>, Julian Pidancet
 <julian.pidancet@oracle.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 Dionna Glaze <dionnaglaze@google.com>, Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?=
 <linux@weissschuh.net>, Juri Lelli <juri.lelli@redhat.com>, Daniel Bristot
 de Oliveira <bristot@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Yair Podemsky <ypodemsk@redhat.com>
Subject: Re: [RFC PATCH v2 06/20] tracing/filters: Optimise scalar vs
 cpumask filtering when the user mask is a single CPU
Message-ID: <20230729155547.35719a1f@rorschach.local.home>
In-Reply-To: <20230720163056.2564824-7-vschneid@redhat.com>
References: <20230720163056.2564824-1-vschneid@redhat.com>
	<20230720163056.2564824-7-vschneid@redhat.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Jul 2023 17:30:42 +0100
Valentin Schneider <vschneid@redhat.com> wrote:

> Steven noted that when the user-provided cpumask contains a single CPU,
> then the filtering function can use a scalar as input instead of a
> full-fledged cpumask.
> 
> When the mask contains a single CPU, directly re-use the unsigned field
> predicate functions. Transform '&' into '==' beforehand.
> 
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
> ---
>  kernel/trace/trace_events_filter.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
> index 2fe65ddeb34ef..54d642fabb7f1 100644
> --- a/kernel/trace/trace_events_filter.c
> +++ b/kernel/trace/trace_events_filter.c
> @@ -1750,7 +1750,7 @@ static int parse_pred(const char *str, void *data,
>  		 * then we can treat it as a scalar input.
>  		 */
>  		single = cpumask_weight(pred->mask) == 1;
> -		if (single && field->filter_type == FILTER_CPUMASK) {
> +		if (single && field->filter_type != FILTER_CPU) {
>  			pred->val = cpumask_first(pred->mask);
>  			kfree(pred->mask);
>  		}
> @@ -1761,6 +1761,11 @@ static int parse_pred(const char *str, void *data,
>  				FILTER_PRED_FN_CPUMASK;
>  		} else if (field->filter_type == FILTER_CPU) {
>  			pred->fn_num = FILTER_PRED_FN_CPU_CPUMASK;
> +		} else if (single) {
> +			pred->op = pred->op == OP_BAND ? OP_EQ : pred->op;

Nit, the above can be written as:

			pred->op = pret->op != OP_BAND ? : OP_EQ;

-- Steve


> +			pred->fn_num = select_comparison_fn(pred->op, field->size, false);
> +			if (pred->op == OP_NE)
> +				pred->not = 1;
>  		} else {
>  			switch (field->size) {
>  			case 8:


