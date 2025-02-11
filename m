Return-Path: <bpf+bounces-51154-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D36EEA30F4B
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 16:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 910B418873D3
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 15:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EFBC250C16;
	Tue, 11 Feb 2025 15:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j7By0Kbm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370BC3D69
	for <bpf@vger.kernel.org>; Tue, 11 Feb 2025 15:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739286593; cv=none; b=AtAybjwhs2CPTb7Nn9y3zZCzbCCCVWYhzKrYOCxkKApoYtQrgVFHPM8tliRZdObtwOGYu96Xy892LO4RiCzY5o+rZK6PtTXbmHaHKWY54qARlTQ68VB21ThLTnn9RODPsCBzvS39o/Abl2pbabiXnLlG4jIjrBAgRPLwmMlDA/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739286593; c=relaxed/simple;
	bh=tjQ5TOqTj68RIVKrmRhma4Z6rMFkoLnFfVeoqv9cG88=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n754wUsJEh3ZKTon+cVj+P4bhvlPCLJxKKLqU06XZoTaI80X3nbLtxfZPUM6Q1vmvqLvf1NMUTdeYyoEb1yg9l3fk81So3Qw5oOUBPCr33sKw8NJxSakGycI8qcWdO9Wk1S7/OqD9fK4z500PBni4dM8M4MKhiLkJ7AvSuE43uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j7By0Kbm; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4362bae4d7dso38037335e9.1
        for <bpf@vger.kernel.org>; Tue, 11 Feb 2025 07:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739286589; x=1739891389; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A9KDoQcRGX56nhYV71KMdY4QwDdJL1RJItnNfCCemAY=;
        b=j7By0Kbmd5/1zA5P+4ni2t8eTpjlM/DH0GH5dx2/gMzTsKkmeiDlus53bzpyY+fMBi
         uPSJYHbfqYVBIyV9wd6VRs14PX4FAIwOINZaWkssq3Pfslt1BCld4v226e9HuwcQzAZ+
         k6X+XgEt83V/z5INcBMvRG2X3BPbOB4oppDwruGXREtqbVRjbVHSMLSwM4AADMfU4Ogw
         MGqV9/CNDC9adf3UTOB2UghW3c1zsq90NZjvF0G6ww9BTaV3V9nUJHLNA67IWA+zx30g
         aWT0rY/fwuuwhWxl1pXNmsQN0Re8QbYfjvT6vGIUuFiLwQBQ0WK86/mxNODIsEvcYs5s
         2T4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739286589; x=1739891389;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A9KDoQcRGX56nhYV71KMdY4QwDdJL1RJItnNfCCemAY=;
        b=jfFT15KSEOK8Flhko8fh870uGCamRtYhq77RkOC5m+UBvqgcpfe3CL9Odfuv7djV1G
         /ehNbDdBK/W2zrHQedG/CJQzQD1WsS9J7vZRfyzHhwPziuHL46ZA3+tmuu2NT6qxbKhR
         tMWlMVGkSq8SGeaD/EGYhnXvVLB7tQhgjFghGWG1AEsIUpZ6cuQMEbGFkUMBeXrB9LiN
         8OviEdtzKBXmJUxaETdmvT7MTV4wnQ7OorNsERIsjV9roa63JBW2GuoQbHyVyn8aInEo
         LsI9o272jxMOpmaIrsgvdCchG3NT9GpEF3/ZPb3/BFi84bx7IhhSgwl2quwTK++cJTW2
         K0Hw==
X-Forwarded-Encrypted: i=1; AJvYcCUEV3zPzuFTPCJBolr1vj7hw4JsXVUube/nf1J6rwHdvkLCOLJhaPms7c6n0T0fRlbO/zU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXax/PggIfTE6ERLG0iR1aXM8sEuehmOmtdmUbff34mSod8pup
	7N58nTIDjfX8cp8+8bsNr/1WE430w2bRXj4G4QBuIgG4ggmyCVQ2
