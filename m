Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C57E450202E
	for <lists+bpf@lfdr.de>; Fri, 15 Apr 2022 03:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242349AbiDOBqC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Apr 2022 21:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234458AbiDOBqB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Apr 2022 21:46:01 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A48AC05B
        for <bpf@vger.kernel.org>; Thu, 14 Apr 2022 18:43:34 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 17so8096664lji.1
        for <bpf@vger.kernel.org>; Thu, 14 Apr 2022 18:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DkGqoOsEwYiMNXbeYbldQZIUjou4J4kmUUyuMgo7rbg=;
        b=Wv6RNnSwlKANCH7ZuJjNpTQsW0Lbun/jkS19MfLwckN9QDZ+SFUnl0inLtIVBH1jY6
         Cd2sXxm0mZSh/v38R7s49wIn1XHHOQ48V0amsw3PDLB+fJ/gkNi4oL5ETodBpM6gq3jo
         XVXOaFmvQvoZUpmwXxLA19sXaodZ3pXGsX90Xtq238M2tho0ssxZnwUzQgRW5/4XOsf2
         x/vgW2Vl1JBODSYqpZdl7rPzUI51lSNjHRmrmM9BCZTJjI6bhoOGMOmtDpp8R4DREeEz
         mTDRVHxvH4/ALacXGjCBmIKvfC+zvM7OvUJ/bUNUOLf19dHzIG8DpDvuZapRSRGiB/7W
         C0bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DkGqoOsEwYiMNXbeYbldQZIUjou4J4kmUUyuMgo7rbg=;
        b=r2WVi70q9aMs7scKpBI2IZo7u1FxGSQ/2Mk88uq8MsH8uoy3/onohPOX2zltXif1ho
         EreNvSsQ9aCahIe+rLJu1g3NWs60T4Rhs/OBcBk1ikaynd7BDAV2YxubVTmtT4KtEb1D
         Me+eTesfnGjTzG2Ypxawij6cgQHl/KAblMSUmqtGfUy46vBsOJdTSXxjHIVCGJ0jhAzb
         PChcNXfjIPMwWzrfBphtEzDa0g5FKcwNm0Cgwx2/XSrHdB37hba4uBoIFvTCOgiq5hBd
         mwPdIl8yVIU3YDdhyLaPJXLUs4NJHeELDPPzTtVNeABvVQ6MRP+U+NqaychlDM4u1Y0i
         P6yA==
X-Gm-Message-State: AOAM5301OSpqFAxCLaGeMgTN/iah7CIBz6sKGzpSehA+A/cSCSOq+2G7
        OuhpRBPOsH1i3F96wzEc2zUuxzSFGfs/k6+XLdQ=
X-Google-Smtp-Source: ABdhPJzbgZ33EpcvYdk16J6mvQAg+GP35WocyB00Vsr6TeO3Peisgxe4sJIE7kc8QCzOqUfiGJ7FLPFYM/39GlKtcLc=
X-Received: by 2002:a2e:9b05:0:b0:24b:e8:8c7e with SMTP id u5-20020a2e9b05000000b0024b00e88c7emr3075457lji.70.1649987012936;
 Thu, 14 Apr 2022 18:43:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220402015826.3941317-1-joannekoong@fb.com> <20220402015826.3941317-4-joannekoong@fb.com>
 <CAEf4BzbRsA+JTP+4mqWpjRd_KEtaaM74ihz7RKGgpu_outhxTg@mail.gmail.com>
 <CAJnrk1Y8nE7n6PY9f7KBHH-P_ji3vAnuH5UP0r1fAk4OUTUZtQ@mail.gmail.com>
 <CAEf4Bzbp=91iYC5Ggm2W6gd3m_=wYXUXrZ7XLnGU5i=STcVAWA@mail.gmail.com>
 <CAJnrk1bxi9Ax0RBCGEz61tH0v2DCZwy=R132R4BS5737-WMN9Q@mail.gmail.com>
 <20220409011158.dwkolvp4nyjl5kvr@MBP-98dd607d3435.dhcp.thefacebook.com> <CAEf4BzaFiCgy9wuQE-KpEX8oQrYJWWowNoq02rUe4uooUgSTLQ@mail.gmail.com>
