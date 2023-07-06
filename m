Return-Path: <bpf+bounces-4292-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 517E174A38D
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 20:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 817221C20E01
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 18:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA98C151;
	Thu,  6 Jul 2023 18:05:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB578C18
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 18:05:29 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211C719B2
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 11:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688666726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mt4cbGq9d8jKpC8J/+jZJ74qgft1NY860RzeCaYTTAU=;
	b=Xbx9k6wsBCW6d/cNDU3L2sRfZ3uTuxbTeu53m2RyZg86DMdYdv8yHnfENl0GxXAkQ4/N73
	DQSep05BvJItRkFGcjQgu+9tKe1YnRTPn/IExO/1BL/l7L65QNKj0GH3zWd/oUzt/GuMEO
	PojAEJSSMWZoRBA6WQ163MlV5b0QvmM=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-8L_zqLQMPlO9PGqK8LqaBw-1; Thu, 06 Jul 2023 14:05:25 -0400
X-MC-Unique: 8L_zqLQMPlO9PGqK8LqaBw-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-5eee6742285so11552446d6.2
        for <bpf@vger.kernel.org>; Thu, 06 Jul 2023 11:05:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688666724; x=1691258724;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mt4cbGq9d8jKpC8J/+jZJ74qgft1NY860RzeCaYTTAU=;
        b=J8UCSKzw60awEEg5bb1U5u2bXJuDYkQvZsu44u/QTJhONOuoj0rKhrk3QQYxGyEcaW
         ys4qovOhZurek4KPjCWKsGWUqpa6L38cNLLs5oEUCdByd+fcrs31FZpJigaN14wUmYXt
         mpothXEdLNuBQ7BqjLx6wtyZi+Zwvh/gnXacsPn+7GvFXcpq7yw5t4O+tJAoXue9eIjj
         w8CnDvSfAFtEDrsfgqvc/zJBaif47Gq+tTBqsVd4bSxFoR45Anzkshq/6Q1K1wxdphCP
         oQSTy7uzgYb7qspcsZ4niaw8t9WZfsb62b6XM6ZNL3wsDQWBAP2bzFbjCfe1d3ytnufy
         PMPg==
X-Gm-Message-State: ABy/qLaEeiDPf/1j9QOWQ26x5LjmVgUlhHb1op842oPyU4xmUcmuuqvp
	FYD6k8ya70BowEYLqvsJdvihuvL9gCszf8MtSfY8YNNi++bgwtVfh1B5KnzH+jed+p56YkAoZuT
	TsQov3C/GDoQ+
X-Received: by 2002:a0c:de07:0:b0:632:1da6:986a with SMTP id t7-20020a0cde07000000b006321da6986amr2462916qvk.17.1688666724510;
        Thu, 06 Jul 2023 11:05:24 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFmb0Wl2yHupEnJvTRYWB02b+IYD3YW7L4gL7H6IsZmD2crA+l9iItFZbkC9he8nK0QEubsug==
X-Received: by 2002:a0c:de07:0:b0:632:1da6:986a with SMTP id t7-20020a0cde07000000b006321da6986amr2462887qvk.17.1688666724257;
        Thu, 06 Jul 2023 11:05:24 -0700 (PDT)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id c12-20020a0ce14c000000b006260c683bf2sm1135942qvl.53.2023.07.06.11.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 11:05:23 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: paulmck@kernel.org, Frederic Weisbecker <frederic@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
 bpf@vger.kernel.org, x86@kernel.org, Nicolas Saenz Julienne
 <nsaenzju@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Thomas
 Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H.
 Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>, Wanpeng
 Li <wanpengli@tencent.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Andy
 Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki
 <urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>, Lorenzo Stoakes
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
In-Reply-To: <4c2cb573-168f-4806-b1d9-164e8276e66a@paulmck-laptop>
References: <20230705181256.3539027-1-vschneid@redhat.com>
 <20230705181256.3539027-12-vschneid@redhat.com>
 <ZKXtfWZiM66dK5xC@localhost.localdomain>
 <xhsmhttuhuvix.mognet@vschneid.remote.csb> <ZKaoHrm0Fejb7kAl@lothringen>
 <4c2cb573-168f-4806-b1d9-164e8276e66a@paulmck-laptop>
Date: Thu, 06 Jul 2023 19:05:17 +0100
Message-ID: <xhsmhlefsvrtu.mognet@vschneid.remote.csb>
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

On 06/07/23 09:39, Paul E. McKenney wrote:
> On Thu, Jul 06, 2023 at 01:40:14PM +0200, Frederic Weisbecker wrote:
>> On Thu, Jul 06, 2023 at 12:30:46PM +0100, Valentin Schneider wrote:
>> > I'm trying to grok how this impacts RCU, IIUC most of RCU mostly cares about the
>> > even/odd-ness of the thing, and rcu_gp_fqs() cares about the actual value
>> > but only to check if it has changed over time (rcu_dynticks_in_eqs_since()
>> > only does a !=).
>> >
>> > I'm rephrasing here to make sure I get it - is it then that the worst case
>> > here is 2^(dynticks_counter_size) transitions happen between saving the
>> > dynticks snapshot and checking it again, so RCU waits some more?
>>
>> That's my understanding as well but I have to defer on Paul to make sure I'm
>> not overlooking something.
>
> That does look plausible to me.
>
> And yes, RCU really cares about whether its part of this counter has
> been a multiple of two during a given interval of time, because this
> indicates that the CPU has no pre-existing RCU readers still active.
> One way that this can happen is for that value to be a multiple of two
> at some point in time.  The other way that this can happen is for the
> value to have changed.  No matter what the start and end values, if they
> are different, the counter must necessarily have at least passed through
> multiple of two in the meantime, again guaranteeing that any RCU readers
> that around when the count was first fetched have now finished.
>

Thank you for the demystification!

> But we should take the machine's opinions much more seriously than we
> take any of our own opinions.

Heh :-)

> Why not adjust RCU_DYNTICKS_IDX so as
> to crank RCU's portion of this counter down to (say) two or three bits
> and let rcutorture have at it on TREE04 or TREE07, both of which have
> nohz_full CPUs?
>
> Maybe also adjust mkinitrd.sh to make the user/kernel transitions more
> frequent?
>
> Please note that I do -not- recommend production use of a three-bit
> (let alone a two-bit) RCU portion because this has a high probability
> of excessively extending grace periods.  But it might be good to keep
> a tiny counter as a debug option so that we regularly rcutorture it.
>

Sounds sensible, I'll add that to my v2 todolist.

Thanks!

>                                                       Thanx, Paul