X-Gm-Gg: ASbGncvhjCxh1SxAR9oQgCoR/qFouP+DnqwP8sfA4UkVVfSD3BixKJRvvABIznnQ9rM
	mWD7myF9EtGbN0syXUTAudfPiWoqBJ2+ncrWyS3a7L6DZeBl9pQo/8YAnN1OlPrC9YkB1wmbIiA
	se06OHiTEnRM2LSR7XghT3PLCK4vg/5z5mdk1kyil9nOw7TdQoCFf8lXJiYiwcTrbjS1w2Qfs+S
	A6BFjotspQ3znWUYMu3o6MTds52qQsubkko4AItKBtCidgxXq26xbLVEoIkoxFtDLc1TAXFKh8g
	rMNGxGlQ0bbaDoUvKUaU9IHZ4VjqwVJpS25Ku1h/Ev6g90KP55Pm
X-Google-Smtp-Source: AGHT+IE8KGJ0GzdzMgx23fR7kM/4XMahrn1BK2WcsY07vrwepQ1roI+v1vaxpfBoo0rpNBDdDNBk3A==
X-Received: by 2002:a5d:6c66:0:b0:38a:418e:1177 with SMTP id ffacd0b85a97d-38dc8d9202dmr13109014f8f.11.1739286589182;
        Tue, 11 Feb 2025 07:09:49 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1126:3:8dd1:e06e:70b9:d7dc? ([2620:10d:c092:500::4:1255])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7b99be322sm491754766b.8.2025.02.11.07.09.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 07:09:48 -0800 (PST)
Message-ID: <718685c5-9a14-4478-9839-620676dc5895@gmail.com>
Date: Tue, 11 Feb 2025 15:09:47 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: introduce veristat test
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
References: <20250210135129.719119-1-mykyta.yatsenko5@gmail.com>
 <20250210135129.719119-3-mykyta.yatsenko5@gmail.com>
 <37033e12b0aad918a1787d2e0ef4a8b5e67c7413.camel@gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <37033e12b0aad918a1787d2e0ef4a8b5e67c7413.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/02/2025 03:01, Eduard Zingerman wrote:
