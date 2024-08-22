Return-Path: <bpf+bounces-37811-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B9E95AAA0
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 03:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CA0F1F224F5
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 01:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5487BA45;
	Thu, 22 Aug 2024 01:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RK8Y2IYp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E708BF3
	for <bpf@vger.kernel.org>; Thu, 22 Aug 2024 01:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724290988; cv=none; b=ePnOEGwe1lNjl2H74RtMu7IgjvqvfHrXTFf5ol1rWw+B2PF8/qjFJHvoQb/2DOTvoI7KUm8PwbWxt4hx+SK4pq+7Pu7H8pc6gD0VUs+QCQ6diix9u00Kdr4c3MPL2X65VnIRgxicWndiLSGDr+HL4NcPuBaEaeEsc+Sfpks7vSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724290988; c=relaxed/simple;
	bh=31GfGpRMjaIksqCFi8xJ6Zp9Va69GceiDXcoquOuw/w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S733bBDO8+kTx7TJDaU4KGYWzJcCcmvbh59Vo53OG4aQZg4jsWWHFpT3NuKVM/lhHsGDzlmd8Rhvsno83kwDFvdCxvduXdPE7JbbQM4nytoh5dgiMt2NK3OYw9zfIrlHE35oQlKzPiydF89F6y3p9sJdp7zIjzfR/8Rqf7a7aoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RK8Y2IYp; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-714262f1bb4so278182b3a.3
        for <bpf@vger.kernel.org>; Wed, 21 Aug 2024 18:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724290986; x=1724895786; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SX+wWEEl3/8nPsjcpROOagI0idfLhBjFIGL9Pc7CJAo=;
        b=RK8Y2IYp2uj2+4XxGnJ0MGJb0bnfMhKiGE0oAYsjish9BeNz5rvaZRani2uF1s+XK/
         hwyZWruMB7UM1ZNzoJLgQTlHwfvjbx1NQPmILjkftPGMoT43DcZ3O3H27i3KKjA30mzu
         WCQqlDqfuG5FlCvYtdVAbv1wcfi3ajBGrN40MBP40PLFowKXlsJXBKtD/c/BisDLRYgJ
         bJSLus65x9Yr/FEOPckGwM6qM4vw+Xr/vpFZS67xHwZEYGTE+wzSQV4KhsAjUKvo2FKX
         Iq1BK8BP5aJTNgrvk0n1qT+l+vbowSIMhYHTTsPsHaXS88Le3YUskEWCeV3a8+k25HPV
         gqmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724290986; x=1724895786;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SX+wWEEl3/8nPsjcpROOagI0idfLhBjFIGL9Pc7CJAo=;
        b=e7pF0NCkBE/G1O2ozA7xUzbOPhTPhXQ1EezE6ozVE0BCk3fpJstkqLl6tV7HGrLK0g
         tka79SJtV3q0laC1Y82/BiMkMe+x86Qr98EjeXzLLN8yIh5+eeB1mGPkEZVgJcq0gSF/
         8D7ebjf1UME5T3jiDB3SWsVIrjIOYBGJb7zPEMqyxH3gSOQOwYBOtftfYDzWR5W9Iem1
         mnH2mEW2fK7IDvTuLc+qyTmxN/KGmfFbsYC0MZm+B0aGhxDeYFWyOx9bbqpZUIkC+qx+
         Ox+pBwKmT/Z8ie8lGum959n2Uc67hJuAYa7RRMUxWR4Gq70X4WEmswAf9bWN+8VmYUes
         6zIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKXRbTtBGoSqrqOCldM/03j2zOZV6LFHQyh5A0D7AA+LR33IGAwBPBh76F0ePuEMPXfI4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzhHqCDQp+kbC5Ib3ovWWdTnT0SbjFaug153CQSbL48yvCDGqZ
	wNlJtzSS+93BW025du9CdKWCZUDmSEWgBf9xjsX31ucARNsEFg/X
X-Google-Smtp-Source: AGHT+IH2S+F1hI56MpidlrE1JTzG9LDVioKxy+74+UO35Bg4y5N8jDKv8qj1Lw2e4kaSWr2+zKR6tQ==
X-Received: by 2002:a05:6a00:91cc:b0:714:1d96:e6bd with SMTP id d2e1a72fcca58-714364d3882mr500075b3a.13.1724290986265;
        Wed, 21 Aug 2024 18:43:06 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-714342e46bbsm294938b3a.107.2024.08.21.18.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 18:43:05 -0700 (PDT)
Message-ID: <b0cef1d8665baac74a173dbae37db884989b170b.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/5] bpf: rename nocsr -> bpf_fastcall in
 verifier
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org, 
	ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	kernel-team@fb.com, jose.marchesi@oracle.com
Date: Wed, 21 Aug 2024 18:43:01 -0700
In-Reply-To: <19598881-6347-4f8b-b9f9-825366e0e536@linux.dev>
References: <20240817015140.1039351-1-eddyz87@gmail.com>
	 <20240817015140.1039351-2-eddyz87@gmail.com>
	 <19598881-6347-4f8b-b9f9-825366e0e536@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-08-21 at 18:17 -0700, Yonghong Song wrote:
> On 8/16/24 6:51 PM, Eduard Zingerman wrote:
> > Attribute used by LLVM implementation of the feature had been changed
> > from no_caller_saved_registers to bpf_fastcall (see [1]).
> > This commit replaces references to nocsr by references to bpf_fastcall
> > to keep LLVM and Kernel parts in sync.
> >=20
> > [1] https://github.com/llvm/llvm-project/pull/101228
>=20
> Let us change this link to
>=20
>  =C2=A0 https://github.com/llvm/llvm-project/pull/105417

Sure, will do, thank you for the review.

[...]


