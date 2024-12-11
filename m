Return-Path: <bpf+bounces-46595-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A799EC5B0
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 08:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9367D188A9FF
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 07:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8E01C5F20;
	Wed, 11 Dec 2024 07:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="Sk7USPrU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B909C2451E2
	for <bpf@vger.kernel.org>; Wed, 11 Dec 2024 07:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733902785; cv=none; b=iTY+5m+m/+5BUrJ8z9gHfyBciZujnIlG6dlmydfB6vUDu04j6mzDfmFrp49db3gPTqDJmNh+lgsoAfCqTID1uTdleOisBQLzk0Rhwiien6AfmoFb3Ksw4lNxXHstvnwu9Qa85ZnxD/mGiqSPouBYpNPPeMQqUymOjgp3HSNB4Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733902785; c=relaxed/simple;
	bh=DORG1Ks2Ys/cwGYFA4vsK35m/+ska6mrKncu7v6xL7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZHZZDvZ1HU6/kDqMQCODkjrMGS2BvSY5tuijK/tAteNRjgv0ZFPUFWl8c4Wze+P2T7z8SaKVo/EjlXZeIxRBJTSfcBZEkHkESF1MJcCyEDJnFbJjNJKUPA5Vsl9B88urQ3syL+Uad+qJbsmmSa4iHxFBkIqkx+5UKp3HGIByXC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=Sk7USPrU; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aa67333f7d2so539104466b.0
        for <bpf@vger.kernel.org>; Tue, 10 Dec 2024 23:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1733902781; x=1734507581; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SDLVARpsnDlTbI+1bNiZJo8O89zIKh2KB20CydSK0Lg=;
        b=Sk7USPrUrYJ9QQvGoQMyuGONoEmDa4ZbODq8itUsp01Rx/EbrJcwtvf0dJolYuAxFO
         LWixIfmMUPpAUC/urA9+LSIcfk9FCoQRlEFZBnhe+V0fQuYj+R5qt+sZ9SyiC070QUhF
         51dTs68e4aDyi70qm7bqp0GiycFlPXzJyWdkJiSJWeMvkwhttvY6Tt9QfomowXEgBSRd
         RGrBc1KmYjcsvzOX18s2ft9kuKSsDuY93rIhnhq46NGEUqsIN2hqx3flrQhuhtWDhqz7
         xyJIsWgamppky21Ms2QCJJOXua9CKmK1Qlz/jWNzsNOoI+hSuyqSlgdlqCdFZ7WDqIKk
         sLoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733902781; x=1734507581;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SDLVARpsnDlTbI+1bNiZJo8O89zIKh2KB20CydSK0Lg=;
        b=frzpTk4d4QUtAI8yFZmzZ2656KKgZ/zPF8sVafQyc96MsxGwEao0HhWNS6p12Q3wux
         a6mKN6PPc3iFbDPT84KXytTbvFaa8tybv1zwPHwl+orZXzZgatErOlUVn19XndAqHM2l
         EXhWYzrm8I0VUD6ADFBDis8oEVtL7l6vvobG+MPV3qYQczsFmCwrYvjykVtEmYvhslvQ
         9R2/lsyKCp5/bKFkvsF54O3PNTzz4PEmIGD+OMhRmOeNFUhxMpPlM0ki6b9UlWhYimGT
         1y6sw018un7QMaaKIyqS9VPcf54KVUhAGR4LqqfZGXcjYSMj8OHlnhrr7RSp5wGhZfYN
         u7TA==
X-Gm-Message-State: AOJu0YzEjhrXbsCGsDq2dDkj5kk5VuQpSDCT6SmAcGPKIwtzaUDdZ89y
	I4oMKGWhR/v8Ei6KCQjd1XJfNbf/SLlcb2honb3Ky5Z7h6Q+g8r9uJKYwypCLAE=
X-Gm-Gg: ASbGncs1Tf0mt01KZkS5xgr0BYYXB4YVg+MVhNLFe2GRbmftNhA+Jx9xSkjEl+GZepv
	lAeumsrMvC/F5Pr9n/1wCWVWzAmLI+KTKzopA9QQoGpRNMndk7Vez9WDlhygBxSP9+cJmpuRbPP
	ZUjdUNnmwgqJ6qcF+PVGbFQrFVgUCobqdVJOc634EpeA+n/O1mPfc8+2DvmccoeR5S2pgA6tPAu
	qwW4hmjFmiKXtGVPplAJ0tbDCOgQzQ2Rl0p/0G9iRSMOb3wgel2TfgW
X-Google-Smtp-Source: AGHT+IFipA+mRShFNJYIIfQNQxqKK4x68o9aNnxvU6g/oFn+L+QU9luB/+oOOIQDdTdJSOLzAlaj/Q==
X-Received: by 2002:a17:906:2922:b0:aa6:6aff:45d0 with SMTP id a640c23a62f3a-aa6b13db741mr144859466b.56.1733902780840;
        Tue, 10 Dec 2024 23:39:40 -0800 (PST)
Received: from [192.168.0.123] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa68f4eb962sm373232366b.3.2024.12.10.23.39.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 23:39:40 -0800 (PST)
Message-ID: <7c069355-03d5-4eec-97ef-83fb8ce21cb7@blackwall.org>
Date: Wed, 11 Dec 2024 09:39:39 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/5] net, team, bonding: Add netdev_base_features
 helper
To: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, mkubecek@suse.cz, Ido Schimmel <idosch@idosch.org>,
 Jiri Pirko <jiri@nvidia.com>
References: <20241210141245.327886-1-daniel@iogearbox.net>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20241210141245.327886-1-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/10/24 16:12, Daniel Borkmann wrote:
> Both bonding and team driver have logic to derive the base feature
> flags before iterating over their slave devices to refine the set
> via netdev_increment_features().
> 
> Add a small helper netdev_base_features() so this can be reused
> instead of having it open-coded multiple times.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Nikolay Aleksandrov <razor@blackwall.org>
> Cc: Ido Schimmel <idosch@idosch.org>
> Cc: Jiri Pirko <jiri@nvidia.com>
> ---
>  drivers/net/bonding/bond_main.c | 4 +---
>  drivers/net/team/team_core.c    | 3 +--
>  include/linux/netdev_features.h | 7 +++++++
>  3 files changed, 9 insertions(+), 5 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


