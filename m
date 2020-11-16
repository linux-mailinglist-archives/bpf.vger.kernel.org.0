Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC5E82B48D9
	for <lists+bpf@lfdr.de>; Mon, 16 Nov 2020 16:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728836AbgKPPLy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Nov 2020 10:11:54 -0500
Received: from www62.your-server.de ([213.133.104.62]:40190 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728029AbgKPPLx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Nov 2020 10:11:53 -0500
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1kegAY-0000q5-Nk; Mon, 16 Nov 2020 16:11:50 +0100
Received: from [85.7.101.30] (helo=pc-9.home)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1kegAY-000Sto-Eo; Mon, 16 Nov 2020 16:11:50 +0100
Subject: Re: [PATCH bpf-next 1/2] bpf: Add bpf_lsm_set_bprm_opts helper
To:     KP Singh <kpsingh@chromium.org>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Paul Turner <pjt@google.com>,
        Pauline Middelink <middelin@google.com>
References: <20201116140110.1412642-1-kpsingh@chromium.org>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <793acf23-b263-6ae5-2206-18fcdfa991eb@iogearbox.net>
Date:   Mon, 16 Nov 2020 16:11:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20201116140110.1412642-1-kpsingh@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.4/25990/Mon Nov 16 14:19:13 2020)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/16/20 3:01 PM, KP Singh wrote:
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
[...]
>   /* integer value in 'imm' field of BPF_CALL instruction selects which helper
> @@ -4119,6 +4128,11 @@ enum bpf_lwt_encap_mode {
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
> index 553107f4706a..4d04fc490a14 100644
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
> @@ -51,6 +52,23 @@ int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
>   	return 0;
>   }
>   
> +BPF_CALL_2(bpf_lsm_set_bprm_opts, struct linux_binprm *, bprm, u64, flags)
> +{

This should also reject invalid flags. I'd rather change this helper from RET_VOID
to RET_INTEGER and throw -EINVAL for everything other than BPF_LSM_F_BPRM_SECUREEXEC
passed in here including zero so it can be extended in future.

> +	bprm->secureexec = (flags & BPF_LSM_F_BPRM_SECUREEXEC);
> +	return 0;
> +}
> +
> +BTF_ID_LIST_SINGLE(bpf_lsm_set_bprm_opts_btf_ids, struct, linux_binprm)
> +
> +const static struct bpf_func_proto bpf_lsm_set_bprm_opts_proto = {
> +	.func		= bpf_lsm_set_bprm_opts,
> +	.gpl_only	= false,
> +	.ret_type	= RET_VOID,
> +	.arg1_type	= ARG_PTR_TO_BTF_ID,
> +	.arg1_btf_id	= &bpf_lsm_set_bprm_opts_btf_ids[0],
> +	.arg2_type	= ARG_ANYTHING,
> +};
> +
