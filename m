Return-Path: <bpf+bounces-30408-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B54E18CD91F
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 19:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E9811F21FA1
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 17:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA7841C92;
	Thu, 23 May 2024 17:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lWbryon1"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714791CFBE
	for <bpf@vger.kernel.org>; Thu, 23 May 2024 17:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716485007; cv=none; b=fhCdgKzQsaeDlRWkntg58nC+fNszSikWlaZESA5QU56JsVE5wJuno/ViBeoKPrfMVfRnDsQAcqtKOdW4Ns4BzxbLniOMA2mNrdTDLhhhIsQAuQWdM5i4efy4O1rYO69qaLhux+lPttZUL7ZsyX6m2CX6qba8WNsKjck6AknK+0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716485007; c=relaxed/simple;
	bh=+JWotaJQtmks7WwWRauX6CYIPXMeLmnc6NnREZPxWng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N+jpTTTYwns0MZdCFaoncmFWSdY1MJtMajnhLKl3txPlWpKyzybyWRJ4cRIeEV6JLSCXL8soRKR0zWQMLvMponCsGE5ICrE81zLjmUCZyqcGIyjx6XLSG+KqCPxbx95XOoq4cYtfZv07YIHE7p7ajaG1C+CvOu8wmBD6BdiuJ0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lWbryon1; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: thinker.li@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716485003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ajM7Qp7e0A1XsCryGuHmlbeo0YjGvXNY3biKUDCkz8c=;
	b=lWbryon10E1lpyq1KiSzLNVPmX7x8pg+gOQ2e/iS1Lb/uXSmGhU2xi0dpcNb3ovH3geT04
	ZqHQpnk6CuLU98WXr722bNX++yLz8kxkgUskyP0gmX59zlLq6wXMQKu1BSmSNLozSvfylS
	LJKd3vJyLxwJuqWbZWLQSbvdSj56Y2s=
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: ast@kernel.org
X-Envelope-To: song@kernel.org
X-Envelope-To: kernel-team@meta.com
X-Envelope-To: andrii@kernel.org
X-Envelope-To: sinquersw@gmail.com
X-Envelope-To: kuifeng@meta.com
Message-ID: <a04e275d-4b29-4a6a-b142-dec5b376f2b9@linux.dev>
Date: Thu, 23 May 2024 10:23:18 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 3/7] bpf: support epoll from bpf struct_ops
 links.
To: Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, sinquersw@gmail.com,
 kuifeng@meta.com
References: <20240521225121.770930-1-thinker.li@gmail.com>
 <20240521225121.770930-4-thinker.li@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240521225121.770930-4-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 5/21/24 3:51 PM, Kui-Feng Lee wrote:
> +static __poll_t bpf_link_poll(struct file *file, struct poll_table_struct *pts)
> +{
> +	struct bpf_link *link = file->private_data;
> +
> +	if (link->ops->poll)
> +		return link->ops->poll(file, pts);
> +
> +	return 0;

The current bpf_link_fops.poll is NULL before this patch. From vfs_poll, it 
seems to be DEFAULT_POLLMASK for this case. Please double check.

> +}
> +
>   static const struct file_operations bpf_link_fops = {
>   #ifdef CONFIG_PROC_FS
>   	.show_fdinfo	= bpf_link_show_fdinfo,
> @@ -3157,6 +3167,7 @@ static const struct file_operations bpf_link_fops = {
>   	.release	= bpf_link_release,
>   	.read		= bpf_dummy_read,
>   	.write		= bpf_dummy_write,
> +	.poll		= bpf_link_poll,

Same here. What does the epoll_ctl(EPOLL_CTL_ADD) currently expect for link 
(e.g. cgroup) that does not support poll?

>   };
>   


