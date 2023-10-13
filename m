Return-Path: <bpf+bounces-12156-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8261B7C8D30
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 20:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAB4EB20B2F
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 18:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20001A266;
	Fri, 13 Oct 2023 18:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YiI+HFlh"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576D91428A
	for <bpf@vger.kernel.org>; Fri, 13 Oct 2023 18:40:02 +0000 (UTC)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F23B83
	for <bpf@vger.kernel.org>; Fri, 13 Oct 2023 11:40:00 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-53db1fbee70so4173777a12.2
        for <bpf@vger.kernel.org>; Fri, 13 Oct 2023 11:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697222399; x=1697827199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p5VQ9XS9BKZw4KQRmwSOIM8UjAV9kKGOxiRZCoLu24s=;
        b=YiI+HFlhD1A+pSQm7hzV0DB9Bdiao+fyOgweKJshBDXIA4tH9PPw90NzcaX9P7hpEy
         64A2BlI/maDNYfmxkoLstiZnemZdr5YovNueM6xhntJ31Cg9LjIJCHvx1n+fzD+D3ljR
         6e/WcBly4IiTXIDWH8BjwQddmiWzpbeUwtSP8p4J7crHdXeVFawdVonQO+r3q5zR0coi
         fgtHa17vbspIjyjL+8zSX0bl22WF9iEybJc89SNzPKbz0/01gb5tvtF0zNwllwUi1HyS
         jcSxmByZmfArrDDUNvAFTe/VgiB7YL28ODy+yputFKp5zR41tvk9CiiSgEZ7lWykBV8U
         6WEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697222399; x=1697827199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p5VQ9XS9BKZw4KQRmwSOIM8UjAV9kKGOxiRZCoLu24s=;
        b=N0s/w5DPfynmQMchjsmN7f1N+tAFakqhTYpBAWmf0/9SZ+P3/1XD4lGEgoa9D366FH
         97LBcnTyFYbOlXFjAXtwLuSxGCXiRIWR88ykdW/Rd5LXAN9IUNLCCQLv118+G9YG9AZ+
         DMgR+ifjFI8HaeAmlvmjVT9/+OGoTbeYGec6yW9FyZeSIAmGBvFWeMmzOwFVaijy/Jym
         YE1t6LRov0lT3Z//uHs3XB968FR1r+gGv3amly2PHN0FrgLzIyCCSKvXjanBTPudvUaW
         I28PM2vaE3HnwB4YN9bUiyOygIubY1YunnLmBVqFnpwBKsUplcib4LQcClL89Smcw13Y
         /5rQ==
X-Gm-Message-State: AOJu0YwFnTbsfxL+Z7NF7vHtKgMcvjz6D1xj7eEvFBsBiMyyttWiYehM
	YgdYRxxrz3U0GlijM8Fj0CbsCPOehXPJIjEKUSMn5vZZ
X-Google-Smtp-Source: AGHT+IED57qUWcENl6IecxvoYmAjbCqXAcsoLH9/eh/QXmxSggC1TR8G1KDwukR/XZSiJd24+pH4+/iTvsULN39+Ucw=
X-Received: by 2002:a05:6402:4303:b0:53e:6239:a04a with SMTP id
 m3-20020a056402430300b0053e6239a04amr890921edc.24.1697222398394; Fri, 13 Oct
 2023 11:39:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231011091732.93254-1-alan.maguire@oracle.com>
 <20231011091732.93254-4-alan.maguire@oracle.com> <CAEf4BzZOMOBpwT6wkXeoh9gBQa5jruE=ynsH-1FOB6TRDxFqzQ@mail.gmail.com>
 <698efb39-c5d2-c322-e83c-f836c0166bd7@oracle.com>
In-Reply-To: <698efb39-c5d2-c322-e83c-f836c0166bd7@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 13 Oct 2023 11:39:46 -0700
Message-ID: <CAEf4BzYoBUZi4hSKB2xHyTkyLekL3or6kNKxtr8TnP843t9=EA@mail.gmail.com>
Subject: Re: [RFC dwarves 3/4] pahole: add --btf_features=feature1[,feature2...]
 support
