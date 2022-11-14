Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7AD66289ED
	for <lists+bpf@lfdr.de>; Mon, 14 Nov 2022 20:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236005AbiKNT5S (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Nov 2022 14:57:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237511AbiKNT5M (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Nov 2022 14:57:12 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F5D6569
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 11:57:11 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-367b8adf788so117469837b3.2
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 11:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=okZRZ7eVdw7Xd9wS10vzsWvpx4uhGH+TJK+PhT6rGPo=;
        b=kUAsD8OmX6iZKCbLQweqX50R2lDx4n8m24//MS8yhtXQD+qVdKtMwtg8uphwrUcClb
         FMFXATtrImh9txppEJ6dGwM9DTAj69oCDPPkN0LYvExj0b6U2FBgitrZblmjvQ69jBMr
         Fyx1enBLr0+65SWzlDv5IhJOPdYYO0UbwGmON7qgYxrSNMuPLOcXHGbLMTU1z+FnpvtQ
         uncyIJ3ZYKweJs+3g0/9L4GsAwX5vg715/7+DNnh/4GVjHeePl2HL3Ck4TeYqMH1xCaj
         sVTqkEkrHHPxlMAU2GTj4gXZQIk0sxZw4lx0DztmlTyBGcq1Uq4Pphp2EV4BqBN4W9Gp
         5GDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=okZRZ7eVdw7Xd9wS10vzsWvpx4uhGH+TJK+PhT6rGPo=;
        b=NL/m07e6SN9BB5DxQjX9GwnT2F5d7EQBKFi+dzfi4ZhC9/RtgvUgkK7B9OAGXHu0aW
         iXqJa4enqQqUs4mGMT8IMZDMHM9TmnajEW3fsJIIpIPKn1mhqDjlvMtsLtRvgHpFzWfq
         bM9dZl22g9xW1zwT+qaglN0kczqKp2B7f8gb2Q969Tlks2JJ/1uG4+vg6kVfA3LlurjE
         C6qk7xdwm3QwQaP3VoBn0Wv2zntPNyVhTmWxDQkM8teeVIHO9Dt7KJ8pdMv4cbv7mLNU
         PoRU2pBe143xc50qddQ7jnEifyjHBNC+tnEd6pbALHeCr2xECTsIiNScezcoByN8lbhl
         YmaQ==
X-Gm-Message-State: ANoB5pnnh7w6vtu3STUXT89XXZWeEl8jDh35WAYMnPkOXF8PQ6GqsYyd
        w0RfwRjl+kvKDX36PyEU/bzywbghbW05rVHG1+s=
X-Google-Smtp-Source: AA0mqf79T1FTqPu1Jw2q5kOIehM+krOrcgDoHQGfq4Qi07uy9lTbMtG2kpW1Uv+qQsKQ2wD4D+2rNvowPSb+hLIusFk=
X-Received: by 2002:a81:5702:0:b0:368:ba4f:dd9f with SMTP id
 l2-20020a815702000000b00368ba4fdd9fmr14631851ywb.155.1668455830824; Mon, 14
 Nov 2022 11:57:10 -0800 (PST)
MIME-Version: 1.0
References: <20221110144320.1075367-1-eddyz87@gmail.com> <20221110144320.1075367-2-eddyz87@gmail.com>
 <CAEf4Bzbnd2UOT9Mko+0Yf9Kgsn-sGsV43MKExYjEaYbWg0WgZg@mail.gmail.com> <3d638bd465fb604ef01c1dc5a5a92617b90482d8.camel@gmail.com>
In-Reply-To: <3d638bd465fb604ef01c1dc5a5a92617b90482d8.camel@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 14 Nov 2022 11:56:57 -0800
Message-ID: <CAEf4BzYZ-oo38ATgv32=0LhFWYciGtwAUcpSeB3Aam8hJ5Yuzg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/3] libbpf: __attribute__((btf_decl_tag("...")))
 for btf dump in C format
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com
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

On Fri, Nov 11, 2022 at 1:30 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> On Fri, 2022-11-11 at 10:58 -0800, Andrii Nakryiko wrote:
> > On Thu, Nov 10, 2022 at 6:43 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
> >
> >
> > [...]
> >
> > >  static int btf_dump_push_decl_stack_id(struct btf_dump *d, __u32 id)
> > > @@ -1438,9 +1593,12 @@ static void btf_dump_emit_type_chain(struct btf_dump *d,
> > >                 }
> > >                 case BTF_KIND_FUNC_PROTO: {
> > >                         const struct btf_param *p = btf_params(t);
> > > +                       struct decl_tag_array *decl_tags = NULL;
> > >                         __u16 vlen = btf_vlen(t);
> > >                         int i;
> > >
> > > +                       hashmap__find(d->decl_tags, id, &decl_tags);
> > > +
> > >                         /*
> > >                          * GCC emits extra volatile qualifier for
> > >                          * __attribute__((noreturn)) function pointers. Clang
> >
> > should there be btf_dump_emit_decl_tags(d, decl_tags, -1) somewhere
> > here to emit tags of FUNC_PROTO itself?
>
> Actually, I have not found a way to attach decl tag to a FUNC_PROTO itself:

I'll need to check with Yonghong, but I think what happens right now
with decl_tag being attached to FUNC instead of its underlying
FUNC_PROTO might be a bug (or maybe it's by design, but certainly is
quite confusing as FUNC itself doesn't have arguments, so
component_idx != -1 is a bit weird).

But regardless if Clang allows you to express it in C code today or
not, if we support decl_tags on func proto args, for completeness
let's support it also on func_proto itself (comp_idx == -1). You can
build BTF manually for test, just like you do it for func_proto args,
right?

>
>   typedef void (*fn)(void) __decl_tag("..."); // here tag is attached to typedef
>   struct foo {
>     void (*fn)(void) __decl_tag("..."); // here tag is attached to a foo.fn field
>   }
>   void foo(void (*fn)(void) __decl_tag("...")); // here tag is attached to FUNC foo
>                                                 // parameter but should probably
>                                                 // be attached to
>                                                 // FUNC_PROTO parameter instead.
>
> Also, I think that Yonghong had reservations about decl tags attached to
> FUNC_PROTO parameters.
> Yonghong, could you please comment?

yep, curious to hear as well


>
> >
> > > @@ -1481,6 +1639,7 @@ static void btf_dump_emit_type_chain(struct btf_dump *d,
> > >
> > >                                 name = btf_name_of(d, p->name_off);
> > >                                 btf_dump_emit_type_decl(d, p->type, name, lvl);
> > > +                               btf_dump_emit_decl_tags(d, decl_tags, i);
> > >                         }
> > >
> > >                         btf_dump_printf(d, ")");
> > > @@ -1896,6 +2055,7 @@ static int btf_dump_var_data(struct btf_dump *d,
> > >                              const void *data)
> > >  {
> > >         enum btf_func_linkage linkage = btf_var(v)->linkage;
> > > +       struct decl_tag_array *decl_tags = NULL;
> > >         const struct btf_type *t;
> > >         const char *l;
> > >         __u32 type_id;
> > > @@ -1920,7 +2080,10 @@ static int btf_dump_var_data(struct btf_dump *d,
> > >         type_id = v->type;
> > >         t = btf__type_by_id(d->btf, type_id);
> > >         btf_dump_emit_type_cast(d, type_id, false);
> > > -       btf_dump_printf(d, " %s = ", btf_name_of(d, v->name_off));
> > > +       btf_dump_printf(d, " %s", btf_name_of(d, v->name_off));
> > > +       hashmap__find(d->decl_tags, id, &decl_tags);
> > > +       btf_dump_emit_decl_tags(d, decl_tags, -1);
> > > +       btf_dump_printf(d, " = ");
> > >         return btf_dump_dump_type_data(d, NULL, t, type_id, data, 0, 0);
> > >  }
> > >
> > > @@ -2421,6 +2584,8 @@ int btf_dump__dump_type_data(struct btf_dump *d, __u32 id,
> > >         d->typed_dump->skip_names = OPTS_GET(opts, skip_names, false);
> > >         d->typed_dump->emit_zeroes = OPTS_GET(opts, emit_zeroes, false);
> > >
> > > +       btf_dump_assign_decl_tags(d);
> > > +
> >
> > I'm actually not sure we want those tags on binary data dump.
> > Generally data dump is not type definition dump, so this seems
> > unnecessary, it will just distract from data itself. Let's drop it for
> > now? If there would be a need we can add it easily later.
>
> Well, this is the only place where VARs are processed, removing this code
> would make the second patch in a series useless.
> But I like my second patch in a series :) should I just drop it?
> I can extract it as a separate series and simplify some of the existing
> data dump tests.

yep, data dump tests can be completely orthogonal, send them
separately if you are attached to that code ;)

but for decl_tags on dump_type_data() I'd rather be conservative for
now, unless in practice those decl_tags will turn out to be needed


>
> >
> > >         ret = btf_dump_dump_type_data(d, NULL, t, id, data, 0, 0);
> > >
> > >         d->typed_dump = NULL;
> > > --
> > > 2.34.1
> > >
>
