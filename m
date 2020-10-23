Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94520297843
	for <lists+bpf@lfdr.de>; Fri, 23 Oct 2020 22:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750872AbgJWUc4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Oct 2020 16:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S465818AbgJWUc4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Oct 2020 16:32:56 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E88C0613CE
        for <bpf@vger.kernel.org>; Fri, 23 Oct 2020 13:32:56 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id a4so2220040ybq.13
        for <bpf@vger.kernel.org>; Fri, 23 Oct 2020 13:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LBqbtr+H2UmpDn6AUvEdhDXN+Lag4ZXdiw3XR0q8uOQ=;
        b=Yq+GeU4Vis09NOMJqnlTIEHLt4UdK4+mQRA6APu5lY9nnsLpyjhbNMLG9D1ThBiCMw
         8zTDlSnwMG1LLEQPTIp9/ZSoWE/0+mmL6QUnoP8fBWW+6T7t+mTEhVQe5ZCz7i2S3juP
         816tWHFsAmc885SrMuXnAdYKkrx+wWN61opC9Vf2C4gFufBSpYfDo/rpmzHoFkY/DNY9
         1w62K0aYVIXEW3YgSrkUGiUEp6W7gIZ4YBuaw52le+RXtDMKjjp3FiQTlMJ7y2ZDGN+Q
         Ib0poVxmkblAA4tU3X007YLV/RW5o9k1Jo6YGwt5sqdrYvNp+HQ9GApt9udMC61AfhFx
         Y7JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LBqbtr+H2UmpDn6AUvEdhDXN+Lag4ZXdiw3XR0q8uOQ=;
        b=OL/WGZYouUAfwLky5jvVekFsvz3cIK54LzD6LtrLuKBhwtOao8T39e1ovy7/7dPxt6
         lGEaTgheI7M/nGUCH1YSCL1C7mWdREcub34f9RU9dy3EzmKZAPmnjl7rug8fE1touWnw
         buau6s54jqvupRITmJKpyys65+TpfrzB5kUpjIyQSk4awk1d0P9jppj/z1n0W5ENE8dN
         tZfvtrX2Sen+QsuKtbuqt52QAVRg0E9iBt1i7NGlnkrFNevI9UZ/LT3nSj6o3sKYv4zm
         Iqqt+rA2cO/rTiwZJart2wUfMznBNGNfWi1YhnE2CLpvDaipayzS6SPzj0ZHu1MlLN9O
         0qVA==
X-Gm-Message-State: AOAM530zhrROBxBqugoNITbbTASfKGYUdwAHep3sZW+fmBwbwq5qhsc8
        YuGYdOn4Pd+y06ZeUtTkDLgHlopLrfbGhQHLYNh6LQJYm+w=
X-Google-Smtp-Source: ABdhPJz2eg8aJk5XHEaj7o5xQ/LNZnCSD1Oc/oOQd4PzcXSiWQ6qCzkmCMvQh9V080W0tyHQjyBoY/Ut0t6z1VVRw80=
X-Received: by 2002:a25:25c2:: with SMTP id l185mr5437233ybl.230.1603485175752;
 Fri, 23 Oct 2020 13:32:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAEf4Bzb7B+_s0Y2oN5TZARTmJby3npTVKDuDKDKfgmbBkAdpPQ@mail.gmail.com>
 <20200915073030.GE1714160@krava> <20200915121743.GA2199675@krava>
 <20200916090624.GD2301783@krava> <20201016213835.GJ1461394@krava>
 <20201021194209.GB2276476@krava> <CAEf4BzaZa2NDz38j=J=g=9szqj=ruStE7EiSs2ueQ5rVHXYRpQ@mail.gmail.com>
 <20201023053651.GE2332608@krava> <20201023065832.GA2435078@krava>
 <CAEf4BzbM=FhKUUjaM9msL1k=t_CSrhoWUNYcubzToZvbAJCJ-A@mail.gmail.com> <20201023201702.GA2495983@krava>
