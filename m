Return-Path: <bpf+bounces-30272-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8CB8CBD76
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 11:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36BC8282B49
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 09:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724C518EB1;
	Wed, 22 May 2024 09:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CgV/Mz8U"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BC87E0E4
	for <bpf@vger.kernel.org>; Wed, 22 May 2024 09:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716368691; cv=none; b=cJvpMYuT7XDC4svlGo6hQj7262q9oR7Hlcpcr/5de/Oeop0qmIlep4FiRJiDi2ebuaYWZu7/R9IneRtqBc7L0w/R5peY7jRGkBw0HDXs+TbxNCNBIUEAopJc6ySllzCOeu8PPnt9gHED7hvpoz3GDaWvzrEGG3rKpeXdQNq/UX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716368691; c=relaxed/simple;
	bh=z8zhKR6lyjZ0wtYc0OUYS6kzyr607+muBvleM+F0uuM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Ctl24PDGA/0BZkVkWYJJEHuYcfGeHLZCtPPrGfhDMvi2KlfKeALVhlFA3YDFSTrjt6qpsm5c1W58P0O45mXIYyrQoj2RJosNHFBOL4xpqUPfDmFpPFcf8VRMDG/9c3mYzWMJHBHmwsyjVPpyTl+zHofJTuqSLoxIEJyadDgl/MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CgV/Mz8U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F06EFC2BD11;
	Wed, 22 May 2024 09:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716368690;
	bh=z8zhKR6lyjZ0wtYc0OUYS6kzyr607+muBvleM+F0uuM=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=CgV/Mz8UdKbycK6Eo6KQlKOtn+gNYpXrmcTycRFscfM56Pqtz+8+NadyOKk5wwFlC
	 IPW/6tZnDNAqPyIgMR8bUoSM+O2e1Q1lJP9ngktnW9Kz6P6rp9Lo/aDuD9SGgAShZy
	 0MRG6ARCLW+awhvQHDWoxWnsQv5gGIFPrKBTVg3Tk6z5LYkl2AmfBTyOqNbUUMxTBC
	 e1ryMBkm2sKAkml07ykViI/qBSphAQ2KyI1wxCug7waBEVo5Hwjcxhfy94+xcnX7DW
	 HEK6CbYFp8JVvPHb6LP0K/ovVzNKxPndE0YGzCY1dSixo9HVZpIazLXej59S+iclp7
	 GAergT/RrDEcg==
Message-ID: <45cd5412-b0f8-484f-bea4-adf4efe2e843@kernel.org>
Date: Wed, 22 May 2024 10:04:40 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Quentin Monnet <qmo@kernel.org>
Subject: Re: [PATCH v4 bpf-next 11/11] bpftool: support displaying
 relocated-with-base split BTF
To: Alan Maguire <alan.maguire@oracle.com>, andrii@kernel.org,
 jolsa@kernel.org, acme@redhat.com
Cc: eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, houtao1@huawei.com, bpf@vger.kernel.org,
 masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org
References: <20240517102246.4070184-1-alan.maguire@oracle.com>
 <20240517102246.4070184-12-alan.maguire@oracle.com>
Content-Language: en-GB
In-Reply-To: <20240517102246.4070184-12-alan.maguire@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Alan, I see in your cover letter that you tried to address the nits
from my review on v3 for patch 11, but it seems the changes got lost at
some point, please double-check.


2024-05-17 11:23 UTC+0100 ~ Alan Maguire <alan.maguire@oracle.com>
> If the -R <base_btf> option is used, we can display BTF that has been
> generated with distilled base BTF in its relocated form.  For example
> for bpf_testmod.ko (which is built as an out-of-tree module, so has
> a distilled .BTF.base section:
> 
> bpftool btf dump file bpf_testmod.ko
> 
> Alternatively, we can display content relocated with
> (a possibly changed) base BTF via
> 
> bpftool btf dump -R /sys/kernel/btf/vmlinux bpf_testmod.ko
> 
> The latter mirrors how the kernel will handle such split
> BTF; it relocates its representation with the running
> kernel, and if successful, renumbers BTF ids to reference
> the current vmlinux BTF.
> 
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> Reviewed-by: Quentin Monnet <qmo@kernel.org>
> ---
>  tools/bpf/bpftool/Documentation/bpftool-btf.rst | 15 ++++++++++++++-
>  tools/bpf/bpftool/bash-completion/bpftool       |  7 ++++---
>  tools/bpf/bpftool/btf.c                         | 11 ++++++++++-
>  tools/bpf/bpftool/main.c                        | 14 +++++++++++++-
>  tools/bpf/bpftool/main.h                        |  2 ++
>  5 files changed, 43 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/Documentation/bpftool-btf.rst b/tools/bpf/bpftool/Documentation/bpftool-btf.rst
> index 3f6bca03ad2e..b11abebeae81 100644
> --- a/tools/bpf/bpftool/Documentation/bpftool-btf.rst
> +++ b/tools/bpf/bpftool/Documentation/bpftool-btf.rst
> @@ -16,7 +16,7 @@ SYNOPSIS
>  
>  **bpftool** [*OPTIONS*] **btf** *COMMAND*
>  
> -*OPTIONS* := { |COMMON_OPTIONS| | { **-B** | **--base-btf** } }
> +*OPTIONS* := { |COMMON_OPTIONS| | { **-B** | **--base-btf** } { **-R** | **relocate-base-btf** } }

Please add the missing double-dash on --relocate-base-btf

[...]

> diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
> index 08d0ac543c67..69d4906bec5c 100644
> --- a/tools/bpf/bpftool/main.c
> +++ b/tools/bpf/bpftool/main.c
> @@ -32,6 +32,8 @@ bool verifier_logs;
>  bool relaxed_maps;
>  bool use_loader;
>  struct btf *base_btf;
> +struct btf *relocate_base_btf;
> +const char *relocate_base_btf_path;
>  struct hashmap *refs_table;
>  
>  static void __noreturn clean_and_exit(int i)
> @@ -448,6 +450,7 @@ int main(int argc, char **argv)
>  		{ "debug",	no_argument,	NULL,	'd' },
>  		{ "use-loader",	no_argument,	NULL,	'L' },
>  		{ "base-btf",	required_argument, NULL, 'B' },
> +		{ "relocate-base-btf", required_argument, NULL, 'R' },

And please use tabs here.

Thanks,
Quentin

