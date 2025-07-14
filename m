Return-Path: <bpf+bounces-63238-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 363A4B0477B
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 20:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 889754A308C
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 18:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA06213E7B;
	Mon, 14 Jul 2025 18:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PMLguTZI"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D361CD1F;
	Mon, 14 Jul 2025 18:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752518726; cv=none; b=LJMoub09eTyglqMLIGgROsoL1ho//+QZI3Oz/DdJNd+I+gZvfRybhBL3iYMzjN10qbSVGk/Gmx1nkJBfUrvUs2O6boKI7DescuMaB9LRu3URnic/qMitAQb7t1NcTnAmDGlG0CT7C+/DYpUsv8Azl4a3VZmLLzPbZsVajdu/+XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752518726; c=relaxed/simple;
	bh=mkpQ3SjUZuzSBpcCMEJAh4f3+IiQc0MR12vYVr0izPA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GymRNzjMNfPTqVV67zCSpsKNmaWu6w52ZCsOWfxszBIKRUgi32jiYoDMqD2mZpO2SZ3VYPTt6ZHBTiJJMs4OLtCuM4K90Kfbe/nDdBXCQHwyPRuiwramVNwaNxnkK+7licNEpW+UxXwZMFlsz6IvwY4VRxSTotaRdXz3zQfKnI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PMLguTZI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDEC0C4CEED;
	Mon, 14 Jul 2025 18:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752518726;
	bh=mkpQ3SjUZuzSBpcCMEJAh4f3+IiQc0MR12vYVr0izPA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PMLguTZIfuSAlhRXgxbxdIv6FYa9mnfTGMRZovZMsONUBXMqcjd9l41MANCjz3p9r
	 TnkuyJCXt5XpvDAtCF9Qloreesj56qE51fugmopuait9e6Z22P2FaYnmWCpry2WAfJ
	 NQdUudhGCJS9jJ8S0puifJ3kdUQBBaqzg5Ql65lQ9Cs+hQh1MZSYgUYDhvoqVCgmFo
	 iC+/fWiq/UkM4Qdq12kkbqHfqV8bP/s4o7CPf+s6kYGGpc8wDWwnt+pu+6TJ91sAI4
	 7ezhxX3IP8YxwUB0omuRJEPDB210Wa2b3wREV3mT6NGtpj7ffwErI0L0BAQJZbJEc7
	 nwVFZVe0NlP8g==
Message-ID: <9618808a-d63b-4eec-b744-471586e270e2@kernel.org>
Date: Mon, 14 Jul 2025 19:45:22 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpf: Replace deprecated strcpy() with strscpy()
To: Thorsten Blum <thorsten.blum@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250714182358.238422-1-thorsten.blum@linux.dev>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20250714182358.238422-1-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2025-07-14 20:23 UTC+0200 ~ Thorsten Blum <thorsten.blum@linux.dev>
> strcpy() is deprecated; use strscpy() instead.
> 
> No functional changes intended.
> 
> Link: https://github.com/KSPP/linux/issues/88
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  kernel/bpf/disasm.c | 2 +-

Hi and thank you for the patch,

The disassembler file is also part of bpftool's source code [0][1],
where it is compiled as user space code, and where strscpy() is not
defined. So I'd rather not replace this particular occurrence of
strcpy(). We could add a comment in the file to mention this, though.

Thanks,
Quentin


[0]:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/bpf/bpftool/Makefile#n246
[1]:
https://github.com/libbpf/bpftool/blob/v7.5.0/src/kernel/bpf/disasm.c#L340

