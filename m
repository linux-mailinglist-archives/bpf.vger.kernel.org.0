Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA7F6CCC1E
	for <lists+bpf@lfdr.de>; Tue, 28 Mar 2023 23:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjC1Vcm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Mar 2023 17:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjC1Vcl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Mar 2023 17:32:41 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35D9268E
        for <bpf@vger.kernel.org>; Tue, 28 Mar 2023 14:32:40 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id eh3so55221841edb.11
        for <bpf@vger.kernel.org>; Tue, 28 Mar 2023 14:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680039159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QtZzXyMCXduJYdgI1PZAKcUSzAtgQkmPX0WXgArjNd8=;
        b=N9jQc/EqvA5mrngYLc9bL0yHtsadll6kOtaW21FRHEvOavWY8PaGcUUaDkZQ8OA24J
         XCv2koGqw9FkYxnkcrxc1intxBBSWgRfLjNBFc6+cGZdtBwyCVPMIzmnziUV3/Ra0UmT
         LWV0eWpbavQ8C+7qtMg+8YCm7w6Aj3jL/ahobNz0K5y/8jakRfH6H/NTRpv+GwF9nKw8
         vJEgYY2NQtzvcprnMZ+xTCDtXsrDhxAIQrsG/8w95R0yP8uRKQOUwdvfrhU1F6euR0oZ
         H9icFnoO+l/X7z/2ftI9HSLAWLp+oAEXxevfR4sre5sScSUA89Wj4fzbV9JLdFPI14ye
         awOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680039159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QtZzXyMCXduJYdgI1PZAKcUSzAtgQkmPX0WXgArjNd8=;
        b=X3OvtNFufIitZ2QavxLfxQ0Ta8UevnASGdeP9oUaw7DzA9tGpS5LpXyw2ToOeLunmZ
         BlOWrxLKHOUcELpg8EbV6hGtF1MJodjV5IIJpRw744lGUeNz9bCfCmodqoukpNa4Byl/
         WibBJllUgXhU2Ylj6YiAMu/KSIOshhoOLznmjYX6vy28x4GghRk7DIEPqCnvmPiRDbE7
         2og9lmZ/kv+7uI27iqOWjmxLZeGHFxSOZDVk1Xa7TTSFqAMMJ4ZLczH4Hzo2IP3ZKsL5
         qhDnzITRggJtTzKRLM+LA6/kJQEho0c1QQyL6Hx/hKmRUlMLy4pujQM2zNApGkB+Dd1+
         tx4Q==
X-Gm-Message-State: AAQBX9fuuX1w3pBL3MMu+f1HrrBk9QJ4H/VwM75bgrM6ljp6mETNpU4Z
        oN6XdAiUVokeQdUyOEZ+wWpO3e/GRmeFgM0tN3s=
X-Google-Smtp-Source: AKy350bghbLCzht6PKwzmPKBmo8St4GGy9n8Z8gGwqx83j9y36TayvzqGx9udWuutURJTNBql+RL5lqMyQ9sG0oq1qU=
X-Received: by 2002:a17:906:2303:b0:930:310:abf1 with SMTP id
 l3-20020a170906230300b009300310abf1mr8718653eja.5.1680039159062; Tue, 28 Mar
 2023 14:32:39 -0700 (PDT)
MIME-Version: 1.0
References: <1d286b16-4d57-d667-e62c-00d6cb0d956d@google.com>
In-Reply-To: <1d286b16-4d57-d667-e62c-00d6cb0d956d@google.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 28 Mar 2023 14:32:27 -0700
Message-ID: <CAEf4BzY8QnPqv7Sn0RYkf4exfQ_dEHtHejLkHJyx2swq4LAs4w@mail.gmail.com>
Subject: Re: inline ASM helpers for proving bounds checks
To:     Barret Rhoden <brho@google.com>
Cc:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Mar 25, 2023 at 9:08=E2=80=AFAM Barret Rhoden <brho@google.com> wro=
te:
>
> hi -
>
> i was chatting with a few people off-list and mentioned that i wrote a
> couple helpers for ensuring ints are bounds-checked for things like
> array accesses.  i used inline asm to prevent the compiler from doing
> things like copying the register, checking the copy, and using the
> original for the indexing operation.
>
> i'll paste them below.
>
> if this is the sort of thing that would be nice in one of the helper
> header files, let me know where you'd like it and i can send a patch.
>
> thanks,
>
> barret
>
>
> /*
>   * Returns pointer to idx element in the array arr, made of
>   * arr_sz number of elements:
>   *
>   *      if (!arr)
>   *              return NULL;
>   *      if (idx >=3D arr_sz)
>   *              return NULL;
>
>   *      return &arr[idx];
>   */
> #define BOUNDED_ARRAY_IDX(arr, arr_sz, idx) ({      \
>          typeof(&(arr)[0]) ___arr =3D arr;             \
>          u64 ___idx =3D idx;                           \
>          if (___arr) {                               \
>                  asm volatile("if %[__idx] >=3D %[__bound] goto 1f;\
>                                %[__idx] *=3D %[__size];            \
>                                %[__arr] +=3D %[__idx];             \
>                                goto 2f;                          \
>                                1:;                               \
>                                %[__arr] =3D 0;                     \
>                                2:                                \
>                                "                                 \
>                               : [__arr]"+r"(___arr), [__idx]"+r"(___idx)\
>                               : [__bound]"i"((arr_sz)),                 \
>                                 [__size]"i"(sizeof(typeof((arr)[0])))   \
>                               : "cc");                                  \
>          }                                                              \
>          ___arr;                                                        \
> })
>

Hey, Barret!

This one looks pretty useful and common (especially to work around
Clang's smartness). I have related set of helpers waiting it's time,
see [0]. I'd say we should think about some good naming of them,
document them properly (including various gotchas), and include them
(initially) in bpf_misc.h and start using them in selftests. This way
we'll have upstream header to point to for eager users, we'll
test-drive their usefulness in selftests, and when we feel confident
they are generally useful and safe, we'll move them into libbpf's
bpf_helpers.h.


  [0] https://github.com/anakryiko/linux/commit/feef5205c05b282d4a6c73a0222=
474a805907864


>
> /*
>   * Forces the verifier to ensure idx is less than bound.  Returns 0 if
>   * idx is not less than bound.
>   */
> static inline size_t bounded_idx(size_t idx, int bound)
> {
>          asm volatile("if %[__idx] < %[__bound] goto 1f; \
>                        %[__idx] =3D 0;                     \
>                        1:"
>                        : [__idx]"+r"(idx) : [__bound]"i"(bound) : "cc");
>          return idx;
> }
>
> this one is a little simpler, but also more dangerous.  if the int isn't

yeah, I'm hesitant about this one. It is very similar to
bpf_clam_xxx() macros I referenced above, probably we should use those
instead.

> actually bounded, it'll set it to 0, which might not be what you want
> since you can't tell the difference between "out of bounds" and
> "actually 0".  i use this in a place where i know the int is bounded
> (barring other horrendous bugs) and can't check.
>
>
