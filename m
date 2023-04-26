Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 165BC6EFCB0
	for <lists+bpf@lfdr.de>; Wed, 26 Apr 2023 23:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239759AbjDZV5l (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Apr 2023 17:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233428AbjDZV5l (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Apr 2023 17:57:41 -0400
Received: from out-31.mta1.migadu.com (out-31.mta1.migadu.com [IPv6:2001:41d0:203:375::1f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656082120
        for <bpf@vger.kernel.org>; Wed, 26 Apr 2023 14:57:36 -0700 (PDT)
Message-ID: <54fb8365-751b-0775-02cd-e3ad0cba124b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1682546253;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MG139qFOYQhMSI/L8TKPpbMRkaH/1tNg2/084vWgMd0=;
        b=fxrsOtsO5145zIi5crPpOOc5QvWBgkrJG5D15Ex2M9KAnld/7MT79oVOwOv/8Jf5zKRqmA
        kiVaAJsD8ubeGfe7cbeY8HLAcNqmjYmaYsJWIrpX/VUOmmsc78pJJI7s0+ekzcBF2ZuY51
        HVIisvQmXrQfFGD3K107aHjbQKeHAV4=
Date:   Wed, 26 Apr 2023 14:57:31 -0700
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 09/10] selftests/bpf: Add tests for cgroup
 unix socket address hooks
Content-Language: en-US
To:     Daan De Meyer <daan.j.demeyer@gmail.com>
Cc:     kernel-team@meta.com, bpf@vger.kernel.org
References: <20230421162718.440230-1-daan.j.demeyer@gmail.com>
 <20230421162718.440230-10-daan.j.demeyer@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230421162718.440230-10-daan.j.demeyer@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 4/21/23 9:27 AM, Daan De Meyer wrote:
> The unix socket address hooks do not support modifying the source
> address so we skip source address checks when we're running a unix
> socket address hook test.
> 
> Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
> ---
>   tools/testing/selftests/bpf/bpf_kfuncs.h      |  13 ++
>   .../selftests/bpf/prog_tests/section_names.c  |  30 ++++
>   .../testing/selftests/bpf/progs/bindun_prog.c |  59 ++++++++
>   .../selftests/bpf/progs/connectun_prog.c      |  53 +++++++
>   .../selftests/bpf/progs/recvmsgun_prog.c      |  59 ++++++++
>   .../selftests/bpf/progs/sendmsgun_prog.c      |  53 +++++++
>   tools/testing/selftests/bpf/test_sock_addr.c  | 137 +++++++++++++++++-
>   7 files changed, 397 insertions(+), 7 deletions(-)
>   create mode 100644 tools/testing/selftests/bpf/progs/bindun_prog.c
>   create mode 100644 tools/testing/selftests/bpf/progs/connectun_prog.c
>   create mode 100644 tools/testing/selftests/bpf/progs/recvmsgun_prog.c
>   create mode 100644 tools/testing/selftests/bpf/progs/sendmsgun_prog.c
> 
> diff --git a/tools/testing/selftests/bpf/bpf_kfuncs.h b/tools/testing/selftests/bpf/bpf_kfuncs.h
> index 8c993ec8ceea..dbdec3d5152e 100644
> --- a/tools/testing/selftests/bpf/bpf_kfuncs.h
> +++ b/tools/testing/selftests/bpf/bpf_kfuncs.h
> @@ -1,6 +1,8 @@
>   #ifndef __BPF_KFUNCS__
>   #define __BPF_KFUNCS__
>   
> +struct bpf_sock_addr_kern;
> +
>   /* Description
>    *  Initializes an skb-type dynptr
>    * Returns
> @@ -35,4 +37,15 @@ extern void *bpf_dynptr_slice(const struct bpf_dynptr *ptr, __u32 offset,
>   extern void *bpf_dynptr_slice_rdwr(const struct bpf_dynptr *ptr, __u32 offset,
>   			      void *buffer, __u32 buffer__szk) __ksym;
>   
> +/* Description
> + *  Modify the contents of a sockaddr.
> + * Returns__bpf_kfunc
> + *  -EINVAL if the sockaddr family does not match, the sockaddr is too small or
> + *  too big, 0 if the sockaddr was successfully modified.
> + */
> +extern int bpf_sock_addr_set(struct bpf_sock_addr_kern *sa_kern,
> +			     const void *addr, __u32 addrlen__sz) __ksym;


It needs some negative tests, like
- addrlen__sz > UNIX_PATH_MAX for AF_UNIX test.
- addrlen__sz is larger than the size of addr in the stack.

> diff --git a/tools/testing/selftests/bpf/progs/bindun_prog.c b/tools/testing/selftests/bpf/progs/bindun_prog.c
> new file mode 100644
> index 000000000000..60addb5a9c96
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/bindun_prog.c
> @@ -0,0 +1,59 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
> +
> +#include "vmlinux.h"
> +
> +#include <string.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_core_read.h>
> +#include "bpf_kfuncs.h"
> +
> +#ifndef AF_UNIX
> +#define AF_UNIX 1

Move it to bpf_tracing_net.h. AF_INET[6] is already there.

> +#endif
> +
> +#define DST_REWRITE_PATH	"\0bpf_cgroup_unix_test_rewrite"
> +
> +void *bpf_cast_to_kern_ctx(void *) __ksym;
> +
> +SEC("cgroup/bindun")
> +int bind_un_prog(struct bpf_sock_addr *ctx)
> +{
> +	struct bpf_sock *sk = ctx->sk;
> +	struct bpf_sock_addr_kern *sa_kern = bpf_cast_to_kern_ctx(ctx);
> +	struct sockaddr_un *sa_kern_unaddr;
> +	struct sockaddr_un unaddr = {
> +		.sun_family = AF_UNIX,
> +	};
> +	__u32 unaddrlen = offsetof(struct sockaddr_un, sun_path) +
> +			  sizeof(DST_REWRITE_PATH) - 1;
> +	int ret;
> +
> +	if (!sk)
> +		return 0;
> +
> +	if (sk->family != AF_UNIX)
> +		return 0;
> +
> +	if (ctx->type != SOCK_STREAM && ctx->type != SOCK_DGRAM)
> +		return 0;
> +
> +	memcpy(unaddr.sun_path, DST_REWRITE_PATH, sizeof(DST_REWRITE_PATH) - 1);
> +
> +	ret = bpf_sock_addr_set(sa_kern, (struct sockaddr *) &unaddr, unaddrlen);
> +	if (ret)
> +		return 0;
> +
> +	if (sa_kern->uaddrlen != unaddrlen)
> +		return 0;
> +
> +	sa_kern_unaddr = bpf_rdonly_cast(sa_kern->uaddr,
> +					 bpf_core_type_id_kernel(struct sockaddr_un));
> +	if (memcmp(sa_kern_unaddr->sun_path, DST_REWRITE_PATH,
> +		   sizeof(DST_REWRITE_PATH) - 1) != 0)
> +		return 0;
> +
> +	return 1;
> +}
> +
> +char _license[] SEC("license") = "GPL";
> diff --git a/tools/testing/selftests/bpf/progs/connectun_prog.c b/tools/testing/selftests/bpf/progs/connectun_prog.c
> new file mode 100644
> index 000000000000..ac7209bd326f
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/connectun_prog.c
> @@ -0,0 +1,53 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
> +
> +#include "vmlinux.h"
> +
> +#include <string.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_core_read.h>
> +#include "bpf_kfuncs.h"
> +
> +#ifndef AF_UNIX
> +#define AF_UNIX 1
> +#endif
> +
> +#define DST_REWRITE_PATH	"\0bpf_cgroup_unix_test_rewrite"
> +
> +void *bpf_cast_to_kern_ctx(void *) __ksym;

Move it to bpf_kfuncs.h also?


