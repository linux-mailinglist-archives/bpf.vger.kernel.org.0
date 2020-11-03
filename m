Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 818AA2A500A
	for <lists+bpf@lfdr.de>; Tue,  3 Nov 2020 20:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729651AbgKCTXp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Nov 2020 14:23:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbgKCTXp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 Nov 2020 14:23:45 -0500
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5277CC0613D1;
        Tue,  3 Nov 2020 11:23:45 -0800 (PST)
Received: by mail-yb1-xb44.google.com with SMTP id o70so15861970ybc.1;
        Tue, 03 Nov 2020 11:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C7lgMRvIUHR5p8yMdbB2MH/zQ/6uk2A8yuT6YzM41C4=;
        b=C83cHNNdtXvSpRkXpdzOe/cldvI/Csu72hXxZV7UKlJDdSfIfiVkzrIygZoy4BATXJ
         gD14QVm6J8doInHfZHMpiyVGP3M1N6DEo9ZoEfj3dNXT9LOGBwf/+yh968fDr5uBse2G
         xCRqoga+pXRo+ZykTVxt1K4dH+sb5jkxeA49cyvif8tM4Qbuge6+wz0q4K6eEWXhQsW9
         fkh+ol0eXZBSubtkwhzcX2xUg71Xx8tmr3zkKLCX6vRM5QhvSf5hCL1lS/TjRPYr9AiA
         v0QkVlMJHSr77Cozg1VWP3kNgx/GMXmwY2acbsIKwQsjBjhJ4dYADDxoOHEMbU6b0ihe
         v86w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C7lgMRvIUHR5p8yMdbB2MH/zQ/6uk2A8yuT6YzM41C4=;
        b=PSh4s0JGkv2lAJZtgYR91AWYVrd0R4bcTI8wnVVoTGCRIxcp1SU0gLonPxsCjT1A4L
         uyvlMgm51GWuud/IqlxO9TKoH0CO8ETMtjZAISNiQmecAkDDk8DBU9MQEdjv5eWBYEBP
         xbgbBtjJsQzUdIXcCzmJrFJuToTTRS8yIWbkY8+/gXjkM+UAQitDvEIHabO79tmlmZWp
         tWfnjg4VG52/5oc4mNCbziQO2V/fIUkVgYhCwHUx7qQQie9Oi92VFOx3NEsQiHwccqE8
         +XemkdWrPiDJ18OQUgyYSZzquhUnP57sMNvP0EqBFsW0WOh5T/zxaKOFSCSdbcNsq5R9
         Jf+Q==
X-Gm-Message-State: AOAM531O/RdU7rMuW1fGvszfH8qmo3jmneM8cvwxTdZWIZ3cyPNqzJRj
        3FYqI8DDce8Eapfv3ZuW758mmIeI/ZBQ93ctSwo=
X-Google-Smtp-Source: ABdhPJwVvHEij/rmY9uFiyPXDwjxlvB0/bNVxNd2e7/7thpurnMLJzRc5EbTjotWYEm8yZ14daBOKQhefh+GDCZR+0M=
X-Received: by 2002:a25:cb10:: with SMTP id b16mr30210282ybg.459.1604431424628;
 Tue, 03 Nov 2020 11:23:44 -0800 (PST)
MIME-Version: 1.0
References: <20201031223131.3398153-1-jolsa@kernel.org> <20201031223131.3398153-3-jolsa@kernel.org>
 <20201102215908.GC3597846@krava> <20201102225658.GD3597846@krava>
 <CAEf4BzbdGwogFQiLE2eH9ER67hne7NgW4S8miYBM4CRb8NDPvg@mail.gmail.com> <20201103190559.GI3597846@krava>
