Return-Path: <bpf+bounces-35566-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6C793B90D
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 00:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00D741F232E8
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 22:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FEB813B5AE;
	Wed, 24 Jul 2024 22:13:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A133E13AD09
	for <bpf@vger.kernel.org>; Wed, 24 Jul 2024 22:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721859224; cv=none; b=IimkX2344Avy7sUERZZ8q5ushLH1uSCaX+FBiQMnRJmjUxTF0vCE8m7NMJUQIXjsoLULBfLc5d971kiOOl0PHRwBVZ3UlfzoTRGWK8bgcwIvjfkansOapAmSLU684Jl27J0kWRUyZa79suWiL3T6NxJBpsi7ONT24eF8Q+0kS/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721859224; c=relaxed/simple;
	bh=lvRz0P3J+J34cyN9fMecUR9+cVtxazSPh/p6p2u5Qmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=foV/eonrW9+vZedO4a4MTd0V3rEyxX1lsQA4WEQWziA2dXnYLJ4R9NuAU40N2eRlMCszQM1Hcsa0Qj2+4wzPu82+kw/iuwkHs3Lec9yEcTNbPo6vjnuSHTY0VQjqYks5ik/TskFVj/mzN/CXE7X7GUtGDAdmaydeQ2oQ7OXFO18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-260e8c98cc2so112710fac.0
        for <bpf@vger.kernel.org>; Wed, 24 Jul 2024 15:13:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721859221; x=1722464021;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x7iQtuatoIYavkPtQ48wt82qRdc37+6kTWhFJOGmrmE=;
        b=ld4fFdXAq5CyUKBJPBUU/nV3tN9av4pwIXx+eJyLJKNd6vsYy1jRZ8NHhGNnTwzwSy
         SgyG3hXufHU8NB8PLSddZbIJWm9+Rbf1izY5RClcS2VU1yfTgWfRkqKB/tcD1cSifnQR
         2CC9Ugz4D5fK9+OwVfRNlbUkbfJkO9cEU9Kk+jibwikIkFGnQkp0gNr5ZfN3h4Nzty84
         a35Gzur5Oo1tvK8L9IsJKI2wVVNCSgI4rSCCurXVweIppxXRVuhjWote+BsDQrW+bmj9
         9A6oGDk8ZRVSGlD/mrxHpYWr5H/OP2eVFfcb9+KGmmO6nvtxj6hEfQXxh9l8kineUUr1
         XGqA==
X-Forwarded-Encrypted: i=1; AJvYcCXUpH/JJ2qTFmlhze3XKsnbq0ppO8XdAZbot9GzZoZ7jxIYB0FcMSl6K0AEWrik7WjQ/RKryWOqB3VxeruyiJpQI+/S
X-Gm-Message-State: AOJu0Yy8uBvJFS2pxf/56LYPqTmfJizYVXW+Q8hM9p9A8K7bkrVl2vYs
	sDkgLH4yQq2d0TEyTEBI5MEjIQyjs8mEJ6r0k8ojRTChRyih+iQ=
X-Google-Smtp-Source: AGHT+IG8naVdaAtks34fv9hncuRdm4WsH5055Epp8/z5xE/tFtJFalhtV2HBpgXE+O9wvq5wQWK9WA==
X-Received: by 2002:a05:6870:b49f:b0:261:86d:89e4 with SMTP id 586e51a60fabf-266ede17897mr93755fac.36.1721859221543;
        Wed, 24 Jul 2024 15:13:41 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:73b6:7410:eb24:cba4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead8a39d8sm47882b3a.213.2024.07.24.15.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 15:13:41 -0700 (PDT)
Date: Wed, 24 Jul 2024 15:13:40 -0700
From: Stanislav Fomichev <sdf@fomichev.me>
To: Kui-Feng Lee <sinquersw@gmail.com>
Cc: Kui-Feng Lee <thinker.li@gmail.com>, bpf@vger.kernel.org,
	ast@kernel.org, martin.lau@linux.dev, song@kernel.org,
	kernel-team@meta.com, andrii@kernel.org, kuifeng@meta.com
Subject: Re: [PATCH bpf-next v2 2/4] selftests/bpf: Monitor traffic for
 tc_redirect/tc_redirect_dtime.
Message-ID: <ZqF8lFuDgGVNNfux@mini-arch>
References: <20240723182439.1434795-1-thinker.li@gmail.com>
 <20240723182439.1434795-3-thinker.li@gmail.com>
 <ZqEdE94dcBewr9Bu@mini-arch>
 <4b65a398-b938-44e1-a0b8-9a663c182577@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4b65a398-b938-44e1-a0b8-9a663c182577@gmail.com>

On 07/24, Kui-Feng Lee wrote:
> 
> 
> On 7/24/24 08:26, Stanislav Fomichev wrote:
> > On 07/23, Kui-Feng Lee wrote:
> > > Enable traffic monitoring for the test case tc_redirect/tc_redirect_dtime.
> > 
> > Alternatively, we might extend test_progs to have some new generic
> > arg to enable trafficmon for a given set of tests (and then pass this
> > flag in the CI):
> > 
> > ./test_progs --traffic_monitor=t1,t2,t3...
> > 
> > Might be useful in case we need to debug some other test in the future.
> 
> We run a few test cases with network namespaces. So we need to
> specify namespaces to monitor. And, these namespaces are not created
> yet when a test starts. To adapt this approach, these test cases should
> be changed to use a generic way that create network namespaces when
> a test starts.
> 
> Or, we just monitor default network namespace. For test cases with
> network namespaces, they need to call these functions.
> 
> WDYT?

Ah, true, in this case ignore me :-)

