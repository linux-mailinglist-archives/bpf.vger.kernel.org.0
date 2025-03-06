Return-Path: <bpf+bounces-53459-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC8DA54327
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 07:59:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38FA916F698
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 06:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0321E1A2C04;
	Thu,  6 Mar 2025 06:59:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA04918DB04
	for <bpf@vger.kernel.org>; Thu,  6 Mar 2025 06:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741244375; cv=none; b=uuGM+DqACHCYuU+QsP1SU81uzUcaAXTbnWpg9bJq0hh37FBiN1UgU0Bo6ziaaM8wTEhKuiDv1zPWHZC+vbxJT1W0WtLqFx7SCdYau31nCBuAlomt+nVBbz5MERn/qb0uOPZ4JjauobACP0gMG9GeleQcGQ2lSKP4giafXq8o/WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741244375; c=relaxed/simple;
	bh=A0fHhnM3rkZZ4IGmU76p5lctfowiPTBncheyFVWjuW0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Hsfwy+bnHSUzAJGzEAjhy+YUAIKphjcl31vA+JA9uwRYvdCWKhbgvEensxRt7gOc5yBLOP+6L46JGOGJfe7Z2vZZrkB4B5JSAqiPOynmLreIyi5csnz6j4M+W1iI9Op/u2fTeU9Swy/Ihpk7KuDb7f/KkhYKUl9hlMyVtRABIT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Z7gJ96yc4z4f3jXh
	for <bpf@vger.kernel.org>; Thu,  6 Mar 2025 14:59:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 24BD81A06D7
	for <bpf@vger.kernel.org>; Thu,  6 Mar 2025 14:59:28 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgDXPH3MR8lnolB0Fg--.55280S2;
	Thu, 06 Mar 2025 14:59:28 +0800 (CST)
Subject: Re: [PATCH v4 2/3] selftests: bpf: add bpf_cpumask_fill selftests
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
 yonghong.song@linux.dev, tj@kernel.org, memxor@gmail.com
References: <20250305211235.368399-1-emil@etsalapatis.com>
 <20250305211235.368399-3-emil@etsalapatis.com>
 <7deb7f8c-d196-ac21-4857-9f8deb65b1f5@huaweicloud.com>
 <CABFh=a7Y3-eJV6Wk+g=XcvBva+x95wEiwCVYTfS8v59nZpCuLQ@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <e6633b1a-a150-5c67-7658-eef5a03a7899@huaweicloud.com>
Date: Thu, 6 Mar 2025 14:59:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABFh=a7Y3-eJV6Wk+g=XcvBva+x95wEiwCVYTfS8v59nZpCuLQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgDXPH3MR8lnolB0Fg--.55280S2
X-Coremail-Antispam: 1UD129KBjvJXoW3GF4kJFy3Ww17Aw18XF4kCrg_yoWxZFWrpF
	W8GFWUKFWUJF1xKw4UX3ZrGF1Yk3s3t3Wv9F1UGa4fAF9Iyrn7tr1jgFyUGr45Cr4kCF1x
	Z3yDKrsxWwn5AFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU92b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x07UAwIDUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 3/6/2025 10:36 AM, Emil Tsalapatis wrote:
> Hi,
>
> thank you for the feedback. I will address it in a v5.
>
> On Wed, Mar 5, 2025 at 8:57 PM Hou Tao <houtao@huaweicloud.com> wrote:
>> Hi,
>>
>> On 3/6/2025 5:12 AM, Emil Tsalapatis wrote:
>>> Add selftests for the bpf_cpumask_fill helper that sets a bpf_cpumask to
>>> a bit pattern provided by a BPF program.

Just find out, the name of bpf_cpumask_fill() also needs update.
>>>
>>> Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>
>>> ---
>>>  .../selftests/bpf/progs/cpumask_failure.c     |  38 ++++++
>>>  .../selftests/bpf/progs/cpumask_success.c     | 114 ++++++++++++++++++
>>>  2 files changed, 152 insertions(+)
>> My local build failed due to the missed declaration of
>> "bpf_cpumask_populate" in cpumask_common.h. It reported the following error:
>>
>> progs/cpumask_success.c:788:8: error: call to undeclared function
>> 'bpf_cpumask_populate'; ISO C99 and later do not support implicit fun
>> ction declarations [-Wimplicit-function-declaration]
>>   788 |         ret = bpf_cpumask_populate((struct cpumask *)local,
>> &toofewbits, sizeof(toofewbits));
>>
>> Don't know the reason why CI succeeded.
>>
> Based on Alexei's email systems with recent pahole versions handle
> this fine (at least the CI and my local setup),
> I will still add the definition in cpumask_common.h for uniformity
> since all the other kfuncs have one.

I see. Thanks for that.
>
>>> diff --git a/tools/testing/selftests/bpf/progs/cpumask_failure.c b/tools/testing/selftests/bpf/progs/cpumask_failure.c
>>> index b40b52548ffb..8a2fd596c8a3 100644
>>> --- a/tools/testing/selftests/bpf/progs/cpumask_failure.c
>>> +++ b/tools/testing/selftests/bpf/progs/cpumask_failure.c
>>> @@ -222,3 +222,41 @@ int BPF_PROG(test_invalid_nested_array, struct task_struct *task, u64 clone_flag
>>>
>>>       return 0;
>>>  }
>>> +
>>> +SEC("tp_btf/task_newtask")
>>> +__failure __msg("type=scalar expected=fp")
>>> +int BPF_PROG(test_populate_invalid_destination, struct task_struct *task, u64 clone_flags)
>>> +{
>>> +     struct bpf_cpumask *invalid = (struct bpf_cpumask *)0x123456;
>>> +     u64 bits;
>>> +     int ret;
>>> +
>>> +     ret = bpf_cpumask_populate((struct cpumask *)invalid, &bits, sizeof(bits));
>>> +     if (!ret)
>>> +             err = 2;
>>> +
>>> +     return 0;
>>> +}
>>> +

