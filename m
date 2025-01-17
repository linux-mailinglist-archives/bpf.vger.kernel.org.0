Return-Path: <bpf+bounces-49209-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DC9A154FE
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 17:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C43A188D03B
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 16:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B321A23AA;
	Fri, 17 Jan 2025 16:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V237xBVY"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FF01A0BC9
	for <bpf@vger.kernel.org>; Fri, 17 Jan 2025 16:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737132824; cv=none; b=ATfqa3AlS++dcJBcTk0s4RdKKLZOYgNs2zoNKcZ3Zlyx/+KE6+PJoirbYzy6SFY8l+HERG7bPVJVhVLx4BiGtc6e3vcSRcUUtA+XeBIVrbXFK+QJzD76vpED4Dmk+ARSW/lo4IDZjZS6ehDml3IApgdsGvthkgEO80i7WJobIcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737132824; c=relaxed/simple;
	bh=zS2KlTiZnGu6aQKTYj9yMifWHTI073WZ1gonGb0ZMuU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fFiIbodDF7ub0pOhCDUTotlBviAopz1bVbPJvt5DC46Sq1UyEv31mDHBQBXfEqjC7BsmDATCtjF0jcil31SDOmQbYlLc/ISgkaA3fTX4dgSYpot2RsAIA0+Rt1Y+N/H0/2A6yE60u4pTdQSvbjnoTdxtLWz8MXNAe3ZMZ2+BYN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V237xBVY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737132820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zS2KlTiZnGu6aQKTYj9yMifWHTI073WZ1gonGb0ZMuU=;
	b=V237xBVYp/iezqcJMg5bYiU99uM6UvmbG1qJ5cgUSDQqCUoMkeIqKu5e0vIna298lx+zVg
	xa1d6DsT3MwU5kyKecGw/t6W8t6Hu3d0YArKCNsjw+y/eo4Uva4I5j9k+mgqkFeYsd76/Y
	0DxNFiaEiJWwwiMX1oLhgsefGZZUtjU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-zSKia50gPgip8gn1ODy9Mw-1; Fri, 17 Jan 2025 11:53:38 -0500
X-MC-Unique: zSKia50gPgip8gn1ODy9Mw-1
X-Mimecast-MFC-AGG-ID: zSKia50gPgip8gn1ODy9Mw
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-38634103b0dso1466752f8f.2
        for <bpf@vger.kernel.org>; Fri, 17 Jan 2025 08:53:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737132817; x=1737737617;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zS2KlTiZnGu6aQKTYj9yMifWHTI073WZ1gonGb0ZMuU=;
        b=RWTu0V0SmsWPTszi5FZgWYZM9/2rxbaczhywn/nZd11AjfFVBSKqM9YmPSAhd/Ld55
         C+eLIgwl3nDe13LkM9Qi3VWQFkutdoRYudBl4IXInmS2256LqHVb7fw8ppWm0ZPiYVOo
         oTr7gCMhfUlwA+96bLi1W46m3Gpd9PtHKGi8rdyQpBod0XaFpn17MD+jm7rsp+W0Rvjt
         iMUxXlliSg2o2ZVIHdXkHrM9W+oKrOIL9+53lO7RnjMRasRJKGUAr8L9b6cmOJ0DLz0O
         Rk3t6agOhtfIvZh5Esz4cLf+kDGY7vc7Vh1q+Es5ZppHoI5a3V0uv7Ly2aDrUYGot1Ln
         SQJg==
X-Forwarded-Encrypted: i=1; AJvYcCURkIAb+6GqLEXbqFUC59ExpOoCtY82v0D2/WmHFdvq8sHarRFcmxuzWCKVDtqFAiurm70=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAd+qLDq3t85gXbOWxJCnT9qAES5rlZ1o4mxXoOSp94h2UoYHd
	L8G1U9urhxEPTulavs3K6Ex5HB8g36wqfghDzmD/dcifEBv19w+NVurD/kof9cc3nGCFBWecZOB
	+mPhITzzTZKtIhGMrBv8ukGmR/llI1X6uNhhCiuEyGiKvG8hG2Q==
X-Gm-Gg: ASbGnctJou3V09wyytG9F+ry0C5p5E0/r/ea6GpkbvbdgasbZRTOdYyNn5q2X+75YhE
	f1jfSyD1wNhYxKM/G3jctGSviN36uEI/qTujYEWcd0kJt1RHd1RSoQ/1ppp/w8V/12vJxlOXw2q
	4eX3MuT0RoTsd8RCW+pYTdu3syBIWyGHAioGKQq7huA+dcJWfqnQguIVEBotFb8gPbz1peRhKvl
	ReEHAhoDbxtshjmEo3wUdoGU/OvoWvOdBHEZnLiiJ2zK/ciIAEs51GuVSHM1269Cb5oFNRCNugb
	yaPTo/hMyDPTucmOjB+9Ibh1jwNYZidNxTv6T3Hmxw==
