Return-Path: <bpf+bounces-39208-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 082D79709CE
	for <lists+bpf@lfdr.de>; Sun,  8 Sep 2024 22:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE6BF282AE4
	for <lists+bpf@lfdr.de>; Sun,  8 Sep 2024 20:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CAA2179204;
	Sun,  8 Sep 2024 20:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJQJqcx6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7646A2D;
	Sun,  8 Sep 2024 20:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725828731; cv=none; b=qGXjZAv2/HezTjK//jZ+5dv5+VapMFH/m8ojuSabtN7/PK2285hhiHLIOWW+5opFEAfMR5d3/UKCWU2F5Rum4sjZHF2y/h0dbng7DKOEmxNoPdbxULukc8kHoloDkXhYL9sKqWCrs9VpM3RxYc1VlYkncdYDLpUrM0Nvwp/5e5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725828731; c=relaxed/simple;
	bh=WFLcP+KQCqOquO+3jU9XmdDfCmJ2fDT1r262MXhyGZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SVynVw2z3fw1CR+NLLO9TLHLmfkkYhZeeY/94O4q0JljOTHXwgyIyg/uBqnUzYjEpcICxSrsIwTxzakwogMjgixBPyI6FlW9Cb69LgwAUTyOqrifPhi+zoAjeveuYT4CQTyudI4Cv9wRzT7aTJOAhUDRIhcuPf5KBoCeqlp7494=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GJQJqcx6; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2da55ea8163so2610648a91.1;
        Sun, 08 Sep 2024 13:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725828729; x=1726433529; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Do9uQL1svkTVMYX5XXwR7FApqFQnFVGbvN0JvWZ55Js=;
        b=GJQJqcx6NrWt9mlDNJeMGTP3TYckMrbMYeCmk3d0xpk51q/rPkToSpsaxv+6bpNH1N
         URg/5dPGUfzFssQNO6ZBxICdk9ye91VuAJ4VO1Z5i9fIT3UQY73mKkfVE6ot+/qfZcE1
         fTDg0tfVSD12WIWZAlhcU/S5P/5Wy1WhluMgnqWHaoIDHSA8zlK8UwArJQSSPWO27qqj
         4EsYVYNbtU2fJ1Gg+H0L3yt8WGO0lYz2WieyctLoOvh1ySoqp+RjJxsQK/vSyv1pmrLK
         Suc2ZhzuPVZ+gq8oTqTwPGvukqpEqRQN8yoJwfrJwvT0HN00lOvrU3QQIi/OYljPlVwF
         3PIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725828729; x=1726433529;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Do9uQL1svkTVMYX5XXwR7FApqFQnFVGbvN0JvWZ55Js=;
        b=MPZliy04X7XNAh/kDpspHL8Z+izk4F8iPf7xfN+/RvpUpjz2DKI6wIwvtrwRxz8V02
         z4vvzm1kiyU6bF657BDkUVi6ppwh+nyUobsSOimtJNV+jfl1VtX7Z/YEz0Hf0fvNb1az
         enQYxJkyXRnLHWirSyrYsKs3P+WZMyY8J8Cb33ghh8LMH/kbdj2khCxynDrcLddPMKCj
         VxLp8m7rDveg7/96m8wwvKG4hogiI4g9VHfU3IH8u9NiUx01LHFGxsrqfyH0OJoYtOAt
         HrF2qcwyuuyyp/oBd/gBzWA6OaQfcQ05EcC3f1Q1JCKdUQU/RCe4cnnzT1UJjISavLnH
         tMBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPPq7qe2r2FNprd//10D4B6HBo7DnMhStHzP+dLY9HdmVuBILeY8CHutJpwqoNerkFfULMERsN7x9/+QPK@vger.kernel.org, AJvYcCVHEnj1taXN8jugAqcjae6449dLwtfQO56sGxBNoB3nUET6Hq8HarFaqcaI2a5cM6MX36U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmEluEfuQ/NEu98Z+tjjF3QPUw++RO1G+58Fqy5jfs/o0tUBg9
	MmGso+OZB0DaDo+hagABwmIYVTt2mR7tVsJ+VNYl83SenqNAVFPs
X-Google-Smtp-Source: AGHT+IGhDxknc26KrAM3JR2U4DgMaDnzsxai0mKLD7DQ5Iya9tVBRKQb/u3qm2L8xDufVrd+0lD4Dg==
X-Received: by 2002:a17:90b:384e:b0:2cf:cbc7:91f8 with SMTP id 98e67ed59e1d1-2dad50fc904mr8022707a91.19.1725828728773;
        Sun, 08 Sep 2024 13:52:08 -0700 (PDT)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2db04136902sm3077744a91.6.2024.09.08.13.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 13:52:08 -0700 (PDT)
Date: Mon, 9 Sep 2024 04:52:03 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Quentin Monnet <qmo@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
	yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	jolsa@kernel.org, jserv@ccns.ncku.edu.tw, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bpftool: Fix undefined behavior caused by shifting into
 the sign bit
Message-ID: <Zt4Oc+4/DPqDSsoN@visitorckw-System-Product-Name>
References: <20240908140009.3149781-1-visitorckw@gmail.com>
 <4a42a392-590d-4b90-a21d-df4290d86204@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a42a392-590d-4b90-a21d-df4290d86204@kernel.org>

On Sun, Sep 08, 2024 at 08:48:40PM +0100, Quentin Monnet wrote:
> On 08/09/2024 15:00, Kuan-Wei Chiu wrote:
> > Replace shifts of '1' with '1U' in bitwise operations within
> > __show_dev_tc_bpf() to prevent undefined behavior caused by shifting
> > into the sign bit of a signed integer. By using '1U', the operations
> > are explicitly performed on unsigned integers, avoiding potential
> > integer overflow or sign-related issues.
> > 
> > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> 
> 
> Looks good, thank you.
> 
> Acked-by: Quentin Monnet <qmo@kernel.org>
> 
> How did you find these?

TL;DR: I discovered this issue through code review.

I am a student developer trying to contribute to the Linux kernel. I
was attempting to compile bpftool with ubsan enabled, and while running
./bpftool net list, I encountered the following error message:

net.c:827:2: runtime error: null pointer passed as argument 1, which is declared to never be null

This prompted me to review the code in net.c, and during that process,
I unexpectedly came across the bug that this patch addresses.

As for the ubsan complaint mentioned above, it was triggered because
qsort is being called as qsort(NULL, 0, ...) when netfilter has no
entries to display. In glibc, qsort is marked with __nonnull ((1, 4)).
However, I found conflicting information on cppreference.com [1], which
states that when count is zero, both ptr and comp can be NULL. This
confused me, so I will need to check the C standard to clarify this. If
it turns out that qsort(NULL, 0, ...) is invalid, I will submit a
separate patch to fix it.

BTW, should this patch include a Fixes tag and a Cc @stable?

[1]: https://en.cppreference.com/w/c/algorithm/qsort

Regards,
Kuan-Wei

