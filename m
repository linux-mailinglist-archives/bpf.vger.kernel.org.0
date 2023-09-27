Return-Path: <bpf+bounces-10914-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B26E7AF810
	for <lists+bpf@lfdr.de>; Wed, 27 Sep 2023 04:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 30ACC281C61
	for <lists+bpf@lfdr.de>; Wed, 27 Sep 2023 02:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36AF25678;
	Wed, 27 Sep 2023 02:17:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6485E2579
	for <bpf@vger.kernel.org>; Wed, 27 Sep 2023 02:17:55 +0000 (UTC)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1DD7AD32
	for <bpf@vger.kernel.org>; Tue, 26 Sep 2023 19:17:53 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1dcf357deedso3776369fac.0
        for <bpf@vger.kernel.org>; Tue, 26 Sep 2023 19:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695781073; x=1696385873; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xC9q6QFtGILXdxXCG4OCqW/58o5PwiJdhaEmxZbXZmM=;
        b=mfmJk9g/pxN7BhKo8sYYlnZOmmswVdOi24ejtaRmJvwW8/VJZ2jTiGPkZkfdyOLeq+
         ElguwREElPYq/qJm2yNEiIDunl2nUz4uMAF68ZTMcEwQKgUBWvz5tfj95L0KssPsL+3K
         X9NsSKeJeGPIat3ufVM4ukiJ5Yk9eIOTh2Rqvzef3CUWsfPo6ywgU0t5Ks5zF1rI2+XY
         kO1bYwaRLi0NG6BQdf+4Rmm+6BXtPyg49lEpo9Co1qfRmpsQw9Ujwj6D5L805YBuwqIx
         IDwP8M3DiUvWgXNVYQ0UTGWnr0zJUsdVi9/rvNdkQNgfHsscY9P260FW6yn0kVnSuufh
         skug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695781073; x=1696385873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xC9q6QFtGILXdxXCG4OCqW/58o5PwiJdhaEmxZbXZmM=;
        b=FktmW2Py+LDrhPb2gNVFRemXVeCyXlnVbncf47MvcieTSEWJ1QZueZTgSLbPoKyUl0
         pdSxdjNNqWpps8VUWJukqiX/O9vgN7W+s4+Fzqnya4oz1JzPJ/2WdzCUNhnHnC8DW9w8
         KL6xwFa+BvgCsdxPjb1n65kqxYWiT7pcRo3anSqrjyfXPzOGAckT2WwHXoOm2ZsriBKu
         95UgZwtZWVPO5XE6NeEwJh+9r4pByXntg+dilqBBZZwhuB/dhYh9rx1+4ZIzaA6NU4M6
         nWX/ITV2d0pLI08qE4MkpxlL1Lnw3CZDBY3iWj013C0Mox436wh8DTB7K/SYXzQ5dU3J
         yP7g==
X-Gm-Message-State: AOJu0YwAEuyOiXM+01eWl7Ds3LbTJ7N/B3xPFxYps18ubiH7fejy38Nx
	ICKnTiNiSAa/P5TvB5f/iRgLQoHGbPNp8dTQWr4=
X-Google-Smtp-Source: AGHT+IHGcQ/Q3S6KD5FXpQ82orEWb5LA6ZZx3FLc/tjGLk3lwjHtOucIBpY3DYgytTNMWJ09gS97EqXyprcMZx0kpdo=
X-Received: by 2002:a05:6870:c1ce:b0:1b7:308e:6cd9 with SMTP id
 i14-20020a056870c1ce00b001b7308e6cd9mr1025779oad.5.1695781072897; Tue, 26 Sep
 2023 19:17:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230925025722.46580-1-hengqi.chen@gmail.com> <CAEf4BzYXwJcT0Ofetjw1qxKkXspqwcwaRkR=8xitJARirTrQgw@mail.gmail.com>
In-Reply-To: <CAEf4BzYXwJcT0Ofetjw1qxKkXspqwcwaRkR=8xitJARirTrQgw@mail.gmail.com>
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Wed, 27 Sep 2023 10:17:42 +0800
Message-ID: <CAEyhmHQf06tseMOy7ZJHv9OiG15KD37-8Dth0+cKq3qcjeYdsA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Allow Golang symbols in uprobe secdef
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 26, 2023 at 7:15=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Sun, Sep 24, 2023 at 8:19=E2=80=AFPM Hengqi Chen <hengqi.chen@gmail.co=
m> wrote:
> >
> > Golang symbols in ELF files are different from C/C++
> > which contains special characters like '*', '(' and ')'.
> > With generics, things get more complicated, there are
> > symbols like:
> >
> >   github.com/cilium/ebpf/internal.(*Deque[go.shape.interface {
> >    Format(fmt.State, int32); TypeName() string;
> >   github.com/cilium/ebpf/btf.copy() github.com/cilium/ebpf/btf.Type
> >   }]).Grow
> >
> > Add " ()*,-/;[]{}" (in alphabetical order) to support matching
> > against such symbols. Note that ']' and '-' should be the first
> > and last characters in the %m range as sscanf required.
> >
> > A working example can be found at this repo ([0]).
> >
> >   [0]: https://github.com/chenhengqi/libbpf-go-symbols
> >
> > Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> > Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> > Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> > ---
> >  tools/lib/bpf/libbpf.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index b4758e54a815..de0e068195ab 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -11630,7 +11630,7 @@ static int attach_uprobe(const struct bpf_progr=
am *prog, long cookie, struct bpf
> >
> >         *link =3D NULL;
> >
> > -       n =3D sscanf(prog->sec_name, "%m[^/]/%m[^:]:%m[a-zA-Z0-9_.@]+%l=
i",
> > +       n =3D sscanf(prog->sec_name, "%m[^/]/%m[^:]:%m[]a-zA-Z0-9 ()*,.=
/;@[_{}-]+%li",
>
> This is almost incomprehensible now... wouldn't it be clearer to just
> have a catch-all %ms at the end, and then internally checking if we
> have '+%li'? I.e., once we match everything after
> "uprobe/<path-to-binary>:", we can strchr('+'), if found, try
> sscanf("%li") on the remaining suffix. If that doesn't parse properly,
> then we have a choice -- either error out, or just assume that
> `+<something>` part is just a part of ELF symbol name?
>
> That way we don't hard-code any fixes set of symbols and avoid any
> future crazy adjustments.
>
> WDYT?

Sounds good. This also solves the matching of unicode identifiers.

As Jiri mentioned above, %ms won't match whitespaces,
so I am wondering if %m[^\n] is acceptable.

>
> >                    &probe_type, &binary_path, &func_name, &offset);
> >         switch (n) {
> >         case 1:
> > --
> > 2.34.1
> >

