Return-Path: <bpf+bounces-5378-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4C6759E01
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 20:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EB08281A1A
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 18:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC33275D6;
	Wed, 19 Jul 2023 18:57:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7120275A1
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 18:57:56 +0000 (UTC)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180F91734
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 11:57:53 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b95efb9d89so11312201fa.0
        for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 11:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689793071; x=1690397871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S6oL1NfebDHo7wRAnVMMF5y9hZXZ/ntO3k2KKpJzLIM=;
        b=aNUXuT4O5sbxxkZdVfayes2BxVR41jns9d01BOAeQukI27ruIRYvAUs3iO+Z4Ts32v
         oLEejmWtdmMJlGbE9wadwZDh0DpmePjNELYnh/4cMrJs1HHCq6xJkLljrcNqDhxl5hIR
         LphGaw+rtnRypmjwCIVUcvO2X9bRvKabd1+H1vJQnaxVEK/5h3eLyJjd/Z3c39pYXMAl
         OrNqmfthwPbCaejAZz1E/rfmcc/tT1RgiTYAmzBg/Eyfjhi+KvV0fSNQCbpsnDZYE++y
         RiGFqPnQdx4PiepYnXOyKRYLfpQJnfO8YgIbnbAiydc5nc/zsZeJiDg9P/x+zPaCRMVT
         vGIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689793071; x=1690397871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S6oL1NfebDHo7wRAnVMMF5y9hZXZ/ntO3k2KKpJzLIM=;
        b=UbtnvN794LPe8LujCqsx7dHjAONhr2vQCDYHXeXHVyOWr42GhSjt6hIEk7kuyRo6wR
         rN5OiyO0aO5N4eOD2TiEw3zSTv7NFVazMsPkO8L4D13Pkmn+eMJcoB/tDpJ024gbpM3I
         3oNxsuifn/jg5vpNuVNqk0dxdV89hs5fPLYskFaKuqko6JwjgqffjzyhasvQH2p8/+Ki
         jurmOenkEl82h+55KWD8u/TP9ENTikbwccucmreisyUxXbKAmw9PkGYb7F3eWkUQ2tXW
         JLaH6SLqVycUCk63ZXE/30nw4/HVzUB5YTwgGD45yWy1MWynLCrbSfMYjI/IzA9RvTDf
         +hQg==
X-Gm-Message-State: ABy/qLbIwew0xkupV/Ke9yLstHQwWm6bT6Xm9FBlLWctJNmJPNsT77Q/
	eOCYd+/j46IGizKB6rP3I/sb6xUWncRqt5OQnNyiEvHBiFM=
X-Google-Smtp-Source: APBJJlHyzvLDNcem1H8ynuji5Jd2QDE08vD61+hf9WPws+ZMR0Dd8ti9jSnLm+YXBQLGpfmzPB1QIbVGlySuTZbbBZA=
X-Received: by 2002:a2e:2c0e:0:b0:2b6:a344:29cf with SMTP id
 s14-20020a2e2c0e000000b002b6a34429cfmr483896ljs.17.1689793070638; Wed, 19 Jul
 2023 11:57:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230719014744.3480131-1-awerner32@gmail.com> <CAADnVQLzUN8DUEpjt7xtr=zqSoTaTrHkt16ifEi3znttdSc_NA@mail.gmail.com>
In-Reply-To: <CAADnVQLzUN8DUEpjt7xtr=zqSoTaTrHkt16ifEi3znttdSc_NA@mail.gmail.com>
From: Andrew Werner <awerner32@gmail.com>
Date: Wed, 19 Jul 2023 14:57:39 -0400
Message-ID: <CA+vRuzMO=V2RAgDU0Vr-TF9VKvjDnzFjMpA8GzsAV8N9jANcxA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: fix ringbuf benchmark output
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, kernel-team@dataexmachina.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 19, 2023 at 1:35=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Jul 18, 2023 at 6:50=E2=80=AFPM Andrew Werner <awerner32@gmail.co=
m> wrote:
> >
> > The headers were confusing.
> > ---
>
> SOB is missing.

Ack.

>
> commit log is too terse.
> Pls explain what you're fixing.

Ack.

> >  tools/testing/selftests/bpf/benchs/run_bench_ringbufs.sh | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/benchs/run_bench_ringbufs.sh b=
/tools/testing/selftests/bpf/benchs/run_bench_ringbufs.sh
> > index 91e3567962ff..8dd97f5108f0 100755
> > --- a/tools/testing/selftests/bpf/benchs/run_bench_ringbufs.sh
> > +++ b/tools/testing/selftests/bpf/benchs/run_bench_ringbufs.sh
> > @@ -6,12 +6,12 @@ set -eufo pipefail
> >
> >  RUN_RB_BENCH=3D"$RUN_BENCH -c1"
> >
> > -header "Single-producer, parallel producer"
> > +header "Single-consumer, parallel producer"
> >  for b in rb-libbpf rb-custom pb-libbpf pb-custom; do
> >         summarize $b "$($RUN_RB_BENCH $b)"
> >  done
> >
> > -header "Single-producer, parallel producer, sampled notification"
> > +header "Single-consumer, parallel producer, sampled notification"
>
> Single-producer, consumer/producer competing on the same CPU, low batch c=
ount
>
> should also be fixed?

In retrospect, having now reread these, I think that they were not
mistakes. Ringbuf is always implicitly a single consumer concept. The
point was to highlight that there is a single producer, and that it is
running in parallel.

I'll more generally take a more in depth pass at making these headers
clearer and more consistent, and I'll address the other items in v2.
Thanks for the review!

