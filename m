Return-Path: <bpf+bounces-13272-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C607D768F
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 23:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A732281CE0
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 21:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2BA34187;
	Wed, 25 Oct 2023 21:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+yHywfo"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59AB12B6D;
	Wed, 25 Oct 2023 21:24:10 +0000 (UTC)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E2E132;
	Wed, 25 Oct 2023 14:24:09 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5a7ac4c3666so1339347b3.3;
        Wed, 25 Oct 2023 14:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698269049; x=1698873849; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b2tlHyzHAWHhl5WlMfjU/HdSIBEM4uvxlEfX0//lC78=;
        b=D+yHywfol8vj6Xkfa12jp/YevEGbSxRnwHLCwgN/eGdJI/dDRQiyYwWucOsnM49BpP
         bCaGYKQB77A3oqGHOU3hV5Qmfh22stGqhQpP4zrLwpdlj1WoFhwfkQ6SIKWoAMlG4oY6
         hjGg+LWZwwkrbV0G65OK7CU27+WWPfZQFxrNdVmi5qTfICHtvUVspI3D8LNaAfjR5Kgd
         UvIU59kq0tk0HRhm5b6HOE1+cHepszaYpQYKLFkAAC0or105PIyQd/oa8j9PIpum7sDb
         RZNSgx9+iM24f5Qw9OssICqSDG9bAngtKeEuHex2RFv/2vG8MPE36OKUWPaL1XVTnBVy
         TxGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698269049; x=1698873849;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b2tlHyzHAWHhl5WlMfjU/HdSIBEM4uvxlEfX0//lC78=;
        b=UkdRgJJfmAKFBfhJJsyS6CToSmHqWYPVk0LzD0ryIZce93BP5ssmWt43kXaKW7HP/R
         +bgrn6iYdI5EsE7YJzADYVTs488b/DTjmBELKT5le6LOvtcpggB5jx0MHWjABqx9EIvj
         ZvQRWM3tcK9BBUQ83fOWU80VovRFT97G5KRCEDdXdGn+h76yb0ZMT2AMPgvK1ZmuqJqm
         eByX+rIGpNi6UKfBEMvCkYeAem/qnoX6DfLwnQsljJPxQMlcd1jXAfVrUyqh9IssR1YZ
         y+lole5uqi+CBoS8+UlvXkcpgUCz+UWVEOjQ8BB0K7vIBxWZOpxzCT5P6J9Z1rt4GEOT
         LJjg==
X-Gm-Message-State: AOJu0YzzDJqMOqWdBwl7t/2CO8c73d91dtFpTwM74cl1lB3pMX6zGAJg
	H/vGz8B5siNV4kx5eMhQsts=
X-Google-Smtp-Source: AGHT+IHrejJCIAGJw5AK48PIQZcv5G1WktJGUSCMiakxtG7viabjRgphqcoVDZrVhoL/ko4uUdYWKA==
X-Received: by 2002:a81:920e:0:b0:5a7:c906:14f with SMTP id j14-20020a81920e000000b005a7c906014fmr16271706ywg.11.1698269048830;
        Wed, 25 Oct 2023 14:24:08 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:1545:3e11:ea38:83fe? ([2600:1700:6cf8:1240:1545:3e11:ea38:83fe])
        by smtp.gmail.com with ESMTPSA id z65-20020a814c44000000b005a8eadbadbesm1670366ywa.19.2023.10.25.14.24.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 14:24:08 -0700 (PDT)
Message-ID: <ad801a2c-217e-44b4-8dae-0ae7b1b8484f@gmail.com>
Date: Wed, 25 Oct 2023 14:24:06 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 1/7] netkit, bpf: Add bpf programmable net
 device
To: Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, martin.lau@linux.dev, razor@blackwall.org,
 ast@kernel.org, andrii@kernel.org, john.fastabend@gmail.com, sdf@google.com,
 toke@kernel.org, kuba@kernel.org, andrew@lunn.ch,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
References: <20231024214904.29825-1-daniel@iogearbox.net>
 <20231024214904.29825-2-daniel@iogearbox.net>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <20231024214904.29825-2-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/24/23 14:48, Daniel Borkmann wrote:
> This work adds a new, minimal BPF-programmable device called "netkit"
> (former PoC code-name "meta") we recently presented at LSF/MM/BPF. The
> core idea is that BPF programs are executed within the drivers xmit routine
> and therefore e.g. in case of containers/Pods moving BPF processing closer
> to the source.
> 

Sorry for intruding into this discussion! Although it is too late to
mentioned this since this patchset have been v4 already.

I notice netkit has introduced a new attach type. I wonder if it
possible to implement it as a new struct_ops type.

