Return-Path: <bpf+bounces-3860-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D843E7458B6
	for <lists+bpf@lfdr.de>; Mon,  3 Jul 2023 11:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F077B1C2088D
	for <lists+bpf@lfdr.de>; Mon,  3 Jul 2023 09:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8700D441F;
	Mon,  3 Jul 2023 09:46:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C32320F5
	for <bpf@vger.kernel.org>; Mon,  3 Jul 2023 09:46:14 +0000 (UTC)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F4EE5D
	for <bpf@vger.kernel.org>; Mon,  3 Jul 2023 02:46:11 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-51d9a925e9aso5353694a12.0
        for <bpf@vger.kernel.org>; Mon, 03 Jul 2023 02:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1688377570; x=1690969570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RAVcfp0GiSAt76fo4gLjijfKkWn98YypFzYe/HtvOKU=;
        b=HD95sOKgKpvDJjMobg5G+wIZgo1K7nnWBpuhskATho6HC5AoGzaZi8rRmPIxXemMq2
         o900X+GzpDo2XZJD199KKY9MrfZHJFr1QtuwRd07VlpmXVZUTLfY0LLTq3xJYVCf/a4/
         /0Le0hGJ5S4GMofEHiKUfaE6g50i0psznpRYu0R6MrOjBoTFVXnIkMsSkcUuBrWx8DBw
         oBHpe79OG2ppm+LVFsp/ULOh1mU+SX9eS6o2rIB95lTdmDBUNaDrUUfwMUNKiKzd7Zv3
         Tk8Lbpw0bJDK7E0+tJ9vUBc6XdoMDUaVABlzzlWA1H71sDEgy4C5RdTlA38Ni0SAY8p1
         A+Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688377570; x=1690969570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RAVcfp0GiSAt76fo4gLjijfKkWn98YypFzYe/HtvOKU=;
        b=KDfnOk19thDFontBz4c4Swh1/vBaypogNN/HJnmiQfzWIa0F2QOyAcr3f1y2J8kwoS
         P30O36M2gbfVx5m9OrpM7YDYHTXjgSZXMjhwITE6hY14UWeiUqCJ1wAFSvmIPLyhl7rf
         sZD0Girc3eH4aD3ZC/MdbEGC2gS3mTz5hRnAF3hqh0QxEWFWpL3hH1DUcsnH74nP2Psf
         gtEpQA07UvvSUUdAGZ1b+s6XSuQblUH3YGVlhm7lQdaG3jT8Jq3HY6AEwmL1d/PArf3P
         GLPsEQWabC0RUfnWltoYwO5gW6JCotsgeQvEBKLtNLh0J7r/RHAQdhQqFErnD6mYizDE
         YKgw==
X-Gm-Message-State: ABy/qLY/zuuz4rIM027SSu3UDdQ4V6eg8xyjsNseMmjL6EKAaHFFdb+f
	542/uMsopjpNlMwe5lLx9W+z4eXrO/k/HiAzUxcmYQ==
X-Google-Smtp-Source: APBJJlH9SIlxp9gcpjrHbH85ZHsZVFnc5U9Yd+D/8BddOA5vnCK0mJ3tEWyu6sryEtQD1gdVrrGDxUNjQ+uJXH990sw=
X-Received: by 2002:a17:906:37cc:b0:94f:449e:75db with SMTP id
 o12-20020a17090637cc00b0094f449e75dbmr7501039ejc.52.1688377570306; Mon, 03
 Jul 2023 02:46:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230613-so-reuseport-v4-3-4ece76708bba@isovalent.com> <20230628183258.74704-1-kuniyu@amazon.com>
In-Reply-To: <20230628183258.74704-1-kuniyu@amazon.com>
From: Lorenz Bauer <lmb@isovalent.com>
Date: Mon, 3 Jul 2023 10:45:59 +0100
Message-ID: <CAN+4W8ihqdQnZW5oWxhgmNaEDisdG9UDQYozVw_HpR41HkWL_g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 3/7] net: remove duplicate reuseport_lookup functions
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, dsahern@kernel.org, 
	edumazet@google.com, haoluo@google.com, hemanthmalla@gmail.com, 
	joe@wand.net.nz, john.fastabend@gmail.com, jolsa@kernel.org, 
	kpsingh@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, martin.lau@linux.dev, mykolal@fb.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, sdf@google.com, shuah@kernel.org, 
	song@kernel.org, willemdebruijn.kernel@gmail.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jun 28, 2023 at 7:33=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:

> > +
> > +inet6_ehashfn_t inet6_ehashfn;
> > +
> > +INDIRECT_CALLABLE_DECLARE(inet6_ehashfn_t udp6_ehashfn);
>
> We need not define udp6_ehashfn() here as inet6_hashtables.c has
> the definition.
>
> Only inet6_ehashfn() is needed because sk_ehashfn() uses it.

Without udp6_ehashfn we get the following error, as reported by Simon
against v1:

net/ipv4/udp.c:410:5: error: no previous prototype for =E2=80=98udp_ehashfn=
=E2=80=99
[-Werror=3Dmissing-prototypes]
  410 | u32 udp_ehashfn(const struct net *net, const __be32 laddr,
const __u16 lport,
      |     ^~~~~~~~~~~

> > +inet_ehashfn_t inet_ehashfn;
> > +
> > +INDIRECT_CALLABLE_DECLARE(inet_ehashfn_t udp_ehashfn);
> > +
>
> We don't need inet_ehashfn() and udp_ehashfn() declarations here.

Without inet_ehashfn I get:

./include/net/inet_hashtables.h: In function =E2=80=98__inet_lookup_skb=E2=
=80=99:
./include/net/inet_hashtables.h:501:42: error: =E2=80=98inet_ehashfn=E2=80=
=99
undeclared (first use in this function); did you mean =E2=80=98inet_bhashfn=
=E2=80=99?
  501 |                              refcounted, inet_ehashfn);

Same problem with the warning as above.

I think this needs to stay the way it is.

