Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2392029CD5E
	for <lists+bpf@lfdr.de>; Wed, 28 Oct 2020 02:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725847AbgJ1BiT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Oct 2020 21:38:19 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45753 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1833061AbgJ0XzD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Oct 2020 19:55:03 -0400
Received: by mail-ed1-f67.google.com with SMTP id dg9so3252130edb.12
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2020 16:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KltW5WB7nh9FObbMtAxJQyGKMUmzgBf2jMpmw0XbnqA=;
        b=wOFqmJWQKCHXYXtesyDb2GRVCsde5sIaS6tCQxPY0hkqe7wvf95wmM/WdkfKOwTX6L
         ldhdtlxJjsKasB3nt/LcLTPi1FAUPZlMkAMejBWZVY13mnKfkeBAXaKaFnUA+XGVYZ+u
         4TUWKyfRXM4t7C4q/JrA7rxhaFYKqEah5dCPmuqeIUN15oEcipcEUD49yLsZPHHSKCq1
         rVPcffanWjK0iP1C0wntSlJjxgG8Urjx2RdKvLQm2/dGgTwOYkYmrxOmGM7OGFUo+ydK
         k6M/6JFSDWrDsgfYH5MBSOHsKs9bAZIOM5sv7i9rGNVFvAMr94IRU9SgJT73cr9QfIyp
         gp3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KltW5WB7nh9FObbMtAxJQyGKMUmzgBf2jMpmw0XbnqA=;
        b=Gm0D3f97Lx45zHuFLeyKxPvrGVbjmGWJKf5XfS+5QRhSSywsoZPdrVEQ1BpqMvY8Ke
         YiYQRxa6EHd470Olm5mn/SI7vEn37q+KDpQy7P8xhnEGjAFhp1nUtS5BQYSokajYKMeI
         JGF3WTkjogX+Py09ut1W+M7ETjwrK7xCymQqNPbPlnzW7W7/lpxn0BGVVnSU5MUuk5K/
         /A8Hv6AInoeqBmFHTZQdKr1tbe52/NnS2HguecplbBwV33AvKnGAcoVZxKK/gHSED0g7
         Pu4AaUdGFQgDLn/507bUfj5LETcRdPYTViV2SQm7btKyfOXA0z8xWBUjCU8Wu6sMX+an
         NAzA==
X-Gm-Message-State: AOAM531IeJ7cFSZK15WpTrKBptgosxDp1+Ca5W3ylc+v2/F76FsLBhMW
        WAhW7WrJKgA3P4IMcG+FzWClVJ7QmEfTdzwKVV1mmg==
X-Google-Smtp-Source: ABdhPJxcK6X5g6DskaxzCUWkXWbt0gzFPeJD/e4ZpL4bZzpV5QJmaXtQt+UlTDMbM5AxxWsViaU8yLjULq+7hHa1Ek4=
X-Received: by 2002:a50:eb8e:: with SMTP id y14mr5055957edr.285.1603842900302;
 Tue, 27 Oct 2020 16:55:00 -0700 (PDT)
MIME-Version: 1.0
References: <20201026223617.2868431-1-jolsa@kernel.org> <20201026223617.2868431-2-jolsa@kernel.org>
 <CAEf4Bzan6=Jjfez17=S55Zu9EQTF_J2dg2DST4v+CfENm8cbUQ@mail.gmail.com>
In-Reply-To: <CAEf4Bzan6=Jjfez17=S55Zu9EQTF_J2dg2DST4v+CfENm8cbUQ@mail.gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Tue, 27 Oct 2020 16:54:49 -0700
Message-ID: <CA+khW7hriWpy9-V9WgdMEv_5814_bzxrZ6we8=525ecanXUjSg@mail.gmail.com>
Subject: Re: [PATCH 1/3] btf_encoder: Move find_all_percpu_vars in generic
 config function
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Mark Wielaard <mjw@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Agree with Andrii. The function name 'config' is too generic and
'config_per_var' is confusing to me. But the rest looked good. Thanks
for taking a look at this.

Hao


On Tue, Oct 27, 2020 at 4:12 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Oct 26, 2020 at 5:07 PM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Moving find_all_percpu_vars under generic onfig function
> > that walks over symbols and calls config_percpu_var.
> >
> > We will add another config function that needs to go
> > through all the symbols, so it's better they go through
> > them just once.
> >
> > There's no functional change intended.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  btf_encoder.c | 126 ++++++++++++++++++++++++++------------------------
> >  1 file changed, 66 insertions(+), 60 deletions(-)
> >
> > diff --git a/btf_encoder.c b/btf_encoder.c
> > index 2a6455be4c52..2dd26c904039 100644
> > --- a/btf_encoder.c
> > +++ b/btf_encoder.c
> > @@ -250,7 +250,64 @@ static bool percpu_var_exists(uint64_t addr, uint32_t *sz, const char **name)
> >         return true;
> >  }
> >
> > -static int find_all_percpu_vars(struct btf_elf *btfe)
> > +static int config_percpu_var(struct btf_elf *btfe, GElf_Sym *sym)
>
> I find the "config" name completely misleading. How about
> "collect_percpu_var" or something along those lines?
>
> > +{
> > +       const char *sym_name;
> > +       uint64_t addr;
> > +       uint32_t size;
> > +
>
> [...]
>
> > +}
> > +
> > +static int config(struct btf_elf *btfe, bool do_percpu_vars)
>
> same here, config is generic and misrepresenting what we are doing
> here. E.g., collect_symbols would probably be more clear.
>
> >  {
> >         uint32_t core_id;
> >         GElf_Sym sym;
>
> [...]
