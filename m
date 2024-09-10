Return-Path: <bpf+bounces-39467-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23579973A73
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 16:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 564921C24775
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 14:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611BE196D81;
	Tue, 10 Sep 2024 14:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="IXC4uti4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DEB19580F
	for <bpf@vger.kernel.org>; Tue, 10 Sep 2024 14:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725979477; cv=none; b=JPxXDnQZX9OzQ7yxDTVJ0b1PPKZLGA81lk41ALAuO+/jAwYqR3172WjdB1xKfNLYXjeyjM1hbE22jBANyGZC7Oshi9NW/Pu4TueVBzyaKe6cndJEhUlH80rTfiE0NzFbcycX8wQTgPPRE5NW51baHzcK9S0c1bBF4/X8dEnn1B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725979477; c=relaxed/simple;
	bh=M+gbX08xWZHTyhMFgI1jc6jQrIG8wpnxP0pi1aThYRo=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=f9UlXDNfMoOhMTQS1CxvSGYsWTCvIPUsg8iviGVt4uf8mmBu29Xn/f17GXhMfkZkXjasByt3UsRwV1ks3aQtxfJCnRnO8Y19AoTeZ6KT9iwFtrcc6BstJ1W85Ce/hbMbwxy2eGqTPR3bpXhe+JNrmrg3miHIzoEYlib8X81ASkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=IXC4uti4; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-718d8d6af8fso3581355b3a.3
        for <bpf@vger.kernel.org>; Tue, 10 Sep 2024 07:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1725979476; x=1726584276; darn=vger.kernel.org;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=UL+Ho0G8dW9EgFhxZAvylDVs+oNzNpFxQWWf5vaHYfM=;
        b=IXC4uti4Ihdonj64MSiJp1yme+PMwfER6roojnfuvZmM559ZSs2fxA5g2Q2W/3khAW
         ztZ3adJHQlFYe4EzVF1mkzcX+N1/F6OwtF2FDVsCaJwB0kgFoGhvD71mJeyLMO8+wNbV
         I+lmVb2hTLLJlmnQ0awdeu8M1MZF3Wic9lhXsZDTPACyzRPsEtnoQKROR5mMeo8cnyvD
         4Bvas+cLxi5uZOiRsXvf7gxm2LbzectcVR70AeXsoD5IzAoQw7o31rSQHBG5OlEJ/dzz
         G8Hrj82uN2JsjOzi92Ag0sHY8tNviMq/9cGBThiCF0Uw+XbihH9k6fkam1pZ427fbIl3
         Pyxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725979476; x=1726584276;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UL+Ho0G8dW9EgFhxZAvylDVs+oNzNpFxQWWf5vaHYfM=;
        b=YZSHt9oM9C1CD8D4XcFUwWHAAWjXG0BFYcK8/yh8cVBKXyzSfVV5CTUVj48ZLBtZWd
         1WQU7hr+IqdqUcllwWqroFHeH090ZudVKc25L1xwpp+JY3a0CZVKFD+B48EBA/J2FIFl
         /yqEoD/jFjI1SpArmrikYV9ZSvtbYGimymdOV++rhE12DJlwI8ZQHrYaiNmOah05iY6i
         Ht8n/kBBpm/PYJ0jkytmrBgAXHpuoyoXEUihiuniyP+whETp3wSMrNOrcGwCndM8dgFa
         UlLpfsRzZSlHQRZhPt9RmL+hLbsl9buCav56YjcnfkUK1y4CxMExv5GX2HmfPKrX2n51
         N7VA==
X-Gm-Message-State: AOJu0YywjTMjWSv0VpG2YZyzbRTekaFBKwuvlSpNO0mhMS1hrtNuT/tk
	8+cOWX48c61YwmBAgDxqi1jiZnuY64QgMCKA9UnSmEWuz1Jba/Ws1sQOeIIY
X-Google-Smtp-Source: AGHT+IESBKhGyp0ly7ai9HHRxLSWGnyRKPL2tzRVtQikIcNHilg+ERKG9Wp5EHnKXRYr6eCaOe4EEw==
X-Received: by 2002:a05:6a21:168b:b0:1cf:2438:c9e3 with SMTP id adf61e73a8af0-1cf5e09689amr1296777637.16.1725979475673;
        Tue, 10 Sep 2024 07:44:35 -0700 (PDT)
Received: from ArmidaleLaptop (64-119-15-123.fiber.ric.network. [64.119.15.123])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71908fe2441sm1454627b3a.51.2024.09.10.07.44.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Sep 2024 07:44:35 -0700 (PDT)
From: Dave Thaler <dthaler1968@googlemail.com>
X-Google-Original-From: "Dave Thaler" <dthaler1968@gmail.com>
To: "'Yonghong Song'" <yonghong.song@linux.dev>,
	"'Alexei Starovoitov'" <alexei.starovoitov@gmail.com>,
	"'Zac Ecob'" <zacecob@protonmail.com>,
	"'Daniel Borkmann'" <daniel@iogearbox.net>
Cc: <bpf@vger.kernel.org>
References: <tPJLTEh7S_DxFEqAI2Ji5MBSoZVg7_G-Py2iaZpAaWtM961fFTWtsnlzwvTbzBzaUzwQAoNATXKUlt0LZOFgnDcIyKCswAnAGdUF3LBrhGQ=@protonmail.com> <CAADnVQ+o1jPQwxP9G9Xb=ZSEQDKKq1m1awpovKWdVRMNf8sgdg@mail.gmail.com> <1058c69c-3e2c-4c0b-b777-2b0460f443f9@linux.dev>
In-Reply-To: <1058c69c-3e2c-4c0b-b777-2b0460f443f9@linux.dev>
Subject: RE: Kernel oops caused by signed divide
Date: Tue, 10 Sep 2024 07:44:33 -0700
Message-ID: <18d101db038f$f3c2d400$db487c00$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQF9UZIBIzpsIoIccFtpL0UiWnR2xwFVGHnBAkqJ6fWy738PwA==
Content-Language: en-us

Yonghong Song wrote: 
[...]
> In verifier, we have
>    /* [R,W]x div 0 -> 0 */
>    /* [R,W]x mod 0 -> [R,W]x */
> 
> What the value for
>    Rx_a sdiv Rx_b -> ?
> where Rx_a = INT64_MIN and Rx_b = -1?
> 
> Should we just do
>    INT64_MIN sdiv -1 -> -1
> or some other values?

What happens for BPF_NEG INT64_MIN?

Dave


