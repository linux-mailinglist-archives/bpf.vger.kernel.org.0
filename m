Return-Path: <bpf+bounces-19991-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6D2835B2C
	for <lists+bpf@lfdr.de>; Mon, 22 Jan 2024 07:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA99928749C
	for <lists+bpf@lfdr.de>; Mon, 22 Jan 2024 06:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5232A6FC6;
	Mon, 22 Jan 2024 06:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="b/DuZuKm"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E90AC8FD
	for <bpf@vger.kernel.org>; Mon, 22 Jan 2024 06:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705905850; cv=none; b=l3cSrQDuwkBuDX0fDuT2PXTCVkA/Ac34sjjSifltFVLW3KtDu2c13KSjaUOvjn0S6yhBeucuKVZ0d8LbxxRDvsAoukAQcKfTOj0N51FtRblpSaV7oK6RfpmQzK82wZ9NDZ+ieVLUPNugLg8U2RVWTSXhjOuDToaPBrIPEm2mkkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705905850; c=relaxed/simple;
	bh=uhCfsj0/kIRJ6S2D2OfSX62lncPP1RbH8EQPsZyTC1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QfjQxc7SHp/47wYxwWLSMtn5KJB1qZ6SJfz4ylRLN2KFNJuMA/wf7X+vRYU4GVNW0Mz6ny1f/+0jclppvFPopU+kOMNDwKURrhZOvMMH8XrsoDfBnBisB/WfT3lWgJJJiCaGkzCJgdoeV3ag1qW9SmSEfOkhkKWSFkqbqDGfO1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=b/DuZuKm; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7fb4e5c0-3f9f-428d-80b9-a9727dd1dbd7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705905846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hc0xT3sbjXEDdVB+rz6QMuCn/jZMiSso1kbNgT164Vw=;
	b=b/DuZuKm7tN1IHzkEtDjnBTT7vJQPOlyM4hMeCCeZQd5oU1j+5ObG9TASRPWBDl6WtgLVu
	PwkVuGN+EsAT9Tvo6W416cP9m9SgcHJBcXv08unFFCVbkXVA3CC90KiDCy3OMT3+1aCNSM
	XxPOL99Z4/oQ+jAGnHxga+rLCTWLNPo=
Date: Sun, 21 Jan 2024 22:44:01 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpftool: add support for split BTF to gen
 min_core_btf
Content-Language: en-GB
To: Bryce Kahle <bryce.kahle@datadoghq.com>, bpf@vger.kernel.org
Cc: quentin@isovalent.com, ast@kernel.org, daniel@iogearbox.net
References: <CALvGib8483xSN1VWqxc4XN98k6Di2cNtW76UH_2Vmyft5WQpkQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CALvGib8483xSN1VWqxc4XN98k6Di2cNtW76UH_2Vmyft5WQpkQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 1/19/24 1:18 PM, Bryce Kahle wrote:
> Enables a user to generate minimized kernel module BTF.
>
> If an eBPF program probes a function within a kernel module or uses
> types that come from a kernel module, split BTF is required. The split
> module BTF contains only the BTF types that are unique to the module.
> It will reference the base/vmlinux BTF types and always starts its type
> IDs at X+1 where X is the largest type ID in the base BTF.
>
> Minimization allows a user to ship only the types necessary to do
> relocations for the program(s) in the provided eBPF object file(s). A
> minimized module BTF will still not contain vmlinux BTF types, so you
> should always minimize the vmlinux file first, and then minimize the
> kernel module file.
>
> Example:
>
> bpftool gen min_core_btf vmlinux.btf vm-min.btf prog.bpf.o
> bpftool -B vm-min.btf gen min_core_btf mod.btf mod-min.btf prog.bpf.o
>
> Signed-off-by: Bryce Kahle <bryce.kahle@datadoghq.com>
> ---
>   .../bpf/bpftool/Documentation/bpftool-gen.rst  | 18 +++++++++++++++++-
>   tools/bpf/bpftool/gen.c                        | 17 ++++++++++++-----
>   2 files changed, 29 insertions(+), 6 deletions(-)
>
> diff --git a/tools/bpf/bpftool/Documentation/bpftool-gen.rst
> b/tools/bpf/bpftool/Documentation/bpftool-gen.rst
> index 5006e724d1bc..9c357d339000 100644
> --- a/tools/bpf/bpftool/Documentation/bpftool-gen.rst
> +++ b/tools/bpf/bpftool/Documentation/bpftool-gen.rst
> @@ -16,7 +16,7 @@ SYNOPSIS
>
>    **bpftool** [*OPTIONS*] **gen** *COMMAND*
>
> - *OPTIONS* := { |COMMON_OPTIONS| | { **-L** | **--use-loader** } }
> + *OPTIONS* := { |COMMON_OPTIONS| | { **-B** | **--base-btf** } | {
> **-L** | **--use-loader** } }
>
>    *COMMAND* := { **object** | **skeleton** | **help** }
>
> @@ -202,6 +202,14 @@ OPTIONS
>   =======
>    .. include:: common_options.rst
>
> + -B, --base-btf *FILE*
> +   Pass a base BTF object. Base BTF objects are typically used
> +   with BTF objects for kernel modules. To avoid duplicating
> +   all kernel symbols required by modules, BTF objects for
> +   modules are "split", they are built incrementally on top of
> +   the kernel (vmlinux) BTF object. So the base BTF reference
> +   should usually point to the kernel BTF.
> +
>    -L, --use-loader
>      For skeletons, generate a "light" skeleton (also known as "loader"
>      skeleton). A light skeleton contains a loader eBPF program. It does
> @@ -444,3 +452,11 @@ ones given to min_core_btf.
>     obj = bpf_object__open_file("one.bpf.o", &opts);
>
>     ...
> +
> +Kernel module BTF may also be minimized by using the -B option:
> +
> +**$ bpftool -B 5.4.0-smaller.btf gen min_core_btf 5.4.0-module.btf
> 5.4.0-module-smaller.btf one.bpf.o**
> +
> +A minimized module BTF will still not contain vmlinux BTF types, so you
> +should always minimize the vmlinux file first, and then minimize the
> +kernel module file.
> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> index ee3ce2b8000d..634c809a5173 100644
> --- a/tools/bpf/bpftool/gen.c
> +++ b/tools/bpf/bpftool/gen.c
> @@ -1630,6 +1630,7 @@ static int do_help(int argc, char **argv)
>    "       %1$s %2$s help\n"
>    "\n"
>    "       " HELP_SPEC_OPTIONS " |\n"
> + "                    {-B|--base-btf} |\n"
>    "                    {-L|--use-loader} }\n"
>    "",
>    bin_name, "gen");
> @@ -1695,14 +1696,14 @@ btfgen_new_info(const char *targ_btf_path)
>    if (!info)
>    return NULL;
>
> - info->src_btf = btf__parse(targ_btf_path, NULL);
> + info->src_btf = btf__parse_split(targ_btf_path, base_btf);
>    if (!info->src_btf) {
>    err = -errno;

Looks like you have formating issues here. The proper identation is gone.

>    p_err("failed parsing '%s' BTF file: %s", targ_btf_path, strerror(errno));
>    goto err_out;
>    }
>
> - info->marked_btf = btf__parse(targ_btf_path, NULL);
> + info->marked_btf = btf__parse_split(targ_btf_path, base_btf);
>    if (!info->marked_btf) {
>    err = -errno;
>    p_err("failed parsing '%s' BTF file: %s", targ_btf_path, strerror(errno));

[...]


