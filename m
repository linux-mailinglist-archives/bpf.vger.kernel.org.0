Return-Path: <bpf+bounces-33978-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66EF5928FB1
	for <lists+bpf@lfdr.de>; Sat,  6 Jul 2024 02:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C90F284239
	for <lists+bpf@lfdr.de>; Sat,  6 Jul 2024 00:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44A1629;
	Sat,  6 Jul 2024 00:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mpkwI1Hh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3910B819;
	Sat,  6 Jul 2024 00:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720225031; cv=none; b=uzYIeekSTjhOaYeALzo9W22LtUg+/el+Lfr/F4Zu9NbRvmsVhaXw++fKYsZsmtHKpSBMYrWQzxSzl6TEGSV6PS12Zcr/gx2ILsixWRU5hibPMG3ulv1wKroF2n4119lkg8970ZLS/8OLPzcdb6NP9w782cDzsVMQLoy9NhzlTKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720225031; c=relaxed/simple;
	bh=bIJlc0+0sSEGhtkvc24CkLXjeEY+a3kQomOalHEodxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bnIvQHyXQLc6J2jAVkWg9qIY3Caf4A3LR0KVpMyl57DTiqouzCzLsZXkWKB7IAaofHsmTkjMCQVaurTVENFxVWLk5CccHAkqSxsw5nqgotQQw12CENUfJnPDuvNOQYmkf6BHJ3tjSfMiFxrWeX4CszgvEqnjW2rKQsmxsY7vRGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mpkwI1Hh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC89BC116B1;
	Sat,  6 Jul 2024 00:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720225030;
	bh=bIJlc0+0sSEGhtkvc24CkLXjeEY+a3kQomOalHEodxk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mpkwI1HhDbx8XZjVnCXiYNuHMEJn/88SIBnVWC8Ph5/iC3jwfOjfQbdGcWKDKITPF
	 qEfqa5KXIgcJ+O9cTZ81r+pWllXYBwEsEWaCmj0tqFPiJprgLF6Wj+atxLjmhgTONY
	 mBLRaFg8/ncPv1Y2i+uhULEQ3ZyNOgraN64+ux3596jzvpbI4LxxJceM7bdeun2xUF
	 n463A4oVa4roLRveMjj1UcUroog/xTSrb//KGVV1O+krAjj4WqQzzX582Db4A/1Kov
	 GzbKH3yrFOVedj2bAJk4OhctDMPuN7ZYOLerXaLNVplcmoRGnByN5avB216cCCUR+d
	 F1KIYVGTJfmQw==
Date: Fri, 5 Jul 2024 17:17:10 -0700
From: Kees Cook <kees@kernel.org>
To: KP Singh <kpsingh@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org,
	bpf@vger.kernel.org, ast@kernel.org, casey@schaufler-ca.com,
	andrii@kernel.org, daniel@iogearbox.net, renauld@google.com,
	revest@chromium.org, song@kernel.org
Subject: Re: [PATCH v13 3/5] security: Replace indirect LSM hook calls with
 static calls
Message-ID: <202407051714.0AAC2D4A9D@keescook>
References: <20240629084331.3807368-4-kpsingh@kernel.org>
 <ce279e1f9a4e4226e7a87a7e2440fbe4@paul-moore.com>
 <CACYkzJ60tmZEe3=T-yU3dF2x757_BYUxb_MQRm6tTp8Nj2A9KA@mail.gmail.com>
 <CAHC9VhQ4qH-rtTpvCTpO5aNbFV4epJr5Xaj=TJ86_Y_Z3v-uyw@mail.gmail.com>
 <CACYkzJ4kwrsDwD2k5ywn78j7CcvufgJJuZQ4Wpz8upL9pAsuZw@mail.gmail.com>
 <CAHC9VhRoMpmHEVi5K+BmKLLEkcAd6Qvf+CdSdBdLOx4LUSsgKQ@mail.gmail.com>
 <CACYkzJ6mWFRsdtRXSnaEZbnYR9w85MfmMJ3i76WEz+af=_QnLg@mail.gmail.com>
 <CAHC9VhRA0hX-Nx20CK+yV276d7nooMmR+Q5OBNOy5fces4q9Bw@mail.gmail.com>
 <CACYkzJ6jADoGNuPP3-1wkk-kV7NOQh+eFkU5KEDEZgq9qNNEfg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACYkzJ6jADoGNuPP3-1wkk-kV7NOQh+eFkU5KEDEZgq9qNNEfg@mail.gmail.com>

