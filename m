Return-Path: <bpf+bounces-58852-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E613AC290A
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 19:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F0E97B8EF7
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 17:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEAE729899F;
	Fri, 23 May 2025 17:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="menGhm68"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4695A22338;
	Fri, 23 May 2025 17:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748022473; cv=none; b=i4C/1ezKhHe5JpZScJUdHZOFyx6c5rYgXYPnh2SKrPVP1oCobMEoiCZlGqo3A30W+AwH06bZcH6FXFOy7i+ijePFKm3X8+UOzoWK36UT95gueEMk2iblEIscxisEXYbSoc8BizJR0n+7XCpCQS/kfxpE4w3iIIaQVLJKdTevFQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748022473; c=relaxed/simple;
	bh=KQHffdcK+pgKnpDycOnrf91EBuZiAG9UyXalXASU+v4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R5uFg6XhIbhFkXxMTCI/bIY0kGf3pEyOSuDu8OPRnUQhEftH2YV9Gyrzv73iA8YLHLKci7jJ1LY+gUt1enGwvlel0+PsT7YOcFDwJqvmI23hO5tHH29dNZhrQhZmNXlm8RvmWNTbBbSiLtjMPdgB8a6zUhAe6r+v8jT3lH/Vn9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=menGhm68; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86427C4CEE9;
	Fri, 23 May 2025 17:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748022471;
	bh=KQHffdcK+pgKnpDycOnrf91EBuZiAG9UyXalXASU+v4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=menGhm68KfXF2wIOpFdKykmCpxaF8ppuiICrk0Vau1/319BnZIsA29aUs50AVHO3F
	 zFKopEztqobsg4z3SMHQWr8ozPwG59wCBIR5GX5rourhAoP67T8YhYUdiibNOz4FW0
	 iPqOLbEm53pDiaM9TMasuUxkY+N6DGu1LMEDJnQgp9v3C/PkiqtjRsMV6SI2AKLZLg
	 ceaHUnM9/NwtBSe5qu70WXXTXyX/H17Jm2zbkgN+w0NxF7DnSdmXIO1a+rajmDwcmx
	 nul6VwC9oqBeDObxGAv8GzdhMwTTwdXWag71nitRtVZ6mduGGZHwQDaY9Bq4wnYWOd
	 O2E+3ukleqcHg==
From: SeongJae Park <sj@kernel.org>
To: Byungchul Park <byungchul@sk.com>
Cc: SeongJae Park <sj@kernel.org>,
	willy@infradead.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel_team@skhynix.com,
	kuba@kernel.org,
	almasrymina@google.com,
	ilias.apalodimas@linaro.org,
	harry.yoo@oracle.com,
	hawk@kernel.org,
	akpm@linux-foundation.org,
	davem@davemloft.net,
	john.fastabend@gmail.com,
	andrew+netdev@lunn.ch,
	asml.silence@gmail.com,
	toke@redhat.com,
	tariqt@nvidia.com,
	edumazet@google.com,
	pabeni@redhat.com,
	saeedm@nvidia.com,
	leon@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	horms@kernel.org,
	linux-rdma@vger.kernel.org,
	bpf@vger.kernel.org,
	vishal.moola@gmail.com
Subject: Re: [PATCH 00/18] Split netmem from struct page
Date: Fri, 23 May 2025 10:47:48 -0700
Message-Id: <20250523174749.58392-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250523032609.16334-1-byungchul@sk.com>
References: 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Byungchul,

On Fri, 23 May 2025 12:25:51 +0900 Byungchul Park <byungchul@sk.com> wrote:

> The MM subsystem is trying to reduce struct page to a single pointer.
> The first step towards that is splitting struct page by its individual
> users, as has already been done with folio and slab.  This patchset does
> that for netmem which is used for page pools.

I found checkpatch.pl outputs some complaints to a few patches of this
patch series.  Most warnings and errors look not critical or even unnecessary,
but seems some of those would better to be reduced in my opinion.


Thanks,
SJ

[...]

