Return-Path: <bpf+bounces-12108-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5CD7C7AC5
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 02:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 064B3282C85
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 00:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C5136E;
	Fri, 13 Oct 2023 00:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M1W0+ACo"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5425B360
	for <bpf@vger.kernel.org>; Fri, 13 Oct 2023 00:14:56 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED5EB7
	for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 17:14:53 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-53e07db272cso2183411a12.3
        for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 17:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697156091; x=1697760891; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gDptXA1m58j5qO7s5hJ+bYpM1Wq79BbWNR0YKrAgK2g=;
        b=M1W0+ACoNEC90cfhKY/FiIS+sn7zxj6JdvvC3hTwjw8jeJCQr+KylOfDg2AAfAV6E2
         x1i8CfzCgSeYuvjHdCsLlWDPSa9u5kam4WXjdkIhOGzjqoaG9umfQqqBriKvmPkFDvFQ
         d7soF4P4aIaUKtl/JNqoMzvETM+2fTKkb/gshzY1HnIOhh2Z+AuYX2dbHMNuwkIa0eVb
         fxnKNiWCHjkHGkIeyb+3fbd+JD6yo6Kg5tlDpnW4BT73RSahabux+sUuDjcmLnMqON4r
         ApoRf10CpNTSYNa2QpLojtvJWuUvBrwzjLJlw9NPFmOizfNuXPfSExUvud9i576oFUPh
         geQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697156091; x=1697760891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gDptXA1m58j5qO7s5hJ+bYpM1Wq79BbWNR0YKrAgK2g=;
        b=sL+/Ch3jm9oakpEO+2FtJAaAQi8vBsqf0bksfFnNe44HQyCwydjjvjN+BJK1307KO1
         DbrRAQIMKxZDwnoxfozjmmpAGgv0LqxOY35xzcz+3luVtyfy6GbqJrzBsxKla9J2SNNR
         SyQnMqY8TVpk0Np6+d7XqVLGDU0fTJb6YsghjEcZJHChLWkzOrnKzPZcwTD08SoNafEC
         ZSsHMt6OK9h3FHQbk71DlxEwtdRE/Eol+Qe4dKmbEBz47WlXTeG+qNW3Ept1Uugvlfdw
         /eqcbFlu3XUWuK2XOK6kYX+DMBdkewqVwJZwHB4k8Wa13SPz8yTd2agQFrAeIRN37Ms+
         3ntw==
X-Gm-Message-State: AOJu0Yy5P0jDCSjbaHcbmo6RMXHtKd7PkCR0k+WJvNBR65ccXKVean8o
	ORjF8HnzjmlADPUGboAObnYabs4hGOYtAyH/sOk=
X-Google-Smtp-Source: AGHT+IFa+fqk3Dq+b79fmOqSAemhtRCMSuLbWOdFzinns4/m+l7o/RX7yfIgOtVq6rN4ZYNIdZ7SB4rVSQ+sKdyXYvE=
X-Received: by 2002:a50:ab57:0:b0:53e:1a0:6a13 with SMTP id
 t23-20020a50ab57000000b0053e01a06a13mr3532403edc.7.1697156091612; Thu, 12 Oct
 2023 17:14:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231011091732.93254-1-alan.maguire@oracle.com>
In-Reply-To: <20231011091732.93254-1-alan.maguire@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 12 Oct 2023 17:14:40 -0700
Message-ID: <CAEf4BzYs4wAScts5rZYVzBy4h-psRi58Unbq+5qKF+=m9tFsnQ@mail.gmail.com>
Subject: Re: [RFC dwarves 0/4] pahole, btf_encoder: support --btf_features
To: Alan Maguire <alan.maguire@oracle.com>
Cc: acme@kernel.org, jolsa@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	eddyz87@gmail.com, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, mykolal@fb.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 11, 2023 at 2:17=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> Currently, the kernel uses pahole version checking as the way to
> determine which BTF encoding features to request from pahole.  This
> means that such features have to be tied to a specific version and
> as new features are added, additional clauses in scripts/pahole-flags.sh
> have to be added; for example
>
> if [ "${pahole_ver}" -ge "125" ]; then
>         extra_paholeopt=3D"${extra_paholeopt} --skip_encoding_btf_inconsi=
stent_proto --btf_gen_optimized"
> fi
>
> To better future-proof this process, we can have a catch-all
> single "btf_features" parameter that uses a comma-separated list
> of encoding options.  What makes this better is that any version
> of pahole that supports btf_features can accept the option list;
> unknown options are silently ignored. However there would be no need
> to add additional version clauses beyond
>
> if [ "${pahole_ver}" -ge "126" ]; then
>         extra_pahole_opt=3D"-j --lang_exclude=3Drust
> --btf_features=3Dencode_force,var,float,decl_tag,type_tag,enum64,optimize=
d,consistent"

I've seen a nice convention used in a lot of CLIs that allow multiple
values for a given parameter:

--btf_feature=3Dencode_force --btf=3Dvar --btf=3Dfloat and so on

It simplifies parsing code, and is also a bit more "modular" in
scripts. But it's just a minor nit, feel free to ignore.

> fi
>
> Newly-supported features would simply be appended to the btf_features
> list, and these would have impact on BTF encoding only if the features
> were supported by pahole.  This means pahole will not require a version
> bump when new BTF features are added, and should ease the burden of
> coordinating such changes between bpf-next and dwarves.

Yep, this is great.

>
> Patches 1 and 2 are preparatory work, while patch 3 adds the
> --btf_features support.  Patch 4 provides a means of querying
> the supported feature set since --btf_features will not error
> out when it encounters an unrecognized features (this ensures
> an older pahole without a requested feature will not dump warnings
> in the build log for kernel/module BTF generation).

List of features is great. I think we can also have something like
--btf_features_strict to make pahole error out if an unsupported
feature is specified.


>
> See [1] for more background on this topic.
>
> [1] https://lore.kernel.org/bpf/CAEf4Bzaz1UqqxuZ7Q+KQee-HLyY1nwhAurBE2n9Y=
TWchqoYLbg@mail.gmail.com/
>
> Alan Maguire (4):
>   btf_encoder, pahole: move btf encoding options into conf_load
>   dwarves: move ARRAY_SIZE() to dwarves.h
>   pahole: add --btf_features=3Dfeature1[,feature2...] support
>   pahole: add --supported_btf_features to display feature support
>
>  btf_encoder.c      |   8 +--
>  btf_encoder.h      |   2 +-
>  dwarves.c          |  16 ------
>  dwarves.h          |  19 +++++++
>  man-pages/pahole.1 |  24 +++++++++
>  pahole.c           | 127 ++++++++++++++++++++++++++++++++++++++++-----
>  6 files changed, 162 insertions(+), 34 deletions(-)
>
> --
> 2.31.1
>

