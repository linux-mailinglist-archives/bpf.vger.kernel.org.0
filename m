Return-Path: <bpf+bounces-39625-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A80C79756CF
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 17:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52C1E1F21424
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 15:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114941AC8A1;
	Wed, 11 Sep 2024 15:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M+2YFp+J"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF6B1AB6F0;
	Wed, 11 Sep 2024 15:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726067933; cv=none; b=sydyEL2rY4IWPa24uq34RkSKhvSe+PvNLlLf5Q0FlKeJB1eyw+/BdL2CiyJD+izrAvZabDuN7lMJUFGRbXlKaZjpREHefCH+F/MCFI99O1e9bxeQ6vxJGwLIJowsTL74jNDlNHQV7fIGCa7BZg5tXREZUWcEXgddKCsAFDq+sQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726067933; c=relaxed/simple;
	bh=dIMTjUUU6Z+9RVyokzndesj6W8X7N4m9fc53dLvlP88=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=gR93kHGqkcwXkkKZ7BYuD/FqkOuinSEaO218GI2Vfgsi18/95cuWXzJVg6fJUi1jE8EialzciWs+qhDpD7dTx2F8B9Ybk3k75tMhzlOBY7Ym5wBsPYuvZDpZVquR/8Lk78Dx7Fli2bLdYmaDBc8uQkv3NKHl5egGkTGwQ3Vreyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M+2YFp+J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38B85C4CEC0;
	Wed, 11 Sep 2024 15:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726067933;
	bh=dIMTjUUU6Z+9RVyokzndesj6W8X7N4m9fc53dLvlP88=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M+2YFp+Jfs373JDhFk6aFPyisWNPDkvgBdhWdiHTa8+1cxhN6kvtNXDIC8JZzUEs9
	 jotL9FYDXo05Hg5u+Hcrt4x2ilKB5TDwzeOg2pNdfz67HlRM75frRCYmPa6Pbj2J5q
	 amh44oTixkfp6AZplnP4U9FBNe9VCZKt70j+7aCsoW9+gkBjbRgBRmBaaXIDPSfl0S
	 1++1jhpqYsaDoDrPhA6Tem3zCgumFqpbsDimb77BXuH0VmxCnMmHWq64o6KyGbs56T
	 X+0Ly9Uli8JxGCXAsBzqwTtxmXoA5emY/Tc/EqDzVARleqVW4H0rDjhtDygr9+IA1G
	 DZKhrv7M3kQ5g==
Date: Thu, 12 Sep 2024 00:18:48 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, bpf <bpf@vger.kernel.org>, Linux
 trace kernel <linux-trace-kernel@vger.kernel.org>, adubey@linux.ibm.com,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, KP Singh
 <kpsingh@chromium.org>, linux-arm-kernel
 <linux-arm-kernel@lists.infradead.org>, Mark Rutland
 <mark.rutland@arm.com>, Will Deacon <will@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Florent Revest
 <revest@chromium.org>, Puranjay Mohan <puranjay@kernel.org>
