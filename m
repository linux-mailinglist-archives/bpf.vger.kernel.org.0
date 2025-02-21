Return-Path: <bpf+bounces-52158-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 832EAA3F0B5
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 10:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F35C37019A4
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 09:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F595209F32;
	Fri, 21 Feb 2025 09:39:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189B62080C0
	for <bpf@vger.kernel.org>; Fri, 21 Feb 2025 09:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740130776; cv=none; b=ne1D0fAH3XT85pPBa1Pi+utxteR3ilFRDj9GUZhEgFVLJsm2xomzFQcl35UuiU61rwSgrS0EYP4xMM3zz0ZsY/YDvMw4J6GeiLg9QG0bbgSHbv5xzfvF3hsRNNEdGLr1eXpdUQOyJFHi7mZmDB8MaC9rFzEWnvi5vpM6qOEWSyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740130776; c=relaxed/simple;
	bh=pNLHKiH5iyIZyAcgfrOn1h7i3U0gjLLFs/8och41gHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ovRnISaGKsPPtRPzzlIfrloQ3Py+ht6IMR1Gbkk4oyL+xAMY7JAPntgIF54+6e4R+RzzjftF9Q3IWEBzT5/E9RtmiuILdeG484JFj12eFZpfqN94WJHsIIHp/McotAIpJTc8vbfrUckssHW35Plh5Gl2K6UP9P1Tb1oaCKWkNqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ab78e6edb99so266131266b.2
        for <bpf@vger.kernel.org>; Fri, 21 Feb 2025 01:39:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740130771; x=1740735571;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QMDyw42RtgNPzqPjL8Io6d0tCmMh05wHQYSwDcPHxro=;
        b=Hk6HFs6B2krR3Qf/3c5M0E1ATU9GO7l6eXIag8avf+XvQmQ675U3Bnqy8HeMNFswcG
         lRaliOnMsruUPCPNt3yE8AA4OMYYldz85TpinZ+wWfJ+ke7dvumoRLx5KQ5/3HaeRXRG
         pN/zoujQrBbGfZsxNC+S2vu0Vt9XxDU6u+sXnKX/jau+P4sXJVmsAcPnrsbLjUql7QAz
         g8D1m5kSvpbbrH5iahnOsB2xzcH1Pj1tvcydKG9T8/r7H5OknARPS//VFhgbw0E96vdc
         FP/59EfRF8reLYG5e5x9qtOSGVwrP1n6kZelIxrUJzgSp9GqiMGvyW2SZYknUcUHq7GB
         u18w==
X-Gm-Message-State: AOJu0YyAssZ77Zi9yj3M89IGJBHNNvgI5jXiLEP1T6zyfdhWh+HYpxst
	y4AV0gk0f/dNM0CPaZVEIuuNGrUYBFBu3SRnI0fbUbYGOtFlLeE/P5O3GA==
X-Gm-Gg: ASbGnctA++iqfJFfOCUCs4ILsP/eYlwxLLwjIU3EYN+sdzaseCcBUe7MlukYaTvDv9V
	FAhmO9APFld0mwxDqZBbYgkEH/zRl7oSZRzcVsaIGf3zUK6o1J4zYZbJ+KOxdl5RTXI6zqsmWQ0
	8KWwllOUmP4dG6svXpd6swXjpjRBXpqO8h+6y/V08LTUFRLAxKWe9KbMy9RqOqmXXXsd+3Ntr2T
	XF5CT+GcZHhk4epO/UbQNQ9WiEruLCkzkN2Kp7TLdxrgf/wAxQTtk3b8NHpohTFf00TbAdSRI6y
	4U1KGuYMflyGEQSV7Q==
X-Google-Smtp-Source: AGHT+IHflAa8rpmnr8xUm/diq0tbSq7Fh4lwmfOLrsoSU1DRlQk9Z1QMUED0Sf6WWB2Z2+KZtbK5fQ==
X-Received: by 2002:a17:906:6a11:b0:abb:d349:73b3 with SMTP id a640c23a62f3a-abc096e0044mr251223566b.0.1740130771040;
        Fri, 21 Feb 2025 01:39:31 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:73::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba532322b9sm1621121766b.37.2025.02.21.01.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 01:39:30 -0800 (PST)
Date: Fri, 21 Feb 2025 01:39:28 -0800
From: Breno Leitao <leitao@debian.org>
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, ast@kernel.org,
	puranjay@kernel.org, xukuohai@huaweicloud.com, kernel-team@meta.com
Subject: Re: [PATCH bpf-next] bpf: arm64: Silent "UBSAN: negation-overflow"
 warning
Message-ID: <20250221-scorpion-of-regular-variation-cedf9e@leitao>
References: <20250218080240.2431257-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218080240.2431257-1-song@kernel.org>

On Tue, Feb 18, 2025 at 12:02:40AM -0800, Song Liu wrote:
> With UBSAN, test_bpf.ko triggers warnings like:
> 
> UBSAN: negation-overflow in arch/arm64/net/bpf_jit_comp.c:1333:28
> negation of -2147483648 cannot be represented in type 's32' (aka 'int'):
> 
> Silent these warnings by casting imm to u32 first.
> 
> Fixes: fd868f148189 ("bpf, arm64: Optimize ADD,SUB,JMP BPF_K using arm64 add/sub immediates")
> Reported-by: Breno Leitao <leitao@debian.org>
> Signed-off-by: Song Liu <song@kernel.org>

Tested-by: Breno Leitao <leitao@debian.org>

