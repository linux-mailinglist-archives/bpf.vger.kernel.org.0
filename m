Return-Path: <bpf+bounces-48557-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE029A092A1
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 14:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8ECB169E87
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 13:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9AF420FA84;
	Fri, 10 Jan 2025 13:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZrPC4+1+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5EA20E718;
	Fri, 10 Jan 2025 13:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736517309; cv=none; b=Ra8nAhjn3JZZTneOUb3GsZrLrD5V1YOM5r8a5UF5VFeCTH18ElvYM8auUKBPBLJ09ZRBdqoE8qj2I7wxAxRNjneMXHfP+4zEhJhVK+kCiN3VBcAquhLUTAsgPDhaM4EiNBscreXlSV6avn5B8w1fp6qXPDpry6HHMWolypvx0Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736517309; c=relaxed/simple;
	bh=+Cqtonat93SUK3hhQ/z73NHSa5y4Yd0tksyBPPY9Y5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uDFep2+evusSIhldQDdq5lqRngX+uk5EAp97RCivydPqxX6uyKrqcW6TE57OqHfmbhzoX0XAJmRPcTgDZHtzJL4JKCBBxSfnzmHp5E5ikg2PjOAwVcgJEzGWgTPvcIvePlEyA0cpBfQ2QLABYwkPwo4cluQNLkilLsUrQ/zG6Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZrPC4+1+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75AACC4CEE0;
	Fri, 10 Jan 2025 13:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736517308;
	bh=+Cqtonat93SUK3hhQ/z73NHSa5y4Yd0tksyBPPY9Y5Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZrPC4+1+qalS1Yl7Eu1fCMCmizfA+/YpLC/OqInSRdhXeMnbnQvTMlx8Ck7pGZeqZ
	 VaR2PIFaBRVWVp/bxVlT+Zh6voJmW1dl9sNfIjDiyNJ44T/ekgPbnTZAdKAeZ6joN8
	 yDlRcCj9UisHKeXEgZscQmSfMdLbc0GsD/Re9jhTTrjSIqDZ0voR2rVP9uH5vUljom
	 XykdzyBP3OHddF41AoxQuWFZ85Jj0wp2NtM1hh9nr6E0/pEtEF+EMwzcbp1WFZ9uZ+
	 SMOaS0f6tyXs04OirO2QFXGTl7yznQvOcApSbAuMnYZcQa+Lf944k/OhT8D+Dwyg46
	 Bt7iRkP4FENXg==
Date: Fri, 10 Jan 2025 10:55:06 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: dwarves@vger.kernel.org, bpf@vger.kernel.org, alan.maguire@oracle.com,
	eddyz87@gmail.com, andrii@kernel.org, mykolal@fb.com,
	olsajiri@gmail.com
Subject: Re: [PATCH dwarves] btf_encoder: always initialize func_state to 0
Message-ID: <Z4Emuq-zVTk7FFuI@x1>
References: <20250110023138.659519-1-ihor.solodrai@pm.me>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250110023138.659519-1-ihor.solodrai@pm.me>

On Fri, Jan 10, 2025 at 02:31:41AM +0000, Ihor Solodrai wrote:
> @@ -1100,7 +1100,10 @@ static struct btf_encoder_func_state *btf_encoder__alloc_func_state(struct btf_e
>  		encoder->func_states.array = tmp;
>  	}
  
> -	return &encoder->func_states.array[encoder->func_states.cnt++];
> +	state = &encoder->func_states.array[encoder->func_states.cnt++];
> +	memset(state, 0, sizeof(*state));
> +
> +	return state;

Just a super nit, the following is equivalent and shorter:

	state = &encoder->func_states.array[encoder->func_states.cnt++];
	return memset(state, 0, sizeof(*state));

:-)

But nah, I'm appling your patch as-is.

Thanks!

- Arnaldo

