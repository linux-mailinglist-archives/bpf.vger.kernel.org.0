Return-Path: <bpf+bounces-78739-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A9637D1A7D1
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 18:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1E38B308A735
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 16:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BF93933FB;
	Tue, 13 Jan 2026 16:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="aEJQBFTL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06633803D9
	for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 16:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768323466; cv=none; b=F4JhvRpXMiN6Gp6aO4Xo7IoyoWatKs8yhlQNkuEz1M9r5yXmtj81PAarYy1aMLfxZSQd3B9BikomaRVFIt5Uk9OdtxGPdHcg888OijxPIEB0VBoTg+IOEFScQfbijjhtlBItK9R8DQ3qcM/lJ57EKuWVdWEj2Fe8Ikj9EwPS/Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768323466; c=relaxed/simple;
	bh=0XnufA+vKKOFM3j1I6V3PEMQn3QU8xGoTX9vlIzUKTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EAaEge9XpKJEZU6NIO4qzBEgtW7rfhA5PyCR2CxtMhkf5iDwxK5BInsv8k2DKsz7JimTU2+QO1wu1FjLagtuZcKrcfO3JvU2V4F8Bel5dVBPEv4LwgkVbR1fbhZVaJqCeSiXdbS/1deeM7ijDgB77s5tuDHB9kUXGYeqzaLbu2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=aEJQBFTL; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-12332910300so1142987c88.0
        for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 08:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1768323459; x=1768928259; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/IWdv0aphEAVaIt1hnbRSuaugoQ1OgFL1kohFBWpHLY=;
        b=aEJQBFTL/qRglMNkawY4oTlqXZL4trWCpQku9IdjJfPVRDhx/aS6WNhSmWaZ7kD7Gp
         ztQxkanhvHVKZ301ooddDR15R7fx6GdllaEYm4EiI0xPA1XgL8J/Mg9//CY53SvjmTBF
         0f/sZUtc1Sq3pbytXfIE6m0oMrUlLX34HachD3NIczMLSPXYRkOhphJfwKQAUDzawbUO
         YTdkDPE6KTegNkuZNErSMs1U5VtqxNHuLjwA1LQC31j7JEXNNJ0WbPqPYbp5IsKXDJlF
         d4Nfn4iicsNctgS8ZbuA2E1cOock0clHgYfHw6EYpg22Vz92z4OswGKMLpQE5il9vxUg
         DyyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768323459; x=1768928259;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/IWdv0aphEAVaIt1hnbRSuaugoQ1OgFL1kohFBWpHLY=;
        b=QavYMZeuz0lcySKBtwsW6bacM6MVNwWBtX5QqLRQ3ycA9duvj/b9QEfh4k/44cXZ1i
         Su7iwGdttaWwJ7OuIgU68ig+ZKTQfqVey+/mbt/VD7qbYU94L34jqstZDLa1BgnHx41q
         2JQcOWGG8a8ZB8LqfvcHcu6nIcvURlYExvdaKLtAA6MKB9SMvPjMlhfBRsGa6kOVhDFh
         N8VeNVodFhUofTEMyQfqd3Oair0STdoEhZCXNxmptZgs4Q5kDVQavMHMX7xBtyJcMeAa
         hJhofsvsiWE0fNmImXm9ebbjDiZxWtQJSOtuIdWUhLcADcztdnAmsf158dTnJfLiTaDB
         Fshg==
X-Forwarded-Encrypted: i=1; AJvYcCWDZu2+zV85Lw0i0CNwj/eXoehO9PqcfeWmtO4F0HwDZ5ZV8Fdv9jSwH0vTupGdAB4G6e8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ5Lj5vFRPiCBVMn0i7+tq4HlRBCWTmjRlEVLE4SxhdGYLKYOH
	bt9yFOlWeaJVAQVaxdtnHJlBWExqGOq3FQHcnnD4yzwXQH2siwdO3vEmvR2P1v6KXyc=
