Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 891AD2AF024
	for <lists+bpf@lfdr.de>; Wed, 11 Nov 2020 12:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgKKL4e (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Nov 2020 06:56:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:51964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726316AbgKKL4b (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Nov 2020 06:56:31 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B94E1206C0;
        Wed, 11 Nov 2020 11:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605095790;
        bh=xmm0DontKjJfDMkWQgae0dgM+uWV8v6hCdBGKAm2aTw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cUcgOl60++vSVx4iRwcnYvSZL0R9tcfwwaKqAo10PMqqcHKspQt2wPQT3hwhwj84X
         lCG7u7USorWiSvAvxs6WLNa3Rg4pXHGaOQhLPrCcTi3cIVEnaHqvty/9WLSDpY9w8U
         5gzezZIHtm1ut5Kz2Dhoot60KZ0jtFR9dGS9gSNo=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 35A4C411D1; Wed, 11 Nov 2020 08:56:27 -0300 (-03)
Date:   Wed, 11 Nov 2020 08:56:27 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     dwarves@vger.kernel.org, bpf@vger.kernel.org, kernel-team@fb.com,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH dwarves 4/4] btf: add support for split BTF loading and
 encoding
Message-ID: <20201111115627.GB355344@kernel.org>
References: <20201106052549.3782099-1-andrii@kernel.org>
 <20201106052549.3782099-5-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106052549.3782099-5-andrii@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Thu, Nov 05, 2020 at 09:25:49PM -0800, Andrii Nakryiko escreveu:
> Add support for generating split BTF, in which there is a designated base
> BTF, containing a base set of types, and a split BTF, which extends main BTF
> with extra types, that can reference types and strings from the main BTF.
 
> This is going to be used to generate compact BTFs for kernel modules, with
> vmlinux BTF being a main BTF, which all kernel modules are based off of.
 
> These changes rely on patch set [0] to be present in libbpf submodule.
 
>   [0] https://patchwork.kernel.org/project/netdevbpf/list/?series=377859&state=*

So, applied and added this:

diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
index 4b5e0a1bf5462b28..20ee91fc911d4b39 100644
--- a/man-pages/pahole.1
+++ b/man-pages/pahole.1
@@ -185,6 +185,10 @@ Do not encode VARs in BTF.
 .B \-\-btf_encode_force
 Ignore those symbols found invalid when encoding BTF.
 
+.TP
+.B \-\-btf_base
+Path to the base BTF file, for instance: vmlinux when encoding kernel module BTF information.
+
 .TP
 .B \-l, \-\-show_first_biggest_size_base_type_member
 Show first biggest size base_type member.

---------------

The entry for btf_encode/-J is missing, I'll add in a followup patch.

Also I had to fixup ARGP_btf_base to 321 as I added this, to simplify
the kernel scripts and Makefiles:

  $ pahole --numeric_version
  118
  $

Now to test this all by applying the kernel patches and the encoding
module BTF, looking at it, etc.

- Arnaldo
 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  btf_encoder.c |  3 ++-
>  btf_loader.c  |  2 +-
>  libbtf.c      | 10 ++++++----
>  libbtf.h      |  4 +++-
>  pahole.c      | 23 +++++++++++++++++++++++
>  5 files changed, 35 insertions(+), 7 deletions(-)
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index b3e47f172bb3..d67e29b9cbee 100644
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
> index b6ddd7599395..3c52aa0d482b 100644
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
