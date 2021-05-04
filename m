Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4048A37311D
	for <lists+bpf@lfdr.de>; Tue,  4 May 2021 21:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbhEDUAG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 May 2021 16:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232615AbhEDUAG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 May 2021 16:00:06 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98E8C061574;
        Tue,  4 May 2021 12:59:10 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id v12so10681130wrq.6;
        Tue, 04 May 2021 12:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DrWNrfi+Ew4LFUqUpxDkLKZY4953siWYFeGLtwXjn7A=;
        b=QE+7SVJwjgYciwmKm9KJ3PY+qk14muy5KhsoBY6CxPqNYCB/3EW7hITS/9jUc+hNev
         eC1J6uUPUJ1K8aMJZFPaedCgd0W7KOBvWVOlteC0wcOGz05FFw5VptHLgRvMxfFbWXOn
         /lqYoLuS7wfqkDhCf71GFCG31oZOgi6OeXkslJCmvYt5PRtc2zA8KRUS+/PNI5vEntjv
         Ni2YjnYHjt9RZggtvIfXfTm9bnPiQ9VpW/1Q7Bj0UhQd4BJSBC9DdG3FoEiLAK6mG9Ra
         JxO5nnZ5gH65gA/mtu3gIVC6RCJ1AHsM5+9MiTcOfjku52Rv30TcR42tCOiJ0lTrLBCi
         5Clw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DrWNrfi+Ew4LFUqUpxDkLKZY4953siWYFeGLtwXjn7A=;
        b=oRJYbmItkqxdMFX68NkwEhCJiW5MmdTV3VFoNHgzqa4foIGshnKURjWeTnJ78MxN7N
         L+DAxHlYNMz0c57hdF26yMyClnurZ1IUlktapi7JdN1EmBQ0IkShcoV1vqIHyPV1Uc34
         x+2st6VApjKzazZeUNZlm4e7edeZAR24MdVU/kKIK3tKQQe2a2dI35apqe4q1423Wi3n
         fvLWTrGDUOKCjlgs9ZWNqu3keoLHM31gx0PrnWvmOzUJKFluIawgHC6rS1xGaEXET9/v
         aFLhwNiJSEqgi+oDR0ebt1ttdvBs3L/kXwtSOSUU7shbj4BHwFFaEUBEFdtuNEXJmU/5
         gEFA==
X-Gm-Message-State: AOAM533wCjS/lALEiF8oT6RyB/Vcy0UDy1g5kvJqF2e+nUCUvj+ZpEcE
        2nxNZoYve9ZOQOGq/2sRmW0=
X-Google-Smtp-Source: ABdhPJx8/T5dui/MKJ9f8IBJbNOXe96bYqrulWjqjgmOC+4G26OcBLa/GwDB3uSESgK9l9w+4GTsZg==
X-Received: by 2002:a05:6000:186f:: with SMTP id d15mr33984740wri.400.1620158349706;
        Tue, 04 May 2021 12:59:09 -0700 (PDT)
Received: from [192.168.0.237] ([170.253.36.171])
        by smtp.gmail.com with ESMTPSA id x17sm3426158wmc.11.2021.05.04.12.59.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 May 2021 12:59:09 -0700 (PDT)
Subject: Re: [RFC v2] bpf.2: Use standard types and attributes
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Zack Weinberg <zackw@panix.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        linux-man <linux-man@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        glibc <libc-alpha@sourceware.org>, GCC <gcc-patches@gcc.gnu.org>,
        bpf <bpf@vger.kernel.org>,
        Joseph Myers <joseph@codesourcery.com>,
        David Laight <David.Laight@aculab.com>
References: <20210423230609.13519-1-alx.manpages@gmail.com>
 <20210504110519.16097-1-alx.manpages@gmail.com>
 <CAADnVQLdW=jH1CUP02jokEu3Sh+=xKsCXvjA19kfz7KOn9mzkA@mail.gmail.com>
 <YJFZHW2afbAMVOmE@kroah.com> <69fb22e0-84bd-47fb-35b5-537a7d39c692@gmail.com>
 <YJFxArfp8wN3ILJb@kroah.com>
 <CAKCAbMg_eRCsD-HYmryL8XEuZcaM1Qdfp4XD85QKT6To+h3QcQ@mail.gmail.com>
 <6740a229-842e-b368-86eb-defc786b3658@gmail.com>
 <87r1imgu5g.fsf@oldenburg.str.redhat.com>
From:   "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Message-ID: <0d9a795a-7c6a-3889-af31-2223dc216d15@gmail.com>
Date:   Tue, 4 May 2021 21:59:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <87r1imgu5g.fsf@oldenburg.str.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Florian,

On 5/4/21 9:45 PM, Florian Weimer wrote:
> * Alejandro Colomar:
> 
>> The thing is, in all of those threads, the only reasons to avoid
>> <stdint.h> types in the kernel (at least, the only explicitly
>> mentioned ones) are (a bit simplified, but this is the general idea of
>> those threads):
>>
>> * Possibly breaking something in such a big automated change.
>> * Namespace collision with userspace (the C standard allows defining
>>    uint32_t for nefarious purposes as long as you don't include
>>   <stdint.h>.   POSIX prohibits that, though)
>> * Uglier
> 
> __u64 can't be formatted with %llu on all architectures.  That's not
> true for uint64_t, where you have to use %lu on some architectures to
> avoid compiler warnings (and technically undefined behavior).  There are
> preprocessor macros to get the expected format specifiers, but they are
> clunky.  I don't know if the problem applies to uint32_t.  It does
> happen with size_t and ptrdiff_t on 32-bit targets (both vary between
> int and long).
> 

Hmmm, that's interesting.  It looks like Linux always uses long long for 
64 bit types, while glibc uses 'long' as long as it's possible, and only 
uses 'long long' when necessary.  Assignment is still 100% valid both 
ways and binary compatibility also 100% (AFAIK), given they're the same 
length and signedness, but pointers are incompatible.  That's something 
to note, even though in this case there are no pointers involved, so no 
incompatibilities.  Maybe the kernel and glibc could use the same rules 
to improve compatibility, but that's out of the scope of this.

Thanks,

Alex


-- 
Alejandro Colomar
Linux man-pages comaintainer; https://www.kernel.org/doc/man-pages/
http://www.alejandro-colomar.es/
