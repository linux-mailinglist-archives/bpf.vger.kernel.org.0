Return-Path: <bpf+bounces-45374-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34FF89D4ED7
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 15:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF4F91F21E1F
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 14:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5DD21DD88B;
	Thu, 21 Nov 2024 14:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IloqTSSz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F061D4144;
	Thu, 21 Nov 2024 14:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732200223; cv=none; b=JsmJW68ZyniDBjXb/FoqaqCYPwTjekNcBKnsGVw+aqBiuQn+XquiJQ9mDTtMeaEUjukpmCjJ8GyWP7BKddspsqpT1VKyWgVcWLHIo7rPyZQ81Q0SVnW8T2mRWKP2ctQMLvxOhr4yXlO6EdfoUmNN3BYgYdRRacR/07uwFpDX85M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732200223; c=relaxed/simple;
	bh=OMopyxZ8WApl9FNvWZD2Hy4emeof9zOeC4OOp8WlqqQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fLhrsNdtA5b/OqjqitSvzmibCJOnaSRbZLrvFtyRkfeV7yd9pxCWleeXG8lEMjY7ly36kgwMY2zIwuQ96eYzy8kY0JEg98Z7aIpLBW5Mzef+YBRFuz64+PNFdbd2AVUgoFghmovYWy2uryU32ZM3tt5vwADbqrRhylgZrZM+Zns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IloqTSSz; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2ea68cd5780so855368a91.3;
        Thu, 21 Nov 2024 06:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732200221; x=1732805021; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lKfc6WK70Ujcv4qyYOGzHtW3+I+/alF7xv4s8D+Od9A=;
        b=IloqTSSzvpqalKDWUPuOeiIdlvixyNDUGolryEulyNCMh1o82LjJfx3dhD46yZ1cyw
         3COWqfpdoXxPENYOhvGzeXlWmQGXSZvNywE8beHxu51f7FCzLrVxc8RRhvK74lQis3+z
         EL6ymI6V74fgd1JHde6VCAeUQIas1C5VHFOKSnu1zQHthbrnoagOJW6URTP3SZr+Q+Vj
         LrAkeWj2iRZ3YN/nUttukOf7I0kK7kpuRP2A1zu6s+gog5rU8DDHRKDtNlZTrj04nUf0
         ivmQO+4NJxvBBbxnmU8st4bcilFaGEJyTBF3GT3+25go7B871I8LQgTONP2y2cYxLTgL
         yoEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732200221; x=1732805021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lKfc6WK70Ujcv4qyYOGzHtW3+I+/alF7xv4s8D+Od9A=;
        b=RnEJ8T1MzliV8GfcGYFZWEPMeEke3t4tpp+1bm9OMyD0xlyZQvm4N7Zx6P7SMuWz01
         seBY6i0WAIQ+0e3Z2BoIlASVUVb4m6L9HpnTRJWEgg2o1wr5x98jqO9Y4Omn/UCpFOGd
         5oH9g+Itl5tK/TFNoirSf0q8pdMSfEmZzYXg2PKtw1IW66HgM7Ugt7YLEhr1KtHxVSGW
         +c7nrNaSkkDsMtjxmcSeiCnE61HR48M076Heg7NBNUFneNK/wzAOxV6bOcWXGNM41+VT
         vlyV9B2H7cZ/iuBvKmIxBq2I17ykhf3OKbAIDUAUKX4Y1PCiZ9/wAj6UL7gwncbDEN/I
         EQ0Q==
X-Forwarded-Encrypted: i=1; AJvYcCU9WvKgCngi/qCuy8knaJwI988jDjA9VxfGZ2Y3LH08+dCVNzC4GoPAOOAf6/kMdb6pECnMWZT3WDs7kYmNtNmJeZXk@vger.kernel.org, AJvYcCUWJwdhUqw1ocem0zpC4D0LTlEsuL0Z+SjS3aUrWpCRIg2Q3e/fdHyAhYAyCz6n6ZPGh0xWAMswyow0nDC7@vger.kernel.org, AJvYcCWZ05oSuorz9RZLgvOYOmW1W9nUaeLn0/cWpLgk6m10/Wto7Wvj6AY/6viBzdPWQUglm6U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm/KbK/9uxu5YB7YXQPl1Uva1iiWJoV8Edd6WQxDoP/PQzRKNQ
	01guJucQ8QKbPLkDHJTCzrIInZAArK7dI9ot3lvQxuRLOQHjV4cKi2gA6OhM9VFrUapk44yq/Lq
	HeB3g9y0acaJAk7v/fhVZX32BiNI=
