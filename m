Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CAB36D0E2B
	for <lists+bpf@lfdr.de>; Thu, 30 Mar 2023 20:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbjC3S4V (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Mar 2023 14:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjC3S4U (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Mar 2023 14:56:20 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6C3DE
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 11:56:19 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id w9so80439659edc.3
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 11:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680202577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eijfFPguX21UNYKpLWiyGkk35z+meeZkeTwfQFE+RQ4=;
        b=jqC23eEg7spm1+720I7ZHQ9UR+0ILuU3th27dpppy/1nW1YtjsFY+e7o3K7BkXJ5eQ
         bGR7gGrSLZL7wBw5tpJ8mHGF7XzA6gLpndtViQ+uuk2pg4Bn5Wba2Po1y61qbLfa/x2u
         DL3ggyMkiu6S0WwgScHfhwJZzH2KIMqKyt7T+TCM/MFcqms6+9cEMCEBKt7oS1/k+vBB
         MyqMy5a2ZMIEMLtMvVZtozTY0KM9vXgg0SF6sxYdH/grfo/GhcEDv8uJ44UlW5EqwlFt
         uNpFaI7c+4d/debOksvSiOoNoZL1jQ5bPWKgHXJJhki5AU89Vy3piMELNZ4u9+rjnYUK
         cuDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680202577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eijfFPguX21UNYKpLWiyGkk35z+meeZkeTwfQFE+RQ4=;
        b=OdI/lvvohI8cm3lHjRMCkfjt1gz1iiN4CfHC0uTVfQVEASLHzr6JhgoRBiSBOnuuHH
         agigVJCfwOp0ivr7RiZ46X3dww+9OKIcunmQEZc2Z3N2jDWwUfevg90J/pY9T1KZPefO
         8VNyLCjOWcV715Q3ecp3Y0Gwo5Y98OAuwL8vbiIKKUtc0tMwcu/IwpOIWMTtJ4XsS+h8
         GeCTdaVn1ty3lSCh9/ummxs3IZe4L+fw5Fl4s9gbR4B9BQsQRf2zm5UKZdoclV6kyQew
         kOvOQdzKLB24yh2uMsNtBaoPVGq3U/OL6J4v3m7HkbI7ISwXMO8QactnieC2sHLgJxGx
         owdA==
X-Gm-Message-State: AAQBX9c4PRqquMe5/Dg683p8c5QlJblQIrLzMRFGGcqUy+x0KTi7dDvb
        fh4QEL1ZnPgsGKGqNoZ5bX2BxN93FOMDnJMTnXazGIGb
X-Google-Smtp-Source: AKy350bDFebzjKoXt4fD6BzLrkO8bRH7/xCuzR3vZaCUyoHnAHYD+n6dXnhCBJpheRlT2DmQ/SdeI9efZKdpwhvFOXQ=
X-Received: by 2002:a17:906:2303:b0:930:310:abf1 with SMTP id
 l3-20020a170906230300b009300310abf1mr12579743eja.5.1680202577485; Thu, 30 Mar
 2023 11:56:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230327185202.1929145-1-andrii@kernel.org> <20230327185202.1929145-4-andrii@kernel.org>
 <09709d267f92856f5fd5293bd81bbe1ada4b41bc.camel@gmail.com>
In-Reply-To: <09709d267f92856f5fd5293bd81bbe1ada4b41bc.camel@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 30 Mar 2023 11:56:05 -0700
Message-ID: <CAEf4BzZ-QC7eFwLn3dEdPHQ8szxc4fRYbo0iV2VPTDCVy0k1wA@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 3/3] veristat: guess and substitue underlying
 program type for freplace (EXT) progs
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
        kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 29, 2023 at 11:36=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Mon, 2023-03-27 at 11:52 -0700, Andrii Nakryiko wrote:
> > SEC("freplace") (i.e., BPF_PROG_TYPE_EXT) programs are not loadable as
> > is through veristat, as kernel expects actual program's FD during
> > BPF_PROG_LOAD time, which veristat has no way of knowing.
> >
> > Unfortunately, freplace programs are a pretty important class of
> > programs, especially when dealing with XDP chaining solutions, which
> > rely on EXT programs.
> >
> > So let's do our best and teach veristat to try to guess the original
> > program type, based on program's context argument type. And if guessing
> > process succeeds, we manually override freplace/EXT with guessed progra=
m
> > type using bpf_program__set_type() setter to increase chances of proper
> > BPF verification.
> >
> > We rely on BTF and maintain a simple lookup table. This process is
> > obviously not 100% bulletproof, as valid program might not use context
> > and thus wouldn't have to specify correct type. Also, __sk_buff is very
> > ambiguous and is the context type across many different program types.
> > We pick BPF_PROG_TYPE_CGROUP_SKB for now, which seems to work fine in
> > practice so far. Similarly, some program types require specifying attac=
h
> > type, and so we pick one out of possible few variants.
> >
> > Best effort at its best. But this makes veristat even more widely
> > applicable.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>
> I left one nitpick below, otherwise looks good.
>
> I tried in on freplace programs from selftests and only 3 out 18
> programs verified correctly, others complained about unavailable
> functions or exit code not in range [0, 1], etc.
> Not sure, if it's possible to select more permissive attachment kinds, th=
ough.
>
> Tested-by: Eduard Zingerman <eddyz87@gmail.com>
>
> > ---
> >  tools/testing/selftests/bpf/veristat.c | 121 ++++++++++++++++++++++++-
> >  1 file changed, 117 insertions(+), 4 deletions(-)
> >

[...]

> > +
> > +             /* context argument is a pointer to a struct/typedef */
> > +             t =3D btf__type_by_id(btf, btf_params(t)[0].type);
> > +             while (t && btf_is_mod(t))
> > +                     t =3D btf__type_by_id(btf, t->type);
> > +             if (!t || !btf_is_ptr(t))
> > +                     goto skip_freplace_fixup;
> > +             t =3D btf__type_by_id(btf, t->type);
> > +             while (t && btf_is_mod(t))
> > +                     t =3D btf__type_by_id(btf, t->type);
> > +             if (!t)
> > +                     goto skip_freplace_fixup;
>
> Nitpick:
>   In case if something goes wrong with BTF there is no "Failed to guess .=
.." message.

I had a strong expectation that BTF is not malformed, which seems
pretty reasonable and common case (you will also get kernel errors
when you attempt to load this program with bad BTF anyways). So it
felt like extra warnings for such an unlikely scenario isn't
necessary.

>
> > +
> > +             ctx_name =3D btf__name_by_offset(btf, t->name_off);
> > +
> > +             if (guess_prog_type_by_ctx_name(ctx_name, &prog_type, &at=
tach_type) =3D=3D 0) {
> > +                     bpf_program__set_type(prog, prog_type);
> > +                     bpf_program__set_expected_attach_type(prog, attac=
h_type);
> > +
> > +                     if (!env.quiet) {
> > +                             printf("Using guessed program type '%s' f=
or %s/%s...\n",
> > +                                     libbpf_bpf_prog_type_str(prog_typ=
e),
> > +                                     filename, prog_name);
> > +                     }
> > +             } else {
> > +                     if (!env.quiet) {
> > +                             printf("Failed to guess program type for =
freplace program with context type name '%s' for %s/%s. Consider using cano=
nical type names to help veristat...\n",
> > +                                     ctx_name, filename, prog_name);
> > +                     }
> > +             }
> > +     }
> > +skip_freplace_fixup:
> > +     return;
> >  }
> >
> >  static int process_prog(const char *filename, struct bpf_object *obj, =
struct bpf_program *prog)
> >  {
> >       const char *prog_name =3D bpf_program__name(prog);
> > +     const char *base_filename =3D basename(filename);
> >       size_t buf_sz =3D sizeof(verif_log_buf);
> >       char *buf =3D verif_log_buf;
> >       struct verif_stats *stats;
> >       int err =3D 0;
> >       void *tmp;
> >
> > -     if (!should_process_file_prog(basename(filename), bpf_program__na=
me(prog))) {
> > +     if (!should_process_file_prog(base_filename, bpf_program__name(pr=
og))) {
> >               env.progs_skipped++;
> >               return 0;
> >       }
> > @@ -835,12 +948,12 @@ static int process_prog(const char *filename, str=
uct bpf_object *obj, struct bpf
> >       verif_log_buf[0] =3D '\0';
> >
> >       /* increase chances of successful BPF object loading */
> > -     fixup_obj(obj);
> > +     fixup_obj(obj, prog, base_filename);
> >
> >       err =3D bpf_object__load(obj);
> >       env.progs_processed++;
> >
> > -     stats->file_name =3D strdup(basename(filename));
> > +     stats->file_name =3D strdup(base_filename);
> >       stats->prog_name =3D strdup(bpf_program__name(prog));
> >       stats->stats[VERDICT] =3D err =3D=3D 0; /* 1 - success, 0 - failu=
re */
> >       parse_verif_log(buf, buf_sz, stats);
>
