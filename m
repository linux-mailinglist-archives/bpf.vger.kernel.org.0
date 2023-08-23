Return-Path: <bpf+bounces-8394-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B43785E71
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 19:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BAC228126E
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 17:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A5C1F176;
	Wed, 23 Aug 2023 17:19:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCE4C139
	for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 17:19:26 +0000 (UTC)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27555E7E;
	Wed, 23 Aug 2023 10:19:24 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so108754a12.1;
        Wed, 23 Aug 2023 10:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692811162; x=1693415962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=smBNS46SHfccBsCDweoV6A2fiGS6o0dTFw9e1IdcIlY=;
        b=af6PX9W371+Gy+INbzK5y3ZlkgyS2hrzS6JC0G5vfdXCX53eaDeP5BVAoD+dRoePCU
         Wo6PG0WZNfg+j9bQlIwPZGvJ9WWTVZReK2LWu9PDu1wgVvGQ+fRFpGu4d/G1f+Sd7h9p
         eWzD2cgRfL014VR0zFfP0SZfxE7OIlmPwwmlE8NnxVZ+H5xnDGf0mtzQmtkaQ+pZJFtT
         LDybIoes8XXWMOAi4mEiioChb3SvRke7dNNLcpHtIn2XjVctZhqSXP2QEF0mOsloeHc7
         kQTisNk6sv22NcPGk4KJpAEJRuzn5HB07s7g9V4ESCCxQksTh5b2sTsxZHcY/HVeVJPT
         StTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692811162; x=1693415962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=smBNS46SHfccBsCDweoV6A2fiGS6o0dTFw9e1IdcIlY=;
        b=EZ4m6SpixbDIU6DgbeuKkcIdanXennknBDz6E9GGsY32haQ2hODclsq4aJhVH0Go2e
         RwpC3VALyy5qYKXcQjYu0kRvZTzmoALC+RMf2jaTcO2JsnSrF9oUUPL4AQYcls3OZFYT
         8FukB2RpjyQ3I8vcf/ET6S8a5m613mFRfRTJuKIP5BnjH5zffyU2xX4hLzL+rgqKZimK
         fH1s0+NhjAZZ0I8+l+fHzRmGNzu7RXU3v1kp3cMCzGP3s6Zusw3sbU8NgrOEIplr3eWP
         yblzduNsifgipCvA+8yykGkCy2FaOGDSl2+H/UKnLIa5ecKmpJXD4i5y1Ip19QnVu4Sn
         duYg==
X-Gm-Message-State: AOJu0YxoHoSnn36W5liwI9vVI+JGQBe2ClZJ/txpznu4/Zf+XwmGSZc6
	IIpHZj/UHCIzPnZ4slsV6Sqo5sfUU9sNHZrcEws=
X-Google-Smtp-Source: AGHT+IFxFebLDqOGGbsvZ7f2aTF0WXlhVRnL30siCMn9A7OevM/8iw7zRw5ga73NmRDOCpCxwW3JeaNPxGNqLdknz4M=
X-Received: by 2002:a05:6402:440f:b0:525:4696:336d with SMTP id
 y15-20020a056402440f00b005254696336dmr16241440eda.8.1692811162423; Wed, 23
 Aug 2023 10:19:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aeb83832ae61bbf463e1b2e39c1e30c3b227f5a5.1692769396.git.dxu@dxuuu.xyz>
In-Reply-To: <aeb83832ae61bbf463e1b2e39c1e30c3b227f5a5.1692769396.git.dxu@dxuuu.xyz>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 23 Aug 2023 10:19:10 -0700
Message-ID: <CAEf4BzbGhhOyeWLuP95K20344aZnQ61TjiQ=scd5TKz_fiP_AQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Add bpf_object__unpin()
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 22, 2023 at 10:44=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> For bpf_object__pin_programs() there is bpf_object__unpin_programs().
> Likewise bpf_object__unpin_maps() for bpf_object__pin_maps().
>
> But no bpf_object__unpin() for bpf_object__pin(). Adding the former adds
> symmetry to the API.
>
> It's also convenient for cleanup in application code. It's an API I
> would've used if it was available for a repro I was writing earlier.
>
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---
>  tools/lib/bpf/libbpf.c   | 15 +++++++++++++++
>  tools/lib/bpf/libbpf.h   |  1 +
>  tools/lib/bpf/libbpf.map |  1 +
>  3 files changed, 17 insertions(+)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 4c3967d94b6d..96ff1aa4bf6a 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -8376,6 +8376,21 @@ int bpf_object__pin(struct bpf_object *obj, const =
char *path)
>         return 0;
>  }
>
> +int bpf_object__unpin(struct bpf_object *obj, const char *path)
> +{
> +       int err;
> +
> +       err =3D bpf_object__unpin_programs(obj, path);
> +       if (err)
> +               return libbpf_err(err);
> +
> +       err =3D bpf_object__unpin_maps(obj, path);
> +       if (err)
> +               return libbpf_err(err);
> +
> +       return 0;
> +}
> +

pin APIs predate me, and I barely ever use them, but I wonder if
people feel fine with the fact that if any single unpin fails, all the
other programs/maps will not be unpinned? I also wonder if the best
effort unpinning of everything (while propagating first/last error) is
more practical? Looking at bpf_object__pin_programs, we try unpin
everything, even if some unpins fail.

Any thoughts or preferences?

>  static void bpf_map__destroy(struct bpf_map *map)
>  {
>         if (map->inner_map) {
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 2e3eb3614c40..0e52621cba43 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -266,6 +266,7 @@ LIBBPF_API int bpf_object__pin_programs(struct bpf_ob=
ject *obj,
>  LIBBPF_API int bpf_object__unpin_programs(struct bpf_object *obj,
>                                           const char *path);
>  LIBBPF_API int bpf_object__pin(struct bpf_object *object, const char *pa=
th);
> +LIBBPF_API int bpf_object__unpin(struct bpf_object *object, const char *=
path);
>
>  LIBBPF_API const char *bpf_object__name(const struct bpf_object *obj);
>  LIBBPF_API unsigned int bpf_object__kversion(const struct bpf_object *ob=
j);
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index 841a2f9c6fef..abf8fea3988e 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -399,4 +399,5 @@ LIBBPF_1.3.0 {
>                 bpf_program__attach_netfilter;
>                 bpf_program__attach_tcx;
>                 bpf_program__attach_uprobe_multi;
> +               bpf_object__unpin;
>  } LIBBPF_1.2.0;
> --
> 2.41.0
>

