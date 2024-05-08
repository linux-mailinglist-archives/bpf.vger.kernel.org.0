Return-Path: <bpf+bounces-28999-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA7D8BF34C
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 02:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6734928A809
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 00:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40EE7364;
	Wed,  8 May 2024 00:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aXgaol+9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7738E376
	for <bpf@vger.kernel.org>; Wed,  8 May 2024 00:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715126463; cv=none; b=XNGaN84nlLqcO5wrNx1E3EZRa588sBHoGklvrP4FwAWK7gS3W5qWVOPF6gpJvI/07iCGRzyjmrcSDEhyioShOlXL594QI6wd8FXL+OH3TuVEYeeYF84c/f7UTTnbswt+tQzAjdnPNb7vCj4OvL6Wc/84LDyJJsHofwAzFo/RVLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715126463; c=relaxed/simple;
	bh=Dd1873tTL8mrfnAaIoCc3BHpnqSCaA0yE/vEawwAGUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KC9tYisQTwkNuq+2UDpan8SY8VN/SXEPfdAv3nrxq7RMJNgwbKT6NyRsuangNz1st9nCzH4W4OnixaftDlE4rVN+fAk2UD6Db3TEClmn3VBRfpHdKMrAD+vA9Zrpe5pVx22wU8MpVig8TsXVVWjlrMVg5AjbpgGVvaDHwRnkg80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aXgaol+9; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1ed96772f92so26896345ad.0
        for <bpf@vger.kernel.org>; Tue, 07 May 2024 17:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715126462; x=1715731262; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kgufUMFIe5CgvxNbbw6MG+VJiW0+zFKlSCfBrZk9Ldo=;
        b=aXgaol+9gFF9vNwz6plXY6shVat85y+MTP7LJ38cTFzUvP2bmiQICsHx+iq6AuGc6K
         UfQYcRkT9h1hEaKAF+eFuCoTqVHr7pwzx+DPrxUfY0CzSuj2HZ1uBicLLPvggDtaLo96
         1tEbm5/BNEmythxTY+s8x26x67boLLjvlFjMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715126462; x=1715731262;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kgufUMFIe5CgvxNbbw6MG+VJiW0+zFKlSCfBrZk9Ldo=;
        b=c9LtRF2BBhpg3LQDFbdH5A94XxWx2yVgR/FOw6KxuMybcxjaMRcQTGHRMI6cKoTr4d
         pJUVkSm5aWr1A2Q1lrTAQbAEfMhxGRPmLdAh5Nw3xJmhIBBTStqa2QX5IvaMinY1PaO5
         9aBO+n26fGD6EZQUquOXoBQNWYwxe2G69gHBPBkvReA3PioFnyFaNURYe4oyQhgqIite
         azr9behtWbD+yDZm+qHLTI8cFNrVCzbvtlA0wOcfALBXLSlp6zAfHEKw7EDzleqDkSMx
         xCpBbsXs9BNRHcpbeSmGqihMGQ9jVWAKIjiUptKLAT8WsFIdVEMtP79BIGKq76Hp7mhV
         XiNA==
X-Forwarded-Encrypted: i=1; AJvYcCUTOKID4R11PH8fz4AjJzIabvkFSLZMt+pYDXfrrJShjv3Rt/eOYANy2mdC0v3+3iemnvrBtLKU1ynP4EclyhXyeRIZ
X-Gm-Message-State: AOJu0YzRjXjpHH4MXynmPErqDyr2S8es+vQPhnwvQsIXKrx3hFeiEGu7
	ND6RSGa2yNgSP85xYFxTHruMYtItARc2ueJqZcTMjcbXDKcbpfLYyW4Qct8MPA==
X-Google-Smtp-Source: AGHT+IEqVNpGRLhqVw8kSUrB4Az3m0syouxfJ3Vc9EaQTLuN0eJuZiZbA1z0yyXDcTk4ZDPLSwmANw==
X-Received: by 2002:a17:903:41d0:b0:1e2:9ddc:f72d with SMTP id d9443c01a7336-1eeb019739bmr12303355ad.26.1715126461737;
        Tue, 07 May 2024 17:01:01 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a12-20020a170902b58c00b001e4881fbec8sm10605606pls.36.2024.05.07.17.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 17:01:01 -0700 (PDT)
Date: Tue, 7 May 2024 17:01:00 -0700
From: Kees Cook <keescook@chromium.org>
To: KP Singh <kpsingh@kernel.org>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
	ast@kernel.org, daniel@iogearbox.net, jackmanb@google.com,
	renauld@google.com, paul@paul-moore.com, casey@schaufler-ca.com,
	song@kernel.org, revest@chromium.org
Subject: Re: [PATCH bpf-next v10 5/5] bpf: Only enable BPF LSM hooks when an
 LSM program is attached
Message-ID: <202405071653.2C761D80@keescook>
References: <20240507221045.551537-1-kpsingh@kernel.org>
 <20240507221045.551537-6-kpsingh@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507221045.551537-6-kpsingh@kernel.org>

On Wed, May 08, 2024 at 12:10:45AM +0200, KP Singh wrote:
> [...]
> +/**
> + * security_toggle_hook - Toggle the state of the LSM hook.
> + * @hook_addr: The address of the hook to be toggled.
> + * @state: Whether to enable for disable the hook.
> + *
> + * Returns 0 on success, -EINVAL if the address is not found.
> + */
> +int security_toggle_hook(void *hook_addr, bool state)
> +{
> +	struct lsm_static_call *scalls = ((void *)&static_calls_table);
> +	unsigned long num_entries =
> +		(sizeof(static_calls_table) / sizeof(struct lsm_static_call));
> +	int i;
> +
> +	for (i = 0; i < num_entries; i++) {
> +		if (!scalls[i].hl)
> +			continue;
> +
> +		if (scalls[i].hl->hook.lsm_func_addr != hook_addr)
> +			continue;
> +
> +		if (state)
> +			static_branch_enable(scalls[i].active);
> +		else
> +			static_branch_disable(scalls[i].active);
> +		return 0;
> +	}
> +	return -EINVAL;
> +}

First of all: patches 1-4 are great. They have a measurable performance
benefit; let's get those in.

But here I come to patch 5 where I will suggest the exact opposite of
what Paul said in v9 for patch 5. :P

I don't want to have a global function that can be used to disable LSMs.
We got an entire distro (RedHat) to change their SELinux configurations
to get rid of CONFIG_SECURITY_SELINUX_DISABLE (and therefore
CONFIG_SECURITY_WRITABLE_HOOKS), via commit f22f9aaf6c3d ("selinux:
remove the runtime disable functionality"). We cannot reintroduce that,
and I'm hoping Paul will agree, given this reminder of LSM history. :)

Run-time hook changing should be BPF_LSM specific, if it exists at all.

-- 
Kees Cook

