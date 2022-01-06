Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 276A8486B0B
	for <lists+bpf@lfdr.de>; Thu,  6 Jan 2022 21:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243691AbiAFUY7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Jan 2022 15:24:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243662AbiAFUY4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Jan 2022 15:24:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A3BC061245;
        Thu,  6 Jan 2022 12:24:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9CECCB823A0;
        Thu,  6 Jan 2022 20:24:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 167FEC36AE5;
        Thu,  6 Jan 2022 20:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641500693;
        bh=AWlOb/n+g5p4uv/N859Up050X5Anv853St+tnU7I6ss=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RwXTIk+MdeVzi0BktZZPlwSG9PTv9v7ohtKsMYY0AuPjJ4wFP7ubxeMTiDWiuYglh
         Vih/vRbPM58Z9DObNZ3DgrmDI7ms41BYsGW+hOjXhudTsIqn5jkwllRSPhuLyJAWDJ
         ICojHH1vJLGyNrA/oZYGI2PCSNcxZ6prdYzyNc4qxAgfMFrKq4uEzt2NY2N8BVqWDN
         aK4cCYkWy2I4zNBZwDUPZ8drQ4XcLi379E2wu/JuttMuKn7OMLquR2+f95b0uDOjQz
         1UPezzK2KxnLBv4lD2A6r8f5xXMncAClq7PEOLGUG9XlUfkpZi+q5sw3I2vN9gLRpk
         gRO+kztSD5fQQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 57D0940B92; Thu,  6 Jan 2022 17:24:51 -0300 (-03)
Date:   Thu, 6 Jan 2022 17:24:51 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Christy Lee <christylee@fb.com>
Cc:     andrii@kernel.org, christyc.y.lee@gmail.com, bpf@vger.kernel.org,
        kernel-team@fb.com, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH bpf-next 3/5] perf: stop using bpf_map__def() API
Message-ID: <YddQE5ZIgkarkRNL@kernel.org>
References: <20220105230057.853163-1-christylee@fb.com>
 <20220105230057.853163-4-christylee@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220105230057.853163-4-christylee@fb.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Wed, Jan 05, 2022 at 03:00:55PM -0800, Christy Lee escreveu:
> libbpf bpf_map__def() API is being deprecated, replace bpftool's
> usage with the appropriate getters and setters.

This log message is for perf, right?

- Arnaldo
 