In-Reply-To: <20201103190559.GI3597846@krava>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 3 Nov 2020 11:23:33 -0800
Message-ID: <CAEf4BzbMOzAdsyMT736idoGnJ1RuxRa5y9wf-egh+LKz406m1g@mail.gmail.com>
Subject: Re: [PATCH 2/2] btf_encoder: Change functions check due to broken dwarf
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Mark Wielaard <mjw@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 3, 2020 at 11:06 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Tue, Nov 03, 2020 at 10:58:58AM -0800, Andrii Nakryiko wrote:
> > On Mon, Nov 2, 2020 at 2:57 PM Jiri Olsa <jolsa@redhat.com> wrote:
> > >
> > > On Mon, Nov 02, 2020 at 10:59:08PM +0100, Jiri Olsa wrote:
> > > > On Sat, Oct 31, 2020 at 11:31:31PM +0100, Jiri Olsa wrote:
> > > > > We need to generate just single BTF instance for the
> > > > > function, while DWARF data contains multiple instances
> > > > > of DW_TAG_subprogram tag.
> > > > >
> > > > > Unfortunately we can no longer rely on DW_AT_declaration
> > > > > tag (https://gcc.gnu.org/bugzilla/show_bug.cgi?id=97060)
> > > > >
> > > > > Instead we apply following checks:
> > > > >   - argument names are defined for the function
> > > > >   - there's symbol and address defined for the function
> > > > >   - function is generated only once
> > > > >
> > > > > Also because we want to follow kernel's ftrace traceable
> > > > > functions, this patchset is adding extra check that the
> > > > > function is one of the ftrace's functions.
> > > > >
> > > > > All ftrace functions addresses are stored in vmlinux
> > > > > binary within symbols:
> > > > >   __start_mcount_loc
> > > > >   __stop_mcount_loc
> > > >
> > > > hum, for some reason this does not pass through bpf internal
> > > > functions like bpf_iter_bpf_map.. I learned it hard way ;-)
> >
> > what's the exact name of the function that was missing?
> > bpf_iter_bpf_map doesn't exist. And if it's __init function, why does
> > it matter, it's not going to be even available at runtime, right?
> >
>
> bpf_map iter definition:
>
> DEFINE_BPF_ITER_FUNC(bpf_map, struct bpf_iter_meta *meta, struct bpf_map *map)
>
> goes to:
>
> #define DEFINE_BPF_ITER_FUNC(target, args...)                   \
>         extern int bpf_iter_ ## target(args);                   \
>         int __init bpf_iter_ ## target(args) { return 0; }
>
> that creates __init bpf_iter_bpf_map function that will make
> it into BTF where it's expected when opening iterator, but the
> code will be freed because it's __init function

hm... should we just drop __init there?

Yonghong, is __init strictly necessary, or was just an optimization to
save a tiny bit of space?

>
> there are few iteratos functions like that, and I was going to
> check if there's more
>
> >
> > > > will check
> > >
> > > so it gets filtered out because it's __init function
> > > I'll check if the fix below catches all internal functions,
> > > but I guess we should do something more robust
> > >
> > > jirka
> > >
> > >
> > > ---
> > > diff --git a/btf_encoder.c b/btf_encoder.c
> > > index 0a378aa92142..3cd94280c35b 100644
> > > --- a/btf_encoder.c
> > > +++ b/btf_encoder.c
> > > @@ -143,7 +143,8 @@ static int filter_functions(struct btf_elf *btfe, struct mcount_symbols *ms)
> > >                 /* Do not enable .init section functions. */
> > >                 if (init_filter &&
> > >                     func->addr >= ms->init_begin &&
> > > -                   func->addr <  ms->init_end)
> > > +                   func->addr <  ms->init_end &&
> > > +                   strncmp("bpf_", func->name, 4))
> >
> > this looks like a very wrong way to do this? Can you please elaborate
> > on what's missing and why it shouldn't be missing?
>
> yes, it's just a hack, we should do something more
> robust as I mentioned above
>
> it just allowed me to use iterators finaly ;-)

sure, I get it, I was just trying to understand why there is such a
problem in the first place. Turns out we need FUNCs not just for
fentry/fexit and similar, but also for bpf_iter, which is an entirely
different use case (similar to raw_tp, but raw_tp is using typedef ->
func_proto approach).

So I don't know, we might as well just not do mcount checks?.. As an
alternative, but it's not great as well.

>
> jirka
>
