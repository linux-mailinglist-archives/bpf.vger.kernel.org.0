Return-Path: <bpf+bounces-4139-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C6B749310
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 03:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FA7C28119B
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 01:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59AEDA35;
	Thu,  6 Jul 2023 01:26:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291EA7F
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 01:26:40 +0000 (UTC)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B1D19A1
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 18:26:38 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b703caf344so1332731fa.1
        for <bpf@vger.kernel.org>; Wed, 05 Jul 2023 18:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688606797; x=1691198797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eLzQoeOkhCnKXQAxFJjSrF7aEuSUHRbXVZphkSgnl+E=;
        b=TzxF4I46afyhHbs3UW00PDsEBiJKJkjOKyRRzqqbY7t066hlzC89X8EMSi4B3skPHJ
         kiAFM8LuoPXAlnLo08xl2Lz0WgfhWTol/rYKpgV4M9JoM8+gdyXlPjKvX4NHPVmrh76s
         b+hRdp8bQj1LoeXaIsgvUxiXL9P8FDOuoNWSXtiK8vmCIIiYobKDOJj0iQN5oSVtg5Jn
         eEJtK5U/MEp1a9x7O72rW7HKifyzLwgOM+nuHQqm9VoUy07dTGiy6VKQPNaWG2FrZycU
         PYG7NpIA5J49Tlfe4pShA7J8kmo+e0pJ+PTiMrhXnoUO9z46rVQejZZYyKml0hR/8UfQ
         DbGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688606797; x=1691198797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eLzQoeOkhCnKXQAxFJjSrF7aEuSUHRbXVZphkSgnl+E=;
        b=S5h89er6Fj8vdn9z47Ug9gKs/Mt9EWxJSsJ/JxMmqmzSqZPXEVcUQT4wSmAf2rlxwn
         talN91hItv37+NAcdiQgV8juRGHBgHP+GjcKtn9ddWqkGX8eOArV2yrcrpIYlx++XteT
         ooufMZkiQ3zhLFW2DAFtypu9anoJMmokrOlkQcjbOWUwzICUxsuyS6issVzOpfLI+8c2
         T2O/Wu2+0ThhG9kzaHmhWfHLnrwQUtpHVC4kEeHLm4RF7UqPsgfPAmcaPRGPHcz+j/df
         FYPxyuVlA8Mh4AIfgewGI01xfWhmMD9iNxOkTkL1fNHqvV9UxQWkLaIKvKmfP4rm5usR
         qT7g==
X-Gm-Message-State: ABy/qLaATPFpMOUxmYYNtGkRw1yUjT4mxIy1yrYweLqG34x3qLBvuqhY
	4HEv8sb3jwPNvJJDYNjjf0Ds4bLAEleoXzRhEBo=
X-Google-Smtp-Source: APBJJlEP7O7u+mfOatSxCS/yUDJxl2Fo2x3TDJ6ZW+9dCjytaIBety6hyRzgQVg0IRXhjF/BgxCVL5CNB+lMCSNq10k=
X-Received: by 2002:a2e:b0d1:0:b0:2b5:7f93:b3b0 with SMTP id
 g17-20020a2eb0d1000000b002b57f93b3b0mr226239ljl.17.1688606796516; Wed, 05 Jul
 2023 18:26:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230705160139.19967-1-aspsk@isovalent.com> <20230705160139.19967-7-aspsk@isovalent.com>
In-Reply-To: <20230705160139.19967-7-aspsk@isovalent.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 5 Jul 2023 18:26:25 -0700
Message-ID: <CAADnVQLZMb3XqJFp8Oaz-83RzVHTV3EwJymKC817ekC57CNMBg@mail.gmail.com>
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

On Wed, Jul 5, 2023 at 9:00=E2=80=AFAM Anton Protopopov <aspsk@isovalent.co=
m> wrote:
>
> Previous commits populated the ->elem_count per-cpu pointer for hash maps=
.
> Check that this pointer is non-NULL in an existing map.
>
> Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> ---
>  tools/testing/selftests/bpf/progs/map_ptr_kern.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/progs/map_ptr_kern.c b/tools/tes=
ting/selftests/bpf/progs/map_ptr_kern.c
> index db388f593d0a..d6e234a37ccb 100644
> --- a/tools/testing/selftests/bpf/progs/map_ptr_kern.c
> +++ b/tools/testing/selftests/bpf/progs/map_ptr_kern.c
> @@ -33,6 +33,7 @@ struct bpf_map {
>         __u32 value_size;
>         __u32 max_entries;
>         __u32 id;
> +       __s64 *elem_count;
>  } __attribute__((preserve_access_index));
>
>  static inline int check_bpf_map_fields(struct bpf_map *map, __u32 key_si=
ze,
> @@ -111,6 +112,8 @@ static inline int check_hash(void)
>
>         VERIFY(check_default_noinline(&hash->map, map));
>
> +       VERIFY(map->elem_count !=3D NULL);
> +

imo that's worse than no test.
Just use kfunc here and get the real count?

