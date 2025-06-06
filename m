Return-Path: <bpf+bounces-59940-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF724AD0967
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 23:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFD2417AD4F
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 21:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A3723506A;
	Fri,  6 Jun 2025 21:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YF6/WaLW"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D39A1E9906
	for <bpf@vger.kernel.org>; Fri,  6 Jun 2025 21:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749245030; cv=none; b=OtzFM4HeWdEZ5XbJGUPYYSirhvDCz7JCoDdu+lTvC9UtR3czxZrTPcLvqR1BgRn0Hnij6wU0jkBpgzie+qk/H4b8h/byTNqyv0QiXW6GiL5lFeDmUHRf76SgazVfe+wj34EW7MGX32+FTVTQQ0GP20yZ2+0lN8EJhJdnEh42Uq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749245030; c=relaxed/simple;
	bh=e8KIp1E7wOMyEG9Cxf0GM5kI67QemCg6sXeuxPjmYyg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rl2SkL9ULy6IwFhx0+y8QGcBezFyCruXWsZIQU9RXfsp5Mw36NVZxZ1KKuAHbRLGWTRmT8MEK1YrH79FA+IOOmyzbvXj8PEMsiocehdMeCX2aKwDgJ9XWlTJtm2xyo9v42IQ3YV2kwG9SBaW08PbyNh4Uu2+bonjihdISisZQgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YF6/WaLW; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2afefc5b-5bb9-416e-894d-e604f39d7ab7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749245019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EqQan0Qh/7ETb6I/nMU1V8V+yIXgsd7Yyir5duNSl0A=;
	b=YF6/WaLWf0AnVGw98cyb/eovUJt2ZIb5ROEZXUb6PcFrnq4Xg0p34c3KeHgrBw2f45W/PF
	qT5f3dSof01WyiTFKl/sXll+lHVJATwgJrswiodhk7cKab8kCqYQBh0/ftMy5ZAydevA0i
	q8zOObkIG65yvmhxrkSGS8uiwJHlwQM=
Date: Fri, 6 Jun 2025 14:23:31 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 3/4] selftests/bpf: Fix ringbuf/ringbuf_write
 test failure with arm64 64KB page size
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
References: <20250606174139.3036576-1-yonghong.song@linux.dev>
 <20250606174155.3037298-1-yonghong.song@linux.dev>
 <CAADnVQJ+eOP7N4ihV6fkOQHiEc6fkH4qkcJnHogUoLWexsj-PA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQJ+eOP7N4ihV6fkOQHiEc6fkH4qkcJnHogUoLWexsj-PA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 6/6/25 1:53 PM, Alexei Starovoitov wrote:
> On Fri, Jun 6, 2025 at 10:42 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>> The ringbuf max_entries must be PAGE_ALIGNED. See kernel function
>> ringbuf_map_alloc(). So for arm64 64KB page size, adjust max_entries
>> properly.
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   tools/testing/selftests/bpf/prog_tests/ringbuf.c       | 5 +++--
>>   tools/testing/selftests/bpf/progs/test_ringbuf_write.c | 5 +++--
>>   2 files changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/ringbuf.c b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
>> index da430df45aa4..89fd3401a23e 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/ringbuf.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
>> @@ -97,7 +97,8 @@ static void ringbuf_write_subtest(void)
>>          if (!ASSERT_OK_PTR(skel, "skel_open"))
>>                  return;
>>
>> -       skel->maps.ringbuf.max_entries = 0x4000;
>> +       skel->maps.ringbuf.max_entries = 4 * page_size;
>> +       skel->rodata->reserve_size = 3 * page_size;
>>
>>          err = test_ringbuf_write_lskel__load(skel);
>>          if (!ASSERT_OK(err, "skel_load"))
>> @@ -108,7 +109,7 @@ static void ringbuf_write_subtest(void)
>>          mmap_ptr = mmap(NULL, page_size, PROT_READ | PROT_WRITE, MAP_SHARED, rb_fd, 0);
>>          if (!ASSERT_OK_PTR(mmap_ptr, "rw_cons_pos"))
>>                  goto cleanup;
>> -       *mmap_ptr = 0x3000;
>> +       *mmap_ptr = 3 * page_size;
>>          ASSERT_OK(munmap(mmap_ptr, page_size), "unmap_rw");
>>
>>          skel->bss->pid = getpid();
>> diff --git a/tools/testing/selftests/bpf/progs/test_ringbuf_write.c b/tools/testing/selftests/bpf/progs/test_ringbuf_write.c
>> index 350513c0e4c9..9acef7afbe8a 100644
>> --- a/tools/testing/selftests/bpf/progs/test_ringbuf_write.c
>> +++ b/tools/testing/selftests/bpf/progs/test_ringbuf_write.c
>> @@ -12,6 +12,7 @@ struct {
>>
>>   /* inputs */
>>   int pid = 0;
>> +const volatile int reserve_size = 0;
> See CI failure:
> |test_ringbuf_write.bpf.o|test_ringbuf_write|success -> failure (!!)|+0.00 % |
>
> I think it's better to init reserve_size with some reasonable
> constant to keep veristat happy.

Yes, I am aware of this and actually fixed locally already. Will send out v3 soon.

>
> pw-bot: cr


