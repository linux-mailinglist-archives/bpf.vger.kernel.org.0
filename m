Return-Path: <bpf+bounces-49842-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5662A1D0B1
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2025 06:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 361BE165C20
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2025 05:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43FAF1FC0F0;
	Mon, 27 Jan 2025 05:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PmHDGUrS"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD98525A638
	for <bpf@vger.kernel.org>; Mon, 27 Jan 2025 05:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737956240; cv=none; b=rx+L2u5eflXxdyuuIlb8OevQwGZI5ZLNN1LNyq0kqL9Z1DvUtetSWRIjIeJCMHLidFXJPvAWE09EZgKsPsYBu5M6o+iYvX8TM3aCdspaPXDotNvDG/e45G+Mt+GSMNvo8gGzf3yM61FADVmzyHG1T8vpSm2TzoB9uScV+q4xvIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737956240; c=relaxed/simple;
	bh=bLD2EWuUPmsgCtgji9updHdwiTh+VTqIgZh3/uNsvOY=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ROW3D2OctvTI63X1NDSoKijpcRIm589KfAmck1oBriKYoqpQBXDLnG37dhtsDTtn7rYQNxH0ANyZmhBYAW6FlFd/cptDem3A3trhdSSpD23Wh2p4XhncmdpX0mgOoPKpSNh5SuR4ERyjGA9+u7US2YrchzUIF4zc4zDRqeCK7TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PmHDGUrS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737956236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uSE/Ol0JxTU1WHL/Q25yYd5SaYMCxKx8zTy8OtH2Clc=;
	b=PmHDGUrSVfmuHBueaH/u+Ge55K638niKW+HYgecEswnSdTArZg7kOBYwlNPX4vU4fErI73
	k0Un2aGG955HP56bX/5YQmkVUtaQFfVnhcbFfQhhErGLQXON1NTq8SmYbfvQxWelEiZZ5R
	K2o6k99ShKSf9mcx1iuFbKjVc8SQNs0=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-mza_FxzZM0ORjVzHhX27bA-1; Mon, 27 Jan 2025 00:37:15 -0500
X-MC-Unique: mza_FxzZM0ORjVzHhX27bA-1
X-Mimecast-MFC-AGG-ID: mza_FxzZM0ORjVzHhX27bA
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ef909597d9so12206958a91.3
        for <bpf@vger.kernel.org>; Sun, 26 Jan 2025 21:37:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737956234; x=1738561034;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uSE/Ol0JxTU1WHL/Q25yYd5SaYMCxKx8zTy8OtH2Clc=;
        b=suGWy8OsXxZdN83DyHFeKIcOGBnZL+T9HAHzJbWFVHdBoUb0I8s9belJRwMrAQ/Vzj
         7+WRZuhgVI2BOT0uioHn1vfU2MWL/0wAmDYjb4bJw8TzSYClmU6md6IhWV3g/mPr6TbT
         chRDfaEk8oPp4kKMQM8inRzWORJjsTT6Sa8vwTH7q/9aATKWSi1wk7OBcPQND9+iROY5
         5s+dodSNwRpviC8ALaTUPryUTW0nokvpDgbONPT88mz3rbz+hnrm7p42adxWSZr57MX2
         YfqfoajAIHHik8OJiJXhVGKXN9Y3Qnfr82ovJ0cQRJxOr4uVBTEVNfSGzXQs5VeTgGq+
         f4tw==
X-Forwarded-Encrypted: i=1; AJvYcCWg7DWJA4DSxZ9jGVj+r+zlHgV+gj7N7k8pnuHa5DflM02MHJemRAERTKRhPGTbZ0f9Tsg=@vger.kernel.org
X-Gm-Message-State: AOJu0YymnItdtpL3tJpEAoJIXeSvIcH749HAqAllYYsymnOkpVKk96BZ
	dXNDD+J8A4dFZlG6G7zW5NbPvcq0tYWzOlpkAg8iwcXpqC62abzbl+ktH8EyjeIZIjgo5zpJRqY
	9eZDTfoHBv4GT1jgC9QFuqsiQncHzmbBcNdfYEREGkhPiZyzPRQ==
X-Gm-Gg: ASbGncu/CLcxbFmS81FRPmNzM2rQu94LHAI4lFDzQl0P/KfGJgPmX6oCOH1cwl+j2uv
	Nuk0wZITENAaV39xdWQW62TQDc/+RO7aHn65Va1xYYzhAYzC2fAmGNoyKFLSvIIgYeT3K0RWNBL
	tMR9fnAhBm2XPkLUTzo3BENJRYfaHAYqyZDrtwchTLiRSUOvaDOSYc6BWe4K+I61JaQQDAynUqA
	UecJYIs/LJg+qzK3ax1pCidx2+pjshDbdnPc/030aohLbwGialbyIfO5KDUy+iPRE4bq/mBq1+b
	LA==
X-Received: by 2002:a05:6a00:989:b0:71d:f4ef:6b3a with SMTP id d2e1a72fcca58-72dafba3219mr53726569b3a.21.1737956233972;
        Sun, 26 Jan 2025 21:37:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH/TqssDmvWN5ryUQzgtXvQ2YFb2l8lfzcBQQ6GtdZ/r9rC4GQ9Xe2PYMi0tKnJZJMOA4H7hA==
