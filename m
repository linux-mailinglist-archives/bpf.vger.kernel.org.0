Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD5E2A7D64
	for <lists+bpf@lfdr.de>; Thu,  5 Nov 2020 12:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729016AbgKELms (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Nov 2020 06:42:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:56976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726665AbgKELmr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Nov 2020 06:42:47 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B6FC2071A;
        Thu,  5 Nov 2020 11:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604576565;
        bh=5VRTwjpmKBu9KB8BMN+QsZm3R0MwdEqWWrsMOe7819Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rENQCXuShVZPMGR73KAG6hXzuZLV4Ly5xRK8AaRdBKUMhIy04FKYk7q3bOF9TDWxP
         nM74Wu7vAJMuYGzWLNyXA54GWqDf8PjQJ59LyqCVB+9C4cXk7w577s5p9sOOTvjAUP
         XN3fYqTG4d5cNB+jPBSZ25lFwZ1+GjJcWfRriRQQ=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 04D96411D1; Thu,  5 Nov 2020 08:42:43 -0300 (-03)
Date:   Thu, 5 Nov 2020 08:42:42 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     dwarves@vger.kernel.org, bpf@vger.kernel.org, kernel-team@fb.com
Subject: Re: [RFC PATCH dwarves] btf: add support for split BTF loading and
 encoding
Message-ID: <20201105114242.GH262228@kernel.org>
References: <20201105043936.2555804-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105043936.2555804-1-andrii@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Wed, Nov 04, 2020 at 08:39:36PM -0800, Andrii Nakryiko escreveu:
> Add support for generating split BTF, in which there is a designated base
> BTF, containing a base set of types, and a split BTF, which extends main BTF
> with extra types, that can reference types and strings from the main BTF.
> 
> This is going to be used to generate compact BTFs for kernel modules, with
> vmlinux BTF being a main BTF, which all kernel modules are based off of.
> 
> These changes rely on patch set [0] to be present in libbpf submodule.
> 
>   [0] https://patchwork.kernel.org/project/netdevbpf/list/?series=377859&state=*
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
> 
> This is posted before libbpf changes landed to show end-to-end how kernel
> module BTFs are going to be integrated into the kernel. Once libbpf split BTF
> support lands, I'll sync it into Github repo and will post a proper v1.
> 
>  btf_encoder.c | 15 ++++++++-------
>  btf_loader.c  |  2 +-
>  libbtf.c      | 43 +++++++++++++++++++++++++++----------------
>  libbtf.h      |  4 +++-
>  pahole.c      | 23 +++++++++++++++++++++++
>  5 files changed, 62 insertions(+), 25 deletions(-)
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 4c92908beab2..d67e29b9cbee 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -12,6 +12,7 @@
>  #include "dwarves.h"
>  #include "libbtf.h"
>  #include "lib/bpf/include/uapi/linux/btf.h"
> +#include "lib/bpf/src/libbpf.h"
>  #include "hash.h"
>  #include "elf_symtab.h"
>  #include "btf_encoder.h"
> @@ -343,7 +344,7 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
>  	}
>  
>  	if (!btfe) {
> -		btfe = btf_elf__new(cu->filename, cu->elf);
> +		btfe = btf_elf__new(cu->filename, cu->elf, base_btf);
>  		if (!btfe)
>  			return -1;
>  
> @@ -358,22 +359,22 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
>  			printf("File %s:\n", btfe->filename);
>  	}
>  
> +	btf_elf__verbose = verbose;
> +	btf_elf__force = force;
> +	type_id_off = btf__get_nr_types(btfe->btf);
> +
>  	if (!has_index_type) {
>  		/* cu__find_base_type_by_name() takes "type_id_t *id" */
>  		type_id_t id;
>  		if (cu__find_base_type_by_name(cu, "int", &id)) {
>  			has_index_type = true;
> -			array_index_id = id;
> +			array_index_id = type_id_off + id;
>  		} else {
>  			has_index_type = false;
> -			array_index_id = cu->types_table.nr_entries;
> +			array_index_id = type_id_off + cu->types_table.nr_entries;
>  		}
>  	}
>  
> -	btf_elf__verbose = verbose;
> -	btf_elf__force = force;
> -	type_id_off = btf__get_nr_types(btfe->btf);
> -
>  	cu__for_each_type(cu, core_id, pos) {
>  		int32_t btf_type_id = tag__encode_btf(cu, pos, core_id, btfe, array_index_id, type_id_off);
>  
> diff --git a/btf_loader.c b/btf_loader.c
> index 6ea207ea65b4..ec286f413f36 100644
> --- a/btf_loader.c
> +++ b/btf_loader.c
> @@ -534,7 +534,7 @@ struct debug_fmt_ops btf_elf__ops;
>  int btf_elf__load_file(struct cus *cus, struct conf_load *conf, const char *filename)
>  {
>  	int err;
> -	struct btf_elf *btfe = btf_elf__new(filename, NULL);
> +	struct btf_elf *btfe = btf_elf__new(filename, NULL, base_btf);
>  
>  	if (btfe == NULL)
>  		return -1;
> diff --git a/libbtf.c b/libbtf.c
> index babf4fe8cd9e..3c52aa0d482b 100644
> --- a/libbtf.c
> +++ b/libbtf.c
> @@ -27,6 +27,7 @@
>  #include "dwarves.h"
>  #include "elf_symtab.h"
>  
> +struct btf *base_btf;
>  uint8_t btf_elf__verbose;
>  uint8_t btf_elf__force;
>  
> @@ -52,9 +53,9 @@ int btf_elf__load(struct btf_elf *btfe)
>  	/* free initial empty BTF */
>  	btf__free(btfe->btf);
>  	if (btfe->raw_btf)
> -		btfe->btf = btf__parse_raw(btfe->filename);
> +		btfe->btf = btf__parse_raw_split(btfe->filename, btfe->base_btf);
>  	else
> -		btfe->btf = btf__parse_elf(btfe->filename, NULL);
> +		btfe->btf = btf__parse_elf_split(btfe->filename, btfe->base_btf);
>  
>  	err = libbpf_get_error(btfe->btf);
>  	if (err)
> @@ -63,7 +64,7 @@ int btf_elf__load(struct btf_elf *btfe)
>  	return 0;
>  }
>  
> -struct btf_elf *btf_elf__new(const char *filename, Elf *elf)
> +struct btf_elf *btf_elf__new(const char *filename, Elf *elf, struct btf *base_btf)
>  {
>  	struct btf_elf *btfe = zalloc(sizeof(*btfe));
>  	GElf_Shdr shdr;
> @@ -77,7 +78,8 @@ struct btf_elf *btf_elf__new(const char *filename, Elf *elf)
>  	if (btfe->filename == NULL)
>  		goto errout;
>  
> -	btfe->btf = btf__new_empty();
> +	btfe->base_btf = base_btf;
> +	btfe->btf = btf__new_empty_split(base_btf);
>  	if (libbpf_get_error(btfe->btf)) {
>  		fprintf(stderr, "%s: failed to create empty BTF.\n", __func__);
>  		goto errout;
> @@ -679,11 +681,11 @@ static int btf_elf__write(const char *filename, struct btf *btf)
>  {
>  	GElf_Shdr shdr_mem, *shdr;
>  	GElf_Ehdr ehdr_mem, *ehdr;
> -	Elf_Data *btf_elf = NULL;
> +	Elf_Data *btf_data = NULL;

Can you please split this into two patches, one doing just the rename
of btf_elf to btf_data and then moving to btf__new_empty_split()? Eases
reviewing.

With this split btf code would it be possible to paralelize the encoding
of the modules BTF? I have to check the other patches and how this gets
used in the kernel build process... :-)

- Arnaldo

>  	Elf_Scn *scn = NULL;
>  	Elf *elf = NULL;
> -	const void *btf_data;
> -	uint32_t btf_size;
> +	const void *raw_btf_data;
> +	uint32_t raw_btf_size;
>  	int fd, err = -1;
>  	size_t strndx;
>  
> @@ -735,18 +737,18 @@ static int btf_elf__write(const char *filename, struct btf *btf)
>  			continue;
>  		char *secname = elf_strptr(elf, strndx, shdr->sh_name);
>  		if (strcmp(secname, ".BTF") == 0) {
> -			btf_elf = elf_getdata(scn, btf_elf);
> +			btf_data = elf_getdata(scn, btf_data);
>  			break;
>  		}
>  	}
>  
> -	btf_data = btf__get_raw_data(btf, &btf_size);
> +	raw_btf_data = btf__get_raw_data(btf, &raw_btf_size);
>  
> -	if (btf_elf) {
> +	if (btf_data) {
>  		/* Exisiting .BTF section found */
> -		btf_elf->d_buf = (void *)btf_data;
> -		btf_elf->d_size = btf_size;
> -		elf_flagdata(btf_elf, ELF_C_SET, ELF_F_DIRTY);
> +		btf_data->d_buf = (void *)raw_btf_data;
> +		btf_data->d_size = raw_btf_size;
> +		elf_flagdata(btf_data, ELF_C_SET, ELF_F_DIRTY);
>  
>  		if (elf_update(elf, ELF_C_NULL) >= 0 &&
>  		    elf_update(elf, ELF_C_WRITE) >= 0)
> @@ -770,12 +772,21 @@ static int btf_elf__write(const char *filename, struct btf *btf)
>  			goto out;
>  		}
>  
> +		if (write(fd, raw_btf_data, raw_btf_size) != raw_btf_size) {
> +			fprintf(stderr, "%s: write of %d bytes to '%s' failed: %d!\n",
> +				__func__, raw_btf_size, tmp_fn, errno);
> +			goto out;
> +		}
> +
>  		snprintf(cmd, sizeof(cmd), "%s --add-section .BTF=%s %s",
>  			 llvm_objcopy, tmp_fn, filename);
> +		if (system(cmd)) {
> +			fprintf(stderr, "%s: failed to add .BTF section to '%s': %d!\n",
> +				__func__, tmp_fn, errno);
> +			goto out;
> +		}
>  
> -		if (write(fd, btf_data, btf_size) == btf_size && !system(cmd))
> -			err = 0;
> -
> +		err = 0;
>  		unlink(tmp_fn);
>  	}
>  
> diff --git a/libbtf.h b/libbtf.h
> index 887b5bc55c8e..71f6cecbea93 100644
> --- a/libbtf.h
> +++ b/libbtf.h
> @@ -27,8 +27,10 @@ struct btf_elf {
>  	uint32_t	  percpu_shndx;
>  	uint64_t	  percpu_base_addr;
>  	struct btf	  *btf;
> +	struct btf	  *base_btf;
>  };
>  
> +extern struct btf *base_btf;
>  extern uint8_t btf_elf__verbose;
>  extern uint8_t btf_elf__force;
>  #define btf_elf__verbose_log(fmt, ...) { if (btf_elf__verbose) printf(fmt, __VA_ARGS__); }
> @@ -39,7 +41,7 @@ struct cu;
>  struct base_type;
>  struct ftype;
>  
> -struct btf_elf *btf_elf__new(const char *filename, Elf *elf);
> +struct btf_elf *btf_elf__new(const char *filename, Elf *elf, struct btf *base_btf);
>  void btf_elf__delete(struct btf_elf *btf);
>  
>  int32_t btf_elf__add_base_type(struct btf_elf *btf, const struct base_type *bt,
> diff --git a/pahole.c b/pahole.c
> index bd9b993777ee..d18092c1212c 100644
> --- a/pahole.c
> +++ b/pahole.c
> @@ -22,12 +22,15 @@
>  #include "dutil.h"
>  #include "ctf_encoder.h"
>  #include "btf_encoder.h"
> +#include "libbtf.h"
> +#include "lib/bpf/src/libbpf.h"
>  
>  static bool btf_encode;
>  static bool ctf_encode;
>  static bool first_obj_only;
>  static bool skip_encoding_btf_vars;
>  static bool btf_encode_force;
> +static const char *base_btf_file;
>  
>  static uint8_t class__include_anonymous;
>  static uint8_t class__include_nested_anonymous;
> @@ -820,6 +823,7 @@ ARGP_PROGRAM_VERSION_HOOK_DEF = dwarves_print_version;
>  #define ARGP_skip_encoding_btf_vars 317
>  #define ARGP_btf_encode_force	   318
>  #define ARGP_just_packed_structs   319
> +#define ARGP_btf_base		   320
>  
>  static const struct argp_option pahole__options[] = {
>  	{
> @@ -1093,6 +1097,12 @@ static const struct argp_option pahole__options[] = {
>  		.key  = ARGP_hex_fmt,
>  		.doc  = "Print offsets and sizes in hexadecimal",
>  	},
> +	{
> +		.name = "btf_base",
> +		.key  = ARGP_btf_base,
> +		.arg  = "SIZE",
> +		.doc  = "Path to the base BTF file",
> +	},
>  	{
>  		.name = "btf_encode",
>  		.key  = 'J',
> @@ -1234,6 +1244,9 @@ static error_t pahole__options_parser(int key, char *arg,
>  		skip_encoding_btf_vars = true;		break;
>  	case ARGP_btf_encode_force:
>  		btf_encode_force = true;		break;
> +	case ARGP_btf_base:
> +		base_btf_file = arg;
> +		break;
>  	default:
>  		return ARGP_ERR_UNKNOWN;
>  	}
> @@ -2682,6 +2695,15 @@ int main(int argc, char *argv[])
>  		goto out;
>  	}
>  
> +	if (base_btf_file) {
> +		base_btf = btf__parse(base_btf_file, NULL);
> +		if (libbpf_get_error(base_btf)) {
> +			fprintf(stderr, "Failed to parse base BTF '%s': %ld\n",
> +				base_btf_file, libbpf_get_error(base_btf));
> +			goto out;
> +		}
> +	}
> +
>  	struct cus *cus = cus__new();
>  	if (cus == NULL) {
>  		fputs("pahole: insufficient memory\n", stderr);
> @@ -2766,6 +2788,7 @@ out_cus_delete:
>  #ifdef DEBUG_CHECK_LEAKS
>  	cus__delete(cus);
>  	structures__delete();
> +	btf__free(base_btf);
>  #endif
>  out_dwarves_exit:
>  #ifdef DEBUG_CHECK_LEAKS
> -- 
> 2.24.1
> 

-- 

- Arnaldo
