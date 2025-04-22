Return-Path: <bpf+bounces-56468-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0584A97B74
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 01:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C13C7A66A9
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 23:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A94B21CA07;
	Tue, 22 Apr 2025 23:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sBDa2fbN"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF9C2147F5;
	Tue, 22 Apr 2025 23:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745366373; cv=none; b=lGyzpWpUbuqQnoUNEY8nidpVL5ayyF4TFmK/eitJMeegqDK1gSA6kLqO2BdBNoB3EChmxAm9eYIixGlLbQiim2HLaRcH0Ma5pZcI/FSn06JOwce87ocGtFoICNOm4lZSqQPdugG1FQU3k4DHBNegh7KWQdmgHHQiROtyMMuDQ+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745366373; c=relaxed/simple;
	bh=ycZjgPaIiTSdeyslN0GksnwwiBHkct0VKuXNWg09bDE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ELngTHGGyu0a7uNaKnGzmEwho3UYDkgpAOUm2oAsWEK4I7rr/3W2IisjbNq3wSncXZWRkiCX16M526KS11h4CG9fa8p8i80Exym9mLX23olY9C6QTof9x4OMp1WXV2+yUXgWwHjea/PqK65L36+D2IaEBPqj4MsQnJeeeznSZC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sBDa2fbN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3CBEC4CEE9;
	Tue, 22 Apr 2025 23:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745366372;
	bh=ycZjgPaIiTSdeyslN0GksnwwiBHkct0VKuXNWg09bDE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sBDa2fbN+ugcqQjBhKpO4IlzaZyKlCfGckIAIuYOY3SFaKqdJ3mVXIy/C85T5fTqE
	 RaDxnHkZeYKrQ0FysCEyLN4gWw4SOQTXcrBWuRpCVwtuo8UFahX5E+eHyx38TP8Xy8
	 OTvsgVYNKgBZu73aLYFt3UwbwZuMcFT5xBnm4k3p4aqsDDQ5kEvhTAzoSMJnLdNx1G
	 Xdhol7CibXwum+8S5uzAdlI/m1JZ+xc29olHM1RkqMvH6liUna521JE86zejjZaT6C
	 U9LCMcD6jnimMk3uXrfzy+rpUDwAyDYnKr0PFMYovxmUPdQ5CMmO/l5XNRd4vqvHmU
	 z+ytFNVZH30IQ==
Date: Tue, 22 Apr 2025 16:59:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Justin Iurman <justin.iurman@uliege.be>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, kuniyu@amazon.com, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>, bpf
 <bpf@vger.kernel.org>, Stanislav Fomichev <stfomichev@gmail.com>, Sebastian
 Sewior <bigeasy@linutronix.de>, Andrea Mayer <andrea.mayer@uniroma2.it>,
 Stefano Salsano <stefano.salsano@uniroma2.it>, Paolo Lungaroni
 <paolo.lungaroni@uniroma2.it>
Subject: Re: [PATCH net v3] net: lwtunnel: disable BHs when required
Message-ID: <20250422165931.6d205a3c@kernel.org>
In-Reply-To: <20250416160716.8823-1-justin.iurman@uliege.be>
References: <20250416160716.8823-1-justin.iurman@uliege.be>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Apr 2025 18:07:16 +0200 Justin Iurman wrote:
> In lwtunnel_{output|xmit}(), dev_xmit_recursion() may be called in
> preemptible scope for PREEMPT kernels. This patch disables BHs before
> calling dev_xmit_recursion(). BHs are re-enabled only at the end, since
> we must ensure the same CPU is used for both dev_xmit_recursion_inc()
> and dev_xmit_recursion_dec() (and any other recursion levels in some
> cases) in order to maintain valid per-cpu counters.

Applied last night by Paolo, thanks!

