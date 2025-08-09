Return-Path: <bpf+bounces-65290-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA15FB1F1D0
	for <lists+bpf@lfdr.de>; Sat,  9 Aug 2025 03:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0E6317E37C
	for <lists+bpf@lfdr.de>; Sat,  9 Aug 2025 01:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034C1275AF7;
	Sat,  9 Aug 2025 01:06:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F71626AC3;
	Sat,  9 Aug 2025 01:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754701602; cv=none; b=nmQB4rohmLz1i6AIhVAnLb6rpbzkCNz8uKqiPlQmYVbqjxC/gtunOVqsD/jqAB/NXb6lh6Et/Bvyg63wIfenmVK9gvMKaPKG8a2ch8K1g0pflWcdoJR1XlT2UdfE1gm5t1SqGNgBWdYCw7E9T3qb+RBb0G8a3Y4XsvTmyIdRPz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754701602; c=relaxed/simple;
	bh=15F7aI+r0WoW6+7rKoODNS2mjeTNusBQQb6gvCRbOO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VV8b+9g45BSlE9zyhzAbwAjAFQgoBQinrmkIYyxTT/lU9bOCjvMSzswPF2BiITDGCARtighBhLQbVe78vFHV7+K3PoIxxsdRYhQ29rl60S84uR7syLZU4el/ecCzc37rBmh7YYCDIzWEmkE3DjJcrNwUeEj1JMfrZo+4Oa/8nVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 54AF7AAF; Fri,  8 Aug 2025 20:06:36 -0500 (CDT)
Date: Fri, 8 Aug 2025 20:06:36 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>, daniel.sneddon@linux.intel.com,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	alexandre.chartre@oracle.com, Ondrej Mosnacek <omosnace@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>,
	selinux@vger.kernel.org,
	LSM List <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH] x86/bpf: use bpf_capable() instead of
 capable(CAP_SYS_ADMIN)
Message-ID: <aJafHPr6GL3DyggB@mail.hallyn.com>
References: <20250806143105.915748-1-omosnace@redhat.com>
 <aJP+/1VGbe1EcgKz@mail.hallyn.com>
 <aJaPQZqDIcT17aAU@mail.hallyn.com>
 <CAADnVQKY0z1RAJdAmRGbLWZxrJPG6Kawe6_qQHjoVM7Xz8CfuA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQKY0z1RAJdAmRGbLWZxrJPG6Kawe6_qQHjoVM7Xz8CfuA@mail.gmail.com>

On Fri, Aug 08, 2025 at 05:46:28PM -0700, Alexei Starovoitov wrote:
> On Fri, Aug 8, 2025 at 4:59 PM Serge E. Hallyn <serge@hallyn.com> wrote:
> >
> > On Wed, Aug 06, 2025 at 08:18:55PM -0500, Serge E. Hallyn wrote:
> > > On Wed, Aug 06, 2025 at 04:31:05PM +0200, Ondrej Mosnacek wrote:
> > > > Don't check against the overloaded CAP_SYS_ADMINin do_jit(), but instead
> > > > use bpf_capable(), which checks against the more granular CAP_BPF first.
> > > > Going straight to CAP_SYS_ADMIN may cause unnecessary audit log spam
> > > > under SELinux, as privileged domains using BPF would usually only be
> > > > allowed CAP_BPF and not CAP_SYS_ADMIN.
> > > >
> > > > Link: https://bugzilla.redhat.com/show_bug.cgi?id=2369326
> > > > Fixes: d4e89d212d40 ("x86/bpf: Call branch history clearing sequence on exit")
> > > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > >
> > > So this seems correct, *provided* that we consider it within the purview of
> > > CAP_BPF to be able to avoid clearing the branch history buffer.
> 
> true, but...
> 
> > >
> > > I suspect that's the case, but it might warrant discussion.
> > >
> > > Reviewed-by: Serge Hallyn <serge@hallyn.com>
> >
> > (BTW, I'm assuming this will get pulled into a BPF tree or something, and
> > doesn't need to go into the capabilities tree.  Let me know if that's wrong)
> 
> Right.
> scripts/get_maintainer.pl arch/x86/net/bpf_jit_comp.c
> is your friend.
> 
> Pls cc author-s of the commit in question in the future.
> Adding them now.
> 
> > > > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> > > > index 15672cb926fc1..2a825e5745ca1 100644
> > > > --- a/arch/x86/net/bpf_jit_comp.c
> > > > +++ b/arch/x86/net/bpf_jit_comp.c
> > > > @@ -2591,8 +2591,7 @@ emit_jmp:
> > > >                     seen_exit = true;
> > > >                     /* Update cleanup_addr */
> > > >                     ctx->cleanup_addr = proglen;
> > > > -                   if (bpf_prog_was_classic(bpf_prog) &&
> > > > -                       !capable(CAP_SYS_ADMIN)) {
> > > > +                   if (bpf_prog_was_classic(bpf_prog) && !bpf_capable()) {
> 
> This looks wrong for several reasons.
> 
> 1.
> bpf_capable() and CAP_BPF in general applies to eBPF only.
> There is no precedent so far to do anything differently
> for cBPF when CAP_BPF is present.

Oh.  I don't see that explicitly laid out in capability.h or in the
commit message for a17b53c4a.  I suspect if I were more familiar
with eBPF it would be obvious based on the detailed list of things
protected.  Perhaps it should've been called CAP_EBPF...

> 2.
> commit log states that
> "privileged domains using BPF would usually only be allowed CAP_BPF
> and not CAP_SYS_ADMIN"
> which is true for eBPF only, since cBPF is always allowed for
> all unpriv users.
> Start chrome browser and you get cBPF loaded.
> 
> 3.
> glancing over bugzilla it seems that the issue is
> excessive audit spam and not related to CAP_BPF and privileges.
> If so then the fix is to use
> ns_capable_noaudit(&init_user_ns, CAP_SYS_ADMIN)

Right, thank you, that seems correct.  Callers with CAP_BPF don't
need to be able to avoid the barrier.

Ondrej, can you send a new patch for that?

> 4.
> I don't understand how the patch is supposed to fix the issue.
> iio-sensor-proxy is probably unpriv. Why would it use CAP_BPF?
> It's using cBPF, so there is no reason for it to have CAP_BPF.
> So capable(CAP_BPF) will fail just like capable(CAP_SYS_ADMIN),
> but since CAP_BPF check was done first, the audit won't
> be printed, because it's some undocumented internal selinux behavior ?
> None of it is in the commit log :(
> 
> 5.
> And finally all that looks like a selinux bug.
> Just because something in the kernel is asking capable(CAP_SYS_ADMIN)
> there is no need to spam users with the wrong message:
> "SELinux is preventing iio-sensor-prox from using the 'sys_admin' capabilities."
> iio-sensor-prox is not trying to use 'sys_admin' capabilities.
> cBPF prog will be loaded anyway, with or without BHB clearing.



