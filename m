Return-Path: <bpf+bounces-46411-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CB59E9C70
	for <lists+bpf@lfdr.de>; Mon,  9 Dec 2024 18:03:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61F8C280362
	for <lists+bpf@lfdr.de>; Mon,  9 Dec 2024 17:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3728155743;
	Mon,  9 Dec 2024 17:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="UFAplIny"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD91154C0C
	for <bpf@vger.kernel.org>; Mon,  9 Dec 2024 17:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733763710; cv=none; b=smx107Nc2ITeSpg/1Q/OKsXjmZOO+QkccJEdTn/dVrcstoDbiIjg4EQMTGFCvqUPvJ99uKxAHRqe+eW1FoHZ3sHNItpb/DyDYl4tkZ7MD/dsNbsl6u9HNXoDLKMx2lVFuOrRCPuJO55Y76mtznqY8ObjK67GZHdKpclI39J7PMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733763710; c=relaxed/simple;
	bh=i928oX/mpne3k+HYSwPwJdb5jtaB69wVPcl0yRy8D+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DGtPjWLHe5DxFTJXoznK1In51pXkErgavvPj+cFQQ7L/7x+IciJxzEzXrTpAQpeQIWlsV5/tQOxFkoPeD/qXjdafNn5QwTBvGD+070zPwvNsmvZFmSI1NDKjkxT9LtFxRyHUXXodFyfQKSYiXmKwXPwHjhyePtoHfZkBY9P/h8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=UFAplIny; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aa543c4db92so81137766b.0
        for <bpf@vger.kernel.org>; Mon, 09 Dec 2024 09:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1733763706; x=1734368506; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PWY3t5+dr0QM3b3J+VJ0zV+Hq69sDwu812ujN+kk1Ho=;
        b=UFAplInysOZrVH9y3MIXxl+euWc9+Glq9kJcDSWLYhZSN/4lEqYhcinjBbuifzsD/s
         stoUe3XBCpRirAHM7UGvIqMggnzgYDKOjGu4BWILviYnUMgLjDTAbCYtRPP6ZrtXxNsg
         oJuLJzgaeYnd/0WID0gouwnta024gAHJxuLyNvbGYBezGVn9C/EjGzlQX4nOmXXf0VR3
         6kTlDMMcqFv5Gc6nNM0iF3CGBaEWlbgN/X2oby6vHLXKa/7zi9Mm+jWrOpe3TtKyqMCD
         vOkEd8jHCIWplnHOM5JrsZyqMrbGE7eVGuVw4aRIgDYPuv3lzNGCczFU/5HLAw+RZwIM
         kPIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733763706; x=1734368506;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PWY3t5+dr0QM3b3J+VJ0zV+Hq69sDwu812ujN+kk1Ho=;
        b=EA58m7hFtjpaJdhCc23hC57TzFdxkrZeO/eptqRP2mSO06XkE2kTsvp8b1BQneZBUP
         qpVijU/v5M2d2XPP2kCGMCKoxK0XQqCsfr+a+wkpWFGoR3RsmBkCWO4QeOHYAhPmqa2R
         qg3t10KyIy+ZZJVIhiiIAAW7Z7V5F7ARGY3Ztkl8xmaLYDBLfziMy//kzNTvua1xQvx/
         Fco5VxBCVlUgjHdgmcrzErA3BwJCjCpIMBCk7zXa+XwL+nvzNskPAFcLkwxn5wLkHzhr
         gJd98LNVBlqWa8ce5UXf7q6eFWzdjclZhIxNEMZTE38X7WTgQJeRTi90j2kfH2u9c4WD
         8NhA==
X-Forwarded-Encrypted: i=1; AJvYcCXGQLlYK1/QoVBlHBQPhFQXFLWgJeB3KQn8YhRbr76rwKyC4bQFUbYmjDroXm/84Ndn/y8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF81hLZQWHM1j/+UwjQRkG7b2zkCsvz2pcTjNzNljHw97ytrn0
	3CcGSLCt1XRL6cPWlWfk7h64YpBCqG2x5jO1JKRl+BUjTOR3vrHaaFKsvFE9nJQ=
X-Gm-Gg: ASbGnctndg6ATL2P1QDz1m2TAEI6CHintPfMjoF5dDIJN8RdIDBrQCxyg6cLhBbIAyd
	hDuGzXhf1SicasoAKEumMt9dxdDih741CrorQXfIwaWpKhGToiROc5QdBhMFfD0h1/qIpfwDZNw
	Zv+GAGmVEDSr+Bxnx8qOlbVvB0ggU+SXkBgpN7oLGaibsnwxo21zq+UUehmTjQf1qLmrxpdNpJQ
	zWL3F2IOIv8qatT+jerOkYMvIN2T8evJxfQ3HTfQQkI3ehSnJcb+yqgqzdFYvPM
X-Google-Smtp-Source: AGHT+IFgCY0LV0E2i86E6uIyabSZKNK/6D6PE02hwvn//+8qGUtJWg0NJ0RhDHb5UusO5237JV3OiA==
X-Received: by 2002:a17:907:9557:b0:aa6:34b0:5c73 with SMTP id a640c23a62f3a-aa69cd53746mr135583666b.30.1733763706154;
        Mon, 09 Dec 2024 09:01:46 -0800 (PST)
Received: from [192.168.1.12] ([87.13.127.164])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa683de38fesm209821366b.108.2024.12.09.09.01.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 09:01:45 -0800 (PST)
Message-ID: <ca871055-0b4c-4380-8f32-a4a7152345c6@isovalent.com>
Date: Mon, 9 Dec 2024 18:01:44 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2] bpftool: Probe for ISA v4 instruction set
 extension
To: Quentin Monnet <qmo@kernel.org>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, nathan@kernel.org,
 ndesaulniers@google.com, morbo@google.com, justinstitt@google.com,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20241209102644.29880-1-simone.magnani@isovalent.com>
 <20241209145439.336362-1-simone.magnani@isovalent.com>
 <11d588c2-febe-46c4-ab49-8fb0ed80faac@kernel.org>
Content-Language: en-US
From: Simone Magnani <simone.magnani@isovalent.com>
In-Reply-To: <11d588c2-febe-46c4-ab49-8fb0ed80faac@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/12/24 16:20, Quentin Monnet wrote:
> Looking again at the probe itself, does the second instruction serve any
> practical purpose here? Don't you just need to test the BPF_JMP32_A?
> 
> Looks good otherwise, thank you!
> 
> Reviewed-by: Quentin Monnet <qmo@kernel.org>

I wanted to keep probes similar to the previous ones (especially v3
and v2), despite we never check their return codes. This means
having as 4th instruction `BPF_MOV64_IMM(BPF_REG_0, 1)`. However,
to do so, I also need the 2nd instruction, otherwise I'd hit an
`Invalid Argument` error while calling `bpf_prog_load()`: I think
that would be due to the fact that no execution paths would
execute that instruction otherwise.

An alternative approach less consistent with the others would be:

struct bpf_insn insns[3] = {
		BPF_MOV64_IMM(BPF_REG_0, 0),
		BPF_JMP32_A(0),
		BPF_EXIT_INSN()
	};

Please let me know if you have any further questions, need
additional information, or if I could improve the patch.

