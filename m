Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD3F283CAB
	for <lists+bpf@lfdr.de>; Mon,  5 Oct 2020 18:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgJEQlU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 5 Oct 2020 12:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbgJEQlU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 5 Oct 2020 12:41:20 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4DEC0613CE
        for <bpf@vger.kernel.org>; Mon,  5 Oct 2020 09:41:19 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id z19so11695825lfr.4
        for <bpf@vger.kernel.org>; Mon, 05 Oct 2020 09:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SZP5VLtuj3ug+wnOoozQeQ1QbBvGkeKOMlMpQjHEAfU=;
        b=mpYMNH7YC487pNrow/xu5tfAiGIfLcI0qDbxPigNTk+1xfc0aj5I7IfK+7yMmLwpQC
         A9NytTQRgU0HvwViwqfzb3Oj9UcSOyrkmipuL8o4EnCmX5s9dqwO9DYbSAEWXIZVUwQr
         k7dtTWCr79JAkvh6q4HbHZvG18/Y9VaIrM+/C6oohNE3Onw9wwAPzf2Ill8zt1MF57sw
         sLj2MmOOaIC+lLo1TXFS0SR2ZuNjQcEo6w/Q+wQWI95CPvnPM/MPiBEmjE+rfCzocYwT
         lP+9rtyVbZDBvjPSsE93zvH7Qp192tMwFZsln+JGXt/Y6PUborbYZdNDnguue4Bj/dox
         MIxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SZP5VLtuj3ug+wnOoozQeQ1QbBvGkeKOMlMpQjHEAfU=;
        b=THf5RIPYD6uXix0HgHuzv9vTiCj5kkG3StITOA/1YEHqG9OfoYYeeSEkwSYj86tF+D
         j+iqcpODwzStCU4FkQ+I5DLo8lhoFVQ6LdWUZos/0vdEBJPKW1ElSknS8Dg1O50EnB5l
         zHT3qm0SxZ4LANC+TzOTbzoLcwgWtW3P0k30JY5DlVEUp3ysaaoAuWN8skW8c7C03VHA
         jXAyJkP/wj+eIYgZi1u027c5uIGS5KbTOrHH+gXgFGkGnjWyJbPbVim3GdXLIYr9S08z
         z+j27wxTjB4vcBl7mu83O68hgs4T7e9LhVGGt3C9k67FaVfGDRMBnlfeEweREe7MBDM1
         4FwA==
X-Gm-Message-State: AOAM531ZSJL8V40jgxYegT7mc/pUpW4V8uHXzWE5PNXGe2XpYyKjV0Nc
        puMWuh0H6YLes37kmCxXo/vLTIF9slyuPRb1QS3fbA==
X-Google-Smtp-Source: ABdhPJyDDNblvUOoGQF1ZPJJjBGzaXQB5qriRubfAmEUQTy2ee7O4PdWk29bycb0NZA28soR+hCMS+bdqUFMoNXisec=
X-Received: by 2002:a19:8488:: with SMTP id g130mr111712lfd.424.1601916077762;
 Mon, 05 Oct 2020 09:41:17 -0700 (PDT)
MIME-Version: 1.0
References: <20201005134100.302271-1-lrizzo@google.com> <102ef3d8-e9fa-24c6-af96-b0d62ccf57c2@fb.com>
In-Reply-To: <102ef3d8-e9fa-24c6-af96-b0d62ccf57c2@fb.com>
From:   Luigi Rizzo <lrizzo@google.com>
Date:   Mon, 5 Oct 2020 18:41:06 +0200
Message-ID: <CAMOZA0JgFMEUyERce3VizCa965Aj14xRHgJheD-8U5oTudYAJA@mail.gmail.com>
Subject: Re: [PATCH] use valid btf in bpf_program__set_attach_target(prog, 0, ...);
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Eelco Chaudron <echaudro@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Petar Penkov <ppenkov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 5, 2020 at 6:04 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 10/5/20 6:41 AM, Luigi Rizzo wrote:
> > bpf_program__set_attach_target() will always fail with fd=0 (attach to a
> > kernel symbol) because obj->btf_vmlinux is NULL and there is no way to
> > set it.
> >
> > Fix this by explicitly calling libbpf_find_kernel_btf() in the function.
> >
> > Signed-off-by: Luigi Rizzo <lrizzo@google.com>
> > ---
> >   tools/lib/bpf/libbpf.c | 9 ++++++---
> >   1 file changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index a4f55f8a460d..3a63db86666f 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -10352,10 +10352,13 @@ int bpf_program__set_attach_target(struct bpf_program *prog,
> >       if (attach_prog_fd)
> >               btf_id = libbpf_find_prog_btf_id(attach_func_name,
> >                                                attach_prog_fd);
> > -     else
> > -             btf_id = __find_vmlinux_btf_id(prog->obj->btf_vmlinux,
> > -                                            attach_func_name,
> > +     else {
> > +             struct btf *btf = libbpf_find_kernel_btf();
> > +
> > +             btf_id = __find_vmlinux_btf_id(btf, attach_func_name,
> >                                              prog->expected_attach_type);
> > +             btf__free(btf);
> > +     }
>
> Doesn't feel this is right fix. In libbpf, we have API function
>     libbpf_find_vmlinux_btf_id
> just doing the above.

nice, that makes the fix even simpler, will post an update:

-               btf_id = __find_vmlinux_btf_id(prog->obj->btf_vmlinux,
+               btf_id = libbpf_find_vmlinux_btf_id(attach_func_name,

>
> Also, could you point out why btf_vmlinux is NULL? Is this related
> to fd = 0? We probably
> should fix the problem there since what if other API functions
> like bpf_program__set_attach_target() wants btf_vmlinux. We should
> not duplicate this logic to other API functions.

As I mentioned in a previous post, I don't know how btf_vmlinux is
meant to be used. To me it looks more like temporary storage for use
in bpf_object__load_xattr() than a property of bpf_object
(in that case it should be released in bpf_object__close() ).

I'd probably fix the current bug now, and wait for the original
author to communicate the intent and decide on followup changes.

thanks
luigi
