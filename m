Return-Path: <bpf+bounces-8290-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC894784A39
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 21:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6D64281178
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 19:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2B234CC7;
	Tue, 22 Aug 2023 19:20:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636A41DDE3
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 19:20:21 +0000 (UTC)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2975AE4E
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 12:20:15 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2bcc4347d2dso30338281fa.0
        for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 12:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692732013; x=1693336813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g5/vSd4Bct9GAuKN8kUhc5W35WDRpB3uODdzaZy5L+Y=;
        b=hxyOJ/hMTJjDllC6PYRkwEiMBb4FFgUw1Z59qOvNXSQk/92SsmAeEE/D5TU3upYk0J
         AgeGEy4b1k9FWWDLFc67Qu8AmToHycM/ObOUAWHVpSLvgIo0teI9hnNm8JI7LAvcEJXN
         rQwN3gvClCqt5+xsExrZuRnQb8RYGRhxk5Pb1x6NjFye2VqPLt2rxIYfcl3p50+xFiR+
         3OBa0UhoKpQwiqz6w/uJQPvSOG3Ik8tNdY80V6Lixj3WryzqoDLCIdozBKHARoqwG4Oc
         SxEmM0F+Un4Wc0ltRAOxCClhe4gAH3+r+b1665GFZwBQBqytFsV0X82Pi3GqCU9yTyiY
         qQ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692732013; x=1693336813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g5/vSd4Bct9GAuKN8kUhc5W35WDRpB3uODdzaZy5L+Y=;
        b=i9/Ow8h37OgN6xrJfdfGnrf+dSwqlT5Z4LuiEwc+sIae7qTU0+fpjlR6ZvNqTzeq7J
         FKurzQr684qjj6aZjbER9OSnaC/c2JV2RmJ94qzKWCcdwW18KAFtloE20867I9GCJH/J
         gW4OyQwnc6CrlSaPnI+fpgGEqBQhVjNvJe8/qBBg7GiUy2k+G1r3rQar3sovpFIKHmSP
         KiwZcp99RyLrE/f6eGNbPx94+P7uVOjRQ8jWq3x1ZXZ6gNI2n4XlBoehQ7Vg0Aa+FYJZ
         CqGo36d4UgkdFsuwN+xE8841NlJVwN3j+Xra3/wUljU18fgv7/TzPvSwKj/+TFi1657b
         7jQA==
X-Gm-Message-State: AOJu0YzDQi6uJu9dKvwRini466NzZ4j6niNAa8MLEOnfvkoOasVNgYEy
	AEKJCJejivFo0x8nWoX/eo/nX24sI0BK/JgNMgk=
X-Google-Smtp-Source: AGHT+IF+EPSHoQjfILESUMfwFkcUiVbUbyPtRR9kOUlRUke9zgczDUmQmrUW//yNoUK9yAtO8528NY9ur3EKL439X6U=
X-Received: by 2002:a2e:9245:0:b0:2bb:99fa:175f with SMTP id
 v5-20020a2e9245000000b002bb99fa175fmr7829228ljg.24.1692732013094; Tue, 22 Aug
 2023 12:20:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230809114116.3216687-1-memxor@gmail.com> <20230809114116.3216687-13-memxor@gmail.com>
 <CAADnVQJoNM7iNfhCesw0gygYtOsW-iS1AbRythfX5ent1BAtwA@mail.gmail.com> <CAP01T74JHcAn92AUoaNXyWAOmdzM4fWbvRQp42Bt-HwWVyV_Dw@mail.gmail.com>
In-Reply-To: <CAP01T74JHcAn92AUoaNXyWAOmdzM4fWbvRQp42Bt-HwWVyV_Dw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 22 Aug 2023 12:20:01 -0700
Message-ID: <CAADnVQLuTZp8VaFF28k-Yc78xpThxBf3tN+oadmWq8D2kmUCwQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 12/14] libbpf: Add support for custom
 exception callbacks
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
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

