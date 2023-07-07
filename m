Return-Path: <bpf+bounces-4472-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF9974B618
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 20:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A4F11C20FA6
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 18:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B21171C2;
	Fri,  7 Jul 2023 18:08:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF20C107B5
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 18:08:30 +0000 (UTC)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFF82125
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 11:08:28 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fbc0609cd6so22863095e9.1
        for <bpf@vger.kernel.org>; Fri, 07 Jul 2023 11:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688753306; x=1691345306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LY1MtbNxovFxzq5b8zJlxWhfAcb5M4dkDW43kjti8gI=;
        b=qssuNbRKyuntNRpffUE582ebwa9s6AaoJ9dfEZTo4jAgV/jqtS1VRIo8EH+915L6ur
         x0MfROlwYTpwg0THB6J2J1PhqzVdDD8Z2OA08eOfFJHD8UKuNusM0kntvVetbNweoKDo
         03QhSu4p42KXTDCbo30gKh4BBTUU8oII6VrUQenUgtWtse4ZSptzI0vgRtARvcW91UcE
         Ixi8uOFcNBC3O5F5UJldQderQrpeCp8Dgsw+lRDa3FRE5fg15aYGFXJ9k+/eKUsbJ4Iu
         bquzDYzo3wUb62CvnUjnngzFOJJm1iAN7DB1iV/kgwyDAF1VgzHAVdh8FZUpyIKc441G
         7Lvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688753306; x=1691345306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LY1MtbNxovFxzq5b8zJlxWhfAcb5M4dkDW43kjti8gI=;
        b=ZnC3l5OcgId8VilpyN1KzeK+CUV2meznBYeq3aH4ocmmc5rI0Dwox8KQCxEUh6ZcQW
         qd4LHOfmD6RclV4K829uKrwRI0B357VcKk8OYI0JlRcBm8c3OQgRSoom6P0TTz+nMeO+
         n7BsYcS2tGJaAvmfQXwIiZgDhQmBwM3Pfznfp7VH+hBOtgoyWRFALD7RMd3yQGK3Vhti
         MhOxZ44kl4quRE8dGZkWZX7Dhy9XJBUu/l+U1ygTFNIbIIVt2Pn2FxRzyDY5ZT+kOEYj
         T4oNPucLBVCOwl9PWvc/Yhfbi/4eQP2KBQzdDXikxY/fwv8oFEw4gkwJy10hgX2GdYkh
         KhsQ==
X-Gm-Message-State: ABy/qLbPy5UdAc/8NCtmU5yJTtqHO3bqTWOeCYb8f39tqSLBgH/tHsT4
	Ge3LTxHJGsiU/wPxjQ3OydLGNrxAijiia2kwllA=
X-Google-Smtp-Source: APBJJlETg3ud8T9edIJCqwA2IDDztOciaPls1VI11aFhnEdPq/NVGMWdYJRPUlpcYqdY+UlSD1nymMptOsFWt75rCh8=
X-Received: by 2002:a7b:cd8c:0:b0:3fa:991c:2af9 with SMTP id
 y12-20020a7bcd8c000000b003fa991c2af9mr4618245wmj.16.1688753306204; Fri, 07
 Jul 2023 11:08:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+vRuzPChFNXmouzGG+wsy=6eMcfr1mFG0F3g7rbg-sedGKW3w@mail.gmail.com>
 <CAADnVQJpLAzmUfwvWBr8a_PWHYHxHw9vdAXnWB4R4PbVY4S4mw@mail.gmail.com>
In-Reply-To: <CAADnVQJpLAzmUfwvWBr8a_PWHYHxHw9vdAXnWB4R4PbVY4S4mw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 7 Jul 2023 11:08:14 -0700
Message-ID: <CAEf4Bzbubu7KjBv=98BZrVnTrcfPQrnsp-g1kOYKM=kUtiqEgw@mail.gmail.com>
Subject: Re: [BUG] verifier escape with iteration helpers (bpf_loop, ...)
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrew Werner <awerner32@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Andrei Matei <andreimatei1@gmail.com>, Tamir Duberstein <tamird@gmail.com>, 
	Joanne Koong <joannelkoong@gmail.com>, kernel-team@dataexmachina.dev, 
	Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 7, 2023 at 9:44=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Jul 7, 2023 at 7:04=E2=80=AFAM Andrew Werner <awerner32@gmail.com=
> wrote:
> >
> > When it comes to fixing the problem, I don't quite know where to start.
> > Perhaps these iteration callbacks ought to be treated more like global =
functions
> > -- you can't always make assumptions about the state of the data in the=
 context
> > pointer. Treating the context pointer as totally opaque seems bad from
> > a usability
> > perspective. Maybe there's a way to attempt to verify the function
> > body of the function
> > by treating all or part of the context as read-only, and then if that
> > fails, go back and
> > assume nothing about that part of the context structure. What is the
> > right way to
> > think about plugging this hole?
>
> 'treat as global' might be a way to fix it, but it will likely break
> some setups, since people passing pointers in a context and current
> global func verification doesn't support that.

yeah, the intended use case is to return something from callbacks
through context pointer. So it will definitely break real uses.

> I think the simplest fix would be to disallow writes into any pointers
> within a ctx. Writes to scalars should still be allowed.

It might be a partial mitigation, but even with SCALARs there could be
problems due to assumed SCALAR range, which will be invalid if
callback is never called or called many times.

> Much more complex fix would be to verify callbacks as
> process_iter_next_call(). See giant comment next to it.

yep, that seems like the right way forward. We need to simulate 0, 1,
2, .... executions of callbacks until we validate and exhaust all
possible context modification permutations, just like open-coded
iterators do it

> But since we need a fix for stable I'd try the simple approach first.
> Could you try to implement that?

