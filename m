Return-Path: <bpf+bounces-60735-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E191BADB5D6
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 17:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1E7D3A7E09
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 15:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E1523B62C;
	Mon, 16 Jun 2025 15:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AYgka5Uj"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A87A482FF
	for <bpf@vger.kernel.org>; Mon, 16 Jun 2025 15:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750088916; cv=none; b=iiSbfpYXnf2m/ttnQYlJV6MzjN0pIWGtD97Cr611ygnSm7wmYlLPZy6gFjMylk8xj3TShWxVCLrp+EonHpcxugGieLM4FJrA1HCk+AxR4PttpY+r1B7J+hNa36oE3rUfdiLYbr9YiE8uxblHcSbH1HQ5x6t03eEXbCuRwuhfwB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750088916; c=relaxed/simple;
	bh=kKvoMdhmj6gzp5HX7F73TE8k80wW3KH4NNj/srmmaqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f4ZudsLbvdGKNqafV8jLRIssHT5IzznU8WMwC/9tf7KKz4CRlHz/lQ28qLA+e7m4UYYle48S5NgkQTs2nSd0dJa6UXCCf4N6kfyDODNeM2yKpPAy6Wa8CMt404hjM0hHSPy7lm5VbKCY5YnD46jfh5FLzut74z67nJgNev9YIOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AYgka5Uj; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ae32f324-93fe-4ff5-bede-cd9f145535c2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750088911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2+0XKaY0539PNBUK/10XXqnoWKTpDeujHW1stHlTXXg=;
	b=AYgka5UjTHKTg2OeQm/3HWeRhQ0/cQqg/zeDOtEW8muOawtJsLOuXrHydQH/oTS5k46p1o
	j5AuAJVe5g2F4rqFLGaQEXXiPpBLpVd6a/ziPhPP8qHpmBc6d/cEEFgop1lGJ2m9Jl8Aba
	97a7oGnNplN1Y0wJxFSvhQpXOd4Jhlw=
Date: Mon, 16 Jun 2025 08:48:26 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/3] selftests/bpf: Refactor the failed
 assertion to another subtest
Content-Language: en-GB
To: Jiri Olsa <olsajiri@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
References: <20250615185345.2756663-1-yonghong.song@linux.dev>
 <20250615185351.2757391-1-yonghong.song@linux.dev> <aE_W1ZoK6BZ6_EGA@krava>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <aE_W1ZoK6BZ6_EGA@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 6/16/25 1:33 AM, Jiri Olsa wrote:
> On Sun, Jun 15, 2025 at 11:53:51AM -0700, Yonghong Song wrote:
>
> SNIP
>
>> There are total 301 locations for usdt_300. For gcc11 built binary, there are
>> 300 spec's. But for clang20 built binary, there are 3 spec's. The libbpf default
>> BPF_USDT_MAX_SPEC_CNT is 256. So for gcc11, the above bpf_program__attach_usdt() will
>> fail, but the function will succeed for clang20.
>>
>> Note that we cannot just change BPF_USDT_MAX_SPEC_CNT from 256 to 2 (through overwriting
>> BPF_USDT_MAX_SPEC_CNT before usdt.bpf.h) since it will cause other test failures.
>> We cannot just set BPF_USDT_MAX_SPEC_CNT to 2 for test_usdt_multispec.c since we
>> have below in the Makefile:
>>    test_usdt.skel.h-deps := test_usdt.bpf.o test_usdt_multispec.bpf.o
>> and the linker will enforce that BPF_USDT_MAX_SPEC_CNT values for both progs must
>> be the same.
>>
>> The refactoring does not change existing test result. But the future change will
>> allow to set BPF_USDT_MAX_SPEC_CNT to be 2 for arm64/clang20 case, which will have
>> the same attachment failure as in gcc11.
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   tools/testing/selftests/bpf/prog_tests/usdt.c | 35 +++++++++++++------
>>   1 file changed, 25 insertions(+), 10 deletions(-)
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/usdt.c b/tools/testing/selftests/bpf/prog_tests/usdt.c
>> index 495d66414b57..dc29ef94312a 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/usdt.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/usdt.c
>> @@ -270,18 +270,8 @@ static void subtest_multispec_usdt(void)
>>   	 */
>>   	trigger_300_usdts();
> should above line (plus the comment) ...
>
>>   
>> -	/* we'll reuse usdt_100 BPF program for usdt_300 test */
>>   	bpf_link__destroy(skel->links.usdt_100);
>> -	skel->links.usdt_100 = bpf_program__attach_usdt(skel->progs.usdt_100, -1, "/proc/self/exe",
>> -							"test", "usdt_300", NULL);
>> -	err = -errno;
>> -	if (!ASSERT_ERR_PTR(skel->links.usdt_100, "usdt_300_bad_attach"))
>> -		goto cleanup;
>> -	ASSERT_EQ(err, -E2BIG, "usdt_300_attach_err");
>>   
>> -	/* let's check that there are no "dangling" BPF programs attached due
>> -	 * to partial success of the above test:usdt_300 attachment
>> -	 */
> ... and the code below (up to usdt_301_sum assert)
> go to the new subtest_multispec_fail_usdt test as well?

Indeed, I need to move more codes related to usdt test/usdt_300 to
subtest_multispec_fail_usdt().

The following code
	skel->bss->usdt_100_called = 0;
	skel->bss->usdt_100_sum = 0;

should remain in function subtest_multispec_usdt() as it is needed
for test/usdt_400 usdt testing which also used usdt_100 prog.

>
> jirka
>
>>   	bss->usdt_100_called = 0;
>>   	bss->usdt_100_sum = 0;
>>   
>> @@ -312,6 +302,29 @@ static void subtest_multispec_usdt(void)
>>   	test_usdt__destroy(skel);
>>   }
>>   
>> +static void subtest_multispec_fail_usdt(void)
>> +{
>> +	LIBBPF_OPTS(bpf_usdt_opts, opts);
>> +	struct test_usdt *skel;
>> +	int err;
>> +
>> +	skel = test_usdt__open_and_load();
>> +	if (!ASSERT_OK_PTR(skel, "skel_open"))
>> +		return;
>> +
>> +	skel->bss->my_pid = getpid();
>> +
>> +	skel->links.usdt_100 = bpf_program__attach_usdt(skel->progs.usdt_100, -1, "/proc/self/exe",
>> +							"test", "usdt_300", NULL);
>> +	err = -errno;
>> +	if (!ASSERT_ERR_PTR(skel->links.usdt_100, "usdt_300_bad_attach"))
>> +		goto cleanup;
>> +	ASSERT_EQ(err, -E2BIG, "usdt_300_attach_err");
>> +
>> +cleanup:
>> +	test_usdt__destroy(skel);
>> +}
>> +
>>
[...]


