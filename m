Return-Path: <bpf+bounces-46156-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E989E54DA
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 13:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6149286D5C
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 12:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D12217706;
	Thu,  5 Dec 2024 12:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="n1X0GaFu"
X-Original-To: bpf@vger.kernel.org
Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DFA212B0A;
	Thu,  5 Dec 2024 12:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733400141; cv=none; b=fAjqR/BcTvYk7Oa/pTdqXexqPoNlbt3UQlqvbNacts+ujexytEdxyB1zwUI+5I91+BbhV6kKUDdHK8GA1yyV1LxmNOJy39I9ludliQVPFy6qTvHX643eI7yCZ3L0ngu8sDI5ii7uptTKMT5pW2E+rID6Pm1YL2VOXj+r7TKZzSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733400141; c=relaxed/simple;
	bh=rKZB8eOnyKwtWssMKLG37zWz+7Nre99PZ2G0rsOt0x8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fznNh0HBbcLOK+1IaJNcTY6MVIIfHyjta1efFJBR9r9H+Zbz9uvJzoHtVdALnFn7swiT/VSoNk/UMe0Clh95daIJrIpqYzTK4D5MCRwLaYFufQyGigEoDd4vk/Tsi2IGHKo9rtMvRvMOrWdzTKamTA8NJrlTDNkCL3mnMdPvQ3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=n1X0GaFu; arc=none smtp.client-ip=203.205.221.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1733400134;
	bh=pQ/CY49J5z1LDtCHFpuwhlm1ryazmeF++8881pRdgxQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=n1X0GaFujagDzYAW7MLsSF6V020HDy1VzeduM94O2lN7Jbum0WiZQRnxWLROfzi1s
	 pMQ5kxzfwR/FHOWV9wwzXTjddWBfHsB2H833bZzpWMIgFROZOnu/1E6D5RXAj7hNcN
	 wEL2pq3ivy81XQalFpJ5ZcCC8Gk7wqevkenVjVfQ=
Received: from [10.56.52.9] ([39.156.73.10])
	by newxmesmtplogicsvrsza15-1.qq.com (NewEsmtp) with SMTP
	id 8ABBE23; Thu, 05 Dec 2024 20:02:10 +0800
X-QQ-mid: xmsmtpt1733400130t9h70yhmo
Message-ID: <tencent_678AD9EBC6E82CE286C1AD1079D6CBA58506@qq.com>
X-QQ-XMAILINFO: NkHKfw09D6j8lYbES8kbQ6GnJsjPBXRxkIxoFVHyntw0bhJ4VULfJExzEOhbkO
	 76JkU7vaSmcM1GPBCjYcLvGN7BeuVQJKnV8g32p+hNw9PyidXhwEKSJafdPLT25Xcefw+svd5GOz
	 xOyPuuhXlNqRdvEJSF6+m4Hun42Nd1Qi0HnCCpeqNOBWuipWVDUdG8mJRSS98ikFUUIWmvNS8Jty
	 b2mcPFCuSi24lAIfW52U73WODFOvw5lqEJeVGNQsXZ9Q2vdO9Wy4O47EZhubhDhmOp6AX5fKU8zH
	 GIILtfzNX7QlB2iPCb8oHwNQyX+p0QANUiPKQ2O42k0rfNtG+JfsVlptARuTrKtpFwRpU/cGb5Ph
	 LP+OyqSpsFU1lVnJst7zHQ1H6//XCUXeQ44F30eovF/DASSXizLr0kdshs/A7Lji4oPqxiWEq1rZ
	 hcHLlxgPIpkCaGZ2q4KAv0jsGm8mMXLG3EiwOBLYG7uyjErFfxhlpzygnQGIoUwdutKaVLN8hN9u
	 IMdLCivntCCxMg2gvU9PajwDKXnWnSy1SGaTntzYoF7WHSX9zBXpEwCgjoh5Hvnt03zuCcHGhJjs
	 Le8tRY7xrqg+Vom+a0c9hyM/K/ve+bwVfEJII4Pu9bUa0QGTl8C2z3fY8HpHt+MAuTVuxBVHsQq9
	 QddoWbUyYwOT+FD6xFOUBaxt0AoESpF5PLFO9LQR0n00KxZWxa1p4Js5gkNLX/6r1piBPuaYaOrY
	 oF9IC/ByIPfanSBfnTGvi05z/cb1GNtmKDwdwMk1UHeRwAaySUtjxoW3R5O2hS53pRDBwEdPIo2O
	 xNLppWR/z7a7Ed5ZWcwztrfTjoETXSlwWQsIzV9ANuIXVAkPdmbpz9+PQ7ny8ov5a78IQdeiQHu/
	 2aACcNxBh5Ukh3e9CJPavEbkMFc1XsE8TlfzXh5uITLxBM/wcCxmk9o/be+w/k6EJ8Kd7Fzl6gDa
	 zicuq1Ilgk3WlFReCC7nmFsK2qzUeK
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-OQ-MSGID: <57aedc13-42da-4032-a9f9-f12571f570d6@foxmail.com>
Date: Thu, 5 Dec 2024 20:02:10 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2] bpftool: Fix gen object segfault
To: Quentin Monnet <qmo@kernel.org>, ast@kernel.org, daniel@iogearbox.net,
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
 <e8d94128-ea41-4e72-83b4-9a6020aaca10@kernel.org>
