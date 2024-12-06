Return-Path: <bpf+bounces-46253-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BBF9E6C2B
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 11:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55B311885EE2
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 10:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C8F1FF7B0;
	Fri,  6 Dec 2024 10:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QgNKkgPN"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD5E1FCF6C;
	Fri,  6 Dec 2024 10:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733480608; cv=none; b=dAJsWHhpBuARxxAu0aeSB6QthUQB0GChL4RTELWQgoGZLwNU7avb/OIWCMXjiZ5Le1ulIAqII/o17j4dFYhKFPQQw8AyGt/poGbL3merZLd3Ijn8YYG4FsmUSEMkrOPtbUJbgwOqNVFrXXm+BPZu2Oq6E+8737xEISbViUJ2+HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733480608; c=relaxed/simple;
	bh=F/jXH7kKA5jvf6NRT4P2cfIO7UZfrKllBmaBbhxhwis=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=irsj+S2XrnImN8k6HuF3wuxD/7JP4vlB/F2W5Lk8p2oSG8nwYmFRagbKuzTkjexFgtDgTs5yYiZW2AtXV15LUvJEG8lfHebjPP3iA/0kjg9e+R7rfesNGhmvME5M4nvImFRLzUnej7kj4z2AyPGZegvqYzmtpr/7D3jr+ZKEWl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QgNKkgPN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 313C7C4CEDE;
	Fri,  6 Dec 2024 10:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733480607;
	bh=F/jXH7kKA5jvf6NRT4P2cfIO7UZfrKllBmaBbhxhwis=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QgNKkgPNyOSBMvthDEYv9PaeVu7w20++VFlGSN5i7eJg+vLvD5pq5C1rEhinUBBPJ
	 pLZgb/nHZHKty0MAoQjYeRM+HG7zilGMjR9Yzn7yiNY3IAnTseCuoQKxd8G9nziozY
	 LPIMU6EH0eOW80lDIzQ7f3ENovHWzdTMiz3k8U8faUpizYBg2WUEKQIXuRgLuVYDhs
	 o/Y0qf2HMTLetAuHNyiPpsOcJJsk1Qi4oJgXJuDdlv+4+Bj7iykrjwAxd7Hn9kBZko
	 2TLbHBDqMpdNGfXT47k4UF4eV4kVeQ3A2iELEqTpU+1YbrlBACrQ96imbF4ts9/N2o
	 7XIfJEqFW/90w==
Message-ID: <e61b6151-43fd-4282-8440-dfee2aad3c1c@kernel.org>
Date: Fri, 6 Dec 2024 10:23:22 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3] bpftool: Fix gen object segfault
To: Rong Tao <rtoax@foxmail.com>, Andrii Nakryiko
 <andrii.nakryiko@gmail.com>, alexei.starovoitov@gmail.com
Cc: ast@kernel.org, daniel@iogearbox.net, rongtao@cestc.cn,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <tencent_A7A870BF168D6A21BA193408D5645D5D920A@qq.com>
 <0b96aa24-13ca-4e0a-8e80-f2586fbe2b57@kernel.org>
 <CAEf4BzbLmXF9XB=fBvL7NLMoPmfD=DFFvuM8Fw5h6T7vfFXUFg@mail.gmail.com>
 <tencent_0F0D028440B2BE2E37547C5EFF467511FD09@qq.com>
 <77c9f13e-0162-4e92-b0b8-531122ab0f5e@kernel.org>
 <tencent_2AC9A80622AF8180D05996E4E58A4AE6EB06@qq.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <tencent_2AC9A80622AF8180D05996E4E58A4AE6EB06@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

