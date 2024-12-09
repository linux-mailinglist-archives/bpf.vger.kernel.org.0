Return-Path: <bpf+bounces-46389-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6949E9441
	for <lists+bpf@lfdr.de>; Mon,  9 Dec 2024 13:35:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 739F5284347
	for <lists+bpf@lfdr.de>; Mon,  9 Dec 2024 12:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9518622F39D;
	Mon,  9 Dec 2024 12:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BPBsh1k4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B5022F38B
	for <bpf@vger.kernel.org>; Mon,  9 Dec 2024 12:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733747598; cv=none; b=GpVUnstjXNSLFZy83/zNrM2uUhG5IFXEuJLAOkpQoRBXFcId1Y/SLWxtSn5Oi+tlKxNNM/KLEazZ1FqO+H8hHVg66Vok2q9RHuSusqFtg8h8GXET8YOwjt0kkTxphf7jrCeVmmotv54zaLfylhOL/fOwp4eJGtWCVJczVwJZu2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733747598; c=relaxed/simple;
	bh=ek6JnJryzS8nkolvdBO+WcL7txRzhCqyp5AS4yQyerY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nY8oBbL3i3XgEnJZWo6t/mFTCsDk88fAsVM0n+1o24fBHUC001Lzde6Cmh70X/VJJxS8cWlJPSFC0VDt26A2e7ieM/OdWnkuXjwPn/P1FQ66w8k2OK4sYfOLAT9rouNqRQvKYs1jCvt/8dwtqwsdNMqqCuavepWO6RMJh3XfSDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BPBsh1k4; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aa551d5dd72so78364366b.3
        for <bpf@vger.kernel.org>; Mon, 09 Dec 2024 04:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733747594; x=1734352394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nt1cndHZ8pbXtiRxeB+O52iETLBujQEcUgkGHWv3lYM=;
        b=BPBsh1k44sW9Uvtngsyo0Z/4E0JbXC/ebAX7UVqfON71LrRfKh6Lhw20HWcf/+WQ0g
         KRFyY8FarxwJfNT9qAg2a51N+oG9jQ937eE/V1hN9T4vzfp9lAxVKm99v99uz+y8SPei
         dBmo/qRSHSf6ZOOtlyNkhPryyggxkF2m9D7kPaiVJfC2M+mw/eUtGRJA00FyxW7vPwwn
         kh/puyj7+ad1J9Rusn+HgTvKlhjaVP1rwu7s8YzubkrDhvwGI70oIOTebzCGUWKlftaf
         Qavzuhg618riQvM8cV8BBJBuyutVbnqPshwOTI5SCUJNXsGPHpyaQDoa3TlbFTJ32QGg
         RTRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733747594; x=1734352394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nt1cndHZ8pbXtiRxeB+O52iETLBujQEcUgkGHWv3lYM=;
        b=UhSkaU0exH2AiHKWnxnQbyKXrwllNqMI7zbWb55AUHSYO9C4AnHLDKOU7nxKYBGGOH
         w7T/4eW70nqXWGfaz5kwY3rxagZXdXdsgMg7TeVvNMyY3VpjsrgjWsY8xFNZH9k/NksM
         WxEY/hQF+tmKVqe/wZ1wBZqQUpOdn65yHFLqzmOcgvhXNwjvfcIFNFnlfNgtRoKVPcX5
         j7gQCDpgiRUZlo6YYj/8CD3F6hZltIJpf6hIHdsbMTzlhd3YpsK7rEySDUnOPilzHr7E
         J5Iw77HeoI/1Kh5mXGRmi8J4rvoGuEWtVWAtVbUJHmbtu1M8G//7YxVmAmqemdWYD5pT
         KMfg==
X-Forwarded-Encrypted: i=1; AJvYcCWuas6ZLqTsIUZPUKBL3/1uZ6FZMVXq+xooxvFq2TPAfqtcNPbA85hjVFxaGQrFaTnINSo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvxpM/fABgBFdldndEcGABz7ss2pRfRTGxCdGUrpK579Yki0Aa
	7NlJt/bzl9Pp+Zo9khCBY7KR9S3JdcJdMOPOr/vKUzLF8iWxjzGAPK1obkBDOXo=
X-Gm-Gg: ASbGncu29qa0/Ev6S/aEjfeZP5+rGr3gsCR4EprxjVrrjw7dmpddN4+RTbzAVBqTEYt
	gadWb6dOPwNB7vdHpIZ05COScobZLoyBybBtUZZA/7g7bHJ+akmY93b+8pM8ucTdaK0MWCZnbIj
	lG/VUVQquUhAReUHsSrteH6U0tIifb4095C1nw1djNEFPzmofmgLgKshlIamL8gMYbw9IlM76Aw
	IO2hQRNLxJNGYWmEIvzw97t9Q+ubUMYky4DBI2dkIC3VjY5KiQN4AR4eyYseO+pdEuFN/CPhumM
	APdZOC0muCpr7QbbwZqQyhdt/5sGpFB3CsD6zxEjmrGyICf8o1CmO5I=
