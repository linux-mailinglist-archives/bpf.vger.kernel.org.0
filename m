Return-Path: <bpf+bounces-72304-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CCB7C0CBBE
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 10:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CEE43A787B
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 09:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935BC1C84B9;
	Mon, 27 Oct 2025 09:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GvlXdDyP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6813F245012
	for <bpf@vger.kernel.org>; Mon, 27 Oct 2025 09:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761558059; cv=none; b=qn31Vcra00A+zdkwGdUKpp9JcBcOx3JmrdHFZbHcOaRZYJ0xv7QVWu+Y1cQgul6dHSGvG/ftliJXzB7ufFGhf74rW94XzXLbIlacDHkwfpqJbB8Il8ISGKZ413W6ryEh11pigxE9y6UUiuG9rR27ws0N9UYc26HR4QvzmQw/J3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761558059; c=relaxed/simple;
	bh=LJf2KlQpTI/J4Q2WN+sN/y3pJoAQ19a2PFHP5cQAUww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nif8TUSBeWTtXVh8FG4zTdHIatLX6KYB+7qh2R1Cu32uGnvbrZrurAf75r0OEbHtjFzjYUkhTWHULnsVFOH3xlJExcpZHdbr2CoKqZhVxvsbmkWczINiAnKISvH8amfTIVktfVV1AXZoxKmeZ+iYUpQjIXDDbNly1BcyL/erPeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GvlXdDyP; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-63c09ff13aeso7554227a12.0
        for <bpf@vger.kernel.org>; Mon, 27 Oct 2025 02:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761558056; x=1762162856; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=09qrJlPsayZCPVTpiVR4xUYmrnkMGkD243Y8R70R/2E=;
        b=GvlXdDyP7cLu2FemyS63alnCOggPpYN6/On9+AmLeq5DI/sea8hwfoGVr8i2FSAAlC
         TjhDV3QmwMxGwn6CSBvn5W8VTCWhP0xdhOBNgzhD3yj3vCzQwz74+GqF5qHoFAsVhh8a
         seFWbKTegfuJTPqXKJbwRP+SLP1KoNs2stalXZ0s3K1H3BzR272WWViM9Wz4JSyFnLWC
         0XXNAZ7qjfFHqWOQbhD9893ksDekOjXHxOkSzn3EV9xnoEJtLt1XrZrzR6vzyAZMKIud
         Xmxirbn/W/jFY1iM5K+9BGOmaUlyOFxTaG7AgrZeUfoEFf+ko1pQ5136GUaek/6fGstl
         Jj0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761558056; x=1762162856;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=09qrJlPsayZCPVTpiVR4xUYmrnkMGkD243Y8R70R/2E=;
        b=GT5HABsIrNQYH6rz7JdMD+LjySBVLgsrIdhXJwvNrAgfFiTSEGuVoIrXI2jkfYygqM
         heheKFuFL4KCoT5ajJxmp2w1D2w5wFdT623n6XQ6VAUNmoDf4iF+48N6gkTls4JiYu2U
         jNqR4azJ2LAbf7HWYR5be+Uec/xTssTz3fIdR857PEq87UPPx2EAk3qCKQRsEboErKde
         Ra/2ah4xzKZyWNpXHAlYJm/mNk8ASx7vEbFSARYNa10fu/pOQs/026xhx1lwC57O64hL
         zl9ZD6wfKqdVm2KGwywVAWf1bpbGC8w+KL2IUHIxpcq37P4UtNkqzobL9TyOluTXRYcQ
         OAHQ==
X-Gm-Message-State: AOJu0Yw+fBHtJQJHvTSGzM45EuxM+AG5SIJ6m3pQgqfNClOH4yI48OBG
	5JvNL/zFFj/s8GCO4JJtTn6FEdteP5VA836b/UgNLEE5tD589lNbqqAvUSNhL3qWNvrF0CX+usk
	jMFRLXw==
