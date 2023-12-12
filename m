Return-Path: <bpf+bounces-17596-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 288B880F9DC
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 23:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C0D91C20DF1
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 22:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAAEC64CD7;
	Tue, 12 Dec 2023 22:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="R7H93iU9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="KrPj9GhH";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="X2TmY1Sc"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59667B3
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 14:01:19 -0800 (PST)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 17A53C403988
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 14:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1702418479; bh=TRu64R+kQqEcScWktKrWr04EC1YD64MNqem5M7YdmCE=;
	h=To:Cc:References:In-Reply-To:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=R7H93iU9MU0/sUZH6M2ABzv6EuER7lIEZKVLcBKYr5rpgwKjqKxIN2O+7uFiaND6I
	 9H6NmNYfU9ZX+vu112dK/CIujL9K6zv6ClISLeDWtuoTPU3zkWpQa/YeJCUUwEREku
	 2jkZXZM4B+o/Gu8fwYMlaQt0AEDNRQewKLgS++7Q=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id E6296C3EFF30;
 Tue, 12 Dec 2023 14:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1702418478; bh=TRu64R+kQqEcScWktKrWr04EC1YD64MNqem5M7YdmCE=;
 h=From:To:Cc:References:In-Reply-To:Date:Subject:List-Id:
 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
 b=KrPj9GhHOOn+xidCdzxZCHq4D7eEI0AadoxOUydn5RsadWLOZ0mTSQ8PzXgVLdN25
 nJFmmp/nTg3o72CH+lxBQUYyBR+OoJ16ZPdb3jGOKFLz8655WNXnlyXMkgwmHxvxyo
 skcsZ1WWr8Mk0hdPTcxh2mcZB3gQuyAugSSCeWow=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 5E6EAC3EFF30
 for <bpf@ietfa.amsl.com>; Tue, 12 Dec 2023 14:01:18 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -1.855
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=googlemail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tfsTmkJvJNDp for <bpf@ietfa.amsl.com>;
 Tue, 12 Dec 2023 14:01:13 -0800 (PST)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id D4A6CC23961F
 for <bpf@ietf.org>; Tue, 12 Dec 2023 14:01:13 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-35d6c5f9579so20220355ab.0
 for <bpf@ietf.org>; Tue, 12 Dec 2023 14:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1702418473; x=1703023273; darn=ietf.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=fcFnqm4eht7UnjBnTd02U10NU6D8Ng4ns4IuB50ron4=;
 b=X2TmY1SckFrgfEwzy65EvmWcqsl1asdkMrlpY6d9iwWtqm9JOZcPq5N6SPq89fE7Vx
 6NdboWIlI6FARv6kqbxmlD7UF+sgKtegKmoj3vss0G02qOejGINTHJvnDMardxrCrlTn
 QVAPnrJMA2ymXeK0zlOezhavZTMN1NpGUA1XVTkzaFJAVjuTfHJ5OePCu1vKEyhe6q0Y
 aDKYby8Z5X5gP5FXcaVN/EciuzeoMDBeFnwIkYqnc+pPgkaruSJIhlQh7VjavKovatnf
 c09Dwhmacww7wYzeFrhGP/UfI8cyPD4t5HHcihqMKdcERVE4malUyI8vqQkjwSLNJUEp
 B6LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702418473; x=1703023273;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fcFnqm4eht7UnjBnTd02U10NU6D8Ng4ns4IuB50ron4=;
 b=G6GHiwnd7EiNPmWH5xEgF5B4nkcgLrckfrJa1kusbAc89cfvhgEA2ga7+F5E0nZJrI
 00CgB8JA/cGMuCVMfLVdcohG1zkOit8InWN/fhYi1plZYaQqGHrKmvCx4H8h0CoHQ1v9
 J5j0s+8JRZA0HKTA7cGaiHhrNE0RIfrbYxMJ13UNIaF0B6jWYpAGijIfQMU/0dozJGgQ
 B6JigQ8PZQb/8RlIUl+eyPXUvlcEuyN0iSIC0oCUrBzGGlDTSUvgK8i61q6KOIT4ZGCh
 sdxm/IwSvambAPDR5C9qMtgcJiCfpKmxWX4F+vXicL18dYv3wyXO05I3nj4OurGqrSEb
 bZzQ==
