Return-Path: <bpf+bounces-52708-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBA9A47191
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 02:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3709F1881DFC
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 01:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA6B54670;
	Thu, 27 Feb 2025 01:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H1cQ2Q0N"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0212017BA6;
	Thu, 27 Feb 2025 01:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740620027; cv=none; b=QAqqVqBYMCSiFZoOybjROj7sfcRs2AwV5btliaaBqkO0K+XoWf8K+xOIEwbuZ3cmSq0fyreMWanM9XYOZfm6KEelH1NpCpk6HA7Te/Lx/38nRr0nV4BLAwJZXrY+CVHPTZFgkiQ02vWekL7qEn6p06IMjztuUiNX7EUDcrxWkF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740620027; c=relaxed/simple;
	bh=uJFpk2kL9G39EGOCMEcg20yJo9cpfRKR8g6k1rv6/30=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LAxVagtRFAisH2hvrno/GP2JJ2kXMjZiZq8Snjxv85Qdfhq91zoSFy4OQpZSEGjQO4wRY+Q9WrVfCfY488cdZUFpqrfhcgRWM1djIGxmvov7N2VCbDU555rkyfOnPp4yJaiMTyAGGDGpbS/QOjVFpnM3HZBWzDlXuiKfM0MQJCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H1cQ2Q0N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40035C4CED6;
	Thu, 27 Feb 2025 01:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740620026;
	bh=uJFpk2kL9G39EGOCMEcg20yJo9cpfRKR8g6k1rv6/30=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=H1cQ2Q0NkUsxmC2ztaGudpOjxhxMKPAV9h/7JoeUhn5T1E9VKeFOCOuJiVaumZhMC
	 aik3kLKZe1Ia1DCGO0s/vcTstb738IsQe80o0WJNzf0shSGI7yO4V+Mr0vnePdegZT
	 H5ugS5MwjBY6zgb/GELNK0MVjZaD4wKrPGMmzCOa5+oQqnPuf/G8Kmowsq2SWnTJeC
	 iHTJC2bbdeazYLGPBRroTuGhdQRwUzQ/FcPF/g8t/n9g2B3OLzlZO9XfIV0IPDR0bu
	 sRp5HTpe6QbPxjXLA16QHMvTuXJlYbJp/Mnba7TaZKOzAaLQL2g0lAajqAfEKbu6Ng
	 iNJ9KSo0edYoA==
Date: Wed, 26 Feb 2025 17:33:45 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, Philo Lu
 <lulie@linux.alibaba.com>, Nikolay Aleksandrov <razor@blackwall.org>,
 Martin KaFai Lau <martin.lau@kernel.org>
Subject: Re: [PATCH net] netkit: Remove double invocation to clear ipvs
 property flag
Message-ID: <20250226173345.61fbff5c@kernel.org>
In-Reply-To: <20250225212927.69271-1-daniel@iogearbox.net>
References: <20250225212927.69271-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Feb 2025 22:29:27 +0100 Daniel Borkmann wrote:
> With ipvs_reset() now done unconditionally in skb_scrub_packet()
> we would then call the former twice netkit_prep_forward(). Thus
> remove the now unnecessary explicit call.
> 
> Fixes: de2c211868b9 ("ipvs: Always clear ipvs_property flag in skb_scrub_packet()")
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Philo Lu <lulie@linux.alibaba.com>
> Cc: Nikolay Aleksandrov <razor@blackwall.org>
> Cc: Martin KaFai Lau <martin.lau@kernel.org>
> ---
>  [ Sending to net since de2c211868b9 is in net ]

I see. But if that's okay with you we'll apply it to net-next tomorrow,
once the trees converge?

