Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D166A46284C
	for <lists+bpf@lfdr.de>; Tue, 30 Nov 2021 00:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbhK2Xfu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Nov 2021 18:35:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231734AbhK2Xfu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Nov 2021 18:35:50 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58938C061574
        for <bpf@vger.kernel.org>; Mon, 29 Nov 2021 15:32:32 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id 131so47047414ybc.7
        for <bpf@vger.kernel.org>; Mon, 29 Nov 2021 15:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bj8i2c/cNVse3r570Tfmch9hehb6lP78+VAK/92ECyA=;
        b=YRsTrSkfFxE+2fb5K3hVkTE9h8Ri4udrPMNs0KWrYfZ2FwIGmZE6ZiEjweOaADHQbM
         Q95ktoiPyQusrdC82n7yQe2pGXQXdpbFEA5OSUr1GCDvIirDPDi424lB0B0A3Y6GZ/63
         TobvFB86YzR8N9HLOmp+z0Rhu/HiXPrKdvjXhUiVNlhgMppjuiTJ4fK1xBGPVfTJzD3E
         uOWksH18Yp8VtWfo2OWPez6pTSs0hRZa64Y9m7b76DBaUKykVPNZ+XFzFGBS9/Ue1xVZ
         XaIVkygLPDC+HYpzYWenD4PXoZ0YrcZu7OpKJV0nGu+EzCahcf9pftWkH86DUze9RuYO
         MMMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bj8i2c/cNVse3r570Tfmch9hehb6lP78+VAK/92ECyA=;
        b=av32vjFM76otBaayFanEdpirlkUQ+y32tiSjfJFGxNWJdsYD9hDg2biBokx59d9+i3
         yFG6qPi697FcxdKptTPYhl1oVH/La9LfVwKP+uSvBtauDrehVwJgV745m1m+relxIOrJ
         h9Vql6KonRhSktFsbXSOgKyyVRvN8MkbJlQLSSywIF0dQH/WhwrTiXMqI57QGlJWkTtj
         WALHJgSTN9BouyGRGJE8Pw29qLbZXbs6CXSVK4iS343QRfpT3Ubds+KnvjL/BwGy+fXh
         Iw95Sm9iQ1+K7SmuCjZEYRhgn6BLwgsIJLJeeA2luScBmThsZCCeyvGBgK2RJFzo0PrC
         ZAZA==
X-Gm-Message-State: AOAM530x84cihn+438JsTW7CgPFi6aTlI+G0wG6j7nFPSw8BdmZB39oV
        b+2MqrJ0mwhF/nVsFbakxnX6ac7LzAnpHd99nQE=
X-Google-Smtp-Source: ABdhPJzdhsi894dTgfPXxIzAH8Pc73NP6S0y5XXUJdisn3kBc7ROeS3W5zN1NlCMiFyGr4wdB7cUBO7OupZyD1z+ybk=
X-Received: by 2002:a25:b204:: with SMTP id i4mr38308645ybj.263.1638228751469;
 Mon, 29 Nov 2021 15:32:31 -0800 (PST)
