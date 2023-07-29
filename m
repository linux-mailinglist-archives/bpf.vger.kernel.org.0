Return-Path: <bpf+bounces-6329-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C50B3768137
	for <lists+bpf@lfdr.de>; Sat, 29 Jul 2023 21:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA30D1C20A0D
	for <lists+bpf@lfdr.de>; Sat, 29 Jul 2023 19:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3FB174DC;
	Sat, 29 Jul 2023 19:09:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11E8171D6
	for <bpf@vger.kernel.org>; Sat, 29 Jul 2023 19:09:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E1ADC433C7;
	Sat, 29 Jul 2023 19:09:03 +0000 (UTC)
Date: Sat, 29 Jul 2023 15:09:01 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kvm@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org,
 x86@kernel.org, rcu@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Wanpeng Li <wanpengli@tencent.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Frederic Weisbecker <frederic@kernel.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, Neeraj Upadhyay <quic_neeraju@quicinc.com>, Joel
 Fernandes <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>,
 Boqun Feng <boqun.feng@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Zqiang <qiang.zhang1211@gmail.com>, Andrew Morton
 <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, Christoph
 Hellwig <hch@infradead.org>, Lorenzo Stoakes <lstoakes@gmail.com>, Jason
 Baron <jbaron@akamai.com>, Kees Cook <keescook@chromium.org>, Sami Tolvanen
 <samitolvanen@google.com>, Ard Biesheuvel <ardb@kernel.org>, Nicholas
 Piggin <npiggin@gmail.com>, Juerg Haefliger
 <juerg.haefliger@canonical.com>, Nicolas Saenz Julienne
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
Subject: Re: [RFC PATCH v2 02/20] tracing/filters: Enable filtering a
 cpumask field by another cpumask
Message-ID: <20230729150901.25b9ae0c@rorschach.local.home>
In-Reply-To: <20230726194148.4jhyqqbtn3qqqqsq@treble>
References: <20230720163056.2564824-1-vschneid@redhat.com>
	<20230720163056.2564824-3-vschneid@redhat.com>
	<20230726194148.4jhyqqbtn3qqqqsq@treble>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Jul 2023 12:41:48 -0700
Josh Poimboeuf <jpoimboe@kernel.org> wrote:

> On Thu, Jul 20, 2023 at 05:30:38PM +0100, Valentin Schneider wrote:
> >  int filter_assign_type(const char *type)
> >  {
> > -	if (strstr(type, "__data_loc") && strstr(type, "char"))
> > -		return FILTER_DYN_STRING;
> > +	if (strstr(type, "__data_loc")) {
> > +		if (strstr(type, "char"))
> > +			return FILTER_DYN_STRING;
> > +		if (strstr(type, "cpumask_t"))
> > +			return FILTER_CPUMASK;
> > +		}  
> 
> The closing bracket has the wrong indentation.
> 
> > +		/* Copy the cpulist between { and } */
> > +		tmp = kmalloc((i - maskstart) + 1, GFP_KERNEL);
> > +		strscpy(tmp, str + maskstart, (i - maskstart) + 1);  
> 
> Need to check kmalloc() failure?  And also free tmp?

I came to state the same thing.

Also, when you do an empty for loop:

	for (; str[i] && str[i] != '}'; i++);

Always put the semicolon on the next line, otherwise it is really easy
to think that the next line is part of the for loop. That is, instead
of the above, do:

	for (; str[i] && str[i] != '}'; i++)
		;


-- Steve


> 
> > +
> > +		pred->mask = kzalloc(cpumask_size(), GFP_KERNEL);
> > +		if (!pred->mask)
> > +			goto err_mem;
> > +
> > +		/* Now parse it */
> > +		if (cpulist_parse(tmp, pred->mask)) {
> > +			parse_error(pe, FILT_ERR_INVALID_CPULIST, pos + i);
> > +			goto err_free;
> > +		}
> > +
> > +		/* Move along */
> > +		i++;
> > +		if (field->filter_type == FILTER_CPUMASK)
> > +			pred->fn_num = FILTER_PRED_FN_CPUMASK;
> > +  
> 


