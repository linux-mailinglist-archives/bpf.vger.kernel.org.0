Return-Path: <bpf+bounces-20879-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC79A844E36
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 01:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6200028507D
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 00:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F6520F1;
	Thu,  1 Feb 2024 00:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="C4qMw8kw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58711FD7
	for <bpf@vger.kernel.org>; Thu,  1 Feb 2024 00:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706748858; cv=none; b=bKOSP/cL05+nXZ93bJn+LEmDw8Kg+bikhWsTH92q6growk5VFLfOZUU4jinqDcIDV9e9HXaNlcj5BwS734+QDTNRD6cJOJI6KM/wXOdg4W9kHLaDXdjUDwhiiyvsvDS+6JaUDNqrbq6IzFniXQwLGDPDshPFVst5LbuNrmangrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706748858; c=relaxed/simple;
	bh=PqvvTc/oq78gbJg28LbncknA9cuXS0NHQD6IJxFhHek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=phm4ZJQviCkxOow6Oad9YoZL9l1MBmfpJP6Jmq/uX8cDwI5rGG3dcc5fctFmWlmTcWPmCODN0IMfbohMnIvUW4FO3ke1D/QidI/4oEJB88ml5QMASuJokF3LfW+ag+4ZZw1ANMaVCtDrr2WqsaToBrvmHkM2yVtb7+Xlz8yZKU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=C4qMw8kw; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40faff092a2so3450315e9.2
        for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 16:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1706748855; x=1707353655; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=klBri4e7oKQTtNhi5hik/dfdLrznbOwVhQvPr7O2KNY=;
        b=C4qMw8kwZrcrCJ3IiS9ZeFoJJBq/k8LLVUg1aQUJga1vNc0oC0667x4JTobIWeVA5p
         qUPw7TJRXlvdfJASI/l0Ug/B968gbYVv1Qlzh6nN4HxOMR58iHqCtjCWEKndhdVAwmBV
         n313fgoXVUgi62V7jc8wrrp8d7Za8b74SX0igWkgbq8tpizxI6Dj8cbYRcuykfGuwGgg
         odMZqzHfVAL4GWjKJnl2ZeuhKer0715hiGbs744Lu3JUoJXG+8TmZLoVE3z6U4UgOatj
         XNErpdR65AWzxykv5pK74ZEZljdZ1XiNZB/xtWnyG1sA8FRhoWukv+8fuWYw/YeF4854
         c6CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706748855; x=1707353655;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=klBri4e7oKQTtNhi5hik/dfdLrznbOwVhQvPr7O2KNY=;
        b=reFetEJE2td8V7ZG33+onxz0bWtK8Ooo8ls7wVGiK17AGLF+Q1oHZq+F2G/JFH5TwN
         Ag+k3foG+AfYIWdJGy+dXTx7Z6Q0DNTGIJop5nXbNwqPC+jhICeAqfNxrjYavdUqxzHn
         MB0KFpOY06PmXklEeHPMEQ+QqtcgMt6SYa5FEkMq9mw0Vqy7bDozyhHcq6crPP3Q2zJv
         Yw3rrais9U+m3ZKrB4wudFMHBXp4dNEwH/HrYKJ2gKJThcANVgmSRQIw5TPocBhY9Iln
         0nB4QR1Yx4o0YbkTDTtgiLvtf1EMtEDXIk4lzVtVBG3SmqKg9RPrLx6w8G6oreBgIbUm
         LnPA==
X-Gm-Message-State: AOJu0YwSpyO8Bo+Q6HHok5c4gRc+R0utBt+VZ/u5X57DkQHzZsIHrCQv
	Els0KdBqq3u0Mf5TGyRwY2/97ryo7jGyNcvxexyj+SSz2IPkaSjHuWh0iZ+0Jyh+ns4j6lW303B
	qNCA=
X-Google-Smtp-Source: AGHT+IEvDMXH2lG0FjvpaWYValEJiiEAHecvxhTgUkhkDzTNcHE/OFKKiNzjYwuv0brF2+6dNdXx7g==
X-Received: by 2002:a5d:4dc9:0:b0:33a:f431:3489 with SMTP id f9-20020a5d4dc9000000b0033af4313489mr2513046wru.56.1706748854833;
        Wed, 31 Jan 2024 16:54:14 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXZfXO4YphwVhdoixadA9RinoR8z/hEglQU7HL2imDVydyDqbUJCbNTbWm1oj3NvPxYQjWY9mRdEwlrSz+rIRCjEimlKYNlO0dnVR86nlfSg6h3dQb8WmbFeOz8I3x7oNrBYXDeRRLHMasQpJjbmuNGw+XXvQ==
Received: from ?IPV6:2a02:8011:e80c:0:cfd2:62a:7c7a:600a? ([2a02:8011:e80c:0:cfd2:62a:7c7a:600a])
        by smtp.gmail.com with ESMTPSA id a15-20020a056000100f00b0033aee3bfac5sm8835973wrx.16.2024.01.31.16.54.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 16:54:14 -0800 (PST)
Message-ID: <9b054832-3469-4659-9484-00bcfef87563@isovalent.com>
Date: Thu, 1 Feb 2024 00:54:13 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4] bpftool: add support for split BTF to gen
 min_core_btf
Content-Language: en-GB
To: Bryce Kahle <git@brycekahle.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net,
 Bryce Kahle <bryce.kahle@datadoghq.com>
References: <20240130230510.791-1-git@brycekahle.com>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20240130230510.791-1-git@brycekahle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2024-01-30 23:05 UTC+0000 ~ Bryce Kahle <git@brycekahle.com>
> From: Bryce Kahle <bryce.kahle@datadoghq.com>
> 
> Enables a user to generate minimized kernel module BTF.
> 
> If an eBPF program probes a function within a kernel module or uses
> types that come from a kernel module, split BTF is required. The split
> module BTF contains only the BTF types that are unique to the module.
> It will reference the base/vmlinux BTF types and always starts its type
> IDs at X+1 where X is the largest type ID in the base BTF.
> 
> Minimization allows a user to ship only the types necessary to do
> relocations for the program(s) in the provided eBPF object file(s). A
> minimized module BTF will still not contain vmlinux BTF types, so you
> should always minimize the vmlinux file first, and then minimize the
> kernel module file.
> 
> Example:
> 
> bpftool gen min_core_btf vmlinux.btf vm-min.btf prog.bpf.o
> bpftool -B vm-min.btf gen min_core_btf mod.btf mod-min.btf prog.bpf.o
> 
> v3->v4:
> - address style nit about start_id initialization
> - rename base to src_base_btf (base_btf is a global var)
> - copy src_base_btf so new BTF is not modifying original vmlinux BTF
> 
> Signed-off-by: Bryce Kahle <bryce.kahle@datadoghq.com>

Looks good, thank you!

Reviewed-by: Quentin Monnet <quentin@isovalent.com>


