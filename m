Return-Path: <bpf+bounces-50208-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5649CA23AC4
	for <lists+bpf@lfdr.de>; Fri, 31 Jan 2025 09:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F4381889E35
	for <lists+bpf@lfdr.de>; Fri, 31 Jan 2025 08:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F01186E2E;
	Fri, 31 Jan 2025 08:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R0IQveLG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241E116D9AF
	for <bpf@vger.kernel.org>; Fri, 31 Jan 2025 08:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738312814; cv=none; b=cnJG+mT/jQHxfwN6KNYScaUh1RX26jlPcTHlFKZldYxoRaFkbguaG48flnNYSqDMfP5THEx9DakIoDL7DQLMH+7RmwVnVcTNXwGmRp1t0xlwwDNsRc0T5FT9Ksk6kXr1+8wf+5QPzMQmlLtPKusDjjOzuR2KmApOzIP3ptPzAvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738312814; c=relaxed/simple;
	bh=l/POijdq0AKYrlhYqcnG18UNaqfR+4/MYXeh403fXUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mEbthAnIvbwlqzu6YxuNzqiIEuDFz1Ss5WseXYAbeoFvcJRQB3FCTMOYHb4ge4UKXG6Fcf1Mynws3YHOjjBarsrotvY4JwkXz6kYCQkEwDTWe1ejwxJrvgI0UFq8q9bws4dpQOgliSFKkZ3hpPtXXIpAN993Vs8fO8c/QqEl4j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R0IQveLG; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a9e44654ae3so281076966b.1
        for <bpf@vger.kernel.org>; Fri, 31 Jan 2025 00:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738312809; x=1738917609; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6fWOGICQN9my2rbxgynZ7r3mlpoPZThnbsR+WYwfiZU=;
        b=R0IQveLGwTbh/iT2UWYB8j9iL+scgY3YGcoWuKaEHXyw2R9ePka+6Vqsbi64swEWu6
         9J5T6PWKvaCHT6FteaRJTWhMeYfhq9w+FZcvMklQgWs8EUoPV9E/60z3G/va5O8wHVPq
         StQgfVPyhVKE5Bvj7X1Z0P8X7Gv2tiUbRnZEVnjdWB3xA2sIZW42S4h3tMpJ2MRUkgwK
         TDOrCLN1RQXi5MIWbUBwMRy0HlMhFBongC+kP3COItW8spisnAaLVKUtLrVzrD6AnAlX
         Z1rqbi0pUrEh/Z6Gzd16SsXaWlJx71uXyWO3piG/NQhr95HqBX+mkPWOf7mt6U7dwjE9
         7rIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738312809; x=1738917609;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6fWOGICQN9my2rbxgynZ7r3mlpoPZThnbsR+WYwfiZU=;
        b=Xvg2TnGz+tUOIjhlEeo3H+LuzeQ0DzSx9GASc6FviwB/MFf6uLmnA4OvjB/cmcAgYc
         PiKrhId4HuVnHfGLfGlw1VVQOePStaT4wOMTXLcNVYISlOUION3iKNkTaTZd7OHa6EQ3
         DolPPXl5wBufpsB/sVtF/rgDmJYLnrlUD49h7birK9qYxI+8NRbn4UMf2wDSVZ8zAl+C
         t+g3kT6HScG9iRHzQ3JNtW+OYkS6ehkWD3zORhyTrCjub7ju2aMF9WCXOyxHUUSk0QaD
         LcT114B61qXzCEpLvwK/KsQWy+KtmicJKCBEHEdX3U7BBxJDU7Xefl7Um1ZCRxemNOv4
         vIOA==
X-Gm-Message-State: AOJu0YzOu3Pt8lhvCiA9oCTETWPhbF4m0ANMkTPbVsVrUAgaEVmd6AWK
	lw/86HlT2qMSJk75aQ+KEwZ1a6hv9LGCvH4C7isskgFebTuB+GSXxh7hZJRAtz/wbJQoVXHQuCj
	mLS1l
X-Gm-Gg: ASbGncvzUQgAAsBSNcZMqZFcP2lQhyNipmr00cLs0kx2206D8TJ99ndk3XFb2uu+3SY
	V8SnNgUqL8oXKmWp/x9eDYF9sr56eEbCwxtQF30pLUSMAl9Jbc0gZq/4VEggPUhfTr0vLAENPEo
	B9SEK8r8LTexaTteMiNz+ygYztlVpCSvg2p1XgtjpgDw4gPMhA7nQJ7oLhnlGIqEYHkn8ikxS5m
	ZLg36uZto+44DMS15a6jtw4289RHS+Ep9hklpMH+yNLnkdSXQEPEYg8aEwsBPaNtonX9ofYIejf
	gbvRK4cP1GlJbYog2zNj2mf8v0NjGH2aBONN/Bkxuz55QZs1+m15MArOdg==
X-Google-Smtp-Source: AGHT+IGc66AisMi+T21YVz5kV2+wGdqam815E3zK4evkRVJys/4pQlIeDgu1Bo2DlXU2pQKmlChh2w==
X-Received: by 2002:a17:907:1c16:b0:aab:c78c:a7ed with SMTP id a640c23a62f3a-ab6cfe12c99mr1095675166b.49.1738312809270;
        Fri, 31 Jan 2025 00:40:09 -0800 (PST)
Received: from google.com (201.31.90.34.bc.googleusercontent.com. [34.90.31.201])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6e47cf924sm257502566b.69.2025.01.31.00.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 00:40:08 -0800 (PST)
Date: Fri, 31 Jan 2025 08:40:04 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	kernel-team@meta.com, andrii@kernel.org, eddyz87@gmail.com,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	kpsingh@kernel.org, liamwisehart@meta.com, shankaran@meta.com
Subject: Re: [PATCH v12 bpf-next 3/5] bpf: lsm: Add two more sleepable hooks
Message-ID: <Z5yMZEn-BXhJwq5e@google.com>
References: <20250130213549.3353349-1-song@kernel.org>
 <20250130213549.3353349-4-song@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250130213549.3353349-4-song@kernel.org>

On Thu, Jan 30, 2025 at 01:35:47PM -0800, Song Liu wrote:
> Add bpf_lsm_inode_removexattr and bpf_lsm_inode_post_removexattr to list
> sleepable_lsm_hooks. These two hooks are always called from sleepable
> context.

Reviewed-by: Matt Bobrowski <mattbobrowski@google.com>

> Signed-off-by: Song Liu <song@kernel.org>
> ---
>  kernel/bpf/bpf_lsm.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> index 967492b65185..0a59df1c550a 100644
> --- a/kernel/bpf/bpf_lsm.c
> +++ b/kernel/bpf/bpf_lsm.c
> @@ -316,7 +316,9 @@ BTF_ID(func, bpf_lsm_inode_getxattr)
>  BTF_ID(func, bpf_lsm_inode_mknod)
>  BTF_ID(func, bpf_lsm_inode_need_killpriv)
>  BTF_ID(func, bpf_lsm_inode_post_setxattr)
> +BTF_ID(func, bpf_lsm_inode_post_removexattr)
>  BTF_ID(func, bpf_lsm_inode_readlink)
> +BTF_ID(func, bpf_lsm_inode_removexattr)
>  BTF_ID(func, bpf_lsm_inode_rename)
>  BTF_ID(func, bpf_lsm_inode_rmdir)
>  BTF_ID(func, bpf_lsm_inode_setattr)
> -- 
> 2.43.5
> 

