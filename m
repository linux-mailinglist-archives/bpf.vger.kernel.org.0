Return-Path: <bpf+bounces-64073-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8BB3B0E0EF
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 17:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B00576C0E6A
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 15:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A2F279DDB;
	Tue, 22 Jul 2025 15:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NOFAGqXY"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F335D27990B;
	Tue, 22 Jul 2025 15:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753199502; cv=none; b=I1X0DjdBBIREiKE73itbrGs5YAga/p6RlE/igtH5qj2cHZeOB/q/ntBlsz0mTWeLW8T+WMEhHfWxZvmOvG9QR+a3IN4VzAO7o77HCNNk8EE12Fi3GJo+lkivPKbIau5J/1UXhmyQzaDlAukZN0v1Nhe8rQ0XfL+Ps6EEOpreF+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753199502; c=relaxed/simple;
	bh=bt8/tE3z2EzRv9/tmy5jzeSFjcDxC2Zmdcs3sq+D0D8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s8eEHppZjQZ+dvXmUhreAAtTWxmbfMJakO+1uuTAGYVm9GR4480iDCHs4I78FnZKTA7uaw7YBlEKLksArid4sOX5vjiA6U8ZRV62ZNBF7LTSVE6vuGvFaGgndsZOzh1rRzNOMN7L5OMx4eDQzx1OxbJVBco8csv5+MYknyriXu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NOFAGqXY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 105A7C4CEEB;
	Tue, 22 Jul 2025 15:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753199501;
	bh=bt8/tE3z2EzRv9/tmy5jzeSFjcDxC2Zmdcs3sq+D0D8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NOFAGqXYcfcb0fOor4DCeCE+qvzanWtrzuWfxPiEO8X9EZ9b0udTujZcWdilSVw0V
	 JcE49xS9pc3TrWXII6ShSgxSn7lzDZUcHqSI/fI3zT9uwz9OepD32pGTW+6e96xaRv
	 6d52b1u/PsIiztVOu0CQDqauyg+MsuSm+WHJH9wwMUVTPoed72C/N70WSN5OwvA43Y
	 19BBpM8G2aY7xu+8C9LymJo+JXFicMHFBFsTAB4hTrifF9/ntMCvfksSabtNcccQAh
	 OdBKQLU0JDQp2eofVlFHn+gMkj0tDjlEdlwih9Pxj1ymKd299C0HD4Eqq2pUc2g4U4
	 uLbfMoDgYqHMw==
Message-ID: <2b417a1a-8f0b-4bca-ad44-aa4195040ef1@kernel.org>
Date: Tue, 22 Jul 2025 16:51:38 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/13] bpftool: Add support for signing BPF programs
To: KP Singh <kpsingh@kernel.org>, bpf@vger.kernel.org,
 linux-security-module@vger.kernel.org
Cc: bboscaccy@linux.microsoft.com, paul@paul-moore.com, kys@microsoft.com,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
References: <20250721211958.1881379-1-kpsingh@kernel.org>
 <20250721211958.1881379-12-kpsingh@kernel.org>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20250721211958.1881379-12-kpsingh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2025-07-21 23:19 UTC+0200 ~ KP Singh <kpsingh@kernel.org>
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


Thanks KP! Some bpftool-related comments below. Looks good overall, I
mostly have minor comments.

One concern might be the license for the new file, GPL-2.0 in your
patch, whereas bpftool is dual-licensed. I hope this is simply an oversight?


> 
> Signed-off-by: KP Singh <kpsingh@kernel.org>
> ---
>  .../bpf/bpftool/Documentation/bpftool-gen.rst |  12 +
>  .../bpftool/Documentation/bpftool-prog.rst    |  12 +
>  tools/bpf/bpftool/Makefile                    |   6 +-
>  tools/bpf/bpftool/cgroup.c                    |   5 +-
>  tools/bpf/bpftool/gen.c                       |  58 ++++-
>  tools/bpf/bpftool/main.c                      |  21 +-
>  tools/bpf/bpftool/main.h                      |  11 +
>  tools/bpf/bpftool/prog.c                      |  25 +++
>  tools/bpf/bpftool/sign.c                      | 210 ++++++++++++++++++
>  9 files changed, 352 insertions(+), 8 deletions(-)
>  create mode 100644 tools/bpf/bpftool/sign.c
> 
> diff --git a/tools/bpf/bpftool/Documentation/bpftool-gen.rst b/tools/bpf/bpftool/Documentation/bpftool-gen.rst
> index ca860fd97d8d..2997313003b1 100644
> --- a/tools/bpf/bpftool/Documentation/bpftool-gen.rst
> +++ b/tools/bpf/bpftool/Documentation/bpftool-gen.rst
> @@ -185,6 +185,18 @@ OPTIONS
>      For skeletons, generate a "light" skeleton (also known as "loader"
>      skeleton). A light skeleton contains a loader eBPF program. It does not use
>      the majority of the libbpf infrastructure, and does not need libelf.