X-Received: by 2002:a5d:6da4:0:b0:38b:e32a:10a6 with SMTP id ffacd0b85a97d-38bf57a9932mr3394933f8f.41.1737132817362;
        Fri, 17 Jan 2025 08:53:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGgg/tn25OOVaMMDMlg+FUQ1oxKEYFZYFbhCFaXXhI5w4vXLbPHJsNwkMnyD4aTZ+GRHXAAGg==
X-Received: by 2002:a5d:6da4:0:b0:38b:e32a:10a6 with SMTP id ffacd0b85a97d-38bf57a9932mr3394815f8f.41.1737132816637;
        Fri, 17 Jan 2025 08:53:36 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf3221db2sm2893201f8f.29.2025.01.17.08.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 08:53:36 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Jann Horn <jannh@google.com>
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
In-Reply-To: <CAG48ez3H8OVP1GxBLdmFgusvT1gQhwu2SiXbgi8T9uuCYVK52w@mail.gmail.com>
References: <20250114175143.81438-1-vschneid@redhat.com>
 <20250114175143.81438-30-vschneid@redhat.com>
 <CAG48ez1Mh+DOy0ysOo7Qioxh1W7xWQyK9CLGNU9TGOsLXbg=gQ@mail.gmail.com>
 <xhsmh34hhh37q.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <CAG48ez3H8OVP1GxBLdmFgusvT1gQhwu2SiXbgi8T9uuCYVK52w@mail.gmail.com>
Date: Fri, 17 Jan 2025 17:53:33 +0100
Message-ID: <xhsmhzfjpfkky.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 17/01/25 16:52, Jann Horn wrote:
> On Fri, Jan 17, 2025 at 4:25=E2=80=AFPM Valentin Schneider <vschneid@redh=
at.com> wrote:
>> On 14/01/25 19:16, Jann Horn wrote:
>> > On Tue, Jan 14, 2025 at 6:51=E2=80=AFPM Valentin Schneider <vschneid@r=
edhat.com> wrote:
>> >> vunmap()'s issued from housekeeping CPUs are a relatively common sour=
ce of
>> >> interference for isolated NOHZ_FULL CPUs, as they are hit by the
>> >> flush_tlb_kernel_range() IPIs.
>> >>
>> >> Given that CPUs executing in userspace do not access data in the vmal=
loc
>> >> range, these IPIs could be deferred until their next kernel entry.
>> >>
>> >> Deferral vs early entry danger zone
>> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >>
>> >> This requires a guarantee that nothing in the vmalloc range can be vu=
nmap'd
>> >> and then accessed in early entry code.
>> >
>> > In other words, it needs a guarantee that no vmalloc allocations that
>> > have been created in the vmalloc region while the CPU was idle can
>> > then be accessed during early entry, right?
>>
>> I'm not sure if that would be a problem (not an mm expert, please do
>> correct me) - looking at vmap_pages_range(), flush_cache_vmap() isn't
>> deferred anyway.
>
> flush_cache_vmap() is about stuff like flushing data caches on
> architectures with virtually indexed caches; that doesn't do TLB
> maintenance. When you look for its definition on x86 or arm64, you'll
> see that they use the generic implementation which is simply an empty
> inline function.
>
>> So after vmapping something, I wouldn't expect isolated CPUs to have
>> invalid TLB entries for the newly vmapped page.
>>
>> However, upon vunmap'ing something, the TLB flush is deferred, and thus
>> stale TLB entries can and will remain on isolated CPUs, up until they
>> execute the deferred flush themselves (IOW for the entire duration of the
>> "danger zone").
>>
>> Does that make sense?
>
> The design idea wrt TLB flushes in the vmap code is that you don't do
> TLB flushes when you unmap stuff or when you map stuff, because doing
> TLB flushes across the entire system on every vmap/vunmap would be a
> bit costly; instead you just do batched TLB flushes in between, in
> __purge_vmap_area_lazy().
>
> In other words, the basic idea is that you can keep calling vmap() and
> vunmap() a bunch of times without ever doing TLB flushes until you run
> out of virtual memory in the vmap region; then you do one big TLB
> flush, and afterwards you can reuse the free virtual address space for
> new allocations again.
>
> So if you "defer" that batched TLB flush for CPUs that are not
> currently running in the kernel, I think the consequence is that those
> CPUs may end up with incoherent TLB state after a reallocation of the
> virtual address space.
>

Ah, gotcha, thank you for laying this out! In which case yes, any vmalloc
that occurred while an isolated CPU was NOHZ-FULL can be an issue if said
CPU accesses it during early entry;

> Actually, I think this would mean that your optimization is disallowed
> at least on arm64 - I'm not sure about the exact wording, but arm64
> has a "break before make" rule that forbids conflicting writable
> address translations or something like that.
>

On the bright side of things, arm64 is not as bad as x86 when it comes to
IPI'ing isolated CPUs :-) I'll add that to my notes, thanks!

> (I said "until you run out of virtual memory in the vmap region", but
> that's not actually true - see the comment above lazy_max_pages() for
> an explanation of the actual heuristic. You might be able to tune that
> a bit if you'd be significantly happier with less frequent
> interruptions, or something along those lines.)


