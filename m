Return-Path: <bpf+bounces-12285-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74DBB7CA849
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 14:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96D671C20A7E
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 12:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD2423740;
	Mon, 16 Oct 2023 12:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="Br/5tNnc"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF851CA84
	for <bpf@vger.kernel.org>; Mon, 16 Oct 2023 12:44:41 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22E4AB;
	Mon, 16 Oct 2023 05:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=WGfVF4rKa9tphXNg08WHl8fCUau1DVCHJsK8Oj5k5Cw=; b=Br/5tNncm5hsnxILANemk280ic
	hhv92KfIORb5qhhSP9UZ2OUibfaUYN0M8nr61NDGPRNSZD2JubYfdE0FTxOT4lLLSv5wurry11es7
	sugANMtNpmIY6kLOKvCzk+IrhpWPxEHF3WXGWC1vHYMjmw1iFo+XANzMcAB0q45mLCWRYVymGaJhP
	97zt8xx+4GTlFCAJJmYcdJal54UpPxP6xJh0uREer6D/rzme7yBc9HdAIbeIowoy+Jd4se5xkvh2e
	mO2nddN5dhrDIKuN7KpbxSIRH/+TJwf6Qz2f4dAgZtpIIM9US5xsXPQnQpr/Atj0aNdYsQcjLT/RW
	7oN4ehHA==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qsMxW-000EUb-RD; Mon, 16 Oct 2023 14:44:34 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qsMxW-0003Y3-FW; Mon, 16 Oct 2023 14:44:34 +0200
Subject: Re: [PATCH v2 2/5] seccomp, bpf: Introduce SECCOMP_LOAD_FILTER
 operation
To: Hengqi Chen <hengqi.chen@gmail.com>, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Cc: keescook@chromium.org, ast@kernel.org, andrii@kernel.org,
 luto@amacapital.net, wad@chromium.org, alexyonghe@tencent.com
References: <20231015232953.84836-1-hengqi.chen@gmail.com>
 <20231015232953.84836-3-hengqi.chen@gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <0df30939-1ba1-5703-58cc-54058fbb1df5@iogearbox.net>
