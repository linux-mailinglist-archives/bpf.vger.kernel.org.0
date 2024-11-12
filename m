Return-Path: <bpf+bounces-44609-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 859739C5269
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 10:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49AE0B2BAE5
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 09:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8886820E021;
	Tue, 12 Nov 2024 09:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AjLKffB2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DEE20DD58;
	Tue, 12 Nov 2024 09:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731404035; cv=none; b=i34QUwyjSvWQaTlfmrX2ZwEM/2pXG6W8oa466B33q7fTio3ond0pRpEjt1iiagbn7jz7K7lg8FAnctvNZGaMJpnO6D53TEgYAK3XDzWz8OK/kkG7TSoOnEx8hyceewUbkOhZCjjBvK1vJ/X0einfq+pvu8Sj/vDxPvwnyPf0qLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731404035; c=relaxed/simple;
	bh=Fg8MnjDmxNCrn8ah//QG+8TRTVgVED9RKQIw3QMapzA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kEFRUMtWjWayoW7A5D4pS2vExj8J4StATMPiAp/eXzVBmkDLC2uPletrmgnYSRp7aKfkgTxPwEhOm8IbzST0/p/3R5T6cq7ywZMXr+PAbx8HRppkwLZR4XZZ8whWLON43B8Dgb7FVjBi1uDwxZm6bUW///xhCRtZvO6ImYZt/AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AjLKffB2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0A01C4CECD;
	Tue, 12 Nov 2024 09:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731404034;
	bh=Fg8MnjDmxNCrn8ah//QG+8TRTVgVED9RKQIw3QMapzA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AjLKffB2pNqPLsTHl9HkHlwxx+YV26vW5NgyMhm71EIeYroFQNRhn0wd/XTj4S2I+
	 Li48MCvM77JRa8OZMnSzXAxGs056PE3k5FGtO99VgSa0EjoCCRDcDdf5inVeZdZI0N
	 ehfBOWyD+rSjOMLkM8z1eYcbcREB4afA44wffgpApx734bhx+HDCJrBWchF9FAgV6G
	 Qpw+1taP7MfQdaSW9ptDHDz2eYm9qL57ia0aFxH2etkat9d87zpBhxGZrJRsAsOZ2m
	 w48L8GJfKgf2zLdR+GN0zqSyCODFRbxHBUJb9CgkRMRrDm4dqxJ9jLb5GRiUUmYUxY
	 Y6ah3lSq+mSVQ==
Message-ID: <d05b2ea4-dc00-4583-bf17-0972083962a9@kernel.org>
Date: Tue, 12 Nov 2024 09:33:49 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpftool: Cast variable `var` to long long
To: Luo Yifan <luoyifan@cmss.chinamobile.com>, andrii.nakryiko@gmail.com
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com,
 john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
 linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@fomichev.me,
 song@kernel.org, yonghong.song@linux.dev
References: <CAEf4BzYgqb=NcSCJiJQEPUPhE02cUZqaFdYc4FJXvQUeXxhHJA@mail.gmail.com>
 <20241112073701.283362-1-luoyifan@cmss.chinamobile.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20241112073701.283362-1-luoyifan@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2024-11-12 15:37 UTC+0800 ~ Luo Yifan <luoyifan@cmss.chinamobile.com>
> When the SIGNED condition is met, the variable `var` should be cast to
> `long long` instead of `unsigned long long`.
> 
> Signed-off-by: Luo Yifan <luoyifan@cmss.chinamobile.com>

Looks good this time, thank you!

Reviewed-by: Quentin Monnet <qmo@kernel.org>