> Signed-off-by: Christy Lee <christylee@fb.com>
> ---
>  tools/perf/util/bpf-loader.c | 58 ++++++++++++++++--------------------
>  tools/perf/util/bpf_map.c    | 28 ++++++++---------
>  2 files changed, 39 insertions(+), 47 deletions(-)
> 
> diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
> index 528aeb0ab79d..ea5ccf0aed1b 100644
> --- a/tools/perf/util/bpf-loader.c
> +++ b/tools/perf/util/bpf-loader.c
> @@ -1002,24 +1002,22 @@ __bpf_map__config_value(struct bpf_map *map,
>  {
>  	struct bpf_map_op *op;
>  	const char *map_name = bpf_map__name(map);
> -	const struct bpf_map_def *def = bpf_map__def(map);
>  
> -	if (IS_ERR(def)) {
> -		pr_debug("Unable to get map definition from '%s'\n",
> -			 map_name);
> +	if (!map) {
> +		pr_debug("Map '%s' is invalid\n", map_name);
>  		return -BPF_LOADER_ERRNO__INTERNAL;
>  	}
>  
> -	if (def->type != BPF_MAP_TYPE_ARRAY) {
> +	if (bpf_map__type(map) != BPF_MAP_TYPE_ARRAY) {
>  		pr_debug("Map %s type is not BPF_MAP_TYPE_ARRAY\n",
>  			 map_name);
>  		return -BPF_LOADER_ERRNO__OBJCONF_MAP_TYPE;
>  	}
> -	if (def->key_size < sizeof(unsigned int)) {
> +	if (bpf_map__key_size(map) < sizeof(unsigned int)) {
>  		pr_debug("Map %s has incorrect key size\n", map_name);
>  		return -BPF_LOADER_ERRNO__OBJCONF_MAP_KEYSIZE;
>  	}
> -	switch (def->value_size) {
> +	switch (bpf_map__value_size(map)) {
>  	case 1:
>  	case 2:
>  	case 4:
> @@ -1061,7 +1059,6 @@ __bpf_map__config_event(struct bpf_map *map,
>  			struct parse_events_term *term,
>  			struct evlist *evlist)
>  {
> -	const struct bpf_map_def *def;
>  	struct bpf_map_op *op;
>  	const char *map_name = bpf_map__name(map);
>  	struct evsel *evsel = evlist__find_evsel_by_str(evlist, term->val.str);
> @@ -1072,18 +1069,16 @@ __bpf_map__config_event(struct bpf_map *map,
>  		return -BPF_LOADER_ERRNO__OBJCONF_MAP_NOEVT;
>  	}
>  
> -	def = bpf_map__def(map);
> -	if (IS_ERR(def)) {
> -		pr_debug("Unable to get map definition from '%s'\n",
> -			 map_name);
> -		return PTR_ERR(def);
> +	if (!map) {
> +		pr_debug("Map '%s' is invalid\n", map_name);
> +		return PTR_ERR(map);
>  	}
>  
>  	/*
>  	 * No need to check key_size and value_size:
>  	 * kernel has already checked them.
>  	 */
> -	if (def->type != BPF_MAP_TYPE_PERF_EVENT_ARRAY) {
> +	if (bpf_map__type(map) != BPF_MAP_TYPE_PERF_EVENT_ARRAY) {
>  		pr_debug("Map %s type is not BPF_MAP_TYPE_PERF_EVENT_ARRAY\n",
>  			 map_name);
>  		return -BPF_LOADER_ERRNO__OBJCONF_MAP_TYPE;
> @@ -1132,7 +1127,6 @@ config_map_indices_range_check(struct parse_events_term *term,
>  			       const char *map_name)
>  {
>  	struct parse_events_array *array = &term->array;
> -	const struct bpf_map_def *def;
>  	unsigned int i;
>  
>  	if (!array->nr_ranges)
> @@ -1143,10 +1137,8 @@ config_map_indices_range_check(struct parse_events_term *term,
>  		return -BPF_LOADER_ERRNO__INTERNAL;
>  	}
>  
> -	def = bpf_map__def(map);
> -	if (IS_ERR(def)) {
> -		pr_debug("ERROR: Unable to get map definition from '%s'\n",
> -			 map_name);
> +	if (!map) {
> +		pr_debug("Map '%s' is invalid\n", map_name);
>  		return -BPF_LOADER_ERRNO__INTERNAL;
>  	}
>  
> @@ -1155,7 +1147,7 @@ config_map_indices_range_check(struct parse_events_term *term,
>  		size_t length = array->ranges[i].length;
>  		unsigned int idx = start + length - 1;
>  
> -		if (idx >= def->max_entries) {
> +		if (idx >= bpf_map__max_entries(map)) {
>  			pr_debug("ERROR: index %d too large\n", idx);
>  			return -BPF_LOADER_ERRNO__OBJCONF_MAP_IDX2BIG;
>  		}
> @@ -1248,21 +1240,21 @@ int bpf__config_obj(struct bpf_object *obj,
>  }
>  
>  typedef int (*map_config_func_t)(const char *name, int map_fd,
> -				 const struct bpf_map_def *pdef,
> +				 const struct bpf_map *map,
>  				 struct bpf_map_op *op,
>  				 void *pkey, void *arg);
>  
>  static int
>  foreach_key_array_all(map_config_func_t func,
>  		      void *arg, const char *name,
> -		      int map_fd, const struct bpf_map_def *pdef,
> +		      int map_fd, const struct bpf_map *map,
>  		      struct bpf_map_op *op)
>  {
>  	unsigned int i;
>  	int err;
>  
> -	for (i = 0; i < pdef->max_entries; i++) {
> -		err = func(name, map_fd, pdef, op, &i, arg);
> +	for (i = 0; i < bpf_map__max_entries(map); i++) {
> +		err = func(name, map_fd, map, op, &i, arg);
>  		if (err) {
>  			pr_debug("ERROR: failed to insert value to %s[%u]\n",
>  				 name, i);
> @@ -1275,7 +1267,7 @@ foreach_key_array_all(map_config_func_t func,
>  static int
>  foreach_key_array_ranges(map_config_func_t func, void *arg,
>  			 const char *name, int map_fd,
> -			 const struct bpf_map_def *pdef,
> +			 const struct bpf_map *map,
>  			 struct bpf_map_op *op)
>  {
>  	unsigned int i, j;
> @@ -1288,7 +1280,7 @@ foreach_key_array_ranges(map_config_func_t func, void *arg,
>  		for (j = 0; j < length; j++) {
>  			unsigned int idx = start + j;
>  
> -			err = func(name, map_fd, pdef, op, &idx, arg);
> +			err = func(name, map_fd, map, op, &idx, arg);
>  			if (err) {
>  				pr_debug("ERROR: failed to insert value to %s[%u]\n",
>  					 name, idx);
> @@ -1304,7 +1296,7 @@ bpf_map_config_foreach_key(struct bpf_map *map,
>  			   map_config_func_t func,
>  			   void *arg)
>  {
> -	int err, map_fd;
> +	int err, map_fd, type;
>  	struct bpf_map_op *op;
>  	const struct bpf_map_def *def;
>  	const char *name = bpf_map__name(map);
> @@ -1330,19 +1322,19 @@ bpf_map_config_foreach_key(struct bpf_map *map,
>  		return map_fd;
>  	}
>  
> +	type = bpf_map__type(map);
>  	list_for_each_entry(op, &priv->ops_list, list) {
> -		switch (def->type) {
> +		switch (type) {
>  		case BPF_MAP_TYPE_ARRAY:
>  		case BPF_MAP_TYPE_PERF_EVENT_ARRAY:
>  			switch (op->key_type) {
>  			case BPF_MAP_KEY_ALL:
>  				err = foreach_key_array_all(func, arg, name,
> -							    map_fd, def, op);
> +						map_fd, map, op);
>  				break;
>  			case BPF_MAP_KEY_RANGES:
>  				err = foreach_key_array_ranges(func, arg, name,
> -							       map_fd, def,
> -							       op);
> +						map_fd, map, op);
>  				break;
>  			default:
>  				pr_debug("ERROR: keytype for map '%s' invalid\n",
> @@ -1451,7 +1443,7 @@ apply_config_evsel_for_key(const char *name, int map_fd, void *pkey,
>  
>  static int
>  apply_obj_config_map_for_key(const char *name, int map_fd,
> -			     const struct bpf_map_def *pdef,
> +			     const struct bpf_map *map,
>  			     struct bpf_map_op *op,
>  			     void *pkey, void *arg __maybe_unused)
>  {
> @@ -1460,7 +1452,7 @@ apply_obj_config_map_for_key(const char *name, int map_fd,
>  	switch (op->op_type) {
>  	case BPF_MAP_OP_SET_VALUE:
>  		err = apply_config_value_for_key(map_fd, pkey,
> -						 pdef->value_size,
> +						 bpf_map__value_size(map),
>  						 op->v.value);
>  		break;
>  	case BPF_MAP_OP_SET_EVSEL:
> diff --git a/tools/perf/util/bpf_map.c b/tools/perf/util/bpf_map.c
> index eb853ca67cf4..c863ae0c5cb5 100644
> --- a/tools/perf/util/bpf_map.c
> +++ b/tools/perf/util/bpf_map.c
> @@ -9,25 +9,25 @@
>  #include <stdlib.h>
>  #include <unistd.h>
>  
> -static bool bpf_map_def__is_per_cpu(const struct bpf_map_def *def)
> +static bool bpf_map__is_per_cpu(enum bpf_map_type type)
>  {
> -	return def->type == BPF_MAP_TYPE_PERCPU_HASH ||
> -	       def->type == BPF_MAP_TYPE_PERCPU_ARRAY ||
> -	       def->type == BPF_MAP_TYPE_LRU_PERCPU_HASH ||
> -	       def->type == BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE;
> +	return type == BPF_MAP_TYPE_PERCPU_HASH ||
> +	       type == BPF_MAP_TYPE_PERCPU_ARRAY ||
> +	       type == BPF_MAP_TYPE_LRU_PERCPU_HASH ||
> +	       type == BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE;
>  }
>  
> -static void *bpf_map_def__alloc_value(const struct bpf_map_def *def)
> +static void *bpf_map__alloc_value(const struct bpf_map *map)
>  {
> -	if (bpf_map_def__is_per_cpu(def))
> -		return malloc(round_up(def->value_size, 8) * sysconf(_SC_NPROCESSORS_CONF));
> +	if (bpf_map__is_per_cpu(bpf_map__type(map)))
> +		return malloc(round_up(bpf_map__value_size(map), 8) *
> +			      sysconf(_SC_NPROCESSORS_CONF));
>  
> -	return malloc(def->value_size);
> +	return malloc(bpf_map__value_size(map));
>  }
>  
>  int bpf_map__fprintf(struct bpf_map *map, FILE *fp)
>  {
> -	const struct bpf_map_def *def = bpf_map__def(map);
>  	void *prev_key = NULL, *key, *value;
>  	int fd = bpf_map__fd(map), err;
>  	int printed = 0;
> @@ -35,15 +35,15 @@ int bpf_map__fprintf(struct bpf_map *map, FILE *fp)
>  	if (fd < 0)
>  		return fd;
>  
> -	if (IS_ERR(def))
> -		return PTR_ERR(def);
> +	if (!map)
> +		return PTR_ERR(map);
>  
>  	err = -ENOMEM;
> -	key = malloc(def->key_size);
> +	key = malloc(bpf_map__key_size(map));
>  	if (key == NULL)
>  		goto out;
>  
> -	value = bpf_map_def__alloc_value(def);
> +	value = bpf_map__alloc_value(map);
>  	if (value == NULL)
>  		goto out_free_key;
>  
> -- 
> 2.30.2

-- 

- Arnaldo
