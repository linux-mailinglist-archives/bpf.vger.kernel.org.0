Return-Path: <bpf+bounces-36713-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0050194C5AA
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 22:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA48A1F2352C
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 20:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C502B156237;
	Thu,  8 Aug 2024 20:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CeR8UTq/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F277B15350B
	for <bpf@vger.kernel.org>; Thu,  8 Aug 2024 20:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723148621; cv=none; b=Kcp/bu1IC0b+4O9Y8It/oUmIbyK3kn728ZNnfklGyaGjW1C+ncYOGOI7SyQVdUd19gLBO2byY0ultQqsnVYs129IETSioU5/G9hLd28YLLBWPNR5bToHmxkaAYt5aXHTRlqyUY0bOf+M7HW5IMEt23CVxc/Kf9nEFEUyuCfRxFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723148621; c=relaxed/simple;
	bh=/7yrbU89jzG1sb3DiJGrj3LjaLdB4jeJhUQXcWaB1pI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M1BFEqWaY29GM45yoCSHKM8os/l8B340kQo/oZjZabi06GvSVWqUgONA1vIBEMDa9rmqo6n9qrtu0b7Lb5ziBQwJzJMGvHYsjT4QuFn+sZr1L5aiWX4ZrDrU3Zuy+ItE9b/Lf09i8vC7Eb4Jr+7g36CCudrinZqhIv81qK133Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CeR8UTq/; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-65f7bd30546so10730807b3.1
        for <bpf@vger.kernel.org>; Thu, 08 Aug 2024 13:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723148619; x=1723753419; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EYPhQsld9GAJre99feKKIfmgjeFER2AEU0jPN6Kk/to=;
        b=CeR8UTq/FoNLiArgulrNJzVAnUWmAE4X6NqFtC5UeqMZ5+8z4PhzgJ+jU0g/3X7HOT
         nDslhIX+yYhZuTTDWc6n3qM2uZReD4vy5gG0ricj0W0HVi0PbOXrT13bs3DDSuNC5JOq
         zEaz+e2u+H3saNbqJ9fhQkYh6yJnuzMBH0YvUlBopAcMJiD8NWDQldCzdPbYJ059g+h7
         rNfJsE+mp/8tSwPcg1rSghV0fqfaHT9n0u7wG2cnZMPRaG4y/gZLwXfsZ2ZIigwp89tr
         KuBWhRrNHGjXRY9iBYXi5I59aBRURO8XSawDG2QP7AfExSfcYd3chXD/IW00u8BuwvVX
         4JQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723148619; x=1723753419;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EYPhQsld9GAJre99feKKIfmgjeFER2AEU0jPN6Kk/to=;
        b=hdFApMQ9uc9Obd/7Lh/nEZSDJzyT3UNn0VbyPfAFnf8k51RJ9EuCRo5c+lLilatFJD
         xlWKI5LJzl/pllNi8K6e8JbXTXQGC6exMK8lvu17njIqNJBGuikS4gFsU/qCKtgWjuTA
         Rf00G369zKObP7MT/Ff2LqG/vusZLVg9qoo+OJ/a4fXybCn5gBM5U8vutONC50b6yYhe
         q5aA0pgZ3CekJLnIC/mObpxrz1UL0Mj1+vfS2Sb5GIxme0TTYdKk5NHtUHmx0ha3gDGv
         IqPV8sFLdDSDh9RYcwNbb2Ng+MeNdCL/KpIbXwgpSD1tUDNirRUT4T/kNxTdHW5Ay1gx
         Mitg==
X-Gm-Message-State: AOJu0YzcXu+8Sy54kcxG9UEnst8DU4VahYjgjN/EwHAt8GWEnKaVigSt
	z4SPBxljGGbE00cdo4py8gpHCvSrcmw3iRiaJxGzDoMgd+I9MDy1
X-Google-Smtp-Source: AGHT+IGx6gLeWV++yyyGQl3aZxwXAWpbkXfwWGnC2AKAdxDW/AEuC4BuSFfoHOj9YhMy/kt492On1Q==
X-Received: by 2002:a05:690c:6106:b0:630:4fab:a090 with SMTP id 00721157ae682-69c11c83ccemr23892807b3.22.1723148618942;
        Thu, 08 Aug 2024 13:23:38 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:fa3a:53c6:c704:2cc7? ([2600:1700:6cf8:1240:fa3a:53c6:c704:2cc7])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-68a10659e5dsm24214487b3.62.2024.08.08.13.23.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Aug 2024 13:23:38 -0700 (PDT)
Message-ID: <a04fb9f6-2bb3-4355-a0f4-78f601fd8367@gmail.com>
Date: Thu, 8 Aug 2024 13:23:37 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v6 2/6] selftests/bpf: Add the traffic monitor
 option to test_progs.
To: Martin KaFai Lau <martin.lau@linux.dev>,
 Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, sdf@fomichev.me,
 geliang@kernel.org, kuifeng@meta.com
References: <20240807183149.764711-1-thinker.li@gmail.com>
 <20240807183149.764711-3-thinker.li@gmail.com>
 <da319aa5-b57e-4d5a-9782-3df05a70ab0e@linux.dev>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <da319aa5-b57e-4d5a-9782-3df05a70ab0e@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/8/24 12:44, Martin KaFai Lau wrote:
> On 8/7/24 11:31 AM, Kui-Feng Lee wrote:
>> +static bool should_tmon(struct test_selector *sel, int num, const 
>> char *name)
> 
> "int num" is not used. -m is name only, so not needed?

Right, it is not needed anymore.

> 
>> +{
>> +    int i;
>> +
>> +    for (i = 0; i < sel->whitelist.cnt; i++) {
>> +        if (glob_match(name, sel->whitelist.tests[i].name) &&
>> +            !sel->whitelist.tests[i].subtest_cnt)
>> +            return true;
>> +    }
>> +
>> +    return false;
>> +}
>> +
> 

