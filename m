Return-Path: <bpf+bounces-46154-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E534E9E53D2
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 12:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CC0E16AAFB
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 11:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F9A2066E7;
	Thu,  5 Dec 2024 11:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="xHWWA7eq"
X-Original-To: bpf@vger.kernel.org
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3531A1F03FF;
	Thu,  5 Dec 2024 11:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733397791; cv=none; b=CM5fbfU7UfC3I0PqS8GCUoIAX8G8Za201qYo0qeWSXkfIjKYYAdracIU39RN22bKMalZAzxjyLrz+vObXncNrTRBOZQRWGE7rpkmDhGsR4f3FNfNBO7Xypg3ZTBhtLyaf1Pr+GAeN+1OazaDHKX+qzaX/BAGi5e4CAtiwjSsewk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733397791; c=relaxed/simple;
	bh=AKbNLvuXbkGgKqXPc7Lf2IYDcrfIDsDLxC7WOjEZ6y8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EOHsDT1o6T+jctP+9EZ3tu5Tw8iDTsd6I2/hk6T80R7Gq0uGIT4VjyGyaOmRlc3TyTm1ML91DlZXN5ujT5dCJ/ekIWhAWBTc+EYqRcBFEqRJYQQ1RlOFDuD94KDEdFooyUfNKnNM4dbm2LL6TcO0sXRdjgEPEAHTgxOtunUAI9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=xHWWA7eq; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1733397784;
	bh=bU5O7EeLJDY1u3LGXX5bi7yZ3FK5EaqG/PRcIv0xo/A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=xHWWA7eq01hhcz/+7012QjseYZmoh69pLj+8RaiB0K1BknMuOWzcdqKCrzmU5afnS
	 I588M6yHSnmvQxBED6X7uR4wZkX6lXeZgGX2/OL1LUAweKz4GR7lu+6CnKtggfJH1w
	 rMg0BYnNWMyB9oBijjVGcSFimnstquOT8yTX0HJQ=
Received: from [10.56.52.9] ([39.156.73.10])
	by newxmesmtplogicsvrszb21-0.qq.com (NewEsmtp) with SMTP
	id 39EA325C; Thu, 05 Dec 2024 19:14:30 +0800
X-QQ-mid: xmsmtpt1733397270t0o5pxa5q
Message-ID: <tencent_BA5119C43D830721CD2CAE4B6D95DC57EC07@qq.com>
X-QQ-XMAILINFO: OGZxhFXqN7PJXbnK1yfvF0mOINQkksYzSjXuIuCUQFEeD+tH5yKwunrAIyU1Pb
	 UoqRleBzkgkhaGsS6729XVKJ03naKEEkJwYK+EJOW9NX3DyVPS7IXPoP94ft1usKIZYNqzSrchYQ
	 Sr59zYDxL/p/X84l6I9AoT+TURlWM/ffnOyGow/WJTGzeTNZMbeVjHjzxgSgLtbtOQpsrDxzysDf
	 LLRHVfgpDsXTaOAB+u7ZpY4vWI0FLtoywBkLhHGRC/BphfJrKJ8xjtThYn/Yd39gnrAu33SiF5zQ
	 9TKTSaT4zufoMOhW4UIyCYFVcvGmAaPdZMOcGDymRt3z2QPZ2RR+gyIfndbSxgIxJzqn5tj/tAoi
	 t6dbuplufZ+D9k+u6Nd4gg68COOgWA8sh/wqN0sdR8GELFHqXlgcYmdMncPAUdpZt49ZcXuy3Nvt
	 VsSb7UbFFx9tbgLCAGbh/ty1vXbwTi7f9XgN0kP1y87l5IYWJkfCwaAKOvK9+oAbxOzyvWgIqZct
	 d443nH8QJVl653mxoEWphFcupsb2zeQ4SH+nyOTbZRoLiQ5JD+VsOFOK6z4oSI4k5lgwnetkwDw4
	 XgexQbEQRLv1NIpfHHVbBMLsLXK+BMSBpwkfWKdF2gR3k2SlXnU4pnNeU+4TuRrwsfvHrW3kwyRL
	 B+fmHaDin918EOUfM+RcR4FHLISU4CEVnPrdxiAOEAl2T9Fb76dGbfFXKV0UKeMxWB9W0Q5oN7Ps
	 hb+ASZHY8H8SuAEfE0xZAiZubSxthalyoBJlE96ZSf/rgY9U92n6wWr+rrnF5fozPRxSOLxV/QJr
	 jGLTAAero/+UBo8Iy2GgUZPMCmFZNh0eIhBTbySWou/WALRZOLXUcXj10PG8Mqt3/rGyKrAln98c
	 EkHPnzbxhGvqtaKrKUenpp+9qvL1M55W3/JIWhOLl63n1eLmBTtepS8UFiunC4eLXKOOcHo3EhGy
	 J83RGi4GJER1wiHXS40JWvxBQpbYEUS+FBnQEyyU4oMRelUXMJx8NmrUv7SIJLf5Yz39iCUzU=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-OQ-MSGID: <a92599d0-6f85-4adb-909e-0bae725fdc56@foxmail.com>
