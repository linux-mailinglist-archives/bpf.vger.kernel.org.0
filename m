Return-Path: <bpf+bounces-35171-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 721F193813E
	for <lists+bpf@lfdr.de>; Sat, 20 Jul 2024 14:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A26BA1C214A4
	for <lists+bpf@lfdr.de>; Sat, 20 Jul 2024 12:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA1212DD9B;
	Sat, 20 Jul 2024 12:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="Eo/FgksV"
X-Original-To: bpf@vger.kernel.org
Received: from submarine.notk.org (62-210-214-84.rev.poneytelecom.eu [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5FB12D758;
	Sat, 20 Jul 2024 12:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721477582; cv=none; b=UDSF3xGf9f/t2v+x/PLDw3f0YJ1vDb8oqj3YJwq5TtK8mHkB1drS2PzjPE3RKh2WBii98GWsmmgN/uWEwDg95VwCk6GohheAN+jlcuBPuGif+S0cAzzPnZutw1ZflEo+FNaUFIhC+F8ovzH5e7rTQjWKBjm/voDExJfXAUMWdfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721477582; c=relaxed/simple;
	bh=Xi87ZsLBes8imKfr3/ypmOCcdmIQ//FnUI37ovOFKVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hWGGFxZ8GZRk78vLT6MgtCbUNlg2LdHUqVlvS678+aFHJSr9aKY1tIBu3FXb7Xg6nYSZJ6XzkqB0gS+fCJBFNCVpP1m0+EUBV3eMjK2SdLWRcjQb13/QjwM2Juk0CddpuGHpIX1vYJkEaCqqkXGoJLD5fZEKbVnCqn7xyjc7d/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=Eo/FgksV; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id B7DCB14C2DD;
	Sat, 20 Jul 2024 14:12:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1721477570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=inHqTJq2wE7kLgaUNqZKgnIPww4wEJomDyRlKC2R9h0=;
	b=Eo/FgksVadRqUNUyUnB0X7qPcndBSiD4a9SYL7MxaZAdc+Y78g5FERPnKx8fx1eBEJQGbP
	AU4SbE5W+hFZfU4XrXkALMPMvxur9R5dHs46K2Zztf6ZWu2JynuGDQMVTY0HjS0TntWiKN
	/L60cnUgBIXYBV5g7DKn9/ZtYqrC3TETZ0G6oRuiwdPLtXunQAVefg/ipwTDQ+IfwGdTNg
	PrD0AqxCtxdcgJ1O1zfXd5kh9fO9DfTlW6uk7P/qZuneY0oCLAOvy7YhNJ9KbOioc16Bcr
	QDETIPsT/BIheyqLqNc49LIyBjdos6CPJ5EzkCFc4lA3vMjr5tTP9llZk2VRTw==
Received: from gaia (localhost.lan [127.0.0.1])
	by gaia.codewreck.org (OpenSMTPD) with ESMTP id 901a445a;
	Sat, 20 Jul 2024 12:12:43 +0000 (UTC)
Date: Sat, 20 Jul 2024 21:12:28 +0900
From: asmadeus@codewreck.org
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Alan Maguire <alan.maguire@oracle.com>, ast@kernel.org,
	andrii@kernel.org, daniel@iogearbox.net, nathan@kernel.org,
	nicolas@fjasle.eu, martin.lau@linux.dev, eddyz87@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
	jolsa@kernel.org, bpf@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH bpf-next] kbuild, bpf: reproducible BTF from pahole when
 KBUILD_BUILD_TIMESTAMP set
Message-ID: <ZpuprMxsR_TIh2gM@codewreck.org>
References: <20240701173133.3283312-1-alan.maguire@oracle.com>
 <CAK7LNAStVrAx8LjDiYogRvS16-dZ+LrwcWq8gHnTbvKvR_JFFA@mail.gmail.com>
 <21ec0d92-fb99-41b3-b1b9-3b8a4504271c@oracle.com>
 <CAK7LNAS-pOi5a5vm4y1vPXh7WH_qtPuvnen3hvp9LrAm4+Q2fg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK7LNAS-pOi5a5vm4y1vPXh7WH_qtPuvnen3hvp9LrAm4+Q2fg@mail.gmail.com>

Masahiro Yamada wrote on Mon, Jul 15, 2024 at 08:19:53PM +0900:
> Kbuild already provides a standard mechanism.
> 
> 
> 
> 
> 
> config DEBUG_INFO_BTF_REPRODUCIBLE

Ah, I thought this was already an existing option but it's a suggestion
for a new one.

With my distro hat I have to say I have no interest in chasing more
reproducible knobs for the kernel -- the current trend in 99% of the
projects is that just setting SOURCE_DATE_EPOCH "just works" and the
every non-default option that is required is work for people to track,
enable in various packaging frameworks, backport to old kernels, update
if it ever changes...

I could understand a new option "toggle everything reproducible"
that would select this, even if it doesn't do anything else right now
(perhaps also complain if KBUILD_BUILD_TIMESTAMP isn't set?), but I
can't say I'm thrilled about a new option pahole-specific that would
have to be individually enabled.

(I guess that means I've just volunteered to add both... perhaps next
year when I find time, for now the distro pahole patch toggling
reproducible if SOURCE_DATE_EPOCH is set will do)
-- 
Dominique Martinet | Asmadeus

