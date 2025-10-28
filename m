Return-Path: <bpf+bounces-72628-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A9750C16919
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 20:09:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8DB234F0441
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 19:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D73534EEF2;
	Tue, 28 Oct 2025 19:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e2bVMAn1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3CB34E761
	for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 19:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761678520; cv=none; b=gmB/NUV2Oc0IRyXE6QhLsTh6IsjDxsEe8Q6AMD+uPVuz1AtAMPWsYVk2htc2fXaXbOXDvaSJnqag7gVgIboQZpz6Dd/Mop+hQVvfNQFD2q+Be4u4UdEDPNbW+cPhh7hZnEzZY+FuGSu4w4sfc9IDIrKpBFHhktj2FBhjbrr4hZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761678520; c=relaxed/simple;
	bh=dIgAm/9ZKKrzxuJF2e29AxbfscMuu8ew8ZS//vsqUN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WtDYlZCCsLbXsyB/lW7g3Bl8gfeeQFVJF5NgEqYE8rWU76dW/g2Iy/2tt9jV5DCin5wLtdyxjvcpudEqKJLQ0DFGnNLojtTFcLBiUgH8vT/kKUsZR/qXWElH0YEbBVJkLVdJ4pAaMx1JXjLAZU4lVYT0E9fYyx+9r0i3VoykGm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e2bVMAn1; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b6d70df0851so960327766b.1
        for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 12:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761678517; x=1762283317; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ouq2ZyKQF2a7t70V3QW4o0PQ+KhEPLYB4qAyOwqIAUs=;
        b=e2bVMAn1nuYkg/zxtLYaiV+Uw8w5xrYumyJ7i8t97N3IVEid2CWQRX8r5bTyQ3uv83
         jIH6m7WDkyT9V4xLeku5p7pvG/TilYv/JnGuP4laLvpkFmfNuC3LQDz/EjdtmlR5dFLQ
         St5lyUL3Pw73egy8/AI4QAnLJx9Os2ZwqxxzW5+g3M3qUPv6XwJUholehyfInr3Y90Xu
         lLhUIyC2IYwPBTE5O5VmM6l4i0y4u7ls3oqprBo7hbsL5eq2irvUWKuxJC1i2vuhk+Oo
         x/Lfc6IrSAjeqxYOcxh+frRP0i+uQMOpdDiSXDGTbROnADlWP8hZT3Q93bwIekZ2djzx
         Moqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761678517; x=1762283317;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ouq2ZyKQF2a7t70V3QW4o0PQ+KhEPLYB4qAyOwqIAUs=;
        b=AvLjbhH1A6omEk/38/3uSp8aHULI6THq60JJYLU628MiA28R/4UsK89Dzm7AWiKsih
         S+pEg72ggyYeSEOBn6qo4StEVCSOgXcNe/jgEvTEHKHnU6mrfUvKwSbS3qMoufuN9Ure
         7OfYWGsDV/kwWVsprG+yI6jcQ/nkpo+ClwwBo9Do8BwMB+9THer/WNy1ZbojvKCwo9tC
         0mwnJGbB71FZKxPB7T1BvUaYF9LsUREPzdrKNwjh2hZXnnA4BAIGoAlYCj9oim7bATGo
         JB3tOmg1g2sdFXxoE/lE7wztx9d+jkem2hlusn26haQ0cv4Y4at9E2n243+n2fQBh2Rf
         Tkvg==
X-Forwarded-Encrypted: i=1; AJvYcCUIvfrLxfLg3uxFbGJYrou0BapSdK48zCAzTV+o3LBT7Qs81bvcyOaSTZoU1a1wxJMkcFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPiEYi1ZM3v0VhRHbWv1xiDDJa/PZUGSolf6umOu3z2CbqtEQr
	iFOuvc5LgfEZ/hIaectK7DCg2ects/wSM7iblfTix4Y3rXN6KQ8C++uUfzH54xIfQQ==
X-Gm-Gg: ASbGncvrPloydIsu0Rl/Jr1x1AFzKEuxD0n8MZj/dRzUjfzStDdvdIH3WKsfmvarbsZ
	53LEVsLgt9JslhN6Sc9OlbFCdr3vISZqbHC0MP+pVu1tbBDXHKjrNEV/USqR1dBHP9H5Zql2ySi
	JDMdOlJbCbvss+gkj3W0RcpO87BDHDAbxZ1R/H3LsuTbrLXTqvBlyq+/HKsN/A6hX11WmgTbex5
	GVN5FyS2qfJAPgwScwhOS3DYwb3v0eV0dGbVQEh/+RrOQAxKr/n0G9O488BkV2xip5AdbyxkWZo
	N7JaRE/COl8L1QgxF6YL1MaApRX6HauSejtbnrfH9ToaRp2OuxKtC4Zj/SNgt4F3ZonM+XBhaWh
	z3xXzkndHOKxiY9w6n06a3jtf2G01czBW/HARK0S7fMMXpytTqSNRNIbQfwRk/4AbzTmm2e66E8
	SoPXgxGABF21C+yL0ySaYwUYZK+PZe8T2sFCxeesNlh3GB/w==
X-Google-Smtp-Source: AGHT+IH0EmWZ0mAkWsOmRHO/iCeahQejrlAGV4ggQwB8Qy+AB7eSdEMBn0SqarA1gw/sa9wIeNpnrg==
X-Received: by 2002:a17:906:cc13:b0:b6d:5fc8:4a79 with SMTP id a640c23a62f3a-b703d554af7mr7172366b.45.1761678516968;
        Tue, 28 Oct 2025 12:08:36 -0700 (PDT)
