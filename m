Return-Path: <bpf+bounces-35769-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4FC93DA43
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 23:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9278428165E
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 21:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1807C149DF0;
	Fri, 26 Jul 2024 21:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0nN4oc0S"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A37911C83
	for <bpf@vger.kernel.org>; Fri, 26 Jul 2024 21:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722030580; cv=none; b=bncreAWk+TqAVFj4tW77xOnsE4cviOwiOJaYEq95FqdOM1hvZ1/B4Tm+disgP0nK4PPGt/FEWXciWMRv1hni06VxgfBS44Sm5qcKC8I+rZKaPGhqHwc/KO6u9V708FElOaJecgU8mQPmHmEPoR65CquYfwnvRKdByW+H4HUK5p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722030580; c=relaxed/simple;
	bh=ADZtYYxf96z9z4D23CRWwaRkEZxvbTeXx3gF8SqqvlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PX7HQTYEIjuLOk8PBMeUZjGVNvvZQ+r0z0WTvbZ25VCnOm0FfG/G8SuWwGg/nfkLJdh82EbO3kclFSnTYTohU6bK3CbkX1eY5olTBA29JUv7/vB4I60DSLT/ywrkgl43ca0hBWjeYrD7rpCL07yHR3UrUdE/k51Ar3lwBvT0Ea4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0nN4oc0S; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a7ab76558a9so356391866b.1
        for <bpf@vger.kernel.org>; Fri, 26 Jul 2024 14:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722030577; x=1722635377; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KR5C4E3vW0MD+HuH8szSgeR8H1u2mdzLNpa9LUydU6w=;
        b=0nN4oc0S3sLs814YNdATLKeZ9UplWc5paYPr6goxEuzw73vhi4XkDzNYmB5xxAPfSA
         k7oJHDP1+Sq0yrfOvSNdfq08xS9OW5/g/q0FJg2V2TQ31S+vFJa6e2HqSRW4mzTMgJx2
         XeqybyRbd6RBOMi7agnn1v11dlarRTWmwK4wZWq1bFj4Em4a+UZtREy8SPSRdXqv9s8Z
         yaOk5QhlgBHzMSW7/o057ryJNGiDMTcvkdtW32WxFKPd/qSV2DRauBKVPA2ttQg5tbOj
         WDdcQpY5YSyKpSj7CsMELB4SBlD7c1r+B/lxmfMFGyXmVC0Cq1BkAtmCZZGAp8vEAn9f
         aSiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722030577; x=1722635377;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KR5C4E3vW0MD+HuH8szSgeR8H1u2mdzLNpa9LUydU6w=;
        b=pYnksADLR7c2JMBWpUgupH5XO70Xr5Yt61LS8kslasuJ/z7r5obw3Dmr79pjJDt9U+
         QsuprbBXvo6uvsShuUA5Poy6SXmFYPR8wa8zPtqUDE/cvM0o437GSfXI/Z1h6+FUt7Ar
         a26sxEAW/zO/fNhUC26BQpO2yXxwlscYDtTAzDnsCQP3ReQfZySzNIxG4A1rGMAnX09I
         W5eil9WekV9J5KznejKpWSY9oHEU7GhZyubpis+WeKF0PQnBIRvc//NbEYxThetOluUV
         wM73aGpBI8AAWlwcfVNpSLjeCUr2HUVdzApvHu1BiWnsvdG6mXU/rvjTJQ740A6VnnmB
         TY2A==
X-Gm-Message-State: AOJu0Yz1iZM0x6joB9zp/HP3vKf/mw/nYmRv/+Yd/TMHPFTXFB+jlSZ6
	ljXC1g4YM1nLqzZxI7aCdHLj3tJwg/EjZxUgA3sR9XVZlLpmrRLkFyZoAo7zzxIkVsqAPhuE9Jg
	Igg==
X-Google-Smtp-Source: AGHT+IGiVSE1aqhxTcotYin0T6nVT5UfpQFvqfGBOr4PTOYBrxBPKl+kbQ4l1XbafZLDs51BOIfGJA==
X-Received: by 2002:a17:906:fd88:b0:a7a:a138:dbc6 with SMTP id a640c23a62f3a-a7d3f86b83bmr74894066b.8.1722030576831;
        Fri, 26 Jul 2024 14:49:36 -0700 (PDT)
Received: from google.com (94.189.141.34.bc.googleusercontent.com. [34.141.189.94])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad41621sm216753966b.113.2024.07.26.14.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 14:49:36 -0700 (PDT)
Date: Fri, 26 Jul 2024 21:49:32 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, kpsingh@kernel.org,
	andrii@kernel.org, jannh@google.com, brauner@kernel.org,
	linux-fsdevel@vger.kernel.org, jolsa@kernel.org,
	daniel@iogearbox.net, memxor@gmail.com
Subject: Re: [PATCH v3 bpf-next 1/3] bpf: introduce new VFS based BPF kfuncs
Message-ID: <ZqQZ7EBooVcv0_hm@google.com>
References: <20240726085604.2369469-1-mattbobrowski@google.com>
 <20240726085604.2369469-2-mattbobrowski@google.com>
 <CAPhsuW7fOvLM+LUf11+iYQH1vAiC0wUonXhq3ewrEvb40eYMdQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW7fOvLM+LUf11+iYQH1vAiC0wUonXhq3ewrEvb40eYMdQ@mail.gmail.com>

On Fri, Jul 26, 2024 at 02:25:26PM -0700, Song Liu wrote:
> On Fri, Jul 26, 2024 at 1:56 AM Matt Bobrowski <mattbobrowski@google.com> wrote:
> >
> [...]
> > +       len = buf + buf__sz - ret;
> > +       memmove(buf, ret, len);
> > +       return len;
> > +}
> > +__bpf_kfunc_end_defs();
> > +
> > +BTF_KFUNCS_START(bpf_fs_kfunc_set_ids)
> > +BTF_ID_FLAGS(func, bpf_get_task_exe_file,
> > +            KF_ACQUIRE | KF_TRUSTED_ARGS | KF_SLEEPABLE | KF_RET_NULL)
> > +BTF_ID_FLAGS(func, bpf_put_file, KF_RELEASE | KF_SLEEPABLE)
> 
> Do we really need KF_SLEEPABLE for bpf_put_file?

Well, the guts of fput() is annotated w/ might_sleep(), so the calling
thread may presumably be involuntarily put to sleep? You can also see
the guts of fput() invoking various indirect function calls
i.e. ->release(), and depending on the implementation of those, they
could be initiating resource release related actions which
consequently could result in waiting for some I/O to be done? fput()
also calls dput() and mntput() and these too can also do a bunch of
teardown.

Please correct me if I've misunderstood something.

/M

