Return-Path: <bpf+bounces-22848-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5E886A923
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 08:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89D611C21CCF
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 07:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57BF250F2;
	Wed, 28 Feb 2024 07:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uB3qROca"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BCA21370
	for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 07:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709106106; cv=none; b=dMU65wILZmMQlB5bHUfb1HIpcsXjrOvxyltwTiDoXBvfeXHi9x15vmrStAKUnhWaHsOd1NHpWmwpxuMRWKLr0KdKhvtAGEqEGq0/cNgY1LNS8CCLA7nFvzAT36acTu3S0LKJ7ewJDkc8gNQfooBcgmC6XY4BQ7tbJOFiMK84h6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709106106; c=relaxed/simple;
	bh=/rET/S5HQ/PfPbmjlsdrQWDUAZbqfjmOjYVTxvfOTSM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h2FJRV3YfyUQmPy+nT8k8HQ2AC9Gohro9A8yhdxb8HwrIfIYwKae9C252pVVadpgCBTMEae71e+7kP/W62ILpXvU20ZbQwhCkdaJ54+GFqqr3viYBBQX9kRve3oHTUJKNrlosUUbo2lyp3j87nySkzIqfrVqj9qs2IrNR5Pywiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uB3qROca; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a7c2be77-9287-4012-b299-1222bcce1de0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709106102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yG+ycLq6TIlCzN0aTRXcji0nA/qXOFZEcThptIIOncI=;
	b=uB3qROcaMotLLNOF3faXH5+/Ceay0E240eN0Jt3kMsAfY9BTgOYYTflQrL0zgiM/F85R7K
	p9l+E47Hbyma2ZgYc9LyCK94nkBl3A+wBWauryHprbG9Hmxul0CX5oWUGL+gxwvoGwvbzr
	ZZeUTfwqRnmu0z9bGiLaSGvn8TsapYY=
Date: Tue, 27 Feb 2024 23:41:34 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1 2/8] libbpf: tie struct_ops programs to kernel
 BTF ids, not to local ids
Content-Language: en-US
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
 yonghong.song@linux.dev, void@manifault.com, bpf@vger.kernel.org,
 ast@kernel.org
References: <20240227204556.17524-1-eddyz87@gmail.com>
 <20240227204556.17524-3-eddyz87@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240227204556.17524-3-eddyz87@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/27/24 12:45 PM, Eduard Zingerman wrote:
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index abe663927013..c239b75d5816 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -1134,8 +1134,27 @@ static int bpf_map__init_kern_struct_ops(struct bpf_map *map)
>   
>   			if (mod_btf)
>   				prog->attach_btf_obj_fd = mod_btf->fd;
> -			prog->attach_btf_id = kern_type_id;
> -			prog->expected_attach_type = kern_member_idx;
> +
> +			/* if we haven't yet processed this BPF program, record proper
> +			 * attach_btf_id and member_idx
> +			 */
> +			if (!prog->attach_btf_id) {
> +				prog->attach_btf_id = kern_type_id;
> +				prog->expected_attach_type = kern_member_idx;
> +			}
> +
> +			/* struct_ops BPF prog can be re-used between multiple
> +			 * .struct_ops & .struct_ops.link as long as it's the
> +			 * same struct_ops struct definition and the same
> +			 * function pointer field
> +			 */
> +			if (prog->attach_btf_id != kern_type_id ||
> +			    prog->expected_attach_type != kern_member_idx) {
> +				pr_warn("struct_ops reloc %s: cannot use prog %s in sec %s with type %u attach_btf_id %u expected_attach_type %u for func ptr %s\n",

The patch lgtm. A nit is s/reloc/init_kern/.

> +					map->name, prog->name, prog->sec_name, prog->type,
> +					prog->attach_btf_id, prog->expected_attach_type, mname);
> +				return -EINVAL;
> +			}
>   
>   			st_ops->kern_func_off[i] = kern_data_off + kern_moff;


