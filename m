Return-Path: <bpf+bounces-28154-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2756D8B636E
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 22:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACF291F21DD7
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 20:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AFFF141987;
	Mon, 29 Apr 2024 20:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jvo6QggI"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C357D13AD18;
	Mon, 29 Apr 2024 20:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714422128; cv=none; b=Qvlge8VqELH2TCYabxhE1Ru51N28AnxTECLFznWpy5+MUz48Yll2IXZGywc071va+DgUXe7n7WxXKCMfJoToyPhr9pgQchHRMzYuvimNQOlHD8aYGXtlSjWbChKJ7o0aiMjSvkm6VBiKuOLezL+feZVloVWYN0kdz8IWXbUoAKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714422128; c=relaxed/simple;
	bh=nAX4l0CH77ceKq9h98bAXcH2qWKqWikvvUnDDIiX0KE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WLSrFyl1LNDlEP9Exwp8rFw9+mLE6O++b5wYyWaesIQnF+Rkrw+2ejQ6gl3ZoGTKC4QMecuE9igHBVjC04GgCS9E2y/DAf5HngPtb2quYpEVl1BLgXU+vmM4S0L9Cfk72nmmVjQAcPJfDwQtzrG1X+/pV70gE6CyFUbiGmXus+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jvo6QggI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00214C113CD;
	Mon, 29 Apr 2024 20:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714422128;
	bh=nAX4l0CH77ceKq9h98bAXcH2qWKqWikvvUnDDIiX0KE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jvo6QggIqTnEIjY84VFN/bt31HZ6PBO7gBoZyqUgwQw9DGDIRGME9/RoYWY05ofun
	 NIlokHiVhBXIZxizDjAnU5gbGxxC1A96DjZF93nbnZWhKW29+qt+gC4X7gyu0UFwnW
	 LdZqwJi/Hy8PDhdSLuZmHI7l/Ff4scOjKImd3QX71fY5ued9nbExFwAyShGWNdjkGJ
	 4gAg92QxlGeQKD0Ml/Vx9BNoJRIT0Mnji4trhhgixMF5qg4MTlraTuSQbp7Xn/K8co
	 h9K85YsSuIQaPZbJgiQWQZgIpjL5UPO1t1tt3Y4GyfNrEbqN2aiZne1S8M4C8LGbuG
	 q2bKyvoOezslQ==
Date: Mon, 29 Apr 2024 13:22:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
 netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: pull-request: bpf-next 2024-04-29
Message-ID: <20240429132207.58ecf430@kernel.org>
In-Reply-To: <20240429131657.19423-1-daniel@iogearbox.net>
References: <20240429131657.19423-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Apr 2024 15:16:57 +0200 Daniel Borkmann wrote:
>       tools: Add ethtool.h header to tooling infra

Could you follow up to remove this header?
Having to keep multiple headers in sync is annoying, and using 
'make headers' or including in-tree headers directly is not rocket
science.

