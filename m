Return-Path: <bpf+bounces-71560-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42632BF6781
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 14:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E01D6424792
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 12:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8392B32F746;
	Tue, 21 Oct 2025 12:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZUC8K7hr"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C4B35505C
	for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 12:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761049946; cv=none; b=JkyCQmV/gpYnyuEM9YfbWCntYXhcDfRBt3PvPYFYyFogUpMfJJZ4m7ixsvifncCzNnl4TWqmEQJ+L/OMLNT/KyPRDSTulDA9DK9mVcJ7MGwAYvP7FKg8F7yXWLGWfksapmdAucqHyrfrje9AOc82KtTi77FIW990cPtyiz2K0I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761049946; c=relaxed/simple;
	bh=gJMb3RaxgZ1ClGa1ulWPL8W3xe59H6NHWiVKgH/F01w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hkNh8w+6ngfYkyhSIzqiRA+ob9kACt1zy4PiCozF0yfcKAA24i5Zw7X7uNo75oZH0nGpjLLirnFGOn56LDbUig43cgi2zFIa9/6JnDenTB8mvYl7KCmL3HvSUg2yjk3sfRskpkDRZ9cwJ+m4qHTzzmkGbkmxmcg/6cq1HXW/ECk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZUC8K7hr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761049943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JdoU62wbuXAxxH0K7ITRbODOzbdvvENaGi26Iv0pTM0=;
	b=ZUC8K7hrNBoz7QNxTUmoYLzXHwn2Jam52nl25RrP5REwuZmIHw4SJRC/Ik1zG92aO3kNDX
	fLajJ3CuhNGGt+ZTkhqr17DllUyyiUwzVdxgYWe6KkyJM+AEqm1XiH92YBJ260U3u+Obb2
	tekDeT2eXWXfmzq8PdiBHCYYa00vdkg=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-8BQE74LhPV2gADX3tVdsnQ-1; Tue, 21 Oct 2025 08:32:19 -0400
X-MC-Unique: 8BQE74LhPV2gADX3tVdsnQ-1
X-Mimecast-MFC-AGG-ID: 8BQE74LhPV2gADX3tVdsnQ_1761049939
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-26985173d8eso143330645ad.1
        for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 05:32:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761049938; x=1761654738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JdoU62wbuXAxxH0K7ITRbODOzbdvvENaGi26Iv0pTM0=;
        b=m9JzfTIn/Gl8TisTFlotIbWUcGbOwHGO4tbdPuSeugbGX8/GhDubNBOrVeprlnvJip
         kT+5/Lne3bDctic/6c68MnR16uHf9rnLcO0YTSX9xPsfhqD+mrZMqglsmj3ECJl/ompz
         AbeFj9bL7GHIk2Fo1Hw0Vgb3mwyqTsvNmAc+MMSop7P0dYJI6avgl4y2gVa5pe6rNnU5
         bxOvOU+TX35Llk1ULwIXAvchFxyXis2zb/TkV4CBFzrh9W4fm8v7Z8o4H+4N6HniUa6K
         4889/WHGrdh5LjtFso3DM5FJ6jNTHXe5n4oDmN3FDjWKB+qMjUB2wtQ1Otgi/6nWxpPV
         +wWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpEpVYm0L8W+kbgL5/UgO8a3mna2gguaB5nw8au4t3xMGd6NnUmAS7g41m4Ww6CyhnWR0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/hUn/6EePhuW8EZwwtYhd28Xx4y9Y55f0ffrpTV2ke0gFElhs
	V8coJaq/8JkDNTysWY4l0jlcgFcE8St+YiCKtiZzte2fDKy5CZzjaGM+Pl7sTzs751s9H7gnYsQ
	IYTFPZp+0WjooCc87jo541V/BEnNuZcGhe08mI92IKotWw1P2C8lFrzIcFtrDV22P8lZC0B5OwK
	pUppk8xoYI7Jt+YL1RcX6bJshLUql2
X-Gm-Gg: ASbGncvbf64oIsiF8AWpgmtS3J5s5TT7BIW8WybY/7pAJ97ExULSrSg9/TDuKPfrejH
	AcheJ4XZbBnL0qjaeLRNYUH+8SLvDrLdQkjTU097VYsJJUs/hGcmVG0oly7oT1hPLHWKHSOvWtq
	hQyPkyp6r06m8GQM89lh5UEFd+gDvhvyjWDXH9sgxB/n6/8efpO4ubXA==
X-Received: by 2002:a17:902:f542:b0:24f:dbe7:73a2 with SMTP id d9443c01a7336-290ca121a7bmr216609925ad.31.1761049938519;
        Tue, 21 Oct 2025 05:32:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOjGo2JPlA16CH9WoVMfy8R1y8uHfg1hDfztqK4uOi1qlrUtTRlrXJgHSiHRG83pPc78ni7SWqR+lje7yjY00=
