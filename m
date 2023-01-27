Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A37A167EC6E
	for <lists+bpf@lfdr.de>; Fri, 27 Jan 2023 18:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233140AbjA0Ra7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Jan 2023 12:30:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235149AbjA0Ra6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Jan 2023 12:30:58 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8787B43A
        for <bpf@vger.kernel.org>; Fri, 27 Jan 2023 09:30:55 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id gs13so4901376ejc.0
        for <bpf@vger.kernel.org>; Fri, 27 Jan 2023 09:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=87pnpXPAsiBVuNrR1gBqFSgVVOCo/03PpXsk6OH2y+Q=;
        b=EzOMELgS/DMATLYl3mTsvIsi7hz77cfltpGBI+Juw+BdZO1X4z/o/g4cIb0HQz7GbO
         6n7yAqFfzQI4YJfsWe4Fy0YqaP6OX4jUcjqoNZGOh1dzsZYgCb9oK81heU5z5DRyJ10q
         oWYWumiRl6l4d/ajFCcspXIbF0whGp9neIjHRvc9W0FRVrgCxBDIpBavbQ90t4wax+WL
         sdQ27wwPJtKj0D5yVvknDHn10k7k8DB35Zgj5LzqyKmDCn2kh5Xhv8nddY3S31rFpb2p
         bTTbseYHaUJ9tt7PZuaUJSeVlNKS48VIiXefXXbjKSD1RtJhFMllmjwmd7f7MS/rInEe
         7Q2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=87pnpXPAsiBVuNrR1gBqFSgVVOCo/03PpXsk6OH2y+Q=;
        b=0z0m1sQ46Zz14m6j6wV28gEOKQ2wKtKM4odqwfbkf5IfZCoieJgH9LArfw6FBVb3HA
         p4r5pinns9xxemW/vvT8RDocD7J9VQLEo4JEVOYMW9SsH4O0iiaxupZmioPRel5NpqP3
         Aw6FQu7T+/3DVWhxKi5vmlQljOjXIsKnsyqOwTmr7c9KPiH3sTJUg1WUWVbgohNYhLzf
         wu/2Dpk/kD6B3vrnLHrRtX9wwj1cF1YWxtsWh11z0cdJWq5JGcLZKgs42anWnpnIZl/R
         g7CpNYVmniRSKpIu/VR1G9v4raMgb15obullyCg26TlOGbMUjbdx7O6I9BeuVWVcEe86
         fpAA==
X-Gm-Message-State: AFqh2kpET+bd6qB8zAObWTv+QPRr/8RVltroL94TMZ4gWOM7bdi4wcqS
        NssN0QkNIxzTbIj8peuuCeQrrTQn9omYg9j7OkTqiAlduV8=
X-Google-Smtp-Source: AMrXdXu0ALB8Aza5PF+ctnnpOlTlB27ZaagSvWcd9uZ3hDzPyfZLJ0NdTNuo3DTny3vGMR3hY7Y/LmMgsdvQORi/lUw=
X-Received: by 2002:a17:906:4ed8:b0:871:ed54:609f with SMTP id
 i24-20020a1709064ed800b00871ed54609fmr7447367ejv.180.1674840654291; Fri, 27
 Jan 2023 09:30:54 -0800 (PST)
MIME-Version: 1.0
References: <20230125213817.1424447-1-iii@linux.ibm.com> <20230125213817.1424447-23-iii@linux.ibm.com>
 <CAEf4BzbaNhFw77bECCxf7cKenBTTe6YvMHbm+XiMQbqgukyW8Q@mail.gmail.com>
 <56b6677c73903638b88f331d6e074c595bd489b9.camel@linux.ibm.com>
 <CAEf4BzZO637m4vXNJ3MNb9R+diuJyx4Ck-zbYof5YHPOrApDYA@mail.gmail.com> <ad1dcd67fb0a118175fabf109d89b9df18714020.camel@linux.ibm.com>
In-Reply-To: <ad1dcd67fb0a118175fabf109d89b9df18714020.camel@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 27 Jan 2023 09:30:42 -0800
Message-ID: <CAEf4BzZFuoaPZMtVxjop+1+A0-vsTZANvKjqu_aHmb44x853YQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 22/24] s390/bpf: Implement arch_prepare_bpf_trampoline()
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
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

