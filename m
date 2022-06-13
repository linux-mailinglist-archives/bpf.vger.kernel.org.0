Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A2C549C99
	for <lists+bpf@lfdr.de>; Mon, 13 Jun 2022 21:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345215AbiFMTBG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Jun 2022 15:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244193AbiFMTAt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Jun 2022 15:00:49 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA1D95A3E
        for <bpf@vger.kernel.org>; Mon, 13 Jun 2022 09:22:39 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id s10so6731228ljh.12
        for <bpf@vger.kernel.org>; Mon, 13 Jun 2022 09:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=mF2hn/Z/GNnY49NnJXwCrywJPikUcZcGELZpy1cbWi4=;
        b=o7fVpaDjzbq40mCgoEt8kWuKfdIG2JW+970L7DvQnQ2RPiLiW8+0X+PwbmNsowgG41
         yAhM1ShzKyke3gZUCeTyOT5e/fTMebIy5KmiFLwG1U+BBOpXveKn4k9TaMO4x3pY6e9Z
         p+Q4xYsRuJemtaSmJlwkrwG28jwVSnnD4h1Dc4kDYv+bqA6S39CP8tCN9iwiziEnWv6V
         D3MSgPg0Y6dhNNVN4ztOcGBwsmkchDzNAUlOg4yXlofeCWn9SrtKFRuwdQD/+SOrbN11
         wW0tESoGU+Tt9aD3eyn2eQ1daLaYYLbqezXxe+QrUyIZfpFEUyw5Ea5VQwxSN5O0xQi+
         c4AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=mF2hn/Z/GNnY49NnJXwCrywJPikUcZcGELZpy1cbWi4=;
        b=Q/ozEK0fZP3b3vmM+fcwbRtpJpUPt5IBdN4IIWDKT9eTJ63vbhkFF0Q2zCdWVIFVDs
         pb3XdBIK6S6C7ioBjU98kVSHKyALmWUpewxq/ojSh4nNb4b9dNi9ZktbxP+wZ7pN3KHJ
         YfJaigTGRT/uQqAwaQE8SNdAXjfSN9OrMOvejp47Ck/LVxA0PhhD3wcnDFh9ZhGtX43r
         VpBp7J+inrE46agkA/yHY0kTlyo3N2B90AYQ3dnwT9ev4yF3iEkd7HnZNmofaS4cGHKT
         OtOlKSVO3SW4gRGUjWlbHkrk5kp1evN7Ts5C9WkXxVrCdSDrBK6ky+a/R34iYUh2bY3l
         7kDg==
X-Gm-Message-State: AJIora84qaJDwKwscpMEkUc3Hy41vO5mj9JfHTu58rk5hUq9OK9z6Sup
        1LkSGFi+XnKCP+flY7EbEb4=
X-Google-Smtp-Source: AGRyM1s+PCZGu2BIp4qKg8Kx2jo4PgGFjduphrYoNSK58SXNfj4MRa7DY6vvqvXouHrUK00RvpVq/A==
X-Received: by 2002:a2e:ba06:0:b0:255:b837:a36c with SMTP id p6-20020a2eba06000000b00255b837a36cmr172984lja.81.1655137357975;
        Mon, 13 Jun 2022 09:22:37 -0700 (PDT)
Received: from [192.168.1.113] (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id v22-20020a2e9256000000b002554b7b9a16sm1051192ljg.73.2022.06.13.09.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 09:22:37 -0700 (PDT)
Message-ID: <97c0de337b9471caf91c203885676e5078aac0f1.camel@gmail.com>
Subject: Re: [PATCH bpf-next v6 3/5] bpf: Inline calls to bpf_loop when
 callback is known
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Song Liu <song@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>, joannelkoong@gmail.com
Date:   Mon, 13 Jun 2022 19:22:35 +0300
In-Reply-To: <CAPhsuW44ryeaWog0+md=q-MgdaUqJQczcoksybKzmCy9j=w7hA@mail.gmail.com>
References: <20220613150141.169619-1-eddyz87@gmail.com>
         <20220613150141.169619-4-eddyz87@gmail.com>
         <CAPhsuW44ryeaWog0+md=q-MgdaUqJQczcoksybKzmCy9j=w7hA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 (by Flathub.org) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> On Mon, 2022-06-13 at 08:48 -0700, Song Liu wrote:
> > +static int optimize_bpf_loop(struct bpf_verifier_env *env)
> > +                       new_prog =3D inline_bpf_loop(env,
> > +                                                  i + delta,
> > +                                                  -(stack_depth + stac=
k_depth_extra),
> > +                                                  inline_state->callba=
ck_subprogno,
> > +                                                  &cnt);
> > +                       if (!new_prog)
> > +                               return -ENOMEM;
>=20
> We do not fail over for -ENOMEM, which is reasonable. (It is also reasona=
ble if
> we do fail the program with -ENOMEM. However, if we don't fail the progra=
m,
> we need to update stack_depth properly before returning, right?
>=20

Ouch, you are correct! Sorry, this was really sloppy on my side. The
behavior here should be the same as in `do_misc_fixups` which does
fail in case of -ENOMEM. In order to do the same `optimize_bpf_loop`
should remain as is but the following part of the patch has to be
updated:

> @@ -15031,6 +15193,9 @@ int bpf_check(struct bpf_prog **prog, union bpf_a=
ttr *attr, bpfptr_t uattr)
>  		ret =3D check_max_stack_depth(env);
>
>  	/* instruction rewrites happen after this point */
> +	if (ret =3D=3D 0)
> +		optimize_bpf_loop(env);
> +

It should be as follows:

+	if (ret =3D=3D 0)
+		ret =3D optimize_bpf_loop(env);  // added `ret` assignment!

Not sure if there is a reasonable way to write a test for this case.
I will add this change and produce the v7 today. Do you see anything
else that should be updated?

Thanks,
Eduard
