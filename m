Return-Path: <bpf+bounces-75176-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B46C9C75DD6
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 19:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 88B732CE00
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 18:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F98333439;
	Thu, 20 Nov 2025 18:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VY3NzBAO"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB8B1F0995;
	Thu, 20 Nov 2025 18:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763661859; cv=none; b=MyiOhrCtth74BJF9F2DtSt/gK5p2qTQHxgSOe21aXQUAF0JOLs0XDf4EqQeJAOVZXcIfd8YSzd9sw++KGhix6Ak2A+goQapBjOCS1ajWHGhza8jN+9dUpTJgnjuEeH0H/9WlDDNjsuOcK6iJgg6EZZSZvuyikhm5EfOw6a2BeJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763661859; c=relaxed/simple;
	bh=EadW+89Qrbcrtd+y7+ujksQ1tYM40RiXEDOZuCtI+M4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=HFvqOfNmd3zTjfE3eYN+YCLB08a6YVdgiIn10dJD+a1WybaQpM9dfSgGPXJnRiv7CgmdX1tN+A8TgbLvmVzvQrt4g2SPHivN7cT21PU+dO0o8HscGvo4dqHV1m5bMS2xx/clH+qtOjtWItLhmaGoEH6poU7KxKG/+TJxGqJpV0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=VY3NzBAO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 961BAC4CEF1;
	Thu, 20 Nov 2025 18:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1763661858;
	bh=EadW+89Qrbcrtd+y7+ujksQ1tYM40RiXEDOZuCtI+M4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VY3NzBAOiH6eZCc9KPPa0MLhZqdlj+P4bYZlCQrIQ5afcx/GC81pKWXzYs7BMcStE
	 s+RCjaghyp7q5KhRRiRi1EsNrkzfeozbdD0r/cfUuZltooFQadczhnfWP8wjrWMfGG
	 GHXYIVYzrqR8I9Mc/VW6dhhEHNT2Y3MLTD1uG/XA=
Date: Thu, 20 Nov 2025 10:04:18 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: SeongJae Park <sj@kernel.org>
Cc: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org,
 Uladzislau Rezki <urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v3 0/4] make vmalloc gfp flags usage more apparent
Message-Id: <20251120100418.76d173758d03fbc60a4299ba@linux-foundation.org>
In-Reply-To: <20251120010303.74537-1-sj@kernel.org>
References: <20251117173530.43293-1-vishal.moola@gmail.com>
	<20251120010303.74537-1-sj@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Nov 2025 17:03:02 -0800 SeongJae Park <sj@kernel.org> wrote:

> On Mon, 17 Nov 2025 09:35:26 -0800 "Vishal Moola (Oracle)" <vishal.moola@gmail.com> wrote:
> 
> > We should do a better job at enforcing gfp flags for vmalloc. Right now, we
> > have a kernel-doc for __vmalloc_node_range(), and hope callers pass in
> > supported flags. If a caller were to pass in an unsupported flag, we may
> > BUG, silently clear it, or completely ignore it.
> > 
> > If we are more proactive about enforcing gfp flags, we can making sure
> > callers know when they may be asking for unsupported behavior.
> > 
> > This patchset lets vmalloc control the incoming gfp flags, and cleans up
> > some hard to read gfp code.
> 
> For the series,
> 
> Acked-by: SeongJae Park <sj@kernel.org>

Thanks.

> > 
> > ---
> > Linked rfc [1] and rfc v2[2] for convenience.
> > 
> > Patch v2 -> v3:
> >   Only changes the whitelist mask and comment in patch 1:
> 
> I'd suggest s/whitelist/allow-list/.

Yeah, it's the modern way.  But this was below the ^---$ separator so
it went away anyway.

