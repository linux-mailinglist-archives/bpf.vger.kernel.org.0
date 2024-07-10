Return-Path: <bpf+bounces-34363-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF5192CB9A
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 09:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38BA52820F5
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 07:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1F5522E;
	Wed, 10 Jul 2024 07:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iU7XUdgg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300C1824BD
	for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 07:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720595229; cv=none; b=mEPMXuXOLiep5MQ2b+QCX0Gs1fAL/8Ka/zHgubUrDHQmcCZ5+I7M75ZOFKflllt4VUU41QSMdCrapEJFTtipyFKFMLgje/ridrxNVm3NSvVqB+xqbo3LZbzfDqDjDM7zxjLuED2SGIDNrvuXJV7ISI18Ex+kk1AVZlvub68if78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720595229; c=relaxed/simple;
	bh=mVmE5gIrEdcvECroL06IiyGkZBo7w4GsyESlZyH6jIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WUFV+0pOzzR7TY9NzpNtQJi0VBEHI4UfNYtnNDrzZaSw0ZLt64BukulpHufFzBNzekIWcplrp/rJdG6H7nArbP1OZMr0xIn9d4M6RiW6BBkfH8NfByxNfRSgBGzTRDu8YbG3+GzfL/Dv6rHdsQJZTJXhc8aNDZhx+tIXOB/WNMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iU7XUdgg; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a77c0b42a8fso72478166b.1
        for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 00:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720595224; x=1721200024; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2uyCRIA2FfVnJhsUvyj/A/3TuaTT/k+FI3pU616uf94=;
        b=iU7XUdggtNXa9bti1mRhQykzn+aS3pTrGxPLxP0rVcaSEvoZQGNKKS8i1Yu71kvBIu
         XEVfr3He0IqBYPf9LullarMSKFvYSZXT0c4OO1uf4l3uXVU/SnAgNcFuc7sozYj8JJEf
         lDQa0nL4093EYMzDLzOwCZqum67REhjasqchfCohUhjCz0HEm02MxO97fAo3PH86vndJ
         /ViFKUsQbxE3O6r/UfW8HexYLJjnp0EL0emhmlOF0257bKvT01tXH6z4bwBGyp6UB4wj
         oiCv/xIG8CXo4IX912wi3jgHqtPLmJjOzulCur0nf4euyRa1R0SumrqEoBzdgZ/9aYbe
         knoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720595224; x=1721200024;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2uyCRIA2FfVnJhsUvyj/A/3TuaTT/k+FI3pU616uf94=;
        b=uV8Y6wFi7orm7H7HwWXQfHDmc4wtRswnwH3R3uO29mWgQbr2TKNPviykoLG2fQYe2N
         oubemgEQeRAeyPHTQyUD7iFdi3/53hclfEAfoXthPfGwlALmjZM5SnE0zFKdFTtEb49g
         jiZ3zQqJ0ORIGNcSO9NTQsagQxlnlYJvQUimOdz6CH+yB/F28U9pa1q4NA3k7RDCpaKg
         G6RaDQEfi9M5hnvxGN/Dq1VCrdZZ2g3elDjOWPGl74CF8WnrqwiKFYO3HrSWY1YvYelH
         rqSfcG9BtLJMe+40W12VgjtGTbuifoAzBiZx7bM/zvVhdmVWbyQF4wucSZRotH3vLZ+8
         MfOg==
X-Gm-Message-State: AOJu0YwkIP7TGOVQVKr3h4eJ4WaLerofpKjNMwJ/I9A0QdthC8TIetIs
	WnuvvrmbqVKirqbCzKDeNnqK5CTdgkm519u/bmWXsdI1ZFWDjXUVSLe14yWW2A==
X-Google-Smtp-Source: AGHT+IHHxBOqggeNl4cbqfq9svAG0iboXmtGcBKHM9zRC3vYTpdlsSe1tEpiBZPz6xU/gd5zfcFNmw==
X-Received: by 2002:a17:907:3f24:b0:a77:b7fe:66c8 with SMTP id a640c23a62f3a-a780d218c67mr351137666b.15.1720595223957;
        Wed, 10 Jul 2024 00:07:03 -0700 (PDT)
