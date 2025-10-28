Return-Path: <bpf+bounces-72504-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D59C13A70
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 09:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 727285E0BCE
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 08:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DB92D7DF4;
	Tue, 28 Oct 2025 08:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zFjti9dY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC5A1F4CB3
	for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 08:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761641689; cv=none; b=NFX8wUAjRh0S0FhKCXXPjJv0vkulHcJeLf9vqlECnIymgvVOUIdrqUCuRjQr5xzNLqI7xl5cLgmSTZHwXXxQmOF87ZGw9LcBLqHJdE1aYV3wFCw66DTslErzjdmARtVeIYN9DDsLFs+f0jgksvGyX1qgkonbCuT6ag15BtnAYh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761641689; c=relaxed/simple;
	bh=QeYx/eFxq6lR4+YZ/DP4VSYkYOnQaUkr9HNt8KAt9V0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JtMpAmnEA4EVprau0yawIkj49+2iFLSvsIakBqog1Gz4KeOiAJjz4ue3xu4A6wEAlkV+EKgqurOj35HakOkHtqOWhBFRTvrJFBLIvgRdi++ToKh0ejgn5QiuZeLSdz49C/FLIo8NKFq1rToR+LX5VdEsbGdw/ErMnX6rwnGiTt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zFjti9dY; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-62fc0b7bf62so2103692a12.2
        for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 01:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761641686; x=1762246486; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zzTgGU8Fc6YeRB9n5ReEGGKnPVnwGcFzwEAmeAoo+6o=;
        b=zFjti9dYn8J4QTHiGtAwOeL3CC2dHxTOYfHv2mGg16qOaBgpifgevyxjJ9qLffs/Bg
         Y6s9EcXQvSIwCbpoA74vD+11teZ4P7G8wHUzx+2Ev4Po6xjcrs/4ErY1qV+tjJ9Gj/cG
         G4PKWLQU+aKQ3PD2CS/HYXP2XtlJEscOg31kXiPCT1YDCBBJKwNxrPAJQ5rKvZfBiqgR
         xjXrNg6334IkzeQd+fXVOKg1LA3jTrRqRONMoeOhn+0WdRLEWbFO125kaHW0dyht75II
         cWpezezAJxWAP79XOxPszpmw5nFbWjjmkaUy/g/g4zc5olxRLyPcsEnzN/NqwtO11Psw
         ygMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761641686; x=1762246486;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zzTgGU8Fc6YeRB9n5ReEGGKnPVnwGcFzwEAmeAoo+6o=;
        b=v9PJfVpKYt8Dci1Mz+im8Tl/HSPMi4SWxnBzzGBuf22PKczdna5MXUYKx7jrRVYQrf
         uVoBkVW8HVQ+yb7dXTTK9DHFhX5w8JyA0zh4nXKK/lYINmMA4Abfst2VqRyBfdcuM2F0
         WOC8mzH7xjqQFKIq+eND4v5MrcZFzejB0mKqiOU0W0JALtaETUQJMaPRoZplvQd8cjM0
         LoaEPRqOfAS+Gv7b/FjWc13q5Y7bok/6PrRZSo4ykJsIqwXw9T3FG4z0/jTpiGSsPj/Z
         4bBICkNEf+LW/MJ9ffYVrpPM+RSWlFmLPgqm0BV4XqWnhKBsDKxzIcTi9epmOVgusrKv
         6ppA==
X-Forwarded-Encrypted: i=1; AJvYcCUUabA4ifGLm0cGAvPI4eTbu5ZS9RSzrbHxjQMJFbKlGsXL63cwBynwaCK+F6GyTU6FpK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCVqMqKSyjRgBog6SiDqP99maExvkx3s98BssP6JVyjXY8AF5C
	ESAkHpHUOcnN4lt8RCp35HytompNMbADToQEzD3LuxcJfXnHs4yzl5CSadYLNE8Kxw==
X-Gm-Gg: ASbGncu3Tycx+XidVi6rUjFJbZBrKJtDNdCuGCspbq3E3TdwVwXfnqE0PNTL8gj1E0b
	lW2Mu9Y01e0bDC9dmPsrqX7IhGXs78fhRsW66LkjPfyZM48unjFVhvrRb5Ninba421P+NWJPFkr
	2hyeS+nVlsZkKywT5UXhM+xuDRlWxC2QjkaKk0yyD6HNeVdljYBPhFdOSuNS6C3Q4vBM9jYP4Hs
	ZvACMptW32qlkCMf8w+mjKZ1kHMWJDW47L1SeGjcYtiTBanYLFvjo6ebErPU7ULCaUHqLZ1weGL
	KRJEqjsJnRTvq7PrhNrSjUspSTzv2KsGo5lz8Mr3348+kRqscyTWyo9IQpO5K/q5LWk7QtU27yh
	y9s02Y9CDQK1gStx1wiHlhrxSBVeLh0DQGBHxPzvAeFimJbz2iopKxvjNFJPq+PNm4HxfEyAoMC
	WgtksuLHRnbbtkybEOS4UR7sdDkTTtgackxbutxEa5/jLvRo5RWd2et97C
