Return-Path: <bpf+bounces-31956-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7450390582E
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2024 18:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F8D91F215CD
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2024 16:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D903180A8A;
	Wed, 12 Jun 2024 16:09:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A6A182AF;
	Wed, 12 Jun 2024 16:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718208543; cv=none; b=dv5sUdtiACGol90MJRxPUCTNQo6f3oibyySK2ZSMEzV5znv4ucxU8II7WuTyhbATW5Nf2cz37cX4YMTXglziXozFAU5WvqMphoKPPK3r05lAJzuKQe17aIk9TNlYKMhAXvlHruCNBPL+5IO8LEkrh977ewLzsrSjKnw72bl6haU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718208543; c=relaxed/simple;
	bh=gFULfkjrENjI7mJ0f3lqXeT0E2K4H0Hh2HhV5zoDq/4=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CVzBXQ8UJzL1oKFsh6p4wnwBJtOsbN3NEuqDwoKBFbIkB6llKMBC69cFSjlKf48QZSU03rbM/ngQPsl8KzzKhq5LgCuQ8I1SouhI8qeJKIAEscOHE70zfUKicT7/FqI4NY2/sRxa0TXMvxe/ovtA34MV/lbjwcqlepEZUetPwIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1B51C116B1;
	Wed, 12 Jun 2024 16:09:00 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>,
	Sumit Garg <sumit.garg@linaro.org>,
	Stephen Boyd <swboyd@chromium.org>,
	Douglas Anderson <dianders@chromium.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Puranjay Mohan <puranjay@kernel.org>
Subject: Re: [PATCH v3 1/2] arm64/arch_timer: include <linux/percpu.h>
Date: Wed, 12 Jun 2024 17:08:58 +0100
Message-Id: <171820853478.4013877.11908320926391379068.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240503171847.68267-1-puranjay@kernel.org>
References: <20240503171847.68267-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 03 May 2024 17:18:46 +0000, Puranjay Mohan wrote:
> arch_timer.h includes linux/smp.h since the commit:
> 
>   6acc71ccac7187fc ("arm64: arch_timer: Allows a CPU-specific erratum to only affect a subset of CPUs")
> 
> It was included to use DEFINE_PER_CPU(), etc. But It should have
> included <linux/percpu.h> rather than <linux/smp.h>. It worked because
> smp.h includes percpu.h.
> 
> [...]

Applied to arm64 (for-next/misc), thanks!

[1/2] arm64/arch_timer: include <linux/percpu.h>
      https://git.kernel.org/arm64/c/7647e2b109f4
[2/2] arm64: implement raw_smp_processor_id() using thread_info
      https://git.kernel.org/arm64/c/bf0baa5bbdc9

-- 
Catalin


