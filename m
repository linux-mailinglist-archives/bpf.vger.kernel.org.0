Return-Path: <bpf+bounces-5813-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B52B76104D
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 12:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDCBF2817C0
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 10:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D202182C8;
	Tue, 25 Jul 2023 10:10:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC0615AEF
	for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 10:10:40 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7450810C8
	for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 03:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690279837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qHJHNAQ/EaLrVgiClukNB6YD2cCwQOLa9+8g/RD5pIg=;
	b=iY4wOsydtMEtxvUuDux6MVHCf2tojKmzGry+T6klLphKk6SXYPUWf5hBJrawogE13qw/PH
	2AjawmjJhIl2TYiDj9I+JHz9xDtotGkGBvQ2aEI3RZSEPDKHx/bmVODoS1rfHxEFpgH1Fy
	Hg5C7SoCJeT8AMYCsbUXtDy7h8TIMJk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-is-f5E1MN72EMF9Al2O1Qw-1; Tue, 25 Jul 2023 06:10:36 -0400
X-MC-Unique: is-f5E1MN72EMF9Al2O1Qw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3fbe590234aso31742715e9.1
        for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 03:10:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690279835; x=1690884635;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qHJHNAQ/EaLrVgiClukNB6YD2cCwQOLa9+8g/RD5pIg=;
        b=A1u1KZGgForrQniBBHzAUscXxpPnBUcx8oX0p0aqf2OAz3IvXmcFwihj0TODO2/iON
         taKTKURWG3frZVyY+LCQmtV0yo1NjbK44aTew6qTK854OLNRmxCLsE3pc6zMXTVPDSEU
         /1/CllmEAQE+6g9rebrUzN9CkiBLe2PQpVt2GpO80mNkoTk1guA52fjAjAtYK5rmRpnW
         Pgib2NPhrWi8J5L7o8uvcgqI+D1mV25AyiyT89G2J2tRD4gD/pf+GJbYMPwnfZlAIjMS
         /oDXq+p+6hHtgVlr/Rgw4uZcp2orPR6utkK2VG9C6pe7I04RN7lri7WIbGBhlxwOJ+K7
         MPzA==
X-Gm-Message-State: ABy/qLbwl93VnoeA+WsKUesI6BJFwgZPa3WBeq0f9z4pSzvBpf9UqUKr
	64BSrZPobgRtZ+vLGUvVp5gbHVaOGJVi42q3riZ1U68QIxYYBu/PinyyzRphK/u3dPNdXaHShws
	P4d7WAfcXACP1
X-Received: by 2002:a7b:c3c8:0:b0:3fc:182:7eac with SMTP id t8-20020a7bc3c8000000b003fc01827eacmr9484355wmj.33.1690279835121;
        Tue, 25 Jul 2023 03:10:35 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEBwe5grVle2BJoQfU1CdlrA5E008mXbdTKHKW2tEfZga9rph2myp9KegOF9DFTCjiBwJ8J/Q==
X-Received: by 2002:a7b:c3c8:0:b0:3fc:182:7eac with SMTP id t8-20020a7bc3c8000000b003fc01827eacmr9484330wmj.33.1690279834786;
        Tue, 25 Jul 2023 03:10:34 -0700 (PDT)
Received: from vschneid.remote.csb ([149.12.7.81])
        by smtp.gmail.com with ESMTPSA id p1-20020a05600c204100b003fc17e8a1efsm15201059wmg.45.2023.07.25.03.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 03:10:34 -0700 (PDT)
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
In-Reply-To: <ZL7OoUMLZwfUttjV@lothringen>
References: <20230720163056.2564824-1-vschneid@redhat.com>
 <20230720163056.2564824-16-vschneid@redhat.com>
 <ZL6QI4mV-NKlh4Ox@localhost.localdomain>
 <xhsmh351dtfjj.mognet@vschneid.remote.csb> <ZL7OoUMLZwfUttjV@lothringen>
Date: Tue, 25 Jul 2023 11:10:31 +0100
Message-ID: <xhsmhzg3ks3mw.mognet@vschneid.remote.csb>
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

On 24/07/23 21:18, Frederic Weisbecker wrote:
> On Mon, Jul 24, 2023 at 05:55:44PM +0100, Valentin Schneider wrote:
>> I can make that a 'do {} while ()' instead to force at least one execution
>> of the cmpxchg().
>>
>> This is only about reducing the race window, right? If we're executing this
>> just as the target CPU is about to enter userspace, we're going to be in
>> racy territory anyway. Regardless, I'm happy to do that change.
>
> Right, it's only about narrowing down the race window. It probably don't matter
> in practice, but it's one less thing to consider for the brain :-)
>

Ack

> Also, why bothering with handling CONTEXT_IDLE?
>

I have reasons! I just swept them under the rug and didn't mention them :D
Also looking at the config dependencies again I got it wrong, but
nevertheless that means I get to ramble about it.

With NO_HZ_IDLE, we get CONTEXT_TRACKING_IDLE, so we get these
transitions:

  ct_idle_enter()
    ct_kernel_exit()
      ct_state_inc_clear_work()

  ct_idle_exit()
    ct_kernel_enter()
      ct_work_flush()

Now, if we just make CONTEXT_TRACKING_WORK depend on CONTEXT_TRACKING_IDLE
rather than CONTEXT_TRACKING_USER, we get to leverage the IPI deferral for
NO_HZ_IDLE kernels - in other words, we get to keep idle CPUs idle longer.

It's a completely different argument than reducing interference for
NOHZ_FULL userspace applications and I should have at the very least
mentioned it in the cover letter, but it's the exact same backing
mechanism.

Looking at it again, I'll probably make the CONTEXT_IDLE thing a separate
patch with a proper changelog.


