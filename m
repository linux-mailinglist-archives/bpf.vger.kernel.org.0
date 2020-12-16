Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90AEB2DC949
	for <lists+bpf@lfdr.de>; Wed, 16 Dec 2020 23:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730300AbgLPWyl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Dec 2020 17:54:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730298AbgLPWyl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Dec 2020 17:54:41 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60B2C061794
        for <bpf@vger.kernel.org>; Wed, 16 Dec 2020 14:54:00 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id v67so24046235ybi.1
        for <bpf@vger.kernel.org>; Wed, 16 Dec 2020 14:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+chVmmGac2b+UIPlXJch7ZlbB1H7Te28qrh1RbhV15E=;
        b=BGKjS3AWGfo2MbtC+kcIdqELG2mGv7T+fpL0vjCjIHDM1WW/1aDxcnBqeU88Jh+wvO
         Qlh94gWqZjEcZrWbk6xHyC6HYK3m3nEOngG6LvWpJbSosm76EaXCeminS+bDvDIulU2t
         pB2sdAJmcGZh9Wh4EbhcS8MC0/NEcRIM7LRa25rYXIY0FS6pgdthLsaBNiLt93tB1EWe
         aLmntedwtHMnQ3z0We7QCzGDolv4ay2J+NSVM/yR7Mo4b9IzHwpkJh5+8w9VdZE/AzMZ
         QjTWfxnF/pLTHXWqIgTrGaZMhSOx19cE7PAJjXdMOtz3NA5dn2MCxKgmPuFMM+V1O4e1
         Fspg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+chVmmGac2b+UIPlXJch7ZlbB1H7Te28qrh1RbhV15E=;
        b=EW6kG6NTpI28cEXVEVEET6JvAS6wNi+MwAqZfVGccg2Og6ot+25moj6g2d4QmRpcPX
         3tBhMcijGolAsaEHwZj2LCQXCYsMgS/nCtxSjDY39yfRknYOAG+TAYBpZoLtjozFXHd1
         Si8QvHa0p/zJVLDHNehXttmRD3JxOlOCK0AUwsyihk6QqzVtwEoWT6hjXTsTI8snzOaz
         mpHJThmId/tOnDDbYLfAfLoaju+4qgcElHICicLBuZiaspfRp0Y/gax6Mczv3DCN8pV/
         l3o35DLLoFM+Sy6k5P1Q7TvBOImM2/vDcNNy9+g2cpuII/Z71d+xRy+3TC/G7mIpBCWu
         5SEw==
X-Gm-Message-State: AOAM530XiU8EEa72LrWENkZHrsXG76EYBWuBu7Dh94BzmRhbSLJclKK5
        /5Co8TnO1+zT3w8zzQ1kcvHOg73JuVXaI8kwVL8=
X-Google-Smtp-Source: ABdhPJwXe7k0IcsxtyB9ujRtNWbrHgxqMtxQjGBvvk2lZ71FSD5vWyvMrzqrMc7YHwSgHm1Di8J7dkg+nNTMz1MyE48=
X-Received: by 2002:a25:c7c6:: with SMTP id w189mr53006158ybe.403.1608159240120;
 Wed, 16 Dec 2020 14:54:00 -0800 (PST)
MIME-Version: 1.0
References: <cover.1607973529.git.me@ubique.spb.ru> <4a0f45692b124b7bca139a6c58c131496ec2dc12.1607973529.git.me@ubique.spb.ru>
In-Reply-To: <4a0f45692b124b7bca139a6c58c131496ec2dc12.1607973529.git.me@ubique.spb.ru>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 16 Dec 2020 14:53:49 -0800
Message-ID: <CAEf4BzZ6AV-6aVNbV58ZHWsB72ekKBeQ+ZF9DrKWr7=fJ7oiCw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: Add unit tests for global functions
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

On Mon, Dec 14, 2020 at 11:53 AM Dmitrii Banshchikov <me@ubique.spb.ru> wrote:
>
> test_global_func9  - check valid scenarios for struct pointers
> test_global_func10 - check that the smaller struct cannot be passed as a
>                      the larger one
> test_global_func11 - check that CTX pointer cannot be passed as a struct
>                      pointer
> test_global_func12 - check access to a null pointer
> test_global_func13 - check access to an arbitrary pointer value
>
> Signed-off-by: Dmitrii Banshchikov <me@ubique.spb.ru>
> ---
>  .../bpf/prog_tests/test_global_funcs.c        |  5 ++
>  .../selftests/bpf/progs/test_global_func10.c  | 29 +++++++++
>  .../selftests/bpf/progs/test_global_func11.c  | 19 ++++++
>  .../selftests/bpf/progs/test_global_func12.c  | 21 +++++++
>  .../selftests/bpf/progs/test_global_func13.c  | 24 ++++++++
>  .../selftests/bpf/progs/test_global_func9.c   | 59 +++++++++++++++++++
>  6 files changed, 157 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/test_global_func10.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_global_func11.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_global_func12.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_global_func13.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_global_func9.c
>

[...]

> +
> +SEC("cgroup_skb/ingress")
> +int test_cls(struct __sk_buff *skb)
> +{
> +       int result = 0;
> +
> +       {
> +               const struct S s = {.x = skb->len };
> +
> +               result |= foo(&s);
> +       }
> +
> +       {
> +               const __u32 key = 1;
> +               const struct S *s = bpf_map_lookup_elem(&map, &key);
> +
> +               result |= foo(s);
> +       }

Can you please also add a test with passing a pointer to a global
variable as an input parameter?

Also, none of these tests seem to validate that correct data is read
and returned from foo. So it would be nice to have a dedicated
selftest (not part of test_global_func) that would pass some input
parameters (easiest to do with global variables) and see that the
subprogram returns it correctly.

> +
> +       {
> +               const struct C c = {.x = skb->len, .y = skb->family };
> +
> +               result |= foo((const struct S *)&c);
> +       }
> +
> +       {
> +               result |= foo(NULL);
> +       }
> +
> +       return result ? 1 : 0;
> +}
> --
> 2.25.1
>
