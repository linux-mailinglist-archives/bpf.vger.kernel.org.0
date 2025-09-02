Return-Path: <bpf+bounces-67210-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE256B40C2D
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 19:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36C6256281D
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 17:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7554034572B;
	Tue,  2 Sep 2025 17:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GpfAIsRh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077412DF14C;
	Tue,  2 Sep 2025 17:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756834629; cv=none; b=LpvXyXP6RFePVRtgv5ZH2HWoCWKyFBOH1ycIHXBygcPX4R8kBMzxjIGi8UjKSjrhdIvL5Ki3lJAKEMxjPuNDiayDrnWyjweZCGk6l74r9N8G35SOAoLS7L7hwWjw1+90j0LvntsGtFaxeDIdsqsgqYlnxWSVNokrYeiIVCDMtZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756834629; c=relaxed/simple;
	bh=fVF/w0IspcUcohNy7rvyBXWI7Etd2t87O+OI9EH6OHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LNb5SDjc2CUwbQ+Y8Ju8VwTpYm6XAqqSEhfYKtBz27GaMVG8SyCiiOFSoxgquL/s8tY3N6yOE+aUuwXXdDioQDpZogPUCsg/Wi+d97oVryklVjQY4L5mUIO/hhUYQbE/157Ehb1dk7VD0Elj/XVE0rI4DnjfGIR0E+bvPU+ZFW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GpfAIsRh; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45b8b1a104cso23863395e9.2;
        Tue, 02 Sep 2025 10:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756834625; x=1757439425; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SDAZFYppHtiutIhhIj0DiwwuGu0zG4rkjXlVpOgF4Ig=;
        b=GpfAIsRhNTI+WcXpHwWddhQHWKbuzbDelXnv8jCHeoG0h6c2/Pbg/KvNsFLq+uyxkP
         G8TTlQvpZ0bOP7411tKSjeSNJEcR1/pEmUDZBHGbUK/ZH0zle4ffkJ8M112btDlwrDnw
         RoXipAbowOlUykJXxjKxC2oigqhjOHdd7T6dwdMrQpPO5wPMfB611uYVEcdVuVVu2+Xn
         QIw8l1F+DZlvIEZNMG2LBYcfPrZoKdEiri+KQHnfR37JDxj7ds0WV7c5TByD3lLNDlvE
         oxon6+/ynmFkWaQ8TWT2ABExO6nHWHFz9WokZTVbj4/RoocuSglEOV0LzHEVIhFtI3dE
         vwVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756834625; x=1757439425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SDAZFYppHtiutIhhIj0DiwwuGu0zG4rkjXlVpOgF4Ig=;
        b=qN+EpTNW2U2rZiO84t2lmdRjjxieH6kO6wfXTqYDtmifqijVUqPPWRQzVROaicDkc9
         XhKw7HtBdpI1anjkLp+VZACjLl3oS3KKIoISyO2r2J4PrjsOTcuqpQXt0kh+t2Vd3oZ2
         0NYQO2D+Rmj/3WxZUKK2p53p8gn3RSX/vCwkbyCgvrMt7TuvHwnuRVnpEB+m9c2wbdyf
         Sxmh7NXU7J5ZCHmpcPgz0ZuWr3gKp8PpzrXVochyWZsZ07uhAaRla7E3N06aUm8FO8xE
         MD15gSKw/09ufOZkw455or0UnZQ8vDH0AmC0u0ldqklbAFE6ucY7HxFzq07Gtqe5l72E
         TdsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUX0KX4XZ23bOHCpKvnuultxuak8dUx/eoE3QTSFO1yVEhSgjZtEYa0wnS82637ujgIUF0=@vger.kernel.org, AJvYcCVJ3XbR4l/KVeOS+h1ClMnPthE/HmFrv2ALHcyxdmSMuIEl5GOpQxdotfxHiJL/clydcpzb7K1aHQ==@vger.kernel.org, AJvYcCVMiGwA47N4Ax2J+d0w890eM7GAszheb4o3VsM5rmqUX+VGwyWZJgbAsT5sOfpY3ZTh+lvHP2dG4YhKCAtU9UBRLbX8zjX6@vger.kernel.org
X-Gm-Message-State: AOJu0YwlYzGhXedeQ0+95YxOIbgjTOgqUyaDH+SppblBTd9j9qsmUbcL
	GH1KHPhS8CxABSBAwgB42AR5maRXmR4qynSuN/hSiHTDR4/MlYA55tYJJOP32knd0HKzTpU8DSV
	slz0GfCLTb8BgDYtvH5eRYrEXTIcCvGvBGlb6
X-Gm-Gg: ASbGncvNiiMe1vRu5Mw8/2MmZu/1zwH1I/8K/Rx7fo5XMbpHSzJ+hK0Q+Omalq44jos
	24gGWg/QfavDYuAmu2sJ0G/qp2dY6EuNnZ++Bc5LR9U4eJNRQfu16gJv1BjS1GSJnUARP6Hk14Q
	ihdnjhhwy8n+7/jEfKisUl6QS3VBaEIDwpOPzef2GerVr/oVyMv+YBlSx1+jSlMVWVncWNFuK6n
	TrnB0eA7leuE3SKeAjetzHtFhBiBezPMw==
