Return-Path: <bpf+bounces-28989-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE288BF2DA
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 02:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4759C1F230A1
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 00:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7DE681AD7;
	Tue,  7 May 2024 23:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pBnSVFFb"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129EF73514
	for <bpf@vger.kernel.org>; Tue,  7 May 2024 23:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715124047; cv=none; b=HoPuhOO8RQ/gi1Rs+LczCwF6T32CgyPavNp9J7/YRFML3xk0KkWabo0iXy/JeQke1ejreqDwQYk456GFvzBOE/t51v8lGqbi82v+DKpEB+J/75loiRJuCJYSPvebcWUQ33GZdV0Dc7jUK5jz+9F79F+AbQgsMXI921WFglNSnqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715124047; c=relaxed/simple;
	bh=VGnjLYCLsh93O+xSMSpjzl2No7wex8k6/FwauUdnQBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=duCxkYvOJemCFu5EY5dAjFx2SlVU2joXDfJLd5FsnSQGwKhUeVrcEfIcBzKz4ntGlrrkmtIC44bqO4rrxmgPHQbg1kDAqct9glXbrYKy6khMZJUGjBd1kKBReR4+jNRAXwDr313SvDhI3zzyjRXhqU15Rzlao5TnQa1ReE96ssI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pBnSVFFb; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ca8136e0-5d2a-402b-ad03-cc8a218affd4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715124042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XVbHDlzQnvUxQGeT6Y01Ypo21CA9imncIrMPaQB2Sdc=;
	b=pBnSVFFb0nOvV+DHU4OF3vtH2xzaSmdBFeVfstUS0wKo/iXV1EC41Orezud71dAMNpB0sg
	nqsteenxlHRq6TB0Lj9lfeERokuEdue7KNXdmGsXsiusrd+Zu5V1bO851PXtMqA08e16on
	o717cIQJQ0rfoPMGudgKvVZBC1/dg8o=
Date: Tue, 7 May 2024 16:20:36 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/1] Fix for bpf_sysctl_set_new_value
To: Raman Shukhau <ramasha@fb.com>
References: <20240504102312.3137741-1-ramasha@fb.com>
 <20240504102312.3137741-2-ramasha@fb.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net
In-Reply-To: <20240504102312.3137741-2-ramasha@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 5/4/24 3:23 AM, Raman Shukhau wrote:
> Noticed that call to bpf_sysctl_set_new_value doesn't change final value
> of the parameter, when called from cgroup/syscall bpf handler. No error
> thrown in this case, new value is simply ignored and original value, sent
> to sysctl, is set. Example (see test added to this change for BPF handler
> logic):
> 
> sysctl -w net.ipv4.ip_local_reserved_ports = 11111
> ... cgroup/syscal handler call bpf_sysctl_set_new_value	and set 22222
> sysctl net.ipv4.ip_local_reserved_ports
> ... returns 11111
> 
> On investigation I found 2 things that needs to be changed:
> * return value check
> * new_len provided by bpf back to sysctl. proc_sys_call_handler	expects
>    this value NOT to include \0 symbol, e.g. if user do

Thanks for the report and the patch.

This patch is changing a few things (1 fix, 1 improvement, 1 test).

Separate these individual changes into its own patch. Patch 1 fixes the return 
value. Patch 2 improves the '\0' and *pcount situation. Patch 3 adds the test.

btw, I am curious what is missed in the test_sysctl.c that didn't catch the 
return value case?

