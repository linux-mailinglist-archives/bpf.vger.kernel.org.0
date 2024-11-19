Return-Path: <bpf+bounces-45175-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E687D9D2530
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 12:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54597B23611
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 11:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D4D1CBE85;
	Tue, 19 Nov 2024 11:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WmOupbsO"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D14211C;
	Tue, 19 Nov 2024 11:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732017526; cv=none; b=nMRDR0HywiyLxc+M63WhiN+cCrrRBUdgEu0LUFmZp9GQcT6784vR0a1GWbA1OIqK6pu60YKNQt9pB83ZHroJZAvUPsuUc/oVndKkK6QwwHlajBzn0HdOIWIE0zYVgANP6EE+/eavWrw9Miy6BW/L/MR6iJUL6bnxE9BEAU6rQwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732017526; c=relaxed/simple;
	bh=K8FMiqW5NIEUmvDDVxv170oLszWNxCd/M4x52+9ZjMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ls3WdjXo2zFPwgzlpXw0rhjakCddID2maxCFo2Rn/9s14fbg+KPyZlXcZ4Kur6/wStmOv9jUjk4dJQUeOH6jDfSH29ClrownJ95gRapoUTXggZWZ34u+rY9Imqhls+yMOXFxBW+8HHmw+85HnH9Bs7s7t1iBZ+gmOSAk/ypcRtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WmOupbsO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C3BCC4CECF;
	Tue, 19 Nov 2024 11:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1732017525;
	bh=K8FMiqW5NIEUmvDDVxv170oLszWNxCd/M4x52+9ZjMU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WmOupbsOU5umXwVorZ1Imowtg2Nkw2bvxxvg4PPd02ZggC3EKr2DnqgT/uzl6J5Cf
	 l0uGiItxip2UQ6YLt62knmbBLKqcnbONHHu2LiKExlUx/T7tzIVMFNQ86nEQozod5g
	 fSGeH5YEjbOgdEvznYNXWvQR6RtIrSSe0rlBrA+Y=
Date: Tue, 19 Nov 2024 12:58:21 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Omar Sandoval <osandov@osandov.com>
Cc: stable@vger.kernel.org, Jiri Olsa <olsajiri@gmail.com>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: Fix build ID parsing logic in stable trees
Message-ID: <2024111955-excursion-diaper-2675@gregkh>
References: <2024110536-agonizing-campus-21f0@gregkh>
 <ZyniGMz5QLhGVWSY@krava>
 <2024110636-rebound-chip-f389@gregkh>
 <ZytZrt31Y1N7-hXK@krava>
 <Zy0dNahbYlHISjkU@telecaster>
 <Zy3NVkewYPO9ZSDx@krava>
 <Zy6eJdwR3LWOlrQg@krava>
 <CAEf4Bza3PFp53nkBxupn1Z6jYw-FyXJcZp7kJh8aeGhe1cc6CA@mail.gmail.com>
 <ZzUWRyDmndTpZU3Y@krava>
 <ZzeQrYy-6I3NK4gX@telecaster>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZzeQrYy-6I3NK4gX@telecaster>

