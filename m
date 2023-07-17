Return-Path: <bpf+bounces-5079-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A62D7755D77
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 09:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97CC01C20AAF
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 07:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80AB49467;
	Mon, 17 Jul 2023 07:51:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550345CB8
	for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 07:51:12 +0000 (UTC)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A35C7;
	Mon, 17 Jul 2023 00:51:10 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b6f943383eso59439911fa.2;
        Mon, 17 Jul 2023 00:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689580269; x=1692172269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YdvmJmDWWDsKPwBUXibJSiHawWBtjbP4ynK0j2yvrUI=;
        b=p9xAGXz4bX8T8QhVwHGm42SbYjno3i0HBw64iH4AkHt0H8p+VQeWmO4s4jRzxJgOjT
         hdNxxVKhdA/NyTBAgE4V09Z5sKb5JVijH062XUVy7zTKa8wyB9TSJjSEfbLKo628ai3H
         X29+DUNUqmU9Gs9nQ18urKOy8AfHVwnJuQqXNexAmejHEkU7k52QySDbQp2mYULgw3Wp
         oZp3SDx5dewaJJ1g3iq9IDpd5jcEKNZNV0iyf5omIVcCxXz7CrUnX+KGOgRstoIC8s5M
         EYh58jsbr6Nct9r5T3dcg+fwHlIe4R0MGYafCVgMecn2MMiiFX2BPLFw3N1Yo4i6cDpF
         xrOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689580269; x=1692172269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YdvmJmDWWDsKPwBUXibJSiHawWBtjbP4ynK0j2yvrUI=;
        b=hFU8KV9cIDgMYF4dlch6Rvg2IBbfTSdA4IS0RVxESUBr6UwWnnb1eX4mbbGJO3Apsj
         KOW81/kQARcz1xivkEJCKuE0IyKYROIr+ZwUhlNEYJz8wlpvkO5mB+tU77tRTmV3/VB7
         1XFtoDTl3y7vwv5otIYvo9j/s+4V+ByZ49aUs3c2BZRMjPF/UTMSOV72GO0PFwHY8+53
         6c1AWvtrMRmW5+2QrMCpuz4QfRGrIf8a0yQb94gC85Q2HENNdoTMOV89uotm7iFheXw6
         0qBu3qsSrAvmt2Vz0i0QbpLlwnuiS1pmcdo+RK7Lcp2KqbiF+D/Pw1FmruIBa3jirqqP
         FXMA==
X-Gm-Message-State: ABy/qLZw4Y9Wak7ydwaGpDmwtApmK/wumRE0IduoZ0zQKMJMxrcojuG/
	w/V5sDgfvepEVXD2uF5NjdBguqkLarQAFtzUf/Q=
X-Google-Smtp-Source: APBJJlG6zusNiSKLB741ID5TTlAleRJE0hv83e4VccVX9+/pxOuTxEXak5WBgVFaUgK5N7AIv7J1MI9eLrYmc7JatFg=
X-Received: by 2002:a2e:9c02:0:b0:2b4:83c3:d285 with SMTP id
 s2-20020a2e9c02000000b002b483c3d285mr8330250lji.38.1689580268474; Mon, 17 Jul
 2023 00:51:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230626085811.3192402-1-puranjay12@gmail.com>
 <7e05efe1-0af0-1896-6f6f-dcb02ed8ca27@iogearbox.net> <ZKMCFtlfJA1LfGNJ@FVFF77S0Q05N>
In-Reply-To: <ZKMCFtlfJA1LfGNJ@FVFF77S0Q05N>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Mon, 17 Jul 2023 09:50:56 +0200
Message-ID: <CANk7y0gTXPBj5U-vFK0cEvVe83tP1FqyD=MuLXT_amWO=EssOA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 0/3] bpf, arm64: use BPF prog pack allocator
 in BPF JIT
To: Mark Rutland <mark.rutland@arm.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, ast@kernel.org, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, catalin.marinas@arm.com, 
	bpf@vger.kernel.org, kpsingh@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Mark,

On Mon, Jul 3, 2023 at 7:15=E2=80=AFPM Mark Rutland <mark.rutland@arm.com> =
wrote:
>
> On Mon, Jul 03, 2023 at 06:40:21PM +0200, Daniel Borkmann wrote:
> > Hi Mark,
>
> Hi Daniel,
>
> > On 6/26/23 10:58 AM, Puranjay Mohan wrote:
> > > BPF programs currently consume a page each on ARM64. For systems with=
 many BPF
> > > programs, this adds significant pressure to instruction TLB. High iTL=
B pressure
> > > usually causes slow down for the whole system.
> > >
> > > Song Liu introduced the BPF prog pack allocator[1] to mitigate the ab=
ove issue.
> > > It packs multiple BPF programs into a single huge page. It is current=
ly only
> > > enabled for the x86_64 BPF JIT.
> > >
> > > This patch series enables the BPF prog pack allocator for the ARM64 B=
PF JIT.
>
> > If you get a chance to take another look at the v4 changes from Puranja=
y and
> > in case they look good to you reply with an Ack, that would be great.
>
> Sure -- this is on my queue of things to look at; it might just take me a=
 few
> days to get the time to give this a proper look.
>
> Thanks,
> Mark.

I am eagerly looking forward to your feedback on this series.

Thanks,
Puranjay

