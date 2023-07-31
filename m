Return-Path: <bpf+bounces-6438-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 818427694A6
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 13:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B23CD1C20A1A
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 11:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CDB01800E;
	Mon, 31 Jul 2023 11:21:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143DE18006
	for <bpf@vger.kernel.org>; Mon, 31 Jul 2023 11:21:00 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D8091713
	for <bpf@vger.kernel.org>; Mon, 31 Jul 2023 04:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690802453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=47HAhqvJlrFOjF3d3mT+sXNh9SqjQbM0s/wrTjkOtJg=;
	b=Epsu1sHEHyXjWzUEAKGS76KcvpmP0zgHZKHyeS3Uk0D1M89ucFcH63fE+oAzmmMlAl4TX9
	NhTld9OR1/83XP3n8hiPKGCc0yfR3k9Z/X8zzZdGArCrpP9Fv8Z5URcWG1ZSERmjtoE2Yd
	6BevUJaiMR7ZWf7fS9a0PZ43lyukJD8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-oLwvQwZDNeWQ3nD4AePA6Q-1; Mon, 31 Jul 2023 07:20:52 -0400
X-MC-Unique: oLwvQwZDNeWQ3nD4AePA6Q-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-63d246654dcso33291426d6.1
        for <bpf@vger.kernel.org>; Mon, 31 Jul 2023 04:20:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690802452; x=1691407252;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=47HAhqvJlrFOjF3d3mT+sXNh9SqjQbM0s/wrTjkOtJg=;
        b=K5ruZOn3P2R91J7Do9PAfieK9OJcJUfUfQX/KtPTEjRlOgtPaVLwthN/wdwu5mVDr2
         /yb6hAWvVovtZfuJe9xnYK9EV34tv4sXoWATIyRzye3wb7tleEukOFI27FNtEZeMy2I1
         3uu9t0+0SHEXrQm3+q3SMJjG8dAI4MXPcblV1RQxhr+QglH9M6ps7OeeNQBs+CPQuzP7
         AgaVKX4rcQQWuSGDDSnaAeid9DzEL4oxMLOwIRj0YUKi+zu/9LYN3bMiodV3h4LLXg1m
         xOIGfFVGOmVtTlJ76vIlD1lTjGlHXLCNGPpmVeI/vPpsnm90gYRdvvXrodgCoFWCT6ZY
         mJhw==
X-Gm-Message-State: ABy/qLZRmfhpOmi434Zvy8WXnBnOiGxiptS55MNXJNWrTfDjjGXMav8c
	K/civY7D5vo607RPsnIIQmgOCfGLcyVXqHjXhID+cbvCd4rIR5XPtMPNd3fGC4MTyeHoqw1AM53
	d7sAq2XkBEofW
X-Received: by 2002:a0c:e14d:0:b0:634:20f:471c with SMTP id c13-20020a0ce14d000000b00634020f471cmr6609383qvl.14.1690802451993;
        Mon, 31 Jul 2023 04:20:51 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGQmknuNkpt4OdqMMs+lcZsPQfXQHCOzlkWOeCIE2fDz4iRThyIeyibV6Yi3WqcRw7uGfKfaw==
X-Received: by 2002:a0c:e14d:0:b0:634:20f:471c with SMTP id c13-20020a0ce14d000000b00634020f471cmr6609334qvl.14.1690802451661;
        Mon, 31 Jul 2023 04:20:51 -0700 (PDT)
Received: from vschneid.remote.csb ([149.12.7.81])
        by smtp.gmail.com with ESMTPSA id n2-20020a0ce542000000b0061b5dbf1994sm3583834qvm.146.2023.07.31.04.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 04:20:51 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
 bpf@vger.kernel.org, x86@kernel.org, rcu@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave
 Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Paolo
 Bonzini <pbonzini@redhat.com>, Wanpeng Li <wanpengli@tencent.com>, Vitaly
 Kuznetsov <vkuznets@redhat.com>, Andy Lutomirski <luto@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, Frederic Weisbecker <frederic@kernel.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Neeraj Upadhyay
 <quic_neeraju@quicinc.com>, Joel Fernandes <joel@joelfernandes.org>, Josh
 Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, Andrew
 Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>,
 Christoph
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
 Dionna Glaze <dionnaglaze@google.com>, Thomas =?utf-8?Q?Wei=C3=9Fschuh?=
 <linux@weissschuh.net>, Juri Lelli <juri.lelli@redhat.com>, Daniel Bristot
 de Oliveira <bristot@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Yair Podemsky <ypodemsk@redhat.com>
Subject: Re: [RFC PATCH v2 06/20] tracing/filters: Optimise scalar vs
 cpumask filtering when the user mask is a single CPU
In-Reply-To: <20230729155547.35719a1f@rorschach.local.home>
References: <20230720163056.2564824-1-vschneid@redhat.com>
 <20230720163056.2564824-7-vschneid@redhat.com>
 <20230729155547.35719a1f@rorschach.local.home>
Date: Mon, 31 Jul 2023 12:20:41 +0100
Message-ID: <xhsmh1qgos4xi.mognet@vschneid.remote.csb>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 29/07/23 15:55, Steven Rostedt wrote:
> On Thu, 20 Jul 2023 17:30:42 +0100
> Valentin Schneider <vschneid@redhat.com> wrote:
>
>> Steven noted that when the user-provided cpumask contains a single CPU,
>> then the filtering function can use a scalar as input instead of a
>> full-fledged cpumask.
>>
>> When the mask contains a single CPU, directly re-use the unsigned field
>> predicate functions. Transform '&' into '==' beforehand.
>>
>> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
>> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
>> ---
>>  kernel/trace/trace_events_filter.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
>> index 2fe65ddeb34ef..54d642fabb7f1 100644
>> --- a/kernel/trace/trace_events_filter.c
>> +++ b/kernel/trace/trace_events_filter.c
>> @@ -1750,7 +1750,7 @@ static int parse_pred(const char *str, void *data,
>>               * then we can treat it as a scalar input.
>>               */
>>              single = cpumask_weight(pred->mask) == 1;
>> -		if (single && field->filter_type == FILTER_CPUMASK) {
>> +		if (single && field->filter_type != FILTER_CPU) {
>>                      pred->val = cpumask_first(pred->mask);
>>                      kfree(pred->mask);
>>              }
>> @@ -1761,6 +1761,11 @@ static int parse_pred(const char *str, void *data,
>>                              FILTER_PRED_FN_CPUMASK;
>>              } else if (field->filter_type == FILTER_CPU) {
>>                      pred->fn_num = FILTER_PRED_FN_CPU_CPUMASK;
>> +		} else if (single) {
>> +			pred->op = pred->op == OP_BAND ? OP_EQ : pred->op;
>
> Nit, the above can be written as:
>
>                       pred->op = pret->op != OP_BAND ? : OP_EQ;
>

That's neater, thanks!

> -- Steve
>
>
>> +			pred->fn_num = select_comparison_fn(pred->op, field->size, false);
>> +			if (pred->op == OP_NE)
>> +				pred->not = 1;
>>              } else {
>>                      switch (field->size) {
>>                      case 8:


