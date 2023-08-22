Return-Path: <bpf+bounces-8303-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 034EB784BDE
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 23:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B184E280F40
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 21:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787B934CCB;
	Tue, 22 Aug 2023 21:15:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D552018C
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 21:15:04 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C7CCF8
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 14:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692738903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hs6oRa1P9l1DMZWjuZAZ32JKOWh/7k3h+3CxrjxqedE=;
	b=dQUFHegExr7gTnXC1AO2OfxVAErGOPQq+f7g1gk4VMlcde/Y9ED9gOqJABjgJeP2QWovQO
	92HVhfOc8Wf1Pscxtm+ziLzprLFEt1v5hyRjOllLM1nsPteluX+A8JT5kljnybMK1y7M2G
	4erwlcVdj41UTQRjBrCgw9u21IFtmx0=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-hF2LbZT7OYu81wfg_6JSWw-1; Tue, 22 Aug 2023 17:14:59 -0400
X-MC-Unique: hF2LbZT7OYu81wfg_6JSWw-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-4f3932e595dso5195508e87.1
        for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 14:14:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692738898; x=1693343698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hs6oRa1P9l1DMZWjuZAZ32JKOWh/7k3h+3CxrjxqedE=;
        b=R8GosB3DpAXfhTR+/Dp06LzxG+cbe3tBaylHxWBixDFDyzqZBSquneOAzq6md9d4Oz
         fNpgdT8rkxvIXiYeCNxc5RUl9biymOK/UMjMh7CQGJqqtJJtbli7kQqQHXARfKHvQUhg
         zJgZV/3YEyKuDR9T05gCxBUEk2e/MAXf1bLLgxYeeoVlckzfwnjw9aNeQ+WAACY/Pn65
         9BJibr8OL0r21N5/MGFKYrkd5Bz85mjhsusV7DU9LXedyEijr+v78PEvVesBYSG7Xw7P
         TanSYATzDMoZ/zgQ01u0kWji9O09vOH+SolNqcOlE6ER+XGjXJUbNInuv9F4p93nPUuy
         pQ1w==
X-Gm-Message-State: AOJu0YyXK2j49qCde2udTaXDK7lStUuTzg5zPAFAAYsqdx5chpmJKDRy
	cmHCKOjzmiUeMxmIwZNwM8Q5626M2r3IBkflO0vXM0uBcoRhL+GEIFtuz89FCkFe4oDSNN/N6m/
	UZr8NMhYWvuwJq11p64eE8n3EJTxp
X-Received: by 2002:a05:6512:604:b0:4ff:7998:f67a with SMTP id b4-20020a056512060400b004ff7998f67amr7393419lfe.5.1692738898011;
        Tue, 22 Aug 2023 14:14:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtUvfKy2U4ilg4d5q5XWEbL3jzNP/hhuRjudpAk/FpKfkvWfx20bkiTJbPpfKskERbtNxA3brJ3DBSoakUv38=
X-Received: by 2002:a05:6512:604:b0:4ff:7998:f67a with SMTP id
 b4-20020a056512060400b004ff7998f67amr7393414lfe.5.1692738897716; Tue, 22 Aug
 2023 14:14:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFhGd8ryUcu2yPC+dFyDKNuVFHxT-=iayG+n2iErotBxgd0FVw@mail.gmail.com>
 <CAKwvOd=p_7gWwBnR_RHUPukkG1A25GQy6iOnX_eih7u65u=oxw@mail.gmail.com>
 <CAO-hwJLio2dWs01VAhCgmub5GVxRU-3RFQifviOL0OTaqj9Ktg@mail.gmail.com>
 <CAFhGd8qmXD6VN+nuXKtV_Uz14gzY1Kqo7tmOAhgYpTBdCnoJRQ@mail.gmail.com> <CAO-hwJJ_ipXwLjyhGC6_4r-uZ-sDbrb_W7um6F2vgws0d-hvTQ@mail.gmail.com>
In-Reply-To: <CAO-hwJJ_ipXwLjyhGC6_4r-uZ-sDbrb_W7um6F2vgws0d-hvTQ@mail.gmail.com>
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date: Tue, 22 Aug 2023 23:14:46 +0200
Message-ID: <CAO-hwJ+DTPXWbpNaBDvCkyAsWZHbeLiBwYo4k93ZW79Jt-HAkg@mail.gmail.com>
Subject: Re: selftests: hid: trouble building with clang due to missing header
To: Justin Stitt <justinstitt@google.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>, linux-kselftest@vger.kernel.org, 
	bpf@vger.kernel.org, linux-input@vger.kernel.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Kees Cook <keescook@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 22, 2023 at 11:06=E2=80=AFPM Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
>
> On Tue, Aug 22, 2023 at 10:57=E2=80=AFPM Justin Stitt <justinstitt@google=
.com> wrote:
> >
> [...]
> > > > > Here's the invocation I am running to build kselftest:
> > > > > `$ make LLVM=3D1 ARCH=3Dx86_64 mrproper headers && make LLVM=3D1 =
ARCH=3Dx86_64
> > > > > -j128 V=3D1 -C tools/testing/selftests`
> > >
> > > I think I fixed the same issue in the script I am running to launch
> > > those tests in a VM. This was in commit
> > > f9abdcc617dad5f14bbc2ebe96ee99f3e6de0c4e (in the v6.5-rc+ series).
> > >
> > > And in the commit log, I wrote:
> > > ```
> > > According to commit 01d6c48a828b ("Documentation: kselftest:
> > > "make headers" is a prerequisite"), running the kselftests requires
> > > to run "make headers" first.
> > > ```
> > >
> > > So my assumption is that you also need to run "make headers" with the
> > > proper flags before compiling the selftests themselves (I might be
> > > wrong but that's how I read the commit).
> >
> > In my original email I pasted the invocation I used which includes the
> > headers target. What are the "proper flags" in this case?
> >
>
> "make LLVM=3D1 ARCH=3Dx86_64 headers" no?
>
> But now I'm starting to wonder if that was not the intent of your
> combined "make mrproper headers". I honestly never tried to combine
> the 2. It's worth a try to split them I would say.

Apologies, I just tested it, and it works (combining the 2).

Which kernel are you trying to test?
I tested your 2 commands on v6.5-rc7 and it just works.

FTR:
$> git checkout v6.5-rc7
$> make LLVM=3D1 ARCH=3Dx86_64 mrproper headers
$> make LLVM=3D1 ARCH=3Dx86_64 -j8 -C tools/testing/selftests TARGETS=3Dhid

->   BINARY   hid_bpf

Cheers,
Benjamin


