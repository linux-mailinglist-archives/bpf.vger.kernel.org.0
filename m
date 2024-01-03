Return-Path: <bpf+bounces-18857-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF80C822A41
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 10:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 747191C231A9
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 09:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD21182DA;
	Wed,  3 Jan 2024 09:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQ413z/4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAD6182B9;
	Wed,  3 Jan 2024 09:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-555f95cc2e4so3445887a12.3;
        Wed, 03 Jan 2024 01:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704273960; x=1704878760; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h8w1Q5f5g/GWHpE9GUXzfWWs0nx0LlPNNZuECXHO52A=;
        b=BQ413z/4ZVWzdJRBkREEyAt3sBTlQmNUD6Fid0mKDMe5RsHAqQcNV2riL+s720LFIO
         GLP/X7nssVUhBHrOLa1wVBnvkUPvb0m7lZAh6hHznz1XJIHgSK1QvK4CnaFRr3crEiDc
         08Dh+jTAaDrca34OxpJIKHh2+8ayTOpYL71haSgsUK/bf/zaMayj1InPFpVGc+R9TJBk
         5dwFjODaHOfVsWZLzGH/UFjIPPUIT1Nevf3Py/p0hB95fbq0xFHfPb8OzyqjjYGf4QlD
         CM9s+wGIBmmYRFETErb+qeSCeTr9SLqdekz+l0I/IVooKR8JCxADCLEq8NDqV1nSruCg
         8p0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704273960; x=1704878760;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h8w1Q5f5g/GWHpE9GUXzfWWs0nx0LlPNNZuECXHO52A=;
        b=H6iAAAhmQoaucYKVXt2CK3HvKddQaySytPy0iLfIZTMfZQFFla5/iAMXZZgXYBxgRv
         PtMeLMSV0vq++eps/6KB9x6v7AOMKhOSbsK9EsbK+YeBBTHII9f/cQTGP/8ZcpB0/kjT
         rZAXnTaUUqbUrtSX7FlbyBL6AnhmuohCok4wPxYUZYiucny1OcTOXRsU7+K+ALGoYv3U
         5azUFTAcGEk3L6DVVlyRZeY9p9xas+cgGIVfeHw5d505ioWrFsmm0teLlYE1l53RUvNi
         E3OF52xFkOVLwUS0MzVD8n5T+BtY7zy0LR5KXh4q9gTRRH3TU6ACouxK2655vFdTg2up
         o4YA==
X-Gm-Message-State: AOJu0YxMvD7zvPF14qOe7cGnzKvo8DYPii0IZXVEe9Tuaz1uGuzx3zSE
	UFHxyVi9NSgsTwaDDNGme18=
X-Google-Smtp-Source: AGHT+IEi4vBme5w7ooMnLQkVjHMZvgsKZSFJ9Vn4H2n0BNfxYWC501Umg+sHPRLC/y3Qre6a0+3Cug==
X-Received: by 2002:a17:906:5303:b0:a1d:932f:9098 with SMTP id h3-20020a170906530300b00a1d932f9098mr4214645ejo.97.1704273960001;
        Wed, 03 Jan 2024 01:26:00 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id ex1-20020a170907954100b00a26f22dca5asm8590760ejc.0.2024.01.03.01.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 01:25:59 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 3 Jan 2024 10:25:57 +0100
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>, Song Liu <song@kernel.org>,
	Ming Wang <wangming01@loongson.cn>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH v1] perf env: Avoid recursively taking env->bpf_progs.lock
Message-ID: <ZZUoJfGbPwLcFCnb@krava>
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

On Wed, Dec 06, 2023 at 05:46:55PM -0800, Ian Rogers wrote:
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

lgtm

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

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
> +
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