In-Reply-To: <20201023201702.GA2495983@krava>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 23 Oct 2020 13:32:44 -0700
Message-ID: <CAEf4BzZzMNfBBPGeXazk0Qh8pbXMPip-i3iaSt6QqXE-tttT=A@mail.gmail.com>
Subject: Re: Build failures: unresolved symbol vfs_getattr
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Veronika Kabatova <vkabatov@redhat.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        bpf <bpf@vger.kernel.org>, "Frank Ch. Eigler" <fche@redhat.com>,
        Mark Wielaard <mjw@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 23, 2020 at 1:17 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Fri, Oct 23, 2020 at 11:22:05AM -0700, Andrii Nakryiko wrote:
> > On Thu, Oct 22, 2020 at 11:58 PM Jiri Olsa <jolsa@redhat.com> wrote:
> > >
> > > On Fri, Oct 23, 2020 at 07:36:57AM +0200, Jiri Olsa wrote:
> > > > On Thu, Oct 22, 2020 at 01:00:19PM -0700, Andrii Nakryiko wrote:
> > > >
> > > > SNIP
> > > >
> > > > > >
> > > > > > hi,
> > > > > > FYI there's still no solution yet, so far the progress is:
> > > > > >
> > > > > > the proposed workaround was to use the negation -> we don't have
> > > > > > DW_AT_declaration tag, so let's find out instead which DW_TAG_subprogram
> > > > > > tags have attached code and skip them if they don't have any:
> > > > > >   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=97060#c10
> > > > > >
> > > > > > the attached patch is doing that, but the resulting BTF is missing
> > > > > > several functions due to another bug in dwarf:
> > > > > >   https://bugzilla.redhat.com/show_bug.cgi?id=1890107
> > > > >
> > > > > It seems fine if there are only few functions (especially if those are
> > > > > unlikely to be traced). Do you have an estimate of how many functions
> > > > > have this second DWARF bug?
> > > >
> > > > it wasn't that many, I'll recheck
> > >
> > > 127 functions missing if the workaround is applied, list attached
> > >
> >
> > some of those seem pretty useful... I guess the quick workaround in
> > pahole would be to just remember function names that were emitted
> > already. The problem with that is that we can pick a version without
> > parameter names, which is not the end of the world, but certainly
> > annoying.
>
> right, we can generate them in bpftrace, but it's a shame
>
>
> >
> > But otherwise, I don't really have a good feeling what's the perfect
> > solution here...
>
> I tried the check of dwarf record against function symbols
> with adresses mentioned earlier (attached)
>
> getting more functions of course ;-)
>
> $ bpftool btf dump file ./vmlinux | grep 'FUNC '  | wc -l
> 46606
>
> compared to 22869 on the same .config with working gcc
> and current pahole

Just curious, what's the change in BTF size due to this?

>
> and resolve_btfids is happy, because there are no duplications
>
> jirka
>
>
> ---

[...]

>  static int btf_var_secinfo_cmp(const void *a, const void *b)
>  {
>         const struct btf_var_secinfo *av = a;
> @@ -72,6 +157,7 @@ struct btf_elf *btf_elf__new(const char *filename, Elf *elf)
>         if (!btfe)
>                 return NULL;
>
> +       btfe->symbols = RB_ROOT;

Can you please check what we do for per-cpu variables with ELF
symbols? Perhaps we can unify approaches. I'd also favor using a sort
+ bsearch approach instead of rb_tree, given we don't really need to
dynamically add/delete elements, it's a one-time operation to iterate
and initialize everything. Also binary search of linear arrays would
be more memory-efficient and cache-efficient, most probably.

>         btfe->in_fd = -1;
>         btfe->filename = strdup(filename);
>         if (btfe->filename == NULL)
> @@ -177,6 +263,7 @@ void btf_elf__delete(struct btf_elf *btfe)
>                         elf_end(btfe->elf);
>         }
>
> +       btfe__delete_symbols(btfe);
>         elf_symtab__delete(btfe->symtab);
>         __gobuffer__delete(&btfe->percpu_secinfo);
>         btf__free(btfe->btf);

[...]
