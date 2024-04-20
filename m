Return-Path: <bpf+bounces-27269-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8AD8AB804
	for <lists+bpf@lfdr.de>; Sat, 20 Apr 2024 02:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07F7BB210FA
	for <lists+bpf@lfdr.de>; Sat, 20 Apr 2024 00:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC523633;
	Sat, 20 Apr 2024 00:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Bf7XtRNQ"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B03C17C
	for <bpf@vger.kernel.org>; Sat, 20 Apr 2024 00:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713571563; cv=none; b=oMw+ZwxNwCvNjrnOvKgoxi+sP4JSWOJUJQIS89TVzIAQ+A7zwx3iNSUhO3+Lfo6Vo9OndFqH7SHfLoaRfXX5xYtVjWxP10KJ0HiRPbgYyVXtzOM9j2K1XttVIpsxwKthDoEeaFT0ugo4L55FB9XinZ9Qa8WGvyWUXAVJzPpIY64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713571563; c=relaxed/simple;
	bh=ItCVRPv7W8vq3MUvBHj/T6U8FpqBNantnb+5Hqkr8/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eUaPqCRfp2cmONgrgH4h4MCrPHX7tOU7bhf+KSgerVKuwu3z4lK1LUkl1QwEBHgUCj/RddumeSBWKgUVjqItOJFcWJFdUFtULY9laWQhhxG3ejPIz8DbIyEA4H9RSads1sqMn0puNBU6hyCXwoSAaHXKg4dXoSzJLubTyzDxOPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Bf7XtRNQ; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8dadfcc9-1f6a-4b93-951b-548e4560ce5a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713571559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B7vqtoHeYofzo+BRMX+SP+yT/J0kPZK1vFHA0Zc5XI8=;
	b=Bf7XtRNQj+IIjM3ZCZnBz6nOxbHppC1sG3ztzp3WLGSBsUA8pP2wQUoIbWqgSbubo7DPrP
	7QCNkdk4O9w0DNkYkVIPG1Es8CorHXCjKysDGVwq0r007LzMhmoUJFwkqbtiWbnS7OV97H
	MFfNC9D+GpT0diHOZx0MDomsGGMrzN8=
Date: Fri, 19 Apr 2024 17:05:53 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/2] bpf: enable the "open" operator on a pinned
 path of a struct_osp link.
To: Kui-Feng Lee <thinker.li@gmail.com>, andrii@kernel.org
Cc: sinquersw@gmail.com, kuifeng@meta.com, bpf@vger.kernel.org,
 ast@kernel.org, song@kernel.org, kernel-team@meta.com
References: <20240417002513.1534535-1-thinker.li@gmail.com>
 <20240417002513.1534535-2-thinker.li@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240417002513.1534535-2-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/16/24 5:25 PM, Kui-Feng Lee wrote:
> +int bpffs_struct_ops_link_open(struct inode *inode, struct file *filp)
> +{
> +	struct bpf_struct_ops_link *link = inode->i_private;
> +
> +	/* Paired with bpf_link_put_direct() in bpf_link_release(). */
> +	bpf_link_inc(&link->link);
> +	filp->private_data = link;
> +	return 0;
> +}
> diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
> index af5d2ffadd70..b020d761ab0a 100644
> --- a/kernel/bpf/inode.c
> +++ b/kernel/bpf/inode.c
> @@ -360,11 +360,16 @@ static int bpf_mkmap(struct dentry *dentry, umode_t mode, void *arg)
>   
>   static int bpf_mklink(struct dentry *dentry, umode_t mode, void *arg)
>   {
> +	const struct file_operations *fops;
>   	struct bpf_link *link = arg;
>   
> -	return bpf_mkobj_ops(dentry, mode, arg, &bpf_link_iops,
> -			     bpf_link_is_iter(link) ?
> -			     &bpf_iter_fops : &bpffs_obj_fops);
> +	if (bpf_link_is_iter(link))
> +		fops = &bpf_iter_fops;
> +	else if (link->type == BPF_LINK_TYPE_STRUCT_OPS)

Open a pinned link and then update should not be specific to struct_ops link. 
e.g. should be useful to the cgroup link also?

Andrii, wdyt about supporting other link types also?

> +		fops = &bpf_link_fops;
> +	else
> +		fops = &bpffs_obj_fops;
> +	return bpf_mkobj_ops(dentry, mode, arg, &bpf_link_iops, fops);
>   }
>   
>   static struct dentry *
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 7d392ec83655..f66bc6215faa 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3108,7 +3108,19 @@ static void bpf_link_show_fdinfo(struct seq_file *m, struct file *filp)
>   }
>   #endif
>   
> -static const struct file_operations bpf_link_fops = {
> +/* Support opening pinned links */
> +static int bpf_link_open(struct inode *inode, struct file *filp)
> +{
> +	struct bpf_link *link = inode->i_private;
> +
> +	if (link->type == BPF_LINK_TYPE_STRUCT_OPS)
> +		return bpffs_struct_ops_link_open(inode, filp);
> +
> +	return -EOPNOTSUPP;
> +}
> +
> +const struct file_operations bpf_link_fops = {
> +	.open = bpf_link_open,
>   #ifdef CONFIG_PROC_FS
>   	.show_fdinfo	= bpf_link_show_fdinfo,
>   #endif


