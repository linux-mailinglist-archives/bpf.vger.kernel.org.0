Return-Path: <bpf+bounces-30310-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B411D8CC4EB
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 18:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6175C1F2291B
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 16:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40ED0141999;
	Wed, 22 May 2024 16:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b1W5D3q2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB44140E3C
	for <bpf@vger.kernel.org>; Wed, 22 May 2024 16:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716395709; cv=none; b=Qi/yNgBdZ77HDXO+MwzTdihvpIiyt2wWvPcwpgi4fHLeAefVmoiXXhhIkEPTHUQRi4/RozyzyNeOTDbnS+vNV4XQOb6h1Tq9GaWgE64Rz5E2ngmG5FmWm8MPjusZ0sEFu+Kb39WTAdRbr/6NsRm5ygr+YQ8oZyzVnQhRW57j//E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716395709; c=relaxed/simple;
	bh=wow702hEWO/XsKIRiOeK7H7iVtAxQpkaiyuys0HINig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dD6hbAO3Sf9TVv9mqU9o6Qst97iy0MCaIDBrylkCKv5UweDApAOjrYZQ00WOrLAJ2UIA31zf2HpPGqs/ekMSSIlA0CQoAVhpnvRFLnzWA0QDurxnO6B4VuiNmom6UoDBhqlqFJ4+bsr2iUrOJTtQ6OyrMQq2MW6pgSfa17/sBuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=b1W5D3q2; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5b27cc76e9aso330123eaf.2
        for <bpf@vger.kernel.org>; Wed, 22 May 2024 09:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1716395707; x=1717000507; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FF30FLh4FVIj5wgbcXLnpEEb1c/d7E6kmTu0z50oYHg=;
        b=b1W5D3q2beJtX3N9HzvoDuQ7BBtVhni8fHJ1kkFxClZdRBBrPwN11W+d/L45GTTpam
         TwaV+CD33Hjdo5YBrAIZySOKgdLuyNNYxRJz0GMKwaAhpxCkAXENKgGf4kLlwGHkKtfX
         L6QaLdyGvfMmd0q7a0i2j9/SbepGGDlun2SNs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716395707; x=1717000507;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FF30FLh4FVIj5wgbcXLnpEEb1c/d7E6kmTu0z50oYHg=;
        b=P0XnF9LOSeUneVcJiQJG+gw4i2vjjfkXKTdMvlYMB3NByBaDx5tCnqmvuVgRbjldJh
         bZlLI8AJRs452I8aYMMn6mnioVXfGHN2yPvnZ0NOn8ajcjjMZwvyA/0eqCKqwBbfrXiw
         uQrD02H7nIlmTQVctN2vIvUzkYj5ua9HLbbq9RfCSuZphpTul/IeuLUAoQVmoTstbObG
         ANhgu6b2QHK1cSPS0DgZwZTcswjqHaV2MA55mODlx3iMXHZcHWQguKIWkgwfKE4Ul6+u
         nzLSEZA1bgEQv3vSayOymWdMw81hsB9VLx5GK+T8I+f9FbaaiYdvlpkpWjMksDghk5+q
         mL8w==
X-Forwarded-Encrypted: i=1; AJvYcCWCVkNiiJW+akmKK6fvmcsOlhXu22PE2Ajwey6DBMbm06DjnzGiHiVMpoLTc/WdTxS8I2ZulpS6P683xih2YhkUgO3O
X-Gm-Message-State: AOJu0YxXNggssIuQXpeDKHGx7RYss6LWyG6Wso7RIJKpY9DZcJZbGf2U
	uA4CkU9hRrJD8uDJy1Q5BMErgv3j6E8nOOxPmbfEHYGbk38U83sAY/x98exOgIo=
X-Google-Smtp-Source: AGHT+IGHfAC3qkCN6OulIhZiaDBbxXmwg5VKYB936DJVaSdhJlQGCxL++LW2UUdg3/EuZDRuVOh0Ug==
X-Received: by 2002:a05:6820:2585:b0:5b2:7d9f:e708 with SMTP id 006d021491bc7-5b6a2df34f2mr2891522eaf.1.1716395707090;
        Wed, 22 May 2024 09:35:07 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5b31b52263fsm2644126eaf.21.2024.05.22.09.35.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 May 2024 09:35:06 -0700 (PDT)
Message-ID: <25596b05-205a-471d-884f-289db262c485@linuxfoundation.org>
Date: Wed, 22 May 2024 10:35:05 -0600
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/68] Define _GNU_SOURCE for sources using
To: Paolo Abeni <pabeni@redhat.com>, Edward Liaw <edliaw@google.com>,
 shuah@kernel.org, =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Christian Brauner <brauner@kernel.org>,
 Richard Cochran <richardcochran@gmail.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-team@android.com, linux-security-module@vger.kernel.org,
 netdev@vger.kernel.org, linux-riscv@lists.infradead.org,
 bpf@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240522005913.3540131-1-edliaw@google.com>
 <b5e333368d9e69efc6325187a23cef4f4337c738.camel@redhat.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <b5e333368d9e69efc6325187a23cef4f4337c738.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/22/24 01:42, Paolo Abeni wrote:
> On Wed, 2024-05-22 at 00:56 +0000, Edward Liaw wrote:
>> Centralizes the definition of _GNU_SOURCE into KHDR_INCLUDES and removes
>> redefinitions of _GNU_SOURCE from source code.
>>
>> 809216233555 ("selftests/harness: remove use of LINE_MAX") introduced
>> asprintf into kselftest_harness.h, which is a GNU extension and needs
>> _GNU_SOURCE to either be defined prior to including headers or with the
>> -D_GNU_SOURCE flag passed to the compiler.
> 
> I'm sorry for the late question, but what is the merge plan here?
> 


I have asked Edward Liaw explore options to localize the fix to the
problem introduced by the following commit

809216233555 ("selftests/harness: remove use of LINE_MAX")

I am not happy with the churn. I don't plan to merge this series
as it for sure.

If and when this problem gets fixed, I plan to merge the change and
take it through kselftest.

thanks,
-- Shuah