X-Received: by 2002:a05:6a00:989:b0:71d:f4ef:6b3a with SMTP id d2e1a72fcca58-72dafba3219mr53726536b3a.21.1737956233619;
        Sun, 26 Jan 2025 21:37:13 -0800 (PST)
Received: from localhost ([240d:1a:c0d:9f00:a03a:475d:8280:d9b7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72f8a77c82fsm6173868b3a.126.2025.01.26.21.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jan 2025 21:37:13 -0800 (PST)
Date: Mon, 27 Jan 2025 14:37:03 +0900 (JST)
Message-Id: <20250127.143703.343581919278286700.syoshida@redhat.com>
To: martin.lau@linux.dev, stfomichev@gmail.com
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 hawk@kernel.org, lorenzo@kernel.org, toke@redhat.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH bpf v2 2/2] selftests/bpf: Adjust data size to have
 ETH_HLEN
From: Shigeru Yoshida <syoshida@redhat.com>
In-Reply-To: <35e5479b-420c-4fd9-80d9-c04530ef1dc2@linux.dev>
References: <5e342fea-764b-48a0-afda-4adfb504bd46@linux.dev>
	<Z5L-ubBI7z1J6IDi@mini-arch>
	<35e5479b-420c-4fd9-80d9-c04530ef1dc2@linux.dev>
X-Mailer: Mew version 6.9 on Emacs 29.4
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Fri, 24 Jan 2025 11:22:16 -0800, Martin KaFai Lau wrote:
> On 1/23/25 6:45 PM, Stanislav Fomichev wrote:
>> On 01/23, Martin KaFai Lau wrote:
>>> On 1/23/25 11:18 AM, Stanislav Fomichev wrote:
>>>> On 01/22, Shigeru Yoshida wrote:
>>>>> The function bpf_test_init() now returns an error if user_size
>>>>> (.data_size_in) is less than ETH_HLEN, causing the tests to
>>>>> fail. Adjust the data size to ensure it meets the requirement of
>>>>> ETH_HLEN.
>>>>>
>>>>> Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
>>>>> ---
>>>>>    .../testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c  | 4 ++--
>>>>>    .../testing/selftests/bpf/prog_tests/xdp_devmap_attach.c  | 8 ++++----
>>>>>    2 files changed, 6 insertions(+), 6 deletions(-)
>>>>>
>>>>> diff --git
>>>>> a/tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c
>>>>> b/tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c
>>>>> index c7f74f068e78..df27535995af 100644
>>>>> --- a/tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c
>>>>> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c
>>>>> @@ -52,10 +52,10 @@ static void test_xdp_with_cpumap_helpers(void)
>>>>>    	ASSERT_EQ(info.id, val.bpf_prog.id, "Match program id to cpumap entry
>>>>>    	prog_id");
>>>>>    	/* send a packet to trigger any potential bugs in there */
>>>>> -	char data[10] = {};
>>>>> +	char data[ETH_HLEN] = {};
>>>>>    	DECLARE_LIBBPF_OPTS(bpf_test_run_opts, opts,
>>>>>    			    .data_in = &data,
>>>>> -			    .data_size_in = 10,
>>>>> +			    .data_size_in = sizeof(data),
>>>>>    			    .flags = BPF_F_TEST_XDP_LIVE_FRAMES,
>>>>>    			    .repeat = 1,
>>>>>    		);
>>>>
>>>> We should still keep 10, but change the ASSERT_OK below to expect the
>>>> error instead. Looking at the comment above, the purpose of the test
>>>> is to exercise that error case.
>>>>
>>>
>>> I think the bpf_prog_test_run_opts in this dev/cpumap test is to check
>>> the
>>> bpf_redirect_map() helper, so it expects the bpf_prog_test_run_opts to
>>> succeed.
>>>
>>> It just happens the current data[10] cannot trigger the fixed bug
>>> because
>>> the bpf prog returns a XDP_REDIRECT instead of XDP_PASS, so
>>> xdp_recv_frames
>>> is not called.
>>>
>>> To test patch 1, a separate test is probably needed to trigger the bug
>>> in
>>> xdp_recv_frames() with a bpf prog returning XDP_PASS.
>> Ah, yes, you're right, I missed the remaining parts that make sure
>> the redirect happens
> 
> Thanks for confirming and the review.
> 
> Applied the fix.

Hi Martin, Stanislav,

Thank you for your comments and feedback!

> Shigeru, please followup with a selftest to test the "less than
> ETH_HLEN" bug addressed in Patch 1. You can reuse some of the
> boilerplate codes from the xdp_cpumap_attach.c. The bpf prog can
> simply be "return XDP_PASS;" and ensure that
> BPF_F_TEST_XDP_LIVE_FRAMES is included in the
> bpf_test_run_opts. Thanks.

I'm not very familiar with bpf and its selftests, but I will try to
make a new test according to your advice.

Thanks,
Shigeru


