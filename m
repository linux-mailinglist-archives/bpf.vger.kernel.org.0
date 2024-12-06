Return-Path: <bpf+bounces-46231-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B8D9E63E4
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 03:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 158342844ED
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 02:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150F614AD0D;
	Fri,  6 Dec 2024 02:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="Q9KlADNj"
X-Original-To: bpf@vger.kernel.org
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CA11EEF9;
	Fri,  6 Dec 2024 02:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733451110; cv=none; b=dwQT6zv3gwMP08827wag5LRKhkrbqJnavHVr+IKgVt+jfGKaq8bU5orI0VuXWDdbvKVa2tbm5DoKIEIV+uzTovP6GV0zaV3+5nqs01yEF0XAalCuBJFymEFvcIcBddgsD7GXTVuAuJLN6DuvbJh3ocwHErInVS3t8NWqJNzgABo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733451110; c=relaxed/simple;
	bh=+qD5YZKfDQTAieYnj5KhhsFb39oa1kbaSr5ve9HTCm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sxJ9eCTuRHSW8DDWN065WqLwOIxnIl2STPEDXUuyIAGGki6p5ztL81lKwRyqIh2zcBda+GI2+d6URQxDx/WpMwVFbigI31Nm2XHCYbKVJ37jpQX7ACT+cXRqhqzuas4lHC4iDgPfUTIQL2Q01iECNsP2tTp72fAxFBjIYIfO7nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=Q9KlADNj; arc=none smtp.client-ip=43.163.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1733450794;
	bh=EfI1X8ZBa5QZaQuD7Dx7QjxpdELf5J1+tEn64+Mt0Gg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Q9KlADNjzZJoLkiXEBM8Knnc7HgymzjtfW3ynkzCq35bunmgVDHBp+LiSbfjon+Jf
	 GxFMKddLaHuJCbDE+GgShetjrDOk72EjqsRQzMpI0OW+FaSyMC2Bu/AhIUQ4xd2dBq
	 tqivg5WnMDwF4uWOhKiIae+PWPTAQ+EWKK3IXbFA=
Received: from [10.56.52.9] ([39.156.73.10])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id 19F310B9; Fri, 06 Dec 2024 10:06:31 +0800
X-QQ-mid: xmsmtpt1733450791tw80qbjzu
Message-ID: <tencent_008480B2A22E9F559E5E21470911BD0D5009@qq.com>
X-QQ-XMAILINFO: N/WmRbclY25Go9IpGYahQRD/FwORO8HqTeFxx0fm7K74CcV9oF9hPjynMUblZe
	 xYKxkSooVOjsUJmkhHw3xHMsOLzZDDFPSO768g/ARM/kCVrsDC2A/nQPFBfFvzqkdU659SCkdI0L
	 c6jJgkktPhoWbCV7h9taI8zKwh0eJzt8ar6QE9tq+ZIkJCaNjeCy5x7et9mkFBjhkDKwt8ZSB2AC
	 fQWNf1dPsZqnd+Dt71xxYhaPt1HL4iEQj6WsTF8mfSM3+ciQV2DifbrZ/eK6ZBZC/bc/iKxg9fwR
	 LUA4RXiOLY3VfpryO62HRwfHKBO9H5uLZZX4HLjLH5G3mYVFujR7QAX0cicyJTNn3KrYRB1wRtzx
	 ld9mABFv0EA1DWsjWWm2XPF8kpUV1V3Qbds+XW9ZwMaBL6VRDvg9TBAbWuaTkbtifvUtxu70PH8q
	 xEzNC9nBLv5bN528ep9i1tParob72IRu+hgyrhgdGO2zxlmCb30y+un1Od0VPYLdqR5Qcy7cyd9P
	 ZvmRTp7mDUOZMEdTWz39bJdcOSGt2vsivOd0eLEWR2VeirUzIj6Yv/nNxZQ2oz9eBXg8rasAaJ6h
	 U4DMIl5j1j9VHcx7bJCex+U+wjbasDzyQ7Gt/ZlMP6iOdQwkuCCtrouMYZUnNZKLSC6WmpcGY4Xq
	 mRen0ufPayHYhp2Y6u0IqkZD14WTnWkGPqmyPksv6bdYGFfJhIN1ifkifHjrF7nj2XKBoYv0gK+I
	 jY2NRqNi17r8pd8m1VZnSJz796RrGuj6KHI2+8CuRZfe4ifNqfmT2kXdUII8gOdxyrXL+gT6aoCi
	 YDqvBX/h6YXFDCZr+QVbfsNJ1CSbqZBqIRDzEUFJCAIwWcTutZbYzvs5dRRjcvp/+6c9vAElCNYD
	 BfywJGFq1s1ly8vHLxXyuwS77SKu1S/b8lygJELYGIn1epM0Y48BQFlpTRT3UwQ1E+6JWsXrUpy0
	 hzmYEpRfO4DSTfNybzLMM7ejjM8GXQqpx72+kJK9njCz8uvR8lkC/2aMvn3e7Xx/t7z7OWE1k=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-OQ-MSGID: <af50c5c4-5ae1-4570-8366-1aadc146c79c@foxmail.com>
Date: Fri, 6 Dec 2024 10:06:31 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3] bpftool: Fix gen object segfault
To: Quentin Monnet <qmo@kernel.org>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>
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
>
> We can drop the patch with the check on the names (sorry!). As Andrii
> mentioned, it's not very reliable to compare filenames. It's true that
> users can truncate files if they pass the same input and output file,
> but then that's the case with many command-line tools if you don't use
> them properly.

I think we could do the both check for 'filename', right.

https://lore.kernel.org/lkml/tencent_4C02217218D4082166DD5C52A8D8BF228F0A@qq.com/

Thanks,

Rong Tao

>
> So, no action required. Feel free to test with the patch above, the
> segfault should not longer occur.
>
> Thanks,
> Quentin