To: Alan Maguire <alan.maguire@oracle.com>
Cc: acme@kernel.org, jolsa@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	eddyz87@gmail.com, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, mykolal@fb.com, bpf@vger.kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Oct 13, 2023 at 4:54=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> On 13/10/2023 01:21, Andrii Nakryiko wrote:
> > On Wed, Oct 11, 2023 at 2:17=E2=80=AFAM Alan Maguire <alan.maguire@orac=
le.com> wrote:
> >>
> >> This allows consumers to specify an opt-in set of features
> >> they want to use in BTF encoding.
> >
> > This is exactly what I had in mind, so thanks a lot for doing this!
> > Minor nits below, but otherwise a big thumb up from me for the overall
> > approach.
> >
>
> Great!
>
> >>
> >> Supported features are
> >>
> >>         encode_force  Ignore invalid symbols when encoding BTF.
> >
> > ignore_invalid? Even then I don't really know what this means even
> > after reading the description, but that's ok :)
> >
>
> The only place it is currently used is when checking btf_name_valid()
> on a variable - if encode_force is specified we skip invalidly-named
> symbols and drive on. I'll try and flesh out the description a bit.
>
>
> >>         var           Encode variables using BTF_KIND_VAR in BTF.
> >>         float         Encode floating-point types in BTF.
> >>         decl_tag      Encode declaration tags using BTF_KIND_DECL_TAG.
> >>         type_tag      Encode type tags using BTF_KIND_TYPE_TAG.
> >>         enum64        Encode enum64 values with BTF_KIND_ENUM64.
> >>         optimized     Encode representations of optimized functions
> >>                       with suffixes like ".isra.0" etc
> >>         consistent    Avoid encoding inconsistent static functions.
> >>                       These occur when a parameter is optimized out
> >>                       in some CUs and not others, or when the same
> >>                       function name has inconsistent BTF descriptions
> >>                       in different CUs.
> >
> > both optimized and consistent refer to functions, so shouldn't the
> > feature name include func somewhere?
> >
>
> Yeah, though consistent may eventually need to apply to variables too.
> As Stephen and I have been exploring adding global variable support for
> all variables, we've run across a bunch of cases where the same variable
> name refers to different types too. Worse, it often happens that the
> same variable name refers to a "struct foo" and a "struct foo *" which
> is liable to be very confusing. So I think we will either need to skip
> encoding such variables for now (the "consistent" approach used for
> functions) or we may have to sort out the symbol->address mapping issue
> in BTF for functions _and_ variables before we land variable support.
> My preference would be the latter - since it will solve the issues with
> functions too - but I think we can probably make either sequence work.
>
> So all of that is to say we can either stick with "consistent" with
> the expectation that it may be more broadly applied to variables, or
> convert to "consistent_func", I've no major preference which.
>
> Optimized definitely refers to functions so we can switch that to
> "optimized_func" if you like.
>

So I'd say optimized params will be its own feature, no? So yeah, I
think optimized_funcs is a better and more specific name. We can
probably add groups/aliases separate or later on, so then "optimized"
will mean both optimized_funcs and optimized_params, etc. Just like
you have all.

But this starts to sounds like a feature creep, so let's go with
specific names now, and worry about aliases when we need them.

> >>
> >> Specifying "--btf_features=3Dall" is the equivalent to setting
> >> all of the above.  If pahole does not know about a feature
> >> it silently ignores it.  These properties allow us to use
> >> the --btf_features option in the kernel pahole_flags.sh
> >> script to specify the desired set of features.  If a new
> >> feature is not present in pahole but requested, pahole
> >> BTF encoding will not complain (but will not encode the
> >> feature).
> >
> > As I mentioned in the cover letter reply, we might add a "strict mode"
> > flag, that will error out on unknown features. I don't have much
> > opinion here, up to Arnaldo and others whether this is useful.
> >
>
> I think this is a good idea. I'll add it to v2 unless anyone has major
> objections.
>

SGTM

> >>
> >> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> >> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> >> ---
> >>  man-pages/pahole.1 | 20 +++++++++++
> >>  pahole.c           | 87 +++++++++++++++++++++++++++++++++++++++++++++=
-
> >>  2 files changed, 106 insertions(+), 1 deletion(-)
> >>

[...]

