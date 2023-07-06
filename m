Return-Path: <bpf+bounces-4284-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6030774A2BF
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 19:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B684281314
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 17:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8580BBA40;
	Thu,  6 Jul 2023 17:03:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A82AD3B
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 17:03:47 +0000 (UTC)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE071BE3
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 10:03:44 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b698937f85so14994101fa.2
        for <bpf@vger.kernel.org>; Thu, 06 Jul 2023 10:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688663022; x=1691255022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5K/Yw/8Qqmmo4pyGkhICp9OFnV+JNrOw7Hd5Z1CXi6Y=;
        b=TDq5DQS1elmfDT0cjrnk7xB4+WCf8iy/FC2rpIglYMrOegwdRSiqZXKC3ciO1Q7Qs2
         CZIXeA8xMv+2AC8crw9qreX1DaREWxJ4sYjNWUeCXmAW581zUNKErJc7otAInRm8I7xk
         Dkn5QnmdnjRLsNke3va+yNOZYJfaMyl6qUOsxOU/svXysSVRnXMu3zv1mzX4IY3VI1FX
         1UqbOLUTnGfzZVMbCEwxgHXg2iIm02j8Ni5MunLfjNPChJJd83fNCYGt4/TX9Pm1n8Lq
         gHYUTZ7uSK5+Oojk841J3UysoMcsE8y5vudUFIBDFfaypdCETGQY2LxIgVeA18WrYnFy
         gv6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688663022; x=1691255022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5K/Yw/8Qqmmo4pyGkhICp9OFnV+JNrOw7Hd5Z1CXi6Y=;
        b=MbaPIUgOnnghJCwch3eVczCpgZVtrZOpZHh+um7wF36dpUm2YxDlA2hu2MU+zw+5pf
         56+0lgm0trKIpxZCCFdljP9RVXuLX8Pehm/XTLh+2a4ajHydQS3J6EClcEPC8X1GfqSv
         c5r/aZ8iOWpTZtSd9+Hzo2XVwfQJBFbfotivKaqDaYw9DLZV9wg16QpovmwB6vJUeCTO
         38dbCtVUlfB9P1aq+tXjf5KLIc/RXhrzP2xmiH6YvYgjuLdBxzPIO5ffFmkZ1ukpugmP
         li9oWooXcsMb0VejkYe3y9PSfceGj5QOoMSJRbvf4fHJz/HXTAubgyQfqR81OEQ/44bj
         nNsw==
X-Gm-Message-State: ABy/qLYQB3Xt6fTe118PijlK3eKMT1TsLm04ib2BkWq7kl/GAgO2/EII
	jUUuj22/vCjUWZYpmlKdhG8Fme+5U+1lLgh+m1w=
X-Google-Smtp-Source: APBJJlF7VOdWpdX5QIaMInuEuPp09Bvs3Q4078DA9rW4JfpOQ5wKjKof0XwKrl8xbNa7DgvJVbv8WgFOXHCTvkcwZcY=
X-Received: by 2002:a2e:6e19:0:b0:2b6:f009:d1b with SMTP id
 j25-20020a2e6e19000000b002b6f0090d1bmr1918150ljc.49.1688663021891; Thu, 06
 Jul 2023 10:03:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230705160139.19967-1-aspsk@isovalent.com> <20230705160139.19967-7-aspsk@isovalent.com>
 <CAADnVQLZMb3XqJFp8Oaz-83RzVHTV3EwJymKC817ekC57CNMBg@mail.gmail.com> <ZKZUpW5QeOviHCne@zh-lab-node-5>
In-Reply-To: <ZKZUpW5QeOviHCne@zh-lab-node-5>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 6 Jul 2023 10:03:30 -0700
Message-ID: <CAADnVQJ4-j6bD9vicVi245cRMWijbW=jQhK5ioczBC-7FCi06A@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 6/6] selftests/bpf: check that ->elem_count is
 non-zero for the hash map
To: Anton Protopopov <aspsk@isovalent.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 5, 2023 at 10:42=E2=80=AFPM Anton Protopopov <aspsk@isovalent.c=
om> wrote:
>
> On Wed, Jul 05, 2023 at 06:26:25PM -0700, Alexei Starovoitov wrote:
> > On Wed, Jul 5, 2023 at 9:00=E2=80=AFAM Anton Protopopov <aspsk@isovalen=
t.com> wrote:
> > >
> > > Previous commits populated the ->elem_count per-cpu pointer for hash =
maps.
> > > Check that this pointer is non-NULL in an existing map.
> > >
> > > Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> > > ---
> > >  tools/testing/selftests/bpf/progs/map_ptr_kern.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/tools/testing/selftests/bpf/progs/map_ptr_kern.c b/tools=
/testing/selftests/bpf/progs/map_ptr_kern.c
> > > index db388f593d0a..d6e234a37ccb 100644
> > > --- a/tools/testing/selftests/bpf/progs/map_ptr_kern.c
> > > +++ b/tools/testing/selftests/bpf/progs/map_ptr_kern.c
> > > @@ -33,6 +33,7 @@ struct bpf_map {
> > >         __u32 value_size;
> > >         __u32 max_entries;
> > >         __u32 id;
> > > +       __s64 *elem_count;
> > >  } __attribute__((preserve_access_index));
> > >
> > >  static inline int check_bpf_map_fields(struct bpf_map *map, __u32 ke=
y_size,
> > > @@ -111,6 +112,8 @@ static inline int check_hash(void)
> > >
> > >         VERIFY(check_default_noinline(&hash->map, map));
> > >
> > > +       VERIFY(map->elem_count !=3D NULL);
> > > +
> >
> > imo that's worse than no test.
> > Just use kfunc here and get the real count?
>
> Then, as I mentioned in the previous version, I will have to teach kfuncs=
 to
> recognize const_ptr_to_map args just for the sake of this selftest, while=
 we
> already testing all functionality in the new selftest for test_maps. So I=
 would
> just omit this one. Or am I missing something?


Don't you want to do:
 val =3D bpf_map_lookup_elem(map, ...);
 cnt =3D bpf_map_sum_elem_count(map);

and that's the main use case ?

So teaching the verifier to understand that const_ptr_to_map matches
BTF 'struct bpf_map *' is essential ?

