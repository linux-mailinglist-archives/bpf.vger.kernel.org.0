Return-Path: <bpf+bounces-49166-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E495A14C65
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 10:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5405C167B43
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 09:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5141FCF7D;
	Fri, 17 Jan 2025 09:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DHBRYnQc"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB97F1FBCA7
	for <bpf@vger.kernel.org>; Fri, 17 Jan 2025 09:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737107281; cv=none; b=NpG8xsp7Dr3Z9+yNh5naGbz2vsPDNoj+8St3OrPcbEvIJ/XKaHD8xfdMTAns+HRMmwU/sr2NapTzY07VjM+saiKnSxSvGvkaAIeG5f4TrjCZHUfiJE6AFklEd2KJ/OBtOFSvRB5rVHCgPT9G4vx2gt/d1lqjm7kwiCI/symDdb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737107281; c=relaxed/simple;
	bh=F2gqeuB0aLhR/bzKUvYunwZ5S0liP9KO05qoNp3Tqo0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OZTfdNBMFb6e7zP82jJADnNwsEKX7zIYzqtUPmFTpAEsjaEcudw4nfRCr1xPc8ItCmYUvucKOsE5PLz5cN7WSm9xyJNETiuu7FxduvBoTZz2KePcB7I2SONM4LwbAgMHyzUZZzgIc8wwWa6Vt+oe3uP7XwUGLUvehGCxtIukJRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DHBRYnQc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737107277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VvR9KfuLK5jT/0k1YGBwcApH+9cF5PsvBxGMV+DYi4c=;
	b=DHBRYnQclWBz29AczmtdH2psrHQWNAp2LDJjwl32uDPBUSGvi1VCdiDO7Zu95RYG4y3OpB
	9Tebjf3WoGAbLJ64WOQ9vzSA4BycUOWy/bKAHOHksNptStG7BmNFug3JbEo5RGgIFyw1yE
	ZQ5x15X5d61OUrj/+AN5FwVAZ+jtRyE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-ZHR_96cMPUK4MEnbAcYsdw-1; Fri, 17 Jan 2025 04:47:55 -0500
X-MC-Unique: ZHR_96cMPUK4MEnbAcYsdw-1
X-Mimecast-MFC-AGG-ID: ZHR_96cMPUK4MEnbAcYsdw
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43623bf2a83so13472485e9.0
        for <bpf@vger.kernel.org>; Fri, 17 Jan 2025 01:47:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737107274; x=1737712074;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VvR9KfuLK5jT/0k1YGBwcApH+9cF5PsvBxGMV+DYi4c=;
        b=GT2XzWzhRdSYZpM9H1TIenw9Gut2W7gaL5uaycmvh7ta7jkZorn7flPlwQP2vjbTp5
         yak0WXkfD8QlPhXyh08+ctdoWdCpH52/+96qCNYYQBTdbD6tmBTF+GQzKf5ily2JZLKc
         1AcJM7cc8t0SlnOY18P4eKcAAgAZKJfZh7d1h/0/z9dG8CTm5AScqngFL/B/fXnol+IJ
         r4adUivB1UfdgYvk9LD6h819CM0uisk3Jzblp/h2FtKBTgyQ24jiJs2JYHhGwnA1U3y+
         6wDPEPBjKtpkLuNMWhUgxtyOR7hXYKg3WAGwLnU6e3XKZKAmucVU9oa0Pcv0DE91TeA/
         v6zA==
X-Forwarded-Encrypted: i=1; AJvYcCWKMTN4l1MftAxFU/M/ndPg/jaqDQIj21tfTIEg74zU31iTolZRDAHQ5NkVchEkZYTptTA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhXrw5c+PKlBT5wuycqPTfczlXYMiTRFbDjMG4Hb38j0/erfWV
	Fb4+wf2wL2wX0QBr5lHAgwo+YgqCbEAdkgcy5x0Tkn/j06ybc+k/KG+qANx1gNyv+9Ha5qD7Hen
	oTJP/iH9gCiRHiMTHcdrhTkGkiQFY6CRG0Gdmrkw7sSQ56uRasg==
X-Gm-Gg: ASbGncv7DnxvdFFoTH4Exc0CiRH64X3AFaeDvG8ZeePe9YeU63jpyBhc2mfjb/XGH14
	66MFdVANhMGvi1v57OPGhnRu84xSC3WBEb7/ABSC+0nzyxe6esek3ICPLL7IECUkCO/wQwYK0HW
	99F3c4Hc+oWKuuEQBFoYZEgizBBd8tq2c3KhuExKe07Me4uds5tUMw6y8PhPYAvVFY0tE1ixhdU
	KISVLeM7Wp0P40mOST4mniGPdDY+KKVadpE/rkDl0FoZbpnIkY6SkuoPkJbtpoLXKvarwxDo9tj
	lkV0MZ6PyWfNonGu/ZGlab6OAHVYIDc/6iLZ8EEIbg==
