Return-Path: <bpf+bounces-76050-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 906AECA45B3
	for <lists+bpf@lfdr.de>; Thu, 04 Dec 2025 16:54:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5A22C303BD2B
	for <lists+bpf@lfdr.de>; Thu,  4 Dec 2025 15:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0CD2EC559;
	Thu,  4 Dec 2025 15:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rtS+zGq9"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB9A26CE25
	for <bpf@vger.kernel.org>; Thu,  4 Dec 2025 15:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764863553; cv=none; b=qmY27kkLXvXCnVLYMTIZlsrKCzCCniUq7k/Pxg4cep3bJkWBYkUXRyvANL2PhlkkKRQGx4SZ5G2cpFAa4UTQ/ws2tliZ7DeWBi95u/4oZSLTesfRyZHURYK12/GvJjF6SAtl3LiLhOVKwjPAmVTVqijjeCuc2T6pmbV4dr1cfpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764863553; c=relaxed/simple;
	bh=oLtoYeeaw4Gi+bMzrt7/e2aNXq4DdAx+YomTWKLFSys=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HZB8VK3/xRyc8yytyRwR0yVxPvGZy9fPkwoeMAwcR6lRCctJgXJ0BUwb81DIV1rK1gLUw6NljymHfwl9cxPKVlOwucKC4VeUyqzTFFmCfChRuzPj3/ezuLMnlSAHIa9L6sNjG9jc5dqoxtVn5ccVMf8XNOw2AvcKpP77SDDntYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rtS+zGq9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6449C4CEFB;
	Thu,  4 Dec 2025 15:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764863552;
	bh=oLtoYeeaw4Gi+bMzrt7/e2aNXq4DdAx+YomTWKLFSys=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=rtS+zGq9Piacb7F8zwYHt8kJRMRHjZy/Otw3rDQMKDX+DyDFYTNWgOYlpDeIXiY2T
	 3tviS1bBH/d6u10ZYAJ1ovJTWqBfkcwvxVnA2c/5FQRksvLPYI5sPtaJcwaMNb5xkT
	 K6pfg+x4EunRUqtOs395vW96SgCubCiO+8k7MgxNViAVQpLg6/ctrRRjhmwjGZmKYe
	 tnXd2fNencS4gFobF5RQTmy6qLyWbCloQrHoh6koHNNs8RywzGXmZPh7Dss1hsZp2A
	 C2jYFrJYd1W+Ob0ZqFL8etAdvQe+LCPa+QI1vSLb6NYRuLyaVXm5boCUD3QwVESAtz
	 hkkdIjewIyuyA==
Message-ID: <8880b703-6557-4ad5-aa38-7dddbb572bff@kernel.org>
Date: Thu, 4 Dec 2025 15:52:30 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: fms-extensions and bpf
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, bpf <bpf@vger.kernel.org>
References: <CAADnVQK9ZkPC7+R5VXKHVdtj8tumpMXm7BTp0u9CoiFLz_aPTg@mail.gmail.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <CAADnVQK9ZkPC7+R5VXKHVdtj8tumpMXm7BTp0u9CoiFLz_aPTg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2025-12-03 20:29 UTC-0800 ~ Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Hi All,
> 
> The kernel is now built with -fms-extensions and it is

[...]

> Quentin,
> pls think of a way to silence warns during bpftool build,
> which is now noisy due to:
> In file included from skeleton/pid_iter.bpf.c:3:
> .../tools/testing/selftests/bpf/tools/build/bpftool/vmlinux.h:64057:3:
> warning: declaration does not declare anything
> [-Wmissing-declarations]
>  64057 |                 struct ns_tree;
>        |                 ^~~~~~~~~~~~~~
> 

I see them too. We can trivially turn off these warnings when building
the BPF programs:

    diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
    index 586d1b2595d1..ad4e10cb59d5 100644
    --- a/tools/bpf/bpftool/Makefile
    +++ b/tools/bpf/bpftool/Makefile
    @@ -224,6 +224,7 @@ endif
     
     $(OUTPUT)%.bpf.o: skeleton/%.bpf.c $(OUTPUT)vmlinux.h $(LIBBPF_BOOTSTRAP)
            $(QUIET_CLANG)$(CLANG) \
    +               -Wno-missing-declarations \
                    -I$(or $(OUTPUT),.) \
                    -I$(srctree)/tools/include/uapi/ \
                    -I$(LIBBPF_BOOTSTRAP_INCLUDE) \

Probably better, we can tell clang to use the MS extensions so that it
doesn't consider these declarations as missing:

    diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
    index 586d1b2595d1..a8d5b32f1c6b 100644
    --- a/tools/bpf/bpftool/Makefile
    +++ b/tools/bpf/bpftool/Makefile
    @@ -224,6 +224,8 @@ endif
     
     $(OUTPUT)%.bpf.o: skeleton/%.bpf.c $(OUTPUT)vmlinux.h $(LIBBPF_BOOTSTRAP)
            $(QUIET_CLANG)$(CLANG) \
    +               -fms-extensions \
    +               -Wno-microsoft-anon-tag \
                    -I$(or $(OUTPUT),.) \
                    -I$(srctree)/tools/include/uapi/ \
                    -I$(LIBBPF_BOOTSTRAP_INCLUDE) \

I'm happy to repost the latter as a patch, if it seems good to you.

Quentin