> 
> 	```
>    open("/proc/sys/net/ipv4/ip_local_reserved_ports", ...)
>    write(fd, "11111", sizeof("22222"))
>    ```
> 
>    or `echo -n "11111" > /proc/sys/net/ipv4/ip_local_reserved_ports`
> 
>    or `sysctl -w	net.ipv4.ip_local_reserved_ports=11111
> 
>    proc_sys_call_handler receives count equal to `5`. To make it consistent
>    with bpf_sysctl_set_new_value, this change also adjust `new_len` with
>    `-1`, if `\0` passed as last character. Alternatively, using
>    `sizeof("11111") - 1` in BPF handler should work, but it might not be
>    obvious and spark confusion. Note: if incorrect count is used, sysctl
>    returns EINVAL to the user.
> 
> Signed-off-by: Raman Shukhau <ramasha@fb.com>
> ---
>   kernel/bpf/cgroup.c                           |  7 ++-
>   .../bpf/progs/test_sysctl_overwrite.c         | 47 +++++++++++++++++++
>   tools/testing/selftests/bpf/test_sysctl.c     | 35 +++++++++++++-
>   3 files changed, 85 insertions(+), 4 deletions(-)
>   create mode 100644 tools/testing/selftests/bpf/progs/test_sysctl_overwrite.c
> 
> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index 8ba73042a239..23736aed1b53 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -1739,10 +1739,13 @@ int __cgroup_bpf_run_filter_sysctl(struct ctl_table_header *head,
>   
>   	kfree(ctx.cur_val);
>   
> -	if (ret == 1 && ctx.new_updated) {
> +	if (ret == 0 && ctx.new_updated) {
>   		kfree(*buf);
>   		*buf = ctx.new_val;
> -		*pcount = ctx.new_len;
> +		if (!(*buf)[ctx.new_len])
> +			*pcount = ctx.new_len - 1;

 From looking at how new_updated is set, my understanding is new_len cannot be 0 
here. just want to double check.


> +		else
> +			*pcount = ctx.new_len;
>   	} else {
>   		kfree(ctx.new_val);
>   	}
> diff --git a/tools/testing/selftests/bpf/progs/test_sysctl_overwrite.c b/tools/testing/selftests/bpf/progs/test_sysctl_overwrite.c
> new file mode 100644
> index 000000000000..e44b429fcfc1
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_sysctl_overwrite.c
> @@ -0,0 +1,47 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2019 Facebook
> +
> +#include <string.h>
> +
> +#include <linux/bpf.h>
> +
> +#include <bpf/bpf_helpers.h>
> +
> +#include "bpf_compiler.h"
> +
> +static const char sysctl_value[] = "31337";
> +static const char sysctl_name[] = "net/ipv4/ip_local_reserved_ports";
> +static __always_inline int is_expected_name(struct bpf_sysctl *ctx)
> +{
> +	unsigned char i;
> +	char name[sizeof(sysctl_name)];
> +	int ret;
> +
> +	memset(name, 0, sizeof(name));
> +	ret = bpf_sysctl_get_name(ctx, name, sizeof(name), 0);
> +	if (ret < 0 || ret != sizeof(sysctl_name) - 1)
> +		return 0;
> +
> +	__pragma_loop_unroll_full
> +	for (i = 0; i < sizeof(sysctl_name); ++i)
> +		if (name[i] != sysctl_name[i])

bpf_strncmp() should be useful here.

> +			return 0;
> +
> +	return 1;
> +}
> +
> +SEC("cgroup/sysctl")
> +int test_value_overwrite(struct bpf_sysctl *ctx)
> +{
> +	if (!ctx->write)
> +		return 1;
> +
> +	if (!is_expected_name(ctx))
> +		return 0;
> +
> +	if (bpf_sysctl_set_new_value(ctx, sysctl_value, sizeof(sysctl_value)) == 0)
> +		return 1;
> +	return 0;
> +}
> +
> +char _license[] SEC("license") = "GPL";
> diff --git a/tools/testing/selftests/bpf/test_sysctl.c b/tools/testing/selftests/bpf/test_sysctl.c
> index bcdbd27f22f0..dfa479861d3a 100644
> --- a/tools/testing/selftests/bpf/test_sysctl.c
> +++ b/tools/testing/selftests/bpf/test_sysctl.c
> @@ -35,6 +35,7 @@ struct sysctl_test {
>   	int seek;
>   	const char *newval;
>   	const char *oldval;
> +	const char *updval;
>   	enum {
>   		LOAD_REJECT,
>   		ATTACH_REJECT,
> @@ -1395,6 +1396,16 @@ static struct sysctl_test tests[] = {
>   		.open_flags = O_RDONLY,
>   		.result = SUCCESS,
>   	},
> +	{
> +		"C prog: override write to ip_local_reserved_ports",
> +		.prog_file = "./test_sysctl_overwrite.bpf.o",

test_sysctl.c is not run in bpf CI. It is not very useful to extend this test 
further. Lets take this chance to create a new progs/cgrp_sysctl.c test that 
will be exercised by ./test_progs in bpf CI. Then it can use the newer skel 
open_and_load also.

Not asking to to migrate the existing tests in test_sysctl.c to the new 
progs/cgrp_sysctl.c in this patch set. The new cgrp_sysctl.c can only have the 
tests that exercise the changes in this patch set. However, it will be useful if 
progs/cgrp_sysctl.c can be bootstrapped in a way that the future test_sysctl.c 
migration will be easier. I also wouldn't worry too much on the existing raw 
insns tests in test_sysctl.c for now. They will need to be moved to either C or 
bpf asm in the future.

pw-bot: cr

> +		.attach_type = BPF_CGROUP_SYSCTL,
> +		.sysctl = "net/ipv4/ip_local_reserved_ports",
> +		.open_flags = O_RDWR,
> +		.newval = "11111",
> +		.updval = "31337",
> +		.result = SUCCESS,
> +	},
>   };
>   
>   static size_t probe_prog_length(const struct bpf_insn *fp)
> @@ -1520,13 +1531,33 @@ static int access_sysctl(const char *sysctl_path,
>   			log_err("Read value %s != %s", buf, test->oldval);
>   			goto err;
>   		}
> -	} else if (test->open_flags == O_WRONLY) {
> +	} else if (test->open_flags == O_WRONLY || test->open_flags == O_RDWR) {
>   		if (!test->newval) {
>   			log_err("New value for sysctl is not set");
>   			goto err;
>   		}
> -		if (write(fd, test->newval, strlen(test->newval)) == -1)
> +		if (write(fd, test->newval, strlen(test->newval)) == -1) {
> +			log_err("Unable to write sysctl value");
>   			goto err;
> +		}
> +		if (test->open_flags == O_RDWR) {
> +			char buf[128];
> +
> +			if (!test->updval) {
> +				log_err("Expected value for sysctl is not set");
> +				goto err;
> +			}
> +
> +			lseek(fd, 0, SEEK_SET);
> +			if (read(fd, buf, sizeof(buf)) == -1) {
> +				log_err("Unable to read updated value");
> +				goto err;
> +			}
> +			if (strncmp(buf, test->updval, strlen(test->updval))) {
> +				log_err("Overwritten value %s != %s", buf, test->updval);
> +				goto err;
> +			}
> +		}
>   	} else {
>   		log_err("Unexpected sysctl access: neither read nor write");
>   		goto err;