Received: from google.com (96.211.141.34.bc.googleusercontent.com. [34.141.211.96])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d8538478fsm1174915866b.33.2025.10.28.12.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 12:08:36 -0700 (PDT)
Date: Tue, 28 Oct 2025 19:08:32 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Paul Moore <paul@paul-moore.com>, r@google.com
Cc: Song Liu <song@kernel.org>, bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org, jmorris@namei.org,
	serge@hallyn.com, casey@schaufler-ca.com, kpsingh@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	john.johansen@canonical.com, eparis@redhat.com,
	audit@vger.kernel.org
Subject: Re: [RFC bpf-next] lsm: bpf: Remove lsm_prop_bpf
Message-ID: <aQEUsA13tBKounRx@google.com>
References: <20251025001022.1707437-1-song@kernel.org>
 <CAHC9VhTb2p3DL_knRgFyDv396BwH-KhwR0cBhqLQ-KdgcA1yLw@mail.gmail.com>
 <CAPhsuW6O96aJbZptVY754tQ1-C_JtH8PwS1oZX6a1Tch7ehEkg@mail.gmail.com>
 <CAHC9VhRzjkTSUPS9odXRruAuSNbv44Atxj2sreQgcVpDu5pL-Q@mail.gmail.com>
 <aQCE0WwGlOADI5xT@google.com>
 <CAHC9VhRTN_PD9f4gNdwZFk2QjYZ3_Vc6Jfmircr2cS49CZ005A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhRTN_PD9f4gNdwZFk2QjYZ3_Vc6Jfmircr2cS49CZ005A@mail.gmail.com>

On Tue, Oct 28, 2025 at 11:18:15AM -0400, Paul Moore wrote:
> On Tue, Oct 28, 2025 at 4:54 AM Matt Bobrowski <mattbobrowski@google.com> wrote:
> > On Mon, Oct 27, 2025 at 09:50:11PM -0400, Paul Moore wrote:
> > > On Mon, Oct 27, 2025 at 6:45 PM Song Liu <song@kernel.org> wrote:
> > > > On Mon, Oct 27, 2025 at 2:14 PM Paul Moore <paul@paul-moore.com> wrote:
> > > > > On Fri, Oct 24, 2025 at 8:10 PM Song Liu <song@kernel.org> wrote:
> > > > > >
> > > > > > lsm_prop_bpf is not used in any code. Remove it.
> > > > > >
> > > > > > Signed-off-by: Song Liu <song@kernel.org>
> > > > > >
> > > > > > ---
> > > > > >
> > > > > > Or did I miss any user of it?
> > > > > > ---
> > > > > >  include/linux/lsm/bpf.h  | 16 ----------------
> > > > > >  include/linux/security.h |  2 --
> > > > > >  2 files changed, 18 deletions(-)
> > > > > >  delete mode 100644 include/linux/lsm/bpf.h
> > > > >
> > > > > You probably didn't miss any direct reference to lsm_prop_bpf, but the
> > > > > data type you really should look for when deciding on this is
> > > > > lsm_prop.  There are a number of LSM hooks that operate on a lsm_prop
> > > > > struct instead of secid tokens, and without a lsm_prop_bpf
> > > > > struct/field in the lsm_prop struct a BPF LSM will be limited compared
> > > > > to other LSMs.  Perhaps that limitation is okay, but it is something
> > > >
> > > > I think audit is the only user of lsm_prop (via audit_names and
> > > > audit_context). For BPF based LSM or audit, I don't think we need
> > > > specific lsm_prop. If anything is needed, we can implement it with
> > > > task local storage or inode local storage.
> > > >
> > > > CC audit@ and Eric Paris for more comments on audit side.
> > >
> > > You might not want to wait on a comment from Eric :)
> > >
> > > > > that should be discussed; I see you've added KP to the To/CC line, I
> > > > > would want to see an ACK from him before I merge anything removing
> > > > > lsm_prop_bpf.
> > > >
> > > > Matt Bobrowski is the co-maintainer of BPF LSM. I think we are OK
> > > > with his Reviewed-by?
> > >
> > > Good to know, I wasn't aware that Matt was also listed as a maintainer
> > > for the BPF LSM.  In that case as long as there is an ACK, not just a
> > > reviewed tag, I think that should be sufficient.
> >
> > ACK.
> >
> > > > > I haven't checked to see if the LSM hooks associated with a lsm_prop
> > > > > struct are currently allowed for a BPF LSM, but I would expect a patch
> > > > > removing the lsm_prop_bpf struct/field to also disable those LSM hooks
> > > > > for BPF LSM use.
> > > >
> > > > I don't think we need to disable anything here. When lsm_prop was
> > > > first introduced in [1], nothing was added to handle BPF.
> > >
> > > If the BPF LSM isn't going to maintain any state in the lsm_prop
> > > struct, I'd rather see the associated LSM interfaces disabled from
> > > being used in a BPF LSM just so we don't run into odd expectations in
> > > the future.  Maybe they are already disabled, I haven't checked.
> >
> > Well, it doesn't ATM, but nothing goes to say that this will change in
> > the future. Until then though, I have no objections around removing
> > lsm_prop_bpf from lsm_prop as there's currently no infrastructure in
> > place allowing a BPF LSM to properly harness lsm_prop/lsm_prop_bpf. By
> > harness, I mean literaly using lsm_prop/lsm_prop_bpf as some form of
> > context storage mechanism.
> >
> > As for the disablement of the associated interfaces, I don't feel like
> > this warranted at this point? Doing so might break some out-of-tree
> > BPF LSM implementations, specifically those that might be using these
> > associated LSM interfaces purely for instrumentation purposes at this
> > point?
> 
> Okay, let's leave things as-is for right now.  The lsm_prop struct is
> an important part of those APIs, and if there is a need for those APIs
> in a BPF LSM then we should preserve all of the API, including the
> lsm_prop component.

I'm also OK with this.