X-Google-Smtp-Source: AGHT+IHhdX0FdatIb0ng+WxBrxtwY6KW2ibAnH43Vj2dTr2Rwd6wvnDl6sDEJjcdHu0Fke7nx/YjOQ==
X-Received: by 2002:a17:907:3fa8:b0:a9a:8216:2f4d with SMTP id a640c23a62f3a-aa639fa5dfamr461325766b.3.1733747593866;
        Mon, 09 Dec 2024 04:33:13 -0800 (PST)
Received: from mordecai.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa62601b5fesm672536266b.117.2024.12.09.04.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 04:33:13 -0800 (PST)
Date: Mon, 9 Dec 2024 13:33:09 +0100
From: Petr Tesarik <ptesarik@suse.com>
To: Valentin Schneider <vschneid@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Dave Hansen
 <dave.hansen@intel.com>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
 bpf@vger.kernel.org, x86@kernel.org, rcu@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Wanpeng Li <wanpengli@tencent.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 Andy Lutomirski <luto@kernel.org>, Frederic Weisbecker
 <frederic@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, Neeraj
 Upadhyay <quic_neeraju@quicinc.com>, Joel Fernandes
 <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>, Boqun Feng
 <boqun.feng@gmail.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki
 <urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>, Lorenzo Stoakes
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
 Dionna Glaze <dionnaglaze@google.com>, Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?=
 <linux@weissschuh.net>, Juri Lelli <juri.lelli@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, Yair Podemsky <ypodemsk@redhat.com>, Daniel Wagner
 <dwagner@suse.de>
Subject: Re: [RFC PATCH v3 13/15] context_tracking,x86: Add infrastructure
 to defer kernel TLBI
Message-ID: <20241209133309.794439ca@mordecai.tesarici.cz>
In-Reply-To: <xhsmh1pyh6p0k.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
References: <20241119153502.41361-1-vschneid@redhat.com>
	<20241119153502.41361-14-vschneid@redhat.com>
	<20241120152216.GM19989@noisy.programming.kicks-ass.net>
	<20241120153221.GM38972@noisy.programming.kicks-ass.net>
	<xhsmhldxdhl7b.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
	<20241121111221.GE24774@noisy.programming.kicks-ass.net>
	<4b562cd0-7500-4b3a-8f5c-e6acfea2896e@intel.com>
	<20241121153016.GL39245@noisy.programming.kicks-ass.net>
	<20241205183111.12dc16b3@mordecai.tesarici.cz>
	<xhsmh1pyh6p0k.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 09 Dec 2024 13:04:43 +0100
Valentin Schneider <vschneid@redhat.com> wrote:

> On 05/12/24 18:31, Petr Tesarik wrote:
> > On Thu, 21 Nov 2024 16:30:16 +0100
> > Peter Zijlstra <peterz@infradead.org> wrote:
> >  
> >> On Thu, Nov 21, 2024 at 07:07:44AM -0800, Dave Hansen wrote:  
> >> > On 11/21/24 03:12, Peter Zijlstra wrote:  
> >> > >> I see e.g. ds_clear_cea() clears PTEs that can have the _PAGE_GLOBAL flag,
> >> > >> and it correctly uses the non-deferrable flush_tlb_kernel_range().  
> >> > >
> >> > > I always forget what we use global pages for, dhansen might know, but
> >> > > let me try and have a look.
> >> > >
> >> > > I *think* we only have GLOBAL on kernel text, and that only sometimes.  
> >> >
> >> > I think you're remembering how _PAGE_GLOBAL gets used when KPTI is in play.  
> >>
> >> Yah, I suppose I am. That was the last time I had a good look at this
> >> stuff :-)
> >>  
> >> > Ignoring KPTI for a sec... We use _PAGE_GLOBAL for all kernel mappings.
> >> > Before PCIDs, global mappings let the kernel TLB entries live across CR3
> >> > writes. When PCIDs are in play, global mappings let two different ASIDs
> >> > share TLB entries.  
> >>
> >> Hurmph.. bah. That means we do need that horrible CR4 dance :/  
> >
> > In general, yes.
> >
> > But I wonder what exactly was the original scenario encountered by
> > Valentin. I mean, if TLB entry invalidations were necessary to sync
> > changes to kernel text after flipping a static branch, then it might be
> > less overhead to make a list of affected pages and call INVLPG on them.
> >
> > AFAIK there is currently no such IPI function for doing that, but if we
> > could add one. If the list of invalidated global pages is reasonably
> > short, of course.
> >
> > Valentin, do you happen to know?
> >  
> 
> So from my experimentation (hackbench + kernel compilation on housekeeping
> CPUs, dummy while(1) userspace loop on isolated CPUs), the TLB flushes only
> occurred from vunmap() - mainly from all the hackbench threads coming and
> going.
> 
> Static branch updates only seem to trigger the sync_core() IPI, at least on
> x86.

Thank you, this is helpful.

So, these allocations span more than tlb_single_page_flush_ceiling
pages (default 33). Is THP enabled? If yes, we could possibly get below
that threshold by improving flushing of huge pages (cf. footnote [1] in
Documentation/arch/x86/tlb.rst).

OTOH even though a series of INVLPG may reduce subsequent TLB misses,
it will not exactly improve latency, so it would go against the main
goal of this whole patch series.

Hmmm... I see, the CR4 dance is the best solution after all. :-|

Petr T

