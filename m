Return-Path: <bpf+bounces-50189-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D3EA23986
	for <lists+bpf@lfdr.de>; Fri, 31 Jan 2025 07:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD67F1889EDE
	for <lists+bpf@lfdr.de>; Fri, 31 Jan 2025 06:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD3D14A0B7;
	Fri, 31 Jan 2025 06:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EX5+aK/6"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B75A7B3E1
	for <bpf@vger.kernel.org>; Fri, 31 Jan 2025 06:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738304903; cv=none; b=aPLxfa/EPc++/1SBdS0nRLEExeoIn8LlfPxSfumg9yQ9ZrU3fx5OI68LPZA3SlSyXaO0rjBqrE0Zz9qLdapta1g09voJLJsEMjjF4qalZfO+1as+BqyN9VlwvB+Zkq/DdGU5Er4cQpBpleyDAUe6/DQiGAEq0jXux2lqhpKnxhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738304903; c=relaxed/simple;
	bh=BNwj/cu2eiUOIuXNgpw6rKDwrnR4+fv5e/EebXhTC3A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kk6tqK0DHuNEd+fs7LSB9MrkvoPOaEm0uvi8/g4TnIrHsVNX467HoSluJenxgnGLCh6kuDKOgWLRKWqXHBhn72HMDM4cLvPx/NGLElQq9mEZV2aNtdFslENgngIWirCRDZ3Yd0KPXo9/ZnUJEI6t2KwF0y+gg8tnrxkX6IywOOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EX5+aK/6; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2d4773f9-c3a4-4512-9c5c-92f841c326f5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738304898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z6nr90zQBuI/mRmsANmm014cd25JJit1RNWXmjt1m1g=;
	b=EX5+aK/6Og8svexi1PHU/CPZfYtsrcZHXTgeg9bnG1usrUIJepcjKdWtJ/vJ+z5PSfA0Ea
	MYY6LzwY6152AJXDF6jRg00V/i185IwtKOBncbtJB79yqcLIICAmKfsHmLz20dhOxXom8c
	BjwZCJDZHUWd8kVY2hIrVZW9D6iceTA=
Date: Thu, 30 Jan 2025 22:28:11 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] selftests: bpf: Support dynamic linking LLVM if static
 not available
Content-Language: en-GB
To: Daniel Xu <dxu@dxuuu.xyz>, shuah@kernel.org, andrii@kernel.org,
 eddyz87@gmail.com, ast@kernel.org, nathan@kernel.org, daniel@iogearbox.net
Cc: martin.lau@linux.dev, song@kernel.org, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 mykolal@fb.com, ndesaulniers@google.com, morbo@google.com,
 justinstitt@google.com, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
References: <872b64e93de9a6cd6a7a10e6a5c5e7893704f743.1738276344.git.dxu@dxuuu.xyz>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <872b64e93de9a6cd6a7a10e6a5c5e7893704f743.1738276344.git.dxu@dxuuu.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT




On 1/30/25 2:33 PM, Daniel Xu wrote:
> Since 67ab80a01886 ("selftests/bpf: Prefer static linking for LLVM
> libraries"), only statically linking test_progs is supported. However,
> some distros only provide a dynamically linkable LLVM.
>
> This commit adds a fallback for dynamically linking LLVM if static
> linking is not available. If both options are available, static linking
> is chosen.
>
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---
>   tools/testing/selftests/bpf/Makefile | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 6722080b2107..da514030a153 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -184,9 +184,14 @@ ifeq ($(feature-llvm),1)
>     LLVM_CONFIG_LIB_COMPONENTS := mcdisassembler all-targets
>     # both llvm-config and lib.mk add -D_GNU_SOURCE, which ends up as conflict
>     LLVM_CFLAGS  += $(filter-out -D_GNU_SOURCE,$(shell $(LLVM_CONFIG) --cflags))
> -  LLVM_LDLIBS  += $(shell $(LLVM_CONFIG) --link-static --libs $(LLVM_CONFIG_LIB_COMPONENTS))
> -  LLVM_LDLIBS  += $(shell $(LLVM_CONFIG) --link-static --system-libs $(LLVM_CONFIG_LIB_COMPONENTS))
> -  LLVM_LDLIBS  += -lstdc++
> +  # Prefer linking statically if it's available, otherwise fallback to shared
> +  ifeq ($(shell $(LLVM_CONFIG) --link-static --libs &> /dev/null && echo static),static)
> +    LLVM_LDLIBS  += $(shell $(LLVM_CONFIG) --link-static --libs $(LLVM_CONFIG_LIB_COMPONENTS))
> +    LLVM_LDLIBS  += $(shell $(LLVM_CONFIG) --link-static --system-libs $(LLVM_CONFIG_LIB_COMPONENTS))
> +    LLVM_LDLIBS  += -lstdc++
> +  else
> +    LLVM_LDLIBS  += $(shell $(LLVM_CONFIG) --link-shared --libs $(LLVM_CONFIG_LIB_COMPONENTS))
> +  endif
>     LLVM_LDFLAGS += $(shell $(LLVM_CONFIG) --ldflags)
>   endif

Although your change looks good, but maybe you can look at bpftool Makefile?

   # If LLVM is available, use it for JIT disassembly
   CFLAGS  += -DHAVE_LLVM_SUPPORT
   LLVM_CONFIG_LIB_COMPONENTS := mcdisassembler all-targets
   # llvm-config always adds -D_GNU_SOURCE, however, it may already be in CFLAGS
   # (e.g. when bpftool build is called from selftests build as selftests
   # Makefile includes lib.mk which sets -D_GNU_SOURCE) which would cause
   # compilation error due to redefinition. Let's filter it out here.
   CFLAGS  += $(filter-out -D_GNU_SOURCE,$(shell $(LLVM_CONFIG) --cflags))
   LIBS    += $(shell $(LLVM_CONFIG) --libs $(LLVM_CONFIG_LIB_COMPONENTS))
   ifeq ($(shell $(LLVM_CONFIG) --shared-mode),static)
     LIBS += $(shell $(LLVM_CONFIG) --system-libs $(LLVM_CONFIG_LIB_COMPONENTS))
     LIBS += -lstdc++
   endif
   LDFLAGS += $(shell $(LLVM_CONFIG) --ldflags)

It would be great if the selftests shared library handling to be the same as bpftool's.


