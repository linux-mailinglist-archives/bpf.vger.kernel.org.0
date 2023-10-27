Return-Path: <bpf+bounces-13419-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B00AB7D99AD
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 15:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33FB11F215C5
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 13:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932351EB3C;
	Fri, 27 Oct 2023 13:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P1n5Fznn"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43C61EB28
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 13:25:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35FDDC433C8;
	Fri, 27 Oct 2023 13:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698413114;
	bh=03RYZfrBUfkXjOlDdjGD9+dpnxu38yIUbIWWZ3ySeKw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P1n5Fznnt7y/H9IBPs563IdgXZnB49rjQLMgLiFJIKRMwtNRu7cY3qq1yF+DXwti6
	 KpfMvqAz9D2GVn1JrDyuMGFD2AyHxTG4ds+wQsdZQvN30kpngwc1Q1z35Fo5NK1Q+m
	 lXjUBwXQ/zSZ51FwiFCFpV3cdWsKbc42ALmDr0r85qN97X6o3FikBr8YjoEJthuobD
	 xw91Qm+GuaNAVqSY5oTKPZkJbeEJ8dEW8a0aNqkPA0sjmlI+XqUc3e/6VgZ4jFhlia
	 mji3h9wyt81X02oexjaMFO6WAu5PjIubxzEzJL7CB5yeIbHAXFWf4haGuyp5dteCdg
	 9of/b7U3VATHw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 68E9A4035D; Fri, 27 Oct 2023 10:25:07 -0300 (-03)
Date: Fri, 27 Oct 2023 10:25:07 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Jiri Olsa <jolsa@kernel.org>, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
	haoluo@google.com, mykolal@fb.com, bpf@vger.kernel.org
Subject: Re: [PATCH v4 dwarves 0/5] pahole, btf_encoder: support
 --btf_features
Message-ID: <ZTu6M99GZL+4UzGG@kernel.org>
References: <20231023095726.1179529-1-alan.maguire@oracle.com>
 <ZTlTpYYVoYL0fls7@kernel.org>
 <ZTlVAtFw7oKaFrvl@kernel.org>
 <ZTlaoGDkALO2h95p@kernel.org>
 <ZTlerFwlAn3AP+o4@kernel.org>
 <f65dd024a49323f4b0e282c1f71384b96f170d16.camel@gmail.com>
 <CAEf4BzbM20uErJ8-UiRb3WCxXJUXtvSRCKSfuAURXpsHU4ud-w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzbM20uErJ8-UiRb3WCxXJUXtvSRCKSfuAURXpsHU4ud-w@mail.gmail.com>
X-Url: http://acmel.wordpress.com

Em Thu, Oct 26, 2023 at 03:06:15PM -0700, Andrii Nakryiko escreveu:
> On Wed, Oct 25, 2023 at 3:28 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
> >
> > On Wed, 2023-10-25 at 15:30 -0300, Arnaldo Carvalho de Melo wrote:
> > > Em Wed, Oct 25, 2023 at 03:12:49PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > > But I guess the acks/reviews + my tests are enough to merge this as-is,
> > > > thanks for your work on this!
> > >
> > > Ok, its in the 'next' branch so that it can go thru:
> > >
> > > https://github.com/libbpf/libbpf/actions/workflows/pahole.yml
> > >
> > > But the previous days are all failures, probably something else is
> > > preventing this test from succeeding? Andrii?
> >
> > It looks like the latest run succeeded, while a number of previous
> > runs got locked up for some reason. All using the same kernel
> > checkpoint commit. I know how to setup local github runner,
> > so I can try to replicate this by forking the repo,
> > redirecting CI to my machine and executing it several times.
> > Will do this over the weekend, need to work on some verifier
> > bugs first.
> >
> 
> BPF selftests are extremely unreliable under slow Github runners,
> unfortunately. Kernel either crashes or locks up very frequently. It
> has nothing to do with libbpf and we don't seem to see this in BPF CI
> due to having much faster runners there.
> 
> I'm not sure what to do about this apart from trying to identify a
> selftest that causes lock up (extremely time consuming endeavor) or
> just wait till libbpf CI will be privileged enough to gain its own
> fast AWS-based worker :)
> 
> But it seems like the last scheduled run succeeded, I think you are good.

I'm not sure it got the btf_features patch, I'll try to change the cmake
files to print the HEAD so that when looking at the output in the github
actions I can be sure that it is using what needs to be tested.

- Arnaldo

