Return-Path: <bpf+bounces-13564-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 316067DAA60
	for <lists+bpf@lfdr.de>; Sun, 29 Oct 2023 02:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53912281762
	for <lists+bpf@lfdr.de>; Sun, 29 Oct 2023 01:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78EFB638;
	Sun, 29 Oct 2023 01:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PlBHcUAR"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A682E38B
	for <bpf@vger.kernel.org>; Sun, 29 Oct 2023 01:42:25 +0000 (UTC)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55EDF91
	for <bpf@vger.kernel.org>; Sat, 28 Oct 2023 18:42:24 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-d9b9adaf291so2218732276.1
        for <bpf@vger.kernel.org>; Sat, 28 Oct 2023 18:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698543743; x=1699148543; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h0kuHt/O5ihCOhvK3sLSYA61Ov8Mg1tUXhVyZtBUWb8=;
        b=PlBHcUAR7+DSQGFAmURpiEZG9kiFpOtle2PUdvdpoOUxuq1gioCqEoT4b4xxmYhNnY
         ZrO6/6AJx0Rpnfly0BXLdrEVw3sSWeGVlQB/FJJ32bWYSfKW1LOOb2g2pjXzxQd+CIP9
         Cb7aBNyvECYCp1Yn44FYs64uyq2hid4PpEfwtUi2xOQIpmtkAdM/t75PvA+9I+ssRRg8
         V1lIl9dF5ub1XSonAaPBdm/T8N2eWKmqzsZ7n3bX+4mfNUoPwsdzSoF8zmPPshVsLuaS
         qKw4410Gr8J6nhgBrPONRNh+rQstdAOFPfquUlwhDL8I6ERNmTpsAGttGICh7efthVGa
         nutQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698543743; x=1699148543;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h0kuHt/O5ihCOhvK3sLSYA61Ov8Mg1tUXhVyZtBUWb8=;
        b=iqeyPh5f11qE/Pc+09e4gwL3E0geoImPORndWS72HUtmVHZFdi/Og13mtsJZokBios
         3L8+KNM/lY7RcfkuwwLzZE62AKWe/bp9njsOL7TIM2ieUzgaYhpyUi643BMX9si9n0f8
         wWfpHK4AadxKcftocHMgU5dCPkflh87qg70f/4OIK7anNwFjB1MVxUd0yN61M7ovimMR
         fkbROnuKS7zFeMbjZOp2EBFzOTso1OTfQuzu6FqymmHdiEEYT5ntdhk/TYKhQbliVPJk
         9zHsSmuIugGAjK3N8oVd71VvqTBzpQZAxdhhAjuO7d+VZja+Cw+ekPHlAiIed81u0RMD
         ajmw==
X-Gm-Message-State: AOJu0YzD0M4jWHwSVaNxYFAXkDp7s2q2jWwH6KvHi+JJhk07mLMGuNX/
	n9NAbLcBQQSBeFwcW5A5k+M=
X-Google-Smtp-Source: AGHT+IEzBNfbOzHjbj3luJkMczFUV7nxT6UYuNwRqlcXobmi0sNFbkaaztVVW8vRkXnvuX+2NBZ44Q==
X-Received: by 2002:a25:ada4:0:b0:d9a:5f91:c615 with SMTP id z36-20020a25ada4000000b00d9a5f91c615mr5158725ybi.18.1698543743089;
        Sat, 28 Oct 2023 18:42:23 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:6208:ded0:c5ca:2313? ([2600:1700:6cf8:1240:6208:ded0:c5ca:2313])
        by smtp.gmail.com with ESMTPSA id v15-20020a25910f000000b00da07d9e47b4sm2157816ybl.55.2023.10.28.18.42.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Oct 2023 18:42:22 -0700 (PDT)
Message-ID: <0c188e9e-a01d-495f-9aa9-d7bf72275f45@gmail.com>
Date: Sat, 28 Oct 2023 18:42:21 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: size_t :0 doesn't always work with llvm-16
Content-Language: en-US
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 Andrii Nakryiko <andrii@kernel.org>
References: <4891ef34-b6a2-4c12-b4cf-eed4d9a84172@gmail.com>
 <CAEf4BzbZ=2KueQo6BErkS+M2TAov7Q0SbsBmV=3iL2m5ZFCvEA@mail.gmail.com>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <CAEf4BzbZ=2KueQo6BErkS+M2TAov7Q0SbsBmV=3iL2m5ZFCvEA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/28/23 18:12, Andrii Nakryiko wrote:
> On Sat, Oct 28, 2023 at 5:52 PM Kui-Feng Lee <sinquersw@gmail.com> wrote:
>>
>> Recently, while running the test_maps, I encountered an error
>> message. Upon further investigation, I discovered that llvm-16 behaves
>> inconsistently when it comes to clearing partially initialized local
>> variables.
>>
>> We appends a 'size_t :0' at the end of many types to prevent dirty
>> bytes at the end of struct types.  libbpf also check dirty padding
>> bytes for CORE. It works most of time with gcc and llvm.  However, I
>> have discovered that it is not always work with llvm. The C
>> specification does not guarantee this either. Nonetheless, we
>> primarily rely on gcc and llvm. In most cases, on x86_64 platforms,
>> llvm utilizes memset() to clear a partially initialized variable of a
>> struct type.
>>
> 
> Yes, which is why using LIBBPF_OPTS() is a good idea. And which is why
> I submitted [0] to fix this in our test_maps tests. I'll resend this
> fix outside of BPF token series.
> 
>    [0] https://patchwork.kernel.org/project/netdevbpf/patch/20231016180220.3866105-14-andrii@kernel.org/

Great to hear that!
Thanks!

