Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEAF44D6B1B
	for <lists+bpf@lfdr.de>; Sat, 12 Mar 2022 00:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbiCKXnA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Mar 2022 18:43:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiCKXm7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Mar 2022 18:42:59 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7B2FFE
        for <bpf@vger.kernel.org>; Fri, 11 Mar 2022 15:41:54 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id x9so504029ilc.3
        for <bpf@vger.kernel.org>; Fri, 11 Mar 2022 15:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eg3iMGfcxjpQ2PXCpAu/smhP8px2IedQmCm3e9gJRgk=;
        b=PSUVz4p00p2T54DcEAV40uQ90z8oFsBiYtMOmT5q4aLzqu/Qm86Xo45WFvJVBFo3se
         1vzwpdzEATWl0xGPyzbgcsZipg5RQMYjWPSMCmb/Te6qpEOjiSYNbjhKpGXwpwkv0ozK
         Gi5Sxu6earhyJDbNuPk33qmNKWWaQ/TKNCKC/2JH+L+GUZuWCmmXmA7lO0gpUUqHe9ZI
         Kq9UuIvgRkB5JBOscB+7Zirkce8Y9U97QCKgjqscj60Y/LL2SF+tLvKdYcPb2rY6KkxV
         2/5I9XxNHf3O8XzDy6QvGSWvJxflZtknrZPMskNImX+hZEON1ZZdawLd5nNQd98jAa72
         bFiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eg3iMGfcxjpQ2PXCpAu/smhP8px2IedQmCm3e9gJRgk=;
        b=t5CaMR3ZDD0oPxbCMSswmhq8dPti+7AkMOiK9rXYg5iHWQCBGGktl9lE3FPhjzWyNm
         XVM5ew9Nae1/ObclXb4AMJScygOf3pRbt8Dt7r3hVKlEi1cNojVIwwb+qWp/bbILaoTy
         xOFasDA7d6OrMGBDGNMri2YN6RNevzsioG3aXG8dc12kwdf8CPzbffkEro/ohoRKX3+K
         MMHxMlujfBT0c3YZIxVOCvhRqp6u1uhrCdNrYewQx+BEEom1GVFlyf4YX3MY6WXYKFIx
         hz+xk2geGtP5vy93K+baJLDaZokhYeiPFfIpHIYXCsmLjUlI4x+RES3uqmpFwNz4D8h2
         VxiQ==
X-Gm-Message-State: AOAM530kK3//juKZabGi2ymJcM1aId8FdROy9q5QKzS2pKlQ9Bu85c4S
        uJMCg/xXLe90ALAAsVvPA8G96KPXDkAQY86B/RGemBRYDtg=
X-Google-Smtp-Source: ABdhPJwCseuhZWaHyc6AEUIlenlbivTzGc3s1qKZL7xy/bHncJ/pocKuDVCxytdS7sbY8e0BFCjkJsrRva1QxFUg+1s=
X-Received: by 2002:a92:6406:0:b0:2bb:f1de:e13e with SMTP id
 y6-20020a926406000000b002bbf1dee13emr9658984ilb.305.1647042114062; Fri, 11
 Mar 2022 15:41:54 -0800 (PST)
MIME-Version: 1.0
References: <cover.1646957399.git.delyank@fb.com> <b7ab6736af3976a8739f0ed75feb4ca58f5e926f.1646957399.git.delyank@fb.com>
 <CAEf4BzYsTBZwwVrLHkEGJyBsNRKyGCBNJSk3xDAS2z8OT8FL6w@mail.gmail.com>
 <CAEf4BzYPRs6wyAsZqcE7ga15Y1jtbNcAV+a+89vXNbW3ZFyEjw@mail.gmail.com> <97cd91b96584c7e0d37637b8d4a0ecf04322c964.camel@fb.com>
