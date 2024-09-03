Return-Path: <bpf+bounces-38753-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7939969431
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 08:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E3481F23FD6
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 06:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247C41D54DA;
	Tue,  3 Sep 2024 06:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="c8Jtp1Nj"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3A91CB527
	for <bpf@vger.kernel.org>; Tue,  3 Sep 2024 06:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725346359; cv=none; b=UeFOvD9N4FCP4EvOFhZqaPkAGyU1k7VD4fiBTXXba5ZTHLXVlWY9IZdiSXKZPNhKZ7ZAaOHEIGFenLA1EAY8QDddgvFAZ/RpZb2cf10Ak3CsJqBQBqSshoBrvXBqmZ5tCIGq4e1VxgdD7DriFj/E3wdV5MVef914nYm6kqIWd8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725346359; c=relaxed/simple;
	bh=zX6t/5bW+I8oTFQtTWFJZTrVglEuXyqG+PInDWlw1Q0=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=gPNJ3FQBKKKp55yGWUJw4b1Ur0zMiaIEtbXz197YGRm0DXKVURkZmtkju5EHnTntJ+CDNaxjrbDOroBANhPBhV/nQ72dFmOUB2vVXP2OE080naUvmSKjVcTyjbw5OBNajyb1npM9a6tqdXVT2ERyHMcjygy2DiHm1j/96I7xpbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=c8Jtp1Nj; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=4poC+gFr9d6uHOiw8G40Tjj3lu18piW7YQBRALtI+mU=; b=c8Jtp1Njox0tQjFJo3lsJgSfL5
	DeDSkmYqnCNqs/+txxYCPITWFEolqy0jvO4O8QY1wvPdWdhYr/L5DM7gbVjsqgJ7OiaU4z75/0Bor
	WPk7uUhKKQzVXnoUFbbMd/sHuA3QtcfPmO3zwiqW0hp9Z57feB8JbhUz27I/pzOmQ8ZMwNhaD0A+S
	jC19Al9hT9/ByEWlptEC7OM5aLv3Py18WxJLDRx95aqy1HDeB8JrbZY2SRpsjwVMEJnLPbqPdQVOT
	avZXAIcUHKQIvyB0dgjVC+X3jwJUBGL7SQxcDDZBGxFz9h7+/2DmhLw9MjLEGpEmC9oOy5nyRHBIh
	YaUMyFnQ==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1slNOs-0008s7-4o; Tue, 03 Sep 2024 08:52:25 +0200
Received: from [178.197.248.23] (helo=linux-2.home)
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1slNOr-000EgE-14;
	Tue, 03 Sep 2024 08:52:25 +0200
Subject: Re: Change default cpu version from v1 to v3 in llvm20
To: Yonghong Song <yonghong.song@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>
References: <ac144cc8-db10-47ea-b364-c9ebf2fe69d3@linux.dev>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <fc2f30b5-c51b-3e2d-4282-2b22fb998285@iogearbox.net>
Date: Tue, 3 Sep 2024 08:52:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ac144cc8-db10-47ea-b364-c9ebf2fe69d3@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27386/Mon Sep  2 10:35:36 2024)

On 9/3/24 6:10 AM, Yonghong Song wrote:
> Hi,
> 
> Suggested by Alexei, I put a llvm20 diff to make cpu=v3 as the default
> cpu version:
>     https://github.com/llvm/llvm-project/pull/107008
> 
> cpu=v3 has been introduced in llvm9 (2019 H2) and the kernel cpu=v3
> support should be available around the same time although I
> cannot remember the exact kernel version.
> 
> There are two motivation to move cpu version default from v1 to v3.
> 
> First, to resolve correct usage of code like
>     (void)__sync_fetch_and_add(&ptr, value);
> In cpu v1/v2, the above insn generates locked add insn, and
> for cpu >= v3, the above insn generates atomic_fetch_add insn.
> The atomic_fetch_add insn is the correct way for the eventual
> insn for arm64. Otherwise, with locked add insn in arm64,
> proper barrier will be missing and incorrect results may
> be generated.
> 
> Second, cpu=v3 should have better performance than cpu=v1
> in most cases. In Meta, several years ago, we have conducted
> performance evaluation to compare v1 and v3 for major bpf
> programs running in our platform and we concluded v3 is
> better than v1 in most cases and in other rare cases v1 and v3
> have the same performance. So moving to v3 can help
> performance too.
> 
> If in rare cases, e.g. really old kernels, v1/v2 is the only
> option, then users can set -mcpu=v1 explicitly.
> 
> Please let us know if you still have some concerns in your
> setup w.r.t. cpu v1->v3 transition.

Sounds good to me! Is there a place somewhere in LLVM where this
can be documented for the BPF backend (along with the various
extensions), so that developers can find sth in the official LLVM
docs if they search the web? I see that riscv and some other archs
have documentation under [0] which seems to get deployed under [1].

   [0] https://github.com/llvm/llvm-project/tree/main/llvm/docs
   [1] https://llvm.org/docs/RISCV/RISCVVectorExtension.html

Thanks,
Daniel

