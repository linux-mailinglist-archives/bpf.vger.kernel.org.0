Return-Path: <bpf+bounces-40870-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B5B98F896
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 23:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4D36B22CE6
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 21:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDAD1B85FB;
	Thu,  3 Oct 2024 21:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HEX89CRG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E892B1B85FF
	for <bpf@vger.kernel.org>; Thu,  3 Oct 2024 21:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727989650; cv=none; b=aAwN614u3E37ItqHe2FNt1vtGgELOYD+LnYCwl37K2wx1m5PFX4s3F3XyHJgO+lyoEk6V7aZ9OR0QnCqW3jllNdXaZmo6xThV6k0+uoZGpRAyoLtD21rk/C3JmbfbUqAymARCjdSVbQyqlQ9m8O8o6EOH0U8PpfvtTbpQbf+gi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727989650; c=relaxed/simple;
	bh=Cmj+QecxmEBoTRkbNe/3bIS38G+dXm1YlSJZOGla7fE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L9lNkhDYeM2ZMid9FF+5BGE+qg3LEWC56j4frW96C/AegdmxwF1IPaLwVH2V4O28f9yoJpktuYkoNE/8ZlNOpp33jp4nvTr7VFhKsJb78X4KJxpwO/asANY/iwDzaWl/+XUyN/OjK2tvMYD/tUDMYMhjtdTK1V1uQ/m2H02cJOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HEX89CRG; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-718816be6cbso1255465b3a.1
        for <bpf@vger.kernel.org>; Thu, 03 Oct 2024 14:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727989648; x=1728594448; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Cmj+QecxmEBoTRkbNe/3bIS38G+dXm1YlSJZOGla7fE=;
        b=HEX89CRGzE6HOr4SFR9tI+eldFB2HeU7zc2z/A+DJkw3Ft+307gMNUlFxNTqSYu956
         R6nJ0iN8f+cXcft9uqycFTHfZPDoVR8P87mjb6+h7raC5uBaRbyDVh53mbm1ZEGhdqNG
         LNdkVzITi+XYZ5Fjp7zTYnYYvYXexHB9GDyXuWkg/83nznCXGgMc/uen/R40RkKeRxdV
         D33ReE3dBCUuo8fozsIo2z0hVrDFnTBnVP8qVsbYEa+q4xvkF2kwRXx22HtayQu4GNXZ
         3Ad4yIetj7Kemuwp6CLMJDfwAtYB8i12tCZvKOiEYlh4ZHs97eUNRnHI2ckeBIwHhA0U
         cSwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727989648; x=1728594448;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cmj+QecxmEBoTRkbNe/3bIS38G+dXm1YlSJZOGla7fE=;
        b=pb1Oh4o0SeYLMz+TqAeo5lTtJIQ+seTOGHOvBTl46r47b13/jwDxQryQwKO+gPH2Aj
         UuwL27uiWNYAoayp7sySxDmt7Armw/C7p4iWiIpMZdo4EykorOBPqCg+Fm0+3Nt7of3J
         ivyiRZcx2oFO2hblsD93l2DjEpftGXkrPMUqzRdTG2xnqef7lBxrALmgVDiLxa8li/jA
         yiBK29o7yTmEda8FWF+68iKhu18irOTcRhzpi9elY9OXjFQs3GBT+PytNXWKSBykeJIT
         95nT/tm+4hkWKGOQqF3vqiThaDEhydcI3DpdimlEILqyuUBcxebe7rL6fXu5m7YLsgd9
         2f/A==
X-Forwarded-Encrypted: i=1; AJvYcCWvu9jsHjP9ZeXfwN1GarwCJKgpimNJLYnrtkNNJjcaDoMgrmWWEcCNpM14xeZhtUbGvmM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQujjFAhBPtmr2+Wh5RKbqJC4edag4y/UtCH41edrEcuYnBDsp
	BbF01/ZPOOg9RTmTcLe71QpP8y7+tMmIRQiITjJxpeEEcoQjsP40
X-Google-Smtp-Source: AGHT+IHjnj3ZAnlxMKHxpS1aXLiry3+RzTpiNCkyRfeegkxsMfQAWN16bWs9LoR0wvmvLV0pNVlmvA==
X-Received: by 2002:a05:6a00:3a14:b0:718:d5e5:2661 with SMTP id d2e1a72fcca58-71de22e83a6mr749254b3a.0.1727989648233;
        Thu, 03 Oct 2024 14:07:28 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71dd9e0809bsm1805983b3a.201.2024.10.03.14.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 14:07:27 -0700 (PDT)
Message-ID: <e5ef86e9bed0f3e1f4a7ad81301e0fe0a0063bb2.camel@gmail.com>
Subject: Re: [PATCH bpf] selftests/bpf: fix backtrace printing for selftests
 crashes
From: Eduard Zingerman <eddyz87@gmail.com>
To: Tony Ambardar <tony.ambardar@gmail.com>
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	kernel-team@fb.com, yonghong.song@linux.dev, bpf@vger.kernel.org, Alexei
 Starovoitov <ast@kernel.org>
Date: Thu, 03 Oct 2024 14:07:23 -0700
In-Reply-To: <20241003210307.3847907-1-eddyz87@gmail.com>
References: <20241003210307.3847907-1-eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-10-03 at 14:03 -0700, Eduard Zingerman wrote:

[...]

> Resolve this by hiding stub definitions behind __GLIBC__ macro check
> instead of using "weak" attribute.
>=20
> Fixes: c9a83e76b5a9 ("selftests/bpf: Fix compile if backtrace support mis=
sing in libc")

Hi Tony,

could you please double-check if your musl setup behaves as expected
after these changes?

Thanks,
Eduard


