Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1825319551
	for <lists+bpf@lfdr.de>; Fri, 10 May 2019 00:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbfEIWk7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 May 2019 18:40:59 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:36225 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbfEIWk7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 May 2019 18:40:59 -0400
Received: by mail-it1-f195.google.com with SMTP id o190so6093662itc.1
        for <bpf@vger.kernel.org>; Thu, 09 May 2019 15:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+c2Z1tjGcCUP7qnZjAbhtnJOxApx0T1cMEm41uQaDmE=;
        b=WXPgU5ADcyJlbRA5g99WKXjN12emhy7wvNhkVXj6LV+uUQ2g0bLmxf2jfXO2F4wu1X
         GWnqbW6jVSPO8ccaxZVrWayTf97V8JS/XGyfLcknXAfPbIkM1xWZHQCTAjoLjza8PO+g
         m5D+vKj+1IO9XWuBCkY1ruZ7RPWbvFG//v0sE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+c2Z1tjGcCUP7qnZjAbhtnJOxApx0T1cMEm41uQaDmE=;
        b=QLnA4674Ud0B3oip+U9thggs7p7wdDXeXFYRcfh1obR44hDDjiV2hl4r80hyYLccED
         SKYIWiUA7SO4bGJGdTmbc5bTWqKYkeXxhT2b83gJzKfNvhYWXYyXowIWW8cS8rTzw4Nj
         U30ek7vb4v+OJuI0gNGvz86pg/0ETs5lFQQ+dLCQx62qF8fMdUnkT+3vNpUogz9bFLD7
         6zxWYoXXPFA1SJte70xSwSjfZZnbpe8P1XEhyYL2gBtblBAlkKUPIZbDEb2EqKANgN0d
         bl9dlht5gdvnmQnjIMEEKyiXIZ3c9Q6P9hdIiWhZEz2SxQXhYrMJPS+rwbxM7dzINPki
         Nuww==
X-Gm-Message-State: APjAAAVXnEqICLXxMeYt1P97xYT4inSz+kId6wVUYKEWHHVVIaoH0D4U
        MJPqMeNzhag2H8AY+9svidDsbw==
X-Google-Smtp-Source: APXvYqxMIWnH4z/8mfTvar+svk0lrRasK0Td8p6AI5iY6AsTpOwftDSabA89CDPcqRDna0Y8mne0pA==
X-Received: by 2002:a24:3ce:: with SMTP id e197mr5240351ite.167.1557441658274;
        Thu, 09 May 2019 15:40:58 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id j8sm1479790itk.0.2019.05.09.15.40.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 15:40:57 -0700 (PDT)
Subject: Re: [GIT PULL] Kselftest update for Linux 5.2-rc1
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        shuah <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
        davem@davemloft.net, Shuah Khan <skhan@linuxfoundation.org>
References: <9b434125-44b6-0e83-4f70-d1fd28752407@linuxfoundation.org>
 <20190509222043.b4zn32kuohduzzzr@ast-mbp>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <dd983d42-d148-372d-3e57-b97c313d58b9@linuxfoundation.org>
