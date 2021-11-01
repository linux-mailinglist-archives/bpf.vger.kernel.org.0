Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31522441DA2
	for <lists+bpf@lfdr.de>; Mon,  1 Nov 2021 17:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232536AbhKAQDP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Nov 2021 12:03:15 -0400
Received: from www62.your-server.de ([213.133.104.62]:43922 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232619AbhKAQDO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Nov 2021 12:03:14 -0400
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1mhZjk-000G2R-1n; Mon, 01 Nov 2021 17:00:40 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1mhZjj-000X5q-T2; Mon, 01 Nov 2021 17:00:39 +0100
Subject: Re: [PATCH bpf-next 02/14] libbpf: add bpf() syscall wrapper into
 public API
To:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org
Cc:     kernel-team@fb.com, Hengqi Chen <hengqi.chen@gmail.com>
References: <20211030045941.3514948-1-andrii@kernel.org>
 <20211030045941.3514948-3-andrii@kernel.org>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <4e19e5e1-e722-5d49-c493-fda2efd3fea1@iogearbox.net>
Date:   Mon, 1 Nov 2021 17:00:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20211030045941.3514948-3-andrii@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.3/26340/Mon Nov  1 09:21:46 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/30/21 6:59 AM, Andrii Nakryiko wrote:
> Move internal sys_bpf() helper into bpf.h and expose as public API.
> __NR_bpf definition logic is also moved. Renamed sys_bpf() into bpf() to
> follow libbpf naming conventions. Adapt internal uses accordingly.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
[...]
>   
> +/*
> + * Kernel headers might be outdated, so define __NR_bpf explicitly, if necessary.
> + */
> +#ifndef __NR_bpf
> +# if defined(__i386__)
> +#  define __NR_bpf 357
> +# elif defined(__x86_64__)
> +#  define __NR_bpf 321
> +# elif defined(__aarch64__)
> +#  define __NR_bpf 280
> +# elif defined(__sparc__)
> +#  define __NR_bpf 349
> +# elif defined(__s390__)
> +#  define __NR_bpf 351
> +# elif defined(__arc__)
> +#  define __NR_bpf 280
> +# else
> +#  error __NR_bpf not defined. libbpf does not support your arch.
> +# endif
> +#endif

Do we still need this nowadays, presumably it's been long enough that system headers do
have __NR_bpf by now?

> +static inline long bpf(enum bpf_cmd cmd, union bpf_attr *attr, unsigned int size)
> +{
> +	return syscall(__NR_bpf, cmd, attr, size);
> +}
> +
>   struct bpf_create_map_attr {
>   	const char *name;
>   	enum bpf_map_type map_type;
> 

