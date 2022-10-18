Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2096033BE
	for <lists+bpf@lfdr.de>; Tue, 18 Oct 2022 22:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbiJRUH7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Oct 2022 16:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiJRUH7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Oct 2022 16:07:59 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6825FF54
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 13:07:57 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id o65so12747516iof.4
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 13:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JpelpJ2RUBl2/Qi1M4Vh9Y2HxJjWm0G/aDT41HqmUC0=;
        b=Nhb4jvAWqE76yCRqMYzFtE7u5krQ1EroS4E6lrrT5u9AWGE1JixNm1tenfB6JXiGP0
         Z3aButljmymrLRAPcXFV2zQJjsCsBLXfDR1PznRboJ3pXOj0nKgeTf3uVX3KOi66PLMt
         Ps8TTVhWJdaYlt2Z0n7ktlGnWdIUF0XvgDWLokz0841zcoaq+wn1SSzkiP7u5BFqFAte
         ezhLManXjpuz/yEKHH5ygbCFQ+qv9oG6Mg80+cIEOtrPVkK//9KaLntuYc4VcS60qkTI
         KTUsBzqSUAq6nkWAMmumpuR+kWHT0mieYgAgxHzICkxW5WKbPxnKMD+KykfgFgd7dlCv
         ch+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JpelpJ2RUBl2/Qi1M4Vh9Y2HxJjWm0G/aDT41HqmUC0=;
        b=fKmiMk/zmC3xzsQg71uGrSwOa3dMHiBzAZy0lxorJc1/EXW2wFSeXhq3J0SCcx1Qwq
         1Mvz/v3v3eNdAOiVEdwQ5Y4Tns9tFF7VQIz4sHs+oWQQ0NMbvRXuMutHI1yaGI2P1IaW
         N39Zu+yu1BhIl4pNioA3ost9IEMAiPgMqgzUbTxVKcu+W1t8/Sn09YCXx3lK+bBW+um3
         TJY31TF9vUK9NLopHJWvkHbEXPvRuXAw1vXnAc3wTO5MDj5u7jQ/IsoqxovNAkWudd93
         49Uf6cEgn4Nl+81Q0Q1OkGT7JuZ3c0XMTPeCV4UAj5I5g0djYMCqy1iziVxoFH3Lvy1t
         gcwQ==
X-Gm-Message-State: ACrzQf37xP5O5t+0bx/xrA0f+y/mKdlaYL5J6BdoQwWPCRdKDE2CHZG8
        f1bR+QCpSt61784pe4x9MjF67CYiBdLyYn6eAyYZMw==
X-Google-Smtp-Source: AMsMyM7f5t5YB3dzGMSGQALGtHyDA7exsywYWD85nS9KuB0Cdebt7cScXuaC1piSYHkZNDhpdVaamLIMiiX1zNZP0r4=
X-Received: by 2002:a05:6638:1455:b0:363:d1a9:5cc0 with SMTP id
 l21-20020a056638145500b00363d1a95cc0mr3123218jad.288.1666123676863; Tue, 18
 Oct 2022 13:07:56 -0700 (PDT)
MIME-Version: 1.0
References: <20221018090550.never.834-kees@kernel.org> <Y07raim32wOBRGPi@google.com>
 <202210181110.CD92A00@keescook>
