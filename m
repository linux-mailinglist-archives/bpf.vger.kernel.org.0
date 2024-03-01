Return-Path: <bpf+bounces-23176-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0587F86E862
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 19:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 314451C238A9
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 18:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4AE920DC5;
	Fri,  1 Mar 2024 18:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ieesKatu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82804C9C
	for <bpf@vger.kernel.org>; Fri,  1 Mar 2024 18:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709317651; cv=none; b=mTtUBBfLMGz4VM+wuFDdi2lx/ET5v+bcZ82Jm0tF+8G7akJazE4FtE+E2jWpevDevEREPJMCQSn789LONzTD4HVFnVJeiIKdxz08XtXcSgDvK4C6guAIbswKqPtdlPz88ZcA/C3kJkM9S71ylQjV6/NEsOvdyr5UDIuHo5zuS4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709317651; c=relaxed/simple;
	bh=NgTKQwV9igaGr23xHt4uGPRdYvra1AcsF6AAFaCt2xQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dneOJIYdfk0MjIkD4nDV4UrGfa8dgy2PqVD5hm2eWf33cXQrUMxt8vG0oWeCkrt8GH2ZcUOZwn2gwTqeNnDXOQhWNcTQWR8l5Y+xH6Q3HkNHPaCzBa/EkbzqmFLV654wuQzdXvqTT1nmCOigS6YU5+aDRWXshcMOww+036N47Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ieesKatu; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33e162b1b71so1325898f8f.1
        for <bpf@vger.kernel.org>; Fri, 01 Mar 2024 10:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709317648; x=1709922448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NgTKQwV9igaGr23xHt4uGPRdYvra1AcsF6AAFaCt2xQ=;
        b=ieesKatu0z9V3wv9Zp46e9IN5N/+NSQ8XqjCGIoXoU1mf1/1aNhujO5Ang6DmrwCQY
         vdSN1Lmk0j9vjDB11Git8JdSQWpRtkDx6isWtgSsJLbQZsFbwDvN9lGoiSPgJnfOTHcb
         aS1Ix1WxufkYCXPxg8obHJrj7pWE/RmAZJcu84Tfjwo/cBEVBcQzJu7SL7vkJD4/wppd
         Fk6vxl/fi18ql6iZCbhK+bAKoFGHhJPlXZ6s87rvprQxKaSXCQ3Jc61mqHNomDfPSenV
         GTtcW0OSlfHnRMFu/idSx5k6Yx2tfZB4vjzbXew5tBnT6flUZXfWpm0yUn7D8MU7e3cH
         3Tjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709317648; x=1709922448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NgTKQwV9igaGr23xHt4uGPRdYvra1AcsF6AAFaCt2xQ=;
        b=S39ZRKJfcOVHMVNl/cM+ORpHYqgzuPdAVvBBDaIxcCX8ibKCwsxPeY4wWUMxo5nLYs
         z5FJyijhE3HXFMfUZZ7BWrh1l0zQSY9a0MXHCOdjX32vn9IlETL24AEOE64FYCMubwvh
         UlQ2czAFaqZzue+5K5jzN8NFenIfbUvm58S1cFgosPxp021ICek9WWWUf8aTsVybLpXX
         bzxJYbVESsGFg1pTHTqtmVADHoqGp3giqRlxSmbX0HWXcMq39IprkPxUjUjqWwW9i6MV
         yzcdnqSUv2NZYGOI8lRI8QiJE/w2OiU4v6S5GP/lweHEYCo9/BrYz4nIydpUl2ix2W68
         IFVg==
X-Forwarded-Encrypted: i=1; AJvYcCWQTjCNW/I465ewxf5vMoF5Ti/94ozniTJmntfljuP/Tvlnijuuf1e7+BRGOVTAKSNveRAbhvkl2QdLL7TP4nVhKmVz
X-Gm-Message-State: AOJu0YwNpxrKMxdwUsZSUpYE03FzgPLCx723a5Ld9f00Y9hFbN/BHGCe
	JXWuj79aw4Ukoju7EwumlWXvXuMUFWKmfpSXCQbFAkKy9M7KJVt4vUP2YhZiT0GM3xRlAEuqHoq
	Bla8JFMSuiVdywrf99RlM72uhkvQ=
X-Google-Smtp-Source: AGHT+IElrYL3B862YBmWkrR61aMaMpMNEemMOliyrEzB7INMZ6iniR5pQ8gECQnNmCElwU6hNVMHS7fPDCKKUxQ+OCc=
X-Received: by 2002:adf:fc8e:0:b0:33d:2f2f:b135 with SMTP id
 g14-20020adffc8e000000b0033d2f2fb135mr1859403wrr.46.1709317648105; Fri, 01
 Mar 2024 10:27:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202403010423.0vNdUDBW-lkp@intel.com> <CAFVMQ6QYvHfc_=cpOddWgoWDTRt3GHG5+LLB3NoFFRRiCMWDLw@mail.gmail.com>
 <73e0fa99-7dff-4cb9-bfed-fd3368e54542@gmail.com>
In-Reply-To: <73e0fa99-7dff-4cb9-bfed-fd3368e54542@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 1 Mar 2024 10:27:16 -0800
Message-ID: <CAADnVQJUZZXusOS3h9fnUUoFQ7=o5iJDDANaUqNBheuhHrUXeg@mail.gmail.com>
Subject: Re: [linux-next:master 5519/11156] kernel/bpf/bpf_struct_ops.c:247:16:
 warning: bitwise operation between different enumeration types ('enum
 bpf_type_flag' and 'enum bpf_reg_type')
To: Kui-Feng Lee <sinquersw@gmail.com>
Cc: Thinker Li <thinker.li@gmail.com>, kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev, 
	Linux Memory Management List <linux-mm@kvack.org>, Martin KaFai Lau <martin.lau@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 10:26=E2=80=AFAM Kui-Feng Lee <sinquersw@gmail.com> =
wrote:
>
> For BPF,
>
> We have a lot of code mixing bpf_type_flag and bpf_reg_type in bpf.
> They cause the warning messages described in the message following.
> Do we want to fix them all, or keep them as they are?
>
> They can be fixed by merging two enum types or casting here and there if
> we want. Any other idea?

We probably should add -Wno-enum-enum-conversion to kernel/bpf/Makefile ins=
tead.

