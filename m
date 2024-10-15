Return-Path: <bpf+bounces-42001-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 454EE99E354
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 12:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75FD91C210B9
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 10:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7722E19F132;
	Tue, 15 Oct 2024 10:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UDaQ3Qf3"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B9E4C9F
	for <bpf@vger.kernel.org>; Tue, 15 Oct 2024 10:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728986646; cv=none; b=W4JHl1ZBOfFkwRUs2ntoInECTbvRE8HzZsY8MTk+PQO0GRrEOg1qoGfeWWPnOpAowlEnO1PUZiX09IzymIM9bCS1tvUsiVXrvjf+drTtgfVs/CzYUnINFXSb3WSfAAn8sianpu4X+7/whmBxGF3KhueRL5sQ4HVFCSOE8G49HAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728986646; c=relaxed/simple;
	bh=T53EwSYb/MSFYhaGXWdhOX/Pc/CvyJUfIIXtobnL1RQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S5RLCFTeBWO6FlGKbqEGHszl/JllErXAe4mc7rUMdymQELNBoQSZkGkOqMpdKH7WZl/lzsARuMG4FT8U1gGyZTnjSHsdCcu2JhfKOHd18KymFTqODKu35tUfM9iGamN25GxmIn8cje8rA/fjdepLwhpIQY/zdFVYtOPbki58xyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UDaQ3Qf3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F884C4CECE;
	Tue, 15 Oct 2024 10:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728986645;
	bh=T53EwSYb/MSFYhaGXWdhOX/Pc/CvyJUfIIXtobnL1RQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UDaQ3Qf3wpNXXb8Ge044RDoTjvwLGnz2+ttc6V+rzP9zDasPi7neLAqkH6S/64p5u
	 J9zJliweuyzPsvfCrot5I1eT2uK2Vrgq3jZXq1W99Tik9Xk3gDi37XnqwEmfUjdD1s
	 HfoBDu3U4lFL9kwakifFal93dcB0cDrYY/KZyS0CW3+7mNGGM+mPviFN306bLfQxxo
	 goVXL2dd0BCzDOEeFn8BuCthfNSm+cE5Mg6ghsMA05EoOCG1VjrW/21kSQdpGfYtPy
	 dCHpWPFJCIdqBZXpbGB0huLTDCUvcZPH2AayPyNOkXVPd1Oh0K7pIBNj1PVhUkeRnd
	 xxQ4ECaCsl71w==
Message-ID: <13c4f2dd-e315-4d0e-9481-b385946c33dc@kernel.org>
Date: Tue, 15 Oct 2024 11:03:53 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 2/3] bpftool: Prevent setting duplicate
 _GNU_SOURCE in Makefile
To: Viktor Malik <vmalik@redhat.com>, bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>
References: <cover.1728975031.git.vmalik@redhat.com>
 <507d699068777b78a5720e617c99fb19a9bb8a89.1728975031.git.vmalik@redhat.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <507d699068777b78a5720e617c99fb19a9bb8a89.1728975031.git.vmalik@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

2024-10-15 08:54 UTC+0200 ~ Viktor Malik <vmalik@redhat.com>
> When building selftests with CFLAGS set via env variable, the value of
> CFLAGS is propagated into bpftool Makefile (called from selftests
> Makefile). This makes the compilation fail as _GNU_SOURCE is defined two
> times - once from selftests Makefile (by including lib.mk) and once from
> bpftool Makefile (by calling `llvm-config --cflags`):
> 
>      $ CFLAGS="" make -C tools/testing/selftests/bpf
>      [...]
>      CC      /bpf-next/tools/testing/selftests/bpf/tools/build/bpftool/btf.o
>      <command-line>: error: "_GNU_SOURCE" redefined [-Werror]
>      <command-line>: note: this is the location of the previous definition
>      cc1: all warnings being treated as errors
>      [...]
> 
> Let bpftool Makefile check if _GNU_SOURCE is already defined and if so,
> do not let llvm-config add it again.
> 
> Signed-off-by: Viktor Malik <vmalik@redhat.com>
> ---
>   tools/bpf/bpftool/Makefile | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
> index ba927379eb20..2b5a713d71d8 100644
> --- a/tools/bpf/bpftool/Makefile
> +++ b/tools/bpf/bpftool/Makefile
> @@ -147,7 +147,13 @@ ifeq ($(feature-llvm),1)
>     # If LLVM is available, use it for JIT disassembly
>     CFLAGS  += -DHAVE_LLVM_SUPPORT
>     LLVM_CONFIG_LIB_COMPONENTS := mcdisassembler all-targets
> -  CFLAGS  += $(shell $(LLVM_CONFIG) --cflags)
> +  # When bpftool build is called from another Makefile which already sets
> +  # -D_GNU_SOURCE, do not let llvm-config add it again as it will cause conflict.


Thanks! Can you please make your comment more explicit and mention the 
file tools/testing/selftests/lib.mk and/or the use case addressed 
(building bpftool from selftests), given that you match on the exact 
string "-D_GNU_SOURCE="? Your check won't skip adding the duplicate 
definition if someone passes "-D_GNU_SOURCE", without the "=", by 
calling the Makefile from another path; that's fine, but I don't want 
users to read the Makefile and expect it to remove the second definition 
in such a case.


> +  ifneq ($(filter -D_GNU_SOURCE=,$(CFLAGS)),)
> +    CFLAGS += $(filter-out -D_GNU_SOURCE,$(shell $(LLVM_CONFIG) --cflags))
> +  else
> +    CFLAGS += $(shell $(LLVM_CONFIG) --cflags)
> +  endif

Looks good otherwise:

Reviewed-by: Quentin Monnet <qmo@kernel.org>

