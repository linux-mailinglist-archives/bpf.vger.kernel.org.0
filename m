Return-Path: <bpf+bounces-58102-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F76AB4C5A
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 08:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88B6286822C
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 06:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B141F098A;
	Tue, 13 May 2025 06:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EppbS1Pt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DBF1F03D6
	for <bpf@vger.kernel.org>; Tue, 13 May 2025 06:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747119354; cv=none; b=DPsw0Zr/XZ3GtFdIfou+woAlggfRNlUdOVA00A+ZCIIDiO4uksW3gyqbQjaY9M+ND7O+POXlqAO82CRhPCMK7QnZwvWooPrJlOwPAiFPeXyPYJzNPAMhPSSvjIIcE+70OdCyjXCd+427TydSUzfVRArpiUMnJnruL1s7ntYZ2GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747119354; c=relaxed/simple;
	bh=CNwMZT9WQrA6EdVJEgo05UMzWBM4RqtEzt039Ek93xM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Idu9dmsua0cpu1gq3WWTd3QXN4zjVhjvD7/bynu5BWQ5+8aunw+WAWsdPsbkkD1kOSdsH2T82emduHx4IXyzlUVLwl8acL4Ml0eLGxXERIEhwMAnw9pLaiC7cWcWrLqN9c4DJKA97cZ8VrmmBO6yJXZL6Xbd16ppxErKKRdD00s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EppbS1Pt; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5fbfa0a7d2cso8833567a12.1
        for <bpf@vger.kernel.org>; Mon, 12 May 2025 23:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747119351; x=1747724151; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z2xRiSFv5DUxreBQg2Vos9MdPz8VRSwkIGSa4Iomr6U=;
        b=EppbS1PtYmmj9Hhtqgy6JIkibTSsgxdbhaWLrvMXojUshgK4kiJ61bUayXitD5D4t6
         5BVzHRwaf16KEp8eY3RIqqSCo1N2ZuilOA9B7r2Y2yih6L5xMa3tWhla2rKYOdwzPKcr
         1lQD4kkVbAF1M5dCe+7pDVxPYcJUd81umb8+FefklYoL1Ub9r9CXZllqjWfD9eOW36Lw
         HRj0oHjoYu2kdEO/rLJ43ubVlHbqqJ3+gj7Gbje9uNi6vOYYUD5XdGati6vPcNw7ZohO
         68cHj/kK2nku1iKfsc+pvbSbgsnHJOWaqVOu+9mBwrpwreNuEAxVWayXWWnUN9EYO1ME
         T2dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747119351; x=1747724151;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z2xRiSFv5DUxreBQg2Vos9MdPz8VRSwkIGSa4Iomr6U=;
        b=dMrqbKYT8dB8xbwLaDW6HmdDRWyczigGXuyw4seGCupLqStyeMt3S9kumFpFnyLM0+
         iAVLm7jSVNUqkpqvDKgS/j84WpwPW+A0ASh44Ro0FDP2479Lo4KVIvbN2F0Y6T1DGcAk
         F9frwwSx7WYAQ+1626tYOQyzK2uvrZKEJ+TocM6ocQwsqtGEWmZMeAW/k91Q47f024g0
         LVA6y+lC2+wIN0mn2agDuwpif1po0WsGkNeYtC28ACPCoNgkWqBYjl9MSglxA1e1U9h2
         dWcHqUf8wu9cNn29+Zi3SS0u6eYNr2XZORkmIytNe6D6adDB0ddZfareTAJMZzEyHlsI
         da4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXro4UzXmbZuKodO1KpXZSxyXDhT/QEgfiW5Jiz9NHIEgYMKjve+XY55iqYkk/KkgIbhu0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf3gyWhcwkS3RrDCJ5+ROt8IGvngXb1s+EM6dg+tbd6YSs/eu8
	cc2oca5tmKMtGsiRghGCVfeFS0UBxXw+rpAoxByUVnUxwnCoRkh96AFI8/+ihw==
