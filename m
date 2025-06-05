Return-Path: <bpf+bounces-59706-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB00ACED4E
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 12:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5019D3ACB39
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 10:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F7D214209;
	Thu,  5 Jun 2025 10:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WAuxgpuk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140013C17;
	Thu,  5 Jun 2025 10:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749117839; cv=none; b=DW5HYLetoDabK59OwobgZR3CfyFQydic8Hq/0sd8B7X+/j4gKxoucpX1hEkIr9v5ykY7xMT/cB8Xtx8lV5hlq5+hdjO29rxdL9U8hGcSz/zpUIArqhBVVL7jr7KZVikiLI8PKmyRGKaz1enT9BUxznpWnJ+VlfkgFeapCBiyUOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749117839; c=relaxed/simple;
	bh=IbFkBMYSzv1GGq40/JG4FvWS9we2ie1V/FudTFOrr54=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KMpZnG4kuCHVRylXtrCCxv5vGRjqDrzuo8d+LsQiPwW8wBhxDhfaAfzSAVLNazWJxYOWx7Mluy21/YaPHumOmBxQw0RZFSJ9n1cEA/peVuHpBiOmeM3HRXZfkaYCTvY1b1Rlg1x/byV3XDdYE65++4l2SEFRuQTQRYafO8qH4ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WAuxgpuk; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-604e745b6fbso1432069a12.2;
        Thu, 05 Jun 2025 03:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749117836; x=1749722636; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E6YKIEIURfzN9VHRc77Dd80LqnT7KLN0i32KIXK3tdg=;
        b=WAuxgpukBAelxaeGSwAncGOzKFD9PmdEUegvK4vrpqToo9Iu1JsXdiQG828iBFLX8m
         WSJLsUzQqKJYrHSfzXWPdgOV9aWQtKSqbaqif1ckC0qcm++CZTBaMasITeSvTSozbKv3
         x+wtzQcFO9FqacQ84fZM2+XtZCzDMOR/E4j6K3ARddjk8A+zJorcfmAJAt7jgCcXdT2+
         HHpmxEtndMrxcymABdR3dbUFbpFCv+JNAtHS+2HcHbAphajFi1eGbt2vPwM4aj0tnqCd
         p25Xkd146w6wiYcKqLEEDWYKBaqmqnuCQuR4rgIgjfAYDGX3g9MhZIq+nOoBJTU/H0Ji
         7AHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749117836; x=1749722636;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E6YKIEIURfzN9VHRc77Dd80LqnT7KLN0i32KIXK3tdg=;
        b=rQIACpOLVlXzI6BGznvB70dbBNp2jD2UbsFXfhN3ANIK4To2sayouZWTEIVREBCSS2
         tPxFvrPDLhP/e7F+6VH9cDAF/xxFoCTm1bWydJR2mQzOBWiMvxRndQIG1xC0EV8OLuRT
         FmJZYMkEMMNoSuD2Dl0sPKv71/d0/DP/QlOwFSZdlISkjYh8vH5OFUbUZTbv7QGi667x
         ILawqG2D2mU/NFgN4vG35H2GTcrCAn536aiJ6oPGiQKWLUg2d178oTRDqNGgkum8J+tS
         97KiklxUPip4TCHL6nU2/FcwrR3QhR9JvTv8VuMfMyT5IUPTVJK+CDAZ7zwy+Mq3I5AF
         2BtQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4t3gCywrFnbgs0FHJemOJ3tW9TNTlACRmKw/QHZ8S/U9EVIixnFjtvNZ58I8RZ01pPMyJSLXkpVVZ2Q==@vger.kernel.org, AJvYcCX3UsFKi8JuSGPwMj6zrPh8EXdRqjQRvcs/a1Gqg0Is767k1njplRdg1SlZloupaJh/TGgS4i3G@vger.kernel.org, AJvYcCXviZr4tchv/8kXRwK0pSIKzHI9lnRwK2Aeaa1XVnTs3fEflc/rOhyA/jYq8k2V3KnOmu8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXgl0T0U1eIz8iP1uUgBw4CgD3jndE3vq6aZ0VaNFGIWsh+HdC
	efbtIJyoH2UGTs6ao+mdfxyn8QLPlLD7nHxjG1BSlw07+KMQPA5A25Np
X-Gm-Gg: ASbGncvt3UdqLf7TyOcYOQdqRiESLptjQck1xHK32vIvkz5czEq6jaUdds5sdZO+iPn
	33vztErcIHTtRojZO3OMTiXZq5dY5XL2nwsM94Ok/ssLLs2z75bCpknmtNC/mb9k3CkkSHo2rhP
	glWiOmb+yr5gsr//GROKglbxXQyuyO4MEp5qdb+qLlfJXT1ShckNZKFKmtOm9Y3cRCaU7mI776c
	ZSUjuukYnDS5iFsONXpqmySYlXb0OoPU9BaM6IFz8phZIrM/fFsAolAm/nqRXfh95kr8WB6Nuuu
	yD0px3xXgF2RoWXAFKMyl66heC2bEzUJdBb8h4jsu5VqI7V/6KNMXb071d8h/vX8UbYmzCemyRQ
	=
X-Google-Smtp-Source: AGHT+IGHwOHFs0rVwCkQOkMluqbJXbdKtriQIiO3+FtsY2VCHwyOrAi82G3s8RnRgtSaBMdtsBdovA==
X-Received: by 2002:a05:6402:34c1:b0:600:99ba:222f with SMTP id 4fb4d7f45d1cf-606f0b83799mr5118654a12.15.1749117836168;
        Thu, 05 Jun 2025 03:03:56 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325::22f? ([2620:10d:c092:600::1:d66f])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-607193ecba2sm1327674a12.35.2025.06.05.03.03.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jun 2025 03:03:55 -0700 (PDT)
Message-ID: <d84f48b0-911b-4a8b-ba08-59eee164bfbf@gmail.com>
Date: Thu, 5 Jun 2025 11:05:14 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 02/18] netmem: introduce netmem alloc APIs to wrap page
 alloc APIs
To: Byungchul Park <byungchul@sk.com>, willy@infradead.org,
 netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 kernel_team@skhynix.com, kuba@kernel.org, almasrymina@google.com,
 ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org,
 akpm@linux-foundation.org, davem@davemloft.net, john.fastabend@gmail.com,
 andrew+netdev@lunn.ch, toke@redhat.com, tariqt@nvidia.com,
 edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com, leon@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, david@redhat.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org,
 linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com
References: <20250604025246.61616-1-byungchul@sk.com>
 <20250604025246.61616-3-byungchul@sk.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20250604025246.61616-3-byungchul@sk.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/4/25 03:52, Byungchul Park wrote:
> To eliminate the use of struct page in page pool, the page pool code
> should use netmem descriptor and APIs instead.
> 
> As part of the work, introduce netmem alloc APIs allowing the code to
> use them rather than the existing APIs for struct page.

Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>

-- 
Pavel Begunkov


