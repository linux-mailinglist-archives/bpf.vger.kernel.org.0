Return-Path: <bpf+bounces-54740-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C7CA71326
	for <lists+bpf@lfdr.de>; Wed, 26 Mar 2025 09:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C34E43ABC1E
	for <lists+bpf@lfdr.de>; Wed, 26 Mar 2025 08:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66F21A3031;
	Wed, 26 Mar 2025 08:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yfhi5Fez"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDBD19F121
	for <bpf@vger.kernel.org>; Wed, 26 Mar 2025 08:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742979375; cv=none; b=IRnTc0uQqFJd6xwckxme0u5Eids1YtPzechqxiW8bWz6BWRx6DpVqsjWKQr7LC3+LYLVrwsO84T5radmP2tE4tNHUOpitqJQRrljIKb3h2n/eMOUqK74xbt5DfVzb0QWJfxvRxXdFoISutt95VeVZHFlYqZUDUxaXmyQb1593C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742979375; c=relaxed/simple;
	bh=F1foF754pT94sYW+RFuaojIiZBGsMyKzZaxtQLw5N2w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mge8GvlWvYvbjdAAKX4x0y4YMGbZmizrl4WknOhwRAXMZcUXWceYXpKCCd68rocFoapa2T3RFBEIdSKTJF0iPbJwW6KjP3Jf1L2Z9pHZgDZf9/eYJht1MZyJNNhXXYTIg8yf8aBAAvimyJhBBD8y7b4UtBOa/joOU9ezK9iV8LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yfhi5Fez; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742979372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ctJ2iKS2diL395+WMoYK5u4EcCy52/qwtJ7bficlTlI=;
	b=Yfhi5Fezki67ljs+vfIlE/81Mso6xrv5nuZ7fPeDMK6fu7mYlLHIo9iF3mg3xgQKjY1yk1
	E6/zZwNvVWzbt+iBbMXz3X0SSRHG9FqnZ7aEsdMBo0H9uOLR6LjzHwbOHKoP0fae0k0K2u
	p/gGMSK+IreznDYsmXWDdt3ikTiZlDU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-xmaEDjXDOnSDLfMRz183lg-1; Wed, 26 Mar 2025 04:56:11 -0400
X-MC-Unique: xmaEDjXDOnSDLfMRz183lg-1
X-Mimecast-MFC-AGG-ID: xmaEDjXDOnSDLfMRz183lg_1742979370
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43d00017e9dso41723765e9.0
        for <bpf@vger.kernel.org>; Wed, 26 Mar 2025 01:56:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742979370; x=1743584170;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ctJ2iKS2diL395+WMoYK5u4EcCy52/qwtJ7bficlTlI=;
        b=Uh7sCk/g4l4fkjgfhSLW0h9yYg3WOllgHP8YjChomApwm8Ze5zGm0AdFiyZZoGmGBy
         yXEmy7RVliPvxrx/OXaRthtP0VVVFB8nBjXWf7zaVpzh2ucEzOUsZW1Y6D4rvUIxh8LW
         saIlNnz5L5+dhHEJA4BqXwrMdhFss1NQmKOd3+qkpo4j63SWajdZ7LU9wQYc5kII3rR7
         cC8wGTzPTOgQ46nY+FCcnWhMHqWm52lSg93GCfI5pY1zss1O0/Wv55QN8jgL4KudPqfM
         guPsVITN8iVTZBTVnFvW+h9EPSAP3tvizl/ZFDAxnevHMEuKEgLx2qQbHt6ZZlVdYWkZ
         ThPw==
X-Forwarded-Encrypted: i=1; AJvYcCUgU3rf7EO9zN9ntQkdkIldLLQA0PJmL29eb8jS/wukzdxN0YGQ2sPTbzrzqeQidlmV3dk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcK8GcBOKyD8xrqpecWSHdG/83j9oSKkC2RkibneSQ3PpkhKHT
	flNoKUw/s2MJuwaobB2lODG2ZVQt4jK9SxW43EQXff8A4ayfGvNkDkOoY8v+YeOYZ9xo2gf/+2E
	FEQviguQcuHFJI991KYtpb6t9XYJHvEXVkErzzV2663NBAF4aYQ==
X-Gm-Gg: ASbGncttj8stpM/Fie5T421MQSLZiAlMd7YnrPOWLnqWbTv/dxLTWKc18cPotk5fn9W
	yamnnUE5uKA2LQg/+Av1+ma9avqs6TOnpXF9ONc57lE1iFhXtWk09kL9uzVqpK+hDrCXh6K8rhN
	hfz45qDKBXwYDgAOslOEbfhf5ysqob6u4FyGyfOYmKJo3bqy8lO/DnGz6J2KkVdCVt0IRdCUDGY
	5ZdXIhe620K9+nUMK1FXsS4MUvwsV9rngWThTJfgIQ/QREnKvW7EAl+IJ9ZwpNZUMC2Z3jAqWYV
	o/QpkBPN3T9NauxCg3L1S8iyfuDp32oRsfKf49Lz7Tt2ZgVUe6EGzIqmqcMjVC1NKU7Q59Qyfh5
	/
