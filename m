Return-Path: <bpf+bounces-15161-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA9C7EDCF6
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 09:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB48D1F23DF9
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 08:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C415745960;
	Thu, 16 Nov 2023 08:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TcX5Fj42"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E187C1AD
	for <bpf@vger.kernel.org>; Thu, 16 Nov 2023 00:33:32 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6b44befac59so1309530b3a.0
        for <bpf@vger.kernel.org>; Thu, 16 Nov 2023 00:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700123611; x=1700728411; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ErBNE1hSgtSz6GHqo6FByGZUILPGcZ37HS6GKHLfRDw=;
        b=TcX5Fj42GVhDdZPxtu/yD5lo49IfIRvzFQtogNbVwbGZFaJFy1gb6npdXDfj0052rP
         7a04diLgp1tJP5Ekfo7+eGoOwWAJUB+RGrmvcGXV4cNT+yXgG9ghrCezTUOYXUQICDy0
         PDV2OrcMF10kduGvWLreXe9k/npNjJTE3kh3VSu4ijNu/VaNCFEKYdzR2+W3Fp69W1/R
         IoIvIe423eJ76rAq7HmlPvrlsnwqbH0cMQ2T6x8Sd4YT+SIBIjDs6lWlDkWfjnu/2rEW
         scfSPV/CJ7MrG8usoWs75qw5d2InfdaJ2vA4Z6RE53PzRa8/D69YDz0XklKh37jdDg4Z
         2bUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700123611; x=1700728411;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ErBNE1hSgtSz6GHqo6FByGZUILPGcZ37HS6GKHLfRDw=;
        b=Hgymwya3tNq1GofbkHsGqLUP4TOcDieDimMhnhfLKEZzDba0kiPyUc50k9IR/ihexV
         Dhck3GvXm0r+3cXPJEXIv155lC0ycUPSBN6AYiyGGutYoUXaNCufp391I0k5y+T+ppd+
         z/Qxw9WZ6UwL/cXQiCO5351Jsp3QNXJ5vVR5mKwVsPpEraCuAoD059+U5BRKLZl/SjE6
         TWC++KTkJcM5gsKkN07OISVPyxR5GDrvp9UAzw1tMzA4vioSqjchZ9bTPIJ42x96iB9C
         /7BWtEkDKRzZzSXRHBswIvgaZqfn2q56VTKHq/IBtS38MsJg6pM4C2S4rZguXDJHvkey
         5sbA==
X-Gm-Message-State: AOJu0YzcJGRbpLW1S8GsL/OjqCTnc3cD1Zvsj0Pi0lzoiMHZFheKHUUI
	ZlOun3hJ3z2kOtQnmSslkOuPmcIxzoE=
X-Google-Smtp-Source: AGHT+IEnqpSJtedGMc/IVBXtAzUgSEqGwgcwKNUgOIEORS3kyUDi17cWw0vnF+QI5wf/XsWPTgZ+XA==
X-Received: by 2002:a17:90b:224a:b0:27d:2601:bc92 with SMTP id hk10-20020a17090b224a00b0027d2601bc92mr1510084pjb.11.1700123611137;
        Thu, 16 Nov 2023 00:33:31 -0800 (PST)
Received: from [10.22.68.115] ([122.11.166.8])
        by smtp.gmail.com with ESMTPSA id ju2-20020a170903428200b001c5d09e9437sm1025728plb.25.2023.11.16.00.33.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 00:33:30 -0800 (PST)
Message-ID: <5ee643a8-d39e-470b-83e9-9d550374e617@gmail.com>
Date: Thu, 16 Nov 2023 16:33:26 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH bpf-next v2 0/4] bpf, x64: Fix tailcall hierarchy
Content-Language: en-US
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 maciej.fijalkowski@intel.com, jakub@cloudflare.com, iii@linux.ibm.com,
 hengqi.chen@gmail.com
References: <20231011152725.95895-1-hffilwlqm@gmail.com>
From: Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <20231011152725.95895-1-hffilwlqm@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

PING

On 11/10/23 23:27, Leon Hwang wrote:
> This patchset fixes a tailcall hierarchy issue with a better solution than v1[0].
> 
> v1 solution stores tail_call_cnt on the stack of bpf prog:
> 
>     |  STACK  |
>     +---------+ RBP
>     |         |
>     |         |
>     |         |
>  +--| tcc_ptr |
>  +->|   tcc   |
>     |   rbx   |
>     +---------+ RSP
> 
> v2 solution stores tail_call_cnt on the stack of bpf prog's caller:
> 
>     |  STACK  |
>     |         |
>     |   rip   |
>  +->|   tcc   |
>  |  |   rip   |
>  |  |   rbp   |
>  |  +---------+ RBP
>  |  |         |
>  |  |         |
>  |  |         |
>  +--| tcc_ptr |
>     |   rbx   |
>     +---------+ RSP
> 
> With this change, it requires less instructions to resolve this issue.
> 
> For more resolving details, please read the following patches.
> 
> The issue is confirmed in the discussions of "bpf, x64: Fix tailcall infinite
> loop"[1].
> 
> Currently, I only resolve this issue on x86. The ones on arm64, s390x and
> loongarch are waiting to be resolved. So, the ci pipeline fails to run for this
> issue fixing.
> 
> Hopefully, this issue on s390x and arm64 will be resolved soon.
> 
> v1 -> v2:
>   * address comments from Stanislav
>     * Separate moving emit_nops() as first patch.
> 
> Links:
> [0] https://lore.kernel.org/bpf/20231005145814.83122-1-hffilwlqm@gmail.com/
> [1] https://lore.kernel.org/bpf/6203dd01-789d-f02c-5293-def4c1b18aef@gmail.com/
> 
> Leon Hwang (4):
>   bpf, x64: Emit nops for X86_PATCH
>   bpf, x64: Fix tailcall hierarchy
>   bpf, x64: Load tail_call_cnt pointer
>   selftests/bpf: Add testcases for tailcall hierarchy fixing
> 
>  arch/x86/net/bpf_jit_comp.c                   |  99 +++--
>  .../selftests/bpf/prog_tests/tailcalls.c      | 418 ++++++++++++++++++
>  .../bpf/progs/tailcall_bpf2bpf_hierarchy1.c   |  34 ++
>  .../bpf/progs/tailcall_bpf2bpf_hierarchy2.c   |  55 +++
>  .../bpf/progs/tailcall_bpf2bpf_hierarchy3.c   |  46 ++
>  5 files changed, 606 insertions(+), 46 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy1.c
>  create mode 100644 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy2.c
>  create mode 100644 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy3.c
> 
> 
> base-commit: 644b54d80d572438a815c05b1bab2b7871e1e5a1