X-Gm-Message-State: AOJu0YzmfysCuqOfMnaT5HUGt/mVD2VWQXPKCcz+2gMflicysByE2X9p
 XaVLx9l4r5FZxud4CusjwTRRaNHQUp0qqQ==
X-Google-Smtp-Source: AGHT+IETdInYAU5TjZP8ulM8KOrP7uZ5DbSxD8j8qnXouHgH7rpcdqZDOkssFWNSVdCrjK3V5lAGNg==
X-Received: by 2002:a92:c24d:0:b0:35d:637e:c3d2 with SMTP id
 k13-20020a92c24d000000b0035d637ec3d2mr8848734ilo.20.1702418472675; 
 Tue, 12 Dec 2023 14:01:12 -0800 (PST)
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net.
 [67.170.74.237]) by smtp.gmail.com with ESMTPSA id
 g192-20020a636bc9000000b0058901200bbbsm8700388pgc.40.2023.12.12.14.01.11
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 12 Dec 2023 14:01:12 -0800 (PST)
X-Google-Original-From: <dthaler1968@gmail.com>
To: "'David Vernet'" <void@manifault.com>
Cc: <bpf@ietf.org>,
	"'bpf'" <bpf@vger.kernel.org>
References: <20231127201817.GB5421@maniforge>
 <072101da2558$fe5f5020$fb1df060$@gmail.com>
 <20231207215152.GA168514@maniforge>
 <CAADnVQ+Mhe6ean6J3vH1ugTyrgWNxupLoFfwKu6-U=3R8i1TNQ@mail.gmail.com>
 <20231212214532.GB1222@maniforge>
In-Reply-To: <20231212214532.GB1222@maniforge>
Date: Tue, 12 Dec 2023 14:01:09 -0800
Message-ID: <157b01da2d46$b7453e20$25cfba60$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKaT4/11CAPHwhRd3AqhQv3W/OzVwEwRWUPAqgd9mMCsPCsZAM3MzMrrtfntJA=
Content-Language: en-us
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/qrDVQkef19BHdVMKw9jSJWjQd9Q>
Subject: Re: [Bpf] BPF ISA conformance groups
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>
X-Original-From: dthaler1968@googlemail.com
From: dthaler1968=40googlemail.com@dmarc.ietf.org

David Vernet <void@manifault.com> wrote: 
[...]
> > > > A given runtime platform would be compliant to some set of the
> > > > following conformance groups:
> > > >
> > > > 1. "basic": all instructions not covered by another group below.
> > > > 2. "atomic": all Atomic operations.  I think Christoph argued for
> > > > this one in the meeting.
> > > > 3. "divide": all division and modulo operations.  Alexei said in
> > > > the meeting that he'd heard demand for this one.
> > > > 4. "legacy": all legacy packet access instructions (deprecated).
> > > > 5. "map": 64-bit immediate instructions that deal with map fds or
> > > > map indices.
> > > > 6. "code": 64-bit immediate instruction that has a "code pointer" type.
> > > > 7. "func": program-local functions.
> > >
> > > I thought for a while about whether this should be part of the basic
> > > conformance group, and talked through it with Jakub Kicinski. I do
> > > think it makes sense to keep it separate like this. For e.g. devices
> > > with Harvard architectures, it could get quite non-trivial for the
> > > verifier to determine whether accesses to arguments stored in
> > > special register are safe. Definitely not impossible, and overall
> > > very useful to support this, but in order to ease vendor adoption
> > > it's probably best to keep this separate.
> > >
> > > > Things that I *think* don't need a separate conformance group (can
> > > > just be in "basic") include:
> > > > a. Call helper function by address or BTF ID.  A runtime that
> > > > doesn't support these simply won't expose any
> > > >     such helper functions to BPF programs.
> > > > b. Platform variable instructions (dst = var_addr(imm)).  A
> > > > runtime that doesn't support this simply won't
> > > >     expose any platform variables to BPF programs.
> > > >
> > > > Comments? (Let the bikeshedding begin...)
> > >
> > > This list seems logical to me,
> >
> > I think we should do just two categories: legacy and the rest, since
> > any scheme will be flawed and infinite bikeshedding will ensue.
> 
> If we do this, then aren't we forcing every vendor that adds BPF support to
> support every single instruction if they want to be compliant?

