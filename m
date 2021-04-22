Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D437367E5A
	for <lists+bpf@lfdr.de>; Thu, 22 Apr 2021 12:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235814AbhDVKKg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Apr 2021 06:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235809AbhDVKKf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Apr 2021 06:10:35 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 942FBC06174A
        for <bpf@vger.kernel.org>; Thu, 22 Apr 2021 03:09:59 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id j12so27718909edy.3
        for <bpf@vger.kernel.org>; Thu, 22 Apr 2021 03:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Dgbz+WwzJEvzXU3bA4j3zNC1nXOTIF5Yz+eNRbOGEO4=;
        b=Qr8cI0eIu70UgXQbPY65cWFkB7yL3Y5CJlwViwiiearYgL4LKba3QYNfEUUxkOZfH6
         ghY7aKFw4aHNwNxYfIHqYgC4DqKZGglXyns1BAamkd6XDPqVFAacjSV0iciKi8+1ZORh
         YFB95EVwNZtZJObqKUYXxwlxAOYtDIjrAXMrI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Dgbz+WwzJEvzXU3bA4j3zNC1nXOTIF5Yz+eNRbOGEO4=;
        b=HK855rOunuMrfMbSoPsE3Wur8JCEhrHdGRN4hZaiurJcri58GQ65lPkH7mIVbjvFnP
         abDOUq6tktCj3XoBXAGlSBbGkw5FTqTdNWL8eVrmqF9VP4xcvCHJBKm4HKh7Il8FUvYS
         mG5stgs8uAPq7RRIChfQK4jO+MLZne4bgbZhBFRd7Ok353I7zsD8LjFB4E61GqWX2tsk
         bS+EoVA7dhw9n1tzK7mgnSy+xkRK9TxqWn0psxXEwtx78SXLcxAQlX03nIWl5ea49xua
         BU5i8L+VVJhC9FPvoAqDJVwOx3qUspOkGudK0x25fzqO109USR25ubk4RUtwFU1+RdJs
         h5vA==
X-Gm-Message-State: AOAM533SC22m//9vnfJY2IlfI8ke2oYuCkAKfrvDjI+pR7Qr1YV7+WlI
        Sal8JFMCDCMZKk86zCQPjgyNTQ==
X-Google-Smtp-Source: ABdhPJycnRFly2jYXEjrpKesJD8puLmkHSHDwWdyaZ8XyrIbsI0ZI8xYIg0dGaBTT8Vc9nailz3caA==
X-Received: by 2002:aa7:c9c9:: with SMTP id i9mr2847424edt.17.1619086198187;
        Thu, 22 Apr 2021 03:09:58 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id i2sm1569179ejv.99.2021.04.22.03.09.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Apr 2021 03:09:57 -0700 (PDT)
Subject: Re: [PATCH] bpf: remove pointless code from bpf_do_trace_printk()
To:     Florent Revest <revest@chromium.org>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alan Maguire <alan.maguire@oracle.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
References: <20210421190736.1538217-1-linux@rasmusvillemoes.dk>
 <CAEf4Bza6-Unvr7QmcbvVtNDPc4BNzf8zMaU4XardNqB_GnGDHw@mail.gmail.com>
 <236995f6-30ee-8047-624c-08d0a1552dc1@rasmusvillemoes.dk>
 <CABRcYmJFfdCU_QxX+gYRWc+7BSbmTWX84o_WT=oBg_CPr8qS=g@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <7e9d3337-eb7b-a2c8-a5ef-037d6a9765d7@rasmusvillemoes.dk>
Date:   Thu, 22 Apr 2021 12:09:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CABRcYmJFfdCU_QxX+gYRWc+7BSbmTWX84o_WT=oBg_CPr8qS=g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 22/04/2021 11.23, Florent Revest wrote:
> On Thu, Apr 22, 2021 at 9:13 AM Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:
>>
>> On 22/04/2021 05.32, Andrii Nakryiko wrote:
>>> On Wed, Apr 21, 2021 at 6:19 PM Rasmus Villemoes
>>> <linux@rasmusvillemoes.dk> wrote:
>>>>
>>>> The comment is wrong. snprintf(buf, 16, "") and snprintf(buf, 16,
>>>> "%s", "") etc. will certainly put '\0' in buf[0]. The only case where
>>>> snprintf() does not guarantee a nul-terminated string is when it is
>>>> given a buffer size of 0 (which of course prevents it from writing
>>>> anything at all to the buffer).
>>>>
>>>> Remove it before it gets cargo-culted elsewhere.
>>>>
>>>> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
>>>> ---
>>>>  kernel/trace/bpf_trace.c | 3 ---
>>>>  1 file changed, 3 deletions(-)
>>>>
>>>
>>> The change looks good to me, but please rebase it on top of the
>>> bpf-next tree. This is not a bug, so it doesn't have to go into the
>>> bpf tree. As it is right now, it doesn't apply cleanly onto bpf-next.
> 
> FWIW the idea of the patch also looks good to me :)
> 
>> Thanks for the pointer. Looking in next-20210420, it seems to me that
>>
>> commit d9c9e4db186ab4d81f84e6f22b225d333b9424e3
>> Author: Florent Revest <revest@chromium.org>
>> Date:   Mon Apr 19 17:52:38 2021 +0200
>>
>>     bpf: Factorize bpf_trace_printk and bpf_seq_printf
>>
>> is buggy. In particular, these two snippets:
>>
>> +#define BPF_CAST_FMT_ARG(arg_nb, args, mod)                            \
>> +       (mod[arg_nb] == BPF_PRINTF_LONG_LONG ||                         \
>> +        (mod[arg_nb] == BPF_PRINTF_LONG && __BITS_PER_LONG == 64)      \
>> +         ? (u64)args[arg_nb]                                           \
>> +         : (u32)args[arg_nb])
>>
>>
>> +       ret = snprintf(buf, sizeof(buf), fmt, BPF_CAST_FMT_ARG(0, args,
>> mod),
>> +               BPF_CAST_FMT_ARG(1, args, mod), BPF_CAST_FMT_ARG(2,
>> args, mod));
>>
>> Regardless of the casts done in that macro, the type of the resulting
>> expression is that resulting from C promotion rules. And (foo ? (u64)bla
>> : (u32)blib) has type u64, which is thus the type the compiler uses when
>> building the vararg list being passed into snprintf(). C simply doesn't
>> allow you to change types at run-time in this way.
>>
>> It probably works fine on x86-64, which passes the first six or so
>> argument in registers, va_start() puts those registers into the va_list
>> opaque structure, and when it comes time to do a va_arg(int), just the
>> lower 32 bits are used. It is broken on i386 and other architectures
>> where arguments are passed on the stack (and for x86-64 as well had
>> there been a few more arguments) and va_arg(ap, int) is essentially ({
>> int res = *(int *)ap; ap += 4; res; }) [or maybe it's -= 4 because stack
>> direction etc., that's not really relevant here].
>>
>> Rasmus
> 
> Thank you Rasmus :)