In-Reply-To: <202210181110.CD92A00@keescook>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Tue, 18 Oct 2022 13:07:45 -0700
Message-ID: <CAKH8qBvwKfhMYjHV=rizA0ZinArHKmBP6U_N63HTcZTmM=QQ+g@mail.gmail.com>
Subject: Re: [PATCH] bpf: Use kmalloc_size_roundup() to match ksize() usage
To:     Kees Cook <keescook@chromium.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 18, 2022 at 11:19 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Tue, Oct 18, 2022 at 11:07:38AM -0700, sdf@google.com wrote:
> > On 10/18, Kees Cook wrote:
> > > Round up allocations with kmalloc_size_roundup() so that the verifier's
> > > use of ksize() is always accurate and no special handling of the memory
> > > is needed by KASAN, UBSAN_BOUNDS, nor FORTIFY_SOURCE. Pass the new size
> > > information back up to callers so they can use the space immediately,
> > > so array resizing to happen less frequently as well. Explicitly zero
> > > any trailing bytes in new allocations.
> >
> > > Additionally fix a memory allocation leak: if krealloc() fails, "arr"
> > > wasn't freed, but NULL was return to the caller of realloc_array() would
> > > be writing NULL to the lvalue, losing the reference to the original
> > > memory.
> >
> > > Cc: Alexei Starovoitov <ast@kernel.org>
> > > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > > Cc: John Fastabend <john.fastabend@gmail.com>
> > > Cc: Andrii Nakryiko <andrii@kernel.org>
> > > Cc: Martin KaFai Lau <martin.lau@linux.dev>
> > > Cc: Song Liu <song@kernel.org>
> > > Cc: Yonghong Song <yhs@fb.com>
> > > Cc: KP Singh <kpsingh@kernel.org>
> > > Cc: Stanislav Fomichev <sdf@google.com>
> > > Cc: Hao Luo <haoluo@google.com>
> > > Cc: Jiri Olsa <jolsa@kernel.org>
> > > Cc: bpf@vger.kernel.org
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > ---
> > >   kernel/bpf/verifier.c | 49 +++++++++++++++++++++++++++----------------
> > >   1 file changed, 31 insertions(+), 18 deletions(-)
> >
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index 014ee0953dbd..8a0b60207d0e 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -1000,42 +1000,53 @@ static void print_insn_state(struct
> > > bpf_verifier_env *env,
> > >    */
> > >   static void *copy_array(void *dst, const void *src, size_t n, size_t
> > > size, gfp_t flags)
> > >   {
> > > -   size_t bytes;
> > > +   size_t src_bytes, dst_bytes;
> >
> > >     if (ZERO_OR_NULL_PTR(src))
> > >             goto out;
> >
> > > -   if (unlikely(check_mul_overflow(n, size, &bytes)))
> > > +   if (unlikely(check_mul_overflow(n, size, &src_bytes)))
> > >             return NULL;
> >
> > > -   if (ksize(dst) < bytes) {
> > > +   dst_bytes = kmalloc_size_roundup(src_bytes);
> > > +   if (ksize(dst) < dst_bytes) {
> >
> > Why not simply do the following here?
> >
> >       if (ksize(dst) < ksize(src)) {
> >
> > ?
>
> Yeah, if src always passes through rounding-up allocation path, that
> might work. I need to double-check that there isn't a case where "size"
> makes this go weird -- e.g. a rounded up "src" may be larger than
> "n * size", but I think that's okay because the memcpy/memset does the
> right thing.
>
> > It seems like we care about src_bytes/bytes only in this case, so maybe
> > move that check_mul_overflow under this branch as well?
> >
> >
> > >             kfree(dst);
> > > -           dst = kmalloc_track_caller(bytes, flags);
> > > +           dst = kmalloc_track_caller(dst_bytes, flags);
> > >             if (!dst)
> > >                     return NULL;
> > >     }
> >
> > > -   memcpy(dst, src, bytes);
> > > +   memcpy(dst, src, src_bytes);
> > > +   memset(dst + src_bytes, 0, dst_bytes - src_bytes);
> > >   out:
> > >     return dst ? dst : ZERO_SIZE_PTR;
> > >   }
> >
> > > -/* resize an array from old_n items to new_n items. the array is
> > > reallocated if it's too
> > > - * small to hold new_n items. new items are zeroed out if the array
> > > grows.
> > > +/* Resize an array from old_n items to *new_n items. The array is
> > > reallocated if it's too
> > > + * small to hold *new_n items. New items are zeroed out if the array
> > > grows. Allocation
> > > + * is rounded up to next kmalloc bucket size to reduce frequency of
> > > resizing. *new_n
> > > + * contains the new total number of items that will fit.
> > >    *
> > > - * Contrary to krealloc_array, does not free arr if new_n is zero.
> > > + * Contrary to krealloc, does not free arr if new_n is zero.
> > >    */
> > > -static void *realloc_array(void *arr, size_t old_n, size_t new_n,
> > > size_t size)
> > > +static void *realloc_array(void *arr, size_t old_n, size_t *new_n,
> > > size_t size)
> > >   {
> > > -   if (!new_n || old_n == new_n)
> > > +   void *old_arr = arr;
> > > +   size_t alloc_size;
> > > +
> > > +   if (!new_n || !*new_n || old_n == *new_n)
> > >             goto out;
> >
> >
> > [..]
> >
> > > -   arr = krealloc_array(arr, new_n, size, GFP_KERNEL);
> > > -   if (!arr)
> > > +   alloc_size = kmalloc_size_roundup(size_mul(*new_n, size));
> > > +   arr = krealloc(old_arr, alloc_size, GFP_KERNEL);
> > > +   if (!arr) {
> > > +           kfree(old_arr);
> > >             return NULL;
> > > +   }
> >
> > Any reason not do hide this complexity behind krealloc_array? Why can't
> > it take care of those roundup details?
>
> It might be possible to do this with a macro, yes, but then callers
> aren't in a position to take advantage of the new size. Maybe we need
> something like:
>
>         arr = krealloc_up(old_arr, alloc_size, &new_size, GFP_KERNEL);

Maybe even krealloc_array_up(arr, &new_n, size, flags) or similar
where we return a new size?
Though I don't know if there are any other places in the kernel to
reuse it and warrant a new function..

> Thanks for looking this over!
>
> --
> Kees Cook

On Tue, Oct 18, 2022 at 11:19 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Tue, Oct 18, 2022 at 11:07:38AM -0700, sdf@google.com wrote:
> > On 10/18, Kees Cook wrote:
> > > Round up allocations with kmalloc_size_roundup() so that the verifier's
> > > use of ksize() is always accurate and no special handling of the memory
> > > is needed by KASAN, UBSAN_BOUNDS, nor FORTIFY_SOURCE. Pass the new size
> > > information back up to callers so they can use the space immediately,
> > > so array resizing to happen less frequently as well. Explicitly zero
> > > any trailing bytes in new allocations.
> >
> > > Additionally fix a memory allocation leak: if krealloc() fails, "arr"
> > > wasn't freed, but NULL was return to the caller of realloc_array() would
> > > be writing NULL to the lvalue, losing the reference to the original
> > > memory.
> >
> > > Cc: Alexei Starovoitov <ast@kernel.org>
> > > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > > Cc: John Fastabend <john.fastabend@gmail.com>
> > > Cc: Andrii Nakryiko <andrii@kernel.org>
> > > Cc: Martin KaFai Lau <martin.lau@linux.dev>
> > > Cc: Song Liu <song@kernel.org>
> > > Cc: Yonghong Song <yhs@fb.com>
> > > Cc: KP Singh <kpsingh@kernel.org>
> > > Cc: Stanislav Fomichev <sdf@google.com>
> > > Cc: Hao Luo <haoluo@google.com>
> > > Cc: Jiri Olsa <jolsa@kernel.org>
> > > Cc: bpf@vger.kernel.org
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > ---
> > >   kernel/bpf/verifier.c | 49 +++++++++++++++++++++++++++----------------
> > >   1 file changed, 31 insertions(+), 18 deletions(-)
> >
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index 014ee0953dbd..8a0b60207d0e 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -1000,42 +1000,53 @@ static void print_insn_state(struct
> > > bpf_verifier_env *env,
> > >    */
> > >   static void *copy_array(void *dst, const void *src, size_t n, size_t
> > > size, gfp_t flags)
> > >   {
> > > -   size_t bytes;
> > > +   size_t src_bytes, dst_bytes;
> >
> > >     if (ZERO_OR_NULL_PTR(src))
> > >             goto out;
> >
> > > -   if (unlikely(check_mul_overflow(n, size, &bytes)))
> > > +   if (unlikely(check_mul_overflow(n, size, &src_bytes)))
> > >             return NULL;
> >
> > > -   if (ksize(dst) < bytes) {
> > > +   dst_bytes = kmalloc_size_roundup(src_bytes);
> > > +   if (ksize(dst) < dst_bytes) {
> >
> > Why not simply do the following here?
> >
> >       if (ksize(dst) < ksize(src)) {
> >
> > ?
>
> Yeah, if src always passes through rounding-up allocation path, that
> might work. I need to double-check that there isn't a case where "size"
> makes this go weird -- e.g. a rounded up "src" may be larger than
> "n * size", but I think that's okay because the memcpy/memset does the
> right thing.
>
> > It seems like we care about src_bytes/bytes only in this case, so maybe
> > move that check_mul_overflow under this branch as well?
> >
> >
> > >             kfree(dst);
> > > -           dst = kmalloc_track_caller(bytes, flags);
> > > +           dst = kmalloc_track_caller(dst_bytes, flags);
> > >             if (!dst)
> > >                     return NULL;
> > >     }
> >
> > > -   memcpy(dst, src, bytes);
> > > +   memcpy(dst, src, src_bytes);
> > > +   memset(dst + src_bytes, 0, dst_bytes - src_bytes);
> > >   out:
> > >     return dst ? dst : ZERO_SIZE_PTR;
> > >   }
> >
> > > -/* resize an array from old_n items to new_n items. the array is
> > > reallocated if it's too
> > > - * small to hold new_n items. new items are zeroed out if the array
> > > grows.
> > > +/* Resize an array from old_n items to *new_n items. The array is
> > > reallocated if it's too
> > > + * small to hold *new_n items. New items are zeroed out if the array
> > > grows. Allocation
> > > + * is rounded up to next kmalloc bucket size to reduce frequency of
> > > resizing. *new_n
> > > + * contains the new total number of items that will fit.
> > >    *
> > > - * Contrary to krealloc_array, does not free arr if new_n is zero.
> > > + * Contrary to krealloc, does not free arr if new_n is zero.
> > >    */
> > > -static void *realloc_array(void *arr, size_t old_n, size_t new_n,
> > > size_t size)
> > > +static void *realloc_array(void *arr, size_t old_n, size_t *new_n,
> > > size_t size)
> > >   {
> > > -   if (!new_n || old_n == new_n)
> > > +   void *old_arr = arr;
> > > +   size_t alloc_size;
> > > +
> > > +   if (!new_n || !*new_n || old_n == *new_n)
> > >             goto out;
> >
> >
> > [..]
> >
> > > -   arr = krealloc_array(arr, new_n, size, GFP_KERNEL);
> > > -   if (!arr)
> > > +   alloc_size = kmalloc_size_roundup(size_mul(*new_n, size));
> > > +   arr = krealloc(old_arr, alloc_size, GFP_KERNEL);
> > > +   if (!arr) {
> > > +           kfree(old_arr);
> > >             return NULL;
> > > +   }
> >
> > Any reason not do hide this complexity behind krealloc_array? Why can't
> > it take care of those roundup details?
>
> It might be possible to do this with a macro, yes, but then callers
> aren't in a position to take advantage of the new size. Maybe we need
> something like:
>
>         arr = krealloc_up(old_arr, alloc_size, &new_size, GFP_KERNEL);
>
> Thanks for looking this over!
>
> --
> Kees Cook
