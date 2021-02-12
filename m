Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E45E931A69E
	for <lists+bpf@lfdr.de>; Fri, 12 Feb 2021 22:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbhBLVPb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Feb 2021 16:15:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbhBLVPW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Feb 2021 16:15:22 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E35C061574
        for <bpf@vger.kernel.org>; Fri, 12 Feb 2021 13:14:42 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id b10so821263ybn.3
        for <bpf@vger.kernel.org>; Fri, 12 Feb 2021 13:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4qDG2chWDXaX3KF1Do4HXqZycVZM68j4BUH+bQK19+U=;
        b=AM9l/cHbWl66tpvvMoZphB8io8g7/AYz6RP2Km9LcCEQ+IzJMQejfgSOdwnsjU8PVq
         ZTAezYVI3OUNM/ji868AmHz/sDmp24LVNQ0/YtXX7lWStWLuLLYxwN6dkkvFyuWuZz0Z
         896KART+/y/vAv5ctVi/55nWbDEAm24BDyhAegdxWNLl51LzCZTG1DAwXVR/RQRMAFHW
         RwpRLKySA6bbnBVuh4v2n51bI0e0GuIWmgfRq+o9gpJh3yLu6ose23zvgVhXJ20TxAuT
         KdQp9AZ5WNggYvb2gzmwJSdWG9oAbZacoOqd3k1n9UqcCwddBPEjTwVpuPXwHUOMbrJE
         O2cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4qDG2chWDXaX3KF1Do4HXqZycVZM68j4BUH+bQK19+U=;
        b=WyMFRIRvX+VcQpB8xbFu0E092WxnrY7QgYBvsrx1W1R2tHIHR0uBnDV0E/R8ceI14s
         eO7L9+PtMJYSoDcsAdFaH47PxuI0ZYWoWNbe00Cbr4JUcWLbCZsccNwE8fRybKC47E0i
         IzkSIpXgxOVrwQU37M2rf7QDfkNJMq0LChvh262p5Mkg0ai56AOd0KEwaWvmE6jtxaga
         jIALq0XMfo1lXHhmqIAA6yz1sQ02bmeW0bUY/nIVEY837zon0nDjC08zmX90eYcMpWnw
         lQOipUCcMZHo4E5EA0kU0XSIgSXs7hwrTRe+3820xhOi2QCT+sVbeKdrShuW41dcuvn7
         mZGw==
X-Gm-Message-State: AOAM5312EMj/X74EanNIS2uKiWPprwA9Cm3oQV9/4CZfZXDJFEzuN4Zd
        m3KSSSdy5ap7/3M1E2T0flC3p06HaY0Xw74WHaI=
X-Google-Smtp-Source: ABdhPJyMj8CfaZJZJXPsQjvRebp8jcE6tnwe6nSKlRv65V+ezBqsTs2+7A3JnLGs6cDg4DQoZvNzTYsPI0VzzyAVWMk=
X-Received: by 2002:a25:4b86:: with SMTP id y128mr6504975yba.403.1613164481801;
 Fri, 12 Feb 2021 13:14:41 -0800 (PST)
MIME-Version: 1.0
References: <20210212205642.620788-1-me@ubique.spb.ru> <20210212205642.620788-4-me@ubique.spb.ru>
In-Reply-To: <20210212205642.620788-4-me@ubique.spb.ru>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 12 Feb 2021 13:14:30 -0800
Message-ID: <CAEf4BzbpPBW9AHZYPdsKL2KN_3Uenkwn=Ao7mpBduzEVPJXLOw@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 3/4] bpf: Support pointers in global func args
To:     Dmitrii Banshchikov <me@ubique.spb.ru>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, Andrey Ignatov <rdna@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 12, 2021 at 12:57 PM Dmitrii Banshchikov <me@ubique.spb.ru> wrote:
>
> Add an ability to pass a pointer to a type with known size in arguments
> of a global function. Such pointers may be used to overcome the limit on
> the maximum number of arguments, avoid expensive and tricky workarounds
> and to have multiple output arguments.
>
> A referenced type may contain pointers but indirect access through them
> isn't supported.
>
> The implementation consists of two parts.  If a global function has an
> argument that is a pointer to a type with known size then:
>
>   1) In btf_check_func_arg_match(): check that the corresponding
> register points to NULL or to a valid memory region that is large enough
> to contain the expected argument's type.
>
>   2) In btf_prepare_func_args(): set the corresponding register type to
> PTR_TO_MEM_OR_NULL and its size to the size of the expected type.
>
> Only global functions are supported because allowance of pointers for
> static functions might break validation. Consider the following
> scenario. A static function has a pointer argument. A caller passes
> pointer to its stack memory. Because the callee can change referenced
> memory verifier cannot longer assume any particular slot type of the
> caller's stack memory hence the slot type is changed to SLOT_MISC.  If
> there is an operation that relies on slot type other than SLOT_MISC then
> verifier won't be able to infer safety of the operation.
>
> When verifier sees a static function that has a pointer argument
> different from PTR_TO_CTX then it skips arguments check and continues
> with "inline" validation with more information available. The operation
> that relies on the particular slot type now succeeds.
>
> Because global functions were not allowed to have pointer arguments
> different from PTR_TO_CTX it's not possible to break existing and valid
> code.
>
> Signed-off-by: Dmitrii Banshchikov <me@ubique.spb.ru>
> ---

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  include/linux/bpf_verifier.h |  2 ++
>  kernel/bpf/btf.c             | 55 +++++++++++++++++++++++++++++-------
>  kernel/bpf/verifier.c        | 30 ++++++++++++++++++++
>  3 files changed, 77 insertions(+), 10 deletions(-)
>

[...]
