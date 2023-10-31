Return-Path: <bpf+bounces-13672-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C127DC5CD
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 06:19:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9B9E1C20BEB
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 05:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80AAD275;
	Tue, 31 Oct 2023 05:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aUHVY278"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2034ECA7C
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 05:19:25 +0000 (UTC)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A67B7
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 22:19:19 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9be3b66f254so774670766b.3
        for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 22:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698729554; x=1699334354; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oapVQRnil/59u3gHAbKWTpeSyDW7jQ4dw86pBfRqhXg=;
        b=aUHVY278vZaQ3lJs5wNfIQlGVv6+vJ0VXlu6SflpDA2oX3k9R24zuSx/Fi9wcHVIga
         iCtmU8vVTZP3vuiKU6aRl6RkchECc/0FZ52lvAUh08NDgR0CcGWqYw9/gG5PPor3BRlr
         9aL0BBsGueFE1bE9wfWQ1BIVp5iYUx4NV9IImfG4wE89KnSqgzLU/sm2Ojq19tVTXTnS
         xJnpCq836MoorovsN9qMaz1xDftnUdhTLWi5bM7s8BDUwX0OU3XYoT9HoaepypPbhnNx
         gEZRd9fQfRN8l4boup1626rhVF/utEQ0iVFYyue04+grBtL97ht0RrPx9pw+cOEzBaSC
         STbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698729554; x=1699334354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oapVQRnil/59u3gHAbKWTpeSyDW7jQ4dw86pBfRqhXg=;
        b=s30ttWa7ZySKc5ExEmRfK5kvHwIjoz2QOHxrgsvFRiI7QRL8WjWIg2WYzzsXdREtRu
         eI/ttEwGL26sK0HnwdNBK6f9Nmj4wB340qPMlsyQmN/AwgcxtctXvpJTld6xmkeOXnMT
         N2d7XLtzVyIMJ/9nT6TEpiRKg2ivYRjgEJxd0RGY4VnxIeD6mm5XTOaXRsgZOfHa0Hlw
         jL57KuQaj7Eh4cmcf/qTgkqWVc5KP289oBqwmhgVPABt60k7OmnWLi3Febj9Ea2XgBfs
         inkz93Keyu5OlBOgUhTCPPWVoSB83PJLD5+I4GdCEFHU5iwy5ev4nE84xV2oM00nxycd
         T8+Q==
X-Gm-Message-State: AOJu0YxSu4V4+BShsV88+EEmH8cx6fP+gB1RT88oYoJSq4x/DrPxvLGi
	Y5U6ml/+Iy6htPbBF0vSAkRJ7dQelOVj8038nJE=
X-Google-Smtp-Source: AGHT+IHspC1ZZTx1OI1EXqtIzGUKUg9D2K7S1Rc6+aUswOK87bKeKp27zfpg3clG6WlxM809a/MOqNPVE9ujUqYeg/w=
X-Received: by 2002:a17:907:3fa4:b0:9be:8ead:54c7 with SMTP id
 hr36-20020a1709073fa400b009be8ead54c7mr10589517ejc.12.1698729553762; Mon, 30
 Oct 2023 22:19:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231027181346.4019398-1-andrii@kernel.org> <20231030175513.4zy3ubkpse2f6gqz@MacBook-Pro-49.local>
In-Reply-To: <20231030175513.4zy3ubkpse2f6gqz@MacBook-Pro-49.local>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 30 Oct 2023 22:19:01 -0700
Message-ID: <CAEf4BzZyLwO_ZppGObkY=4aXZEGE+k+tTtJug7MP63DffoxrYA@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 00/23] BPF register bounds logic and testing improvements
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Paul Chaignon <paul@isovalent.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 30, 2023 at 10:55=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Oct 27, 2023 at 11:13:23AM -0700, Andrii Nakryiko wrote:
> >
> > Note, this is not unique to <range> vs <range> logic. Just recently ([0=
])
> > a related issue was reported for existing verifier logic. This patch se=
t does
> > fix that issues as well, as pointed out on the mailing list.
> >
> >   [0] https://lore.kernel.org/bpf/CAEf4Bzbgf-WQSCz8D4Omh3zFdS4oWS6XELnE=
7VeoUWgKf3cpig@mail.gmail.com/
>
> Quick comment regarding shift out of bound issue.
> I think this patch set makes Hao Sun's repro not working, but I don't thi=
nk
> the range vs range improvement fixes the underlying issue.

Correct, yes, I think adjust_reg_min_max_vals() might still need some fixin=
g.

> Currently we do:
> if (umax_val >=3D insn_bitness)
>   mark_reg_unknown
> else
>   here were use src_reg->u32_max_value or src_reg->umax_value
> I suspect the insn_bitness check is buggy and it's still possible to hit =
UBSAN splat with
> out of bounds shift. Just need to try harder.
> if w8 < 0xffffffff goto +2;
> if r8 !=3D r6 goto +1;
> w0 >>=3D w8;
> won't be enough anymore.

Agreed, but I felt that fixing adjust_reg_min_max_vals() is out of
scope for this already large patch set. If someone can take a deeper
look into reg bounds for arithmetic operations, it would be great.

On the other hand, one of those academic papers claimed to verify
soundness of verifier's reg bounds, so I wonder why they missed this?
cc Paul, maybe he can clarify (and also, Paul, please try to run all
that formal verification machinery against this patch set, thanks!)

