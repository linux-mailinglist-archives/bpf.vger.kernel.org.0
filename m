Return-Path: <bpf+bounces-8302-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B790784BC4
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 23:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEFB428116B
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 21:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F109034CC7;
	Tue, 22 Aug 2023 21:06:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39792018C
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 21:06:24 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB500CD9
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 14:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692738381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eozuvkXZf7lt2j4GJR5fEMVPoz5joKAi735jAZphMzo=;
	b=BAb2chtr9jmuQF5TF6QDuWcbsUTQ76d9cS4AeyY/6s0XOKW6dcE3q+UTThGPxKWgwOHUGZ
	17XScQKR2J2mMyRNQ6T6885wXIXK7g4ClkNQ98nLy8Oh/0SlmKnveaeIAh3nl6o8kWNpmn
	vQCDDgfA8gnic7SnEgoPVD9ItSwQW9c=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-Th_hmMcWP7S4vdDSlznMOg-1; Tue, 22 Aug 2023 17:06:19 -0400
X-MC-Unique: Th_hmMcWP7S4vdDSlznMOg-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-4fe3c8465e0so5260154e87.1
        for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 14:06:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692738374; x=1693343174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eozuvkXZf7lt2j4GJR5fEMVPoz5joKAi735jAZphMzo=;
        b=d7AAjXr8PuHhLHIH9gSY0H+xrr3YztTAsKjzXcHuTD5r0PFzm3X+5848NvbHULX8BG
         ZACMfc9M0SVOkY2N5DQZeIwAQAh3FTRN3IaPyM5aNJdXBglMAx0zEDWXIkCzlC28rt9e
         B5E3EGfTqMYR182ot5G0qHF3gmOO+vcfeMoUtZm8RJiv9KCgvqAUApyPYluxHxu6FAg7
         YWa3Q0GamUFFqoqla14Kw3+SNoe9HwoRAkMnlXgwG7jPCDguToRO3KSooCL5az4PBAko
         I/YKUl48L1K/c+JYc8mVCFfNwiQW/+KJo66p44Uf8cgvR57BNrGARKOoI98DxEh0dM9F
         nqMA==
X-Gm-Message-State: AOJu0YyD8+ldj0UUyLzOX93LnUjTzUP2fiVpolFWib+XtZ+fAk+2bu/l
	I0BCHAz5yzKWz+QvfPZz9w3CRPHoJVQbY/U2ZpB4tV/TKF+Gle2EuSLB/DsbRJOp90prlTuCe6C
	aAXIGdFWZCT7m20qFHC56i/h+yCka
X-Received: by 2002:ac2:55a7:0:b0:500:8fcd:c3b5 with SMTP id y7-20020ac255a7000000b005008fcdc3b5mr1464017lfg.12.1692738374175;
        Tue, 22 Aug 2023 14:06:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHeNyF1wlvbOJcWPDTAWORFiO3zXf51SnVR8DhrtgaVaRfNn3Wuj/OWqV2eXbAGJfYHTm1809Rq9Jm3OA9QzNg=
X-Received: by 2002:ac2:55a7:0:b0:500:8fcd:c3b5 with SMTP id
 y7-20020ac255a7000000b005008fcdc3b5mr1464006lfg.12.1692738373861; Tue, 22 Aug
 2023 14:06:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFhGd8ryUcu2yPC+dFyDKNuVFHxT-=iayG+n2iErotBxgd0FVw@mail.gmail.com>
 <CAKwvOd=p_7gWwBnR_RHUPukkG1A25GQy6iOnX_eih7u65u=oxw@mail.gmail.com>
 <CAO-hwJLio2dWs01VAhCgmub5GVxRU-3RFQifviOL0OTaqj9Ktg@mail.gmail.com> <CAFhGd8qmXD6VN+nuXKtV_Uz14gzY1Kqo7tmOAhgYpTBdCnoJRQ@mail.gmail.com>
In-Reply-To: <CAFhGd8qmXD6VN+nuXKtV_Uz14gzY1Kqo7tmOAhgYpTBdCnoJRQ@mail.gmail.com>
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date: Tue, 22 Aug 2023 23:06:02 +0200
Message-ID: <CAO-hwJJ_ipXwLjyhGC6_4r-uZ-sDbrb_W7um6F2vgws0d-hvTQ@mail.gmail.com>
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

On Tue, Aug 22, 2023 at 10:57=E2=80=AFPM Justin Stitt <justinstitt@google.c=
om> wrote:
>
[...]
> > > > Here's the invocation I am running to build kselftest:
> > > > `$ make LLVM=3D1 ARCH=3Dx86_64 mrproper headers && make LLVM=3D1 AR=
CH=3Dx86_64
> > > > -j128 V=3D1 -C tools/testing/selftests`
> >
> > I think I fixed the same issue in the script I am running to launch
> > those tests in a VM. This was in commit
> > f9abdcc617dad5f14bbc2ebe96ee99f3e6de0c4e (in the v6.5-rc+ series).
> >
> > And in the commit log, I wrote:
> > ```
> > According to commit 01d6c48a828b ("Documentation: kselftest:
> > "make headers" is a prerequisite"), running the kselftests requires
> > to run "make headers" first.
> > ```
> >
> > So my assumption is that you also need to run "make headers" with the
> > proper flags before compiling the selftests themselves (I might be
> > wrong but that's how I read the commit).
>
> In my original email I pasted the invocation I used which includes the
> headers target. What are the "proper flags" in this case?
>

"make LLVM=3D1 ARCH=3Dx86_64 headers" no?

But now I'm starting to wonder if that was not the intent of your
combined "make mrproper headers". I honestly never tried to combine
the 2. It's worth a try to split them I would say.

Cheers,
Benjamin


