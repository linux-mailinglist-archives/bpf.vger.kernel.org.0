Return-Path: <bpf+bounces-18870-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 751C4823104
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 17:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D4301C23AC3
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 16:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B52F1B29B;
	Wed,  3 Jan 2024 16:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SWVz1l5J"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CDF1B272;
	Wed,  3 Jan 2024 16:09:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C54CC433C7;
	Wed,  3 Jan 2024 16:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704298154;
	bh=lGmN0wrRuGDJdYZbuAeGfH/5xd4gu2xMwykDg7Rwxrk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SWVz1l5JvumJN02FTr6UwA84RzEmW8akZ2iLYZKED3D8c4u2jlTWUW9Bh5joRKJ5Q
	 JCA488Vv0ijYjtNJYzJ4JkToeL9hf4WX/FCkryWnj0n1m+BmYkM8liIE6yjjOqXNyi
	 y+aVE83X/Yqf1u6tReebJJIuXUHj7Ea080RLOJ/EyB17mgpRD0rCDuP/tXUagSPjPF
	 U2iMEJrS4zDALJurbI8zS1lnhAcWV6+/3lmjA0v9+Wpsgi6r9V8NB/K3XVC+N+euHd
	 NZ9cHTgmGpKx3izoa9DAFsvWGaV8LKBs4R6h1xM+BPxJ3lB+80Ea5z5v+ezHbiRsfJ
	 nrxHieVfT+Ksw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 43DCA403EF; Wed,  3 Jan 2024 13:09:11 -0300 (-03)
Date: Wed, 3 Jan 2024 13:09:11 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>, Song Liu <song@kernel.org>,
	Ming Wang <wangming01@loongson.cn>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH v1] perf env: Avoid recursively taking env->bpf_progs.lock
Message-ID: <ZZWGp9i-ZovCimfD@kernel.org>
References: <20231207014655.1252484-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207014655.1252484-1-irogers@google.com>
X-Url: http://acmel.wordpress.com