Received: from google.com (94.189.141.34.bc.googleusercontent.com. [34.141.189.94])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a6e04fesm133897066b.68.2024.07.10.00.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 00:07:03 -0700 (PDT)
Date: Wed, 10 Jul 2024 07:06:59 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, eddyz87@gmail.com, kpsingh@kernel.org,
	sdf@fomichev.me, jolsa@kernel.org
Subject: Re: [PATCH bpf] bpf: relax zero fixed offset constraint on
 KF_TRUSTED_ARGS/KF_RCU
Message-ID: <Zo4zE1KCRELxFuLA@google.com>
References: <20240709210939.1544011-1-mattbobrowski@google.com>
 <CAP01T77XeZBAY6KJJcKexw=EKRLrcsnmigb8B9D0Cv8Z2KcRfw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP01T77XeZBAY6KJJcKexw=EKRLrcsnmigb8B9D0Cv8Z2KcRfw@mail.gmail.com>

On Tue, Jul 09, 2024 at 11:23:34PM +0200, Kumar Kartikeya Dwivedi wrote:
> On Tue, 9 Jul 2024 at 23:09, Matt Bobrowski <mattbobrowski@google.com> wrote:
> >
> > Currently, BPF kfuncs which accept trusted pointer arguments
> > i.e. those flagged as KF_TRUSTED_ARGS, KF_RCU, or KF_RELEASE, all
> > require an original/unmodified trusted pointer argument to be supplied
> > to them. By original/unmodified, it means that the backing register
> > holding the trusted pointer argument that is to be supplied to the BPF
> > kfunc must have its fixed offset set to zero, or else the BPF verifier
> > will outright reject the BPF program load. However, this zero fixed
> > offset constraint that is currently enforced by the BPF verifier onto
> > BPF kfuncs specifically flagged to accept KF_TRUSTED_ARGS or KF_RCU
> > trusted pointer arguments is rather unnecessary, and can limit their
> > usability in practice. Specifically, it completely eliminates the
> > possibility of constructing a derived trusted pointer from an original
> > trusted pointer. To put it simply, a derived pointer is a pointer
> > which points to one of the nested member fields of the object being
> > pointed to by the original trusted pointer.
> >
> > This patch relaxes the zero fixed offset constraint that is enforced
> > upon BPF kfuncs which specifically accept KF_TRUSTED_ARGS, or KF_RCU
> > arguments. Although, the zero fixed offset constraint technically also
> > applies to BPF kfuncs accepting KF_RELEASE arguments, relaxing this
> > constraint for such BPF kfuncs has subtle and unwanted
> > side-effects. This was discovered by experimenting a little further
> > with an initial version of this patch series [0]. The primary issue
> > with relaxing the zero fixed offset constraint on BPF kfuncs accepting
> > KF_RELEASE arguments is that it'd would open up the opportunity for
> > BPF programs to supply both trusted pointers and derived trusted
> > pointers to them. For KF_RELEASE BPF kfuncs specifically, this could
> > be problematic as resources associated with the backing pointer could
> > be released by the backing BPF kfunc and cause instabilities for the
> > rest of the kernel.
> >
> > With this new fixed offset semantic in-place for BPF kfuncs accepting
> > KF_TRUSTED_ARGS and KF_RCU arguments, we now have more flexibility
> > when it comes to the BPF kfuncs that we're able to introduce moving
> > forward.
> >
> > Early discussions covering the possibility of relaxing the zero fixed
> > offset constraint can be found using the link below. This will provide
> > more context on where all this has stemmed from [1].
> >
> > Notably, pre-existing tests have been updated such that they provide
> > coverage for the updated zero fixed offset
> > functionality. Specifically, the nested offset test was converted from
> > a negative to positive test as it was already designed to assert zero
> > fixed offset semantics of a KF_TRUSTED_ARGS BPF kfunc.
> >
> > [0] https://lore.kernel.org/bpf/ZnA9ndnXKtHOuYMe@google.com/
> > [1] https://lore.kernel.org/bpf/ZhkbrM55MKQ0KeIV@google.com/
> >
> > Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
> > ---
> 
> Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> 
> Though I'm not sure this is bpf material since it isn't a fix, it
> might be better to base it against bpf-next.

Yes, sorry, this was based off bpf-next. I just happened to screw up
the subject prefix.

Thanks for the review! 

/M

