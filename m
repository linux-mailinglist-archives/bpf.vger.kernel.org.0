Return-Path: <bpf+bounces-10828-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6E47AE2E6
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 02:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 6F3E9B20804
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 00:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9097373;
	Tue, 26 Sep 2023 00:24:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33A2366
	for <bpf@vger.kernel.org>; Tue, 26 Sep 2023 00:24:49 +0000 (UTC)
Received: from out-206.mta1.migadu.com (out-206.mta1.migadu.com [95.215.58.206])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9D510A
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 17:24:47 -0700 (PDT)
Message-ID: <fc8405d5-7e8c-5adf-2e66-edd3527d1db6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1695687885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HvjukWK/F4hbUmfcPiV3OOUDNnJinF9jvF7E4pVdMkg=;
	b=g2EkYrE+Gj/dGL/QS2WPoHQ7amgdKEp1l48y6ny4fkr8pgRElpME0k6d7YJxnl+V+rUMwb
	J1KreuiyBbbQOVEs7bPpr/768/STKd05QQoq4+g/q/X6gBTP8ZApg/g/O90bPyKbDD5/cl
	TCkGglVPJWku0a0HmoBPyiyfuLpX1yA=
Date: Mon, 25 Sep 2023 17:24:38 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC bpf-next v3 08/11] bpf: pass attached BTF to find correct
 type info of struct_ops progs.
Content-Language: en-US
To: thinker.li@gmail.com
Cc: sinquersw@gmail.com, kuifeng@meta.com, bpf@vger.kernel.org,
 ast@kernel.org, song@kernel.org, kernel-team@meta.com, andrii@kernel.org
References: <20230920155923.151136-1-thinker.li@gmail.com>
 <20230920155923.151136-9-thinker.li@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230920155923.151136-9-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/20/23 8:59 AM, thinker.li@gmail.com wrote:
> From: Kui-Feng Lee <thinker.li@gmail.com>
> 
> The type info of a struct_ops type may be in a module.  So, we need to know
> which module BTF to look for type information.  The later patches will make
> libbpf to attach module BTFs to programs. This patch passes attached BTF
> from syscall to bpf_struct_ops subsystem to make sure attached BTF is
> available when the bpf_struct_ops subsystem is ready to use it.
> 
> bpf_prog has attach_btf in aux from attach_btf_obj_fd, that is pass along
> with the bpf_attr loading the program. attach_btf is used to find the btf
> type of attach_btf_id. attach_btf_id is used to identify the traced
> function for a trace program.  For struct_ops programs, it is used to
> identify the struct_ops type of the struct_ops object a program attached
> to.
> 
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---
>   include/uapi/linux/bpf.h       |  4 ++++
>   kernel/bpf/bpf_struct_ops.c    | 12 +++++++++++-
>   kernel/bpf/syscall.c           |  2 +-
>   kernel/bpf/verifier.c          |  4 +++-
>   tools/include/uapi/linux/bpf.h |  4 ++++
>   5 files changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 73b155e52204..178d6fa45fa0 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1390,6 +1390,10 @@ union bpf_attr {
>   		 * to using 5 hash functions).
>   		 */
>   		__u64	map_extra;
> +
> +		__u32   mod_btf_fd;	/* fd pointing to a BTF type data
> +					 * for btf_vmlinux_value_type_id.
> +					 */
>   	};
>   
>   	struct { /* anonymous struct used by BPF_MAP_*_ELEM commands */
> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> index 8b5c859377e9..d5600d9ad302 100644
> --- a/kernel/bpf/bpf_struct_ops.c
> +++ b/kernel/bpf/bpf_struct_ops.c
> @@ -765,9 +765,19 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
>   	struct bpf_struct_ops_map *st_map;
>   	const struct btf_type *t, *vt;
>   	struct bpf_map *map;
> +	struct btf *btf;
>   	int ret;
>   
> -	st_ops = bpf_struct_ops_find_value(attr->btf_vmlinux_value_type_id, btf_vmlinux);
> +	/* XXX: We need a module name or ID to find a BTF type. */
> +	/* XXX: should use btf from attr->btf_fd */
> +	if (attr->mod_btf_fd) {
> +		btf = btf_get_by_fd(attr->mod_btf_fd);

The btf is leaked in all cases because it is not stored (and owned) in st_map 
during map_alloc. This circle back to the earlier comment in patch 4 about where 
btf is stored.

> +		if (IS_ERR(btf))
> +			return ERR_PTR(PTR_ERR(btf));
> +	} else {
> +		btf = btf_vmlinux;
> +	}
> +	st_ops = bpf_struct_ops_find_value(attr->btf_vmlinux_value_type_id, btf);
>   	if (!st_ops)
>   		return ERR_PTR(-ENOTSUPP);
>   


