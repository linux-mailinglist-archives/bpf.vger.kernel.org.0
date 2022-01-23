Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9142949735D
	for <lists+bpf@lfdr.de>; Sun, 23 Jan 2022 18:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239089AbiAWRGP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 23 Jan 2022 12:06:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59400 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230015AbiAWRGP (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 23 Jan 2022 12:06:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642957574;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r/ok9f9jETsucgdW3Lf+0CFLf6etHVPhmpEoG/Uqmto=;
        b=L0/gfempT0JQwV7vZ9gxNp28Hw8bcRlmfi3Z8wUGQezxqlKg1yATLuHiHhXxH4CQL1sSes
        7qVJHpljqHi2E5zV5PBpWEMeRtlq34Ls9XRPTB9N1A7ujXqwudcsKG7WK+majZgwGaMJCq
        3TAxE6XEmUKqvw1IU23YLZF8XBaDuZ8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-30-1oz2csKfPbGbTv1ybRdVjQ-1; Sun, 23 Jan 2022 12:06:13 -0500
X-MC-Unique: 1oz2csKfPbGbTv1ybRdVjQ-1
Received: by mail-ed1-f70.google.com with SMTP id j10-20020a05640211ca00b003ff0e234fdfso11653422edw.0
        for <bpf@vger.kernel.org>; Sun, 23 Jan 2022 09:06:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=r/ok9f9jETsucgdW3Lf+0CFLf6etHVPhmpEoG/Uqmto=;
        b=fC8AbBni74PKrZDrHQwffqrMqCwWj9n71fJNrNb919ZuI9I2RgTuQiCsiLpirYPakt
         S/lYlDwRCVHDuTFdxe/2PqFrSPdESteAPktN0H9fbfdFyp9PGvAwgjB/u3gFCmU51YQ/
         /lpauC4xm2i1kPtCDny0gGw2wD50qgA88IB+OpQZN3pQmb5My50rEMmRCNY264mHqhQK
         NHug0GFya5gfbpot4jL4tUEPrfKEKmpvbmd0sK33UKHFE6Z7sXN8nl3MAL+fRrZP4Uc1
         SoIDKzQiNKhZqdBSYArVeyMA7LcqbuQk/BJoiSabjsuTFvYQMCJbobs+0w4AxOzZfkiR
         /dmQ==
X-Gm-Message-State: AOAM533NZ23LMddBrFYDuOh6HPQgotLWXf9f/xmz7B/J5Hjuh9V8uEEe
        LBYyAjQksmUylVCsN+mai/TNcWeMBVI4gAZfD/My16AgoKGxxHUDjKPJjVAitgQHK7AIUvpas1P
        ULR+WtRq00ZW2
X-Received: by 2002:a05:6402:1395:: with SMTP id b21mr12392016edv.299.1642957571771;
        Sun, 23 Jan 2022 09:06:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyBmipCGxZHfOlIW+Hrh0alIVK2sHqvlltom/jaSs+Xl7pcUpkmKtaq/NUc2xMIJyheAUMNRA==
X-Received: by 2002:a05:6402:1395:: with SMTP id b21mr12391992edv.299.1642957571484;
        Sun, 23 Jan 2022 09:06:11 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id da21sm4800441edb.65.2022.01.23.09.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 09:06:10 -0800 (PST)
Date:   Sun, 23 Jan 2022 18:06:08 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Christy Lee <christylee@fb.com>
Cc:     andrii@kernel.org, acme@kernel.org, christyc.y.lee@gmail.com,
        bpf@vger.kernel.org, linux-perf-users@vger.kernel.org,
        kernel-team@fb.com, wangnan0@huawei.com,
        bobo.shaobowang@huawei.com, yuehaibing@huawei.com
Subject: Re: [PATCH bpf-next v4 2/2] perf: stop using deprecated
 bpf_object__next() API
Message-ID: <Ye2LAEiXaBoj2n8Z@krava>
References: <20220119230636.1752684-1-christylee@fb.com>
 <20220119230636.1752684-3-christylee@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220119230636.1752684-3-christylee@fb.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 19, 2022 at 03:06:36PM -0800, Christy Lee wrote:

SNIP

> ---
>  tools/perf/util/bpf-loader.c | 72 +++++++++++++++++++++++++++---------
>  tools/perf/util/bpf-loader.h |  1 +
>  2 files changed, 55 insertions(+), 18 deletions(-)
> 
> diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
> index 4631cac3957f..b1822f8af2bb 100644
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

hum.. I still can't see any code adding/removing bpf_perf_object
objects to this list, and that's why the code is failing to remove
probes

because there are no objects to iterate on, so added probes stay
configured and screw following tests

you need something like below to add and del objects from
bpf_objects_list list

it also simplifies for_each macros to work just over perf_obj,
because I wasn't patient enough to make it work with the extra
bpf_object ;-) I don't mind if you fix that, but this way looks
simpler to me

