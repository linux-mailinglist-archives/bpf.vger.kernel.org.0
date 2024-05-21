Return-Path: <bpf+bounces-30077-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79DFB8CA5C2
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 03:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAA171C21338
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 01:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E54848A;
	Tue, 21 May 2024 01:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kFlm0V2H"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4B8947E
	for <bpf@vger.kernel.org>; Tue, 21 May 2024 01:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716254804; cv=none; b=UfvOVJfO6FrhYRx4QPVyaRd4aHBCn3o005FXYgYUPoSjOAjm5UAeYm6IUobrUCk1uLSzy4Ik2IsoJHIVMPpwuWdZ/wo7Sh51WCgZx5C8UGbSOI4kqWpczfAMZBHrkKZFCvhrxS80sBKRhw/vTjvYt/BDyC4woqfA/aFl3fs32XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716254804; c=relaxed/simple;
	bh=rGJYGZ+sq1LOLIv5Ox+BpBT8RPYR3d9GczKiZswv2Uc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SjwHyyJwJihaoUNfpA6GhjnHjgvF5XxjsDZNamJ+y038TbCxZaH7MbCs62oF47s9weCT7NC2vZZkFAt6JVVGLniihFTrHA2XSArvMENUrwjrwrnsY+IQkl0z1gHd7aH6wk+JmHZRdChJkTyXflAS4zbTmiW6jCam66hI3hRs3oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kFlm0V2H; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: thinker.li@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716254801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lyayakj483N8C8tLyCctx1VGKGRJLmao9aSMuMqB/iY=;
	b=kFlm0V2Hzl90xiulXrdB8dReA/lLDih0ieky715IgHlZni4l0omE0JyPupMEu5ftwMxUDh
	TpE71k5T7bbMyl6Lfkk03bacGwyOJiUBHLy8HngWIfnuRHRZBSyDGe9OH5rqTSe/bqMl/7
	/xT79y48kSimfzK896hiLI/lJAb6U6A=
X-Envelope-To: sinquersw@gmail.com
X-Envelope-To: kuifeng@meta.com
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: ast@kernel.org
X-Envelope-To: song@kernel.org
X-Envelope-To: kernel-team@meta.com
X-Envelope-To: andrii@kernel.org
Message-ID: <708a8b9f-45ce-48f1-9c6b-bbf226faf679@linux.dev>
Date: Mon, 20 May 2024 18:26:37 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 3/7] bpf: support epoll from bpf struct_ops
 links.
To: Kui-Feng Lee <thinker.li@gmail.com>
Cc: sinquersw@gmail.com, kuifeng@meta.com, bpf@vger.kernel.org,
 ast@kernel.org, song@kernel.org, kernel-team@meta.com, andrii@kernel.org
References: <20240510002942.1253354-1-thinker.li@gmail.com>
 <20240510002942.1253354-4-thinker.li@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240510002942.1253354-4-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 5/9/24 5:29 PM, Kui-Feng Lee wrote:
> +static __poll_t bpf_struct_ops_map_link_poll(struct file *file,
> +					     struct poll_table_struct *pts)
> +{
> +	struct bpf_struct_ops_link *st_link = file->private_data;
> +
> +	poll_wait(file, &st_link->wait_hup, pts);
> +
> +	return (st_link->map) ? 0 : EPOLLHUP;

nit. It should need a rcu_access_pointer(st_link->map).


