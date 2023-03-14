Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE8D26B9188
	for <lists+bpf@lfdr.de>; Tue, 14 Mar 2023 12:22:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbjCNLWW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Mar 2023 07:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbjCNLWR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Mar 2023 07:22:17 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106C987A35;
        Tue, 14 Mar 2023 04:21:49 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id f18so19551682lfa.3;
        Tue, 14 Mar 2023 04:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678792907;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YxLZd2G4eMO1n0QEMBSqPpLqzSkJkPkShGMuo23NQf0=;
        b=GjxiKB+Yu+18P1uFK37adLy+90Ig4mKpegvLJUjbR4VyQIHRXCgRSTULuoY33dzKNP
         8qExdM6fUGokwf9vDW7h3zs5QuDdwzVWjYJO/D4sblTJsDvbe9c+GvDG0kHvFHBv9oX2
         dHVDJFYlxJXFx1NM6oog6X9vhwkxavJoyUTmsTdtMVj8VeY9S35X0OLaj2U5tjOcCqjm
         PYm7u2MqnI08lh4W29+EtgVGRNsCxJpV4zmBtzeuFjPd6eCFIcVE0o2E5c5ScjJRVrCS
         E95jgm4UnYGedkS42cpZ7mJDo37jjiU1A1z5HXMnk1ifNTKCjPQsq7vRvSGH56upDpm7
         lbYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678792907;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YxLZd2G4eMO1n0QEMBSqPpLqzSkJkPkShGMuo23NQf0=;
        b=AAdWaauh+bf2/KtsMNjJdjEL/zckCCz7mzmWxTnloAJ8oxD5a7oOJ+VWAkrZfHlNW1
         u2dsEfy8vyD385sUe9dGmzQZQlcVAQxdvnasrpuwC7GfMTNd1sXMXL03KkGu8a2gspZf
         Ugmtu2stnxGaV7SfaKDRL3xHWU26jXXQZSKm5MeJseGvMOBGawZClBGaD8uvL4YB+cQK
         cBuE1WcrsneDJZcGKOr+GzYe9gpEOJHcveL81klTObXL8hiTd7+7i5hSV1kgkkLaI8u7
         mbT7nJ9bNPb3uJSTfwbWilLQznf4v4LE6Cl997U6TR+HYk9nzMR52cXtY77hf7rdz2zx
         O4Kg==
X-Gm-Message-State: AO0yUKUG2zbuMK0QGi2ZkvGUK4A7K0fmHzoQ7ZVxj89J92HXD2O4D8dy
        iKLJYtwEj1sXiGXa+jDx320=
X-Google-Smtp-Source: AK7set81/7Y2iGgCtuoXfQyEom9t7oNhCfyhC5LYkTaz5uZ5ky/figvn21d9WQP8cbQU5XE/AOjnZw==
X-Received: by 2002:a05:6512:24f:b0:4dd:998b:4dc7 with SMTP id b15-20020a056512024f00b004dd998b4dc7mr661582lfo.21.1678792907099;
        Tue, 14 Mar 2023 04:21:47 -0700 (PDT)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id x26-20020a19f61a000000b004d988f59633sm361093lfe.161.2023.03.14.04.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 04:21:46 -0700 (PDT)
Message-ID: <1cb31e59286d33620e33d478fc8e948593e121ce.camel@gmail.com>
Subject: Re: [PATCH dwarves 1/1] dwarf_loader: Support for btf:type_tag
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Alan Maguire <alan.maguire@oracle.com>, dwarves@vger.kernel.org,
        arnaldo.melo@gmail.com
Cc:     bpf@vger.kernel.org, kernel-team@fb.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, yhs@fb.com,
        jose.marchesi@oracle.com, david.faust@oracle.com
Date:   Tue, 14 Mar 2023 13:21:43 +0200
In-Reply-To: <cd8636e4-0d76-b26d-7ddf-b28d2896b05a@oracle.com>
References: <20230313021744.406197-1-eddyz87@gmail.com>
         <20230313021744.406197-2-eddyz87@gmail.com>
         <cd8636e4-0d76-b26d-7ddf-b28d2896b05a@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 2023-03-14 at 10:30 +0000, Alan Maguire wrote:
[...]
> > See also:
> > [1] Mailing list discussion regarding `btf:type_tag`
> >     https://lore.kernel.org/bpf/87r0w9jjoq.fsf@oracle.com/
> >=20
>=20
> I know there's a v2 coming but one suggestion and one other issue below..
>=20
> this is a great explanation, thanks for the details! one other thing that=
 might help
> here is specifying that the solution adopted is option 2 described in tha=
t discussion
> (at least I think it is?).

Hi Alan,

Yes, it's option #2, sorry should have noted it in the original message.

[...]

> > -static void ftype__recode_dwarf_types(struct tag *tag, struct cu *cu);
> > +/** Add @tuple to @ctx->mappings array, extend it if necessary. */
> > +static int push_btf_type_tag_mapping(struct btf_type_tag_mapping *tupl=
e,
> > +				     struct recode_context *ctx)
> > +{
> > +	if (ctx->nr_allocated =3D=3D ctx->nr_entries) {
> > +		uint32_t new_nr =3D ctx->nr_allocated * 2;
> > +		void *new_array =3D reallocarray(ctx->mappings, new_nr,
> > +					       sizeof(ctx->mappings[0]));
>=20
> older libcs won't have reallocarray; might be good to either replace with=
 realloc
> or define our own variant in dutil.h like was done with libbpf_reallocarr=
ay()?

Will use `realloc()`, thank you for the heads-up.

Thanks,
Eduard
