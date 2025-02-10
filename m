Return-Path: <bpf+bounces-50992-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E9DA2F0FF
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 16:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3139163A94
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 15:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BDD8204861;
	Mon, 10 Feb 2025 15:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LnzQrgKR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335571CA84;
	Mon, 10 Feb 2025 15:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739200325; cv=none; b=PVz+EGXtRCxPwu32MXv9HgfVaEwWXeSOXNi4FWv4p20T7QT5u3nHdmPw7gliTioW7T1yjnMDJPzAu7R3GxX5O0VCQE7by+kBIZHiI9sU/qqyzIWpxJMEk2TL9oCYsbBBu1JTMUsauGlyUGLbII/Z4wIH4SSoiOpJ84VWWkZqhwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739200325; c=relaxed/simple;
	bh=x/7S1tchuBT4T48aebrLbaQ1SbEdg8BOEkE3/s6U9BU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EEzd4YW8/3CQ5VQ82JSMxG9iOHy4ihLfnuzCWF0miauq0+6C9P3KoYFb/xFH9yg6QDXIxAneXMgxf+7JkTq19NcQR1XMSztQNKuLcfHZ1jgsYh0sfP7/4UWw3LPENOZVCBhz1olhcTiOxaDQZ9pileMpr2MjFKUpxU+1I/kvsqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LnzQrgKR; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21f48ab13d5so71272015ad.0;
        Mon, 10 Feb 2025 07:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739200323; x=1739805123; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TwlaKob5aPZVu9GIo5whxhxN00CNR1c8p78BFmqhxnQ=;
        b=LnzQrgKRdfaTmMRArDXvyKysBqe1l8weQzneVQ2m7jlTNetAHJ8AZ5bEGMkQPJGHwg
         eEMzjbRysqZV0TwR6wDulKtHDjvVfQ09VCvWSz80pFjkuz8GiHKmCt1bOKp2FoK1CT1o
         EtAZNtY5fEVXMRf7D2in3TuyGXOsjDk7myDRGoNUKOWxeTiR/MpjaetgCa3L5ybWucbn
         DshoHXlChRzZkcknZ7pqVSSYhGWPGbj+z3Vo7pb3VtxqlM28Q2HFVzKhC0wOZ5ALfoJV
         95IsXdfNMLwI3S/vHgkO33fbqlqNwdyBXxdvlLgKwtJG5Cpgfj+kQphkYoKByUrJ3cSK
         ZxEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739200323; x=1739805123;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TwlaKob5aPZVu9GIo5whxhxN00CNR1c8p78BFmqhxnQ=;
        b=OFAA8epRDWeDXx/Emh9LeTiY2TBnFDvZtE0smc/tDLUO1k5NeJyQR5K3hBkplgiedK
         AWyj5+GoX8WSCYjKa2U/C2F7fEt7CA0zFUGAWzAv7qWqvq5NDtynCf1pzgjXCpDQHrYd
         tmcFkCTb4BI3Ow+SWrUwxYscAGXMCTOI6Bx1T0OyMtiHDFmDtKLBeXjjMLtszpZTHaQA
         g4iv19DIBaUKN97n3tmIMQvXq5dn6UB+YIDJczTs/ofdZfCjpQFIibs+zlicLC0jZ3mI
         Fhkx1HCu+TSNV+Vev8LPo9ZfY+1VR5PkUHXY7XlfSHshXQRl70h6m865HH/ZKh+bIpal
         8X2A==
X-Forwarded-Encrypted: i=1; AJvYcCXYRw3UMUCpf4F1hQXja4B00GfOE4QfeCWO2oyena8tkyu8IC0jl0pUZ+Ni+42KUBwuH57ihX4XhvtIXN6k@vger.kernel.org, AJvYcCXkWFoxMkylK/uww5RF5qk70zAaxo6QZrgep9rGsgawih2G/Tw05epD7OqIag7786T/P7g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6uxPnbK8dWULM2Yz9wt5NFs2OdREX56xFUqZCHr1xoFESNhDB
	IGFQ2NEiL85lx5RKHJKax6lmEWx8+zGWrOt4eW32uA9P8ndVjbihZqoz+g==
