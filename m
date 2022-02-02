Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BAA04A765D
	for <lists+bpf@lfdr.de>; Wed,  2 Feb 2022 18:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbiBBRAZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Feb 2022 12:00:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26812 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230401AbiBBRAY (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 2 Feb 2022 12:00:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643821224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I6RwFSZT05qzCJcW4r0ewmQek1g1YFuQ0vQAboQA1k0=;
        b=BXP7fTd2qED/omVcDKnrdRTFyadX2v/1nRQ3F7TpSRLFieVn7prTPi9TZHEgWgdWCioBJ0
        GKpqxHZrGQir4lMIGlBT398CD0QNCFTaCsRfQEsN+20tRJ0sBImzxlD/SIVCawQnH1rKm0
        PeX567guH1ap28eyX8mw1PLm0flF01o=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-338-7Q3isfSaPOSUDZ5xW9IhPA-1; Wed, 02 Feb 2022 12:00:22 -0500
X-MC-Unique: 7Q3isfSaPOSUDZ5xW9IhPA-1
Received: by mail-ej1-f70.google.com with SMTP id x16-20020a170906135000b006b5b4787023so8448434ejb.12
        for <bpf@vger.kernel.org>; Wed, 02 Feb 2022 09:00:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=I6RwFSZT05qzCJcW4r0ewmQek1g1YFuQ0vQAboQA1k0=;
        b=aUVUcDFBiHU7bvPritxxM1J9fH3CCg2F5BWmAl+5usQ9c/mnVfe//Lvp3nspYSGYZP
         Wx3fApU3zORPNmmsG1nfRu2I2IfcQr4Vw8U0q6Pu84Vblij8WsvBRbe/uBe0J6QjKsnv
         4nJ+ytso3uTpjkzw5Vd2x4gIjTp7Tzr1hTrKy1qqJnTJecYlhZwt/qySmKiy3FpvCUoh
         sKUkKk9on15O6+L8f6ZWDxY68F6sYOWpCB162tfjNgPj1ARyn++7wTsWOQQT+ajlPEgj
         APMjrNfF/1FhuIQUgJRlcUdxyNM+UZUBguaRQ14qBVXpC9TLEzqLuVkJ/fd47A4vcpsM
         tuxg==
X-Gm-Message-State: AOAM533nmoJn12EwdzASAlryKpyzLk4jPjO0YXBS/2AsS8gx/F9S4VH1
        IzN6oidinqKjpWGo7CLtVstf1a+ok+nqm4SbMoxPN3nBX6N0kWyvJMWG/f5tIA2xiA8GWRykVai
        4tVXSV5t5/NyO
X-Received: by 2002:a17:906:9756:: with SMTP id o22mr17666060ejy.448.1643821221615;
        Wed, 02 Feb 2022 09:00:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxt2K79nagGae2RyUI317cqDvLS9xeLNwgy7fUFJHAIV2pmOoO8OSRHWMDSIt1a0ATJQVOdSQ==
X-Received: by 2002:a17:906:9756:: with SMTP id o22mr17666037ejy.448.1643821221293;
        Wed, 02 Feb 2022 09:00:21 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id ch27sm17127285edb.74.2022.02.02.09.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 09:00:20 -0800 (PST)
Date:   Wed, 2 Feb 2022 18:00:19 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Christy Lee <christylee@fb.com>
Cc:     andrii@kernel.org, acme@kernel.org, christyc.y.lee@gmail.com,
        bpf@vger.kernel.org, linux-perf-users@vger.kernel.org,
        kernel-team@fb.com, wangnan0@huawei.com,
        bobo.shaobowang@huawei.com, yuehaibing@huawei.com
Subject: Re: [PATCH bpf-next v4 2/2] perf: stop using deprecated
 bpf_object__next() API
Message-ID: <Yfq4o0Op4eYvFKIp@krava>
References: <20220119230636.1752684-1-christylee@fb.com>
 <20220119230636.1752684-3-christylee@fb.com>
 <Ye2LAEiXaBoj2n8Z@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ye2LAEiXaBoj2n8Z@krava>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

hi,
just checking, do you plan to send new version for this?

thanks,
jirka

On Sun, Jan 23, 2022 at 06:06:08PM +0100, Jiri Olsa wrote:
> On Wed, Jan 19, 2022 at 03:06:36PM -0800, Christy Lee wrote:
> 
> SNIP
> 
> > ---
> >  tools/perf/util/bpf-loader.c | 72 +++++++++++++++++++++++++++---------
> >  tools/perf/util/bpf-loader.h |  1 +
> >  2 files changed, 55 insertions(+), 18 deletions(-)
> > 
> > diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
> > index 4631cac3957f..b1822f8af2bb 100644
> > --- a/tools/perf/util/bpf-loader.c
> > +++ b/tools/perf/util/bpf-loader.c
> > @@ -29,9 +29,6 @@
> >  
> >  #include <internal/xyarray.h>
> >  
> > -/* temporarily disable libbpf deprecation warnings */
> > -#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
> > -
> >  static int libbpf_perf_print(enum libbpf_print_level level __attribute__((unused)),
> >  			      const char *fmt, va_list args)
> >  {
> > @@ -49,6 +46,36 @@ struct bpf_prog_priv {
> >  	int *type_mapping;
> >  };
> >  
> > +struct bpf_perf_object {
> > +	struct bpf_object *obj;
> > +	struct list_head list;
> > +};
> > +
> > +static LIST_HEAD(bpf_objects_list);
> 
> hum.. I still can't see any code adding/removing bpf_perf_object
> objects to this list, and that's why the code is failing to remove
> probes
> 
> because there are no objects to iterate on, so added probes stay
> configured and screw following tests
> 
> you need something like below to add and del objects from
> bpf_objects_list list
> 
> it also simplifies for_each macros to work just over perf_obj,
> because I wasn't patient enough to make it work with the extra
> bpf_object ;-) I don't mind if you fix that, but this way looks
> simpler to me
> 
> tests are working for me with this fix, please feel free to
> squash it into your change
> 
> thanks,
> jirka
> 
> 
> ---
> diff --git a/tools/perf/tests/bpf.c b/tools/perf/tests/bpf.c
> index 57b9591f7cbb..d09d25707f1e 100644
> --- a/tools/perf/tests/bpf.c
> +++ b/tools/perf/tests/bpf.c
> @@ -210,6 +210,11 @@ prepare_bpf(void *obj_buf, size_t obj_buf_sz, const char *name)
>  		pr_debug("Compile BPF program failed.\n");
>  		return NULL;
>  	}
> +
> +	if (bpf_perf_object__add(obj)) {
> +		bpf_object__close(obj);
> +		return NULL;
> +	}
>  	return obj;
>  }
>  
> diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
> index 89e584ac267c..a7a8ad32c847 100644
> --- a/tools/perf/util/bpf-loader.c
> +++ b/tools/perf/util/bpf-loader.c
> @@ -70,11 +70,11 @@ struct bpf_perf_object *bpf_perf_object__next(struct bpf_perf_object *prev)
>  	return next;
>  }
>  
> -#define bpf_perf_object__for_each(perf_obj, tmp, obj)                          \
> -	for ((perf_obj) = bpf_perf_object__next(NULL),                         \
> -	    (tmp) = bpf_perf_object__next(perf_obj), (obj) = NULL;             \
> -	     (perf_obj) != NULL; (perf_obj) = (tmp),                           \
> -	    (tmp) = bpf_perf_object__next(tmp), (obj) = (perf_obj)->obj)
> +#define bpf_perf_object__for_each(perf_obj, tmp)         \
> +	for ((perf_obj) = bpf_perf_object__next(NULL),   \
> +	     (tmp) = bpf_perf_object__next(perf_obj);    \
> +	     (perf_obj) != NULL; (perf_obj) = (tmp),     \
> +	    (tmp) = bpf_perf_object__next(tmp) )
>  
>  static bool libbpf_initialized;
>  
> @@ -97,6 +97,24 @@ bpf__prepare_load_buffer(void *obj_buf, size_t obj_buf_sz, const char *name)
>  	return obj;
>  }
>  
> +int bpf_perf_object__add(struct bpf_object *obj)
> +{
> +	struct bpf_perf_object *perf_obj = zalloc(sizeof(*perf_obj));
> +
> +	if (perf_obj) {
> +		perf_obj->obj = obj;
> +		list_add_tail(&perf_obj->list, &bpf_objects_list);
> +	}
> +	return perf_obj ? 0 : -ENOMEM;
> +}
> +
> +static void bpf_perf_object__close(struct bpf_perf_object *perf_obj)
> +{
> +	list_del(&perf_obj->list);
> +	bpf_object__close(perf_obj->obj);
> +	free(perf_obj);
> +}
> +
>  struct bpf_object *bpf__prepare_load(const char *filename, bool source)
>  {
>  	struct bpf_object *obj;
> @@ -135,17 +153,20 @@ struct bpf_object *bpf__prepare_load(const char *filename, bool source)
>  		return obj;
>  	}
>  
> +	if (bpf_perf_object__add(obj)) {
> +		bpf_object__close(obj);
> +		return ERR_PTR(-BPF_LOADER_ERRNO__COMPILE);
> +	}
>  	return obj;
>  }
>  
>  void bpf__clear(void)
>  {
>  	struct bpf_perf_object *perf_obj, *tmp;
> -	struct bpf_object *obj;
>  
> -	bpf_perf_object__for_each(perf_obj, tmp, obj) {
> -		bpf__unprobe(obj);
> -		bpf_object__close(obj);
> +	bpf_perf_object__for_each(perf_obj, tmp) {
> +		bpf__unprobe(perf_obj->obj);
> +		bpf_perf_object__close(perf_obj);
>  	}
>  }
>  
> @@ -1538,11 +1559,10 @@ apply_obj_config_object(struct bpf_object *obj)
>  int bpf__apply_obj_config(void)
>  {
>  	struct bpf_perf_object *perf_obj, *tmp;
> -	struct bpf_object *obj;
>  	int err;
>  
> -	bpf_perf_object__for_each(perf_obj, tmp, obj) {
> -		err = apply_obj_config_object(obj);
> +	bpf_perf_object__for_each(perf_obj, tmp) {
> +		err = apply_obj_config_object(perf_obj->obj);
>  		if (err)
>  			return err;
>  	}
> @@ -1550,25 +1570,24 @@ int bpf__apply_obj_config(void)
>  	return 0;
>  }
>  
> -#define bpf__perf_for_each_map(perf_obj, tmp, obj, map)                        \
> -	bpf_perf_object__for_each(perf_obj, tmp, obj)                          \
> -		bpf_object__for_each_map(map, obj)
> +#define bpf__perf_for_each_map(perf_obj, tmp, map)                   \
> +	bpf_perf_object__for_each(perf_obj, tmp)                     \
> +		bpf_object__for_each_map(map, perf_obj->obj)
>  
> -#define bpf__perf_for_each_map_named(perf_obj, tmp, obj, map, name)            \
> -	bpf__perf_for_each_map(perf_obj, tmp, obj, map)                        \
> +#define bpf__perf_for_each_map_named(perf_obj, tmp, map, name)            \
> +	bpf__perf_for_each_map(perf_obj, tmp, map)                        \
>  		if (bpf_map__name(map) && (strcmp(name, bpf_map__name(map)) == 0))
>  
>  struct evsel *bpf__setup_output_event(struct evlist *evlist, const char *name)
>  {
>  	struct bpf_map_priv *tmpl_priv = NULL;
>  	struct bpf_perf_object *perf_obj, *tmp;
> -	struct bpf_object *obj;
>  	struct evsel *evsel = NULL;
>  	struct bpf_map *map;
>  	int err;
>  	bool need_init = false;
>  
> -	bpf__perf_for_each_map_named(perf_obj, tmp, obj, map, name) {
> +	bpf__perf_for_each_map_named(perf_obj, tmp, map, name) {
>  		struct bpf_map_priv *priv = bpf_map__priv(map);
>  
>  		if (IS_ERR(priv))
> @@ -1604,7 +1623,7 @@ struct evsel *bpf__setup_output_event(struct evlist *evlist, const char *name)
>  		evsel = evlist__last(evlist);
>  	}
>  
> -	bpf__perf_for_each_map_named(perf_obj, tmp, obj, map, name) {
> +	bpf__perf_for_each_map_named(perf_obj, tmp, map, name) {
>  		struct bpf_map_priv *priv = bpf_map__priv(map);
>  
>  		if (IS_ERR(priv))
> diff --git a/tools/perf/util/bpf-loader.h b/tools/perf/util/bpf-loader.h
> index 95262b7e936f..78c7d3662910 100644
> --- a/tools/perf/util/bpf-loader.h
> +++ b/tools/perf/util/bpf-loader.h
> @@ -83,6 +83,8 @@ int bpf__strerror_config_obj(struct bpf_object *obj,
>  int bpf__apply_obj_config(void);
>  int bpf__strerror_apply_obj_config(int err, char *buf, size_t size);
>  
> +int bpf_perf_object__add(struct bpf_object *obj);
> +
>  int bpf__setup_stdout(struct evlist *evlist);
>  struct evsel *bpf__setup_output_event(struct evlist *evlist, const char *name);
>  int bpf__strerror_setup_output_event(struct evlist *evlist, int err, char *buf, size_t size);