X-Google-Smtp-Source: AGHT+IEn9zWW9Vz1EabYQOWeJfcroDWJpKkgsgIYU3nBRfp2SBg+1PbyAPhQ7LSYaniCBmNW5y2GSnWBnnGiE1WE8O0=
X-Received: by 2002:a05:6000:26c2:b0:3cb:3490:6b86 with SMTP id
 ffacd0b85a97d-3d1dc699f5emr7208639f8f.1.1756834625031; Tue, 02 Sep 2025
 10:37:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250806143105.915748-1-omosnace@redhat.com> <aJP+/1VGbe1EcgKz@mail.hallyn.com>
 <aJaPQZqDIcT17aAU@mail.hallyn.com> <CAADnVQKY0z1RAJdAmRGbLWZxrJPG6Kawe6_qQHjoVM7Xz8CfuA@mail.gmail.com>
 <CAFqZXNtAfzFJtL3gG7ViEFOWoAE2VNrvCOA5DxqMmWt7z6g5Yg@mail.gmail.com>
In-Reply-To: <CAFqZXNtAfzFJtL3gG7ViEFOWoAE2VNrvCOA5DxqMmWt7z6g5Yg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 2 Sep 2025 10:36:51 -0700
X-Gm-Features: Ac12FXxv-nPz8Ga4zFYQ-oFJgZrRlz5k4q7uUJZB88xrgrU59te55lFRsl6pXPo
Message-ID: <CAADnVQL7C6hM6vwztSdq_U4b0u8p-0aVwkaKDAxd53q_+8G1bw@mail.gmail.com>
Subject: Re: [PATCH] x86/bpf: use bpf_capable() instead of capable(CAP_SYS_ADMIN)
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>, daniel.sneddon@linux.intel.com, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, alexandre.chartre@oracle.com, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>, 
	selinux@vger.kernel.org, LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 2:49=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.co=
m> wrote:
>
> On Sat, Aug 9, 2025 at 2:46=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Fri, Aug 8, 2025 at 4:59=E2=80=AFPM Serge E. Hallyn <serge@hallyn.co=
m> wrote:
> > >
> > > On Wed, Aug 06, 2025 at 08:18:55PM -0500, Serge E. Hallyn wrote:
> > > > On Wed, Aug 06, 2025 at 04:31:05PM +0200, Ondrej Mosnacek wrote:
> > > > > Don't check against the overloaded CAP_SYS_ADMINin do_jit(), but =
instead
> > > > > use bpf_capable(), which checks against the more granular CAP_BPF=
 first.
> > > > > Going straight to CAP_SYS_ADMIN may cause unnecessary audit log s=
pam
> > > > > under SELinux, as privileged domains using BPF would usually only=
 be
