Return-Path: <bpf+bounces-39650-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2F6975B99
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 22:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3DC2B21356
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 20:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812FF1BB69F;
	Wed, 11 Sep 2024 20:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JjiMdCOv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802F21BA883;
	Wed, 11 Sep 2024 20:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726085907; cv=none; b=aMCd7oACQG4VrC8Mb/kpZ2D6WGpy89jXrUHsgoBoLiU0kKL1INVslRoO5XHAjWsgwd8Zavk5IzlT//rqGgVmTZJT5PSH50nBS8fg006NPx5w0rj0r/dTauLNZwXdDnSCLW4Sd3ke3Bg264hAdHP6OPAGRUtok9YqiUrlag4VN0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726085907; c=relaxed/simple;
	bh=hp/H/LDOAUYNlPZKBUwnLV6UZTeCqkeY9EML0hLTvXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GR1nhR5xTuflRHy15Vn10rIPVt35yeXrpvL+nWpuduSXvT3UqIdqyNNzyY0RAxTelKnRaL409eYDdgzknw6SBCqx9Hg3jz6jrKIfnj0wiDAEyZFfKbdx35odWwwk2I7rt2S8itpWHqjG0tV1A2hbyKdY8cPm5z/rd4fzqFPC1co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JjiMdCOv; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-6e7b121be30so188430a12.1;
        Wed, 11 Sep 2024 13:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726085905; x=1726690705; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQ65uqvG6oOfFabrAM8cFTKhTB2LFL8uMahweQD9GlY=;
        b=JjiMdCOvx+/RiclK/EqzvqVj0c799VCZQ7+ASZFEQqSHzjqCY6BvV15gc1BMt+Z/vG
         K+eh3eN42WkYjH/t0oYrO9aX/bNmJuKt3tYDRdwVOwccBwiD48AUHL4uSaIruiOxFf0H
         /+29YmfSGPMOy2b0jUoCx6dQs3LDkD3zieg6RvwXymxTlD4Nm1Nz+xmdGlY/PmGNbB8A
         2JsgDAbb/7Fq5nNqwg+KJTMyCrztevA5MMwByQbOXNNdVoR5Bp2yePJF2O5IsKPP8WvH
         Y5GkOVw0mPzIWTz5dlBzaiv2o9T+54ar9Qn1E5gsPIccCQb1U9e6DFmePfYhC4JFYVUo
         tanA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726085905; x=1726690705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IQ65uqvG6oOfFabrAM8cFTKhTB2LFL8uMahweQD9GlY=;
        b=Id8hQZ7pzJmkryaWKAPm2o5IXxpN5WqCEOix4CskhXkTFOi/mmMBA4j2cWYFk63Y7V
         b/NoAdkZPZgnnsvurb2RvRIUHbc245SL+kIOvWtwiNhrER1CLIGcwXviq7XfskbPm/Vy
         zRUmnR23JQT9U7tKy49JU3dPl1P4dIuJXL603FO3NU1mpvpAc2FcmoXzkE+9kWqZrvXs
         crlqd65SqV2QodsSc6UH/RIe5Eg0vlZON7+DkiXhtfQXjcjczQH/cDZ2VkCjQRYwpxjC
         IDCpR6JY4fELWgvBjvMrzL0+6PsTZEoKlPtKqY1OKBb65AKdid3BRPJjPFTPuH7vlMd/
         d0qw==
X-Forwarded-Encrypted: i=1; AJvYcCVYs2JbROr8ehl2x1z0sHrZ/nF3Nk68UMytiE+DYAIG4TmiTEiXoH9k5y3mm7RDsE1I1UU=@vger.kernel.org, AJvYcCWnJwf+p7g8mevX3dLKw2evGRYVSYqxeVH/CTUbBtoJeS93GpRV19xGqgbUjBVSYMCmzm3o5Oi0kNCgWiIXzXqJTJ/v@vger.kernel.org
X-Gm-Message-State: AOJu0YxZjXfnzHGjViLhii+3beYK4EO5UvcgVfpt9fCu7ChtLKzt4gwU
	da/vE2S+FVTJm63C2EliSPNRtL95s8mU2OJbWdBVmD1JgVcH3lRXYYB2XNx4lQFnO8lQW1IWHob
	UYg7GkMFqXHrvvlPX5XOGd3FlsTY=
