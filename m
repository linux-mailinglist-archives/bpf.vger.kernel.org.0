Return-Path: <bpf+bounces-18394-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5E781A230
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 16:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E03AE1F24FF5
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 15:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B071D3FB32;
	Wed, 20 Dec 2023 15:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="aLTXRI7C"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8E745C00;
	Wed, 20 Dec 2023 15:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=0qtJ6cMiPjn508wgVFzs9dwMKKbw6Wwcn8Pqm15SfEY=; b=aLTXRI7C0yKWj7DiSr3D0IsTWU
	NUzhkcGUDt2+2T50NiL70IcSfapPJBugj59JGCE3jLztW9HC+irv76OkHxmtRXrXWdo84h9iyd+XY
	5hewJNM0xOw4Vj5ORHbWFCww3Fn8hf8jhf8PTHozbdMnzQvvEkuyAhasJSavmiGkAlZwNAWh7/uCi
	cCa5fXY/pmnUxGg0ylkXn39YBR4bJmmqSYTVGGuOBVuR1KfFa0hP6LfCOYvWcN3ZGYs+/13u6NyPy
	oeVLjvSCHxNfaWrZSeECYy/obiNwJ1wF26pbIE+7zF3HCTkfH2R90JU/nt/lAQZ4f8jZi5TAgoH07
	Kp9H8u2Q==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rFyKu-000NpG-NP; Wed, 20 Dec 2023 16:18:16 +0100
Received: from [178.197.249.36] (helo=linux.home)
	by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1rFyKt-0007Lg-Nv; Wed, 20 Dec 2023 16:18:15 +0100
Subject: Re: [PATCH] fix null pointer dereference in
 bpf_object__collect_prog_relos
To: Xin Liu <liuxin350@huawei.com>, ast@kernel.org, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, yanan@huawei.com,
 wuchangye@huawei.com, xiesongyang@huawei.com, kongweibin2@huawei.com,
 tianmuyang@huawei.com, zhangmingyi5@huawei.com
References: <20231220134151.144224-1-liuxin350@huawei.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <fb06f00f-4a82-4b78-928e-775edd6340d0@iogearbox.net>
Date: Wed, 20 Dec 2023 16:18:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231220134151.144224-1-liuxin350@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27129/Wed Dec 20 10:38:37 2023)

On 12/20/23 2:41 PM, Xin Liu wrote:
> From: zhangmingyi <zhangmingyi5@huawei.com>

Small nits only, otherwise lgtm.

Please prefix subject with libbpf e.g. the full one should look like
"libbpf: Fix NULL pointer dereference in bpf_object__collect_prog_relos"

> a issue occurred while reading an ELF file in libbpf.c during fuzzing:

"An issue [...]"

> 	Program received signal SIGSEGV, Segmentation fault.
> 	0x0000000000958e97 in bpf_object.collect_prog_relos () at libbpf.c:4206
> 	4206 in libbpf.c
> 	(gdb) bt
> 	#0 0x0000000000958e97 in bpf_object.collect_prog_relos () at libbpf.c:4206
> 	#1 0x000000000094f9d6 in bpf_object.collect_relos () at libbpf.c:6706
> 	#2 0x000000000092bef3 in bpf_object_open () at libbpf.c:7437
> 	#3 0x000000000092c046 in bpf_object.open_mem () at libbpf.c:7497
> 	#4 0x0000000000924afa in LLVMFuzzerTestOneInput () at fuzz/bpf-object-fuzzer.c:16
> 	#5 0x000000000060be11 in testblitz_engine::fuzzer::Fuzzer::run_one ()
> 	#6 0x000000000087ad92 in tracing::span::Span::in_scope ()
> 	#7 0x00000000006078aa in testblitz_engine::fuzzer::util::walkdir ()
> 	#8 0x00000000005f3217 in testblitz_engine::entrypoint::main::{{closure}} ()
> 	#9 0x00000000005f2601 in main ()
> 	(gdb)
> 
> scn_data was null at this code(tools/lib/bpf/src/libbpf.c):
> 
> 	if (rel->r_offset % BPF_INSN_SZ || rel->r_offset >= scn_data->d_size) {
> 
> The scn_data is derived from the code above:
>      
> 	scn = elf_sec_by_idx(obj, sec_idx);
> 	scn_data = elf_sec_data(obj, scn);
> 
> 	relo_sec_name = elf_sec_str(obj, shdr->sh_name);
> 	sec_name = elf_sec_name(obj, scn);
> 	if (!relo_sec_name || !sec_name)// don't check whether scn_data is NULL
> 		return -EINVAL;
> 
> In certain special scenarios, such as reading a malformed ELF file,
> it is possible that scn_data may be a null pointer
> 
> Signed-off-by: zhangmingyi  <zhangmingyi5@huawei.com>

Zhang Mingyi <zhangmingyi5@huawei.com> ?

If that is correct, please also make sure that this is the same in From: line.

> Signed-off-by: Xin Liu <liuxin350@huawei.com>
> Signed-off-by: Changye Wu <wuchangye@huawei.com>
> ---
>   tools/lib/bpf/libbpf.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index e067be95da3c..df1b550f7460 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -4344,6 +4344,8 @@ bpf_object__collect_prog_relos(struct bpf_object *obj, Elf64_Shdr *shdr, Elf_Dat
>   
>   	scn = elf_sec_by_idx(obj, sec_idx);
>   	scn_data = elf_sec_data(obj, scn);
> +	if (!scn_data)
> +		return -LIBBPF_ERRNO__FORMAT;
>   
>   	relo_sec_name = elf_sec_str(obj, shdr->sh_name);
>   	sec_name = elf_sec_name(obj, scn);
> 


