Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43FF0429C29
	for <lists+bpf@lfdr.de>; Tue, 12 Oct 2021 06:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbhJLEFh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Oct 2021 00:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbhJLEFh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Oct 2021 00:05:37 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C055C061570
        for <bpf@vger.kernel.org>; Mon, 11 Oct 2021 21:03:36 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id r1so43640952ybo.10
        for <bpf@vger.kernel.org>; Mon, 11 Oct 2021 21:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cl85gijkEC0tjL4hR5V2nxVpz85M33PXepeEn6XKfbQ=;
        b=Dy9NfmfVRfgbK/KuSf4QohaXxHCfitKc4U0Q/qF/ihI+0qM/M38G1YIU+8i8ThBDu9
         gIoLulwSyfrxvdFWUy50On1M1MwXzuDOMqAtYnDpx9t2s8v0ArxDnZvDYHxNgWqg/3/8
         qklN0piOadU/XEsm0oVvzu0WG3Hmm+6e2/sg96rwLJkDYjtleLFoxE8C4Wr9Bcf5/c8a
         3UzECtz0Qs2aWH/AN316xZAK8+grtCS2dz4WoiYptV8+pu5Gtkm3IAYnLaTJmsASo1WR
         mlVrVQMM7AK4lFCtnfCPb7Jol2nvs4AkHAsZJsCgKkvQWw5w5AT3uhGCTTbq3Wq0TwL0
         IoqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cl85gijkEC0tjL4hR5V2nxVpz85M33PXepeEn6XKfbQ=;
        b=kDYafgBxmq3dLW7SZ3SFcVaQbRS+OBC0f4dC1gE7a6R5SXzxdySWbvc2LudpYA9OrL
         L68Y3o3Rr+CGHK2GI0rZmQpujqg/tB/z0NzmyG9krqOqLjTYWVE7xDHkytK3d2RN10cF
         /NsgHzjonzmcc4suJfQ5rGmfhuC29jiKMDsYVY37p2v6kYPytA+HuS6nU+x4RQaLltfZ
         Y6euV02ZRRjYCISZeHpTZQbCmz44RsCAo0h8E97EQwxTueVIK9Jdmf8MhWe9libOmm4B
         zQbd4XeOk5QAy9puFeU0+6nI+Ox1543wApheQ1OxJO4Yh0Q3bkTIx6WZt8MJkD1+23Js
         mEkg==
X-Gm-Message-State: AOAM532tGIZH6H31FYFgRixbEvQC4wmlyOFqhFqN1lgDyhSMhyhVlJHg
        l/V84NhzRs4kYLICBLhDE1T3/RpQzMZCDek3rZA=
X-Google-Smtp-Source: ABdhPJzFdyyRHdRzCSGJptpC4kOhDrkWfIBWgSukYaTlUvE1zGsepl9Jqn8lqNIZAAwWsTp9Zd3NQTqWAm2rvJcGR0k=
X-Received: by 2002:a25:5606:: with SMTP id k6mr25555145ybb.51.1634011415344;
 Mon, 11 Oct 2021 21:03:35 -0700 (PDT)
MIME-Version: 1.0
References: <20211012023218.399568-1-iii@linux.ibm.com> <20211012023218.399568-3-iii@linux.ibm.com>
In-Reply-To: <20211012023218.399568-3-iii@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 12 Oct 2021 06:03:24 +0200
Message-ID: <CAEf4BzZeUQf4DzCNgkpR7yqsb41=Vvu8EPfdTQBwaBk95Dxi-w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] libbpf: Fix dumping big-endian bitfields
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 12, 2021 at 4:32 AM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> On big-endian arches not only bytes, but also bits are numbered in
> reverse order (see e.g. S/390 ELF ABI Supplement, but this is also true
> for other big-endian arches as well).
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  tools/lib/bpf/btf_dump.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
> index ad6df97295ae..ab45771d0cb4 100644
> --- a/tools/lib/bpf/btf_dump.c
> +++ b/tools/lib/bpf/btf_dump.c
> @@ -1577,14 +1577,15 @@ static int btf_dump_get_bitfield_value(struct btf_dump *d,
>         /* Bitfield value retrieval is done in two steps; first relevant bytes are
>          * stored in num, then we left/right shift num to eliminate irrelevant bits.
>          */
> -       nr_copy_bits = bit_sz + bits_offset;
>         nr_copy_bytes = t->size;
>  #if __BYTE_ORDER == __LITTLE_ENDIAN
>         for (i = nr_copy_bytes - 1; i >= 0; i--)
>                 num = num * 256 + bytes[i];
> +       nr_copy_bits = bit_sz + bits_offset;
>  #elif __BYTE_ORDER == __BIG_ENDIAN
>         for (i = 0; i < nr_copy_bytes; i++)
>                 num = num * 256 + bytes[i];
> +       nr_copy_bits = nr_copy_bytes * 8 - bits_offset;

oh, I remember dealing with this in the context of pahole. Just one
nit, please use t->size instead of nr_copy_bytes, I think it will make
it a bit more explicit (nr_copy_bytes is logically mutable, though
only in little-endian case, but still).

>  #else
>  # error "Unrecognized __BYTE_ORDER__"
>  #endif
> --
> 2.31.1
>
