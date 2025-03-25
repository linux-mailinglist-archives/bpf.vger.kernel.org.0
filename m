Return-Path: <bpf+bounces-54707-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76046A70889
	for <lists+bpf@lfdr.de>; Tue, 25 Mar 2025 18:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DC171763E9
	for <lists+bpf@lfdr.de>; Tue, 25 Mar 2025 17:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CFE126463D;
	Tue, 25 Mar 2025 17:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G12cdrLZ"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F17263F46
	for <bpf@vger.kernel.org>; Tue, 25 Mar 2025 17:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742925164; cv=none; b=EBkMRy/p2/6ecAT4zmcL+nTV0Ol5ewxqc7ApSLuzyWhnF2OLEfscG8r6SKUa0LMvsbOY/nI34h27WlVPW6t6lOmpXiASr4gpKcm2cQ0+2jAW9uze6aKvhA2tc+t93AkMQnXmljbpTdMKXJSA+mhnntiBRMDqs11agjHZNmRmPro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742925164; c=relaxed/simple;
	bh=rqgWaiOeIHt4zG94xEwnMSEUgdwajlC/lHAStnrVhlo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ugw9+a9OdEhfHl8RgI0bAhsGBBpZlN+AjxHHNQG3S6PP4Rx2u7IoBpWZqkjPfIrMw166bXAmkagWQYJ8R2a1/tCh4YY+ONIjkbogqkd5Nguwhm1U2OYZNjD/IjVuWMplAQzqgYajTPfLMm5fKy4Wub+et2UyjXIl1HaYSsoR+dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G12cdrLZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742925161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=58+r+FAQ5TTby/P3+2e15XArHywgR9oB31F4zzKw58o=;
	b=G12cdrLZiH2O0I4Fg9LV2QgbNKilLkFryvzQoZqQyrdz4IU7BXV+H8AgVX+ixYY3mzjs0J
	pr8rcxZr3R2Od8PodkTO80jh4WHY8KNzNIjFL+0u585isJEqAChbTEthKR4TJWoPYyrqkh
	Lpm5nAIXo8zJzGyw9V+1NuhsjdY9mtU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-lSD6S9rsNGuzicgCWBakUQ-1; Tue, 25 Mar 2025 13:52:40 -0400
X-MC-Unique: lSD6S9rsNGuzicgCWBakUQ-1
X-Mimecast-MFC-AGG-ID: lSD6S9rsNGuzicgCWBakUQ_1742925159
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43ab5baf62cso39377415e9.0
        for <bpf@vger.kernel.org>; Tue, 25 Mar 2025 10:52:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742925159; x=1743529959;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=58+r+FAQ5TTby/P3+2e15XArHywgR9oB31F4zzKw58o=;
        b=Uuu5Duf3s7rV991R7pr0xYj9AKRLd/xZE8kfg/8XXytP+RYOrPj3EYovTs3hYpj78O
         Paw7mUJOOpefjgM8MieOISBUe47CE5gRb+wVacHy6xdJzrtBSA2PMxokpcsRcE8v7muF
         D4C2bnG0jRB0Q75sbCwACPGi1/6N7Otiq2eBDl1hIAYkruYaMfMatM+/LZ+PWeJwqoTE
         O8zeoz9fc9VgMF4Wp/iiokZ5ELAVdx2eTL4sTcpypZ2arxbbNFHK+Qmv/AHeWPw267L0
         T9CQ+9fFyw/HPgyLtGh8I6yDQQIrgi8viC1FFqQOp3zJVeh2XWJy56QHHs638x93ZGWf
         AkaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPRwAeh62XqnpAcVvx8VgvCseYZy4tt8tnLD6Dw9m+Hj6oT/zyyag8d7Bic9yjM5YVm5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWW4WIrfOfPmuRANDZENPjetDvVNP7Z8qRUck3qAIi08sZ3tZB
	+M0BeGWYgto0xaLvPexebW/Prcwu2JAirlasAfw0saVYWsO5yTZlcd5UnIjKeS6h5SwvFsK5Qm5
	D9GIcwzkZISa2Gv9Ud23NFS+9LP4nmQiJwR4b3LMgeWGB51vWPA==
X-Gm-Gg: ASbGnctaGZ+FBLj4mUBbK2SD3e2x5lJFB7pbKWlxmpNz0HWR38vT+Kz+sHYYPs2GNaG
	JvjlSXfTuXa81EfiMVwjwIEX6DarJqT3+rbvizuC0G22c8yvEywfvsg1j9zGnLwJBpgQUYWFF27
	IETVHI/oGIsRSmPgul0R7qM6lhhDhKfOOkqjp4zvOu2XvEKoM+CTpcKz3ohUXEjSMmP/nMN994b
	yjAla5yskIC7o0aFyXOS1QulhpyegfUiloFda/C4BKVZi/EzplXR9jpXNtsN0BN/mrtAMURZJAv
	pO5ThRVluMHvDtK6uvcHdPo2qJK53anQMxka+HpzXRSWvOjnaE2ohVHZgyu083Sd+BOEmPaKw4p
	m
X-Received: by 2002:a05:600c:4584:b0:43c:fe85:e4ba with SMTP id 5b1f17b1804b1-43d509f4b25mr191666495e9.15.1742925159173;
        Tue, 25 Mar 2025 10:52:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFE+waNkOHjpFuU78xXxVfBVrthL7+/n2itqapsAHnKkAlkbjOyC6OGUhEtlUEcPF/6kvS3dA==
X-Received: by 2002:a05:600c:4584:b0:43c:fe85:e4ba with SMTP id 5b1f17b1804b1-43d509f4b25mr191665765e9.15.1742925158655;
        Tue, 25 Mar 2025 10:52:38 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9b409fsm14543767f8f.50.2025.03.25.10.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 10:52:37 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Dave Hansen <dave.hansen@intel.com>, Jann Horn <jannh@google.com>
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
In-Reply-To: <408ebd8b-4bfb-4c4f-b118-7fe853c6e897@intel.com>
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
Date: Tue, 25 Mar 2025 18:52:34 +0100
Message-ID: <xhsmhy0wtngkd.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 20/02/25 09:38, Dave Hansen wrote:
> But, honestly, I'm still not sure this is worth all the trouble. If
> folks want to avoid IPIs for TLB flushes, there are hardware features
> that *DO* that. Just get new hardware instead of adding this complicated
> pile of software that we have to maintain forever. In 10 years, we'll
> still have this software *and* 95% of our hardware has the hardware
> feature too.

Sorry, you're going to have to deal with my ignorance a little bit longer...

Were you thinking x86 hardware specifically, or something else?
AIUI things like arm64's TLBIVMALLE1IS can do what is required without any
IPI:

C5.5.78
"""
The invalidation applies to all PEs in the same Inner Shareable shareability domain as the PE that
executes this System instruction.
"""

But for (at least) these architectures:

  alpha
  x86
  loongarch
  mips
  (non-freescale 8xx) powerpc
  riscv
  xtensa

flush_tlb_kernel_range() has a path with a hardcoded use of on_each_cpu(),
so AFAICT for these the IPIs will be sent no matter the hardware.



