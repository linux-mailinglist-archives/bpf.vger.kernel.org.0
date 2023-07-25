Return-Path: <bpf+bounces-5817-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACAB761940
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 15:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4088B1C20E63
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 13:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228541F186;
	Tue, 25 Jul 2023 13:05:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AD61F16C
	for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 13:05:57 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 093C7173B
	for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 06:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690290354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Sjst0ANUHPkhmyS9EMxljg+0hKTtA2LkvoCccenEaWc=;
	b=F7+xFVN/UTPtioUDXmny4WuOauzeqiMr3GZY7z4ZN3NSNic3rnB+YM9YlvrM4oJIRcpCBR
	EUZkTCN/IFwszgRPwQqPwmuiuHakAykTSIQ66vIQqAu2TWbA+DLVAG6WUkHPt+sDmTvotf
	yFAjlzdpsTNHhc69ehl4uvxwy8/lHq0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-JFDeF6WTMoyCsX_Om3I0Mw-1; Tue, 25 Jul 2023 09:05:52 -0400
X-MC-Unique: JFDeF6WTMoyCsX_Om3I0Mw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3176c4de5bbso291546f8f.0
        for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 06:05:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690290352; x=1690895152;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sjst0ANUHPkhmyS9EMxljg+0hKTtA2LkvoCccenEaWc=;
        b=aHduKTl5d9TRGJpC91uvUQPfwrDdAdw+8sJ6EBUTY/46ZeG0MAPKcLT25RpBvP7phn
         Whh05MAdAiPWaIsE7GJ7kWUCXoWQe4ogmNcrvkYflTRVm3dd0ebGXuTzpL9ZWPZiJPrJ
         +NxhHV98jkFrrzDdP+lDwGXWyizbE/lu53JHUtxWXlNCnQDxXRAt1+AZ9z0OEOoQHTN1
         5XUbp/do9vEi/taDTJ8VE77KEk9wiUlrqHSs8wyJ0fK2Swml9tpuwJCEV80cOEshITfP
         9k9bx841OjTwoFk4E8fJSoAc40pd52kZglxCqc4shsgIiqGt+SP0ADMaEFtOsW9/mDT6
         +wrw==
X-Gm-Message-State: ABy/qLa/fQOu+K3Uo0Wdqazr1TU9LkMPgMxaQ2cGkmC1YqYMYVya5nT/
	OALN6EkIyXqd7Tc93GcYejH6NmXP3venozbUG9iV+a3BMGoyOO+JKqlHeCA9OdlGwATURl9tPuc
	S2CvTdjqtsIW8
X-Received: by 2002:a05:6000:4c3:b0:314:3f98:a788 with SMTP id h3-20020a05600004c300b003143f98a788mr9662106wri.7.1690290351824;
        Tue, 25 Jul 2023 06:05:51 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF3IfiPQXJmTRIbnVDIkRhO1QGeOmJQGB2V7Ax+LFUYp7XQ/uOSm8c19TiPQx/PfreNkIV1Uw==
X-Received: by 2002:a05:6000:4c3:b0:314:3f98:a788 with SMTP id h3-20020a05600004c300b003143f98a788mr9662062wri.7.1690290351507;
        Tue, 25 Jul 2023 06:05:51 -0700 (PDT)
Received: from vschneid.remote.csb ([149.12.7.81])
        by smtp.gmail.com with ESMTPSA id a15-20020adfeecf000000b00311d8c2561bsm16238717wrp.60.2023.07.25.06.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 06:05:51 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
 bpf@vger.kernel.org, x86@kernel.org, rcu@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Nicolas Saenz Julienne
 <nsaenzju@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Thomas
 Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H.
 Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>, Wanpeng
 Li <wanpengli@tencent.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Andy
 Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, "Paul
 E. McKenney" <paulmck@kernel.org>, Neeraj Upadhyay
 <quic_neeraju@quicinc.com>, Joel Fernandes <joel@joelfernandes.org>, Josh
 Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, Andrew
 Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>,
 Christoph Hellwig <hch@infradead.org>, Lorenzo Stoakes
 <lstoakes@gmail.com>, Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron
 <jbaron@akamai.com>, Kees Cook <keescook@chromium.org>, Sami Tolvanen
 <samitolvanen@google.com>, Ard Biesheuvel <ardb@kernel.org>, Nicholas
 Piggin <npiggin@gmail.com>, Juerg Haefliger
 <juerg.haefliger@canonical.com>, Nicolas Saenz Julienne
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
Subject: Re: [RFC PATCH v2 15/20] context-tracking: Introduce work deferral
 infrastructure
In-Reply-To: <ZL+wgn76H1em9hZU@lothringen>
References: <20230720163056.2564824-1-vschneid@redhat.com>
 <20230720163056.2564824-16-vschneid@redhat.com>
 <ZL6QI4mV-NKlh4Ox@localhost.localdomain>
 <xhsmh351dtfjj.mognet@vschneid.remote.csb> <ZL7OoUMLZwfUttjV@lothringen>
 <xhsmhzg3ks3mw.mognet@vschneid.remote.csb> <ZL+wgn76H1em9hZU@lothringen>
Date: Tue, 25 Jul 2023 14:05:47 +0100
Message-ID: <xhsmhwmyorvis.mognet@vschneid.remote.csb>
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

On 25/07/23 13:22, Frederic Weisbecker wrote:
> On Tue, Jul 25, 2023 at 11:10:31AM +0100, Valentin Schneider wrote:
>> I have reasons! I just swept them under the rug and didn't mention them :D
>> Also looking at the config dependencies again I got it wrong, but
>> nevertheless that means I get to ramble about it.
>>
>> With NO_HZ_IDLE, we get CONTEXT_TRACKING_IDLE, so we get these
>> transitions:
>>
>>   ct_idle_enter()
>>     ct_kernel_exit()
>>       ct_state_inc_clear_work()
>>
>>   ct_idle_exit()
>>     ct_kernel_enter()
>>       ct_work_flush()
>>
>> Now, if we just make CONTEXT_TRACKING_WORK depend on CONTEXT_TRACKING_IDLE
>> rather than CONTEXT_TRACKING_USER, we get to leverage the IPI deferral for
>> NO_HZ_IDLE kernels - in other words, we get to keep idle CPUs idle longer.
>>
>> It's a completely different argument than reducing interference for
>> NOHZ_FULL userspace applications and I should have at the very least
>> mentioned it in the cover letter, but it's the exact same backing
>> mechanism.
>>
>> Looking at it again, I'll probably make the CONTEXT_IDLE thing a separate
>> patch with a proper changelog.
>
> Ok should that be a seperate Kconfig? This indeed can bring power improvement
> but at the cost of more overhead from the sender. A balance to be measured...

Yep agreed, I'll make that an optional config.


