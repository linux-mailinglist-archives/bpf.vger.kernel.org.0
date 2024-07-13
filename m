Return-Path: <bpf+bounces-34741-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4CC930740
	for <lists+bpf@lfdr.de>; Sat, 13 Jul 2024 22:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01F65B222E3
	for <lists+bpf@lfdr.de>; Sat, 13 Jul 2024 20:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110361422D1;
	Sat, 13 Jul 2024 20:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="pCis6QhX"
X-Original-To: bpf@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F02218EA1;
	Sat, 13 Jul 2024 20:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720901684; cv=none; b=LVrfYwKlOYi9do/dvU+2HhzCaX8iyoi1L5e33qUQ0nx+9BkQ4v3FEPFM4XB7NsNbxel43qF/J1JjeKV24AaLlc/haIPELnRFHeJ/56suuxZn+CwFtdgRTIfnTugzZnftmfz8PhpOV+3pJjPtj9S/dFRns8RZAzEs2htxoDiLk24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720901684; c=relaxed/simple;
	bh=B3tkF5ilr5P/pluWVQVHBV612MuyhLdB6uu8hhYGo/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cWxGoDCiN0NANqmGa2l0ne9AsOCd/74WvZmzDApwA7SVn1QeH6qT3SDlqVY4Ue5paxjIzfMHoCnqfi/58VYjvrn4AkWq+ipV+8DmGh8F9J/oxAqZYmqkCZIBz3i1HjVErqwE3/wEAVJOt2s46qxepdzTSndkAI/KoU7/NIhCE+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=pCis6QhX; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1sSj8f-00FcW8-Bl; Sat, 13 Jul 2024 22:14:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=1RSZc8Z267ymAY0LSMCxfts/ykk1ogkiXvSrzU74YxE=; b=pCis6QhXS4nJmo88wCxHrSaY+m
	AL/n2lKr/gNWJnu6ubB8ZRJqy9WywasPtwmsu8B177Kh0p32AYNS9V5nlOidjVssw3wCscx8u1DBy
	u4MMwqtiqTXE0JmvgbM+INRC7idPkECw181QXFodCIVj7BMRZa/FiW7s3+fy2YWIpKC8XGeB9OE5i
	wnXKprK8hr2ZyA0nOds19o0K8XhHYJ+SEob2FpDPI7T9RQwUP8tSOGrmgKouuuinFA3j1m3AQPhX5
	COFnHtPtmvYQSB0p12iFPtY+ilvBeHJy3GekvEpPNl7cm99ciuzGWY6gYFRa7c0pJu6tpJKS4BvKe
	JKHf2JDw==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1sSj8e-0007es-7T; Sat, 13 Jul 2024 22:14:36 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1sSj8M-0013GH-3J; Sat, 13 Jul 2024 22:14:18 +0200
Message-ID: <cc71d3c5-41f9-4e6a-98d2-7822877b6214@rbox.co>
Date: Sat, 13 Jul 2024 22:14:16 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v4 0/4] af_unix: MSG_OOB handling fix & selftest
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, john.fastabend@gmail.com,
 jakub@cloudflare.com, kuniyu@amazon.com, Rao.Shoaib@oracle.com,
 cong.wang@bytedance.com
References: <20240713200218.2140950-1-mhal@rbox.co>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <20240713200218.2140950-1-mhal@rbox.co>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/13/24 21:41, Michal Luczaj wrote:
> PATCH 1/4 tells BPF redirect to silently drop AF_UNIX's MSG_OOB. The rest
> is selftest-related.
> 
> Michal Luczaj (4):
>   af_unix: Disable MSG_OOB handling for sockets in sockmap/sockhash
>   selftest/bpf: Support SOCK_STREAM in unix_inet_redir_to_connected()
>   selftest/bpf: Parametrize AF_UNIX redir functions to accept send()
>     flags
>   selftest/bpf: Test sockmap redirect for AF_UNIX MSG_OOB
> 
>  net/unix/af_unix.c                            | 41 ++++++++-
>  net/unix/unix_bpf.c                           |  3 +
>  .../selftests/bpf/prog_tests/sockmap_listen.c | 85 +++++++++++++------
>  3 files changed, 102 insertions(+), 27 deletions(-)

Arrgh, forgot the changelog:

v4:
  - Fix typo; comment, extend and streamline the selftest (Jakub)
  - Fix commit message in PATCH 2/4
  - Collect Reviewed-bys

v3: https://lore.kernel.org/netdev/20240707222842.4119416-1-mhal@rbox.co/
  - Add selftest

v2: https://lore.kernel.org/netdev/20240622223324.3337956-1-mhal@rbox.co/
  - Reduce time under mutex, restructure (Kuniyuki)
  - Handle unix_release_sock() race

v1: https://lore.kernel.org/netdev/20240620203009.2610301-1-mhal@rbox.co/


