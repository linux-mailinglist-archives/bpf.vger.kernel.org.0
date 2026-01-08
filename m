Return-Path: <bpf+bounces-78249-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A98E7D0601E
	for <lists+bpf@lfdr.de>; Thu, 08 Jan 2026 21:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7D9C303194E
	for <lists+bpf@lfdr.de>; Thu,  8 Jan 2026 20:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02C632ED24;
	Thu,  8 Jan 2026 20:13:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E9D329C53;
	Thu,  8 Jan 2026 20:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767903204; cv=none; b=bsghpU7f0H14yvF5MU7J+Fnzw9Jotw8VhC5sIkdGze3t+WgGRL7KuuoEmDj2pjfArDKU/EYSzCxJM/bbKlQxs/Y4NhPNq7UiQeQeE9HmNV2115fOxaJR19tUuT0M9zH63+S62IaftBdXVGIqmMr9C2nNTedkdqZMzCrgQI3o2dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767903204; c=relaxed/simple;
	bh=z0PPlUqC7r8L1j3NK1evCkqSyRSxLM4/O9nRp9vaMTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FXa1DOKEdwMKruDn1xIY89yYJEnA0V5fc/HuxWiycMUw8nQeYJ0w7zE28UzuM1YJDJuTdkKY/uY+wnfZFt7Ljk2sm/zKSBjlHQNb934RKiCI5WEG9sVZMITwOhLUuuGrY7z/H86vVyP54TOKDZhEJGaa7qwHUps4nuzPSqnTrKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB1A8497;
	Thu,  8 Jan 2026 12:13:14 -0800 (PST)
Received: from arm.com (arrakis.cambridge.arm.com [10.1.197.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DA72A3F5A1;
	Thu,  8 Jan 2026 12:13:15 -0800 (PST)
Date: Thu, 8 Jan 2026 20:13:11 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: kasan-dev@googlegroups.com, andreyknvl@gmail.com,
	Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: dvyukov@google.com, vincenzo.frascino@arm.com, ryabinin.a.a@gmail.com,
	glider@google.com, linux-mm@kvack.org,
	Jiayuan Chen <jiayuan.chen@shopee.com>,
	Will Deacon <will@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Yang Shi <yang@os.amperecomputing.com>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Huang Shijie <shijie@os.amperecomputing.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH v1] kasan,mm: fix incomplete tag reset in
 change_memory_common()
Message-ID: <176790294571.2289790.2180517635826904022.b4-ty@arm.com>
References: <20260104123532.272627-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260104123532.272627-1-jiayuan.chen@linux.dev>

(for some reason, I did not get this email, our server dropped it;
thanks to Will for telling me)

On Sun, 04 Jan 2026 20:35:27 +0800, Jiayuan Chen wrote:
> Running KASAN KUnit tests with {HW,SW}_TAGS mode triggers a fault in
> change_memory_common():
> 
>   Call trace:
>    change_memory_common+0x168/0x210 (P)
>    set_memory_ro+0x20/0x48
>    vmalloc_helpers_tags+0xe8/0x338
>    kunit_try_run_case+0x74/0x188
>    kunit_generic_run_threadfn_adapter+0x30/0x70
>    kthread+0x11c/0x200
>    ret_from_fork+0x10/0x20
>   ---[ end trace 0000000000000000 ]---
>       # vmalloc_helpers_tags: try faulted
>       not ok 67 vmalloc_helpers_tags
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] kasan,mm: fix incomplete tag reset in change_memory_common()
      https://git.kernel.org/arm64/c/5fcd5513072b

-- 
Catalin

