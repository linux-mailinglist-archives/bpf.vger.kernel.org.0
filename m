Return-Path: <bpf+bounces-64158-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE80B0F016
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 12:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CC971891AA2
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 10:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D861428C2D2;
	Wed, 23 Jul 2025 10:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VS+a5Ckl"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583C3B67A;
	Wed, 23 Jul 2025 10:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753267200; cv=none; b=s6IQWHyw8Z/J+orF0REeGNXUE9eqwVUzKjb+HutXVaw1pQEbbXB06NK+xHq2KZKJWCDq+dgaQnpVH1Z1b7bAQf+pHN1OgMjjWKmEqy1cegGQabSiL6zkByEGM2FBU9S5xGzf+1G2Wi+bcQ9UAxbOM0ycUdPKEM02UUIvYWaejnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753267200; c=relaxed/simple;
	bh=9YEDoLiDX6VEtg9vMY/SqJMJ9fjFWBooeWfGaj00H20=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mHxzPW3hFxjaKIJsDBSIMYBJcGtbSLP2jSrctKMl0bOSWFMCI3AEHNKc/xCtDT13AjhyAPK7y9HIu+etSH5McMFH8yAq8RC2qxcX6Aocvh/0S9sj7EjwUO1K6hd61EQdF/i3TU+hwlpL+YX1IZQp7I0RV9tjx/NTHnPpSecjCUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VS+a5Ckl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBB6DC4CEE7;
	Wed, 23 Jul 2025 10:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753267199;
	bh=9YEDoLiDX6VEtg9vMY/SqJMJ9fjFWBooeWfGaj00H20=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VS+a5CklnqHhWVfuW+tIKMUYjeTIOqSco4dTx1cAQPsaCXZaC0p0a9+FRmrCSPSwc
	 qD5WS5FAsjPnT+bRHcZeS0iKKxKaKbs/oTaEnInwJAkisLxfVnMgLvBwoeL+Yq2D1w
	 4uEgTAFu0a5hbqSHrLvuvvkhgRt8kQUhGNABiLBApmz1AT8TPrU/azOgqeeDEdzh7u
	 SKKUXcWRFXUrrxW06TvDuPOADl3d+UwpYH/seudKxN0Q4mT07fsUNDwcUqCqGbXYWb
	 L7Z+QZWL4XJkeVoxV149n2bQNVqHiYTz8Y+QkrMR2H9uAwnG0dlzD33B3eUrEiCaJb
	 Mh6BYHVaklEcg==
Message-ID: <c75a2d7c-8fc4-4335-8c6f-ec016a23db45@kernel.org>
Date: Wed, 23 Jul 2025 11:39:55 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 2/3] bpftool: Add bpftool-token manpage
To: Tao Chen <chen.dylane@linux.dev>, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 kuba@kernel.org, hawk@kernel.org
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20250723033107.1411154-1-chen.dylane@linux.dev>
 <20250723033107.1411154-2-chen.dylane@linux.dev>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20250723033107.1411154-2-chen.dylane@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2025-07-23 11:31 UTC+0800 ~ Tao Chen <chen.dylane@linux.dev>
> Add bpftool-token manpage with information and examples of token-related
> commands.
> 
> Suggested-by: Quentin Monnet <qmo@kernel.org>
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>

Reviewed-by: Quentin Monnet <qmo@kernel.org>

Thanks!

