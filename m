Return-Path: <bpf+bounces-49682-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CB9A1BAF5
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 17:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0C80162A9C
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 16:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCC81990C5;
	Fri, 24 Jan 2025 16:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AeowmUQK"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F271FBF6
	for <bpf@vger.kernel.org>; Fri, 24 Jan 2025 16:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737737506; cv=none; b=N2Ex4xwBuUpAPRUS/fneMRZX3TEJ8QPkXcFznRW5OhjIb6dkUL5eDyrw9zz7MJ47c0h/ceqXq8zh08yKpoZA0rZh8yFG13Lh5yMym8BDQNGCEYSW5yvSNpFCqDgMGrbabmKT/ZVZtYPlZqUGFcPkuyN9MtJGSyE2e6yTfsUlMqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737737506; c=relaxed/simple;
	bh=DwitzjRGQEzgyZZn0UD4LNiBUZsqGx1Qrum3CBb5LtE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pVaED99jqpepb2xypbfDlagXVri0ibEm/xuOOwOBqV3ovpMr01roqTo0BRXts1T//E3h/Qksw2IwoWhTfzqZf+fK4Xhk3JjxYmoMpT8aeHkqo596YDMRJEYNTSFNWMqSW7a3LxKEvpJ48JM5Lw4Wh04bcPdK5Kwfc1nM5qNGhxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AeowmUQK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737737503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DwitzjRGQEzgyZZn0UD4LNiBUZsqGx1Qrum3CBb5LtE=;
	b=AeowmUQKquRtYX1yDylCy0Zlnu0MqwzCXszE86NlWvLtIQxDhDAFZ+6JfVFnEPNlLhayeY
	zNpQVcWmtM6gBmyRVKLx11XiVa7rf5cieHWUi3Q94S/IaWdlYvR/DkL4UjWF0hP89NaaLB
	BG+dRM2+5B8se8tw5WepG8ajk2+rZ5g=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-YlXmjeIMPYCEv57jF7jWVQ-1; Fri, 24 Jan 2025 11:51:41 -0500
X-MC-Unique: YlXmjeIMPYCEv57jF7jWVQ-1
X-Mimecast-MFC-AGG-ID: YlXmjeIMPYCEv57jF7jWVQ
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-46dd46d759eso39640881cf.2
        for <bpf@vger.kernel.org>; Fri, 24 Jan 2025 08:51:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737737501; x=1738342301;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DwitzjRGQEzgyZZn0UD4LNiBUZsqGx1Qrum3CBb5LtE=;
        b=DcieAlkqdEbtIkQVsEUxmd6cm4o8nCxnUP4ywR1WCSjU8+Q5dWAwevXkcovY8FqkY9
         lgFcUYw3JIr6/ygjicarlqLRg98iA+XNpkwZVLM4FPxqTQmuwNTTxHACxmTokqUps414
         op+P1DWBvC4pBUyYsGRooCGbBn6fTegZnwbrtMjo4Z6HhpVnOwdhH7VPpbCjppHLbuna
         KykW0UO+BuyVGib7H7/7+cTKoVgRH9vtm+vtU2W+CfFJUCaKrDr7Bg4JZ/XMHCAbbkmp
         Nx32GuFr6frJsgHg/hVfCZVp0cg4ydnBW8g6pHtisoOuv/mxlxJdPOCRstVPlzYiZzhq
         JKvw==
X-Forwarded-Encrypted: i=1; AJvYcCUCSP+Hs3pMcbrUlZ0RbPJ3iWdhvrbQxd8tWLGNx7VGJIQsl+fMwJV7qRTTjzVapdchamY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbSNF4AYmjf5DMbjFmvvD+l2aX4+Tkq79J+nq8j+/zZC+xF7IP
	Ni6SsyIM9rzpIqESH9riOrzJe3dHfx6zRmBaO/O2ywV06whgdvAS7ddG+HUwXnn+NrhWAN7Ev0x
	J+b6mz1RWyk5lCR+mSRzMupEVFbM5MJbXpPFSoDEy2rgrSn0QBg==