X-Gm-Gg: ASbGncvthh/e6zzeVTJg9aKT3rRt4yJt0siAI+zlQQ/JkFAaOWNTi5Rmy8ZwBaWvAzk
	bpO4EP2UZinePAJtQuJ/dBqEndzsEugPfo90d/sPDFMHCrSc=
X-Google-Smtp-Source: AGHT+IHI1sNYh8TGwsXDad2aw7zBPtwV39Yiz8NDiu1l/E1ipvCw/26XGQRMk0sEM8UETmQ5TWxeG9UsU+oCg/GqQQg=
X-Received: by 2002:a17:90b:4a51:b0:2ea:525e:14a7 with SMTP id
 98e67ed59e1d1-2eaca7c675bmr8652406a91.29.1732200220751; Thu, 21 Nov 2024
 06:43:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028010818.2487581-1-andrii@kernel.org> <CAEf4BzYPajbgyvcvm7z1EiPgkee1D1r=a8gaqxzd7k13gh9Uzw@mail.gmail.com>
 <CAEf4Bza=pwrZvd+3dz-a7eiAQMk9rwBDO1Kk_iwXSCM70CAARw@mail.gmail.com>
 <CAEf4BzbiZT5mZrQp3EDY688PzAnLV5DrqGQdx6Pzo6oGZ2KCXQ@mail.gmail.com>
 <20241120154323.GA24774@noisy.programming.kicks-ass.net> <Zz4IQaF9CCfjS28S@gmail.com>
 <CAEf4BzYR44BgfAjKAvppmyG_hjojBL7XZe75C0qBTPoE7WXzHg@mail.gmail.com> <Zz7-bXrFsC8zJwu3@gmail.com>
In-Reply-To: <Zz7-bXrFsC8zJwu3@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 21 Nov 2024 06:43:28 -0800
Message-ID: <CAEf4BzYV109EfUupJ_DaUrLSkng=pevdd+67Y=ifw-ZjsG2nJg@mail.gmail.com>
Subject: Re: [PATCH v4 tip/perf/core 0/4] uprobes,mm: speculative lockless
 VMA-to-uprobe lookup
To: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org, 
	akpm@linux-foundation.org, oleg@redhat.com, rostedt@goodmis.org, 
	mhiramat@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jolsa@kernel.org, paulmck@kernel.org, willy@infradead.org, surenb@google.com, 
	mjguzik@gmail.com, brauner@kernel.org, jannh@google.com, mhocko@kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>, vbabka@suse.cz, shakeel.butt@linux.dev, 
	hannes@cmpxchg.org, Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, 
	david@redhat.com, arnd@arndb.de, richard.weiyang@gmail.com, 
	zhangpeng.00@bytedance.com, linmiaohe@huawei.com, viro@zeniv.linux.org.uk, 
	hca@linux.ibm.com, Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Kernel Team <kernel-team@meta.com>, 
	Liao Chang <liaochang1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cc'ing Liao for awareness (should have done it earlier, sorry)

On Thu, Nov 21, 2024 at 1:33=E2=80=AFAM Ingo Molnar <mingo@kernel.org> wrot=
e:
>
>
> * Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> > Is this about Liao's siglock patch set? We are at v4 (!) already (see
> > [0]) with Oleg's Acked-by added.
>
> AFAICS you didn't Cc: me to -v3 and -v4 - and while I'll generally see
> those patches too, eventually, there's a delay.

Ok, I think we are now switching to my patch set here ([0]), because
Liao's v4 ([1]) does have mingo@redhat.com in CC. So, on Liao's
behalf, there wasn't really anything specific pointed out that would
explain a month's delay.

But let's switch to my patch set. Yes, my bad, I didn't CC you
directly, that wasn't in any way intentional, and that's my bad and I
will make sure to CC you on every patch for uprobes subsystem, even
though you are not explicitly listed in UPROBES section of MAINTAINERS
([2]), and Peter was the one who was handling all the uprobe-related
stuff since before this summer.

But let's please not randomly jump between discussing two separate
patch sets here, it's confusing.

