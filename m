Return-Path: <bpf+bounces-14302-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3F87E2BE2
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 19:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78C0C2817BD
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 18:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5F62D025;
	Mon,  6 Nov 2023 18:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fwDd+vdT"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647FB2C86B
	for <bpf@vger.kernel.org>; Mon,  6 Nov 2023 18:26:27 +0000 (UTC)
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [IPv6:2001:41d0:203:375::ba])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61D710C3
	for <bpf@vger.kernel.org>; Mon,  6 Nov 2023 10:26:24 -0800 (PST)
Message-ID: <b7f188bd-d131-4e52-a5fd-edbc58a3c529@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1699295182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aWJ9kfNF0nHB2pt+jswuTZSbsK6VOKrY/q9X4PjA/4U=;
	b=fwDd+vdTiw7tnZGbrgkFLahW0fjPoMUbgIMiYY/ITy7RKj3G5rS/rxMLpLXe/6M1byWbd3
	Me+pdbAFe6jsbwquu+NSnHWDCjc4DlsS1J/qCoJT6emWV8wRY30RamwGVoNKRfyFndHD52
	j09KioGWKiNP+MZZ7K7nymXSWjVTa+U=
Date: Mon, 6 Nov 2023 10:26:14 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf 1/2] bpf: Let verifier consider {task,cgroup} is
 trusted in bpf_iter_reg
Content-Language: en-GB
To: Chuyi Zhou <zhouchuyi@bytedance.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@kernel.org
References: <20231105133458.1315620-1-zhouchuyi@bytedance.com>
 <20231105133458.1315620-2-zhouchuyi@bytedance.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20231105133458.1315620-2-zhouchuyi@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 11/5/23 5:34 AM, Chuyi Zhou wrote:
> BTF_TYPE_SAFE_TRUSTED(struct bpf_iter__task) in verifier.c wanted to
> teach BPF verifier that bpf_iter__task -> task is a trusted ptr. But it
> doesn't work well.
>
> The reason is, bpf_iter__task -> task would go through btf_ctx_access()
> which enforces the reg_type of 'task' is ctx_arg_info->reg_type, and in
> task_iter.c, we actually explicitly declare that the
> ctx_arg_info->reg_type is PTR_TO_BTF_ID_OR_NULL.
>
> This patch sets ctx_arg_info->reg_type is PTR_TO_BTF_ID_OR_NULL |
> PTR_TRUSTED in task_reg_info.

Actually we have a previous case like this. See

  https://lore.kernel.org/all/20230706133932.45883-3-aspsk@isovalent.com/

where PTR_TRUSTED is added to the arg flag for map_iter.

You could mention this case in your commit message.

>
> Similarly, bpf_cgroup_reg_info -> cgroup is also PTR_TRUSTED since we are
> under the protection of cgroup_mutex and we would check cgroup_is_dead()
> in __cgroup_iter_seq_show().
>
> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>

> ---
>   kernel/bpf/cgroup_iter.c | 2 +-
>   kernel/bpf/task_iter.c   | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/cgroup_iter.c b/kernel/bpf/cgroup_iter.c
> index d1b5c5618..f04a468cf 100644
> --- a/kernel/bpf/cgroup_iter.c
> +++ b/kernel/bpf/cgroup_iter.c
> @@ -282,7 +282,7 @@ static struct bpf_iter_reg bpf_cgroup_reg_info = {
>   	.ctx_arg_info_size	= 1,
>   	.ctx_arg_info		= {
>   		{ offsetof(struct bpf_iter__cgroup, cgroup),
> -		  PTR_TO_BTF_ID_OR_NULL },
> +		  PTR_TO_BTF_ID_OR_NULL | PTR_TRUSTED },
>   	},
>   	.seq_info		= &cgroup_iter_seq_info,
>   };
> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> index 4e156dca4..26082b978 100644
> --- a/kernel/bpf/task_iter.c
> +++ b/kernel/bpf/task_iter.c
> @@ -704,7 +704,7 @@ static struct bpf_iter_reg task_reg_info = {
>   	.ctx_arg_info_size	= 1,
>   	.ctx_arg_info		= {
>   		{ offsetof(struct bpf_iter__task, task),
> -		  PTR_TO_BTF_ID_OR_NULL },
> +		  PTR_TO_BTF_ID_OR_NULL | PTR_TRUSTED },
>   	},
>   	.seq_info		= &task_seq_info,
>   	.fill_link_info		= bpf_iter_fill_link_info,

