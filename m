Return-Path: <bpf+bounces-63997-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE17EB0D15F
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 07:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF47517EF06
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 05:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FE728B4F8;
	Tue, 22 Jul 2025 05:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jkr7B2K3"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1A178F32
	for <bpf@vger.kernel.org>; Tue, 22 Jul 2025 05:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753163326; cv=none; b=ldhe288yFRxFDfaEuExw+ygVvP886awmYvaKig1HmQFTeWSr7tItTe1P4+grENUPqXfow5bQ5IEZCn1sWLQd4pA/tCqR7AtKDR9/Vvg1Twktv/Zas9ZIcgcstEfdz8M50i2ZxugJOnfrZsnhwdL/oljJgbOOtBdD4E99JWqFMq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753163326; c=relaxed/simple;
	bh=C3xpCXSwydRrWzTdRceLtbVq+xVHgKzdzMnpKU5QheM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i5ubfq7jgVYyR6ko8YoaZPSmPiHSNfYqzQiULTe1/wm7dXNlf76mVII+/ozu6qKLsjss1uFy/moHSTVB7iMXbQuYzCw8A+V+b+Fr3rrMTN8iBs3udhYJHw3/fCJoe6UrS6AsDkqpNKRlPYg6YanpAZN0W596kIyBvoJSJShxLWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jkr7B2K3; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <06387128-8d34-49fd-a409-d35f5d60b094@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753163321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m/iwLPdiIBFi6lp1IENj7q/2PClonPRpthSmWe4Tk/c=;
	b=jkr7B2K3bc55GgaXWR4zwgbI1qDEq33XvAeRPGQONKTIqbOL+Egj3NJ6SWLapcygwaXrC4
	sMssxCc7+JR962mGrWBwE9HosZGL+IsI/VHm5euAQ8z6uxER/1eth+FE9WRa5sKl01Cf5V
	MKlHMuZ1HcNgfrqxzO1Xx1PC9fX8aYk=
Date: Tue, 22 Jul 2025 13:48:28 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/2] bpftool: Add bpf_token show
To: Quentin Monnet <qmo@kernel.org>, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 kuba@kernel.org, hawk@kernel.org
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20250720173310.1334483-1-chen.dylane@linux.dev>
 <6b0669fd-fef6-4f4e-b80d-512769e86938@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <6b0669fd-fef6-4f4e-b80d-512769e86938@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/7/22 00:23, Quentin Monnet 写道:
> Thanks a lot for this!
> 

Hi Quenin,

> 
> 2025-07-21 01:33 UTC+0800 ~ Tao Chen <chen.dylane@linux.dev>
>> Add `bpftool token show` command to get token info
>> from bpf fs in /proc/mounts.
>>
>> Example plain output for `token show`:
>> token_info:
>>          /sys/fs/bpf/token
>>
>> allowed_cmds:
>>          map_create          prog_load
>>
>> allowed_maps:
>>
>> allowed_progs:
>>          kprobe
>>
>> allowed_attachs:
>>          xdp
>>
>> Example json output for `token show`:
>> {
>>      "token_info": "/sys/fs/bpf/token",
>>      "allowed_cmds": ["map_create","prog_load"
>>      ],
>>      "allowed_maps":
> 
> 
> This is not valid JSON. You're missing a value for "allowed_maps" (here
> it should likely be an empty array), and the comma:
> 
> 	"allowed_maps": [],
> 
> 
>>      "allowed_progs": ["kprobe"
>>      ],
>>      "allowed_attachs": ["xdp"
>>      ]
>> }
>>
>> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
>> ---
>>   tools/bpf/bpftool/main.c  |   3 +-
>>   tools/bpf/bpftool/main.h  |   1 +
>>   tools/bpf/bpftool/token.c | 229 ++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 232 insertions(+), 1 deletion(-)
>>   create mode 100644 tools/bpf/bpftool/token.c
>>
>> diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
>> index 2b7f2bd3a7d..0f1183b2ed0 100644
>> --- a/tools/bpf/bpftool/main.c
>> +++ b/tools/bpf/bpftool/main.c
>> @@ -61,7 +61,7 @@ static int do_help(int argc, char **argv)
>>   		"       %s batch file FILE\n"
>>   		"       %s version\n"
>>   		"\n"
>> -		"       OBJECT := { prog | map | link | cgroup | perf | net | feature | btf | gen | struct_ops | iter }\n"
>> +		"       OBJECT := { prog | map | link | cgroup | perf | net | feature | btf | gen | struct_ops | iter | token }\n"
>>   		"       " HELP_SPEC_OPTIONS " |\n"
>>   		"                    {-V|--version} }\n"
>>   		"",
>> @@ -87,6 +87,7 @@ static const struct cmd commands[] = {
>>   	{ "gen",	do_gen },
>>   	{ "struct_ops",	do_struct_ops },
>>   	{ "iter",	do_iter },
>> +	{ "token",	do_token },
>>   	{ "version",	do_version },
>>   	{ 0 }
>>   };
>> diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
>> index 6db704fda5c..a2bb0714b3d 100644
>> --- a/tools/bpf/bpftool/main.h
>> +++ b/tools/bpf/bpftool/main.h
>> @@ -166,6 +166,7 @@ int do_tracelog(int argc, char **arg) __weak;
>>   int do_feature(int argc, char **argv) __weak;
>>   int do_struct_ops(int argc, char **argv) __weak;
>>   int do_iter(int argc, char **argv) __weak;
>> +int do_token(int argc, char **argv) __weak;
>>   
>>   int parse_u32_arg(int *argc, char ***argv, __u32 *val, const char *what);
>>   int prog_parse_fd(int *argc, char ***argv);
>> diff --git a/tools/bpf/bpftool/token.c b/tools/bpf/bpftool/token.c
>> new file mode 100644
>> index 00000000000..2fcaff4f2ba
>> --- /dev/null
>> +++ b/tools/bpf/bpftool/token.c
>> @@ -0,0 +1,229 @@
>> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +
>> +#ifndef _GNU_SOURCE
>> +#define _GNU_SOURCE
>> +#endif
>> +#include <errno.h>
>> +#include <fcntl.h>
>> +#include <stdbool.h>
>> +#include <stdio.h>
>> +#include <stdlib.h>
>> +#include <string.h>
>> +#include <unistd.h>
>> +#include <mntent.h>
>> +#include <sys/types.h>
>> +#include <sys/stat.h>
>> +
>> +#include "json_writer.h"
>> +#include "main.h"
>> +
>> +#define MOUNTS_FILE "/proc/mounts"
>> +
>> +#define zclose(fd) do { if (fd >= 0) close(fd); fd = -1; } while (0)
> 
> 
> Seems unused?
> 
My fault, will remove it in v2, thanks.