Subject: Re: Unsupported CONFIG_FPROBE and CONFIG_RETHOOK on ARM64
Message-Id: <20240912001848.d9629a1579ea3ef6531a9a0b@kernel.org>
In-Reply-To: <CAEf4BzbdxSbaK1V10j8t_rjG4ZnYsFQLqPrBSswR8KhjmC=5cg@mail.gmail.com>
References: <CAEf4BzaYyEftmRmt6FswrTOsb9FuQMtzuDXD4OJMO7Ein2ZRGg@mail.gmail.com>
	<CAEf4BzasRqeAY3ZpBDbjyWSKUriZgUf4U_YoQNSSutKhX5g2kw@mail.gmail.com>
	<20240911091343.77c60bc2e5d96cbfd8787c19@kernel.org>
	<CAEf4BzbdxSbaK1V10j8t_rjG4ZnYsFQLqPrBSswR8KhjmC=5cg@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 10 Sep 2024 17:37:48 -0700
Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> On Tue, Sep 10, 2024 at 5:13 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > On Tue, 10 Sep 2024 11:23:29 -0700
> > Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> >
> > > + arm ML and maintainers
> > >
> > > On Wed, Sep 4, 2024 at 6:02 PM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > Hey,
> > > >
> > > > I just recently realized that we are still missing multi-kprobe
> > > > support for ARM64, which depends on CONFIG_FPROBE. And CONFIG_FPROBE
> > > > seems to require CONFIG_HAVE_RETHOOK, which, it turns out, is not
> > > > implemented for ARM64.
> > > >
> > > > It took me a while to realize what's going on, as I roughly remembered
> > > > (and confirmed through lore search) that Masami's original rethook
> > > > patches had arm64-specific bits. Long story short:
> > > >
> > > > 0f8f8030038a Revert "arm64: rethook: Add arm64 rethook implementation"
> > > > 83acdce68949 arm64: rethook: Add arm64 rethook implementation
> > > >
> > > > The patch was landed and then reverted. I found some discussion online
> > > > and it seems like the plan was to land arch-specific bits shortly
> > > > after bpf-next PR.
> > > >
> > > > But it seems like that never happened. Why?
> > > >
> > > > I see s390x, RISC-V, loongarch (I'm not even mentioning x86-64) all
> > > > have CONFIG_HAVE_RETHOOK, even powerpc is getting one (see [0]), it
> > > > seems. How come ARM64 is the one left out?
> > > >
> > > > Can anyone please provide some context? And if that's just an
> > > > oversight, can we prioritize landing this for ARM64 ASAP?
> > > >
> > > >   [0] https://lore.kernel.org/bpf/20240830113131.7597-1-adubey@linux.ibm.com/
> > > >
> > >
> > > Masami, Steven,
> > >
> > > Does Linus have to be in CC to get any reply here? Come on, it's been
> > > almost a full week.
> >
> > Sorry about bothering you, let me check that. But I think we eventually
> 
> You don't bother me, but I'd appreciate a bit more timely replies in
> the future, if that's OK.
> 
> > need my fprobe-on-fgraph patch which allows all architecture uses ftrace_regs
> > instead of pt_regs for ftrace/fgraph users. That allows arm64 to implement
> > fprobe.
> 
> Ok, thanks for a bit more context. I understand the end goal with
> fprobe-on-fgraph, but see below.
> 
> >
> > >
> > > Maybe ARM64 folks have some context?... And hopefully desire to see
> > > this through so that ARM64 doesn't stick out as a lesser-supported
> > > platform as far as tracing goes compared to loongarch, s390x, and
> > > powerpc (which just landed rethook support, see [2]).
> >
> > I think lesser-supported or not is not a matter, but they need to keep
> > their architecutre healthy. Mark said that the current rethook
> > implementation is not acceptable because arm64 can not manually generate
> 
> I don't see Mark's reply in the link you sent. But did he refer to the
> code in kprobes_trampoline.S or is it something different?

Sorry, here it is: https://lkml.org/lkml/2022/4/12/2233

> 
> By lesser-supported I mean that a very important functionality (BPF
> multi-kprobe, which relies on CONFIG_FPROBE and thus
> {HAVE|CONFIG}_RETHOOK) is currently still missing. And whether x86-64
> support landed more than 2 years ago (end of March 2022), the second
> practically most popular (and thus important for tools and such) ARM64
> platform still doesn't have this functionality.
> 
> And that's limiting, BPF multi-kprobes are a huge improvement in
> tooling usability.

Sorry for inconvenient. But I think this transformation is really
important.

> So while I get the desire to have a clean and nice
> end goal, and that it might take a bit longer to get everything right.
> But, maybe, landing a stop-gap solution meanwhile (especially as
> isolated and thus easily backportable as the patch [0] you referenced)
> is an OK path forward?

I had not realized that the PSTATE register was not saved correctly
at that point. This is one reason why I decided to move in the
current fprobe-on-fgraph direction.

> 
> I'm just lacking full understanding on what exactly the issue is/was,
> and that's why I'm asking all these questions. I'm not sure if [0] is
> just broken for some subtle reason, or it is just suboptimal in some
> sense (performance, code duplication, whatnot)?

If [0] was not broken, I pushed it and the current pt_regs to ftrace_regs
series is separated series. But it was broken. So I tried to find the
correct way to fix it, and finally introduced the current fprobe on 
fgraph series. performance improvement is just a side effect.

Thank you,

> 
> 
>   [0] https://lore.kernel.org/bpf/164338038439.2429999.17564843625400931820.stgit@devnote2/
> 
> > pt_regs. So we need to use ftrace_regs for that.
> > So eventually, we need my fprobe series.
> >
> > https://lore.kernel.org/bpf/164338038439.2429999.17564843625400931820.stgit@devnote2/
> >
> > Thank you,
> >
> > >
> > > Note that there was already an implementation (see [1]), but for some
> > > reason it never made it.
> > >
> > >   [1] https://lore.kernel.org/bpf/164338038439.2429999.17564843625400931820.stgit@devnote2/
> > >   [2] https://lore.kernel.org/bpf/172562357215.467568.2172858907419105155.b4-ty@ellerman.id.au/
> > >
> > > >
> > > > -- Andrii
> >
> >
> > --
> > Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

