Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 617E062639C
	for <lists+bpf@lfdr.de>; Fri, 11 Nov 2022 22:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232943AbiKKVaN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Nov 2022 16:30:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233096AbiKKVaJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Nov 2022 16:30:09 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4DBEE3C
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 13:30:08 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id a29so10078340lfj.9
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 13:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Z2RDeDC0zbGBOevxy4zwakC/HLXW7bzQ6/+uaAznvXA=;
        b=Zzzm+BwXz/Fa8p8KREG/M1n7gLtwLdQgl4O1Tx/2QJ+KtpEz3CUQ91ZZxilWtQkwZF
         KbivfKjO81fHI9ME8jZgFaa96CMCt5cirV1eWbGcDUVe5qHzHoHjndSO7ZbGif5Pdn9t
         nP2Lfg3Iy1pxn5Z7t3zm+fa0aDBIf/XI6+YC8dEpM1D5/iuPQIUUMPBc7z5Dnhfe6PAH
         QUEcAVWX/6ipVtQCrVXSE3vM3SqdT6dyN9H81b9xNpl5fHq2U2L1rH5JG9/DwnsuUVn4
         1xIKwUEbGD2FAn4+5P37hCzJceSusUnyAyk5kFcxI4t1GHZ+fGC0TL7SRx6Y8uRnfTi6
         T/Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z2RDeDC0zbGBOevxy4zwakC/HLXW7bzQ6/+uaAznvXA=;
        b=Q8qkXVa84i9KEuzDXR6POL/15v091lsmoINa6FfqJBnnBf0JOS4dQJkqBmkiw/aXes
         N1VXoRXE6l+QktKpgUJ2EySHL4xVhMeTHuzvw7B1yhKfe87AyBN46IY6rVejSLUu2OEZ
         9NdkHArzAPxMoijapn1Dj4y3nIrAnUOLkm8Xc2npvFokLwXP53vfXs4yXL/YuhLwW6i7
         yS9t1gxAYStjbDWVa2s95Qn5DTzmar/eQ1lqqIape6r1F3HC2eLS9rLfs2/t5gb1Sa5+
         XU/AZcrY7WGrCsDRLfvUZ9h9OvyA/3j6F8gISwsYRALMHsHfuVXRSnbZPwf/OPuh8bpw
         /qcA==
X-Gm-Message-State: ANoB5pnQyUTrwhdzN6qALIXLhncZOu4oDb6n6/ZDEEHvT5F02yq2aqdl
        3Mwo5Ib4gZ4gMUY2/b/cTDxJdvDKQzmQlZLp
X-Google-Smtp-Source: AA0mqf4zK2uaFy+ACEU16zzQOD62gAg+xreOc/OKj8QImYcNjoaRr1YeADWyJ8sewZw2OhqvyiDEsA==
X-Received: by 2002:a05:6512:3da9:b0:4aa:e519:a065 with SMTP id k41-20020a0565123da900b004aae519a065mr1486303lfv.455.1668202206634;
        Fri, 11 Nov 2022 13:30:06 -0800 (PST)
Received: from [192.168.1.113] (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id a21-20020ac25e75000000b00494603953b6sm518892lfr.6.2022.11.11.13.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 13:30:06 -0800 (PST)
Message-ID: <3d638bd465fb604ef01c1dc5a5a92617b90482d8.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 1/3] libbpf:
 __attribute__((btf_decl_tag("..."))) for btf dump in C format
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com
Date:   Fri, 11 Nov 2022 23:30:03 +0200
In-Reply-To: <CAEf4Bzbnd2UOT9Mko+0Yf9Kgsn-sGsV43MKExYjEaYbWg0WgZg@mail.gmail.com>
References: <20221110144320.1075367-1-eddyz87@gmail.com>
         <20221110144320.1075367-2-eddyz87@gmail.com>
         <CAEf4Bzbnd2UOT9Mko+0Yf9Kgsn-sGsV43MKExYjEaYbWg0WgZg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 2022-11-11 at 10:58 -0800, Andrii Nakryiko wrote:
