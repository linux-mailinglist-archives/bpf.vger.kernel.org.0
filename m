Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06E3846A8C3
	for <lists+bpf@lfdr.de>; Mon,  6 Dec 2021 21:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349787AbhLFUsa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Dec 2021 15:48:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238973AbhLFUs3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Dec 2021 15:48:29 -0500
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41AF6C061746
        for <bpf@vger.kernel.org>; Mon,  6 Dec 2021 12:45:00 -0800 (PST)
Received: by mail-ua1-x930.google.com with SMTP id t13so22206327uad.9
        for <bpf@vger.kernel.org>; Mon, 06 Dec 2021 12:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H1IWrexvZzmC3OlHyCwu3L3FMnddBhp4Xgye3o5A3H8=;
        b=hQ+e8FVIFV4Em2HYS7NsvKAG5GvpM3i5W8e4qyJA0UVDhVnO9BAWniqKbWlxO1lO18
         Kk/73Tj3k+DGd9OxJ73zMA/NY1N0vcUlidfir/894cwTl+X4PfE6ZZkkYek/38/bA3zC
         +/wawsAEI4Lu8PW0XHmSCQJtiqWupQNjvRoYPNWJWjOgVBYY5pE70+eKvpY/VJHEVQ21
         169NI9g6CFPtfPIOlobCFn9PXuvDUAane4LWxN4qVDTY6RjXV28i+Z1YbyJ8A0+xG4rZ
         I+Pv0Pco6uuSQzk5bTf2+O4dA+lSpaQmD13XbXLkEjkJZlDrMq4Nc/zfFwgW0TexqLmm
         MgNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H1IWrexvZzmC3OlHyCwu3L3FMnddBhp4Xgye3o5A3H8=;
        b=LfDk+11AIH8g3qPDBIjyx9VRl+IXEmFgmby5hweuCItLmL0C3rGYcrlRmVEY45GjXf
         SKqqxxWoKEYW15h14ng6/UeKbrdE9uFuGh2kzTCL9/wLjKgwjRdbVYLp038xS7dUcFJC
         c1jdSYJU+Zi+xoJWGg3B5nsTO8kyIzUQ0fOVuZMVmpmTWOpELvcoMnEJ3hBtONSsZrX0
         oySmgSTmwE+vLpnHNUm1hG4Mm5Hq8KspRxXY+/HYs7XgXGmG9E4siHSWZB7tYPPYbirc
         RIWt7bRwn/ygMSd4LulSf7dVwIPALCvl+k5IUmpe+3RtwJze4LLAEEyXICVKYnqnwji0
         qgeg==
X-Gm-Message-State: AOAM532zwT0ysUpmFZ3cx1DYpVjwZZfzGvOlBwuB6v+g1waP5E7E8X52
        gVdgmSFgrYi/hqvV/KeFe4oNVuE+6pbmQ0yPQ4c=
X-Google-Smtp-Source: ABdhPJxB0xdkJzPAyWnBflk33/0gYgpcWb2jwd2jbAlt/UDcvN4b/3MK2Jf8Vsh5Dh+yP35nI3cwcb3q5pnEZy2gejQ=
X-Received: by 2002:a05:6102:3ec9:: with SMTP id n9mr39381908vsv.67.1638823499189;
 Mon, 06 Dec 2021 12:44:59 -0800 (PST)
MIME-Version: 1.0
References: <20211127210200.1104120-1-grantseltzer@gmail.com>
 <CAPhsuW6+LiLZf0SsGbOT+2BNHGB28TZazoEELwb6anbo5_mLPQ@mail.gmail.com> <CAEf4BzZa=xFdsWwqt0u_4u0jSwJErGUTcfXiswMWof=XnruK1g@mail.gmail.com>
