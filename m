Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7E1F41EB63
	for <lists+bpf@lfdr.de>; Fri,  1 Oct 2021 13:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353725AbhJALIb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 1 Oct 2021 07:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353721AbhJALIb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Oct 2021 07:08:31 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADBBCC06177B
        for <bpf@vger.kernel.org>; Fri,  1 Oct 2021 04:06:46 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id r11-20020a1c440b000000b0030cf0f01fbaso3375167wma.1
        for <bpf@vger.kernel.org>; Fri, 01 Oct 2021 04:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=Ic8xXiFIaM5JGwOBFHZCQicrwrYtjcMu6SEU2TZ/HzU=;
        b=xveUO6JABTX6wVw2mDKiysxksM8SH6FnuIPhIoGVMSaHIn6H0VD9NKBKFi+sOge3lN
         J+k3GBgST1yZyd2ZsjRmG1Yzo17/kj6ISXX1WoMhqpVXcYkxo/6T6CM9JhcHjyd7qUOl
         MhO4lqeNb3C+6WtpbOwfhT3UqYukYb+VXdrlPmchA8pr/eWa9DuPP7LCFTLiGlwEklXp
         Gt2p+vk42HNGfSSqk4R8/gxL+fCDqE+gCjRiGvfndDdOjf/G7UfRziAm3yyPlGkV/g0A
         N3c6l5+FfalAY3woJmPZj3CcHbUhz+WUevTW3lKIw+2uJOa2jBJxID/XRTyEzJdwRSY1
         7oBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=Ic8xXiFIaM5JGwOBFHZCQicrwrYtjcMu6SEU2TZ/HzU=;
        b=QjHtnAxmM7omnqkyoqVhVjeJbK49JOS1tC7XAgQ9YOhWUjcyytJgzGgye/bx3Wd8DG
         gRQSOqXxH3uoE2rcCGzCmT33KtAl7TpuzNvkt8HJMM+zWYOV7Ftda4Ky3000zAnElPpQ
         +WKYOXcBn5yQQoLuWdFea0m6V/ySuJ5F6bFSLWsBYTilT4QBSifrooEQUpVO/cwUY9DO
         osMHl4RxlDRTOurTWBsWUr1MigcpO8R4Gt0+RjR/4s+NpgHRKrev+zZ54d2e6m7Y1knU
         m1oJd41eRkyzSaRzPk84SXWWDvZJAYRNtYIBiOlvjm/5rrLfrKBWHlxeH/OvwmTxQ0fW
         jlXw==
X-Gm-Message-State: AOAM530LJqWRAigAgfhUCKUlgYfIAX8+J7JIYByBt0nsmZwIAzeg8LGy
        54xrKERO+UyRn8ZB1Z6hKEHckA==
X-Google-Smtp-Source: ABdhPJxbDoDy2kazexW//RNpVrkMlwjdEz2/ZLPKYlKUl3giJE+FrAoXmwQECe+3ot8yERe4gzizgA==
X-Received: by 2002:a1c:7d44:: with SMTP id y65mr3728469wmc.181.1633086405139;
        Fri, 01 Oct 2021 04:06:45 -0700 (PDT)
Received: from [192.168.1.8] ([149.86.91.69])
        by smtp.gmail.com with ESMTPSA id f15sm5221859wrd.44.2021.10.01.04.06.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Oct 2021 04:06:44 -0700 (PDT)
Message-ID: <37d25d01-c6ad-4ff9-46e2-236c60369171@isovalent.com>
Date:   Fri, 1 Oct 2021 12:06:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH bpf-next 6/9] bpf: iterators: install libbpf headers when
 building
Content-Language: en-US
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org
References: <20210930113306.14950-1-quentin@isovalent.com>
 <20210930113306.14950-7-quentin@isovalent.com>
 <354d2a7b-3dfc-f1b2-e695-1b77d013c621@isovalent.com>
In-Reply-To: <354d2a7b-3dfc-f1b2-e695-1b77d013c621@isovalent.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2021-09-30 13:17 UTC+0100 ~ Quentin Monnet <quentin@isovalent.com>
> 2021-09-30 12:33 UTC+0100 ~ Quentin Monnet <quentin@isovalent.com>
>> API headers from libbpf should not be accessed directly from the
>> library's source directory. Instead, they should be exported with "make
>> install_headers". Let's make sure that bpf/preload/iterators/Makefile
>> installs the headers properly when building.
> 
> CI complains when trying to build
> kernel/bpf/preload/iterators/iterators.o. I'll look more into this.

My error was in fact on the previous patch for kernel/preload/Makefile,
where iterators.o is handled. The resulting Makefile in my v1 contained:

	bpf_preload_umd-objs := iterators/iterators.o
	bpf_preload_umd-userldlibs := $(LIBBPF_A) -lelf -lz

	$(obj)/bpf_preload_umd: $(LIBBPF_A)

This declares a dependency on $(LIBBPF_A) for building the final
bpf_preload_umd target, when iterators/iterators.o is linked against the
libraries. It does not declare the dependency for iterators/iterators.o
itself. So when we attempt to build the object file, libbpf has not been
compiled yet (not an issue per se), and the API headers from libbpf have
not been installed and made available to iterators.o, causing the build
to fail.

Before this patch, there was no issue because the headers would be
included directly from tools/lib/bpf, so they would always be present.
I'll fix this by adding the relevant dependency, and send a v2.

As a side note, I couldn't reproduce the issue locally or in the VM for
the selftests, I'm not sure why. I struggled to get helpful logs from
the kernel CI (kernel build in non-verbose mode), so I ended up copying
the CI infra (running on kernel-patches/bpf on GitHub) to my own GitHub
repository to add debug info and do other runs without re-posting every
time to the mailing list. In case anyone else is interested, I figured I
might share the steps:

- Clone the linux repo on GitHub, push the bpf-next branch
- Copy all files and directories from the kernel-patches/vmtest GitHub
repo (including the .github directory) to the root of my linux repo, on
my development branch.
- Update the checks on "kernel-patches/bpf" repository name in
.github/workflows/test.yaml, to avoid pulling new Linux sources and
overwriting the files on my branch.
- (Add as much build debug info as necessary.)
- Push the branch to GitHub and open a PR against my own bpf-next
branch. This should trigger the Action.

Or was there a simpler way to test my set on the CI, that I ignore?

Quentin
