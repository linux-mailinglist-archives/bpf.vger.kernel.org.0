Return-Path: <bpf+bounces-46689-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D059EE14C
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 09:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D4651888132
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 08:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C11720C015;
	Thu, 12 Dec 2024 08:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="miwuHk0H"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CE21C460A
	for <bpf@vger.kernel.org>; Thu, 12 Dec 2024 08:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733992286; cv=none; b=g4HKv8dL4InGx2pVMEI2DHcqbDoKrEOFBLSuW1uR+T/6/EJmFllvfLpBTVq9MMFBHOttszpyzEXaIGd9xht6k7WMqqbcYg2xRjnzfAFhPWO6XaCEcPZ7hptImVoYrqNRY9eCWk68VP+GpuCk2j6Rq3fn+bMjU0/C0g4PaacC/00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733992286; c=relaxed/simple;
	bh=TtqwbhDdjTGWur/AFkn29pIoyLhmrdts8FFcsnS4ag8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o2JSb6ygrLn5lVXxqa77IUYuDqsqhHKunh5THtK4w7tQ1GE4x3iu9pcYFDf1a5IbbpajYH4LsiriTN95bKmmEQhp1kYoKQwYqTjqaOQwGrx6juxbbj4TPAsCcBhhiWFjK1pOrsy3bIUdjL1M4HEVkuVGLPksoH4lQKHW7R392XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=miwuHk0H; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5d0d32cd31aso409595a12.0
        for <bpf@vger.kernel.org>; Thu, 12 Dec 2024 00:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733992283; x=1734597083; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0Etgz7RSgss7nTlumi/Zc3I+JdxVFiVXjCxhG6C9rmk=;
        b=miwuHk0Hy1vp2KZ77bgD8ZIhIhw5WKaiNow/diXgivBAmH0hLCFjSQCP47XAxu79i3
         spIZap9d3Xwi4MKBxAul9C3m/48RxzK46DP2XlzFLB2JW4qkn+l/Yke4+8D+uBWmkV7h
         hAuxVxa1hYVbY2JQR8/AYaE763HooHpvnQazU6FHr2g8M4Rxegh6w7w5mp3muvMOU/RO
         EBM7pDyS6w8JaU6BQ4o0f+LsANW5LOd9JSdt5269CVgoSAaksLDwn9U4yxs5HcQH9Ici
         A9BlWcZPpDoZgZkZXSSW05A4qosk5tHCja8Nk4u3bRO9Zy7acqb/iYX8TpyrvGckA2OQ
         CspA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733992283; x=1734597083;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Etgz7RSgss7nTlumi/Zc3I+JdxVFiVXjCxhG6C9rmk=;
        b=XcsrBikeomwy0TlBjFM2Gj6l1bUZUYqbS0hj7ezWwUIN7SYhloUHyQ78CmJr759oye
         euQ+1lktJxfri4t4vL/USxYFT7QdkBDL+sW5vRKYFMzuDBC14ByJhm+t/4Bar00QzKkf
         bln9/CZV88RE3R1nl5KivK9T+ao+qzeB+74VO2UhabsgB3VlY5p7KAE+wUqtmYpVy9PZ
         tLj1i08YY5q7aMtUsIenwBalSDKl3hnSdfvIaiTR64zFXYAVQ1MhD7DWmScVJ7F1Aa4E
         Wl5HHE+FXab3VVkrSXfFzO11QmmTsRTVC5NziYZXRdNRE+k4A8IIhs80Edfp15TRqdoB
         5FxQ==
X-Gm-Message-State: AOJu0YycAggD5flHYan33euP19OwOiN4xhU2Gi6SW/pq4+dS2plxGate
	Vc48v/c66hGTbeW/BXP/tVdzCDYhGlngAmPnN3aGQ+E4Y0yJ02nzErDONN/TxA==
X-Gm-Gg: ASbGnctsBwT5kXmARSeRu7p8E328I2zMV5g17SJf0/YCIAaWayRxZ+4Kkpn8yNV+/9y
	tI6kFgc24K4UpO+3StOORTzubOTENftdfXXf2+CCRaHBrqsoCXdm7BJ8N+QqWEFZoWuR+k7CIs/
	yn/eUyTwD/k4AGkCOf/hcgm7eLJgrsMfg+WCVRvM2M0TMDL2F4DiooFZm8YFVAmtcmqDDVXMT1c
	u4qDcZKxwad00iLsX3/OqoqwYVa9jwr7yN7Bi6BBkc5wLiHsHfTj5s0L5+up6Y13fA7HtOZqI7i
	oDTYE25fYIOaUNQrwOzWt8rT3Q==
X-Google-Smtp-Source: AGHT+IFD3lPy25E1CHURlBiI+488wd3G2AN3safpm/L9TeioPakNrgwNL3OiBG7nWK80XYFaJpY3wA==
X-Received: by 2002:a05:6402:26d4:b0:5d2:7199:ac2 with SMTP id 4fb4d7f45d1cf-5d4e8f65be9mr479811a12.2.1733992282606;
        Thu, 12 Dec 2024 00:31:22 -0800 (PST)
Received: from google.com (97.176.141.34.bc.googleusercontent.com. [34.141.176.97])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6656f306csm759543766b.61.2024.12.12.00.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 00:31:21 -0800 (PST)
Date: Thu, 12 Dec 2024 08:31:17 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org, kernel-team@meta.com,
	andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@linux.dev, kpsingh@kernel.org
Subject: Re: [PATCH bpf-next] bpf: lsm: Remove hook to bpf_task_storage_free
Message-ID: <Z1qfVZDXLNoOjR9i@google.com>
References: <20241212075956.2614894-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212075956.2614894-1-song@kernel.org>

On Wed, Dec 11, 2024 at 11:59:56PM -0800, Song Liu wrote:
> free_task() already calls bpf_task_storage_free(). It is not necessary
> to call it again on security_task_free(). Remove the hook.

Acked-by: Matt Bobrowski <mattbobrowski@google.com>

> Signed-off-by: Song Liu <song@kernel.org>
> 
> ---
> 
> This was initially sent in a patchset [1]. However, this patch is not
> closely related to other patches in the set, so sending it alone.
> 
> [1] https://lore.kernel.org/bpf/20241112083700.356299-1-song@kernel.org/
> ---
>  security/bpf/hooks.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
> index 3663aec7bcbd..db759025abe1 100644
> --- a/security/bpf/hooks.c
> +++ b/security/bpf/hooks.c
> @@ -13,7 +13,6 @@ static struct security_hook_list bpf_lsm_hooks[] __ro_after_init = {
>  	#include <linux/lsm_hook_defs.h>
>  	#undef LSM_HOOK
>  	LSM_HOOK_INIT(inode_free_security, bpf_inode_storage_free),
> -	LSM_HOOK_INIT(task_free, bpf_task_storage_free),
>  };
>  
>  static const struct lsm_id bpf_lsmid = {
> -- 
> 2.43.5
> 

