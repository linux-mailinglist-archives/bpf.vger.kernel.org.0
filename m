Return-Path: <bpf+bounces-68863-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF35B87001
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 23:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B77E73BD076
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 21:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219752D594D;
	Thu, 18 Sep 2025 21:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g9S2fLlJ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9942C2857F9;
	Thu, 18 Sep 2025 21:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758229453; cv=none; b=nIgsSn55bJwm4Gr/lMzjR6BwjtB23CDdQdJkC9qfzu/N7ZfqlH6DWo9EDy3BG3h75+xjiu4IIt1LIOFzJeJOTXgWdLG9MEkAr6CC/rZOF5J6e5X1FoYHc9VcmdxGACNVxCPVpQqAxMaBPJrw824FiwIjCJo5eMnnUpifgxpqQSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758229453; c=relaxed/simple;
	bh=2O9yPOWddE8LDiEsp2ElN8xZs725nB8hk6USPK3Nc5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cI7btOLUw8H3dvj2WSY1BddKebhb1Xai3lsrk3+sXYLpwPxfuGcnrjSuqiAjsh8GqPtbw/9q1SyV+M8aNKsauil2qqLyRARwxpo65JY33GBGlancNjw8Vl0H2KsFn3ZSdOre/sKFnOGjUFcm21/d/1mLvVZULgigz9m+sDPigP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g9S2fLlJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61C29C4CEE7;
	Thu, 18 Sep 2025 21:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758229453;
	bh=2O9yPOWddE8LDiEsp2ElN8xZs725nB8hk6USPK3Nc5w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=g9S2fLlJ6+Z6+lwDfyO0iCqQveCISvq/vhJFT5uEWI47c8EP4tfUXKzMOzeu6z5KH
	 TwqEgcMD05wH0mIrtIQyrW2FVz7F3l4KMkp1ofWIBVY7v7WrzIWnVGKb7HczZ8F2Np
	 wIvoJz/W1r7U9+C/FRD7Hj8Cw7lOyXVgo1ouTKDGhPaBDqWYo5Wpsrhp7GFU1sQxYz
	 sgV+fzxYdtbEB7bFI+dpy6kiroyaWd2itx72Np5u+hayuyg+gSA71bfnolWNe7jETb
	 74GD02i8Y+2ycIRuZCc2okNJ1k0EzyGImYO8fEwTUPI9bqsTjiLhimsFPFHMu8g101
	 dvamsW0be/FwA==
Message-ID: <1f98f82e-f15a-42d1-8975-e1cb6b66129f@kernel.org>
Date: Thu, 18 Sep 2025 22:04:09 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/12] bpftool: Add support for signing BPF programs
To: KP Singh <kpsingh@kernel.org>, bpf@vger.kernel.org,
 linux-security-module@vger.kernel.org
Cc: bboscaccy@linux.microsoft.com, paul@paul-moore.com, kys@microsoft.com,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
References: <20250914215141.15144-1-kpsingh@kernel.org>
 <20250914215141.15144-12-kpsingh@kernel.org>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20250914215141.15144-12-kpsingh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2025-09-14 23:51 UTC+0200 ~ KP Singh <kpsingh@kernel.org>
> Two modes of operation being added:
> 
> Add two modes of operation:
> 
> * For prog load, allow signing a program immediately before loading. This
>   is essential for command-line testing and administration.
> 
>       bpftool prog load -S -k <private_key> -i <identity_cert> fentry_test.bpf.o
> 
> * For gen skeleton, embed a pre-generated signature into the C skeleton
>   file. This supports the use of signed programs in compiled applications.
> 
>       bpftool gen skeleton -S -k <private_key> -i <identity_cert> fentry_test.bpf.o
> 
> Generation of the loader program and its metadata map is implemented in
> libbpf (bpf_obj__gen_loader). bpftool generates a skeleton that loads
> the program and automates the required steps: freezing the map, creating
> an exclusive map, loading, and running. Users can use standard libbpf
> APIs directly or integrate loader program generation into their own
> toolchains.
> 
> Signed-off-by: KP Singh <kpsingh@kernel.org>


Hi KP, thanks for this work! Apologies for the delay, I know I've missed
v3 - and I still have some small nits from bpftool's side.


> ---
>  .../bpf/bpftool/Documentation/bpftool-gen.rst |  16 +-
>  .../bpftool/Documentation/bpftool-prog.rst    |  18 +-
>  tools/bpf/bpftool/Makefile                    |   6 +-
>  tools/bpf/bpftool/cgroup.c                    |   4 +
>  tools/bpf/bpftool/gen.c                       |  66 +++++-
>  tools/bpf/bpftool/main.c                      |  26 ++-
>  tools/bpf/bpftool/main.h                      |  11 +
>  tools/bpf/bpftool/prog.c                      |  27 ++-
>  tools/bpf/bpftool/sign.c                      | 212 ++++++++++++++++++


