Return-Path: <bpf+bounces-51629-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E03A36A15
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 01:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DED57A2778
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 00:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0200B32C85;
	Sat, 15 Feb 2025 00:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Hm5NcPPw"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0288EEACE
	for <bpf@vger.kernel.org>; Sat, 15 Feb 2025 00:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739580597; cv=none; b=nzN9ObMooCMW9lj8wZ3uD0FYVyGoiBGwPdW9qhSZd0vRjqnR4ltgcGM8F8XkxhV6U4hIhQ7k6Lzi3C5cb8AYDrJlvvSceeW8Jlt3P71/vvMzP9tVOddeBX6kC8fFzcfp8girHVqIkcTsPvkdL2hQR1SyIAyy0CKbKkpMnjutQ9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739580597; c=relaxed/simple;
	bh=nZtmbLzKDGmws3B0bBK9OnRd4Aw7dfrznrZXI/ZzVMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WRSOdx3ldHOoSpMqctWyx2TAvVpcy2OnIDe4DAOBIC3vYuPGQzZRuCGHcnfS7NN1kB9ofY91NGpJ9PzG+C75tDlWneVkJqFxe+ecJnRHKRzp2PcnsQ7pREyltC/GOONk4nuY22xw/0subfqEAwLDTRmHbLARQ4P6TVEbN8zBQAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Hm5NcPPw; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4661b71e-4932-4c80-ad6d-073fc4e8ae90@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739580591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JDR5G/j8y3hKmHPPPdNRLxHfxFchk3aZwWi+MuzqFog=;
	b=Hm5NcPPwZFsKfDHlx8H3g2X07Gb1P6dXMfSfedMLJ+X7SM7fLEq6lqnTrUHazPouEEIPxe
	ffGPsz610RnD6P1qPyqV6GsJFaiOI1xRCR5fjibPlqu9chNeyYdIcmbrzlJthZfh3Wq+ag
	dZsZuLsOUdT+ForGH/xILQ3SzSHvxbg=
Date: Fri, 14 Feb 2025 16:49:44 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1 2/5] bpf: Support getting referenced kptr from
 struct_ops argument
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 alexei.starovoitov@gmail.com, martin.lau@kernel.org, eddyz87@gmail.com,
 kernel-team@meta.com
References: <20250214164520.1001211-1-ameryhung@gmail.com>
 <20250214164520.1001211-3-ameryhung@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250214164520.1001211-3-ameryhung@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/14/25 8:45 AM, Amery Hung wrote:
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 9de6acddd479..fd3470fbd144 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -6677,6 +6677,7 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
>   			info->reg_type = ctx_arg_info->reg_type;
>   			info->btf = ctx_arg_info->btf ? : btf_vmlinux;
>   			info->btf_id = ctx_arg_info->btf_id;
> +			info->ref_obj_id = ctx_arg_info->refcounted ? ctx_arg_info->ref_obj_id : 0;

A small nit. No need to check ctx_arg_info->refcounted. If refcounted is false, 
ref_obj_id should have been 0.

			info->ref_obj_id = ctx_arg_info->ref_obj_id;


Acked-by: Martin KaFai Lau <martin.lau@kernel.org>

