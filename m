Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57E3D288D5D
	for <lists+bpf@lfdr.de>; Fri,  9 Oct 2020 17:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389366AbgJIPxk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Oct 2020 11:53:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:50288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388745AbgJIPxk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Oct 2020 11:53:40 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B71272225D;
        Fri,  9 Oct 2020 15:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602258819;
        bh=yJDNEVa4frgGIhL+keLgAofYw/AcMyWMgHatE53kFZU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=toajAKNPygv24uPVJ7tkmF4SXp4QxUOGWuJSXSnHsP4taoT+XlWb+aGprpwRpYMOt
         GYu1SO8b2s9lu8tME7k41c+nfR8qiSR6zV33MHQ/hE0ZpJXUwKt1w5MQBGoce0e8u/
         RBI4R9sdSusciqXOXLB/jiZqaglCoh7Cuj+XRPmw=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9C3C5403AC; Fri,  9 Oct 2020 12:53:36 -0300 (-03)
Date:   Fri, 9 Oct 2020 12:53:36 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Hao Luo <haoluo@google.com>, Andrii Nakryiko <andrii@kernel.org>
Cc:     dwarves@vger.kernel.org, bpf@vger.kernel.org, kernel-team@fb.com,
        ast@kernel.org, Andrii Nakryiko <andriin@fb.com>,
        Oleg Rombakh <olegrom@google.com>
Subject: Re: [PATCH v2 dwarves 5/8] btf_encoder: revamp how per-CPU variables
 are encoded
Message-ID: <20201009155336.GC322246@kernel.org>
References: <20201008234000.740660-1-andrii@kernel.org>
 <20201008234000.740660-6-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201008234000.740660-6-andrii@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Thu, Oct 08, 2020 at 04:39:57PM -0700, Andrii Nakryiko escreveu:
> From: Andrii Nakryiko <andriin@fb.com>
> 
> Right now to encode per-CPU variables in BTF, pahole iterates complete vmlinux
> symbol table for each CU. There are 2500 CUs for a typical kernel image.
> Overall, to encode 287 per-CPU variables pahole spends more than 10% of its CPU
> budget, this is incredibly wasteful.

You forgot to add Hao to the Cc list, Hao, can you take a look? I'm
tentatively applying it to my local branch, but would like to hear from
you since you wrote this code.

- Arnaldo

