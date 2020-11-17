Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44D6E2B71C5
	for <lists+bpf@lfdr.de>; Tue, 17 Nov 2020 23:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbgKQWlr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Nov 2020 17:41:47 -0500
Received: from www62.your-server.de ([213.133.104.62]:59538 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729139AbgKQWlr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Nov 2020 17:41:47 -0500
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1kf9fU-0006g3-P7; Tue, 17 Nov 2020 23:41:44 +0100
Received: from [85.7.101.30] (helo=pc-9.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1kf9fU-000UHR-JN; Tue, 17 Nov 2020 23:41:44 +0100
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Add bpf_lsm_set_bprm_opts helper
To:     KP Singh <kpsingh@chromium.org>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Pauline Middelink <middelin@google.com>
References: <20201117021307.1846300-1-kpsingh@chromium.org>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <cc03ab7e-dee8-f717-7a4f-413a3a5f58b7@iogearbox.net>
Date:   Tue, 17 Nov 2020 23:41:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20201117021307.1846300-1-kpsingh@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.4/25991/Tue Nov 17 14:12:35 2020)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/17/20 3:13 AM, KP Singh wrote:
> From: KP Singh <kpsingh@google.com>
> 
> The helper allows modification of certain bits on the linux_binprm
> struct starting with the secureexec bit which can be updated using the
> BPF_LSM_F_BPRM_SECUREEXEC flag.
> 
> secureexec can be set by the LSM for privilege gaining executions to set
> the AT_SECURE auxv for glibc.  When set, the dynamic linker disables the
> use of certain environment variables (like LD_PRELOAD).
> 
> Signed-off-by: KP Singh <kpsingh@google.com>
> ---
>   include/uapi/linux/bpf.h       | 18 ++++++++++++++++++
>   kernel/bpf/bpf_lsm.c           | 27 +++++++++++++++++++++++++++
>   scripts/bpf_helpers_doc.py     |  2 ++
>   tools/include/uapi/linux/bpf.h | 18 ++++++++++++++++++
>   4 files changed, 65 insertions(+)
> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 162999b12790..bfa79054d106 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -3787,6 +3787,18 @@ union bpf_attr {
>    *		*ARG_PTR_TO_BTF_ID* of type *task_struct*.
>    *	Return
>    *		Pointer to the current task.
> + *
> + * long bpf_lsm_set_bprm_opts(struct linux_binprm *bprm, u64 flags)
> + *

small nit: should have no extra newline (same for the tools/ copy)

> + *	Description
> + *		Set or clear certain options on *bprm*:
> + *
> + *		**BPF_LSM_F_BPRM_SECUREEXEC** Set the secureexec bit
> + *		which sets the **AT_SECURE** auxv for glibc. The bit
> + *		is cleared if the flag is not specified.
> + *	Return
> + *		**-EINVAL** if invalid *flags* are passed.
> + *
>    */
>   #define __BPF_FUNC_MAPPER(FN)		\
>   	FN(unspec),			\
> @@ -3948,6 +3960,7 @@ union bpf_attr {
>   	FN(task_storage_get),		\
>   	FN(task_storage_delete),	\
>   	FN(get_current_task_btf),	\
> +	FN(lsm_set_bprm_opts),		\
>   	/* */
>   
>   /* integer value in 'imm' field of BPF_CALL instruction selects which helper
> @@ -4119,6 +4132,11 @@ enum bpf_lwt_encap_mode {
>   	BPF_LWT_ENCAP_IP,
>   };
>   
> +/* Flags for LSM helpers */
> +enum {
> +	BPF_LSM_F_BPRM_SECUREEXEC	= (1ULL << 0),
> +};
> +
>   #define __bpf_md_ptr(type, name)	\
>   union {					\
>   	type name;			\
> diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> index 553107f4706a..cd85482228a0 100644
> --- a/kernel/bpf/bpf_lsm.c
> +++ b/kernel/bpf/bpf_lsm.c
> @@ -7,6 +7,7 @@
>   #include <linux/filter.h>
>   #include <linux/bpf.h>
>   #include <linux/btf.h>
> +#include <linux/binfmts.h>
>   #include <linux/lsm_hooks.h>
>   #include <linux/bpf_lsm.h>
>   #include <linux/kallsyms.h>
> @@ -51,6 +52,30 @@ int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
>   	return 0;
>   }
>   
> +/* Mask for all the currently supported BPRM option flags */
> +#define BPF_LSM_F_BRPM_OPTS_MASK	BPF_LSM_F_BPRM_SECUREEXEC
> +
> +BPF_CALL_2(bpf_lsm_set_bprm_opts, struct linux_binprm *, bprm, u64, flags)
> +{
> +

ditto

Would have fixed up these things on the fly while applying, but one small item
I wanted to bring up here given uapi which will then freeze: it would be cleaner
to call the helper just bpf_bprm_opts_set() or so given it's implied that we
attach to lsm here and we don't use _lsm in the naming for the others either.
Similarly, I'd drop the _LSM from the flag/mask.

> +	if (flags & ~BPF_LSM_F_BRPM_OPTS_MASK)
> +		return -EINVAL;
> +
> +	bprm->secureexec = (flags & BPF_LSM_F_BPRM_SECUREEXEC);
> +	return 0;
> +}
> +
> +BTF_ID_LIST_SINGLE(bpf_lsm_set_bprm_opts_btf_ids, struct, linux_binprm)
> +
> +const static struct bpf_func_proto bpf_lsm_set_bprm_opts_proto = {
> +	.func		= bpf_lsm_set_bprm_opts,
> +	.gpl_only	= false,
> +	.ret_type	= RET_INTEGER,
> +	.arg1_type	= ARG_PTR_TO_BTF_ID,
> +	.arg1_btf_id	= &bpf_lsm_set_bprm_opts_btf_ids[0],
> +	.arg2_type	= ARG_ANYTHING,
> +};
> +
>   static const struct bpf_func_proto *
>   bpf_lsm_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>   {
> @@ -71,6 +96,8 @@ bpf_lsm_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>   		return &bpf_task_storage_get_proto;
>   	case BPF_FUNC_task_storage_delete:
>   		return &bpf_task_storage_delete_proto;
> +	case BPF_FUNC_lsm_set_bprm_opts:
> +		return &bpf_lsm_set_bprm_opts_proto;
>   	default:
>   		return tracing_prog_func_proto(func_id, prog);
>   	}
