Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E05AE36A275
	for <lists+bpf@lfdr.de>; Sat, 24 Apr 2021 19:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbhDXR5U (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 24 Apr 2021 13:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbhDXR5T (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 24 Apr 2021 13:57:19 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B885FC061574;
        Sat, 24 Apr 2021 10:56:39 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id a26-20020a05600c225ab029013f5867af96so699467wmm.0;
        Sat, 24 Apr 2021 10:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+3dJUoLYyYMa/vI7AHmb/SZXL5HX54JGSkbPUpPeWD0=;
        b=I7TgfXrERMrF6Fg9DoDM8q+Lt7w163xeraBoXQ/1BM9RzL4K0G+rDROWM2V/6qnvoy
         3sIX4n4Qi9bf/mxEDs21jY84L8sqKVUuX0LQEIrzUXQvO1FZTuzC+C3Y6ClblxviaKCg
         7eWglwb9jr7+x9ZgdvSNAkR6cnsyMdEBZrpgsYc0Mw305P9W3cV8xhRMZoZJqGFuLFrD
         ls1AwHYPWZIlxFZhnFv021paz1pa4MXi8i3eLBbEofdU0QmFy2kOCmAK4KNvsn5RHXoJ
         5Dw/+O/OM7OJpWUXNhrfGIQQs9rdGoVLHVAtfYNL7Pu2eZDbYkdXzWlkTa1sAfNNkTwu
         WcXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+3dJUoLYyYMa/vI7AHmb/SZXL5HX54JGSkbPUpPeWD0=;
        b=DMKceKyBp0j78qITgJVWP1DVNbPjBdmikB6mxCxd/aNdBudmTq5e47mp+gpzaqdy1C
         ZuYqdX08r8QdH1OUQMRpdrhuPMqU4N1GHaBXAso+Lv5IQafXG1KbYx1Rjz2Mn6vUR5Tb
         KeZeSxGabhRj0bVM6jzwHgcPyBThNIMC1RU0WYetVojW7oMMVIm7cZ7pMqDyKRRTJRNI
         yv1MCLt5DRlBUflAX2XlVvEoj+Zx+2SijUanfqqSxfVuriZj+mEmwGsjxNzHlg5v8i3K
         1tOeotcXyzD5OB1GdwNFEiD9cl/HAu/GfjxgCFT5exQKHN5YJ4eEJC6j6jA99tnWwss3
         QBBQ==
X-Gm-Message-State: AOAM530fBV/ZAYRMvhMnRR8aKezM1Jh4HuBhUP76nDycHXR4KnoxL6Lm
        EFXJaPrAYmV67AtYVAep2vs=
X-Google-Smtp-Source: ABdhPJyLjRZ6IPyTgXPVKlvPeziTETG15nsqCl3g7zO7HhQkPygxFVlUvq4iKkWvgcpkbthEvvaxEw==
X-Received: by 2002:a1c:6382:: with SMTP id x124mr11669823wmb.142.1619286998442;
        Sat, 24 Apr 2021 10:56:38 -0700 (PDT)
Received: from [192.168.0.169] ([170.253.36.171])
        by smtp.gmail.com with ESMTPSA id t14sm13485428wrz.55.2021.04.24.10.56.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Apr 2021 10:56:38 -0700 (PDT)
Subject: Re: [RFC] bpf.2: Use standard types and attributes
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>
Cc:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        linux-man <linux-man@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, libc-alpha@sourceware.org,
        gcc-patches@gcc.gnu.org
References: <20210423230609.13519-1-alx.manpages@gmail.com>
 <CAADnVQLf4qe3Hj7cjBUCY4wXb9t2ZjUt=Z=JuygRY0LNNHWAoA@mail.gmail.com>
From:   "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Message-ID: <56932c68-4992-c5e4-819f-a88f60b3f63a@gmail.com>
Date:   Sat, 24 Apr 2021 19:56:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <CAADnVQLf4qe3Hj7cjBUCY4wXb9t2ZjUt=Z=JuygRY0LNNHWAoA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello Alexei,

On 4/24/21 1:20 AM, Alexei Starovoitov wrote:
> Nack.
> The man page should describe the kernel api the way it is in .h file.

Why?

When glibc uses __size_t (or any other non-standard types) just because 
the standard doesn't allow it to define some types in some specific 
header, the manual pages document the equivalent standard type, (i.e., 
if glibc uses __size_t, we document size_t).

The compiler, AFAIK (gcc is CCd, so they can jump in if I'm wrong), 
using uint32_t in every situation where __u32 is expected.  They're both 
typedefs for the same basic type.

I can understand why Linux will keep using u32 types (and their __ user 
space variants), but that doesn't mean user space programs need to use 
the same type.

If we have a standard syntax for fixed-width integral types (and for 
anything, actually), the manual pages should probably follow it, 
whenever possible.  Any deviation from the standard (be it C or POSIX) 
should have a very good reason to be;  otherwise, it only creates confusion.

Thanks,

Alex

-- 
Alejandro Colomar
Linux man-pages comaintainer; https://www.kernel.org/doc/man-pages/
Senior SW Engineer; http://www.alejandro-colomar.es/
