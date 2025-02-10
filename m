Return-Path: <bpf+bounces-51053-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 609F2A2FCA2
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 23:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 265423A36C1
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 22:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A43724FBF8;
	Mon, 10 Feb 2025 22:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Er4k8Jgg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B9824E4AD
	for <bpf@vger.kernel.org>; Mon, 10 Feb 2025 22:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739225377; cv=none; b=G7+fUggHs9b3n6uDyN1pjab3otn9nGW+gqogmn6vtS94nIA+rM4ozOEkoC+tHFUj8UCvsDPsPOgCEabGHTlB0XVotrmInqoLzg+elWKJgbtGkLU1EFO3R7d7/xFSTRG9n5bwJdNEp+yem44HPPuQnkRtCiwuBO3sqvikWh/LzuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739225377; c=relaxed/simple;
	bh=44AOn8KPG/5b/gwXWVMZM4o0cSu0C5gCOO/mytEsVzc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L6Nfu8VSCAlVE4W7gyi2cIVys0tfzsAr9MsL9DQgIF4J6EbULm12F9oZYXJQTqqi/2VZis6AFUXEhbPfZPV0z8C/8x54UV2TBG2vIaA1rNka2xYajvW1synGqxiY9NdUJPUAC/vuQlGsfik/p7dFM4VHDizLxG4HemJz1QfRsDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Er4k8Jgg; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5de6d412ee9so943a12.1
        for <bpf@vger.kernel.org>; Mon, 10 Feb 2025 14:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739225374; x=1739830174; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=44AOn8KPG/5b/gwXWVMZM4o0cSu0C5gCOO/mytEsVzc=;
        b=Er4k8Jggi+SM4CnJwm27bFFKeQkowgsaqOyOh89teRf+uRTV8W9l50Gr/9vDaBFO2l
         DdtALmmisHwzd0PONwPMwil4vpdlJoTeTDFTI3ixQL7x7X8vLAV4839xH0GVspld/V+6
         96JBHWoYyIJDLDlzGZC/6SyFOwuKXU6qjZY/YzEQ8WeXnGJ1AsmfW2qXHUaA2we5g0v/
         ArIgVC/8Sq4RykAHj7LkOYAzsNPoLcj/bsq01O5TmO1a6pxI+7SI8q9/zDIrXXSR8D6Y
         AZAXikH7tZA/LJrwUl9A5DHiVLl+THQrcU87unLFsk16627Gmr4dY3LrCGoj8FQzh2mc
         KLnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739225374; x=1739830174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=44AOn8KPG/5b/gwXWVMZM4o0cSu0C5gCOO/mytEsVzc=;
        b=ZjG+Ub3GBuBz3F8OzXsEs5rkfcMXJ3wpjUJJ+igPmWLeoAFDmntn7f1K3DpY2uio7T
         rsoANKIPpAucqO3ZZpSz78fkbCjQ0RG921OQXOoSfkVZTiBkt1w7cIuv5fDxlId7BvDy
         59+1A2OPUO/SZud2ZaSKFeuuOgbm29zwCIjXBEHr4yiTRSbAG4Yft5o2C+kvA9RzMfhU
         uTS3mFTR+osluSvpo5RMiUGNdRyWct6KQKaVSFlCMI2K0RLvYpHqL7VJ0/ur2/9JmkSn
         vZcHoWFDylD80EB1P2TE7Y/SVxsuUFinaF2zjXXTV9ccvr89Dw6UdyGp8c81E/wQeYW7
         Xgkw==
X-Forwarded-Encrypted: i=1; AJvYcCUBWXrh07K9PJXSZNxCw0/wKu0HAWw+r7GWAXeN659rwHhESCLPlGWsf5IDGXzcIniOSIY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaNYJRx5kuApjMCXWRrWHfsbje8LR4p06ajNxWZX14aEubFWgk
	NIRa7J7QhhnQumViYy7de0QWBdbzKqGfyq+lCA5/JvaIJmBlDe0E2UGWyzXJoBLsCAhdSiI/Agm
	QAArRtJmApMBQps2uLsUikAJZwy5GDZBp1FJB
