Return-Path: <bpf+bounces-8351-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AFD2785714
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 13:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70EA41C20C3B
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 11:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1176BE55;
	Wed, 23 Aug 2023 11:48:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6786BA34
	for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 11:48:15 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D27FD3;
	Wed, 23 Aug 2023 04:48:14 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-99357737980so726078666b.2;
        Wed, 23 Aug 2023 04:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692791293; x=1693396093;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JcwskZsrCRrgS36tHYAJTHDpFh9Wjgu4eN2vWD3M+NQ=;
        b=ngzWZs4JudOXfCd5a8uXHtrrC14kHvjG+DLg8t4zXAztBodpKxIeJIRW5luJhw48nZ
         kUyjUHzcNP/a97GvHghOfNKj6iMq/uoyxSu4/FxC+5rg6j0W7r2jcszOYPjepVrtjUM/
         EwXYIWrWG5XjLEy71Adll0uNt0On3HQWIJvL15nVNH1UkbVuk7oK+uBv89Uxq8cD3S1B
         7MOxxnHaz/eZEbO/fVWqeUzLWHirylir0PhdDP3or2xUgyn2ypGi3gsulGdITr9BhUWG
         QMjuk8TKQM5olpvy7belsNvOsQ3mq3rARCpZq5ZJv1fQwyP3tJjC77UQMFVUTgW8782e
         vx0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692791293; x=1693396093;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JcwskZsrCRrgS36tHYAJTHDpFh9Wjgu4eN2vWD3M+NQ=;
        b=Q9g6dm0gGWtJaLbURHAfwgZ5UjoeblQ0p+3zr+8MTp+lkgGxRLg6UmUYRtNczE5EPu
         63rUZ9p4xEpZ/KwFfzRiT+MYdQ9eiX1tNfzxtoPYPPBVRY2pDAcdFNTQ3RPaelXE25kJ
         8E58BQqgVtl8AjXRGthte9coAOSgyxpO9pPkj1IjitMLSj7dOrvv9IIo51cKuvf/TN1l
         2MVKCgJHQz6htyA5YzmW3Vnai/tfBovoRBOZGwkAgBOaeATGkTC8IC3uh1goCMCB3zJl
         gDEc33zCV5OOeGXx1W2P55nsB8iLeNnWuLRchCK51l6izuQjW1D+gY3tLtO3w2QlXPEK
         x+Cw==
X-Gm-Message-State: AOJu0YyiBscgBILs78LQ/6B+a1z4zz5ELdyzAGQq6RXlOeVuYQ2RM9XE
	AGneWjKj5Sg7SY736IrFNus=
X-Google-Smtp-Source: AGHT+IFxRW5lcZ+RptmpUaj5dkRYe6Aw6nUs3mvRv5+V9166Zfr6ateKbVaKwa3UffHQNCq7Am2pIA==
X-Received: by 2002:a17:906:225c:b0:994:555a:e49f with SMTP id 28-20020a170906225c00b00994555ae49fmr2176436ejr.31.1692791292472;
        Wed, 23 Aug 2023 04:48:12 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id dt9-20020a170906b78900b0099bcf9c2ec6sm9524503ejb.75.2023.08.23.04.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 04:48:11 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 23 Aug 2023 13:48:09 +0200
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
	haoluo@google.com, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next] libbpf: Add bpf_object__unpin()
Message-ID: <ZOXx+emQcLTKcPwP@krava>
References: <aeb83832ae61bbf463e1b2e39c1e30c3b227f5a5.1692769396.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeb83832ae61bbf463e1b2e39c1e30c3b227f5a5.1692769396.git.dxu@dxuuu.xyz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 22, 2023 at 11:44:25PM -0600, Daniel Xu wrote:
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
> @@ -8376,6 +8376,21 @@ int bpf_object__pin(struct bpf_object *obj, const char *path)
>  	return 0;
>  }
>  
> +int bpf_object__unpin(struct bpf_object *obj, const char *path)
> +{
> +	int err;
> +
> +	err = bpf_object__unpin_programs(obj, path);
> +	if (err)
> +		return libbpf_err(err);
> +
> +	err = bpf_object__unpin_maps(obj, path);
> +	if (err)
> +		return libbpf_err(err);
> +
> +	return 0;
> +}
> +
>  static void bpf_map__destroy(struct bpf_map *map)
>  {
>  	if (map->inner_map) {
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 2e3eb3614c40..0e52621cba43 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -266,6 +266,7 @@ LIBBPF_API int bpf_object__pin_programs(struct bpf_object *obj,
>  LIBBPF_API int bpf_object__unpin_programs(struct bpf_object *obj,
>  					  const char *path);
>  LIBBPF_API int bpf_object__pin(struct bpf_object *object, const char *path);
> +LIBBPF_API int bpf_object__unpin(struct bpf_object *object, const char *path);
>  
>  LIBBPF_API const char *bpf_object__name(const struct bpf_object *obj);
>  LIBBPF_API unsigned int bpf_object__kversion(const struct bpf_object *obj);
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index 841a2f9c6fef..abf8fea3988e 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -399,4 +399,5 @@ LIBBPF_1.3.0 {
>  		bpf_program__attach_netfilter;
>  		bpf_program__attach_tcx;
>  		bpf_program__attach_uprobe_multi;
> +		bpf_object__unpin;

nit, I think we add in here in alphabetical order

jirka

>  } LIBBPF_1.2.0;
> -- 
> 2.41.0
> 

