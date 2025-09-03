Return-Path: <bpf+bounces-67335-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 092B9B42A16
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 21:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B93FA5E742D
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 19:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6897336934D;
	Wed,  3 Sep 2025 19:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HfMxEENU"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AA23112C4
	for <bpf@vger.kernel.org>; Wed,  3 Sep 2025 19:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756928493; cv=none; b=iAys9NoSFiz7eF5cr+SO5dAtRfH+GHCkorMBx98wI3pYVhKUQpuupIZ+Pk0THBwS+VtFP52V3udrPZDMgOExxRHUq3Yjp5VCYdMVpdIBXEp6I2+dNgPyTBZA5S1d3EC9kcjiCAaqz6dNi1pySQfKevAEdUy2I9Y2WcoMcsoJKbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756928493; c=relaxed/simple;
	bh=AnLl03C3lEMWEuhKP4zlQA7qh1JCTWIkpSGbgait56k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EKbmdpC5WmKS4qHFR8YA66nXIb5/7Jy1sP3g8w81MHAUyYIIk7TBoNT6k7aF9mSJotjd7TPZ68/oqQOvZ2XFtpXIqzbBfp4jWUPGN5C2v9hb7SWeIAb7IbvAg5ybKbQoOJOdlaeemhN64SrQJnu1qXy4PAA0NJ9kyemiOg3fKsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HfMxEENU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756928491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IcrdCi/QQ2Pi9AawoI2D1LHbeyQi4TYyEyYByMDtp+8=;
	b=HfMxEENUcY9K9lJnfmtBY8fhNJ2OsHJ1O5mV/ET83uRZXFpqlTfOFMsuq1O1n10G9S8YhN
	MJTw4cJWl++uIdXJO51r4SBDYPhQxHIfEC3dYfO4C0JVu6MHPklpRj47sSTCMJWNN1QtmD
	7+bOzSfRfBHR7+uoRQvBuuXG5aHSrXo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-s36mPl5pNYOqm6ZjxlLAIA-1; Wed, 03 Sep 2025 15:41:30 -0400
X-MC-Unique: s36mPl5pNYOqm6ZjxlLAIA-1
X-Mimecast-MFC-AGG-ID: s36mPl5pNYOqm6ZjxlLAIA_1756928489
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b042cc395f5so16644866b.2
        for <bpf@vger.kernel.org>; Wed, 03 Sep 2025 12:41:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756928489; x=1757533289;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IcrdCi/QQ2Pi9AawoI2D1LHbeyQi4TYyEyYByMDtp+8=;
        b=EqDVYsoWOsps1/mzsOXmi26RtdrCDfgFw+WFv4mk2jB4i5cImcAu1dCCgxdea22nC7
         XlA1jqHJSL5D+c27+dVMB+47ibsb9bXmaTYI64RZmG3sjoR3Tboio/huVCjScCfkjiB5
         DS+ri3dgT/6qefHsI5c3hzQo/YfUnuS4PWyoS0N6haMgUz/s5ufNU6HUKgOt7tIpH/W8
         7m/v4AfhIG1hygOIReCxwhBllne5gImVRRygaRPxX5WQdiefVKu/nBGebBrHYrmtDm0H
         vhSM2vxK2HxHsypKkVyc4egCMpfY5x7SLWRUHZ3W6xycCdFADsv4cnkSf+Ay1uXIpMnP
         TSHg==
X-Forwarded-Encrypted: i=1; AJvYcCX8Ft20p4SsqOeRv+dkhoHkv1d765lEaDTXkJWi6XQ0BHs7banHLQQ/iT1UJn2m9as9JQI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE3Q4HVUyH6Im2CTwH/nZrXBYDmGPyGJpe2BTEZlvm/ac08LUP
	shUd0W2dB4dUUNfHiR0zuQ+5HA4A9Ve3IqL55zFurAhrwogw0FOxxSSzmugjwDP8bd+y4NXODjR
	UMZAe/u0IOUpC01Dsa4airPYi/uB2Cm1dx/riA+mpr/f0aRi0rijt
X-Gm-Gg: ASbGnctrk9xZzZKjjsqfXRmJ2sIdAIz0iyJ7fcCCXoi3rvpe4dcH71L5xXhpO3ok6y9
	0ydkqXf5Uz7HjO6/Snbx6jHP7QXl5qfX62xLO+HRCjqxvt8u8qGPT0FV8bW9FTX34Ncaw8wWauV
	POkI3p8dah9gTB/pUVFOlpWonCICUgHzbfsv0/JFyfErVTUxbODIWzwrwn8SJAAEYcRveiFlkiL
	ue++sbAvBMgOSdimx+H8yur4a3IGfbfoO0X1USHQIkRytNeg/L8B4yRQlPOUsz8HFac9E8LMTo0
	nlc0Q49fzhZI1GiAfcIS5KFbS1Tlh7dfpZlJWghAoZWHEF8LV6wSrvQ0GTqDeZh+ClcFxO8FLg=
	=
X-Received: by 2002:a17:907:9808:b0:afd:d9e4:51e9 with SMTP id a640c23a62f3a-b01f20bfb23mr1654945666b.65.1756928488989;
        Wed, 03 Sep 2025 12:41:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYpszeOoco4oO7Qi8zM/uizj0H2Y+lWNHl3YoEbRLN0QQfvHzIRAK9mKQMhKDLrctQ/N7Qjg==
X-Received: by 2002:a17:907:9808:b0:afd:d9e4:51e9 with SMTP id a640c23a62f3a-b01f20bfb23mr1654944066b.65.1756928488639;
        Wed, 03 Sep 2025 12:41:28 -0700 (PDT)
Received: from [192.168.0.102] (185-219-167-205-static.vivo.cz. [185.219.167.205])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b046f888b95sm161394366b.34.2025.09.03.12.41.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 12:41:28 -0700 (PDT)
Message-ID: <64d235b2-ea1b-4e48-9c2d-9f22be50929f@redhat.com>
Date: Wed, 3 Sep 2025 21:41:26 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 1/2] bpf: add bpf_strcasecmp kfunc
To: Yonghong Song <yonghong.song@linux.dev>, Rong Tao <rtoax@foxmail.com>,
 andrii@kernel.org, ast@kernel.org
Cc: Rong Tao <rongtao@cestc.cn>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>,
 "open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)"
 <bpf@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
References: <cover.1756856613.git.rtoax@foxmail.com>
 <tencent_292BD3682A628581AA904996D8E59F4ACD06@qq.com>
 <809a98fc-2add-4727-af98-6f72e16c71e7@linux.dev>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <809a98fc-2add-4727-af98-6f72e16c71e7@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/3/25 18:39, Yonghong Song wrote:
> 
> 
> On 9/2/25 4:47 PM, Rong Tao wrote:
>> From: Rong Tao <rongtao@cestc.cn>
>>
>> bpf_strcasecmp() function performs same like bpf_strcmp() except ignoring
>> the case of the characters.
>>
>> Signed-off-by: Rong Tao <rongtao@cestc.cn>
> 
> Acked-by: Yonghong Song <yonghong.song@linux.dev>

Already from the previous revision:

Acked-by: Viktor Malik <vmalik@redhat.com>

for the series.


