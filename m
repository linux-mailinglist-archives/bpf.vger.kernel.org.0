Return-Path: <bpf+bounces-12292-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 616E07CAA93
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 15:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1915B20DB7
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 13:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1CC2869A;
	Mon, 16 Oct 2023 13:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UF09JfgO"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739BD27EF8
	for <bpf@vger.kernel.org>; Mon, 16 Oct 2023 13:56:19 +0000 (UTC)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24F29B
	for <bpf@vger.kernel.org>; Mon, 16 Oct 2023 06:56:17 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-53dd752685fso7934807a12.3
        for <bpf@vger.kernel.org>; Mon, 16 Oct 2023 06:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697464576; x=1698069376; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ut0aOhIEBeKKYKpdsR+h9/gfyQesAuLvQWzXwIN3yv0=;
        b=UF09JfgOZyxVOg16lu7Vgfw2SRyWb8hjTwJk+sMJ84HQTRPinRlCWUhQNvFLiwK1ji
         LCU+ycdoFKh457o+CDpkYtsp/dpN9d/sEwR7f8gSuxi0Jo/7ftW8uRxT/9iy4Fm/a/p3
         OEzLNLs65e9V2+X+EFcNFAfXQQMjymGxP2riRbuh7AQr3dH1bm+BNteRtfIT5W6b5LTH
         kXC8qmB1OGEO+DpAcAt1wDKwHs3uLtGT/2/VBwPqjJvf/OQr5elgN3WW0pCJqAe7SE0A
         PvAfeT/+M5vtaktUNKvvgaHDfuBJg4k/P35gaaPoilEBYZvRDBKEgkkc1gopK2GqnH4W
         4XEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697464576; x=1698069376;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ut0aOhIEBeKKYKpdsR+h9/gfyQesAuLvQWzXwIN3yv0=;
        b=EI6+c7IC2HL1PN4/8af7+xNWdC/4fJ5FF/RcuViLpwHprPPgt+SxQ0fl+x7026cd/q
         bCw8NXsJ3k2XL/Ki5iqHdFhk40jC7WynzRF1Fxqfy9Fislx+hDZ5tXGWTAU8Tmb4g7NQ
         icgLoE1WzNYkTrNf8lePIQeb4jooMc3QkWFmkxau8cIVNIqkhjncl3MZaMKUfxHPZVmh
         Tg+rhRkqUnHF0p5sHRFs9m8DAyEuhxHFAuSIYhmfQUiudKRMZ+SMxeCWR3QOBnLnUq/u
         U6gTOVlNItMg6ZEcbCyQmJbIy9eq+lUJIOg70w9QI9ZBPAimxwV2N29snyokbJefEN5T
         mmyg==
X-Gm-Message-State: AOJu0Yyy/OZsvraKUM4mFUgiCnzlDsTfuDo8Ve0ZT2D5AH1ZIFLLsrdH
	DV/qd38YNM9sN6Kl1Ju9qmV3dAvkHwo=
X-Google-Smtp-Source: AGHT+IH96i6mpp9JzwwdkGVz1h7CoLwI+bQPHMApgmBaCQfcA8VV3DFn7bsZw6OZkbUp1KMTGgGhZQ==
X-Received: by 2002:a17:907:928c:b0:9c3:cefa:93c0 with SMTP id bw12-20020a170907928c00b009c3cefa93c0mr2865216ejc.38.1697464575758;
        Mon, 16 Oct 2023 06:56:15 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id b8-20020a17090636c800b009c4cb1553edsm1164742ejc.95.2023.10.16.06.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 06:56:14 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 16 Oct 2023 15:56:13 +0200
To: Alan Maguire <alan.maguire@oracle.com>
Cc: acme@kernel.org, andrii.nakryiko@gmail.com, ast@kernel.org,
	daniel@iogearbox.net, eddyz87@gmail.com, martin.lau@linux.dev,
	song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
	mykolal@fb.com, bpf@vger.kernel.org
Subject: Re: [PATCH v2 dwarves 0/5] pahole, btf_encoder: support
 --btf_features
