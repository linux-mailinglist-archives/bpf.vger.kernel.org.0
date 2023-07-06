Return-Path: <bpf+bounces-4299-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0ED974A4F4
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 22:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4198281409
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 20:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B639BA26;
	Thu,  6 Jul 2023 20:33:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48322FB6
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 20:33:17 +0000 (UTC)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351021996
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 13:33:16 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b5c2433134so14483891fa.0
        for <bpf@vger.kernel.org>; Thu, 06 Jul 2023 13:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688675594; x=1691267594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h9XDePPn1L1B40GLalRpaH6UmEPAHG/iw8vce92gVlY=;
        b=XvxYHU8JTr2ciO3OBxrFtUuvmXOKnrNc0TQb+tVIUaF/J+cHRPKL7TAbDXrcX9TZMo
         3vn2YdDRDVbNcK1duECYlfAiBjlRpdIiCVKgjLALhJeknf/29/vYYcyA4lfahcTk78Tw
         b92b3YEr3+9a/yg73IVxptNAkn9NouQadwaMK0pemeSgfudH4pXffjtWZYhKNrHiji3q
         p7D9OjI5UM9InkGc1h0sYQI7NuDhF6HlJrP4dPu+S6/EpAdDjUdbHqlBx56LTVa85dtT
         rJJa1j1tD4P+Nl8ASR14B49sP+OQNOdv91Y3kKDtk00fV+e9v4UOIuRQthxy6qm2eTkl
         wBcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688675594; x=1691267594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h9XDePPn1L1B40GLalRpaH6UmEPAHG/iw8vce92gVlY=;
        b=KKDrwKDWIlqbKmCHyExGL05vVsPaPLsUyfO/ESatgO6aY6K7UdfyVO7+hLc4ZBHShd
         vC+vIl+xuwZEnqA9UxrtITVAyo3k4BvNctWzXg/UNlq61tY9LFJXpfmryMiTPJg/Tw4B
         yyOEc0/+rsIrP5iqwt+KFpLrWPpVeiQgm+fQBYYMo3o+N3qZeyzIQJGjGh0CGzh15z9B
         zdXnbhO+yiNrAlaVD7gl/XBDqHdSXZkHutI3CS+ws6k1rfP3pr4NMFDQMPzQfQCrSOjG
         PefDmCX5CVk+Twb7F0R4pFNwYxiUwJ/HAFioQkVwfK+ETbNc8Q5v9HXUwYYDdnjhkXpH
         kPGw==
X-Gm-Message-State: ABy/qLafeoyuZaiOscbtlAmziUK2QNd2MzO3DND90azn6zFiA7ET7zXF
	MGF4hzt+2eQNj26cgouCQmgEI7NTxN2/jle+RCg=
X-Google-Smtp-Source: APBJJlH3xr5vOd89otZ/C4fRHthpwoCRUsnEB0EpQQ6o4Vr6pk7m//SKAM1obLNlcILud0yzMNb6MtdHWwhpOPhjj5I=
X-Received: by 2002:a05:651c:399:b0:2b6:a0c8:fde3 with SMTP id
 e25-20020a05651c039900b002b6a0c8fde3mr2400589ljp.6.1688675594093; Thu, 06 Jul
 2023 13:33:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230705160139.19967-1-aspsk@isovalent.com> <20230705160139.19967-7-aspsk@isovalent.com>
 <CAADnVQLZMb3XqJFp8Oaz-83RzVHTV3EwJymKC817ekC57CNMBg@mail.gmail.com>
 <ZKZUpW5QeOviHCne@zh-lab-node-5> <CAADnVQJ4-j6bD9vicVi245cRMWijbW=jQhK5ioczBC-7FCi06A@mail.gmail.com>
 <ZKb9TjHX3GV35Yol@zh-lab-node-5> <CAADnVQJd9wb4_DumPdw31k6MCPQUy+T-ae6hFfGBpnX7tVLmKQ@mail.gmail.com>
 <ZKcJZt4JEKL1m8BR@zh-lab-node-5>
In-Reply-To: <ZKcJZt4JEKL1m8BR@zh-lab-node-5>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 6 Jul 2023 13:33:02 -0700
Message-ID: <CAADnVQKMPccWC4AQFA_CmCx-vjuRWygxgiVa4vNPR4K7ZMwQTg@mail.gmail.com>
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

On Thu, Jul 6, 2023 at 11:34=E2=80=AFAM Anton Protopopov <aspsk@isovalent.c=
om> wrote:
>
> On Thu, Jul 06, 2023 at 10:48:16AM -0700, Alexei Starovoitov wrote:
> > On Thu, Jul 6, 2023 at 10:42=E2=80=AFAM Anton Protopopov <aspsk@isovale=
nt.com> wrote:
> > >
> > > >
> > > > Don't you want to do:
> > > >  val =3D bpf_map_lookup_elem(map, ...);
> > > >  cnt =3D bpf_map_sum_elem_count(map);
> > > >
> > > > and that's the main use case ?
> > >
> > > Not sure I understand what this ^ use case is...
> > >
> > > Our primary use case is to [periodically] get the number of elements =
from the
> > > user space. We can do this using an iterator as you've suggested and =
what is
> > > tested in the added selftest.
> >
> > Hmm. During the last office hours John explained that he needs to raise
> > alarm to user space when the map is close to full capacity.
> > Currently he's doing it with his own per-map counters implemented
> > in a bpf prog.
> > I'd expect the alarm to be done inline with updates to the counters.
> > If you scan maps from user space every second or so there is a chance
> > the spike in usage will be missed.
> >
> > If we're adding map counters they should be usable not only via iterato=
rs.
>
> In some use cases this is ok to miss a spike in favour of not checking co=
unters
> too often. But yes, for other use cases this makes sense to add support f=
or
> const map ptr, so I will do this.

Great. Please send a follow up.
I've applied the current set.

