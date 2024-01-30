Return-Path: <bpf+bounces-20644-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA9E841766
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 01:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBA87B231F8
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 00:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0169442;
	Tue, 30 Jan 2024 00:15:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9328BEC9
	for <bpf@vger.kernel.org>; Tue, 30 Jan 2024 00:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706573712; cv=none; b=JvNNHzMAh0gXrdJwobJX5ngifJ2UWNSFWRan1iyRf132C1luvPFmzV2WtC5SsWcT5fd+71jUs81dw+lP4JJRKhtc3MWjl6ipPo9tmzHVAtjT3Zd2fmEuUoHFqjglgfA+SIUACNFf4R25hVgqNus4gAZi/XdWGaz/ZglGMfRgoIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706573712; c=relaxed/simple;
	bh=rC4tGlxiih9h+dUiH9jiqVYgbOtNEZDRejnXkDIU10Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tOiAIRZVK5wD0Y4QtAnRsxefFftJAqTGXl7g/Fy89cXmx2PeA71mPfSjKRiCkoFwigaWUNNV1g4hvpvNe+5N833eyxkyvVQKH3OE42YrpBdBmHvOy10CJtWHUK5oxr8F9gphbz/MAAhyTusxnJzvCD3z+29/betDMNYloHgwbKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-68c444f9272so13957876d6.3
        for <bpf@vger.kernel.org>; Mon, 29 Jan 2024 16:15:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706573709; x=1707178509;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tZyZ5s5CLPpbWKJr3SnDrNAfCVNLL0uygefMtNKXkBE=;
        b=UCs23VuJVPtg4O/IIn6YY9ushFBj69vC2SelvlcXVM6PrsaDfGa1G5HevHoOnQmKMw
         nBbzZYaxRtXF4ovrDv1IHULDJlxQs3vYMyIScfJnwrkf4ZAW6fMY5H2To9bPeSiP/QsP
         IADX61vV8AedA2QWA9bYqBo9nf/D4gq/c9JNqDEoWM6f/qOdhknWHe1Zs4peQG2p3wIW
         n8UkPH3MDpY7IygSeppNVmLAJDHy7JlHYtXEb1BkKd1lF5q4OexSWdj7O16HTS7aNQ8/
         f+onYmp4YnVfqSJ72h8iZqrCy456AFW0mfASdo+/GcOHEhgqcJ5amx9CpHcdQMUowEVk
         qNGA==
X-Gm-Message-State: AOJu0YxFfZj0So6aMCEwgX8Lk7g0r9e5CrS5dcRGU03Do0utN8Lxg+dP
	nYLOvRwuTIInxnHVwUAsPMLIU5p2u12eCHcZlaqsKM3MpEX2+0Gn
X-Google-Smtp-Source: AGHT+IEkohHy02mcq1H5BPx9PchMsSuAHIkLjvl0J/NNxDZ1Hp5hzgVeLYaWeaMQCJTtbI7hC03mhA==
X-Received: by 2002:a05:6214:2681:b0:681:9ba2:dd99 with SMTP id gm1-20020a056214268100b006819ba2dd99mr7082028qvb.124.1706573709250;
        Mon, 29 Jan 2024 16:15:09 -0800 (PST)