Date: Mon, 16 Oct 2023 14:44:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231015232953.84836-3-hengqi.chen@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27063/Mon Oct 16 10:02:17 2023)
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/16/23 1:29 AM, Hengqi Chen wrote:
> This patch adds a new operation named SECCOMP_LOAD_FILTER.
> It accepts a sock_fprog the same as SECCOMP_SET_MODE_FILTER
> but only performs the loading process. If succeed, return a
> new fd associated with the JITed BPF program (the filter).
> The filter can then be pinned to bpffs using the returned
> fd and reused for different processes. To distinguish the
> filter from other BPF progs, BPF_PROG_TYPE_SECCOMP is added.
> 
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> ---
>   include/uapi/linux/bpf.h       |  1 +
>   include/uapi/linux/seccomp.h   |  1 +
>   kernel/seccomp.c               | 43 ++++++++++++++++++++++++++++++++++
>   tools/include/uapi/linux/bpf.h |  1 +
>   4 files changed, 46 insertions(+)
> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 7ba61b75bc0e..61c80ffb1724 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -995,6 +995,7 @@ enum bpf_prog_type {
>   	BPF_PROG_TYPE_SK_LOOKUP,
>   	BPF_PROG_TYPE_SYSCALL, /* a program that can execute syscalls */
>   	BPF_PROG_TYPE_NETFILTER,
> +	BPF_PROG_TYPE_SECCOMP,

Please don't extend UAPI surface if this is not reachable/usable from user
space anyway.

>   enum bpf_attach_type {
> diff --git a/include/uapi/linux/seccomp.h b/include/uapi/linux/seccomp.h
> index dbfc9b37fcae..ee2c83697810 100644
> --- a/include/uapi/linux/seccomp.h
> +++ b/include/uapi/linux/seccomp.h
> @@ -16,6 +16,7 @@
>   #define SECCOMP_SET_MODE_FILTER		1
>   #define SECCOMP_GET_ACTION_AVAIL	2
>   #define SECCOMP_GET_NOTIF_SIZES		3
> +#define SECCOMP_LOAD_FILTER		4
>   
>   /* Valid flags for SECCOMP_SET_MODE_FILTER */
>   #define SECCOMP_FILTER_FLAG_TSYNC		(1UL << 0)
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index faf84fc892eb..c9f6a19f7a4e 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -17,6 +17,7 @@
>   
>   #include <linux/refcount.h>
>   #include <linux/audit.h>
> +#include <linux/bpf.h>
>   #include <linux/compat.h>
>   #include <linux/coredump.h>
>   #include <linux/kmemleak.h>
> @@ -25,6 +26,7 @@
>   #include <linux/sched.h>
>   #include <linux/sched/task_stack.h>
>   #include <linux/seccomp.h>
> +#include <linux/security.h>
>   #include <linux/slab.h>
>   #include <linux/syscalls.h>
>   #include <linux/sysctl.h>
> @@ -2032,12 +2034,48 @@ static long seccomp_set_mode_filter(unsigned int flags,
>   	seccomp_filter_free(prepared);
>   	return ret;
>   }
> +
> +static long seccomp_load_filter(const char __user *filter)
> +{
> +	struct sock_fprog fprog;
> +	struct bpf_prog *prog;
> +	int ret;
> +
> +	ret = seccomp_copy_user_filter(filter, &fprog);
> +	if (ret)
> +		return ret;
> +
> +	ret = seccomp_prepare_prog(&prog, &fprog);
> +	if (ret)
> +		return ret;
> +
> +	ret = security_bpf_prog_alloc(prog->aux);
> +	if (ret) {
> +		bpf_prog_free(prog);
> +		return ret;
> +	}
> +
> +	prog->aux->user = get_current_user();
> +	atomic64_set(&prog->aux->refcnt, 1);
> +	prog->type = BPF_PROG_TYPE_SECCOMP;
> +
> +	ret = bpf_prog_new_fd(prog);
> +	if (ret < 0)
> +		bpf_prog_put(prog);

My bigger concern here is that bpf_prog_new_fd() is only used by eBPF (not cBPF).

Then you get an 'eBPF'-like fd back to user space which you can pass to various
other bpf(2) commands like BPF_OBJ_GET_INFO_BY_FD etc which all have the assumption
that this is a proper looking eBPF prog fd.

There may be breakage/undefined behavior in subtle ways.

I would suggest two potential alternatives :

1) Build a seccomp-specific fd via anon_inode_getfd() so that BPF side does not
    confuse it with bpf_prog_fops and therefore does not recognize it in bpf(2)
    as a prog fd.

2) Extend seccomp where proper eBPF could be supported.

If option 2) is not realistic (where you would get this out of the box), then I
think 1) could be however.

> +	return ret;
> +}
>   #else
>   static inline long seccomp_set_mode_filter(unsigned int flags,
>   					   const char __user *filter)
>   {
>   	return -EINVAL;
>   }
> +
> +static inline long seccomp_load_filter(const char __user *filter)
> +{
> +	return -EINVAL;
> +}
>   #endif
>   
>   static long seccomp_get_action_avail(const char __user *uaction)
> @@ -2099,6 +2137,11 @@ static long do_seccomp(unsigned int op, unsigned int flags,
>   			return -EINVAL;
>   
>   		return seccomp_get_notif_sizes(uargs);
> +	case SECCOMP_LOAD_FILTER:
> +		if (flags != 0)
> +			return -EINVAL;
> +
> +		return seccomp_load_filter(uargs);
>   	default:
>   		return -EINVAL;
>   	}
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index 7ba61b75bc0e..61c80ffb1724 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -995,6 +995,7 @@ enum bpf_prog_type {
>   	BPF_PROG_TYPE_SK_LOOKUP,
>   	BPF_PROG_TYPE_SYSCALL, /* a program that can execute syscalls */
>   	BPF_PROG_TYPE_NETFILTER,
> +	BPF_PROG_TYPE_SECCOMP,
>   };
>   
>   enum bpf_attach_type {
> 


