Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E618B283F80
	for <lists+bpf@lfdr.de>; Mon,  5 Oct 2020 21:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729319AbgJETVR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 5 Oct 2020 15:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgJETVQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 5 Oct 2020 15:21:16 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE76C0613CE
        for <bpf@vger.kernel.org>; Mon,  5 Oct 2020 12:21:16 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id s7so7389266qkh.11
        for <bpf@vger.kernel.org>; Mon, 05 Oct 2020 12:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=51bUXe4hXWLbOV3TYT9XpSYljKsinNrtDRnIo2tzTSg=;
        b=Fu9lPnL2uux5XQFr9sNcZsY2PAVJhaBrcF5h7GI3BBbPNj7iq+lPjGn+ow95F+EQTC
         HF21GCzBiiLQE+N/oH77RO5GqAKGxgBd8WoJl6LkYkZ4PlizJY1HOBtg8GtvJRQ+1qlg
         rs+P6l84vAQGa7fxZnzsiR9PGASmtt8OCQwdbaaXmWLu62z64UdqFMyY7DyGAsloyqVq
         sbGZpXKv6xIG8JfTZkYVZC7O1gcjaiFRXUcO5oEaUm1TJr+fIeYczE7AXTsYtlEKTWMe
         uOzzluc6HhGygF3VVsjy/gHVac0plgGmfZMY20CyqawTSHJe0JMuVXTG8cUH+9Ghe34o
         k6pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=51bUXe4hXWLbOV3TYT9XpSYljKsinNrtDRnIo2tzTSg=;
        b=Zpnqo4QqvDrN8ZCageU1CYZvUXxE1cIQZb3X3TR63135DD1PQrFDBX0NdsvXjHKu+s
         rspKFU2s1vVRAmxB3lINqqT8lBxRgvpyJqBk4DxRt0n0SZc3X6zZq4ErLD6HFXcUF27s
         NSYWWCNgUPK18c+AFqHHxz3gF4+anOcOGSmtPI7F46ddWphtoNCZiU+S7dG/CzZMQRKp
         sihRx2XyLnLT16E/2r1ZCd7+fs2r5FSH+HBcbZQPh7gYfxqTz/2lDdTeIZCYRwobngPg
         XN1CJmmbdQb7dwW8h2mmk1LkU4rnvBalyEM9decFXBTi5mAtKFr167shr36B6YXuJzL5
         07wA==
X-Gm-Message-State: AOAM533UMrnJe4QJtcw3NJFi/1VQG9oECiUKtzT/tGtmIucCH87PN8M4
        LgEYDs5631Gqlp6BNWOq7D0ecDUY2ignlBGiJ/g=
X-Google-Smtp-Source: ABdhPJwvRoEc4X2gaYqyclsgKIwP7KedjOm9APDIfVYVwzfknZzbjhrHUF+eCpFPtiYbXqdg8WzjQcMYOhaxiKTcVdQ=
X-Received: by 2002:a25:2596:: with SMTP id l144mr2040877ybl.510.1601925675938;
 Mon, 05 Oct 2020 12:21:15 -0700 (PDT)
MIME-Version: 1.0
References: <20201005163934.331875-1-lrizzo@google.com>
In-Reply-To: <20201005163934.331875-1-lrizzo@google.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 5 Oct 2020 12:21:05 -0700
Message-ID: <CAEf4BzZq8t0XZy5Z6SBHAURJBxuDBPdU9amsJ0z0os7TE-cjoQ@mail.gmail.com>
Subject: Re: [PATCH v2] use valid btf in bpf_program__set_attach_target(prog,
 0, ...);
To:     Luigi Rizzo <lrizzo@google.com>
Cc:     bpf <bpf@vger.kernel.org>, Eelco Chaudron <echaudro@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Petar Penkov <ppenkov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 5, 2020 at 9:40 AM Luigi Rizzo <lrizzo@google.com> wrote:
>
> bpf_program__set_attach_target() will always fail with fd=0 (attach to a
> kernel symbol) because obj->btf_vmlinux is NULL and there is no way to
> set it.
>
> Fix this by using libbpf_find_vmlinux_btf_id()
>
> (on a side note: it is unclear whether btf_vmlinux is meant to be
> just temporary storage for use in bpf_object__load_xattr(), or
> a property of bpf_object, in which case it could be initialuzed
> opportunistically, and properly released in bpf_object__close() ).

It's more of a former. vmlinux BTF shouldn't be needed past
bpf_object's load phase, so there is no need to keep a few megabytes
of memory laying around needlessly.

>
> Signed-off-by: Luigi Rizzo <lrizzo@google.com>
> ---
>  tools/lib/bpf/libbpf.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index a4f55f8a460d..33bf102259dd 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -10353,9 +10353,8 @@ int bpf_program__set_attach_target(struct bpf_program *prog,
>                 btf_id = libbpf_find_prog_btf_id(attach_func_name,
>                                                  attach_prog_fd);
>         else
> -               btf_id = __find_vmlinux_btf_id(prog->obj->btf_vmlinux,
> -                                              attach_func_name,
> -                                              prog->expected_attach_type);
> +               btf_id = libbpf_find_vmlinux_btf_id(attach_func_name,
> +                                                   prog->expected_attach_type);

It's a bit inefficient, if you need to do this for a few programs, but
it's ok as a fix. We'll need to unify this internal vmlinux BTF
caching at some point.

Acked-by: Andrii Nakryiko <andriin@fb.com>


>
>         if (btf_id < 0)
>                 return btf_id;
> --
> 2.28.0.806.g8561365e88-goog
>
