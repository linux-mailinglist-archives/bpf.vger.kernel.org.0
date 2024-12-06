Return-Path: <bpf+bounces-46233-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 389AE9E6422
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 03:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E67D71683D6
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 02:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109A71714DF;
	Fri,  6 Dec 2024 02:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="R0NtjIjL"
X-Original-To: bpf@vger.kernel.org
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4696A156F54;
	Fri,  6 Dec 2024 02:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733452153; cv=none; b=IF6VoZ1zKqKBewBwAJZPBNYrBjkaxaazNk4BZGNn9cE7rZW4CXi76B03/8qMyukuvqOp66/LwdjaCuqmQJ02oixIJW1ZEaatOIJxZR3XmyYAJid0J07Jh4tdqZVNvPpEik5xAxMAU4GEf9uB8+mPPdU/OvhLdFYvhlq1rht6Ys0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733452153; c=relaxed/simple;
	bh=DWChgoAkGjcs985ZnQGbj8bV9eoCZan6eJ0VqgGaJYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZLPTp32g/KBcpqzOtsSe2QwJeIg1kZfcenbin9kVqnPGprQZgfupWNNL5Y2TFqkVDzpvljQ4loBsX4ozhw7WemCm2hXdqhCt96EVsbcd33DOBPVhcav6EwgBd7dPmbnkeVxeD8h4kTTvJLgCfcvqy9XlKSFMSEOp+ldMGAmvp4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=R0NtjIjL; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1733452145;
	bh=wjQ20CsYQkqMwulAzTKRahW5QkCEP8shqiUUC13vdZk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=R0NtjIjLVWaFV/Bi8zARgYeawxAuHBXvLxiWU0VJN6CHD1UIU0mJMo7lABN8GLxsZ
	 7QSbRLJtqYTvU3FZjLe8kfTn5aumwhRUM4ZMcpxjkfFCyoGZScksEfGCxjpCIN72Ij
	 pBb7F6PXmNeWKJwlglMZ29rQj8scBvN9Ld33vBLk=
Received: from [10.56.52.9] ([39.156.73.10])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id 5A421071; Fri, 06 Dec 2024 10:22:36 +0800
X-QQ-mid: xmsmtpt1733451756t8vy4fodi
Message-ID: <tencent_2AC9A80622AF8180D05996E4E58A4AE6EB06@qq.com>
X-QQ-XMAILINFO: N/WmRbclY25Go9IpGYahQRCP0JyzV4ADH1e5m6zto0pj9++PTO37OxeGClaMdO
	 jkU5c+awKwUHfnDULYVi2qVU+Gs/QcxNJOxGb0A6wSSmhV42fR2UEP6wcxd/WN1g28umQ/UdOZkQ
	 sBxCxtPYHU8SsYHPRFYdf+MX6e32LNc+BOccBUJkiIo6KEn1sz4h65pV6yAmzajmV3juZdSX1wEY
	 bhJCDXjFlceKUxRemlj735P2HyKGx8UY1PRICCRBpcfh/fYHWlB/MrSCMW5bKvQFjauCjM/YJ3N8
	 kZH3L+0+1sgFOdqpSA6IvfjxELiJC857ZX+cbbxZb4Jtj8TBn+MhA4+3QIoFQc290fd9eun590MF
	 uDocY5fd2T9/k6Be4Rh5yl32Uz2/vSy4lzbgcEJmRKdftT5M1NRkypjdWGmGAf0L83PdqQkGoSIM
	 UobTMTXeGSy/g/UF0c7hlHGJ1V3odXnxeQPqfgKPwefeu2Za325PihLGy6L98krixaVZqANMPmwF
	 nSRxR8z+gnY508pVwnqj07SvgPnE2sqKbV3K4Thiz3PdE8HIPO/HVi9eBkhGnAhIS9qRwgABYMVU
	 lbghd4Snm612LClFvymV4fgHkNzOQiT0s/PM+X43wJvopMCbe3G6LASuo23TmD9VvwozKC4QGAhG
	 Jh7nPGZ4u1bvwaCeJ6dphTGw/EvFaaHhxMhcSaqrHbpmoR+aanorFnfnyZQ2dafVX21fQZ9z59Gx
	 6DwExhliP379UcD888hMmojqXgpzpW0B++PUsaiXeuIsrISRGKm35ceSMABknsLXGV3505I0PnjZ
	 kpmFCWUzbprIX435kIZnx5FH3NlJ6r9h+V8mHEaqNLsDgAmoJKxjixt6YWu/OnwA+2DcT7OaT+ht
	 TDyAuT9XJrdRT+BaEJW8hgiKouvBp2PFk1v3PbTJTi8HCCH5RYtUHmIsNvwssLdMWRbiwtgZ/sP6
	 t7hYsfy72jetMnEqpe505haeEfTIMepE35uahZO4U14lWLs8375Kp9uEa1KtD8+Sjxdr+ddpmIuG
	 GXS9sABQ==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-OQ-MSGID: <c96ecd21-2766-4742-9075-f7fef4dc2279@foxmail.com>
