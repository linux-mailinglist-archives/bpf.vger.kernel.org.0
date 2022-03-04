Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB7924CDE2C
	for <lists+bpf@lfdr.de>; Fri,  4 Mar 2022 21:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbiCDUF6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Mar 2022 15:05:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbiCDUFX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Mar 2022 15:05:23 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3E623D00A
        for <bpf@vger.kernel.org>; Fri,  4 Mar 2022 12:00:39 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id bt3so8389018qtb.0
        for <bpf@vger.kernel.org>; Fri, 04 Mar 2022 12:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=77iv4Pq0Y7GpEvJhUWDdlrG+y5sXRRMFxcR0/E2a30M=;
        b=o6AO8NB9aecxo3zUTkzg3Aexm9WknMS6SDFRsTF8+6vRZmjm191EKHEw0S4JZqBKbJ
         hn95BDqDAfyEso7EjMb3vOoqu2vlML6mhFxs2Dwt1CxUb9gF7YcXtNVhEhhXqP9A367T
         ndFcEtTyWXPjPpV1B+GPiTNujULQAKKfjZlAfejlEfAmlQ+UPq/Is+HPtU/yq6AC63ea
         rqXLvpyeBpeZNEPnK/3BTdSpC6kgLiS4qpmmuNPZQJTNYnvVIsGANPexzI954zsc7BYJ
         ugiS8zdm1JztdTqzZi27lpa2rjP+0lzQRP1iglnP5EdjpqjYEWg/mHHE9nd9dnEmnEVI
         yK7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=77iv4Pq0Y7GpEvJhUWDdlrG+y5sXRRMFxcR0/E2a30M=;
        b=jJeeNUB2PUgHNizAai0+f3nL6/CVYMCR85GmW3Me1UkgWcwK/rEY5KCcH/fDnJy2EE
         m1yM5w3c2305idIlOHHmB0oTBfmZvuU3nEvw2qrO//ijKxx53dofqufWCP1nVSN9iMzA
         WCYXzTY1xyo4dC5107BjbEPSvgRPNObLOb889VZxa9HpRmpzp0JgDPoMBxDtpRS0i5Qr
         N82OirZHRFVvh0ArkOzzk+3qQc1LTfr2/KTjjSbpCmmyUXftz3QuOnFQd+qv3ttayslo
         NZ63RKMX9w3/tg2PX122MRCQPjFQfLfxIc6lWrsEM0wwdmHr7WGHwh4JtQR2GXccJiDw
         Jf5A==
X-Gm-Message-State: AOAM531HgLdak5/MLcN5230rwZtndNDDLQMR2GUnsdgEZQMOhAoC8SW1
        jzETCQqpmoVfceTHJhi1SMIbGn4zz6hgggy1pIAGi+efmw28Hg==
X-Google-Smtp-Source: ABdhPJyanpWPbBUsgqnmKCRJIXgRbit3D2u5LvrN4gB4HRfZE7yfSKJbVMKscJBWmdgTw+GNgzKYRhNYtqwn9/X9FOc=
X-Received: by 2002:a05:6638:382:b0:30e:3e2e:3227 with SMTP id
 y2-20020a056638038200b0030e3e2e3227mr96430jap.234.1646422171351; Fri, 04 Mar
 2022 11:29:31 -0800 (PST)
MIME-Version: 1.0
References: <cover.1646188795.git.delyank@fb.com> <a679538775e08c6f7686c2aec201589b47eda483.1646188795.git.delyank@fb.com>
 <CAEf4BzZzAToLHESKrddn2y1FoLHHUVGzJe7=1ih0E3EA7BBdHg@mail.gmail.com> <9028e60f908d30d5f156064cebfd5af8d66c5c9c.camel@fb.com>
In-Reply-To: <9028e60f908d30d5f156064cebfd5af8d66c5c9c.camel@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 4 Mar 2022 11:29:20 -0800
Message-ID: <CAEf4BzbuQ+7vkKw0ozkwX7E1D7ygfTbyhaUMJitxTgiYq9y7Fg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/4] bpftool: add support for subskeletons
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

