Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56D1118329B
	for <lists+bpf@lfdr.de>; Thu, 12 Mar 2020 15:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbgCLOPS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Mar 2020 10:15:18 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37902 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbgCLOPS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Mar 2020 10:15:18 -0400
Received: by mail-wr1-f65.google.com with SMTP id x11so2916631wrv.5
        for <bpf@vger.kernel.org>; Thu, 12 Mar 2020 07:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VMEvwyC77GXnGO2rSUyO+xui8zJErMGcDBUsFB0iwHk=;
        b=Cog5P0XOgKXw/oVes6R/jzu9Y0dN+s4ErOv74KWTZL4oprATUFNp6UBkpAIyGnjOvB
         w7LCXG4SaEpnNnaupguvNrlkTtr4HrnwUAoAJVyC0oBG3ZvDQ8lMAo2uc4YRehNnDysd
         ZQOcXCJ1cqS5Q+ppS1VsP8GHcQVaetUKW8tMjdyldRxWpAs6x/9EYOUBfcUj25KXr3wd
         A+zCG0N0hNbfH0r5DXXyqc9PBHILAYMPLdg/1zeDXoZS+myvTsYLXGtJZvUiJdF/WB/D
         Akk5YfpCOv7UyG9jTQ3NcboGbhO+pGGvG+HuZ0MOA0r4NT1R7Euswewbb7JVaDShyLI2
         djbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VMEvwyC77GXnGO2rSUyO+xui8zJErMGcDBUsFB0iwHk=;
        b=mpRuTMikpScnStj0B09lY9KVJEKh9wNN6/nbBUNCEwATYK8VX0xzOOFWV17nCQvRQp
         4H2UNKfXIn7zcIGfsnuKAXbo9sH+tBWmm7sRv0OO7a3M0jU/a8R/izbod0ZwfFhrP2YK
         QWujP6BoRDwyL0o5aZgmmXqKJqq3G6EDEGDRrKzpHEwqx/F9JsTG91m/gvcZTLp5Hxat
         09xuijILm6Xs0+vUpmO1kfN0VSUblfaeAxEd1l/4sE9ur6PoW1j9fPv4RN4SaXNAHgrC
         qaUWuLHB7C+6WGT9ucDaxHgstEngydtKOiF6l43Q8Dj7bRWFSrWnW9dAe0LFHWW08+b8
         0+rg==
X-Gm-Message-State: ANhLgQ22Y945aSuCa0sYrG9CGOzfnH0bG4lRnfQiWIQcpqfPEgUTISAF
        0v4b8rK5mn2UO8kIAcycLpJMlQ==
X-Google-Smtp-Source: ADFU+vu9/OBTYCLMNLSZjYlP33eK+0eZJYcHOitu6lHMYx86ehCwVBprXkhCjfyGuCUmIwZVUEpxow==
X-Received: by 2002:adf:f00d:: with SMTP id j13mr11776282wro.207.1584022516208;
        Thu, 12 Mar 2020 07:15:16 -0700 (PDT)
Received: from [192.168.1.10] ([194.35.118.177])
        by smtp.gmail.com with ESMTPSA id o9sm78196201wrw.20.2020.03.12.07.15.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2020 07:15:15 -0700 (PDT)
Subject: Re: [PATCH bpf-next v2] bpftool: use linux/types.h from source tree
 for profiler build
To:     Tobias Klauser <tklauser@distanz.ch>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        bpf@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
References: <20200312105335.10465-1-tklauser@distanz.ch>
 <20200312130330.32239-1-tklauser@distanz.ch>
From:   Quentin Monnet <quentin@isovalent.com>
Message-ID: <a01e3ca9-0787-2537-3cb4-91a869929aaf@isovalent.com>
Date:   Thu, 12 Mar 2020 14:15:09 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200312130330.32239-1-tklauser@distanz.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2020-03-12 14:03 UTC+0100 ~ Tobias Klauser <tklauser@distanz.ch>
> When compiling bpftool on a system where the /usr/include/asm symlink
> doesn't exist (e.g. on an Ubuntu system without gcc-multilib installed),
> the build fails with:
> 
>     CLANG    skeleton/profiler.bpf.o
>   In file included from skeleton/profiler.bpf.c:4:
>   In file included from /usr/include/linux/bpf.h:11:
>   /usr/include/linux/types.h:5:10: fatal error: 'asm/types.h' file not found
>   #include <asm/types.h>
>            ^~~~~~~~~~~~~
>   1 error generated.
>   make: *** [Makefile:123: skeleton/profiler.bpf.o] Error 1
> 
> This indicates that the build is using linux/types.h from system headers
> instead of source tree headers.
> 
> To fix this, adjust the clang search path to include the necessary
> headers from tools/testing/selftests/bpf/include/uapi and
> tools/include/uapi. Also use __bitwise__ instead of __bitwise in
> skeleton/profiler.h to avoid clashing with the definition in
> tools/testing/selftests/bpf/include/uapi/linux/types.h.
> 
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Song Liu <songliubraving@fb.com>
> Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Cc: Quentin Monnet <quentin@isovalent.com>
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>

Looks good, thanks!
Reviewed-by: Quentin Monnet <quentin@isovalent.com>
