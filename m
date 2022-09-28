Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8343B5EE9CA
	for <lists+bpf@lfdr.de>; Thu, 29 Sep 2022 01:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbiI1XAL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Sep 2022 19:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiI1XAH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Sep 2022 19:00:07 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF81A7FFA4;
        Wed, 28 Sep 2022 16:00:04 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id sb3so30026446ejb.9;
        Wed, 28 Sep 2022 16:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=qUQYN10e4QRgkYQrbGoxNXOkqQlHKW3Ltpu72/uBXD0=;
        b=oX717eqTwi1rhghvz8SxfnxS2kiue9cKy0SJ4k5wy5OrtexJIsdsllJ6G/5fvMfcpC
         /GW4FsmAPyzrc3CGMXpXCu0kZqabRUWE/eZ24ZUS0ZTEtkJ2btK6QVaDbfZrT+rsV2Ro
         kJHdQS2pD+c32+JRwmxEfwYwSpBJOzefiFnHsBVsWOFQGeITetHIT5op1OGDeR7W9tv9
         UKhyjQzTA2t7D2q0rMEf0APBUw3+dr07GoL4Ci40wypPKYdzZfwwa7YvfUfVF1G+sPVU
         56XA21qrfFiyyeguEfjtaLOIKSGv1LzSCXr4M8uUnrlQfIzq02/3pqWBAX18qdgDF6pO
         9xpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=qUQYN10e4QRgkYQrbGoxNXOkqQlHKW3Ltpu72/uBXD0=;
        b=vWuatzO1HSuQJRZBcR+7IYBNtOICwUO7jEEyF+1q/RkoQXjhWZsU0a0MKIpxculmwy
         8FWedWEwrztx/O6sgP0ugwuqWAK9ssXKdKtw6Oa3iUFmhdw1hHtB5Wu90KuP5a3+cXqP
         C7vo+fIDk3GdFqaXzYD4i+ac0TFo0JdBA64ZdAik8VT/2QhiTcADiCDj1swDJ2d4r3ZX
         uDun05Vq12lhoL2tiStUZ2q3c9YqP8HF+7gRFQVPumSlNYN8itfAhm3WsBTDnpFqaJU+
         vL+KqTxcjEoL8KV27MDRJ9o26caQjx69e1sfTboJu20kikvSzL8mXDD+I8HC9/oIK4hT
         AFlw==
X-Gm-Message-State: ACrzQf0L5tnVbhAw4DZ/iACAnM0wBQzHVagwYt2CYZ9GJ7sXbACO3WiM
        T3QT2bJcDlGC2Ui33vvr3bBJf9RcOlAnkLF80ww=
X-Google-Smtp-Source: AMsMyM4fz4rtZaf8UYDQRFWIe7TK9YImEZLgNG8j1ECSDniF0kd6Mr5nJWvbLj3sKoaQW1q1p+gXthNnvDWGWZayAjk=
X-Received: by 2002:a17:907:72c1:b0:783:34ce:87b9 with SMTP id
 du1-20020a17090772c100b0078334ce87b9mr182779ejc.115.1664406003394; Wed, 28
 Sep 2022 16:00:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220924101209.50653-1-liuxin350@huawei.com> <20220924101209.50653-2-liuxin350@huawei.com>
In-Reply-To: <20220924101209.50653-2-liuxin350@huawei.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 28 Sep 2022 15:59:50 -0700
Message-ID: <CAEf4BzZp1oGtOy56noPtx+MimQq5ua7X25mB4Sf05CHLx=1m0g@mail.gmail.com>
Subject: Re: [PATCH 1/2] libbpf: add fPIC option for static library
To:     Xin Liu <liuxin350@huawei.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, yanan@huawei.com,
        wuchangye@huawei.com, xiesongyang@huawei.com, zhudi2@huawei.com,
        kongweibin2@huawei.com
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

On Sat, Sep 24, 2022 at 3:13 AM Xin Liu <liuxin350@huawei.com> wrote:
>
> Some programs depned on libbpf.a(eg:bpftool). If libbpf.a miss -fPIC,
> this will cause a similar error at compile time:
>
> /usr/bin/ld: .../libbpf.a(libbpf-in.o): relocation
> R_AARCH64_ADR_PREL_PG_HI21 against symbol `stderr@@GLIBC_2.17' which
> may bind externally can not be used when making a sharedobject;
> recompile with -fPIC
>
> Use -fPIC for static library compilation to solve this problem.
>
> Signed-off-by: Xin Liu <liuxin350@huawei.com>
> ---
>  tools/lib/bpf/Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
> index 4c904ef0b47e..427e971f4fcd 100644
> --- a/tools/lib/bpf/Makefile
> +++ b/tools/lib/bpf/Makefile
> @@ -91,9 +91,10 @@ override CFLAGS += $(INCLUDES)
>  override CFLAGS += -fvisibility=hidden
>  override CFLAGS += -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64
>  override CFLAGS += $(CLANG_CROSS_FLAGS)
> +override CFLAGS += -fPIC
>

It seems wrong to force -fPIC for static library just because in some
situations users might want to statically link their *shared* library
with *static* libbpf. It's a bit unconventional, even though I see
situations in which this might be useful.

But I don't think this can be a default. I see three possible solutions:

1. Do nothing. Let users specify EXTRA_CFLAGS=-fPIC if they need
position-independent static lib
2. Let packagers decide this (again, through EXTRA_CFLAGS or by
patching Makefile, whichever is best). Or maybe build both PIC and
non-PIC static libraries and package both?
3. Produce PIC and non-PIC libbpf.a libraries from libbpf's Makefile.

I'm not sure which one is the best answer, would be nice to hear
opinions of people who do the packaging and distribution of libbpf in
distros.

>  # flags specific for shared library
> -SHLIB_FLAGS := -DSHARED -fPIC
> +SHLIB_FLAGS := -DSHARED
>
>  ifeq ($(VERBOSE),1)
>    Q =
> --
> 2.33.0
>