On Tue, Aug 22, 2023 at 9:58=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Tue, 22 Aug 2023 at 22:05, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Wed, Aug 9, 2023 at 4:44=E2=80=AFAM Kumar Kartikeya Dwivedi <memxor@=
gmail.com> wrote:
> > >
> > > Add support to libbpf to append exception callbacks when loading a
> > > program. The exception callback is found by discovering the declarati=
on
> > > tag 'exception_callback:<value>' and finding the callback in the valu=
e
> > > of the tag.
> >
> > ...
> >
> > > +       /* After adding all programs, now pair them with their except=
ion
> > > +        * callbacks if specified.
> > > +        */
> > > +       if (!kernel_supports(obj, FEAT_BTF_DECL_TAG))
> > > +               goto out;
> > > +out:
> >
> > The above looks odd. Accidental leftover?
> >
>
> Oops, yes. I have dropped it now.
>
> > >         return 0;
> > >  }
> > >
> > > @@ -3137,6 +3148,80 @@ static int bpf_object__sanitize_and_load_btf(s=
truct bpf_object *obj)
> > >                 }
> > >         }
> > >
> > > +       if (!kernel_supports(obj, FEAT_BTF_DECL_TAG))
> > > +               goto skip_exception_cb;
> > > +       for (i =3D 0; i < obj->nr_programs; i++) {
> > > +               struct bpf_program *prog =3D &obj->programs[i];
> > > +               int j, k, n;
> > > +
> > > +               if (prog_is_subprog(obj, prog))
> > > +                       continue;
> > > +               n =3D btf__type_cnt(obj->btf);
> > > +               for (j =3D 1; j < n; j++) {
> > > +                       const char *str =3D "exception_callback:", *n=
ame;
> >
> > On the first read of this patch and corresponding kernel support
> > I started doubting my earlier suggestion to use decl_tag and
> > reconsidered going back to fake bpf_register_except_cb() call,
>
> This is exactly what I thought when I realised it's not that simple
> when implementing it :).
>
> > but after sleeping on it I think it is a useful extension for both
> > kernel and libbpf to support such tagging.
> > We might specify ctors and dtors with decl_tag in the future
> > and other various callbacks that are never explicitly referenced
> > in bpf_call, ld_imm64 or other bpf insns.
> > So having libbpf and kernel support such tagging will help in the long =
run.
> > It's not going to be limited to exceptions.
> > Despite the extra complexity this is a good step forward.
> >
>
> I agree. This same code can also be reused to establish an edge from
> one BTF type to some other BTF type (by name).
> function -> exception_cb. struct -> ctor, struct -> dtor etc.
>
> I did have some questions though.
> First of all this is explicitly an unstable feature. How do we feel
> about putting related support for it in libbpf and making breaking
> changes later?
> Will the expectation be to pair the libbpf with its corresponding
> kernel release to use such features? Or do we have to make the changes
> in a backwards compatible fashion?

We should always do backwards compatible changes in both kernel and libbpf,
but sooner or later we might hit an issue where we would have to break thin=
gs.
At that time the special prefix won't save us, so...

>
> Secondly, due to proliferation of BTF tag usage, do you think it's
> time we reserve a namespace for all tags that would be recognized by
> the verifier? E.g. require all of them to be prefixed with "bpf."
> similar to "llvm." etc.? Since they are simply attributes for a
> specific BTF type (or component of a type).
> It may be too late for some BTF tags, but we could do better going forwar=
d.
>
> It may also allow us to indicate that a tag is experimental until its
> effect on the program becomes stabilized. E.g.
> bpf.experimental.exception_callback instead of exception_callback? Or
> do you feel it's unnecessary?

... I don't think any of that is necessary.
Whether btf tag is prefixed with "exception_callback:" or
"bpf.experimental.debug.exception_callback:" we will be doing the same thin=
g.
We'll keep backward compat if trade-offs allow.

