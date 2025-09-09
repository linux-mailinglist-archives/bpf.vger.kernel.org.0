Return-Path: <bpf+bounces-67926-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA126B5049E
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 19:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 838F77A5E57
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 17:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E5F345723;
	Tue,  9 Sep 2025 17:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NXRYpXo6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E098422CBC6
	for <bpf@vger.kernel.org>; Tue,  9 Sep 2025 17:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757439799; cv=none; b=VynEThy7vL8cs+xOFyJJbhtbtjWS4xbH0eRA4xEACt85jUAzlJQyfD0GB2d8YCQsvcvNO7pvVbesw7we3mgJxKU0wsWcVtTL3PSJ36QBKBYrruX/CKxc7dwxqrjP18ubERifycw4oMoqjd1inzW8v1PFh/ROfF1w94eOW7TmQy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757439799; c=relaxed/simple;
	bh=BvQb6kT/0BgL8i4g8xvMWhvNmnBB4lCjfyN8t/RpY6c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VJTIw1kcDyuFrKZXcnK5AIDJVyR/D0fSeVBgOFiESWvkvaQpVHlv/a7vXKBZWfP/SWVNDp8poJh6/Ub+i+03ShXPk3HOcSpb5BvbYDha//fdttOSqZyRURpHigzYsUfGda6l2yR2EXC1DioiUzcSiXhucIVdaS1Zap/JKGJB19Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NXRYpXo6; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b4c1fc383eeso3668264a12.1
        for <bpf@vger.kernel.org>; Tue, 09 Sep 2025 10:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757439795; x=1758044595; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ehaBvL5mwc8SZQIwOqWZuETikIQ0vyouBo4B6n27EPE=;
        b=NXRYpXo6PX6NDpF9CO3NK0mUZBLg2YSnTkkS4xiSsCWCqj1bZXQ1/GmTDJKJ0F1QiJ
         RUKYLb1gJ8CnoKDwJ5e41oLLCC7OO4EsxcgVKLll4kjo4TQS8Pb4mPtgbRvR92M8+i0y
         mehs4BwD+juLS0ClAteOkin5B/YCLDqbfU8JI1jZbRl5FRECF9LcZbtmZ8xgn8nzW2t9
         lXHH7wtMIE1UrOmGrTV8AdlquFsQOYgtu69BlVpS3UQANV06PBXyi2frSa9g6qBMG6cw
         aTG2H54iHIRq83PpnBtj6ATaVQEwYI7ArCef0ueJZ9+aZlwFRmVyWkw+4g7YZv4Mh1Bn
         HTrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757439795; x=1758044595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ehaBvL5mwc8SZQIwOqWZuETikIQ0vyouBo4B6n27EPE=;
        b=s8nghdqK96X7dl9Pn0/M1WrbZNgQ2mH6VPIKTx/cNnI03Ch1ZZoxA1OtqRPhbs3Xx9
         u+HYXHFZm1t9wdiFK/nzh2LuObu/1VFsaBrXkFvYL31AjbrEvNvC4jmUvm9NkKRZdbTi
         UJsMzudmCSrVJQOQmOX3FB5rOAgRxPPotqQOQ0OGcrPViFQMpRPLbuUiOBVtviC16QPk
         VdwGzEfMQSoeeIlPpl56C8/W9ZXcRIp8VwMMqkmE8K9Yox8WGXrs3kBQ6QkznwK7syeA
         JaUWZCkUsoG89hT15mSt/p0QHW8S9/CCWO5IDZBQrAVCapqsb67/7XLv4VGMnD9zUdyT
         5dqg==
X-Gm-Message-State: AOJu0YzyDGt6925KDeP2Xahi4qrFmyfaHV3E9bs1bv9uaBP/8CutF0mN
	nPW/uD5BzruqWtT8h0+hkRn+Dw4j8B17Av7/hfMzmBBHQ/JTBmKRjAwQtUm0QxRf5hF3ycnBCQX
	4TOMySIeLuaSLXYwoHAXeby/3tisJFvg=
X-Gm-Gg: ASbGncuN7vWzbpRSbhNmq9m8jGG+ysMul40fS5hUbIE7v5qXySGfADdrp7AiuLPaub3
	GqncfEGPrHmgfivWw9ALgQ9W4Lp1voYmq1pFzG1GWOxCSV/ZBSX3/pTjfdNaPl81iUcXUJVK0yZ
	CFKsBW1z6Y6Oi2FUTx8KlyTL58E9wSVFy7biK1YrQWzkOsRQbvLIIlnDBxEoVXsXAWVC7r/zyT+
	U+7Dp9yrZn/mMnR4/nc9VslisvsBPU8Ng==
X-Google-Smtp-Source: AGHT+IEnKshsa0wLAiq12+HI8hiVyTL5sg1YEnRU5aSF1IXC/Ci/ZeC6LvuZQ97fcyThMlSiLy/LSVNzMwcsaNxaynA=
X-Received: by 2002:a17:90b:3e83:b0:327:7c8e:8725 with SMTP id
 98e67ed59e1d1-32d43f02b62mr17944187a91.10.1757439794903; Tue, 09 Sep 2025
 10:43:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909171638.2417272-1-eddyz87@gmail.com>
In-Reply-To: <20250909171638.2417272-1-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 9 Sep 2025 13:42:59 -0400
X-Gm-Features: Ac12FXyiH26jM9-ytrx6XnSn-jxIBrbM--7bDmfROhK6pgvMhC6lKkFXYRmQ4Kg
Message-ID: <CAEf4BzYf3ew_ho3=FWiZr_VYvex=XVFDv8Y9ymTUuAgn9EKqOw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: remove Mykola Lysenko from BPF
 selftests maintainers
To: Eduard Zingerman <eddyz87@gmail.com>, nickolay.lysenko@gmail.com
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 1:16=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> Unfortunately Mykola won't participate in BPF selftests maintenance
> anymore. He asked me to remove the entry on his behalf.
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fe168477caa4..6056ad6f1afa 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4682,7 +4682,6 @@ F:        security/bpf/
>  BPF [SELFTESTS] (Test Runners & Infrastructure)
>  M:     Andrii Nakryiko <andrii@kernel.org>
>  M:     Eduard Zingerman <eddyz87@gmail.com>
> -R:     Mykola Lysenko <mykolal@fb.com>

cc'ing Mykola

>  L:     bpf@vger.kernel.org
>  S:     Maintained
>  F:     tools/testing/selftests/bpf/
> --
> 2.47.3
>

