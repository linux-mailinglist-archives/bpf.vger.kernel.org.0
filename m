Return-Path: <bpf+bounces-63928-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B55B0C892
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 18:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96808165FF0
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 16:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F50F2E03FA;
	Mon, 21 Jul 2025 16:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tH3N33YN"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790D81F37D3;
	Mon, 21 Jul 2025 16:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753115035; cv=none; b=Wu37EebPak7vbVUMDQzm1/EuRYR6+vD0xanFsYHk+28QtBGPkhtmqxLr0fU222mH2/kujQkukSjuGaityHDiuSuVYEJs+v9RAhWvOIkVcOearlpgIymoKNKsHgltcmwyXE+JxLBvGH0V3dsWe1YrB9bvgPYYA4gN2sv5SbomGmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753115035; c=relaxed/simple;
	bh=kO/ojY0PKE/G0K4Aubf2edaZj4LmwtMDF2WwLrQ1IUU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hhu8Sl+C+UdrIHA8USTKdBpScS3OQ6GqatnXL0SZgPQBzSinyTppswccKIMb8R7rcFfjeqGFk2u8Osz92qo37dgiNmHwD3i/tuyiVHe5qrz6CHmAYhFeL9cmjaa0I0KtzrUwKONMyz2NXcwDxVgaypDTfYdfSAKgNOxF71Cte88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tH3N33YN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44C41C4CEED;
	Mon, 21 Jul 2025 16:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753115035;
	bh=kO/ojY0PKE/G0K4Aubf2edaZj4LmwtMDF2WwLrQ1IUU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tH3N33YNAGoUDzxav2ywGWPKinOWFxIp5t3GbrgF0ubIvy0u7H+GFTQZ/SZ5xj5iI
	 9j0IQjlAVKDQXzuWqikwXYAWcE9ZhLBFrGa1HnEB3TI+jjUUyIdnEdf1XmfGjwkDVU
	 5BgBRAh4x3Ndp+JlaBucVjjTrLBVqgyYYxACVob5jE3rBEGsrUC+1ajEDlqbWeMt0z
	 4Po82Ff13FhV44Y0hoYeL4zL3xhR2/gd3z1xQSp3Rk4rTvMPGbrd1EL26uUcXC29nf
	 MEj6+KfSnXS3PQXRX7ka+LcmYmUtGVjtsUUKVr782yFISn1KFYiP5EZCPmOKSyieiJ
	 RuAHqpSNCm+ug==
Message-ID: <6b0669fd-fef6-4f4e-b80d-512769e86938@kernel.org>
Date: Mon, 21 Jul 2025 17:23:50 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/2] bpftool: Add bpf_token show
To: Tao Chen <chen.dylane@linux.dev>, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 kuba@kernel.org, hawk@kernel.org
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20250720173310.1334483-1-chen.dylane@linux.dev>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20250720173310.1334483-1-chen.dylane@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Thanks a lot for this!


2025-07-21 01:33 UTC+0800 ~ Tao Chen <chen.dylane@linux.dev>
> Add `bpftool token show` command to get token info
> from bpf fs in /proc/mounts.
> 
> Example plain output for `token show`:
> token_info:
>         /sys/fs/bpf/token
> 
> allowed_cmds:
>         map_create          prog_load
> 
> allowed_maps:
> 
> allowed_progs:
>         kprobe
> 
> allowed_attachs:
>         xdp
> 
> Example json output for `token show`:
> {
>     "token_info": "/sys/fs/bpf/token",
>     "allowed_cmds": ["map_create","prog_load"
>     ],
>     "allowed_maps":


This is not valid JSON. You're missing a value for "allowed_maps" (here
it should likely be an empty array), and the comma:

	"allowed_maps": [],


