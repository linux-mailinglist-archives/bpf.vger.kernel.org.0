Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B676614434
	for <lists+bpf@lfdr.de>; Tue,  1 Nov 2022 06:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiKAFYN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Nov 2022 01:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbiKAFYC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Nov 2022 01:24:02 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18CA1109A
        for <bpf@vger.kernel.org>; Mon, 31 Oct 2022 22:23:56 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id k15so4489787pfg.2
        for <bpf@vger.kernel.org>; Mon, 31 Oct 2022 22:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ckme17bDZWxNa/iBrFHvpbZAlPaN1AATcxEYKVR5N8g=;
        b=G3J/0mFiAFHA1lsmj/bsPEXX9ijq8ulfS8Z54Vtj+6oDabl3DmskvPp9QBgIHelZoj
         XUF7AJ9UblwlD7+KOM0gEMh5cqELGGGTdL2LLdwfhq/sTis9oarKQzqLUhUWcUPmKc7V
         k26SzoGnRIgCvh16xegLCWqK6abjyR7j1CuCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ckme17bDZWxNa/iBrFHvpbZAlPaN1AATcxEYKVR5N8g=;
        b=IxgHcWFKxuTUl02ME9AWyHpXGZFh0xDTdvI+gIuRWfzxIR2IRz6yC+kacjYoWypqzE
         oQKkOcULJ9VYem0nFu+SHJHf5BGam2uESe1ovLfQfShVd4AautL60SD3EAeFpQOvszku
         uPRv9sGXahR5hjysSii/vxcu7JEL8/P7DG0F0vIzbLJgGqZWNAI6HRm45KPQrtTGk/2P
         /yHlDUBF9Yp/Rz0pvCUTU7TCTc8anHoZqMh8b2eo5T4VnuKJr10oSP5fioKro0z6rwlD
         jabvarQoKJcIyxZxdGr2Oxb4pfGPdYKk1E7Z1yZsZRF8nQxoCm+P2siunddndNf6HCsu
         s8QA==
X-Gm-Message-State: ACrzQf2k8YTyyZXvWuwTIWeIkFpEZteOwkGyvbLGOapayhqcMXu51YEW
        BSv94UA/CaikMaT17wBT1+mfUg==
X-Google-Smtp-Source: AMsMyM7axCKf5t2an+uR1OgVVP6jvEDx7TMZGaFnNA5XMS09xxYJdATNmQ+GiQ1szPf0wgJWBN3utw==
X-Received: by 2002:a65:6e93:0:b0:456:5024:e6ae with SMTP id bm19-20020a656e93000000b004565024e6aemr68920pgb.466.1667280235910;
        Mon, 31 Oct 2022 22:23:55 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id ix22-20020a170902f81600b001769206a766sm5296014plb.307.2022.10.31.22.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 22:23:55 -0700 (PDT)
Date:   Mon, 31 Oct 2022 22:23:54 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 3/3] bpf/verifier: Take advantage of full
 allocation sizes
Message-ID: <202210312222.0AE80CD3@keescook>
References: <20221029024444.gonna.633-kees@kernel.org>
 <20221029025433.2533810-3-keescook@chromium.org>
 <CAKH8qBtS9UHTVZ8PgFd2fOS1k6MLxot_SDBg2+H5BhoqQTOcGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKH8qBtS9UHTVZ8PgFd2fOS1k6MLxot_SDBg2+H5BhoqQTOcGg@mail.gmail.com>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 31, 2022 at 02:53:35PM -0700, Stanislav Fomichev wrote:
> On Fri, Oct 28, 2022 at 7:54 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > Since the full kmalloc bucket size is being explicitly allocated, pass
> > back the resulting details to take advantage of the full size so that
> > reallocation checking will be needed less frequently.
> >
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > Cc: John Fastabend <john.fastabend@gmail.com>
> > Cc: Andrii Nakryiko <andrii@kernel.org>
> > Cc: Martin KaFai Lau <martin.lau@linux.dev>
> > Cc: Song Liu <song@kernel.org>
> > Cc: Yonghong Song <yhs@fb.com>
> > Cc: KP Singh <kpsingh@kernel.org>
> > Cc: Stanislav Fomichev <sdf@google.com>
> > Cc: Hao Luo <haoluo@google.com>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: bpf@vger.kernel.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  kernel/bpf/verifier.c | 27 ++++++++++++++++-----------
> >  1 file changed, 16 insertions(+), 11 deletions(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 1c040d27b8f6..e58b554e862b 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -1020,20 +1020,23 @@ static void *copy_array(void *dst, const void *src, size_t n, size_t size, gfp_t
> >         return dst ? dst : ZERO_SIZE_PTR;
> >  }
> >
> > -/* resize an array from old_n items to new_n items. the array is reallocated if it's too
> > - * small to hold new_n items. new items are zeroed out if the array grows.
> > +/* Resize an array from old_n items to *new_n items. The array is
> > + * reallocated if it's too small to hold *new_n items. New items are
> > + * zeroed out if the array grows. Allocation is rounded up to next kmalloc
> > + * bucket size to reduce frequency of resizing. *new_n contains the new
> > + * total number of items that will fit.
> >   *
> > - * Contrary to krealloc_array, does not free arr if new_n is zero.
> > + * Contrary to krealloc, does not free arr if new_n is zero.
> >   */
> > -static void *realloc_array(void *arr, size_t old_n, size_t new_n, size_t size)
> > +static void *realloc_array(void *arr, size_t old_n, size_t *new_n, size_t size)
> >  {
> >         size_t alloc_size;
> >         void *new_arr;
> >
> > -       if (!new_n || old_n == new_n)
> > +       if (!new_n || !*new_n || old_n == *new_n)
> >                 goto out;
> >
> > -       alloc_size = kmalloc_size_roundup(size_mul(new_n, size));
> > +       alloc_size = kmalloc_size_roundup(size_mul(*new_n, size));
> >         new_arr = krealloc(arr, alloc_size, GFP_KERNEL);
> >         if (!new_arr) {
> >                 kfree(arr);
> > @@ -1041,8 +1044,9 @@ static void *realloc_array(void *arr, size_t old_n, size_t new_n, size_t size)
> >         }
> >         arr = new_arr;
> >
> > -       if (new_n > old_n)
> > -               memset(arr + old_n * size, 0, (new_n - old_n) * size);
> > +       *new_n = alloc_size / size;
> > +       if (*new_n > old_n)
> > +               memset(arr + old_n * size, 0, (*new_n - old_n) * size);
> >
> >  out:
> >         return arr ? arr : ZERO_SIZE_PTR;
> 
> [..]
> 
> > @@ -1074,7 +1078,7 @@ static int copy_stack_state(struct bpf_func_state *dst, const struct bpf_func_st
> >
> >  static int resize_reference_state(struct bpf_func_state *state, size_t n)
> >  {
> > -       state->refs = realloc_array(state->refs, state->acquired_refs, n,
> > +       state->refs = realloc_array(state->refs, state->acquired_refs, &n,
> >                                     sizeof(struct bpf_reference_state));
> >         if (!state->refs)
> >                 return -ENOMEM;
> 
> Patches 1 & 2 look good, but not sure about this part. We later do the
> following in the same routine:

I'm totally fine leaving off #3. 1 is a bug fix, 2 is what I need to get
the ksize side-effect managed in bpf, and 3 was maybe an optimization.

-- 
Kees Cook