> 
>> +
>> +static bool has_delegate_options(const char *mnt_ops)
>> +{
>> +	return strstr(mnt_ops, "delegate_cmds") != NULL ||
>> +	       strstr(mnt_ops, "delegate_maps") != NULL ||
>> +	       strstr(mnt_ops, "delegate_progs") != NULL ||
>> +	       strstr(mnt_ops, "delegate_attachs") != NULL;
>> +}
>> +
>> +static char *get_delegate_value(const char *opts, const char *key)
>> +{
>> +	char *token, *rest, *ret = NULL;
>> +	char *opts_copy = strdup(opts);
>> +
>> +	if (!opts_copy)
>> +		return NULL;
>> +
>> +	for (token = strtok_r(opts_copy, ",", &rest); token != NULL;
>> +			token = strtok_r(NULL, ",", &rest)) {
>> +		if (strncmp(token, key, strlen(key)) == 0 &&
>> +				token[strlen(key)] == '=') {
>> +			ret = token + strlen(key) + 1;
>> +			break;
>> +		}
>> +	}
>> +	free(opts_copy);
>> +
>> +	return ret;
>> +}
>> +
>> +static void print_items_per_line(const char *input, int items_per_line)
>> +{
>> +	char *str, *rest;
>> +	int cnt = 0;
>> +	char *strs = strdup(input);
>> +
>> +	if (!strs)
>> +		return;
>> +
>> +	for (str = strtok_r(strs, ":", &rest); str != NULL;
>> +			str = strtok_r(NULL, ":", &rest)) {
>> +		if (cnt % items_per_line == 0)
>> +			printf("\n\t");
>> +
>> +		printf("%-20s", str);
>> +		cnt++;
>> +	}
>> +
>> +	free(strs);
>> +}
>> +
>> +#define ITEMS_PER_LINE 4
>> +static void show_token_info_plain(struct mntent *mntent)
>> +{
>> +	char *value;
>> +
>> +	printf("\ntoken_info:");
>> +	printf("\n\t%s\n", mntent->mnt_dir);
>> +
>> +	printf("\nallowed_cmds:");
>> +	value = get_delegate_value(mntent->mnt_opts, "delegate_cmds");
>> +	if (value)
>> +		print_items_per_line(value, ITEMS_PER_LINE);
>> +	printf("\n");
>> +
>> +	printf("\nallowed_maps:");
>> +	value = get_delegate_value(mntent->mnt_opts, "delegate_maps");
>> +	if (value)
>> +		print_items_per_line(value, ITEMS_PER_LINE);
>> +	printf("\n");
>> +
>> +	printf("\nallowed_progs:");
>> +	value = get_delegate_value(mntent->mnt_opts, "delegate_progs");
>> +	if (value)
>> +		print_items_per_line(value, ITEMS_PER_LINE);
>> +	printf("\n");
>> +
>> +	printf("\nallowed_attachs:");
>> +	value = get_delegate_value(mntent->mnt_opts, "delegate_attachs");
>> +	if (value)
>> +		print_items_per_line(value, ITEMS_PER_LINE);
>> +	printf("\n");
>> +}
>> +
>> +static void __json_array_str(const char *input)
> 
> 
> Nit: Why the double underscore in the function name? Let's use a more
> explicit name also, maybe something like "split_to_json_array"?
> 

Well, it looks better, will change it in v2.

