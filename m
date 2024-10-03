Return-Path: <bpf+bounces-40818-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CDE98EC1B
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 11:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 280571F21FEC
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 09:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B63A13DBB1;
	Thu,  3 Oct 2024 09:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YGfsAtH1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCA5143725;
	Thu,  3 Oct 2024 09:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727946834; cv=none; b=Vhb+DVSNZnpjuL1a+7uD8089/WH35RcgALBBxVDJ7LF/QAJEixPECieha96xWzRc8rCrELvFigYirj5myvn62az4X5qwBBLS2XGTlELQcOHCnSHFcQknK5krdZ6y5gOHCrZeNR/vwq6Mj4OJAQDV0I+pxxM8Jo4RLTZZsmhaSMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727946834; c=relaxed/simple;
	bh=ycpdvLNhz+R+FpxfbMcMNSiEkjPDEsZjLMjIcym0XAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fnUX1GRR9IIGnCanGCzqclEGyW04SeXoPwFwnclR22gUxHvOWLog06apLq0fKuuRiohmo3lKccLHPqJoLl5fqmaxuaYCahawRn9ctnREre7n/emya7wE0OADux/zeL7i4unirU3tbI2GMuROoP5GJq5qZNXR/l0ayjY6v9bqwwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YGfsAtH1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0117C4CEC7;
	Thu,  3 Oct 2024 09:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727946833;
	bh=ycpdvLNhz+R+FpxfbMcMNSiEkjPDEsZjLMjIcym0XAE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YGfsAtH1SaRWz5ZO2owf+AkYYxzeP93z2XE/fSNKttVgS945LQ7hxEThQWjVAeD3k
	 Q82S3BBNOiKQZwJf4H2+dK8Vi8mnOORfNPUEZ/NYDaEtpqdgkR4myBymvWubCyOOw2
	 t4Lg95AkpnFMhCBAh1rzy2u5MbB5XHpWuioxe/X6/HXwAz+jDD6jefLa004wOgcUvl
	 PqBgJp/xai9T7pDgapyEkyAsZ5sXdijOwTIcXjPeEPYI2vnNbUkmAb/AZ9kC0Zl2W9
	 fmHT5gNeXSqlDvAtmnLM9itByKMehuMunzfOsaXHx9lkQYCI7LWryRdT9Af13fONCz
	 BVSraE1KkCSmA==
Date: Thu, 3 Oct 2024 11:13:46 +0200
From: Christian Brauner <brauner@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, peterz@infradead.org, 
	oleg@redhat.com, rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org, willy@infradead.org, 
	surenb@google.com, akpm@linux-foundation.org, linux-mm@kvack.org, mjguzik@gmail.com, 
	jannh@google.com, mhocko@kernel.org, vbabka@suse.cz, mingo@kernel.org, 
	Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH v2 tip/perf/core 3/5] fs: add back RCU-delayed freeing of
 FMODE_BACKING file
Message-ID: <20241003-lachs-handel-4f3a9f31403d@brauner>
References: <20241001225207.2215639-1-andrii@kernel.org>
 <20241001225207.2215639-4-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241001225207.2215639-4-andrii@kernel.org>

On Tue, Oct 01, 2024 at 03:52:05PM GMT, Andrii Nakryiko wrote:
> 6cf41fcfe099 ("backing file: free directly") switched FMODE_BACKING
> files to direct freeing as back then there were no use cases requiring
> RCU protected access to such files.
> 
> Now, with speculative lockless VMA-to-uprobe lookup logic, we do need to
> have a guarantee that struct file memory is not going to be freed from
> under us during speculative check. So add back RCU-delayed freeing
> logic.
> 
> We use headless kfree_rcu_mightsleep() variant, as file_free() is only
> called for FMODE_BACKING files in might_sleep() context.
> 
> Suggested-by: Suren Baghdasaryan <surenb@google.com>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