2024-12-06 10:22 UTC+0800 ~ Rong Tao <rtoax@foxmail.com>
> 
> On 12/6/24 09:56, Quentin Monnet wrote:
>> 2024-12-06 09:11 UTC+0800 ~ Rong Tao <rtoax@foxmail.com>
>>> On 12/6/24 05:34, Andrii Nakryiko wrote:
>>>> On Thu, Dec 5, 2024 at 4:22 AM Quentin Monnet <qmo@kernel.org> wrote:
>>>>> On 05/12/2024 12:09, Rong Tao wrote:
>>>>>> From: Rong Tao <rongtao@cestc.cn>
>>>>>>
>>>>>> If the input file and output file are the same, the input file is
>>>>>> cleared
>>>>>> due to opening, resulting in a NULL pointer access by libbpf.
>>>>>>
>>>>>>       $ bpftool gen object prog.o prog.o
>>>>>>       libbpf: failed to get ELF header for prog.o: invalid `Elf'
>>>>>> handle
>>>>>>       Segmentation fault
>>>>>>
>>>>>>       (gdb) bt
>>>>>>       #0  0x0000000000450285 in linker_append_elf_syms
>>>>>> (linker=0x4feda0, obj=0x7fffffffe100) at linker.c:1296
>>>>>>       #1  bpf_linker__add_file (linker=0x4feda0, filename=<optimized
>>>>>> out>, opts=<optimized out>) at linker.c:453
>>>>>>       #2  0x000000000040c235 in do_object ()
>>>>>>       #3  0x00000000004021d7 in main ()
>>>>>>       (gdb) frame 0
>>>>>>       #0  0x0000000000450285 in linker_append_elf_syms
>>>>>> (linker=0x4feda0, obj=0x7fffffffe100) at linker.c:1296
>>>>>>       1296              Elf64_Sym *sym = symtab->data->d_buf;
>>>>>>
>>>>>> Signed-off-by: Rong Tao <rongtao@cestc.cn>
>>>>> Tested-by: Quentin Monnet <qmo@kernel.org>
>>>>> Reviewed-by: Quentin Monnet <qmo@kernel.org>
>>>> Isn't this papering over a deeper underlying issue? Why do we get
>>>> SIGSEGV inside the linker at all instead of just erroring out?
>>>> Comparison based on file path isn't a reliable way to check if input
>>>> and output are both the same file, so this fixes the most obvious
>>>> case, but not the actual issue.
>>> Thanks for your replay! The current scenario is similar to the following
>>> code.
>>> After a.txt is opened in read mode, it is opened in write mode again,
>>> which
>>> causes the contents of a.txt file to be cleared, resulting in no data
>>> being read,
>>>
>>>
>>>      fpr = fopen("a.txt", "r");
>>>      fpw = fopen("a.txt", "w");
>>>
>>>      /* fgets() will get nothing, It's not glibc's fault. */
>>>      while (fgets(buff, sizeof(buff), fpr))
>>>          printf("%s", buff);
>>>
>>>      fprintf(fpw, "....");
>>>
>>>      fclose(fpr);
>>>      fclose(fpw);
>>>
>>> corresponding to the SEGV of bpftool. Perhaps we can add the following
>>> warning
>>>
>>>      if (x == NULL) {
>>>          fprintf(stderr, "Maybe the file was opened for writing after
>>> opened for read\n");
>>>          return -EINVAL;
>>>      }
>>>
>>> Whether this warning can be added may depend on libelf's processing.
>>> I will
>>> try to fix this SEGV in libbpf, hopefully it can be fixed.
>> Thank you Rong, I'm not sure I followed your explanation (the above is
>> not bpftool code, is it?), but I think we just addressed the issue in
>> libbpf with:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/
>> commit/?id=e10500b69c3f3378f3dcfc8c2fe4cdb74fc844f5
> Thanks for this, i just try this patch, there is still one problem as
> follows:
> 
>    $ cd tools/bpf/bpftool
>    $ make -j8
>    $ ls -l prog.o
>    -rw-r--r--. 1 rongtao rongtao 78408 Dec  6 10:18 prog.o
>    $ ./bpftool gen object prog.o prog.o
>    libbpf: failed to get ELF header for prog.o: invalid `Elf' handle
>    Error: failed to link 'prog.o': Invalid argument (22)
>    $ ls -l prog.o
>    -rw-r--r--. 1 rongtao rongtao 0 Dec  6 10:18 prog.o
> 
> The input file is cleared (size=0), which is not what the user expected.


And what would the user expect in this case, exactly?

	$ bpftool gen help
	Usage: bpftool gen object OUTPUT_FILE INPUT_FILE [INPUT_FILE...]

Bpftool clearly states that the first argument is an _output_ file. So
yes, if an existing file is passed as the first argument, whether or not
it's the same as one of the input files, it gets truncated. Same thing
happens if you run "dd if=prog.o of=prog.o". If the user expects
otherwise, they are mistaken: I don't see a valid use case for passing
twice the same argument as both input and output, nor should we focus on
detecting this particular case. If users do get mistaken, then we likely
need to do a better work on the docs or the help commands instead.

Apologies for the misleading review earlier on your patch, as Andrii and
Alexei have highlighted as well, this is the wrong approach.

Quentin