X-Google-Smtp-Source: AGHT+IHPxqEW49Ey0+zH+V6NlQOHGZMBbZmRTn/CRr7R/OqlH3S491uTZTrMlBZvDnudHLtpe1IUUQ==
X-Received: by 2002:a05:6402:3582:b0:639:fd12:65a2 with SMTP id 4fb4d7f45d1cf-63ed84965d2mr2330090a12.15.1761641686193;
        Tue, 28 Oct 2025 01:54:46 -0700 (PDT)
Received: from google.com (96.211.141.34.bc.googleusercontent.com. [34.141.211.96])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e7ef96105sm8342279a12.19.2025.10.28.01.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 01:54:45 -0700 (PDT)
Date: Tue, 28 Oct 2025 08:54:41 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Song Liu <song@kernel.org>, bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org, jmorris@namei.org,
	serge@hallyn.com, casey@schaufler-ca.com, kpsingh@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	john.johansen@canonical.com, eparis@redhat.com,
	audit@vger.kernel.org
Subject: Re: [RFC bpf-next] lsm: bpf: Remove lsm_prop_bpf
Message-ID: <aQCE0WwGlOADI5xT@google.com>
References: <20251025001022.1707437-1-song@kernel.org>
 <CAHC9VhTb2p3DL_knRgFyDv396BwH-KhwR0cBhqLQ-KdgcA1yLw@mail.gmail.com>
 <CAPhsuW6O96aJbZptVY754tQ1-C_JtH8PwS1oZX6a1Tch7ehEkg@mail.gmail.com>
 <CAHC9VhRzjkTSUPS9odXRruAuSNbv44Atxj2sreQgcVpDu5pL-Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhRzjkTSUPS9odXRruAuSNbv44Atxj2sreQgcVpDu5pL-Q@mail.gmail.com>

On Mon, Oct 27, 2025 at 09:50:11PM -0400, Paul Moore wrote:
> On Mon, Oct 27, 2025 at 6:45 PM Song Liu <song@kernel.org> wrote:
> > On Mon, Oct 27, 2025 at 2:14 PM Paul Moore <paul@paul-moore.com> wrote:
> > > On Fri, Oct 24, 2025 at 8:10 PM Song Liu <song@kernel.org> wrote:
> > > >
> > > > lsm_prop_bpf is not used in any code. Remove it.
> > > >
> > > > Signed-off-by: Song Liu <song@kernel.org>
> > > >
> > > > ---
> > > >
> > > > Or did I miss any user of it?
> > > > ---
> > > >  include/linux/lsm/bpf.h  | 16 ----------------
> > > >  include/linux/security.h |  2 --
> > > >  2 files changed, 18 deletions(-)
> > > >  delete mode 100644 include/linux/lsm/bpf.h
> > >
> > > You probably didn't miss any direct reference to lsm_prop_bpf, but the
> > > data type you really should look for when deciding on this is
> > > lsm_prop.  There are a number of LSM hooks that operate on a lsm_prop
> > > struct instead of secid tokens, and without a lsm_prop_bpf
> > > struct/field in the lsm_prop struct a BPF LSM will be limited compared
> > > to other LSMs.  Perhaps that limitation is okay, but it is something
> >
> > I think audit is the only user of lsm_prop (via audit_names and
> > audit_context). For BPF based LSM or audit, I don't think we need
> > specific lsm_prop. If anything is needed, we can implement it with
> > task local storage or inode local storage.
> >
> > CC audit@ and Eric Paris for more comments on audit side.
> 
> You might not want to wait on a comment from Eric :)
> 
> > > that should be discussed; I see you've added KP to the To/CC line, I
> > > would want to see an ACK from him before I merge anything removing
> > > lsm_prop_bpf.
> >
> > Matt Bobrowski is the co-maintainer of BPF LSM. I think we are OK
> > with his Reviewed-by?
> 
> Good to know, I wasn't aware that Matt was also listed as a maintainer
> for the BPF LSM.  In that case as long as there is an ACK, not just a
> reviewed tag, I think that should be sufficient.

ACK.

> > > I haven't checked to see if the LSM hooks associated with a lsm_prop
> > > struct are currently allowed for a BPF LSM, but I would expect a patch
> > > removing the lsm_prop_bpf struct/field to also disable those LSM hooks
> > > for BPF LSM use.
> >
> > I don't think we need to disable anything here. When lsm_prop was
> > first introduced in [1], nothing was added to handle BPF.
> 
> If the BPF LSM isn't going to maintain any state in the lsm_prop
> struct, I'd rather see the associated LSM interfaces disabled from
> being used in a BPF LSM just so we don't run into odd expectations in
> the future.  Maybe they are already disabled, I haven't checked.

Well, it doesn't ATM, but nothing goes to say that this will change in
the future. Until then though, I have no objections around removing
lsm_prop_bpf from lsm_prop as there's currently no infrastructure in
place allowing a BPF LSM to properly harness lsm_prop/lsm_prop_bpf. By
harness, I mean literaly using lsm_prop/lsm_prop_bpf as some form of
context storage mechanism.

As for the disablement of the associated interfaces, I don't feel like
this warranted at this point? Doing so might break some out-of-tree
BPF LSM implementations, specifically those that might be using these
associated LSM interfaces purely for instrumentation purposes at this
point?

