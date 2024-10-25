Return-Path: <bpf+bounces-43154-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DBB59B01BB
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 13:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15808282D81
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 11:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8190E1FF7B9;
	Fri, 25 Oct 2024 11:54:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E039A1F708E;
	Fri, 25 Oct 2024 11:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729857261; cv=none; b=s8y/F7046OhsvqMjF7GcCIuGYCASGmHy++KXhXMqa5QbS0nfjf/7KYcp4ANKgh+dcgGwu6yyvUSoiJVHSay5zlbAV01qi6fnSiqjXY01shUMbu/HgDB5ha89wNzIWtbx4NHFKNwSACdbhlclHqAtPrFZrfItbBRpat2znUPdoSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729857261; c=relaxed/simple;
	bh=L18BjS4lHeGmvqIfZywwQh5LQfpUChnhxmKKCoOhayk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=oC58Gpf6KUvnssOqUXGxq5q72RRrkdD+27y7LwopVF/IgQPjwTKqfbLxSMaXhQ5Jdx5UG/RAjjhm35SEtA3IsXcIWku+WmcJ4yIdfAl0N+aZjzD+cSQcBP3Lwu8N8JfrK1YyDm0dr34c2okkrjZxLRQpbsuTjkGdBYwl62wMrBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XZh5H6969z4f3lgR;
	Fri, 25 Oct 2024 19:53:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 311DB1A018D;
	Fri, 25 Oct 2024 19:54:14 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgDnXSrlhhtnp5_EEw--.54303S2;
	Fri, 25 Oct 2024 19:54:14 +0800 (CST)
Subject: Re: [PATCH] selftests/bpf: Add test for trie_get_next_key()
To: Byeonguk Jeong <jungbu2855@gmail.com>,
 Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
References: <ZxoOdzdMwvLspZiq@localhost.localdomain>
 <d94bf8c7-b026-4608-83d7-6230f136ee3b@iogearbox.net>
 <ZxrJnZ4+hmZ90Mbj@localhost.localdomain>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <836aeb86-ea15-339a-7dbd-2d3157022e0c@huaweicloud.com>
Date: Fri, 25 Oct 2024 19:54:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZxrJnZ4+hmZ90Mbj@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgDnXSrlhhtnp5_EEw--.54303S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CFyUXF43GF1rKFyDGFW3ZFb_yoW8uFyrpa
	y8Ja1qkF4rXFyrXF18Z3y5Xw4Fkrs3Aa4jy3ZYqrWDuF15Gas2yr4xKF4YgF9xWrWFqan8
	Cw4Sgas5W34xZFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v2
	6r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_
	Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UtR6
	wUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 10/25/2024 6:26 AM, Byeonguk Jeong wrote:
> Hi Daniel,
>
> Okay, I will submit them in a series of patches. Btw, ASSERT_* macros
> are not defined for map_tests. Should I add the definitions for them,
> or just go with CHECK?

For tests in map_tests, I think using CHECK() will be fine.
>
> Thanks,
> Byeonguk
>
> On Thu, Oct 24, 2024 at 11:41:19AM +0200, Daniel Borkmann wrote:
>> Hi Byeonguk,
>>
>> On 10/24/24 11:08 AM, Byeonguk Jeong wrote:
>>> Add a test for out-of-bounds write in trie_get_next_key() when a full
>>> path from root to leaf exists and bpf_map_get_next_key() is called
>>> with the leaf node. It may crashes the kernel on failure, so please
>>> run in a VM.
>>>
>>> Signed-off-by: Byeonguk Jeong <jungbu2855@gmail.com>
>> Could you submit the fix + this selftest as a 2-patch series, otherwise BPF CI
>> cannot test both in combination (pls make sure subject has [PATCH bpf] so that
>> our CI adds this on top of the bpf tree).
>>
>> Right now the CI selftest build threw an error:
>>
>>   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/map_tests/lpm_trie_map_get_next_key.c: In function ‘test_lpm_trie_map_get_next_key’:
>>   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/map_tests/lpm_trie_map_get_next_key.c:84:9: error: format not a string literal and no format arguments [-Werror=format-security]
>>      84 |         CHECK(map_fd == -1, "bpf_map_create(), error:%s\n",
>>         |         ^~~~~
>>     TEST-OBJ [test_maps] task_storage_map.test.o
>>     TEST-OBJ [test_progs] access_variable_array.test.o
>>   cc1: all warnings being treated as errors
>>     TEST-OBJ [test_progs] align.test.o
>>     TEST-OBJ [test_progs] arena_atomics.test.o
>>   make: *** [Makefile:765: /tmp/work/bpf/bpf/tools/testing/selftests/bpf/lpm_trie_map_get_next_key.test.o] Error 1
>>   make: *** Waiting for unfinished jobs....
>>     GEN-SKEL [test_progs-no_alu32] test_usdt.skel.h
>>   make: Leaving directory '/tmp/work/bpf/bpf/tools/testing/selftests/bpf'
>>
>> Also on quick glance, please use ASSERT_*() macros instead of CHECK() as the
>> latter is deprecated.
>>
>> Thanks,
>> Daniel
> .


