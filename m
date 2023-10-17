Return-Path: <bpf+bounces-12470-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F867CCB47
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 20:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 185681F234C5
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 18:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A7945F42;
	Tue, 17 Oct 2023 18:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aoXJd725"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A63F2D7AB
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 18:53:16 +0000 (UTC)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC369F
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 11:53:15 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-5384975e34cso10675117a12.0
        for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 11:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697568793; x=1698173593; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tyYgB0LAVThivCO+sUzjlOvN7ymGD6G+SKDcRXQZS5o=;
        b=aoXJd725cA4iUFme6bF4w9mFfr2WC7SXOVUJMr2sBuK0iX7qIhi8vvwqUu1Pbx3t0h
         KTo5AKW/0CsoCY3noUgjyVQq9y2YntOPxL+rxQdqdumEFNYu9k7tDSe34Fq5T72uMUNQ
         0gHmdUtfsTlSCL6GYUcV1sFjYjhwQDlj7cvFQpkaDKcd5+y+7t6wGGntQ3dvjcUorCgG
         Wcsots6qRtw/yt3y+g1BXnvVxr58PP+VReCbYdZ1xVzjkZ4Y4NbAHu5sYg5jjqh6IBaX
         Em633NTSbDYnZ1NIK0KHzwkGaRQmHblazIRd3T/TTMBA5wb0wSztNYfjV7c8X2sBQaHF
         FBUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697568793; x=1698173593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tyYgB0LAVThivCO+sUzjlOvN7ymGD6G+SKDcRXQZS5o=;
        b=IKq4RdFTHgpxpHDeU2drldrlTU034rur4cM7Z2gFAslbygxcR6+gZm7HRU+C9Yo/Lj
         pN2HjDPUYRmr8SBgjLY0hHmc0zqfAzPjTZykk0NfLkAaLnbv25L8bibK6u0OAPE9vavU
         SLkKeWoeuFxw34+G13xJ5P+1jr9A4KuwFI9BWDpOfWm9kioRqStxSjzyIGkv3hYBrBeP
         mSmrw8lMLIjtgu+C6z81jbUuahtr4lLEKYi+ljJ5XUdbtREZ+5rSzcoRDvjApUVQK+11
         9yaFVTB2blRPpz1xlslnUSn86bmBmqWC2etwK6bbw5ICsLzOnyfwJKLLkaZuBhkFchLo
         ba4A==
X-Gm-Message-State: AOJu0Ywnck+TawKqCU8Ka9V5M3hT1WAC128Eig9bQFGTDMPGX758F992
	2nhJv3KYdpzndpCQDzXtQA5zHJ8q8biRRoB1+hM=
X-Google-Smtp-Source: AGHT+IHoaSLY+TeOEuwe16dTKrb19R+KBl/y+dVWkWY5s+S7XFmqfVxGv06Wr1zJowMfEq88do2DP6huxlR1yp59tY4=
X-Received: by 2002:a50:9fe3:0:b0:53d:a1c0:410e with SMTP id
 c90-20020a509fe3000000b0053da1c0410emr2672161edf.7.1697568793518; Tue, 17 Oct
 2023 11:53:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231013153359.88274-1-alan.maguire@oracle.com> <42b74a5e36fa013262138a33ba635afe7c15a085.camel@gmail.com>
In-Reply-To: <42b74a5e36fa013262138a33ba635afe7c15a085.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 17 Oct 2023 11:53:02 -0700
Message-ID: <CAEf4BzZJv5OyQ5Hktgj2GKD+usgiDx9R+TjyTScE1wPBWjn4Qg@mail.gmail.com>
Subject: Re: [PATCH v2 dwarves 0/5] pahole, btf_encoder: support --btf_features
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, acme@kernel.org, jolsa@kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org, 
	yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, mykolal@fb.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 17, 2023 at 5:57=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Fri, 2023-10-13 at 16:33 +0100, Alan Maguire wrote:
> > Currently, the kernel uses pahole version checking as the way to
> > determine which BTF encoding features to request from pahole.  This
> > means that such features have to be tied to a specific version and
> > as new features are added, additional clauses in scripts/pahole-flags.s=
h
> > have to be added; for example
> >
> > if [ "${pahole_ver}" -ge "125" ]; then
> >         extra_paholeopt=3D"${extra_paholeopt} --skip_encoding_btf_incon=
sistent_proto --btf_gen_optimized"
> > fi
> >
> > To better future-proof this process, this series introduces a
> > single "btf_features" parameter that uses a comma-separated list
> > of encoding options.  This is helpful because
> >
> > - the semantics are simpler for the user; the list comprises the set of
> >   BTF features asked for, rather than having to specify a combination o=
f
> >   --skip_encoding_btf_feature and --btf_gen_feature options; and
> > - any version of pahole that supports --btf_features can accept the
> >   option list; unknown options are silently ignored.  As a result, ther=
e
> >   would be no need to add additional version clauses beyond
> >
> > if [ "${pahole_ver}" -ge "126" ]; then
> >         extra_pahole_opt=3D"-j --lang_exclude=3Drust
> > --btf_features=3Dencode_force,var,float,decl_tag,type_tag,enum64,optimi=
zed,consistent"
> > fi
>
> Nitpick, could you please update the line above as below?
>
>   --btf_features_strict=3Dencode_force,var,float,decl_tag,type_tag,enum64=
,optimized_func,consistent_func

We do not want "strict" behavior for the kernel build script.

I'd say we will want to use a multi arg variant as it's more composable:

--btf_features=3Dencode_force \
--btf_feature=3Dvar \

and so on.


Either way, this patch set overall looks good to me:

Acked-by: Andrii Nakryiko <andrii@kernel.org>

