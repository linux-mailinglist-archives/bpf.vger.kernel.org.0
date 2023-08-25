Return-Path: <bpf+bounces-8667-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41907788E01
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 19:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5D59281308
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 17:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E81418047;
	Fri, 25 Aug 2023 17:49:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32073101CA
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 17:49:33 +0000 (UTC)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D4026A1
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 10:49:32 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2bbad32bc79so18466701fa.0
        for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 10:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692985771; x=1693590571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2j0jLcnmPgFDDUb6GJNx1yLaZ39VkcU3VVUDU0xfMk4=;
        b=QH1flM4lbO/pac8g9dJSk/6JR0Y8FMlewOLNOQGKdMY1roDZULqphUVUO5pe7Ukrcm
         6rmgPDkwSKZ1ch+2VVkdt9/NagPtNXEfFHlgxGJ6Vm7Gkh4UYCwPKSF63y87MsS01F5D
         pRtV150NbepbHXTZ1AWglT4gA6rx887lodM5/tgB/rCefL1+u2d5fnWznIOFEMFrpeh0
         Nx9rteXSFwYVyL/pOg8qHFGVqIGl0NQfxK1DLq6LGboFM2htYWAdCiQAQ7kG/XB0Ds94
         CkAVSNV8NpghkrV32PsNEXO7m8sY+dqD4fpZhQEkKtWKI6VAGPSjDBfoMQCLtIyWTJj+
         FtKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692985771; x=1693590571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2j0jLcnmPgFDDUb6GJNx1yLaZ39VkcU3VVUDU0xfMk4=;
        b=Rgc4P12ALkBHH4eaYc/Yft5a/dHFPRC5LIEwejtIGoz0plOzAfadnGy6pO/TMvghu8
         Bra/n5trOxNRfZil0rMbblw6ZMmlnc9iZ2yWOMeTOz7+JVbdXYW2pzxmbV9qbMDtCjg+
         kmGrVIjzaUcoOYMb7E9nq3xk+d+U+5o+tdvR8Kc/w6hWcXtl8qVESezRIOAyy4yVF8v+
         gOQFDY0rCQUO6iIdu5o8rXzj1AbZHhd0X5QPEJQcYvjNuQvYE4u+ZPmwuI9iqP545TRR
         dQG/JF8gSe6X+YHJsmkyY3BWkf38A+IEay2aFvfWS/ve1j97qacTS/Q8niVTbKoXScpz
         KEfQ==
X-Gm-Message-State: AOJu0YzBm/KI+4ZWvJBfe+ne0KqzWcLjwKdHEdqtkmsooF2gUj04+k+p
	emTdO5O5tKfCytc3ZwCFLVKixNhzdLLERw6+kkE=
X-Google-Smtp-Source: AGHT+IFO97oujZy2kbnJzE2mVqPL4OjTUfbnBvG93oatFn8wv/j2NfagjBqCUkUbkOeE3grJCtbH3MEiaawwo+AfYy8=
X-Received: by 2002:a2e:81d0:0:b0:2bc:d33e:ccc5 with SMTP id
 s16-20020a2e81d0000000b002bcd33eccc5mr9490236ljg.41.1692985770413; Fri, 25
 Aug 2023 10:49:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230824220907.1172808-1-awerner32@gmail.com> <ce26e0c1-7d05-1572-dfc9-10d251fde86f@iogearbox.net>
 <CA+vRuzPsN=1xgvAaP6PrMaiLb7U+B5g1t2eBSnqZRC-XQ2EkzA@mail.gmail.com> <257a7f97-a587-adf4-dfb8-e32a8f8e44b7@iogearbox.net>
In-Reply-To: <257a7f97-a587-adf4-dfb8-e32a8f8e44b7@iogearbox.net>
From: Andrew Werner <awerner32@gmail.com>
Date: Fri, 25 Aug 2023 13:49:19 -0400
Message-ID: <CA+vRuzNJ1wEoNPjGN_=94ddotK6P8xRTewnTwaB-XXGSjXzXmw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3] libbpf: handle producer position overflow
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, kernel-team@dataexmachina.dev, 
	alexei.starovoitov@gmail.com, andrii@kernel.org, olsajiri@gmail.com, 
	houtao@huaweicloud.com, void@manifault.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 25, 2023 at 1:23=E2=80=AFPM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> On 8/25/23 6:39 PM, Andrew Werner wrote:
> > On Fri, Aug 25, 2023 at 11:28=E2=80=AFAM Daniel Borkmann <daniel@iogear=
box.net> wrote:
> >> On 8/25/23 12:09 AM, Andrew Werner wrote:
> >>> Before this patch, the producer position could overflow `unsigned
> >>> long`, in which case libbpf would forever stop processing new writes =
to
> >>> the ringbuf. Similarly, overflows of the producer position could resu=
lt
> >>> in __bpf_user_ringbuf_peek not discovering available data. This patch
> >>> addresses that bug by computing using the signed delta between the
> >>> consumer and producer position to determine if data is available; the
> >>> delta computation is robust to overflow.
> >>>
> >>> A more defensive check could be to ensure that the delta is within
> >>> the allowed range, but such defensive checks are neither present in
> >>> the kernel side code nor in libbpf. The overflow that this patch
> >>> handles can occur while the producer and consumer follow a correct
> >>> protocol.
> >>>
> >>> Secondarily, the type used to represent the positions in the
> >>> user_ring_buffer functions in both libbpf and the kernel has been
> >>> changed from u64 to unsigned long to match the type used in the
> >>> kernel's representation of the structure. The change occurs in the
> >>
> >> Hm, but won't this mismatch for 64bit kernel and 32bit user space? Why
> >> not fixate both on u64 instead so types are consistent?
> >
> > Sure. It feels like if we do that then we'd break existing 32bit
> > big-endian clients, though I am not sure those exist. Concretely, the
> > request here would be to change the kernel structure and all library
> > usages to use u64, right?
>
> Yes, to align all consistently on u64. From your diff, I read that for
> the kernel its the case already.

I would not say that for the kernel it's the case that these values
are u64. Today the kernel representation of the positions are both
`unsigned long`, and almost all functions which read or write to those
locations in memory use `unsigned long`. Two kernel functions related
to the user_ring_buffer and one libbpf function related to the
user_ring_buffer were reading the data at those addresses in the data
structure into u64.

>
> Thanks,
> Daniel