Content-Language: en-US
From: Rong Tao <rtoax@foxmail.com>
In-Reply-To: <e8d94128-ea41-4e72-83b4-9a6020aaca10@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 12/5/24 19:20, Quentin Monnet wrote:
> On 05/12/2024 11:10, Rong Tao wrote:
>> From: Rong Tao <rongtao@cestc.cn>
>>
>> If the input file and output file are the same, the input file is cleared
>> due to opening, resulting in a NULL pointer access by libbpf.
>>
>>      $ bpftool gen object prog.o prog.o
>>      libbpf: failed to get ELF header for prog.o: invalid `Elf' handle
>>      Segmentation fault
>>
>>      (gdb) bt
>>      #0  0x0000000000450285 in linker_append_elf_syms (linker=0x4feda0, obj=0x7fffffffe100) at linker.c:1296
>>      #1  bpf_linker__add_file (linker=0x4feda0, filename=<optimized out>, opts=<optimized out>) at linker.c:453
>>      #2  0x000000000040c235 in do_object ()
>>      #3  0x00000000004021d7 in main ()
>>      (gdb) frame 0
>>      #0  0x0000000000450285 in linker_append_elf_syms (linker=0x4feda0, obj=0x7fffffffe100) at linker.c:1296
>>      1296		Elf64_Sym *sym = symtab->data->d_buf;
>>
>> Signed-off-by: Rong Tao <rongtao@cestc.cn>
>> ---
>> v1: https://lore.kernel.org/lkml/tencent_410B8166C55CD2AB64BDEA8E92204619180A@qq.com/
>> ---
>>   tools/bpf/bpftool/gen.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
>> index 5a4d3240689e..506d205138db 100644
>> --- a/tools/bpf/bpftool/gen.c
>> +++ b/tools/bpf/bpftool/gen.c
>> @@ -1879,6 +1879,8 @@ static int do_object(int argc, char **argv)
>>   	struct bpf_linker *linker;
>>   	const char *output_file, *file;
>>   	int err = 0;
>> +	int argc_cpy = argc;
>> +	char **argv_cpy = argv;
>
> Oops sorry, argc_cpy and argv_cpy need to be initialised _after_ the
> call to GET_ARG() below, otherwise we always start comparing output_file
> with itself. Please test this code on your side, too :)
>
> pw-bot: cr

Sorry, i just test this patch in [1], and it's works, maybe the 
compile-flags is differenet.

I'll fix this and submit v2 soon, thanks!!

[1] https://github.com/libbpf/bpftool

>
>>   
>>   	if (!REQ_ARGS(2)) {
>>   		usage();
>> @@ -1887,6 +1889,14 @@ static int do_object(int argc, char **argv)
>>   
>>   	output_file = GET_ARG();
>>   
>> +	/* Ensure we don't overwrite any input file */
>> +	while (argc_cpy--) {
>> +		if (!strcmp(output_file, *argv_cpy++)) {
>> +			p_err("Input and output files cannot be the same");
>> +			goto out;
>> +		}
>> +	}
>> +
>>   	linker = bpf_linker__new(output_file, NULL);
>>   	if (!linker) {
>>   		p_err("failed to create BPF linker instance");


