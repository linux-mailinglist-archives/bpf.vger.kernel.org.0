Return-Path: <bpf+bounces-51457-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 230C9A34CA3
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 18:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20FF816C599
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 17:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B274923A9B4;
	Thu, 13 Feb 2025 17:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PKqet2+z"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8DA203719
	for <bpf@vger.kernel.org>; Thu, 13 Feb 2025 17:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739469523; cv=none; b=MgFxR+hLs1z3jLRQctuKC8Ug/1f/8gg6EO/bZUwRSIbAjPrFIjXPnomJJUGKYL7ZijLmR0LFSx44OxHZer0CRpaj7QAIhe84z57UulaPx2e5T/XQKBw59R7TGunfMf1FMdW30sC9K3yQkU3U/qPjeaGz9OiGekmYeQv5sl87CwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739469523; c=relaxed/simple;
	bh=iCD1EJbH1lIRLMhar/vubBdCo81+Zp/krmtY+yjRst0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UZ8AQP5Dh/HhQUOVEeP1wEuhDktBnV76oOfMEqfUxyN05bMCuGFDj3l4D4ZSeT/WVHMAAu3JCcjrEZM8ftF54eHN0ZdVdqLYeZgvm3HFXb3gqWd+jSMgqlNTRrhFhVLwSwcWg5A57bWYYK3Y9BNPWGRSI4CkDZDmGWUrc06mgkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PKqet2+z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DB16C4CEF5
	for <bpf@vger.kernel.org>; Thu, 13 Feb 2025 17:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739469522;
	bh=iCD1EJbH1lIRLMhar/vubBdCo81+Zp/krmtY+yjRst0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PKqet2+zH1t97Tb9PYh+csE5Hdb00pQkostRd2H2ctUmml1g8pGaPSCFUWnd+A+O0
	 bOMyt4JNMnU96lRXLcWJRor87iyLPNItlWNX/iX3dZG/1Uiu89IzQ4X1LtvLTcY/2O
	 7WicsQQbKQWDPk3XgXrgyZQz+ak29vrd2BaMECULVVsLSjv6pwN53nd3BBp1r2DRDD
	 pIZ75RwafjHlIFQ0r/x5yRo8Lo9WUvLtkAcvnfH1UGQHS0RIb9w282c8FYrQtCWJzD
	 mHbM4bZhXbdkWtKXrrOa0kyfEtO0tPU8X02toteJqeRdwmKZL4nLi3fjSdEH7rvIaQ
	 lI+jDpT9mbxmQ==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5ded51d31f1so1169480a12.3
        for <bpf@vger.kernel.org>; Thu, 13 Feb 2025 09:58:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW3RZLHG1XUglkp8FcI3dzQDi0VdUZvxXM/Isp+gkQfcZYVaALI8EPtVvro3etpNaZCP1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVgLbU1Dt0h7oE9Cc4ga7njWyIQc+q7hDxX1zvBcfYcfjqBtg4
	aiuJVLwgs0zSOioJeS++FcCzSA/uv/Nj12eJECCTPn3ZLaqGDNSni9vtjKLV0ErQQ//AiCrq9Hg
	HUM1/EqSSRp+kfcJSlhoRfhecl9shZUoDrbxX
X-Google-Smtp-Source: AGHT+IFHopkCd1IJRkVGtcRhcYRjj+s4dlwwFJCs/2tuVCIcDrZdxsclaMkaSiHDnOZupJK47TfVKKdiSuDfdpu5g6U=
X-Received: by 2002:a17:907:3ea2:b0:ab7:c43f:8382 with SMTP id
 a640c23a62f3a-ab7f33cab3bmr916405866b.31.1739469520915; Thu, 13 Feb 2025
 09:58:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212220433.3624297-1-jolsa@kernel.org> <CALCETrVFdAFVinbpPK+q7pSQHo3=JgGxZSPZVz-y7oaG=xP3fA@mail.gmail.com>
 <Z623ZcZj6Wsbnrhs@krava>
In-Reply-To: <Z623ZcZj6Wsbnrhs@krava>
From: Andy Lutomirski <luto@kernel.org>
Date: Thu, 13 Feb 2025 09:58:29 -0800
X-Gmail-Original-Message-ID: <CALCETrVt=N-QG3zGyPspNCF=8tA4icC75RVVe70-DvJfsh7Sww@mail.gmail.com>
X-Gm-Features: AWEUYZkKsWtgJBXXFU3xbPGAlALgrkQUHGzWNL5HcC7wERAjq_EEPmO7fwgtv2M
Message-ID: <CALCETrVt=N-QG3zGyPspNCF=8tA4icC75RVVe70-DvJfsh7Sww@mail.gmail.com>
Subject: Re: [PATCHv3 perf/core] uprobes: Harden uretprobe syscall trampoline check
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Andy Lutomirski <luto@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Andrii Nakryiko <andrii@kernel.org>, Kees Cook <kees@kernel.org>, 
	Eyal Birger <eyal.birger@gmail.com>, stable@vger.kernel.org, 
	Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-api@vger.kernel.org, x86@kernel.org, 
	bpf@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Deepak Gupta <debug@rivosinc.com>, Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 1:16=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Wed, Feb 12, 2025 at 05:37:11PM -0800, Andy Lutomirski wrote:
> > On Wed, Feb 12, 2025 at 2:04=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wr=
ote:
> > >
> > > Jann reported [1] possible issue when trampoline_check_ip returns
> > > address near the bottom of the address space that is allowed to
> > > call into the syscall if uretprobes are not set up.
> > >
> > > Though the mmap minimum address restrictions will typically prevent
> > > creating mappings there, let's make sure uretprobe syscall checks
> > > for that.
> >
> > It would be a layering violation, but we could perhaps do better here:
> >
> > > -       if (regs->ip !=3D trampoline_check_ip())
> > > +       /* Make sure the ip matches the only allowed sys_uretprobe ca=
ller. */
> > > +       if (unlikely(regs->ip !=3D trampoline_check_ip(tramp)))
> > >                 goto sigill;
> >
> > Instead of SIGILL, perhaps this should do the seccomp action?  So the
> > logic in seccomp would be (sketchily, with some real mode1 mess):
> >
> > if (is_a_real_uretprobe())
> >     skip seccomp;
>
> IIUC you want to move the address check earlier to the seccomp path..
> with the benefit that we would kill not allowed caller sooner?

The benefit would be that seccomp users that want to do something
other than killing a process (returning an error code, getting
notified, etc) could retain that functionality without the new
automatic hole being poked for uretprobe() in cases where uprobes
aren't in use or where the calling address doesn't match the uprobe
trampoline.  IOW it would reduce the scope to which we're making
seccomp behave unexpectedly.

>
> jirka
>
> >
> > where is_a_real_uretprobe() is only true if the nr and arch match
> > uretprobe *and* the address is right.
> >
> > --Andy
>

