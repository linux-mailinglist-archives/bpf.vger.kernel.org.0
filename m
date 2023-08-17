Return-Path: <bpf+bounces-7954-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6918C77EF98
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 05:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D7D81C212B2
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 03:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3247B7FD;
	Thu, 17 Aug 2023 03:38:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF21638
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 03:38:50 +0000 (UTC)
Received: from out-5.mta0.migadu.com (out-5.mta0.migadu.com [IPv6:2001:41d0:1004:224b::5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C76E268D
	for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 20:38:49 -0700 (PDT)
Message-ID: <2d530dec-e6c2-5e3a-ccf2-d65039a9969d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1692243527; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4m46oeFWulkljhnMK2IlsZAL/z+HepLc7sY/jkFgntU=;
	b=pCB1K6WuwIyrwKQoCLmnEYzNWwQJDfkEF5N6rjtdW9GjwQlrbgeXfXXL0vmmvAAqajy/E+
	6L0oqY8uFkPq8PuPawfWoKXdJNbO1yAl8pl47tnHOl0W5OvHVS/M5rrKCHemOS13j5GYWK
	Z+kLKaPWetUQk5ZWQjCa69d84yAX7uY=
Date: Wed, 16 Aug 2023 20:38:40 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next] bpf: Disable -Wmissing-declarations for
 globally-linked kfuncs
Content-Language: en-US
To: David Vernet <void@manifault.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com,
 kernel test robot <lkp@intel.com>
References: <20230816150634.1162838-1-void@manifault.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20230816150634.1162838-1-void@manifault.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/16/23 8:06 AM, David Vernet wrote:
> We recently got an lkp warning about missing declarations, as in e.g.
> [0]. This warning is largely redundant with -Wmissing-prototypes, which
> we already disable for kfuncs that have global linkage and are meant to
> be exported in BTF, and called from BPF programs. Let's also disable
> -Wmissing-declarations for kfuncs. For what it's worth, I wasn't able to
> reproduce the warning even on W <= 3, so I can't actually be 100% sure
> this fixes the issue.
> 
> [0]: https://lore.kernel.org/all/202308162115.Hn23vv3n-lkp@intel.com/

Okay, I just got a similar email to [0] which complains
   bpf_obj_new_impl, ..., bpf_cast_to_kern_ctx
missing declarations.

In the email, the used compiler is
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0

Unfortunately, I did not have gcc-7 to verify this.
Also, what is the minimum gcc version kernel supports? 5.1?

> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202308162115.Hn23vv3n-lkp@intel.com/
> Signed-off-by: David Vernet <void@manifault.com>
> ---
>   Documentation/bpf/kfuncs.rst                          | 4 +++-
>   kernel/bpf/bpf_iter.c                                 | 2 ++
>   kernel/bpf/cpumask.c                                  | 2 ++
>   kernel/bpf/helpers.c                                  | 2 ++
>   kernel/bpf/map_iter.c                                 | 2 ++
>   kernel/cgroup/rstat.c                                 | 2 ++
>   kernel/trace/bpf_trace.c                              | 2 ++
>   net/bpf/test_run.c                                    | 2 ++
>   net/core/filter.c                                     | 4 ++++
>   net/core/xdp.c                                        | 2 ++
>   net/ipv4/fou_bpf.c                                    | 2 ++
>   net/netfilter/nf_conntrack_bpf.c                      | 2 ++
>   net/netfilter/nf_nat_bpf.c                            | 2 ++
>   net/xfrm/xfrm_interface_bpf.c                         | 2 ++
>   tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c | 2 ++
>   15 files changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
> index 0d2647fb358d..62ce5a7b92b4 100644
> --- a/Documentation/bpf/kfuncs.rst
> +++ b/Documentation/bpf/kfuncs.rst
> @@ -36,10 +36,12 @@ prototype in a header for the wrapper kfunc.
>   
>   An example is given below::
>   
> -        /* Disables missing prototype warnings */
> +        /* Disables missing prototypes and declarations warnings */
>           __diag_push();
>           __diag_ignore_all("-Wmissing-prototypes",
>                             "Global kfuncs as their definitions will be in BTF");
> +        __diag_ignore_all("-Wmissing-declarations",
> +                          "Global kfuncs as their definitions will be in BTF");
>   
>           __bpf_kfunc struct task_struct *bpf_find_get_task_by_vpid(pid_t nr)
>           {
> diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
> index 96856f130cbf..b8def6e4e5e8 100644
> --- a/kernel/bpf/bpf_iter.c
> +++ b/kernel/bpf/bpf_iter.c
> @@ -785,6 +785,8 @@ struct bpf_iter_num_kern {
>   __diag_push();
>   __diag_ignore_all("-Wmissing-prototypes",
>   		  "Global functions as their definitions will be in vmlinux BTF");
> +__diag_ignore_all("-Wmissing-declarations",
> +		  "Global functions as their definitions will be in vmlinux BTF");
>   
>   __bpf_kfunc int bpf_iter_num_new(struct bpf_iter_num *it, int start, int end)
>   {
[...]

