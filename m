Return-Path: <bpf+bounces-49168-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC85A14C90
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 10:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19A813A1F57
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 09:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600111FC7C8;
	Fri, 17 Jan 2025 09:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MEM462nk"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C121FAC4A
	for <bpf@vger.kernel.org>; Fri, 17 Jan 2025 09:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737107664; cv=none; b=u0zApcS0Bwjlz+mKOpQ1S58ydowfGWXzs/zybeBaENSugMIiJBquzdkb/7sm4jUBFS3QGYrCGpwTNcImnwV3YnDZPrxzBueu6TEyKAecENa6YDlqHV4R/pCCaePwmF24Wt8fLydCyDdKwUT3vpZnTSyeIf6CfMeaklKukoxtLxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737107664; c=relaxed/simple;
	bh=dfiy2R/0rK2WNQBFJ4B8wz0dhd7gEAJUhvpkWIIsvfg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WqAMeCQLRbMS3TAjlkZ6XuJ324yVa6IRg3Pxikh4heyrowRTxgAu5nAvgFPkxlrhWlG5KaKlxmpoEpR6EREQjgcbx1BbQrONPAjFZHAKUENOtTRnrSF//qJ8wotZwe/8JMoG9xeZ88pUR4ZQ9oD5kM7uk6xVSECmkY7lWjHI8nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MEM462nk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737107661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L9Oe7BkLz3ZQnhnrUC9eWHjE3nyj6wgCJoWV2O/5t40=;
	b=MEM462nkotuKIWlejchotO6NXtiSxbY2f+TAC6c5+Z9PfH5Lb1HdPpuw4rFsZ7yI+E4z+t
	ckw2Y2Skz/2QRCw9jeT3my9NnYPKwtznNUmjCxYEl8hXte6fxyaftJS1xGmxyZn8DwdnPI
	xsxXCOp+hABm1DeoEeZxMhiyP7y1CyQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-GLZ3RTjzMCm-umOTxyqM-Q-1; Fri, 17 Jan 2025 04:54:16 -0500
X-MC-Unique: GLZ3RTjzMCm-umOTxyqM-Q-1
X-Mimecast-MFC-AGG-ID: GLZ3RTjzMCm-umOTxyqM-Q
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4361fc2b2d6so9630285e9.3
        for <bpf@vger.kernel.org>; Fri, 17 Jan 2025 01:54:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737107655; x=1737712455;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L9Oe7BkLz3ZQnhnrUC9eWHjE3nyj6wgCJoWV2O/5t40=;
        b=tI8B1i7TaOg4KqhOMib16c+SvRi+6GTknHW7raf7+O3oxfrJSTHwmibQZQN472ith7
         qTpIgWIXhBGDGLpxzax1v6h6CSpXih68M/PY1kg2lMiowbBvBvE9eeZQK9HbGtn6zfqY
         ADeamruo/bwnF725dNrEk6LWWVvGBoqdl+RfdjydauzWiHFnOgZ1PBmXHYm9ogaMu+wo
         IC+NcF2o8PcXCyyNLrYse9tkCZOURJ3VLsVzIyCE/67cXpXqEtA24dD2DkGjF5a9urep
         QsVku026JJoxKaEe2MXZDrZLF5KYoWxFgYySAjYgrZbZ4r8YbnP2EaxiMrsWIrXbI5f8
         xCBA==
X-Forwarded-Encrypted: i=1; AJvYcCUfG8XSRTdblGUs1BD5gX1VEaFKCBQ/RYzuoOoa7ORqOKtlGR9GwRc9/r9Af2nptgS70v4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS0LzaCUiI2jwXaXBwMDvXYQQn93z0emb85LM3SANrvqNtKahZ
	rtbRZQBPJFaNjytJqNu3xh907uZIP+v0RhuEXJonsjmLjG37Hr7RK2sJYfbcU0hnLma4yObUZQ0
	kNMJh8HP/MoWItp8kdr42hAAeXRLFr8kNIQnDotNTd+j77jFKoQ==
X-Gm-Gg: ASbGnctI1oJk8laOox5a1MUtD2FB2RBmXQvwrX4WcD+SlBIPXytKc6KvNl5d21PCQJb
	0m3lTkYBKbWBIJCPF/+nRYZEQecSGDojG8icmcAdNq8chEqW3JmgB7LCVBobn0LjeprhoDvQPid
	pT/7w75eQSqKdzhHg2d1ND6O8rzkMuZprQtPQXFFyLKgO3W/YT7hXVbNCXtf8bSpmhQ66Cw8DUT
	ZRs0XwfkdniI8+9+4ASY7FDflA8U8qNmEBm5QgDX+S3C/vVJrDu19Pf2FFgDJJdKGmRkiYkUDsc
	kUvhVjTYYxEL6QL2Ci0ZNWcb/tYek5hw9D3/d9hdfw==
X-Received: by 2002:a05:600c:450d:b0:436:840b:261c with SMTP id 5b1f17b1804b1-438914340afmr16340035e9.19.1737107655105;
        Fri, 17 Jan 2025 01:54:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFuw6rUkDZiEIMePly7ic4RGfvY46wjcWihk2kMpcZz3D30VqRFOYeHlJ+bekZM5WnBbSAhfQ==