X-Received: by 2002:a17:902:f542:b0:24f:dbe7:73a2 with SMTP id
 d9443c01a7336-290ca121a7bmr216609545ad.31.1761049938081; Tue, 21 Oct 2025
 05:32:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250806143105.915748-1-omosnace@redhat.com> <aJP+/1VGbe1EcgKz@mail.hallyn.com>
 <aJaPQZqDIcT17aAU@mail.hallyn.com> <CAADnVQKY0z1RAJdAmRGbLWZxrJPG6Kawe6_qQHjoVM7Xz8CfuA@mail.gmail.com>
 <CAFqZXNtAfzFJtL3gG7ViEFOWoAE2VNrvCOA5DxqMmWt7z6g5Yg@mail.gmail.com> <CAADnVQL7C6hM6vwztSdq_U4b0u8p-0aVwkaKDAxd53q_+8G1bw@mail.gmail.com>
In-Reply-To: <CAADnVQL7C6hM6vwztSdq_U4b0u8p-0aVwkaKDAxd53q_+8G1bw@mail.gmail.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Tue, 21 Oct 2025 14:32:06 +0200
X-Gm-Features: AS18NWDtlLiRlYTkW7OcLz395NuzOZ99QUZ8rPCjWvXNNpMvBxp3958XQNO852E
Message-ID: <CAFqZXNuNDSrCYqOUiAY4B2BTcCbte+cR822K7zFjxPyko53Wbg@mail.gmail.com>
Subject: Re: [PATCH] x86/bpf: use bpf_capable() instead of capable(CAP_SYS_ADMIN)
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>, daniel.sneddon@linux.intel.com, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, alexandre.chartre@oracle.com, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>, 
	selinux@vger.kernel.org, LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 7:37=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Aug 13, 2025 at 2:49=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.=
com> wrote:
> >
> > On Sat, Aug 9, 2025 at 2:46=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Fri, Aug 8, 2025 at 4:59=E2=80=AFPM Serge E. Hallyn <serge@hallyn.=
com> wrote:
> > > >
> > > > On Wed, Aug 06, 2025 at 08:18:55PM -0500, Serge E. Hallyn wrote:
> > > > > On Wed, Aug 06, 2025 at 04:31:05PM +0200, Ondrej Mosnacek wrote:
> > > > > > Don't check against the overloaded CAP_SYS_ADMINin do_jit(), bu=
t instead
> > > > > > use bpf_capable(), which checks against the more granular CAP_B=
PF first.
> > > > > > Going straight to CAP_SYS_ADMIN may cause unnecessary audit log=
 spam