Date:   Thu, 9 May 2019 16:40:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190509222043.b4zn32kuohduzzzr@ast-mbp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 5/9/19 4:20 PM, Alexei Starovoitov wrote:
> On Mon, May 06, 2019 at 10:56:56AM -0600, Shuah Khan wrote:
>> Hi Linus,
>>
>> Please pull the following Kselftest update for Linux 5.2-rc1
>>
>> This Kselftest update for Linux 5.2-rc1 consists of
>>
>> - fixes to seccomp test, and kselftest framework
>> - cleanups to remove duplicate header defines
>> - fixes to efivarfs "make clean" target
>> - cgroup cleanup path
>> - Moving the IMA kexec_load selftest to selftests/kexec work from
>>    Mimi Johar and Petr Vorel
>> - A framework to kselftest for writing kernel test modules addition
>>    from Tobin C. Harding
>>
>> diff is attached.
>>
>> thanks,
>> -- Shuah
>>
>>
>> ----------------------------------------------------------------
>> The following changes since commit 15ade5d2e7775667cf191cf2f94327a4889f8b9d:
>>
>>    Linux 5.1-rc4 (2019-04-07 14:09:59 -1000)
>>
>> are available in the Git repository at:
>>
>>    git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest
>> tags/linux-kselftest-5.2-rc1
>>
>> for you to fetch changes up to d917fb876f6eaeeea8a2b620d2a266ce26372f4d:
>>
>>    selftests: build and run gpio when output directory is the src dir
>> (2019-04-22 17:02:26 -0600)
>>
>> ----------------------------------------------------------------
>> linux-kselftest-5.2-rc1
>>
>> This Kselftest update for Linux 5.2-rc1 consists of
>>
>> - fixes to seccomp test, and kselftest framework
>> - cleanups to remove duplicate header defines
>> - fixes to efivarfs "make clean" target
>> - cgroup cleanup path
>> - Moving the IMA kexec_load selftest to selftests/kexec work from
>>    Mimi Johar and Petr Vorel
>> - A framework to kselftest for writing kernel test modules addition
>>    from Tobin C. Harding
>>
>> ----------------------------------------------------------------
>> Kees Cook (3):
>>        selftests/seccomp: Handle namespace failures gracefully
>>        selftests/harness: Add 30 second timeout per test
>>        selftests/ipc: Fix msgque compiler warnings
>>
>> Mathieu Desnoyers (1):
>>        rseq/selftests: Adapt number of threads to the number of detected cpus
>>
>> Mimi Zohar (9):
>>        selftests/kexec: move the IMA kexec_load selftest to selftests/kexec
>>        selftests/kexec: cleanup the kexec selftest
>>        selftests/kexec: define a set of common functions
>>        selftests/kexec: define common logging functions
>>        selftests/kexec: define "require_root_privileges"
>>        selftests/kexec: kexec_file_load syscall test
>>        selftests/kexec: check kexec_load and kexec_file_load are enabled
>>        selftests/kexec: make kexec_load test independent of IMA being enabled
>>        selftests/kexec: update get_secureboot_mode
>>
>> Petr Vorel (1):
>>        selftests/kexec: Add missing '=y' to config options
>>
>> Po-Hsu Lin (1):
>>        selftests/efivarfs: clean up test files from test_create*()
>>
>> Roman Gushchin (1):
>>        selftests: cgroup: fix cleanup path in test_memcg_subtree_control()
>>
>> Sabyasachi Gupta (4):
>>        selftest/x86/mpx-dig.c: Remove duplicate header
>>        selftest/timers: Remove duplicate header
>>        selftest/rseq: Remove duplicate header
>>        selftest/gpio: Remove duplicate header
>>
>> Shuah Khan (2):
>>        selftests: fix headers_install circular dependency
> 
> Shuah,
> 
> the commit 8ce72dc32578 ("selftests: fix headers_install circular dependency")
> broke our build/test workflow, since it added:
>    ifneq ($(KBUILD_OUTPUT),)
>            OUTPUT := $(KBUILD_OUTPUT)
>    else
> 
> which means that all of selftests/bpf artifacts are now going into
> main build directory cluttering it with all sorts of .o, generated files
> and executables.
> The end result is humans and scripts can no longer find tests.
> 
> For now I hacked it as:
> diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
> index 5979fdc4f36c..caecec7aebde 100644
> --- a/tools/testing/selftests/lib.mk
> +++ b/tools/testing/selftests/lib.mk
> @@ -6,12 +6,8 @@ ifeq (0,$(MAKELEVEL))
>       ifneq ($(O),)
>          OUTPUT := $(O)
>       else
> -       ifneq ($(KBUILD_OUTPUT),)
> -               OUTPUT := $(KBUILD_OUTPUT)
> -       else
> -               OUTPUT := $(shell pwd)
> -               DEFAULT_INSTALL_HDR_PATH := 1
> -       endif
> +       OUTPUT := $(shell pwd)
> +       DEFAULT_INSTALL_HDR_PATH := 1
>       endif
>   endif
> 
> bpf developers are doing "cd tools/testing/selftests/bpf; make; ./test_verifier; ..."
> while KBUILD_OUTPUT is also set.
Sorry about that. I tested several use-cases, and missed this one. :(
This patch was in next for a while before I sent the pull request.

> I don't quite get this 'circular dependency' issue that your commit suppose to address
> but please fix it differently, so bpf developer's workflow is restored and buildbots work again.
> People and scripts depend on it.
> It's even described in Documentation/bpf/bpf_devel_QA.rst
> 

You won't see the circular dependency with your use-case. I will try
to get the fix in.

thanks,
-- Shuah



