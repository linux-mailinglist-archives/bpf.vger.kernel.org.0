Return-Path: <bpf+bounces-49194-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D837A150C7
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 14:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 465DD3A97A7
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 13:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68C0200B96;
	Fri, 17 Jan 2025 13:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MZHV+9J1"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE071FFC65
	for <bpf@vger.kernel.org>; Fri, 17 Jan 2025 13:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737121501; cv=none; b=r/r6d+5AEQXMEnJtR4JhiEkFLftTdqtkt8XEmKBH29xB7PsJVuUTZHKIHdnSOnJ0aGzDjGKE6Kh0QoBDUhh1mpRuAzhZSq0GTqSTCF3dgqWU2tMi2ztk16JNXzMhqGsnLtsy9znATXTS6iBy6vgX6e/s2IXBuT7w+BFUJQVVXHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737121501; c=relaxed/simple;
	bh=3uGThAIZZrxCJ1Zag/yc29l3qlAKBV2/uT4Bw7pXLWs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AHZ4VqeoRmPdhYAC8UL475I81bUNRVHVjhoYbGQdE59w9Ttco2QRZLz8VZRz9c7sCCq8DPk0pxnCmhbfEZEFPaxhbhcLC93pBMGiJwoutpJG/7oTogYqCwSqRUseeYzNOEXsIa/3Qx8SSS4k/PAucBF+h28ZFxvwjYZa76CchRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MZHV+9J1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737121498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HEKKhsO2kOL/qF9SHnIE9a8dcD47/tUh4wLid3vzvOo=;
	b=MZHV+9J1aUgCppsgpkJpQvMYzSoG8bhifFYQCfj/9s39EQl3oZJe672ABRiEOX8cuePG88
	3H4b1jduRVI2XTe2rKcWYkNV8UBEftukh2MH9GB4kpf3dz+QS0I7nla6c06YGeayOfRZVY
	03On0hJE0BKuZFwayCxYqjEIo6cGR24=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-9cGfgnHQNAmFsq32DG90cQ-1; Fri, 17 Jan 2025 08:44:57 -0500
X-MC-Unique: 9cGfgnHQNAmFsq32DG90cQ-1
X-Mimecast-MFC-AGG-ID: 9cGfgnHQNAmFsq32DG90cQ
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4675c482d6cso43607461cf.2
        for <bpf@vger.kernel.org>; Fri, 17 Jan 2025 05:44:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737121496; x=1737726296;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HEKKhsO2kOL/qF9SHnIE9a8dcD47/tUh4wLid3vzvOo=;
        b=oFeGIs8ZdWYraxkVSBrUhXmU2txUjhDY2+TyVEi2vYcic48oLPlTFW/B1IjfgNjffc
         E+W1pcpDijCLAFsUx05g8o8xuNhTUPSSseNmMD266nyCESWWV/Gq0TTXYU9Fav46Q6N5
         341+tQ5sbTi8k87DwpjvTn7gOCQ/ObUy+Z7+rArCwBeZlYCOBF4Z3kjc99riqKD/Y0Mf
         zHS66vNEOWs+QIs+Ls69yPJ2yLgsGLc61zl/kW3tkrC3iRz3cd4HgkGo8ej+tynkhrF2
         NVu6EpKaZR6jz7yeDe0cZp7RTNlN2eJh7un1WrJdr7UeJIvvgOMQQkH37tjE1AULi+id
         5OdA==
X-Forwarded-Encrypted: i=1; AJvYcCU56bRCtUNq8y/fHz2Gn97ZVtO1K6wgV5a5bkNlMsLQi54KA98R3d8cIdIuEDdU6fLt/o0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/LfuEi+KIxrojle6lyWOMJBqmjCm7owxcCoBgj6kLbX8rTLPT
	bdKQvBk3st1Xdg0aXNe4vzmX46o/tVUIS00JV+WJr2CflpviK1yn913Tm1ulez1PllqDGuNWeUx
	DjcoVZC/CL9IlPpoUbjN80UJZyUDIVhF7na8d+mVUZUTTGKkClQ==
X-Gm-Gg: ASbGncsmN+uiP0RCZyE3+gN9SncniBtnM63fcfLa5Zd1hHW/lzCeHZqaS7POrrHFksk
	ejohmpzzWy4NbsCL+5urcX1PV2YijFjRG9+rhWtUg7J6Mbjs/UazEh4vh5+KjzNawaX3/hoLBMJ
	EkwUahOKTtBhxqQmPqlgI8e+aUesr/t6rDGNzEmiRnL5guNjjLahw8ClXs7cN96vMc6SjgjOo32
	X2zqqsEek5AgPqCLi6XXqdKL74C7n5iSvawUgA1u1cKWroPZ6aeM//JbECzSDB7p7QLojxO+v22
	xhxFbOfc1v+oZ4NHa4Rb+6u6hQnIgvf1oF48Pf5fgYZn47+mP+9j7xw=
