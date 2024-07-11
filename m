Return-Path: <bpf+bounces-34523-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2804F92E26E
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 10:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90997B25054
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 08:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD9815E5CA;
	Thu, 11 Jul 2024 08:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="NgCJdfh7"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C45158866
	for <bpf@vger.kernel.org>; Thu, 11 Jul 2024 08:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720686687; cv=none; b=Dt0Dhun0MY+LymQkEaMkeMbjgrRXrjGU04XblQesv+V74LyktcM30KzxdXPlvgYSoOnDmrqn1mZnoiNb2JMt9LurVAnLvFIAPRd2TBgyT8JEcwW1xQl6ZV+onFb3O79UY1DI+wUEZ0HDwZ5zGQL2uDUOLmvF5cVbf6EXpl8+9vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720686687; c=relaxed/simple;
	bh=xWyO1S9UIZ3Z882bYQcwY72G19Dd0pm+a1aZ/c5fDSY=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=JRnxw9kSKffUyeIs66rtaG2DEKzr51/ujBrtnoMA7s7lB0ukJuVsiG9iiVWbbvn8O2ZhccVPqY4PobeSzWd4Nl+FF73H3fTZbaIWq/weG5u3EqTjqKsyEncpT3iRo2dk5E5PGE1DmowOUu+ZUfImXre/bm/k9emLdWQaLMMkf5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=NgCJdfh7; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=RA8QzzWNVhXAUlpQX14fh8a0nJM1yWhqAECu3eyI7mE=; b=NgCJdfh7BWFPJY3V+wjjWdCq3n
	vIMHhNWMkw2uG6+KqQkCVlUlfhsQW1U0GrT9V1Mi/JmC4A+UqBZCHMbnUyayaO6nPANUdJwqNQfB8
	aMrp4cpZ6j6aO+uZcpFSI9XEp6I3v32ZBE0OY2OyBN7rAzAm2eydl3AKxjoYs4HiV+ayAnI/iWekQ
	0xviLzZWmB/b7Z229pLkgvWdD1ibP9kMh0HLNW9C9M85BetBVHBtH1BbcwU8TkHygi78CIlujNL9E
	YkgLJguJH4Bn3UgIoZc7u+wV7ZhW/X4IRrwivB2ClxlcSFNfLfMp6QxxWSrwHSB2tLeEsBzuqHYAc
	9kqpuCrQ==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1sRpCs-000G9z-Ue; Thu, 11 Jul 2024 10:31:14 +0200
Received: from [178.197.248.35] (helo=linux.home)
	by sslproxy06.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1sRpCr-000PEg-33;
	Thu, 11 Jul 2024 10:31:14 +0200
Subject: Re: [PATCH bpf v2] selftests/bpf: Add timer lockup selftest
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Dohyun Kim <dohyunkim@google.com>,
 Neel Natu <neelnatu@google.com>, Barret Rhoden <brho@google.com>,
 Tejun Heo <htejun@gmail.com>, David Vernet <void@manifault.com>
References: <20240711052709.2148616-1-memxor@gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <a6f11588-94b1-3ab1-5071-1baef9442f18@iogearbox.net>
Date: Thu, 11 Jul 2024 10:31:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240711052709.2148616-1-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27332/Wed Jul 10 10:36:46 2024)

On 7/11/24 7:27 AM, Kumar Kartikeya Dwivedi wrote:
> Add a selftest that tries to trigger a situation where two timer
> callbacks are attempting to cancel each other's timer. By running them
> continuously, we hit a condition where both run in parallel and cancel
> each other. Without the fix in the previous patch, this would cause a
> lockup as hrtimer_cancel on either side will wait for forward progress
> from the callback.
> 
> Ensure that this situation leads to a EDEADLK error.
> 
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
> Changelog:
>   * Add missing timer_lockup__destroy.
>   * Fix inline declarations (Alexei).
>   * Shorten pthread_create line (Alexei).
>   * Fix type of map value parameter to time cb (Alexei).
>   * Add a counter to skip test if race does not reproduce (Alexei).

Did some small cleanups while applying, and ran several times w/o issues.
Applied, thanks Kumar!

