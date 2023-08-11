Return-Path: <bpf+bounces-7543-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B985778F43
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 14:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 160F62818E5
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 12:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98877200A5;
	Fri, 11 Aug 2023 12:19:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F61100AD
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 12:19:25 +0000 (UTC)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E5A30CA
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 05:19:08 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b9cdbf682eso29387211fa.2
        for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 05:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691756325; x=1692361125;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GXzMe/4v9wcqme6+Ghxf3GeVhmupXpzPfNuSwFVE1kw=;
        b=XLeN1WbAr8s/zRpFlnyqPPOQWqJpOKJE/wYVw9/W6GnJuTCuK+cMyb1KWvYGuMunKk
         tHIGQpej4mAZuTICg0wztyV7jiFU9N9zXyUIKcaCbVpyAvgiYLpspGKrt3y9+Z6144Cj
         dXmIrwQ/6JBwcAwyIst/WMzRxmowiayt+aZ9HSZaNwNhQ3HD7FYlFRPGqSoGBrnTCwGr
         Rb6VCr2AwyzGjS4DRTmvNFX+G3dmxGwHf8/hl4EibKQWDzhEaZsYuk5o42t1hlX8Xpg5
         Tkerfl6jrMhGmYvu7nGPN6hGaRjlXDZXz1jILGwvy7NjHqkvWwFefNuyaMH+m/SN+OXd
         bh7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691756325; x=1692361125;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GXzMe/4v9wcqme6+Ghxf3GeVhmupXpzPfNuSwFVE1kw=;
        b=SywAaDKL5AiVVXKwrdqs9GwpV4tPvNxeqiDoMW8aSAdrF719RWYM/OkZSVyiLyy/Jl
         4gcV5edPtzzExFooa+q/0XI7Y9uXn3HmYMyiIeoraaSkC2Zu6eniLj44UaUfdPuMEal3
         zvr3WQOZWnj5Gydyy3kc+2VGhyzfrIBF0BbaIoCj4EkX0T23bOfT30TPz+bGMjkGG22W
         4X+5k1VA4tYnXv/9ZFFSTw9q+p8vcEtNiTqqd0mOzeIYwedx/0MykYrqeptz8PBAtOgq
         8oBmCowQ5RuXdRatJJ7D602iZGu0JR1M3wLL06+ztc2Rym4EzE2vHnL9nSArPvkNbYrt
         Fw/w==
X-Gm-Message-State: AOJu0Yyc7CvE62CXRO6VKJ2f3uQkmGEUYgKDt9U9km3O3h7b+Oq1SSeN
	XD5Cx62qgiGwH89II4sQl/k=
X-Google-Smtp-Source: AGHT+IHA3YgBiUho2Gw/LhNLa8aJrJFbW1efDRbtetsHtLrX1eOayxUZHFDaRt9+0eerx0bamD4y1w==
X-Received: by 2002:a2e:998d:0:b0:2b5:1b80:264b with SMTP id w13-20020a2e998d000000b002b51b80264bmr1606706lji.12.1691756324530;
        Fri, 11 Aug 2023 05:18:44 -0700 (PDT)
Received: from [192.168.43.113] (178-133-60-176.mobile.vf-ua.net. [178.133.60.176])
        by smtp.gmail.com with ESMTPSA id a11-20020a170906670b00b0099315454e76sm2174503ejp.211.2023.08.11.05.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 05:18:42 -0700 (PDT)
Message-ID: <48b24b86e221a9559a13d51df57b72d0da5d0c7f.camel@gmail.com>
Subject: Re: Usage of "p" constraint in BPF inline asm
From: Eduard Zingerman <eddyz87@gmail.com>
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc: yonghong.song@linux.dev, bpf@vger.kernel.org, Nick Desaulniers
	 <ndesaulniers@google.com>
Date: Fri, 11 Aug 2023 15:18:41 +0300
In-Reply-To: <87y1ihg53e.fsf@oracle.com>
References: <87edkbnq14.fsf@oracle.com>
	 <a4c550e4-1d65-aace-d9ba-820b89390f54@linux.dev>
	 <87a5uyiyp1.fsf@oracle.com>
	 <223ef785-8f8a-14bf-58e4-f9ed02b21482@linux.dev>
	 <37b9680f074a871041c3dd61d22e6a6c9fd02fb0.camel@gmail.com>
	 <87v8dmhfwg.fsf@oracle.com>
	 <7ae83d1248b649a8765a3e01e7a526c86b956ef3.camel@gmail.com>
	 <87y1ihg53e.fsf@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, 2023-08-11 at 14:01 +0200, Jose E. Marchesi wrote:
> > On Thu, 2023-08-10 at 21:10 +0200, Jose E. Marchesi wrote:
> > [...]
> > > Note the same fix would be needed in the inline asm in
> > > selftests/bpf/progs/iters.c:iter_err_unsafe_asm_loop.
> >=20
> > Right, sorry. Tested with that change as well, no changes in the
> > generated object files for clang. Can't grep "p" anywhere else in
> > selftests.
> >=20
> > [...]
>=20
> Thank you.
>=20
> Ok, so since people seems to agree to the proposed fix, I will prepare a
> patch for this.  First I will have to set up a kernel BPF development
> environment... but I guess it is about time for that ;)
>=20
> Other than running the kernel selftests, is there any other testing you
> would recommend to a n00b like me, for changes like this (code
> generation changes)?

What I do is run same kernel selftests as CI:
- test_verifier
- test_progs
- test_progs-no_alu32
- test_progs-cpuv4

Do you need any help with the environment itself?
(I can describe my setup if you need that).