Date: Fri, 6 Dec 2024 10:22:35 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3] bpftool: Fix gen object segfault
To: Quentin Monnet <qmo@kernel.org>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>, alexei.starovoitov@gmail.com
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
Content-Language: en-US
From: Rong Tao <rtoax@foxmail.com>
In-Reply-To: <77c9f13e-0162-4e92-b0b8-531122ab0f5e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 12/6/24 09:56, Quentin Monnet wrote:
> 2024-12-06 09:11 UTC+0800 ~ Rong Tao <rtoax@foxmail.com>
>> On 12/6/24 05:34, Andrii Nakryiko wrote:
>>> On Thu, Dec 5, 2024 at 4:22 AM Quentin Monnet <qmo@kernel.org> wrote:
>>>> On 05/12/2024 12:09, Rong Tao wrote:
>>>>> From: Rong Tao <rongtao@cestc.cn>
>>>>>
>>>>> If the input file and output file are the same, the input file is
>>>>> cleared
>>>>> due to opening, resulting in a NULL pointer access by libbpf.
>>>>>
>>>>>       $ bpftool gen object prog.o prog.o
>>>>>       libbpf: failed to get ELF header for prog.o: invalid `Elf' handle
>>>>>       Segmentation fault
>>>>>
>>>>>       (gdb) bt
>>>>>       #0  0x0000000000450285 in linker_append_elf_syms
>>>>> (linker=0x4feda0, obj=0x7fffffffe100) at linker.c:1296
>>>>>       #1  bpf_linker__add_file (linker=0x4feda0, filename=<optimized
>>>>> out>, opts=<optimized out>) at linker.c:453
>>>>>       #2  0x000000000040c235 in do_object ()
>>>>>       #3  0x00000000004021d7 in main ()
>>>>>       (gdb) frame 0
>>>>>       #0  0x0000000000450285 in linker_append_elf_syms
>>>>> (linker=0x4feda0, obj=0x7fffffffe100) at linker.c:1296
>>>>>       1296              Elf64_Sym *sym = symtab->data->d_buf;
>>>>>
>>>>> Signed-off-by: Rong Tao <rongtao@cestc.cn>
>>>> Tested-by: Quentin Monnet <qmo@kernel.org>
>>>> Reviewed-by: Quentin Monnet <qmo@kernel.org>
>>> Isn't this papering over a deeper underlying issue? Why do we get
>>> SIGSEGV inside the linker at all instead of just erroring out?
>>> Comparison based on file path isn't a reliable way to check if input
>>> and output are both the same file, so this fixes the most obvious
>>> case, but not the actual issue.
>> Thanks for your replay! The current scenario is similar to the following
>> code.
>> After a.txt is opened in read mode, it is opened in write mode again, which
>> causes the contents of a.txt file to be cleared, resulting in no data
>> being read,
>>
>>
>>      fpr = fopen("a.txt", "r");
>>      fpw = fopen("a.txt", "w");
>>
>>      /* fgets() will get nothing, It's not glibc's fault. */
>>      while (fgets(buff, sizeof(buff), fpr))
>>          printf("%s", buff);
>>
>>      fprintf(fpw, "....");
>>
>>      fclose(fpr);
>>      fclose(fpw);
>>
>> corresponding to the SEGV of bpftool. Perhaps we can add the following
>> warning
>>
>>      if (x == NULL) {
>>          fprintf(stderr, "Maybe the file was opened for writing after
>> opened for read\n");
>>          return -EINVAL;
>>      }
>>
>> Whether this warning can be added may depend on libelf's processing. I will
>> try to fix this SEGV in libbpf, hopefully it can be fixed.
> Thank you Rong, I'm not sure I followed your explanation (the above is
> not bpftool code, is it?), but I think we just addressed the issue in
> libbpf with:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit/?id=e10500b69c3f3378f3dcfc8c2fe4cdb74fc844f5
Thanks for this, i just try this patch, there is still one problem as 
follows:

    $ cd tools/bpf/bpftool
    $ make -j8
    $ ls -l prog.o
    -rw-r--r--. 1 rongtao rongtao 78408 Dec  6 10:18 prog.o
    $ ./bpftool gen object prog.o prog.o
    libbpf: failed to get ELF header for prog.o: invalid `Elf' handle
    Error: failed to link 'prog.o': Invalid argument (22)
    $ ls -l prog.o
    -rw-r--r--. 1 rongtao rongtao 0 Dec  6 10:18 prog.o

The input file is cleared (size=0), which is not what the user expected.

Thanks,
Rong Tao
>
> We can drop the patch with the check on the names (sorry!). As Andrii
> mentioned, it's not very reliable to compare filenames. It's true that
> users can truncate files if they pass the same input and output file,
> but then that's the case with many command-line tools if you don't use
> them properly.
>
> So, no action required. Feel free to test with the patch above, the
> segfault should not longer occur.
>
> Thanks,
> Quentin


