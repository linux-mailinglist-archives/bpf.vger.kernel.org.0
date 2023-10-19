Return-Path: <bpf+bounces-12689-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A13CE7CF627
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 13:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57C30281EFE
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 11:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C751618C07;
	Thu, 19 Oct 2023 11:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OOMko0mO"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DE8179B7
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 11:07:10 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBD2185
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 04:07:04 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9b6559cbd74so1339187366b.1
        for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 04:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697713623; x=1698318423; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FeHxAXJdGHLgcDgG819Ku/k2Xo9FM16qcxqvvwn0tvs=;
        b=OOMko0mOdl712UdDmIu8YBj8egFJ8DtxlIV3qUroUDRlC/Vogw/o4DrUCXz2pedZUt
         cguP4TeIyzc0Jaq5zzJFDd0I0pXAJUzxTzq+tyPL/PPpJT4kyTaQ24/p+khS6ZXAfAg5
         NuHDysjyA1Q5jJYmFfs5ll+JbmpMCcFR7x6G/PCLavfyV3H5cLK6FoChVCcJgJ8DJ/69
         1v81+E3E0tk+p1quLEjO32e5AuNrbKQydaijiP1yO5CB3DKZ2oTtRLupa6vqw2AxA8LS
         oPuznI0ZLYt3M+Tkr752AZ8K4bsp31XmcULrPG37mYHPqFhjTjoi5EUfULSTrpAv6uVB
         8sSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697713623; x=1698318423;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FeHxAXJdGHLgcDgG819Ku/k2Xo9FM16qcxqvvwn0tvs=;
        b=TA/IJoZeBGrzlkoyuTb5kdcuLfHvhYouof4HrKlQmsjnjvJbAZJNz+arkSUo6WXb1C
         /u9coRkFyS7QD8jDY0OqOVkfTpDSO8Yc1VaGCjYWCEA3rK0aqcc7F4AzNkitrLtbzfuP
         IvszBjOfj9aT0IKBQILJIPXv7wexp/5mgHixunYYdLRA4ZeBZTB8GrJ9foEN4S7U/uOB
         Qvze2+xkchY/2Neipl5lEl1lWo5B6CT/H4eCgwHiMWtrBZaszw0VXcf1ekh/F9xr8lUl
         tVGLfzf8XfxmDx0DNf6/o+4XJp1+PN3KLg04sOcBmZvu2QzgavFeHih8WBqI+HNwLtvJ
         Uqnw==
X-Gm-Message-State: AOJu0YwROfBlCRqUIoWLGk9pKa/On81s+GgOrtlMV6GHP+IpIZVzl3/o
	9M7HhThl9Mr2STLddASMpY0=
X-Google-Smtp-Source: AGHT+IELTrJaGqvsVjQEhumClDQkJ1yf5Gid78i+/9lFCz1TO6+IuyDtzuMG66MARiMntMvJ0OT8NA==
X-Received: by 2002:a17:907:72d0:b0:9bf:b5bc:6c50 with SMTP id du16-20020a17090772d000b009bfb5bc6c50mr1369258ejc.4.1697713622710;
        Thu, 19 Oct 2023 04:07:02 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id f4-20020a170906560400b009ad81554c1bsm3287141ejq.55.2023.10.19.04.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 04:07:01 -0700 (PDT)
Message-ID: <ca6ca9a23f4ad8e679e873940beceef4c7c172a7.camel@gmail.com>
Subject: Re: [PATCH v3 dwarves 0/5] pahole, btf_encoder: support
 --btf_features
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, acme@kernel.org, 
	andrii.nakryiko@gmail.com
Cc: jolsa@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev,  song@kernel.org, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@kernel.org,  sdf@google.com,
 haoluo@google.com, mykolal@fb.com, bpf@vger.kernel.org
Date: Thu, 19 Oct 2023 14:07:00 +0300
In-Reply-To: <20231018122926.735416-1-alan.maguire@oracle.com>
References: <20231018122926.735416-1-alan.maguire@oracle.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2023-10-18 at 13:29 +0100, Alan Maguire wrote:
> Currently, the kernel uses pahole version checking as the way to
> determine which BTF encoding features to request from pahole.  This
> means that such features have to be tied to a specific version and
> as new features are added, additional clauses in scripts/pahole-flags.sh
> have to be added; for example
>=20
> if [ "${pahole_ver}" -ge "125" ]; then
>         extra_paholeopt=3D"${extra_paholeopt} --skip_encoding_btf_inconsi=
stent_proto --btf_gen_optimized"
> fi
>=20
> To better future-proof this process, this series introduces a
> single "btf_features" parameter that uses a comma-separated list
> of encoding options.  This is helpful because
>=20
> - the semantics are simpler for the user; the list comprises the set of
>   BTF features asked for, rather than having to specify a combination of
>   --skip_encoding_btf_feature and --btf_gen_feature options; and
> - any version of pahole that supports --btf_features can accept the
>   option list; unknown options are silently ignored.  As a result, there
>   would be no need to add additional version clauses beyond
>=20
> if [ "${pahole_ver}" -ge "126" ]; then
>         extra_pahole_opt=3D"-j --lang_exclude=3Drust
> --btf_features=3Dencode_force,var,float,decl_tag,type_tag,enum64,optimize=
d_func,consistent_func"
> fi
>=20
>   Newly-supported features would simply be appended to the btf_features
>   list, and these would have impact on BTF encoding only if the features
>   were supported by pahole.  This means pahole will not require a version
>   bump when new BTF features are added, and should ease the burden of
>   coordinating such changes between bpf-next and dwarves.
>=20
> Patches 1 and 2 are preparatory work, while patch 3 adds the
> --btf_features support.  Patch 4 provides a means of querying
> the supported feature set since --btf_features will not error
> out when it encounters unrecognized features (this ensures
> an older pahole without a requested feature will not dump warnings
> in the build log for kernel/module BTF generation).  Patch 5
> adds --btf_features_strict, which is identical to --btf_features
> aside from the fact it will fail if an unrecognized feature is used.
>=20
> See [1] for more background on this topic.
>=20
> Changes since v2 [2]:
> - added acks from Andrii and Jiri (patches 1-5)
> - merged suggestions from Eduard which simplify and clean up code
>   considerably; these changes fix issues with --btf_features_strict
>   while providing better diagnostic output when an unknown feature
>   is encountered (specifying the unknown feature if in verbose
>   or strict modes).  Added Suggested-bys from Eduard for the
>   relevant patches (Eduard, patches 3,5)
>=20
> Changes since RFC [3]:
>=20
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
>=20
> [1] https://lore.kernel.org/bpf/CAEf4Bzaz1UqqxuZ7Q+KQee-HLyY1nwhAurBE2n9Y=
TWchqoYLbg@mail.gmail.com/
> [2] https://lore.kernel.org/bpf/20231013153359.88274-1-alan.maguire@oracl=
e.com/
> [3] https://lore.kernel.org/bpf/20231011091732.93254-1-alan.maguire@oracl=
e.com/

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

Hi Alan,

thank you for accommodating my changes, I've tested this patch-set and
everything seems to work fine.
I left one nitpick for patch #3 feel free to ignore it if you don't agree.

Thanks,
Eduard



