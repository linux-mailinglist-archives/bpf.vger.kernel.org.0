Return-Path: <bpf+bounces-31530-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9DA8FF44C
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 20:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEAEF28A6C1
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 18:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C6219A282;
	Thu,  6 Jun 2024 18:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f5s59++m"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C0716FF26;
	Thu,  6 Jun 2024 18:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717697243; cv=none; b=BmwFDsjXvHKadtXn91rGy8fHvO/71k9bE44Rhf5ieq3/EnsEAICRXlUeu7V3v9TK+LhFLOZmMMCvB389j69/BheeSJi1jQ7NNePI4pe/AeWsc8GpyeVHONbG9GIFdFlIigBHSSx7pPXELCVUslVsmYQH8etS/sClW2BfuqfZmX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717697243; c=relaxed/simple;
	bh=aZojnkR8OHqTvCRPx8BRkZ2FGcBOyZP/LRYz4CpLm9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GVw/7jLvojidINUu9rV+Nf3tUOwXDuOv+pEmQ1JRvt+uZ2foMtJ3LPSjp68o7PNrAIBGYJ3VodMv0dMAMz1d54+T3Qy2KHdrHR9hGcn0wgAKGwQRf//n2I6cy1tS3vlck8naZphhMueFfh+PXmSUjg8RoVvlKGeNwcXN1gBt+y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f5s59++m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3807C2BD10;
	Thu,  6 Jun 2024 18:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717697243;
	bh=aZojnkR8OHqTvCRPx8BRkZ2FGcBOyZP/LRYz4CpLm9w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f5s59++mQaKs8pYNLpQey9LcYzoGhFSVo6b2L2H3eR+1O+Z6JXycasQ/R72kZkAjI
	 bqlvpb/WLs34mT4oIiC//qbPwWwFVAKgZK82MA3bFWsMzc5DPrz+bDrt6XdDAwM39v
	 jWaR7Caa6iZTrQTek4zxp3xjzOXtXqdwBJFRAKd51IcflkitYtAUG+SKQdwFQ80vmT
	 vCxBd1XFFQyQ2B43yymfyt2MVqDjuHjp74ummXeL5HL1CqezULhDoVfbc+1MiHmO4D
	 W7rKR+IsvG70aMw/gJIcjg/YczdAfuD11UQy+Kz9CZ/5I0SKVdTFuQT43zLw05vGHr
	 JHR+fDlIFDaxg==
Date: Thu, 6 Jun 2024 11:07:22 -0700
From: Kees Cook <kees@kernel.org>
To: Paul Moore <paul@paul-moore.com>
Cc: KP Singh <kpsingh@kernel.org>, linux-security-module@vger.kernel.org,
	bpf@vger.kernel.org, ast@kernel.org, casey@schaufler-ca.com,
	andrii@kernel.org, daniel@iogearbox.net, renauld@google.com,
	revest@chromium.org, song@kernel.org
Subject: Re: [PATCH v12 0/5] Reduce overhead of LSMs with static calls
Message-ID: <202406061049.F2FD4F8A@keescook>
References: <20240516003524.143243-1-kpsingh@kernel.org>
 <202406060856.95CBD48@keescook>
 <CAHC9VhQ1NfdPZ1WVKTnsYmMt_0Lvb0XKMS3EqLKHQrX78yjohg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhQ1NfdPZ1WVKTnsYmMt_0Lvb0XKMS3EqLKHQrX78yjohg@mail.gmail.com>

On Thu, Jun 06, 2024 at 12:36:03PM -0400, Paul Moore wrote:
> It's in the queue, I've been swamped lately as you'll likely notice I
> haven't really had a chance to process patches yet during this cycle.

I get that you're busy, and I understand that situation -- I get swamped
too. The latency on LSM patch review has been very high lately, and I'm
hoping there's some way we could help. I assume other folks could jump
in and help with the queue[1], but I'm not sure if that would satisfy
your requirements? Other subsystems have been switching more and more to
a group maintainership system, etc. Are there other people you'd be
comfortable sharing the load with? (Currently James and Serge are also
listed as "M:" in MAINTAINERS, but I don't think the 3 of you have a
shared git.kernel.org tree, for example...)

And yes, there are a lot of patches up for review. I'm antsy about this
series in particular because I'm worried inaction is going to create
larger problems for the LSM as a whole. We've already had Linus drop
in and tell us to do better; I'd really like to avoid having him make
unilateral changes to the LSM, especially when we have a solution on
deck that has been reviewed by many people.

I will go back to being anxious/patient... ;)

-Kees

[1] https://patchwork.kernel.org/project/linux-security-module/list/

-- 
Kees Cook