X-Google-Smtp-Source: AGHT+IEAX4gPsitnvS07dpR3aZJ5wvIDLSSKwn1lPMJCO2guTararx3vRe94P3a2EzWxVl5U0OUHP4+ibCLC6JrVec4=
X-Received: by 2002:a17:90a:a012:b0:2d8:bd33:9c07 with SMTP id
 98e67ed59e1d1-2dba0064f0emr387270a91.26.1726085904616; Wed, 11 Sep 2024
 13:18:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEf4BzaYyEftmRmt6FswrTOsb9FuQMtzuDXD4OJMO7Ein2ZRGg@mail.gmail.com>
 <CAEf4BzasRqeAY3ZpBDbjyWSKUriZgUf4U_YoQNSSutKhX5g2kw@mail.gmail.com>
 <20240911091343.77c60bc2e5d96cbfd8787c19@kernel.org> <CAEf4BzbdxSbaK1V10j8t_rjG4ZnYsFQLqPrBSswR8KhjmC=5cg@mail.gmail.com>
 <20240912001848.d9629a1579ea3ef6531a9a0b@kernel.org>
In-Reply-To: <20240912001848.d9629a1579ea3ef6531a9a0b@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 11 Sep 2024 13:18:12 -0700
Message-ID: <CAEf4BzaWtsAeXyDWh7kq8Qnyy=9u7iAVonmefNRvXnTfbv03yg@mail.gmail.com>
Subject: Re: Unsupported CONFIG_FPROBE and CONFIG_RETHOOK on ARM64
To: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Jiri Olsa <jolsa@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, bpf <bpf@vger.kernel.org>, 
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>, adubey@linux.ibm.com, 
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, KP Singh <kpsingh@chromium.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Will Deacon <will@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Florent Revest <revest@chromium.org>, Puranjay Mohan <puranjay@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 8:18=E2=80=AFAM Masami Hiramatsu <mhiramat@kernel.o=
rg> wrote:
>
> On Tue, 10 Sep 2024 17:37:48 -0700
> Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> > On Tue, Sep 10, 2024 at 5:13=E2=80=AFPM Masami Hiramatsu <mhiramat@kern=
el.org> wrote:
> > >
> > > On Tue, 10 Sep 2024 11:23:29 -0700
> > > Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> > >
> > > > + arm ML and maintainers
> > > >
> > > > On Wed, Sep 4, 2024 at 6:02=E2=80=AFPM Andrii Nakryiko
> > > > <andrii.nakryiko@gmail.com> wrote:
> > > > >
> > > > > Hey,
> > > > >
> > > > > I just recently realized that we are still missing multi-kprobe
> > > > > support for ARM64, which depends on CONFIG_FPROBE. And CONFIG_FPR=
OBE
> > > > > seems to require CONFIG_HAVE_RETHOOK, which, it turns out, is not
> > > > > implemented for ARM64.
> > > > >
> > > > > It took me a while to realize what's going on, as I roughly remem=
bered
> > > > > (and confirmed through lore search) that Masami's original rethoo=
k
> > > > > patches had arm64-specific bits. Long story short:
> > > > >
> > > > > 0f8f8030038a Revert "arm64: rethook: Add arm64 rethook implementa=
tion"
> > > > > 83acdce68949 arm64: rethook: Add arm64 rethook implementation
> > > > >
> > > > > The patch was landed and then reverted. I found some discussion o=
nline
> > > > > and it seems like the plan was to land arch-specific bits shortly
> > > > > after bpf-next PR.
> > > > >
> > > > > But it seems like that never happened. Why?
> > > > >
> > > > > I see s390x, RISC-V, loongarch (I'm not even mentioning x86-64) a=
ll
> > > > > have CONFIG_HAVE_RETHOOK, even powerpc is getting one (see [0]), =
it
> > > > > seems. How come ARM64 is the one left out?
> > > > >
> > > > > Can anyone please provide some context? And if that's just an
> > > > > oversight, can we prioritize landing this for ARM64 ASAP?
> > > > >
> > > > >   [0] https://lore.kernel.org/bpf/20240830113131.7597-1-adubey@li=
nux.ibm.com/
> > > > >
> > > >
> > > > Masami, Steven,
> > > >
> > > > Does Linus have to be in CC to get any reply here? Come on, it's be=
en
> > > > almost a full week.
> > >
> > > Sorry about bothering you, let me check that. But I think we eventual=
ly
> >
> > You don't bother me, but I'd appreciate a bit more timely replies in
> > the future, if that's OK.
> >
> > > need my fprobe-on-fgraph patch which allows all architecture uses ftr=
ace_regs
> > > instead of pt_regs for ftrace/fgraph users. That allows arm64 to impl=
ement
> > > fprobe.
> >
> > Ok, thanks for a bit more context. I understand the end goal with
> > fprobe-on-fgraph, but see below.
> >
> > >
> > > >
> > > > Maybe ARM64 folks have some context?... And hopefully desire to see
> > > > this through so that ARM64 doesn't stick out as a lesser-supported
> > > > platform as far as tracing goes compared to loongarch, s390x, and
> > > > powerpc (which just landed rethook support, see [2]).
> > >
> > > I think lesser-supported or not is not a matter, but they need to kee=
p
> > > their architecutre healthy. Mark said that the current rethook
> > > implementation is not acceptable because arm64 can not manually gener=
ate
> >
> > I don't see Mark's reply in the link you sent. But did he refer to the
> > code in kprobes_trampoline.S or is it something different?
>
> Sorry, here it is: https://lkml.org/lkml/2022/4/12/2233
>

Thanks for the link!

> >
> > By lesser-supported I mean that a very important functionality (BPF
> > multi-kprobe, which relies on CONFIG_FPROBE and thus
> > {HAVE|CONFIG}_RETHOOK) is currently still missing. And whether x86-64
> > support landed more than 2 years ago (end of March 2022), the second
> > practically most popular (and thus important for tools and such) ARM64
> > platform still doesn't have this functionality.
> >
> > And that's limiting, BPF multi-kprobes are a huge improvement in
> > tooling usability.
>
> Sorry for inconvenient. But I think this transformation is really
> important.
>
> > So while I get the desire to have a clean and nice
> > end goal, and that it might take a bit longer to get everything right.
> > But, maybe, landing a stop-gap solution meanwhile (especially as
> > isolated and thus easily backportable as the patch [0] you referenced)
> > is an OK path forward?
>
> I had not realized that the PSTATE register was not saved correctly
> at that point. This is one reason why I decided to move in the
> current fprobe-on-fgraph direction.

Sure, but you said yourself, the same problem exists with current
kretprobe implementation, so this won't regress anything. And yes,
your fprobe-on-fgraph series is supposed to fix this for good, which
is great, but that's a separate topic.

>
> >
> > I'm just lacking full understanding on what exactly the issue is/was,
> > and that's why I'm asking all these questions. I'm not sure if [0] is
> > just broken for some subtle reason, or it is just suboptimal in some
> > sense (performance, code duplication, whatnot)?
>
> If [0] was not broken, I pushed it and the current pt_regs to ftrace_regs
> series is separated series. But it was broken. So I tried to find the
> correct way to fix it, and finally introduced the current fprobe on
> fgraph series. performance improvement is just a side effect.

So, looking at Mark's replies, I didn't get the impression that
something was badly broken (but what do I know about arm64 bits). The
reason I'm asking to implement rethook on arm64 is because the code is
almost there, and so it seems like it would be pretty easy to get this
in. The code doesn't regress anything compared to existing kretprobe
implementation. And there isn't that much code and it seems to be
pretty well contained. This makes it easier to backport to older
production kernels. Which is great thing all in itself.

Mark, what are your thoughts on this? Would you be ok with landing
rethook-for-arm64 as an interim solution while Masami is ironing out
the kinds with his fprobe-on-fgraph solution (which seems to have a
pretty noticeable regression for kprobes, and I'm not sure that's
acceptable; this is being investigated at the moment, cc @Jiri).

>
> Thank you,
>
> >
> >
> >   [0] https://lore.kernel.org/bpf/164338038439.2429999.1756484362540093=
1820.stgit@devnote2/
> >
> > > pt_regs. So we need to use ftrace_regs for that.
> > > So eventually, we need my fprobe series.
> > >
> > > https://lore.kernel.org/bpf/164338038439.2429999.17564843625400931820=
.stgit@devnote2/
> > >
> > > Thank you,
> > >
> > > >
> > > > Note that there was already an implementation (see [1]), but for so=
me
> > > > reason it never made it.
> > > >
> > > >   [1] https://lore.kernel.org/bpf/164338038439.2429999.175648436254=
00931820.stgit@devnote2/
> > > >   [2] https://lore.kernel.org/bpf/172562357215.467568.2172858907419=
105155.b4-ty@ellerman.id.au/
> > > >
> > > > >
> > > > > -- Andrii
> > >
> > >
> > > --
> > > Masami Hiramatsu (Google) <mhiramat@kernel.org>
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

