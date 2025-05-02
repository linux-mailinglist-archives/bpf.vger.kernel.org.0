Return-Path: <bpf+bounces-57212-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71CA6AA6E89
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 11:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9EC246750E
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 09:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C3523956A;
	Fri,  2 May 2025 09:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NeKatkF9"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6D4235371
	for <bpf@vger.kernel.org>; Fri,  2 May 2025 09:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746179731; cv=none; b=FBHyTIPujUvPQjDK7/fkoIM7+3+UE78jlk4X9Bf86fhEcNP7SBnQZS4qeEWY3TSikhQ3LSgwXWkk8XGcr0q080JrrSdFrCyqaqHY2sGwSq1ON5kfMQoz+ocYo6Ehd0vuEaslanoQd1xeD7a9WMuaoa5qVcocrJ5spnCceBx0xqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746179731; c=relaxed/simple;
	bh=DbOmruiDXqyCFuxtwBSQJBYz2MVx6spaIxjAgcz+Oj8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PSHzSn8CetyhlNluU20ca1N28O36vS8cfd0hbmC+pX4Uf4JQxdY8h5bE+L7Z+ksWB0cdAt/6G+d+xEbfTLZroF1JDt8NvDtJFHbFGnSKtydWpr0yP8yJi4cvzBhSF1AvQH+lJ3Fctq4wNdWvywlLSVsJv4laMLfL0cAKfAdwQ+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NeKatkF9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746179729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Lg/z+bj6Vp6Uwot26MZjMyBdidDV8u4Eq/gx3z2pwHw=;
	b=NeKatkF9dKxlRB8lOdaII8+V7da1tydBeXe7MbTIv2DjdpbqA0ZIexlgv4fyNjHBYF91Zd
	hx7trX5K+c5289zD2Exir+bGLqjgQBpCqtzVZo9AWItN43qBDcdy/b5MjC7t9inJH7wZWL
	ss+n3KY/kMqY1z+oR7AFnHTp1qtpgBI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-AC2l-23OMuO9igIkIdlnog-1; Fri, 02 May 2025 05:55:27 -0400
X-MC-Unique: AC2l-23OMuO9igIkIdlnog-1
X-Mimecast-MFC-AGG-ID: AC2l-23OMuO9igIkIdlnog_1746179726
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-39143311936so531313f8f.0
        for <bpf@vger.kernel.org>; Fri, 02 May 2025 02:55:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746179726; x=1746784526;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lg/z+bj6Vp6Uwot26MZjMyBdidDV8u4Eq/gx3z2pwHw=;
        b=dzoUxRSMSRZ5SJDIjg+mn5j4DW7rxLaMsooAXknyACiPMgM2rAWYH9x5XOgHx71eH5
         Sk+LASJ19URAqZCNTRMdkDOukQIymphsvkqfgUyBWES1w6SDFpAcibvq3Ja0d1PbPWUn
         ZgADVrqzSM/jSKB1ob2Vl6qoESm27sWJXG30IxTOjhTnh/ZxnV6QVxgQAktpuqCfWyk/
         6uAWmSXMlnAkRExfupFQAo3DQ6c/RPxuTgP+xAbBaZ7lBICgqp7iuEulkqn/HmFuCY2W
         7oZBBuWQ+Vn2uF32y+gLASrXXP8a3OGHNFj0RDNU59Tw3IadWAP4eRad1RDc+Z+Go17z
         3lwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpstXuBl3ZQ+1FEvjZejEPVJoIgnTQ3LffXPqcPeSFWgYPWiAKCrpNHV2CpCv8kMINEHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFagUnEcj/TGahiWkweHrGcChZ8deGp2WhifD2xBa6evseeoWJ
	7tqJuAHmpvp2/pG10gDZH+AvOmy1kY12uzcCn/cZrYWUDhNrf4c8RQdw0n/J0Mmm51Lb+TjCY56
	sULlXBqR7T4C7uPNb+1V6cJ8kwLR7eFAUp1eQe29yb9hyNrUD+g==