Right, indeed I think it could hinder BPF adoption if we required every
single instruction in any hardware offload card that wanted to add BPF support.

> > For example, let's take a look at #2 atomic...
> > Should it include or exclude atomic_add insn ? It was added at the
> > very beginning of BPF ISA and was used from day one.
> > Without it it's impossible to count stats. The typical network or
> > tracing use case needs to count events and one cannot do it without
> > atomic increment. Eventually per-cpu maps were added as an alternative.
> > I suspect any platform that supports #1 basic insn without atomic_add
> > will not be practically useful.
> > Should atomic_add be a part of "basic" then? But it's atomic.
> > Then what about atomic_fetch_add insn? It's pretty close semantically.
> > Part of atomic or part of basic?
> 
> I think it's reasonable to expect that if you require an atomic add, that you
> may also require the other atomic instructions as well and that it would be
> logical to group them together, yes. I believe that Netronome supports all of
> the atomic instructions, as one example. If you're providing a BPF runtime in
> an environment where atomic adds are required, I think it stands to reason
> that you should probably support the other atomics as well, no?

I agree.

> > Another example, #3 divide. bpf cpu=v1 ISA only has unsigned div/mod.
> > Eventually we added a signed version. Integer division is one of the
> > slowest operations in a HW. Different cpus have different flavors of
> > them 64/32 64/64 32/32, etc. All with different quirks.
> > cpu=v1 had modulo insn because in tracing one often needs to do it to
> > select a slot in a table, but in networking there is rarely a need.
> > So bpf offload into netronome HW doesn't support it (iirc).
> 
> Correct, my understanding is that BPF offload in netronome supports neither
> division nor modulo.

In my opinion, this is a valid technical reason to put them into a separate
conformance group, to allow hardware offload cards to support BPF without
requiring division/modulo which they might not have space or other budget for.

> > Should div/mod signed/unsigned be a part of basic? or separate?
> > Only 32 or 64 bit?
> >
> > Hence my point: legacy and the rest (as of cpu=v4) are the only two
> > categories we should have in _this_ version of the standard.
> > Rest assured we will add new insn in the coming months.
> > I suggest we figure out conformance groups for future insns at that time.
> > That would be the time to argue and actually extract value out of
> discussion.
> > Retroactive bike shedding is a bike shedding and nothing else.
> 
> I wouldn't personally categorize this as retroactive _bikeshedding_.

_ bikeshedding_ typically refers to spending a disproportionate amount of
time on trivial matters.  The discussion here isn't about a trivial matter,
in my view, it's about encouraging adoption of BPF in standardized ways
that can be reasoned about and strike a reasonable balance between
platform complexity/cost and user-perceivable complexity.

> What we're trying to do is retroactive _grouping_, and I think what you're
> really arguing for is that grouping in general isn't necessary.
> So I think we should maybe take a step back and talk about what value it
> brings at a higher level to determine if the complexity / ambiguity of grouping
> is worth the benefit.
> 
> From my perspective, the reason that we want conformance groups is purely
> for compliance and cross compatibility. If someone has a BPF program that
> does some class of operations, then conformance groups inform them about
> whether their prog will be able to run on some vendor implementation of
> BPF.  For example, if you're doing network packet filtering and doing some
> atomics, hashing, etc on a Netronome NIC, you'd like for it to be able to run
> on other NICs that implement offload as well. If a NIC isn't compliant with the
> atomics group, it won't be able to support your prog.
> 
> If we don't have conformance groups, I don't see how we can provide that
> guarantee. I think there's essentially a 0% chance that vendors will implement
> every instruction; nor should they have to. So if we just do "legacy" and
> "other", the grouping won't really tell a vendor or BPF developer anything
> other than what instructions are completely useless and should be avoided.

+1 to all of above.

> If we want to get rid of conformance groups that's fine and I do think there's
> an argument for it, but I think we need to discuss this in terms of compliance
> and not the grouping aspect.
> 
> FWIW, my perspective is that we should be aiming to enable compliance.
> I don't see any reason why a BPF prog that's offloaded to a NIC to do packet
> filtering shouldn't be able to e.g. run on multiple devices.
> That certainly won't be the case for every type of BPF program, but classifying
> groups of instructions does seem prudent.

I agree with David's assessment above.

Dave

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