In-Reply-To: <97cd91b96584c7e0d37637b8d4a0ecf04322c964.camel@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 11 Mar 2022 15:41:43 -0800
Message-ID: <CAEf4Bzb9bj-Z3oO11Y6hxQvSo6ss6LZM_iEs_1uuoHXZpns33A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/5] libbpf: add subskeleton scaffolding
To:     Delyan Kratunov <delyank@fb.com>
Cc:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 11, 2022 at 3:28 PM Delyan Kratunov <delyank@fb.com> wrote:
>
> Thanks Andrii!
>
> On Fri, 2022-03-11 at 15:08 -0800, Andrii Nakryiko wrote:
> > On Fri, Mar 11, 2022 at 2:52 PM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> >
> > >
>
> [...]
>
> > > > +
> > > > +       err = populate_skeleton_maps(s->obj, s->maps, s->map_cnt);
> > > > +       if (err) {
> > > > +               pr_warn("failed to populate subskeleton maps: %d\n", err);
> > > > +               return libbpf_err(err);
> > > >         }
> > > >
> > > > -       for (i = 0; i < s->prog_cnt; i++) {
> > > > -               struct bpf_program **prog = s->progs[i].prog;
> > > > -               const char *name = s->progs[i].name;
> > > > +       err = populate_skeleton_progs(s->obj, s->progs, s->prog_cnt);
> > > > +       if (err) {
> > > > +               pr_warn("failed to populate subskeleton maps: %d\n", err);
> > > > +               return libbpf_err(err);
> > > > +       }
> > > >
> > > > -               *prog = bpf_object__find_program_by_name(obj, name);
> > > > -               if (!*prog) {
> > > > -                       pr_warn("failed to find skeleton program '%s'\n", name);
> > > > -                       return libbpf_err(-ESRCH);
> > > > +       for (var_idx = 0; var_idx < s->var_cnt; var_idx++) {
> > > > +               var_skel = &s->vars[var_idx];
> > > > +               map = *var_skel->map;
> > > > +               map_type_id = bpf_map__btf_value_type_id(map);
> > > > +               map_type = btf__type_by_id(btf, map_type_id);
> > > > +
> > >
> > > should we double-check that map_type is DATASEC?
>
> Sure, can do.
>
> > >
> > > > +               len = btf_vlen(map_type);
> > > > +               var = btf_var_secinfos(map_type);
> > > > +               for (i = 0; i < len; i++, var++) {
> > > > +                       var_type = btf__type_by_id(btf, var->type);
> > > > +                       if (!var_type) {
> > >
> > > unless BTF itself is corrupted, this shouldn't ever happen. So
> > > checking for DATASEC should be enough and this if (!var_type) is
> > > redundant
> > >
> > > > +                               pr_warn("Could not find var type for item %1$d in section %2$s",
> > > > +                                       i, bpf_map__name(map));
> > > > +                               return libbpf_err(-EINVAL);
> > > > +                       }
> > > > +                       var_name = btf__name_by_offset(btf, var_type->name_off);
> > > > +                       if (strcmp(var_name, var_skel->name) == 0) {
> > > > +                               *var_skel->addr = (char *) map->mmaped + var->offset;
> > >
> > > is (char *) cast necessary? C allows pointer adjustment on void *, so
> > > shouldn't be
> >
> > oh, wait, it's so that C++ compiler doesn't complain, never mind
>
> This is libbpf code, not subskel code, so it shouldn't get compiled as C++. It's
> really because of -Wpointer-arith and -Werror.

Oh, if it's libbpf code then it shouldn't be necessary, after all. I'm
pretty sure we assume in many places that we can do pointer arithmetic
on void *. Did you try and it didn't compile? Or you just did it
preemptively?

>
> >
> > >
> > > > +                               break;
> > > > +                       }
> > > >                 }
> > > >         }
> > > > -
> > > >         return 0;
> > > >  }
> > > >
> > >
> > > [...]
> > >
> > > >  struct gen_loader_opts {
> > > >         size_t sz; /* size of this struct, for forward/backward compatiblity */
> > > >         const char *data;
> > > > diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> > > > index df1b947792c8..d744fbb8612e 100644
> > > > --- a/tools/lib/bpf/libbpf.map
> > > > +++ b/tools/lib/bpf/libbpf.map
> > > > @@ -442,6 +442,8 @@ LIBBPF_0.7.0 {
> > > >
> > > >  LIBBPF_0.8.0 {
> > > >         global:
> > > > +               bpf_object__open_subskeleton;
> > > > +               bpf_object__destroy_subskeleton;
> > >
> > > nit: should be in alphabetic order
> > >
> > > >                 libbpf_register_prog_handler;
> > > >                 libbpf_unregister_prog_handler;
> > > >  } LIBBPF_0.7.0;
> > > > --
> > > > 2.34.1
>
