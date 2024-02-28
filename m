Return-Path: <bpf+bounces-22960-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C490686BC42
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 00:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29EF91F26C9A
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 23:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB22F3FB92;
	Wed, 28 Feb 2024 23:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KAm2Rs8i"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CCF13D2E3
	for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 23:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709163479; cv=none; b=Pp4sudjvpw4MeCdBbyg4VG74vyXlJcNLiakSm09wF7j2SHAQ/M/7A5BU05HbFbnxvNCZWY8EFJ9hxwZzSjDI2ZnGoF9ckIDhZXW35oePacrHPI6UB1fBUXXPX3je87sgnxU+Q3ywtj29FXyMWjHPUDkA91fBxmKWPVdsOuc9+bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709163479; c=relaxed/simple;
	bh=EOz6ENAMDJ5kt6tLLJ4NhpG1zPH9LoLH0ViX+bHH4OA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JUBJi2fpo9tZv70wN9RmZhYuaH1VvDgNfR+C6A7W3AgJN+Z0chbLb9wK5Ku7LqQuQJI3IDsLZFT+IsHLYV+n1Jp2oW7OVNoFysFdYcSjii2PiFA3je6pMD+yZ82mVIqgddMI82Mk9pvVGUeRcvB7SNjHAL0mHsTE2or8U+7hrEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KAm2Rs8i; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-512f3e75391so191380e87.2
        for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 15:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709163476; x=1709768276; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EOz6ENAMDJ5kt6tLLJ4NhpG1zPH9LoLH0ViX+bHH4OA=;
        b=KAm2Rs8ilePFNWNI493diLwt5WxU2GkR3t9XLMwboamBoBrvIklzwS7FVTOM9e5YpU
         JcVODphcZNvJA8OpIRFXQaiXYnCBrYrTVAiVSka2BSXWhh3DIgFs15YQtpDhIRBEQQCE
         kebN00aQDfJLt7BGNCNfwwC9rXU6/8Yu/LGl+gzQwuntCEvZcFm9FL2inOlBEl6X5XW0
         zqEDYyYaQIl249I9U1BrC3SN4XYU4VF5IK2PzkEllWf/iApfOPSHSDSjQ9yz07yl8jCt
         r6HeH/JWEJHyTDxdh7D8Cso5WEqQqi6tfXMAESYa2V37fGvTdD4CO6gNCqDbQfiAGja7
         OWMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709163476; x=1709768276;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EOz6ENAMDJ5kt6tLLJ4NhpG1zPH9LoLH0ViX+bHH4OA=;
        b=oETue7267rYTVqAUbZKtHaqr1wQLOqZpCeJSWRb6z2+qg1XbceFPD4JqWazP2ChCT6
         +R9fCE1rCMMcjEHEeV5BEI1hlmOWfPS2eyvXDLdMX1zEgwIEiqqc2He37TqGifVuKyKT
         +rAhrtbzzirDRY/sNsjf9fIQD+cDRikEEkKY3xtHZdyj1h5fcEyzeYkh6D7PtsCbwrl0
         xGbijyUT0G4K5ZXKqid5CDZ3P78ogwlrwUbZFZpSRzbMkWxYlcYhootyS4+GFr8OIaOJ
         3KjvsX303avhgg7zsXH3pOt89Ax2yivX9aE0jI/S2sh50cBnxbEL1w/CKzxEQc6emRBe
         k9+g==
X-Forwarded-Encrypted: i=1; AJvYcCWuSZCMkfPEpMSNyTp4jrXPwXeJU+LHA3rDwfoLAMcdr8wetvoEj3sT1QOJwqdhbHHtsAybY4EFPaiET0R4fL16Etd7
X-Gm-Message-State: AOJu0YwLVae8SydNl9KL/rqMqxYYkVTIDPauz2sKrsUJzhPqvU3ZYlyT
	D0q8WiX7LT7tKOONPi/RQYY5+rrmD9/wg/IREbEX6OLFCenW27DI
X-Google-Smtp-Source: AGHT+IFoN12YxMGPjr+G6AtM4Tlt//rR/1XLzxSeErCh3JQXrFhmpBdaKtznuVoD9ePnVulD4uNJPg==
X-Received: by 2002:ac2:5a5c:0:b0:512:d877:df6f with SMTP id r28-20020ac25a5c000000b00512d877df6fmr266123lfn.2.1709163475692;
        Wed, 28 Feb 2024 15:37:55 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id y17-20020a056512045100b0051319dfe6d7sm30761lfk.75.2024.02.28.15.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 15:37:55 -0800 (PST)
Message-ID: <3526ee1f86c643aadc0c43b3a7571e18cd1924c0.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 1/8] libbpf: allow version suffixes
 (___smth) for struct_ops types
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: David Vernet <void@manifault.com>, bpf@vger.kernel.org, ast@kernel.org, 
 andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
 kernel-team@fb.com,  yonghong.song@linux.dev
Date: Thu, 29 Feb 2024 01:37:49 +0200
In-Reply-To: <CAEf4BzZ33ZuMFG_tmL-O0tKBx1GMSNY3uJyp425ZXpbywqiZ2g@mail.gmail.com>
References: <20240227204556.17524-1-eddyz87@gmail.com>
	 <20240227204556.17524-2-eddyz87@gmail.com>
	 <20240228162936.GA148327@maniforge>
	 <a369e0b2cd129cbfc8e33d2c61ed78265c21982d.camel@gmail.com>
	 <CAEf4BzZ33ZuMFG_tmL-O0tKBx1GMSNY3uJyp425ZXpbywqiZ2g@mail.gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-02-28 at 15:21 -0800, Andrii Nakryiko wrote:

[...]

> It would still be nice to avoid allocation even if for the sake of
> simplifying error handling. I think it's reasonable to have `char
> name[256]` on the stack and snprintf() into it. Let's keep it simple.

Ok
>=20

