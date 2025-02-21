Return-Path: <bpf+bounces-52174-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 002B4A3F3ED
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 13:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCFB17AE553
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 12:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A88209681;
	Fri, 21 Feb 2025 12:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I36v2kuH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B97D208961
	for <bpf@vger.kernel.org>; Fri, 21 Feb 2025 12:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740139724; cv=none; b=B7GFoq+hqaIM/Wr5dfZAwRtK61OkLzDAqc1CjR2Vkf495wXK9Zkhzqf0+pcfJfRlGRSYtA47+GHC6ZuPDJ5GTbbsVhz4h1J0c4LT9sgNVBkzWbP03rRuDyXobkpRaN8QgRyyrRRM8j1hXNO7hFp00BhoV1ggX76PjX+uYrnWSXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740139724; c=relaxed/simple;
	bh=XDVhRtAzHGGbOAJmoRiPeITjG3iKTc7NaFlPY9pimEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kl1xVeBeuO/Ygq6tF5lM/oJJBvnhf3619ZOh56a/YIRRjMOWFvYdxh//CLFaS8hCTjYBrDUEiQ0PxGHL5XHJamL2DztwcKHLm26Gxq1yhLKIC7XANDQE9S3Y9u+4z0mzHu3TXL8Cd74HoFgWaMWy41SFnu5ufcNJGlJqh3wVQGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I36v2kuH; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4394a823036so19804915e9.0
        for <bpf@vger.kernel.org>; Fri, 21 Feb 2025 04:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740139721; x=1740744521; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GEIOie78jKAv2yXHmdeT1nMIqP7O77iIevYsDMVemDY=;
        b=I36v2kuHNq5yUFy10LBuUyUJG+Ot150AkDEDOOQmjS3DLz9xg8TfItfzt3p5UTKNoR
         ZaDc1yTK8LbcNW5xd0zRB7Mjj/DyNn8A7+17vRKs5URaD2HxhpFsSbrR1+NpWCdeArx+
         ihsWHGOUrSbLzvQpsH1L3aenyg4xVlsNU6+/Ll+445X3eDjZTnHjvujSFkZUsky5YhsV
         3OupNf1ldGP7TIgqj3VZZFEvimjGN9a5PgmgiryNQH3g5KDY+aMKyARCfPGLhhwNbviu
         t01Hmj5iw9DWNL0/QOA120mjo81O8HzKBDrpd1oEETEedABOmu2Paw8Vp9zhSCbEWJJZ
         VuAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740139721; x=1740744521;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GEIOie78jKAv2yXHmdeT1nMIqP7O77iIevYsDMVemDY=;
        b=Hy9HeFJWxE2IMUlJ8pugPfegkBLE3oz3DGZMEoFo7rMz3p2jNQM9eig/B7M5Y1aQ1n
         n39zE2PoKsS+lcc09GIjVXyEcnRwg1Iv9jyruAv7YcFLFJivbOC4pwKHreBXiUpIJ13X
         gZVvbJ+ammMx2GAeinwTknn85TD5Xqnh8CzCL0om8EgWU8RwAusCTRzNGin9uU140fNQ
         dt8KmCWvgIG2Ex0q+H3cojgk3kIGdCoIb7LOJUZZYxIpFPYa3xLkviZCr8j6qp5e+A7A
         GxG7DiyX323wTvslm4o02O3AvvU6ggVcE5H9j1BRmYkn3DsoaF5WUIZsEQ/9z/kPO+Ct
         QELw==
X-Gm-Message-State: AOJu0YylYlW3zFo0J4R3QDSD5nY50kxGxADdWSTcWQEEqMN73XATS6Lf
	z4Rv/1V2SuqdMhV7zTAI0KFSSFEcXmGsHvTii24z+283/ralEViN
