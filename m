Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A85F84FCC47
	for <lists+bpf@lfdr.de>; Tue, 12 Apr 2022 04:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbiDLCPI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Apr 2022 22:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbiDLCPH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Apr 2022 22:15:07 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7160713D73
        for <bpf@vger.kernel.org>; Mon, 11 Apr 2022 19:12:51 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id x9so12704624ilc.3
        for <bpf@vger.kernel.org>; Mon, 11 Apr 2022 19:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gZTQfU0Ho+7OGMfFl2zQkHzv3Y/9k8PuAKpyaB84tJw=;
        b=Z+tTG3SXO0IV6k4DCx/Agdkv4bfF4jLi4QOD9FppcOQxBtDzV8A8lcR/sh4FnOkv+T
         hJ1D/ETgCNSxTb0DiagIg0IO6ye6/xchvSf7vI4P+ayIjrB++ygrjgFK/ZvrsPNylsWw
         LwNeaLH+o01VgrwcxFA/K1yWfM/qP5V6DpbeZj6l44M7qgl+TWsltQF6KPn+ziLpr/7E
         uIdYZoodkTM0JGVFT2Y8e2UDcAZuBcjmru6qk/IFNKqzf22wlyJldEtHW3eiGdPFFsA3
         OlTVzyveUdQkORxAyE/Ftd6rqszDnjgIQlbBkxChVd4eXxBzRZ+8x7y114Eut6I3s7m4
         IEgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gZTQfU0Ho+7OGMfFl2zQkHzv3Y/9k8PuAKpyaB84tJw=;
        b=8F4hPsh2aVh35NGqn9usDRh+IpzZGGBeb76VIbgqbOXkuyKEKaXuvz2BDir7aOE677
         uWO9EzKxcQbr5i/aKmOzhPSqT6oDeaUihtvHnPpxDOnkJ8JTpYIlAoaAKZ8xx9PTOyxQ
         ioIJa+KCwpVpymQPTFDPfy5756atbOl1vrlVjFUmXu3xjDj7f3Pga1od2yW9ePctdDXs
         b9pb/TqFRwdPWHMq6eSGxvu1d20PAwgC7we5mZ79yrmKFj8R9rd4sd47yDrMZ9h+cNq0
         D44Obsv9PwKn40K/c+mDYhbLB1HrCy/b8WoNfIhMSwC1zHP1M20Mt3ClYP2niVHj4FvF
         +Zuw==
X-Gm-Message-State: AOAM533io7YOw4WdiqilC7lB7/Du7DEGn8crdG7+Rn4+0FocuqQ1X2Ey
        zGVJfrDIGgB4bsoaA/hGx7c1ZHvwpBjn6dn6GUV77n3+
X-Google-Smtp-Source: ABdhPJygtsdsiXpEOBFbo4S7JKPvKs8ykHIft7wbiqhqDsZthtHaY7anAXxIFRQK7yaTrWv8IHjI+lr/WC2W82Y9K9I=
X-Received: by 2002:a05:6e02:1562:b0:2ca:50f1:72f3 with SMTP id
 k2-20020a056e02156200b002ca50f172f3mr14829409ilu.71.1649729570823; Mon, 11
 Apr 2022 19:12:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220402015826.3941317-1-joannekoong@fb.com> <20220402015826.3941317-4-joannekoong@fb.com>
 <CAEf4BzbRsA+JTP+4mqWpjRd_KEtaaM74ihz7RKGgpu_outhxTg@mail.gmail.com>
 <CAJnrk1Y8nE7n6PY9f7KBHH-P_ji3vAnuH5UP0r1fAk4OUTUZtQ@mail.gmail.com>
 <CAEf4Bzbp=91iYC5Ggm2W6gd3m_=wYXUXrZ7XLnGU5i=STcVAWA@mail.gmail.com>
 <CAJnrk1bxi9Ax0RBCGEz61tH0v2DCZwy=R132R4BS5737-WMN9Q@mail.gmail.com> <20220409011158.dwkolvp4nyjl5kvr@MBP-98dd607d3435.dhcp.thefacebook.com>
