Return-Path: <bpf+bounces-8280-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51637784816
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 18:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83ADD1C20B5D
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 16:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE052B563;
	Tue, 22 Aug 2023 16:58:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35E22B548
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 16:58:47 +0000 (UTC)
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672CBD7
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 09:58:46 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id 4fb4d7f45d1cf-523bf06f7f8so5681400a12.1
        for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 09:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692723525; x=1693328325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2IjXkkOfq0T1/OkJJrVxQm2BP7EJKT8mageE4OWQgUI=;
        b=H0NR8mIz2RWO+xrZ0NhfVkRfxLPwqf/gXwYdOv7jihHfBHlBo1/AvDc3pAOq9BKamW
         f0Om+dMyQxom5Lq8ujoH63e4WWYo52pM99xRpxqqQVRZPydcaflibTpLFieN6Ckz/ruE
         G7PX7fWmIcU/9NiwK9wD3uig8NiT6hGFSXpqKDNNX21wUwlYw8uIqqbysTsbyHQHS9yP
         XVe9FVI1IewW//nBmWyEc0tjW1vO3fWr9UBqAdcEb1ffYIBpEpO4Y9j0wc8/fwihvfE2
         V+ijDuLW9wUtBw26xuDHQLrBY9MxvM2M/NWv4xFmMaaHKBfmTXt2W0oE8z6RfHCMto4i
         cs+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692723525; x=1693328325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2IjXkkOfq0T1/OkJJrVxQm2BP7EJKT8mageE4OWQgUI=;
        b=dDXIcIY8iJjdNB3xsB6Y3A5f3x2nW6dOhG2Rbm5dbaESnRxKY1g/ES1jhGqhg9cBm1
         262uA9OClZt7v0trSuvcqbRmIV8ZjvzAf6QFhXlVH4ca74aw+qBRsRA4SmmLRYLCTH8e
         Kj3feY5OPEpfOkk/I22Co4WvUSSfB6kgwTAd7GGvBp3t/TutcReJHa8xq5cWFZhzz+QC
         bEyor5K4e4g4d09Q2QHOmgj9ed09r5Vz9oZpqFBs5wg0WwyEMbOkvVNu0BxGgAC/zhWS
         HkfSxxfs/oszdX64eO0z0NEx3JB3vg20ENzJPHeH5VYRu0h6Gd3Ex1gt6Up+9SAoqvd/
         kJQw==
X-Gm-Message-State: AOJu0Yyp5nQFwr0OZ44RaMCstaMxcmJzeWcTj4a4uGRFzDRRvy4vpb0d
	7Cutb7QQSL4jWatGqd37j60BYiTGODZRbntuwRk=
X-Google-Smtp-Source: AGHT+IEo66p/ed+czlJQB4jKPOMjcC6kiEu4d6Gd3WJPYnYVKkha1lHFwiS4hUG9HKyHN4xzA/HvNOxfzja0UAKs8sY=
X-Received: by 2002:aa7:ca48:0:b0:525:4ea3:a373 with SMTP id
 j8-20020aa7ca48000000b005254ea3a373mr7393043edt.29.1692723524654; Tue, 22 Aug
 2023 09:58:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230809114116.3216687-1-memxor@gmail.com> <20230809114116.3216687-13-memxor@gmail.com>
 <CAADnVQJoNM7iNfhCesw0gygYtOsW-iS1AbRythfX5ent1BAtwA@mail.gmail.com>
In-Reply-To: <CAADnVQJoNM7iNfhCesw0gygYtOsW-iS1AbRythfX5ent1BAtwA@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 22 Aug 2023 22:28:08 +0530
Message-ID: <CAP01T74JHcAn92AUoaNXyWAOmdzM4fWbvRQp42Bt-HwWVyV_Dw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 12/14] libbpf: Add support for custom
 exception callbacks
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, 
	David Vernet <void@manifault.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 22 Aug 2023 at 22:05, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Aug 9, 2023 at 4:44=E2=80=AFAM Kumar Kartikeya Dwivedi <memxor@gm=
ail.com> wrote:
> >
> > Add support to libbpf to append exception callbacks when loading a
> > program. The exception callback is found by discovering the declaration
> > tag 'exception_callback:<value>' and finding the callback in the value
> > of the tag.
>
> ...
>
> > +       /* After adding all programs, now pair them with their exceptio=
n
> > +        * callbacks if specified.
> > +        */
> > +       if (!kernel_supports(obj, FEAT_BTF_DECL_TAG))
> > +               goto out;
> > +out:
>
> The above looks odd. Accidental leftover?
>

Oops, yes. I have dropped it now.

> >         return 0;
> >  }
> >
> > @@ -3137,6 +3148,80 @@ static int bpf_object__sanitize_and_load_btf(str=
uct bpf_object *obj)
> >                 }
> >         }
> >
> > +       if (!kernel_supports(obj, FEAT_BTF_DECL_TAG))
> > +               goto skip_exception_cb;
> > +       for (i =3D 0; i < obj->nr_programs; i++) {
> > +               struct bpf_program *prog =3D &obj->programs[i];
> > +               int j, k, n;
> > +
> > +               if (prog_is_subprog(obj, prog))
> > +                       continue;
> > +               n =3D btf__type_cnt(obj->btf);
> > +               for (j =3D 1; j < n; j++) {
> > +                       const char *str =3D "exception_callback:", *nam=
e;
>
> On the first read of this patch and corresponding kernel support
> I started doubting my earlier suggestion to use decl_tag and
> reconsidered going back to fake bpf_register_except_cb() call,

This is exactly what I thought when I realised it's not that simple
when implementing it :).

> but after sleeping on it I think it is a useful extension for both
> kernel and libbpf to support such tagging.
> We might specify ctors and dtors with decl_tag in the future
> and other various callbacks that are never explicitly referenced
> in bpf_call, ld_imm64 or other bpf insns.
> So having libbpf and kernel support such tagging will help in the long ru=
n.
> It's not going to be limited to exceptions.
> Despite the extra complexity this is a good step forward.
>

I agree. This same code can also be reused to establish an edge from
one BTF type to some other BTF type (by name).
function -> exception_cb. struct -> ctor, struct -> dtor etc.

I did have some questions though.
First of all this is explicitly an unstable feature. How do we feel
about putting related support for it in libbpf and making breaking
changes later?
Will the expectation be to pair the libbpf with its corresponding
kernel release to use such features? Or do we have to make the changes
in a backwards compatible fashion?

Secondly, due to proliferation of BTF tag usage, do you think it's
time we reserve a namespace for all tags that would be recognized by
the verifier? E.g. require all of them to be prefixed with "bpf."
similar to "llvm." etc.? Since they are simply attributes for a
specific BTF type (or component of a type).
It may be too late for some BTF tags, but we could do better going forward.

It may also allow us to indicate that a tag is experimental until its
effect on the program becomes stabilized. E.g.
bpf.experimental.exception_callback instead of exception_callback? Or
do you feel it's unnecessary?

> > +static int
> > +bpf_object__append_subprog_code(struct bpf_object *obj, struct bpf_pro=
gram *main_prog,
> > +                               struct bpf_program *subprog)
> > +{
>
> Please split this refactoring into a separate patch for ease of review.

Ack, will do.

