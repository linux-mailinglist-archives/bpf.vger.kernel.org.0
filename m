Return-Path: <bpf+bounces-19766-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE788310BD
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 02:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F255E1F248BB
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 01:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E510D53A4;
	Thu, 18 Jan 2024 01:11:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F3123D8;
	Thu, 18 Jan 2024 01:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705540284; cv=none; b=l26PeVWHpCDHyKfkbuOW1t7zd4GJAVZpD6hRcNJgA+zlgEzPEch9oKiF57tAjFPGZn/e7XolggQYXQ3Vb5pWTzgnU+bd9x7lHTNCMXBVX06a5UpRhpRxZiqhcXmIHXQeOorDFxWmWTGLo3lBtPea/C6+3cPCz5vNehg+PySxw/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705540284; c=relaxed/simple;
	bh=rb+V3lYIDplaQC+beZ0jkIMshQswDlRpS1356CVlADM=;
	h=Received:Received:Received:Subject:To:Cc:References:From:
	 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:Content-Language:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo; b=uimcmIAbMKL5+cUYqNFUxhQU8asENecCfrAvrJtfm4NugajnpuobSKucx6KfGWCsqfESq1C8VWjXRNM/Xp7EPUY/4HtM7aiToHMJ0Bae2u743Pg7KNn1C3cZayjEh9dVRLQYrNhAqpMlROJPB+eq0959Ld6uKLNMqqeSwElIQm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TFl7M5pDBz4f3lWJ;
	Thu, 18 Jan 2024 09:11:11 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id E79CA1A0AFD;
	Thu, 18 Jan 2024 09:11:17 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP3 (Coremail) with SMTP id _Ch0CgAn6aCyeqhlnFOUBA--.27416S2;
	Thu, 18 Jan 2024 09:11:17 +0800 (CST)
Subject: Re: [PATCH bpf-next v5 3/3] selftests/bpf: Skip callback tests if jit
 is disabled in test_verifier
To: Song Liu <song@kernel.org>, Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240117111000.12763-1-yangtiezhu@loongson.cn>
 <20240117111000.12763-4-yangtiezhu@loongson.cn>
 <CAPhsuW6mWoQQ1M-uPE_i+RWv=t5GaVqUDAObWgpEC-PCYSbwHQ@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <342f1c7f-a8d3-dbba-a45f-66fc672883be@huaweicloud.com>
Date: Thu, 18 Jan 2024 09:11:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAPhsuW6mWoQQ1M-uPE_i+RWv=t5GaVqUDAObWgpEC-PCYSbwHQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:_Ch0CgAn6aCyeqhlnFOUBA--.27416S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CF1rArW5Zr45WF15uw47XFb_yoW8CFWxpa
	y8J3WIyFW8tFy2v342yan7XF4ayr4kJF1UWF48Wr47Z34DCry3Kas8GF4rXF1kurnY9Fya
	va1jvrW5u34Uta7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
	GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvj
	xUrR6zUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi Song,

On 1/18/2024 1:20 AM, Song Liu wrote:
> On Wed, Jan 17, 2024 at 3:10 AM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
> [...]
>> @@ -1622,6 +1624,16 @@ static void do_test_single(struct bpf_test *test, bool unpriv,
>>         alignment_prevented_execution = 0;
>>
>>         if (expected_ret == ACCEPT || expected_ret == VERBOSE_ACCEPT) {
>> +               if (fd_prog < 0 && saved_errno == EINVAL && jit_disabled) {
>> +                       for (i = 0; i < prog_len; i++, prog++) {
>> +                               if (!insn_is_pseudo_func(prog))
>> +                                       continue;
>> +                               printf("SKIP (callbacks are not allowed in non-JITed programs)\n");
>> +                               skips++;
>> +                               goto close_fds;
>> +                       }
>> +               }
>> +
> I would put this chunk above "alignment_prevented_execution = 0;".
>
> @@ -1619,6 +1621,16 @@ static void do_test_single(struct bpf_test
> *test, bool unpriv,
>                 goto close_fds;
>         }
>
> +       if (fd_prog < 0 && saved_errno == EINVAL && jit_disabled) {
> +               for (i = 0; i < prog_len; i++, prog++) {
> +                       if (!insn_is_pseudo_func(prog))
> +                               continue;
> +                       printf("SKIP (callbacks are not allowed in
> non-JITed programs)\n");
> +                       skips++;
> +                       goto close_fds;
> +               }
> +       }
> +
>         alignment_prevented_execution = 0;
>
>         if (expected_ret == ACCEPT || expected_ret == VERBOSE_ACCEPT) {
>
> Other than this,

The check was placed before the checking of expected_ret in v3. However
I suggested Tiezhu to move it after the checking of expected_ret due to
the following two reasons:
1) when the expected result is REJECT, the return value in about one
third of these test cases is -EINVAL. And I think we should not waste
the cpu to check the pseudo func and exit prematurely, instead we should
let test_verifier check expected_err.
2) As for now all expected_ret of these failed cases are ACCEPT when jit
is disabled, so I think it will be enough for current situation and we
can revise it later if the checking of pseudo func is too later.

So wdyt ?

>
> Acked-by: Song Liu <song@kernel.org>
>
> Thanks,
> Song
>
> .


