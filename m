Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0700067D50F
	for <lists+bpf@lfdr.de>; Thu, 26 Jan 2023 20:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232089AbjAZTHE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Jan 2023 14:07:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbjAZTHD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 Jan 2023 14:07:03 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B4B268127
        for <bpf@vger.kernel.org>; Thu, 26 Jan 2023 11:06:58 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id y11so2780642edd.6
        for <bpf@vger.kernel.org>; Thu, 26 Jan 2023 11:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iZElPXdMYwPZ4E7gzFtx/or71zbeqUWt2WDfoqyW/JE=;
        b=Ka0H3/9+y/0781CTVSDEZd3g1JacTR4Vc6CYqe2z81ARq0cusz1yuwa8f/e/eJXtU+
         UUSmgb1gz4e7CV2x/nteBZwsQnWy7Dd+YtwoQyIHfSdfFK10A9Ry9BC2YcZd07bqJRb+
         xd45/8OKRahJJQNCBc+m3gAiDik4oncgP2KIziB3aTMQJPlUskIVTLRWqwRuOOeq0L/v
         zJ3LRek/lYVyyV6IGKxKjVHYm24rI4qBxGIhdneZPJzyHJW0Srr5r7Zf2OMlbILscy/z
         bDtQZSg/9Q/dlnSPM6I/1I9Dvj1w/ojMPPvomZq7FLeAxeBigYiG8IJuT6eFZgEazKCc
         8x3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iZElPXdMYwPZ4E7gzFtx/or71zbeqUWt2WDfoqyW/JE=;
        b=BSF2c0UbBCbYsmL1eagwlfs8ue8aEZ5/aSPhQ0grqE9jIE4chMqSu9FvRWGenmE9bG
         MTceGKDYMHmUqzywTt5UJLg3CNjKOXOLhNv8+/OxZn50elOfr8SE2+zQ3psAMBVQefaP
         U9OVyTIyJB//PkicKYjAHgj+gTs5HR+sdNCHuFZVGdtlt/hFQM/u62W5tK6klpb2Qtk/
         oa5pi9X+GFnYFM9FH07DpeJGzDa1EUaLg1QMn6OEsv/sX3osfSxH/mfoZrKLfn63RJZy
         sLoSuCFujFUGVt9+9SN9UlIJc7tzYnLu3NXC+z61u2cYaL43CWamw1GOSML4vjh6VDGq
         EgtQ==
X-Gm-Message-State: AO0yUKW4Hk8PH2hp4YXzmJpzPMwTTaP7c7+3wjaKhPZdprAbPo+ttQD9
        F6mILmTyC+u63cvcLGVQn9Y5kQ+HLVB3CYgW3Gfnfg8q
X-Google-Smtp-Source: AK7set+VHYZLeLrGDaQKGmWAlLg3S5Pb7hyPf7QrTFg+bU6WMKhfTPl3nS9jn/BVz1Cf63IDmCMc/LV4YGl0yWHMWv4=
X-Received: by 2002:a05:6402:510d:b0:4a0:cfed:1a47 with SMTP id
 m13-20020a056402510d00b004a0cfed1a47mr1187466edd.18.1674760016892; Thu, 26
 Jan 2023 11:06:56 -0800 (PST)
MIME-Version: 1.0
References: <20230125213817.1424447-1-iii@linux.ibm.com> <20230125213817.1424447-23-iii@linux.ibm.com>
 <CAEf4BzbaNhFw77bECCxf7cKenBTTe6YvMHbm+XiMQbqgukyW8Q@mail.gmail.com> <56b6677c73903638b88f331d6e074c595bd489b9.camel@linux.ibm.com>
