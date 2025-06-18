Return-Path: <bpf+bounces-60921-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BDE9ADED14
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 14:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A8611891127
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 12:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8432E763D;
	Wed, 18 Jun 2025 12:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gPxx9j5+"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B132556E
	for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 12:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750251399; cv=none; b=ceS1hqskWgrXJ8sp5prJR+IhxmVlUsTzfLbKQ7pXKB4qj4dbtZ3BW91W4YUFbm3F8h4yAz7Yofuuq9sZJxVhhSwtQxVayeSfGT/HWxTk+EB3q4Y6Od2UhAYS8iC6BffzeWxAx+fTVLYRwt9nTtdb2gzK+gqSBZ/3PCiSmwQ6UUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750251399; c=relaxed/simple;
	bh=fNnOuETpXLRGF7DtpMIFoZ30UuOhkjcSpc7vSMwe4E4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ryk+3wklDM2Kfl7vWeB9PbKDpuwkNmzkXnouZjaaNvV7yN2MYCUE8alfDbwyZOaN+ohlTqdIAlcX/7se6SiO/FFioj1AtNcNIrBU56sNRjgjz44hRNWuGk/5iEWboAXRD5CZNRV5xOBNZ0f8LEpiSiZ2hvS0UsTTE8newSAJv/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gPxx9j5+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750251394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gx/RH+/G9i3iANe+sp7vSNvU9LmauuMv8eQ16agHmOk=;
	b=gPxx9j5+u19WPS6ARHaFx8b5rRcLuWmS9dlBQgFQjdIYyBeY6wDWJXoK0bbXX0XWXQ5N7q
	Xx2CKb5ZY+WCz+YYdXvYm8pK1m2Lq5YfTIt2DI+mH21Y+6T317BT0gVcQN15rErg1C0h+v
	21lf+SDgy6bgq6TI0GyXqvdCgvNUcjc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-_7kf9NbXMdaXR7Xw4hi5Zw-1; Wed, 18 Jun 2025 08:56:33 -0400
X-MC-Unique: _7kf9NbXMdaXR7Xw4hi5Zw-1
X-Mimecast-MFC-AGG-ID: _7kf9NbXMdaXR7Xw4hi5Zw_1750251392
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a4eee2398bso2980255f8f.1
        for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 05:56:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750251392; x=1750856192;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gx/RH+/G9i3iANe+sp7vSNvU9LmauuMv8eQ16agHmOk=;
        b=SvYbCdogXvlVQRzN7OVxGynHzTV7HaYSYy+bxPLZnxhZQ7EpOcTbBCfh5TH3lr93KG
         N5B0yLt9YvqgJWWYZTCDbfc/YMgIx5gHS3rdMBY2lFtHi77IOL0xGFVccN//cvKB7ivf
         +YXBo5iB/IFVUuhuaIOlM0PW24A8P/QX4fLlZyH3lxim6fpD7Q2CuTWQkCXfcxA9Peu8
         mZdR/hg58ps++xPa5moYvUkU30DUByXDPIzaHPEmmRXuOOTAoB6P67YJLVVdz872fr57
         nlKi3sfV5HiwwqxXie+uzUOtqTACs1RdPCrA2TLnx/jrmQsApai5LzCyDXIUAFr6k+0G
         7+Fg==
X-Forwarded-Encrypted: i=1; AJvYcCX4JFbfjQcp40ea7eCNv0uSWpNZV77bEbENmmS34Ns1QDoNwlKmzY8mOEGjF8atSMDe3Fg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyivFZeTb3Z3arW8MZy95bzOMWwFa+5bAfYWrupsf5D+HDrjjAP
	/FgIsephohMaXZ5mcGNRxkbCBDcLdbEcwub/rubN86f1BNCsUhKwRUSTw42uevjCVu0qifBhSVr
	LSbM3JbbDE0xj8wWhpshMJE462gQoPKiBf1CXCTFaAN78DzdyAp5q
X-Gm-Gg: ASbGnctnkxRe5mGqLwGpK+1eomyk+iYCMx5UI/Ru5PPKG60nu8RJS+2LyiETxFve0yP
	nluwfxpk0t8dWjlra5B/eaNAS1kf2WfFhG9vbb3wd5nSWW0hcI/i/n2R3p4iVLGmWHdCSwbQ7t3
	c4VfUF2K5ZsFMl++5q4YbiOAC6Zux0uXols1L0ClEH2EVLFTt7uBYtVIpjv3Vf04oh/4zpXb0aU
	FRRgb/1584IhlvLBC5x+5EWmEvgI1KouSKHdAtbQPvgs5hYYZbnxXXV6OrR7nI2tmP04QAll/IN
	7BUsAUKmw2oBmEsvXoQ8XHBHvRlbbbE82prDzh01puzPKIAOsqApGbDu
X-Received: by 2002:a05:6000:1447:b0:3a4:d9fa:f1ed with SMTP id ffacd0b85a97d-3a572371aa7mr13920752f8f.13.1750251391770;
        Wed, 18 Jun 2025 05:56:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoLWyYfNUW0AwVEWxCQ/eEcC68YZNog3Tjfb+YpquBLj+756zBMjs4UHCmfC/77SPabRgulA==
X-Received: by 2002:a05:6000:1447:b0:3a4:d9fa:f1ed with SMTP id ffacd0b85a97d-3a572371aa7mr13920729f8f.13.1750251391361;
        Wed, 18 Jun 2025 05:56:31 -0700 (PDT)
Received: from [192.168.0.102] (185-219-167-205-static.vivo.cz. [185.219.167.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532de8c229sm205666195e9.6.2025.06.18.05.56.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 05:56:30 -0700 (PDT)
Message-ID: <597dec76-804a-4cd4-8e3e-0b1e0c57e6a1@redhat.com>
Date: Wed, 18 Jun 2025 14:56:29 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v1] selftests/bpf: include limits.h needed for
 PATH_MAX directly
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
 kernel-team@fb.com, yonghong.song@linux.dev
References: <20250618093134.3078870-1-eddyz87@gmail.com>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <20250618093134.3078870-1-eddyz87@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/18/25 11:31, Eduard Zingerman wrote:
> Constant PATH_MAX is used in function unpriv_helpers.c:open_config().
> This constant is provided by include file <limits.h>.
> The dependency was added by commit [1], which does not include
> <limits.h> directly, relying instead on <limits.h> being included from
> zlib.h -> zconf.h.
> As it turns out, this is not the case for all systems, e.g. on
> Fedora 41 zlib 1.3.1 is used, and there <limits.h> is not included
> from zconf.h. Hence, there is a compilation error on Fedora 41.
> 
> [1] commit fc2915bb8bfc ("selftests/bpf: More precise cpu_mitigations state detection")
> 
> Fixes: fc2915bb8bfc ("selftests/bpf: More precise cpu_mitigations state detection")
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>

Just ran across this on a ppc Fedora 42. Thanks for the fix, it works!

Acked-by: Viktor Malik <vmalik@redhat.com>

> ---
>  tools/testing/selftests/bpf/unpriv_helpers.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/bpf/unpriv_helpers.c b/tools/testing/selftests/bpf/unpriv_helpers.c
> index 3aa9ee80a55e..f997d7ec8fd0 100644
> --- a/tools/testing/selftests/bpf/unpriv_helpers.c
> +++ b/tools/testing/selftests/bpf/unpriv_helpers.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  
>  #include <errno.h>
> +#include <limits.h>
>  #include <stdbool.h>
>  #include <stdlib.h>
>  #include <stdio.h>