>
> > > Andrii did get some other uprobes scalability work merged in v6.13:
> > >
> > >     - Switch to RCU Tasks Trace flavor for better performance
> > >     (Andrii Nakryiko)
> > >
> > >     - Massively increase uretprobe SMP scalability by
> > >       SRCU-protecting the uretprobe lifetime (Andrii Nakryiko)
> > >
> > > So we've certainly not been ignoring his patches, to the contrary
> > > ...
> >
> > Yes, and as I mentioned, this one is a) ready, reviewed, tested and
> > b) complements the other work you mention.
>
> Sorry, but patchsets that didn't even build a few weeks before the
> development window closed are generally pushed further down the
> backlog. Think of this as rate-limiting the risk of potentially broken
> code entering the kernel. You can avoid this problem by doing more
> testing, or by accepting that sometimes one more cycle is needed to get
> your patchsets merged.

Those build failures were happening in stub implementations, which
were used only on !CONFIG_PER_VMA_LOCK configuration, which I'm not
even sure if possible to get on x86-64. When I tried to reproduce this
locally I couldn't even get such configuration. Thankfully we have a
kernel test robot that would test multiple architectures and
configurations and it did catch it on i386 and loongarch64. And was
fixed quickly.

It doesn't seem fair or reasonable to penalize patch sets for *weeks*,
silently and without any notice just for this, IMO.

The patch set was very thoroughly tested, actually. Not just building,
but also running various unit tests (BPF selftests in particular). But
even more so, I built an entire uprobe stress-testing tool just to
test all my uprobe-related. I deployed custom kernels and ran these
stress tests on all uprobe patch sets and their revisions, over many
hours.

Sure, my main platform is x86-64, so that's where all the testing was
done. But you can't accuse me of negligence.

>
> > [...] It removes mmap_lock which limits scalability of the rest of
> > the work. Is there some rule that I get to land only two patch sets
> > in a single release?
>
> Your facetous question and the hostile tone of your emails is not
> appreciated.

I'm sticking to the facts in these emails. And when I get a response
in the style of "you got two patch sets in, why are you complaining",
that's not exactly friendly and fair. I put a lot of effort and time
not just into producing and testing all those patches, but also into
the logistics of it, coordinating with other people working within
uprobes subsystem.

And instead of accusations, I'd like to get an understanding of
expectations I can have in terms of handling patches. Being ignored
for many weeks is not OK. If you don't like something about what I do
or how, procedurally or technically, please call it out and I'll try
to fix whatever the problem might be. Silent treatment is not
productive.

But while on the topic. Those two patch sets you mentioned didn't go
in smoothly and quickly either. "Switch to RCU Tasks Trace flavor for
better performance" in particular should have gone in with the
original patch set one release earlier. But instead that patch was
dropped from the tree after applying it. Silently. I was not notified
at all (5 days that passed before I asked would be plenty of time to
mention this, IMO). It's good I noticed this, inquired with an email
reply (after making sure it's not some transient patch handling
issue), and only after that I got a reply that there was a build
failure I had to fix. You can see the thread at [4].

>
> Me pointing out that two other patchsets of yours got integrated simply
> demonstrates how your original complaint of an 'ignore list' is not
> just unprofessional on its face, but also demonstrably unfair:
>
> > > > > I'm not sure what's going on here, this patch set seems to be
> > > > > in some sort of "ignore list" on Peter's side with no
> > > > > indication on its destiny.

My "ignore list" complaint is specifically about this patch set, which
I explicitly stated above in the quote you provided. So yes, it's a
professional, and demonstrably fair statement, and I provided the
timeline and supporting links.

>
> Trying to pressure maintainers over a patchset that recently had build
> failures isn't going to get your patches applied faster.
>

I'm not asking to apply my patches blindly without critical review or
anything like that. I'm not expecting reviews or even just email
replies within a few days of posting. I *do* expect some sort of
reaction, though, and not after many weeks of inactivity and pinging
from my side, yes. And note, I got replies only after sending an email
straight to Linus.

I'm not pressuring anyone into anything. But as a maintainer myself, I
do think that being a maintainer is not just about having rights, it's
also about responsibilities.

Let's please stop with the excuses and instead discuss constructive solutio=
ns.

> Thanks,
>
>         Ingo

[0] https://lore.kernel.org/linux-trace-kernel/20241028010818.2487581-1-and=
rii@kernel.org/
[1] https://lore.kernel.org/linux-trace-kernel/20241022073141.3291245-1-lia=
ochang1@huawei.com/
[2] https://lore.kernel.org/all/172074397710.247544.17045299807723238107.st=
git@devnote2/
[3] https://github.com/libbpf/libbpf-bootstrap/commit/2f88cef90f9728ec8c7be=
e7bd48fdbcf197806c3
[4] https://lore.kernel.org/all/CAEf4BzZihPPiReE3anhrVOzjoZW5v4vFVouK_Arm8v=
JexCTT4g@mail.gmail.com/

