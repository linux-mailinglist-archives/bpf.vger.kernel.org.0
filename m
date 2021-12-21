Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB8447BBC1
	for <lists+bpf@lfdr.de>; Tue, 21 Dec 2021 09:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235556AbhLUIW5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Dec 2021 03:22:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48586 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234713AbhLUIW4 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 21 Dec 2021 03:22:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640074975;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YiEBtqVMI3AfI7hLxBSh0p15rHT1GTRnDFKf1L4c1i4=;
        b=GEHKacPEGa39G83BA19sYBC+mceco7Bb/ux3ZrHcnsQqhMLLmnVXuDzx17xwF1mj/EJQPO
        vSZVMM+qbNMHZjmsj7tASimpD9RkAIukqQ4Ej7220Dk4a+LTwmKEZDRBjek2zRMSerkZdr
        dvTGjfgLfEfXZyA6drij6BZr53fhVLs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-632-a5MFB0JLNwudvemlP4NVpA-1; Tue, 21 Dec 2021 03:22:54 -0500
X-MC-Unique: a5MFB0JLNwudvemlP4NVpA-1
Received: by mail-wr1-f72.google.com with SMTP id k11-20020adfc70b000000b001a2333d9406so4414256wrg.3
        for <bpf@vger.kernel.org>; Tue, 21 Dec 2021 00:22:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YiEBtqVMI3AfI7hLxBSh0p15rHT1GTRnDFKf1L4c1i4=;
        b=5ZQlDEpUv7A5aaOlrOmDhiwbCcy4S1b9/qGacMEoCAvMMw5WSruZgF/UPyyzopxeyi
         +h+umetUvTdweH9OOOgWGcc6rTdg7pc6LsjJklK0SjNs+h02K2VOiUIf7HibM6alr8ep
         RsweP89KulMjVZKxnJgjZF4+3Cs07Np5+ihVilkoupSK1nXCaKxoNHGsKz1gR4gxnJiX
         Rzuywv18vohY1jwN6Lw9PfWgqLVqo8F8zWT07Yv6pU6NZPCuxM5iTPuMPRvmtp5OOX6K
         XKgGJi198Zz6yWW0JYEqWAAARM7OmlZufIO1Ida29fcRdoloQ7VOUj9T4PVnKTkKd2Ge
         UDZg==
X-Gm-Message-State: AOAM533/5n26CRYtAcmizWGUzZ8i9nBYy/ArrtNe+aUdZpBn4nAJoUt1
        25H6j2kaNTTqWJYAerMohca/20LO2c06W2wHJFv+Ahq/NaNDXOv+Kn/6tXCzm6glN2mefFAhP6K
        9up+tp7X6u2Sc
X-Received: by 2002:adf:82f6:: with SMTP id 109mr1644623wrc.169.1640074973301;
        Tue, 21 Dec 2021 00:22:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxbcJKz2+o3IsTftmDBx/rpcXNfL8aGJwHoPzjVkKyIcNRKnS0kalBcKsEwarmV0pveyA+B0A==
X-Received: by 2002:adf:82f6:: with SMTP id 109mr1644601wrc.169.1640074973049;
        Tue, 21 Dec 2021 00:22:53 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id t12sm3790754wrs.72.2021.12.21.00.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 00:22:52 -0800 (PST)
Date:   Tue, 21 Dec 2021 09:22:51 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Christy Lee <christylee@fb.com>
Cc:     andrii@kernel.org, acme@kernel.org, christyc.y.lee@gmail.com,
        bpf@vger.kernel.org, linux-perf-users@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH bpf-next 2/2] perf: stop using deprecated
 bpf__object_next() API
Message-ID: <YcGO271nDvfMeSlK@krava>
References: <20211216222108.110518-1-christylee@fb.com>
 <20211216222108.110518-3-christylee@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216222108.110518-3-christylee@fb.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 16, 2021 at 02:21:08PM -0800, Christy Lee wrote:
