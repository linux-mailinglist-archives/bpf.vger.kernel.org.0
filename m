Return-Path: <bpf+bounces-60342-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EAB7AD5B86
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 18:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A15118830B1
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 16:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3A11DF73C;
	Wed, 11 Jun 2025 16:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+q718xY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA23185920;
	Wed, 11 Jun 2025 16:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749658318; cv=none; b=glvdJWRAUlhomtdZOUDXRrnrzrrR/2F+/+CZhE8WNRoj1Kd3lIsjAqsJXBnJ7LxErEQU2qL97NBS6m4r71dNgVODwh7dk+zzR7t0WPcgUWtd5zrMsbOqkUWntdbA+IMx5zD0KnBRfMcK/0qJF/0nJ6siKZobwYI6d8FEGfz0lm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749658318; c=relaxed/simple;
	bh=r9gVpsnHpGrtoJrWmUf0sGMNrOTRnLBmf2zx4bQB6zA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JcXPeZbw29Iobtw6Nalg34/li/Y443vdLZhW6VJBsxjTx0GDUoUd07kyDCMMhDS0Nv7O5ji/n80PIF5gogEwMDps1Qq2Csn42GZHHn6oAj18TnnGnfc7mLsXfdGhn3UgA0E6h8G5lUUVmibmdN3Lr74AZfKgjqQBkubqjT0XaEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J+q718xY; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a365a6804eso42188f8f.3;
        Wed, 11 Jun 2025 09:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749658314; x=1750263114; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jReI8KhNKfigh70b3JHArUDIBFvLt+THCjYcLez/QDE=;
        b=J+q718xYPAZi5osLMbVMeLE9oLnPlqXpbDrw8/ODrFa0XjvzlRkEs7sLiKxJp7nBPQ
         znTmrtUnwcEAdxDcFCUPX2Gox2bl8ood0eHBCAMhsDCGfX4un1/6zvUdj7ULUMN+mRLR
         /zygfWNBevgWtMEt4v+VIQdIdBvL4yzDtrTlrNvFC25ITNR2tDjuqBCSpGMlOgdg/2I7
         XQm0GvXIpEgeZCMZvUglQ9Mf5ujPbxHNnrBn4K3MtTRPFlDep+aBrid0RncbzbnSAr5/
         pK88SeiO4kKWXmRNA5naUIgCxD/JdeOPMHWxaBlkx2cG+1sTVEoYL1cyGIHmKd0M8gMP
         6DFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749658314; x=1750263114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jReI8KhNKfigh70b3JHArUDIBFvLt+THCjYcLez/QDE=;
        b=Zp8pJjISwDDKVpDyhiqwjB6ct6sxeZb/5u67Z8xfF6FPCrJkw4tsU0fXh2xjXOdFpt
         7/kWPQwWHzUR9LGyBgOiXTrS0nqRDPHR4TRJKYIGNz+OcRiLIqOB17f3M55ALhoSiM1c
         yO48VXbeHpNHVRVXQYFHvObh/6Uo6dhvKlzJsh6359GoBBzzrdJ6lg0QoZmhynlejphm
         EA5JMQXmGfy6YY8XJAtSvbgTNQA7/aI94Uak1CoZZiQII/TW3eZx5amhORD21snYafms
         FLEmRJam+XX1ID277LJZcNTEARlvUhrqlrr5lPoRunXrciZqiTIjPH9oViJ6V/78NvF7
         vSjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAXnrogi09B5R+tGKr5CdmSvNdQ92aLhR+OTqj6yLJYa+8ilYOwFY3h+UIxuOGcsb6ulQ=@vger.kernel.org, AJvYcCW+iJq7tK8chJwQHJagvIzWrgSpvo7MUh73OmX/eoTXqahNX2Hj/UTVuFJhnY2ZRLXgqFdXIUrKfSd+MA5Z@vger.kernel.org