On Thu, Mar 3, 2022 at 10:57 AM Delyan Kratunov <delyank@fb.com> wrote:
>
> Thanks Andrii for taking a thorough look!
>
> On Wed, 2022-03-02 at 17:46 -0800, Andrii Nakryiko wrote:
> > There is a need (I needed it in libusdt, for example). Let's add it
> > from the very beginning, especially that it can be done in *exactly*
> > the same form as for skeletons.
>
> Absolutely, I'll get that into the next version!
>
> > seems like subskel's datasec codegen is considerably different (and
> > simpler, really) than skeleton's, I'd add a separate function for it
> > instead of all this if (subskel) special-casing. Main concern for
> > skeleton is generating correct memory layout, while for subskel we
> > just need to generate a list of pointers without any regard to memory
> > layout.
>
> I'm not 100% convinced given how much code would end up being duplicated but I
> can go in that direction, if you'd prefer it.
>
> >
>
> > it's unfortunate to have to modify original BTF just to have this '*'
> > added.  If I remember correctly, C syntax for pointers has special
> > case only for arrays and func prototypes, so it should work with this
> > logic (not tested, obviously)
> >
> > 1. if top variable type is array or func_proto, set var_ident to "(*<variable>)"
> > 2. otherwise set var_ident to "*<variable>"
> >
> > we'd need to test it for array and func_proto, but it definitely
> > should work for all other cases
>
> A couple of thoughts here:
>
> 1. We are not modifing the original BTF, we are layering in-memory-only types on
> top of it. This ends up working transparently through btf_dump code, which is
> the source of truth of what "correct" is. I think this is strictly better than
> the alternative textual modifications to var_ident.

Yeah, I noticed that you are creating split BTF later. Ok, I don't
mind, let's do it this way (due to the horrible pointer-to-array
syntax inconsistency). Please leave the comment somewhere here to make
it obvious that we are not modifying original BTF

>
> 2. I guess we see the change differently - to me it's not just about adding an
> asterisk but instead working with derivative types. This might come in handy in
> other contexts that we haven't envisioned yet and I feel is a direction worth
> supporting overall.

It's not "just about adding an asterisk", it's about generating a
pointer to the type. Split BTF added on top makes it a bit more
tolerable (though there is still a bunch of unnecessary complexity and
overhead just for that pesky asterisk).

Another alternative would be:

typeof(char[123]) *my_ptr;

This can be done without generating extra BTF. For complex types it's
actually even easier to parse, tbh. I initially didn't like it, but
now I'm thinking maybe for arrays and func_protos we should do just
this? WDYT?

>
> 3. We have a full type system with layering and mixed file- and memory-based
> storage. Why limit ourselves to templating instead of using it in the codegen?
> If I were writing this from scratch, much of codegen_datasecs would instead
> create in-memory BTF types and have btf_dump emit them (but that's not the
> bikeshed I want to paint here!).

Maybe, but at the time this code was written we didn't have either
split BTF nor BTF writing APIs.

>
> > > +       char header_guard[MAX_OBJ_NAME_LEN + sizeof("__SKEL_H__")];
> >
> > use __SUBSKEL_H__ here?
>
> Sure, I can introduce the .subskel.h suffix everywhere.
>
> >
> > > +                       strncpy(obj_name, *argv, MAX_OBJ_NAME_LEN - 1);
> > > +                       obj_name[MAX_OBJ_NAME_LEN - 1] = '\0';
> >
> > we should probably force obj_name to be an empty string, so that all
> > map names match their proper section names
>
> Ah, maybe this is why bpf_map__name was not doing the right thing before. I
> don't really like that we're relying on side effects of the empty obj_name but
> I'll try it and see if anything breaks (the templating for one will need it
> anyway).

Yeah, it's due to the fact that we are using "object name" as part of
.data, .rodata, and .bss maps (and .kconfig, probably). Historic
decision, too bad, but we have what we have. We probably should clean
this up in libbpf 1.0, it's too confusing throughout.