>     "allowed_progs": ["kprobe"
>     ],
>     "allowed_attachs": ["xdp"
>     ]
> }
> 
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> ---
>  tools/bpf/bpftool/main.c  |   3 +-
>  tools/bpf/bpftool/main.h  |   1 +
>  tools/bpf/bpftool/token.c | 229 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 232 insertions(+), 1 deletion(-)
>  create mode 100644 tools/bpf/bpftool/token.c
> 
> diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
> index 2b7f2bd3a7d..0f1183b2ed0 100644
> --- a/tools/bpf/bpftool/main.c
> +++ b/tools/bpf/bpftool/main.c
> @@ -61,7 +61,7 @@ static int do_help(int argc, char **argv)
>  		"       %s batch file FILE\n"
>  		"       %s version\n"
>  		"\n"
> -		"       OBJECT := { prog | map | link | cgroup | perf | net | feature | btf | gen | struct_ops | iter }\n"
> +		"       OBJECT := { prog | map | link | cgroup | perf | net | feature | btf | gen | struct_ops | iter | token }\n"
>  		"       " HELP_SPEC_OPTIONS " |\n"
>  		"                    {-V|--version} }\n"
>  		"",
> @@ -87,6 +87,7 @@ static const struct cmd commands[] = {
>  	{ "gen",	do_gen },
>  	{ "struct_ops",	do_struct_ops },
>  	{ "iter",	do_iter },
> +	{ "token",	do_token },
>  	{ "version",	do_version },
>  	{ 0 }
>  };
> diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
> index 6db704fda5c..a2bb0714b3d 100644
> --- a/tools/bpf/bpftool/main.h
> +++ b/tools/bpf/bpftool/main.h
> @@ -166,6 +166,7 @@ int do_tracelog(int argc, char **arg) __weak;
>  int do_feature(int argc, char **argv) __weak;
>  int do_struct_ops(int argc, char **argv) __weak;
>  int do_iter(int argc, char **argv) __weak;
> +int do_token(int argc, char **argv) __weak;
>  
>  int parse_u32_arg(int *argc, char ***argv, __u32 *val, const char *what);
>  int prog_parse_fd(int *argc, char ***argv);
> diff --git a/tools/bpf/bpftool/token.c b/tools/bpf/bpftool/token.c
> new file mode 100644
> index 00000000000..2fcaff4f2ba
> --- /dev/null
> +++ b/tools/bpf/bpftool/token.c
> @@ -0,0 +1,229 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +
> +#ifndef _GNU_SOURCE
> +#define _GNU_SOURCE
> +#endif
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <stdbool.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <mntent.h>
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +
> +#include "json_writer.h"
> +#include "main.h"
> +
> +#define MOUNTS_FILE "/proc/mounts"
> +
> +#define zclose(fd) do { if (fd >= 0) close(fd); fd = -1; } while (0)


Seems unused?


> +
> +static bool has_delegate_options(const char *mnt_ops)
> +{
> +	return strstr(mnt_ops, "delegate_cmds") != NULL ||
> +	       strstr(mnt_ops, "delegate_maps") != NULL ||
> +	       strstr(mnt_ops, "delegate_progs") != NULL ||
> +	       strstr(mnt_ops, "delegate_attachs") != NULL;
> +}
> +
> +static char *get_delegate_value(const char *opts, const char *key)
> +{
> +	char *token, *rest, *ret = NULL;
> +	char *opts_copy = strdup(opts);
> +
> +	if (!opts_copy)
> +		return NULL;
> +
> +	for (token = strtok_r(opts_copy, ",", &rest); token != NULL;
> +			token = strtok_r(NULL, ",", &rest)) {
> +		if (strncmp(token, key, strlen(key)) == 0 &&
> +				token[strlen(key)] == '=') {
> +			ret = token + strlen(key) + 1;
> +			break;
> +		}
> +	}
> +	free(opts_copy);
> +
> +	return ret;
> +}
> +
> +static void print_items_per_line(const char *input, int items_per_line)
> +{
> +	char *str, *rest;
> +	int cnt = 0;
> +	char *strs = strdup(input);
> +
> +	if (!strs)
> +		return;
> +
> +	for (str = strtok_r(strs, ":", &rest); str != NULL;
> +			str = strtok_r(NULL, ":", &rest)) {
> +		if (cnt % items_per_line == 0)
> +			printf("\n\t");
> +
> +		printf("%-20s", str);
> +		cnt++;
> +	}
> +
> +	free(strs);
> +}
> +
> +#define ITEMS_PER_LINE 4
> +static void show_token_info_plain(struct mntent *mntent)
> +{
> +	char *value;
> +
> +	printf("\ntoken_info:");
> +	printf("\n\t%s\n", mntent->mnt_dir);
> +
> +	printf("\nallowed_cmds:");
> +	value = get_delegate_value(mntent->mnt_opts, "delegate_cmds");
> +	if (value)
> +		print_items_per_line(value, ITEMS_PER_LINE);
> +	printf("\n");
> +
> +	printf("\nallowed_maps:");
> +	value = get_delegate_value(mntent->mnt_opts, "delegate_maps");
> +	if (value)
> +		print_items_per_line(value, ITEMS_PER_LINE);
> +	printf("\n");
> +
> +	printf("\nallowed_progs:");
> +	value = get_delegate_value(mntent->mnt_opts, "delegate_progs");
> +	if (value)
> +		print_items_per_line(value, ITEMS_PER_LINE);
> +	printf("\n");
> +
> +	printf("\nallowed_attachs:");
> +	value = get_delegate_value(mntent->mnt_opts, "delegate_attachs");
> +	if (value)
> +		print_items_per_line(value, ITEMS_PER_LINE);
> +	printf("\n");
> +}
> +
> +static void __json_array_str(const char *input)


