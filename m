Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6DB367AB5
	for <lists+bpf@lfdr.de>; Thu, 22 Apr 2021 09:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbhDVHNi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Apr 2021 03:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbhDVHNh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Apr 2021 03:13:37 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38610C06174A
        for <bpf@vger.kernel.org>; Thu, 22 Apr 2021 00:13:03 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id w3so67243224ejc.4
        for <bpf@vger.kernel.org>; Thu, 22 Apr 2021 00:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Vdeyx2EiZ4VVtfgSkJvRIr5ICOqaF5aOZ8liQEySarM=;
        b=YPV3CqMEfMbRawW5v7Mh0/kDQEEeiRidIc6BFfEJ7Cy2RPnOBKpjJ3meCyg3B3dj7Y
         T23HcXybLv+3EUDMj25ODMxPRP8kuUreNtyZ4Ci8dIhpAMxALrSBE8jJrGWzTXmhxYZb
         Ua7sq7Z+p4ds57CAyxWZL0TtBlqKP20dnp5kg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Vdeyx2EiZ4VVtfgSkJvRIr5ICOqaF5aOZ8liQEySarM=;
        b=ikmF9atv1xrmdTwjqw8qoDVMtHuofwOfyPFnJPHJNaSX7RDFJKiwEp0b2Hd5Dl6fXl
         MGmXJgDJnSFXykanstjJw7x1NwMJbhP3YsHEh6vk8DUnwMMEZg6l4eiyJjRMV2DYLrPo
         3oJaV5UoCYbnm38FJdNWHAI2tmyM9CRj2OeYPyIEU3649doLdXu3a48Fmglgmbp8aelj
         l+y8sRVlKU2Yi6+TWEkymw5/kE6YfsCUJGEF8LW7gRnI8CewuuChEurOEoMISUTq/nHB
         qcm2FyaYLJcOVQY+VGbOUqqah7TAXGHFxCC0ixmvx1M5uTt4Ht3Ssu6qeZFOeYJTwg9q
         okrA==
X-Gm-Message-State: AOAM530CVUzdsGA/d4q9BgAcZwUJUd0NmBl+bogIIhoARQijuUS6YW90
        qd9bWWojdrzve0lffbGjM89sXw==
X-Google-Smtp-Source: ABdhPJzmo155Rt45+yFK2rxmK+jof0hG9KwOE3VJP8U8oPglLPeWzFmQpm5PJGsvjv1Y0WrrLAtA/g==
X-Received: by 2002:a17:906:9990:: with SMTP id af16mr1776543ejc.195.1619075581971;
        Thu, 22 Apr 2021 00:13:01 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id ca1sm1248712edb.76.2021.04.22.00.13.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Apr 2021 00:13:01 -0700 (PDT)
Subject: Re: [PATCH] bpf: remove pointless code from bpf_do_trace_printk()
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alan Maguire <alan.maguire@oracle.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Florent Revest <revest@chromium.org>,
        Alexei Starovoitov <ast@kernel.org>
References: <20210421190736.1538217-1-linux@rasmusvillemoes.dk>
 <CAEf4Bza6-Unvr7QmcbvVtNDPc4BNzf8zMaU4XardNqB_GnGDHw@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <236995f6-30ee-8047-624c-08d0a1552dc1@rasmusvillemoes.dk>
Date:   Thu, 22 Apr 2021 09:13:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAEf4Bza6-Unvr7QmcbvVtNDPc4BNzf8zMaU4XardNqB_GnGDHw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 22/04/2021 05.32, Andrii Nakryiko wrote:
> On Wed, Apr 21, 2021 at 6:19 PM Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:
>>
>> The comment is wrong. snprintf(buf, 16, "") and snprintf(buf, 16,
>> "%s", "") etc. will certainly put '\0' in buf[0]. The only case where
>> snprintf() does not guarantee a nul-terminated string is when it is
>> given a buffer size of 0 (which of course prevents it from writing
>> anything at all to the buffer).
>>
>> Remove it before it gets cargo-culted elsewhere.
>>
>> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
>> ---
>>  kernel/trace/bpf_trace.c | 3 ---
>>  1 file changed, 3 deletions(-)
>>
> 
> The change looks good to me, but please rebase it on top of the
> bpf-next tree. This is not a bug, so it doesn't have to go into the
> bpf tree. As it is right now, it doesn't apply cleanly onto bpf-next.

Thanks for the pointer. Looking in next-20210420, it seems to me that

commit d9c9e4db186ab4d81f84e6f22b225d333b9424e3
Author: Florent Revest <revest@chromium.org>
Date:   Mon Apr 19 17:52:38 2021 +0200

    bpf: Factorize bpf_trace_printk and bpf_seq_printf

is buggy. In particular, these two snippets:

+#define BPF_CAST_FMT_ARG(arg_nb, args, mod)                            \
+       (mod[arg_nb] == BPF_PRINTF_LONG_LONG ||                         \
+        (mod[arg_nb] == BPF_PRINTF_LONG && __BITS_PER_LONG == 64)      \
+         ? (u64)args[arg_nb]                                           \
+         : (u32)args[arg_nb])


+       ret = snprintf(buf, sizeof(buf), fmt, BPF_CAST_FMT_ARG(0, args,
mod),
+               BPF_CAST_FMT_ARG(1, args, mod), BPF_CAST_FMT_ARG(2,
args, mod));

Regardless of the casts done in that macro, the type of the resulting
expression is that resulting from C promotion rules. And (foo ? (u64)bla
: (u32)blib) has type u64, which is thus the type the compiler uses when
building the vararg list being passed into snprintf(). C simply doesn't
allow you to change types at run-time in this way.

It probably works fine on x86-64, which passes the first six or so
argument in registers, va_start() puts those registers into the va_list
opaque structure, and when it comes time to do a va_arg(int), just the
lower 32 bits are used. It is broken on i386 and other architectures
where arguments are passed on the stack (and for x86-64 as well had
there been a few more arguments) and va_arg(ap, int) is essentially ({
int res = *(int *)ap; ap += 4; res; }) [or maybe it's -= 4 because stack
direction etc., that's not really relevant here].

Rasmus