In-Reply-To: <CAEf4BzaFiCgy9wuQE-KpEX8oQrYJWWowNoq02rUe4uooUgSTLQ@mail.gmail.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Thu, 14 Apr 2022 18:43:21 -0700
Message-ID: <CAJnrk1YVP5Kp6uoOz+tgMpAb87eR1toMMShdC-o-V383sYjp2Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 3/7] bpf: Add bpf_dynptr_from_mem, bpf_malloc, bpf_free
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
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

On Mon, Apr 11, 2022 at 7:12 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Apr 8, 2022 at 6:12 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Fri, Apr 08, 2022 at 04:37:02PM -0700, Joanne Koong wrote:
> > > > > > > + *
> > > > > > > + * void bpf_free(struct bpf_dynptr *ptr)
> > > > > >
> > > > > > thinking about the next patch set that will add storing this malloc
> > > > > > dynptr into the map, bpf_free() will be a lie, right? As it will only
> > > > > > decrement a refcnt, not necessarily free it, right? So maybe just
> > > > > > generic bpf_dynptr_put() or bpf_malloc_put() or something like that is
> > > > > > a bit more "truthful"?
> > > > > I like the simplicity of bpf_free(), but I can see how that might be
> > > > > confusing. What are your thoughts on "bpf_dynptr_free()"? Since when
> > > > > we get into dynptrs that are stored in maps vs. dynptrs stored
> > > > > locally, calling bpf_dynptr_free() frees (invalidates) your local
> > > > > dynptr even if it doesn't free the underlying memory if it still has
> > > > > valid refcounts on it? To me, "malloc" and "_free" go more intuitively
> > > > > together as a pair.
> > > >
> > > > Sounds good to me (though let's use _dynptr() as a suffix
> > > > consistently). I also just realized that maybe we should call
> > > > bpf_malloc() a bpf_malloc_dynptr() instead. I can see how we might
> > > > want to enable plain bpf_malloc() with statically known size (similar
> > > > to statically known bpf_ringbuf_reserve()) for temporary local malloc
> > > > with direct memory access? So bpf_malloc_dynptr() would be a
> > > > dynptr-enabled counterpart to fixed-sized bpf_malloc()? And then
> > > > bpf_free() will work with direct pointer returned from bpf_malloc(),
> > > > while bpf_free_dynptr() will work with dynptr returned from
> > > > bpf_malloc_dynptr().
> > > I see! What is the advantage of a plain bpf_malloc()? Is it that it's
> > > a more ergonomic API (you get back a direct pointer to the data
> > > instead of getting back a dynptr and then having to call
> > > bpf_dynptr_data to get direct access) and you don't have to allocate
> > > extra bytes for refcounting?
> > >
> > > I will rename this to bpf_malloc_dynptr() and bpf_free_dynptr().
> >
> > Let's make it consistent with kptr. Those helpers will be:
> > bpf_kptr_alloc(btf_id, flags, &ptr)
> > bpf_kptr_get
> > bpf_kptr_put
> >
> > bpf_dynptr_alloc(byte_size, flags, &dynptr);
>
> I don't have strong feelings about this naming, but
> bpf_ringbuf_reserve_dynptr() is a bit of counter-example with a
> convention of using "_dynptr" suffix for variations of API that
> *produce* dynptrs as an output. bpf_dynptr_alloc() sounds like we are
> allocating struct bpf_dynptr itself, not a memory to which bpf_dynptr
> points. But I'm don't have perfect naming scheme.
I agree. bpf_dynptr_alloc() sounds like it allocates the struct dynptr
- I like bpf_dynptr_malloc() more. But I'm fine going with
bpf_dynptr_alloc() if there's a strong preference for that.
>
> > bpf_dynptr_put(dynptr);
> > would fit the best.
> >
> > Output arg being first doesn't match anything we had.
> > let's keep it last.
>
> yep, agree
>
> >
> > zero-alloc or plain kmalloc can be indicated by the flag.
> > kzalloc() in the kernel is just static inline that adds __GFP_ZERO to flags.
> > We don't need bpf_dynptr_alloc and bpf_dynptr_zalloc as two helpers.
> > The latter can be a static inline helper in a bpf program.
>
> yeah, sure, my point was that zero-initialization is a better default
>
> >
> > Similar to Andrii's concern I feel that bpf_dynptr_free() would be misleading.
