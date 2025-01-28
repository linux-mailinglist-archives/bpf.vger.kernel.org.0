Return-Path: <bpf+bounces-49983-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB76A213AB
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 22:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77FCD167721
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 21:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23411EEA5E;
	Tue, 28 Jan 2025 21:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="e9DpxoKe"
X-Original-To: bpf@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830F578F58;
	Tue, 28 Jan 2025 21:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738100687; cv=none; b=rDZITPnB88EQFGJI7AZrgjF9lXurHpRYsampqVuLs/3LCliiPTyeI7QgcVUV2kdcr/tpCVRvMbLqpvlTvlACZdhVHxH0rfPj1dbbBLiMf8nP/+I64Kscr99zX/b+BA5lonHoGPiFvwjQo0s+YQv9gNBGT7mQzWuAiHQN/hZ07aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738100687; c=relaxed/simple;
	bh=/ZVfTjb6OB6mwOq5oov2dfGCKk9jKalsU95smqbbt3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sHmt/BIyerDtUkTGM4fGzezct0pZPacMYTYauJzNQmw9h//CPvipm4X39ECeKl3FEWh7cBsCN3ctIgGn12Ky/uDWgSiqtupBr4Mz3sU0pWJXYhvYR56Rru4GKeyJWbWYASjizo9NQfhC6tDmE0WRbsIqIGcKnmDt1Ktz5sIZMno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=e9DpxoKe; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1738100682;
	bh=/ZVfTjb6OB6mwOq5oov2dfGCKk9jKalsU95smqbbt3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e9DpxoKedhbbEEwT6cJk8l+hJKEnzOeN6eIPyv+mEHwWnhhERrdM7T12crNn9FfXZ
	 m4IK1QIwqBd37RjmvZrFW7U8x2uk8y3GejhrhiXglitMco3yIU9suq3SQzK6imzfZy
	 9/bMPULruTldNrbPcRild5kQvmhlE8fR6BEDF0b4=
Date: Tue, 28 Jan 2025 22:44:42 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Daniel Gomez <da.gomez@samsung.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	llvm@lists.linux.dev, iovisor-dev@lists.iovisor.org, gost.dev@samsung.com
Subject: Re: [PATCH 1/2] module: allow for module error injection
Message-ID: <559c6c43-e081-454b-9e87-c30600a97ae1@t-8ch.de>
References: <20250122-modules-error-injection-v1-0-910590a04fd5@samsung.com>
 <CGME20250122131158eucas1p133e9989e5b972e0658b4ef7255901085@eucas1p1.samsung.com>
 <20250122-modules-error-injection-v1-1-910590a04fd5@samsung.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122-modules-error-injection-v1-1-910590a04fd5@samsung.com>

On 2025-01-22 14:11:13+0100, Daniel Gomez wrote:
> Allow to test kernel module initialization with eBPF error injection
> by forcing errors when any of the below annotated functions with
> ALLOW_ERROR_INJECTION() return.
> 
> Allow to debug and test module load error behaviour when:
> 
> complete_formation(): when module initialization switches from
> MODULE_STATE_UNFORMED to MODULE_STATE_COMING stage.
> 
> do_init_module(): when an error occurs during module initialization and
> before we switch from MODULE_STATE_COMING to MODULE_STATE_LIVE stage.
> 
> module_enable_rodata_ro_after_init(): when an error occurs while
> setting memory to RO after module initialization. This is when module
> initialization reaches MODULE_STATE_LIVE stage.
> 
> Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
> ---
>  kernel/module/main.c       | 3 +++
>  kernel/module/strict_rwx.c | 2 ++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index 1fb9ad289a6f8f328fc37c6d93730882d0e6e613..54e6c4d0aab23ae5001a52c26417e7e7957ea3fd 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -59,6 +59,7 @@
>  #include <linux/codetag.h>
>  #include <linux/debugfs.h>
>  #include <linux/execmem.h>
> +#include <linux/bpf.h>

This should be <linux/error-injection.h>, no?

>  #include <uapi/linux/module.h>
>  #include "internal.h"
>  
> @@ -3089,6 +3090,7 @@ static noinline int do_init_module(struct module *mod)
>  
>  	return ret;
>  }
> +ALLOW_ERROR_INJECTION(do_init_module, ERRNO);
>  
>  static int may_init_module(void)
>  {
> @@ -3225,6 +3227,7 @@ static int complete_formation(struct module *mod, struct load_info *info)
>  	mutex_unlock(&module_mutex);
>  	return err;
>  }
> +ALLOW_ERROR_INJECTION(complete_formation, ERRNO);
>  
>  static int prepare_coming_module(struct module *mod)
>  {

<snip>