X-Gm-Gg: ASbGncvjVzNZuvnny1VPTstKxXowB7DtTEJvFiCJ7vIteOmbDhZoM0RaBrwXs9CGILn
	VKSnljDD20WUMvNvxHK0yip+MvBEEV8s4+iN5tNsM/UXKi6Cif/3IrvbVAgEe74MMXYwA6crUWF
	xl+qgx4B4GSPFthnSRxX5WDnAqMMKZzMQj1XzazsuBxzDnT+Tei9EE/ibDBM+t06082I1D16HMI
	dK4v+U6yhIZqFxk+Ecoz8gakx8Z+du6icm28JbzkiylmdaXeooVJYILJIf5NCAgYD8Ae3pL0Bxd
	OTxgAdC5ZF4jGkpbkUoqooZZz7y2OiF3BijuWm3Iut5FlWkQ3ox34FMJ/5Rbs2y4HipL1249lRZ
	nKQ1iKAALk1MvJ2nQkw==
X-Google-Smtp-Source: AGHT+IEJcWAfvRS3kBvpInjaCmKU8N/uYiVZUsBrTjTyDMdtwenObnLSTYADlQEa479B/uOO9FGD5w==
X-Received: by 2002:a17:907:998d:b0:ad2:4eb9:d889 with SMTP id a640c23a62f3a-ad24eb9da87mr593957166b.30.1747119351130;
        Mon, 12 May 2025 23:55:51 -0700 (PDT)
Received: from google.com (201.31.90.34.bc.googleusercontent.com. [34.90.31.201])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad21988d43asm738207466b.178.2025.05.12.23.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 23:55:50 -0700 (PDT)
Date: Tue, 13 May 2025 06:55:46 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Viktor Malik <vmalik@redhat.com>, bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v4 2/4] uaccess: Define pagefault lock guard
Message-ID: <aCLs8rUaO2q4NViq@google.com>
References: <cover.1746598898.git.vmalik@redhat.com>
 <39416cac1d011661601caffc6ac38195c82ede86.1746598898.git.vmalik@redhat.com>
 <aByA1wael6H4tMo8@google.com>
 <CAEf4BzbggjOmEziyLjSRSsEQzLMMXQGoEJ6SODVF2exLR1S9UQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzbggjOmEziyLjSRSsEQzLMMXQGoEJ6SODVF2exLR1S9UQ@mail.gmail.com>

On Fri, May 09, 2025 at 11:20:48AM -0700, Andrii Nakryiko wrote:
> On Thu, May 8, 2025 at 3:01 AM Matt Bobrowski <mattbobrowski@google.com> wrote:
> >
> > On Wed, May 07, 2025 at 08:40:37AM +0200, Viktor Malik wrote:
> > > Define a pagefault lock guard which allows to simplify functions that
> > > need to disable page faults.
> > >
> > > Signed-off-by: Viktor Malik <vmalik@redhat.com>
> > > ---
> > >  include/linux/uaccess.h | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
> > > index 7c06f4795670..1beb5b395d81 100644
> > > --- a/include/linux/uaccess.h
> > > +++ b/include/linux/uaccess.h
> > > @@ -296,6 +296,8 @@ static inline bool pagefault_disabled(void)
> > >   */
> > >  #define faulthandler_disabled() (pagefault_disabled() || in_atomic())
> > >
> > > +DEFINE_LOCK_GUARD_0(pagefault, pagefault_disable(), pagefault_enable())
> >
> > I can't help but mention that naming this scope-based cleanup helper
> > `pagefault` just seems overly ambiguous. That's just me though...
> 
> I do see the concern, but
> 
> DEFINE_LOCK_GUARD_0(preempt, preempt_disable(), preempt_enable())
> DEFINE_LOCK_GUARD_0(irq, local_irq_disable(), local_irq_enable())
> 
> so we are just staying consistent here? But also "guard (against) the
> pagefault" does (internally) read somewhat meaningfully, no?

Now that you've written it out like that, yes I do agree, that does
read somewhat meaningfully. I also don't have any better suggestions
at this point, so I think leaving it as it is now is also totally
fine.

