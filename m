Return-Path: <bpf+bounces-71109-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8559CBE320F
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 13:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81A1B5863A3
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 11:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D4731A815;
	Thu, 16 Oct 2025 11:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hn+YaKcq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8F732861C
	for <bpf@vger.kernel.org>; Thu, 16 Oct 2025 11:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760614985; cv=none; b=aXhyuBZso2wxpF6kF39SSfRg280mV9S35YmsJCwtScSXFKzGD635n3hyHhCe0Xf8YCkMhEgwmmJvkIa00wzUS8pgC/NQxhFT4U1+E/VjDoWK8ZN0M/UUCGnFIs1ViG3+DKGTZILVKvTscXZf4p71GrVXZPzjk+QyPraFmpPL1Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760614985; c=relaxed/simple;
	bh=bUyYG0HIh8MaLURhxnUqYcu0/fygQ1lfGK9Q7zxoK8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I5DTrjBtd4CBazHELBDaJrjkrs3FWrYWIFQGxN5y04obo9iXvGLi2wktpWEyOxJBNywffRBTM0ii/zXX3y5GMQQd7F8d9Oc8QlKvnet2gWSzQVDHWbQllylPMx7kQka7FSphIGNdbph7qZSCKEeDHQjdlwjQSOJQRlpGOksQSVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hn+YaKcq; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47106fc51faso7157595e9.0
        for <bpf@vger.kernel.org>; Thu, 16 Oct 2025 04:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760614982; x=1761219782; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=voJkYT8DvrAOkitxkGU4HDwPlC5KSyWYaQzVHXHtQCc=;
        b=hn+YaKcqoZrG1LCO84eiUM/d7bfRFScfXBOz2bHXx/VieTMpmu8eAXjjXx9ONK4obI
         6HboLo7LYuPDNk0XPwX8DI8BPOrNJ8GKP5VeV3npKkD2yJPmnw6pZn2APflKu+UmO/Ls
         yS9W0DM4GeX16Bw8lvmRVGJSTnlup01n8YTlRAfc6cgrBRLfIxIDtSYdIOuLiaHEiT13
         9gXRaLXhg+gNuTxt1qdhT4o0I5vjslZj1sWDB/VlxDEKPCl3LLusBu1F47+zIn7EW9Mc
         cGfi/EVFxmXl+Tp1y2JGTK+skfn9PDdzJgxhiAhIUxSIsiU3BWxtDlqhXyeaCim0n0pe
         eeUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760614982; x=1761219782;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=voJkYT8DvrAOkitxkGU4HDwPlC5KSyWYaQzVHXHtQCc=;
        b=CMjMZB0uRQka6vp1f64QggxyN8+fXCEr55IKMcCL7FHojaKh4RJPSx6qgK1pDzkpZY
         mNQpJJkWvOWovZ3MZAciTDre+YIV4E0DBB2VyXzQt4GIcbA2CYqyy81+QzGN/nB2ZnSj
         D3TpVKonnCx1ywjgobKy13Roy/CkpjvUo8Moc0f30714c/e9C4cCZ4coWdD91WKEs1CG
         KY8h6Mh+rty5YJ0y1Dqn6XB7oYCjE77xv8k7EOl/iRpPVG/xMhnSHYc7cFykpWLrMhlG
         hf3474Uo6jIL/f1ZmBc7ym5WtBADORb/6Q0wjPHnFK4krUAOcnFVDMXkMC/D0AIEIDxG
         WxrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJyh5sanxzpNWqnOteklVeRjg1mO6Hs7KJAJ0476FK4OBq7XD7CZxPqp/VI7tQJuihi7U=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywvn/gvLGghnsVzveHuvw5wfIBQfhT1/lo3AnZSdb6lamBESv5L
	LIH2eZuZXmEPqmkbZYV1oonVP++wyl4AgSwVLu0WXKC8e2uYvMXsBqRJ7B267g==
X-Gm-Gg: ASbGncutOoVRrtedD5K2qGsz2Ko5qLp/5s4BFiXwOzKIHJ4KX73np8m2BnEQ4cuJITU
	Sk+Iu9GTrxf6kkKEG72iBlwE+HalutlJxhnexZjCauMySyO5nBOXHHgNTUk5X1nRmizlnX4M51f
	lT49ppv9b6wU9Uok2LHQBDGz+BGYN8F2yymavqGLll3dbP/UE56JHnM7y6bjcBxsK/R/+28EJpZ
	tKkwtYJPpYhbpSGF4ZNGu7tTfs00ZMtoXMBHqWZhjKNWwMBR9ZjYf3KlUtZx0bWPNhF+ofkiKwj
	fPbK0eLg8mEs36sZ2Sbj1zq9czhZIjMZ3CxuJ+GUirnazqiQZJLt7joCqUs0j+GuitbNyIwqTRA
	Bug9KiwTFBhn9CO7SGFBsUKdyr4gclvuljphqJ+Qi94kno7vUGxM3x5UdmZoUYCPwX801yAMuQF
	6tlBzUv9wMzrMcSlBTqtBIiKcQmc6iHWts+T+F3kXN3zC/rlFN5pU=