In-Reply-To: <CAEf4BzZa=xFdsWwqt0u_4u0jSwJErGUTcfXiswMWof=XnruK1g@mail.gmail.com>
From:   Grant Seltzer Richman <grantseltzer@gmail.com>
Date:   Mon, 6 Dec 2021 15:44:47 -0500
Message-ID: <CAO658oX9p9pq1cbH0b29Mxp2ocPPVev7jdk3EP3r3EPCQh76vA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Add doc comments in libb.h
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Song Liu <song@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 29, 2021 at 6:32 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Sat, Nov 27, 2021 at 1:28 PM Song Liu <song@kernel.org> wrote:
> >
> > On Sat, Nov 27, 2021 at 1:04 PM grantseltzer <grantseltzer@gmail.com> wrote:
> > >
> > > From: Grant Seltzer <grantseltzer@gmail.com>
> > >
> > > This adds comments above functions in libbpf.h which document
> > > their uses. These comments are of a format that doxygen and sphinx
> > > can pick up and render. These are rendered by libbpf.readthedocs.org
> > >
> > > These doc comments are for:
> > >
> > > - bpf_object__open_file()
> > > - bpf_object__open_mem()
> > > - bpf_program__attach_uprobe()
> > > - bpf_program__attach_uprobe_opts()
> > >
> > > Signed-off-by: Grant Seltzer <grantseltzer@gmail.com>
> >
> > s/libb.h/libbpf.h/ in subject
> >
> > > ---
> > >  tools/lib/bpf/libbpf.h | 45 ++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 45 insertions(+)
> > >
> > > diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> > > index 4ec69f224342..acfb207e71d1 100644
> > > --- a/tools/lib/bpf/libbpf.h
> > > +++ b/tools/lib/bpf/libbpf.h
> > > @@ -108,8 +108,26 @@ struct bpf_object_open_opts {
> > >  #define bpf_object_open_opts__last_field btf_custom_path
> > >
> > >  LIBBPF_API struct bpf_object *bpf_object__open(const char *path);
> > > +
> > > +/**
> > > + * @brief **bpf_object__open_file()** creates a bpf_object by opening
> > > + * the BPF object file pointed to by the passed path and loading it
>
> Would be nice to mention that it's ELF, no? "BPF ELF object file", maybe?
>
> > > + * into memory.
> > > + * @param path BPF object file relative or absolute path
>
> I started worrying about relative vs absolute paths after reading this
> :) I think just stating "BPF object file path" should be totally fine.
> Relative vs absolute works totally fine as expected with any API that
> accepts file paths.
>
>
> > > + * @param opts options for how to load the bpf object
>
> let's mention that opts are optional (i.e., you can pass NULL)
>
> > > + * @return pointer to the new bpf_object
> >
> > Please document return value on errors, i.e. libbpf_err_ptr(err)
> > instead of NULL. Same for all functions here.
>
> With libbpf 1.0 and forward APIs like this will return NULL on error,
> so let's use that as the convention in documentation. So something
> like "NULL is returned on error, error code is stored in errno"?
>
> >
> > > + */
> > >  LIBBPF_API struct bpf_object *
> > >  bpf_object__open_file(const char *path, const struct bpf_object_open_opts *opts);
> > > +
> > > +/**
> > > + * @brief **bpf_object__open_mem()** creates a bpf_object by reading
> > > + * the BPF objects raw bytes from an in memory buffer.
>
> typo: "an in"? Also it's even more important to mention that those
> bytes should be a valid BPF ELF object file?
>
> > > + * @param obj_buf pointer to the buffer containing bpf object bytes
>
> s/bpf object bytes/ELF file bytes/ ?
>
> > > + * @param obj_buf_sz number of bytes in the buffer
> > > + * @param opts options for how to load the bpf object
> > > + * @return pointer to the new bpf_object
> > > + */
> > >  LIBBPF_API struct bpf_object *
> > >  bpf_object__open_mem(const void *obj_buf, size_t obj_buf_sz,
> > >                      const struct bpf_object_open_opts *opts);
> > > @@ -344,10 +362,37 @@ struct bpf_uprobe_opts {
> > >  };
> > >  #define bpf_uprobe_opts__last_field retprobe
> > >
> > > +/**
> > > + * @brief **bpf_program__attach_uprobe** attaches a BPF program
>
> missing () after attach_uprobe
>
> > > + * to the userspace function which is found by binary path and
> > > + * offset. You can optionally specify a particular proccess to attach
> > s/proccess/process/
> >
> > > + * to. You can also optionally attach the program to the function
> > > + * exit instead of entry.
> > > + *
> > > + * @param prog BPF program to attach
> > > + * @param retprobe Attach to function exit
> > > + * @param pid Process ID to attach the uprobe to, -1 for all processes
>
> There is also 0 for self (own process).
>
> > > + * @param binary_path Path to binary that contains the function symbol
> > > + * @param func_offset Offset within the binary of the function symbol
> > > + * @return Reference to the newly created BPF link
>
> or NULL on error (errno is set to error code).
>
> > > + */
> > >  LIBBPF_API struct bpf_link *
> > >  bpf_program__attach_uprobe(const struct bpf_program *prog, bool retprobe,
> > >                            pid_t pid, const char *binary_path,
> > >                            size_t func_offset);
> > > +
> > > +/**
> > > + * @brief **bpf_program__attach_uprobe_opts** is just like
>
> () missing
>
> > > + * bpf_program__attach_uprobe except with a options struct
>
> (), let's use that around referenced to functions to make it clear
>
> > > + * for various configurations.
> > > + *
> > > + * @param prog BPF program to attach
> > > + * @param pid Process ID to attach the uprobe to, -1 for all processes
> > > + * @param binary_path Path to binary that contains the function symbol
> > > + * @param func_offset Offset within the binary of the function symbol
> > > + * @param opts Options for altering program attachment
> >
> > Let's also document details about these options.
>
> yep, but on uprobe_opts struct itself

I need to fix something with the configuration, the docs site
currently isn't displaying structs.

Also I haven't forgotten about adding a check for libbpf docs
generating properly. I'm working on a patch that I'll submit to the
docs tree allowing `make htmldocs` to take an argument for which
subsection to exclusively build.

>
>
> >
> > > + * @return Reference to the newly created BPF link
> > > + */
> > >  LIBBPF_API struct bpf_link *
> > >  bpf_program__attach_uprobe_opts(const struct bpf_program *prog, pid_t pid,
> > >                                 const char *binary_path, size_t func_offset,
> > > --
> > > 2.31.1
> > >
