Return-Path: <bpf+bounces-45471-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD529D6129
	for <lists+bpf@lfdr.de>; Fri, 22 Nov 2024 16:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 606AB1602C6
	for <lists+bpf@lfdr.de>; Fri, 22 Nov 2024 15:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7EC515ADAB;
	Fri, 22 Nov 2024 15:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d0sl82Qh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E798148FE1
	for <bpf@vger.kernel.org>; Fri, 22 Nov 2024 15:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732288503; cv=none; b=M5XHH7JVVDR+dHIFfOm0mSomMsdUyzrehnv+rxJIzLoUfCUC50ZB6u5HTQILq+kBavdo+Ufm79cxUbn7Wy69NnIEtZ4jX4HRg5EA29P0/aj2qVNE5udtYnU+0l4WRhBs4ck212p8pv17oxJ4fvQOcwWxuy/DUYwna4tYbakN9OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732288503; c=relaxed/simple;
	bh=G4ZWYFmDGGCQIedY71/8GZGdAfKcnsuVFa5JVn99a40=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X4X5ojLrdtCh/5Q3q+uHQVa6c1jU7CnDpvFrpGlJ2mvrSC0nSxr5e3fWiFCCMF6jC9gxUANOHcjB1jfnQITZTH+tdRZjbFXH/pPHWE2y+u1w6SqgO2u+RIMd9NRIkjQ/eJQ+DP15Pk0TK+8B/EoTmJ/ieksYzyrKeA2VJO3V64A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=d0sl82Qh; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-83a9be2c028so74305139f.1
        for <bpf@vger.kernel.org>; Fri, 22 Nov 2024 07:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1732288500; x=1732893300; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rmBxC4X0qWTi2jB3Mdi9nSIUH+PS6n9GSNvglpxej84=;
        b=d0sl82QhPnq84etKN05j5uIcVQ0fDAtllmUo3ENl6LHqc/FE29FuxkudCbEzHXaOLM
         SqfYgvVMwCmhCihB1tE4trzsr/522vvpr77e+qPZ7YYl4Eob17aV7Ea/Pa0+BFB126J3
         ZEan1Yo/R3EMd1RW3CYQAHlHwdDD8oCmh8aJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732288500; x=1732893300;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rmBxC4X0qWTi2jB3Mdi9nSIUH+PS6n9GSNvglpxej84=;
        b=Qk2fjqUf1DZgKUh3fnBO/AHMU3LH+4pVoRZEysw8R7hPksR/Jka0/qtqJ5os21KXWd
         RrYCx9cNkrSl1FHog2rdMEC81BgLh7wezt+6meyq3YU7kFxgdcuxG8LN1YgCplzbaRw+
         0KZKwKoXZ8/C7KJhuNGicMJBmyzPAW6w8BOarIiPjRjiJwg6yKbhSvdrR3ddvQ2ELzDf
         Qi1C3ZEJlh74CmjKJci2wWfX70upXAgR5DIOlUjSY3e1klEY7v4zCImOKAx6yu+3CKLR
         LtqT9RCUkWEZ2X8dRHcwIjixsBakzP38Wsig4XIkJfzVUAChYOMR8IT2OGjs54Zob3WM
         arsw==
X-Forwarded-Encrypted: i=1; AJvYcCW6nYpK4oNZChVoSNBzKTARmNdISFIVNeMV+vZOiUom7crYyHmvtO2K3RZM3Wo4AkR94ZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5DIDC8pUoMEwN5dXYs6jopzji4sD7+L6IQofVY7awdiqNZrkA
	xkv9Rknz/rj6WXmLsvfC1rf9y3lfAYVs4t+utIAseIQXDifzfldZAsyNquZJDs8sSiaRu5ExpTB
	h
X-Gm-Gg: ASbGncvQkTqw3McOtLOeiy+7OYBDxURf6GnrLaOubFh4N88VpTGGWX2aBWs7hJZPGDl
	5RuTumfMDUY4pV0mHgkWyTf/1jYAWAOMoa9Jx2HGatOCH9ZBVube4OdG+aIGzf8In3VI/TmjwBv
	9bfZI8jQbLg3MCbUvGVQEmX5sQghLYZJJj9M1WbcXJbYkqxIJX71GOwgvtrH+bye7goLvAWj3cW
	j/UqdTL3hihwsanz/ry0tnJv+5KBqlOQ9oNExcR8u6XFx+LmIm6r/2RwgoLPg==
X-Google-Smtp-Source: AGHT+IHy5Cwa3AA3W2fNjldnU0Ki3uW2K71uWzdXCbgAWsASPCmhOBROw7+r3q6xtya9E03fAwzWCw==
X-Received: by 2002:a05:6602:3c6:b0:83b:47:8d5 with SMTP id ca18e2360f4ac-83ecdc538d9mr370017639f.3.1732288500377;
        Fri, 22 Nov 2024 07:15:00 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e1cfe1a0e2sm640295173.7.2024.11.22.07.14.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 07:14:59 -0800 (PST)
