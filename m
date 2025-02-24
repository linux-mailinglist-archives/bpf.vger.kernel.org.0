Return-Path: <bpf+bounces-52450-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C2ECA42FF4
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 23:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ECF717B14D
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 22:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6CF22045B5;
	Mon, 24 Feb 2025 22:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lcCCmS7H"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37811DF242
	for <bpf@vger.kernel.org>; Mon, 24 Feb 2025 22:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740435688; cv=none; b=Micv9Td6c+fCiuOOnvXaCPna1e8S2/mizEbqkR0P4qe5zaSSZVD/E7Ex5E7MFMU03Uozylz2DUvPVLriUwZa2CUk4+/WOcyy+5j+xSNynfPwrPz4gO6vQ0yDrrFDhxRPV55GxLfQD8FWbjCsMuCOI82F8DiA1xiiLbE4cJP5e4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740435688; c=relaxed/simple;
	bh=vI39FAD0dL70SFwKILeTdhflWqEiFGZhyC8arPTEZok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HQGf80QqYm3MYSXjClsGQlpyp7UPpIjZZeK6FuVz7p4TzCVpC/cWB7/yWdXEqCXwW733wg1Wb2whOE2KR2lO5DGIxAyGavuXrSfE9Z5NYzVfvZdvUX2lvq9qRbj6VC6Te7P337TtjfqcJVHvAgLyE63C5DdJFPDfyGfQhBjFUdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lcCCmS7H; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-abb892fe379so765445366b.0
        for <bpf@vger.kernel.org>; Mon, 24 Feb 2025 14:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740435685; x=1741040485; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vI39FAD0dL70SFwKILeTdhflWqEiFGZhyC8arPTEZok=;
        b=lcCCmS7HSy0Zx6OWu1ZFFstNCF95yuhOP2uJKfioDgNG3RIPATMegQb9xMUb39a4Mz
         uDQBem1Ai8+o/QtV4Vl6wi4i2EaminBDcSrPJbJnKiZokwRXmKcca4za803dJu1bwCFS
         kopjnYlxMYX3QZaKL/wFtWVYSxmxzNtGy2bTgXHRJOdPhtRdLptO4gun3HktnHPbdPY0
         r1xk4dMvcRHXrm5qS4qyS83R1vIqmYkC1ujSYvchz3JHG8GqFNNaxw9SE/x2oWdZrF+N
         hkjU6UZee+MBWAOUucou8N9ae7mIH4tCY1INfu0yS7M5xw44RBL4ZIPkcmlD85+17OT2
         ZogQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740435685; x=1741040485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vI39FAD0dL70SFwKILeTdhflWqEiFGZhyC8arPTEZok=;
        b=hNR0AaAGB8Y67Le7mWVTUIm5IXn6us4ADUgbtJ8NBMiRRGA41LmS2bnm5PsvPQJti9
         YybDwSOBQ7KUl85d/EsypXdF1F1oK9QmaPaDgSOGHYiJNQakx/9po4mij8zp/fwvZ6Qd
         +GkPKYUo+4MYim9lfZyOraXKIbu657PH+uwdSIaUE3x7sWLB4drLfhXOolK1P8ZwGCky
         G72ZN9+KXQcIZBTvNsFIvBGUlC4X2huKoXeHDMbUAvo39ER2BmRMcQ6kVQ4cgisaXPiM
         pNfrUT3XM0OAuxh7EXEtlp4qTCXzl3AmLfzzoH19oZ06gcS8Z5h0+qt+kD6JD3qS7QOq
         cMbA==
X-Forwarded-Encrypted: i=1; AJvYcCXfTYZTYSUcshxt9bUQ3vwzedQTSqt+Iax2gzfNUQYd3fLs7dVDzA3DKsEgVazgOpDT9zo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRMfrHPGUkyIJkowlJXC2uwpTqdc/iPiWS4Na3jLpywb2JcBTL
	Z7YBcE4ybPJm1F5gDhw/aoPLeb1ZcBSw5Yn5eaNDVCOAgN7rBuQqXkiUDXsG3xs9ftfPdXDDfRj
	00rNZpv4waT2VuQ/JnmpR2muYbG8=
X-Gm-Gg: ASbGncubd0NYja/WiqsMGJP/A4LjMF9QQxOtBOZRkaB+KD1gpF1HIkxU4ZVHjBrnfHI
	PpcxyZOrbGe/R2LIZPfihUS6fzxljv54i4FRnvA8uqQ1VWTnGl+dtjWOImU1O1k3KWs7CALhtlB
	PdV21eUUQ=
