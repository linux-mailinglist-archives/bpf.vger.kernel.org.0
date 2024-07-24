Return-Path: <bpf+bounces-35525-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5F293B4F2
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 18:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 267D6B23F91
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 16:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4815A15B541;
	Wed, 24 Jul 2024 16:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lx/5n27d"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD3F158DA7
	for <bpf@vger.kernel.org>; Wed, 24 Jul 2024 16:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721838288; cv=none; b=Ay4hu8tP3pSR/vXq1VoGK77BK7UexB2yO7CY33bnJkQwjbSgmRw2AgWujchLdCOUjanrUMTOoTBz7x84dme423vBVmmvfbwGVtQR7ZEEMLDEw2+djJK/q7s13P1iuqTTIAJa00yvzxbP5WOJ7vl4zLGwxNvVHvAlNRsGGDiWjoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721838288; c=relaxed/simple;
	bh=xtOnKnZpYvLSsGF/AYSVG56fKkwMVcQwoGyw+GxpOic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q6EKacltyaX1Z/lqYvXRPJfHLgeYKP/wgrI0p0ibtniOBowCO/hCkGtyUd7XpbH2dMeKxsJC0/WKOXSiS50j+S5+lIt7jpfUvlmCY/G0ZVt5nJ81tdIrAsBJ+HxE3VT/X/NwbAYY2Y/xd2lvBX60CGgFzPqGH7svLICRv2EP7YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lx/5n27d; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-66526e430e0so71888107b3.2
        for <bpf@vger.kernel.org>; Wed, 24 Jul 2024 09:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721838286; x=1722443086; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cNHVa1wLRJ80WbZ7/W8IXWMc3VhwPCaXxUdPQ+femNc=;
        b=lx/5n27dbPIni7WZQL4QE7BDbFuQ1pCNu3oeU8N17gQl82U1Xi0dYzHet+Hl7uVeni
         6aIqWPEWJ2Af6jP+6ca6XM1j7MIRdtCfC5YXM+Fute6FnklPh43pMivso3A06xDbCKmu
         aVKhNPE+psUd5lPdJzwyvkY5yavNdka7L5R49kfDq6h+fKArv/TNPz9tPyy9Zf1Vkd/o
         GNFWOBErimFWb9nrSj1ObN58gqxmkxig7vf7SPTZf7lbEaGtFuzbJeXYnYrXaa/DIyjD
         eJR5NNbx9TWn/QODH8YHlK5uHFGo3qJo4aK8BoR1w7hc35c8ZyQXS8m8ZHIF96jdb0/T
         Nm9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721838286; x=1722443086;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cNHVa1wLRJ80WbZ7/W8IXWMc3VhwPCaXxUdPQ+femNc=;
        b=RAzdSMlZFCZIX1yutN/m6mCBzUw1vRqGuep3czrJiyKqnJZddUNk9Gl8WtuMFahC+g
         2UTyjBvU6HpVAnNRM2SbMNyfY2Xey25E3LQ1de7pmaishogYQWEknnbC+VBiLwm0SKom
         g/6prDi4KpyoZRzWtw8aUDe037czVHck0MZ3WTO6HMbE9RI40tgDh19+Slp4v96dHBeQ
         RIXPi4JemqlzuWCQnYIb0dXcWVdFwcWujp8oRiqYnh9hVUYyFQtBRgZH8gDJFCI//+g3
         e1me8aXKQLt/ObuI3LWLYDfpCsNOYuQuvO8OQFPe3zE/8WilARVt3CBd10xVvSOkA5el
         +/sw==
X-Forwarded-Encrypted: i=1; AJvYcCXFvDnXN6MmwK9JwD92f1iYQs/CieRdjZOeHsX8Pv2g9n+Kv8ZujLErMVs/1I3TJtkBQ1Yo/aa90YrV1LUQGCGnb28q
X-Gm-Message-State: AOJu0YxjjyVogPmX1QIHjkDb5vHvrK3dMP0RGI1xFRI2X6aYzRKzaHJm
	x5P1YwVcnhNkd5hAJ+SOkMvUQzw18iBBgDXo4wzcCh2D2mDN0rQx
X-Google-Smtp-Source: AGHT+IGXxEeL5DeWeClT2tDDmRs7YzH5q2qe0SBKSM+XwQnOciecNB7kxVjNrjy4fdtYJynidNf5Rg==
X-Received: by 2002:a05:690c:3147:b0:65f:8218:8b2f with SMTP id 00721157ae682-66adab24f8fmr132987067b3.43.1721838286337;
        Wed, 24 Jul 2024 09:24:46 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:abc3:64f6:15ee:5e16? ([2600:1700:6cf8:1240:abc3:64f6:15ee:5e16])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-66952458953sm25197747b3.36.2024.07.24.09.24.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jul 2024 09:24:45 -0700 (PDT)
Message-ID: <134682b6-2be8-4757-9852-ecbfb3e3b79a@gmail.com>
Date: Wed, 24 Jul 2024 09:24:44 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 3/4] selftests/bpf: Monitor traffic for
 sockmap_listen.
To: Geliang Tang <geliang@kernel.org>, Kui-Feng Lee <thinker.li@gmail.com>,
 bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, sdf@fomichev.me
Cc: kuifeng@meta.com
References: <20240723182439.1434795-1-thinker.li@gmail.com>
 <20240723182439.1434795-4-thinker.li@gmail.com>
 <14043bdeb2621f6f283fbe59eff0084bbf8179fa.camel@kernel.org>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <14043bdeb2621f6f283fbe59eff0084bbf8179fa.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 7/24/24 02:32, Geliang Tang wrote:
> On Tue, 2024-07-23 at 11:24 -0700, Kui-Feng Lee wrote:
>> Enable traffic monitor for each subtest of sockmap_listen.
>>
>> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
>> ---
>>   tools/testing/selftests/bpf/prog_tests/sockmap_listen.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
>> b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
>> index e91b59366030..62683ccb6d56 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
>> @@ -28,6 +28,7 @@
>>   #include "test_sockmap_listen.skel.h"
>>   
>>   #include "sockmap_helpers.h"
>> +#include "network_helpers.h"
>>   
>>   static void test_insert_invalid(struct test_sockmap_listen *skel
>> __always_unused,
>>   				int family, int sotype, int mapfd)
>> @@ -1893,14 +1894,21 @@ static void test_udp_unix_redir(struct
>> test_sockmap_listen *skel, struct bpf_map
>>   {
>>   	const char *family_name, *map_name;
>>   	char s[MAX_TEST_NAME];
>> +	struct tmonitor_ctx *tmon;
>>   
>>   	family_name = family_str(family);
>>   	map_name = map_type_str(map);
>>   	snprintf(s, sizeof(s), "%s %s %s", map_name, family_name,
>> __func__);
>>   	if (!test__start_subtest(s))
>>   		return;
>> +
>> +	tmon = traffic_monitor_start(NULL);
>> +	ASSERT_TRUE(tmon, "traffic_monitor_start");
> 
> Using ASSERT_TRUE() on a pointer is a bit strange, it's better to use
> ASSERT_NEQ(NULL) like patch 2.

Sure!

> 
>> +
>>   	inet_unix_skb_redir_to_connected(skel, map, family);
>>   	unix_inet_skb_redir_to_connected(skel, map, family);
>> +
>> +	traffic_monitor_stop(tmon);
>>   }
>>   
>>   static void run_tests(struct test_sockmap_listen *skel, struct
>> bpf_map *map,
> 