X-Google-Smtp-Source: AGHT+IFz6IAPF/FpXJKXc5uI4vwRITKT/KjTrU/bj3h6H7CSveqaEfaEDGtAzrbcVnXjtGyAR2Pkpg==
X-Received: by 2002:a05:600c:3b19:b0:471:114e:58a8 with SMTP id 5b1f17b1804b1-471114e6921mr14383265e9.25.1760614981894;
        Thu, 16 Oct 2025 04:43:01 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:408e:25b1:d6c:77d7? ([2620:10d:c092:500::7:63af])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4711441f776sm23759435e9.3.2025.10.16.04.43.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 04:43:01 -0700 (PDT)
Message-ID: <5686c95f-2737-43e8-8ccd-bb577d969982@gmail.com>
Date: Thu, 16 Oct 2025 12:42:55 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 11/11] selftests/bpf: add file dynptr tests
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
References: <20251015161155.120148-1-mykyta.yatsenko5@gmail.com>
 <20251015161155.120148-12-mykyta.yatsenko5@gmail.com>
 <9228f1039879afba155be1237526537411aa4706.camel@gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <9228f1039879afba155be1237526537411aa4706.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/15/25 23:50, Eduard Zingerman wrote:
> On Wed, 2025-10-15 at 17:11 +0100, Mykyta Yatsenko wrote:
>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>
>> Introducing selftests for validating file-backed dynptr works as
>> expected.
>>   * validate implementation supports dynptr slice and read operations
>>   * validate destructors should be paired with initializers
>>   * validate sleepable progs can page in.
>>
>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>> ---
> I think a few additional test cases are needed:
> - negative verification test cases, e.g. when file dynptr is created
>    but not discarded and vice versa;
> - a test case for bpf_dynptr_adjust();
> - a test case for bpf_dynptr_read() starting at non-zero offset.
>
> [...]
>
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/prog_tests/file_reader.c
> [...]
>
>> +static int initialize_file_contents(void)
>> +{
>> +	int fd, page_sz = sysconf(_SC_PAGESIZE);
>> +	ssize_t n = 0, cur, off;
>> +	void *addr;
>> +
>> +	fd = open("/proc/self/exe", O_RDONLY);
>> +	if (!ASSERT_GT(fd, 0, "Open /proc/self/exe\n"))
> Nit: ASSERT_OK_FD, 0 is a valid fd number.
>
>> +		return 1;
>> +
>> +	do {
>> +		cur = read(fd, file_contents + n, sizeof(file_contents) - n);
>> +		if (!ASSERT_GT(cur, 0, "read success"))
>> +			break;
>> +		n += cur;
>> +	} while (n < sizeof(file_contents));
>> +
>> +	close(fd);
>> +
>> +	if (!ASSERT_EQ(n, sizeof(file_contents), "Read /proc/self/exe\n"))
>> +		return 1;
>> +
>> +	addr = get_executable_base_addr();
>> +	if (!ASSERT_NEQ(addr, NULL, "get executable address"))
>> +		return 1;
>> +
>> +	/* page-align base file address */
>> +	addr = (void *)((unsigned long)addr & ~(page_sz - 1));
>> +
>> +	for (off = 0; off < sizeof(file_contents); off += page_sz) {
>> +		if (!ASSERT_OK(madvise(addr + off, page_sz, MADV_PAGEOUT),
>> +			       "madvise pageout"))
>> +			return errno;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static void run_test(const char *prog_name)
>> +{
>> +	struct file_reader *skel;
>> +	struct bpf_program *prog;
>> +	int err;
>> +	char data[256];
>> +	LIBBPF_OPTS(bpf_test_run_opts, opts, .data_in = &data, .repeat = 1,
>> +		    .data_size_in = sizeof(data));
>> +
>> +	err = initialize_file_contents();
>> +	if (!ASSERT_OK(err, "initialize file contents"))
>> +		return;
>> +
>> +	skel = file_reader__open();
>> +	if (!ASSERT_OK_PTR(skel, "file_reader__open"))
>> +		return;
>> +
>> +	bpf_object__for_each_program(prog, skel->obj) {
>> +		if (strcmp(bpf_program__name(prog), prog_name) == 0)
>> +			bpf_program__set_autoload(prog, true);
>> +		else
>> +			bpf_program__set_autoload(prog, false);
> Nit: bpf_program__set_autoload(prog, strcmp(bpf_program__name(prog), prog_name) == 0);
>
>> +	}
>> +
>> +	skel->bss->user_buf = file_contents;
>> +	skel->rodata->user_buf_sz = sizeof(file_contents);
>> +	skel->bss->pid = getpid();
>> +	skel->bss->user_ptr = (char *)user_ptr;
>> +
>> +	err = file_reader__load(skel);
>> +	if (!ASSERT_OK(err, "file_reader__load"))
>> +		goto cleanup;
>> +
>> +	err = file_reader__attach(skel);
>> +	if (!ASSERT_OK(err, "file_reader__attach"))
>> +		goto cleanup;
>> +
>> +	getpid();
>> +
>> +	ASSERT_EQ(skel->bss->err, 0, "err");
> Nit: I'd check for some more unique value, e.g. 42, something not null.
I'd like not to use non-zero err value to indicate success, it's
probably better to introduce a separate success variable,
to verify that programs did what we expect.
>
>> +cleanup:
>> +	file_reader__destroy(skel);
>> +}
>> +
>> +void test_file_reader(void)
>> +{
>> +	if (test__start_subtest("on_getpid_expect_fault"))
>> +		run_test("on_getpid_expect_fault");
>> +
>> +	if (test__start_subtest("on_getpid_validate_file_read"))
>> +		run_test("on_getpid_validate_file_read");
>> +}
> [...]