X-Received: by 2002:a05:600c:450d:b0:436:840b:261c with SMTP id 5b1f17b1804b1-438914340afmr16338925e9.19.1737107654599;
        Fri, 17 Jan 2025 01:54:14 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43890420412sm28393455e9.18.2025.01.17.01.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 01:54:14 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 virtualization@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-perf-users@vger.kernel.org, xen-devel@lists.xenproject.org,
 kvm@vger.kernel.org, linux-arch@vger.kernel.org, rcu@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
 bcm-kernel-feedback-list@broadcom.com, Peter Zijlstra
 <peterz@infradead.org>, Nicolas Saenz Julienne <nsaenzju@redhat.com>,
 Juergen Gross <jgross@suse.com>, Ajay Kaher <ajay.kaher@broadcom.com>,
 Alexey Makhalov <alexey.amakhalov@broadcom.com>, Russell King
 <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui
 <kernel@xen0n.name>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Thomas
 Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H.
 Peter Anvin" <hpa@zytor.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
 <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter
 <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, Boris
 Ostrovsky <boris.ostrovsky@oracle.com>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Andy Lutomirski <luto@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Frederic Weisbecker <frederic@kernel.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Jason Baron <jbaron@akamai.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ard Biesheuvel <ardb@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes
 <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>, Boqun
 Feng <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, Juri Lelli
 <juri.lelli@redhat.com>, Clark Williams <williams@redhat.com>, Yair
 Podemsky <ypodemsk@redhat.com>, Tomas Glozar <tglozar@redhat.com>, Vincent
 Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, Mel Gorman
 <mgorman@suse.de>, Kees Cook <kees@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Christoph Hellwig <hch@infradead.org>, Shuah
 Khan <shuah@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, Miguel
 Ojeda <ojeda@kernel.org>, Alice Ryhl <aliceryhl@google.com>, "Mike
 Rapoport (Microsoft)" <rppt@kernel.org>, Samuel Holland
 <samuel.holland@sifive.com>, Rong Xu <xur@google.com>, Geert Uytterhoeven
 <geert@linux-m68k.org>, Yosry Ahmed <yosryahmed@google.com>, "Kirill A.
 Shutemov" <kirill.shutemov@linux.intel.com>, "Masami Hiramatsu (Google)"
 <mhiramat@kernel.org>, Jinghao Jia <jinghao7@illinois.edu>, Luis
 Chamberlain <mcgrof@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
 Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: Re: [PATCH v4 25/30] context_tracking,x86: Defer kernel text
 patching IPIs
In-Reply-To: <Z4bbwE8yfg349gBx@google.com>
References: <20250114175143.81438-1-vschneid@redhat.com>
 <20250114175143.81438-26-vschneid@redhat.com>
 <Z4bTlZkqihaAyGb4@google.com> <Z4bbwE8yfg349gBx@google.com>
Date: Fri, 17 Jan 2025 10:54:11 +0100
Message-ID: <xhsmh8qr9hikc.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 14/01/25 13:48, Sean Christopherson wrote:
> On Tue, Jan 14, 2025, Sean Christopherson wrote:
>> On Tue, Jan 14, 2025, Valentin Schneider wrote:
>> > +/**
>> > + * is_kernel_noinstr_text - checks if the pointer address is located in the
>> > + *                    .noinstr section
>> > + *
>> > + * @addr: address to check
>> > + *
>> > + * Returns: true if the address is located in .noinstr, false otherwise.
>> > + */
>> > +static inline bool is_kernel_noinstr_text(unsigned long addr)
>> > +{
>> > +	return addr >= (unsigned long)__noinstr_text_start &&
>> > +	       addr < (unsigned long)__noinstr_text_end;
>> > +}
>>
>> This doesn't do the right thing for modules, which matters because KVM can be
>> built as a module on x86, and because context tracking understands transitions
>> to GUEST mode, i.e. CPUs that are running in a KVM guest will be treated as not
>> being in the kernel, and thus will have IPIs deferred.  If KVM uses a static key
>> or branch between guest_state_enter_irqoff() and guest_state_exit_irqoff(), the
>> patching code won't wait for CPUs to exit guest mode, i.e. KVM could theoretically
>> use the wrong static path.
>>
>> I don't expect this to ever cause problems in practice, because patching code in
>> KVM's VM-Enter/VM-Exit path that has *functional* implications, while CPUs are
>> actively running guest code, would be all kinds of crazy.  But I do think we
>> should plug the hole.
>>
>> If this issue is unique to KVM, i.e. is not a generic problem for all modules (I
>> assume module code generally isn't allowed in the entry path, even via NMI?), one
>> idea would be to let KVM register its noinstr section for text poking.
>
> Another idea would be to track which keys/branches are tagged noinstr, i.e. generate
> the information at compile time instead of doing lookups at runtime.  The biggest
> downside I can think of is that it would require plumbing in the information to
> text_poke_bp_batch().

IIUC that's what I went for in v3:

https://lore.kernel.org/lkml/20241119153502.41361-11-vschneid@redhat.com

but, modules notwithstanding, simply checking if the patched instruction is
in .noinstr was a lot neater.


