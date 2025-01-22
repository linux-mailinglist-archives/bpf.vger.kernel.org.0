Return-Path: <bpf+bounces-49423-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFC9A1893A
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 02:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31C2F3AA9F9
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 01:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5E82837A;
	Wed, 22 Jan 2025 01:00:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DE515AF6
	for <bpf@vger.kernel.org>; Wed, 22 Jan 2025 01:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737507609; cv=none; b=rH7OH4LAnhFkDGTClf1dpi3do3xOzduWuhP35awdaj2UWP2uNKHFatR2V1FJHnYtVgIC0AezC6Ry1ee/MAnng1BgrY6RtiwDCuvUpgwx0HolyTtA27Qt2r27gYSuByZD9ye6dUUbFq4f+l4IgIg+mIlopZYuOtUoRkV+Ew/Z40o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737507609; c=relaxed/simple;
	bh=d5VNR5XKRCh24DRMRYcpMxYERtvjJwpAAbi3Qd2GbxM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=g6+PaEVaQ3uL/ytOU0gUUJ3TiN0x5AZe3casS4VCbb26xUv1+0Mp/MY2NoB/NTLGpn454mvZINi9bw+CrhaCHA7Pp5w7Y02Bmjnsc7ubEL/kAVv6DoKEWJTlQrLCj7CB5hUDHRC703Nwlo0902RfrsUFQA4xKVXsuwyyyedBUhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Yd5MH162Hz4f3jM8
	for <bpf@vger.kernel.org>; Wed, 22 Jan 2025 08:59:39 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 0A43A1A084E
	for <bpf@vger.kernel.org>; Wed, 22 Jan 2025 09:00:01 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP1 (Coremail) with SMTP id cCh0CgB3KHkDQ5BnqQBxBg--.17487S2;
	Wed, 22 Jan 2025 09:00:00 +0800 (CST)
Message-ID: <27a58ab7-22c3-4305-b1dd-0e33c4131319@huaweicloud.com>
Date: Wed, 22 Jan 2025 08:59:47 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Tengda Wu <wutengda@huaweicloud.com>
Subject: Re: [PATCH bpf] selftests/bpf: Fix freplace_link segfault in
 tailcalls prog test
To: Leon Hwang <leon.hwang@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 hffilwlqm@gmail.com
References: <20250121125602.683613-1-wutengda@huaweicloud.com>
 <59696465-ee36-444f-9666-6d913d9d280b@linux.dev>
Content-Language: en-US
In-Reply-To: <59696465-ee36-444f-9666-6d913d9d280b@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgB3KHkDQ5BnqQBxBg--.17487S2
X-Coremail-Antispam: 1UD129KBjvJXoWxurW7KF4xtFy8XF17uFW8tFb_yoW5Zr1kpa
	4kZw1jkr1Sgr1YqF47Ww429FWS9Fs7XFyrCr1rWwn5Ar4Uur97GF1IgFW5WFn3ury5Xw1F
	vw1xtrn3C3yxJrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AK
	xVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jUzV
	bUUUUU=
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

Hi Leon,

On 2025/1/21 22:27, Leon Hwang wrote:
> Hi Tengda,
> 
> On 2025/1/21 20:56, Tengda Wu wrote:
>> There are two bpf_link__destroy(freplace_link) calls in
>> test_tailcall_bpf2bpf_freplace(). After the first bpf_link__destroy()
>> is called, if the following bpf_map_{update,delete}_elem() throws an
>> exception, it will jump to the "out" label and call bpf_link__destroy()
>> again, causing double free and eventually leading to a segfault.
>>
> 
> Thank you for pointing this out.
> 
>> Fix this issue by moving bpf_link__destroy() out of the "out" label
>> and only calling it when freplace_link exists and has not been freed.
>>
> 
> I think it would be better to reset freplace_link to NULL immediately
> after the first bpf_link__destroy(freplace_link) call. This would help
> avoid potential double-free scenarios.

What a great suggestion, I can't believe I didn't think of it! Haha.
I will resend a v2 version later. Thanks, Leon.

> 
> I’ve tested the following diff, which implements this change:
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/tailcalls.c
> b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
> index 544144620ca61..a12fa0521ccc0 100644
> --- a/tools/testing/selftests/bpf/prog_tests/tailcalls.c
> +++ b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
> @@ -1602,6 +1602,7 @@ static void test_tailcall_bpf2bpf_freplace(void)
>         err = bpf_link__destroy(freplace_link);
>         if (!ASSERT_OK(err, "destroy link"))
>                 goto out;
> +       freplace_link = NULL;
> 
>         /* OK to update prog_array map then delete element from the map. */
> 
> Thanks,
> Leon
> 
>> Fixes: 021611d33e78 ("selftests/bpf: Add test to verify tailcall and freplace restrictions")
>> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
>> ---
>>  tools/testing/selftests/bpf/prog_tests/tailcalls.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/tailcalls.c b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
>> index 544144620ca6..028439dd2c5f 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/tailcalls.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
>> @@ -1624,7 +1624,7 @@ static void test_tailcall_bpf2bpf_freplace(void)
>>  	freplace_link = bpf_program__attach_freplace(freplace_skel->progs.entry_freplace,
>>  						     prog_fd, "subprog_tc");
>>  	if (!ASSERT_ERR_PTR(freplace_link, "attach_freplace failure"))
>> -		goto out;
>> +		goto out_free_link;
>>  
>>  	err = bpf_map_delete_elem(map_fd, &key);
>>  	if (!ASSERT_OK(err, "delete_elem from jmp_table"))
>> @@ -1638,11 +1638,11 @@ static void test_tailcall_bpf2bpf_freplace(void)
>>  		goto out;
>>  
>>  	err = bpf_map_update_elem(map_fd, &key, &prog_fd, BPF_ANY);
>> -	if (!ASSERT_ERR(err, "update jmp_table failure"))
>> -		goto out;
>> +	ASSERT_ERR(err, "update jmp_table failure");
>>  
>> -out:
>> +out_free_link:
>>  	bpf_link__destroy(freplace_link);
>> +out:
>>  	tailcall_freplace__destroy(freplace_skel);
>>  	tc_bpf2bpf__destroy(tc_skel);
>>  }
> 


