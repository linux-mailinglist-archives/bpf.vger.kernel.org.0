Return-Path: <bpf+bounces-18302-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 124DC818ACD
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 16:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B530B28240A
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 15:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEAF71C2BB;
	Tue, 19 Dec 2023 15:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="kC04D1U+"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF41B1D522;
	Tue, 19 Dec 2023 15:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=R/vmasdD8C/Es8rulSddoTxa2akPlp14LR49UBKvGpo=; b=kC04D1U+4Y9zUcVFKdmmPo0gy6
	woG+GGzBGaMYwqOH5X7HSeErMYRCvyVVyD/HyeuvOOPqO2FGS2+YLr/WJ2FFpuNcmw623aTwtodlx
	a4Pr6Vz8REG0vms+k+/NqzND5kSsAHdIREznsyMKsmY6/OTlQRvhfsdj4PV2eafI1josgmhSQzny0
	qlW71qOAH1mms1s8/108G6XFRmVArKlCZNbv/q2l0g8VOOyiS+g4G5sCTvhlPdY3pzCFq9IJfVNGp
	gr6zSo5Odwhj36Yg4gcCMH1UGVixqyncMflHs0Ar28Z7vNzmGkIacHAQ1Vzt/y+33sG71Ck1UPZ5D
	fE7H4KIw==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rFbgT-000LRB-3J; Tue, 19 Dec 2023 16:07:01 +0100
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1rFbgR-00005I-Vs; Tue, 19 Dec 2023 16:07:00 +0100
Subject: Re: An invalid memory access was discovered by a fuzz test
To: Xin Liu <liuxin350@huawei.com>, ast@kernel.org, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, yanan@huawei.com,
 wuchangye@huawei.com, xiesongyang@huawei.com, kongweibin2@huawei.com,
 tianmuyang@huawei.com, zhangmingyi5@huawei.com
References: <20231219141544.128812-1-liuxin350@huawei.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <42e69551-5675-de6e-e679-652dbc3d6146@iogearbox.net>
Date: Tue, 19 Dec 2023 16:06:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231219141544.128812-1-liuxin350@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27128/Tue Dec 19 10:36:48 2023)

On 12/19/23 3:15 PM, Xin Liu wrote:
> Hi all:
> 
> The issue occurred while reading an ELF file in libbpf.c during fuzzing
> 
>      Using host libthread_db library "/usr/lib64/libthread_db.so.1".
>      0.000243187s DEBUG total counters = 7816
>      0.000346533s DEBUG binary maps to 400000-155f280, len = 18215552
>      0.000765462s DEBUG init_fuzzer:run_seed: running initial seed path="crash-sigsegv-b905489aaeb39555ff1245117f1efd1677195b9ac1437bfb18b8d2d04099704b"
> 
>      Program received signal SIGSEGV, Segmentation fault.
>      0x0000000000958e97 in bpf_object.collect_prog_relos () at libbpf.c:4206
>      4206 in libbpf.c
>      (gdb) bt
>      #0 0x0000000000958e97 in bpf_object.collect_prog_relos () at libbpf.c:4206
>      #1 0x000000000094f9d6 in bpf_object.collect_relos () at libbpf.c:6706
>      #2 0x000000000092bef3 in bpf_object_open () at libbpf.c:7437
>      #3 0x000000000092c046 in bpf_object.open_mem () at libbpf.c:7497
>      #4 0x0000000000924afa in LLVMFuzzerTestOneInput () at fuzz/bpf-object-fuzzer.c:16
>      #5 0x000000000060be11 in testblitz_engine::fuzzer::Fuzzer::run_one ()
>      #6 0x000000000087ad92 in tracing::span::Span::in_scope ()
>      #7 0x00000000006078aa in testblitz_engine::fuzzer::util::walkdir ()
>      #8 0x00000000005f3217 in testblitz_engine::entrypoint::main::{{closure}} ()
>      #9 0x00000000005f2601 in main ()
>      (gdb)
> 
> then, I checked the code and found that scn_data was null at this code(tools/lib/bpf/src/libbpf.c):
> 
>      if (rel->r_offset % BPF_INSN_SZ || rel->r_offset >= scn_data->d_size) {
>      
> The scn_data is derived from the code above:
>      
>      scn = elf_sec_by_idx(obj, sec_idx);
>      scn_data = elf_sec_data(obj, scn);
>      
>      relo_sec_name = elf_sec_str(obj, shdr->sh_name);
>      sec_name = elf_sec_name(obj, scn);
>      if (!relo_sec_name || !sec_name)    // don't check whether scn_data is NULL
>      	return -EINVAL;
> 
> Do sec_data and sec_name always occur together? Is it possible that scn_data is NULL but sec_name
> is not NULL? libbpf uses sec_name to determine if it’s a null pointer, Maybe we should do some
> check here.

Weird, is this based on a malformed elf given sec_idx comes from shdr->sh_info?
It probably makes sense to NULL check and then return with -LIBBPF_ERRNO__FORMAT
as we do elsewhere. Do you want to send a fix?

Thanks,
Daniel

