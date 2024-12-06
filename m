Return-Path: <bpf+bounces-46227-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0729E63CB
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 02:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1C991881BE9
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 01:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E3213C8FF;
	Fri,  6 Dec 2024 01:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="In5wXmi5"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B92136C;
	Fri,  6 Dec 2024 01:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733450211; cv=none; b=r6oKvzHwNLshhZW1pyNRNKUI/Pv/VFHW8XorVjxC/T37ryrSI5M9kU+qo9n3TcZ3f3RMgsOSRXIEIvznliuf85Szr4qbcY9xoIy5GPiXLGNH6QLYjywOrIJ+XjBxRtZmgQysZQ38QjgkPyKtQgXr2EDCnt7njKVDA5/vD9Robkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733450211; c=relaxed/simple;
	bh=oGgLnkXY+peMs1hL9SBaKITe7y+CwdhfVSTf6KVgEo8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=t6POndql6l0eGr63g6KGqh2HNJ2imC9g0GUmNj1TzvuRm8bqxy2WwQ54aXr2AjzUQ1LOYmSK0ft2EYBT+ebAep/lQ/09+ButeNBmqVWmYVwv53xsa0yJmu7XjK3VN7gz7Hkrl+rT9APOeUY9i098R3yV58RxO6XopLpWypcT0Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=In5wXmi5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D853C4CED1;
	Fri,  6 Dec 2024 01:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733450210;
	bh=oGgLnkXY+peMs1hL9SBaKITe7y+CwdhfVSTf6KVgEo8=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=In5wXmi5fCYgE1/k9wh5ooRCK3rYMTt5wKJAROOx26i0J1gzJ4PxXu5MHG2p/+3OH
	 qjlK3ZTeerUWdlO1sNle9klq+/qZN3TGElzTn3nFnaE1O74YdnanBHWMmy9rEHrEdJ
	 tkbcGFRjoce70kfNRp4zL/hRDnbFG5xjlek6sBz3UDiQF5fHe2eMgGVVyUoQ0DSvPe
	 QXbC7BB1kbSZDwpmByN+XbPcPcJEbhv1ubeK6voQdijAZgMjvMw8ZOXv+IF19Ksgsr
	 egFPXYyXPBGYWvudpZgU8z1RNJh2FIfJaRpt22QSllhSfKzsGx+/+msSk/icfKBGfB
	 cNItnScmFfPbQ==
Message-ID: <77c9f13e-0162-4e92-b0b8-531122ab0f5e@kernel.org>
Date: Fri, 6 Dec 2024 01:56:45 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Quentin Monnet <qmo@kernel.org>
Subject: Re: [PATCH bpf-next v3] bpftool: Fix gen object segfault
To: Rong Tao <rtoax@foxmail.com>, Andrii Nakryiko <andrii.nakryiko@gmail.com>
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
Content-Language: en-GB
In-Reply-To: <tencent_0F0D028440B2BE2E37547C5EFF467511FD09@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

2024-12-06 09:11 UTC+0800 ~ Rong Tao <rtoax@foxmail.com>
> 
> On 12/6/24 05:34, Andrii Nakryiko wrote:
>> On Thu, Dec 5, 2024 at 4:22 AM Quentin Monnet <qmo@kernel.org> wrote:
>>> On 05/12/2024 12:09, Rong Tao wrote:
>>>> From: Rong Tao <rongtao@cestc.cn>
>>>>
>>>> If the input file and output file are the same, the input file is
>>>> cleared
>>>> due to opening, resulting in a NULL pointer access by libbpf.
>>>>
>>>>      $ bpftool gen object prog.o prog.o
>>>>      libbpf: failed to get ELF header for prog.o: invalid `Elf' handle
>>>>      Segmentation fault
>>>>
>>>>      (gdb) bt
>>>>      #0  0x0000000000450285 in linker_append_elf_syms
>>>> (linker=0x4feda0, obj=0x7fffffffe100) at linker.c:1296
>>>>      #1  bpf_linker__add_file (linker=0x4feda0, filename=<optimized
>>>> out>, opts=<optimized out>) at linker.c:453
>>>>      #2  0x000000000040c235 in do_object ()
>>>>      #3  0x00000000004021d7 in main ()
>>>>      (gdb) frame 0
>>>>      #0  0x0000000000450285 in linker_append_elf_syms
>>>> (linker=0x4feda0, obj=0x7fffffffe100) at linker.c:1296
>>>>      1296              Elf64_Sym *sym = symtab->data->d_buf;
>>>>
>>>> Signed-off-by: Rong Tao <rongtao@cestc.cn>
>>> Tested-by: Quentin Monnet <qmo@kernel.org>
>>> Reviewed-by: Quentin Monnet <qmo@kernel.org>
>> Isn't this papering over a deeper underlying issue? Why do we get
>> SIGSEGV inside the linker at all instead of just erroring out?
>> Comparison based on file path isn't a reliable way to check if input
>> and output are both the same file, so this fixes the most obvious
>> case, but not the actual issue.
> Thanks for your replay! The current scenario is similar to the following
> code.
> After a.txt is opened in read mode, it is opened in write mode again, which
> causes the contents of a.txt file to be cleared, resulting in no data
> being read,
> 
> 
>     fpr = fopen("a.txt", "r");
>     fpw = fopen("a.txt", "w");
> 
>     /* fgets() will get nothing, It's not glibc's fault. */
>     while (fgets(buff, sizeof(buff), fpr))
>         printf("%s", buff);
> 
>     fprintf(fpw, "....");
> 
>     fclose(fpr);
>     fclose(fpw);
> 
> corresponding to the SEGV of bpftool. Perhaps we can add the following
> warning
> 
>     if (x == NULL) {
>         fprintf(stderr, "Maybe the file was opened for writing after
> opened for read\n");
>         return -EINVAL;
>     }
> 
> Whether this warning can be added may depend on libelf's processing. I will
> try to fix this SEGV in libbpf, hopefully it can be fixed.

Thank you Rong, I'm not sure I followed your explanation (the above is
not bpftool code, is it?), but I think we just addressed the issue in
libbpf with:

https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit/?id=e10500b69c3f3378f3dcfc8c2fe4cdb74fc844f5

We can drop the patch with the check on the names (sorry!). As Andrii
mentioned, it's not very reliable to compare filenames. It's true that
users can truncate files if they pass the same input and output file,
but then that's the case with many command-line tools if you don't use
them properly.

So, no action required. Feel free to test with the patch above, the
segfault should not longer occur.

Thanks,
Quentin

