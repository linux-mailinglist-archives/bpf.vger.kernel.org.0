Return-Path: <bpf+bounces-32755-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 880FF912D24
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 20:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8E2E1C21EB9
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 18:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B6016A95F;
	Fri, 21 Jun 2024 18:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="UqDetdgO"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD7C8C1E;
	Fri, 21 Jun 2024 18:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718994336; cv=none; b=a/6hGpzGxN5ZitWUtHPtdM2KIz8UVsiowOZ5uwwtTCIKA7D1Fyf7JF838QEt3TLzirAZfW7Tf7vw+cp8HPmSIkr8bSvRX8HPlG6Ntl7wqzaPpR3KwELjoimO8TT7rFRdnVHQSM9x45LgXYzxCBtQmBoYcb6URSqx9p+KAAaisak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718994336; c=relaxed/simple;
	bh=hSzchEtpq6LBrWJN4YUDEKviYndDkKtD/lwrPFaJzqY=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=dBpa6lt4ml4dCGSkwS0bF5i3WszOg/pz3ZFRiXw0Wjw3CWnSkE/uH/Qpcw5/cOOrr2jh2kmMMQlfcUkwgIZV0uaKnjy3ZdYYlZaCIbYx/oUY3yPRPgR6AlmXBQ5vNwL9c60zLtgDNfGm/tJ/tSJq7v5HUWR+nwjy2vW53QK8+jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=UqDetdgO; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=9cHHAmuK/9S5OvB8X+j45KsfWlpRwwli9ByLJ9x+EBg=; b=UqDetdgOLoYkMXRpJM/jtimp/v
	fnU90Tzxpw0kwYyRjHoYRnSWv6dNgfAqyPaUUbgLrDkEnPwndVyE/hjibdw8FPsyz9T9SW+L6QM50
	TRa2BjDPqOm+3VfFfIdq8b/CoPlALuj4jdawmDCSR+jFoztJ5qFRXMf4w1vPyxE+SqEwIJ1/Wklsw
	uiAJKdBaqg/gxvY+gcN2xkocbdp0W21IGQSue7UIje4rinlGlL9H5eI02pJJVos6KCs3bAYK+5MPz
	kJ7cJ+g+xYXw1st0v0KU8q2bt9HDTd/TWDCD8/38l8TxvSYJ1zizB+ui/7VQ4JZZU9rz+7lxDkapq
	yrWgEDNg==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1sKiX5-000Aaw-VL; Fri, 21 Jun 2024 19:58:44 +0200
Received: from [178.197.248.18] (helo=linux.home)
	by sslproxy06.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1sKiX4-00021C-1G;
	Fri, 21 Jun 2024 19:58:43 +0200
Subject: Re: [PATCH] bpf: add security_file_post_open() LSM hook to
 sleepable_lsm_hooks
To: Paul Moore <paul@paul-moore.com>,
 Matt Bobrowski <mattbobrowski@google.com>
Cc: bpf@vger.kernel.org, kpsingh@kernel.org, ast@kernel.org,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, linux-security-module@vger.kernel.org,
 roberto.sassu@huawei.com
References: <20240618192923.379852-1-mattbobrowski@google.com>
 <CAHC9VhTMmPC47A91NqazrR=RKwt4JxBMRbpsPowTqxQ06ZjgZA@mail.gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <c4db2cc9-b8d3-f4fc-2f62-6d83022db49a@iogearbox.net>
Date: Fri, 21 Jun 2024 19:58:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAHC9VhTMmPC47A91NqazrR=RKwt4JxBMRbpsPowTqxQ06ZjgZA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27313/Fri Jun 21 10:28:08 2024)

On 6/18/24 9:44 PM, Paul Moore wrote:
> On Tue, Jun 18, 2024 at 3:29 PM Matt Bobrowski <mattbobrowski@google.com> wrote:
>>
>> The new generic LSM hook security_file_post_open() was recently added
>> to the LSM framework in commit 8f46ff5767b0b ("security: Introduce
>> file_post_open hook"). Let's proactively add this generic LSM hook to
>> the sleepable_lsm_hooks BTF ID set, because I can't see there being
>> any strong reasons not to, and it's only a matter of time before
>> someone else comes around and asks for it to be there.
>>
>> security_file_post_open() is inherently sleepable as it's purposely
>> situated in the kernel that allows LSMs to directly read out the
>> contents of the backing file if need be. Additionally, it's called
>> directly after securuty_file_open(), and that LSM hook in itself
> 
> *cough*
> 
> "security_file_open()"

Fixed up while applying, thanks!