X-Google-Smtp-Source: AGHT+IGE2HSWpwEBMdMWHwI6dgsE6ZM+mTH9zsdMwe83I0Py45r5K/RkkONeNDs0ldrG/XU+WPiYONmB1eVThqZr26A=
X-Received: by 2002:a05:6402:13d1:b0:5d0:c697:1f02 with SMTP id
 4fb4d7f45d1cf-5e4469dad6amr1721474a12.17.1740435684655; Mon, 24 Feb 2025
 14:21:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <14422cf1-4a63-4115-87cb-92685e7dd91b@suse.cz> <e2fz26kcbni37rp2rdqvac7mljvrglvtzmkivfpsnibubu3g3t@blz27xo4honn>
 <svy4dxxdgbt4mnapfrqod7c2imufgb4daao7id3j5p7tgeok4j@jtknbmybpqsg> <7wjnfy7cvmxzcmh4rs5xqi7qmurj365wa4kf252u7bnjgo4bqb@x42ceby4d27p>
In-Reply-To: <7wjnfy7cvmxzcmh4rs5xqi7qmurj365wa4kf252u7bnjgo4bqb@x42ceby4d27p>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Mon, 24 Feb 2025 23:21:12 +0100
X-Gm-Features: AWEUYZmbh11x690V0KlZ7fKf6xOPxcgyOdfvzCEoQWbzL_BI-f-3M3ENvBfElzo
Message-ID: <CAGudoHHoBf7K3bBMnTs1+BPLmcW+=SXLLNnf-tvhTLjnBsooTw@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] SLUB allocator, mainly the sheaves caching layer
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Vlastimil Babka <vbabka@suse.cz>, lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org, 
	bpf <bpf@vger.kernel.org>, Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>, 
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, "Uladzislau Rezki (Sony)" <urezki@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 10:12=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.d=
ev> wrote:
>
> On Mon, Feb 24, 2025 at 07:46:52PM +0100, Mateusz Guzik wrote:
> > On Mon, Feb 24, 2025 at 10:02:09AM -0800, Shakeel Butt wrote:
> > > What about pre-memcg-charged sheaves? We had to disable memcg chargin=
g
> > > of some kernel allocations and I think sheaves can help in reenabling
> > > it.
> >
> > It has been several months since last I looked at memcg, so details are
> > fuzzy and I don't have time to refresh everything.
> >
> > However, if memory serves right the primary problem was the irq on/off
> > trip associated with them (sometimes happening twice, second time with
> > refill_obj_stock()).
> >
> > I think the real fix(tm) would recognize only some allocations need
> > interrupt safety -- as in some slabs should not be allowed to be used
> > outside of the process context. This is somewhat what sheaves is doing,
> > but can be applied without fronting the current kmem caching mechanism.
> > This may be a tough sell and even then it plays whackamole with patchin=
g
> > up all consumers.
> >
> > Suppose it is not an option.
> >
> > Then there are 2 ways that I considered.
> >
> > The easiest splits memcg accounting for irq and process level -- simila=
r
> > to what localtry thing is doing. this would only cost preemption off/on
> > trip in the common case and a branch on the current state. But suppose
> > this is a no-go as well.
>
> Have you seen 559271146efc ("mm/memcg: optimize user context object
> stock access"). It got reverted for RT (or something). Maybe we can look
> at it again.
>

Huh. I have not it, it does look like the same core idea.

Even if RT itself is the problem, perhaps this could be made build
time conditional on it?

> >
> > My primary idea was using hand-rolled sequence counters and local 8-byt=
e
> > cmpxchg (*without* the lock prefix, also not to be confused with 16-byt=
e
> > used by the current slub fast path). Should this work, it would be
> > significantly faster than irq trips.
> >
> > The irq thing is there only to facilitate several fields being updated
> > or memcg itself getting replaced in an atomic manner for process vs
> > interrupt context.
> >
> > The observation is that all values which are getting updated are 4
> > bytes. Then perhaps an additional counter can be added next to each one
> > so that an 8-byte cmpxchg is going to fail should an irq swoop in and
> > change stuff from under us.
> >
> > The percpu state would have a sequence counter associated with the
> > assigned memcg_stock_pcp. The memcg_stock_pcp object would have the sam=
e
> > value replicated inside for every var which can be updated in the fast
> > path.
> >
> > Then the fast path would only succeed if the value read off from per-cp=
u
> > did not change vs what's in the stock thing.
> >
> > Any change to memcg_stock_pcp (e.g., rolling up bytes after passing the
> > page size threshold) would disable interrupts and modify all these
> > counters.
> >
> > There is some more work needed to make sure the stock obj can be safely
> > swapped out for a new one and not accidentally have a value which lines
> > up with the prevoius one, I don't remember what I had for that (and yes=
,
> > I recognize a 4 byte value will invariably roll over and *in principle*
> > a conflict will be possible).
> >
> > This is a rough outline since Vlasta keeps prodding me about it.
>
> By chance do you have this code lying around somewhere? Not saying this
> is the way to go but wanted to take a look.

Sorry mate, there was a lot of handwaving produced around this and
kmem fast paths, but no code. :)

Conceptually though I think this is pretty straightforward.

Anyhow, I forgot to mention another angle: perhaps a kernel-equivalent
of rseq could be somehow employed here?

As in you prep the op. Should an interrupt come in, it can detect you
were going to execute it and redirect your IP to a fallback or just
restart. I have no idea how feasible this is here, food for thought.
--=20
Mateusz Guzik <mjguzik gmail.com>

