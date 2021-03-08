Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC8F330EDF
	for <lists+bpf@lfdr.de>; Mon,  8 Mar 2021 14:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbhCHNHs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Mar 2021 08:07:48 -0500
Received: from www62.your-server.de ([213.133.104.62]:58966 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbhCHNHg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Mar 2021 08:07:36 -0500
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1lJFbf-0005yC-6i; Mon, 08 Mar 2021 14:07:31 +0100
Received: from [85.7.101.30] (helo=pc-9.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1lJFbf-000V0j-0q; Mon, 08 Mar 2021 14:07:31 +0100
Subject: Re: [PATCH bpf] bpf: Dont allow vmlinux BTF to be used in map_create
 and prog_load.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        davem@davemloft.net
Cc:     andrii@kernel.org, kafai@fb.com, bpf@vger.kernel.org,
        kernel-team@fb.com
References: <20210307225248.79031-1-alexei.starovoitov@gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <51365de1-e52b-f3fc-8f7d-537deb3d88ba@iogearbox.net>
Date:   Mon, 8 Mar 2021 14:07:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20210307225248.79031-1-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.4/26102/Mon Mar  8 13:03:13 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/7/21 11:52 PM, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> The syzbot got FD of vmlinux BTF and passed it into map_create which caused
> crash in btf_type_id_size() when it tried to access resolved_ids. The vmlinux
> BTF doesn't have 'resolved_ids' and 'resolved_sizes' initialized to save
> memory. To avoid such issues disallow using vmlinux BTF in prog_load and
> map_create commands.
> 
> Reported-by: syzbot+8bab8ed346746e7540e8@syzkaller.appspotmail.com
> Fixes: 5329722057d4 ("bpf: Assign ID to vmlinux BTF and return extra info for BTF in GET_OBJ_INFO")
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>   kernel/bpf/syscall.c  | 5 +++++
>   kernel/bpf/verifier.c | 4 ++++
>   2 files changed, 9 insertions(+)
> 
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index c859bc46d06c..250503482cda 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -854,6 +854,11 @@ static int map_create(union bpf_attr *attr)
>   			err = PTR_ERR(btf);
>   			goto free_map;
>   		}
> +		if (btf_is_kernel(btf)) {
> +			btf_put(btf);
> +			err = -EACCES;
> +			goto free_map;
> +		}
>   		map->btf = btf;
>   
>   		if (attr->btf_value_type_id) {
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index c56e3fcb5f1a..4192a9e56654 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -9056,6 +9056,10 @@ static int check_btf_info(struct bpf_verifier_env *env,
>   	btf = btf_get_by_fd(attr->prog_btf_fd);
>   	if (IS_ERR(btf))
>   		return PTR_ERR(btf);
> +	if (btf_is_kernel(btf)) {
> +		btf_put(btf);
> +		return -EACCES;
> +	}

Looks good, applied!

>   	env->prog->aux->btf = btf;
>   
>   	err = check_btf_func(env, attr, uattr);

Btw, the error handling convention of c454a46b5efd ("bpf: Add bpf_line_info support")
is just highly confusing. Simple validation errors defer the BTF reference count drop
to __bpf_prog_put_noref() instead of just having it drop inside check_btf_info() as
you did and only assigning env->prog->aux->btf in actual success case.