>
> >
> > > +       if (verifier_logs)
> > > +               /* log_level1 + log_level2 + stats, but not stable UAPI */
> > > +               opts.kernel_log_level = 1 + 2 + 4;
> >
> > hm.. we shouldn't need this, we are not loading anything into kernel
> > and don't use light skeleton
>
> You're right, will remove.
>
> >
> > > +       obj = bpf_object__open_mem(obj_data, file_sz, &opts);
> > > +       err = libbpf_get_error(obj);
> >
> > no need for libbpf_get_error() anymore, bpftool is in libbpf 1.0 mode,
> > so it will get NULL on error and error itself will be in errno
>
> Ah, yes, I won't add new callsites.
>
> >
> > >
> > > +               map_type_id = btf__find_by_name_kind(btf, bpf_map__section_name(map), BTF_KIND_DATASEC);
> >
> > if we set obj_name to "", bpf_map__name() should return ELF section
> > name here, so no need to expose this as an API
> >
> >
> > oh, but also bpf_map__btf_value_type_id() should give you this ID directly
>
> TIL, that's not obvious at all. There's a few places in gen.c that could be
> simplified then - find_type_for_map goes through slicing the complete name and
> walking over every BTF type to match on the slice. Is there some compatibility
> reason to do that or is btf_value_type_id always there?

No legacy reason, we should use btf_value_type_id if
necessary/possible (it's going to be DATASEC type for all global var
maps, I think). But I just double checked and it seems that we fill
out btf_value_type_id only during map creation (that is, during
bpf_object__load()). But I don't see any reason to postpone it so
late, so let's just move it to the open phase. See
bpf_map_find_btf_info() and where it's called.

>
> >
> > > +               for (i = 0, var = btf_var_secinfos(map_type), len = btf_vlen(map_type);
> > > +                    i < len;
> > > +                    i++, var++) {
> >
> > nit: move those long one-time assignments out of the for() loop and
> > keep it single-line?
>
> Yeah, I hate that structure too, I'll clean it up.
>
> >
> > >
> > > +                       if (!subskel) {                                     \n\
> > > +                               errno = ENOMEM;                             \n\
> > > +                               return NULL;                                \n\
> >
> > leaking obj here
>
> Yeah, I noticed that I didn't use __destroy in the subskel, will fix for v2.
>
>
> > > +       /* walk through each symbol and emit the runtime representation
> > > +        */
> >
> > nit: keep this comment single-lined?
>
> I did initially and checkpatch scolded me :)

checkpatch still loves 80 character lines, but it was relaxed to 100 a
while ago. Checkpatch.pl is not an authority, it's just a suggestion
for a lot of cases.

>
> >
> > > +       bpf_object__for_each_map(map, obj) {
> > > +               if (!bpf_map__is_internal(map))
> > > +                       continue;
> > > +
> > > +               if (!(bpf_map__map_flags(map) & BPF_F_MMAPABLE))
> > > +                       continue;
> > > +
> > > +               if (!get_map_ident(map, ident, sizeof(ident)))
> > > +                       continue;
> >
> > this sequence of ifs seems so frequently repeated that it's probably
> > time to add a helper function?
>
> It is and it's annoying me too. I'll look at the whole iteration pattern more
> closely.
>
> >
> >
> > > +                       codegen("\
> > > +                       \n\
> > > +                               syms[%4$d].name = \"%1$s\";                 \n\
> > > +                               syms[%4$d].section = \"%3$s\";              \n\
> > > +                               syms[%4$d].addr = (void**) &obj->%2$s.%1$s; \n\
> > > +                       ", var_ident, ident, bpf_map__section_name(map), sym_idx);
> > > +               }
> > > +       }
> >
> > why not assign subskel->sym_cnt here using sym_idx and avoid that
> > extra loop over all variables above?
>
> Good call, will do.
> >
> > Quentin will remind you that you should also update the man page and
> > bash completion script :)
>
> Ah, yes, glad to see it's rst and I don't have to suffer groff/mdoc flashbacks!
>
> Thanks,
> Delyan
>
