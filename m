Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A53AA681DA4
	for <lists+bpf@lfdr.de>; Mon, 30 Jan 2023 23:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjA3WE7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Jan 2023 17:04:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbjA3WEt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Jan 2023 17:04:49 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC18F2FCEF
        for <bpf@vger.kernel.org>; Mon, 30 Jan 2023 14:04:35 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id j29-20020a05600c1c1d00b003dc52fed235so3705508wms.1
        for <bpf@vger.kernel.org>; Mon, 30 Jan 2023 14:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3g4atxfx7e+KCYDM9aRV+o7t4dz+VqTx/sSUN8fU4Gw=;
        b=YMgDMteQq40BVcIzmP5We/9nv8bJ+UUZXBv8wNDIs/2Mvq3fM5N3qN3Q7ZWdJBOA4T
         PZ0tfb5wV9GDIi1Kn39Nlo9sSpVmgFEIZ899ObqwFUSvvMT2l8ESmWiyqUjMLKMkHWOQ
         xYgxC7o0NwjVVdwisURcEPHm38ga7NPwb3hLk0e3LdSla+oTCS+TMvmZlemmE/3Fqh0V
         3WBqsVTRz0tPlUhcBzs6TMn2o4Ti8zdkKBXpJj4IZkcRiGbbHM48E2kExAojgwJzyGLI
         r6iCnmDwuh1OZMuJbVc1ixjWU065aVhVSUaqbXTI0oo58HJh5Uxc/n1zX7l/Y1eTpfWr
         Qq8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3g4atxfx7e+KCYDM9aRV+o7t4dz+VqTx/sSUN8fU4Gw=;
        b=NGphh3ccrDxXbnOycB8nxqsJoapyYfG7fB/+qgBn6EaBkovBhcSAZ9NETzGiEEk73T
         b38eCcxElYr2oU/NvCshKFixLxTkacikwordTBNjMhOBC3XvUtppsQn8/jlMH2JPaDrU
         mslrWN9iwKBBS2cIZfzIHmUWL5l2TPeYjMitlPmaxYgclWjjo+mZgnqiBwouuN/terc3
         J8kvIOl087Da6Jb5JuwVrykd10lmyz8Qd/Rwb1fmqTLKBFHrUuy1u5aPD2dMjTvNxskN
         Pa8cPGrD7rznBN+jTznhWYmhox7rmZRDoZHhSOWI/ZDkHHvPFV8IXmX28a8pi2+AhNLy
         zYWg==
X-Gm-Message-State: AFqh2krbdg3ojdil0qcClHcVjRxipds1l8ZlJsUe699px4fdiDbX3qSP
        DPPiawSyGpTOofkOTILdt2a22LkOhb2XhgE/
X-Google-Smtp-Source: AMrXdXto3jhZzy2CpL0a28gj3+KDOQqG8/42QtCxQfJvJ7oetHBmfG5jCvygSERAvbUVC1GI6Wm9mA==
X-Received: by 2002:a05:6402:49:b0:49e:33ce:144d with SMTP id f9-20020a056402004900b0049e33ce144dmr134879113edu.37.1675116263690;
        Mon, 30 Jan 2023 14:04:23 -0800 (PST)
Received: from krava ([83.240.61.48])
        by smtp.gmail.com with ESMTPSA id r23-20020aa7c157000000b0049e1f167956sm3689662edp.9.2023.01.30.14.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 14:04:23 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Mon, 30 Jan 2023 23:04:20 +0100
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     acme@kernel.org, yhs@fb.com, ast@kernel.org, olsajiri@gmail.com,
        eddyz87@gmail.com, sinquersw@gmail.com, timo@incline.eu,
        daniel@iogearbox.net, andrii@kernel.org, songliubraving@fb.com,
        john.fastabend@gmail.com, kpsingh@chromium.org, sdf@google.com,
        haoluo@google.com, martin.lau@kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v2 dwarves 3/5] btf_encoder: rework btf_encoders__*() API
 to allow traversal of encoders
