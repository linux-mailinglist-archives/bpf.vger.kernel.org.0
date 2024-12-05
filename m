Return-Path: <bpf+bounces-46149-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F899E52A4
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 11:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF8D9280ED6
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 10:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9021DFE2B;
	Thu,  5 Dec 2024 10:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bRM/7y3f"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B1E1DB956;
	Thu,  5 Dec 2024 10:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733395232; cv=none; b=UAASYUNP5rpPWy8hcV4LtvfgHQX6/E8gApFOnh+wsdQ4cuBq4/PzE17uaZmihhqOnBR/LBMRpUrHVPw5BRIs25JTJrXkFxBUlVRNsXQeM65DoTA6z8AKmUc61tjOyhTz/ODyJS8PB5rqpQC5Bc/fEmZorGCHj78X6atwFPIM6do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733395232; c=relaxed/simple;
	bh=ORSekGk4bOFiPV6otsw59RgRZOUrMWgVuVEVcZLExgo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E+A9bLv3wR25HklvEVFnjQ3DrAwykWtfrLfr5AkVo1E/SaCPEk7Z0lbO3HKOTopMFC/qNKi0e3eSRoHLKeIsx/eb2UlGCZb5eY0aAT5IzfgHJdT1CNdwfNIesBi03/9Wox6v9TL6NKKZx5PH71lSpEqmpqr3lI5/OjLTtFyzD0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bRM/7y3f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64C7AC4CED1;
	Thu,  5 Dec 2024 10:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733395232;
	bh=ORSekGk4bOFiPV6otsw59RgRZOUrMWgVuVEVcZLExgo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bRM/7y3f/MryGKjbTZFCiskiiY2QVswALYCXFiQXLqBA+nqo2bi7UmjFrJ1+RT6WR
	 U8ESHoJB2937mGHfPQ9e2LIymobTTrdaX6CGhB9K3e2Ud5xfrcqWr6bgrQUzGlqcdb
	 GhSxF1YSpdJAwI5QYJ5tiViRT+erR74xrOurfV5yCiCkoZ0eVMoKY2GUZle/JinzvP
	 S/rpnCp8n5KpDyX+aa8IhkIW1rwEosvh02HnRl0zZI7TT8jq37A0gpZAYUiReM3HTU
	 PC2dQPdz26YVFESf+kd367yrta+PgmtHnyYb/2x9/a1KNQA/nbKg3Gz4uC1gi2vh86
	 R3qHx9zj2jD5A==
Message-ID: <2f620bc7-5761-48e4-8568-063136cbf8b8@kernel.org>
Date: Thu, 5 Dec 2024 10:40:27 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpftool: Fix gen object segfault
To: Rong Tao <rtoax@foxmail.com>, rongtao@cestc.cn, ast@kernel.org
Cc: Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>,
 "open list:BPF [TOOLING] (bpftool)" <bpf@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <tencent_410B8166C55CD2AB64BDEA8E92204619180A@qq.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <tencent_410B8166C55CD2AB64BDEA8E92204619180A@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/12/2024 09:08, Rong Tao wrote:
> From: Rong Tao <rongtao@cestc.cn>
> 
> If the input file and output file are the same, the input file is cleared
> due to opening, resulting in a NULL pointer access by libbpf.
> 
>     $ sudo ./bpftool gen object prog.o prog.o


(No sudo required to generate object files)


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
>  tools/bpf/bpftool/gen.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> index 5a4d3240689e..4cd135726758 100644
> --- a/tools/bpf/bpftool/gen.c
> +++ b/tools/bpf/bpftool/gen.c
> @@ -1896,6 +1896,11 @@ static int do_object(int argc, char **argv)
>  	while (argc) {
>  		file = GET_ARG();
>  
> +		if (!strcmp(file, output_file)) {
> +			p_err("Input/Output file couldn't be same.");


Nits: lowercase for "output", and "cannot" rather than "couldn't"; also
bpftool doesn't use periods at the end of error messages:

    p_err("Input and output files cannot be the same");


> +			goto out;
> +		}
> +
>  		err = bpf_linker__add_file(linker, file, NULL);
>  		if (err) {
>  			p_err("failed to link '%s': %s (%d)", file, strerror(errno), errno);


Good catch, thank you for this!

I've got one concern though, while your patch addresses the segfault it
doesn't prevent the user from overwriting the input file. Could we
instead move the check above the call to bpf_linker__new(...), please?
Something like this:

	int argc_cpy = argc;
	char **argv_cpy = argv;

	[...]
	output_file = GET_ARG();

	/* Ensure we don't overwrite any input file */
	while (argc_cpy--) {
		if (!strcmp(output_file, *argv_cpy++)) {
			p_err("...");
			goto out;
		}
	}

	linker = ...

Thanks,
Quentin

pw-bot: cr