Date: Thu, 5 Dec 2024 19:14:29 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpftool: Fix gen object segfault
To: Quentin Monnet <qmo@kernel.org>, rongtao@cestc.cn, ast@kernel.org
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
 <2f620bc7-5761-48e4-8568-063136cbf8b8@kernel.org>
Content-Language: en-US
From: Rong Tao <rtoax@foxmail.com>
In-Reply-To: <2f620bc7-5761-48e4-8568-063136cbf8b8@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 12/5/24 18:40, Quentin Monnet wrote:
> On 05/12/2024 09:08, Rong Tao wrote:
>> From: Rong Tao <rongtao@cestc.cn>
>>
>> If the input file and output file are the same, the input file is cleared
>> due to opening, resulting in a NULL pointer access by libbpf.
>>
>>      $ sudo ./bpftool gen object prog.o prog.o
>
> (No sudo required to generate object files)
>
>
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
>>   tools/bpf/bpftool/gen.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
>> index 5a4d3240689e..4cd135726758 100644
>> --- a/tools/bpf/bpftool/gen.c
>> +++ b/tools/bpf/bpftool/gen.c
>> @@ -1896,6 +1896,11 @@ static int do_object(int argc, char **argv)
>>   	while (argc) {
>>   		file = GET_ARG();
>>   
>> +		if (!strcmp(file, output_file)) {
>> +			p_err("Input/Output file couldn't be same.");
>
> Nits: lowercase for "output", and "cannot" rather than "couldn't"; also
> bpftool doesn't use periods at the end of error messages:
>
>      p_err("Input and output files cannot be the same");
>
>
>> +			goto out;
>> +		}
>> +
>>   		err = bpf_linker__add_file(linker, file, NULL);
>>   		if (err) {
>>   			p_err("failed to link '%s': %s (%d)", file, strerror(errno), errno);
>
> Good catch, thank you for this!
>
> I've got one concern though, while your patch addresses the segfault it
> doesn't prevent the user from overwriting the input file. Could we
> instead move the check above the call to bpf_linker__new(...), please?
> Something like this:
>
> 	int argc_cpy = argc;
> 	char **argv_cpy = argv;
>
> 	[...]
> 	output_file = GET_ARG();
>
> 	/* Ensure we don't overwrite any input file */
> 	while (argc_cpy--) {
> 		if (!strcmp(output_file, *argv_cpy++)) {
> 			p_err("...");
> 			goto out;
> 		}
> 	}

Thanks a lot, I just submit v2, please review!!

Rong Tao

>
> 	linker = ...
>
> Thanks,
> Quentin
>
> pw-bot: cr


