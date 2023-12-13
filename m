Return-Path: <bpf+bounces-17645-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5430810890
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 04:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5353EB2103D
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 03:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48D26120;
	Wed, 13 Dec 2023 03:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lp44egpz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC3C3B3
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 19:09:35 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6d089e8b1b2so1938878b3a.3
        for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 19:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702436975; x=1703041775; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=85W9r1cs8xuGQ1U2GHYqAWpxTmIRIWjrMwEfZ5LyH3k=;
        b=lp44egpzfN4WyyfX1XvtS5uLCcDfwZ0TaSmKAOv99QmD1OaJN/n4NGgEQoDPvJhqvq
         Eu9SS7YpOecegT8XeL6h0dv1ujELtx6S0AT5+Uy1I5tQPs9rHowpz3SOfjPM30mzA/wf
         KyrKrQwP/oykKlObtj8DHPk+9NKo4OJ0k2Id1aOpcX9T0i+S3G0bumfNhG1RmotqiZdU
         tb1l0DwY+A+hY9exb22bStBEI+T/V6wFSl5+vlKWW7f3k2vWuAm84+2Zn1eLhvg8SZjy
         9dSaj8kXH5kSKxvFLTeQC2Kwwfhrm6OjKa5fAdHB+z6AFjnx3eyjKBDxJfJTG+dtnXgN
         udNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702436975; x=1703041775;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=85W9r1cs8xuGQ1U2GHYqAWpxTmIRIWjrMwEfZ5LyH3k=;
        b=RpZ/F+EMEq2bvxS87hRV8Kv/Bl2BwgARVLUmCB0HCv5bGj6/cq4iziWEPWRHah7/b8
         qS02J3ynowAdJYLs0jrNT0G+FPYj5wXoHlby1mg94+9YUpjzScK+Nxvhr1viJaG35B9b
         Uz/CsFhs84lmHpY07w4jCfQbkPGStw7tvjH9sE2u8o2LZXDdzD1094Db9sgOIOMIHq80
         O6Ufg35nzzr6hPCzHv3Yorhy/V5rLMqH2rtrk8rXIKA62PoNsFaG4shZgDs5L2lNjHU6
         wyDX7BwCANfur5BV1rUEWVVe1WzxdOfOynXE6IvgH8yCR0yTXYW2N/cTq0QqNF1ZB0Cz
         nFbg==
X-Gm-Message-State: AOJu0YzqvY4g4oo1QEVVVMUm6Qc3TZmg4Pk8kTdpOMf618k8LEDwit1/
	++nwQ63lqaRCOjqc5GMSm04=
X-Google-Smtp-Source: AGHT+IEbd4QbhpW+MZF5lEZvl6yPq5tcK4FXq1n4iXk7PhSGNHGxhs92QFou/SdKhKQqMkiIG94IxQ==
X-Received: by 2002:a05:6a20:f397:b0:18f:c875:6b3b with SMTP id qr23-20020a056a20f39700b0018fc8756b3bmr3816920pzb.100.1702436975025;
        Tue, 12 Dec 2023 19:09:35 -0800 (PST)
Received: from [10.22.68.68] ([122.11.166.8])
        by smtp.gmail.com with ESMTPSA id e5-20020a170902744500b001d34cc99dc5sm334457plt.232.2023.12.12.19.09.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 19:09:34 -0800 (PST)
Message-ID: <175e8f74-0b9b-4acb-8c3e-473fff319097@gmail.com>
Date: Wed, 13 Dec 2023 11:09:31 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH bpf-next v2 4/4] selftests/bpf: Add testcases for
 tailcall hierarchy fixing
Content-Language: en-US
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, jakub@cloudflare.com, iii@linux.ibm.com,
 hengqi.chen@gmail.com
References: <20231011152725.95895-1-hffilwlqm@gmail.com>
 <20231011152725.95895-5-hffilwlqm@gmail.com> <ZXdPTeij9XtxOJVe@boxer>
From: Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <ZXdPTeij9XtxOJVe@boxer>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/12/23 02:05, Maciej Fijalkowski wrote:
> On Wed, Oct 11, 2023 at 11:27:25PM +0800, Leon Hwang wrote:
>> Add some test cases to confirm the tailcall hierarchy issue has been fixed.
>>
>> tools/testing/selftests/bpf/test_progs -t tailcalls
>> 235/17  tailcalls/tailcall_bpf2bpf_hierarchy_1:OK
>> 235/18  tailcalls/tailcall_bpf2bpf_hierarchy_fentry:OK
>> 235/19  tailcalls/tailcall_bpf2bpf_hierarchy_fexit:OK
>> 235/20  tailcalls/tailcall_bpf2bpf_hierarchy_fentry_fexit:OK
>> 235/21  tailcalls/tailcall_bpf2bpf_hierarchy_2:OK
>> 235/22  tailcalls/tailcall_bpf2bpf_hierarchy_3:OK
>> 235     tailcalls:OK
>> Summary: 1/22 PASSED, 0 SKIPPED, 0 FAILED
>>
>> Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
>> ---
>>  .../selftests/bpf/prog_tests/tailcalls.c      | 418 ++++++++++++++++++
> 
> Generally it feels like a lot of duplicated code from your previous
> fentry/fexit fixes, but I didn't look closely if it would be possible to
> pull out something in common.
> 

test_tailcall_hierarchy_count() and test_tailcall_count() are similar. They can
combine into test_tailcall_count() with more arguments.

Thanks,
Leon

>>  .../bpf/progs/tailcall_bpf2bpf_hierarchy1.c   |  34 ++
>>  .../bpf/progs/tailcall_bpf2bpf_hierarchy2.c   |  55 +++
>>  .../bpf/progs/tailcall_bpf2bpf_hierarchy3.c   |  46 ++
>>  4 files changed, 553 insertions(+)
>>  create mode 100644 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy1.c
>>  create mode 100644 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy2.c
>>  create mode 100644 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy3.c
>>

