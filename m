Return-Path: <bpf+bounces-66383-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A957BB33E42
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 13:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B66D7B1B57
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 11:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1C62EACF0;
	Mon, 25 Aug 2025 11:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YwqShMBX"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F85172602
	for <bpf@vger.kernel.org>; Mon, 25 Aug 2025 11:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756122046; cv=none; b=bhYjYzxGo9LAMn4RUMN5Sf6ubVKMndcXoWMrG/pW/ptQFxsA/Fqhqz7CXgRYeA3om9vefcdsjKhhf9iVt82beUU7UuyTOFb9yqIQgUIcNE3JAZqWZqgDx8DKs6aG6WQNbihNmAGWfUeO/2iY+6196kWynJWv7Fh9D77lkQjB3Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756122046; c=relaxed/simple;
	bh=XmOeOd1pViwutI8wtiDdDhgWiGhbRMXdQ9LlGz9YIc0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nLNRCOkyTnoWQ59AnmYT31i4o8SmiKP3G4xX0jLWQJnxCBp60I4nbr6sBls8QqZBxDwm3dMCxYuyKs/+CoinKAw4y2j8/48aLx+BvItqPpyTf9CshSx0CSWUGwpQWEhb260Biu4CwnxCaXhdZofGsU1hpv/hwmncMUUCOPW+01U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YwqShMBX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756122043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i1tL7FInsElGn6Q+dpU9DZrUipU/+oqNog7jlscNK44=;
	b=YwqShMBX9jA+mf8SZCUuPsKAezr/h6m/wxFUgNc01ysRSWnd9K8Szh82KkN/4UNIBm+V+u
	l1zETnTTA60+VA9lKsxcqfTROfOg0d61CiRY7clzP/b6o6yw7trt99TLNeX9f9aofpLoA1
	jgjjy6Z5Lq6eEnI3KCZwgm2zG9qKpV4=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-676-WySMli2kPdOYNbnZSFfvdA-1; Mon, 25 Aug 2025 07:40:42 -0400
X-MC-Unique: WySMli2kPdOYNbnZSFfvdA-1
X-Mimecast-MFC-AGG-ID: WySMli2kPdOYNbnZSFfvdA_1756122041
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-246cf6af2f4so19851365ad.1
        for <bpf@vger.kernel.org>; Mon, 25 Aug 2025 04:40:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756122041; x=1756726841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i1tL7FInsElGn6Q+dpU9DZrUipU/+oqNog7jlscNK44=;
        b=PPgLpVxb6jUIu9BQ4RNmhSQIEseRh8jhXjMREdcuLoo+U2S/bFO6IJmqocyvE8zA/e
         iieZBv7vZxCdcA35+18IUtfsdCXK/PT24M1g+wT/DnrmKuwXwnRFHRscIupi7JZRP/BF
         Q5CW+eDXM2BKBlvK0uH8hqYFAaG0EOeS+nh2Vlsb7jEXoqvrJt3FR7RKNrrUu1jf2sRO
         QopcGBygAzcXuUPopjA70fvdIN0vmLW37D052fMpCvfl60Nu6bLuLZwXN6LT1RSujIrb
         3E8FR4DLJnWqHJWLW0VTKCPHGHDUDYTaMFpryR+xy7VhtWD5XvAb1cqhj8FRJUI5p1yx
         15Bg==
X-Forwarded-Encrypted: i=1; AJvYcCUkemE5bOzH5DppW7vW+LiWPjOG8tNPLQ0/9y43VPCTqWyr9VBGUytcgtVQfigUwjA9eIc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLNBzQ84sRVahXauvoaPJL/mWyvL+Vh3e+00l88eGCY1tuRZY6
	qwEM1KX9wVxxfw5+wWHjm2GuPv543mWYHpvnNcB/JHB5pqFDoPBORsXMxEnMAuvhLqG/CKqDHkt
	kh7TPZcAPjH3WRKg3BbuD0d7DzG+koiaJosvZRD7777j7xflxvWYfnIXUa+RK8ne/OhjSExRAC7
	yiBXsaFLCJFeGsXE6MCTjznd44V+DN
X-Gm-Gg: ASbGnctr6mBYGinZUxeEYN/pLw+5ZKI31L/camPqAC1o/nWpjId7vVkNKdT653yblHq
	c+HelTTGvFzH6pUDSY+c/0+V3XGv29hI5Vu5pg8WE1q6I1RMh98KrXkfQsygHf857mWy/SHp4s0
	huPJ/XMALrovrR4UByEhwwlO7ksKSlWpTL6tzuK+Na7RvMPKDz0+nbOw==
X-Received: by 2002:a17:903:187:b0:235:ec11:f0ee with SMTP id d9443c01a7336-2462eded8bbmr149438075ad.14.1756122040926;
        Mon, 25 Aug 2025 04:40:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLCziNmCrrf8tECcKtIH9dzFLSdIyn7zlRi1/szsUtdVvup0dJYiATJcecD2+pMYNgqYeGYRFvetRjSq8AhlA=
X-Received: by 2002:a17:903:187:b0:235:ec11:f0ee with SMTP id
 d9443c01a7336-2462eded8bbmr149437725ad.14.1756122040456; Mon, 25 Aug 2025
 04:40:40 -0700 (PDT)
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
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Mon, 25 Aug 2025 13:40:29 +0200
X-Gm-Features: Ac12FXywkjbpILypI5RWnFIND68dT-H5iuSShUyGnrn6lJQ2zbZhJJjba7Q-KBA
Message-ID: <CAFqZXNukE9n6MN_kQ+Q2c5fFaMt3aO-Z8km-u_RSpiJCr+eb2A@mail.gmail.com>
Subject: Re: [PATCH] x86/bpf: use bpf_capable() instead of capable(CAP_SYS_ADMIN)
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>, daniel.sneddon@linux.intel.com, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, alexandre.chartre@oracle.com, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>, 
	selinux@vger.kernel.org, LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 11:49=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.c=
om> wrote:
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

Bumping this, as I'd like to hear some feedback to the points above.

Thanks,

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.


