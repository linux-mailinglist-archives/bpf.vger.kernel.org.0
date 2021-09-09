Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9974F404507
	for <lists+bpf@lfdr.de>; Thu,  9 Sep 2021 07:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350770AbhIIFef (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Sep 2021 01:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350756AbhIIFeb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Sep 2021 01:34:31 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D22FDC061575
        for <bpf@vger.kernel.org>; Wed,  8 Sep 2021 22:33:22 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id q70so1512398ybg.11
        for <bpf@vger.kernel.org>; Wed, 08 Sep 2021 22:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PnOY5Y47/AW71dTlVOeM5rUtHegoI9iKApeBCFGQ5dA=;
        b=fbdohMUqfrWe6z8cT/hhSCXVTdXCwMocVaX3a3z8eUzfdSYBL2FmtYypH704bOjMPw
         tIRHA8RnZWRnGAoUpyLLilqYRgB3kEDDWL08GGJEIU5fUHq3k+N+UPkz31QUQWl4w5Xb
         S/zA9sv7gO3eCI40yEM6H4xj8mJ4UFKk4+jSxcwL8/jxq4Y5UHWIdxbmjRhKZcWkts/8
         fetqD9ImllAHPRxBWmYaPSPxXLq2aFT36oWlJo3KLpMjHTehGHsCv2k8p1c6DVaadTm3
         EOIIii75nlEbrdCaP/5sI60MgvX0odinJ+4pp6rVKPwZg6QlfN08xBAeWqdLixWbRSmf
         pHVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PnOY5Y47/AW71dTlVOeM5rUtHegoI9iKApeBCFGQ5dA=;
        b=DjwdfJNGhfnj21yN4im0D7uPZ6Yk1IPadPwC7ZY6fTVtTamskbFpjdLALXVN6S5w5P
         DhcrwbZzORY1HCcPUMnxPLZNoHvsjQO0at4+0xg8rpCxMq0d5G/YihyOccUO3W2FHTZb
         V987aBCvKHz+sErGEoqXViZ2K+5oW1bGVFUX8XhZd29ygfmuzMQXtosYtMqZhE6QqjKV
         /eK/+YLqoNuOsGMHjuRI5f11lJSwaCtsLwj8pe7LfKS5LjqX/2EXF3z0wHie58k6SBfi
         R22mLPQ1JzuBmIW8bFKDHE2+/aJiA1LNrZv+Lt4CTHpLyV/R+jNDOZfVnk1cftGcv9te
         2QZA==
X-Gm-Message-State: AOAM53260wUyCbZNLMeZnpiblwXqq5DJxNoVVv4wtLs3FSVH/7XlP6Pn
        NKytGW3WYMEOaGqJB6OQe2oimJQn4bph7GbHQ7E=
X-Google-Smtp-Source: ABdhPJzfXhjyhn3kruFv62AsrYWbgxHLZsfs77/Lsj841rYD446BwlODS/UnJGgqSxLXPPxluEj3atb5KfoYkRrz2d0=
X-Received: by 2002:a25:ef46:: with SMTP id w6mr1607465ybm.546.1631165602159;
 Wed, 08 Sep 2021 22:33:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210907230050.1957493-1-yhs@fb.com> <20210907230111.1959279-1-yhs@fb.com>
 <CAEf4BzZ6eX5GbV4o+4vz2whXyOQd+5_AaVEYn+uvR5=sV=aWZw@mail.gmail.com>
In-Reply-To: <CAEf4BzZ6eX5GbV4o+4vz2whXyOQd+5_AaVEYn+uvR5=sV=aWZw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 8 Sep 2021 22:33:11 -0700
Message-ID: <CAEf4Bza5SodxX+tU1jtjoAJW-4nZ7WvDA-7wVbTca7s8AkexFg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/9] bpftool: add support for BTF_KIND_TAG
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 8, 2021 at 10:28 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Sep 7, 2021 at 4:01 PM Yonghong Song <yhs@fb.com> wrote:
> >
> > added bpftool support to dump BTF_KIND_TAG information.
> > The new bpftool will be used in later patches to dump
> > btf in the test bpf program object file.
> >

What should be done for `bpftool btf dump file <path> format c` if BTF
contains btf_tag? Should it ignore it silently? Should it error out?
Or should we corrupt output (as will be the case right now, I think)?

> > Signed-off-by: Yonghong Song <yhs@fb.com>
> > ---
> >  tools/bpf/bpftool/btf.c | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >
> > diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> > index f7e5ff3586c9..89c17ea62d8e 100644
> > --- a/tools/bpf/bpftool/btf.c
> > +++ b/tools/bpf/bpftool/btf.c
> > @@ -37,6 +37,7 @@ static const char * const btf_kind_str[NR_BTF_KINDS] = {
> >         [BTF_KIND_VAR]          = "VAR",
> >         [BTF_KIND_DATASEC]      = "DATASEC",
> >         [BTF_KIND_FLOAT]        = "FLOAT",
> > +       [BTF_KIND_TAG]          = "TAG",
> >  };
> >
> >  struct btf_attach_table {
> > @@ -347,6 +348,23 @@ static int dump_btf_type(const struct btf *btf, __u32 id,
> >                         printf(" size=%u", t->size);
> >                 break;
> >         }
> > +       case BTF_KIND_TAG: {
> > +               const struct btf_tag *tag = (const void *)(t + 1);
> > +
> > +
>
> extra empty line?
>
> > +               if (json_output) {
> > +                       jsonw_uint_field(w, "type_id", t->type);
> > +                       if (btf_kflag(t))
> > +                               jsonw_int_field(w, "comp_id", -1);
> > +                       else
> > +                               jsonw_uint_field(w, "comp_id", tag->comp_id);
> > +               } else if (btf_kflag(t)) {
> > +                       printf(" type_id=%u, comp_id=-1", t->type);
> > +               } else {
> > +                       printf(" type_id=%u, comp_id=%u", t->type, tag->comp_id);
> > +               }
>
> here not using kflag would be more natural as well ;)
>
> > +               break;
> > +       }
> >         default:
> >                 break;
> >         }
> > --
> > 2.30.2
> >