tests are working for me with this fix, please feel free to
squash it into your change

thanks,
jirka


---
diff --git a/tools/perf/tests/bpf.c b/tools/perf/tests/bpf.c
index 57b9591f7cbb..d09d25707f1e 100644
--- a/tools/perf/tests/bpf.c
+++ b/tools/perf/tests/bpf.c
@@ -210,6 +210,11 @@ prepare_bpf(void *obj_buf, size_t obj_buf_sz, const char *name)
 		pr_debug("Compile BPF program failed.\n");
 		return NULL;
 	}
+
+	if (bpf_perf_object__add(obj)) {
+		bpf_object__close(obj);
+		return NULL;
+	}
 	return obj;
 }
 
diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
index 89e584ac267c..a7a8ad32c847 100644
--- a/tools/perf/util/bpf-loader.c
+++ b/tools/perf/util/bpf-loader.c
@@ -70,11 +70,11 @@ struct bpf_perf_object *bpf_perf_object__next(struct bpf_perf_object *prev)
 	return next;
 }
 
-#define bpf_perf_object__for_each(perf_obj, tmp, obj)                          \
-	for ((perf_obj) = bpf_perf_object__next(NULL),                         \
-	    (tmp) = bpf_perf_object__next(perf_obj), (obj) = NULL;             \
-	     (perf_obj) != NULL; (perf_obj) = (tmp),                           \
-	    (tmp) = bpf_perf_object__next(tmp), (obj) = (perf_obj)->obj)
+#define bpf_perf_object__for_each(perf_obj, tmp)         \
+	for ((perf_obj) = bpf_perf_object__next(NULL),   \
+	     (tmp) = bpf_perf_object__next(perf_obj);    \
+	     (perf_obj) != NULL; (perf_obj) = (tmp),     \
+	    (tmp) = bpf_perf_object__next(tmp) )
 
 static bool libbpf_initialized;
 
@@ -97,6 +97,24 @@ bpf__prepare_load_buffer(void *obj_buf, size_t obj_buf_sz, const char *name)
 	return obj;
 }
 
+int bpf_perf_object__add(struct bpf_object *obj)
+{
+	struct bpf_perf_object *perf_obj = zalloc(sizeof(*perf_obj));
+
+	if (perf_obj) {
+		perf_obj->obj = obj;
+		list_add_tail(&perf_obj->list, &bpf_objects_list);
+	}
+	return perf_obj ? 0 : -ENOMEM;
+}
+
+static void bpf_perf_object__close(struct bpf_perf_object *perf_obj)
+{
+	list_del(&perf_obj->list);
+	bpf_object__close(perf_obj->obj);
+	free(perf_obj);
+}
+
 struct bpf_object *bpf__prepare_load(const char *filename, bool source)
 {
 	struct bpf_object *obj;
@@ -135,17 +153,20 @@ struct bpf_object *bpf__prepare_load(const char *filename, bool source)
 		return obj;
 	}
 
