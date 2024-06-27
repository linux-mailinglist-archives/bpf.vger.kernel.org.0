Return-Path: <bpf+bounces-33254-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F2F91A744
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 15:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D03441F248A1
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 13:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F639186285;
	Thu, 27 Jun 2024 13:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="szj4CuqS"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CCB185E60;
	Thu, 27 Jun 2024 13:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719493494; cv=none; b=peCUOoNwc4altm5tUro0RCqzIXsVzTnND03zdtX5SzIlqdvfyK51TYyDL30a1oJv7faZssPy+3x1rg7LcdecJCjLWZ8kgogcEnFrovLlVg58mkLDMbnvCwhkZ7+yroR/tWbxTfbD0L8RlqrMWDdxor0lzpTcU+fLu7FkgA3ipHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719493494; c=relaxed/simple;
	bh=SyVoOzQtkMqAOY6r7zcxFymql4HgnqH2GBKDWSknWRY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=QVyZF6uURl+NL0v2eKMcMqA5SJRldrtWFTVGDTxirbBTzwdlKdeFensk/ehGuPwGB7wti1GUR6BEuGSCtFRdXL8xC34ruj3CykHZuLJ5nOAhOfHudkJlfs+/ygPx621/sSiSZLMflvdv5cvtQjS+LxhtUlC5y0fFgF8tE+MKGps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=szj4CuqS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EBA3C2BBFC;
	Thu, 27 Jun 2024 13:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719493494;
	bh=SyVoOzQtkMqAOY6r7zcxFymql4HgnqH2GBKDWSknWRY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=szj4CuqSSBM0KuE+wfZsuaR131fU78LZv7Gftow2gA2ienC5Br2p9JMMhhw3khmRl
	 8XS+k7h/wdXQs5CBKp53qvVFZbBiEbo9+nF/RmAc9Q3gIGbI/v2wt1qWODfro2UwS5
	 os1Hv+V1780wJoaiRQL7L69OseSHH1EHh3BVM91oh+/Y3L+KoPcVwArGT/++upBkuh
	 dlLFXiOD6iaWF1B4QljfvY90u6Cv+Tjyjjdi0n1uHPOn90d+hdIstbqOxGrz3GbjG/
	 T1zk12CbNdaGZ9j+R5murrUM9OKjVrvDomxRBEp5VkJD2ALZCY6qk/smEx+0kdRkqs
	 k8bODd50eMjzA==
Date: Thu, 27 Jun 2024 22:04:49 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org,
 oleg@redhat.com, peterz@infradead.org, mingo@redhat.com,
 bpf@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org, clm@meta.com
Subject: Re: [PATCH 06/12] uprobes: add batch uprobe register/unregister
 APIs
Message-Id: <20240627220449.0d2a12e24731e4764540f8aa@kernel.org>
In-Reply-To: <20240625002144.3485799-7-andrii@kernel.org>
References: <20240625002144.3485799-1-andrii@kernel.org>
	<20240625002144.3485799-7-andrii@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Jun 2024 17:21:38 -0700
Andrii Nakryiko <andrii@kernel.org> wrote:

> -static int __uprobe_register(struct inode *inode, loff_t offset,
> -			     loff_t ref_ctr_offset, struct uprobe_consumer *uc)
> +int uprobe_register_batch(struct inode *inode, int cnt,
> +			  uprobe_consumer_fn get_uprobe_consumer, void *ctx)

Is this interface just for avoiding memory allocation? Can't we just
allocate a temporary array of *uprobe_consumer instead? 

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