X-Gm-Gg: ASbGnctd5/zfcoUEyJdbOT4IsJLH8Bj8ka0JIZgmMy3yrWSaN4PFNHXw3bkio7NekQW
	S134KIIaucaa43lw1wSEpiARGcCtt/HRPR9I6HW0slxpTegpFzLJ6mR99djbrnphy8q+3ecZf2X
	6fpsS/I37bwnIZ4oY35fvvj99WpKgSIKnhuAh297cS7YavbtOCBrQOt5veDNd0ZgFL5GGW/+FPJ
	McMjt2Pe4oobUCiNsacDZh6yM8oT0YZ+1dcWhKe5a2I13l3A0egUPri0jtpyQJsT8P2xU/H6tMp
	jb9uADnrGuOPb3ippCG0Fqm3pBP8eaWi76ivkTl3hj3y5L1nNDcrE3I=
X-Received: by 2002:a05:6214:1302:b0:6d8:861f:adca with SMTP id 6a1803df08f44-6e1b2235c9fmr497774816d6.42.1737732153370;
        Fri, 24 Jan 2025 07:22:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE5TeadQAXYF5iUiWYdZcwN/B3B0GhQEA3OgvrN+YGY06rhpOtkdAXjp93P8gBhIIoKYtqxZQ==
X-Received: by 2002:a05:6214:1302:b0:6d8:861f:adca with SMTP id 6a1803df08f44-6e1b2235c9fmr497773786d6.42.1737732152904;
        Fri, 24 Jan 2025 07:22:32 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e2058c2a51sm9344776d6.109.2025.01.24.07.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 07:22:32 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Uladzislau Rezki <urezki@gmail.com>, Jann Horn <jannh@google.com>,
 linux-kernel@vger.kernel.org, x86@kernel.org,
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
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan
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
Subject: Re: [PATCH v4 29/30] x86/mm, mm/vmalloc: Defer
 flush_tlb_kernel_range() targeting NOHZ_FULL CPUs
In-Reply-To: <Z4_Sl-zu7GprkbaL@pc636>
References: <20250114175143.81438-1-vschneid@redhat.com>
 <20250114175143.81438-30-vschneid@redhat.com>
 <CAG48ez1Mh+DOy0ysOo7Qioxh1W7xWQyK9CLGNU9TGOsLXbg=gQ@mail.gmail.com>
 <xhsmh34hhh37q.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <Z4qBMqcMg16p57av@pc636>
 <xhsmhwmetfk9d.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <Z44wSJTXknQVKWb0@pc636>
 <xhsmhr04xfow1.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <Z4_Sl-zu7GprkbaL@pc636>
Date: Fri, 24 Jan 2025 16:22:19 +0100
Message-ID: <xhsmh8qr0p784.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 21/01/25 18:00, Uladzislau Rezki wrote:
>> >
>> > As noted before, we defer flushing for vmalloc. We have a lazy-threshold
>> > which can be exposed(if you need it) over sysfs for tuning. So, we can add it.
>> >
>>
>> In a CPU isolation / NOHZ_FULL context, isolated CPUs will be running a
>> single userspace application that will never enter the kernel, unless
>> forced to by some interference (e.g. IPI sent from a housekeeping CPU).
>>
>> Increasing the lazy threshold would unfortunately only delay the
>> interference - housekeeping CPUs are free to run whatever, and so they will
>> eventually cause the lazy threshold to be hit and IPI all the CPUs,
>> including the isolated/NOHZ_FULL ones.
>>
> Do you have any testing results for your workload? I mean how much
> potentially we can allocate. Again, maybe it is just enough to back
> and once per-hour offload it.
>

Potentially as much as you want... In our Openshift environments, you can
get any sort of container executing on the housekeeping CPUs and they're
free to do pretty much whatever they want. Per CPU isolation they're not
allowed/meant to disturb isolated CPUs, however.

> Apart of that how critical IPIing CPUs affect your workloads?
>

If I'm being pedantic, a single IPI to an isolated CPU breaks the
isolation. If we can't quiesce IPIs to isolated CPUs, then we can't
guarantee that whatever is running on the isolated CPUs is actually
isolated / shielded from third party interference.