X-Received: by 2002:a05:600c:5025:b0:43d:300f:fa51 with SMTP id 5b1f17b1804b1-43d509ea850mr177277765e9.9.1742979369926;
        Wed, 26 Mar 2025 01:56:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmtDcswSiHFvojL/8/X8XbIAG8pFv35YFW9PLdaiNFn4jtJsKwcY6xoArge3H5jo1mJzUGFA==
X-Received: by 2002:a05:600c:5025:b0:43d:300f:fa51 with SMTP id 5b1f17b1804b1-43d509ea850mr177277375e9.9.1742979369446;
        Wed, 26 Mar 2025 01:56:09 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39ac67970a2sm5909443f8f.16.2025.03.26.01.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 01:56:08 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Jann Horn <jannh@google.com>, Rik van Riel <riel@surriel.com>
Cc: Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, virtualization@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-perf-users@vger.kernel.org,
 xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
 linux-arch@vger.kernel.org, rcu@vger.kernel.org,
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
 <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Frederic Weisbecker
 <frederic@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, Jason
 Baron <jbaron@akamai.com>, Steven Rostedt <rostedt@goodmis.org>, Ard
 Biesheuvel <ardb@kernel.org>, Neeraj Upadhyay
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
Subject: Re: [PATCH v4 29/30] x86/mm, mm/vmalloc: Defer
 flush_tlb_kernel_range() targeting NOHZ_FULL CPUs
In-Reply-To: <CAG48ez2bSh6=J8cXJhqYX=Y8pXcGsFgC05HsGcF0b1sJK2VH7A@mail.gmail.com>
References: <20250114175143.81438-1-vschneid@redhat.com>
 <20250114175143.81438-30-vschneid@redhat.com>
 <CAG48ez1Mh+DOy0ysOo7Qioxh1W7xWQyK9CLGNU9TGOsLXbg=gQ@mail.gmail.com>
 <xhsmh34hhh37q.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <CAG48ez3H8OVP1GxBLdmFgusvT1gQhwu2SiXbgi8T9uuCYVK52w@mail.gmail.com>
 <xhsmh5xlhk5p2.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <CAG48ez1EAATYcX520Nnw=P8XtUDSr5pe+qGH1YVNk3xN2LE05g@mail.gmail.com>
 <xhsmh34gkk3ls.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <352317e3-c7dc-43b4-b4cb-9644489318d0@intel.com>
 <xhsmhjz9mj2qo.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <d0450bc8-6585-49ca-9cad-49e65934bd5c@intel.com>
 <xhsmhh64qhssj.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <eef09bdc-7546-462b-9ac0-661a44d2ceae@intel.com>
 <xhsmhfrk84k5k.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <408ebd8b-4bfb-4c4f-b118-7fe853c6e897@intel.com>
 <xhsmhy0wtngkd.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <CAG48ez2bSh6=J8cXJhqYX=Y8pXcGsFgC05HsGcF0b1sJK2VH7A@mail.gmail.com>
Date: Wed, 26 Mar 2025 09:56:06 +0100
Message-ID: <xhsmhv7rwnpax.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 25/03/25 19:41, Jann Horn wrote:
> On Tue, Mar 25, 2025 at 6:52=E2=80=AFPM Valentin Schneider <vschneid@redh=
at.com> wrote:
>> On 20/02/25 09:38, Dave Hansen wrote:
>> > But, honestly, I'm still not sure this is worth all the trouble. If
>> > folks want to avoid IPIs for TLB flushes, there are hardware features
>> > that *DO* that. Just get new hardware instead of adding this complicat=
ed
>> > pile of software that we have to maintain forever. In 10 years, we'll
>> > still have this software *and* 95% of our hardware has the hardware
>> > feature too.
>>
>> Sorry, you're going to have to deal with my ignorance a little bit longe=
r...
>>
>> Were you thinking x86 hardware specifically, or something else?
>> AIUI things like arm64's TLBIVMALLE1IS can do what is required without a=
ny
>> IPI:
>>
>> C5.5.78
>> """
>> The invalidation applies to all PEs in the same Inner Shareable shareabi=
lity domain as the PE that
>> executes this System instruction.
>> """
>>
>> But for (at least) these architectures:
>>
>>   alpha
>>   x86
>>   loongarch
>>   mips
>>   (non-freescale 8xx) powerpc
>>   riscv
>>   xtensa
>>
>> flush_tlb_kernel_range() has a path with a hardcoded use of on_each_cpu(=
),
>> so AFAICT for these the IPIs will be sent no matter the hardware.
>
> On X86, both AMD and Intel have some fairly recently introduced CPU
> features that can shoot down TLBs remotely.
>
> The patch series
> <https://lore.kernel.org/all/20250226030129.530345-1-riel@surriel.com/>
> adds support for the AMD flavor; that series landed in the current
> merge window (it's present in the mainline git repository now and should
> be part of 6.15). I think support for the Intel flavor has not yet
> been implemented, but the linked patch series mentions a plan to look
> at the Intel flavor next.

Thanks for the info!