X-Gm-Gg: ASbGncu1m9YY3SVUdGfBPga6Qq5wJLT5rLpDS+D5cAyPQxnrXiUekNq20oIKqTVJzqg
	ljfMtjAUpc9PNHb2B9WK+MOn9BdOrIeN/i+4Dn/Oz8q1AUPxqAL4LSDqpAIcQXmnOM4JZViOMJu
	b+gZA4tKbjP9An1kBE4XRMVNE=
X-Google-Smtp-Source: AGHT+IG6JmQxBrqAHiHQy9r7fd0aAn9Heiw/iaJpJbhcsh707Pq8kG+sl2h6STthD8Ujnt3Wdn5OEmJdDMQ5PMlBL9s=
X-Received: by 2002:a50:aa93:0:b0:5dc:d08e:e128 with SMTP id
 4fb4d7f45d1cf-5dea05e7838mr1520a12.5.1739225373121; Mon, 10 Feb 2025 14:09:33
 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250114175143.81438-1-vschneid@redhat.com> <20250114175143.81438-30-vschneid@redhat.com>
 <CAG48ez1Mh+DOy0ysOo7Qioxh1W7xWQyK9CLGNU9TGOsLXbg=gQ@mail.gmail.com>
 <xhsmh34hhh37q.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <CAG48ez3H8OVP1GxBLdmFgusvT1gQhwu2SiXbgi8T9uuCYVK52w@mail.gmail.com> <xhsmh5xlhk5p2.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
In-Reply-To: <xhsmh5xlhk5p2.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
From: Jann Horn <jannh@google.com>
Date: Mon, 10 Feb 2025 23:08:55 +0100
X-Gm-Features: AWEUYZmtdNVDV_xq3vvo5TVQ7aaS79EFzdycTCfl72XGpztchND9QHjN9zcxWNo
Message-ID: <CAG48ez1EAATYcX520Nnw=P8XtUDSr5pe+qGH1YVNk3xN2LE05g@mail.gmail.com>
Subject: Re: [PATCH v4 29/30] x86/mm, mm/vmalloc: Defer flush_tlb_kernel_range()
 targeting NOHZ_FULL CPUs
To: Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	virtualization@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	loongarch@lists.linux.dev, linux-riscv@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, xen-devel@lists.xenproject.org, 
	kvm@vger.kernel.org, linux-arch@vger.kernel.org, rcu@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, bpf@vger.kernel.org, 
	bcm-kernel-feedback-list@broadcom.com, Juergen Gross <jgross@suse.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.amakhalov@broadcom.com>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Liang, Kan" <kan.liang@linux.intel.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Frederic Weisbecker <frederic@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Jason Baron <jbaron@akamai.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Joel Fernandes <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Zqiang <qiang.zhang1211@gmail.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Clark Williams <williams@redhat.com>, Yair Podemsky <ypodemsk@redhat.com>, 
	Tomas Glozar <tglozar@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, 
	Mel Gorman <mgorman@suse.de>, Kees Cook <kees@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@infradead.org>, 
	Shuah Khan <shuah@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>, Samuel Holland <samuel.holland@sifive.com>, Rong Xu <xur@google.com>, 
	Nicolas Saenz Julienne <nsaenzju@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Yosry Ahmed <yosryahmed@google.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Jinghao Jia <jinghao7@illinois.edu>, 
	Luis Chamberlain <mcgrof@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 7:36=E2=80=AFPM Valentin Schneider <vschneid@redhat=
.com> wrote:
> What if isolated CPUs unconditionally did a TLBi as late as possible in
> the stack right before returning to userspace? This would mean that upon
> re-entering the kernel, an isolated CPU's TLB wouldn't contain any kernel
> range translation - with the exception of whatever lies between the
> last-minute flush and the actual userspace entry, which should be feasibl=
e
> to vet? Then AFAICT there wouldn't be any work/flush to defer, the IPI
> could be entirely silenced if it targets an isolated CPU.

Two issues with that:

1. I think the "Common not Private" feature Will Deacon referred to is
incompatible with this idea:
<https://developer.arm.com/documentation/101811/0104/Address-spaces/Common-=
not-Private>
says "When the CnP bit is set, the software promises to use the ASIDs
and VMIDs in the same way on all processors, which allows the TLB
entries that are created by one processor to be used by another"

2. It's wrong to assume that TLB entries are only populated for
addresses you access - thanks to speculative execution, you have to
assume that the CPU might be populating random TLB entries all over
the place.

