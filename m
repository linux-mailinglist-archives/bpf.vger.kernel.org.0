Return-Path: <bpf+bounces-9338-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6CDB794083
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 17:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C15B61C20A66
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 15:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E21107BF;
	Wed,  6 Sep 2023 15:38:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAD1107B1
	for <bpf@vger.kernel.org>; Wed,  6 Sep 2023 15:38:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B04FDC433C8;
	Wed,  6 Sep 2023 15:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694014700;
	bh=u7o/1IrYDxHmPHoEPJYlxEJhId0q8woRVu5tZnNykBE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fIxIB1OobEomc9sdmxE5eD249OA4R7w/M/lSkoDwIorxmdnsxlMM6IpTWP+9Hb719
	 Y9S82qrQq19IhBGtc4Ec/WLFo0DkkHMqqD9OLoIthiXEeERt/5ZothDJRsXsOtRsv7
	 vZ5H4zC8N28Lb0otCxAby9GLwkLmfrBPnGWOltFfI4qDp35QlZWgKG3zg1jxyhBrCk
	 mHbYL0IAJa3lRxsRcLwUasRB9F1gl0MEqdZ1XQ1p/YtINY9bxqqeipM4otFe+MZnWe
	 R1YcNKkq6lIkhsBHrMvCa7eZahBlxM1/VygJDUPEITIYJeH/NoHaOhVfrIQq4HoD9L
	 VduPnLx3hv4wQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 08EEF403F4; Wed,  6 Sep 2023 12:38:17 -0300 (-03)
Date: Wed, 6 Sep 2023 12:38:16 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>, bpf@vger.kernel.org
Subject: Re: [PATCH 1/5] perf tools: Add read_all_cgroups() and
 __cgroup_find()
Message-ID: <ZPic6Fegc7PGSvmp@kernel.org>
References: <20230830230126.260508-1-namhyung@kernel.org>
 <20230830230126.260508-2-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230830230126.260508-2-namhyung@kernel.org>
X-Url: http://acmel.wordpress.com

Em Wed, Aug 30, 2023 at 04:01:22PM -0700, Namhyung Kim escreveu:
> The read_all_cgroups() is to build a tree of cgroups in the system and
> users can look up a cgroup using __cgroup_find().

⬢[acme@toolbox perf-tools-next]$ alias m='make -k BUILD_BPF_SKEL=1 CORESIGHT=1 O=/tmp/build/perf-tools-next -C tools/perf install-bin && git status && perf test python'
⬢[acme@toolbox perf-tools-next]$ m
make: Entering directory '/var/home/acme/git/perf-tools-next/tools/perf'
  BUILD:   Doing 'make -j32' parallel build
Warning: Kernel ABI header differences:
  diff -u tools/include/uapi/linux/perf_event.h include/uapi/linux/perf_event.h
  diff -u tools/arch/x86/include/asm/cpufeatures.h arch/x86/include/asm/cpufeatures.h
  diff -u tools/arch/x86/include/asm/msr-index.h arch/x86/include/asm/msr-index.h
  diff -u tools/arch/arm64/include/uapi/asm/perf_regs.h arch/arm64/include/uapi/asm/perf_regs.h

  INSTALL libsubcmd_headers
  INSTALL libperf_headers
  INSTALL libapi_headers
  INSTALL libsymbol_headers
  INSTALL libbpf_headers
  CC      /tmp/build/perf-tools-next/builtin-lock.o
  CC      /tmp/build/perf-tools-next/util/bpf_lock_contention.o
builtin-lock.c: In function ‘__cmd_contention’:
builtin-lock.c:2162:9: error: too few arguments to function ‘lock_contention_finish’
 2162 |         lock_contention_finish();
      |         ^~~~~~~~~~~~~~~~~~~~~~
In file included from builtin-lock.c:14:
util/lock-contention.h:156:5: note: declared here
  156 | int lock_contention_finish(struct lock_contention *con);
      |     ^~~~~~~~~~~~~~~~~~~~~~
make[3]: *** [/var/home/acme/git/perf-tools-next/tools/build/Makefile.build:97: /tmp/build/perf-tools-next/builtin-lock.o] Error 1
make[3]: *** Waiting for unfinished jobs....
util/bpf_lock_contention.c: In function ‘lock_contention_get_name’:
util/bpf_lock_contention.c:231:34: error: ‘struct contention_key’ has no member named ‘lock_addr_or_cgroup’
  231 |                 u64 cgrp_id = key->lock_addr_or_cgroup;
      |                                  ^~
make[4]: *** [/var/home/acme/git/perf-tools-next/tools/build/Makefile.build:97: /tmp/build/perf-tools-next/util/bpf_lock_contention.o] Error 1
make[3]: *** [/var/home/acme/git/perf-tools-next/tools/build/Makefile.build:150: util] Error 2
make[2]: *** [Makefile.perf:662: /tmp/build/perf-tools-next/perf-in.o] Error 2
make[1]: *** [Makefile.perf:238: sub-make] Error 2
make: *** [Makefile:113: install-bin] Error 2
make: Leaving directory '/var/home/acme/git/perf-tools-next/tools/perf'
⬢[acme@toolbox perf-tools-next]$

Trying to figure this out.

