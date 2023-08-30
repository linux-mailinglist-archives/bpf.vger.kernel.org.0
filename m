Return-Path: <bpf+bounces-8992-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37AC378D6EF
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 17:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6A5728111B
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 15:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B1E746C;
	Wed, 30 Aug 2023 15:21:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F142F7466
	for <bpf@vger.kernel.org>; Wed, 30 Aug 2023 15:21:38 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A9D1A2
	for <bpf@vger.kernel.org>; Wed, 30 Aug 2023 08:21:36 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-401d6f6b2e0so6542485e9.1
        for <bpf@vger.kernel.org>; Wed, 30 Aug 2023 08:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1693408895; x=1694013695; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g3CtT48jPlJIgusYzTnrLdg/99F2+CEON4UsLWqQKko=;
        b=PTndykky8SKmMRVa5wJO30iumxi4Lb2OpAoYzFfYTFpw9ZubZSzfnYBymf8lUNhyJW
         zqttAdCC9VCrk6umAHFliAGPuDCVO/Q2XHr/CQkec0nRASvTS5sUsLqISy9hxSfLcwt0
         F0ymHP8oCZy2B+D2066kMSYpXh9+69CW5dbTF4ooShZNT39pDe8xoiy2FjT6tjMlUdvH
         tXXXcVM6zEuqEP199hVWNNskvjrBeUcoeZ0QQzE0Jq6Eh3XsXnaPUhzbwvy4QeFIh3tB
         aH18EJrY/Yng2ykQ8rFJIeTzw/JTo6AF4/o16Tfuwy0zUW7qm4aIGKR1eq+ZFNzcbeLk
         uA5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693408895; x=1694013695;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g3CtT48jPlJIgusYzTnrLdg/99F2+CEON4UsLWqQKko=;
        b=gHvxowtsuA0NRpGEI6wUCN6zhm9qNUPRFXtsQSqZcxHapFJlRnIH69Oq977P2fHhpT
         0AyTNOufFAXSyuzgGYuh7i5HD1yYlm3QGL6mSIZtXFdgm7Ufc4yPh/1XtXHeme8xabWq
         Uo1ZwskWdZUJkoSjmVnsnUcNEkxzL3SE91HzA/7b4je0Ka8eF4AnhqkuPeyIXPUYm/Ks
         uF+OLbh/bEByW0tCbtMep40HWY1XLZ6mpxg1cE8RpnoLJIkVyb3gdtKk3IARCVrfnoDK
         oev+/mwyPrfR3ppYP+YFUiQd8icf36gHeBQQMokNC9ADw5O/zVZitOn0xe7uyUmSWZZy
         g1TA==
X-Gm-Message-State: AOJu0YxZAVcUxyNYqjwzpJSumNlxpeMs1ehpCAckxIDZSxTU6ckwlyww
	qbZiKp0V4kTtQ1taGLuDdAq/kg==
X-Google-Smtp-Source: AGHT+IEzQMej866IzE8FCkgk6gCxfjVeFksIip5jMrjrfICUSVE6k6l/gLx7wW7sFI65pTLcljpopg==
X-Received: by 2002:a7b:cb90:0:b0:3ff:516b:5c4c with SMTP id m16-20020a7bcb90000000b003ff516b5c4cmr2126478wmi.18.1693408894839;
        Wed, 30 Aug 2023 08:21:34 -0700 (PDT)
Received: from ?IPV6:2a02:8011:e80c:0:ab9c:c93c:ba9e:7ca? ([2a02:8011:e80c:0:ab9c:c93c:ba9e:7ca])
        by smtp.gmail.com with ESMTPSA id r19-20020a05600c299300b003fe539b83f2sm2556800wmd.42.2023.08.30.08.21.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 08:21:34 -0700 (PDT)
Message-ID: <2195c267-619e-4877-af5e-48ef56b81d4c@isovalent.com>
Date: Wed, 30 Aug 2023 16:21:33 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Fix invalid escape sequence warnings
Content-Language: en-GB
To: Vishal Chourasia <vishalc@linux.ibm.com>
Cc: andrii.nakryiko@gmail.com, andrii@kernel.org, ast@kernel.org,
 bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net,
 haoluo@google.com, hawk@kernel.org, john.fastabend@gmail.com,
 jolsa@kernel.org, kpsingh@kernel.org, kuba@kernel.org,
 linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org,
 sachinp@linux.ibm.com, sdf@google.com, song@kernel.org,
 srikar@linux.vnet.ibm.com, yhs@fb.com
References: <e640e5f2-381c-4f65-40b9-c2e3e94696f9@linux.ibm.com>
 <20230829074931.2511204-1-vishalc@linux.ibm.com>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20230829074931.2511204-1-vishalc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 29/08/2023 08:49, Vishal Chourasia wrote:
> The script bpf_doc.py generates multiple SyntaxWarnings related to invalid
> escape sequences when executed with Python 3.12. These warnings do not appear in
> Python 3.10 and 3.11 and do not affect the kernel build, which completes
> successfully.
> 
> This patch resolves these SyntaxWarnings by converting the relevant string
> literals to raw strings or by escaping backslashes. This ensures that
> backslashes are interpreted as literal characters, eliminating the warnings.
> 
> Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
> Reported-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>

Thanks! I observed that this patch fixes warnings reported by pyright in
my editor. I've also validated that the generated files (helpers man
page, syscall man page, bpf_helper_defs.h) remain unchanged.

Tested-by: Quentin Monnet <quentin@isovalent.com>