I think you were lucky (or unlucky, depending on how you look at it)
with your test case

+	num_ret  = BPF_SNPRINTF(num_out, sizeof(num_out),
+				"%d %u %x %li %llu %lX",
+				-8, 9, 150, -424242, 1337, 0xDABBAD00);

because it just so happens that the eventual snprintf() call uses three
arguments for itself, so the first three 32-bit arguments end up being
passed via registers, while the 64 bit arguments are passed via the
stack. Can I get you to test what would happen if you interchanged
these, i.e. changed the test case to do

+	num_ret  = BPF_SNPRINTF(num_out, sizeof(num_out),
+				"%li %llu %lX %d %u %x",
+				-424242, 1337, 0xDABBAD00, -8, 9, 150);

(or just add a few more expects-a-32-bit argument format specifiers and
corresponding arguments). My guess is that up until formatting -8 it
goes well, but when vsnprintf() is to grab the argument corresponding to
%u, it will get the 0xffffffff from the upper half of (u64)-8.

> It seems that we went offtrack in
> https://lore.kernel.org/bpf/CAEf4BzZVEGM4esi-Rz67_xX_RTDrgxViy0gHfpeauECR5bmRNA@mail.gmail.com/
> and we do need something like "88a5c690b6 bpf: fix bpf_trace_printk on
> 32 bit archs". Thinking about it again, it's clearer now why the
> __BPF_TP_EMIT macro emits 2^3=8 different __trace_printk() indeed.

Isn't it 3^3 = 27, or has that been reduced in -next compared to Linus'
master? Doesn't matter much, just curious.

> In the case of bpf_trace_printk with a maximum of 3 args, it's
> relatively cheap; but for bpf_seq_printf and bpf_snprintf which accept
> up to 12 arguments, that would be 2^12=4096 calls.

Yeah, that doesn't scale at all.

 Until now
> bpf_seq_printf has just ignored this problem and just considered
> everything as u64, I wonder if that'd be the best approach for these
> two helpers anyway.
> 

[wild handwaving ahead]

One possibility, if one is willing to get hands dirty and dig into ABI
details on various arches, is to create a

  struct fake_va_list {
    union {
      va_list      ap; /* opaque, compiler-provided */
      arch_va_list _ap; /* arch-provided, must match layout of ap */
    };
    void *stack;
  };

Then do

  struct fake_va_list fva;
  u64 buf[24]; /* or whatever you want to support, can be different in
different functions */

  fake_va_init(&fva, buf);
  /* various C code, parsing format string etc. */
  if (arg[i] is really 32 bits)
    fake_va_push(&fva, (u32)arg[i]);
  else
    fake_va_push(&fva, (u64)arg[i]);
  /* etc. */
  ...
  vsnprintf(out, size, fmt, fva.va);

On arches like x86-64, where va_list is really a typedef for a
one-element array of

struct __va_list_tag {
        unsigned int               gp_offset;
        unsigned int               fp_offset;
        void *                     overflow_arg_area;
        void *                     reg_save_area;
};


fake_va_init() would make the va_list look like the reg_save_area is
already used (i.e., set gp_offset to 48), and initialize both
->_ap.overflow_arg_area and ->stack to point at the given buffer.
fake_va_push() would use and update stack appropriately. For 32 bit x86,
va_list is really just a pointer, so fake_va_init would essentially just
do "fva->_ap = fva->stack = buf", and fake_va_push() would again just
need to manipulate ->stack.

It's not pretty, but I don't think it necessarily requires too much
arch-specific work (fake_va_push() could be common, perhaps just with a
arch define to say whether 64 bit arguments need ->stack to first be
up-aligned to an 8 byte boundary).

Rasmus
