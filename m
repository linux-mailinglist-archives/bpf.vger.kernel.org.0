Return-Path: <bpf+bounces-49884-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5106FA1DD85
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2025 21:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B041B16543F
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2025 20:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41D3198E81;
	Mon, 27 Jan 2025 20:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ioQmiJuk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BEF198857
	for <bpf@vger.kernel.org>; Mon, 27 Jan 2025 20:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738010705; cv=none; b=h7fvJck1A5Q5Sr21yuyn7ofHEmETNCOECmzBETqDKKF5trsTiqrQoLgFTHqtYDiFNzYj0yOTHUfeeGJbukCXiVf6NkTvbZPHOOTSsg9lP7DdaAlll6FrTZJtDxVqazwudKom3EohvY8CLNid3EZVAcqRM3Rf0m3jhKd1mPZZwvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738010705; c=relaxed/simple;
	bh=F+RheqY0XWtX64Hz/jspCq+Q1VTBvvJUKJ9vH/vOSwE=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NoKHwPqB7d4U3/Iw871KgdPQuFORraSlq4mqd0ltg3zcAe5zsBDGKd654F+VHhJELGHBge4uxMieEaBtEQrlqBnx97D9gaLAI1ab0mNmaxMy1xdF3ctaVZ7JFSzy8x08rXl43mndY3Xok1cB8SJCt7OadWwgR4kC45Gj35eWpuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ioQmiJuk; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2166360285dso83471995ad.1
        for <bpf@vger.kernel.org>; Mon, 27 Jan 2025 12:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738010703; x=1738615503; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F+RheqY0XWtX64Hz/jspCq+Q1VTBvvJUKJ9vH/vOSwE=;
        b=ioQmiJukGFgQ1Vg4TDaNBvLzCTwoeBlmsoJljb8Fx+GRLy+KNClNu9SYjo1n0tstjH
         eaLtac9C5XwNxrXFul8kYif8ygivY9DLBxT5b8RM1mc9MG/DmV+hJReBHPaeKqQwbMLY
         WTCftxy8/CbSc5OVukVmOQZolK9CJLfcGzD40sc4GOug5G/jzM9xCeYayxAcN9m+aQha
         oqQmeJMgQjZVA0+7PqcC4d5VNsNGzO17o3zM32909vE/oqAwfRN83jlVKBVseOgZ3Fih
         fXXg8gZV5/A3tL0HEqzgFxKAaxi96RtQCbvArmySCTnqfINOoob+5g9tcegFgjK8xzmR
         xdJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738010703; x=1738615503;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F+RheqY0XWtX64Hz/jspCq+Q1VTBvvJUKJ9vH/vOSwE=;
        b=w8chJtOD+ZQkIdgd+bQUMXV5X8tXEhrZAIH+ZBScxosC2Xf4jfVZh06C2YI2r5Zirj
         1IMOjtqK3MBt3x8XninotDmEu+y/X3QBUEnoG2lDdgD6WBBGpug1rkALBDKeym9pdMya
         etg4GXD4O4ym8UAQEzC1rrlEgfjelWBIbcJffumxi1mgjeBhuwKSuCaGxy+7AIGQQ9O6
         tl2BOmhE8JFbVyMH1z05Wfw6H3jzU6hOZRFgIQQG/A0I1Yx673qbdH91FM2lTdlqu5H6
         RyOgw2avCLxJDQ6x8XZAVgS/RQ1raqAqmu+S28PG7o4A/HC6fpYU/Ri58LDPTZnOU7nz
         IQ3A==
X-Forwarded-Encrypted: i=1; AJvYcCU39A0Tx/ZGaXfVobM+z6kUdd0wVOJq/UtIPkCSwrP0o+8SFnaoO4mFECCFgpi98bu6hEI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUSOAcV9m3SrYMFPp4KrFCKjUf/2OpMxnZcJOuDIcfY2pMuFMM
	twjhQTSjlXc/uwTJ57PxrZN3zRRV6YUn5/63CyF9+xsboaFlDVG9
X-Gm-Gg: ASbGnctK5TADjYsAXp/5kCQrJNMTnZ/WsHAZkam/i8WI+X55TSHWDI3DVN3DL7pcuye
	wbeqROWvHDexAeBM57k2WlVKwgWVX0XuGEG/CTfZXLBOjdjzbopBUYinCoK5tV7Kyg69fXoIDH9
	hTn/zdrR5KTZkXYIH7gKVLuribOIoXGW1CnQnUKb4kUp0Myn2Q/EA4yxAM+RsD0kr00smMoaaE2
	O9pg0RtckDKgJw/vX/jEhIcI7iExDrjhUsZynPCVZQ2dqGNq6c+DWvRCJC022lAafyp2hcYeFOH
	BQ==
X-Google-Smtp-Source: AGHT+IEdOrVEG/ZVAxe1QPXKSxdBA8H5I0xd02PK3BK+ZfYwS8t//BOH41YifPDz6QINDt4FnpQ3NQ==
X-Received: by 2002:a17:902:d501:b0:20c:9821:6998 with SMTP id d9443c01a7336-21c352c798emr730890535ad.10.1738010702955;
        Mon, 27 Jan 2025 12:45:02 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da3d9e1besm68114225ad.11.2025.01.27.12.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 12:45:02 -0800 (PST)
Message-ID: <84c9958a01420bc79290e959a1bf6f94463c57d1.camel@gmail.com>
Subject: Re: Vurnability in libbpf heap buffer attached with solution and
 Issue link
From: Eduard Zingerman <eddyz87@gmail.com>
To: shivam tiwari <shivam.tiwari00021@gmail.com>, bpf@vger.kernel.org
Date: Mon, 27 Jan 2025 12:44:57 -0800
In-Reply-To: <CALz0HOrGei1UTAkceBZqPjGkY=6pRhpjt=b63bhhgPjF7_E9Gg@mail.gmail.com>
References: 
	<CALz0HOrGei1UTAkceBZqPjGkY=6pRhpjt=b63bhhgPjF7_E9Gg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-01-24 at 13:25 +0530, shivam tiwari wrote:
> Fix Heap Buffer Overflow in btf_ext_parse_info Function
> This pull request addresses a heap-buffer-overflow vulnerability detected=
 in the btf_ext_parse_info function located in src/btf.c. The issue arises =
at line 3001, where an out-of-bounds memory access occurs, potentially lead=
ing to undefined behavior and memory corruption. This can happen if the fun=
ction accesses data that exceeds the allocated buffer size without sufficie=
nt bounds checking.
> Fix:
> =C2=A0* Added additional checks to ensure the buffer accesses remain with=
in bounds.
> =C2=A0* Improved memory validation to prevent overflows and ensure the in=
tegrity of the data being processed.
> This change mitigates the risk of a heap buffer overflow, improving the s=
afety of the code and ensuring that all memory accesses are within valid ra=
nges.
>=20
> For further details, refer to the issue link: OSS-Fuzz Issue 388905046=C2=
=A0https://issues.oss-fuzz.com/issues/388905046=C2=A0
> attached below updated code file=C2=A0
> If you have any specific resolution code or further details to include in=
 the PR, please let me know.

Hi Shivam,

Please take a look at kernel contribution guidlines:
https://www.kernel.org/doc/html/latest/process/submitting-patches.html
Please consider sending a patch in accordance to these guidelines.

