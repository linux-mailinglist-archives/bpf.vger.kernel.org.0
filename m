Return-Path: <bpf+bounces-17718-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E730811ECB
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 20:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD41E282C18
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 19:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF5468269;
	Wed, 13 Dec 2023 19:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cZZBwHl3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240DE9C
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 11:25:25 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-a1ceae92ab6so975108566b.0
        for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 11:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702495523; x=1703100323; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8YbJP/XBSklUxW8YMy7Lav6IU83aE4FGm4t2lFulAD8=;
        b=cZZBwHl3VcAFiWhkzFlAYdp8zbmkiaJjq05NBdc/NEt5wt0R2k1ef+FZNWNUkLHqyP
         veFaRrV6lJCluaQgt1lEdEV4ivMCd9Pni0z42QiGgQ2I0KLW7zVTPwvS0rWxCWJLDmx0
         BSfY+HblEAwptVYMn7DKbMUWecj41EaZLlljNfYo3qB/wXkIeQwtPha8usDLMKaZcxLm
         VCmNfJZs7QosGSPC2JtrPgVYqAqliNLh3flxUo22xPIRmUc5IHQgm1PKnP8eFFZEklVm
         l9hZqE+fs/PEKZ56z1Spb5IUR4w2PTHBehh1ftc2jFjwYenJ214Uz4Q/WzLLW6d1Bbmn
         8xSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702495523; x=1703100323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8YbJP/XBSklUxW8YMy7Lav6IU83aE4FGm4t2lFulAD8=;
        b=Z8qUutwRYMcHx2jTP2YlBCgX1njOInUs2LAqERccoYzNV91CWsqllygg9wWD+OoID8
         P1q+1FsBx9/sz7hOI4N/fepTp71Rpa2583aMDHBUxfSRYhuQlrq3ddMxSHTl0TyMurRD
         lKWkv4FUN+s1lCtnwuH44YCRIiOc4wjMvvgwEOtcmGOBNDL9PBXW0e30Bz0nls2DjR7q
         opODz9JLPZ6qaPA3d05+DowGmyuwpZngZpOQ4Lrp8Ur1q6jsZK1/926wqfg5bPEl+Orf
         EZoZnWGIYz+1Bfhbrf6GH12XNZmNps8GWtWFcjNDvufFUaHlDD4wWrr9HxzlrY+THLtP
         kQ6w==
X-Gm-Message-State: AOJu0YyDqSWV0u5y9m/WJKklZqjqORZB/lnf+Eja7sy5TawMi+KS0B0o
	of4a0u10A7AVc2cRNk36Vx/ggDYAnfzR+uNWo7ksE3CuYpE=
X-Google-Smtp-Source: AGHT+IEsEiGygptrDRs2wQyUFsq7grzPIOrUcGjK94g2R17Xch6pCUvTWqpDUYJQsjMIMauWhKRWDCEnZe7viDPTkr4=
X-Received: by 2002:a17:906:8472:b0:a19:a1ba:da39 with SMTP id
 hx18-20020a170906847200b00a19a1bada39mr3815374ejc.96.1702495523398; Wed, 13
 Dec 2023 11:25:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212232535.1875938-1-andrii@kernel.org> <20231212232535.1875938-11-andrii@kernel.org>
 <f94dd0e3404253936b7489ea9aee3a530749c633.camel@gmail.com>
In-Reply-To: <f94dd0e3404253936b7489ea9aee3a530749c633.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 13 Dec 2023 11:25:11 -0800
Message-ID: <CAEf4BzaeEhfFB=ZSQO=i8hT6OP1bkT4b2pzHoViFA4Q_Vju1tA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 10/10] selftests/bpf: add freplace of
 BTF-unreliable main prog test
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 9:44=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Tue, 2023-12-12 at 15:25 -0800, Andrii Nakryiko wrote:
> > Add a test validating that freplace'ing another main (entry) BPF progra=
m
> > fails if the target BPF program doesn't have valid/expected func proto =
BTF.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
> I have two nitpicks, fill free to ignore.
> When test is run with -vvv, verifier log says:
>
>     -- BEGIN PROG LOAD LOG --
>     func#0 @0
>     Cannot replace static functions
>     processed 0 insns ...
>     -- END PROG LOAD LOG --
>
> Would it be possible to match the error message in this test?

Yes, if we add a bunch of extra log grabbing and matching logic to
fexit_bpf2bpf test. Which, honestly, I just didn't want to touch more
than I absolutely needed to. So I'll use your permission to ignore
this.


> Also, maybe kernel should be tweaked to be a bit more informative,
> as message about static function is confusing, wdyt?
>

Currently the verifier doesn't distinguish between reasons for
"unreliable". Not sure if it's worth tracking more information just
for this. Certainly that feels like an orthogonal to this series
improvement.