> On Thu, Nov 10, 2022 at 6:43 AM Eduard Zingerman <eddyz87@gmail.com> wrot=
e:
>=20
>=20
> [...]
>=20
> >  static int btf_dump_push_decl_stack_id(struct btf_dump *d, __u32 id)
> > @@ -1438,9 +1593,12 @@ static void btf_dump_emit_type_chain(struct btf_=
dump *d,
> >                 }
> >                 case BTF_KIND_FUNC_PROTO: {
> >                         const struct btf_param *p =3D btf_params(t);
> > +                       struct decl_tag_array *decl_tags =3D NULL;
> >                         __u16 vlen =3D btf_vlen(t);
> >                         int i;
> >=20
> > +                       hashmap__find(d->decl_tags, id, &decl_tags);
> > +
> >                         /*
> >                          * GCC emits extra volatile qualifier for
> >                          * __attribute__((noreturn)) function pointers.=
 Clang
>=20
> should there be btf_dump_emit_decl_tags(d, decl_tags, -1) somewhere
> here to emit tags of FUNC_PROTO itself?

Actually, I have not found a way to attach decl tag to a FUNC_PROTO itself:

  typedef void (*fn)(void) __decl_tag("..."); // here tag is attached to ty=
pedef
  struct foo {
    void (*fn)(void) __decl_tag("..."); // here tag is attached to a foo.fn=
 field
  }
  void foo(void (*fn)(void) __decl_tag("...")); // here tag is attached to =
FUNC foo
                                                // parameter but should pro=
bably=20
                                                // be attached to
                                                // FUNC_PROTO parameter ins=
tead.

Also, I think that Yonghong had reservations about decl tags attached to
FUNC_PROTO parameters.
Yonghong, could you please comment?

>=20
> > @@ -1481,6 +1639,7 @@ static void btf_dump_emit_type_chain(struct btf_d=
ump *d,
> >=20
> >                                 name =3D btf_name_of(d, p->name_off);
> >                                 btf_dump_emit_type_decl(d, p->type, nam=
e, lvl);
> > +                               btf_dump_emit_decl_tags(d, decl_tags, i=
);
> >                         }
> >=20
> >                         btf_dump_printf(d, ")");
> > @@ -1896,6 +2055,7 @@ static int btf_dump_var_data(struct btf_dump *d,
> >                              const void *data)
> >  {
> >         enum btf_func_linkage linkage =3D btf_var(v)->linkage;
> > +       struct decl_tag_array *decl_tags =3D NULL;
> >         const struct btf_type *t;
> >         const char *l;
> >         __u32 type_id;
> > @@ -1920,7 +2080,10 @@ static int btf_dump_var_data(struct btf_dump *d,
> >         type_id =3D v->type;
> >         t =3D btf__type_by_id(d->btf, type_id);
> >         btf_dump_emit_type_cast(d, type_id, false);
> > -       btf_dump_printf(d, " %s =3D ", btf_name_of(d, v->name_off));
> > +       btf_dump_printf(d, " %s", btf_name_of(d, v->name_off));
> > +       hashmap__find(d->decl_tags, id, &decl_tags);
> > +       btf_dump_emit_decl_tags(d, decl_tags, -1);
> > +       btf_dump_printf(d, " =3D ");
> >         return btf_dump_dump_type_data(d, NULL, t, type_id, data, 0, 0)=
;
> >  }
> >=20
> > @@ -2421,6 +2584,8 @@ int btf_dump__dump_type_data(struct btf_dump *d, =
__u32 id,
> >         d->typed_dump->skip_names =3D OPTS_GET(opts, skip_names, false)=
;
> >         d->typed_dump->emit_zeroes =3D OPTS_GET(opts, emit_zeroes, fals=
e);
> >=20
> > +       btf_dump_assign_decl_tags(d);
> > +
>=20
> I'm actually not sure we want those tags on binary data dump.
> Generally data dump is not type definition dump, so this seems
> unnecessary, it will just distract from data itself. Let's drop it for
> now? If there would be a need we can add it easily later.

Well, this is the only place where VARs are processed, removing this code
would make the second patch in a series useless.
But I like my second patch in a series :) should I just drop it?
I can extract it as a separate series and simplify some of the existing
data dump tests.

>=20
> >         ret =3D btf_dump_dump_type_data(d, NULL, t, id, data, 0, 0);
> >=20
> >         d->typed_dump =3D NULL;
> > --
> > 2.34.1
> >=20

