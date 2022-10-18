Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35680603697
	for <lists+bpf@lfdr.de>; Wed, 19 Oct 2022 01:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbiJRXTK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Oct 2022 19:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiJRXTH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Oct 2022 19:19:07 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE01D38FE
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 16:19:00 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id w18so35982620ejq.11
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 16:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3ZL6xPjD0gFrle4w/+g9Va0YjI51fXBqs9QaoHsEiig=;
        b=qBdlK2Mjs99a95wOfSoRrIt6IELJhoChRblAwyWCM7Rgjq5Y2Pc5TgySDqw0+yOanS
         5g/aMQbz1zx+rbAWu4Y8rP8hgHYhxnShKyXRgUAnvb20FwPwshVzu+lAtmKA9mrQXrZv
         r1H+PfrgE6M3xuksawWHTso4XgSUV+j+DgM2ZbWYwzOzfH80m8Ez7t7YjYnUGL0rfVVl
         siK2KB+5/KmMYQqH+gc0TgIFojJLSU7v0EJvU/29jKnBdpB+/WpBij6LO3FFpY5x2+ce
         KbON78xGBpS3mC3EIpDExf4gMxf7FwDqDSRPaJNCtXUIkD6ChpkgzHygMkllGZXf7UkO
         HXFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3ZL6xPjD0gFrle4w/+g9Va0YjI51fXBqs9QaoHsEiig=;
        b=qCG9mFTluUkTxyYhw8YvS/P92KGrcAM+dO6hMhwI0ca9VNzgz5/7gTLz7PkhKQ9OgZ
         c3leH3L0jfUaM/iHSVHWGHCM9xnyi9xgYF1seHb2opfzd2cWq9ph3tCeAOusWOuAkJqt
         bDR2yxRB7cv4NoAuwl2LB6AXB9rQyjfb6QcrTBFr+HGSSxn9BnR9k0A58V+wWs0MeaLl
         +zCjAJYENyd1vsE+x9P7oRk1zAva4dhCN2+40l8PzpS/u2UmyarBEuqYGylOEoBsEcmH
         vdHZziSOFEyiC+BXLJUPSyc/9kzhZOgyx99N+jU/hJOduaK6+oY8+fmeFhct42Ua9cWX
         OIFg==
X-Gm-Message-State: ACrzQf3EebQkTJUUK6/fY913MRlVoybwWmyXVVafyKIM+VBNgYeHDajh
        gQEkU3BkINMnJgKAnkyawfjw993+pxfAg24Box8=
X-Google-Smtp-Source: AMsMyM4wu1z92GgT7ACULHOI/UZGjlz44j8CwCkWTaRZsSOuH/OHhfsjiy1WvVZ0oVJxj4GnfvVsYeydsT/RibkRDJY=
X-Received: by 2002:a17:907:984:b0:77f:4d95:9e2f with SMTP id
 bf4-20020a170907098400b0077f4d959e2fmr4466069ejc.176.1666135139299; Tue, 18
 Oct 2022 16:18:59 -0700 (PDT)
MIME-Version: 1.0
References: <20221018035646.1294873-1-andrii@kernel.org> <20221018035646.1294873-2-andrii@kernel.org>
 <Y0700LilBVP2D39B@google.com>
In-Reply-To: <Y0700LilBVP2D39B@google.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 18 Oct 2022 16:18:47 -0700
Message-ID: <CAEf4BzbFNpy3Ksp9ez_xvG7_C8uD=72d6gZeZj7xWsaODuOpNg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/3] libbpf: clean up and refactor BTF fixup step
To:     sdf@google.com
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kernel-team@fb.com
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

On Tue, Oct 18, 2022 at 11:47 AM <sdf@google.com> wrote:
>
> On 10/17, Andrii Nakryiko wrote:
> > Refactor libbpf's BTF fixup step during BPF object open phase. The only
> > functional change is that we now ignore BTF_VAR_GLOBAL_EXTERN variables
> > during fix up, not just BTF_VAR_STATIC ones, which shouldn't cause any
> > change in behavior as there shouldn't be any extern variable in data
> > sections for valid BPF object anyways.
>
> > Otherwise it's just collapsing two functions that have no reason to be
> > separate, and switching find_elf_var_offset() helper to return entire
> > symbol pointer, not just its offset. This will be used by next patch to
> > get ELF symbol visibility.
>
> > While refactoring, also "normalize" debug messages inside
> > btf_fixup_datasec() to follow general libbpf style and print out data
> > section name consistently, where it's available.
>
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>
> Acked-by: Stanislav Fomichev <sdf@google.com>
>
> Left a couple of questions below.
>
> > ---
> >   tools/lib/bpf/libbpf.c | 95 ++++++++++++++++++------------------------
> >   1 file changed, 41 insertions(+), 54 deletions(-)
>

[...]

> > -     /* .extern datasec size and var offsets were set correctly during
> > -      * extern collection step, so just skip straight to sorting variables
> > +     /* extern-backing datasecs (.ksyms, .kconfig) have their size and
> > +      * variable offsets set at the previous step, so we skip any fixups
> > +      * for such sections
> >        */
> >       if (t->size)
> >               goto sort_vars;
>
> > -     ret = find_elf_sec_sz(obj, name, &size);
> > -     if (ret || !size) {
> > -             pr_debug("Invalid size for section %s: %u bytes\n", name, size);
> > +     err = find_elf_sec_sz(obj, sec_name, &size);
> > +     if (err || !size) {
> > +             pr_debug("sec '%s': invalid size %u bytes\n", sec_name, size);
>
> nit: do we want to log err instead here? it seems like the size will be
> zero on error anyway, so probably not worth logging it?

hmm.. I mostly just preserved the original message content. Error can
be zero, and size can be zero, so don't know, we can log both or none?
Section name will probably be more important in practice.

>
> >               return -ENOENT;
> >       }
>
> >       t->size = size;
>
> >       for (i = 0, vsi = btf_var_secinfos(t); i < vars; i++, vsi++) {
> > +             const struct btf_type *t_var;
> > +             struct btf_var *var;
> > +             const char *var_name;
> > +             Elf64_Sym *sym;
> > +

[...]

> > -static int btf_finalize_data(struct bpf_object *obj, struct btf *btf)
> > +static int bpf_object_fixup_btf(struct bpf_object *obj)
> >   {
> > -     int err = 0;
> > -     __u32 i, n = btf__type_cnt(btf);
> > +     int i, n, err = 0;
>
> > +     if (!obj->btf)
> > +             return 0;
> > +
> > +     n = btf__type_cnt(obj->btf);
>
> qq: why do s/__u32/int/ here? btf__type_cnt seems to be returning u32?

mostly to consolidate all the variables above into single short line.
BTF IDs can't be so big to not fit into int, so it's safe to use
signed int everywhere.

>
> >       for (i = 1; i < n; i++) {
> > -             struct btf_type *t = btf_type_by_id(btf, i);
> > +             struct btf_type *t = btf_type_by_id(obj->btf, i);
>
> >               /* Loader needs to fix up some of the things compiler
> >                * couldn't get its hands on while emitting BTF. This

[...]
