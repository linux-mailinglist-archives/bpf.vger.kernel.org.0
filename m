Return-Path: <bpf+bounces-50794-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E34A2C9D4
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 18:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 382BB16DFA1
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 17:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39BBE19DF4C;
	Fri,  7 Feb 2025 17:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gy5PdcJb"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F543192D80
	for <bpf@vger.kernel.org>; Fri,  7 Feb 2025 17:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738948016; cv=none; b=aN4d62bAwAUSNhzXFxEGj1jlERtUBrkv1X5rMdUJwKerq8/agoQC/MYAn9vMLTvKP4zB/O4pKiUiSE17McunwJaB/A8PmPA1rkS8zCWAGVaRGe0Wrn9AJyFITFQ/QU0QWm3Ae5k29eDygJKu+2VfMit28389MtoZlq1jOtAcgaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738948016; c=relaxed/simple;
	bh=I2e5fwjdOHrC389H955xUrW7Yt08enQx3eznrVoldiA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=S2uNv21u5T6+015ma2g4L0vJ3MsKINUoNLtYu3SMmfBLV2E/QQT5saND6dXjKGpNhF1skz2CkUEnOQvCKba3uZt0TdGSAF2ji72ChZlckL+CrKRvB/gTP2pO/ODpNqrNBgevYsA+hZ4I69UQJg2jJvsfF7ZKd9C57sASTkLadY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gy5PdcJb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738948013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YX0Ta551pNoazXrou1rxJx7Jk32CWnG6aaI06lzcMPk=;
	b=Gy5PdcJbnHjL7K0E4kK4hk3QCTNCqxEyPsiDCzCFlFUSBHIc2grmLHdmMAyVhBThY98kTo
	Rn3nUgHYCdFM20G/rcpSBWwefwHz9jwJs8u6D1csMFh2MzOkHWti/C/jlaIelyw2LMpFUx
	xd9R5MoGiQw5qzU+xqO34VUPB//H/a4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-GQf7WWQ5PqCOUrGLzo1Xpw-1; Fri, 07 Feb 2025 12:06:52 -0500
X-MC-Unique: GQf7WWQ5PqCOUrGLzo1Xpw-1
X-Mimecast-MFC-AGG-ID: GQf7WWQ5PqCOUrGLzo1Xpw
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-38daf7d2d1cso1030819f8f.3
        for <bpf@vger.kernel.org>; Fri, 07 Feb 2025 09:06:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738948011; x=1739552811;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YX0Ta551pNoazXrou1rxJx7Jk32CWnG6aaI06lzcMPk=;
        b=v0Nk5axgrGRNM7Ou/u7TYc8r4GDCrUlzqC2hu1qkUaQBGhWCrNAjHdO6meEZNa4qqt
         vKIEZ43FJV1utdXPCIfM5dGXwIZ+dLKQd1QLDhrXG8mZEWmd4yziPOAc/NluLiapNADt
         8n5ugoAFo2QnQNUjk+vN7QpLjTBEUoPD9a/La3IuVW0qJWBUt9O0jLe9pe0KofTDmOVp
         pq9CvFVZsdLv0Gqe7ytzjkC1rEs65wXD/uu76IbItl8f9uwim9RSwcEZk1zJdyfcBZFC
         mG2EAJJ0Kkf2vs22zfS0wHQks/zUvTImk8KH3y3jVAd7+oQhEvG4Mk0rY55vrooLwE2P
         h2Zw==
X-Forwarded-Encrypted: i=1; AJvYcCUy/mgPbrePNR+5XUTJLFca6mAlm07umTqaN8ZOG164FfpwWW/yHrz12QYqhfv/vaqgLeM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywixaywz2Y35rYyBHqkNmZK7poq3HnModnNR2+RzJWqQxhdRal1
	oYnvRIqYoh+0HgJwX+yryjQYCOOUU7pUGQBfxGAuNDSy4JK79099e3UdteSyBJz4gPeHGKe8e5Q
	EVZDh9eW1Ro+/qMihKoqtLw5QcC9daoNS/hVUabrOjZD+AucYRA==
X-Gm-Gg: ASbGnctT1pIZRFEu/SusklzwbnZWqS9SXpYrNZvg6zifd8+YEwuXJfoXuqtenvdzCY1
	d1g8mUma4SuFoWQWG5gYGLGzJ4BX0n35PzmIRDfmhiRWoA1XgNWSALIOjoGh+aiUQgHAjr+EBD+
	TM+f0+N+XgSeFJsHDWHMcjVkKuWK1folFe8HgPl+YSPYB6mNApCIVyA9wV8MpqsQ15ZswfFbZGA
	bygk8D8CBtfuRp5iZot1/tQzF05/cMFpuUC1fA74QgqFoVTNMtC2YNaXl0MYz07JPEe1P9Kb3IH
	5+Su0sDYiz4Wx2XWUHZk3oxpOwKvo+w3xFj1I9vMQvycXiQEHVonlEV9eFe1HuRosQ==
X-Received: by 2002:a5d:638d:0:b0:386:5b2:a9d9 with SMTP id ffacd0b85a97d-38dc9497d11mr1924006f8f.53.1738948011062;
        Fri, 07 Feb 2025 09:06:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEOdkgTDMixdzesAbzZ6LQT5F1eKCI9U7dpB+ZFF0HwYFgHj2Fc571j17/M7jlf73QfQ/8NiQ==
