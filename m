Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E24F24EF883
	for <lists+bpf@lfdr.de>; Fri,  1 Apr 2022 18:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346903AbiDAQ7A (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 1 Apr 2022 12:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240531AbiDAQ7A (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Apr 2022 12:59:00 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE7113369E
        for <bpf@vger.kernel.org>; Fri,  1 Apr 2022 09:57:10 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id b16so3902294ioz.3
        for <bpf@vger.kernel.org>; Fri, 01 Apr 2022 09:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7rUB6a1IXmDPqB8md/3wCjR8vTMZ/9wqvEFDJXw5qn0=;
        b=d3hev1wNE4XPJ+TiLjXHCORSw4n3MyABkOxFZEL4232pPU5cSa4ibp5giF74mwkyRu
         4GHyod6c0OvoshYMLT5FciXd6K3No0AqxNC3NbSmrr3zAlK9PX0EmO80WKI4DsQmOOsP
         y0UkiBvw8ZbkJQCF9tdL8Rx/vhp2CX04U8xAJh4ZBlciywFVPg3VcnzQWnpf0bdqEIE9
         yAzZvIAK7FERuJrIZ78Vs2lo7TSJfsGxpyoQS+5/rC6WDFYZLk5C7I19uRLeGKK6r6aQ
         jhyxJCCkmypHW+u2bhWTR3M+lWS3gbS29zi0FthQoK5HlCpA7WFz4C/JQ9AChk+/MeK6
         2feA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7rUB6a1IXmDPqB8md/3wCjR8vTMZ/9wqvEFDJXw5qn0=;
        b=JifOXNQNgK0T3RAjpSTW3JNgAymPT2bs2TbjMVozB84TreSqAzlc+A4kgZOv4uVzSa
         wLlf/q8oaXZdM4ppkDqjwXJ7QYhyMMNf9bfdrc/ZDAeTp5baDvrrFqP/vnyYVF2XYavD
         6Cynsar4OzDztt54R+5Ihuw7TgpZLSPhncycn7CdQbCfd/t1LDHFeNY6UnQsvNuIHsMH
         zPWo9I4Ase5LhENh2r6w5LGVeXlmXJi+TGg/cHfzrXrca2LomkNUIjN4FGv3MT3D87FN
         kTIlMrJ8yUni6/3cnB73ZiJ0giM3wGXCt06cSe3rWpkuRyOakZwZJlKE2IeyYm3FTZuq
         fuug==
X-Gm-Message-State: AOAM5302LeGwynEgWv9WWOhn5vDxalb5+OGtsUxqUgsgbb/FUry8dEuA
        E5ltkxfOVBewsRsfea/NdnEdDuy+YSgxrZUqVvP0wO1TaNU=
X-Google-Smtp-Source: ABdhPJztHiBlEm8t75nf/2T/pJ13y4eYY9xK6+EycJl5rLgE0KJ8iNoAi5Yrh3cV2bXS2da8gS9/R1tlSTFSFKHHMAk=
X-Received: by 2002:a05:6638:1685:b0:323:9fed:890a with SMTP id
 f5-20020a056638168500b003239fed890amr6003970jat.103.1648832229371; Fri, 01
 Apr 2022 09:57:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220325052941.3526715-1-andrii@kernel.org> <20220325052941.3526715-2-andrii@kernel.org>
 <CAADnVQLkYb6NiEq=bkP_AC4pj8OFC1achC8m9UdEhwWp4ahrFw@mail.gmail.com>
 <CAEf4Bza9_L=biSu_G_ux9vgn05LVTLVdfpfi3P_XH421SeH_4g@mail.gmail.com> <CAADnVQKuxEj63pGfHgB04n2BBNja+2NuRJXMjZrvx-4SB8ZX8A@mail.gmail.com>
In-Reply-To: <CAADnVQKuxEj63pGfHgB04n2BBNja+2NuRJXMjZrvx-4SB8ZX8A@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 1 Apr 2022 09:56:58 -0700
Message-ID: <CAEf4BzYHLohBniijHJFS3FA8Ety0LYPuh8r5THSpdiWyCr2MgA@mail.gmail.com>
Subject: Re: program local storage. Was: [PATCH bpf-next 1/7] libbpf: add
 BPF-side of USDT support
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
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

On Thu, Mar 31, 2022 at 5:38 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Mar 31, 2022 at 1:13 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Thu, Mar 31, 2022 at 11:34 AM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Thu, Mar 24, 2022 at 10:30 PM Andrii Nakryiko <andrii@kernel.org> wrote:
> > > > +
> > > > +struct __bpf_usdt_arg_spec {
> > > > +       __u64 val_off;
> > > > +       enum __bpf_usdt_arg_type arg_type;
> > > > +       short reg_off;
> > > > +       bool arg_signed;
> > > > +       char arg_bitshift;
> > > > +};
> > > > +
> > > > +/* should match USDT_MAX_ARG_CNT in usdt.c exactly */
> > > > +#define BPF_USDT_MAX_ARG_CNT 12
> > > > +struct __bpf_usdt_spec {
> > > > +       struct __bpf_usdt_arg_spec args[BPF_USDT_MAX_ARG_CNT];
> > > > +       __u64 usdt_cookie;
> > > > +       short arg_cnt;
> > > > +};
> > > > +
> > > > +__weak struct {
> > > > +       __uint(type, BPF_MAP_TYPE_ARRAY);
> > > > +       __uint(max_entries, BPF_USDT_MAX_SPEC_CNT);
> > > > +       __type(key, int);
> > > > +       __type(value, struct __bpf_usdt_spec);
> > > > +} __bpf_usdt_specs SEC(".maps");
> > > > +
> > > > +__weak struct {
> > > > +       __uint(type, BPF_MAP_TYPE_HASH);
> > > > +       __uint(max_entries, BPF_USDT_MAX_IP_CNT);
> > > > +       __type(key, long);
> > > > +       __type(value, struct __bpf_usdt_spec);
> > > > +} __bpf_usdt_specs_ip_to_id SEC(".maps");
> > > ...
> > >
> > > > +
> > > > +/* Fetch USDT argument *arg* (zero-indexed) and put its value into *res.
> > > > + * Returns 0 on success; negative error, otherwise.
> > > > + * On error *res is guaranteed to be set to zero.
> > > > + */
> > > > +__hidden __weak
> > > > +int bpf_usdt_arg(struct pt_regs *ctx, int arg, long *res)
> > > > +{
> > > > +       struct __bpf_usdt_spec *spec;
> > > > +       struct __bpf_usdt_arg_spec *arg_spec;
> > > > +       unsigned long val;
> > > > +       int err, spec_id;
> > > > +
> > > > +       *res = 0;
> > > > +
> > > > +       spec_id = __bpf_usdt_spec_id(ctx);
> > > > +       if (spec_id < 0)
> > > > +               return -ESRCH;
> > > > +
> > > > +       spec = bpf_map_lookup_elem(&__bpf_usdt_specs, &spec_id);
> > > > +       if (!spec)
> > > > +               return -ESRCH;
> > > > +
> > > > +       if (arg >= spec->arg_cnt)
> > > > +               return -ENOENT;
> > > > +
> > > > +       arg_spec = &spec->args[arg];
> > > > +       switch (arg_spec->arg_type) {
> > >
> > > Without bpf_cookie in the kernel each arg access is two lookups.
> > > With bpf_cookie it's a single lookup in an array that is fast.
> > > Multiply that cost by number of args.
> > > Not a huge cost, but we can do better long term.
> > >
> > > How about annotating bpf_cookie with PTR_TO_BTF_ID at prog load time.
> > > So that bpf_get_attach_cookie() returns PTR_TO_BTF_ID instead of long.
> > > This way bpf_get_attach_cookie() can return
> > > "struct __bpf_usdt_spec *".
> > >
> > > At attach time libbpf will provide populated 'struct __bpf_usdt_spec'
> > > to the kernel and the kernel will copy the struct's data
> > > in the bpf_link.
> > > At detach time that memory is freed.
> > >
> > > Advantages:
> > > - saves an array lookup at runtime
> > > - no need to provide size for __bpf_usdt_specs map.
> > >   That map is no longer needed.
> > >   users don't need to worry about maxing out BPF_USDT_MAX_SPEC_CNT.
> > > - libbpf doesn't need to populate __bpf_usdt_specs map
> > >   libbpf doesn't need to allocate spec_id-s.
> > >   libbpf will keep struct __bpf_usdt_spec per uprobe and
> > >   pass it to the kernel at attach time to store in bpf_link.
> > >
> > > "cookie as ptr_to_btf_id" is a generic mechanism to provide a
> > > blob of data to the bpf prog instead of a single "long".
> > > That blob can be read/write too.
> > > It can be used as per-program + per-attach point scratch area.
> > > Similar to task/inode local storage...
> > > That would be (prog, attach_point) local storage.
> > >
> > > Thoughts?
> >
> > Well, I'm not concerned about ARRAY lookup, as it is inlined and very
> > fast. Sizing maps is hard and annoying, true, but I think we should
> > eventually just have resizable or dynamically-sized BPF maps, which
> > will be useful in a lot of other contexts.
>
> Yes. dynamically sized bpf maps would be great.
> That's orthogonal.
>
> > We've had a discussion about a cookie that's bigger than 8 bytes with
> > Daniel. I argued for simplicity and I still like it. If you think we
> > should add blobs per attachment, it's fine, but let's keep it separate
> > from the BPF cookie.
>
> Well, Daniel was right.
> This USDT work is first real use of bpf_cookie and
> it clearly demonstrates that bpf_cookie alone as 8-byte long
> is not enough. The bpf progs have to do map lookup.
> I bet the majority of bpf_cookie use cases will include map lookup.

Well, yeah, absolutely, just how I argued when adding the BPF cookie.
Map lookup was the idea from the very beginning. It was clear that
only for most trivial use cases having u64 by itself would be enough,
it was always the goal to use u64 as a look up key into whatever
additional map (including hashmap) or global var array necessary.

> In the case of USDT we were able to get away with array lookup
> which is cheap, but we won't be that lucky next time.

Retsnoop is the second real use case for BPF cookie and there I just
have a global var array. Works good as well. I think you are
micro-optimizing around map look up in this case. Resizability/sizing
the map is a bigger concern (not even necessarily a real problem) in
practice, not the map lookup overhead.

> Hash lookup will be more costly and dynamically sized map
> won't help the performance consideration.

See above, I personally haven't been concerned with optimizing away
hash map lookup. In my local benchmarking hash lookup costs 14ns vs
4ns or ARRAY map lookup and 3ns global var array lookup. Yes, a bit
slower, but not a huge deal. Given that uprobe activation takes on the
order of 500ns, adding 14ns for single hashmap lookup seem ok to me.

But to be clear, I think it would be great to have this ability to
pre-allocate more storage per attachment. But with BPF cookie I wanted
something simple to use both from BPF program side and set up from
user-space side. And I think this feature provides that.

Whatever we do with variable-sized per-attach storage won't be as
straightforward. So it's worthwhile to consider it, but I still stand
by BPF cookie's approach, which overall is more flexible. E.g., I can
use the same cookie as a key into multiple independent maps, as
necessary. I can utilize all the fancy spinlocks, timers, dynptrs,
kptrs, etc inside map values without any extra verifier machinery and
extra user-space setup. All the building blocks are at my disposal.

But maybe what you want should be a special kind of local storage map
where key (bpf_link, presumably) will be implicitly taken from
bpf_run_ctx. Or something along those lines, so that one can utilize
all the generic map_value features.

>
> It would be ok to keep ptr_to_btf_id separate from cookie only if
> it won't sacrifice performance. The way cookie is shaping up
> as part of bpf_run_ctx gives hope that they can stay separate.

Yep, I think so.

>
> > As for the PTR_TO_BTF_ID, I'm a bit confused, as kernel doesn't know
> > __bpf_usdt_spec type, it's not part of vmlinux BTF, so you are
> > proposing to have PTR_TO_BTF_ID that points to user-provided type?
>
> Yes. It will be pointing to prog's BTF.
>
> > I'm
> > not sure I see how exactly that will work from the verifier's
> > standpoint, tbh. At least I don't see how verifier can allow more than
> > just giving direct memory access to a memory buffer.
>
> It's a longer discussion, but user provided BTF doesn't mean
> that it should be limited to scalars only.
> Such struct can contain pointers too. Not on day one probably.
> kptr and dynptr can be and should be allowed in user's BTFs eventually.

I see. It seems like this will mean that this BTF ID will have to be
provided during program load, not attach then? Assuming we have direct
memory access to the cookie contents.

Alternatively I can see how we can use dynptr to expose this memory to
user-space. Though probably without BTF info. In any case, I agree
it's bigger and separate discussion.

>
> > But then each
> > uprobe attachment can have differently-sized blob, so statically
> > verifying that during program load time is impossible.
>
> In this USDT case the __bpf_usdt_spec is fixed size for all attach points.
> One ptr_to_btf_id as a cookie per program is a minor limitation.
> I don't see a need to support different ptr_to_btf_id-s
> in different attach points.
> USDT use case doesn't need it at least.
>
> > In any case, I don't think we should wait for any extra kernel
> > functionality to add USDT support. If we have some of those and they
> > bring noticeable benefits, we can opportunistically use them, if the
> > kernel is recent enough.
>
> Of course! It's not a blocker for libbpf usdt feature.
> That's why this discussion is a separate thread.

Ok, wasn't sure so wanted to double check. I guess I missed the new
thread factor. As I mentioned above, I think this feature should still
be separate and complementary to BPF cookie (especially that BPF
cookie is UAPI anyways). And there are a bunch of ways we can go about
it, with pros and cons each. Sounds like something that can be
discussed at LSF/MM/BPF?
