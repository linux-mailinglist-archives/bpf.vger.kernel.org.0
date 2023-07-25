Return-Path: <bpf+bounces-5850-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B143762060
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 19:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64D971C20F6D
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 17:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D661C2591F;
	Tue, 25 Jul 2023 17:41:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CB625140
	for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 17:41:39 +0000 (UTC)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41AC9193
	for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 10:41:36 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-403a3df88a8so44378781cf.3
        for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 10:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1690306895; x=1690911695;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WJvVodEb8nnJEl20cUTyJdImyktiXScfem+69qgqo3Q=;
        b=e5ID1UqXliZ+Zyl9RyCsKE4cEfBV1Yk3CrsZNrSv5V3zn6E8LT99TL1D17Nwe6Lqiv
         nW/9bnXAFTLNnHj1mEGcktsTtyeTL09GQF65dj1XCRs8uhbyeGqbtPrqeu2zjjCtPw6E
         CGqFZ4KvpaNSKdpjWcT/8chMGtdRtPBD4m7d8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690306895; x=1690911695;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WJvVodEb8nnJEl20cUTyJdImyktiXScfem+69qgqo3Q=;
        b=DGosxs/diVmpqVGcvmv0ub1+x4bBKqZU3Yrx41wfLHR3vyUjXf7AbU2I3cQNBLMnr7
         M9zD41tuNpZfb5hyAFLKvsyF2c/ljLO3JgEtcTkkkd0OWTfA7TkSvBQ4pvTPx68vLv2z
         R7Na1tOzzZ4v7PAHsgOv0pvw2rPw/HFn0M4S76KOnWXinfhI22MJ2DRLfbDKYTLB/ers
         VMPKIcAeLPWwHBMo3EJ9P+/tPH7/3POf1rhOl2jr4n+QQ8ZA/FaoVwXmxqrMWT7kRJEF
         7Xn5k2MKBg9PERknlNG+Mv5sYuAgtMWw7aPUdpD6OpsBYPCG0HMNSXmk+y+XAw/wQz9b
         vHYw==
X-Gm-Message-State: ABy/qLaqyJBME/cF6owyMnCb5M7rY5wIA31qTISv7Ub1OwGV6ufNQXuw
	Bf7c937tw/rhTpTBQo3e0VL1pA==
X-Google-Smtp-Source: APBJJlHBHpNnHoYZv15+3LbjPWhNhvppPgE8W+pmrg9pYJauopPMXA+KIqGV321IR1oTEDcTpImI2Q==
X-Received: by 2002:a05:622a:1742:b0:403:b6a9:b8f9 with SMTP id l2-20020a05622a174200b00403b6a9b8f9mr3981171qtk.36.1690306895263;
        Tue, 25 Jul 2023 10:41:35 -0700 (PDT)
Received: from [192.168.0.198] (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id z4-20020a05622a124400b004054b7cc490sm3480130qtx.73.2023.07.25.10.41.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 10:41:34 -0700 (PDT)
Message-ID: <1e254a35-d0c2-8d41-f020-21694945911a@joelfernandes.org>
Date: Tue, 25 Jul 2023 13:41:32 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFC PATCH v2 18/20] context_tracking,x86: Defer kernel text
 patching IPIs
Content-Language: en-US
To: Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
 bpf@vger.kernel.org, x86@kernel.org, rcu@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Nicolas Saenz Julienne <nsaenzju@redhat.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Wanpeng Li <wanpengli@tencent.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 Andy Lutomirski <luto@kernel.org>, Frederic Weisbecker
 <frederic@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>,
 Neeraj Upadhyay <quic_neeraju@quicinc.com>,
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Uladzislau Rezki <urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>,
 Lorenzo Stoakes <lstoakes@gmail.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Jason Baron <jbaron@akamai.com>, Kees Cook <keescook@chromium.org>,
 Sami Tolvanen <samitolvanen@google.com>, Ard Biesheuvel <ardb@kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Juerg Haefliger <juerg.haefliger@canonical.com>,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Nadav Amit <namit@vmware.com>, Dan Carpenter <error27@gmail.com>,
 Chuang Wang <nashuiliang@gmail.com>, Yang Jihong <yangjihong1@huawei.com>,
 Petr Mladek <pmladek@suse.com>, "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Song Liu <song@kernel.org>, Julian Pidancet <julian.pidancet@oracle.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Dionna Glaze
 <dionnaglaze@google.com>, =?UTF-8?Q?Thomas_Wei=c3=9fschuh?=
 <linux@weissschuh.net>, Juri Lelli <juri.lelli@redhat.com>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Yair Podemsky <ypodemsk@redhat.com>
References: <20230720163056.2564824-19-vschneid@redhat.com>
 <6EBAEEED-6F38-472D-BA31-9C61179EFA2F@joelfernandes.org>
 <xhsmhtttsru2s.mognet@vschneid.remote.csb>
From: Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <xhsmhtttsru2s.mognet@vschneid.remote.csb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/25/23 09:36, Valentin Schneider wrote:
> On 25/07/23 06:49, Joel Fernandes wrote:
>> Interesting series Valentin. Some high-level question/comments on this one:
>>
>>> On Jul 20, 2023, at 12:34 PM, Valentin Schneider <vschneid@redhat.com> wrote:
>>>
>>> ﻿text_poke_bp_batch() sends IPIs to all online CPUs to synchronize
>>> them vs the newly patched instruction. CPUs that are executing in userspace
>>> do not need this synchronization to happen immediately, and this is
>>> actually harmful interference for NOHZ_FULL CPUs.
>>
>> Does the amount of harm not correspond to practical frequency of text_poke?
>> How often does instruction patching really happen? If it is very infrequent
>> then I am not sure if it is that harmful.
>>
> 
> Being pushed over a latency threshold *once* is enough to impact the
> latency evaluation of your given system/application.
> 
> It's mainly about shielding the isolated, NOHZ_FULL CPUs from whatever the
> housekeeping CPUs may be up to (flipping static keys, loading kprobes,
> using ftrace...) - frequency of the interference isn't such a big part of
> the reasoning.

Makes sense.

>>> As the synchronization IPIs are sent using a blocking call, returning from
>>> text_poke_bp_batch() implies all CPUs will observe the patched
>>> instruction(s), and this should be preserved even if the IPI is deferred.
>>> In other words, to safely defer this synchronization, any kernel
>>> instruction leading to the execution of the deferred instruction
>>> sync (ct_work_flush()) must *not* be mutable (patchable) at runtime.
>>
>> If it is not infrequent, then are you handling the case where userland
>> spends multiple seconds before entering the kernel, and all this while
>> the blocking call waits? Perhaps in such situation you want the real IPI
>> to be sent out instead of the deferred one?
>>
> 
> The blocking call only waits for CPUs for which it queued a CSD. Deferred
> calls do not queue a CSD thus do not impact the waiting at all. See
> smp_call_function_many_cond().

Ah I see you are using on_each_cpu_cond(). I should have gone through
the other patch before making noise.

thanks,

 - Joel


