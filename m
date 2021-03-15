Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02C5E33C9E9
	for <lists+bpf@lfdr.de>; Tue, 16 Mar 2021 00:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbhCOXd6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Mar 2021 19:33:58 -0400
Received: from www62.your-server.de ([213.133.104.62]:52342 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbhCOXdv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Mar 2021 19:33:51 -0400
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1lLwib-0001k3-IW; Tue, 16 Mar 2021 00:33:49 +0100
Received: from [85.7.101.30] (helo=pc-9.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1lLwib-000AY0-EW; Tue, 16 Mar 2021 00:33:49 +0100
Subject: Re: [PATCH bpf-next] bpf: net: emit anonymous enum with BPF_TCP_CLOSE
 value explicitly
To:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>, kernel-team@fb.com
References: <20210314035812.1958641-1-yhs@fb.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <2b98276d-62d4-721d-a956-80ed1d71987a@iogearbox.net>
Date:   Tue, 16 Mar 2021 00:33:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20210314035812.1958641-1-yhs@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.4/26109/Mon Mar 15 12:06:12 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/14/21 4:58 AM, Yonghong Song wrote:
[...]
> This patch explicited add an expression like
>    (void)BPF_TCP_ESTABLISHED
> to enable generation of debuginfo for the anonymous
> enum which also includes BPF_TCP_CLOSE. I put
> this explicit type generation in kernel/bpf/core.c
> to (1) avoid polute net/ipv4/tcp.c and more importantly
> (2) provide a central place to add other types (e.g. in
> bpf/btf uapi header) if they are not referenced in the kernel
> or generated in vmlinux dwarf.
> 
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>   include/linux/btf.h |  1 +
>   kernel/bpf/core.c   | 19 +++++++++++++++++++
>   2 files changed, 20 insertions(+)
> 
> diff --git a/include/linux/btf.h b/include/linux/btf.h
> index 7fabf1428093..9c1b52738bbe 100644
> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h
> @@ -9,6 +9,7 @@
>   #include <uapi/linux/bpf.h>
>   
>   #define BTF_TYPE_EMIT(type) ((void)(type *)0)
> +#define BTF_TYPE_EMIT_ENUM(enum_val) ((void)enum_val)
>   
>   struct btf;
>   struct btf_member;
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 3a283bf97f2f..60551bf68ece 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -2378,3 +2378,22 @@ EXPORT_SYMBOL(bpf_stats_enabled_key);
>   
>   EXPORT_TRACEPOINT_SYMBOL_GPL(xdp_exception);
>   EXPORT_TRACEPOINT_SYMBOL_GPL(xdp_bulk_tx);
> +
> +static int __init bpf_emit_btf_type(void)
> +{
> +	/* bpf uapi header bpf.h defines an anonymous enum with values
> +	 * BPF_TCP_* used by bpf programs. Currently gcc built vmlinux
> +	 * is able to emit this enum in dwarf due to the following
> +	 * BUILD_BUG_ON test in net/ipv4/tcp.c:
> +	 *   BUILD_BUG_ON((int)BPF_TCP_ESTABLISHED != (int)TCP_ESTABLISHED);
> +	 * clang built vmlinux does not have this enum in dwarf
> +	 * since clang removes the above code before generating IR/debuginfo.
> +	 * Let us explicitly emit the type debuginfo to ensure the
> +	 * above-mentioned anonymous enum in the vmlinux dwarf and hence BTF
> +	 * regardless of which compiler is used.
> +	 */
> +	BTF_TYPE_EMIT_ENUM(BPF_TCP_ESTABLISHED);
> +
> +	return 0;
> +}
> +late_initcall(bpf_emit_btf_type);

Does this have to be late_initcall() given this adds minor init call
overhead, what if this would be exported as symbol for modules instead?

Thanks,
Daniel