- Arnaldo
 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/cgroup.c | 61 ++++++++++++++++++++++++++++++++++------
>  tools/perf/util/cgroup.h |  4 +++
>  2 files changed, 57 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
> index bfb13306d82c..2e969d1464f4 100644
> --- a/tools/perf/util/cgroup.c
> +++ b/tools/perf/util/cgroup.c
> @@ -48,28 +48,36 @@ static int open_cgroup(const char *name)
>  }
>  
>  #ifdef HAVE_FILE_HANDLE
> -int read_cgroup_id(struct cgroup *cgrp)
> +static u64 __read_cgroup_id(const char *path)
>  {
> -	char path[PATH_MAX + 1];
> -	char mnt[PATH_MAX + 1];
>  	struct {
>  		struct file_handle fh;
>  		uint64_t cgroup_id;
>  	} handle;
>  	int mount_id;
>  
> +	handle.fh.handle_bytes = sizeof(handle.cgroup_id);
> +	if (name_to_handle_at(AT_FDCWD, path, &handle.fh, &mount_id, 0) < 0)
> +		return -1ULL;
> +
> +	return handle.cgroup_id;
> +}
> +
> +int read_cgroup_id(struct cgroup *cgrp)
> +{
> +	char path[PATH_MAX + 1];
> +	char mnt[PATH_MAX + 1];
> +
>  	if (cgroupfs_find_mountpoint(mnt, PATH_MAX + 1, "perf_event"))
>  		return -1;
>  
>  	scnprintf(path, PATH_MAX, "%s/%s", mnt, cgrp->name);
>  
> -	handle.fh.handle_bytes = sizeof(handle.cgroup_id);
> -	if (name_to_handle_at(AT_FDCWD, path, &handle.fh, &mount_id, 0) < 0)
> -		return -1;
> -
> -	cgrp->id = handle.cgroup_id;
> +	cgrp->id = __read_cgroup_id(path);
>  	return 0;
>  }
> +#else
> +static inline u64 __read_cgroup_id(const char *path) { return -1ULL; }
>  #endif  /* HAVE_FILE_HANDLE */
>  
>  #ifndef CGROUP2_SUPER_MAGIC
> @@ -562,6 +570,11 @@ struct cgroup *cgroup__findnew(struct perf_env *env, uint64_t id,
>  	return cgrp;
>  }
>  
> +struct cgroup *__cgroup__find(struct rb_root *root, uint64_t id)
> +{
> +	return __cgroup__findnew(root, id, /*create=*/false, /*path=*/NULL);
> +}
> +
>  struct cgroup *cgroup__find(struct perf_env *env, uint64_t id)
>  {
>  	struct cgroup *cgrp;
> @@ -587,3 +600,35 @@ void perf_env__purge_cgroups(struct perf_env *env)
>  	}
>  	up_write(&env->cgroups.lock);
>  }
> +
> +void read_all_cgroups(struct rb_root *root)
> +{
> +	char mnt[PATH_MAX];
> +	struct cgroup_name *cn;
> +	int prefix_len;
> +
> +	if (cgroupfs_find_mountpoint(mnt, sizeof(mnt), "perf_event"))
> +		return;
> +
> +	/* cgroup_name will have a full path, skip the root directory */
> +	prefix_len = strlen(mnt);
> +
> +	/* collect all cgroups in the cgroup_list */
> +	if (nftw(mnt, add_cgroup_name, 20, 0) < 0)
> +		return;
> +
> +	list_for_each_entry(cn, &cgroup_list, list) {
> +		const char *name;
> +		u64 cgrp_id;
> +
> +		/* cgroup_name might have a full path, skip the prefix */
> +		name = cn->name + prefix_len;
> +		if (name[0] == '\0')
> +			name = "/";
> +
> +		cgrp_id = __read_cgroup_id(cn->name);
> +		__cgroup__findnew(root, cgrp_id, /*create=*/true, name);
> +	}
> +
> +	release_cgroup_list();
> +}
> diff --git a/tools/perf/util/cgroup.h b/tools/perf/util/cgroup.h
> index 12256b78608c..beb6fe1012ed 100644
> --- a/tools/perf/util/cgroup.h
> +++ b/tools/perf/util/cgroup.h
> @@ -37,6 +37,7 @@ int parse_cgroups(const struct option *opt, const char *str, int unset);
>  struct cgroup *cgroup__findnew(struct perf_env *env, uint64_t id,
>  			       const char *path);
>  struct cgroup *cgroup__find(struct perf_env *env, uint64_t id);
> +struct cgroup *__cgroup__find(struct rb_root *root, uint64_t id);
>  
>  void perf_env__purge_cgroups(struct perf_env *env);
>  
> @@ -49,6 +50,9 @@ static inline int read_cgroup_id(struct cgroup *cgrp __maybe_unused)
>  }
>  #endif  /* HAVE_FILE_HANDLE */
>  
> +/* read all cgroups in the system and save them in the rbtree */
> +void read_all_cgroups(struct rb_root *root);
> +
>  int cgroup_is_v2(const char *subsys);
>  
>  #endif /* __CGROUP_H__ */
> -- 
> 2.42.0.283.g2d96d420d3-goog
> 

-- 

- Arnaldo

