Return-Path: <bpf+bounces-61748-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BB3AEB604
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 13:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ABCD56501C
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 11:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA6E2BF3E4;
	Fri, 27 Jun 2025 11:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fJ3FdMvl"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4016D29DB6B;
	Fri, 27 Jun 2025 11:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751022531; cv=none; b=NQlsjfo7rU4nD4bmbhHWIwrjteV1xR0z5PugpvwRYp8NOJi5q6y5AoLU03fd9nb7dGP+Rv0/GKak1eDVVijwAwEn8qVYKQMRW+pkJV5zUDx0JKhV23mgY3V1aGrjaHey9NtdHafIz9+drn1AFz65ueCthwJP1Vm2ICjGNCvxbBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751022531; c=relaxed/simple;
	bh=oDXi3+L82y/mdd5opEhSbT+ju5BwjkSShkLIrL1LkwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dJuXrOVvra4MJRM5WbhP2kmaVdBApnXnJrCu7SirNxP4gp8tkR6CWiRxmKMmrIr1ZC/aUIz1AmA1Pv0iD9QJYQ6/BfiIsuXWsmqCi3dh+k20emkXJ//9iWO91ZvzC1v8MCs13sdJnXyskLn4PHmzkPnCRhq3X3AWF04EvN+w7fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fJ3FdMvl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4256C4CEE3;
	Fri, 27 Jun 2025 11:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751022530;
	bh=oDXi3+L82y/mdd5opEhSbT+ju5BwjkSShkLIrL1LkwM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fJ3FdMvlJFLzTR4tz5kdgVQqi/EDQtRP81fmbJ3oXz2wwJ2D+Iisnf5DPlHakrK4i
	 i3Tk7/kVWoFS3meq4EuVcWnENllM6GPbOkKQu+J0iNP+F6+EbqyCdE9DUQxrwXQPvD
	 yCFCJsNkB3ZR577eA0VZYsnrbPDuEI/JXrlYKyiOcG8dBPF5zxzmvC9TxMpKPEE5fn
	 aJEAthkmiE0nPADMxGKpJ5KIH2a7wII0+mupRqtTN9a5CgqShuAxGfKETv31ptwnJb
	 OjXq4gtuE0d0KHCOW2ig8T0cuWWDhIJPD4H1wtFHD0JsGJsZ6EWHBbM9lTrJ9NQ6WO
	 7D+wNRYaqxsUA==
Message-ID: <a3e42c2d-0a43-4fe7-8be5-96a3dff723d2@kernel.org>
Date: Fri, 27 Jun 2025 12:08:48 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] bpftool: Add CET-aware symbol matching for x86_64
 architectures
To: Yuan Chen <chenyuan_fl@163.com>, ast@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yuan Chen <chenyuan@kylinos.cn>, Jiri Olsa <jolsa@kernel.org>
References: <20250626061158.29702-1-chenyuan_fl@163.com>
 <20250626074930.81813-1-chenyuan_fl@163.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20250626074930.81813-1-chenyuan_fl@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Thanks! Next time, please try to add all relevant maintainers as
recipients or in copy of your message when submitting patches. You can
get the list with get_maintainer.pl, try running it on your patch or with
"./scripts/get_maintainer.pl -f tools/bpf/bpftool/link.c"

2025-06-26 15:49 UTC+0800 ~ Yuan Chen <chenyuan_fl@163.com>
> From: Yuan Chen <chenyuan@kylinos.cn>
> 
> Adjust symbol matching logic to account for Control-flow Enforcement
> Technology (CET) on x86_64 systems. CET prefixes functions with a 4-byte
> 'endbr' instruction, shifting the actual entry point to symbol + 4.
> 
> Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
> ---
>  tools/bpf/bpftool/link.c | 30 ++++++++++++++++++++++++++++--
>  1 file changed, 28 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
> index 03513ffffb79..dfd192b4c5ad 100644
> --- a/tools/bpf/bpftool/link.c
> +++ b/tools/bpf/bpftool/link.c
> @@ -307,8 +307,21 @@ show_kprobe_multi_json(struct bpf_link_info *info, json_writer_t *wtr)
>  		goto error;
>  
>  	for (i = 0; i < dd.sym_count; i++) {
> -		if (dd.sym_mapping[i].address != data[j].addr)
> +		if (dd.sym_mapping[i].address != data[j].addr) {
> +#if defined(__x86_64__) || defined(__amd64__)


I'm not familiar with CET, but from what I read, it's been around since
Tiger Lake processors (2020). Do we have a risk of false positive with
older CPUs? Maybe check that the instruction at
dd.sym_mapping[i].address is endbr32 or endbr34?


> +			/*
> +			 * On x86_64 architectures with CET (Control-flow Enforcement Technology),
> +			 * function entry points have a 4-byte 'endbr' instruction prefix.
> +			 * This causes the actual function address = symbol address + 4.
> +			 * Here we check if this symbol matches the target address minus 4,
> +			 * indicating we've found a CET-enabled function entry point.
> +			 */
> +			if (dd.sym_mapping[i].address == data[j].addr - 4)
> +				goto found;
> +#endif
>  			continue;
> +		}
> +found:
>  		jsonw_start_object(json_wtr);
>  		jsonw_uint_field(json_wtr, "addr", dd.sym_mapping[i].address);


I suppose we still want to print dd.sym_mapping[i].address (and not
data[j].addr) when we found it with the CET offset here - just
double-checking.


>  		jsonw_string_field(json_wtr, "func", dd.sym_mapping[i].name);
> @@ -744,8 +757,21 @@ static void show_kprobe_multi_plain(struct bpf_link_info *info)
>  
>  	printf("\n\t%-16s %-16s %s", "addr", "cookie", "func [module]");
>  	for (i = 0; i < dd.sym_count; i++) {
> -		if (dd.sym_mapping[i].address != data[j].addr)
> +		if (dd.sym_mapping[i].address != data[j].addr) {
> +#if defined(__x86_64__) || defined(__amd64__)
> +			/*
> +			 * On x86_64 architectures with CET (Control-flow Enforcement Technology),
> +			 * function entry points have a 4-byte 'endbr' instruction prefix.
> +			 * This causes the actual function address = symbol address + 4.
> +			 * Here we check if this symbol matches the target address minus 4,
> +			 * indicating we've found a CET-enabled function entry point.
> +			 */
> +			if (dd.sym_mapping[i].address == data[j].addr - 4)
> +				goto found;
> +#endif


Given that we have twice the same check, I'd move this to a dedicated
wrapper function that we could call from both show_kprobe_multi_json()
and show_kprobe_multi_plain().


>  			continue;
> +		}
> +found:
>  		printf("\n\t%016lx %-16llx %s",
>  		       dd.sym_mapping[i].address, data[j].cookie, dd.sym_mapping[i].name);
>  		if (dd.sym_mapping[i].module[0] != '\0')