X-Received: by 2002:a05:600c:9a3:b0:434:fa73:a907 with SMTP id 5b1f17b1804b1-4389191b819mr16313885e9.13.1737107273768;
        Fri, 17 Jan 2025 01:47:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHToHDxXT5KMOIEW1byUZUSn/LchRidR5pJg2ZFHbUxu07B2Q/njknWrWkjTXhDYHkp8NfwWQ==
X-Received: by 2002:a05:600c:9a3:b0:434:fa73:a907 with SMTP id 5b1f17b1804b1-4389191b819mr16313255e9.13.1737107273291;
        Fri, 17 Jan 2025 01:47:53 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438904131f5sm27135155e9.11.2025.01.17.01.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 01:47:52 -0800 (PST)
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
In-Reply-To: <Z4bTlZkqihaAyGb4@google.com>
References: <20250114175143.81438-1-vschneid@redhat.com>
 <20250114175143.81438-26-vschneid@redhat.com>
 <Z4bTlZkqihaAyGb4@google.com>
Date: Fri, 17 Jan 2025 10:47:49 +0100
Message-ID: <xhsmhed11hiuy.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 14/01/25 13:13, Sean Christopherson wrote:
> On Tue, Jan 14, 2025, Valentin Schneider wrote:
>> text_poke_bp_batch() sends IPIs to all online CPUs to synchronize
>> them vs the newly patched instruction. CPUs that are executing in userspace
>> do not need this synchronization to happen immediately, and this is
>> actually harmful interference for NOHZ_FULL CPUs.
>
> ...
>
>> This leaves us with static keys and static calls.
>
> ...
>
>> @@ -2317,11 +2334,20 @@ static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries
>>       * First step: add a int3 trap to the address that will be patched.
>>       */
>>      for (i = 0; i < nr_entries; i++) {
>> -		tp[i].old = *(u8 *)text_poke_addr(&tp[i]);
>> -		text_poke(text_poke_addr(&tp[i]), &int3, INT3_INSN_SIZE);
>> +		void *addr = text_poke_addr(&tp[i]);
>> +
>> +		/*
>> +		 * There's no safe way to defer IPIs for patching text in
>> +		 * .noinstr, record whether there is at least one such poke.
>> +		 */
>> +		if (is_kernel_noinstr_text((unsigned long)addr))
>> +			cond = NULL;
>
> Maybe pre-check "cond", especially if multiple ranges need to be checked?  I.e.
>
>               if (cond && is_kernel_noinstr_text(...))
>> +
>> +		tp[i].old = *((u8 *)addr);
>> +		text_poke(addr, &int3, INT3_INSN_SIZE);
>>      }
>>
>> -	text_poke_sync();
>> +	__text_poke_sync(cond);
>>
>>      /*
>>       * Second step: update all but the first byte of the patched range.
>
> ...
>
>> +/**
>> + * is_kernel_noinstr_text - checks if the pointer address is located in the
>> + *                    .noinstr section
>> + *
>> + * @addr: address to check
>> + *
>> + * Returns: true if the address is located in .noinstr, false otherwise.
>> + */
>> +static inline bool is_kernel_noinstr_text(unsigned long addr)
>> +{
>> +	return addr >= (unsigned long)__noinstr_text_start &&
>> +	       addr < (unsigned long)__noinstr_text_end;
>> +}
>
> This doesn't do the right thing for modules, which matters because KVM can be
> built as a module on x86, and because context tracking understands transitions
> to GUEST mode, i.e. CPUs that are running in a KVM guest will be treated as not
> being in the kernel, and thus will have IPIs deferred.  If KVM uses a static key
> or branch between guest_state_enter_irqoff() and guest_state_exit_irqoff(), the
> patching code won't wait for CPUs to exit guest mode, i.e. KVM could theoretically
> use the wrong static path.
>

AFAICT guest_state_{enter,exit}_irqoff() are only used in noinstr functions
and thus such a static key usage should at the very least be caught and
warned about by objtool - when this isn't built as a module.

I never really thought about noinstr sections for modules; I can get
objtool to warn about a non-noinstr allowed key being used in
e.g. vmx_vcpu_enter_exit() just by feeding it the vmx.o:

arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_vcpu_enter_exit.isra.0+0x0: dummykey: non-RO static key usage in noinstr

...but that requires removing a lot of code first because objtool stops
earlier in its noinstr checks as it hits functions it doesn't have full
information on, e.g.

arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_vcpu_enter_exit+0x21c: call to __ct_user_enter() leaves .noinstr.text section

__ct_user_enter() *is* noinstr, but you don't get that from just the header prototype.

> I don't expect this to ever cause problems in practice, because patching code in
> KVM's VM-Enter/VM-Exit path that has *functional* implications, while CPUs are
> actively running guest code, would be all kinds of crazy.  But I do think we
> should plug the hole.
>
> If this issue is unique to KVM, i.e. is not a generic problem for all modules (I
> assume module code generally isn't allowed in the entry path, even via NMI?), one
> idea would be to let KVM register its noinstr section for text poking.