X-Gm-Gg: ASbGncs+DXZWOSxZd+Pqdj0gEkrr3vfQgLDEt7CfW34IxyuzbokECMBrZ32rvDUx4u0
	KcTLOZJgh3SRJxr2ZkWDk4uvBAtewoMTP3XedSkwighOdjCqZ1rsaBJk+9OwUJpsGJgYlylJ8K/
	mDe2nYIvO+MrCjg7PioHZqMqV/ck76vzDqFILxtAyce+63eKBeYNBCALT0qlWCffhnX3ZCwEtAS
	xHYeGA1W8lo4WMF7pPzV5aAnOfgr2YBDmVAH/rX2Es/Voj+vHMcoTddpGTy3yCKN/F+LL5EqCLL
	VKuj2jMqXDP3
X-Google-Smtp-Source: AGHT+IHRU7SfP3/WrS2oIjmCiGCsoVPhbHW8Xu9AvHFvJV4J1y32M+1ILa6ZWYEGUWW4UaGRYenVcQ==
X-Received: by 2002:a17:902:ec84:b0:21f:85d0:828 with SMTP id d9443c01a7336-21f85d00ac1mr104164225ad.41.1739200323218;
        Mon, 10 Feb 2025 07:12:03 -0800 (PST)
Received: from [0.0.0.0] ([5.34.218.148])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ad53de9ee79sm3573749a12.40.2025.02.10.07.11.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2025 07:12:02 -0800 (PST)
Message-ID: <179645b8-fd74-415b-8522-9de13e84c883@gmail.com>
Date: Mon, 10 Feb 2025 23:11:57 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 4/4] selftests/bpf: Add libbpf_probe_bpf_kfunc
 API selftests
To: Jiri Olsa <olsajiri@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, haoluo@google.com, qmo@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250210055945.27192-1-chen.dylane@gmail.com>
 <20250210055945.27192-5-chen.dylane@gmail.com> <Z6oDXNpqmwHo6lKh@krava>
From: Tao Chen <chen.dylane@gmail.com>
In-Reply-To: <Z6oDXNpqmwHo6lKh@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2025/2/10 21:47, Jiri Olsa 写道:
> On Mon, Feb 10, 2025 at 01:59:45PM +0800, Tao Chen wrote:
>> Add selftests for prog_kfunc feature probing.
>>
>>   ./test_progs -t libbpf_probe_kfuncs
>>   #153     libbpf_probe_kfuncs:OK
>>   Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
>>
>> Signed-off-by: Tao Chen <chen.dylane@gmail.com>
>> ---
>>   .../selftests/bpf/prog_tests/libbpf_probes.c  | 118 ++++++++++++++++++
>>   1 file changed, 118 insertions(+)
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c b/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c
>> index 4ed46ed58a7b..fc4c9dc2cbed 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c
>> @@ -126,3 +126,121 @@ void test_libbpf_probe_helpers(void)
>>   		ASSERT_EQ(res, d->supported, buf);
>>   	}
>>   }
>> +
>> +static int module_btf_fd(char *module)
>> +{
>> +	int fd, err;
>> +	__u32 id = 0, len;
>> +	struct bpf_btf_info info;
>> +	char name[64];
>> +
>> +	while (true) {
>> +		err = bpf_btf_get_next_id(id, &id);
>> +		if (err && (errno == ENOENT || errno == EPERM))
>> +			return 0;
>> +		if (err) {
>> +			err = -errno;
>> +			return err;
>> +		}
>> +		fd = bpf_btf_get_fd_by_id(id);
>> +		if (fd < 0) {
>> +			if (errno == ENOENT)
>> +				continue;
>> +			err = -errno;
>> +			return err;
> 
> nit, return -errno ?
> 
> jirka
> 

Ack.

>> +		}
>> +		len = sizeof(info);
>> +		memset(&info, 0, sizeof(info));
>> +		info.name = ptr_to_u64(name);
>> +		info.name_len = sizeof(name);
>> +		err = bpf_btf_get_info_by_fd(fd, &info, &len);
>> +		if (err) {
>> +			err = -errno;
>> +			goto err_out;
>> +		}
>> +		/* find target module btf */
>> +		if (!strcmp(name, module))
>> +			break;
>> +
>> +		close(fd);
>> +	}
>> +
>> +	return fd;
>> +err_out:
>> +	close(fd);
>> +	return err;
>> +}
> 
> SNIP


-- 
Best Regards
Dylane Chen