X-Received: by 2002:a05:622a:1387:b0:467:674d:237f with SMTP id d75a77b69052e-46e12ad5f7bmr40518851cf.11.1737121496626;
        Fri, 17 Jan 2025 05:44:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHmIl4MCDkHkFsxi8fUyXS99BtrKRZsY+6w06Ii3eQgKuqou3xcsKirOxy10aWGIFujuL9O5w==
X-Received: by 2002:a05:622a:1387:b0:467:674d:237f with SMTP id d75a77b69052e-46e12ad5f7bmr40518371cf.11.1737121496270;
        Fri, 17 Jan 2025 05:44:56 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46e1042ef63sm11228641cf.71.2025.01.17.05.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 05:44:55 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, virtualization@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-perf-users@vger.kernel.org,
 xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
 linux-arch@vger.kernel.org, rcu@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
 bcm-kernel-feedback-list@broadcom.com
Cc: Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>,
 Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov
 <alexey.amakhalov@broadcom.com>, Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Paul
 Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave
 Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
 <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
 <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter
 <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, Boris
 Ostrovsky <boris.ostrovsky@oracle.com>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann
 <arnd@arndb.de>, Frederic Weisbecker <frederic@kernel.org>, "Paul E.
 McKenney" <paulmck@kernel.org>, Jason Baron <jbaron@akamai.com>, Steven
 Rostedt <rostedt@goodmis.org>, Ard Biesheuvel <ardb@kernel.org>, Neeraj
 Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes
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
 <samuel.holland@sifive.com>, Rong Xu <xur@google.com>, Nicolas Saenz
 Julienne <nsaenzju@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Yosry Ahmed <yosryahmed@google.com>, "Kirill A. Shutemov"
 <kirill.shutemov@linux.intel.com>, "Masami Hiramatsu (Google)"
 <mhiramat@kernel.org>, Jinghao Jia <jinghao7@illinois.edu>, Luis
 Chamberlain <mcgrof@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
 Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: Re: [PATCH v4 26/30] x86,tlb: Make __flush_tlb_global()
 noinstr-compliant
In-Reply-To: <52311c3d-83cf-4dc4-bbcb-5fbca8eb249c@intel.com>
References: <20250114175143.81438-1-vschneid@redhat.com>
 <20250114175143.81438-27-vschneid@redhat.com>
 <52311c3d-83cf-4dc4-bbcb-5fbca8eb249c@intel.com>
Date: Fri, 17 Jan 2025 14:44:42 +0100
Message-ID: <xhsmh5xmdh7w5.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 14/01/25 13:45, Dave Hansen wrote:
> On 1/14/25 09:51, Valentin Schneider wrote:
>> +	cr4 = this_cpu_read(cpu_tlbstate.cr4);
>> +	asm volatile("mov %0,%%cr4": : "r" (cr4 ^ X86_CR4_PGE) : "memory");
>> +	asm volatile("mov %0,%%cr4": : "r" (cr4) : "memory");
>> +	/*
>> +	 * In lieu of not having the pinning crap, hard fail if CR4 doesn't
>> +	 * match the expected value. This ensures that anybody doing dodgy gets
>> +	 * the fallthrough check.
>> +	 */
>> +	BUG_ON(cr4 != this_cpu_read(cpu_tlbstate.cr4));
>
> Let's say someone managed to write to cpu_tlbstate.cr4 where they
> cleared one of the pinned bits.
>
> Before this patch, CR4 pinning would WARN_ONCE() about it pretty quickly
> and also reset the cleared bits.
>
> After this patch, the first native_flush_tlb_global() can clear pinned
> bits, at least until native_write_cr4() gets called the next time. That
> seems like it'll undermine CR4 pinning at least somewhat.
>

The BUG_ON() should still catch any pinned bit mishandling, however...

> What keeps native_write_cr4() from being noinstr-compliant now? Is it
> just the WARN_ONCE()?
>

I don't think that's even an issue since __WARN_printf() wraps the print in
instrumentation_{begin,end}(). In v3 I made native_write_cr4() noinstr and
added a non-noinstr wrapper to be used in existing callsites.

AFAICT if acceptable we could make the whole thing noinstr and stick with
that; Peter, is there something I missed that made you write the handmade
noinstr CR4 RMW?