MIME-Version: 1.0
References: <20211127210200.1104120-1-grantseltzer@gmail.com> <CAPhsuW6+LiLZf0SsGbOT+2BNHGB28TZazoEELwb6anbo5_mLPQ@mail.gmail.com>
In-Reply-To: <CAPhsuW6+LiLZf0SsGbOT+2BNHGB28TZazoEELwb6anbo5_mLPQ@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 29 Nov 2021 15:32:20 -0800
Message-ID: <CAEf4BzZa=xFdsWwqt0u_4u0jSwJErGUTcfXiswMWof=XnruK1g@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Add doc comments in libb.h
To:     Song Liu <song@kernel.org>
Cc:     grantseltzer <grantseltzer@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Nov 27, 2021 at 1:28 PM Song Liu <song@kernel.org> wrote:
>
> On Sat, Nov 27, 2021 at 1:04 PM grantseltzer <grantseltzer@gmail.com> wrote:
> >
> > From: Grant Seltzer <grantseltzer@gmail.com>
> >
> > This adds comments above functions in libbpf.h which document
> > their uses. These comments are of a format that doxygen and sphinx
> > can pick up and render. These are rendered by libbpf.readthedocs.org
> >
> > These doc comments are for:
> >
> > - bpf_object__open_file()
> > - bpf_object__open_mem()
> > - bpf_program__attach_uprobe()
> > - bpf_program__attach_uprobe_opts()
> >
> > Signed-off-by: Grant Seltzer <grantseltzer@gmail.com>
>
> s/libb.h/libbpf.h/ in subject
>
> > ---
> >  tools/lib/bpf/libbpf.h | 45 ++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 45 insertions(+)
> >
> > diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> > index 4ec69f224342..acfb207e71d1 100644
> > --- a/tools/lib/bpf/libbpf.h
> > +++ b/tools/lib/bpf/libbpf.h
> > @@ -108,8 +108,26 @@ struct bpf_object_open_opts {
> >  #define bpf_object_open_opts__last_field btf_custom_path
> >
> >  LIBBPF_API struct bpf_object *bpf_object__open(const char *path);
> > +
> > +/**
> > + * @brief **bpf_object__open_file()** creates a bpf_object by opening
> > + * the BPF object file pointed to by the passed path and loading it

Would be nice to mention that it's ELF, no? "BPF ELF object file", maybe?

> > + * into memory.
> > + * @param path BPF object file relative or absolute path

I started worrying about relative vs absolute paths after reading this
:) I think just stating "BPF object file path" should be totally fine.
Relative vs absolute works totally fine as expected with any API that
accepts file paths.


> > + * @param opts options for how to load the bpf object

let's mention that opts are optional (i.e., you can pass NULL)

> > + * @return pointer to the new bpf_object
>
> Please document return value on errors, i.e. libbpf_err_ptr(err)
> instead of NULL. Same for all functions here.

With libbpf 1.0 and forward APIs like this will return NULL on error,
so let's use that as the convention in documentation. So something
like "NULL is returned on error, error code is stored in errno"?

>
> > + */
> >  LIBBPF_API struct bpf_object *
> >  bpf_object__open_file(const char *path, const struct bpf_object_open_opts *opts);
> > +
> > +/**
> > + * @brief **bpf_object__open_mem()** creates a bpf_object by reading
> > + * the BPF objects raw bytes from an in memory buffer.

typo: "an in"? Also it's even more important to mention that those
bytes should be a valid BPF ELF object file?

> > + * @param obj_buf pointer to the buffer containing bpf object bytes

s/bpf object bytes/ELF file bytes/ ?

> > + * @param obj_buf_sz number of bytes in the buffer
> > + * @param opts options for how to load the bpf object
> > + * @return pointer to the new bpf_object
> > + */
> >  LIBBPF_API struct bpf_object *
> >  bpf_object__open_mem(const void *obj_buf, size_t obj_buf_sz,
> >                      const struct bpf_object_open_opts *opts);
> > @@ -344,10 +362,37 @@ struct bpf_uprobe_opts {
> >  };
> >  #define bpf_uprobe_opts__last_field retprobe
> >
> > +/**
> > + * @brief **bpf_program__attach_uprobe** attaches a BPF program

missing () after attach_uprobe

> > + * to the userspace function which is found by binary path and
> > + * offset. You can optionally specify a particular proccess to attach
> s/proccess/process/
>
> > + * to. You can also optionally attach the program to the function
> > + * exit instead of entry.
> > + *
> > + * @param prog BPF program to attach
> > + * @param retprobe Attach to function exit
> > + * @param pid Process ID to attach the uprobe to, -1 for all processes

There is also 0 for self (own process).

> > + * @param binary_path Path to binary that contains the function symbol
> > + * @param func_offset Offset within the binary of the function symbol
> > + * @return Reference to the newly created BPF link

or NULL on error (errno is set to error code).

> > + */
> >  LIBBPF_API struct bpf_link *
> >  bpf_program__attach_uprobe(const struct bpf_program *prog, bool retprobe,
> >                            pid_t pid, const char *binary_path,
> >                            size_t func_offset);
> > +
> > +/**
> > + * @brief **bpf_program__attach_uprobe_opts** is just like

() missing

> > + * bpf_program__attach_uprobe except with a options struct

(), let's use that around referenced to functions to make it clear

> > + * for various configurations.
> > + *
> > + * @param prog BPF program to attach
> > + * @param pid Process ID to attach the uprobe to, -1 for all processes
> > + * @param binary_path Path to binary that contains the function symbol
> > + * @param func_offset Offset within the binary of the function symbol
> > + * @param opts Options for altering program attachment
>
> Let's also document details about these options.

yep, but on uprobe_opts struct itself

>
> > + * @return Reference to the newly created BPF link
> > + */
> >  LIBBPF_API struct bpf_link *
> >  bpf_program__attach_uprobe_opts(const struct bpf_program *prog, pid_t pid,
> >                                 const char *binary_path, size_t func_offset,
> > --
> > 2.31.1
> >
