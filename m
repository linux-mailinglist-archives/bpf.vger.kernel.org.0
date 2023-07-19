Return-Path: <bpf+bounces-5337-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 219B0759AC2
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 18:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D05B02817AB
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 16:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF611BB37;
	Wed, 19 Jul 2023 16:30:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7B81BB3C;
	Wed, 19 Jul 2023 16:30:36 +0000 (UTC)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B6E1733;
	Wed, 19 Jul 2023 09:30:35 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b933bbd3eeso75719441fa.1;
        Wed, 19 Jul 2023 09:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689784234; x=1692376234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O7QrzdqRJDmBXPI4sTDgiqyvsQI/8XFjzdONJvE8L8g=;
        b=DPBkE0BteEojQ9L1pgfzJUzR37XAkt9HpKm7BwtrtF8of6PGpvZxXBPhOpFmK0IjdW
         RiafYe5sGrTOq6GoBXTA7YWbijO2ScxAttwCQJNQ2Kyg2yudp5SqX6rOr/aaeMKJjO/o
         vLPmNw7waaX6cavcTaBFw1UE2SNZTJUebLdM+HMKzjFCq7DLuEUYp7OMajdoWYot53qQ
         cA+ZZIh9s/VLi5bh8c9wing79nVUZuUrKKs0L2CcomqtTjo6MVLQAv+o+jZ4iKvFs4HL
         JoDhNeIXHSOpdEhSCIVivdWMegfmAtHsFxG1kedZwr0466DhuTiLOWw5FiwTK+8HjgaR
         mbhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689784234; x=1692376234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O7QrzdqRJDmBXPI4sTDgiqyvsQI/8XFjzdONJvE8L8g=;
        b=kQCsvPruM1h2Pxbsm4crpSRIr752tV2undu4CzQJTGBy2jQsVoUrePqNI4xxG+iCoA
         TS/YkeaKpplbRedTTRIcfgK7jBynx2GIO1/CmQGyH0GGuyn+gfGmxhiTChVKCQE379AP
         0hKFVuGHae62qTAmwsoNeBYQH6OtuwgUYFcpISxhf3UTpVVyznV4jHlwNsnz1Ecbvqwb
         m4wfgrT1tjYtMHr+tceYDzVAeTSRT0MbKvVslEVxHxmQyJlybZj5NxphhnR2iXBNCS6i
         dXqn9ebvBFjDDpO1BJY90BZpj9+anarSyxtvbOMil4ngL+5III7MHe3ogeUrTTgOfCfV
         MLUg==
X-Gm-Message-State: ABy/qLZeA703T9jB1lJTsp4YBWyz4XrUr9zz1WTR16LR6an+YY/xtPFS
	iPYpa56iuhPrJp6QkPYdOIyqK/YlJK2sNqp8PmU=
X-Google-Smtp-Source: APBJJlFdYqVBILwlIBca95ud/FR/YVJREdldr5HU4X4xISoRWauvA69yC39i4a8UF7K8WBU1FOQm8CjycyzIYBF5DiY=
X-Received: by 2002:a2e:9f17:0:b0:2b6:fe55:7318 with SMTP id
 u23-20020a2e9f17000000b002b6fe557318mr328753ljk.12.1689784233480; Wed, 19 Jul
 2023 09:30:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230718234021.43640-1-alexei.starovoitov@gmail.com> <dae5886a8b3b4d9f869e4f8ab3cefa96@AcuMS.aculab.com>
In-Reply-To: <dae5886a8b3b4d9f869e4f8ab3cefa96@AcuMS.aculab.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 19 Jul 2023 09:30:22 -0700
Message-ID: <CAADnVQJ+NSeVOJROKHYY1VVRDwK8Gm8jgSoRTCmbrN8XG=y3JA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf, net: Introduce skb_pointer_if_linear().
To: David Laight <David.Laight@aculab.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org" <kuba@kernel.org>, 
	"edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>, 
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "andrii@kernel.org" <andrii@kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"kernel-team@fb.com" <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 19, 2023 at 6:10=E2=80=AFAM David Laight <David.Laight@aculab.c=
om> wrote:
>
> From: Alexei Starovoitov
> > Sent: 19 July 2023 00:40
> >
> > Network drivers always call skb_header_pointer() with non-null buffer.
> > Remove !buffer check to prevent accidental misuse of skb_header_pointer=
().
> > Introduce skb_pointer_if_linear() instead.
> >
> ...
> > +static inline void * __must_check
> > +skb_pointer_if_linear(const struct sk_buff *skb, int offset, int len)
> > +{
> > +     if (likely(skb_headlen(skb) - offset >=3D len))
> > +             return skb->data + offset;
> > +     return NULL;
> > +}
>
> Shouldn't both 'offset' and 'len' be 'unsigned int' ?
>
> The check should probably be written:
>                 offset + len <=3D skb_headlen(skb)
> so that it fails if 'offset' is also large.
> (Provided 'offset + len' itself doesn't wrap.)

I agree that this style is easier to read, but
consistency with skb_header_pointer() trumps all such considerations.

