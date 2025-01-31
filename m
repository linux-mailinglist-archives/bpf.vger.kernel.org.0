Return-Path: <bpf+bounces-50182-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E09D9A23906
	for <lists+bpf@lfdr.de>; Fri, 31 Jan 2025 03:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D960164012
	for <lists+bpf@lfdr.de>; Fri, 31 Jan 2025 02:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7015043AB9;
	Fri, 31 Jan 2025 02:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CzZZgbnF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58D511CA0
	for <bpf@vger.kernel.org>; Fri, 31 Jan 2025 02:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738292150; cv=none; b=cnI4YBkCKfCLTSFQY6J0VqG0VWx6myPOhvd2vdBCsWPBF4u5FoxGh6m/cNTQ4IYFycVfxAG4LZxZddJiEehRvhVxOVP4K57nXdHaI5MWNjB8UBBlnMRns6+4odAR85IHjQDG/ZWu6Pz03b6tYhm2MAs3faNqlvPskV3dMSUdNag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738292150; c=relaxed/simple;
	bh=nSnY8a8wVK/PJ1e5N7at5SRIyBNetDDP3RmhMQ2A2BY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A6yyS5BjY9hKplhFnbXKpWW8rBXy/yaNuLO1AEbLTLFwT+WHWDgvv05jztG7uY4u2rzpXLKsHPb6D1R5Ktq5zQQzIOVbm3Z2YKnHTkDkHTKiVZnXOdGonhZoaBoofJbXZJ5jFQualrv5Gk0XAyC/Wavq+5YWiVO6opcYkgNdoZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CzZZgbnF; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21631789fcdso35390455ad.1
        for <bpf@vger.kernel.org>; Thu, 30 Jan 2025 18:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738292148; x=1738896948; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=74ZKjQBc5GTWKk7/1cAJiPEKeqaGIF2LKqNgzGBXVe8=;
        b=CzZZgbnFis9S2gII4NdJ25jnICR5YNqE9mom4f2aJl+UubFAPsb4TsNVvS2Xw63wiy
         2cUm+xxhlDkNoQ9GwouZef+wPs/LsNIMV2XrR0ukQUicz3bbZ6MtX/jKqPFo0fVc2q4t
         JTjY1JQHLWEoVyf4U/NlqCmuiRNUZVsyiNrv8MoDUkT4KABqlmrlA2jsJnRz6sFJN6PA
         0yZzUWdOq6Mtk0POaHAB3b5ixpzBRU26DXL45IZ+25AodDoPHiru2TLtPaX4A7syFYUI
         S+0rlsFmE9zDJ/4ALrNEGv9GoWSsFQZiyb/4FQdvnfA6sZsPxXRbrh44Qo1vV+qmHqjR
         PmBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738292148; x=1738896948;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=74ZKjQBc5GTWKk7/1cAJiPEKeqaGIF2LKqNgzGBXVe8=;
        b=TehhFCzi3Q4+iaQ56O1KU3xAwog4bOXLyAsYhbgf7Bi1UO25vwZAOHvD3KxL+TAYtU
         ryK8nXaaxMPvtK85kSKQcrSSMLqFf/2ToV3G7GilUVr6zMrbnSPWenCMYoWQT5kGyME3
         WvRtqbY8K3kSxPSUWKwzBjGj0PHgEJwzoB26wASm9oadmHr4xn2oHNNu2qONbuUVZ5HN
         j+lFQpNWyLLYJmccRUVzbxR2mF7fo40RmDEvg/+K43GsVZEe/xjmDAnTc+a8LG1ke/DS
         RrRRzJGKaLraQbcVxl1Vrn2Uo2d36IBmnkJBqpdybDXKUFJ19cxoEc6U7QSK7v/uM+gW
         EPyQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6OpcQmCtkZT6dCniJ68VO8Dg3fctiM+oQvHWi0RHzRNP5L3sQOU+el0ylQWqfpwH9swc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx83AGHlbcuEVewec2PDFG1qIch5CsjDR+BLPFGmiCnPqd96ACQ
	+NQOb036TvCiWlXVf4C2Wpi7CWlsKYiieMTPhh9hQc9eMLPIgpUU
X-Gm-Gg: ASbGncuT72ycPr1koPxmoqj0fPD+MAqSBlU6h69XVJRHnnz6DPoTU1xSDb9kTenyBeh
	FAHORAHcORK+rTmSmtKiVOQuKL0EXRTiptc/S/84Bx8uZNqrX7q9aFTHwEaDjCBkaRSshaJ6VY3
	hOR25jon0VivB8shObLoQJu3Yh3ydj3m1m1Djktf0UscBEx++5ghpmuD+eeutoVbxu2KZanEonY
	vTKF0JOk0f85UPsy0PXrkIkq2WfIqCiDcISQL1gAPZWGo1k2Wlb6XBtZUrKvStYKXtYEuWGpgM/
	Omsihp8AJ2UQ
X-Google-Smtp-Source: AGHT+IF93h9s0AIv9vGdD4aRWOMMfOLELDMN+V5E0iwHa4RJmK48cX7N8gzJO4bPqoKkz94MEGkJ9w==
X-Received: by 2002:a05:6a20:2daa:b0:1e1:a48f:1212 with SMTP id adf61e73a8af0-1ed872d98f8mr7499588637.4.1738292147736;
        Thu, 30 Jan 2025 18:55:47 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe631bfe7sm2211976b3a.33.2025.01.30.18.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2025 18:55:47 -0800 (PST)
Message-ID: <18d4d2c22ae66601fee7a604c1b0c8185ce9f430.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 5/6] bpf: allow kind_flag for BTF type and
 decl tags
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, bpf@vger.kernel.org
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, mykolal@fb.com,
 	jose.marchesi@oracle.com
Date: Thu, 30 Jan 2025 18:55:42 -0800
In-Reply-To: <20250130201239.1429648-6-ihor.solodrai@linux.dev>
References: <20250130201239.1429648-1-ihor.solodrai@linux.dev>
	 <20250130201239.1429648-6-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-01-30 at 12:12 -0800, Ihor Solodrai wrote:
> BTF type tags and decl tags now may have info->kflag set to 1,
> changing the semantics of the tag.
>=20
> Change BTF verification to permit BTF that makes use of this feature:
>   * remove kflag check in btf_decl_tag_check_meta(), as both values
>     are valid
>   * allow kflag to be set for BTF_KIND_TYPE_TAG type in
>     btf_ref_type_check_meta()
>=20
> Make sure kind_flag is NOT set when checking for specific BTF tags,
> such as "kptr", "user" etc.
>=20
> Modify a selftest checking for kflag in decl_tag accordingly.
>=20
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---

Double checked all places where btf_type_is_type_tag() and
btf_type_kflag() are used. The changes look correct.

btf_type_is_type_tag() is used in 7 places, in 4 such places it is
used in conjunction with !btf_type_kflag(t). Not sure if embedding
btf_type_kflag(t) in btf_type_is_type_tag() makes sense.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]