On Fri, Jul 05, 2024 at 09:34:20PM +0200, KP Singh wrote:
> On Fri, Jul 5, 2024 at 8:07 PM Paul Moore <paul@paul-moore.com> wrote:
> >
> > On Wed, Jul 3, 2024 at 7:08 PM KP Singh <kpsingh@kernel.org> wrote:
> > > On Thu, Jul 4, 2024 at 12:52 AM Paul Moore <paul@paul-moore.com> wrote:
> > > > On Wed, Jul 3, 2024 at 6:22 PM KP Singh <kpsingh@kernel.org> wrote:
> > > > > On Wed, Jul 3, 2024 at 10:56 PM Paul Moore <paul@paul-moore.com> wrote:
> > > > > > On Wed, Jul 3, 2024 at 12:55 PM KP Singh <kpsingh@kernel.org> wrote:
> > > > > > > On Wed, Jul 3, 2024 at 2:07 AM Paul Moore <paul@paul-moore.com> wrote:
> > > > > > > > On Jun 29, 2024 KP Singh <kpsingh@kernel.org> wrote:
> > > > > > > > >
> > > > > > > > > LSM hooks are currently invoked from a linked list as indirect calls
> > > > > > > > > which are invoked using retpolines as a mitigation for speculative
> > > > > > > > > attacks (Branch History / Target injection) and add extra overhead which
> > > > > > > > > is especially bad in kernel hot paths:
> >
> > ...
> >
> > > > > > I'm not aware of any other existing problems relating to the LSM hook
> > > > > > default values, if there are any, we need to fix them independent of
> > > > > > this patchset.  The LSM framework should function properly if the
> > > > > > "default" values are used.
> > > > >
> > > > > Patch 5 eliminates the possibilities of errors and subtle bugs all
> > > > > together. The problem with subtle bugs is, well, they are subtle, if
> > > > > you and I knew of the bugs, we would fix all of them, but we don't. I
> > > > > really feel we ought to eliminate the class of issues and not just
> > > > > whack-a-mole when we see the bugs.
> > > >
> > > > Here's the thing, I don't really like patch 5/5.  To be honest, I
> > > > don't really like a lot of this patchset.  From my perspective, the
> > > > complexity of the code is likely going to mean more maintenance
> > > > headaches down the road, but Linus hath spoken so we're doing this
> > > > (although "this" is still a bit undefined as far as I'm concerned).
> > > > If you want me to merge patch 5/5 you've got to give me something real
> > > > and convincing that can't be fixed by any other means.  My current
> > > > opinion is that you're trying to use a previously fixed bug to scare
> > > > and/or coerce the merging of some changes I don't really want to
> > > > merge.  If you want me to take patch 5/5, you've got to give me a
> > > > reason that is far more compelling that what you've written thus far.
> > >
> > > Paul, I am not scaring you, I am providing a solution that saves us
> > > from headaches with side-effects and bugs in the future. It's safer by
> > > design.
> >
> > Perhaps I wasn't clear enough in my previous emails; instead of trying
> > to convince me that your solution is literally the best possible thing
> > to ever touch the kernel, convince me that there is a problem we need
> > to fix.  Right now, I'm not convinced there is a bug that requires all
> > of the extra code in patch 5/5 (all of which have the potential to
> > introduce new bugs).  As mentioned previously, the bugs that typically
> > have been used as examples of unwanted side effects with the LSM hooks
> > have been resolved, both in the specific and general case.  If you
> > want me to add more code/functionality to fix a bug, you must first
> > demonstrate the bug exists and the risk is real; you have not done
> > that as far as I'm concerned.
> >
> > > You say you have not reviewed it carefully ...
> >
> > That may have been true of previous versions of this patchset, but I
> > did not say that about this current patchset.
> >
> > > ... but you did ask me to move
> > > the function from the BPF LSM layer to an LSM API, and we had a bunch
> > > of discussion around naming in the subsequent revisions.
> > >
> > > https://lore.kernel.org/bpf/f7e8a16b0815d9d901e019934d684c5f@paul-moore.com/
> >
> > That discussion predates commit 61df7b828204 ("lsm: fixup the inode
> > xattr capability handling") which is currently in the lsm/dev branch,
> > marked for stable, and will go up to Linus during the upcoming merge
> > window.
> >
> > > My reasons are:
> > >
> > > 1. It's safer, no side effects, guaranteed to be not buggy. Neither
> > > you, nor me, can guarantee that a default value will be safe in the
> > > LSM layer.
> >
> > In the first sentence above you "guarantee" that your code is not
> > buggy and then follow that up with a second sentence discussing how no
> > one can guarantee source code safety.  Regardless of whatever point
> > you were trying to make here, I maintain that *all* patches have the
> > potential for bugs, even those that are attempting to fix bugs.  WithD
> > that in mind, if you want me to merge more code to fix a bug (class),
> > a bug that I've mentioned several times now that I believe we've
> > already fixed, you first MUST convince me that the bug (class) still
> > exists.  You have not done that.
> >
> 
> Paul, I am talking about eliminating a class of bugs, but you don't
> seem to get the point and you are fixated on the very instance of this
> bug class.

Let's take this one step at a time. I think patches 1-4 are fine and
stand alone and solve a specific problem without creating any new
immediate problems.

After 1-4 is accepted, we can come back around to what patch 5 is trying
to do, and work on whatever issues may remain at that time.

-- 
Kees Cook

