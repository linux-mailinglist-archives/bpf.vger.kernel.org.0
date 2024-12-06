Return-Path: <bpf+bounces-46224-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A76D9E6319
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 02:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E469918848A4
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 01:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B926814A099;
	Fri,  6 Dec 2024 01:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="xcuoTw9j"
X-Original-To: bpf@vger.kernel.org
Received: from out203-205-221-202.mail.qq.com (out203-205-221-202.mail.qq.com [203.205.221.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8751411C8;
	Fri,  6 Dec 2024 01:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733447521; cv=none; b=ucpmOar5w+s8eZoazNnChunnk0EimcSoT6/f9Im1P1jRepfgFbB0QepIiIILQlf8WlmZ6csRSZTzQkevPB5dw7bp5OdMmFQkSz+GiPR5J7eyOslyXw4BABvoraRl1MN0Xpn3dBX6D6QWbKQGHmFUaqECHlDY5iXLwCCTih82gHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733447521; c=relaxed/simple;
	bh=fcP4qZk6nabIDUkPnVvFVYsoocR+VsAXZVzU64BGtzA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iwG3f7sDuWDZJ7Ne5YjPQ0880qVyigZQT9NjqhqVbelgdGvyDnChO+LgOHNdh1SiOdskj5rNExq7Tp89ECLbLna6RhYeeGFDhNodaUm8l91VqgrN9BQ0yN3xSyZNrub4MwBKFc6vtcEn5fgeQgA+ZoItz1C2q1PnR6wFLL6OFH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=xcuoTw9j; arc=none smtp.client-ip=203.205.221.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1733447508;
	bh=lGNVgTWKnAmXQ720+QkWvitJc7cq4QaoaY6WqsdA1FE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=xcuoTw9ja2W07qNhUSslBHOlxpqqlz6o5fabwn2pq+BqjRaaMYmZ4/5XeSVPedY94
	 R9dpePAs/gfGq74e1Bk8S1lC8BSOPdSB9qJ3UoruwBO4upoS8kYtL4th2GLiesXHi9
	 DncW5BIdw2LX2My1RKxXJhjvjP5NOp1utJ1IA2vM=
Received: from [10.56.52.9] ([39.156.73.10])
	by newxmesmtplogicsvrszb20-0.qq.com (NewEsmtp) with SMTP
	id 2ED15C15; Fri, 06 Dec 2024 09:11:45 +0800
X-QQ-mid: xmsmtpt1733447505tja5xslbz
Message-ID: <tencent_0F0D028440B2BE2E37547C5EFF467511FD09@qq.com>
X-QQ-XMAILINFO: MFdGPHhuqhNoenT7vtHyF/zEcnozbjhR9bTAu7UWjTAH1UAMPTz2cbuM1RB5cK
	 tcnognY2NyXzEnm5R8yuRf75TXByZ25XvigXRihSDOqiH3j/C9KYa9KdKAb46foGyGK9HP+SXrvv
	 j663ItAyC2Ii6IDwNLticMic531bFv1n55jt4xUoO71KnJcO7f36e/wBw4S/EQGe6auNlEgi3hGR
	 NXq9J8u/F6SsE0XZsH/jT4fkGvKdwlwzLPhh46ZUQuWv7XVwqO8etirC5rE7SYwo9nJkm15gVx8M
	 ApsWEbPnPQ5EFnZ5SB3Q4utzpi1PswLgB9rMoMp9gHTO422V3c9TnSz3CH4yR1FyNhsYAnb1D4+r
	 ilYmF9mwNn03zkrIsghHkktANe3CacNcxJIE7CVcssfp0RwZUNPeEhIpuN36Ln3jdzR3XrXEbK86
	 fskiTjjmX8HTVXBoOLf5fv3K222ChTilgoduqZSLr2tcQyyxTiEpoqEIJzqIiKHcKLQOUVmNFV2D
	 E9KkKnIv551WgvS5QYFZgcQA5GPiFeKoHwcikdj8a34TtIjyKoWRg5HpH4kxjyR2KQRkk9A0JwL1
	 nw845WRAFViL+JO7MnABRPmvQm7ZB2wPyRU4ZMA+oS/jGZ5MRmLCk0TF7zCmvexFcCXiyQzR2YpO
	 Eoy6dTvggjhAgLup5InjzBphOy5SZrBIznilyS/H4qyidMoLRTb1ln8noFuSAljDXAQEuwDh+18N
	 5L82NiG9WZjYkBPhJmEi/JuRgpFbUteKiJdZDyELF5pxB1W4MYK6rIk42GaTFdNx7AKDD6zhVTuz
	 fC1XkLksri/ewjTtBCneuuLQqhfe2XCbwGIpVzJZFgIsZ6kgJF+DVQ7OfhMBdwXD4mbBPedM4Ccz
	 ML65yhRhSbWot09l7zIJPNvxc8Ep7oW6cCxsSFYlsYQ1whsWx6kss/hkcmfMY95m+fjAIdLebOg3
	 ehmzONOYz5OymdtMHCNQ9YoMSgPTS5aUE8i+FpLfpOmYmrWJOdSg==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-OQ-MSGID: <f3b76844-f23d-4c78-ac76-528fb841df6b@foxmail.com>
Date: Fri, 6 Dec 2024 09:11:44 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3] bpftool: Fix gen object segfault
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Quentin Monnet <qmo@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, rongtao@cestc.cn,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>,
 "open list:BPF [TOOLING] (bpftool)" <bpf@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <tencent_A7A870BF168D6A21BA193408D5645D5D920A@qq.com>
 <0b96aa24-13ca-4e0a-8e80-f2586fbe2b57@kernel.org>
 <CAEf4BzbLmXF9XB=fBvL7NLMoPmfD=DFFvuM8Fw5h6T7vfFXUFg@mail.gmail.com>
Content-Language: en-US
From: Rong Tao <rtoax@foxmail.com>
In-Reply-To: <CAEf4BzbLmXF9XB=fBvL7NLMoPmfD=DFFvuM8Fw5h6T7vfFXUFg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 12/6/24 05:34, Andrii Nakryiko wrote:
> On Thu, Dec 5, 2024 at 4:22 AM Quentin Monnet <qmo@kernel.org> wrote:
>> On 05/12/2024 12:09, Rong Tao wrote:
>>> From: Rong Tao <rongtao@cestc.cn>
>>>
>>> If the input file and output file are the same, the input file is cleared
>>> due to opening, resulting in a NULL pointer access by libbpf.
>>>
>>>      $ bpftool gen object prog.o prog.o
>>>      libbpf: failed to get ELF header for prog.o: invalid `Elf' handle
>>>      Segmentation fault
>>>
>>>      (gdb) bt
>>>      #0  0x0000000000450285 in linker_append_elf_syms (linker=0x4feda0, obj=0x7fffffffe100) at linker.c:1296
>>>      #1  bpf_linker__add_file (linker=0x4feda0, filename=<optimized out>, opts=<optimized out>) at linker.c:453
>>>      #2  0x000000000040c235 in do_object ()
>>>      #3  0x00000000004021d7 in main ()
>>>      (gdb) frame 0
>>>      #0  0x0000000000450285 in linker_append_elf_syms (linker=0x4feda0, obj=0x7fffffffe100) at linker.c:1296
>>>      1296              Elf64_Sym *sym = symtab->data->d_buf;
>>>
>>> Signed-off-by: Rong Tao <rongtao@cestc.cn>
>> Tested-by: Quentin Monnet <qmo@kernel.org>
>> Reviewed-by: Quentin Monnet <qmo@kernel.org>
> Isn't this papering over a deeper underlying issue? Why do we get
> SIGSEGV inside the linker at all instead of just erroring out?
> Comparison based on file path isn't a reliable way to check if input
> and output are both the same file, so this fixes the most obvious
> case, but not the actual issue.
Thanks for your replay! The current scenario is similar to the following 
code.
After a.txt is opened in read mode, it is opened in write mode again, which
causes the contents of a.txt file to be cleared, resulting in no data 
being read,


     fpr = fopen("a.txt", "r");
     fpw = fopen("a.txt", "w");

     /* fgets() will get nothing, It's not glibc's fault. */
     while (fgets(buff, sizeof(buff), fpr))
         printf("%s", buff);

     fprintf(fpw, "....");

     fclose(fpr);
     fclose(fpw);

corresponding to the SEGV of bpftool. Perhaps we can add the following 
warning

     if (x == NULL) {
         fprintf(stderr, "Maybe the file was opened for writing after 
opened for read\n");
         return -EINVAL;
     }

Whether this warning can be added may depend on libelf's processing. I will
try to fix this SEGV in libbpf, hopefully it can be fixed.

Thanks,
Rong Tao
>> Thank you!