On Fri, Nov 15, 2024 at 10:19:25AM -0800, Omar Sandoval wrote:
> On Wed, Nov 13, 2024 at 10:12:39PM +0100, Jiri Olsa wrote:
> > On Wed, Nov 13, 2024 at 12:07:39PM -0800, Andrii Nakryiko wrote:
> > > On Fri, Nov 8, 2024 at 3:26 PM Jiri Olsa <olsajiri@gmail.com> wrote:
> > > >
> > > > On Fri, Nov 08, 2024 at 09:35:34AM +0100, Jiri Olsa wrote:
> > > > > On Thu, Nov 07, 2024 at 12:04:05PM -0800, Omar Sandoval wrote:
> > > > > > On Wed, Nov 06, 2024 at 12:57:34PM +0100, Jiri Olsa wrote:
> > > > > > > On Wed, Nov 06, 2024 at 07:12:05AM +0100, Greg KH wrote:
> > > > > > > > On Tue, Nov 05, 2024 at 10:15:04AM +0100, Jiri Olsa wrote:
> > > > > > > > > On Tue, Nov 05, 2024 at 07:54:48AM +0100, Greg KH wrote:
> > > > > > > > > > On Mon, Nov 04, 2024 at 06:52:52PM +0100, Jiri Olsa wrote:
> > > > > > > > > > > hi,
> > > > > > > > > > > sending fix for buildid parsing that affects only stable trees
> > > > > > > > > > > after merging upstream fix [1].
> > > > > > > > > > >
> > > > > > > > > > > Upstream then factored out the whole buildid parsing code, so it
> > > > > > > > > > > does not have the problem.
> > > > > > > > > >
> > > > > > > > > > Why not just take those patches instead?
> > > > > > > > >
> > > > > > > > > I guess we could, but I thought it's too big for stable
> > > > > > > > >
> > > > > > > > > we'd need following 2 changes to fix the issue:
> > > > > > > > >   de3ec364c3c3 lib/buildid: add single folio-based file reader abstraction
> > > > > > > > >   60c845b4896b lib/buildid: take into account e_phoff when fetching program headers
> > > > > > > > >
> > > > > > > > > and there's also few other follow ups:
> > > > > > > > >   5ac9b4e935df lib/buildid: Handle memfd_secret() files in build_id_parse()
> > > > > > > > >   cdbb44f9a74f lib/buildid: don't limit .note.gnu.build-id to the first page in ELF
> > > > > > > > >   ad41251c290d lib/buildid: implement sleepable build_id_parse() API
> > > > > > > > >   45b8fc309654 lib/buildid: rename build_id_parse() into build_id_parse_nofault()
> > > > > > > > >   4e9d360c4cdf lib/buildid: remove single-page limit for PHDR search
> > > > > > > > >
> > > > > > > > > which I guess are not strictly needed
> > > > > > > >
> > > > > > > > Can you verify what exact ones are needed here?  We'll be glad to take
> > > > > > > > them if you can verify that they work properly.
> > > > > > >
> > > > > > > ok, will check
> > > > > >
> > > > > > Hello,
> > > > > >
> > > > > > I noticed that the BUILD-ID field in vmcoreinfo is broken on
> > > > > > stable/longterm kernels and found this thread. Can we please get this
> > > > > > fixed soon?
> > > > > >
> > > > > > I tried cherry-picking the patches mentioned above ("lib/buildid: add
> > > > > > single folio-based file reader abstraction" and "lib/buildid: take into
> > > > > > account e_phoff when fetching program headers"), but they don't apply
> > > > > > cleanly before 6.11, and they'd need to be reworked for 5.15, which was
> > > > > > before folios were introduced. Jiri's minimal fix works for me and seems
> > > > > > like a much safer option.
> > > > >
> > > > > hi,
> > > > > thanks for testing
> > > > >
> > > > > I think for 6.11 we could go with backport of:
> > > > >   de3ec364c3c3 lib/buildid: add single folio-based file reader abstraction
> > > > >   60c845b4896b lib/buildid: take into account e_phoff when fetching program headers
> > > > >
> > > > > and with the small fix for the rest
> > > > >
> > > > > but I still need to figure out why also 60c845b4896b is needed
> > > > > to fix the issue on 6.11.. hopefully today
> > > >
> > > > ok, so the fix the issue in 6.11 with upstream backports we'd need both:
> > > >
> > > >   1) de3ec364c3c3 lib/buildid: add single folio-based file reader abstraction
> > > >   2) 60c845b4896b lib/buildid: take into account e_phoff when fetching program headers
> > > >
> > > > 2) is needed because 1) seems to omit ehdr->e_phoff addition (patch below)
> > > > which is added back in 2)
> > > >
> > > > IMO 6.11 is close to upstream and by taking above upstream fixes it will be
> > > > easier to backport other possible fixes in the future, for other trees I'd
> > > > take the original one line fix I posted
> > > 
> > > I still maintain that very minimal is the way to go instead of risking
> > > bringing new potential regressions by partially backporting folio
> > > rework patchset.
> > > 
> > > Jiri, there is no point in risking this, best to fix this quickly and
> > > minimally. If we ever need to backport further fixes, *then* we can
> > > think about folio-based implementation backport.
> > 
> > ok, make sense, the original plan works for me as well
> > 
> > jirka
> 
> Greg, could you please queue up Jiri's one line fixes for 5.15, 6.1,
> 6.6, and 6.11?

Ok, will do, but hopefully you all will help out if there's any problems
with the change going forward...

greg k-h

