Return-Path: <bpf+bounces-44305-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A65579C1182
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 23:08:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D84741C21B5A
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 22:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB39A2185A8;
	Thu,  7 Nov 2024 22:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kbBE/bHD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28998217F2B
	for <bpf@vger.kernel.org>; Thu,  7 Nov 2024 22:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731017299; cv=none; b=jQ/WVFWsRhypESIhYs4b4enXQbyNOa2wxMcygut6TECgP0DWVjZlqy49G5t5Fevh8+qpGwUH3YtskemVT8UpcgNVEifEf8Tl2qduCuxdmqdj66Odj+BlZ049/0kohppZZbNoOFakFG9JwMA/3iQwhLdn4k6hIFGFa8v6xbCptxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731017299; c=relaxed/simple;
	bh=RSC7gFebVXIMFuxjfawmqQY41D2heE7vKMlCHSJ6rV0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rUlVJgpX+idwNCu18fm9wu9VvB6eVxrjeLDDn0Ir00hXn/4VzNA+618/rAI5bCmUCWx0lOuX907q7Y6FkmTM7w7FIsWGj+dQSX4gIjNO+EbliUMPJr5I4m3TvLTwJtMymYVy5WUruAYc3a1fFasHm4ouh8IJsW9m72M4gFjSLLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kbBE/bHD; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3e602a73ba1so998552b6e.2
        for <bpf@vger.kernel.org>; Thu, 07 Nov 2024 14:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731017296; x=1731622096; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RSC7gFebVXIMFuxjfawmqQY41D2heE7vKMlCHSJ6rV0=;
        b=kbBE/bHD/LrqFVvNoiBS8UXyLK405Hf96CczAHTdxDyuLtg8v5aXB9A/ePJhvxfWy5
         7hEnbQtgtPAl1iy7h7Qt88EwZ6GbSyUaqez60jPDonQi0JroYHyjt+4fUQZN3HwlkSyE
         DCe9VuaZ7tEHn2GNwPr4R8Bie/1Rxa/1AwruBZe1S34eZ/wGsCCZPGZQaEqPi+NzURdJ
         5Yc0YT2WkgtLB7sIacFOUPPjAG3PfhRytgy9/xfR2rTKYESWwlwfGWX4jvw5lRGfmTYE
         jiQQUuWR8VzlT1AsCtEVpp40oYQZy0z7JhaEkwvNNTQYfdXtZqgfNJ+t2TFaPJCMLxd8
         /hqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731017296; x=1731622096;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RSC7gFebVXIMFuxjfawmqQY41D2heE7vKMlCHSJ6rV0=;
        b=EUWvr2JcOnJPfGYanlfLlfAyVXa9RO6KtH9Sg5VctKh2EjqSStTkx9fJqHaVCvKHcH
         Ngy5hvK7zbofq2sxP4TIeJi741Fyouwh9YNGPN711+wlOyRNvvMaHDO7VNQbdKa2mEd5
         YkBCEDMsYOz2YF5HBe9ky6WpmdmF10Ry6drbBlb4JfZvvIzIoZVotnPERvOCkBw9pjb8
         n8Nu0NGprwH5hTwzv58eQJQ9bf/6WcJP/uf9AD2ehTSICxSMFEv9Xh1AQ8nDlLTDASY8
         i7pkmablDUp5Kh6SUcRxKHZZWILrbD1yYRXvE1iOpUVA5vAL1bhrbQFg2xYgyWtBRuJD
         /H7w==
X-Forwarded-Encrypted: i=1; AJvYcCW3/OCqslR5Y8CqT0XGwQRG1D9WNCndjC67e7yTjI2tasDGrMDDVgLZLnK1eP6cTVVsx4I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwopE2NMrtTA/ZZZTeh6/6VrxudiBgJ7EFmiNl588l3GupYrgOE
	PO59rgRPlCQ3ZRlaReHoe/2Vxv671kY3oeSCUu5SHCY+PHotk3BN
X-Google-Smtp-Source: AGHT+IGqmjJ6c2vqijUa+e1E1Tsmns/eoDsxtoEnJZDLr+ijqET4OI+p/4gbXbs5QHUzmIZoGzihbw==
X-Received: by 2002:a05:6808:1921:b0:3e6:5134:be25 with SMTP id 5614622812f47-3e7946e10admr951468b6e.26.1731017296117;
        Thu, 07 Nov 2024 14:08:16 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f41f65b5afsm2023876a12.76.2024.11.07.14.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 14:08:15 -0800 (PST)
Message-ID: <5a82fa4bcb3c342a8bb305945baed072d4b89a92.camel@gmail.com>
Subject: Re: [RFC bpf-next 10/11] selftests/bpf: tests to verify handling of
 inlined kfuncs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>, bpf@vger.kernel.org, 
	ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	kernel-team@fb.com, yonghong.song@linux.dev, memxor@gmail.com
Date: Thu, 07 Nov 2024 14:08:10 -0800
In-Reply-To: <ff32dfb9-5fd5-4d43-9a8b-f640da32e000@quicinc.com>
References: <20241107175040.1659341-1-eddyz87@gmail.com>
	 <20241107175040.1659341-11-eddyz87@gmail.com>
	 <ff32dfb9-5fd5-4d43-9a8b-f640da32e000@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-11-07 at 14:04 -0800, Jeff Johnson wrote:

[...]

> Since commit 1fffe7a34c89 ("script: modpost: emit a warning when the
> description is missing"), a module without a MODULE_DESCRIPTION() will
> result in a warning when built with make W=3D1. Not sure if this is
> applicable to your new module, but if so, please add the missing
> MODULE_DESCRIPTION().
>=20

Hi Jeff,

Thank you for the heads-up.
The MODULE_DESCRIPTION is already present in the bpf_testmod.c
(this file is renamed in the RFC, but remains as a part of the module).


