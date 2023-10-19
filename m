Return-Path: <bpf+bounces-12700-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD817CFC81
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 16:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D962B212FF
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 14:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324EB2E40F;
	Thu, 19 Oct 2023 14:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="VblVA/j9"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E55329CF3
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 14:28:30 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C1C13D
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 07:28:28 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40806e4106dso5383065e9.1
        for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 07:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1697725707; x=1698330507; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XFu0ef+zdh3Ln5vrsGeJWeSUKFjMRNqdynnNl9ppqdQ=;
        b=VblVA/j9NVtX0S4e/CRaVh0i1/CJUZDP6LbOwgKPuzEL36hE7KAcC3Ix8236MaqZ1b
         ovdHDIN4R+l3vYOh/CgyYFEQ3n03pHcAj9gV06SunIC5UglaCJmoI0dKn6mBnndpf+IA
         oDi8j7BDKusvoCkD/e2jrM21zMOgb7hN6cQfduiqbG97wSdxlNSEbSXvkFHyp5vlgoMT
         iVLym7mTQpjmyTGafokUiExQcQzLECShLXpVuMEoOEviB999oWIQm0bYK6bE3HGQRrLw
         x+kLSenqBuLLzo7OkTKJGJaoof7nedJS/qCgWUUCzCGNh9Gb20F6zuZECJ8cQz4Frido
         Q/xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697725707; x=1698330507;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XFu0ef+zdh3Ln5vrsGeJWeSUKFjMRNqdynnNl9ppqdQ=;
        b=IFvGU9U94iKK77kOJv1yDJtxnX9GDk+mMeQdv8F2T+Eve+cGlcEiXcBCT+aD1XXXiP
         GsvQflZtxMOd21ep96cMSDg6Dy9b5e84BGsKaqzhwlFbAznrSzdGkZrZ3+amTLzK5otT
         0Al5b1NguRUmJUNV+HU6jDhgMrDa9x9reoUl4waOWVS0C1ypPMRCkF9tMj+MtSJpeJeh
         xd+ORSxHO0F1tOWfYb5KgwwLuJaChYKUkMV5ny3HTI8yY2WbbSOEsUA7zlLzE1gF02fD
         m9VJSamVC6uy7HNNwsusCvoeka9Mwy1+7Rm2qf72wwoKXKNe1kZrEkttmuWle5vkFBzq
         jZ3A==
X-Gm-Message-State: AOJu0YwQQrpLtoITk+HjUgULNLz76+RzC8v+6TXzw7k+pyQ6AOP9k+50
	m8dH/6SwF+0M1suElSmwzVYnkA==
X-Google-Smtp-Source: AGHT+IHOeapdLxuvl7GvBzzOJn6e31pRsq5Xh5rpZRbTgcamH7be1UUBEU3GiVaaQ83kfggorINFeA==
X-Received: by 2002:a05:600c:5489:b0:3fe:1fd9:bedf with SMTP id iv9-20020a05600c548900b003fe1fd9bedfmr2185781wmb.11.1697725706905;
        Thu, 19 Oct 2023 07:28:26 -0700 (PDT)
Received: from ?IPV6:2a02:8011:e80c:0:c4fd:a5df:859a:71c8? ([2a02:8011:e80c:0:c4fd:a5df:859a:71c8])
        by smtp.gmail.com with ESMTPSA id j17-20020a5d5651000000b0032d8f075810sm4597862wrw.10.2023.10.19.07.28.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 07:28:26 -0700 (PDT)
Message-ID: <e2270719-3dc6-4f3f-bbea-dd3fd4a17b77@isovalent.com>
Date: Thu, 19 Oct 2023 15:28:25 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 0/2] bpftool: Fix some json formatting for
 struct_ops
Content-Language: en-GB
To: Manu Bretelle <chantr4@gmail.com>, bpf@vger.kernel.org,
 andrii@kernel.org, daniel@iogearbox.net, ast@kernel.org,
 martin.lau@linux.dev, song@kernel.org, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org
References: <20231018230133.1593152-1-chantr4@gmail.com>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20231018230133.1593152-1-chantr4@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/10/2023 00:01, Manu Bretelle wrote:
> When dumping struct_ops with bpftool, the json produced was invalid.
> 1) pointer values where not printed with surrounding quotes, causing an
> invalid json integer to be emitted
> 2) when bpftool struct_ops dump id <id>, the 2 dictionaries were not
> wrapped in a array, here also causing an invalid json payload to be
> emitted. 
> 
> Manu Bretelle (2):
>   bpftool: fix printing of pointer value
>   bpftool: wrap struct_ops dump in an array
> 
>  tools/bpf/bpftool/btf_dumper.c | 2 +-
>  tools/bpf/bpftool/struct_ops.c | 6 ++++++
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 

Acked-by: Quentin Monnet <quentin@isovalent.com>

Thanks a lot for these fixes!

