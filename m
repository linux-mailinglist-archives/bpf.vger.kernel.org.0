Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 571355A569F
	for <lists+bpf@lfdr.de>; Tue, 30 Aug 2022 00:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbiH2WCL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Aug 2022 18:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiH2WCK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Aug 2022 18:02:10 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7688F6D9C9
        for <bpf@vger.kernel.org>; Mon, 29 Aug 2022 15:02:08 -0700 (PDT)
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1oSmpW-000AfE-Ha; Tue, 30 Aug 2022 00:02:02 +0200
Received: from [85.1.206.226] (helo=linux-4.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1oSmpW-000GRY-7Z; Tue, 30 Aug 2022 00:02:02 +0200
Subject: Re: [PATCH v4 bpf-next 15/15] bpf: Introduce sysctl
 kernel.bpf_force_dyn_alloc.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        davem@davemloft.net
Cc:     andrii@kernel.org, tj@kernel.org, memxor@gmail.com, delyank@fb.com,
        linux-mm@kvack.org, bpf@vger.kernel.org, kernel-team@fb.com
References: <20220826024430.84565-1-alexei.starovoitov@gmail.com>
 <20220826024430.84565-16-alexei.starovoitov@gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <f0e3e3ab-99b7-4d87-4b5a-b71ca7724310@iogearbox.net>
Date:   Tue, 30 Aug 2022 00:02:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20220826024430.84565-16-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.6/26642/Mon Aug 29 09:54:26 2022)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 8/26/22 4:44 AM, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Introduce sysctl kernel.bpf_force_dyn_alloc to force dynamic allocation in bpf
> hash map. All selftests/bpf should pass with bpf_force_dyn_alloc 0 or 1 and all
> bpf programs (both sleepable and not) should not see any functional difference.
> The sysctl's observable behavior should only be improved memory usage.
> 
> Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>   include/linux/filter.h | 2 ++
>   kernel/bpf/core.c      | 2 ++
>   kernel/bpf/hashtab.c   | 5 +++++
>   kernel/bpf/syscall.c   | 9 +++++++++
>   4 files changed, 18 insertions(+)
> 
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index a5f21dc3c432..eb4d4a0c0bde 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -1009,6 +1009,8 @@ bpf_run_sk_reuseport(struct sock_reuseport *reuse, struct sock *sk,
>   }
>   #endif
>   
> +extern int bpf_force_dyn_alloc;
> +
>   #ifdef CONFIG_BPF_JIT
>   extern int bpf_jit_enable;
>   extern int bpf_jit_harden;
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 639437f36928..a13e78ea4b90 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -533,6 +533,8 @@ void bpf_prog_kallsyms_del_all(struct bpf_prog *fp)
>   	bpf_prog_kallsyms_del(fp);
>   }
>   
> +int bpf_force_dyn_alloc __read_mostly;
> +
>   #ifdef CONFIG_BPF_JIT
>   /* All BPF JIT sysctl knobs here. */
>   int bpf_jit_enable   __read_mostly = IS_BUILTIN(CONFIG_BPF_JIT_DEFAULT_ON);
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 89f26cbddef5..f68a3400939e 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -505,6 +505,11 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
>   
>   	bpf_map_init_from_attr(&htab->map, attr);
>   
> +	if (!lru && bpf_force_dyn_alloc) {
> +		prealloc = false;
> +		htab->map.map_flags |= BPF_F_NO_PREALLOC;
> +	}
> +

The rationale is essentially for testing, right? Would be nice to avoid
making this patch uapi. It will just confuse users with implementation
details, imho, and then it's hard to remove it again.

>   	if (percpu_lru) {
>   		/* ensure each CPU's lru list has >=1 elements.
>   		 * since we are at it, make each lru list has the same
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 074c901fbb4e..5c631244b63b 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -5299,6 +5299,15 @@ static struct ctl_table bpf_syscall_table[] = {
>   		.mode		= 0644,
>   		.proc_handler	= bpf_stats_handler,
>   	},
> +	{
> +		.procname	= "bpf_force_dyn_alloc",
> +		.data		= &bpf_force_dyn_alloc,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0600,
> +		.proc_handler	= proc_dointvec_minmax,
> +		.extra1		= SYSCTL_ZERO,
> +		.extra2		= SYSCTL_ONE,
> +	},
>   	{ }
>   };
>   
> 