We miss the bash completion update.


>  9 files changed, 373 insertions(+), 13 deletions(-)
>  create mode 100644 tools/bpf/bpftool/sign.c
> 
> diff --git a/tools/bpf/bpftool/Documentation/bpftool-gen.rst b/tools/bpf/bpftool/Documentation/bpftool-gen.rst
> index ca860fd97d8d..cef469d758ed 100644
> --- a/tools/bpf/bpftool/Documentation/bpftool-gen.rst
> +++ b/tools/bpf/bpftool/Documentation/bpftool-gen.rst
> @@ -16,7 +16,8 @@ SYNOPSIS
>  
>  **bpftool** [*OPTIONS*] **gen** *COMMAND*
>  
> -*OPTIONS* := { |COMMON_OPTIONS| | { **-L** | **--use-loader** } }
> +*OPTIONS* := { |COMMON_OPTIONS| [ { **-L** | **--use-loader** } ]
> +[ { { **-S** | **--sign** } **-k** <private_key.pem> **-i** <certificate.x509> } ] }}


Please don't remove the "|" separators. I understand we may use several
of these options on the command line, but if we remove them this should
be done consistently over all documentation pages.


>  
>  *COMMAND* := { **object** | **skeleton** | **help** }
>  
> @@ -186,6 +187,19 @@ OPTIONS
>      skeleton). A light skeleton contains a loader eBPF program. It does not use
>      the majority of the libbpf infrastructure, and does not need libelf.
>  
> +-S, --sign
> +    For skeletons, generate a signed skeleton. This option must be used with
> +    **-k** and **-i**. Using this flag implicitly enables **--use-loader**.
> +    See the "Signed Skeletons" section in the description of the
> +    **gen skeleton** command for more details.


404: Section not found!


> +
> +-k <private_key.pem>
> +    Path to the private key file in PEM format, required for signing.
> +
> +-i <certificate.x509>
> +    Path to the X.509 certificate file in PEM or DER format, required for
> +    signing.
> +
>  EXAMPLES
>  ========
>  **$ cat example1.bpf.c**
> diff --git a/tools/bpf/bpftool/Documentation/bpftool-prog.rst b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
> index f69fd92df8d8..55b812761df2 100644
> --- a/tools/bpf/bpftool/Documentation/bpftool-prog.rst
> +++ b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
> @@ -16,9 +16,9 @@ SYNOPSIS
>  
>  **bpftool** [*OPTIONS*] **prog** *COMMAND*
>  
> -*OPTIONS* := { |COMMON_OPTIONS| |
> -{ **-f** | **--bpffs** } | { **-m** | **--mapcompat** } | { **-n** | **--nomount** } |
> -{ **-L** | **--use-loader** } }
> +*OPTIONS* := { |COMMON_OPTIONS| [ { **-f** | **--bpffs** } ] [ { **-m** | **--mapcompat** } ]
> +[ { **-n** | **--nomount** } ] [ { **-L** | **--use-loader** } ]
> +[ { { **-S** | **--sign** } **-k** <private_key.pem> **-i** <certificate.x509> } ] }


Same for "|" separators


