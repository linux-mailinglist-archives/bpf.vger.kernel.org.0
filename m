Return-Path: <bpf+bounces-72847-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD46C1CC5B
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 19:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D891E188A182
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 18:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89AAB3559F0;
	Wed, 29 Oct 2025 18:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ndpPn+k4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D982DBF75
	for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 18:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761762375; cv=none; b=JORBe9y3I5AG0leNNnfjfvAZ0/qvhI2kSM9xtLUC+B7urSzt4wnKPlslaIIKbG+Kd2Bu3voffDcKOp3dSeZFIOfHgTBvo279xhULRvKtL9S+9EntKGvJXw82Z6mfrpNnGM7gj0JZd4Lzo+KDVmJ7jMudYydjpPZYDGym6ovMGfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761762375; c=relaxed/simple;
	bh=SOFE0nE/iwywHZBzY2PA6i2R26wO5/VtY5Jl8lJ4X0I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CxpK7/kIp9hKws5L1qXnOr48+vcfPLnPV/K4umT7SyvLRaQRuAZngAhOuoSLuJ9OiGKmNZMJVinyn84ufOMn68WAliTBRJjvdIDGoYf5ELYQ9n+h391t+BDKHLAeDFQUeURBGAijJC0Ze+7iu5zYArzqg5jeJbp00N3fQlikOSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ndpPn+k4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2806C113D0
	for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 18:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761762374;
	bh=SOFE0nE/iwywHZBzY2PA6i2R26wO5/VtY5Jl8lJ4X0I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ndpPn+k4EfUaw6fNwY0zWNL1ecVLo8aBHRZnSz07kFgD/dq8DvyELXxj76gXV4oVi
	 ktU0XjzrjKbY7uijyq0vT7UtIcjyb/ND1tDToftHHtDIAiRt0YVm3arL2lh8baMuAI
	 +vz8+RoK0Jww3pqJv+AvrM17kvv5Zn3eqLes/WMlFA/6VE5WWXYm60bfEKGra5Xg6r
	 thZTXHsYe14mAvd0C1rleJrkFPDe0BuI4HmI2JV5mxGnO4BhQlXQdt5qvo6Gy0KBaT
	 P6l6n7spmgQ3gWjfr6j6dtYxaD0JXVPuWt+vLn28H15m5YyfxxytbyH5B0vKNTckDF
	 7LduBId0jKXTw==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-378cffe5e1aso1038211fa.2
        for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 11:26:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV44/luW+6rDE12Bf6xGuDGu5KLRWKZfEqla59RwAm60sLZ8Illzz0VIuRa+zf61Sh/zzY=@vger.kernel.org
X-Gm-Message-State: AOJu0YziGKYGHnaG+HJGnDfiyKhLh2AKuMZr/kH/ycRy4OH8aqUsUGJ/
	Ivx3na6RvUx1lTTBq7X2M/2J5D4PpwbkTtHKs7CN+4qA1A5EmTL3ItOUt8fgfbcoNzOVE68wStp
	9XcpMUePCxEkrfxfhLDr/Ana6ea54Wy4=
X-Google-Smtp-Source: AGHT+IGWFfmJwHuAqzPgZNMRZ1ozVQDIzy88Y1FgQVzyMri4R3xOByg4mInRl7CgPci19RHNrfDbNPxS6PSkoSTGQDU=
X-Received: by 2002:a05:651c:1986:b0:365:b79:8845 with SMTP id
 38308e7fff4ca-37a023ba9e9mr11427831fa.10.1761762372950; Wed, 29 Oct 2025
 11:26:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028004614.393374-1-viro@zeniv.linux.org.uk>
 <20251028004614.393374-23-viro@zeniv.linux.org.uk> <66300d81c5e127e3bca8c6c4d997da386b142004.camel@HansenPartnership.com>
 <20251028174540.GN2441659@ZenIV> <20251028210805.GP2441659@ZenIV>
 <CAMj1kXF6tvg6+CL_1x7h0HK1PoSGtxDjc0LQ1abGQBd5qrbffg@mail.gmail.com> <20251029180835.GT2441659@ZenIV>
In-Reply-To: <20251029180835.GT2441659@ZenIV>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 29 Oct 2025 19:26:01 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEB+W6wNDUnWeaeiuRqR-AKDwNhsoCAXokAEqRjSt7v7Q@mail.gmail.com>
X-Gm-Features: AWmQ_bl33W7u9Z27QoRt9V2mEw_lUKBXPTlGyVImKaOffP2I82t-eoqvuUfjNRY
Message-ID: <CAMj1kXEB+W6wNDUnWeaeiuRqR-AKDwNhsoCAXokAEqRjSt7v7Q@mail.gmail.com>
Subject: Re: [PATCH v2 22/50] convert efivarfs
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, linux-fsdevel@vger.kernel.org, 
	torvalds@linux-foundation.org, brauner@kernel.org, jack@suse.cz, 
	raven@themaw.net, miklos@szeredi.hu, neil@brown.name, a.hindborg@kernel.org, 
	linux-mm@kvack.org, linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev, 
	kees@kernel.org, rostedt@goodmis.org, gregkh@linuxfoundation.org, 
	linux-usb@vger.kernel.org, paul@paul-moore.com, casey@schaufler-ca.com, 
	linuxppc-dev@lists.ozlabs.org, john.johansen@canonical.com, 
	selinux@vger.kernel.org, borntraeger@linux.ibm.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 29 Oct 2025 at 19:08, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Tue, Oct 28, 2025 at 10:34:51PM +0100, Ard Biesheuvel wrote:
>
> > I'll let James respond to the specifics of your suggestion, but I'll
> > just note that this code has a rather convoluted history, as we used
> > to have two separate pseudo-filesystem drivers, up until a few years
> > ago: the sysfs based 'efivars' and this efivarfs driver. Given that
> > modifications in one needed to be visible in the other, they shared a
> > linked list that shadowed the state of the underlying variable store.
> > 'efivars' was removed years ago, but it was only recently that James
> > replaced the linked list in this driver with the dentry cache as the
> > shadow mechanism.
>
> Hmm...  Another question about that code: is efivar_get_variable()
> safe outside of efivar_lock()?

Not according to its kerneldoc

/*
 * efivar_get_variable() - retrieve a variable identified by name/vendor
 *
 * Must be called with efivars_lock held.
 */

But actually, I'm not convinced this is accurate. The reason for
locking at this level is mainly to ensure that a SetVariable() call
does not interfere with an ongoing enumeration calling
GetNextVariable() in a loop. The individual EFI runtime calls are
still serialized at a lower level, given that the firmware is not
reentrant, and so holding efivars_lock does not provide anything
meaningful for a GetVariable() call.

