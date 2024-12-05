Return-Path: <bpf+bounces-46161-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 009C39E554A
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 13:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15E1616B9BF
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 12:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F92B217F5D;
	Thu,  5 Dec 2024 12:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l3w5duU8"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EE51C3C03;
	Thu,  5 Dec 2024 12:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733401364; cv=none; b=sHlTzGnXVRJV0qNkJRYHkwVqpsByFkUUUSUnK8qjhiDhhWZKsgKGZD85vzx9LZHuNGHNOEc2BaFqAgnD39wq32DpOgBVhiEnGXbRZctMyLWVMXgnfKUko1x8wp1CuFIEV5EFLA5Yr8DrD1guYxbd7pdvxaNXaWh0L4zh38K7rKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733401364; c=relaxed/simple;
	bh=iw+41GhAQsdhxc08dK9RKaw/CEStYopM8Vlb/tDQzPQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s6sMOiF1htYQW13n/DskoaSXqrNCBbkOUNi66V5XNJhcmmfbvjvi2Vi2HgwuOFrwsyhXVpeCKhfWvX92iSOwgtDtCTRVHe/Ygwo7+AQOnh5k6Ni+/PMWLJ1SZFXf7pf+SmkdEAj606RCigqRUWK4XJ9MxFd/syGAhs/FC3MKagM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l3w5duU8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3F17C4CEDC;
	Thu,  5 Dec 2024 12:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733401363;
	bh=iw+41GhAQsdhxc08dK9RKaw/CEStYopM8Vlb/tDQzPQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=l3w5duU8tArKzpYorRiEnwh5tHgC87/epftZLhR3fJXmsrSAKNwq8x/7e+3y/Qh4i
	 sPNmKEwMFEFnjD+5stcBQybSFX+zjuvYRt8yCoHk7SltC69m/ftuIhPAD3QgD7FCOF
	 hOqpBHcyihihmCOV9V9+bEmRsle5Mu0klOq7JXDPGxSHk3dATbeN0JTEJHHo8gqG0Y
	 m018CUecanU+7L9kJUoob+vbdgT6VCvVnEmZ28kLWl8anQ2b/jKUUwNIZEdBdSLO2P
	 aYF45W2lKmLTthLlXxzIXHpCJTgI+AqekHxKhL8xB3kwUf9X2HBA4Xsnx7Oe2n100J
	 7XQVPPP3fgo9Q==
Message-ID: <0b96aa24-13ca-4e0a-8e80-f2586fbe2b57@kernel.org>
Date: Thu, 5 Dec 2024 12:22:39 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3] bpftool: Fix gen object segfault
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
References: <tencent_A7A870BF168D6A21BA193408D5645D5D920A@qq.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <tencent_A7A870BF168D6A21BA193408D5645D5D920A@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/12/2024 12:09, Rong Tao wrote:
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

Tested-by: Quentin Monnet <qmo@kernel.org>
Reviewed-by: Quentin Monnet <qmo@kernel.org>

Thank you!