X-Gm-Message-State: AOJu0YxGoL4f2D3LHePIXA2hn57D7sqzuPQN4EZgID0+xQYibHEA7g3p
	khbliohB2H0tIyWGPUKAYUMYLt7kWExW3J7pkXUoye99yO1yb3QDWdlA8GvJX96fdjpiP/HUPZ7
	cLdfVqn4KcUP/utKmFTrqirTh3w4W+oc=
X-Gm-Gg: ASbGnctRw/ijBoLRVeWxNvJa/lR/oIyx6+yRl7kjLHAuZgeWelsbpNI9H97AidOLOVV
	y1FctPTbZl7kltcElIraUsoBH2K33/cVXQVWWgyJdnfaBPIc4tpq/cj7DHCoImIrxmU14wXETkC
	7f5dBWGOZaywxH1HJUOQnMYACzxt//WCuxakZ8l6PWU8fF0psDppyi18eGzNmzKGnKyJeCkfky
X-Google-Smtp-Source: AGHT+IHbC4H+NNf3XUowh5H15YVnQIo+YOGW6Dam9XQa/7o5vMFzAsasiWLW7RxwHhsyc9iqAHGwwtbMufPIiBlK68I=
X-Received: by 2002:a5d:688c:0:b0:3a3:63d3:369a with SMTP id
 ffacd0b85a97d-3a55869cdf9mr2574215f8f.25.1749658313973; Wed, 11 Jun 2025
 09:11:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250528034712.138701-1-dongml2@chinatelecom.cn>
 <CAADnVQ+G+mQPJ+O1Oc9+UW=J17CGNC5B=usCmUDxBA-ze+gZGw@mail.gmail.com> <CADxym3YhE23r0p31xLE=UHay7mm3DJ8+n6GcaP7Va8BaKCxRfA@mail.gmail.com>
In-Reply-To: <CADxym3YhE23r0p31xLE=UHay7mm3DJ8+n6GcaP7Va8BaKCxRfA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 11 Jun 2025 09:11:41 -0700
X-Gm-Features: AX0GCFsMyM94LIHgtmrz8f8L9g5wVRcpXekQSU_dzyT0N5hOrlD2IaVAnlN0xBQ
Message-ID: <CAADnVQ+Qn5H7idVv-ae84NSMpPHKyKRYbrn30bVRoq=nnPq-pw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 00/25] bpf: tracing multi-link support
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Menglong Dong <dongml2@chinatelecom.cn>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 5:59=E2=80=AFAM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> On 6/11/25 11:32, Alexei Starovoitov wrote:
> > On Tue, May 27, 2025 at 8:49=E2=80=AFPM Menglong Dong <menglong8.dong@g=
mail.com> wrote:
> >>
> >> 1. Add per-function metadata storage support.
> >> 2. Add bpf global trampoline support for x86_64.
> >> 3. Add bpf global trampoline link support.
> >> 4. Add tracing multi-link support.
> >> 5. Compatibility between tracing and tracing_multi.
> >
> > ...
> >
> >> ... and I think it will be a
> >> liberation to split it out to another series :/
> >
> > There are lots of interesting ideas here and you know
> > already what the next step should be...
> > Split it into small chunks.
> > As presented it's hard to review and even if maintainers take on
> > that challenge the set is unlandable, since it spans various
> > subsystems.
> >
> > In a small reviewable patch set we can argue about
> > approach A vs B while the current set has too many angles
> > to argue about.
>
>
> Hi, Alexei.
>
>
> You are right. In the very beginning, I planned to make the kernel functi=
on
> metadata to be the first series. However, it's hard to judge if the funct=
ion
> metadata is useful without the usage of the BPF tracing multi-link. So I
> kneaded them together in this series.
>
>
> The features in this series can be split into 4 part:
> * kernel function metadata
> * BPF global trampoline
> * tracing multi-link support
> * gtramp work together with trampoline
>
>
> I was planning to split out the 4th part out of this series. And now, I'm
> not sure if we should split it in the following way:
>
> * series 1: kernel function metadata
> * series 2: BPF global trampoline + tracing multi-link support
> * series 3: gtramp work together with trampoline

