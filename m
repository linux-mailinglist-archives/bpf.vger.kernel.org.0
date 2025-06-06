Return-Path: <bpf+bounces-59854-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F13AD00BA
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 12:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95D103B144C
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 10:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8612857CF;
	Fri,  6 Jun 2025 10:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="zqPERQUg"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-bc0a.mail.infomaniak.ch (smtp-bc0a.mail.infomaniak.ch [45.157.188.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CD027FB35
	for <bpf@vger.kernel.org>; Fri,  6 Jun 2025 10:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749206796; cv=none; b=Qb1WMbcpVMjOx1TGrh3FVsaUn7Gq/Ie5FjyhSvMt+2FobnE37LXp/9MDxZakD6RNjlbd5L+AEOn9EpCJSaegwSNu/CmIy+L2Q+pZcPrxhWmLUnxK+tMGCFTbTftU04gevUFp0caRi8zPSL+2gNN/jwpzzCzuTwE8tZNHAjYYwtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749206796; c=relaxed/simple;
	bh=EdISCY8+Nwj/6Ck2qwx1KqleTaHrkAdcHuOQ931eBqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sMqgYSReQjSckn1V9J/da0yf2Qa6hhZJK4pkT9V1QPrFHpAgb/04ArtjPz9SPf5yjRZyHsZqARXCdVX8VyphRBWP3s+8pmlZCBwZ9VhPFaOIX2RN4/hRKc3l7/RCnvD/EGF4w1RX55wNKdHijaIYY03lQUaUJQ8xKn9vmNSAWtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=zqPERQUg; arc=none smtp.client-ip=45.157.188.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4bDJ0747jqz5rT;
	Fri,  6 Jun 2025 12:46:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1749206791;
	bh=hiQyTj6n+Gg20Nh1xHG8uksvLeu5UW/Ze/TPfn76o9k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zqPERQUgAHkRj+EGCmB9c3YgKTMwsZbMGsK/qDMZwD9Lbj13miqcFlVMURYAAubK2
	 i3B1WOlx1T6ZOUgtjJ7iZXjsqnEa4LKxII8BScUkuboPqOuMTLNxP2K6Xw7639aa52
	 Jt8of9CfhDl4RPMREdx+2Zl5Z0PPL9Czm1Wrphfo=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4bDJ062Hb4zhsp;
	Fri,  6 Jun 2025 12:46:30 +0200 (CEST)
Date: Fri, 6 Jun 2025 12:46:29 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, kernel-team@meta.com, 
	andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	kpsingh@kernel.org, mattbobrowski@google.com, amir73il@gmail.com, repnop@google.com, 
	jlayton@kernel.org, josef@toxicpanda.com, gnoack@google.com, m@maowtm.org
Subject: Re: [PATCH v2 bpf-next 2/4] landlock: Use path_walk_parent()
Message-ID: <20250606.zo5aekae6Da6@digikod.net>
References: <20250603065920.3404510-1-song@kernel.org>
 <20250603065920.3404510-3-song@kernel.org>
 <20250603.Av6paek5saes@digikod.net>
 <CAPhsuW6J_hDtXZm4MH_OAz=GCpRW0NMM1EXMrJ=nqsTdpf8vcg@mail.gmail.com>
 <CAPhsuW7MtxryseFsHF2xqBFS2UWammJatjf8UxBhytgn_nA4=g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW7MtxryseFsHF2xqBFS2UWammJatjf8UxBhytgn_nA4=g@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Thu, Jun 05, 2025 at 09:47:36AM -0700, Song Liu wrote:
> On Wed, Jun 4, 2025 at 12:37 PM Song Liu <song@kernel.org> wrote:
> >
> > On Tue, Jun 3, 2025 at 6:46 AM Mickaël Salaün <mic@digikod.net> wrote:
> > >
> > > Landlock tests with hostfs fail:
> > >
> > > ok 126 layout3_fs.hostfs.tag_inode_file
> > > #  RUN           layout3_fs.hostfs.release_inodes ...
> > > # fs_test.c:5555:release_inodes:Expected EACCES (13) == test_open(TMP_DIR, O_RDONLY) (0)
> > >
> > > This specific test checks that an access to a (denied) mount point over
> > > an allowed directory is indeed denied.
> 
> I just realized this only fails on hostfs. AFAICT, hostfs is only used
> by um. Do we really need this to behave the same on um+hostfs?

Yes, this would be a regression, and in fact it is not related to hostfs
and it would be a new security bug.

The issue is that the path_walk_parent() doesn't return the parent
dentry but the underlying mount point if any.  When choose_mountpoint()
returns true, path_walk_parent() should continue to the following root
check and potentiall the dget_parent() call.  We need to be careful with
the path_put() though.

This issue was only spotted by this hostfs test because this one adds a
rule which is tied to the inode of the mount which is in fact the same
inode of the mount point because the mount is a bind mount.  I'll send a
new test that check the same thing but with tmpfs (for convenience, but
it would be the same for any filesystem).

> 
> Thanks,
> Song
> 
> >
> > I am having trouble understanding the test. It appears to me
> > the newly mounted tmpfs on /tmp is allowed, but accesses to
> > / and thus mount point /tmp is denied? What would the walk in
> > is_access_to_paths_allowed look like?

The test checks that a mount is not wrongly identified as the underlying
mount point.

> >
> > > It's not clear to me the origin of the issue, but it seems to be related
> > > to choose_mountpoint().
> > >
> > > You can run these tests with `check-linux.sh build kselftest` from
> > > https://github.com/landlock-lsm/landlock-test-tools
> >
> > How should I debug this test? printk doesn't seem to work.

The console log level is set to warn, so you can use pr_warn().

> >
> > Thanks,
> > Song

