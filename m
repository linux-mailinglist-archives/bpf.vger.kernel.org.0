Return-Path: <bpf+bounces-14593-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 334377E6D3F
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 16:21:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8A10B20C6F
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 15:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CD920318;
	Thu,  9 Nov 2023 15:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3K2/SNk"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D251CA9D
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 15:21:45 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F2E830DC
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 07:21:44 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-54366784377so1509182a12.3
        for <bpf@vger.kernel.org>; Thu, 09 Nov 2023 07:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699543303; x=1700148103; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MStOZcizJ9n1NP3gklUTp70sjxqh+EulIVoFdsGJl3I=;
        b=G3K2/SNkcJ40T3SvKaBnLigErv6t/5ejhbMPbgA/cP1razbWxNWF+kLKYLteEb0bnZ
         rveAECfoKSAN21odVhgq5xK8FkGlS41dWseXohZ1fHywYhw6GCn0chdGsT1KGRaABxDi
         9fbmbmUIHu797rODALU1EuKjvS/qFJLD4wvYnky6Ro5FcHWVyWgfx8qkgKF3bPNFO+4G
         Txcy2VXXwAKdUAdshviuNB12MDiL4gUr3CiTHoU7j4drtlKl2hBsP+z4dVDnfGafpQ4l
         PYNXnn/pi87LtBKHai3p5em88VO1NE2i0kRzlU+Nu3B2bRH/zYzyG6G18VVmGKeI49C7
         V6tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699543303; x=1700148103;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MStOZcizJ9n1NP3gklUTp70sjxqh+EulIVoFdsGJl3I=;
        b=ebv1d1RORuC9WYMZKrjDaXzERUULIxsnpRPZJctEioS7sTSFBICMSO0X5cHj9j3znH
         tOOwhE4RC2hpHnHsnYIP+CIgy1IKcCoUQyZ/IxW9e289EQPm6IEl5PDE2gyOIQAkXQJK
         CkNZgHYpqoUZgmhIydnWrJzrsv6lMnU5kaUrEDj6JrQzU2JGqFHqqMUkTZpegK6fTCo/
         geLEIW2Ok54tjJsO+MSJSr09SdJL22zjGNhr2ag7gvMB2gME6/xOZSbg7gLbDKpm1aaP
         Ma9l2IL2VGm4A56hVvBPMvXsf/x3MTUQyuUlpwry2rJXgJ1t/SlZ/e7x6gSIaUyxE0sn
         gHOQ==
X-Gm-Message-State: AOJu0Yxk3t+TSS/0tq5Zgcu3AkdZdt6c2XqWTzmbMZ2LN5WaGdy9dKxS
	ncNp212LnT21q4XcfAs5IL1mV5oANnI=
X-Google-Smtp-Source: AGHT+IE6ODgjYIle27hQQ6V/6KUyiIrnUW4/CDj14VpL1GDNqRngiP4jCXAHXGHrz2Ubh76ICK28LQ==
X-Received: by 2002:a17:907:c27:b0:9e2:a5e7:5fea with SMTP id ga39-20020a1709070c2700b009e2a5e75feamr5381041ejc.18.1699543302622;
        Thu, 09 Nov 2023 07:21:42 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id f4-20020a170906c08400b0098ce63e36e9sm2716667ejz.16.2023.11.09.07.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 07:21:41 -0800 (PST)
Message-ID: <38b2c899104ac9cb7009351531787a7691748bee.camel@gmail.com>
Subject: Re: [PATCH bpf-next 7/7] bpf: track aligned STACK_ZERO cases as
 imprecise spilled registers
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com
Date: Thu, 09 Nov 2023 17:21:40 +0200
In-Reply-To: <20231031050324.1107444-8-andrii@kernel.org>
References: <20231031050324.1107444-1-andrii@kernel.org>
	 <20231031050324.1107444-8-andrii@kernel.org>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2023-10-30 at 22:03 -0700, Andrii Nakryiko wrote:
> track aligned STACK_ZERO cases as imprecise spilled registers

Great improvement.
Could you please add a test case?

Acked-by: Eduard Zingerman <eddyz87@gmail.com>