X-Gm-Gg: ASbGncuvKfP+F0lRlmCHkeFK96FUcE+ekz5uKm4BserHXuybnNuMxxZqV6GgmZ5J4nq
	5vlHYNtxfnX2GlVDET/ComjdmR9nMVLnMquv6NQfX/6wArF8HSTZi+hBI8i2ra0dDqWm906a88l
	I62kULYzIaKp9VLmQFuI5B8jSG6JHcR1Y/S8CpOosjcpkHsqZaHt6LBnTFmX3kzuT7pyaip8sB4
	zEuktItvN8fQSsZNhZcBSeT8Aegi7uIYqMZQMC7X74Ssstic//RmWh0s8Pl7aF4y6kv6EMPVEof
	RA2qc5KpfNdJ0qiZorwcdCNoLdV/VaByufkl0+H88x9UPwt9OuDD2kvEJlL34gFQXeUDVpxtDrE
	koEQw8GNxr/iQYwklupc6SA==
X-Google-Smtp-Source: AGHT+IEmxTlAtBBEIzWsQLF5Vgsu4n3NLqFxdrMA9eNH9Qytt3DZJXLwksxEU0+OtIQ+4YTy8sa0tg==
X-Received: by 2002:a5d:64e9:0:b0:38f:3471:71c8 with SMTP id ffacd0b85a97d-38f70783c9amr2377861f8f.3.1740139720591;
        Fri, 21 Feb 2025 04:08:40 -0800 (PST)