Message-ID: <93d96c99-4712-4054-a36f-3c65c80ab3f8@linuxfoundation.org>
Date: Fri, 22 Nov 2024 08:14:58 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH kselftest] fix single bpf test
To: Jiayuan Chen <mrpre@163.com>, linux-kselftest@vger.kernel.org,
 Mark Brown <broonie@kernel.org>
Cc: song@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, martin.lau@linux.dev, andrii@kernel.org,
 ast@kernel.org, kpsingh@kernel.org, jolsa@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241118140608.53524-1-mrpre@163.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241118140608.53524-1-mrpre@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/18/24 07:06, Jiayuan Chen wrote:
> Currently, when testing a certain target in selftests, executing the
> command 'make TARGETS=XX -C tools/testing/selftests' succeeds for non-BPF,
> but a similar command fails for BPF:
> '''
> make TARGETS=bpf -C tools/testing/selftests
> 
> make: Entering directory '/linux-kselftest/tools/testing/selftests'
> make: *** [Makefile:197: all] Error 1
> make: Leaving directory '/linux-kselftest/tools/testing/selftests'
> '''
> 
> The reason is that the previous commit:
> commit 7a6eb7c34a78 ("selftests: Skip BPF seftests by default")
> led to the default filtering of bpf in TARGETS which make TARGETS empty.
> That commit also mentioned that building BPF tests requires external
> commands to run. This caused target like 'bpf' or 'sched_ext' defined
> in SKIP_TARGETS to need an additional specification of SKIP_TARGETS as
> empty to avoid skipping it, for example:
> '''
> make TARGETS=bpf SKIP_TARGETS="" -C tools/testing/selftests
> '''
> 
> If special steps are required to execute certain test, it is extremely
> unfair. We need a fairer way to treat different test targets.
> 

Note: Adding Mark, author for commit 7a6eb7c34a78 to the thread

The reason we did this was bpf test depends on newer versions
of LLVM tool chain.

A better solution would be to check for compile time dependencies in
bpf Makefile and check run-time dependencies from bpf test or a wrapper
script invoked from run_tests to the skip the test if test can't run.

I would like to see us go that route over addressing this problem
with SKIP_TARGETS solution.

The commit 7a6eb7c34a78 went in 4 years ago? DO we have a better
story for the LLVM tool chain to get rid of skipping bpf and sched_ext?

Running make -C tools/testing/selftests/bpf/ gave me the following error.
Does this mean we still can't include bpf in default run?

make -C tools/testing/selftests/bpf/
make: Entering directory '/linux/linux_6.12/tools/testing/selftests/bpf'

Auto-detecting system features:
...                                    llvm: [ OFF ]


   GEN     /linux/linux_6.12/tools/testing/selftests/bpf/tools/build/bpftool/vmlinux.h
libbpf: failed to find '.BTF' ELF section in /linux/linux_6.12/vmlinux
Error: failed to load BTF from /linux/linux_6.12/vmlinux: No data available
make[1]: *** [Makefile:209: /linux/linux_6.12/tools/testing/selftests/bpf/tools/build/bpftool/vmlinux.h] Error 195
make[1]: *** Deleting file '/linux/linux_6.12/tools/testing/selftests/bpf/tools/build/bpftool/vmlinux.h'
make: *** [Makefile:369: /linux/linux_6.12/tools/testing/selftests/bpf/tools/sbin/bpftool] Error 2
make: Leaving directory '/linux/linux_6.12/tools/testing/selftests/bpf'

> This commit provider a way: If a user has specified a single TARGETS,
> it indicates an expectation to run the specified target, and thus the
> object should not be skipped.
> 
> Another way is to change TARGETS to DEFAULT_TARGETS in the Makefile and
> then check if the user specified TARGETS and decide whether filter or not,
> though this approach requires too many modifications.
> Signed-off-by: Jiayuan Chen <mrpre@163.com>
> ---
>   tools/testing/selftests/Makefile | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index 363d031a16f7..d76c1781ec09 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -116,7 +116,7 @@ TARGETS += vDSO
>   TARGETS += mm
>   TARGETS += x86
>   TARGETS += zram
> -#Please keep the TARGETS list alphabetically sorted
> +# Please keep the TARGETS list alphabetically sorted
>   # Run "make quicktest=1 run_tests" or
>   # "make quicktest=1 kselftest" from top level Makefile
>   
> @@ -132,12 +132,15 @@ endif
>   
>   # User can optionally provide a TARGETS skiplist. By default we skip
>   # targets using BPF since it has cutting edge build time dependencies
> -# which require more effort to install.
> +# If user provide custom TARGETS, we just ignore SKIP_TARGETS so that
> +# user can easy to test single target which defined in SKIP_TARGETS
>   SKIP_TARGETS ?= bpf sched_ext
>   ifneq ($(SKIP_TARGETS),)
> +ifneq ($(words $(TARGETS)), 1)
>   	TMP := $(filter-out $(SKIP_TARGETS), $(TARGETS))
>   	override TARGETS := $(TMP)
>   endif
> +endif
>   
>   # User can set FORCE_TARGETS to 1 to require all targets to be successfully
>   # built; make will fail if any of the targets cannot be built. If
> 
> base-commit: 67b6d342fb6d5abfbeb71e0f23141b9b96cf7bb1

thanks,
-- Shuah

