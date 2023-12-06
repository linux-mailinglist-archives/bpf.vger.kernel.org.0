Return-Path: <bpf+bounces-16871-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7DA806CD3
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 11:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E46A1F2157A
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 10:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173C03064A;
	Wed,  6 Dec 2023 10:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MXudTH+S"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6263035D
	for <bpf@vger.kernel.org>; Wed,  6 Dec 2023 10:58:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 570B3C433C7;
	Wed,  6 Dec 2023 10:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701860283;
	bh=AcT/6o6Krxxla0EPj4m4NzJBKpALV3cCw3Q0fJzomu8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MXudTH+S/rLTLZSISY1v9AteFuRb9jRF/c+38U3+aEmceRHLK0wbgu/VoKRHzo4tU
	 AGIO4Ojo0ksYeYD4z0CKqkiOj/KcwMqi8h9zRRdNremPXxtJ9z3yte7L6X8uYVuxH4
	 tHfcxTt1DSqn0WuczvKVGg7r/zAoA+gmuKQUWKaS5/JC9v2/XdnnU595tjvlxbQghI
	 a2GpB3/GiLhpJ9/moFdgEeEyPj9Leb2lLLbJV7hjBx/2Ia4bKxy/nDHCFfa6mlWRNM
	 Z52tAFOEO7TQa9u71iDFc7+c1ZX6msObuMeowMbC/Zb1+4ouCiWRf0VPlzbocK8KsC
	 k25qXcksfxN3A==
Date: Wed, 6 Dec 2023 11:57:59 +0100
From: Christian Brauner <brauner@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jie Jiang <jiejiang@chromium.org>, Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org, vapier@chromium.org
Subject: Re: [PATCH bpf-next] bpf: Support uid and gid when mounting bpffs
Message-ID: <20231206-ruhmreich-abklopfen-21c69e3e9cfd@brauner>
References: <20231201094729.1312133-1-jiejiang@chromium.org>
 <20231205-versorgen-funde-1184ee3f6aa4@brauner>
 <CAEf4BzZY=twEbSyE7cLee_aYcH3k8qxUEt6tBC_G-etU7E9JpA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZY=twEbSyE7cLee_aYcH3k8qxUEt6tBC_G-etU7E9JpA@mail.gmail.com>

On Tue, Dec 05, 2023 at 10:28:39AM -0800, Andrii Nakryiko wrote:
> On Tue, Dec 5, 2023 at 8:31 AM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Fri, Dec 01, 2023 at 09:47:29AM +0000, Jie Jiang wrote:
> > > Parse uid and gid in bpf_parse_param() so that they can be passed in as
> > > the `data` parameter when mount() bpffs. This will be useful when we
> > > want to control which user/group has the control to the mounted bpffs,
> > > otherwise a separate chown() call will be needed.
> > >
> > > Signed-off-by: Jie Jiang <jiejiang@chromium.org>
> > > ---
> >
> > Sorry, I was asked to take a quick look at this. The patchset looks fine
> > overall but it will interact with Andrii's patchset which makes bpffs
> > mountable inside a user namespace (with caveats).
> >
> > At that point you need additional validation in bpf_parse_param(). The
> > simplest thing would probably to just put this into this series or into
> > @Andrii's series. It's basically a copy-pasta from what I did for tmpfs
> > (see below).
> >
> > I plan to move this validation into the VFS so that {g,u}id mount
> > options are validated consistenly for any such filesystem. There is just
> > some unpleasantness that I have to figure out first.
> >
> > @Andrii, with the {g,u}id mount option it means that userns root can
> >
> > fsconfig(..., FSCONFIG_SET_STRING, "uid", "1000", ...)
> > fsconfig(..., FSCONFIG_SET_STRING, "gid", "1000", ...)
> > fsconfig(..., FSCONFIG_CMD_CREATE, ...)
> >
> > If you delegate CAP_BPF in that userns to uid 1000 then an unpriv user
> > in that userns can create bpf tokens. Currently this would require
> > userns root to give both CAP_DAC_READ_SEARCH and CAP_BPF to such an
> > unprivileged user.
> 
> This is probably fine. Basically the only difference is that BPF FS
> can be instantiated inside an unpriv namespace, instead of in a
> privileged parent namespace, right?

Hm, I think this is slightly misphrased but I guess I get what you mean.

Basically, userns root can change what {g,u}id bpffs will use to
instantiate inodes once init_user_ns root creates the superblock. IOW,
the {g,u}id mount option isn't guarded and can thus be changed by userns
root.

> 
> But delegate_xxx options are still guarded by the explicit
> capable(CAP_SYS_ADMIN) check, so that unprivileged user won't be able
> to grant themselves BPF token-enabling capabilities without a
> privileged parent doing it on their behalf.
> 
> Is my understanding correct or am I missing some nuance here?

No, that's correct.

