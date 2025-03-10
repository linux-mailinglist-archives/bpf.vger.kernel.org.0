Return-Path: <bpf+bounces-53738-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89289A59A57
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 16:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD9421649B1
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 15:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443BD22CBD5;
	Mon, 10 Mar 2025 15:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M7MqfMJ0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99EE221565;
	Mon, 10 Mar 2025 15:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741621751; cv=none; b=PI3IBYiPRDH8la4wDhCucjHUUyzGoCQ/WF2fG0hnzHELgmJMOoWw8+FbG/ECZNtDLKXP97uRLlrgMSqJSKfm7/KZo70o8DEjY82gskRQZciqYEP9ll4zXvjTfuAiC41JgET6B4ptuiP5/hW0RdGl6s5RRcfdBQ36A7+chAES/eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741621751; c=relaxed/simple;
	bh=PBHeZEmt3D4fKXPbB6mRfqMmP+pG7/eCXydjxzPsKYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ETAN2riLQ+mhseBzD/o4yyb4U+2zAi3BoXAPQ3YGNWo8LSH80FeKA8O5Qydpinkslq4Cn4lA9uABfUP+IqzERC0CR/gAp6jBL9K5cDP0ITwS3WhR5+lrJl5E7l0i9LEytT3nymEwVcD5PSyhhzhgZMDX91IrdpLCaergGq+rPhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M7MqfMJ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4404BC4CEE5;
	Mon, 10 Mar 2025 15:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741621751;
	bh=PBHeZEmt3D4fKXPbB6mRfqMmP+pG7/eCXydjxzPsKYo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=M7MqfMJ02HNk6Dy3sZgBoQuQ+ogQQCCjuck1sGRQYzal+X25DBWQRsxhTK28eOiDH
	 +2PXFzGXTXfVrAG6Y/pUI4N43cBPNLT/gI/mkvhhjOl+dlO4eKXpDIXzjiI5r/SCjd
	 rJWy7haKO/ywHhiSQp0NQ0dLdHky+nQg1ndIe+rCDEyN58IGeaz+t06q+4ZvxHBcwT
	 V+wJFXuRQf93rh0AuKV8S6vNxCU3i8d33EFmsAjrwiJfT1Rq67WM6KMFW9Lg6fuG4o
	 qyYVVhkz6Iy46011305ThenUmfg5ugyozU2NUJL2qEKPMV6aSiXm64pboxHp5g+KDa
	 7Av2L0eIjrp3w==
Message-ID: <654713e8-f4ce-4742-8165-f73838ea8d16@kernel.org>
Date: Mon, 10 Mar 2025 15:49:05 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v1 1/2] bpftool: Add -Wformat-signedness flag to
 detect format errors
To: Jiayuan Chen <jiayuan.chen@linux.dev>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, linux-kernel@vger.kernel.org, ast@kernel.org,
 davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 mrpre@163.com, Arnaldo Carvalho de Melo <acme@kernel.org>
References: <20250310142037.45932-1-jiayuan.chen@linux.dev>
 <20250310142037.45932-2-jiayuan.chen@linux.dev>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20250310142037.45932-2-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2025-03-10 22:20 UTC+0800 ~ Jiayuan Chen <jiayuan.chen@linux.dev>
> This commit adds the -Wformat-signedness compiler flag to detect and
> prevent printf format errors, where signed or unsigned types are
> mismatched with format specifiers. This helps to catch potential issues at
> compile-time, ensuring that our code is more robust and reliable. With
> this flag, the compiler will now warn about incorrect format strings, such
> as using %d with unsigned types or %u with signed types.
> 
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>


Acked-by: Quentin Monnet <qmo@kernel.org>

Thanks for that. Have you looked into enabling the flag along with the
other EXTRA_WARNINGS in tools/scripts/Makefile.include? It would be
ideal to have it there, but I suppose it raises too many warnings across
tools/? (I didn't try myself.) No objection to taking it in bpftool only.


> ---
>  tools/bpf/bpftool/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
> index dd9f3ec84201..d9f3eb51a48f 100644
> --- a/tools/bpf/bpftool/Makefile
> +++ b/tools/bpf/bpftool/Makefile
> @@ -71,7 +71,7 @@ prefix ?= /usr/local
>  bash_compdir ?= /usr/share/bash-completion/completions
>  
>  CFLAGS += -O2
> -CFLAGS += -W -Wall -Wextra -Wno-unused-parameter -Wno-missing-field-initializers
> +CFLAGS += -W -Wall -Wextra -Wformat-signedness -Wno-unused-parameter -Wno-missing-field-initializers


Nit: This line is becoming long enough that I'd consider moving each
flag to its own line, for better reading:

	CFLAGS += -W
	CFLAGS += -Wall
	CFLAGS += -Wextra
	CFLAGS += -Wformat-signedness
	...

>  CFLAGS += $(filter-out -Wswitch-enum -Wnested-externs,$(EXTRA_WARNINGS))
>  CFLAGS += -DPACKAGE='"bpftool"' -D__EXPORTED_HEADERS__ \
>  	-I$(or $(OUTPUT),.) \