On Fri, Jan 27, 2023 at 3:15 AM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> On Thu, 2023-01-26 at 11:06 -0800, Andrii Nakryiko wrote:
> > On Thu, Jan 26, 2023 at 6:30 AM Ilya Leoshkevich <iii@linux.ibm.com>
> > wrote:
> > >
> > > On Wed, 2023-01-25 at 17:15 -0800, Andrii Nakryiko wrote:
> > > > On Wed, Jan 25, 2023 at 1:39 PM Ilya Leoshkevich
> > > > <iii@linux.ibm.com>
> > > > wrote:
> > > > >
> > > > > arch_prepare_bpf_trampoline() is used for direct attachment of
> > > > > eBPF
> > > > > programs to various places, bypassing kprobes. It's responsible
> > > > > for
> > > > > calling a number of eBPF programs before, instead and/or after
> > > > > whatever they are attached to.
> > > > >
> > > > > Add a s390x implementation, paying attention to the following:
> > > > >
> > > > > - Reuse the existing JIT infrastructure, where possible.
> > > > > - Like the existing JIT, prefer making multiple passes instead
> > > > > of
> > > > >   backpatching. Currently 2 passes is enough. If literal pool
> > > > > is
> > > > >   introduced, this needs to be raised to 3. However, at the
> > > > > moment
> > > > >   adding literal pool only makes the code larger. If branch
> > > > >   shortening is introduced, the number of passes needs to be
> > > > >   increased even further.
> > > > > - Support both regular and ftrace calling conventions,
> > > > > depending on
> > > > >   the trampoline flags.
> > > > > - Use expolines for indirect calls.
> > > > > - Handle the mismatch between the eBPF and the s390x ABIs.
> > > > > - Sign-extend fmod_ret return values.
> > > > >
> > > > > invoke_bpf_prog() produces about 120 bytes; it might be
> > > > > possible to
> > > > > slightly optimize this, but reaching 50 bytes, like on x86_64,
> > > > > looks
> > > > > unrealistic: just loading cookie, __bpf_prog_enter, bpf_func,
> > > > > insnsi
> > > > > and __bpf_prog_exit as literals already takes at least 5 * 12 =
> > > > > 60
> > > > > bytes, and we can't use relative addressing for most of them.
> > > > > Therefore, lower BPF_MAX_TRAMP_LINKS on s390x.
> > > > >
> > > > > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > > > > ---
> > > > >  arch/s390/net/bpf_jit_comp.c | 535
> > > > > +++++++++++++++++++++++++++++++++--
> > > > >  include/linux/bpf.h          |   4 +
> > > > >  2 files changed, 517 insertions(+), 22 deletions(-)
> > > > >
> > > >
> > > > [...]
> > > >
> > > > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > > > index cf89504c8dda..52ff43bbf996 100644
> > > > > --- a/include/linux/bpf.h
> > > > > +++ b/include/linux/bpf.h
> > > > > @@ -943,7 +943,11 @@ struct btf_func_model {
> > > > >  /* Each call __bpf_prog_enter + call bpf_func + call
> > > > > __bpf_prog_exit is ~50
> > > > >   * bytes on x86.
> > > > >   */
> > > > > +#if defined(__s390x__)
> > > > > +#define BPF_MAX_TRAMP_LINKS 27
> > > > > +#else
> > > > >  #define BPF_MAX_TRAMP_LINKS 38
> > > > > +#endif
> > > >
> > > > if we turn this into enum definition, then on selftests side we
> > > > can
> > > > just discover this from vmlinux BTF, instead of hard-coding
> > > > arch-specific constants. Thoughts?
> > >
> > > This seems to work. I can replace 3/24 and 4/24 with that in v2.
> > > Some random notes:
> > >
> > > - It doesn't seem to be possible to #include "vlinux.h" into tests,
> > >   so one has to go through the btf__load_vmlinux_btf() dance and
> > >   allocate the fd arrays dynamically.
> >
> > yes, you can't include vmlinux.h into user-space code, of course. And
> > yes it's true about needing to use btf__load_vmlinux_btf().
> >
> > But I didn't get what you are saying about fd arrays, tbh. Can you
> > please elaborate?
>
> That's a really minor thing; fexit_fd and and link_fd in fexit_stress
> now need to be allocated dynamically.
>
> > > - One has to give this enum an otherwise unnecessary name, so that
> > >   it's easy to find. This doesn't seem like a big deal though:
> > >
> > > enum bpf_max_tramp_links {
> >
> > not really, you can keep it anonymous enum. We do that in
> > include/uapi/linux/bpf.h for a lot of constants
>
> How would you find it then? My current code is:
>
> int get_bpf_max_tramp_links_from(struct btf *btf)
> {
>         const struct btf_enum *e;
>         const struct btf_type *t;
>         const char *name;
>         int id;
>
>         id = btf__find_by_name_kind(btf, "bpf_max_tramp_links",
> BTF_KIND_ENUM);
>         if (!ASSERT_GT(id, 0, "bpf_max_tramp_links id"))
>                 return -1;
>         t = btf__type_by_id(btf, id);
>         if (!ASSERT_OK_PTR(t, "bpf_max_tramp_links type"))
>                 return -1;
>         if (!ASSERT_EQ(btf_vlen(t), 1, "bpf_max_tramp_links vlen"))
>                 return -1;
>         e = btf_enum(t);
>         if (!ASSERT_OK_PTR(e, "bpf_max_tramp_links[0]"))
>                 return -1;
>         name = btf__name_by_offset(btf, e->name_off);
>         if (!ASSERT_OK_PTR(name, "bpf_max_tramp_links[0].name_off") &&
>             !ASSERT_STREQ(name, "BPF_MAX_TRAMP_LINKS",
> "BPF_MAX_TRAMP_LINKS"))
>                 return -1;
>
>         return e->val;
> }
>
> Is there a way to bypass looking up the enum, and go straight for the
> named member?


don't use btf__find_by_name_kind, just iterate all types and look at
all anonymous enums and its values, roughly

for (i = 1; i < btf__type_cnt(btf); i++) {
    const btf_type *t = btf__type_by_id(i);
    if (!btf_is_enum(t) || t->name_off)
        continue;
    for (j = 0; j < btf_vlen(t); j++) {
        if (strcmp(btf__str_by_offset(btf, btf_enum(t)[j].name_off),
"BPF_MAX_TRAMP_LINKS") != 0)
            continue;
        /* found it */
    }
}

but cleaner :)


>
> > > #if defined(__s390x__)
> > >         BPF_MAX_TRAMP_LINKS = 27,
> > > #else
> > >         BPF_MAX_TRAMP_LINKS = 38,
> > > #endif
> > > };
> > >
> > > - An alternative might be to expose this via /proc, since the users
> > >   might be interested in it too.
> >
> > I'd say let's not, there is no need, having it in BTF is more than
> > enough for testing purposes
>
> Fair enough.
> >
