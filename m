Return-Path: <bpf+bounces-51838-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF67A39F50
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 15:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F63B17733B
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 14:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49A126A0CA;
	Tue, 18 Feb 2025 14:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hwjejwI+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E71269D1B;
	Tue, 18 Feb 2025 14:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739888716; cv=none; b=KscCqhYZ4Xw7SCYVpOoKI1iIIa/4kNAeO9VrwCnQTLyflWSpDzAJgGmcD4480n+r7/rZTXmt6Uk9nb8r4PeYOjcyH4295zgIaEnbpg0TO6BOmJcYV/JGawLsjkcFyH85oPCCsyspf46qfcZ1Mx9O+Qfr4mJw/RXtPssnNzGNHWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739888716; c=relaxed/simple;
	bh=lxwLjCBJajtWzaRsy8pRrf11hv7+sqzFijfOOsIMNiU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=lY1mHeZQ/4gREiWQCmcBm7Nzc8ObAbNWhyR5WnxFF5VeCqHUSZ5FxtfP3KELZv1ngexv3d3kDEA7pb4yeY+tjb2vqSh1d5qUVFJOiABlBe8TeviVvSvigm1z+GpSM/GQoRQ4dVOajnQ/pHFpuT/sb5jUrk3fpWFXb8z2haDN7C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hwjejwI+; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6e6698667c7so48924676d6.2;
        Tue, 18 Feb 2025 06:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739888714; x=1740493514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SjlgcMMqJDdeuMoyqpKeWIayNuR9Egse6jJeToK8tgA=;
        b=hwjejwI+CEhAqAgk+CuGnplGTQCcCOLloeXJGhG5IwKWNotqAVdXVPs2UbSsdN7cD1
         ZnpH6w3cTI90idECJ06Dx+W2XgS5vqRrOIeyAhlkmMv7j1ucwy+5tUNVwnMpD3vy76z1
         mdZamUONFity9QRaNHKySPdnelolsZuWm6X80h9SSn1kQkXI/4p263PXH6lxZ+949woU
         duq74uMwniTX23rbPHea0QtsAoIPCikefgTiLTZelIlshS1L5bKTpbAOV8S4XzCbwAfW
         Caf1JX5NZ13I1+5J4rAtwa4HhuV6fnk1P7PRWuvRVN0u/Ca+rhPYgpX6V+e+OybAgKt6
         eWaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739888714; x=1740493514;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SjlgcMMqJDdeuMoyqpKeWIayNuR9Egse6jJeToK8tgA=;
        b=wfymXtR40MVYlrgso4dmsjGJLPzNs5Aucb6k8/ZUXkhyUf3+tnErSyKeQeVIWL6AZA
         HgnL1lai4tr3WndrMbk11Fpu/V85hGDODP7I8yKNg+z1WkZZo52/wYoQC2lLu0zWU7Vk
         RSuTo4Z3JENcarhIiPsfIO187m1p7pb55Wu+Ab80nokSob1+DnXgnzY7Dvx9QO3dUMvY
         OpUABptluLsjoSBslSi0qNqNkQ2wWIn8Vv76j6UsdDEmZHL+tDJmOvjOASVkjjzV+uiJ
         EZ3qMjbY+3sf+aYBOzdNOf7/f2jEqKywAPgm7A/Z+y495xjj1VVz23qX8gtQXlt4b3PU
         rL0g==
X-Forwarded-Encrypted: i=1; AJvYcCXMAb5QheEiJzBaA8m5M3ki1x+MyNnpsLv/T2FhhImXqJ4rYExtMD2xHt5wFrdJOwyCD7ZAwVU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMFQrZBo3EuFHBgANkZko9NZyNdlaHdrfBOCWx0fK629bdv8x2
	JygZJUFgmkhwwMGCxuyy7woAWyMNJNNf+aXAtvJLsOPx75vndUC/
X-Gm-Gg: ASbGncs9HMpqP5QVVqsNa0J24Tom6bdoTdriddEiDSSJrwriTE3LiZcIa2WR1P8bflY
	iUxhaF+DtnsabIg33JeIuYZ1xxE0e+XOpvNqE01cHcXJCSI1AtViC/CzBTjJ1syrvvqCRur1BC5
	vqdg/qvEUxM6AdME19/40Fl7pW/3Qjndi8FZ4jthBHEsVzXJCnmciwzKursIWPDKkhgYehGnTua
	WtPIOxzFLERYVmAhK9uLDWOp6OvC6She5yygka4GqN7LzqtbWrgp+Iwqs77e8kUIC2ByGVRqa1m
	goHzmEeID9t2DVeZbmK/ckYUi0fbpUGpKV0UKNBRH0iKyydsB3OUE9BqI/vztL4=
X-Google-Smtp-Source: AGHT+IHu7PdU59at4kGPYkzhaNI9dPdA+7XpebIwViRcfka6VwouB3Jp+J76s2y68q8u0gZHZstvmQ==
X-Received: by 2002:ad4:5f0a:0:b0:6e4:4393:de7 with SMTP id 6a1803df08f44-6e66cc8951bmr211066306d6.2.1739888713725;
        Tue, 18 Feb 2025 06:25:13 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c07c5f35bdsm669157985a.7.2025.02.18.06.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 06:25:13 -0800 (PST)
Date: Tue, 18 Feb 2025 09:25:12 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 willemb@google.com, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 andrii@kernel.org, 
 martin.lau@linux.dev, 
 eddyz87@gmail.com, 
 song@kernel.org, 
 yonghong.song@linux.dev, 
 john.fastabend@gmail.com, 
 kpsingh@kernel.org, 
 sdf@fomichev.me, 
 haoluo@google.com, 
 jolsa@kernel.org, 
 shuah@kernel.org, 
 ykolal@fb.com
Cc: bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Jason Xing <kerneljasonxing@gmail.com>
Message-ID: <67b49848ec47c_10d6a329425@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250218050125.73676-13-kerneljasonxing@gmail.com>
References: <20250218050125.73676-1-kerneljasonxing@gmail.com>
 <20250218050125.73676-13-kerneljasonxing@gmail.com>
Subject: Re: [PATCH bpf-next v12 12/12] selftests/bpf: add simple bpf tests in
 the tx path for timestamping feature
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jason Xing wrote:
> BPF program calculates a couple of latency deltas between each tx
> timestamping callbacks. It can be used in the real world to diagnose
> the kernel behaviour in the tx path.
> 
> Check the safety issues by accessing a few bpf calls in
> bpf_test_access_bpf_calls() which are implemented in the patch 3 and 4.
> 
> Check if the bpf timestamping can co-exist with socket timestamping.
> 
> There remains a few realistic things[1][2] to highlight:
> 1. in general a packet may pass through multiple qdiscs. For instance
> with bonding or tunnel virtual devices in the egress path.
> 2. packets may be resent, in which case an ACK might precede a repeat
> SCHED and SND.
> 3. erroneous or malicious peers may also just never send an ACK.
> 
> [1]: https://lore.kernel.org/all/67a389af981b0_14e0832949d@willemb.c.googlers.com.notmuch/
> [2]: https://lore.kernel.org/all/c329a0c1-239b-4ca1-91f2-cb30b8dd2f6a@linux.dev/
> 
> Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