Received: from maniforge (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id mb6-20020a056214550600b0068c5e3d86bdsm173944qvb.48.2024.01.29.16.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 16:15:08 -0800 (PST)
Date: Mon, 29 Jan 2024 18:15:06 -0600
From: David Vernet <void@manifault.com>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: lsf-pc@lists.linux-foundation.org, Tejun Heo <tj@kernel.org>,
	bpf@vger.kernel.org, schatzberg.dan@gmail.com,
	andrea.righi@canonical.com, davemarchevsky@meta.com,
	changwoo@igalia.com, julia.lawall@inria.fr,
	himadrispandya@gmail.com
Subject: Re: [LSF/MM/BPF TOPIC] Discuss more features + use cases for
 sched_ext
Message-ID: <20240130001506.GA754714@maniforge>
References: <20240126215908.GA28575@maniforge>
 <7f389bbb-fdb2-4478-83c4-7df27f26e091@joelfernandes.org>
 <47d47cd3-f49c-401e-9f45-b3de5a084b67@joelfernandes.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zcULpOkkxkfBkI/N"
Content-Disposition: inline
In-Reply-To: <47d47cd3-f49c-401e-9f45-b3de5a084b67@joelfernandes.org>
User-Agent: Mutt/2.2.12 (2023-09-09)


--zcULpOkkxkfBkI/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 05:42:54PM -0500, Joel Fernandes wrote:
> Tejun's address bounced so I am adding the correct one. Thanks.

Ah, thanks, my mistake.

>=20
> On 1/29/2024 5:41 PM, Joel Fernandes wrote:
> >=20
> >=20
> > On 1/26/2024 4:59 PM, David Vernet wrote:
> >> Hello,
> >>
> >> A few more use cases have emerged for sched_ext that are not yet
> >> supported that I wanted to discuss in the BPF track. Specifically:
> >>
> >> - EAS: Energy Aware Scheduling
> >>
> >> While firmware ultimately controls the frequency of a core, the kernel
> >> does provide frequency scaling knobs such as EPP. It could be useful f=
or
> >> BPF schedulers to have control over these knobs to e.g. hint that
> >> certain cores should keep a lower frequency and operate as E cores.
> >> This could have applications in battery-aware devices, or in other
> >> contexts where applications have e.g. latency-sensitive
> >> compute-intensive workloads.
> >=20
> > This is a great topic. I think integrating/merging such mechanism with =
the NEST
> > scheduler could be useful too? You mentioned there is sched_ext impleme=
ntation
> > of NEST already? One reason that's interesting to me is the task-packin=
g and

Correct -- it's called scx_nest [0].

[0]: https://github.com/sched-ext/scx/blob/main/scheds/c/scx_nest.bpf.c

> > less-spreading may have power benefits, this is exactly what EAS on ARM=
 does,
> > but it also uses an energy model to know when packing is a bad idea. Si=
nce we
> > don't have fine grained control of frequency on Intel, I wonder what el=
se can we
> > do to know when the scheduler should pack and when to spread. Maybe som=
ething
> > simple which does not need an energy model but packs based on some other
> > signal/heuristic would be great in the short term.

Makes sense. What kinds of signals were you thinking? We can have user
space query for whatever we'd need, and then communicate that to the
kernel via shared maps. Or probably even more ideal, if we could get the
information we need from tracepoints or kprobes, then we could possibly
avoid having to deal with that and just keep everything in the kernel.
Note that we don't have to necessarily just track public APIs if we did
all of this in the kernel. If we can access a struct in a tracepoint or
a kprobe, we can read from it, and use that in the scheduler however we
want.

Of course, none of this comes with any kind of ABI stability guarantees,
but that's one of the features of sched_ext: because the actual
scheduler itself is a _kernel_ program that runs in kernel space, we can
experiment with and implement things without tying anyone's hands to
fully supporting it in the kernel forever. The user space portion
communicates with the BPF scheduler over maps that are UAPI (part of BPF
UAPI), but the actual scheduler itself is just a kernel program, and
therefore is free to interact with the rest of the system without making
anything UAPI or adding ABI stability requirements. The contents of
what's passed over those maps are not UAPI, in the same manner that the
contents sent over the communication channels setup by KVM per your
other thread [1] would not be UAPI.

[1]: https://lore.kernel.org/all/653c2448-614e-48d6-af31-c5920d688f3e@joelf=
ernandes.org/

> > Maybe a signal can be the "Quality of service (QoS)" approach where tas=
ks with
> > lower QoS are packed more aggressively and higher QoS are spread more (=
?).
> >=20
> >>
> >> - Componentized schedulers
> >>
> >> Scheduler implementations today largely have to reinvent the wheel. For
> >> example, if you want to implement a load balancer in rust, you need to
> >> add the necessary fields to the BPF program for tracking load / duty
> >> cycle, and then parse and consume them from the rust side. That's pret=
ty
> >> suboptimal though, as the actual load balancing algorithm itself is
> >> essentially the exact same. The challenge here is that the feature
> >> requires both BPF and user space components to work together. It's not
> >> enough to ship a rust crate -- you need to also ship a BPF object file
> >=20
> > Maybe I am confused but why does rust userspace code need to link to BPF
> > objects? The BPF object is loaded into the kernel right?

So there are a few pieces at play here:

1. You're correct that the BPF program is loaded into kernel space, but
the actual BPF bytecode itself is linked statically into the
application, and the application is what actually makes the syscalls
(via libbpf) to load the BPF program into the kernel. Here's a
high-level overview of the workflow for loading a scheduler:

	- Open the scheduler: This involves libbpf parsing the BPF
	  object file passed by the application, and discovering its
	  maps, progs, etc which should be created. At this phase user
	  space can still update any maps in the program, including e.g.
	  read-only maps such as .rodata. This allows user space to do
	  things like set the max # of CPUs on the system, set debug
	  flags if they were requested by the user, etc.
	- Load the scheduler: Libbpf creates BPF maps, does relocations
	  for CO-RE [2], and verifies and loads the scheduler into the
	  kernel. At this point, the program is loaded into the kernel,
	  but the scheduler is not actively running yet. User space can
	  no longer write read-only maps in the BPF program, but it can
	  still read and write _writeable_ maps, and it can in fact do
	  so indefinitely throughout the runtime of the scheduler. As
	  described below, this is why we need both a user space and
	  a BPF object file portion for such features.
	- Attach the scheduler: This actually calls into ext.c to update
	  the currently running scheduler to use the BPF sched_ext
	  scheduler.

[2]: https://nakryiko.com/posts/bpf-core-reference-guide/

2. As alluded to above, the user space program that loaded the scheduler
can interact with the scheduler in real time by reading and writing to
its writeable maps. This allows user space to e.g. read some procfs
values to determine utilization for each core in the system, do some
load balancing math with floating point numbers basad on that data and
on task weight / duty cycle, and then notify the BPF scheduler that is
should migrate tasks by writing to shared maps.

This is exactly what we do in scx_rusty [3]. We track duty cycles and
load in kernel space (soon we'll only track duty cycles and do all load
scaling in user space), and then periodically we'll do a load balancing
pass in the user-space portion of the scheduler where we read those
values, use floats, and then signal to the kernel if and where it should
migrate tasks by writing to maps. This is all done async from the
perspective of the kernel, so the kernel will check the maps to see if
there's an update on e.g. enqueue paths.

[3]: https://github.com/sched-ext/scx/tree/main/scheds/rust/scx_rusty/src

So to summarize -- the rust portion isn't running in the kernel, but it
is influencing the kernel scheduler's decisions by communicating with it
via these shared maps (and the kernel can similarly communicate with
user space in the opposite direction). That's the reason that it needs
to have both the user space portion and the kernel portion available to
implement these features. Neither makes sense without the other.

Note that not every scheduler we've implemented has a robust user space
portion, but every scheduler does have _some_ user space counterpart
which is responsible for loading it. scx_nest.c [4], for example,
doesn't really do anything in user space other than periodically print
out some data that's exported to it from the kernel scheduler via a
shared map. If we wanted to add user-space load balancing to scx_nest,
the same requirements would apply as for schedulers with a rust
user-space component: we'd need both a user space portion, and a
kernel-space portion.

[4]: https://github.com/sched-ext/scx/blob/main/scheds/c/scx_nest.c#L195

> >> that your program can link against. And what should the API look like =
on
> >> both ends? Should rust / BPF have to call into functions to get load
> >> balancing? Or should it be automatically packaged and implemented?
> >>
> >> There are a lot of ways that we can approach this, and it probably
> >> warrants discussing in some more detail
> >=20
> > But I get the gist of the issue, would be interesting to discuss.

Sounds great, thanks for reading this over.

- David

--zcULpOkkxkfBkI/N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZbg/igAKCRBZ5LhpZcTz
ZIxzAP0aPy8MX0C6dzlNF4heuYfDKij/FvHQJMM+vsNWktN6FQEA5C2Q5vQ9hL4U
IHXLnGTQh4vgMsZxRxuj19/Pl4lswgY=
=YZZJ
-----END PGP SIGNATURE-----

--zcULpOkkxkfBkI/N--