+	if (bpf_perf_object__add(obj)) {
+		bpf_object__close(obj);
+		return ERR_PTR(-BPF_LOADER_ERRNO__COMPILE);
+	}
 	return obj;
 }
 
 void bpf__clear(void)
 {
 	struct bpf_perf_object *perf_obj, *tmp;
-	struct bpf_object *obj;
 
-	bpf_perf_object__for_each(perf_obj, tmp, obj) {
-		bpf__unprobe(obj);
-		bpf_object__close(obj);
+	bpf_perf_object__for_each(perf_obj, tmp) {
+		bpf__unprobe(perf_obj->obj);
+		bpf_perf_object__close(perf_obj);
 	}
 }
 
@@ -1538,11 +1559,10 @@ apply_obj_config_object(struct bpf_object *obj)
 int bpf__apply_obj_config(void)
 {
 	struct bpf_perf_object *perf_obj, *tmp;
-	struct bpf_object *obj;
 	int err;
 
-	bpf_perf_object__for_each(perf_obj, tmp, obj) {
-		err = apply_obj_config_object(obj);
+	bpf_perf_object__for_each(perf_obj, tmp) {
+		err = apply_obj_config_object(perf_obj->obj);
 		if (err)
 			return err;
 	}
@@ -1550,25 +1570,24 @@ int bpf__apply_obj_config(void)
 	return 0;
 }
 
-#define bpf__perf_for_each_map(perf_obj, tmp, obj, map)                        \
-	bpf_perf_object__for_each(perf_obj, tmp, obj)                          \
-		bpf_object__for_each_map(map, obj)
+#define bpf__perf_for_each_map(perf_obj, tmp, map)                   \
+	bpf_perf_object__for_each(perf_obj, tmp)                     \
+		bpf_object__for_each_map(map, perf_obj->obj)
 
-#define bpf__perf_for_each_map_named(perf_obj, tmp, obj, map, name)            \
-	bpf__perf_for_each_map(perf_obj, tmp, obj, map)                        \
+#define bpf__perf_for_each_map_named(perf_obj, tmp, map, name)            \
+	bpf__perf_for_each_map(perf_obj, tmp, map)                        \
 		if (bpf_map__name(map) && (strcmp(name, bpf_map__name(map)) == 0))
 
 struct evsel *bpf__setup_output_event(struct evlist *evlist, const char *name)
 {
 	struct bpf_map_priv *tmpl_priv = NULL;
 	struct bpf_perf_object *perf_obj, *tmp;
-	struct bpf_object *obj;
 	struct evsel *evsel = NULL;
 	struct bpf_map *map;
 	int err;
 	bool need_init = false;
 
-	bpf__perf_for_each_map_named(perf_obj, tmp, obj, map, name) {
+	bpf__perf_for_each_map_named(perf_obj, tmp, map, name) {
 		struct bpf_map_priv *priv = bpf_map__priv(map);
 
 		if (IS_ERR(priv))
@@ -1604,7 +1623,7 @@ struct evsel *bpf__setup_output_event(struct evlist *evlist, const char *name)
 		evsel = evlist__last(evlist);
 	}
 
-	bpf__perf_for_each_map_named(perf_obj, tmp, obj, map, name) {
+	bpf__perf_for_each_map_named(perf_obj, tmp, map, name) {
 		struct bpf_map_priv *priv = bpf_map__priv(map);
 
 		if (IS_ERR(priv))
diff --git a/tools/perf/util/bpf-loader.h b/tools/perf/util/bpf-loader.h
index 95262b7e936f..78c7d3662910 100644
--- a/tools/perf/util/bpf-loader.h
+++ b/tools/perf/util/bpf-loader.h
@@ -83,6 +83,8 @@ int bpf__strerror_config_obj(struct bpf_object *obj,
 int bpf__apply_obj_config(void);
 int bpf__strerror_apply_obj_config(int err, char *buf, size_t size);
 
+int bpf_perf_object__add(struct bpf_object *obj);
+
 int bpf__setup_stdout(struct evlist *evlist);
 struct evsel *bpf__setup_output_event(struct evlist *evlist, const char *name);
 int bpf__strerror_setup_output_event(struct evlist *evlist, int err, char *buf, size_t size);