X-Gm-Gg: ASbGncvhyRTzIxqbB0Ikt8j/903Gg73C36Z9mvaXF1eIb55sEemyWI5BpGgnVdVXpwo
	MK7vErB+zeBLKkqFkqtLyj2HHzE4krvg6KqHQnyB6k8NghW79oJcrNKy4Ykn0ZPN55bvFQ+kUdc
	ae7FWqH0Q2l+tKqDmBMq1A5zvCFuRbHyTK0XFPjpVKZCk9fbs3ZRCakBy3NLb3BzM3GcREBKMk5
	VsIKzbb5zkyBMmJguXSOD/0JvPgDKZmNoWESE/8aMSykUM8LWSR6m38ZmWMlKKuVcaV06f4Gbpf
	xjn2kxyikeHx0feBJtAe+kUtcye7lcHWom+VeD32CA7InYoc
X-Received: by 2002:a05:6000:40cd:b0:391:4873:7940 with SMTP id ffacd0b85a97d-3a099aef847mr1613278f8f.54.1746179725800;
        Fri, 02 May 2025 02:55:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpWssSttWyCeyGY3CsU2VpUSZWAU4rNhFXcV+QIILeKOWgOhhc72G0KBYplClE77XLY5f7yg==
X-Received: by 2002:a05:6000:40cd:b0:391:4873:7940 with SMTP id ffacd0b85a97d-3a099aef847mr1613170f8f.54.1746179725069;
        Fri, 02 May 2025 02:55:25 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb ([2001:861:43c1:5950:3e51:b684:9982:d4a2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099ae3ccdsm1693329f8f.38.2025.05.02.02.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 02:55:24 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Dave Hansen <dave.hansen@intel.com>, Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-perf-users@vger.kernel.org,
 kvm@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 rcu@vger.kernel.org, linux-hardening@vger.kernel.org,
 linux-kselftest@vger.kernel.org, bpf@vger.kernel.org, Juri Lelli
 <juri.lelli@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Yair
 Podemsky <ypodemsk@redhat.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Daniel Wagner <dwagner@suse.de>, Petr Tesarik <ptesarik@suse.com>, Nicolas
 Saenz Julienne <nsaenz@amazon.com>, Frederic Weisbecker
 <frederic@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, Dave
 Hansen <dave.hansen@linux.intel.com>, Sean Christopherson
 <seanjc@google.com>, Juergen Gross <jgross@suse.com>, Ajay Kaher
 <ajay.kaher@broadcom.com>, Alexey Makhalov
 <alexey.amakhalov@broadcom.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Russell King
 <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui
 <kernel@xen0n.name>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre
 Ghiti <alex@ghiti.fr>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, "H.
 Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
 <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
 <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter
 <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, Pawan
 Gupta <pawan.kumar.gupta@linux.intel.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jason Baron
 <jbaron@akamai.com>, Ard Biesheuvel <ardb@kernel.org>, Luis Chamberlain
 <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen
 <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>, Naveen N
 Rao <naveen@kernel.org>, Anil S Keshavamurthy
 <anil.s.keshavamurthy@intel.com>, "David S. Miller" <davem@davemloft.net>,
 Masami Hiramatsu <mhiramat@kernel.org>, Neeraj Upadhyay
 <neeraj.upadhyay@kernel.org>, Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Uladzislau Rezki <urezki@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Zqiang <qiang.zhang1211@gmail.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Kees Cook
 <kees@kernel.org>, Shuah Khan <shuah@kernel.org>, Masahiro Yamada
 <masahiroy@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda
 <ojeda@kernel.org>, "Mike Rapoport (Microsoft)" <rppt@kernel.org>, Rong Xu
 <xur@google.com>, Rafael Aquini <aquini@redhat.com>, Song Liu
 <song@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Dan Carpenter
 <dan.carpenter@linaro.org>, Brian Gerst <brgerst@gmail.com>, "Kirill A.
 Shutemov" <kirill.shutemov@linux.intel.com>, Benjamin Berg
 <benjamin.berg@intel.com>, Vishal Annapurve <vannapurve@google.com>, Randy
 Dunlap <rdunlap@infradead.org>, John Stultz <jstultz@google.com>, Tiezhu
 Yang <yangtiezhu@loongson.cn>
Subject: Re: [PATCH v5 00/25] context_tracking,x86: Defer some IPIs until a
 user->kernel transition
In-Reply-To: <a6b3a331-1ff3-4490-b300-a62b3c21578d@intel.com>
References: <20250429113242.998312-1-vschneid@redhat.com>
 <fefcd1a6-f146-4f3c-b28b-f907e7346ddd@intel.com>
 <20250430132047.01d48647@gandalf.local.home>
 <019f6713-cfbd-466b-8fb5-dcd982cf8644@intel.com>
 <20250430154228.1d6306b4@gandalf.local.home>
 <a6b3a331-1ff3-4490-b300-a62b3c21578d@intel.com>
Date: Fri, 02 May 2025 11:55:21 +0200
Message-ID: <xhsmhr0179w1i.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 30/04/25 13:00, Dave Hansen wrote:
> On 4/30/25 12:42, Steven Rostedt wrote:
>>> Look at the syscall code for instance:
>>>
>>>> SYM_CODE_START(entry_SYSCALL_64)
>>>>         swapgs
>>>>         movq    %rsp, PER_CPU_VAR(cpu_tss_rw + TSS_sp2)
>>>>         SWITCH_TO_KERNEL_CR3 scratch_reg=%rsp
>>> You can _trivially_ audit this and know that swapgs doesn't touch memory
>>> and that as long as PER_CPU_VAR()s and the process stack don't have
>>> their mappings munged and flushes deferred that this would be correct.
>> Hmm, so there is still a path for this?
>>
>> At least if it added more ways to debug it, and some other changes to make
>> the locations where vmalloc is dangerous smaller?
>
> Being able to debug it would be a good start. But, more generally, what
> we need is for more people to be able to run the code in the first
> place. Would a _normal_ system (without setups that are trying to do
> NOHZ_FULL) ever be able to defer TLB flush IPIs?
>
> If the answer is no, then, yeah, I'll settle for some debugging options.
>
> But if you shrink the window as small as I'm talking about, it would
> look very different from this series.
>
> For instance, imagine when a CPU goes into the NOHZ mode. Could it just
> unconditionally flush the TLB on the way back into the kernel (in the
> same SWITCH_TO_KERNEL_CR3 spot)? Yeah, it'll make entry into the kernel
> expensive for NOHZ tasks, but it's not *THAT* bad. And if the entire
> point of a NOHZ_FULL task is to minimize the number of kernel entries
> then a little extra overhead there doesn't sound too bad.
>

Right, so my thought per your previous comments was to special case the
TLB flush, depend on kPTI and do it uncondtionally in SWITCH_TO_KERNEL_CR3
just like you've described - but keep the context tracking mechanism for
other deferrable operations.

My gripe with that was having two separate mechanisms
- super early entry around SWITCH_TO_KERNEL_CR3)
- later entry at context tracking

Shifting everything to SWITCH_TO_KERNEL_CR3 means we lose the
context_tracking infra to dynamically defer operations (atomically reading
and writing to context_tracking.state), which means we unconditionally run
all possible deferrable operations. This doesn't scream scalable, even
though as you say NOHZ_FULL kernel entry is already a "you lose" situation.

Yet another option is to duplicate the context tracking state specifically
for IPI deferral and have it driven in/by SWITCH_TO_KERNEL_CR3, which is
also not super savoury.

I suppose I can start poking around running deferred ops in that
SWITCH_TO_KERNEL_CR3 region, and add state/infra on top. Let's see where
this gets me :-)

Again, thanks for the insight and the suggestions Dave!

> Also, about the new hardware, I suspect there's some mystery customer
> lurking in the shadows asking folks for this functionality. Could you at
> least go _talk_ to the mystery customer(s) and see which hardware they
> care about? They might already even have the magic CPUs they need for
> this, or have them on the roadmap. If they've got Intel CPUs, I'd be
> happy to help figure it out.