X-Received: by 2002:a5d:638d:0:b0:386:5b2:a9d9 with SMTP id ffacd0b85a97d-38dc9497d11mr1923876f8f.53.1738948010215;
        Fri, 07 Feb 2025 09:06:50 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4391dca0041sm59887155e9.14.2025.02.07.09.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 09:06:49 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 virtualization@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-perf-users@vger.kernel.org, xen-devel@lists.xenproject.org,
 kvm@vger.kernel.org, linux-arch@vger.kernel.org, rcu@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
 bcm-kernel-feedback-list@broadcom.com, Juergen Gross <jgross@suse.com>,
 Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov
 <alexey.amakhalov@broadcom.com>, Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Paul
 Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave
 Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian
 Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>, Boris Ostrovsky
 <boris.ostrovsky@oracle.com>, Josh Poimboeuf <jpoimboe@kernel.org>, Pawan
 Gupta <pawan.kumar.gupta@linux.intel.com>, Sean Christopherson
 <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, Andy Lutomirski
 <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, "Paul E. McKenney"
 <paulmck@kernel.org>, Jason Baron <jbaron@akamai.com>, Steven Rostedt
 <rostedt@goodmis.org>, Ard Biesheuvel <ardb@kernel.org>, Neeraj Upadhyay
 <neeraj.upadhyay@kernel.org>, Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Uladzislau Rezki <urezki@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Zqiang <qiang.zhang1211@gmail.com>, Juri Lelli <juri.lelli@redhat.com>,
 Clark Williams <williams@redhat.com>, Yair Podemsky <ypodemsk@redhat.com>,
 Tomas Glozar <tglozar@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Kees Cook
 <kees@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Christoph
 Hellwig <hch@infradead.org>, Shuah Khan <shuah@kernel.org>, Sami Tolvanen
 <samitolvanen@google.com>, Miguel Ojeda <ojeda@kernel.org>, Alice Ryhl
 <aliceryhl@google.com>, "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
 Samuel Holland <samuel.holland@sifive.com>, Rong Xu <xur@google.com>,
 Nicolas Saenz Julienne <nsaenzju@redhat.com>, Geert Uytterhoeven
 <geert@linux-m68k.org>, Yosry Ahmed <yosryahmed@google.com>, "Kirill A.
 Shutemov" <kirill.shutemov@linux.intel.com>, "Masami Hiramatsu (Google)"
 <mhiramat@kernel.org>, Jinghao Jia <jinghao7@illinois.edu>, Luis
 Chamberlain <mcgrof@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
 Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: Re: [PATCH v4 22/30] context_tracking: Exit CT_STATE_IDLE upon
 irq/nmi entry
In-Reply-To: <xhsmh5xm0pkuo.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
References: <20250114175143.81438-1-vschneid@redhat.com>
 <20250114175143.81438-23-vschneid@redhat.com>
 <Z5A6NPqVGoZ32YsN@pavilion.home>
 <xhsmh5xm0pkuo.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Date: Fri, 07 Feb 2025 18:06:45 +0100
Message-ID: <xhsmhbjvdk7kq.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 27/01/25 12:17, Valentin Schneider wrote:
> On 22/01/25 01:22, Frederic Weisbecker wrote:
>> And NMIs interrupting userspace don't call
>> enter_from_user_mode(). In fact they don't call irqentry_enter_from_user_mode()
>> like regular IRQs but irqentry_nmi_enter() instead. Well that's for archs
>> implementing common entry code, I can't speak for the others.
>>
>
> That I didn't realize, so thank you for pointing it out. Having another
> look now, I mistook DEFINE_IDTENTRY_RAW(exc_int3) for the general case
> when it really isn't :(
>
>> Unifying the behaviour between user and idle such that the IRQs/NMIs exit the
>> CT_STATE can be interesting but I fear this may not come for free. You would
>> need to save the old state on IRQ/NMI entry and restore it on exit.
>>
>
> That's what I tried to avoid, but it sounds like there's no nice way around it.
>
>> Do we really need it?
>>
>
> Well, my problem with not doing IDLE->KERNEL transitions on IRQ/NMI is that
> this leads the IPI deferral logic to observe a technically-out-of-sync sate
> for remote CPUs. Consider:
>
>   CPUx            CPUy
>                     state := CT_STATE_IDLE
>                     ...
>                     ~>IRQ
>                     ...
>                     ct_nmi_enter()
>                     [in the kernel proper by now]
>
>   text_poke_bp_batch()
>     ct_set_cpu_work(CPUy, CT_WORK_SYNC)
>       READ CPUy ct->state
>       `-> CT_IDLE_STATE
>       `-> defer IPI
>
>
> I thought this meant I would need to throw out the "defer IPIs if CPU is
> idle" part, but AIUI this also affects CT_STATE_USER and CT_STATE_GUEST,
> which is a bummer :(

Soooo I've been thinking...

Isn't

  (context_tracking.state & CT_RCU_WATCHING)

pretty much a proxy for knowing whether a CPU is executing in kernelspace,
including NMIs?

NMI interrupts userspace/VM/idle -> ct_nmi_enter()   -> it becomes true
IRQ interrupts idle              -> ct_irq_enter()   -> it becomes true
IRQ interrupts userspace         -> __ct_user_exit() -> it becomes true
IRQ interrupts VM                -> __ct_user_exit() -> it becomes true

IOW, if I gate setting deferred work by checking for this instead of
explicitely CT_STATE_KERNEL, "it should work" and prevent the
aforementioned issue? Or should I be out drinking instead? :-)


