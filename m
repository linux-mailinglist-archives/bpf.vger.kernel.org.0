Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA26338EF8
	for <lists+bpf@lfdr.de>; Fri, 12 Mar 2021 14:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbhCLNjv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Mar 2021 08:39:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:51276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231330AbhCLNju (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Mar 2021 08:39:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A035564FCE;
        Fri, 12 Mar 2021 13:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615556389;
        bh=nZfmjBUd/XLz0rLwPXsFG4Oi9D6W8pv68SGJVGeRlnw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ac63uhQ+DyWnr8HaowEwst0892bAZqp29LHVMHG6kkxAv8sk6r3qGvGHxU9mpvmdm
         BZvpSZ21wVOV0wdpZWRE3X/+URLT4cInog3VJdrfj0UbEgB/m7+PUbKgorlbIlg0rs
         H2nkxccEp7lHU6CENSgVDJ80pjhDtwKt/kBHKvfeNA5XZRJGYksUqILeiVTepNQvzK
         Z7aG4SsDi+jluk+qgmm9cydwgGA7zb9OkHiBkK6n8ihp6b6OPDC0ZAGGhpAMMqR/Xa
         TitNvN4tUxIfCrjqp1T8SkYg8D9xzkW3dtZN6M8EHrJFrvHHvk54aFfM0DFhHuIjOz
         /wCUlGbYYW8Gw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 898DF40647; Fri, 12 Mar 2021 10:39:46 -0300 (-03)
Date:   Fri, 12 Mar 2021 10:39:46 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andrii Nakryiko <andrii@kernel.org>, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH dwarves] btf: Add --btf_gen_all flag
Message-ID: <YEtvIvODFEQHgt8m@kernel.org>
References: <20210312000808.175262-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312000808.175262-1-iii@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Fri, Mar 12, 2021 at 01:08:08AM +0100, Ilya Leoshkevich escreveu:
> By default, pahole makes use only of BTF features introduced with
> kernel v5.2. Features that are added later need to be turned on with
> explicit feature flags, such as --btf_gen_floats. According to [1],
> this will hinder the people who generate BTF for kernels externally
> (e.g. for old kernels to support BPF CO-RE).
> 
> Introduce --btf_gen_all that allows using all BTF features supported
> by pahole.
> 
> [1] https://lore.kernel.org/dwarves/CAEf4Bzbyugfb2RkBkRuxNGKwSk40Tbq4zAvhQT8W=fVMYWuaxA@mail.gmail.com/

Applied locally, testing ongoing.

Also added this:

Suggested-by: Andrii Nakryiko <andrii@kernel.org>

- Arnaldo
 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  man-pages/pahole.1 | 4 ++++
>  pahole.c           | 8 ++++++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
> index e292b2c..cbbefbf 100644
> --- a/man-pages/pahole.1
> +++ b/man-pages/pahole.1
> @@ -204,6 +204,10 @@ to "/sys/kernel/btf/vmlinux".
>  Allow producing BTF_KIND_FLOAT entries in systems where the vmlinux DWARF
>  information has float types.
>  
> +.TP
> +.B \-\-btf_gen_all
> +Allow using all the BTF features supported by pahole.
> +
>  .TP
>  .B \-l, \-\-show_first_biggest_size_base_type_member
>  Show first biggest size base_type member.
> diff --git a/pahole.c b/pahole.c
> index c8d38f5..df6aa83 100644
> --- a/pahole.c
> +++ b/pahole.c
> @@ -826,6 +826,7 @@ ARGP_PROGRAM_VERSION_HOOK_DEF = dwarves_print_version;
>  #define ARGP_numeric_version       320
>  #define ARGP_btf_base		   321
>  #define ARGP_btf_gen_floats	   322
> +#define ARGP_btf_gen_all	   323
>  
>  static const struct argp_option pahole__options[] = {
>  	{
> @@ -1125,6 +1126,11 @@ static const struct argp_option pahole__options[] = {
>  		.key  = ARGP_btf_gen_floats,
>  		.doc  = "Allow producing BTF_KIND_FLOAT entries."
>  	},
> +	{
> +		.name = "btf_gen_all",
> +		.key  = ARGP_btf_gen_all,
> +		.doc  = "Allow using all the BTF features supported by pahole."
> +	},
>  	{
>  		.name = "structs",
>  		.key  = ARGP_just_structs,
> @@ -1262,6 +1268,8 @@ static error_t pahole__options_parser(int key, char *arg,
>  		print_numeric_version = true;		break;
>  	case ARGP_btf_gen_floats:
>  		btf_gen_floats = true;			break;
> +	case ARGP_btf_gen_all:
> +		btf_gen_floats = true;			break;
>  	default:
>  		return ARGP_ERR_UNKNOWN;
>  	}
> -- 
> 2.29.2
> 

-- 

- Arnaldo
