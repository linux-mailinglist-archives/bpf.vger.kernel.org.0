Return-Path: <bpf+bounces-57207-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C75ECAA6E11
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 11:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C0457A48B5
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 09:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6EB22DF86;
	Fri,  2 May 2025 09:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DbWpqVm4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A78229B2E;
	Fri,  2 May 2025 09:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746177978; cv=none; b=XBD5oscXoHq1sm6/GC/IqfQvgZW4twfMYoYGChmo0dCh/UHxSWciNs/LiYaE8LiSA6iScX44XYD8jp9GQHG9dfqMcSj2Z/TkpWURZZCKtELfTs0/gdbDS+M3f1HVvA00ixKBqrNMwJ8afSxiYvm7hKQODN9fNUS2tIBziwr3lJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746177978; c=relaxed/simple;
	bh=/r0atEBdpILwjy4O7MLex3WN3fl8Y37ugsOOXsz/Gvw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZvzY+1MiA+odty3/+jkVOT/8PJOtiaSUgORtvhdprQyLQ/ok8UPpjnOCOOaE6wPsmr4yfFXQ7gQhi9Fc2FDUtDFKnBqBjHAEeFeWCL04I/g/5k+0uDqBiCoLI4hhGMeHPwdFKOZO9ewoTWUEz2pCESMeOzOlnEFxYrPOPAVV924=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DbWpqVm4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF33DC4CEE4;
	Fri,  2 May 2025 09:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746177976;
	bh=/r0atEBdpILwjy4O7MLex3WN3fl8Y37ugsOOXsz/Gvw=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=DbWpqVm4VLKelZS6AecoC4T85QBufUxfxbrxnuFFd/43YQJcq1pzBVaesRE6WfRtl
	 5A+n+/E5/CjiZPUMh4lFVU6WKnRrq18WoS+/ivkE60vmlWKas9TunUVnAkcUdXIMv9
	 mcepiH2oyLJ3AwMY3F9JTKR08KniSOURaR+rNsObTeWAbN3eM0XJZHAvE4xd8LRA1a
	 eTDQTu5xIcbgy50PnpINQsNYmedUQoFzPgJF+IVfLqMVrU9lmStcI3ObNaYdc1Hgt9
	 SbaaAQBNy1RYg7x0WWeiPOTVBXy8AzpO+44Ak7NivlaqDys/s9Cj3R1Z7WYrRTEuBe
	 921jA9ii8JGFA==
Message-ID: <7326223e-0cb9-4d22-872f-cbf1ff42227d@kernel.org>
Date: Fri, 2 May 2025 10:26:12 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpftool: build bpf bits with -std=gnu11
To: =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250502085710.3980-1-holger@applied-asynchrony.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20250502085710.3980-1-holger@applied-asynchrony.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 02/05/2025 09:57, Holger Hoffstätte wrote:
> A gcc-15-based bpf toolchain defaults to C23 and fails to compile various
> kernel headers due to their use of a custom 'bool' type.
> Explicitly using -std=gnu11 works with both clang and bpf-toolchain.
> 
> Signed-off-by: Holger Hoffstätte <holger@applied-asynchrony.com>

Thanks! I tested that it still works with clang.

Acked-by: Quentin Monnet <qmo@kernel.org>

I didn't manage to compile with gcc, though. I tried with gcc 15.1.1 but
option '--target=bpf' is apparently unrecognised by the gcc version on
my setup.

Out of curiosity, how did you build using gcc for the skeleton? Was it
enough to run "CLANG=gcc make"? Does it pass the clang-bpf-co-re build
probe successfully?

Thanks,
Quentin