Nit: Why the double underscore in the function name? Let's use a more
explicit name also, maybe something like "split_to_json_array"?


> +{
> +	char *str, *rest;
> +	char *strs = strdup(input);
> +
> +	if (!strs)
> +		return;
> +
> +	jsonw_start_array(json_wtr);
> +	for (str = strtok_r(strs, ":", &rest); str != NULL;
> +			str = strtok_r(NULL, ":", &rest)) {
> +		jsonw_string(json_wtr, str);
> +	}
> +	jsonw_end_array(json_wtr);
> +
> +	free(strs);
> +}
> +
> +static void show_token_info_json(struct mntent *mntent)
> +{
> +	char *value;
> +
> +	jsonw_start_object(json_wtr);
> +
> +	jsonw_string_field(json_wtr, "token_info", mntent->mnt_dir);
> +
> +	jsonw_name(json_wtr, "allowed_cmds");
> +	value = get_delegate_value(mntent->mnt_opts, "delegate_cmds");
> +	if (value)
> +		__json_array_str(value);


As mentioned above, you need to change __json_array_str() to print
something when you don't get a "value" here - just have it print an
empty array.


> +
> +	jsonw_name(json_wtr, "allowed_maps");
> +	value = get_delegate_value(mntent->mnt_opts, "delegate_maps");
> +	if (value)
> +		__json_array_str(value);
> +
> +	jsonw_name(json_wtr, "allowed_progs");
> +	value = get_delegate_value(mntent->mnt_opts, "delegate_progs");
> +	if (value)
> +		__json_array_str(value);
> +
> +	jsonw_name(json_wtr, "allowed_attachs");
> +	value = get_delegate_value(mntent->mnt_opts, "delegate_attachs");
> +	if (value)
> +		__json_array_str(value);
> +
> +	jsonw_end_object(json_wtr);
> +}
> +
> +static int __show_token_info(struct mntent *mntent)
> +{
> +
> +	if (json_output)
> +		show_token_info_json(mntent);
> +	else
> +		show_token_info_plain(mntent);
> +
> +	return 0;
> +}
> +
> +static int show_token_info(void)
> +{
> +	FILE *fp;
> +	struct mntent *ent;
> +	bool hit = false;
> +
> +	fp = setmntent(MOUNTS_FILE, "r");
> +	if (!fp) {
> +		p_err("Failed to open:%s", MOUNTS_FILE);


Missing space after the colon, in the error message.


> +		return -1;
> +	}
> +
> +	while ((ent = getmntent(fp)) != NULL) {
> +		if (strcmp(ent->mnt_type, "bpf") == 0) {


File common.c has:

		if (strncmp(mntent->mnt_type, "bpf", 3) != 0)
			continue;

Maybe do the same for consistency, and to avoid indenting too far right?


> +			if (has_delegate_options(ent->mnt_opts)) {
> +				hit = true;
> +				break;


Apologies, my knowledge of BPF tokens is limited. Can you have only one
token exposed through a bpffs at a time? Asking because I know you can
have several bpffs on your system, if each can have delegate options
then why stop after the first bpffs mount point you find?


> +			}
> +		}
> +	}
> +
> +	if (hit)
> +		__show_token_info(ent);


Maybe at least a p_info() message if you don't find anything to print?


> +	endmntent(fp);
> +
> +	return 0;
> +}
> +
> +static int do_show(int argc, char **argv)
> +{
> +	if (argc)
> +		return BAD_ARG();
> +
> +	return show_token_info();
> +}
> +
> +static int do_help(int argc, char **argv)
> +{
> +	if (json_output) {
> +		jsonw_null(json_wtr);
> +		return 0;
> +	}
> +
> +	fprintf(stderr,
> +		"Usage: %1$s %2$s { show | list }\n"
> +		"	%1$s %2$s help\n"
> +		"\n"
> +		"",
> +		bin_name, argv[-2]);
> +	return 0;
> +}
> +
> +static const struct cmd cmds[] = {
> +	{ "show",	do_show },
> +	{ "help",	do_help },
> +	{ "list",	do_show },


Nit: Can we have "help" coming third, below both "show" and "list" please?


> +	{ 0 }
> +};
> +
> +int do_token(int argc, char **argv)
> +{
> +	return cmd_select(cmds, argc, argv, do_help);
> +}