> bpf__object_next is deprecated, track bpf_objects directly in
> perf instead.
> 
> Signed-off-by: Christy Lee <christylee@fb.com>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  tools/perf/util/bpf-loader.c | 72 +++++++++++++++++++++++++++---------
>  tools/perf/util/bpf-loader.h |  1 +
>  2 files changed, 55 insertions(+), 18 deletions(-)
> 
> diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
> index 528aeb0ab79d..9e3988fd719a 100644
> --- a/tools/perf/util/bpf-loader.c
> +++ b/tools/perf/util/bpf-loader.c
> @@ -29,9 +29,6 @@
>  
>  #include <internal/xyarray.h>
>  
> -/* temporarily disable libbpf deprecation warnings */
> -#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
> -
>  static int libbpf_perf_print(enum libbpf_print_level level __attribute__((unused)),
>  			      const char *fmt, va_list args)
>  {
> @@ -49,6 +46,36 @@ struct bpf_prog_priv {
>  	int *type_mapping;
>  };
>  
> +struct bpf_perf_object {
> +	struct bpf_object *obj;
> +	struct list_head list;
> +};
> +
> +static LIST_HEAD(bpf_objects_list);

hum, so this duplicates libbpf's bpf_objects_list,
how do objects get on this list?

could you please put more comments in changelog
and share how you tested this?

thanks,
jirka

> +
> +struct bpf_perf_object *bpf_perf_object__next(struct bpf_perf_object *prev)
> +{
> +	struct bpf_perf_object *next;
> +
> +	if (!prev)
> +		next = list_first_entry(&bpf_objects_list,
> +					struct bpf_perf_object, list);
> +	else
> +		next = list_next_entry(prev, list);
> +
> +	/* Empty list is noticed here so don't need checking on entry. */
> +	if (&next->list == &bpf_objects_list)
> +		return NULL;
> +
> +	return next;
> +}
> +
> +#define bpf_perf_object__for_each(perf_obj, tmp, obj)                          \
> +	for ((perf_obj) = bpf_perf_object__next(NULL),                         \
> +	    (tmp) = bpf_perf_object__next(perf_obj), (obj) = NULL;             \
> +	     (perf_obj) != NULL; (perf_obj) = (tmp),                           \
> +	    (tmp) = bpf_perf_object__next(tmp), (obj) = (perf_obj)->obj)
> +
>  static bool libbpf_initialized;
>  
>  struct bpf_object *
> @@ -113,9 +140,10 @@ struct bpf_object *bpf__prepare_load(const char *filename, bool source)
>  
>  void bpf__clear(void)
>  {
> -	struct bpf_object *obj, *tmp;
> +	struct bpf_perf_object *perf_obj, *tmp;
> +	struct bpf_object *obj;
>  
> -	bpf_object__for_each_safe(obj, tmp) {
> +	bpf_perf_object__for_each(perf_obj, tmp, obj) {
>  		bpf__unprobe(obj);
>  		bpf_object__close(obj);
>  	}
> @@ -621,8 +649,12 @@ static int hook_load_preprocessor(struct bpf_program *prog)
>  	if (err)
>  		return err;
>  
> +/* temporarily disable libbpf deprecation warnings */
> +#pragma GCC diagnostic push
> +#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
>  	err = bpf_program__set_prep(prog, priv->nr_types,
>  				    preproc_gen_prologue);
> +#pragma GCC diagnostic pop
>  	return err;
>  }
>  
> @@ -776,7 +808,11 @@ int bpf__foreach_event(struct bpf_object *obj,
>  			if (priv->need_prologue) {
>  				int type = priv->type_mapping[i];
>  
> +/* temporarily disable libbpf deprecation warnings */
> +#pragma GCC diagnostic push
> +#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
>  				fd = bpf_program__nth_fd(prog, type);
> +#pragma GCC diagnostic pop
>  			} else {
>  				fd = bpf_program__fd(prog);
>  			}
> @@ -1498,10 +1534,11 @@ apply_obj_config_object(struct bpf_object *obj)
>  
>  int bpf__apply_obj_config(void)
>  {
> -	struct bpf_object *obj, *tmp;
> +	struct bpf_perf_object *perf_obj, *tmp;
> +	struct bpf_object *obj;
>  	int err;
>  
> -	bpf_object__for_each_safe(obj, tmp) {
> +	bpf_perf_object__for_each(perf_obj, tmp, obj) {
>  		err = apply_obj_config_object(obj);
>  		if (err)
>  			return err;
> @@ -1510,26 +1547,25 @@ int bpf__apply_obj_config(void)
>  	return 0;
>  }
>  
> -#define bpf__for_each_map(pos, obj, objtmp)	\
> -	bpf_object__for_each_safe(obj, objtmp)	\
> -		bpf_object__for_each_map(pos, obj)
> +#define bpf__perf_for_each_map(perf_obj, tmp, obj, map)                        \
> +	bpf_perf_object__for_each(perf_obj, tmp, obj)                          \
> +		bpf_object__for_each_map(map, obj)
>  
> -#define bpf__for_each_map_named(pos, obj, objtmp, name)	\
> -	bpf__for_each_map(pos, obj, objtmp) 		\
> -		if (bpf_map__name(pos) && 		\
> -			(strcmp(name, 			\
> -				bpf_map__name(pos)) == 0))
> +#define bpf__perf_for_each_map_named(perf_obj, tmp, obj, map, name)            \
> +	bpf__perf_for_each_map(perf_obj, tmp, obj, map)                        \
> +		if (bpf_map__name(map) && (strcmp(name, bpf_map__name(map)) == 0))
>  
>  struct evsel *bpf__setup_output_event(struct evlist *evlist, const char *name)
>  {
>  	struct bpf_map_priv *tmpl_priv = NULL;
> -	struct bpf_object *obj, *tmp;
> +	struct bpf_perf_object *perf_obj, *tmp;
> +	struct bpf_object *obj;
>  	struct evsel *evsel = NULL;
>  	struct bpf_map *map;
>  	int err;
>  	bool need_init = false;
>  
> -	bpf__for_each_map_named(map, obj, tmp, name) {
> +	bpf__perf_for_each_map_named(perf_obj, tmp, obj, map, name) {
>  		struct bpf_map_priv *priv = bpf_map__priv(map);
>  
>  		if (IS_ERR(priv))
> @@ -1565,7 +1601,7 @@ struct evsel *bpf__setup_output_event(struct evlist *evlist, const char *name)
>  		evsel = evlist__last(evlist);
>  	}
>  
> -	bpf__for_each_map_named(map, obj, tmp, name) {
> +	bpf__perf_for_each_map_named(perf_obj, tmp, obj, map, name) {
>  		struct bpf_map_priv *priv = bpf_map__priv(map);
>  
>  		if (IS_ERR(priv))
> diff --git a/tools/perf/util/bpf-loader.h b/tools/perf/util/bpf-loader.h
> index 5d1c725cea29..95262b7e936f 100644
> --- a/tools/perf/util/bpf-loader.h
> +++ b/tools/perf/util/bpf-loader.h
> @@ -53,6 +53,7 @@ typedef int (*bpf_prog_iter_callback_t)(const char *group, const char *event,
>  
>  #ifdef HAVE_LIBBPF_SUPPORT
>  struct bpf_object *bpf__prepare_load(const char *filename, bool source);
> +struct bpf_perf_object *bpf_perf_object__next(struct bpf_perf_object *prev);
>  int bpf__strerror_prepare_load(const char *filename, bool source,
>  			       int err, char *buf, size_t size);
>  
> -- 
> 2.30.2
> 