>  
>  *COMMANDS* :=
>  { **show** | **list** | **dump xlated** | **dump jited** | **pin** | **load** |
> @@ -248,6 +248,18 @@ OPTIONS
>      creating the maps, and loading the programs (see **bpftool prog tracelog**
>      as a way to dump those messages).
>  
> +-S, --sign
> +    Enable signing of the BPF program before loading. This option must be
> +    used with **-k** and **-i**. Using this flag implicitly enables
> +    **--use-loader**.
> +
> +-k <private_key.pem>
> +    Path to the private key file in PEM format, required when signing.
> +
> +-i <certificate.x509>
> +    Path to the X.509 certificate file in PEM or DER format, required when
> +    signing.
> +
>  EXAMPLES
>  ========
>  **# bpftool prog show**

> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> index 67a60114368f..694e61f1909e 100644
> --- a/tools/bpf/bpftool/gen.c
> +++ b/tools/bpf/bpftool/gen.c

> @@ -1930,7 +1988,7 @@ static int do_help(int argc, char **argv)
>  		"       %1$s %2$s help\n"
>  		"\n"
>  		"       " HELP_SPEC_OPTIONS " |\n"
> -		"                    {-L|--use-loader} }\n"
> +		"                    {-L|--use-loader} | [ {-S|--sign } {-k} <private_key.pem> {-i} <certificate.x509> ]}\n"


Nit: No need for curly braces when you just have a short option name,
for "-k" and "-i".


>  		"",
>  		bin_name, "gen");
>  
> diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
> index 0f1183b2ed0a..c78eb80b9c94 100644
> --- a/tools/bpf/bpftool/main.c
> +++ b/tools/bpf/bpftool/main.c
> @@ -33,6 +33,9 @@ bool relaxed_maps;
>  bool use_loader;
>  struct btf *base_btf;
>  struct hashmap *refs_table;
> +bool sign_progs;
> +const char *private_key_path;
> +const char *cert_path;
>  
>  static void __noreturn clean_and_exit(int i)
>  {
> @@ -448,6 +451,7 @@ int main(int argc, char **argv)
>  		{ "nomount",	no_argument,	NULL,	'n' },
>  		{ "debug",	no_argument,	NULL,	'd' },
>  		{ "use-loader",	no_argument,	NULL,	'L' },
> +		{ "sign",	no_argument,	NULL,	'S' },
>  		{ "base-btf",	required_argument, NULL, 'B' },
>  		{ 0 }
>  	};
> @@ -474,7 +478,7 @@ int main(int argc, char **argv)
>  	bin_name = "bpftool";
>  
>  	opterr = 0;
> -	while ((opt = getopt_long(argc, argv, "VhpjfLmndB:l",
> +	while ((opt = getopt_long(argc, argv, "VhpjfLmndSi:k:B:l",
>  				  options, NULL)) >= 0) {
>  		switch (opt) {
>  		case 'V':
> @@ -520,6 +524,16 @@ int main(int argc, char **argv)
>  		case 'L':
>  			use_loader = true;
>  			break;
> +		case 'S':
> +			sign_progs = true;
> +			use_loader = true;
> +			break;
> +		case 'k':
> +			private_key_path = optarg;
> +			break;
> +		case 'i':
> +			cert_path = optarg;
> +			break;
>  		default:
>  			p_err("unrecognized option '%s'", argv[optind - 1]);
>  			if (json_output)
> @@ -534,6 +548,16 @@ int main(int argc, char **argv)
>  	if (argc < 0)
>  		usage();
>  
> +	if (sign_progs && (private_key_path == NULL || cert_path == NULL)) {
> +		p_err("-i <identity_x509_cert> and -k <private> key must be supplied with -S for signing");
> +		return -EINVAL;
> +	}
> +
> +	if (!sign_progs && (private_key_path != NULL || cert_path != NULL)) {
> +		p_err("-i <identity_x509_cert> and -k <private> also need --sign to be used for sign programs");


Typo: s/to be used for sign/to sign/


> +		return -EINVAL;
> +	}
> +
>  	if (version_requested)
>  		ret = do_version(argc, argv);
>  	else

> diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> index cf18c3879680..f78a5135f104 100644
> --- a/tools/bpf/bpftool/prog.c
> +++ b/tools/bpf/bpftool/prog.c

> @@ -1953,6 +1956,24 @@ static int try_loader(struct gen_loader_opts *gen)
>  	opts.insns = gen->insns;
>  	opts.insns_sz = gen->insns_sz;
>  	fds_before = count_open_fds();
> +
> +	if (sign_progs) {
> +		opts.excl_prog_hash = prog_sha;
> +		opts.excl_prog_hash_sz = sizeof(prog_sha);
> +		opts.signature = sig_buf;
> +		opts.signature_sz = MAX_SIG_SIZE;
> +		opts.keyring_id = KEY_SPEC_SESSION_KEYRING;
> +
> +		err = bpftool_prog_sign(&opts);
> +		if (err < 0)
> +			return err;


On error here, I think you need the same as below: an error message, and
a "goto out" to free log_buf.


> +
> +		err = register_session_key(cert_path);
> +		if (err < 0) {
> +			p_err("failed to add session key");
> +			goto out;
> +		}
> +	}
>  	err = bpf_load_and_run(&opts);
>  	fd_delta = count_open_fds() - fds_before;
>  	if (err < 0 || verifier_logs) {
> @@ -1961,6 +1982,7 @@ static int try_loader(struct gen_loader_opts *gen)
>  			fprintf(stderr, "loader prog leaked %d FDs\n",
>  				fd_delta);
>  	}
> +out:
>  	free(log_buf);
>  	return err;
>  }
> @@ -1988,6 +2010,9 @@ static int do_loader(int argc, char **argv)
>  		goto err_close_obj;
>  	}
>  
> +	if (sign_progs)
> +		gen.gen_hash = true;
> +
>  	err = bpf_object__gen_loader(obj, &gen);
>  	if (err)
>  		goto err_close_obj;
> @@ -2562,7 +2587,7 @@ static int do_help(int argc, char **argv)
>  		"       METRIC := { cycles | instructions | l1d_loads | llc_misses | itlb_misses | dtlb_misses }\n"
>  		"       " HELP_SPEC_OPTIONS " |\n"
>  		"                    {-f|--bpffs} | {-m|--mapcompat} | {-n|--nomount} |\n"
> -		"                    {-L|--use-loader} }\n"
> +		"                    {-L|--use-loader} | [ {-S|--sign } {-k} <private_key.pem> {-i} <certificate.x509> ] \n"


"... -k <private_key.pem> -i <certificate.x509> ..."

The rest of the patch looks good.

Thanks,
Quentin