In-Reply-To: <20220409011158.dwkolvp4nyjl5kvr@MBP-98dd607d3435.dhcp.thefacebook.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 11 Apr 2022 19:12:39 -0700
Message-ID: <CAEf4BzaFiCgy9wuQE-KpEX8oQrYJWWowNoq02rUe4uooUgSTLQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 3/7] bpf: Add bpf_dynptr_from_mem, bpf_malloc, bpf_free
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Joanne Koong <joannelkoong@gmail.com>,
        Joanne Koong <joannekoong@fb.com>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 8, 2022 at 6:12 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Apr 08, 2022 at 04:37:02PM -0700, Joanne Koong wrote:
> > > > > > + *
> > > > > > + * void bpf_free(struct bpf_dynptr *ptr)
> > > > >
> > > > > thinking about the next patch set that will add storing this malloc
> > > > > dynptr into the map, bpf_free() will be a lie, right? As it will only
> > > > > decrement a refcnt, not necessarily free it, right? So maybe just
> > > > > generic bpf_dynptr_put() or bpf_malloc_put() or something like that is
> > > > > a bit more "truthful"?
> > > > I like the simplicity of bpf_free(), but I can see how that might be
> > > > confusing. What are your thoughts on "bpf_dynptr_free()"? Since when
> > > > we get into dynptrs that are stored in maps vs. dynptrs stored
> > > > locally, calling bpf_dynptr_free() frees (invalidates) your local
> > > > dynptr even if it doesn't free the underlying memory if it still has
> > > > valid refcounts on it? To me, "malloc" and "_free" go more intuitively
> > > > together as a pair.
> > >
> > > Sounds good to me (though let's use _dynptr() as a suffix
> > > consistently). I also just realized that maybe we should call
> > > bpf_malloc() a bpf_malloc_dynptr() instead. I can see how we might
> > > want to enable plain bpf_malloc() with statically known size (similar
> > > to statically known bpf_ringbuf_reserve()) for temporary local malloc
> > > with direct memory access? So bpf_malloc_dynptr() would be a
> > > dynptr-enabled counterpart to fixed-sized bpf_malloc()? And then
> > > bpf_free() will work with direct pointer returned from bpf_malloc(),
> > > while bpf_free_dynptr() will work with dynptr returned from
> > > bpf_malloc_dynptr().
> > I see! What is the advantage of a plain bpf_malloc()? Is it that it's
> > a more ergonomic API (you get back a direct pointer to the data
> > instead of getting back a dynptr and then having to call
> > bpf_dynptr_data to get direct access) and you don't have to allocate
> > extra bytes for refcounting?
> >
> > I will rename this to bpf_malloc_dynptr() and bpf_free_dynptr().
>
> Let's make it consistent with kptr. Those helpers will be:
> bpf_kptr_alloc(btf_id, flags, &ptr)
> bpf_kptr_get
> bpf_kptr_put
>
> bpf_dynptr_alloc(byte_size, flags, &dynptr);

I don't have strong feelings about this naming, but
bpf_ringbuf_reserve_dynptr() is a bit of counter-example with a
convention of using "_dynptr" suffix for variations of API that
*produce* dynptrs as an output. bpf_dynptr_alloc() sounds like we are
allocating struct bpf_dynptr itself, not a memory to which bpf_dynptr
points. But I'm don't have perfect naming scheme.

> bpf_dynptr_put(dynptr);
> would fit the best.
>
> Output arg being first doesn't match anything we had.
> let's keep it last.

yep, agree

>
> zero-alloc or plain kmalloc can be indicated by the flag.
> kzalloc() in the kernel is just static inline that adds __GFP_ZERO to flags.
> We don't need bpf_dynptr_alloc and bpf_dynptr_zalloc as two helpers.
> The latter can be a static inline helper in a bpf program.

yeah, sure, my point was that zero-initialization is a better default

>
> Similar to Andrii's concern I feel that bpf_dynptr_free() would be misleading.
