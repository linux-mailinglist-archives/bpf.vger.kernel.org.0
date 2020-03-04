Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0A37179810
	for <lists+bpf@lfdr.de>; Wed,  4 Mar 2020 19:38:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730249AbgCDShx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Mar 2020 13:37:53 -0500
Received: from www62.your-server.de ([213.133.104.62]:57978 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729703AbgCDShx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Mar 2020 13:37:53 -0500
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1j9Yty-0006bb-7P; Wed, 04 Mar 2020 19:37:50 +0100
Received: from [2001:1620:665:0:5795:5b0a:e5d5:5944] (helo=linux.fritz.box)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1j9Ytx-000VDw-RH; Wed, 04 Mar 2020 19:37:49 +0100
Subject: Re: [PATCH bpf-next v3 1/7] bpf: Refactor trampoline update code
To:     KP Singh <kpsingh@chromium.org>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
References: <20200304154747.23506-1-kpsingh@chromium.org>
 <20200304154747.23506-2-kpsingh@chromium.org>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <cb54c137-6d8e-b4e5-bd17-e0a05368c3eb@iogearbox.net>
Date:   Wed, 4 Mar 2020 19:37:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200304154747.23506-2-kpsingh@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.2/25741/Wed Mar  4 15:15:26 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/4/20 4:47 PM, KP Singh wrote:
> From: KP Singh <kpsingh@google.com>
> 
> As we need to introduce a third type of attachment for trampolines, the
> flattened signature of arch_prepare_bpf_trampoline gets even more
> complicated.
> 
> Refactor the prog and count argument to arch_prepare_bpf_trampoline to
> use bpf_tramp_progs to simplify the addition and accounting for new
> attachment types.
> 
> Signed-off-by: KP Singh <kpsingh@google.com>
> Acked-by: Andrii Nakryiko <andriin@fb.com>

[...]
> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> index c498f0fffb40..9f7e0328a644 100644
> --- a/kernel/bpf/bpf_struct_ops.c
> +++ b/kernel/bpf/bpf_struct_ops.c
> @@ -320,6 +320,7 @@ static int bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
>   	struct bpf_struct_ops_value *uvalue, *kvalue;
>   	const struct btf_member *member;
>   	const struct btf_type *t = st_ops->type;
> +	struct bpf_tramp_progs *tprogs = NULL;
>   	void *udata, *kdata;
>   	int prog_fd, err = 0;
>   	void *image;
> @@ -425,10 +426,18 @@ static int bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
>   			goto reset_unlock;
>   		}
>   
> +		tprogs = kcalloc(BPF_TRAMP_MAX, sizeof(*tprogs), GFP_KERNEL);
> +		if (!tprogs) {
> +			err = -ENOMEM;
> +			goto reset_unlock;
> +		}
> +

Looking over the code again, I'm quite certain that here's a memleak
since the kcalloc() is done in the for_each_member() loop in the ops
update but then going out of scope and in the exit path we only kfree
the last tprogs.

> +		tprogs[BPF_TRAMP_FENTRY].progs[0] = prog;
> +		tprogs[BPF_TRAMP_FENTRY].nr_progs = 1;
>   		err = arch_prepare_bpf_trampoline(image,
>   						  st_map->image + PAGE_SIZE,
>   						  &st_ops->func_models[i], 0,
> -						  &prog, 1, NULL, 0, NULL);
> +						  tprogs, NULL);
>   		if (err < 0)
>   			goto reset_unlock;
>   
> @@ -469,6 +478,7 @@ static int bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
>   	memset(uvalue, 0, map->value_size);
>   	memset(kvalue, 0, map->value_size);
>   unlock:
> +	kfree(tprogs);
>   	mutex_unlock(&st_map->lock);
>   	return err;
>   }