SNIP
>> An extra newline.
>>> @@ -770,3 +771,116 @@ int BPF_PROG(test_refcount_null_tracking, struct task_struct *task, u64 clone_fl
>>>               bpf_cpumask_release(mask2);
>>>       return 0;
>>>  }
>>> +
>>> +SEC("tp_btf/task_newtask")
>>> +__success
>> For tp_btf, bpf_prog_test_run() doesn't run the prog and it just returns
>> directly, therefore, the prog below is not exercised at all. How about
>> add test_populate_reject_small_mask into cpumask_success_testcases
>> firstly, then switch these test cases to use __success() in a following
>> patch ?
> Sorry about that, I had the selftests properly hooked into
> prog_tests/cpumask.c until v3 but saw duplicate entries in the
> selftest log
> and thought it was being run twice. I will add them back in.
>
> Is __success() a different annotation? AFAICT __success is enough as
> long as err is set to nonzero on an error path, and all
> error paths are set like that in the selftests. In that case,
> shouldn't adding the new tests cpumask_success_testcases be
> enough to properly run the tests?

Yes. __success() annotation is a bit different. It uses
bpf_prog_test_run() to run the bpf prog directly instead of trigger the
running of prog through an external event. I think adding new tests in
cpumask_success_testcases will be enough. However, there is one success
test test_refcount_null_tracking in cpumask_success.c which uses
__success annotation, and it is still buggy. I think it would be better
to switch all test cases to use __success annotation because the
annotation provides much clarity.
>
>
>>> +int BPF_PROG(test_populate_reject_small_mask, struct task_struct *task, u64 clone_flags)
>>> +{
>>> +     struct bpf_cpumask *local;
>>> +     u8 toofewbits;
>>> +     int ret;
>>> +
>>> +     local = create_cpumask();
>>> +     if (!local)
>>> +             return 0;
>>> +
>>> +     /* The kfunc should prevent this operation */
>>> +     ret = bpf_cpumask_populate((struct cpumask *)local, &toofewbits, sizeof(toofewbits));
>>> +     if (ret != -EACCES)
>>> +             err = 2;
>>> +
>>> +     bpf_cpumask_release(local);
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +/* Mask is guaranteed to be large enough for bpf_cpumask_t. */
>>> +#define CPUMASK_TEST_MASKLEN (sizeof(cpumask_t))
>>> +
>>> +/* Add an extra word for the test_populate_reject_unaligned test. */
>>> +u64 bits[CPUMASK_TEST_MASKLEN / 8 + 1];
>>> +extern bool CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS __kconfig __weak;
>>> +
>>> +SEC("tp_btf/task_newtask")
>>> +__success
>> Same for test_populate_reject_unaligned.
>>> +int BPF_PROG(test_populate_reject_unaligned, struct task_struct *task, u64 clone_flags)
>>> +{
>>> +     struct bpf_cpumask *mask;
>>> +     char *src;
>>> +     int ret;
>>> +
>>> +     /* Skip if unaligned accesses are fine for this arch.  */
>>> +     if (CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)
>>> +             return 0;
>>> +
>>> +     mask = bpf_cpumask_create();
>>> +     if (!mask) {
>>> +             err = 1;
>>> +             return 0;
>>> +     }
>>> +
>>> +     /* Misalign the source array by a byte. */
>>> +     src = &((char *)bits)[1];
>>> +
>>> +     ret = bpf_cpumask_populate((struct cpumask *)mask, src, CPUMASK_TEST_MASKLEN);
>>> +     if (ret != -EINVAL)
>>> +             err = 2;
>>> +
>>> +     bpf_cpumask_release(mask);
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +
>>> +SEC("tp_btf/task_newtask")
>>> +__success
>>> +int BPF_PROG(test_populate, struct task_struct *task, u64 clone_flags)
>>> +{
>>> +     struct bpf_cpumask *mask;
>>> +     bool bit;
>>> +     int ret;
>>> +     int i;
>>> +
>>> +     /* Set only odd bits. */
>>> +     __builtin_memset(bits, 0xaa, CPUMASK_TEST_MASKLEN);
>>> +
>>> +     mask = bpf_cpumask_create();
>>> +     if (!mask) {
>>> +             err = 1;
>>> +             return 0;
>>> +     }
>>> +
>>> +     /* Pass the entire bits array, the kfunc will only copy the valid bits. */
>>> +     ret = bpf_cpumask_populate((struct cpumask *)mask, bits, CPUMASK_TEST_MASKLEN);
>>> +     if (ret) {
>>> +             err = 2;
>>> +             goto out;
>>> +     }
>>> +
>>> +     /*
>>> +      * Test is there to appease the verifier. We cannot directly
>>> +      * access NR_CPUS, the upper bound for nr_cpus, so we infer
>>> +      * it from the size of cpumask_t.
>>> +      */
>>> +     if (nr_cpus < 0 || nr_cpus >= CPUMASK_TEST_MASKLEN * 8) {
>>> +             err = 3;
>>> +             goto out;
>>> +     }
>>> +
>>> +     bpf_for(i, 0, nr_cpus) {
>>> +             /* Odd-numbered bits should be set, even ones unset. */
>>> +             bit = bpf_cpumask_test_cpu(i, (const struct cpumask *)mask);
>>> +             if (bit == (i % 2 != 0))
>>> +                     continue;
>>> +
>>> +             err = 4;
>>> +             break;
>>> +     }
>>> +
>>> +out:
>>> +     bpf_cpumask_release(mask);
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +#undef CPUMASK_TEST_MASKLEN


