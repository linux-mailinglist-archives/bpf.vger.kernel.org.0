Return-Path: <bpf+bounces-55560-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E66A82E0C
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 19:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD5B31B62C97
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 17:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16471276046;
	Wed,  9 Apr 2025 17:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ebmd7KGB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDF626B966;
	Wed,  9 Apr 2025 17:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744221280; cv=none; b=SMEJd6LMhrcba1xG6VXLo2o+COySCtiyghSacueo4LxKHbfzF2MkTXzmelGWO57wM74Clf7PvB6NCgeS3MriFmTwUlYrkQJaA5aN3k3hGofYMqqBiBGMpvLNEpWi4h1t9IHcHqwQRPx8Ra106jviQ08hlF73c4kbc+jDX1v1qRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744221280; c=relaxed/simple;
	bh=KV8Gr6aibJsRtpeVHbUAUlRhB0veTfaY3cN18G/7Szo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pi9jIWCK7Q69PwD23DhiRrAxubk2B43akp8mU68OaoWqdTCRZh6t9nfbiEu7sMm2OIas0nNPqMJzB3TWJuY/fXwiBCbzOMthOR2otSMDUDUhiM+ww2IsH0jjMlS3LKoZT4VAOV156Ecl7G4yGcVyYgWl9Q+ICN4EjglHFCk2AuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ebmd7KGB; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7399838db7fso7099b3a.0;
        Wed, 09 Apr 2025 10:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744221278; x=1744826078; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zIQZXyBX0AytvzBB0OOKXXRLrUfu5UCGT9piUz6hbi0=;
        b=Ebmd7KGBfnEKhZ0NsiYYxx/iZYVfhhbMbHfC+X1D+4L3Jq8OzVhwx4su2u1/b8Fu5X
         AghstD9zcfC0RGl+21CMYx23zpIEHMsf3pSrQU9omlGDYoCvyRG+5+b4GtgS+V8ZHr2/
         UysGHANe8OnEksIfprEAUFwatEcRnt8UvJt+lM607704jeW6AgHxdSD9NNDqeeQMoPt9
         8qTN12uUbFS3Qem3kvsJbSIeDOJVLWlf4XPhpuVkoCcfshNNCekxsth604R6hzF/s4mV
         /Vi62WvZlMiIGiRV1Fx6x4w7JHKesN7qrrfJ5Fj4BXUaFY8OaOf5JJBSVnm463ndevzF
         u7xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744221278; x=1744826078;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zIQZXyBX0AytvzBB0OOKXXRLrUfu5UCGT9piUz6hbi0=;
        b=jfNYPUIhUmHAnX/urSNbbb/MgOms2b40X9LHDAEXtX5QeW2aVQ0kbIK12pIvKxboyw
         cdjHWq2rxA/Cr5Jhfg5Bh65YVorEzTIkHH9fZ0fMds+JzuXNH9UP8SeyskijP7Pv6ECj
         thKJfX4eQLrHZRCLjwhEywUVRN1ZQKc5jwInvx756WNu0cGjy2AXTMfaCxva9qKW9oRs
         4NymP2St1RrmSG5uS1RSUnmlYkuLU916zwl3bUxNw2rEBlY0Gd4J4D2M8pRUP77cmyXt
         /sEF4SzLxjRhzmE3bRvAgeynnmSLkLRNWrSuhjFUduJo+K1aKNuOjZ6at7TNTSPfcoqL
         vuww==
X-Gm-Message-State: AOJu0YyqalGGr0lKL/WaWdsBormer0cvyOO2dskKp1mt1AaCvQ3Pf8IZ
	LYRdefTHSBpwsm8xe4uxUe6wt/bNi39ONjWLCVsztnAuPO0VKs87uQvy0A==
X-Gm-Gg: ASbGncszS3GU6VtzWOPxarzmDpU0BFrhFPtOznIYOdal0ArfJCE+b4b0a0Jq32b4xOd
	qGqO+0FL3ZCyknGbh/pbaPVhgDvo34frdYSp6OlghBvPR6BgUGI+zQ6cp9qJHCuPMugVYuAlbwQ
	nbBE1bwGkKbTjnvJx2d6XWJ17iV/Im5wLoJgglSCvYs+bttXD5103+H6xDXl1f2Ki2vyLsINf1z
	cJeT44byRwKr2qxkceYzn0gTMxMM8idOnB7rac1RJtmO3Yf3nobu0Vu6Jb3VWCO0W29foO12UK4
	7x1vu/2AAip+pBIrLq+QsJs1tvvRKyonFrACt+outUJHd+aMVqPXl4I=
X-Google-Smtp-Source: AGHT+IHNuuFWf1d3sRu2voHSJ5IXdWmy4lcV/fLgSMmiaLE2NiLd18OYO2sW+28FFfhx3FHsD4tDtg==
X-Received: by 2002:a05:6a00:1411:b0:736:4d05:2e35 with SMTP id d2e1a72fcca58-73bbcc1425bmr510930b3a.3.1744221278109;
        Wed, 09 Apr 2025 10:54:38 -0700 (PDT)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bb1e3824asm1693952b3a.103.2025.04.09.10.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 10:54:37 -0700 (PDT)
Date: Wed, 9 Apr 2025 10:54:36 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, jakub@cloudflare.com, john.fastabend@gmail.com,
	zhoufeng.zf@bytedance.com
Subject: Re: [Patch bpf-next v2 0/4] tcp_bpf: improve ingress redirection
 performance with message corking
Message-ID: <Z/a0XH5lqh7raKd6@pop-os.localdomain>
References: <20250306220205.53753-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306220205.53753-1-xiyou.wangcong@gmail.com>

Hi John,

On Thu, Mar 06, 2025 at 02:02:01PM -0800, Cong Wang wrote:
> This patchset improves skmsg ingress redirection performance by a)
> sophisticated batching with kworker; b) skmsg allocation caching with
> kmem cache.
> 
> As a result, our patches significantly outperforms the vanilla kernel
> in terms of throughput for almost all packet sizes. The percentage
> improvement in throughput ranges from 3.13% to 160.92%, with smaller
> packets showing the highest improvements.
> 
> For latency, it induces slightly higher latency across most packet sizes
> compared to the vanilla, which is also expected since this is a natural
> side effect of batching.
> 

Per our in-person conversation at LSF/MM/BPF, you are okay with this
patchset. If so, may we get your ACK here? If not, please let us know
what changes you prefer to make for V3?

Thanks!

