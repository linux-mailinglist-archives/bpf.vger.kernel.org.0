Return-Path: <bpf+bounces-12422-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C187CC3D0
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 14:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FF881C20AEC
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 12:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AFBE42BF2;
	Tue, 17 Oct 2023 12:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dinDgrVT"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4519D41E34
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 12:57:51 +0000 (UTC)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F703F0
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 05:57:49 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-53db360294fso9995759a12.3
        for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 05:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697547468; x=1698152268; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BoeNzOO9utnW9I1a0+lFfY2UvjEqeJjm/R9O0yeFilc=;
        b=dinDgrVTmq/imggnUCd1TqNvFPlpVpL3/28gh1kCnOXywPGa+LlL9ZM+GVTMUn5ttd
         ijXZpXMuwNsf019ApsXphI94xDexEV/hHll4nHhDk0iTEVX4HpvFxcRwPuPPzPZjBqIh
         YsneYkS4SwqebTDrc3XtcoFHUckjoip3iuHR3BdThaMD7F52zJiO66QfCu8lwrwvO4vi
         XGsZ6vpiFUS3bNvIUEeHBiCTnwNuURZLg750FHg1wYA4lZBN9fGD80aI9Q192npdd7Ca
         JM8IoFAUlmk6oOsRJnQ7If5R08uLl8YhSr1V7pTJwX7iRS5ZFY2bZ1Rh6rgkSb3V3lLy
         qCXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697547468; x=1698152268;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BoeNzOO9utnW9I1a0+lFfY2UvjEqeJjm/R9O0yeFilc=;
        b=WF6mRUtQWh85s+58VTFfOKNDgOK4+Yc+MFZm3nviLe8QDIGLAL00nzKbaBAEvKVT/6
         t/dhYn1FycWRzeO2tOPdXqq5jTkLMbR78Uj5wl3ZU+u8dRuAP4doXCMd7AtpvSyM2Ka9
         iv219JgQ3O1aJOc1q6kvNpPubgcefySj+Rh5Q9xQfjGy1fx9+YtHwSvYYQll+PIj9fAj
         gQ50zWM5zUXmFYFzQm1ncGL3lqkqF15AExMAJuPKtJxET6G2sq4fWCf6QpW/lhZZoSNu
         EcHhhUQpD90Yy77aeSMmnYQzGwrrPpbBhFOOlLOA6lKshZhNHUPLqi2Bjelvb3PPERo1
         XkUQ==
X-Gm-Message-State: AOJu0Yw2NUE0c40v5hPSbvSIO7TTPHNJr04YU/fQjGu9nChx2/2neRmk
	8gz3xZklFrBvpV32Ias79VA=
X-Google-Smtp-Source: AGHT+IHfF4haZWqOGEMqYyVjYczdOJU5YF2Iesaf5XTIGUY0fUCk/4Qy8nPjeqzje95sg2DnRgxwRA==
X-Received: by 2002:a05:6402:42d3:b0:53d:fffc:36ec with SMTP id i19-20020a05640242d300b0053dfffc36ecmr2059954edc.16.1697547467493;
        Tue, 17 Oct 2023 05:57:47 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id ev12-20020a056402540c00b00533e915923asm1170246edb.49.2023.10.17.05.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 05:57:47 -0700 (PDT)
Message-ID: <42b74a5e36fa013262138a33ba635afe7c15a085.camel@gmail.com>
Subject: Re: [PATCH v2 dwarves 0/5] pahole, btf_encoder: support
 --btf_features
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, acme@kernel.org, 
	andrii.nakryiko@gmail.com
Cc: jolsa@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev,  song@kernel.org, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@kernel.org,  sdf@google.com,
 haoluo@google.com, mykolal@fb.com, bpf@vger.kernel.org
Date: Tue, 17 Oct 2023 15:57:45 +0300
In-Reply-To: <20231013153359.88274-1-alan.maguire@oracle.com>
References: <20231013153359.88274-1-alan.maguire@oracle.com>
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
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, 2023-10-13 at 16:33 +0100, Alan Maguire wrote:
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
d,consistent"
> fi

Nitpick, could you please update the line above as below?

  --btf_features_strict=3Dencode_force,var,float,decl_tag,type_tag,enum64,o=
ptimized_func,consistent_func

