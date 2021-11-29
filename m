Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2564946288B
	for <lists+bpf@lfdr.de>; Tue, 30 Nov 2021 00:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233794AbhK2XuR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Nov 2021 18:50:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbhK2XuQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Nov 2021 18:50:16 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 844CFC061574
        for <bpf@vger.kernel.org>; Mon, 29 Nov 2021 15:46:58 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id 131so47119189ybc.7
        for <bpf@vger.kernel.org>; Mon, 29 Nov 2021 15:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k0M/YVuIMnnbo6SkHLfn1/C0MQY+t5bE6qhJP7oYRyI=;
        b=NtbXt5EoIeoCguoIwrYHHlUrLwDLmBEu59PWKaU8O6foEWI+WtasaWm6Kr8W2y/Fc0
         z7pCWpSzWEjt7EJGsF/4VTGrkcefI2WfYEeWPSpc1cyIksp7fLWyOkjUjoD7WaJBlsid
         806CiSzBq9eHaa15UeBXQxJCkjTpuNCIahbVvHVdu70HKEyt3zAEIAthF9m4BD6B31b9
         7mpInPdHwYcOBNJYpRMkh3XynruwhdeL2LWOXfigAE8ppJOI4/Bw79czpaBWeclW/m0u
         7PAsOxvQhdPe+G2FUf3GdhipEwerxo7IQIoRBikRItCf5AQakgZSbHR/Os+DOmFPbdM9
         5QVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k0M/YVuIMnnbo6SkHLfn1/C0MQY+t5bE6qhJP7oYRyI=;
        b=HjjoeHfvHRcqIT2gSjCggBVm7WxZN1auHSMJ55Cf2+fy2o44EZV9KknOWbjry4etiO
         UlSsM42eZO/sQ+ZcSdCgMTUTUuGZYUIu6kSqeJ9A3geSy6he4t5VzjwmEk/9jnYMXL0+
         nf2P9oqMJMSXA/YHhp6Z/VYeLX3qZ85ZsFW2vAhccLub7DfQXxr42q9LWGrcsySUwum2
         1VEPODCQupCMrfbLa5CPcGb0/+46fLMFlLAUPtGPyMckrrdzYU4IWM9dcsAjmQ9BY1WF
         yrGocxwQPpgOr0dhgcAotefeYhIsFfsrWbqt0S3hJzifkgz97YIxL/hiyLW0wp3doBkl
         eX4w==
X-Gm-Message-State: AOAM533+3eF9SBD8LrriqTQy0y6nGHmztXNlaOA7ps4h2J/uXqMZ9Osj
        WjS6rsJaTiEWUsd2uMozyFy6izpSAgTeXJ9Pqj01wEUbkBc=
X-Google-Smtp-Source: ABdhPJwRtIZHY3wCTjVotu8RJU6agYH5y0TMZvqd+F8xCo0IFURVQgDeTiKl13pHAm3ewj9J/bC17gecZJD3y2SuFPM=
X-Received: by 2002:a25:6d4:: with SMTP id 203mr36959670ybg.83.1638229617749;
 Mon, 29 Nov 2021 15:46:57 -0800 (PST)
MIME-Version: 1.0
References: <20211122144742.477787-1-memxor@gmail.com> <20211122144742.477787-4-memxor@gmail.com>
In-Reply-To: <20211122144742.477787-4-memxor@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 29 Nov 2021 15:46:46 -0800
Message-ID: <CAEf4BzbLGhxCAUbU-UFscuMub+kO3a=k=1fosR_Keobk=E4AQw@mail.gmail.com>
Subject: Re: [PATCH bpf v2 3/3] tools/resolve_btfids: Skip unresolved symbol
 warning for empty BTF sets
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 22, 2021 at 6:47 AM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> resolve_btfids prints a warning when it finds an unresolved symbol,
> (id == 0) in id_patch. This can be the case for BTF sets that are empty
> (due to disabled config options), hence printing warnings for certain
> builds, most recently seen in [0].
>
> The reason behind this is because id->cnt aliases id->id in btf_id

do we need to alias this, btw? We are trying to save 4 bytes on 800+
struct (addr[ADDR_CNT] is big) and instead are getting more confusion
in the code.

> struct, leading to empty set showing up as ID 0 when we get to id_patch,
> which triggers the warning. Since sets are an exception here, accomodate
> by reusing hole in btf_id for bool is_set member, setting it to true for
> BTF set when setting id->cnt, and use that to skip extraneous warning.
>
>   [0]: https://lore.kernel.org/all/1b99ae14-abb4-d18f-cc6a-d7e523b25542@gmail.com
>
> Before:
>
> ; ./tools/bpf/resolve_btfids/resolve_btfids -v -b vmlinux net/ipv4/tcp_cubic.ko
> adding symbol tcp_cubic_kfunc_ids
> WARN: resolve_btfids: unresolved symbol tcp_cubic_kfunc_ids
> patching addr     0: ID       0 [tcp_cubic_kfunc_ids]
> sorting  addr     4: cnt      0 [tcp_cubic_kfunc_ids]
> update ok for net/ipv4/tcp_cubic.ko
>
> After:
>
> ; ./tools/bpf/resolve_btfids/resolve_btfids -v -b vmlinux net/ipv4/tcp_cubic.ko
> adding symbol tcp_cubic_kfunc_ids
> patching addr     0: ID       0 [tcp_cubic_kfunc_ids]
> sorting  addr     4: cnt      0 [tcp_cubic_kfunc_ids]
> update ok for net/ipv4/tcp_cubic.ko
>
> Cc: Jiri Olsa <jolsa@kernel.org>

Jiri, can you please take a look as well?

> Fixes: 0e32dfc80bae ("bpf: Enable TCP congestion control kfunc from modules")
> Reported-by: Pavel Skripkin <paskripkin@gmail.com>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  tools/bpf/resolve_btfids/main.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
> index a59cb0ee609c..73409e27be01 100644
> --- a/tools/bpf/resolve_btfids/main.c
> +++ b/tools/bpf/resolve_btfids/main.c
> @@ -83,6 +83,7 @@ struct btf_id {
>                 int      cnt;
>         };
>         int              addr_cnt;
> +       bool             is_set;
>         Elf64_Addr       addr[ADDR_CNT];
>  };
>
> @@ -451,8 +452,10 @@ static int symbols_collect(struct object *obj)
>                          * in symbol's size, together with 'cnt' field hence
>                          * that - 1.
>                          */
> -                       if (id)
> +                       if (id) {
>                                 id->cnt = sym.st_size / sizeof(int) - 1;
> +                               id->is_set = true;
> +                       }
>                 } else {
>                         pr_err("FAILED unsupported prefix %s\n", prefix);
>                         return -1;
> @@ -568,9 +571,8 @@ static int id_patch(struct object *obj, struct btf_id *id)
>         int *ptr = data->d_buf;
>         int i;
>
> -       if (!id->id) {
> +       if (!id->id && !id->is_set)
>                 pr_err("WARN: resolve_btfids: unresolved symbol %s\n", id->name);
> -       }
>
>         for (i = 0; i < id->addr_cnt; i++) {
>                 unsigned long addr = id->addr[i];
> --
> 2.34.0
>
