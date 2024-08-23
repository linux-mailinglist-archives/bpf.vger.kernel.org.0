Return-Path: <bpf+bounces-37936-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 150AD95CA95
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 12:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C451D285B1C
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 10:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF84185B6B;
	Fri, 23 Aug 2024 10:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="pjAkK2Oi"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-190f.mail.infomaniak.ch (smtp-190f.mail.infomaniak.ch [185.125.25.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2519437144
	for <bpf@vger.kernel.org>; Fri, 23 Aug 2024 10:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724409533; cv=none; b=DRvCDfPP4eRDZB/OfV/Ujx3PnToXsgj5LUxCAyzNFvwbEGFKRS6AqUPAg+ufDTDiagKu8D7UE961HLOqSi6mb4a1hAPcVCxJ3SLkE5R0Aj6S+EoGV2IPu/NodBG5CKvchg6DIqheJk3KrMYZF3xjuhEvMJrme49Rh7rwodi9Fjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724409533; c=relaxed/simple;
	bh=YBqL3sN6Z30EdGp/SNi7tkoBNbgiS7ggY2BAQok1vVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mJ9I246aYKPNJ5dN1cVEOyfCUTgOcIimHAphJ6flWmDbhmvvbcqu85dPoYfmBOeJq2h0xypjUYMLjyH9IX5CaSd0HOzWsARNwTzGo4VrpIqgd9+/p6LiReWxNWBK2I2pEJYGFc4g3sFj+QG4KqZeDVBiX7Ty7v0cGcDK5pUBlZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=pjAkK2Oi; arc=none smtp.client-ip=185.125.25.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WqxPZ3rgHz6bJ;
	Fri, 23 Aug 2024 12:38:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1724409522;
	bh=ZJi/0dhpThM5/X8AiDcSNY58hEt/BED8l/BaMzmo8kQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pjAkK2OiTa6P9V+HF4aDH6oUsbs6RfZZypdrCxIpWzDoLxMBuRbN75o+RXX3hilRb
	 jrNOqAv91KVir9uprm/0rqhF4+pNLj7HG7y6iUIYh+LDiFkHcIqqXbDiN1RHAQJ+yb
	 iPOpD4bBGkIoAZmYQIO+Gy17jUv3AcRaCxZsV5Aw=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4WqxPY24mmzCRw;
	Fri, 23 Aug 2024 12:38:41 +0200 (CEST)
Date: Fri, 23 Aug 2024 12:38:36 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Song Liu <songliubraving@meta.com>
Cc: Paul Moore <paul@paul-moore.com>, 
	Christian Brauner <brauner@kernel.org>, Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Kernel Team <kernel-team@meta.com>, "andrii@kernel.org" <andrii@kernel.org>, 
	"eddyz87@gmail.com" <eddyz87@gmail.com>, "ast@kernel.org" <ast@kernel.org>, 
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "martin.lau@linux.dev" <martin.lau@linux.dev>, 
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "jack@suse.cz" <jack@suse.cz>, 
	"kpsingh@kernel.org" <kpsingh@kernel.org>, "mattbobrowski@google.com" <mattbobrowski@google.com>, 
	Liam Wisehart <liamwisehart@meta.com>, Liang Tang <lltang@meta.com>, 
	Shankaran Gnanashanmugam <shankaran@meta.com>, LSM List <linux-security-module@vger.kernel.org>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add tests for
 bpf_get_dentry_xattr
Message-ID: <20240823.zeiC0zauhah1@digikod.net>
References: <20240729-zollfrei-verteidigen-cf359eb36601@brauner>
 <8DFC3BD2-84DC-4A0C-A997-AA9F57771D92@fb.com>
 <20240819-keilen-urlaub-2875ef909760@brauner>
 <20240819.Uohee1oongu4@digikod.net>
 <370A8DB0-5636-4365-8CAC-EF35F196B86F@fb.com>
 <20240820.eeshaiz3Zae6@digikod.net>
 <1FFB2F15-EB60-4EAD-AEB0-6895D3E216C1@fb.com>
 <CAHC9VhQ3Sq_vOCo_XJ4hEo6fA8RvRn28UDaxwXAM52BAdCkUSg@mail.gmail.com>
 <7A37AEE2-7DEA-4CC4-B0DB-6F6326BE6596@fb.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7A37AEE2-7DEA-4CC4-B0DB-6F6326BE6596@fb.com>
X-Infomaniak-Routing: alpha

On Wed, Aug 21, 2024 at 03:43:48AM +0000, Song Liu wrote:
> 
> 
> > On Aug 20, 2024, at 2:11 PM, Paul Moore <paul@paul-moore.com> wrote:
> > 
> > On Tue, Aug 20, 2024 at 1:43 PM Song Liu <songliubraving@meta.com> wrote:
> >>> On Aug 20, 2024, at 5:45 AM, Mickaël Salaün <mic@digikod.net> wrote:
> > 
> > ...
> > 
> >>> What about adding BPF hooks to Landlock?  User space could create
> >>> Landlock sandboxes that would delegate the denials to a BPF program,
> >>> which could then also allow such access, but without directly handling
> >>> nor reimplementing filesystem path walks.  The Landlock user space ABI
> >>> changes would mainly be a new landlock_ruleset_attr field to explicitly
> >>> ask for a (system-wide) BPF program to handle access requests if no
> >>> Landlock rule allow them.  We could also tie a BPF data (i.e. blob) to
> >>> Landlock domains for consistent sandbox management.  One of the
> >>> advantage of this approach is to only run related BPF programs if the
> >>> sandbox policy would deny the request.  Another advantage would be to
> >>> leverage the Landlock user space interface to let any program partially
> >>> define and extend their security policy.
> >> 
> >> Given there is BPF LSM, I have never thought about adding BPF hooks to
> >> Landlock or other LSMs. I personally would prefer to have a common API
> >> to walk the path, maybe something like vma_iterator. But I need to read
> >> more code to understand whether this makes sense?

I think it would not be an issue to use BPF Landlock hooks along with
BPF LSM hooks for the same global policy.  This could also use the
Landlock domain concept for your use case, including domain inheritance,
domain identification, cross-domain protections... to avoid
reimplementing the same semantic (and going through the same issues).
Limiting the BPF program calls could also improve performance.

> > 
> > Just so there isn't any confusion, I want to make sure that everyone
> > is clear that "adding BPF hooks to Landlock" should mean "add a new
> > Landlock specific BPF hook inside Landlock" and not "reuse existing
> > BPF LSM hooks inside Landlock".
> 
> I think we are on the same page. My understanding of Mickaël's idea is
> to add some brand new hooks to Landlock code, so that Landlock can
> use BPF program to make some decisions. 

Correct

