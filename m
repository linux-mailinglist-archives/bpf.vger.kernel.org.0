Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D77768CC88
	for <lists+bpf@lfdr.de>; Tue,  7 Feb 2023 03:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjBGCXj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Feb 2023 21:23:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBGCXi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Feb 2023 21:23:38 -0500
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102BCF778;
        Mon,  6 Feb 2023 18:23:37 -0800 (PST)
Received: by mail-yb1-xb43.google.com with SMTP id x8so8472152ybt.13;
        Mon, 06 Feb 2023 18:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oasGFPSWMrpTNhbAhdcnL/rowDmuIn5jSJ0VHoLfVPE=;
        b=BOfHuCu+FMHtB1pZRGt7jnAnTgT+YMJdj1hi8i42yzZ0nW58lHSdYnjqnLB8eph7tv
         uJGGHiPfP44HmI0W3BgQSiNyfAoWgavF93aZszhue30DREAPXMgOwFbCYeAs1cm4sVuL
         7MHtrGGL0Qsp8j+3QS7sWOmlj4h2UwgkPMPFSGEO8mwPiVLf6kSjWxHoTpcyjS4XwFkL
         WAXlKVfkTF8B3RsIwY7tMG3ePtzK7xvMA+twG9W6/M+E1rYfy4N8+MH2X/L2aqnM6q+w
         scRCvMErt8notwkwpfgOF9DmV12Nx7Lkp9ONIePo+YhSE6j8zfK//10YI6UQlgACc0rM
         mshQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oasGFPSWMrpTNhbAhdcnL/rowDmuIn5jSJ0VHoLfVPE=;
        b=NGHSssnXkvSVbfJfXdUyBySWUWYlxWa4EO34F+319KFoi1Fopp/smkrdltkE+hWZ/d
         +AWbMz8CwIC+s3UdSNM0iop4HV7T9VP+ww0h2LiT5UE2d/pNouuVVqDz8gnRq9I6hxIe
         F26rsxezg+ZIDWDitwfmLwlHmOn67cVdDZlzGbs68fYcGHYt5S1HyKXMOhc8o13OcB6U
         5viPeQp2Jn8G0b78yYaMX/P21DZjM8CC0XxAguP6GSRDrdxPjYIaYabcDbTfAgp+ARvo
         e/Z17RVju5ixi+B3xTPtuoS7mH5BaY0ndWjzn7CXrbwmcJ4uzsrmdoZdxlW//7DGtnpV
         l0+Q==
X-Gm-Message-State: AO0yUKUgyw5yHfy6OuUnnsk1HQeCLEJtF9MrsVN5wtXpVBKXCYOyNA04
        dn/4QI+uLKeDVcQq2vIeKirFTKS7DEyluc/A+BE=
X-Google-Smtp-Source: AK7set8yf+oFf8zI8UK+suWtpbA2MSdFcT2IICuuSySGoTHuHYkTty1uBOCGbWUfrqBcUSdcKmbsBCad6F9k7+OEvMk=
X-Received: by 2002:a5b:ad2:0:b0:80b:c194:7d61 with SMTP id
 a18-20020a5b0ad2000000b0080bc1947d61mr258130ybr.26.1675736616215; Mon, 06 Feb
 2023 18:23:36 -0800 (PST)
MIME-Version: 1.0
References: <20230203031742.1730761-1-imagedong@tencent.com>
 <20230203031742.1730761-2-imagedong@tencent.com> <CAEf4Bzbig9DmCEJd0i64gA=jzczK7n=joqiD0MAa6sFSgd=WAw@mail.gmail.com>
In-Reply-To: <CAEf4Bzbig9DmCEJd0i64gA=jzczK7n=joqiD0MAa6sFSgd=WAw@mail.gmail.com>
From:   Menglong Dong <menglong8.dong@gmail.com>
Date:   Tue, 7 Feb 2023 10:23:24 +0800
Message-ID: <CADxym3ZwYNkmoECRQZZuprZuXoMJSiT2umCsC4gtsiPAb2dm6A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] libbpf: add support to set kprobe/uprobe
 attach mode
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     alan.maguire@oracle.com, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Menglong Dong <imagedong@tencent.com>
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