X-Gm-Gg: AY/fxX7HSCFKs3MRLIoDAujgR0I9VpyL5A3B/DCZrNFDOMHBL7HdJvcMAk8MAoebVlq
	/qykuriGT4wSAqeGa5Voc03kLT8ixmu49J9hsYXmX56Ul+6T4BauplZlExRluiAfyx0KgYktEoj
	Lx2miN+i7A01BJnR7x5CFm8HwzMhbWcX73Zb2GsKJhIuiVgJyUhR3pEg7Hg7L71Ib6avaKJnoiN
	t7vSBfLdwLghoEnOxpl1o+AI+RKfpCW4oraWpku4sr0xjUcOH2Lk5DCsn7arQcqULkdIh1bw6vz
	BWgbjjOoJO566U1VqAad2Ac3MXOl8t3aKh7u0QfkSMkDe8jJ4SukWzPOY8Q5/5BEfPT7tG6stQL
	hKvWmzWLT0QsMpMrdmICvfXivOuq2j3MeNfqiubHJ1SybKeA31tCeZ7PJL4vTM58UbLVD08oS9H
	t1BmIMzsrlYegpZWVWh4JvohlTtR3ac0WBQuCR+csshil0U2fn2uHV+6W0CScI/jAuMpA/+s7KM
	uNUwNsFBdNFPxCx142f
X-Google-Smtp-Source: AGHT+IH/Z/YUd3HhJgUE2KDAOVqPnirOdWOY08BI6bWnSTC6xKDHkmgqpxkpujIvZh2zqFAbqFN1gQ==
X-Received: by 2002:a05:7300:ed13:b0:2ae:5cdc:214c with SMTP id 5a478bee46e88-2b17d30bff4mr23323000eec.39.1768323459051;
        Tue, 13 Jan 2026 08:57:39 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1156:1:c8f:b917:4342:fa09? ([2620:10d:c090:500::7ecc])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f248c239sm23354318c88.9.2026.01.13.08.57.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jan 2026 08:57:38 -0800 (PST)
Message-ID: <24891166-20a8-42d7-88bd-0b3f4d425c33@davidwei.uk>
Date: Tue, 13 Jan 2026 08:57:36 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 13/16] selftests/net: Add bpf skb forwarding
 program
To: Stanislav Fomichev <stfomichev@gmail.com>,
 Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, kuba@kernel.org,
 davem@davemloft.net, razor@blackwall.org, pabeni@redhat.com,
 willemb@google.com, sdf@fomichev.me, john.fastabend@gmail.com,
 martin.lau@kernel.org, jordan@jrife.io, maciej.fijalkowski@intel.com,
 magnus.karlsson@intel.com, toke@redhat.com, yangzhenze@bytedance.com,
 wangdongdong.6@bytedance.com
References: <20260109212632.146920-1-daniel@iogearbox.net>
 <20260109212632.146920-14-daniel@iogearbox.net> <aWQPNM5Sh1QNKtp7@mini-arch>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <aWQPNM5Sh1QNKtp7@mini-arch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-01-11 12:59, Stanislav Fomichev wrote:
> On 01/09, Daniel Borkmann wrote:
>> From: David Wei <dw@davidwei.uk>
>>
>> Add nk_forward.bpf.c, a BPF program that forwards skbs matching some IPv6
>> prefix received on eth0 ifindex to a specified netkit ifindex. This will
>> be needed by netkit container tests.
>>
>> Signed-off-by: David Wei <dw@davidwei.uk>
>> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
>> ---
>>   .../selftests/drivers/net/hw/.gitignore       |  2 +
>>   .../selftests/drivers/net/hw/nk_forward.bpf.c | 49 +++++++++++++++++++
>>   2 files changed, 51 insertions(+)
>>   create mode 100644 tools/testing/selftests/drivers/net/hw/nk_forward.bpf.c
>>
>> diff --git a/tools/testing/selftests/drivers/net/hw/.gitignore b/tools/testing/selftests/drivers/net/hw/.gitignore
>> index 46540468a775..9ae058dba155 100644
>> --- a/tools/testing/selftests/drivers/net/hw/.gitignore
>> +++ b/tools/testing/selftests/drivers/net/hw/.gitignore
>> @@ -2,3 +2,5 @@
>>   iou-zcrx
>>   ncdevmem
>>   toeplitz
>> +# bpftool
> 
> nit: "# bpftool" is not needed here?

Leftover from a previous iteration. Will remove.

