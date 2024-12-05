Return-Path: <bpf+bounces-46153-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD789E53BE
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 12:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D54A285C20
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 11:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407581F4290;
	Thu,  5 Dec 2024 11:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kTTGgsHA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BF81E0E16;
	Thu,  5 Dec 2024 11:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733397649; cv=none; b=oUbJCeEFGyC2dwsLAZdp6JINnezhsamqxdNSeO4sY7oJdQdYUW3wQye5+xhGOxOuyhWj66w/GryjfLKHb0xgDHeR7UTob1//6OtXpGZTHl0hF5av22Gw23U0xqfr2cmtIYcMNO+5QIOq77722R8Hu8Af3iZo7+KatQgF/lFdFu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733397649; c=relaxed/simple;
	bh=kShquW8D173tygDwcvyWix8E3OST3cSYanottycigGs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ukYsOI8cYWZvy419TRKXKBPMze4Peap1aAmKaB0kR4cmJiSwnnrtIcY/Vj4MYxY/GdZhE0HG4ZeIOmXeegHYwip+qj5uY/npHjk4edL/WnVteAemxvrX/YZ2D7hzBXzwf2MEqI2ZXTxQ8OgnUnWxThhH17a/VhwWc3iaYhWlgsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kTTGgsHA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A81CFC4CED1;
	Thu,  5 Dec 2024 11:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733397649;
	bh=kShquW8D173tygDwcvyWix8E3OST3cSYanottycigGs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kTTGgsHAbzh3Xe5owtwUPIK8iGPD7RWdE3mZox/dCEdbM7mkFzqNjYiZkXaUizOor
	 A7ywSV+6BbyjntXdy2Mj6BLBPx//DV//ryrGqRdKN4bGyVqYC7PY8LQTNnkSPTHnXf
	 dKhyE3PCHTkqXRSukTXXDO8rlO1t46RZS5OBgZqLQ+y+wSm5uM3S3jDEzi77bF6KLi
	 +5D2kBT3EW15FZsJjZtAvHEq9AcXK8AyUZUFvB/q5j0lIT7ZjW11xUrh/ds21KIo5w
	 97DazKXF0HVGF6nSomE3DSXL3VdLys6Hdtp+4ymZucOGRHG2EWwDB8bej3Zs7BqSZM
	 hUEK0wstxto1g==
Message-ID: <e8d94128-ea41-4e72-83b4-9a6020aaca10@kernel.org>
Date: Thu, 5 Dec 2024 11:20:45 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2] bpftool: Fix gen object segfault
To: Rong Tao <rtoax@foxmail.com>, ast@kernel.org, daniel@iogearbox.net,
 rongtao@cestc.cn
Cc: Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>,
 "open list:BPF [TOOLING] (bpftool)" <bpf@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <tencent_F62A51AFF6A38188D70664421F5934974008@qq.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <tencent_F62A51AFF6A38188D70664421F5934974008@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/12/2024 11:10, Rong Tao wrote:
> From: Rong Tao <rongtao@cestc.cn>
> 
> If the input file and output file are the same, the input file is cleared
> due to opening, resulting in a NULL pointer access by libbpf.
> 
>     $ bpftool gen object prog.o prog.o
>     libbpf: failed to get ELF header for prog.o: invalid `Elf' handle
>     Segmentation fault
> 
>     (gdb) bt
>     #0  0x0000000000450285 in linker_append_elf_syms (linker=0x4feda0, obj=0x7fffffffe100) at linker.c:1296
>     #1  bpf_linker__add_file (linker=0x4feda0, filename=<optimized out>, opts=<optimized out>) at linker.c:453
>     #2  0x000000000040c235 in do_object ()
>     #3  0x00000000004021d7 in main ()
>     (gdb) frame 0
>     #0  0x0000000000450285 in linker_append_elf_syms (linker=0x4feda0, obj=0x7fffffffe100) at linker.c:1296
>     1296		Elf64_Sym *sym = symtab->data->d_buf;
> 
> Signed-off-by: Rong Tao <rongtao@cestc.cn>
> ---
> v1: https://lore.kernel.org/lkml/tencent_410B8166C55CD2AB64BDEA8E92204619180A@qq.com/
> ---
>  tools/bpf/bpftool/gen.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> index 5a4d3240689e..506d205138db 100644
> --- a/tools/bpf/bpftool/gen.c
> +++ b/tools/bpf/bpftool/gen.c
> @@ -1879,6 +1879,8 @@ static int do_object(int argc, char **argv)
>  	struct bpf_linker *linker;
>  	const char *output_file, *file;
>  	int err = 0;
> +	int argc_cpy = argc;
> +	char **argv_cpy = argv;


Oops sorry, argc_cpy and argv_cpy need to be initialised _after_ the
call to GET_ARG() below, otherwise we always start comparing output_file
with itself. Please test this code on your side, too :)

pw-bot: cr


>  
>  	if (!REQ_ARGS(2)) {
>  		usage();
> @@ -1887,6 +1889,14 @@ static int do_object(int argc, char **argv)
>  
>  	output_file = GET_ARG();
>  
> +	/* Ensure we don't overwrite any input file */
> +	while (argc_cpy--) {
> +		if (!strcmp(output_file, *argv_cpy++)) {
> +			p_err("Input and output files cannot be the same");
> +			goto out;
> +		}
> +	}
> +
>  	linker = bpf_linker__new(output_file, NULL);
>  	if (!linker) {
>  		p_err("failed to create BPF linker instance");


