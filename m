Return-Path: <bpf+bounces-58101-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB84AB4C48
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 08:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6452E466068
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 06:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B781EB5D4;
	Tue, 13 May 2025 06:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r/4AvaaM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A5F1AA1F4
	for <bpf@vger.kernel.org>; Tue, 13 May 2025 06:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747118901; cv=none; b=ISLdF6E01/lEkwAgVJTMAyIAsGBOjGcL/x162H9NVDwa0ehrIhtkbzjs8Djsf2Ss/+S9Z9/7hm7eiclrxh+ERsMUCPPGsH9nsZY30Usq6zszFnS36d7U1hog88rJQbGJUyYU1BXLLzYjVlJrIJcta21yZ5vblRqVW04gQbXSF0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747118901; c=relaxed/simple;
	bh=RcRfRfiAuuRF9bhIwkVKzgLO/wyEa7YyInUjDk8gKWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CosIpLOrb8MDlpUwVkgRvurI4ognzgUjeOODC2o2BZL/tQ0Qs4dRZZYfra3gnnuaT7uYOiTa6v1OqL8/XIbFvoJbnlSauERziNbniwLscq80r1kEk43hkTYcaYJOXwZZZmnSKI3w21J1FmT14bN/SStMKgdT2H8VGDTDxdar5R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r/4AvaaM; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ad21a5466f6so741773766b.1
        for <bpf@vger.kernel.org>; Mon, 12 May 2025 23:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747118897; x=1747723697; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+86WWrgrCI2isrodBtQXApphsPK21iLq8TQArOlfymA=;
        b=r/4AvaaMFC5/jCv7TkWwTCxBZWtpvadUD+jR8eMJx3EMpLLj3mZ4eeo9ZSw4G9wLjS
         fmeHBqIsogvlMSTvyovnD4Gh/yGYvVeqBqgrwC/1+v8C7qn9Mrph/tZ3sFJOEdv7zQSu
         efJdgV/cxQeWNQY8taj/vcT6UQ2j+TjOgoWImTYwfb/XPEiS8msNsMqjHyNS4iEKokUt
         3wfiBz64X+eSc2uc/0e1dYz/pUDZBdzciZ15le5Z696KiDInp42wt2CnSXD9lRey0M19
         ixS8pp6RBY660vqv+3fcfUfyh1KncoWEPcFkHs8Rfp5elH4m0HP4YOdF/cKmRlt59EoJ
         GJwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747118897; x=1747723697;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+86WWrgrCI2isrodBtQXApphsPK21iLq8TQArOlfymA=;
        b=vWhtxvER23Pkyi/mV8DJNTATPGR4cm8OIDUrrJCic1aBKqjL3g7/Qg8L3Cj6rYy+U3
         TaDSThfDYuuFIe53oORb6y0Ej+ViUzBxi79M021RC8+QtxLp8962nv2ZYrExth1O1g6r
         EqXYqMZNA1OLbPmOp3Gj0fYF/tTWHZ45xFauUXrtoqBhsWNWdtQnG5nLmlaSH84l4Inn
         hwcOJ28YV5bwgEHc6hVQrWDto1+GjDQ3QMfYnctrpsDpGPW8Lanozts2d9tmkdMJt3ky
         h4SPaBfFmkU3kgzI9A6vYkYcFVj6ewjzTdxp4WsY8X6PzWVxSpmbVedX2lxHFWOBBolA
         0Tjg==
X-Forwarded-Encrypted: i=1; AJvYcCUucMWlpHFYyDMJMnIZQeUOi3fROqIk8s3ZmgzjBP/+S7CVvprMdDCZy7hyK3OOfj967dQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2zY9ZM+9jDiVNI1XdQR1cgpTLyCsd/VN14CAPvahbBILkM7Dc
	WK872iNCCf5bGZWw6BUNUm9OxaQW8ezJ3OXgyP5Whf4yOjC3B0YFVBtp4PfEWg==
X-Gm-Gg: ASbGnct73qYiuKX+EluMGHah+6vbHShOt6C5W/cLQ32wNhhY3hzxTr6ZtE6CxKaWueD
	TuHg3YxKPN1yrr2/cLrDMfHhIeSuFuSjVXmEYVCVwu7rqH1SifOrwXRSwXav8Vz8fBY8rSWA2M9
	jm/JupacCU+H4/KYoD/3e2FiojD1QmQWrbX0nIjzwRK7Ga4TwAMsJelbmiFxcfyVty/tiGI7lsE
	0EJyKtQ6gjahDt9Jm9/6QWqRfv+FQ6yr/ofwoVKlRDgtPjXrvcjdpVtHtU0QMs5MqQM3y9VWOgJ
	tuaqbGKpRZf+J2vgZNQgWXvoBXAS4IhaLfRp2ERQ4q88/VgF8rWAoi24S3nq+IsNRPv/0WueaI3
	PqjjnI2uzSkdmGSHoU/Qkv9HqzGPb
X-Google-Smtp-Source: AGHT+IEx/rIkx3818alL18ZeAwy1SGquFOX4T0iyB7PUV6+2b1UcLa/RP4qAqcGL+Xw/CV0i69lTuA==
X-Received: by 2002:a17:907:7f94:b0:ad2:50dd:dbb5 with SMTP id a640c23a62f3a-ad4d46b0e55mr239229866b.0.1747118896909;
        Mon, 12 May 2025 23:48:16 -0700 (PDT)
Received: from google.com (201.31.90.34.bc.googleusercontent.com. [34.90.31.201])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad2197bd224sm742271566b.148.2025.05.12.23.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 23:48:16 -0700 (PDT)
Date: Tue, 13 May 2025 06:48:11 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Viktor Malik <vmalik@redhat.com>, bpf <bpf@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH bpf-next v4 1/4] bpf: Teach vefier to handle const ptrs
 as args to kfuncs
Message-ID: <aCLrK_QBMVWCy4bo@google.com>
References: <cover.1746598898.git.vmalik@redhat.com>
 <1497b70f2a948fe29559c6bfb03551a7cc8638f1.1746598898.git.vmalik@redhat.com>
 <aBx0qmVvL84Jb3rf@google.com>
 <CAADnVQJD3dQfuT2ExXL5iGeVj0TJ9L5KWGovmsSz5giKft4ryQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJD3dQfuT2ExXL5iGeVj0TJ9L5KWGovmsSz5giKft4ryQ@mail.gmail.com>

On Fri, May 09, 2025 at 09:20:53AM -0700, Alexei Starovoitov wrote:
> On Thu, May 8, 2025 at 2:09 AM Matt Bobrowski <mattbobrowski@google.com> wrote:
> >
> > >
> > >  static int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
> > > -                      u32 regno, u32 mem_size)
> > > +                      u32 regno, u32 mem_size, bool read_only)
> >
> > Maybe s/read_only/write_mem_access?
> 
> 'bool' arguments are not readable at the callsite.
> Let's use enum bpf_access_type BPF_READ|WRITE here
> or introduce another enum ?

Yes, I agree, and using enum bpf_access_type is also something that
had crossed my mind. I think that's what should be used here in favour
of the boolean.