> > > > > allowed CAP_BPF and not CAP_SYS_ADMIN.
> > > > >
> > > > > Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D2369326
> > > > > Fixes: d4e89d212d40 ("x86/bpf: Call branch history clearing seque=
nce on exit")
> > > > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > >
> > > > So this seems correct, *provided* that we consider it within the pu=
rview of
> > > > CAP_BPF to be able to avoid clearing the branch history buffer.
> >
> > true, but...
> >
> > > >
> > > > I suspect that's the case, but it might warrant discussion.
> > > >
> > > > Reviewed-by: Serge Hallyn <serge@hallyn.com>
> > >
> > > (BTW, I'm assuming this will get pulled into a BPF tree or something,=
 and
> > > doesn't need to go into the capabilities tree.  Let me know if that's=
 wrong)
> >
> > Right.
> > scripts/get_maintainer.pl arch/x86/net/bpf_jit_comp.c
> > is your friend.
> >
> > Pls cc author-s of the commit in question in the future.
> > Adding them now.
> >
> > > > > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_c=
omp.c
> > > > > index 15672cb926fc1..2a825e5745ca1 100644
> > > > > --- a/arch/x86/net/bpf_jit_comp.c
> > > > > +++ b/arch/x86/net/bpf_jit_comp.c
> > > > > @@ -2591,8 +2591,7 @@ emit_jmp:
> > > > >                     seen_exit =3D true;
> > > > >                     /* Update cleanup_addr */
> > > > >                     ctx->cleanup_addr =3D proglen;
> > > > > -                   if (bpf_prog_was_classic(bpf_prog) &&
> > > > > -                       !capable(CAP_SYS_ADMIN)) {
> > > > > +                   if (bpf_prog_was_classic(bpf_prog) && !bpf_ca=
pable()) {
> >
> > This looks wrong for several reasons.
> >
> > 1.
> > bpf_capable() and CAP_BPF in general applies to eBPF only.
> > There is no precedent so far to do anything differently
> > for cBPF when CAP_BPF is present.
>
> That's not entirely true, see below.
>
> > 2.
> > commit log states that
> > "privileged domains using BPF would usually only be allowed CAP_BPF
> > and not CAP_SYS_ADMIN"
> > which is true for eBPF only, since cBPF is always allowed for
> > all unpriv users.
> > Start chrome browser and you get cBPF loaded.
>
> Processes using cBPF (via SO_ATTACH_FILTER) already can trigger a
> CAP_BPF check - when the net.core.bpf_jit_harden sysctl is set to 1,
> then the sequence sk_attach_filter() -> __get_filter() ->
> bpf_prog_alloc() -> bpf_prog_alloc_no_stats() ->
> bpf_jit_blinding_enabled() -> bpf_token_capable() happens for the same
> iio-sensor-proxy syscall as the one that hits the CAP_SYS_ADMIN check.

Agree that it's a similar case and we should standardize on
the way to check whether mitigation is necessary.
But I think in both cases it should be "_noaudit" version.
In other words, everywhere where jit, verifier or anything else
is checking caps to apply a mitigation or not we should use "_noaudit".

> Because of this we have already granted the BPF capability in
> Fedora/RHEL SELinux policy to many domains that would usually run as
> root and that use SO_ATTACH_FILTER. The logic being that they are
> legitimately using BPF + without SELinux they would be fully
> privileged (root) and they would pass that check + it seemed they
> could otherwise lose some performance due to the hardening (though I'm
> not sure now if it applies to cBPF, so this point could be moot) +
> CAP_BPF doesn't grant any excess privileges beyond this (as opposed to
> e.g. CAP_SYS_ADMIN). This is what I meant behind that commit log
> statement, though I didn't remember the details, so I didn't state it
> as clearly as I could have (my apologies).
>
> Now this same usage started triggering the new plain CAP_SYS_ADMIN
> check so I naturally assumed that changing it to bpf_capable() would
> be the most logical solution (as it would let us keep the services
> excluded from the hardening via CAP_BPF without granting the broad
> CAP_SYS_ADMIN).

I see. Sounds like you identified bpf_jit_blinding_enabled() case
and special cased it selinux. So doing bpf_capable() in JIT
would fit the existing selinux handling.

>
> Is the fact that CAP_BPF check is reachable via cBPF use unexpected
> behavior? If both cBPF and eBPF can be JIT'd and CAP_BPF is already
> being used for the "exempt from JIT hardening" semantics in one place,
> why should cBPF and eBPF be treated differently? In fact, shouldn't
> the decision to apply the Spectre mitigation also take into account
> the net.core.bpf_jit_harden sysctl even when the program is not cBPF?
>
> > 3.
> > glancing over bugzilla it seems that the issue is
> > excessive audit spam and not related to CAP_BPF and privileges.
> > If so then the fix is to use
> > ns_capable_noaudit(&init_user_ns, CAP_SYS_ADMIN)
> >
> > 4.
> > I don't understand how the patch is supposed to fix the issue.
> > iio-sensor-proxy is probably unpriv. Why would it use CAP_BPF?
> > It's using cBPF, so there is no reason for it to have CAP_BPF.
> > So capable(CAP_BPF) will fail just like capable(CAP_SYS_ADMIN),
> > but since CAP_BPF check was done first, the audit won't
> > be printed, because it's some undocumented internal selinux behavior ?
> > None of it is in the commit log :(
>
> It is not unprivileged. It runs as root and without SELinux it would
> have all capabilities allowed. If it were running without any
> capabilities, then indeed there would be no SELinux checks.
>
> > 5.
> > And finally all that looks like a selinux bug.
> > Just because something in the kernel is asking capable(CAP_SYS_ADMIN)
> > there is no need to spam users with the wrong message:
> > "SELinux is preventing iio-sensor-prox from using the 'sys_admin' capab=
ilities."
> > iio-sensor-prox is not trying to use 'sys_admin' capabilities.
> > cBPF prog will be loaded anyway, with or without BHB clearing.
>
> Well, it depends... In this case the AVC denial informs us that the
> kernel is making some decision depending on the capability and that a
> decision should be made in the policy to allow or silence the access
> vector. Even when the consequence is not a failure of the syscall, it
> still may be useful to have the denial reported, since there is a
> potential performance impact. OTOH, with CAP_SYS_ADMIN if the decision
> is to not allow it, then silencing it via a dontaudit rule would
> potentially hide other more critical CAP_SYS_ADMIN denials, so it's
> hard to decide what is better - to silence this specific case in the
> kernel vs. to let the user allow/silence the specific AV in the
> policy...

imo we should apply a general rule for using "_noaudit"
for all checks that don't end up as a denial.
There are various bpf_allow_ptr_leaks(), bpf_bypass_spec_v[14]()
checks in the verifier that should be converted to "_noaudit".
It's true that the check affects performance and users could be
interested in the end result, but if they enable mitigations they
expect the performance hit across the board, so skipping a mitigation
for a privileged process is a bonus. A prog will be tiny bit faster.
So not worth flagging anywhere.

