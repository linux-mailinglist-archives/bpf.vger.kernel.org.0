Return-Path: <bpf+bounces-30975-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5F58D53D1
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 22:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DDDFB238B7
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 20:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DADD14BFA5;
	Thu, 30 May 2024 20:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mBfF35T/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4829D7C6D5
	for <bpf@vger.kernel.org>; Thu, 30 May 2024 20:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717100600; cv=none; b=CL0R8z/cECOiwuv9CWfKt5beHLBYzK7EvDls4iVpxOdUjNQG7Z05aJXTUQV0b4V9tdbaubNCIeN1kmUlXQZb4d0GTdYplzPc98cbgwcTd4JChW11k0LUGweXzQ4LlG089dfLS2UvN5prNJsSZzgwrvAcR0rCvxV8S5qLWB8KKdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717100600; c=relaxed/simple;
	bh=YDHY0xHyshOhByLk5to1Hqve4a8I+4CcIsjNIMWtEVo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fNQjWpIuhxyzYsGdk71rgBKQdOmnXKrxp/jr/9c4NXV23nmjgBkxRQjSrSHs6kEJJrknzt54e120j5OiW7aHfYIsHtSTXhz4F1OV6PM2aB0ix1cZKJaoCHNTUp3yUtvgmeumQv30ehaDXgK/rkwJn75hk6gGABBdbX2aySi+0+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mBfF35T/; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3737f146db5so5256735ab.1
        for <bpf@vger.kernel.org>; Thu, 30 May 2024 13:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717100598; x=1717705398; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8CUFyPsDWx6CFEYPjJGM46zv5yfSEThnCh2p2pyi36U=;
        b=mBfF35T/vDgsjaGuBsowVXutQJ8cf5geEuMbPskrw1eM1/QTaxAJiLkpiTG/VLX6Wg
         9SzsvxZm+ZFygDwbPN7QIszmUVYpgeHiSPjtfndWsUDdCjEGvp38nUuzp+LehTTJY+fN
         F1kGrr/NUxMElOhe3EpyTlwRhxumztwknqxbr3YR0pV8vgJ6w8ESr4OrCLDlwnhmh5GK
         kRP+MuUABFlhn9X8ynKmY8jqs/S+40u61KNFTwkRG73ZxOZ5Kpl4PbnsQ8ZirlK68Bo8
         UrF9B6UPnWmJlJD1OB/+91oNCX1zFJHHEcvJ2GpPFaw1Xs/9CpYmmXI6+wn9gA0qzybH
         SlMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717100598; x=1717705398;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8CUFyPsDWx6CFEYPjJGM46zv5yfSEThnCh2p2pyi36U=;
        b=ip9opk8/1+bsLIFB5/Rid/PeVGYwrlelOT/arkFfgzzGi5N6xzyn3lYP3vUECwSGtk
         piu2jrqalajRLWegTBTPRrAX2Y9HxFUhUreWCSsp8c8sKrgUa8rLfFnntxvptXQLyokV
         VtYUh8erNuuWoPBFdQ43Mc8/U9e2lnRxDpus4pDoVDJDiR7zpqxgiEC/QKF58IuHlHue
         o0XSibqLI6A6d53/8kgl/clDqawWhDe18rUkwVO9aMhQOX7irE0r2cF3/ZRJLG1/k9fK
         80nkeH3ZSDruhKACqIvhNx1n/qg/Hw1Ib8NCripVSGqZlF5gYh3gYyvnLoyVa8SbPGG/
         bSzw==
X-Forwarded-Encrypted: i=1; AJvYcCWuETPa6he9enXAjQk2HICiglOANjGd5D8BMt+Ft1zkTO4HSC/dqx6CfLpb1ELdT2YfPSYYlzIFNs3Gqj3dfW8YM4a9
X-Gm-Message-State: AOJu0Yxoyc5UGmy7f2YsICXAgI/F6n5jxSoej5JbIMQBQKMAxzxhk1wC
	ePpFBaJPPDZTk9qwVCDwhYQ70SBCZCMFKgYa5HArw0KyDFj6NJE2
X-Google-Smtp-Source: AGHT+IFw4Ru5tDnTS/0g/TbVbViUT3+cqTWa64+NUeQFt7Dd66D53zxqk494ZLWVl+DU2niAH8/tFQ==
X-Received: by 2002:a05:6e02:13ae:b0:36c:4cb4:314d with SMTP id e9e14a558f8ab-3747dfc2937mr33216565ab.30.1717100598277;
        Thu, 30 May 2024 13:23:18 -0700 (PDT)
Received: from ?IPv6:2604:3d08:6979:1160::3424? ([2604:3d08:6979:1160::3424])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6c355cd88aesm136699a12.50.2024.05.30.13.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 13:23:17 -0700 (PDT)
Message-ID: <0b4ac618dcbac920ea2129548251426770ec7f9a.camel@gmail.com>
Subject: Re: [PATCH v5 bpf-next 2/9] selftests/bpf: test distilled base,
 split BTF generation
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, andrii@kernel.org,
 jolsa@kernel.org,  acme@redhat.com, quentin@isovalent.com
Cc: mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev,  song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com,  kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, houtao1@huawei.com,  bpf@vger.kernel.org,
 masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org
Date: Thu, 30 May 2024 13:23:16 -0700
In-Reply-To: <20240528122408.3154936-3-alan.maguire@oracle.com>
References: <20240528122408.3154936-1-alan.maguire@oracle.com>
	 <20240528122408.3154936-3-alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-05-28 at 13:24 +0100, Alan Maguire wrote:
> Test generation of split+distilled base BTF, ensuring that
>=20
> - named base BTF STRUCTs and UNIONs are represented as 0-vlen sized
>   STRUCT/UNIONs
> - named ENUM[64]s are represented as 0-vlen named ENUM[64]s
> - anonymous struct/unions are represented in full in split BTF
> - anonymous enums are represented in full in split BTF
> - types unreferenced from split BTF are not present in distilled
>   base BTF
>=20
> Also test that with vmlinux BTF and split BTF based upon it,
> we only represent needed base types referenced from split BTF
> in distilled base.
>=20
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