Received: from [192.168.0.18] (cpc158789-hari22-2-0-cust468.20-2.cable.virginm.net. [86.26.115.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d5923sm23420096f8f.74.2025.02.21.04.08.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 04:08:40 -0800 (PST)
Message-ID: <9eaf9945-9a5c-4313-b449-cfa8144975e0@gmail.com>
Date: Fri, 21 Feb 2025 12:08:39 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: add tests for bpf_dynptr_copy
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, martin.lau@linux.dev
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
 eddyz87@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
References: <20250218190027.135888-1-mykyta.yatsenko5@gmail.com>
 <20250218190027.135888-4-mykyta.yatsenko5@gmail.com>
 <CAEf4BzaxYL1y4wR0KuSouDzmrt610CBwtv0dKp4xbO9LD-t9qg@mail.gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <CAEf4BzaxYL1y4wR0KuSouDzmrt610CBwtv0dKp4xbO9LD-t9qg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 21/02/2025 00:52, Andrii Nakryiko wrote:
> On Tue, Feb 18, 2025 at 11:01 AM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>
>> Add XDP setup type for dynptr tests, enabling testing for
>> non-contiguous buffer.
>> Add 2 tests:
>>   - test_dynptr_copy - verify correctness for the fast (contiguous
>>   buffer) code path.
>>   - test_dynptr_copy_xdp - verifies code paths that handle
>>   non-contiguous buffer.
>>
>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>> ---
>>   tools/testing/selftests/bpf/bpf_kfuncs.h      |  8 ++
>>   .../testing/selftests/bpf/prog_tests/dynptr.c | 25 ++++++
>>   .../selftests/bpf/progs/dynptr_success.c      | 77 +++++++++++++++++++
>>   3 files changed, 110 insertions(+)
>>
>> diff --git a/tools/testing/selftests/bpf/bpf_kfuncs.h b/tools/testing/selftests/bpf/bpf_kfuncs.h
>> index 8215c9b3115e..e9c193036c82 100644
>> --- a/tools/testing/selftests/bpf/bpf_kfuncs.h
>> +++ b/tools/testing/selftests/bpf/bpf_kfuncs.h
>> @@ -43,6 +43,14 @@ extern bool bpf_dynptr_is_rdonly(const struct bpf_dynptr *ptr) __ksym __weak;
>>   extern __u32 bpf_dynptr_size(const struct bpf_dynptr *ptr) __ksym __weak;
>>   extern int bpf_dynptr_clone(const struct bpf_dynptr *ptr, struct bpf_dynptr *clone__init) __ksym __weak;
>>
>> +/* Description
>> + *  Copy data from one dynptr to another
>> + * Returns
>> + *  Error code
>> + */
>> +extern int bpf_dynptr_copy(struct bpf_dynptr *dst, __u32 dst_off,
>> +                          struct bpf_dynptr *src, __u32 src_off, __u32 size) __ksym __weak;
>> +
> Do we *need* this? Doesn't all this come from vmlinux.h nowadays?
>
>>   /* Description
>>    *  Modify the address of a AF_UNIX sockaddr.
>>    * Returns
>> diff --git a/tools/testing/selftests/bpf/prog_tests/dynptr.c b/tools/testing/selftests/bpf/prog_tests/dynptr.c
>> index b614a5272dfd..247618958155 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/dynptr.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/dynptr.c
>> @@ -10,6 +10,7 @@ enum test_setup_type {
>>          SETUP_SYSCALL_SLEEP,
>>          SETUP_SKB_PROG,
>>          SETUP_SKB_PROG_TP,
>> +       SETUP_XDP_PROG,
>>   };
>>
>>   static struct {
>> @@ -18,6 +19,8 @@ static struct {
>>   } success_tests[] = {
>>          {"test_read_write", SETUP_SYSCALL_SLEEP},
>>          {"test_dynptr_data", SETUP_SYSCALL_SLEEP},
>> +       {"test_dynptr_copy", SETUP_SYSCALL_SLEEP},
>> +       {"test_dynptr_copy_xdp", SETUP_XDP_PROG},
>>          {"test_ringbuf", SETUP_SYSCALL_SLEEP},
>>          {"test_skb_readonly", SETUP_SKB_PROG},
>>          {"test_dynptr_skb_data", SETUP_SKB_PROG},
>> @@ -120,6 +123,28 @@ static void verify_success(const char *prog_name, enum test_setup_type setup_typ
>>
>>                  break;
>>          }
>> +       case SETUP_XDP_PROG:
>> +       {
>> +               char data[5000];
>> +               int err, prog_fd;
>> +
> no empty line here, opts is a variable
>
>> +               LIBBPF_OPTS(bpf_test_run_opts, opts,
>> +                           .data_in = &data,
>> +                           .data_size_in = sizeof(data),
>> +                           .repeat = 1,
>> +               );
>> +
>> +               prog_fd = bpf_program__fd(prog);
>> +               if (!ASSERT_GE(prog_fd, 0, "prog_fd"))
>> +                       goto cleanup;
>
> we shouldn't check this, if program loaded successfully this will
> always be true (and yeah, I know that existing code does that, we
> should remove or at least not duplicate this)
>
>> +
>> +               err = bpf_prog_test_run_opts(prog_fd, &opts);
>> +
>> +               if (!ASSERT_OK(err, "test_run"))
>> +                       goto cleanup;
>> +
>> +               break;
>> +       }
>>          }
>>
>>          ASSERT_EQ(skel->bss->err, 0, "err");
>> diff --git a/tools/testing/selftests/bpf/progs/dynptr_success.c b/tools/testing/selftests/bpf/progs/dynptr_success.c
>> index bfcc85686cf0..8a6b35418e39 100644
>> --- a/tools/testing/selftests/bpf/progs/dynptr_success.c
>> +++ b/tools/testing/selftests/bpf/progs/dynptr_success.c
>> @@ -567,3 +567,80 @@ int BPF_PROG(test_dynptr_skb_tp_btf, void *skb, void *location)
>>
>>          return 1;
>>   }
>> +
>> +SEC("?tp/syscalls/sys_enter_nanosleep")
>> +int test_dynptr_copy(void *ctx)
>> +{
>> +       char *data = "hello there, world!!";
>> +       char buf[32] = {'\0'};
>> +       __u32 sz = strlen(data);
> this is fragile, this is not guaranteed to work (only if compiler just
> substituted a constant value). maybe just use data[] = "hello
> there..." and use sizeof(data) then?
>
>> +       struct bpf_dynptr src, dst;
>> +
>> +       bpf_ringbuf_reserve_dynptr(&ringbuf, sz, 0, &src);
>> +       bpf_ringbuf_reserve_dynptr(&ringbuf, sz, 0, &dst);
>> +
>> +       err = bpf_dynptr_write(&src, 0, data, sz, 0);
>> +       err = err ?: bpf_dynptr_copy(&dst, 0, &src, 0, sz);
>> +       err = err ?: bpf_dynptr_read(buf, sz, &dst, 0, 0);
>> +       err = err ?: __builtin_memcmp(data, buf, sz);
>> +
>> +       err = err ?: bpf_dynptr_copy(&dst, 3, &src, 5, sz - 5);
>> +       err = err ?: bpf_dynptr_read(buf, sz - 5, &dst, 3, 0);
>> +       err = err ?: __builtin_memcmp(data + 5, buf, sz - 5);
>> +
>> +       bpf_ringbuf_discard_dynptr(&src, 0);
>> +       bpf_ringbuf_discard_dynptr(&dst, 0);
>> +       return 0;
>> +}
>> +
>> +SEC("xdp")
>> +int test_dynptr_copy_xdp(struct xdp_md *xdp)
>> +{
>> +       struct bpf_dynptr ptr_buf, ptr_xdp;
>> +       char *data = "qwertyuiopasdfghjkl;";
>> +       char buf[32] = {'\0'};
>> +       __u32 len = strlen(data);
> ditto
>
>> +       int i, chunks = 200;
>> +
>> +       bpf_dynptr_from_xdp(xdp, 0, &ptr_xdp);
>> +       bpf_ringbuf_reserve_dynptr(&ringbuf, len * chunks, 0, &ptr_buf);
>> +
>> +       bpf_for(i, 0, chunks) {
>> +               err =  err ?: bpf_dynptr_write(&ptr_buf, i * len, data, len, 0);
>> +       }
>> +
>> +       err = err ?: bpf_dynptr_copy(&ptr_xdp, 0, &ptr_buf, 0, len * chunks);
>> +
>> +       bpf_for(i, 0, chunks) {
>> +               memset(buf, 0, sizeof(buf));
> __builtin_memset(), memset() works only because compiler optimizes it
> to built-in, but let's not rely on that
>
>> +               err = err ?: bpf_dynptr_read(&buf, len, &ptr_xdp, i * len, 0);
>> +               err = err ?: memcmp(data, buf, len);
> __builtin_memcmp() and all the other cases below, please
>
>> +       }
>> +
>> +       memset(buf, 0, sizeof(buf));
>> +       bpf_for(i, 0, chunks) {
>> +               err = err ?: bpf_dynptr_write(&ptr_buf, i * len, buf, len, 0);
>> +       }
>> +
>> +       err = err ?: bpf_dynptr_copy(&ptr_buf, 0, &ptr_xdp, 0, len * chunks);
>> +
>> +       bpf_for(i, 0, chunks) {
>> +               memset(buf, 0, sizeof(buf));
>> +               err = err ?: bpf_dynptr_read(&buf, len, &ptr_buf, i * len, 0);
>> +               err = err ?: memcmp(data, buf, len);
>> +       }
>> +
>> +       bpf_ringbuf_discard_dynptr(&ptr_buf, 0);
>> +
>> +       err = err ?: bpf_dynptr_copy(&ptr_xdp, 2, &ptr_xdp, len, len * (chunks - 1));
>> +
>> +       bpf_for(i, 0, chunks - 1) {
>> +               memset(buf, 0, sizeof(buf));
>> +               err = err ?: bpf_dynptr_read(&buf, len, &ptr_xdp, 2 + i * len, 0);
>> +               err = err ?: memcmp(data, buf, len);
>> +       }
>> +
>> +       err = err ?: (bpf_dynptr_copy(&ptr_xdp, 2000, &ptr_xdp, 0, len * chunks) == -E2BIG ? 0 : 1);
> overdoing it a bit with the whole `err ?: ` pattern, IMO
>
>
> BTW, more questions to networking folks (maybe Martin knows). Is there
> a way to setup SKB or XDP packet with a non-linear region for testing?
The setup I made in dynptr.c for XDP makes non-linear region.
It looks like maximum linear mem size is 4k, so when going above that,
it creates multiple frags in xdp_buff:

```

char data[5000];
...
.data_in = &data,

```

I verified that in this test xdp_buff is non-linear, and all non-fast 
code paths of
the bpf_dynptr_copy are tested.

>
>> +
>> +       return XDP_DROP;
>> +}
>> --
>> 2.48.1
>>
Thanks for findings, fixing them in v2.