In-Reply-To: <56b6677c73903638b88f331d6e074c595bd489b9.camel@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 26 Jan 2023 11:06:45 -0800
Message-ID: <CAEf4BzZO637m4vXNJ3MNb9R+diuJyx4Ck-zbYof5YHPOrApDYA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 22/24] s390/bpf: Implement arch_prepare_bpf_trampoline()
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 26, 2023 at 6:30 AM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> On Wed, 2023-01-25 at 17:15 -0800, Andrii Nakryiko wrote:
> > On Wed, Jan 25, 2023 at 1:39 PM Ilya Leoshkevich <iii@linux.ibm.com>
> > wrote:
> > >
> > > arch_prepare_bpf_trampoline() is used for direct attachment of eBPF
> > > programs to various places, bypassing kprobes. It's responsible for
> > > calling a number of eBPF programs before, instead and/or after
> > > whatever they are attached to.
> > >
> > > Add a s390x implementation, paying attention to the following:
> > >
> > > - Reuse the existing JIT infrastructure, where possible.
> > > - Like the existing JIT, prefer making multiple passes instead of
> > >   backpatching. Currently 2 passes is enough. If literal pool is
> > >   introduced, this needs to be raised to 3. However, at the moment
> > >   adding literal pool only makes the code larger. If branch
> > >   shortening is introduced, the number of passes needs to be
> > >   increased even further.
> > > - Support both regular and ftrace calling conventions, depending on
> > >   the trampoline flags.
> > > - Use expolines for indirect calls.
> > > - Handle the mismatch between the eBPF and the s390x ABIs.
> > > - Sign-extend fmod_ret return values.
> > >
> > > invoke_bpf_prog() produces about 120 bytes; it might be possible to
> > > slightly optimize this, but reaching 50 bytes, like on x86_64,
> > > looks
> > > unrealistic: just loading cookie, __bpf_prog_enter, bpf_func,
> > > insnsi
> > > and __bpf_prog_exit as literals already takes at least 5 * 12 = 60
> > > bytes, and we can't use relative addressing for most of them.
> > > Therefore, lower BPF_MAX_TRAMP_LINKS on s390x.
> > >
> > > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > > ---
> > >  arch/s390/net/bpf_jit_comp.c | 535
> > > +++++++++++++++++++++++++++++++++--
> > >  include/linux/bpf.h          |   4 +
> > >  2 files changed, 517 insertions(+), 22 deletions(-)
> > >
> >
> > [...]
> >
> > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > index cf89504c8dda..52ff43bbf996 100644
> > > --- a/include/linux/bpf.h
> > > +++ b/include/linux/bpf.h
> > > @@ -943,7 +943,11 @@ struct btf_func_model {
> > >  /* Each call __bpf_prog_enter + call bpf_func + call
> > > __bpf_prog_exit is ~50
> > >   * bytes on x86.
> > >   */
> > > +#if defined(__s390x__)
> > > +#define BPF_MAX_TRAMP_LINKS 27
> > > +#else
> > >  #define BPF_MAX_TRAMP_LINKS 38
> > > +#endif
> >
> > if we turn this into enum definition, then on selftests side we can
> > just discover this from vmlinux BTF, instead of hard-coding
> > arch-specific constants. Thoughts?
>
> This seems to work. I can replace 3/24 and 4/24 with that in v2.
> Some random notes:
>
> - It doesn't seem to be possible to #include "vlinux.h" into tests,
>   so one has to go through the btf__load_vmlinux_btf() dance and
>   allocate the fd arrays dynamically.

yes, you can't include vmlinux.h into user-space code, of course. And
yes it's true about needing to use btf__load_vmlinux_btf().

But I didn't get what you are saying about fd arrays, tbh. Can you
please elaborate?

>
> - One has to give this enum an otherwise unnecessary name, so that
>   it's easy to find. This doesn't seem like a big deal though:
>
> enum bpf_max_tramp_links {

not really, you can keep it anonymous enum. We do that in
include/uapi/linux/bpf.h for a lot of constants

> #if defined(__s390x__)
>         BPF_MAX_TRAMP_LINKS = 27,
> #else
>         BPF_MAX_TRAMP_LINKS = 38,
> #endif
> };
>
> - An alternative might be to expose this via /proc, since the users
>   might be interested in it too.

I'd say let's not, there is no need, having it in BTF is more than
enough for testing purposes

>
> > >
> > >  struct bpf_tramp_links {
> > >         struct bpf_tramp_link *links[BPF_MAX_TRAMP_LINKS];
> > > --
> > > 2.39.1
> > >
>