> > > > > > under SELinux, as privileged domains using BPF would usually on=
ly be
> > > > > > allowed CAP_BPF and not CAP_SYS_ADMIN.
> > > > > >
> > > > > > Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D2369326
> > > > > > Fixes: d4e89d212d40 ("x86/bpf: Call branch history clearing seq=
uence on exit")
> > > > > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > > >
> > > > > So this seems correct, *provided* that we consider it within the =
purview of
> > > > > CAP_BPF to be able to avoid clearing the branch history buffer.
> > >
> > > true, but...
> > >
> > > > >
> > > > > I suspect that's the case, but it might warrant discussion.
> > > > >
> > > > > Reviewed-by: Serge Hallyn <serge@hallyn.com>
> > > >
> > > > (BTW, I'm assuming this will get pulled into a BPF tree or somethin=
g, and
> > > > doesn't need to go into the capabilities tree.  Let me know if that=
's wrong)
> > >
> > > Right.
> > > scripts/get_maintainer.pl arch/x86/net/bpf_jit_comp.c
> > > is your friend.
> > >
> > > Pls cc author-s of the commit in question in the future.
> > > Adding them now.
> > >
> > > > > > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit=
_comp.c
> > > > > > index 15672cb926fc1..2a825e5745ca1 100644
> > > > > > --- a/arch/x86/net/bpf_jit_comp.c
> > > > > > +++ b/arch/x86/net/bpf_jit_comp.c
> > > > > > @@ -2591,8 +2591,7 @@ emit_jmp:
> > > > > >                     seen_exit =3D true;
> > > > > >                     /* Update cleanup_addr */
> > > > > >                     ctx->cleanup_addr =3D proglen;
> > > > > > -                   if (bpf_prog_was_classic(bpf_prog) &&
> > > > > > -                       !capable(CAP_SYS_ADMIN)) {
> > > > > > +                   if (bpf_prog_was_classic(bpf_prog) && !bpf_=
capable()) {
> > >
> > > This looks wrong for several reasons.
> > >
> > > 1.
> > > bpf_capable() and CAP_BPF in general applies to eBPF only.
> > > There is no precedent so far to do anything differently
> > > for cBPF when CAP_BPF is present.
> >
> > That's not entirely true, see below.
> >
> > > 2.
> > > commit log states that
> > > "privileged domains using BPF would usually only be allowed CAP_BPF
> > > and not CAP_SYS_ADMIN"
> > > which is true for eBPF only, since cBPF is always allowed for
> > > all unpriv users.
> > > Start chrome browser and you get cBPF loaded.
> >
> > Processes using cBPF (via SO_ATTACH_FILTER) already can trigger a
> > CAP_BPF check - when the net.core.bpf_jit_harden sysctl is set to 1,
> > then the sequence sk_attach_filter() -> __get_filter() ->
> > bpf_prog_alloc() -> bpf_prog_alloc_no_stats() ->
> > bpf_jit_blinding_enabled() -> bpf_token_capable() happens for the same
> > iio-sensor-proxy syscall as the one that hits the CAP_SYS_ADMIN check.
>
> Agree that it's a similar case and we should standardize on
> the way to check whether mitigation is necessary.
> But I think in both cases it should be "_noaudit" version.
> In other words, everywhere where jit, verifier or anything else
> is checking caps to apply a mitigation or not we should use "_noaudit".
>
> > Because of this we have already granted the BPF capability in
> > Fedora/RHEL SELinux policy to many domains that would usually run as
> > root and that use SO_ATTACH_FILTER. The logic being that they are
> > legitimately using BPF + without SELinux they would be fully
> > privileged (root) and they would pass that check + it seemed they
> > could otherwise lose some performance due to the hardening (though I'm
> > not sure now if it applies to cBPF, so this point could be moot) +
> > CAP_BPF doesn't grant any excess privileges beyond this (as opposed to
> > e.g. CAP_SYS_ADMIN). This is what I meant behind that commit log
> > statement, though I didn't remember the details, so I didn't state it
> > as clearly as I could have (my apologies).
> >
> > Now this same usage started triggering the new plain CAP_SYS_ADMIN
> > check so I naturally assumed that changing it to bpf_capable() would
> > be the most logical solution (as it would let us keep the services
> > excluded from the hardening via CAP_BPF without granting the broad
> > CAP_SYS_ADMIN).
>
> I see. Sounds like you identified bpf_jit_blinding_enabled() case
> and special cased it selinux. So doing bpf_capable() in JIT
> would fit the existing selinux handling.
>
> >
> > Is the fact that CAP_BPF check is reachable via cBPF use unexpected
> > behavior? If both cBPF and eBPF can be JIT'd and CAP_BPF is already
> > being used for the "exempt from JIT hardening" semantics in one place,
> > why should cBPF and eBPF be treated differently? In fact, shouldn't
> > the decision to apply the Spectre mitigation also take into account
> > the net.core.bpf_jit_harden sysctl even when the program is not cBPF?
> >
> > > 3.
> > > glancing over bugzilla it seems that the issue is
> > > excessive audit spam and not related to CAP_BPF and privileges.
> > > If so then the fix is to use
> > > ns_capable_noaudit(&init_user_ns, CAP_SYS_ADMIN)
> > >
> > > 4.
> > > I don't understand how the patch is supposed to fix the issue.
> > > iio-sensor-proxy is probably unpriv. Why would it use CAP_BPF?
> > > It's using cBPF, so there is no reason for it to have CAP_BPF.
> > > So capable(CAP_BPF) will fail just like capable(CAP_SYS_ADMIN),
> > > but since CAP_BPF check was done first, the audit won't
> > > be printed, because it's some undocumented internal selinux behavior =
?
> > > None of it is in the commit log :(
> >
> > It is not unprivileged. It runs as root and without SELinux it would
> > have all capabilities allowed. If it were running without any
> > capabilities, then indeed there would be no SELinux checks.
> >
> > > 5.
> > > And finally all that looks like a selinux bug.
> > > Just because something in the kernel is asking capable(CAP_SYS_ADMIN)
> > > there is no need to spam users with the wrong message:
> > > "SELinux is preventing iio-sensor-prox from using the 'sys_admin' cap=
abilities."
> > > iio-sensor-prox is not trying to use 'sys_admin' capabilities.
> > > cBPF prog will be loaded anyway, with or without BHB clearing.
> >
> > Well, it depends... In this case the AVC denial informs us that the
> > kernel is making some decision depending on the capability and that a
> > decision should be made in the policy to allow or silence the access
> > vector. Even when the consequence is not a failure of the syscall, it
> > still may be useful to have the denial reported, since there is a
> > potential performance impact. OTOH, with CAP_SYS_ADMIN if the decision
> > is to not allow it, then silencing it via a dontaudit rule would
> > potentially hide other more critical CAP_SYS_ADMIN denials, so it's
> > hard to decide what is better - to silence this specific case in the
> > kernel vs. to let the user allow/silence the specific AV in the
> > policy...
>
> imo we should apply a general rule for using "_noaudit"
> for all checks that don't end up as a denial.
> There are various bpf_allow_ptr_leaks(), bpf_bypass_spec_v[14]()
> checks in the verifier that should be converted to "_noaudit".
> It's true that the check affects performance and users could be
> interested in the end result, but if they enable mitigations they
> expect the performance hit across the board, so skipping a mitigation
> for a privileged process is a bonus. A prog will be tiny bit faster.
> So not worth flagging anywhere.

Ok, so I have sent a v2 that switches to ns_capable_noaudit() instead:
https://lore.kernel.org/selinux/20251021122758.2659513-1-omosnace@redhat.co=
m/

--
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.