X-Gm-Gg: ASbGncsgdk+2UPzeS5qfH1hEM3VqKHvcuPEoOw7BLGyKXPTvx1rHqO8JwlBXqjQm5cP
	p7eE27+7dvBpZk7qaxxfC6PNmUEguTSjya8LC1O8gDGGG/hsMKyTDbIMy3hSZuM1ryOC/rVWmhK
	z/pmL8Rx4+6O/4rVapFALSNy3RLHkVPIV5Mxk2R9N3jEXjNP5+8PBifvAVTxFUiPS7DRG7yuPAF
	vSYjhqZ7t65AkVv2C91m5FMHxySAmVZ91wV+LSfHyyWSPiUZsBtOooVuzkfGVC7mHKXoNnKl5cT
	vgET9XrKYC63UzKGSm8baFVFZ3KcuTdhSUxVGvROc6/9muojbF1Pldym7DWLEyPqKRE3rU1tADD
	ma1DYz28wsEe4tVx63VCrJp9oYTtaw8hoFUi2AU2LxtH0sTQA9e9hztNjoKVbaceCQw53REQvP7
	IwcoV9osqFfo5dHHL7insSc1Wf1VdwikLpiEyJJBtrfucgiAcAySaBUx+X
X-Google-Smtp-Source: AGHT+IGN1boHe/GFDg/GqZt15GA1jLaCNOuuTeRlKLZW/T+8td18Gf64Z7udwrA77jn62CAOrb+kNg==
X-Received: by 2002:a05:6402:1442:b0:637:e57d:c21 with SMTP id 4fb4d7f45d1cf-63c1f62ab3amr34451213a12.3.1761558055326;
        Mon, 27 Oct 2025 02:40:55 -0700 (PDT)
Received: from google.com (96.211.141.34.bc.googleusercontent.com. [34.141.211.96])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e7efb9739sm5929263a12.29.2025.10.27.02.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 02:40:54 -0700 (PDT)
Date: Mon, 27 Oct 2025 09:40:51 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
	casey@schaufler-ca.com, kpsingh@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org,
	john.johansen@canonical.com
Subject: Re: [RFC bpf-next] lsm: bpf: Remove lsm_prop_bpf
Message-ID: <aP8-I5ZBMU0PNDJV@google.com>
References: <20251025001022.1707437-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251025001022.1707437-1-song@kernel.org>

On Fri, Oct 24, 2025 at 05:10:22PM -0700, Song Liu wrote:
> lsm_prop_bpf is not used in any code. Remove it.
> 
> Signed-off-by: Song Liu <song@kernel.org>

Reviewed-by: Matt Bobrowski <mattbobrowski@google.com>

> ---
> 
> Or did I miss any user of it?

No, it doesn't look like you have, and I don't see how struct lsm_prop
could be used from the context of the BPF LSM ATM anyway. Thanks for
cleaning this up.

> ---
>  include/linux/lsm/bpf.h  | 16 ----------------
>  include/linux/security.h |  2 --
>  2 files changed, 18 deletions(-)
>  delete mode 100644 include/linux/lsm/bpf.h
> 
> diff --git a/include/linux/lsm/bpf.h b/include/linux/lsm/bpf.h
> deleted file mode 100644
> index 8106e206fcef..000000000000
> --- a/include/linux/lsm/bpf.h
> +++ /dev/null
> @@ -1,16 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -/*
> - * Linux Security Module interface to other subsystems.
> - * BPF may present a single u32 value.
> - */
> -#ifndef __LINUX_LSM_BPF_H
> -#define __LINUX_LSM_BPF_H
> -#include <linux/types.h>
> -
> -struct lsm_prop_bpf {
> -#ifdef CONFIG_BPF_LSM
> -	u32 secid;
> -#endif
> -};
> -
> -#endif /* ! __LINUX_LSM_BPF_H */
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 92ac3f27b973..b6ace332576f 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -37,7 +37,6 @@
>  #include <linux/lsm/selinux.h>
>  #include <linux/lsm/smack.h>
>  #include <linux/lsm/apparmor.h>
> -#include <linux/lsm/bpf.h>
>  
>  struct linux_binprm;
>  struct cred;
> @@ -163,7 +162,6 @@ struct lsm_prop {
>  	struct lsm_prop_selinux selinux;
>  	struct lsm_prop_smack smack;
>  	struct lsm_prop_apparmor apparmor;
> -	struct lsm_prop_bpf bpf;
>  };
>  
>  extern const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1];
> -- 
> 2.47.3
> 