Neither. First thing is to understand benchmark numbers.
We're not there yet.

> >
> > Like the new concept of global trampoline.
> > It's nice to write bpf_global_caller() in asm
> > compared to arch_prepare_bpf_trampoline() that emits asm
> > on the fly, but it seems the only thing where it truly
> > needs asm is register save/restore. The rest can be done in C.
>
>
> We also need to get the function ip from the stack and do the origin
> call with asm.
>
>
> >
> > I suspect the whole gtramp can be written in C.
> > There is an attribute(interrupt) that all compilers support...
> > or use no attributes and inline asm for regs save/restore ?
> > or attribute(naked) and more inline asm ?
>
>
> That's a nice shot, which will make the bpf_global_caller() much easier.
> I believe it worth a try.
>
>
> >
> >> no-mitigate + hash table mode
> >> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >> nop     | fentry    | fm_single | fm_all    | km_single | km_all
> >> 9.014ms | 162.378ms | 180.511ms | 446.286ms | 220.634ms | 1465.133ms
> >> 9.038ms | 161.600ms | 178.757ms | 445.807ms | 220.656ms | 1463.714ms
> >> 9.048ms | 161.435ms | 180.510ms | 452.530ms | 220.943ms | 1487.494ms
> >> 9.030ms | 161.585ms | 178.699ms | 448.167ms | 220.107ms | 1463.785ms
> >> 9.056ms | 161.530ms | 178.947ms | 445.609ms | 221.026ms | 1560.584ms
> >
> > ...
> >
> >> no-mitigate + function padding mode
> >> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >> nop     | fentry    | fm_single | fm_all    | km_single | km_all
> >> 9.320ms | 166.454ms | 184.094ms | 193.884ms | 227.320ms | 1441.462ms
> >> 9.326ms | 166.651ms | 183.954ms | 193.912ms | 227.503ms | 1544.634ms
> >> 9.313ms | 170.501ms | 183.985ms | 191.738ms | 227.801ms | 1441.284ms
> >> 9.311ms | 166.957ms | 182.086ms | 192.063ms | 410.411ms | 1489.665ms
> >> 9.329ms | 166.332ms | 182.196ms | 194.154ms | 227.443ms | 1511.272ms
> >>
> >> The overhead of fentry_multi_all is a little higher than the
> >> fentry_multi_single. Maybe it is because the function
> >> ktime_get_boottime_ns(), which is used in bpf_testmod_bench_run(), is =
also
> >> traced? I haven't figured it out yet, but it doesn't matter :/
> >
> > I think it matters a lot.
> > Looking at patch 25 the fm_all (in addition to fm_single) only
> > suppose to trigger from ktime_get_boottime,
> > but for hash table mode the difference is huge.
> > 10M bpf_fentry_test1() calls are supposed to dominate 2 calls
> > to ktime_get and whatever else is called there,
> > but this is not what numbers tell.
> >
> > Same discrepancy with kprobe_multi. 7x difference has to be understood,
> > since it's a sign that the benchmark is not really measuring
> > what it is supposed to measure. Which casts doubts on all numbers.
>
>
> I think there is some misunderstand here. In the hash table mode, we trac=
e
> all the kernel function for fm_all and km_all. Compared to fm_single and
> km_single, the overhead of fm_all and km_all suffer from the hash lookup,
> as we traced 40k+ functions in these case.
>
>
> The overhead of kprobe_multi has a linear relation with the total kernel
> function number in fprobe, so the 7x difference is reasonable. The same
> to fentry_multi in hash table mode.

No, it's not. More below...

> NOTE: The hash table lookup is not O(1) if the function number that we
> traced more than 1k. According to my research, the loop count that we use
> to find bpf_fentry_test1() with hlist_for_each_entry() is about 35 when
> the functions number in the hash table is 47k.
>
> BTW, the array length of the hash table that we use is 1024.

