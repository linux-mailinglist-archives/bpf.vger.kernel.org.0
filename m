Return-Path: <bpf+bounces-60781-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 162AEADBDD3
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 01:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D83601891B03
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 23:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9AD2264D4;
	Mon, 16 Jun 2025 23:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uLmnTxEg"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689A4136349;
	Mon, 16 Jun 2025 23:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750117741; cv=none; b=ITuVBjR7/vQiMGGqma1nmq9LIjaXiYLNafAIcvDCpoDY+Gv0MK1kFHy1eeX0aHfPf1nFtWPx72KxcNsXdFcDE6uQZB22PyPmk1Rp8V+trv3YAfjyuBqX9hTXr9TJkGdWla2+JQI0afy0y5K9huYgSkkmY9QDWseZyCRtBKdiUmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750117741; c=relaxed/simple;
	bh=xK2Nrlwu7G6iv8WQURJrT+89oquNLSs2X1sO/pypvt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o/Dp/HvXH5sO5+JBsOzOzDYHaMycFTuCmXaQbVoJIEX5rT5TDnDgP3JZBTTfkluaNy0tlY5IZvoeXsvFQWlZYJr0vFyMk5Shodw3rBg5Fs2nL0vFHJte/lVP1mXazA4g0D3cwLa8ylvMJVYToZE4bxhOfhhXn8uHHBr8xYBy0OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uLmnTxEg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73A6CC4CEEA;
	Mon, 16 Jun 2025 23:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750117740;
	bh=xK2Nrlwu7G6iv8WQURJrT+89oquNLSs2X1sO/pypvt0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uLmnTxEgbccbxLmLLLyNQc9UP9DBcBqwRwiLHSlyimhqUta85UQKFFf99IAiHtd56
	 IhdglFY4ZeP1ki4N+OMmvdkPxnD4wv/cPv/E7/zLOH/dVCZ+4zgFsUvSd8QsGuygSQ
	 97/wAAgcaC44mBoo14LNVcRMfKdo7GjZsRKHJokvLDmTY3eRXJeJgpf6mr5EJHvdZg
	 g9v8YVnbhYKKpSdAgC5Ewwx/hLcifu8emKRl45intC30BkEDhAJ/DTyPNVZ8GO1vAl
	 M/TWifViC5QenukHzCgQ009zpiAEZ5qJkCDIhLhqCcVfGw7RJHMYXrVKGVl22d4IkP
	 roILkeU586ZCg==
Date: Mon, 16 Jun 2025 23:48:57 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: KP Singh <kpsingh@kernel.org>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
	bboscaccy@linux.microsoft.com, paul@paul-moore.com,
	kys@microsoft.com, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org
Subject: Re: [PATCH 01/12] bpf: Implement an internal helper for SHA256
 hashing
Message-ID: <20250616234857.GC23807@google.com>
References: <20250606232914.317094-1-kpsingh@kernel.org>
 <20250606232914.317094-2-kpsingh@kernel.org>
 <20250612190739.GC1283@sol>
 <CACYkzJ5NbpTjwtWKx6ehqy7wyENovcFQVQqjO0-m9XoAJP=-nw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACYkzJ5NbpTjwtWKx6ehqy7wyENovcFQVQqjO0-m9XoAJP=-nw@mail.gmail.com>

On Tue, Jun 17, 2025 at 01:40:22AM +0200, KP Singh wrote:
> On Thu, Jun 12, 2025 at 9:08 PM Eric Biggers <ebiggers@kernel.org> wrote:
> >
> [...]
> >
> > You're looking for sha256() from <crypto/sha2.h>.  Just use that instead.
> 
> I did look at it but my understanding is that it will always use the
> non-accelerated version and in theory the program can be megabytes in
> size, so might be worth using the accelerated crypto API. What do you
> think?
> 

I fixed that in 6.16.  sha256() gives you the accelerated version now.

- Eric