> >> +{
>> +	char *str, *rest;
>> +	char *strs = strdup(input);
>> +
>> +	if (!strs)
>> +		return;
>> +
>> +	jsonw_start_array(json_wtr);
>> +	for (str = strtok_r(strs, ":", &rest); str != NULL;
>> +			str = strtok_r(NULL, ":", &rest)) {
>> +		jsonw_string(json_wtr, str);
>> +	}
>> +	jsonw_end_array(json_wtr);
>> +
>> +	free(strs);
>> +}
>> +
>> +static void show_token_info_json(struct mntent *mntent)
>> +{
>> +	char *value;
>> +
>> +	jsonw_start_object(json_wtr);
>> +
>> +	jsonw_string_field(json_wtr, "token_info", mntent->mnt_dir);
>> +
>> +	jsonw_name(json_wtr, "allowed_cmds");
>> +	value = get_delegate_value(mntent->mnt_opts, "delegate_cmds");
>> +	if (value)
>> +		__json_array_str(value);
> 
> 
> As mentioned above, you need to change __json_array_str() to print
> something when you don't get a "value" here - just have it print an
> empty array.
> 

As you mentioned, the 'value' will be checked within the 
__json_array_str, and print empty array if it is NULL in v2.

> 
>> +
>> +	jsonw_name(json_wtr, "allowed_maps");
>> +	value = get_delegate_value(mntent->mnt_opts, "delegate_maps");
>> +	if (value)
>> +		__json_array_str(value);
>> +
>> +	jsonw_name(json_wtr, "allowed_progs");
>> +	value = get_delegate_value(mntent->mnt_opts, "delegate_progs");
>> +	if (value)
>> +		__json_array_str(value);
>> +
>> +	jsonw_name(json_wtr, "allowed_attachs");
>> +	value = get_delegate_value(mntent->mnt_opts, "delegate_attachs");
>> +	if (value)
>> +		__json_array_str(value);
>> +
>> +	jsonw_end_object(json_wtr);
>> +}
>> +
>> +static int __show_token_info(struct mntent *mntent)
>> +{
>> +
>> +	if (json_output)
>> +		show_token_info_json(mntent);
>> +	else
>> +		show_token_info_plain(mntent);
>> +
>> +	return 0;
>> +}
>> +
>> +static int show_token_info(void)
>> +{
>> +	FILE *fp;
>> +	struct mntent *ent;
>> +	bool hit = false;
>> +
>> +	fp = setmntent(MOUNTS_FILE, "r");
>> +	if (!fp) {
>> +		p_err("Failed to open:%s", MOUNTS_FILE);
> 
> 
> Missing space after the colon, in the error message.
> 

will fix it in v2.

> 
>> +		return -1;
>> +	}
>> +
>> +	while ((ent = getmntent(fp)) != NULL) {
>> +		if (strcmp(ent->mnt_type, "bpf") == 0) {
> 
> 
> File common.c has:
> 
> 		if (strncmp(mntent->mnt_type, "bpf", 3) != 0)
> 			continue;
> 
> Maybe do the same for consistency, and to avoid indenting too far right?
> 

Yes, i will refrence that, thanks.

> 
>> +			if (has_delegate_options(ent->mnt_opts)) {
>> +				hit = true;
>> +				break;
> 
> 
> Apologies, my knowledge of BPF tokens is limited. Can you have only one
> token exposed through a bpffs at a time? Asking because I know you can
> have several bpffs on your system, if each can have delegate options
> then why stop after the first bpffs mount point you find?
> 

Yes it is, only the first bpffs with token info will be showed above.
Actually, it will not be limited how many bpffs ceated in kernel, it 
depends on the user scenarios. In most cases, only one will be created. 
But, maybe it's better to show all. I will change it in v2.

> 
>> +			}
>> +		}
>> +	}
>> +
>> +	if (hit)
>> +		__show_token_info(ent);
> 
> 
> Maybe at least a p_info() message if you don't find anything to print?
> 
Ok, will add it in v2.

> 
>> +	endmntent(fp);
>> +
>> +	return 0;
>> +}
>> +
>> +static int do_show(int argc, char **argv)
>> +{
>> +	if (argc)
>> +		return BAD_ARG();
>> +
>> +	return show_token_info();
>> +}
>> +
>> +static int do_help(int argc, char **argv)
>> +{
>> +	if (json_output) {
>> +		jsonw_null(json_wtr);
>> +		return 0;
>> +	}
>> +
>> +	fprintf(stderr,
>> +		"Usage: %1$s %2$s { show | list }\n"
>> +		"	%1$s %2$s help\n"
>> +		"\n"
>> +		"",
>> +		bin_name, argv[-2]);
>> +	return 0;
>> +}
>> +
>> +static const struct cmd cmds[] = {
>> +	{ "show",	do_show },
>> +	{ "help",	do_help },
>> +	{ "list",	do_show },
> 
> 
> Nit: Can we have "help" coming third, below both "show" and "list" please?
> 

will change it in v2.

> 
>> +	{ 0 }
>> +};
>> +
>> +int do_token(int argc, char **argv)
>> +{
>> +	return cmd_select(cmds, argc, argv, do_help);
>> +}
> 
-- 
Best Regards
Tao Chen