> On Mon, 2025-02-10 at 13:51 +0000, Mykyta Yatsenko wrote:
>
> [...]
>
>> +void test_veristat_set_global_vars_succeeds(void)
>> +{
> test_progs based tests are usually organized as a hierarchy of tests and sub-tests.
> E.g. take a look at tools/testing/selftests/bpf/prog_tests/ksyms_btf.c:
> - it defines an entry point test_ksyms_btf;
> - and a bunch of sub-tests declared as static void functions,
>    called from entry point;
> - test__start_subtest() function is used to check if sub-test has to
>    be executed.
>
>> +	char command[512];
>> +	struct fixture *fix = init_fixture();
>> +
>> +	snprintf(command, sizeof(command),
>> +		 "./veristat set_global_vars.bpf.o"\
>> +		 " -G \"var_s64 = 0xf000000000000001\" "\
>> +		 " -G \"var_u64 = 0xfedcba9876543210\" "\
>> +		 " -G \"var_s32 = -0x80000000\" "\
>> +		 " -G \"var_u32 = 0x76543210\" "\
>> +		 " -G \"var_s16 = -32768\" "\
>> +		 " -G \"var_u16 = 60652\" "\
>> +		 " -G \"var_s8 = -128\" "\
>> +		 " -G \"var_u8 = 255\" "\
>> +		 " -G \"var_ea = EA2\" "\
>> +		 " -G \"var_eb = EB2\" "\
>> +		 " -G \"var_ec = EC2\" "\
>> +		 " -G \"var_b = 1\" "\
>> +		 "-vl2 > %s", fix->tmpfile);
>> +	if (!ASSERT_EQ(0, system(command), "command"))
>> +		goto out;
> Nit: there is SYS macro in test_progs.h, it combines
>       snprintf/system/ASSERT_OK/goto.
>
>> +
>> +	read(fix->fd, fix->output, fix->sz);
> Nit: check error for read() call (same read()/write() in tests below).
>
>> +	ASSERT_NEQ(NULL, strstr(fix->output, "_w=0xf000000000000001 "),
>> +		   "var_s64 = 0xf000000000000001");
> Nit: I'd do these checks as below:
>
> #define __CHECK_STR(str, name) \
> 	if (!ASSERT_HAS_SUBSTR(fix->output, (str), (str))) goto out
>          __CHECK_STR("_w=0xf000000000000001 ");
>          ...
> #undef __CHECK_STR
>
>       this way fix->output would be printed if sub-string is not found.
>       For other tests I suggest using ASSERT_HAS_SUBSTR as well,
>       as it prints the string where sub-string was looked for.
>
>> +	ASSERT_NEQ(NULL, strstr(fix->output, "_w=0xfedcba9876543210 "),
>> +		   "var_u64 = 0xfedcba9876543210");
>> +	ASSERT_NEQ(NULL, strstr(fix->output, "_w=0x80000000 "), "var_s32 = -0x80000000");
>> +	ASSERT_NEQ(NULL, strstr(fix->output, "_w=0x76543210 "), "var_u32 = 0x76543210");
>> +	ASSERT_NEQ(NULL, strstr(fix->output, "_w=0x8000 "), "var_s16 = -32768");
>> +	ASSERT_NEQ(NULL, strstr(fix->output, "_w=0xecec "), "var_u16 = 60652");
>> +	ASSERT_NEQ(NULL, strstr(fix->output, "_w=128 "), "var_s8 = -128");
>> +	ASSERT_NEQ(NULL, strstr(fix->output, "_w=255 "), "var_u8 = 255");
>> +	ASSERT_NEQ(NULL, strstr(fix->output, "_w=11 "), "var_ea = EA2");
>> +	ASSERT_NEQ(NULL, strstr(fix->output, "_w=12 "), "var_eb = EB2");
>> +	ASSERT_NEQ(NULL, strstr(fix->output, "_w=13 "), "var_ec = EC2");
>> +	ASSERT_NEQ(NULL, strstr(fix->output, "_w=1 "), "var_b = 1");
>> +
>> +out:
>> +	teardown_fixture(fix);
>> +}
>> +
>> +void test_veristat_set_global_vars_from_file_succeeds(void)
>> +{
>> +	struct fixture *fix = init_fixture();
>> +	char command[512];
>> +	char input_file[80];
>> +	const char *vars = "var_s16 = -32768\nvar_u16 = 60652";
>> +	int fd;
>> +
>> +	snprintf(input_file, sizeof(input_file), "/tmp/veristat_input.XXXXXX");
>> +	fd = mkstemp(input_file);
>> +	if (!ASSERT_GT(fd, 0, "valid fd"))
> Nit: ASSERT_GE.
>
>> +		goto out;
>> +
>> +	write(fd, vars, strlen(vars));
>> +	snprintf(command, sizeof(command),
>> +		 "./veristat set_global_vars.bpf.o -G \"@%s\" -vl2 > %s",
>> +		 input_file, fix->tmpfile);
>> +
>> +	ASSERT_EQ(0, system(command), "command");
>> +	read(fix->fd, fix->output, fix->sz);
>> +	ASSERT_NEQ(NULL, strstr(fix->output, "_w=0x8000 "), "var_s16 = -32768");
>> +	ASSERT_NEQ(NULL, strstr(fix->output, "_w=0xecec "), "var_u16 = 60652");
>> +
>> +out:
>> +	close(fd);
>> +	remove(input_file);
>> +	teardown_fixture(fix);
>> +}
> [...]
Thanks, will update this patch accordingly.
>


