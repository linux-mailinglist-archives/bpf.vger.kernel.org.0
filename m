Return-Path: <bpf+bounces-22878-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE3C86B1EE
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 15:38:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6119288D31
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 14:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E70115A4A6;
	Wed, 28 Feb 2024 14:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="eMG73QO+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451E21852
	for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 14:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709131133; cv=none; b=Ov3H6751t0sGi3GDWfNKm+YHhvyUTB9oJsPruZbT3uiIT6sbg7VKfKP4ez2v4JhLPCerTbdvBhKCZabKofWMQ6vh906iz5QxzTxccUzXabG1XM/fLBivd0WLHH38ApwzAw5Kb/awQbXNsK0pCqOhM9VwR0JsG2OcJm8JbHBiyBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709131133; c=relaxed/simple;
	bh=RMdzcVOTNoBSqeDfKOXSW1mN8QyII4YE+UnJCch+QTk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BGqHqLkatvNCRrMEYMGNc+Rs1xgHk5Bdz8/YDwOC8khb+VmTHe7CV6L11/csDBdyDn40PRslvTCMPPo1AUau3t7iQe4MHyqTNotdWgWBJrhf/2ixzo7D2gwodNmxYQqM8YxjGIVj9gbZRVncMnWEKf4ALJzGJQlmasaDF8TQG8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=eMG73QO+; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-412b5a9916eso3973745e9.1
        for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 06:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1709131130; x=1709735930; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C+1RRfhIt9Zrpn1OWgIdTuReOYXGBIkuKAqm9XOFS+A=;
        b=eMG73QO++CjVMyr4Mc0RI8AeTh2sVlaoNPx0PIZLeatD8I3K1ZOF7KPCmWDfloVQCo
         WHw3y8Po6oqM32/NqW3F30Uaq9sRciCUNSTmbb7yDd21JbOqKBH1JFW4iucX+tNH4k8k
         qJP6gFK20dnyXIEUTzkvGKpHg7gAx3KM5ibpPRKIx1Vwf5D/ckSY8QLB0N8htTUMrt7a
         Kvk4tmu+PyH5m9rGzsFjvtqPTTBfTNnIa6T+ilK6AihIwfyVBC/dmTukpcfICxM/3hkj
         JpCmvHjUt5axmagv6VHAGzBPYp5whvvzt8KPwFzcMeeN2h3f0ssa3kdyj2AsDx3csKS3
         aRcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709131130; x=1709735930;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C+1RRfhIt9Zrpn1OWgIdTuReOYXGBIkuKAqm9XOFS+A=;
        b=Fy0Di1z3Jx+ndbxXaN/RBNYVWi7WRxEZd50QP731x1RHan2nzAMoqHFdFGD0dM5qlh
         vemYisaTBF494DYx+/HkkpWZVZ5jR0q61iEXbR+NmM/3U+v0RbyQ+qVUTvFq+lhZHHKd
         76FkUdgBZ1bAcIxwbHopjCFqlS6mRkO4BWv2GbjHBTb5i9tfEtJLSgPiyIS4YeBwL++J
         TsDD7hHDCwECry4PBGIleNTcQjy6uEZM4GYHdCAnf/t19U+tk0hfdUMXbLlnzxYn1zGh
         hIZLQYmtGiVnaqSAoLvLaxlNP4VQeYTpMMwxigmaZnXBNxmmUdr/ioXiVW3uJLV60RLx
         QDow==
X-Forwarded-Encrypted: i=1; AJvYcCVslGfsZFZF1SRBGThXJc6bV+vHlGOKpkpNyKbOLsExkzmSFEEs2lrZMSZ37Sv4TtLrms4mmWXgDXJQzeIlUvF/PQwY
X-Gm-Message-State: AOJu0YwMBUa7Xfz5DHIZfqLDzXbbvI/DZmNqB8udT+1XD1oc80Jum4Yu
	wO751i2gFo8Dw3uJtzRk5Zy1BnvOCVO1KdaB8t7cEYDU0exDZqyy2MHRCz1LhhE=
X-Google-Smtp-Source: AGHT+IHSd9E6u7KdaxqaFc+lZHXV0ybU1zDKm9DYZOJtTklnmXLBw/43pmirSKgNA4JZmtMxOoAJCQ==
X-Received: by 2002:a05:600c:1e0d:b0:412:b84e:91b9 with SMTP id ay13-20020a05600c1e0d00b00412b84e91b9mr160024wmb.8.1709131130680;
        Wed, 28 Feb 2024 06:38:50 -0800 (PST)
Received: from ?IPV6:2a02:8011:e80c:0:5379:cc82:ab28:8613? ([2a02:8011:e80c:0:5379:cc82:ab28:8613])
        by smtp.gmail.com with ESMTPSA id k6-20020a056000004600b0033d87f61613sm14637334wrx.58.2024.02.28.06.38.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 06:38:50 -0800 (PST)
Message-ID: <ee842834-ea90-4402-8820-66e7c0db1560@isovalent.com>
Date: Wed, 28 Feb 2024 14:38:49 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 5/6] bpftool: Add an example for struct_ops
 map and shadow type.
Content-Language: en-GB
To: Kui-Feng Lee <thinker.li@gmail.com>, bpf@vger.kernel.org, ast@kernel.org,
 martin.lau@linux.dev, song@kernel.org, kernel-team@meta.com,
 andrii@kernel.org
Cc: sinquersw@gmail.com, kuifeng@meta.com
References: <20240227010432.714127-1-thinker.li@gmail.com>
 <20240227010432.714127-6-thinker.li@gmail.com>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20240227010432.714127-6-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2024-02-27 01:04 UTC+0000 ~ Kui-Feng Lee <thinker.li@gmail.com>
> The example in bpftool-gen.8 explains how to use the pointer of the shadow
> type to change the value of a field of a struct_ops map.
> 
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>


Thanks for this, and for addressing my previous comments!

Reviewed-by: Quentin Monnet <quentin@isovalent.com>

