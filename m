Return-Path: <bpf+bounces-142-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 994C76F89F9
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 22:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 443492810BE
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 20:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF48D2E8;
	Fri,  5 May 2023 20:05:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D204C99
	for <bpf@vger.kernel.org>; Fri,  5 May 2023 20:05:54 +0000 (UTC)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5285A101
	for <bpf@vger.kernel.org>; Fri,  5 May 2023 13:05:53 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f00d41df22so18209810e87.1
        for <bpf@vger.kernel.org>; Fri, 05 May 2023 13:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683317151; x=1685909151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EvUqN7+4B5H/i6Yp7tD8ZXadcbiO6goPqSXqTxE7CN8=;
        b=i19WE8x8LVhRb4DSOBQS48ialcaKRcmQdaBXIBXK0LuXj68Cjkrkiv92ndZzjxm1Pj
         PC0ZTbUGwp5GK1neyAxOQT6EzxGuiJCnjItkiiJzicRRezGALRhqsBbtzAsYBcDSVV5X
         NFTGXQ47Xyx16Q8OHs69VHBU1jPx3B+FIHgzrjcJZgnun4nt7d03ZfCt+8Q5VZu/ff+W
         5Y2YsW3mnCOcPg3ZjO0yJl+RBWFwxyE1ZkFHelpdSKr6UFu2RIk1L3RHBl+3YBgucAt8
         CrLEhuPn4Dare9kQ3gJxhYcuKpJcbJO25JvVzAUNIKert4CT+c2M1lND6MX9rEJga3oI
         8jGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683317151; x=1685909151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EvUqN7+4B5H/i6Yp7tD8ZXadcbiO6goPqSXqTxE7CN8=;
        b=UIJoXXuHlZVbKpLDj8KPcZjvmYPRolBkJQmmU/7tiZk7KFSilyPf7j0mKn/vd46LoL
         E4/MBx1J6YkCjSMl9+hcsT2MYYCy0LdLQv9WQtuyJOemEbGOu2fggx2YjOJQUrNl2aHd
         mtXbJIMdRpl+OIfUw4whdjhEH+nH0dDm5wCIfEhC49bJdXGe3BzEI7YVn/98r0VP0N89
         gXy/iaqcMERa9dWtHWCVWW4WqGUo4MZK+vue1pgXBC7Wtr5eGmBs3LuZJUucpJ+Xs5F+
         Xumw8/uq7whOAn1Y2W73v4RgqRpwNbOaN/L7GbYiv0LLWQHBNIcQCDFlCGCAQn1j3AMF
         63Cw==
X-Gm-Message-State: AC+VfDz0ErvqthEfuNVIfAGszmSbRsh39jpg8Utew1T46q0aH8g8Nfwt
	uIM1/3werl1yUuUL42Qv1AROwxtNGdqru7OpJpc=
X-Google-Smtp-Source: ACHHUZ55ZAEL6Trqo+sca4+JJ9YjhccAtqFx9lCf+Qtfdp1Au+eN0cMw6ULGZnXfUtCEeHLq+E3EzNNAES4aMf/jpRU=
X-Received: by 2002:a05:6512:3a8d:b0:4ec:9f37:2cfb with SMTP id
 q13-20020a0565123a8d00b004ec9f372cfbmr3016581lfu.27.1683317151255; Fri, 05
 May 2023 13:05:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230503225351.3700208-1-aditi.ghag@isovalent.com>
 <20230503225351.3700208-7-aditi.ghag@isovalent.com> <1013e81f-5a0a-dd0b-c18d-3ee849c079ab@linux.dev>
 <45684b6f-ecfb-5f14-e5ad-386b8f611c7a@linux.dev>
In-Reply-To: <45684b6f-ecfb-5f14-e5ad-386b8f611c7a@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 5 May 2023 13:05:39 -0700
Message-ID: <CAADnVQ+dSt0CgTTdEKQSxS6Cy_xYyHqahVPwQtTwA7K+PF8_8A@mail.gmail.com>
Subject: Re: [PATCH v7 bpf-next 06/10] bpf: Add bpf_sock_destroy kfunc
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Stanislav Fomichev <sdf@google.com>, bpf <bpf@vger.kernel.org>, 
	Aditi Ghag <aditi.ghag@isovalent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, May 5, 2023 at 11:49=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 5/4/23 5:13 PM, Martin KaFai Lau wrote:
> >
> > Follow up on the v6 patch-set regarding KF_TRUSTED_ARGS.
> > KF_TRUSTED_ARGS is needed here to avoid the cases where a PTR_TO_BTF_ID=
 sk is
> > obtained by following another pointer. eg. getting a sk pointer (may be=
 even
> > NULL) by following another sk pointer. The recent PTR_TRUSTED concept i=
n the
> > verifier can guard this. I tried and the following should do:
> >
> > diff --git i/net/core/filter.c w/net/core/filter.c
> > index 68b228f3eca6..d82e038da0e3 100644
> > --- i/net/core/filter.c
> > +++ w/net/core/filter.c
> > @@ -11767,7 +11767,7 @@ __bpf_kfunc int bpf_sock_destroy(struct sock_co=
mmon *sock)
> >   __diag_pop()
> >
> >   BTF_SET8_START(sock_destroy_kfunc_set)
> > -BTF_ID_FLAGS(func, bpf_sock_destroy)
> > +BTF_ID_FLAGS(func, bpf_sock_destroy, KF_TRUSTED_ARGS)
> >   BTF_SET8_END(sock_destroy_kfunc_set)
> >
> >   static int tracing_iter_filter(const struct bpf_prog *prog, u32 kfunc=
_id)
> > diff --git i/net/ipv4/tcp_ipv4.c w/net/ipv4/tcp_ipv4.c
> > index 887f83a90d85..a769284e8291 100644
> > --- i/net/ipv4/tcp_ipv4.c
> > +++ w/net/ipv4/tcp_ipv4.c
> > @@ -3354,7 +3354,7 @@ static struct bpf_iter_reg tcp_reg_info =3D {
> >       .ctx_arg_info_size    =3D 1,
> >       .ctx_arg_info        =3D {
> >           { offsetof(struct bpf_iter__tcp, sk_common),
> > -          PTR_TO_BTF_ID_OR_NULL },
> > +          PTR_TO_BTF_ID_OR_NULL | PTR_TRUSTED },
>
> Alexei, what do you think about having "PTR_MAYBE_NULL | PTR_TRUSTED" her=
e?
> The verifier side looks fine (eg. is_trusted_reg() is taking PTR_MAYBE_NU=
LL into
> consideration). However, it seems this will be the first "PTR_MAYBE_NULL =
|
> PTR_TRUSTED" use case and not sure if PTR_MAYBE_NULL may conceptually con=
flict
> with the PTR_TRUSTED idea (like PTR_TRUSTED should not be NULL).

Conceptually it should be fine. There are no real cases of
PTR_TRUSTED | PTR_MAYBE_NULL now, though check_reg_type() handles it.
Proceed with care, I guess :)

