Return-Path: <bpf+bounces-44307-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5599C121F
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 00:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27A2A283E1A
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 23:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0618217915;
	Thu,  7 Nov 2024 23:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZl1eceu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C189E1EC017
	for <bpf@vger.kernel.org>; Thu,  7 Nov 2024 23:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731020412; cv=none; b=Ffd7vplbkO7YFhYnAo4QvpSQHjElWGbnrVGvphzpj+j0MiakA9ZXMZnAXqNeRZo1rBDAjid1yOu0AymT7MuvVHTVRKGOXrwckEC7/jvBwliFpIKUk8Gmcq+sSTxpuRb4fiNEHgAifiyz6B2gr7fUw018m0L0KkyYj5jss8KzFpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731020412; c=relaxed/simple;
	bh=AcrL1q1hRWn/i7qFa78DvgwKJCkuqPBZc0qPKZxVP4k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=axOOZix82pdbYxUwogtjhA1Us1S1YBCW7BfGmxShH2zfYJpsiX20bVMvRx+lItuClBGtZcEgJyel8JNuVaPUgdwWw5+bPHX5nmXd1aABnAtUGYnXUqZp5oaiBEQ5p7pYF8kQJK8JsTVEWhVc3DkITtxIO/wYjblQvzw0Eg6ooSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PZl1eceu; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2951f3af3ceso1054540fac.1
        for <bpf@vger.kernel.org>; Thu, 07 Nov 2024 15:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731020410; x=1731625210; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AcrL1q1hRWn/i7qFa78DvgwKJCkuqPBZc0qPKZxVP4k=;
        b=PZl1eceuxeWB0lauZ9yqgKk4hgrCcE7XijE/P1Xzac+w9w4C07EPF6MpORGnjO6hlz
         P5as4f9ihsMVlz6O0xZcD/UuQoJxdsLcu60qfXqKhtDkhMRnFwJMJaMQqA9DNjacdRhU
         Hz1zG33OTQbqeh+Ukqsuqj2wXohHh8mgzj4e7kxk9sAvdj/VV6DJw1axVwoppYnzfFny
         NX0q+rrrOSke7JF6RKDUaS01B+ph0s2PXq/iUsed3lfYrdf+X5INhL7kwoulXaiWmcRc
         odnfCL6Z8/RdNBup35863VTEonV67NxH26u7x0+fRozgQPFN4J1Vz/4tBc15rm11cYRl
         wGQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731020410; x=1731625210;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AcrL1q1hRWn/i7qFa78DvgwKJCkuqPBZc0qPKZxVP4k=;
        b=cYR34HzuRnvAlWKziGiCeD16KJ7ThG1epGj47l25w9kKs22sdATz0UHC214RZKcJpc
         dKb13shXim25lhyrHxW3iEVC4NYpM/90kt3M4HlJ9lwkN+Rlf0yW4484fO3dkLKGXLzK
         6Vp+HwRySrJlg9UJURGimxHqZ36Xl6Kh5K0R/Cng7oF5bcms0KfbGbVsMh6bF8qi0uA5
         rVV1sI69JBRppwllElRugQ4bXnNZSCcgLvwwGQqcf7V08xOEnqmc5Ert88F1FJG5MR2q
         BqLUWb9MszxJD9zcXGPmq9bFubwctK1mblR9xLAQJd4tOKaH/ieKoslU5FvcGxrPa0l0
         maDw==
X-Forwarded-Encrypted: i=1; AJvYcCXKPJAjfC3c5YlTKXAOhnsCAJGkIPxDhjhxebx+QiODzpU/ZFxjVc6cAN0XvnsHdEE5OMk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOr5jkj9S60AO+nfikBbbmbEDbuKV/8kn0bWvMtDmHF3C9xoMI
	pov3TAwEbnosfCf7kmo+NNW6763VZXg1dnCR53U7vrrUzLaX6J2f
X-Google-Smtp-Source: AGHT+IGBJcuivK2oMG0f3sOx9WSFQ4/lBsqCyMSK4tazsK+hPLRZPI7FfgSy94c49ehDkmkqiFna/A==
X-Received: by 2002:a05:6871:1cd:b0:277:d8ee:6dda with SMTP id 586e51a60fabf-2956011f91amr672127fac.23.1731020408283;
        Thu, 07 Nov 2024 15:00:08 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f41f5e7f3fsm2074298a12.46.2024.11.07.15.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 15:00:07 -0800 (PST)
Message-ID: <93d45a0224f3916ea0f8703df3565b94cfea5e55.camel@gmail.com>
Subject: Re: [RFC bpf-next 10/11] selftests/bpf: tests to verify handling of
 inlined kfuncs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>, bpf@vger.kernel.org, 
	ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	kernel-team@fb.com, yonghong.song@linux.dev, memxor@gmail.com
Date: Thu, 07 Nov 2024 15:00:02 -0800
In-Reply-To: <4e809347-4b5e-4e6c-8c60-8eea19292165@quicinc.com>
References: <20241107175040.1659341-1-eddyz87@gmail.com>
	 <20241107175040.1659341-11-eddyz87@gmail.com>
	 <ff32dfb9-5fd5-4d43-9a8b-f640da32e000@quicinc.com>
	 <5a82fa4bcb3c342a8bb305945baed072d4b89a92.camel@gmail.com>
	 <4e809347-4b5e-4e6c-8c60-8eea19292165@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-11-07 at 14:19 -0800, Jeff Johnson wrote:

[...]

> Does bpf_testmod.c already have a MODULE_LICENSE(). If so, then I'd drop =
the
> extra one in test_inlinable_kfuncs.c.

It does, will drop the license line from test_inlinable_kfuncs.c.

> My reviews on this subject are triggered by the lore search pattern:
> MODULE_LICENSE AND NOT MODULE_DESCRIPTION
>=20
> Since it is expected that the two should appear together.

Understood, thank you for explaining.


