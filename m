Return-Path: <bpf+bounces-58517-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E25ABCBE5
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 02:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E6D43B681F
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 00:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1031C1F22;
	Tue, 20 May 2025 00:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UBmmaPDs"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E9F1B042C;
	Tue, 20 May 2025 00:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747699568; cv=none; b=VMMzPRC6XfcggBmIqN5WPSuwdDs5wkO3jOC0XG3nbzQp4J6yiAhnPa+ho3eiD/rN3rXzMlPSRAs299Q5BHX4QZ2WvbnEqb/ES/tVB3gz7BfilfJ+CWQNywZQtO1EgvBv+M3XCrBL4PeFgyPplCQsMbk6+bKFS4ioQoqCew4bRGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747699568; c=relaxed/simple;
	bh=MLmWWAhsV7Skm2n1JrtLQVRQUmxUvpFL/4s1COZZ7iQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=JXSHAhuRpgIiS5qS1U3nmuKb9Hk61FIHv4UfVmulH1D3mdo+aWjxKCaAfanpsF89h1KWx5Yeq95eF1v+0vZRTanJkrlzdR8Rf+JcDwl8YW+jZiDbBDCIFpHo9jQKOqGIvkSSkyA7ANCZ2O/4xLEitMRQwUf6lIzJZCZT6xMq0b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UBmmaPDs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DC21C4CEE4;
	Tue, 20 May 2025 00:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1747699568;
	bh=MLmWWAhsV7Skm2n1JrtLQVRQUmxUvpFL/4s1COZZ7iQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UBmmaPDsoZYHx8Fdql+2DqKX0LL8iTPmo2xcINgKzMPZYqFhYe1kVcCf2fr7a/cAE
	 eQakaes0uMmbRDB+dnnWf9zQlY5cquv6lIIUHuKPvca7GcGQNPap5VVt1eIOo0GNib
	 Jn0EbPaXeXr0KHgO2tsJ6nTe13i8+QOQ/OwuiINY=
Date: Mon, 19 May 2025 17:06:07 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Kees Cook <kees@kernel.org>
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>, Eduard Zingerman
 <eddyz87@gmail.com>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Uladzislau Rezki <urezki@gmail.com>, Erhard Furtner <erhard_f@mailbox.org>,
 Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, bpf@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 0/2] mm: vmalloc: Actually use the in-place vrealloc
 region
Message-Id: <20250519170607.b8d9c23bb928935d19b333fa@linux-foundation.org>
In-Reply-To: <202505191217.B047E005F2@keescook>
References: <20250515214020.work.519-kees@kernel.org>
	<202505191217.B047E005F2@keescook>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 May 2025 12:18:42 -0700 Kees Cook <kees@kernel.org> wrote:

> On Thu, May 15, 2025 at 02:42:14PM -0700, Kees Cook wrote:
> > This fixes a performance regression[1] with vrealloc(). This needs to
> > get into v6.15, which is where the regression originates, and then it'll
> > get backport to the -stable releases as well.

No -stable backporting will be needed?

> Andrew, can you get these to Linus this week?

Sure.