Blank line separator, please


> +-S, --sign
> +    For skeletons, generate a signed skeleton. This option must be used with
> +    **-k** and **-i**. Using this flag implicitly enables **--use-loader**.
> +    See the "Signed Skeletons" section in the description of the
> +    **gen skeleton** command for more details.
> +
> +-k <private_key.pem>
> +    Path to the private key file in PEM format, required for signing.
> +
> +-i <certificate.x509>
> +    Path to the X.509 certificate file in PEM or DER format, required for
> +    signing.


Please also update the options list in the SYNOPSIS section at the top
of the page; and the option list at the bottom of gen.c (just like for
"--use-loader").

Can you also please take a look at the bash completion update? It
shouldn't be too hard if you look at how it deals with other options, in
particular --base-btf that also takes one argument - and I can help if
necessary.


>  
>  EXAMPLES
>  ========
> diff --git a/tools/bpf/bpftool/Documentation/bpftool-prog.rst b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
> index f69fd92df8d8..dc2ca196137e 100644
> --- a/tools/bpf/bpftool/Documentation/bpftool-prog.rst
> +++ b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
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


Same as for skeletons: please update the list of options in the synopsis
and at the bottom of prog.c (bash completion for skeletons' options
should also cover this case, so no additional work required here).


> +
>  EXAMPLES
>  ========
>  **# bpftool prog show**
> diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
> index 9e9a5f006cd2..586d1b2595d1 100644
> --- a/tools/bpf/bpftool/Makefile
> +++ b/tools/bpf/bpftool/Makefile
> @@ -130,8 +130,8 @@ include $(FEATURES_DUMP)
>  endif
>  endif
>  
> -LIBS = $(LIBBPF) -lelf -lz
> -LIBS_BOOTSTRAP = $(LIBBPF_BOOTSTRAP) -lelf -lz
> +LIBS = $(LIBBPF) -lelf -lz -lcrypto
> +LIBS_BOOTSTRAP = $(LIBBPF_BOOTSTRAP) -lelf -lz -lcrypto
>  
>  ifeq ($(feature-libelf-zstd),1)
>  LIBS += -lzstd
> @@ -194,7 +194,7 @@ endif
>  
>  BPFTOOL_BOOTSTRAP := $(BOOTSTRAP_OUTPUT)bpftool
>  
> -BOOTSTRAP_OBJS = $(addprefix $(BOOTSTRAP_OUTPUT),main.o common.o json_writer.o gen.o btf.o)
> +BOOTSTRAP_OBJS = $(addprefix $(BOOTSTRAP_OUTPUT),main.o common.o json_writer.o gen.o btf.o sign.o)
>  $(BOOTSTRAP_OBJS): $(LIBBPF_BOOTSTRAP)
>  
>  OBJS = $(patsubst %.c,$(OUTPUT)%.o,$(SRCS)) $(OUTPUT)disasm.o
> diff --git a/tools/bpf/bpftool/cgroup.c b/tools/bpf/bpftool/cgroup.c
> index 944ebe21a216..90c9aa297806 100644
> --- a/tools/bpf/bpftool/cgroup.c
> +++ b/tools/bpf/bpftool/cgroup.c
> @@ -1,7 +1,10 @@
>  // SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>  // Copyright (C) 2017 Facebook
>  // Author: Roman Gushchin <guro@fb.com>
> -


Let's keep the blank line


> +#undef GCC_VERSION
> +#ifndef _GNU_SOURCE
> +#define _GNU_SOURCE
> +#endif


What are these for?


>  #define _XOPEN_SOURCE 500
>  #include <errno.h>
>  #include <fcntl.h>

[...]

> diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
> index 2b7f2bd3a7db..fc25bb390ec7 100644
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
> @@ -447,6 +450,7 @@ int main(int argc, char **argv)
>  		{ "nomount",	no_argument,	NULL,	'n' },
>  		{ "debug",	no_argument,	NULL,	'd' },
>  		{ "use-loader",	no_argument,	NULL,	'L' },
> +		{ "sign",	required_argument, NULL, 'S'},
>  		{ "base-btf",	required_argument, NULL, 'B' },
>  		{ 0 }
>  	};
> @@ -473,7 +477,7 @@ int main(int argc, char **argv)
>  	bin_name = "bpftool";
>  
>  	opterr = 0;
> -	while ((opt = getopt_long(argc, argv, "VhpjfLmndB:l",
> +	while ((opt = getopt_long(argc, argv, "VhpjfLmndSi:k:B:l",
>  				  options, NULL)) >= 0) {
>  		switch (opt) {
>  		case 'V':
> @@ -519,6 +523,16 @@ int main(int argc, char **argv)
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
> @@ -533,6 +547,11 @@ int main(int argc, char **argv)
>  	if (argc < 0)
>  		usage();
>  
> +	if (sign_progs && (private_key_path == NULL || cert_path == NULL)) {
> +		p_err("-i <identity_x509_cert> and -k <private> key must be supplied with -S for signing");
> +		return -EINVAL;
> +	}


What if -i and/or -k are passed without -S?


> +
>  	if (version_requested)
>  		ret = do_version(argc, argv);
>  	else
> diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
> index 6db704fda5c0..f921af3cda87 100644
> --- a/tools/bpf/bpftool/main.h
> +++ b/tools/bpf/bpftool/main.h
> @@ -6,9 +6,14 @@
>  
>  /* BFD and kernel.h both define GCC_VERSION, differently */
>  #undef GCC_VERSION
> +#ifndef _GNU_SOURCE
> +#define _GNU_SOURCE
> +#endif
>  #include <stdbool.h>
>  #include <stdio.h>
> +#include <errno.h>
>  #include <stdlib.h>
> +#include <bpf/skel_internal.h>


Wnat do you need these includes (and _GNU_SOURCE) in main.h for?


>  #include <linux/bpf.h>
>  #include <linux/compiler.h>
>  #include <linux/kernel.h>

[...]

> diff --git a/tools/bpf/bpftool/sign.c b/tools/bpf/bpftool/sign.c
> new file mode 100644
> index 000000000000..f0b5dd10a46b
> --- /dev/null
> +++ b/tools/bpf/bpftool/sign.c
> @@ -0,0 +1,210 @@
> +// SPDX-License-Identifier: GPL-2.0


Please consider making this file dual-licensed like the rest of
bpftool's source code, "(GPL-2.0-only OR BSD-2-Clause)".


> +
> +/*
> + * Copyright (C) 2022 Google LLC.


2025?


> + */
> +#define _GNU_SOURCE


Please guard this:

	#ifndef _GNU_SOURCE
	#define _GNU_SOURCE
	#endif

This is because "llvm-config --cflags" passes -D_GNU_SOURCE and we may
end up with a duplicate definition, otherwise.


> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <stdint.h>
> +#include <stdbool.h>
> +#include <string.h>
> +#include <string.h>
> +#include <getopt.h>
> +#include <err.h>
> +#include <openssl/opensslv.h>
> +#include <openssl/bio.h>
> +#include <openssl/evp.h>
> +#include <openssl/pem.h>
> +#include <openssl/err.h>
> +#include <openssl/cms.h>
> +#include <linux/keyctl.h>
> +#include <errno.h>
> +
> +#include <bpf/skel_internal.h>
> +
> +#include "main.h"
> +
> +#define OPEN_SSL_ERR_BUF_LEN 256
> +
> +static void display_openssl_errors(int l)
> +{
> +	char buf[OPEN_SSL_ERR_BUF_LEN];
> +	const char *file;
> +	const char *data;
> +	unsigned long e;
> +	int flags;
> +	int line;
> +
> +	while ((e = ERR_get_error_all(&file, &line, NULL, &data, &flags))) {
> +		ERR_error_string_n(e, buf, sizeof(buf));
> +		if (data && (flags & ERR_TXT_STRING)) {
> +			p_err("OpenSSL %s: %s:%d: %s\n", buf, file, line, data);


Please remove the trailing '\n', p_err() handles it already.


> +		} else {
> +			p_err("OpenSSL %s: %s:%d\n", buf, file, line);


Same here.

[...]

