Return-Path: <bpf+bounces-31168-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BB98D7928
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 01:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D47121F217A6
	for <lists+bpf@lfdr.de>; Sun,  2 Jun 2024 23:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7087F481;
	Sun,  2 Jun 2024 23:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qh1ej48X"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FBF78283;
	Sun,  2 Jun 2024 23:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717371227; cv=none; b=Kqk5LORIc4J7oHJxBlHB9sM8T4xD6G9MAwbvSkIjDAbPN6ezU+xIlrJ1RRGuEtyRDvJIS0xVchSoAurob7Bam45f+8q8aO3HAYxaQOti2ox5UNz4EB+t2zAmStBfczn9cb/o5MD+2puqPG14WG7DGfedsUFdTK4qwEA7tDrSkWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717371227; c=relaxed/simple;
	bh=cdM87lmlrIHNiUm1YK2XV5w3mcdumawnrY5eacXrA3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sSwrSDz9tiSFCAjxjsWZTLEDyCzg2eQbeHvfllQlDOdksYFbVPdWe/BAaho8tN99MuOmRy69riC2IkvpFv0pucujKHaN2q9V4I3U7OM1JApo4Wrta9HSCjunbhGKxJhrIEpR+0aAOfgqc7J/iEl/53jq2RjY0t+VNd05H3YrHcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qh1ej48X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83D6FC2BBFC;
	Sun,  2 Jun 2024 23:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717371226;
	bh=cdM87lmlrIHNiUm1YK2XV5w3mcdumawnrY5eacXrA3E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Qh1ej48Xs5WtSkUNTSWqioP0oVtnycasxVxcMSkmEQNPjluzrPeItZVYma4u1FgMQ
	 /AtQLAn9AAE1b3LSM/i4kE/IKJwn3zMZoe9CO9n0K1nzPKLokzguif6ySQeLtkriy3
	 BDpKWbxLmtnN8C8xUDup1nDUdT2Ezb1cDRI2kYqYPgerYMPFSkjAXR4jnxX60BVkAj
	 GR2GTSErDvEapbeW+Mf0xhhYIbbAiHrWNDSf3KHprfk1ThDM8rDla61dEdYiAqdCgN
	 oW6xeqzOmedggyJ72z/0lrhKLivKiWeiGQ6zcZu73LULhkPfwKkcH9B+puG51FIa5t
	 bBiu9Jhvagpxg==
Message-ID: <746e0ddd-de6c-49f6-b836-3b8fcc5f18c5@kernel.org>
Date: Mon, 3 Jun 2024 00:33:41 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH] tools/bpf: matric typo erro
To: Swan Beaujard <beaujardswan@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240602225812.81171-1-beaujardswan@gmail.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20240602225812.81171-1-beaujardswan@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/06/2024 23:58, Swan Beaujard wrote:
> Corrected typo in bpftool profiler.
> 
> Changed all instances of 'MATRICS' to 'METRICS' in the profiler.bpf.c file.
> 
> Signed-off-by: Swan Beaujard <beaujardswan@gmail.com>
Acked-by: Quentin Monnet <qmo@kernel.org>

For future bpftool patches, please use directly "bpftool:" rather than
"tools/bpf:" as component prefix for the commit object, and make sure to
have a clear title ("erro" seems to be a typo itself).

Thanks!