and that's the bug.
You added 47k functions to a htab with 1k bucket and
argue it's performance is slow?!
That's a pointless baseline.
Use rhashtable or size up buckets to match the number of functions
being traced, so that hash lookup is O(1).

>
> The CPU I used for the testing is:
> AMD Ryzen 9 7940HX with Radeon Graphics
>
>
> >
> > Another part is how come fentry is 20x slower than nop.
> > We don't see it in the existing bench-es. That's another red flag.
>
>
> I think this has a strong relation with the Kconfig I use. When I do the
> testing with "make tinyconfig" as the base, the fentry is ~9x slower than
> nop. I do this test with the Kconfig of debian12 (6.1 kernel), and I thin=
k
> there is more overhead to rcu_read_lock, migrate_disable, etc, in this
> Kconfig.

It shouldn't make any difference if hashtable is properly used.

>
>
> >
> > You need to rethink benchmarking strategy. The bench itself
> > should be spotless. Don't invent new stuff. Add to existing benchs.
> > They already measure nop, fentry, kprobe, kprobe-multi.
>
>
> Great! It seems that I did so many useless works on the bench testing :/
>
>
> >
> > Then only introduce a global trampoline with a simple hash tab.
> > Compare against current numbers for fentry.
> > fm_single has to be within couple percents of fentry.
> > Then make fm_all attach to everything except funcs that bench trigger c=
alls.
> > fm_all has to be exactly equal to fm_single.
> > If the difference is 2.5x like here (180 for fm_single vs 446 for fm_al=
l)
> > something is wrong. Investigate it and don't proceed without full
> > understanding.
>
>
> Emm......Like what I explain above, the 2.5X difference is reasonable, an=
d
> this is exact the reason why we need the function padding based metadata,
> which is able to make fentry_multi and kprobe_multi(in the feature) out o=
f
> overhead of the hash lookup.

Absolutely not. It only points into an implementation issue with hashtab.

>
> >
> > And only then introduce 5 byte special insn that indices into
> > an array for fast access to metadata.
> > Your numbers are a bit suspicious, but they show that fm_single
> > with hash tab is the same speed as the special kfunc_md_arch_support().
> > Which is expected.
> > With fm_all that triggers small set of kernel function
> > in a tight benchmark loop the performance of hashtab vs special
> > should _also_ be the same, because hashtab will perform O(1) lookup
> > that is hot in the cache (or hashtab has bad collisions and should be f=
ixed).
>
>
> I think this is the problem. The kernel function number is much more than
> the array length, which makes the hash lookup not O(1) anymore.
>
> Sorry that I wanted to show the performance of function padding based
> metadata, and made the kernel function number that we traced huge, which
> is ~47k.
>
>
> When the function number less than 2k, the performance of fm_single and
> fm_all don't have much difference, according to my previous testing :/

Sigh. You should have said that in the beginning that your hashtab
is fixed size. All the comparisons and reasons are bogus.

>
> >
> > fm_all should have the same speed as fm_single too,
> > because bench will only attach to things outside of the tight bench loo=
p.
> > So attaching to thousands of kernel functions that are not being
> > triggered by the benchmark should not affect results.
>
>
> This is 47k kernel functions in this testing :/
>
>
> > The performance advantage of special kfunc_md_arch_support()
> > can probably only be seen in production when fentry.multi attaches
> > to thousands of kernel functions and random functions are called.
> > Then hash tab cache misses will be noticeable vs direct access.
> > There will be cache misses in both cases, but significantly more misses
> > for hash tab. Only then we can decide where special stuff is truly nece=
ssary.
> > So patches 2 and 3 are really last. After everything had already landed=
.
>
>
> Emm......The cache miss is something I didn't expect. The only thing I
> concerned before is just the overhead of the hash lookup. To my utter
> astonishment, this actually helps with cache misses as well!
>
>
> BTW, should I still split out the function padding based metadata in
> the last series?

No. First make sure fm_single and fm_all has the same performance
with hashtable and demonstrate that with existing selftests/bpf/benchs/