Message-ID: <Y9g+5LlDrOjqS5ES@krava>
References: <1675088985-20300-1-git-send-email-alan.maguire@oracle.com>
 <1675088985-20300-4-git-send-email-alan.maguire@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1675088985-20300-4-git-send-email-alan.maguire@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 30, 2023 at 02:29:43PM +0000, Alan Maguire wrote:
> To coordinate across multiple encoders at collection time, there
> will be a need to access the set of encoders.  Rework the unused
> btf_encoders__*() API to facilitate this.
> 
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  btf_encoder.c | 30 ++++++++++++++++++++++--------
>  btf_encoder.h |  6 ------
>  2 files changed, 22 insertions(+), 14 deletions(-)
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 44f1905..e20b628 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -30,6 +30,7 @@
>  
>  #include <errno.h>
>  #include <stdint.h>
> +#include <pthread.h>
>  
>  struct elf_function {
>  	const char	*name;
> @@ -79,21 +80,32 @@ struct btf_encoder {
>  	} functions;
>  };
>  
> -void btf_encoders__add(struct list_head *encoders, struct btf_encoder *encoder)
> -{
> -	list_add_tail(&encoder->node, encoders);
> -}
> +static LIST_HEAD(encoders);
> +static pthread_mutex_t encoders__lock = PTHREAD_MUTEX_INITIALIZER;
>  
> -struct btf_encoder *btf_encoders__first(struct list_head *encoders)
> +/* mutex only needed for add/delete, as this can happen in multiple encoding
> + * threads.  Traversal of the list is currently confined to thread collection.
> + */
> +static void btf_encoders__add(struct btf_encoder *encoder)
>  {
> -	return list_first_entry(encoders, struct btf_encoder, node);
> +	pthread_mutex_lock(&encoders__lock);
> +	list_add_tail(&encoder->node, &encoders);
> +	pthread_mutex_unlock(&encoders__lock);
>  }
>  
> -struct btf_encoder *btf_encoders__next(struct btf_encoder *encoder)
> +#define btf_encoders__for_each_encoder(encoder)		\
> +	list_for_each_entry(encoder, &encoders, node)
> +
> +static void btf_encoders__delete(struct btf_encoder *encoder)
>  {
> -	return list_next_entry(encoder, node);
> +	pthread_mutex_lock(&encoders__lock);
> +	list_del(&encoder->node);
> +	pthread_mutex_unlock(&encoders__lock);
>  }
>  
> +#define btf_encoders__for_each_encoder(encoder)			\
> +	list_for_each_entry(encoder, &encoders, node)
> +

there's extra btf_encoders__for_each_encoder define

hum I'm scratching my head how this compile, probably because it's identical

jirka


>  #define PERCPU_SECTION ".data..percpu"
>  
>  /*
> @@ -1505,6 +1517,7 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
>  
>  		if (encoder->verbose)
>  			printf("File %s:\n", cu->filename);
> +		btf_encoders__add(encoder);
>  	}
>  out:
>  	return encoder;
> @@ -1519,6 +1532,7 @@ void btf_encoder__delete(struct btf_encoder *encoder)
>  	if (encoder == NULL)
>  		return;
>  
> +	btf_encoders__delete(encoder);
>  	__gobuffer__delete(&encoder->percpu_secinfo);
>  	zfree(&encoder->filename);
>  	btf__free(encoder->btf);
> diff --git a/btf_encoder.h b/btf_encoder.h
> index a65120c..34516bb 100644
> --- a/btf_encoder.h
> +++ b/btf_encoder.h
> @@ -23,12 +23,6 @@ int btf_encoder__encode(struct btf_encoder *encoder);
>  
>  int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct conf_load *conf_load);
>  
> -void btf_encoders__add(struct list_head *encoders, struct btf_encoder *encoder);
> -
> -struct btf_encoder *btf_encoders__first(struct list_head *encoders);
> -
> -struct btf_encoder *btf_encoders__next(struct btf_encoder *encoder);
> -
>  struct btf *btf_encoder__btf(struct btf_encoder *encoder);
>  
>  int btf_encoder__add_encoder(struct btf_encoder *encoder, struct btf_encoder *other);
> -- 
> 1.8.3.1
> 
