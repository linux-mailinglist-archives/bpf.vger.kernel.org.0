Return-Path: <bpf+bounces-48520-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9910FA0881F
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 07:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD8773AB6C6
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 06:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8A620B1FD;
	Fri, 10 Jan 2025 06:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KWQ4gxDR"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD2720B1F7
	for <bpf@vger.kernel.org>; Fri, 10 Jan 2025 06:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736489155; cv=none; b=OmP5EBXFSXar046XdZUGeZScFf0RqPrf5dF2hRb/RcaSpw87QPVTCSrRCTymlYymfaa3yyKvp/2WM3NNZS4Ut9Y7UAQSEvPkHgRYO4D9awmCJZ+hdU1iF4Z2WwXZq/PhjhLR/c6Ua7Czx+TiNlucd9sbUrMie9YaGx7TBDHao38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736489155; c=relaxed/simple;
	bh=dzyF4rYJ+bsbZTuINIu6y/f/yDzf/388ZdxfeXIhWUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S+8+rWsFhdUaOwbsxnXsFwXJfRsKLbd9vH9wvSfU8c52Hf1Sb7dz5nL43IOdfDHl45DfqUPrMcM6qRXM4ArsGoS5LAYJY16o4tyVdnNn4vIFn7rLpzhovLpwsob69x7bIWqGK+LEQvB4fSoLii9inWPYbpRKsl2Pbe2TivVQn5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KWQ4gxDR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AED0C4CEDD;
	Fri, 10 Jan 2025 06:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736489154;
	bh=dzyF4rYJ+bsbZTuINIu6y/f/yDzf/388ZdxfeXIhWUw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KWQ4gxDRfewWrLNVtcDPmLWoHDqO0pKNtiZu0ETv17uaWJTCws1fWzCwztMtjQXp+
	 yS/ZMeF4RqnaAxgYYQjaZWJpf1Ia/nkd1oNAybYjiKkZtWOgYpNy8ZOYkH9IaAybzT
	 deUMSf9EA9fFSur9pO+yFGJBWEerfQmXISbfO/gQ=
Date: Fri, 10 Jan 2025 07:05:03 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
Cc: bpf@vger.kernel.org, nkapron@google.com, teknoraver@meta.com,
	roberto.sassu@huawei.com, paul@paul-moore.com, code@tyhicks.com,
	flaniel@linux.microsoft.com
Subject: Re: [PATCH 07/14] bpf: Implement BPF_LOAD_FD subcommand handler
Message-ID: <2025011010-unglue-latch-34ea@gregkh>
References: <20250109214617.485144-1-bboscaccy@linux.microsoft.com>
 <20250109214617.485144-8-bboscaccy@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250109214617.485144-8-bboscaccy@linux.microsoft.com>

On Thu, Jan 09, 2025 at 01:43:49PM -0800, Blaise Boscaccy wrote:
> The new LOAD_FD subcommand keys off of a sysfs entry file descriptor
> and a file descriptor pointing to a raw elf object file.

A sysfs file descriptor?  That feels very odd and is not how sysfs
should be used, as it's only for text files and binary pass-through
stuff.

> +static void bpf_loader_show_fdinfo(struct seq_file *m, struct file *filp)
> +{
> +	int i;
> +	struct bpf_obj *obj = filp->private_data;
> +
> +	for (i = 0; i < obj->nr_programs; i++)
> +		seq_printf(m, "program: %s\n", obj->progs[i].name);

So what file is printing this out in sysfs?  Where is the
Documentation/ABI/ entry for it?

confused,

greg k-h