Message-ID: <ZS1A/VeqRDFD/f54@krava>
References: <20231013153359.88274-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013153359.88274-1-alan.maguire@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Oct 13, 2023 at 04:33:54PM +0100, Alan Maguire wrote:
> Currently, the kernel uses pahole version checking as the way to
> determine which BTF encoding features to request from pahole.  This
> means that such features have to be tied to a specific version and
> as new features are added, additional clauses in scripts/pahole-flags.sh
> have to be added; for example
> 
> if [ "${pahole_ver}" -ge "125" ]; then
>         extra_paholeopt="${extra_paholeopt} --skip_encoding_btf_inconsistent_proto --btf_gen_optimized"
> fi
> 
> To better future-proof this process, this series introduces a
> single "btf_features" parameter that uses a comma-separated list
> of encoding options.  This is helpful because
> 
> - the semantics are simpler for the user; the list comprises the set of
>   BTF features asked for, rather than having to specify a combination of
>   --skip_encoding_btf_feature and --btf_gen_feature options; and
> - any version of pahole that supports --btf_features can accept the
>   option list; unknown options are silently ignored.  As a result, there
>   would be no need to add additional version clauses beyond
> 
> if [ "${pahole_ver}" -ge "126" ]; then
>         extra_pahole_opt="-j --lang_exclude=rust
> --btf_features=encode_force,var,float,decl_tag,type_tag,enum64,optimized,consistent"
> fi
> 
>   Newly-supported features would simply be appended to the btf_features
>   list, and these would have impact on BTF encoding only if the features
>   were supported by pahole.  This means pahole will not require a version
>   bump when new BTF features are added, and should ease the burden of
>   coordinating such changes between bpf-next and dwarves.
> 
> Patches 1 and 2 are preparatory work, while patch 3 adds the
> --btf_features support.  Patch 4 provides a means of querying
> the supported feature set since --btf_features will not error
> out when it encounters unrecognized features (this ensures
> an older pahole without a requested feature will not dump warnings
> in the build log for kernel/module BTF generation).  Patch 5
> adds --btf_features_strict, which is identical to --btf_features
> aside from the fact it will fail if an unrecognized feature is used.
> 
> See [1] for more background on this topic.
> 
> Changes since RFC [2]:
> 
> - ensure features are disabled unless requested; use "default" field in
>   "struct btf_features" to specify the conf_load default value which
>   corresponds to the feature being disabled.  For
>   conf_load->btf_gen_floats for example, the default value is false,
>   while for conf_load->skip_encoding_btf_type_tags the default is
>   true; in both cases the intent is to _not_ encode the associated
>   feature by default.  However if the user specifies "float" or
>   "type_tag" in --btf_features, the default conf_load value is negated,
>   resulting in a BTF encoding that contains floats and type tags
>   (Eduard, patch 3)
> - clarify feature default/setting behaviour and how it only applies
>   when --btf_features is used (Eduard, patch 3)
> - ensure we do not run off the end of the feature_list[] array
>   (Eduard, patch 3)
> - rather than having each struct btf_feature record the offset in the
>   conf_load structure of the boolean (requiring us to later do pointer
>   math to update it), record the pointers to the boolean conf_load
>   values associated with each feature (Jiri, patch 3)
> - allow for multiple specifications of --btf_features, enabling the
>   union of all features specified (Andrii, patch 3)
> - rename function-related optimized/consistent to optimized_func and
>   consistent_func in recognition of the fact they are function-specific
>   (Andrii, patch 3)
> - add a strict version of --btf_features, --btf_features_strict that
>   will error out if an unrecognized feature is used (Andrii, patch 5)
> 
> [1] https://lore.kernel.org/bpf/CAEf4Bzaz1UqqxuZ7Q+KQee-HLyY1nwhAurBE2n9YTWchqoYLbg@mail.gmail.com/
> [2] https://lore.kernel.org/bpf/20231011091732.93254-1-alan.maguire@oracle.com/
> 

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> Alan Maguire (5):
>   btf_encoder, pahole: move btf encoding options into conf_load
>   dwarves: move ARRAY_SIZE() to dwarves.h
>   pahole: add --btf_features support
>   pahole: add --supported_btf_features
>   pahole: add --btf_features_strict to reject unknown BTF features
> 
>  btf_encoder.c      |   8 +--
>  btf_encoder.h      |   2 +-
>  dwarves.c          |  16 -----
>  dwarves.h          |  19 ++++++
>  man-pages/pahole.1 |  32 +++++++++
>  pahole.c           | 167 +++++++++++++++++++++++++++++++++++++++++----
>  6 files changed, 210 insertions(+), 34 deletions(-)
> 
> -- 
> 2.31.1
> 

