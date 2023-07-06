Return-Path: <bpf+bounces-4290-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FCB474A369
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 19:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50CA21C20B75
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 17:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206EBC120;
	Thu,  6 Jul 2023 17:48:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E162B8C18
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 17:48:31 +0000 (UTC)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 127181703
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 10:48:30 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b6f97c7115so14498641fa.2
        for <bpf@vger.kernel.org>; Thu, 06 Jul 2023 10:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688665708; x=1691257708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+rYVZ8lAgbOkPPCaIutfl5+MfRqrc5ItRB47BNXPWFo=;
        b=DTDbizoPKhywoMOP2qGEwuCU2hWzN2FBeB9CdUoG6JrGAbtmcoae6BwiKSbXX9gFRT
         +NFHW/GyeT2NRmAUNtvjaKBELk/PDuE225B0ZT1iDftnp53MR3C0L0eG98RGfTDQGXfj
         7TYPfvLA4KRB7cZIHys8GzCJ/zjnegatQSfltFTjb2KwkprslYBUxMdJChZAvlq50UL1
         RYqp4mFvncj20kIlM73iCa8iU54qoyAaa+vS7NWnj03qdar6CbBL1GrWiadCqjhBjHCb
         7dQhgkULbntJmci5/LWYAb5tRARYNAUmMl4USymKeRgIeA742zc0kaTxVlFvNutTs5s2
         hhuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688665708; x=1691257708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+rYVZ8lAgbOkPPCaIutfl5+MfRqrc5ItRB47BNXPWFo=;
        b=aAY8wuDf4l5Cf+plc/lj1VfvNt9QgWlBZoosMuZRVTZL3dsW+l3KNKOG52BHSttiVu
         dud13ObGS6Vl4/RPs52OeCQMEwP5cW2y9Msxhdu/CpWoN2jsUW4thrXRfohA+Pibzxtx
         xsiUFjNAKDml6XL2ndk+i4IzqDvZaLah3175cj+PhCsDI2ilCGZpU0mZhECxCqsI3/6m
         6I2qSYVz57UAkmeFAyZHWQVyLmWY0oZCC2esDamduhYSqWKD+BGCnjXmEB7YuRpMXeBW
         V3uuHNJmYEYt0JeTX0jVz5XJsBqfljIXmETusTrJPdBBjN48r4TOTjhog1BhWtMx0IZR
         0WQg==
X-Gm-Message-State: ABy/qLYwrU+7zhN+rQg5nERg/OpOqm9QXAs63DbwJPdbouXFHAD/xWh1
	iWq6rUN+aKAlfngf+cVYy66j/8vsFSXwlIqmQFA=
X-Google-Smtp-Source: APBJJlHNytD1t0QILQduerikXLUZ6L68PCcL8P7lQW0yDhhOc1vKCbRzzpk6iTLvUYSXOuqOkXE7s+WelJ1lW8+kemo=
X-Received: by 2002:a2e:80d2:0:b0:2b6:e2e4:7d9a with SMTP id
 r18-20020a2e80d2000000b002b6e2e47d9amr1842551ljg.38.1688665708071; Thu, 06
 Jul 2023 10:48:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230705160139.19967-1-aspsk@isovalent.com> <20230705160139.19967-7-aspsk@isovalent.com>
 <CAADnVQLZMb3XqJFp8Oaz-83RzVHTV3EwJymKC817ekC57CNMBg@mail.gmail.com>
 <ZKZUpW5QeOviHCne@zh-lab-node-5> <CAADnVQJ4-j6bD9vicVi245cRMWijbW=jQhK5ioczBC-7FCi06A@mail.gmail.com>
 <ZKb9TjHX3GV35Yol@zh-lab-node-5>
In-Reply-To: <ZKb9TjHX3GV35Yol@zh-lab-node-5>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 6 Jul 2023 10:48:16 -0700
Message-ID: <CAADnVQJd9wb4_DumPdw31k6MCPQUy+T-ae6hFfGBpnX7tVLmKQ@mail.gmail.com>
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

On Thu, Jul 6, 2023 at 10:42=E2=80=AFAM Anton Protopopov <aspsk@isovalent.c=
om> wrote:
>
> >
> > Don't you want to do:
> >  val =3D bpf_map_lookup_elem(map, ...);
> >  cnt =3D bpf_map_sum_elem_count(map);
> >
> > and that's the main use case ?
>
> Not sure I understand what this ^ use case is...
>
> Our primary use case is to [periodically] get the number of elements from=
 the
> user space. We can do this using an iterator as you've suggested and what=
 is
> tested in the added selftest.

Hmm. During the last office hours John explained that he needs to raise
alarm to user space when the map is close to full capacity.
Currently he's doing it with his own per-map counters implemented
in a bpf prog.
I'd expect the alarm to be done inline with updates to the counters.
If you scan maps from user space every second or so there is a chance
the spike in usage will be missed.

If we're adding map counters they should be usable not only via iterators.

John,
did I describe your use case correctly?

