Return-Path: <bpf+bounces-55193-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BA8A798CD
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 01:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E4DB188CECB
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 23:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E861F63D9;
	Wed,  2 Apr 2025 23:27:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD5473477;
	Wed,  2 Apr 2025 23:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743636469; cv=none; b=Du9tctchjph4QTjmu7M31daPws6JgNFNYW17F3/4xg6Nh7ZODH/3QPuskZDxvyOzRfxzmRqn+qFOo1bM1jnMqVyRpmJ+IHl1HN/QTjTzNoOxBKoxesjw0T1d5+TVAec7m3Lf/d0E9gRSek9rQ96oIb5pxzYk1WNZ85tbht7VkhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743636469; c=relaxed/simple;
	bh=1Uv31Ll1fQK0AqFMccftUdwxSBINZAldPxF7EF0eGss=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZDmUExh9CtmIMiJHZvpQYK3dG1JXtC+S/enf16EVVyjrC/1Gd3P4BHnk3WCr1Y+MO1427dCPrT9ujU9TSDPOqf2OxINIhySxC9b+TT0BRXiTdADJx3V20fcaR6BzgS3AriBOGRHW8GJx2ba2Np1zhFpW8cQVazXoDV9D66860Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A841C4CEDD;
	Wed,  2 Apr 2025 23:27:47 +0000 (UTC)
Date: Wed, 2 Apr 2025 19:28:51 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Masami Hiramatsu"
 <mhiramat@kernel.org>, "Catalin Marinas" <catalin.marinas@arm.com>, "Nathan
 Chancellor" <nathan@kernel.org>, "Ilya Leoshkevich" <iii@linux.ibm.com>,
 "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev"
 <agordeev@linux.ibm.com>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] scripts/sorttable: Fix endianness handling in
 build-time mcount sort
Message-ID: <20250402192851.0bc6fc77@gandalf.local.home>
In-Reply-To: <6acbc2347a86153c2646a4bfebaa226e9b0e01f7@linux.dev>
References: <patch.git-dca31444b0f1.your-ad-here.call-01743554658-ext-8692@work.hours>
	<6acbc2347a86153c2646a4bfebaa226e9b0e01f7@linux.dev>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 02 Apr 2025 23:22:40 +0000
"Ihor Solodrai" <ihor.solodrai@linux.dev> wrote:

> Hi Vasily,
> 
> I can confirm that this patch fixes BPF selftests on s390x:
> https://github.com/kernel-patches/vmtest/actions/runs/14231181710
> 
> Tested-by: Ihor Solodrai <ihor.solodrai@linux.dev>

Thanks, but I already submitted a pull request that includes this fix, as
it looked pretty obvious (I did run it through all my normal tests, but
just didn't test the big/little endian case).

  https://lore.kernel.org/all/20250402174449.08caae28@gandalf.local.home/

-- Steve