> 
> This patch revamps how this is done. Now it pre-processes symbol table once
> before any of per-CU processing starts. It remembers each per-CPU variable
> symbol, including its address, size, and name. Then during processing each CU,
> binary search is used to correlate DWARF variable with per-CPU symbols and
> figure out if variable belongs to per-CPU data section. If the match is found,
> BTF_KIND_VAR is emitted and var_secinfo is recorded, just like before. At the
> very end, after all CUs are processed, BTF_KIND_DATASEC is emitted with sorted
> variables.
> 
> This change makes per-CPU variables generation overhead pretty negligible and
> returns back about 10% of CPU usage.
> 
> Performance counter stats for './pahole -J /home/andriin/linux-build/default/vmlinux':
> 
> BEFORE:
>       19.160149000 seconds user
>        1.304873000 seconds sys
> 
>          24,114.05 msec task-clock                #    0.999 CPUs utilized
>                 83      context-switches          #    0.003 K/sec
>                  0      cpu-migrations            #    0.000 K/sec
>            622,417      page-faults               #    0.026 M/sec
>     72,897,315,125      cycles                    #    3.023 GHz                      (25.02%)
>    127,807,316,959      instructions              #    1.75  insn per cycle           (25.01%)
>     29,087,179,117      branches                  # 1206.234 M/sec                    (25.01%)
>        464,105,921      branch-misses             #    1.60% of all branches          (25.01%)
>     30,252,119,368      L1-dcache-loads           # 1254.543 M/sec                    (25.01%)
>      1,156,336,207      L1-dcache-load-misses     #    3.82% of all L1-dcache hits    (25.05%)
>        343,373,503      LLC-loads                 #   14.240 M/sec                    (25.02%)
>         12,044,977      LLC-load-misses           #    3.51% of all LL-cache hits     (25.01%)
> 
>       24.136198321 seconds time elapsed
> 
>       22.729693000 seconds user
>        1.384859000 seconds sys
> 
> AFTER:
>       16.781455000 seconds user
>        1.343956000 seconds sys
> 
>          23,398.77 msec task-clock                #    1.000 CPUs utilized
>                 86      context-switches          #    0.004 K/sec
>                  0      cpu-migrations            #    0.000 K/sec
>            622,420      page-faults               #    0.027 M/sec
>     68,395,641,468      cycles                    #    2.923 GHz                      (25.05%)
>    114,241,327,034      instructions              #    1.67  insn per cycle           (25.01%)
>     26,330,711,718      branches                  # 1125.303 M/sec                    (25.01%)
>        465,926,869      branch-misses             #    1.77% of all branches          (25.00%)
>     24,662,984,772      L1-dcache-loads           # 1054.029 M/sec                    (25.00%)
>      1,054,052,064      L1-dcache-load-misses     #    4.27% of all L1-dcache hits    (25.00%)
>        340,970,622      LLC-loads                 #   14.572 M/sec                    (25.00%)
>         16,032,297      LLC-load-misses           #    4.70% of all LL-cache hits     (25.03%)
> 
>       23.402259654 seconds time elapsed
> 
>       21.916437000 seconds user
>        1.482826000 seconds sys
> 
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>
> ---
>  btf_encoder.c | 248 +++++++++++++++++++++++++++++---------------------
>  libbtf.c      |   6 +-
>  libbtf.h      |   1 +
>  3 files changed, 148 insertions(+), 107 deletions(-)
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 2e5df03e040f..2a6455be4c52 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -17,6 +17,7 @@
>  #include "btf_encoder.h"
>  
>  #include <ctype.h> /* for isalpha() and isalnum() */
> +#include <stdlib.h> /* for qsort() and bsearch() */
>  #include <inttypes.h>
>  
>  /*
> @@ -53,18 +54,18 @@ static bool btf_name_valid(const char *p)
>  	return !*p;
>  }
>  
> -static void dump_invalid_symbol(const char *msg, const char *sym, const char *cu,
> +static void dump_invalid_symbol(const char *msg, const char *sym,
>  				int verbose, bool force)
>  {
>  	if (force) {
>  		if (verbose)
> -			fprintf(stderr, "PAHOLE: Warning: %s, ignored (sym: '%s', cu: '%s').\n",
> -				msg, sym, cu);
> +			fprintf(stderr, "PAHOLE: Warning: %s, ignored (sym: '%s').\n",
> +				msg, sym);
>  		return;
>  	}
>  
> -	fprintf(stderr, "PAHOLE: Error: %s (sym: '%s', cu: '%s').\n", msg, sym, cu);
> -	fprintf(stderr, "PAHOLE: Error: Use '-j' or '--force' to ignore such symbols and force emit the btf.\n");
> +	fprintf(stderr, "PAHOLE: Error: %s (sym: '%s').\n", msg, sym);
> +	fprintf(stderr, "PAHOLE: Error: Use '--btf_encode_force' to ignore such symbols and force emit the btf.\n");
>  }
>  
>  extern struct debug_fmt_ops *dwarves__active_loader;
> @@ -202,6 +203,9 @@ int btf_encoder__encode()
>  {
>  	int err;
>  
> +	if (gobuffer__size(&btfe->percpu_secinfo) != 0)
> +		btf_elf__add_datasec_type(btfe, PERCPU_SECTION, &btfe->percpu_secinfo);
> +
>  	err = btf_elf__encode(btfe, 0);
>  	btf_elf__delete(btfe);
>  	btfe = NULL;
> @@ -209,24 +213,117 @@ int btf_encoder__encode()
>  	return err;
>  }
>  
> -#define HASHADDR__BITS 8
> -#define HASHADDR__SIZE (1UL << HASHADDR__BITS)
> -#define hashaddr__fn(key) hash_64(key, HASHADDR__BITS)
> +#define MAX_PERCPU_VAR_CNT 4096
> +
> +struct var_info {
> +	uint64_t addr;
> +	uint32_t sz;
> +	const char *name;
> +};
> +
> +static struct var_info percpu_vars[MAX_PERCPU_VAR_CNT];
> +static int percpu_var_cnt;
> +
> +static int percpu_var_cmp(const void *_a, const void *_b)
> +{
> +	const struct var_info *a = _a;
> +	const struct var_info *b = _b;
> +
> +	if (a->addr == b->addr)
> +		return 0;
> +	return a->addr < b->addr ? -1 : 1;
> +}
> +
> +static bool percpu_var_exists(uint64_t addr, uint32_t *sz, const char **name)
> +{
> +	const struct var_info *p;
> +	struct var_info key = { .addr = addr };
> +
> +	p = bsearch(&key, percpu_vars, percpu_var_cnt,
> +		    sizeof(percpu_vars[0]), percpu_var_cmp);
> +
> +	if (!p)
> +		return false;
> +
> +	*sz = p->sz;
> +	*name = p->name;
> +	return true;
> +}
>  
> -static struct variable *hashaddr__find_variable(const struct hlist_head hashtable[],
> -						const uint64_t addr)
> +static int find_all_percpu_vars(struct btf_elf *btfe)
>  {
> -	struct variable *variable;
> -	struct hlist_node *pos;
> -	uint16_t bucket = hashaddr__fn(addr);
> -	const struct hlist_head *head = &hashtable[bucket];
> -
> -	hlist_for_each_entry(variable, pos, head, tool_hnode) {
> -		if (variable->ip.addr == addr)
> -			return variable;
> +	uint32_t core_id;
> +	GElf_Sym sym;
> +
> +	/* cache variables' addresses, preparing for searching in symtab. */
> +	percpu_var_cnt = 0;
> +
> +	/* search within symtab for percpu variables */
> +	elf_symtab__for_each_symbol(btfe->symtab, core_id, sym) {
> +		const char *sym_name;
> +		uint64_t addr;
> +		uint32_t size;
> +
> +		/* compare a symbol's shndx to determine if it's a percpu variable */
> +		if (elf_sym__section(&sym) != btfe->percpu_shndx)
> +			continue;
> +		if (elf_sym__type(&sym) != STT_OBJECT)
> +			continue;
> +
> +		addr = elf_sym__value(&sym);
> +		/*
> +		 * Store only those symbols that have allocated space in the percpu section.
> +		 * This excludes the following three types of symbols:
> +		 *
> +		 *  1. __ADDRESSABLE(sym), which are forcely emitted as symbols.
> +		 *  2. __UNIQUE_ID(prefix), which are introduced to generate unique ids.
> +		 *  3. __exitcall(fn), functions which are labeled as exit calls.
> +		 *
> +		 * In addition, the variables defined using DEFINE_PERCPU_FIRST are
> +		 * also not included, which currently includes:
> +		 *
> +		 *  1. fixed_percpu_data
> +		 */
> +		if (!addr)
> +			continue;
> +
> +		sym_name = elf_sym__name(&sym, btfe->symtab);
> +		if (!btf_name_valid(sym_name)) {
> +			dump_invalid_symbol("Found symbol of invalid name when encoding btf",
> +					    sym_name, btf_elf__verbose, btf_elf__force);
> +			if (btf_elf__force)
> +				continue;
> +			return -1;
> +		}
> +		size = elf_sym__size(&sym);
> +		if (!size) {
> +			dump_invalid_symbol("Found symbol of zero size when encoding btf",
> +					    sym_name, btf_elf__verbose, btf_elf__force);
> +			if (btf_elf__force)
> +				continue;
> +			return -1;
> +		}
> +
> +		if (btf_elf__verbose)
> +			printf("Found per-CPU symbol '%s' at address 0x%lx\n", sym_name, addr);
> +
> +		if (percpu_var_cnt == MAX_PERCPU_VAR_CNT) {
> +			fprintf(stderr, "Reached the limit of per-CPU variables: %d\n",
> +				MAX_PERCPU_VAR_CNT);
> +			return -1;
> +		}
> +		percpu_vars[percpu_var_cnt].addr = addr;
> +		percpu_vars[percpu_var_cnt].sz = size;
> +		percpu_vars[percpu_var_cnt].name = sym_name;
> +		percpu_var_cnt++;
>  	}
>  
> -	return NULL;
> +	if (percpu_var_cnt)
> +		qsort(percpu_vars, percpu_var_cnt, sizeof(percpu_vars[0]), percpu_var_cmp);
> +
> +	if (btf_elf__verbose)
> +		printf("Found %d per-CPU variables!\n", percpu_var_cnt);
> +	return 0;
>  }
>  
>  int cu__encode_btf(struct cu *cu, int verbose, bool force,
> @@ -234,13 +331,10 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
>  {
>  	uint32_t type_id_off;
>  	uint32_t core_id;
> +	struct variable *var;
>  	struct function *fn;
>  	struct tag *pos;
>  	int err = 0;
> -	struct hlist_head hash_addr[HASHADDR__SIZE];
> -	struct variable *var;
> -	bool has_global_var = false;
> -	GElf_Sym sym;
>  
>  	if (btfe && strcmp(btfe->filename, cu->filename)) {
>  		err = btf_encoder__encode();
> @@ -257,6 +351,9 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
>  		if (!btfe)
>  			return -1;
>  
> +		if (!skip_encoding_vars && find_all_percpu_vars(btfe))
> +			goto out;
> +
>  		has_index_type = false;
>  		need_index_type = false;
>  		array_index_id = 0;
> @@ -278,6 +375,7 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
>  	}
>  
>  	btf_elf__verbose = verbose;
> +	btf_elf__force = force;
>  	type_id_off = btf__get_nr_types(btfe->btf);
>  
>  	cu__for_each_type(cu, core_id, pos) {
> @@ -325,12 +423,11 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
>  	if (verbose)
>  		printf("search cu '%s' for percpu global variables.\n", cu->name);
>  
> -	/* cache variables' addresses, preparing for searching in symtab. */
> -	for (core_id = 0; core_id < HASHADDR__SIZE; ++core_id)
> -		INIT_HLIST_HEAD(&hash_addr[core_id]);
> -
>  	cu__for_each_variable(cu, core_id, pos) {
> -		struct hlist_head *head;
> +		uint32_t size, type, linkage, offset;
> +		const char *name;
> +		uint64_t addr;
> +		int id;
>  
>  		var = tag__variable(pos);
>  		if (var->declaration && !var->spec)
> @@ -338,89 +435,37 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
>  		/* percpu variables are allocated in global space */
>  		if (variable__scope(var) != VSCOPE_GLOBAL && !var->spec)
>  			continue;
> -		has_global_var = true;
> -		head = &hash_addr[hashaddr__fn(var->ip.addr)];
> -		hlist_add_head(&var->tool_hnode, head);
> -	}
> -	if (!has_global_var) {
> -		if (verbose)
> -			printf("cu has no global variable defined, skip.\n");
> -		goto out;
> -	}
> -
> -	/* search within symtab for percpu variables */
> -	elf_symtab__for_each_symbol(btfe->symtab, core_id, sym) {
> -		uint32_t linkage, type, size, offset;
> -		int32_t btf_var_id, btf_var_secinfo_id;
> -		uint64_t addr;
> -		const char *sym_name;
> -
> -		/* compare a symbol's shndx to determine if it's a percpu variable */
> -		if (elf_sym__section(&sym) != btfe->percpu_shndx)
> -			continue;
> -		if (elf_sym__type(&sym) != STT_OBJECT)
> -			continue;
>  
> -		addr = elf_sym__value(&sym);
> -		/*
> -		 * Store only those symbols that have allocated space in the percpu section.
> -		 * This excludes the following three types of symbols:
> -		 *
> -		 *  1. __ADDRESSABLE(sym), which are forcely emitted as symbols.
> -		 *  2. __UNIQUE_ID(prefix), which are introduced to generate unique ids.
> -		 *  3. __exitcall(fn), functions which are labeled as exit calls.
> -		 *
> -		 * In addition, the variables defined using DEFINE_PERCPU_FIRST are
> -		 * also not included, which currently includes:
> -		 *
> -		 *  1. fixed_percpu_data
> -		 */
> -		if (!addr)
> -			continue;
> -		var = hashaddr__find_variable(hash_addr, addr);
> -		if (var == NULL)
> -			continue;
> +		/* addr has to be recorded before we follow spec */
> +		addr = var->ip.addr;
>  		if (var->spec)
>  			var = var->spec;
>  
> -		sym_name = elf_sym__name(&sym, btfe->symtab);
> -		if (!btf_name_valid(sym_name)) {
> -			dump_invalid_symbol("Found symbol of invalid name when encoding btf",
> -					    sym_name, cu->name, verbose, force);
> -			if (force)
> -				continue;
> -			err = -1;
> -			break;
> -		}
>  		if (var->ip.tag.type == 0) {
> -			dump_invalid_symbol("Found symbol of void type when encoding btf",
> -					    sym_name, cu->name, verbose, force);
> -			if (force)
> -				continue;
> -			err = -1;
> -			break;
> -		}
> -		type = type_id_off + var->ip.tag.type;
> -		size = elf_sym__size(&sym);
> -		if (!size) {
> -			dump_invalid_symbol("Found symbol of zero size when encoding btf",
> -					    sym_name, cu->name, verbose, force);
> +			fprintf(stderr, "error: found variable in CU '%s' that has void type\n",
> +				cu->name);
>  			if (force)
>  				continue;
>  			err = -1;
>  			break;
>  		}
>  
> -		if (verbose)
> -			printf("symbol '%s' of address 0x%lx encoded\n",
> -			       sym_name, addr);
> +		type = var->ip.tag.type + type_id_off;
> +		linkage = var->external ? BTF_VAR_GLOBAL_ALLOCATED : BTF_VAR_STATIC;
> +		if (!percpu_var_exists(addr, &size, &name))
> +			continue; /* not a per-CPU variable */
> +
> +		if (btf_elf__verbose) {
> +			printf("Variable '%s' from CU '%s' at address 0x%lx encoded\n",
> +			       name, cu->name, addr);
> +		}
>  
>  		/* add a BTF_KIND_VAR in btfe->types */
> -		linkage = var->external ? BTF_VAR_GLOBAL_ALLOCATED : BTF_VAR_STATIC;
> -		btf_var_id = btf_elf__add_var_type(btfe, type, sym_name, linkage);
> -		if (btf_var_id < 0) {
> +		id = btf_elf__add_var_type(btfe, type, name, linkage);
> +		if (id < 0) {
>  			err = -1;
> -			printf("error: failed to encode variable '%s'\n", sym_name);
> +			fprintf(stderr, "error: failed to encode variable '%s' at addr 0x%lx\n",
> +			        name, addr);
>  			break;
>  		}
>  
> @@ -428,13 +473,12 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
>  		 * add a BTF_VAR_SECINFO in btfe->percpu_secinfo, which will be added into
>  		 * btfe->types later when we add BTF_VAR_DATASEC.
>  		 */
> -		type = btf_var_id;
>  		offset = addr - btfe->percpu_base_addr;
> -		btf_var_secinfo_id = btf_elf__add_var_secinfo(&btfe->percpu_secinfo,
> -							      type, offset, size);
> -		if (btf_var_secinfo_id < 0) {
> +		id = btf_elf__add_var_secinfo(&btfe->percpu_secinfo, id, offset, size);
> +		if (id < 0) {
>  			err = -1;
> -			printf("error: failed to encode var secinfo '%s'\n", sym_name);
> +			fprintf(stderr, "error: failed to encode section info for variable '%s' at addr 0x%lx\n",
> +			        name, addr);
>  			break;
>  		}
>  	}
> diff --git a/libbtf.c b/libbtf.c
> index 0467f1f2a596..27aa3e5a986e 100644
> --- a/libbtf.c
> +++ b/libbtf.c
> @@ -28,6 +28,7 @@
>  #include "elf_symtab.h"
>  
>  uint8_t btf_elf__verbose;
> +uint8_t btf_elf__force;
>  
>  static int btf_var_secinfo_cmp(const void *a, const void *b)
>  {
> @@ -62,7 +63,6 @@ int btf_elf__load(struct btf_elf *btfe)
>  	return 0;
>  }
>  
> -
>  struct btf_elf *btf_elf__new(const char *filename, Elf *elf)
>  {
>  	struct btf_elf *btfe = zalloc(sizeof(*btfe));
> @@ -771,10 +771,6 @@ int btf_elf__encode(struct btf_elf *btfe, uint8_t flags)
>  {
>  	struct btf *btf = btfe->btf;
>  
> -	if (gobuffer__size(&btfe->percpu_secinfo) != 0)
> -		btf_elf__add_datasec_type(btfe, PERCPU_SECTION,
> -					  &btfe->percpu_secinfo);
> -
>  	/* Empty file, nothing to do, so... done! */
>  	if (btf__get_nr_types(btf) == 0)
>  		return 0;
> diff --git a/libbtf.h b/libbtf.h
> index 9b3d396da31f..887b5bc55c8e 100644
> --- a/libbtf.h
> +++ b/libbtf.h
> @@ -30,6 +30,7 @@ struct btf_elf {
>  };
>  
>  extern uint8_t btf_elf__verbose;
> +extern uint8_t btf_elf__force;
>  #define btf_elf__verbose_log(fmt, ...) { if (btf_elf__verbose) printf(fmt, __VA_ARGS__); }
>  
>  #define PERCPU_SECTION ".data..percpu"
> -- 
> 2.24.1
> 

-- 

- Arnaldo