Em Wed, Dec 06, 2023 at 05:46:55PM -0800, Ian Rogers escreveu:
> Add variants of perf_env__insert_bpf_prog_info, perf_env__insert_btf
> and perf_env__find_btf prefixed with __ to indicate the
> env->bpf_progs.lock is assumed held. Call these variants when the lock
> is held to avoid recursively taking it and potentially having a thread
> deadlock with itself.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
> Previously this patch was part of a larger set:
> https://lore.kernel.org/lkml/20231127220902.1315692-51-irogers@google.com/
> ---
>  tools/perf/util/bpf-event.c |  8 +++---
>  tools/perf/util/bpf-event.h | 12 ++++-----
>  tools/perf/util/env.c       | 53 +++++++++++++++++++++++--------------
>  tools/perf/util/env.h       |  4 +++
>  tools/perf/util/header.c    |  8 +++---
>  5 files changed, 51 insertions(+), 34 deletions(-)
> 
> diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
> index 830711cae30d..3573e0b7ef3e 100644
> --- a/tools/perf/util/bpf-event.c
> +++ b/tools/perf/util/bpf-event.c
> @@ -545,9 +545,9 @@ int evlist__add_bpf_sb_event(struct evlist *evlist, struct perf_env *env)
>  	return evlist__add_sb_event(evlist, &attr, bpf_event__sb_cb, env);
>  }
>  
> -void bpf_event__print_bpf_prog_info(struct bpf_prog_info *info,
> -				    struct perf_env *env,
> -				    FILE *fp)
> +void __bpf_event__print_bpf_prog_info(struct bpf_prog_info *info,
> +				      struct perf_env *env,
> +				      FILE *fp)
>  {
>  	__u32 *prog_lens = (__u32 *)(uintptr_t)(info->jited_func_lens);
>  	__u64 *prog_addrs = (__u64 *)(uintptr_t)(info->jited_ksyms);
> @@ -563,7 +563,7 @@ void bpf_event__print_bpf_prog_info(struct bpf_prog_info *info,
>  	if (info->btf_id) {
>  		struct btf_node *node;
>  
> -		node = perf_env__find_btf(env, info->btf_id);
> +		node = __perf_env__find_btf(env, info->btf_id);
>  		if (node)
>  			btf = btf__new((__u8 *)(node->data),
>  				       node->data_size);
> diff --git a/tools/perf/util/bpf-event.h b/tools/perf/util/bpf-event.h
> index 1bcbd4fb6c66..e2f0420905f5 100644
> --- a/tools/perf/util/bpf-event.h
> +++ b/tools/perf/util/bpf-event.h
> @@ -33,9 +33,9 @@ struct btf_node {
>  int machine__process_bpf(struct machine *machine, union perf_event *event,
>  			 struct perf_sample *sample);
>  int evlist__add_bpf_sb_event(struct evlist *evlist, struct perf_env *env);
> -void bpf_event__print_bpf_prog_info(struct bpf_prog_info *info,
> -				    struct perf_env *env,
> -				    FILE *fp);
> +void __bpf_event__print_bpf_prog_info(struct bpf_prog_info *info,
> +				      struct perf_env *env,
> +				      FILE *fp);
>  #else
>  static inline int machine__process_bpf(struct machine *machine __maybe_unused,
>  				       union perf_event *event __maybe_unused,
> @@ -50,9 +50,9 @@ static inline int evlist__add_bpf_sb_event(struct evlist *evlist __maybe_unused,
>  	return 0;
>  }
>  
> -static inline void bpf_event__print_bpf_prog_info(struct bpf_prog_info *info __maybe_unused,
> -						  struct perf_env *env __maybe_unused,
> -						  FILE *fp __maybe_unused)
> +static inline void __bpf_event__print_bpf_prog_info(struct bpf_prog_info *info __maybe_unused,
> +						    struct perf_env *env __maybe_unused,
> +						    FILE *fp __maybe_unused)
>  {
>  
>  }
> diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
> index c68b7a004f29..cfdacbf29456 100644
> --- a/tools/perf/util/env.c
> +++ b/tools/perf/util/env.c
> @@ -22,15 +22,20 @@ struct perf_env perf_env;
>  #include "bpf-utils.h"
>  #include <bpf/libbpf.h>
>  
> -void perf_env__insert_bpf_prog_info(struct perf_env *env,
> -				    struct bpf_prog_info_node *info_node)
> +void perf_env__insert_bpf_prog_info(struct perf_env *env, struct bpf_prog_info_node *info_node)
> +{
> +	down_write(&env->bpf_progs.lock);
> +	__perf_env__insert_bpf_prog_info(env, info_node);
> +	up_write(&env->bpf_progs.lock);
> +}

Minor nit/modification:

diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index cfdacbf294566c33..a459374d0a1a1dc8 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -22,7 +22,8 @@ struct perf_env perf_env;
 #include "bpf-utils.h"
 #include <bpf/libbpf.h>
 
-void perf_env__insert_bpf_prog_info(struct perf_env *env, struct bpf_prog_info_node *info_node)
+void perf_env__insert_bpf_prog_info(struct perf_env *env,
+				    struct bpf_prog_info_node *info_node)
 {
 	down_write(&env->bpf_progs.lock);
 	__perf_env__insert_bpf_prog_info(env, info_node);

Just to reduce patch size a bit, just like happened with
perf_env__insert_btf() further down, where its body was changed  to call
the __ variant but the non __ function got just the body modified.

- Arnaldo

> +void __perf_env__insert_bpf_prog_info(struct perf_env *env, struct bpf_prog_info_node *info_node)
>  {
>  	__u32 prog_id = info_node->info_linear->info.id;
>  	struct bpf_prog_info_node *node;
>  	struct rb_node *parent = NULL;
>  	struct rb_node **p;
>  
> -	down_write(&env->bpf_progs.lock);
>  	p = &env->bpf_progs.infos.rb_node;
>  
>  	while (*p != NULL) {
> @@ -42,15 +47,13 @@ void perf_env__insert_bpf_prog_info(struct perf_env *env,
>  			p = &(*p)->rb_right;
>  		} else {
>  			pr_debug("duplicated bpf prog info %u\n", prog_id);
> -			goto out;
> +			return;
>  		}
>  	}
>  
>  	rb_link_node(&info_node->rb_node, parent, p);
>  	rb_insert_color(&info_node->rb_node, &env->bpf_progs.infos);
>  	env->bpf_progs.infos_cnt++;
> -out:
> -	up_write(&env->bpf_progs.lock);
>  }
>  
>  struct bpf_prog_info_node *perf_env__find_bpf_prog_info(struct perf_env *env,
> @@ -79,14 +82,22 @@ struct bpf_prog_info_node *perf_env__find_bpf_prog_info(struct perf_env *env,
>  }
>  
>  bool perf_env__insert_btf(struct perf_env *env, struct btf_node *btf_node)
> +{
> +	bool ret;
> +
> +	down_write(&env->bpf_progs.lock);
> +	ret = __perf_env__insert_btf(env, btf_node);
> +	up_write(&env->bpf_progs.lock);
> +	return ret;
> +}
> +
> +bool __perf_env__insert_btf(struct perf_env *env, struct btf_node *btf_node)
>  {
>  	struct rb_node *parent = NULL;
>  	__u32 btf_id = btf_node->id;
>  	struct btf_node *node;
>  	struct rb_node **p;
> -	bool ret = true;
>  
> -	down_write(&env->bpf_progs.lock);
>  	p = &env->bpf_progs.btfs.rb_node;
>  
>  	while (*p != NULL) {
> @@ -98,25 +109,31 @@ bool perf_env__insert_btf(struct perf_env *env, struct btf_node *btf_node)
>  			p = &(*p)->rb_right;
>  		} else {
>  			pr_debug("duplicated btf %u\n", btf_id);
> -			ret = false;
> -			goto out;
> +			return false;
>  		}
>  	}
>  
>  	rb_link_node(&btf_node->rb_node, parent, p);
>  	rb_insert_color(&btf_node->rb_node, &env->bpf_progs.btfs);
>  	env->bpf_progs.btfs_cnt++;
> -out:
> -	up_write(&env->bpf_progs.lock);
> -	return ret;
> +	return true;
>  }
>  
>  struct btf_node *perf_env__find_btf(struct perf_env *env, __u32 btf_id)
> +{
> +	struct btf_node *res;
> +
> +	down_read(&env->bpf_progs.lock);
> +	res = __perf_env__find_btf(env, btf_id);
> +	up_read(&env->bpf_progs.lock);
> +	return res;
> +}
> +
> +struct btf_node *__perf_env__find_btf(struct perf_env *env, __u32 btf_id)
>  {
>  	struct btf_node *node = NULL;
>  	struct rb_node *n;
>  
> -	down_read(&env->bpf_progs.lock);
>  	n = env->bpf_progs.btfs.rb_node;
>  
>  	while (n) {
> @@ -126,13 +143,9 @@ struct btf_node *perf_env__find_btf(struct perf_env *env, __u32 btf_id)
>  		else if (btf_id > node->id)
>  			n = n->rb_right;
>  		else
> -			goto out;
> +			return node;
>  	}
> -	node = NULL;
> -
> -out:
> -	up_read(&env->bpf_progs.lock);
> -	return node;
> +	return NULL;
>  }
>  
>  /* purge data in bpf_progs.infos tree */
> diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
> index bf7e3c4c211f..7c527e65c186 100644
> --- a/tools/perf/util/env.h
> +++ b/tools/perf/util/env.h
> @@ -175,12 +175,16 @@ const char *perf_env__raw_arch(struct perf_env *env);
>  int perf_env__nr_cpus_avail(struct perf_env *env);
>  
>  void perf_env__init(struct perf_env *env);
> +void __perf_env__insert_bpf_prog_info(struct perf_env *env,
> +				      struct bpf_prog_info_node *info_node);
>  void perf_env__insert_bpf_prog_info(struct perf_env *env,
>  				    struct bpf_prog_info_node *info_node);
>  struct bpf_prog_info_node *perf_env__find_bpf_prog_info(struct perf_env *env,
>  							__u32 prog_id);
>  bool perf_env__insert_btf(struct perf_env *env, struct btf_node *btf_node);
> +bool __perf_env__insert_btf(struct perf_env *env, struct btf_node *btf_node);
>  struct btf_node *perf_env__find_btf(struct perf_env *env, __u32 btf_id);
> +struct btf_node *__perf_env__find_btf(struct perf_env *env, __u32 btf_id);
>  
>  int perf_env__numa_node(struct perf_env *env, struct perf_cpu cpu);
>  char *perf_env__find_pmu_cap(struct perf_env *env, const char *pmu_name,
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index 08cc2febabde..02bf9d8b5f74 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -1849,8 +1849,8 @@ static void print_bpf_prog_info(struct feat_fd *ff, FILE *fp)
>  		node = rb_entry(next, struct bpf_prog_info_node, rb_node);
>  		next = rb_next(&node->rb_node);
>  
> -		bpf_event__print_bpf_prog_info(&node->info_linear->info,
> -					       env, fp);
> +		__bpf_event__print_bpf_prog_info(&node->info_linear->info,
> +						 env, fp);
>  	}
>  
>  	up_read(&env->bpf_progs.lock);
> @@ -3188,7 +3188,7 @@ static int process_bpf_prog_info(struct feat_fd *ff, void *data __maybe_unused)
>  		/* after reading from file, translate offset to address */
>  		bpil_offs_to_addr(info_linear);
>  		info_node->info_linear = info_linear;
> -		perf_env__insert_bpf_prog_info(env, info_node);
> +		__perf_env__insert_bpf_prog_info(env, info_node);
>  	}
>  
>  	up_write(&env->bpf_progs.lock);
> @@ -3235,7 +3235,7 @@ static int process_bpf_btf(struct feat_fd *ff, void *data __maybe_unused)
>  		if (__do_read(ff, node->data, data_size))
>  			goto out;
>  
> -		perf_env__insert_btf(env, node);
> +		__perf_env__insert_btf(env, node);
>  		node = NULL;
>  	}
>  
> -- 
> 2.43.0.rc2.451.g8631bc7472-goog
> 

-- 

- Arnaldo