On Tue, Feb 7, 2023 at 3:59 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Feb 2, 2023 at 7:18 PM <menglong8.dong@gmail.com> wrote:
> >
> > From: Menglong Dong <imagedong@tencent.com>
> >
> > By default, libbpf will attach the kprobe/uprobe eBPF program in the
> > latest mode that supported by kernel. In this patch, we add the support
> > to let users manually attach kprobe/uprobe in legacy or perf mode.
> >
> > There are 3 mode that supported by the kernel to attach kprobe/uprobe:
> >
> >   LEGACY: create perf event in legacy way and don't use bpf_link
> >   PERF: create perf event with perf_event_open() and don't use bpf_link
> >   LINK: create perf event with perf_event_open() and use bpf_link
> >
> > Users now can manually choose the mode with
> > bpf_program__attach_uprobe_opts()/bpf_program__attach_kprobe_opts().
> >
> > Link: https://lore.kernel.org/bpf/20230113093427.1666466-1-imagedong@tencent.com/
> > Signed-off-by: Menglong Dong <imagedong@tencent.com>
> > ---
> >  tools/lib/bpf/libbpf.c | 26 +++++++++++++++++++++++++-
> >  tools/lib/bpf/libbpf.h | 19 ++++++++++++++++---
> >  2 files changed, 41 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index eed5cec6f510..0d20bf1ee301 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -9784,7 +9784,7 @@ struct bpf_link *bpf_program__attach_perf_event_opts(const struct bpf_program *p
> >         link->link.dealloc = &bpf_link_perf_dealloc;
> >         link->perf_event_fd = pfd;
> >
> > -       if (kernel_supports(prog->obj, FEAT_PERF_LINK)) {
> > +       if (kernel_supports(prog->obj, FEAT_PERF_LINK) && !opts->no_link) {
> >                 DECLARE_LIBBPF_OPTS(bpf_link_create_opts, link_opts,
> >                         .perf_event.bpf_cookie = OPTS_GET(opts, bpf_cookie, 0));
> >
> > @@ -10148,16 +10148,28 @@ bpf_program__attach_kprobe_opts(const struct bpf_program *prog,
> >         struct bpf_link *link;
> >         size_t offset;
> >         bool retprobe, legacy;
> > +       enum probe_mode mode;
> >         int pfd, err;
> >
> >         if (!OPTS_VALID(opts, bpf_kprobe_opts))
> >                 return libbpf_err_ptr(-EINVAL);
> >
> > +       mode = OPTS_GET(opts, mode, PROBE_MODE_DEFAULT);
> >         retprobe = OPTS_GET(opts, retprobe, false);
> >         offset = OPTS_GET(opts, offset, 0);
> >         pe_opts.bpf_cookie = OPTS_GET(opts, bpf_cookie, 0);
> >
> >         legacy = determine_kprobe_perf_type() < 0;
> > +       switch (mode) {
> > +       case PROBE_MODE_LEGACY:
> > +               legacy = true;
> > +       case PROBE_MODE_PERF:
> > +               pe_opts.no_link = true;
> > +               break;
> > +       default:
> > +               break;
> > +       }
> > +
> >         if (!legacy) {
> >                 pfd = perf_event_open_probe(false /* uprobe */, retprobe,
> >                                             func_name, offset,
> > @@ -10817,10 +10829,12 @@ bpf_program__attach_uprobe_opts(const struct bpf_program *prog, pid_t pid,
> >         int pfd, err;
> >         bool retprobe, legacy;
> >         const char *func_name;
> > +       enum probe_mode mode;
> >
> >         if (!OPTS_VALID(opts, bpf_uprobe_opts))
> >                 return libbpf_err_ptr(-EINVAL);
> >
> > +       mode = OPTS_GET(opts, mode, PROBE_MODE_DEFAULT);
> >         retprobe = OPTS_GET(opts, retprobe, false);
> >         ref_ctr_off = OPTS_GET(opts, ref_ctr_offset, 0);
> >         pe_opts.bpf_cookie = OPTS_GET(opts, bpf_cookie, 0);
> > @@ -10849,6 +10863,16 @@ bpf_program__attach_uprobe_opts(const struct bpf_program *prog, pid_t pid,
> >         }
> >
> >         legacy = determine_uprobe_perf_type() < 0;
> > +       switch (mode) {
> > +       case PROBE_MODE_LEGACY:
> > +               legacy = true;
> > +       case PROBE_MODE_PERF:
> > +               pe_opts.no_link = true;
> > +               break;
> > +       default:
> > +               break;
> > +       }
> > +
>
> I think this is a good place to also return errors early if, say, user
> requested LINK mode, but that mode is not supported by kernel. Instead
> of returning some -ENOTSUP generic error, we can error out early?
> Similar for PERF mode, if only legacy is supported, and so on. Similar
> for attach_uprobe, of course.
>

Yes, sounds great.

> >         if (!legacy) {
> >                 pfd = perf_event_open_probe(true /* uprobe */, retprobe, binary_path,
> >                                             func_offset, pid, ref_ctr_off);
> > diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> > index 8777ff21ea1d..7fb474e036a3 100644
> > --- a/tools/lib/bpf/libbpf.h
> > +++ b/tools/lib/bpf/libbpf.h
> > @@ -451,8 +451,10 @@ struct bpf_perf_event_opts {
> >         size_t sz;
> >         /* custom user-provided value fetchable through bpf_get_attach_cookie() */
> >         __u64 bpf_cookie;
> > +       /* don't use bpf_link when attach eBPF pprogram */
>
> typo: pprogram

Ops, get it!

>
> > +       bool no_link;
>
> I've been struggling with this "no_link" name a bit. It is quite
> confusing considering that from libbpf's API side we do return `struct
> bpf_link`. So I'm thinking that maybe "force_ioctl_attach" would be a
> better way to describe it (and will be scary enough for people not
> knowing what this is about to not set it to true?)
>

Yeah, "force_ioctl_attach" sounds more appropriate.

> Also, we'll need size_t: 0 at the end to avoid uninitialized padding
> issues (like we have in kprobe_opts and uprobe_opts)
>
> >  };
> > -#define bpf_perf_event_opts__last_field bpf_cookie
> > +#define bpf_perf_event_opts__last_field no_link
> >
> >  LIBBPF_API struct bpf_link *
> >  bpf_program__attach_perf_event(const struct bpf_program *prog, int pfd);
> > @@ -461,6 +463,13 @@ LIBBPF_API struct bpf_link *
> >  bpf_program__attach_perf_event_opts(const struct bpf_program *prog, int pfd,
> >                                     const struct bpf_perf_event_opts *opts);
> >
> > +enum probe_mode {
>
> shall we call it probe_attach_mode?
>
> also let's elaborate a bit more in doc comment that specifying mode
> will force libbpf to use that, but if kernel doesn't support it --
> then we'll error out.
>

OK.

> > +       PROBE_MODE_DEFAULT = 0, /* latest supported by kernel */
> > +       PROBE_MODE_LEGACY,
> > +       PROBE_MODE_PERF,
> > +       PROBE_MODE_LINK,
> > +};
> > +
> >  struct bpf_kprobe_opts {
> >         /* size of this struct, for forward/backward compatiblity */
> >         size_t sz;
> > @@ -470,9 +479,11 @@ struct bpf_kprobe_opts {
> >         size_t offset;
> >         /* kprobe is return probe */
> >         bool retprobe;
> > +       /* kprobe attach mode */
> > +       enum probe_mode mode;
>
> nit: mode -> attach_mode?
>
> >         size_t :0;
> >  };
> > -#define bpf_kprobe_opts__last_field retprobe
> > +#define bpf_kprobe_opts__last_field mode
> >
> >  LIBBPF_API struct bpf_link *
> >  bpf_program__attach_kprobe(const struct bpf_program *prog, bool retprobe,
> > @@ -570,9 +581,11 @@ struct bpf_uprobe_opts {
> >          * binary_path.
> >          */
> >         const char *func_name;
> > +       /* uprobe attach mode */
> > +       enum probe_mode mode;
> >         size_t :0;
> >  };
> > -#define bpf_uprobe_opts__last_field func_name
> > +#define bpf_uprobe_opts__last_field mode
>
> ditto
>

I'll fix these problems in the V2.

Thanks!
Menglong Dong

> >
> >  /**
> >   * @brief **bpf_program__attach_uprobe()** attaches a BPF program
> > --
> > 2.39.0
> >
