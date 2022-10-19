Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4089C60370A
	for <lists+bpf@lfdr.de>; Wed, 19 Oct 2022 02:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbiJSAR1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Oct 2022 20:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbiJSARI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Oct 2022 20:17:08 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66EACDED35
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 17:16:15 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id e15so13211805iof.2
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 17:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=37bdsyQHCRTXJLfG9pay7ecUUBRUHONlsC+UzXv6Ay0=;
        b=KR2BoPcB+A6xHoXnCHGW98IJjEn7C7e5MkcQltx1+9n69xreByGpLIEUe9YAsTlYKf
         BEzEcSx+ha3bqgTcEEbWtTNHLA50+iAhh+mvrY0MB+25Dl0cZ9Vpdb2jfT3FRABEYyq8
         /4ZPCKvWWupp3a1KWr2SJ2HNG0YtO0VRUK8hOMHxZj0MptitP3y3KhDBRuwA4l5iTPIU
         W0JTq0OXKpoFMfNhsQK2R1dAXT0gksG+g6b1kjnbB8YEYye0B50908pKdTqkLxgUjx7K
         jBrtHmsCHbnJiJn1T1uKcQ4tw2LGKgjaWn3kY8GOt2Z380evcJyqmcBr9FqgE8VSVj2Y
         9oSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=37bdsyQHCRTXJLfG9pay7ecUUBRUHONlsC+UzXv6Ay0=;
        b=hZqy0t4JUhv5V6geb5y4JRyqwXesMTvTjyUGMCQRTFBFy1+rd3JtX5sizDvfQCOms1
         65M0J9+rEoZJm/wEGP3oCSOObM0hW+oV4Kp6X72PtUWrUMGIDo2gvt1i6uxL4z+x/rB8
         0BfKym681S/TtcLvOjnw5XTzpYli7N1ufqysKCjqzLSOm3PyKBxUF4crzHEDRnuxsJJz
         3V5FgLNwLN8gc8C+YNeBJPm9zFtyx9GyfDJ6uJgNQNdjpykgCEO2dM3bmq+1jhplNhrr
         29Lf5hDzKvoQYyv3IlAHY5VwCHzd7HbjlR/UiQVwmCUwMUbij6hoQWa+DwKefxk1paBI
         m2hg==
X-Gm-Message-State: ACrzQf3uCG58ld1AlndEZYNib7t8OQZ/9sAQ5yFMHIsGPrUlNU8lVr0X
        zlGQlm9pHPfn76ZlszaC35XSoHDuubtJAwGE8QeHHQ==
X-Google-Smtp-Source: AMsMyM43Ai3nNYY/sHxohCYBzifXEnyc6eOwojr2TPqWt71wVdkbptfalplF6i+TjTXYaiKu7H879qEHimRNia8LJ+Q=
X-Received: by 2002:a05:6638:3c49:b0:363:c8dc:fb2f with SMTP id
 bg9-20020a0566383c4900b00363c8dcfb2fmr3850770jab.119.1666138547398; Tue, 18
 Oct 2022 17:15:47 -0700 (PDT)
MIME-Version: 1.0
References: <20221018035646.1294873-1-andrii@kernel.org> <20221018035646.1294873-2-andrii@kernel.org>
 <Y0700LilBVP2D39B@google.com> <CAEf4BzbFNpy3Ksp9ez_xvG7_C8uD=72d6gZeZj7xWsaODuOpNg@mail.gmail.com>
