Return-Path: <bpf+bounces-56636-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0DAA9B6C1
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 20:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF9E1927B95
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 18:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FDDF28E5E1;
	Thu, 24 Apr 2025 18:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qiottNsh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656D1155342;
	Thu, 24 Apr 2025 18:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745520715; cv=none; b=YFT061CCTpLuBc69c2XD+bGx3VBYobgyKxIPxfPKFvH56HshemHsHrxRDgJJtiqLGBJN5ylMV8OEKQSVpOUbi+xx0D+kfrIoqvyb1iSrf1LCrY45HfGQL6AFdXxV9+MuK+bqY/uBO1udyxQB7XLlHODLmZaxAxI8o8hhVKK4L8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745520715; c=relaxed/simple;
	bh=v+0hjcLc+iKWUqMJmXjTqbssY3oDq1sDVgbQL6UbPqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ro05mX0RsTCFS5Ye4Ip39U0u7Fbz0yoU2y3A5iKXE14wk7k/9bhepUooAUiAWXQ1lu3FmWwirYqzbN8F/ptCeCvjk7I5b6CbJk1hs8hp0BkfixZOwamNWorM/Yi88qkrk38uixR7uXcUYHRh4CK3JU5CxsiOnTWJ5TfgdS4nThU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qiottNsh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B92DAC4CEE3;
	Thu, 24 Apr 2025 18:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745520714;
	bh=v+0hjcLc+iKWUqMJmXjTqbssY3oDq1sDVgbQL6UbPqs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qiottNsh571nFLJULZWcKjrVK3UAryulXSZb7xkhJGDxbt0cvlo5EMuuP2RGsSaTF
	 g9ytTykWxqAyb1MQNKJAdsaBAlA921HpgqDupGBXu5GHAUVuhPqeSDKiDIMg8uG0n9
	 SZIxWKGJTu20l8QYdT0DtOVppbEt0LYIM9Uz7780=
Date: Thu, 24 Apr 2025 14:51:51 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: patchwork-bot+netdevbpf@kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Network Development <netdev@vger.kernel.org>
Subject: Re: [PATCH 0/3] selftests/bpf: Fix a few issues in arena_spin_lock
Message-ID: <20250424-imported-beautiful-orangutan-bb09e0@meerkat>
References: <20250424165525.154403-1-iii@linux.ibm.com>
 <174551961000.3446286.10420854203925676664.git-patchwork-notify@kernel.org>
 <CAADnVQL2YzG1TX4UkTOwhfeExCPV5Sj3dd-2c8Wn98PMsUQWCA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQL2YzG1TX4UkTOwhfeExCPV5Sj3dd-2c8Wn98PMsUQWCA@mail.gmail.com>

On Thu, Apr 24, 2025 at 11:41:16AM -0700, Alexei Starovoitov wrote:
> On Thu, Apr 24, 2025 at 11:32 AM <patchwork-bot+netdevbpf@kernel.org> wrote:
> >
> > Hello:
> >
> > This series was applied to netdev/net-next.git (main)
> > by Jakub Kicinski <kuba@kernel.org>:
> >
> > On Thu, 24 Apr 2025 18:41:24 +0200 you wrote:
> > > Hi,
> > >
> > > I tried running the arena_spin_lock test on s390x and ran into the
> > > following issues:
> > >
> > > * Changing the header file does not lead to rebuilding the test.
> > > * The checked for number of CPUs and the actually required number of
> > >   CPUs are different.
> > > * Endianness issue in spinlock definition.
> > >
> > > [...]
> >
> > Here is the summary with links:
> >   - [1/3] selftests/bpf: Fix arena_spin_lock.c build dependency
> >     https://git.kernel.org/netdev/net-next/c/4fe09ff1a54a
> >   - [2/3] selftests/bpf: Fix arena_spin_lock on systems with less than 16 CPUs
> >     (no matching commit)
> >   - [3/3] selftests/bpf: Fix endianness issue in __qspinlock declaration
> >     (no matching commit)
> 
> Hmm. Looks like pw-bot had too much influence from AI bots
> and started hallucinating itself :)

I'll look into what happened here.

-K

