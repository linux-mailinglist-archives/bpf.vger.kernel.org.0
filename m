Return-Path: <bpf+bounces-47460-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4081B9F9918
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 19:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08637168224
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 18:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C992210F6;
	Fri, 20 Dec 2024 17:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PXKsN6kC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D245E21D5AE;
	Fri, 20 Dec 2024 17:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734717210; cv=none; b=fJay9Wb6KYX8+0qIL0FR8S6ZsHkSJwWKXjOnmVFsgogzPhrS2gjnSqW/qE5Jacw940mriq/rYN6ukKlUoab/4c7U+cJ4BAEOyVGKxTNB9aU/v5gtn2PZUve+zbpz7Se/pIE7ciqHrEyPDnjohSivEwfIJSbcuIm0o8lJlhdU/PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734717210; c=relaxed/simple;
	bh=+qOJg9i1tRH7NPMO25N5xssDP2rhL0b5wSfiwZm2UYY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=jNOl++jMJ/PNWtmCG2ObJmB2esJy57QGp/pYfjJWtolIqCkkJkDlw+bq7QnY9xsGR5ITpEXz9g/8xKE3P3a0oUM8UnXY91AbcmQgVF23EFDXkZhNNlNLTcBw+/ruXm/+M5epHgIokxh1hhOoLri/Gw+0ovN/2+DbZHNZI1Ls8f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PXKsN6kC; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-725f3594965so1978496b3a.3;
        Fri, 20 Dec 2024 09:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734717207; x=1735322007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7trZKep1I/sq5Xca9TswA6+9HBZrobD8EndRh9SeyBk=;
        b=PXKsN6kC+y2RCpaUBJJVQcMOrxfrMPcBgtNiX0XpuNvYbR96VIBShM9kT130K8B5j+
         Hf1gYiVu2CJjBXYmP1bE8jku/y4nqVO2SjLZ3skEjVOkSzlOLN2XwQWiKBkjvv+0oFur
         z8Afdhs+mN2YgJr6+GGCOQSVIl3PUHxjlxaGHuXK7KGkybZVD2g8duW19Maq2NhBsuF3
         B+n8NGPWqdygz7Jltbm+WfiquG6yTex7R3Tt7FPjf49mL+YRNNnPoF+/uCZ8NDMG4929
         u8OxZmIr88NvWZgFTqyA02Znj3FhEAE+E0AwQ6vz3qw9W7T7Z3gR+D7ZwFXgT69lAyC9
         taYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734717207; x=1735322007;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7trZKep1I/sq5Xca9TswA6+9HBZrobD8EndRh9SeyBk=;
        b=S3WvLoY/279DQuMvtMoMXXhyM+Wz4nQh67PX7tV+TKZL+PtQy2IDXAGh3NR8CxjAiu
         hwcDDWcEgb7h1iVA70ssjmasxPHLMYsm9V9K4WMbciA3vYLv21rEBxZvWTqVGfoASyot
         ekLPA0Ku3UQOULlnxd8JaWiMyiL1yQsKW6NImoDPCdq0VRwSdq46hKDk+TNbuqQ8F78T
         JuzOtZ27LiNTeM1hgaaF1XQHiMt+pRrfWu8aqA/49cVYFb9KOy7qtIq5beHYKpbem1L1
         cgS0xLTgkzOr4RLf3jSNeAb8sfneUs8NcbN/8i7ZVM+M0XHPfXcttXr0Ofb+EP3Gg/RK
         HOPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYh/htYUd5I5HOY2hNxFcZ4PHRbyp+y5Uq+mqUKFhxsYw/2cUItBiPpbahYVmA2MAlrDrigAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN6KzrWp8reb7/OlLOWBKTKED9G+l/MKxbamxDhU4u2M5JyfS5
	lhHeuo4io55RJyUS8yV4whgoUgkICwC7YhNLvFKEjjXi5OI7HxzHo2wr6Q==
X-Gm-Gg: ASbGncsBKIdptpd6ocnNbScc8KpnzeiDCUWHDojNrI/aaV7+YeyCRKryWI1R3dYOHTB
	fs6HU1hGJtJP1p0pxBbmEtUa+PUVPQjdzv9+8nEGPgNhEkvee19oUo5178KQYJhGNZSIf1b/K8U
	5lugJDhtHSAI1zhhvnsMHa1ll5gUAuaLg6QkouyyXBHzcPMFfZScuYM1mUhsdU2fTmxAUWFmRiw
	WYExcYkcahhGUark3x1nChdKOqfbrReXxRHfyvs48cM2sUY/b/0cI0=
X-Google-Smtp-Source: AGHT+IG/JaUAIMYXiLkqU+oqLzq3DoGDrWlQGghyjUe/tFosAerfFlpZ0mSFlFQ+UgQVMnPNIIZZZA==
X-Received: by 2002:a05:6a21:7108:b0:1d9:fbc:457c with SMTP id adf61e73a8af0-1e5e08028ebmr6100766637.36.1734717207119;
        Fri, 20 Dec 2024 09:53:27 -0800 (PST)
Received: from localhost ([98.97.44.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8fb9a8sm3395663b3a.157.2024.12.20.09.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 09:53:26 -0800 (PST)
Date: Fri, 20 Dec 2024 09:53:25 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Cong Wang <xiyou.wangcong@gmail.com>, 
 netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, 
 Cong Wang <cong.wang@bytedance.com>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Zijian Zhang <zijianzhang@bytedance.com>
Message-ID: <6765af15e5f9f_21de2208f@john.notmuch>
In-Reply-To: <20241213034057.246437-4-xiyou.wangcong@gmail.com>
References: <20241213034057.246437-1-xiyou.wangcong@gmail.com>
 <20241213034057.246437-4-xiyou.wangcong@gmail.com>
Subject: RE: [Patch bpf v3 3/4] selftests/bpf: Introduce socket_helpers.h for
 TC tests
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Cong Wang wrote:
> From: Cong Wang <cong.wang@bytedance.com>
> 
> Pull socket helpers out of sockmap_helpers.h so that they can be reused
> for TC tests as well. This prepares for the next patch.
> 
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Zijian Zhang <zijianzhang@bytedance.com>
> Signed-off-by: Cong Wang <cong.wang@bytedance.com>
> ---

Acked-by: John Fastabend <john.fastabend@gmail.com>