In-Reply-To: <CAEf4BzbFNpy3Ksp9ez_xvG7_C8uD=72d6gZeZj7xWsaODuOpNg@mail.gmail.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Tue, 18 Oct 2022 17:15:36 -0700
Message-ID: <CAKH8qBvibWBL3okWMQTe_SZ=a94a4FkR8RM884YRfsTRxtQKaA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/3] libbpf: clean up and refactor BTF fixup step
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 18, 2022 at 4:19 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Oct 18, 2022 at 11:47 AM <sdf@google.com> wrote:
> >
> > On 10/17, Andrii Nakryiko wrote:
> > > Refactor libbpf's BTF fixup step during BPF object open phase. The only
> > > functional change is that we now ignore BTF_VAR_GLOBAL_EXTERN variables
> > > during fix up, not just BTF_VAR_STATIC ones, which shouldn't cause any
> > > change in behavior as there shouldn't be any extern variable in data
> > > sections for valid BPF object anyways.
> >
> > > Otherwise it's just collapsing two functions that have no reason to be
> > > separate, and switching find_elf_var_offset() helper to return entire
> > > symbol pointer, not just its offset. This will be used by next patch to
> > > get ELF symbol visibility.
> >
> > > While refactoring, also "normalize" debug messages inside
> > > btf_fixup_datasec() to follow general libbpf style and print out data
> > > section name consistently, where it's available.
> >
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> >
> > Acked-by: Stanislav Fomichev <sdf@google.com>
> >
> > Left a couple of questions below.
> >
> > > ---
> > >   tools/lib/bpf/libbpf.c | 95 ++++++++++++++++++------------------------
> > >   1 file changed, 41 insertions(+), 54 deletions(-)
> >
>
> [...]
>
> > > -     /* .extern datasec size and var offsets were set correctly during
> > > -      * extern collection step, so just skip straight to sorting variables
> > > +     /* extern-backing datasecs (.ksyms, .kconfig) have their size and
> > > +      * variable offsets set at the previous step, so we skip any fixups
> > > +      * for such sections
> > >        */
> > >       if (t->size)
> > >               goto sort_vars;
> >
> > > -     ret = find_elf_sec_sz(obj, name, &size);
> > > -     if (ret || !size) {
> > > -             pr_debug("Invalid size for section %s: %u bytes\n", name, size);
> > > +     err = find_elf_sec_sz(obj, sec_name, &size);
> > > +     if (err || !size) {
> > > +             pr_debug("sec '%s': invalid size %u bytes\n", sec_name, size);
> >
> > nit: do we want to log err instead here? it seems like the size will be
> > zero on error anyway, so probably not worth logging it?
>
> hmm.. I mostly just preserved the original message content. Error can
> be zero, and size can be zero, so don't know, we can log both or none?
> Section name will probably be more important in practice.

Logging both is probably the easiest? Let's have them just in case,
shouldn't hurt; I'm not sure how relevant that really is..

> >
> > >               return -ENOENT;
> > >       }
> >
> > >       t->size = size;
> >
> > >       for (i = 0, vsi = btf_var_secinfos(t); i < vars; i++, vsi++) {
> > > +             const struct btf_type *t_var;
> > > +             struct btf_var *var;
> > > +             const char *var_name;
> > > +             Elf64_Sym *sym;
> > > +
>
> [...]
>
> > > -static int btf_finalize_data(struct bpf_object *obj, struct btf *btf)
> > > +static int bpf_object_fixup_btf(struct bpf_object *obj)
> > >   {
> > > -     int err = 0;
> > > -     __u32 i, n = btf__type_cnt(btf);
> > > +     int i, n, err = 0;
> >
> > > +     if (!obj->btf)
> > > +             return 0;
> > > +
> > > +     n = btf__type_cnt(obj->btf);
> >
> > qq: why do s/__u32/int/ here? btf__type_cnt seems to be returning u32?
>
> mostly to consolidate all the variables above into single short line.
> BTF IDs can't be so big to not fit into int, so it's safe to use
> signed int everywhere.

SG, thanks!

> >
> > >       for (i = 1; i < n; i++) {
> > > -             struct btf_type *t = btf_type_by_id(btf, i);
> > > +             struct btf_type *t = btf_type_by_id(obj->btf, i);
> >
> > >               /* Loader needs to fix up some of the things compiler
> > >                * couldn't get its hands on while emitting BTF. This
>
> [...]
