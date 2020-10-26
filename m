Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE6229994F
	for <lists+bpf@lfdr.de>; Mon, 26 Oct 2020 23:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391717AbgJZWGX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Oct 2020 18:06:23 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:37656 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391702AbgJZWGW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Oct 2020 18:06:22 -0400
Received: by mail-yb1-f196.google.com with SMTP id h196so8996940ybg.4
        for <bpf@vger.kernel.org>; Mon, 26 Oct 2020 15:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yBMo/R9/ROQJgmE2PA4qWWxGdEkZOw1PZiHRjvTRTmM=;
        b=IinPtLutSqwQ9U3ovm83fnXAj4v0OojNgSd1LFOhLpfa1cb4RXFURBNb7pKq+UWVIL
         K2f4rJ6JH6CpglqOSHK4g5HBjenwWlvj26N5Rn/VCCH7sQ2v6PxkH/qIrXWAcUrci0WO
         39SDl3pRDa0GxgFdsWDAtcz53/QJoH+cZnuCgjN2Ywgae7suZV35bP00KmjN8pfgIotl
         4M83NTFRYCsve8OzF56kIyUhJiKMeWIuodbwVVTWys+AsbUDeecZss51ZnZjKxEcR1R/
         ToOL3miNCTtgMz5SZQ2okXQX1t39I7VathTioVcW/6rMycgaf45lTuqhNwkgJslPCx84
         QZzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yBMo/R9/ROQJgmE2PA4qWWxGdEkZOw1PZiHRjvTRTmM=;
        b=oJB9tlkHqmC9uyBSZY1g5JIzTecg4osB20cbNgh4zerVO/VXigCIxrzLSZpoDv1Tix
         idG/LyKCWw7q1wzpFtWuksQJrvfCO9/XDgRJ01pm/3pGV8iPmFX50/Owz+veBoyQvXoe
         qBoQTf1Sb5i00xhlwGyD/kAPgDGON8At/4IyWw3KvL2hVQOHLu//t/52nGOSaEarTOpd
         biG93K5QYh+TkI29dgUJU2f+UziOoVj+emuI8Yt6h09E9aZBxdTgVi4tUCnWDRFuy/Na
         pqjKte6AfVqwWd0+gFh9uBFPJ07Z2LS1me9B/8yCBV0+hJ1RyJp6CjAZfklTI5UIpj9s
         38Lg==
X-Gm-Message-State: AOAM5336LKsZtdQLHLNRFVH4MvDs0rNhIyxLhwpu71Eww/QdACGSP0DY
        Qfpu9IbgonCe5w3dEUCQjuQ/JG/S8/Aj0437ULs=
X-Google-Smtp-Source: ABdhPJxNP5mnniF9KtQH9tWZpf2rMq+CPxY203KbwTrrmbxXA/Iwek/CFVTkVwX885/uIXNcU+yGmz3f4dF2omd9ZJQ=
X-Received: by 2002:a25:da4e:: with SMTP id n75mr25535033ybf.425.1603749980858;
 Mon, 26 Oct 2020 15:06:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAEf4Bzb7B+_s0Y2oN5TZARTmJby3npTVKDuDKDKfgmbBkAdpPQ@mail.gmail.com>
 <20200915073030.GE1714160@krava> <20200915121743.GA2199675@krava>
 <20200916090624.GD2301783@krava> <20201016213835.GJ1461394@krava>
 <20201021194209.GB2276476@krava> <CAEf4BzaZa2NDz38j=J=g=9szqj=ruStE7EiSs2ueQ5rVHXYRpQ@mail.gmail.com>
 <20201023053651.GE2332608@krava> <20201023065832.GA2435078@krava>
 <CAEf4BzbM=FhKUUjaM9msL1k=t_CSrhoWUNYcubzToZvbAJCJ-A@mail.gmail.com> <20201026101441.GA2726983@krava>
In-Reply-To: <20201026101441.GA2726983@krava>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 26 Oct 2020 15:06:09 -0700
Message-ID: <CAEf4BzZgrEc=vBYq_KZ2xPkPOQOu14GJR1HZoA42fhZFJ2zC4A@mail.gmail.com>
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

On Mon, Oct 26, 2020 at 3:14 AM Jiri Olsa <jolsa@redhat.com> wrote:
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
> with the change below I seem to get all argument names
>
> the change assumes that we can skip dwarf functions with
> no argument names, because if the function is defined in
> the object, it needs to have argument names

I'd love it if it was that simple, but I learn time and time again
that DWARF and compilers tend to always have some bugs and gotchas
with type information. But let's try and see, of course.

>
> so there will be eventualy dwarf definition of that function
> with full argument names
>
> I wonder we could use this code as a check that the function
> is present in the object ;-) but I think we need to keep
> the symbols check as well
>
> I'll send that out together with the rest of the changes
>
> jirka
>
>
> ---
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 7e370eb48174..0c14ac210425 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -397,6 +397,19 @@ static int config(struct btf_elf *btfe, bool do_percpu_vars)
>         return 0;
>  }
>
> +static bool has_arg_names(struct cu *cu, struct ftype *ftype)
> +{
> +       struct parameter *param;
> +       const char *name;
> +
> +       ftype__for_each_parameter(ftype, param) {
> +               name = dwarves__active_loader->strings__ptr(cu, param->name);
> +               if (name == NULL)
> +                       return false;
> +       }
> +       return true;
> +}
> +
>  int cu__encode_btf(struct cu *cu, int verbose, bool force,
>                    bool skip_encoding_vars)
>  {
> @@ -472,6 +485,9 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
>                 int btf_fnproto_id, btf_fn_id;
>                 const char *name;
>
> +               if (!has_arg_names(cu, &fn->proto))
> +                       continue;
> +
>                 if (!generate_func(btfe, function__name(fn, cu)))
>                         continue;
>
>
