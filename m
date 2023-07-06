Return-Path: <bpf+bounces-4225-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D59749AA4
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 13:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 797AA281280
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 11:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C966E8C03;
	Thu,  6 Jul 2023 11:31:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E418BFA
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 11:31:27 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03E61BEA
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 04:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688643080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YUOZEoZh3tniSwu0Lc1VH/leg3NuusrIfXtvdOdkp+U=;
	b=GAP+5qy64HiGUi/Yu5pzuSNUHxUdy2i1KEhlFHSa2K6iIvdSUDWtwUtVlRRPZ+r/7DFCGg
	g/8n3HaOrYserd6z5k3RRT+9Kz5AWCCG/1XXdqNUevIu1omw3T43Ckr+7EfBcyj8Hj8BVE
	yaaO4LkKDIIT4Y7OdRWsYc4f26pBl9E=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-Zfii8khaPeqMenLzJsB5ig-1; Thu, 06 Jul 2023 07:31:19 -0400
X-MC-Unique: Zfii8khaPeqMenLzJsB5ig-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-62de65b3a5bso8368096d6.2
        for <bpf@vger.kernel.org>; Thu, 06 Jul 2023 04:31:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688643079; x=1691235079;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YUOZEoZh3tniSwu0Lc1VH/leg3NuusrIfXtvdOdkp+U=;
        b=e4lWGz3Lqe0OTK1xCn3QscNBH/+LreLoA8RI4z/gsWX63UZ8Bkz/G1Zzb2kqAuRa1/
         FUaEIt3HqCW/pUxmzXlkIdBfPN2uF/4IPcdkNkjwuQFlth2Iy6opiaGrRspcoyfvHLW6
         5jmZ0nhfZgav0sKRtBx/iiB2ac10vyZN/PZkS6cR/Eab1P+3RC5qXlaMyeZa0ujw69DM
         Tl1ZJ+oG0TFR7cN1iSACUDVyg6z2wD/JNzsi5tlIw/S3XMf1zrkgfd7C+CX1eF/LOeDp
         IOeLpAufCR8LFFXeXYDvvd829DKIeqodPjobUetEIoGHwvEvLPN6wZ3mAS+OsMlnXEAs
         5B8Q==
X-Gm-Message-State: ABy/qLYKqp7lWtOw5OR0bRuMJ/FfZ/HVseFNtI3uXXFRR8Ldv3R7oVcT
	wN18INC++dGThLqCIdgmW5OTxSj53h7NiBHht6In0saxFKpokRwmaIWaVODWtnnkENejGo6/kw3
	BYPFuhWIOaQHa
X-Received: by 2002:a0c:f014:0:b0:636:e56c:eedb with SMTP id z20-20020a0cf014000000b00636e56ceedbmr1572790qvk.34.1688643079075;
        Thu, 06 Jul 2023 04:31:19 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEBNT72yhfIkKfRmJowXJfm9QDc9/aizAtdc3cEmmOmAM0nOogaJ0lzClntXieI3e1t66iJTw==
X-Received: by 2002:a0c:f014:0:b0:636:e56c:eedb with SMTP id z20-20020a0cf014000000b00636e56ceedbmr1572731qvk.34.1688643078801;
        Thu, 06 Jul 2023 04:31:18 -0700 (PDT)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id oo23-20020a05620a531700b007673f8803c3sm624918qkn.96.2023.07.06.04.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 04:31:18 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
 bpf@vger.kernel.org, x86@kernel.org, Nicolas Saenz Julienne
 <nsaenzju@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Thomas
 Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H.
 Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>, Wanpeng
 Li <wanpengli@tencent.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Andy
 Lutomirski <luto@kernel.org>, Frederic Weisbecker <frederic@kernel.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>,
 Christoph Hellwig <hch@infradead.org>, Lorenzo Stoakes
 <lstoakes@gmail.com>, Josh Poimboeuf <jpoimboe@kernel.org>, Kees Cook
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
Subject: Re: [RFC PATCH 11/14] context-tracking: Introduce work deferral
 infrastructure
In-Reply-To: <20230705223956.GD2813335@hirez.programming.kicks-ass.net>
References: <20230705181256.3539027-1-vschneid@redhat.com>
 <20230705181256.3539027-12-vschneid@redhat.com>
 <20230705223956.GD2813335@hirez.programming.kicks-ass.net>
Date: Thu, 06 Jul 2023 12:31:11 +0100
Message-ID: <xhsmhsfa1uvi8.mognet@vschneid.remote.csb>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 06/07/23 00:39, Peter Zijlstra wrote:
> On Wed, Jul 05, 2023 at 07:12:53PM +0100, Valentin Schneider wrote:
>
>> Note: A previous approach by PeterZ [1] used an extra bit in
>> context_tracking.state to flag the presence of deferred callbacks to
>> execute, and the actual callbacks were stored in a separate atomic
>> variable.
>>
>> This meant that the atomic read of context_tracking.state was sufficient to
>> determine whether there are any deferred callbacks to execute.
>> Unfortunately, it presents a race window. Consider the work setting
>> function as:
>>
>>   preempt_disable();
>>   seq = atomic_read(&ct->seq);
>>   if (__context_tracking_seq_in_user(seq)) {
>>        /* ctrl-dep */
>>        atomic_or(work, &ct->work);
>>        ret = atomic_try_cmpxchg(&ct->seq, &seq, seq|CT_SEQ_WORK);
>>   }
>>   preempt_enable();
>>
>>   return ret;
>>
>> Then the following can happen:
>>
>>   CPUx                                             CPUy
>>                                                   CT_SEQ_WORK \in context_tracking.state
>>     atomic_or(WORK_N, &ct->work);
>>                                                    ct_kernel_enter()
>>                                                      ct_state_inc();
>>     atomic_try_cmpxchg(&ct->seq, &seq, seq|CT_SEQ_WORK);
>>
>> The cmpxchg() would fail, ultimately causing an IPI for WORK_N to be
>> sent. Unfortunately, the work bit would remain set, and it can't be sanely
>> cleared in case another CPU set it concurrently - this would ultimately
>> lead to a double execution of the callback, one as a deferred callback and
>> one in the IPI. As not all IPI callbacks are idempotent, this is
>> undesirable.
>
> So adding another atomic is arguably worse.
>
> The thing is, if the NOHZ_FULL CPU is actually doing context transitions
> (SYSCALLs etc..) then everything is fundamentally racy, there is no
> winning that game, we could find the remote CPU is in-kernel, send an
> IPI, the remote CPU does return-to-user and receives the IPI.
>
> And then the USER is upset... because he got an IPI.
>

Yeah, that part is inevitably racy.

The thing I was especially worried about was the potential double
executions (once in IPI, again in deferred work). It's not /too/ bad as the
only two deferred callbacks I'm introducing here are costly-but-stateless,
but IMO is a bad foundation.

But it seems like we can reuse the existing atomic and squeeze some bits in
there, so let's see how that goes :-)


