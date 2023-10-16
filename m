Return-Path: <bpf+bounces-12286-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4347CA858
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 14:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AD501C209DC
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 12:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC31E241FF;
	Mon, 16 Oct 2023 12:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="mHs0jN2J"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDCB20B22
	for <bpf@vger.kernel.org>; Mon, 16 Oct 2023 12:46:58 +0000 (UTC)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C878EE
	for <bpf@vger.kernel.org>; Mon, 16 Oct 2023 05:46:53 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1e5bc692721so2511677fac.0
        for <bpf@vger.kernel.org>; Mon, 16 Oct 2023 05:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697460412; x=1698065212; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QQn52arwsdlU29PQnPUmt11cUghW1KEbpQJERkynB38=;
        b=mHs0jN2JyCgWWmOVLzDbHdbX7Yc+arb8AC3OgKm/udJ2jmgw+t+dPSWnsIS8hOTmyF
         EnuAZJWXTCVeql5wRmiN8ncP4PgqEay7OAzt4BTv90T9omUAPIPt/uD8KqD14uu+vbDp
         6gOEOQlfTiydNDSRAc0BVOoVwZ16qobwiBbklql/c0jG2PkBOHEyzMyjbdKJZUyum/u+
         4IxXHO0yv4PwMV9qee+DJoaApz9YsHk+4LNHMX03KMiYOMVDZNHeD/pVE68hY6Z3bk0o
         3GSg1VNXUmnRDIowKjsevXQGXyeY5k2HaIjfkyouahOfFOW+GSXbZ0zNkLpHU1fAb1u5
         WWZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697460412; x=1698065212;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QQn52arwsdlU29PQnPUmt11cUghW1KEbpQJERkynB38=;
        b=bVIIL+f280S8lGiJo1oXs6w7tfHJLxnEqJddKT0+PJSvmg3OzmDj7mWXESAMwkLx5V
         t8mm4R8EHjOn2xfPG0nItKXcsFkC8MkagmxIjGh9St/BE+bOP1Vtij0sOIqVd7qj7NMG
         GOnL9o4P79cGv+g0aXtDlpl71RcBE1QlzqikRak5hxYPd6RRGOpXThs7iUxwvyKE/Jzh
         9SZxKobD0x2h7ZxCUe79oFl/NWKpCn275oFP7fSIgUgIoUk9TnY2B+pJdQJCr8KSYjdP
         OH8K5/5PrA6sW1dNQ6W/v4m3q17LdtydQLsPuRxXBEGqY6rjgTcpYEi83YJvwXJFhJE2
         /RkA==
X-Gm-Message-State: AOJu0YwgvV8+VNrYTfbwDLXrkf1Goi51B1MTO8EJMCpyDe/qmReTAUup
	FN/NRcqYIEPazjRjsRBXA40uGA==
X-Google-Smtp-Source: AGHT+IFvrhrpIu8cV2fbdx301eoOk6upJqN7PRTBdpuJFrIHudU6DCIRXETrY2BPEMiiSd3o90G1Vw==
X-Received: by 2002:a05:6870:588c:b0:1b4:4a2e:33f1 with SMTP id be12-20020a056870588c00b001b44a2e33f1mr39706890oab.29.1697460412561;
        Mon, 16 Oct 2023 05:46:52 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486? ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
        by smtp.gmail.com with ESMTPSA id d15-20020a63360f000000b0058ac101ad83sm7926569pga.33.2023.10.16.05.46.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 05:46:52 -0700 (PDT)
Message-ID: <a158470f-6393-4a24-ad8f-ce6c3474db9f@daynix.com>
Date: Mon, 16 Oct 2023 21:46:47 +0900
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/bpf: Use pkg-config to determine ld flags
Content-Language: en-US
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Andrii Nakryiko <andrii@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Alexei Starovoitov <ast@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Nick Terrell <terrelln@fb.com>, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231016115438.21451-1-akihiko.odaki@daynix.com>
 <f2af3626-deb5-2830-9e41-4f6b7537baa6@iogearbox.net>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <f2af3626-deb5-2830-9e41-4f6b7537baa6@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023/10/16 21:19, Daniel Borkmann wrote:
> On 10/16/23 1:54 PM, Akihiko Odaki wrote:
>> When linking statically, libraries may require other dependencies to be
>> included to ld flags. In particular, libelf may require libzstd. Use
>> pkg-config to determine such dependencies.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>> V1 -> V2: Implemented fallback, referring to HOSTPKG_CONFIG.
> 
> This still does not work with BPF CI, BPF selftest build fails again :
> 
> https://github.com/kernel-patches/bpf/actions/runs/6524480596/job/17716169959 :

I was so careless forgetting to put "echo". I have just sent v3.

