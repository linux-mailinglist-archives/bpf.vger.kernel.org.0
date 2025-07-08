Return-Path: <bpf+bounces-62682-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36850AFCC5A
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 15:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CB724A45A3
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 13:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F122DD5EF;
	Tue,  8 Jul 2025 13:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ihDOmJvd"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAF91F949
	for <bpf@vger.kernel.org>; Tue,  8 Jul 2025 13:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751982166; cv=none; b=DYCwQiKCSUd8C1v95PLuKJGl7GcTJ7lPhwhmX7pRp1Q8/nVxyRNofesyP4JFn2cIdRDOVucqNW4SzQ0XuS+coTPS2Tvo/4oD8pnlGnou5TCSD582xexyLiuyCSu740K9MbnAi+4ZgmKnlPh3Tdsmm+lXKcxzxpGM+VokoPZmMXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751982166; c=relaxed/simple;
	bh=7IMZwdtT4ONplTSo8XHJ6xX4Q4sptOL8v2V3UkoQjlw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aXzXpB1J6CeZ7DNd+Z6Ne5KlRogiqN5+BmQkGahzRx7+Trd7W4tPpaTenlWfp5UMP0jofFEuN92wFDqOcgDzpvZ3n5fgAvFfc+DXOp3hXSQyKWfeSKy6msY9Axq3ZyYlBWF94RRXk/rq1xENFDsAXo3zqNQI20dSa0KxrtSgtSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ihDOmJvd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751982163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P27oZItgQlQTIEu6BrjTyR+ZcNfbW2DcDgBZkxGIz3s=;
	b=ihDOmJvdrY2E265JJO7y9DLpzLGY0sviPFqgWmQsi70zhelyRwzN5aMfS3YSLk/sXF8s5P
	1UYUWVOVY3CPkzFO+5mosNee7Y0YdCkAx5FCWs0rC/yIWBCuYkR2omM+IPToXY8Z0ssBLx
	Bkt/SeReuvstDMoNBvNJdBk0QWG6MYE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-tg2UaIevOZKxc8gziVq0AQ-1; Tue, 08 Jul 2025 09:42:41 -0400
X-MC-Unique: tg2UaIevOZKxc8gziVq0AQ-1
X-Mimecast-MFC-AGG-ID: tg2UaIevOZKxc8gziVq0AQ_1751982161
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4536962204aso18731565e9.3
        for <bpf@vger.kernel.org>; Tue, 08 Jul 2025 06:42:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751982161; x=1752586961;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P27oZItgQlQTIEu6BrjTyR+ZcNfbW2DcDgBZkxGIz3s=;
        b=sQ3DnzjHsxlHVAW1fiO6PYE6gkhO2RPxag2D8LPniCOoceUSD1HFdHnuHAsETy53HQ
         s1FDRby31tHfV/hN/kqa0er2QnioUChtdGkfFLj1J64J2JCgh4b0tR6+ZCLpk2gGkFES
         Uyshyn0POUguqjCs9/F3PFS42kINXU+nhX4Xj+YtysPzULcnO9I+RLgw0nLmGJoKNV4k
         csHhwEZWkUhIYCHLofAr9JkeitoFhaGkXq3ktJ0n2/XO5Q8val5xqsrN2LvAv8kRMThl
         gcl29sn+m/YFb7aXH7OiPmonD8NbpQwl9ZkpqOoSrJ/uKi1DGQYkXSJTcmwWE5Oerf85
         OYng==
X-Forwarded-Encrypted: i=1; AJvYcCV/m+n94hJxrOIKvlhnSfRf2S+R2oHYRYdfFQSWQGlPGJValeodQQfI2XKlSoWQrz9buo0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyZsD4zaWiGYo/3rrOd7o+AxkZtPi3uDN72HeWYZWOEUl8E3cT
	V0FBXHMwcSlS/27aIkWBYOaiVjjL79RbCNgZYLQMCCWN6IjMdKdd3qTGqsPdPtM3H2oF4Uw1Bb+
	sjkAyUnGuajMCSTt4iAvvOdMWZ4SfXXc5H248NOPHzmM1jSEqPaaVkw==
X-Gm-Gg: ASbGnctUQffDnHJgqSWiBnaEhYO+kocI7omS1QHSqt8lb/A/HxBZ/UbuPdwWJzmU3yh
	33PzW9BOdvWAkWAuWdUi8huDPc3EMZDj1Qtl8+moBAajl4VorL7zFuF1BxxP3Tb9MdBsmyBgm4w
	az3QBMXIg2XRJNIgCs53tLuxqNhZR0b8y+c0lgZXo/k14Fi51BVMxfvmuh1Z0oo6FI5ebPFAc9F
	d4UR1YnoYn8Mg/3lYBqxN/8jmHeSbDq6ZGaJwkTs5AWOKPm0C3muC42dEF+1+B4AbNwsgoUfx9m
	FrbEnTJINN0D58GIrwFtTm8ua698RvEdVzkG8q7W4FfHR3TYXuNtcUJ9VTIA7jju0GbLjg==
X-Received: by 2002:a05:600c:154c:b0:442:f482:c429 with SMTP id 5b1f17b1804b1-454b4eacc98mr145947485e9.8.1751982160577;
        Tue, 08 Jul 2025 06:42:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwFsHBVEro5CvXOCFzVmkJDQs/mNrwHrnzu4qHxJ8LIqAIs4YS5XK8sVi8hyjhO6N8NrfG4w==
X-Received: by 2002:a05:600c:154c:b0:442:f482:c429 with SMTP id 5b1f17b1804b1-454b4eacc98mr145947095e9.8.1751982159842;
        Tue, 08 Jul 2025 06:42:39 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2717:8910:b663:3b86:247e:dba2? ([2a0d:3344:2717:8910:b663:3b86:247e:dba2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b4708d0b9bsm13204192f8f.30.2025.07.08.06.42.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 06:42:39 -0700 (PDT)
Message-ID: <b610c003-5c8b-4fef-8fea-a2b40f8d1377@redhat.com>
Date: Tue, 8 Jul 2025 15:42:33 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 1/3] selftests: drv-net: add helper/wrapper
 for bpftrace
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Simon Horman <horms@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, bpf@vger.kernel.org,
 kernel-team@meta.com
References: <20250702-netpoll_test-v4-0-cec227e85639@debian.org>
 <20250702-netpoll_test-v4-1-cec227e85639@debian.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250702-netpoll_test-v4-1-cec227e85639@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/2/25 1:21 PM, Breno Leitao wrote:
> From: Jakub Kicinski <kuba@kernel.org>
> 
> bpftrace is very useful for low level driver testing. perf or trace-cmd
> would also do for collecting data from tracepoints, but they require
> much more post-processing.
> 
> Add a wrapper for running bpftrace and sanitizing its output.
> bpftrace has JSON output, which is great, but it prints loose objects
> and in a slightly inconvenient format. We have to read the objects
> line by line, and while at it return them indexed by the map name.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Reviewed-by: Breno Leitao <leitao@debian.org>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Does not apply cleanly anymore. Please rebase and repost, thanks!

/P


