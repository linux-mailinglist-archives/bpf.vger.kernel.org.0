Return-Path: <bpf+bounces-35524-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D0893B4EB
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 18:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E750282C13
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 16:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F9415E5B8;
	Wed, 24 Jul 2024 16:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2nhMect"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D1518E10
	for <bpf@vger.kernel.org>; Wed, 24 Jul 2024 16:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721838245; cv=none; b=Kw4QSBePej0P5q+nOydU5NpA/Kj5f/X5wKBry+m16nvaAVjk/4nKuoIolBNOPXth0kdaOw04xqpI/11Cj7BNB3HoEG+6bOyes7SqgPXsmqPuaJTmrOpxxhi+iPuFEwZpM8krS2GobpVHFdsTYH0Z4r+HPjFjJzGtQnxTAqq5SK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721838245; c=relaxed/simple;
	bh=cGSguORkwVIeR4jQyrEv3nKd4usw+T+jxNMcoU4mxTM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r4ECMxIlV55we1h4K8QwKOYCpolcSfPhiT61bN+e0Q1iy3q0ay6fLLOMmpYEIjr5kPEXojE53C0TA5aO6bYILF25ct5K2C63CxkEkkGeFYwnh94vbiRN8lHfpor9H5knX2KvEfqLJg7jbX03NiJZnFyXuWlgfX8+73tsv4daB1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H2nhMect; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-66108213e88so68723857b3.1
        for <bpf@vger.kernel.org>; Wed, 24 Jul 2024 09:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721838243; x=1722443043; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=thPyQFfNml51YcCH2023gxo99EaamlJLt3vtneP5gjk=;
        b=H2nhMectQkM/5v4DXRrEWnCClTGl0a1XqDuQM6G+/rIIjXzTqzruy+jcHfvvm+Z8UQ
         mk8xslB0dqMWbZpxTsFJzR0RoQX31/WwqaZNP+5aRmu7E/RviN2wBibIJ4Ka9PQAjOi6
         1iiHpzE9oGZCfyQwoTht7Z26BLjsYG4sfWXc6AvByejF/o+CW0q+izXKS2v27vCzR5Sh
         NI+7pru8mIv1DTJTKjkuXn5YVuU6sMfD+q91zy13ubMiLnJOj76KB/5Y608f6Ajj/EK4
         YsDxdWzDFi7odGQAHBeZE8lOa0tV6P3KCqj+oU40SNL/QHUtYsNTNUqB4pGKadddxf1C
         /FzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721838243; x=1722443043;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=thPyQFfNml51YcCH2023gxo99EaamlJLt3vtneP5gjk=;
        b=dywfN0Rq1XkvOvkKXWGdu6yKEaGBlFMpV/XRWI8CjNb08c4MPBKjqDVwfdeS34emkm
         rz89yWxXncjH+nvwRzU2OVL74EDMAhp7TgvvxZEZ27H+6HHYWbPEmjQ9axl6hZFIq7I2
         61rYxzqUdleDOdL18aLpNW5tuQOrZWKF4Nf/0X6uw7EEgukk0t8oVGh3+hL10l1V0Eeq
         cOZCOcsLv3WCA7xxjdGIX40TPcCOwlAXFcAEn/A95x3TjErNfhBWWsq/yTxo3KmnKt61
         F/57+Cqm3pqRvV0Hupu2B5JI+KI93cqtrHvNm+4vR5v0cFZkjQeaEUEa9T3t/cAxIbwx
         K5VQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQGg3FrDkDmwPe9eslJiY7b1pSCe12tBqMAikpWMK8oCIucLlVfyw/b/b2LjbsT+zcJY4hvVB2CBDnSsxoVNpOZWVR
X-Gm-Message-State: AOJu0YyNkUVWnrLXdjgzaAfhkuMKinlFrTs2c9e6QskaeN5H05b5tE/i
	pL23l1hD2A3/BVO3UVaWunASGyJC9aA7hmzDRnDSvvaRoqHeH0Zy
X-Google-Smtp-Source: AGHT+IGgmId4ONYg9LJAK19GPAKDCXn0aJnvY9oCyoTeeBcOw4F8MkeGb/u5j30dE8HmtpozV4+lVA==
X-Received: by 2002:a05:690c:4246:b0:64b:44b4:e13 with SMTP id 00721157ae682-6727d6c6049mr27864387b3.28.1721838242654;
        Wed, 24 Jul 2024 09:24:02 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:abc3:64f6:15ee:5e16? ([2600:1700:6cf8:1240:abc3:64f6:15ee:5e16])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-66953ae0a9dsm25373887b3.99.2024.07.24.09.24.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jul 2024 09:24:02 -0700 (PDT)
Message-ID: <bcafcd2b-0ab5-4e43-a4bd-84eb97109991@gmail.com>
Date: Wed, 24 Jul 2024 09:24:00 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 2/4] selftests/bpf: Monitor traffic for
 tc_redirect/tc_redirect_dtime.
To: Geliang Tang <geliang@kernel.org>, Kui-Feng Lee <thinker.li@gmail.com>,
 bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, sdf@fomichev.me
Cc: kuifeng@meta.com
References: <20240723182439.1434795-1-thinker.li@gmail.com>
 <20240723182439.1434795-3-thinker.li@gmail.com>
 <a5fbc09945bf0f191d9ca52bd5238871171ab9f8.camel@kernel.org>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <a5fbc09945bf0f191d9ca52bd5238871171ab9f8.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 7/24/24 01:36, Geliang Tang wrote:
> On Tue, 2024-07-23 at 11:24 -0700, Kui-Feng Lee wrote:
>> Enable traffic monitoring for the test case
>> tc_redirect/tc_redirect_dtime.
>>
>> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
>> ---
>>   tools/testing/selftests/bpf/prog_tests/tc_redirect.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
>> b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
>> index 327d51f59142..1be6ea8d6c64 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
>> @@ -900,6 +900,7 @@ static void test_udp_dtime(struct test_tc_dtime
>> *skel, int family, bool bpf_fwd)
>>   static void test_tc_redirect_dtime(struct netns_setup_result
>> *setup_result)
>>   {
>>   	struct test_tc_dtime *skel;
>> +	struct tmonitor_ctx *tmon = NULL;
> 
> nit: No need to set "tmon" to NULL here.

Earlier "goto done" statements would need tmon to be initialized.
Does that make sense?


> 
>>   	struct nstoken *nstoken;
>>   	int hold_tstamp_fd, err;
>>   
>> @@ -934,6 +935,9 @@ static void test_tc_redirect_dtime(struct
>> netns_setup_result *setup_result)
>>   	if (!ASSERT_OK(err, "disable forwarding"))
>>   		goto done;
>>   
>> +	tmon = traffic_monitor_start(NS_DST);
>> +	ASSERT_NEQ(tmon, NULL, "traffic_monitor_start");
>> +
>>   	test_tcp_clear_dtime(skel);
>>   
>>   	test_tcp_dtime(skel, AF_INET, true);
>> @@ -958,6 +962,7 @@ static void test_tc_redirect_dtime(struct
>> netns_setup_result *setup_result)
>>   	test_udp_dtime(skel, AF_INET6, false);
>>   
>>   done:
>> +	traffic_monitor_stop(tmon);
>>   	test_tc_dtime__destroy(skel);
>>   	close(hold_tstamp_fd);
>>   }
> 

