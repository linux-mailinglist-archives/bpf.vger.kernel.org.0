Return-Path: <bpf+bounces-36484-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17BDE94973C
	for <lists+bpf@lfdr.de>; Tue,  6 Aug 2024 19:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B386B21FAB
	for <lists+bpf@lfdr.de>; Tue,  6 Aug 2024 17:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E695F78C8B;
	Tue,  6 Aug 2024 17:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="dfdWBFOl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FC974C1B
	for <bpf@vger.kernel.org>; Tue,  6 Aug 2024 17:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722967143; cv=none; b=eIMIcSbSNK/W+cAPdJmVECjt+yeoicmJBTCf8+yYGwisTESV+KpjwrEZb/bLsWCh9ekyCl5g3km1Wqhc93Sp+NUihRDXPJBNJziuVKHAtkPXM6cHWZOG7MLpEpfDRpupBiXvFgvJDfgeRcRX9QG+E0gKIE6i48g3VDfdZQ0VCt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722967143; c=relaxed/simple;
	bh=Vr4ssX3LexIo2N6PgFRtbpKq5//JSwMuoHCZ2wWW88c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AQcP5vmPxapQbozFbBVTl1O21Y5uT/cQaltTSDk/F4hPqSEELgV2N4LYXfdiQiHeF1Y2eq4ePAAagaOWJEVf6O/2BHsT9/K3vKzNlmcSQmIXNIktdYiAMKyP5HEIKnUcs8fzgTFHRsPkC23jeieLjQMxr3anrfIXMkPZ6LHC9o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=dfdWBFOl; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3d9e13ef8edso522737b6e.2
        for <bpf@vger.kernel.org>; Tue, 06 Aug 2024 10:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1722967141; x=1723571941; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9reD6LjBIDqI3rzCI/2rJ/w7uTHYKxSa2MJZ9OknCy8=;
        b=dfdWBFOlaaALwxoIKu0QSosUVGXBLx4UNDbO54AvopPTo9IOW8/NzY9mQXQfJfHnpv
         7S+3ol2Kbt2hYwvLqhGzwl9aquRu/80zuvfXeD6qaKnefoTHn1mRUmb9tw2IRpaGYVcz
         V731EOf8WLioZ7giCcg44U6TR2aJXJi3q088YwzTDxAI4nRl32JY5XDG//QtE/QCAnj5
         cPgbU+W8RIW/rSq2Aun0u4bDRnnVGQ9BM+BabAKkBk6oy0GLaUZju+XBwww6a/3e3Pbq
         MVMTU9QkSngPFAzPaeeQAhEkOkJJcOEKOCznKXrrmloa7gGU1ZZOb6mpSfSzE3Spsaid
         fplg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722967141; x=1723571941;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9reD6LjBIDqI3rzCI/2rJ/w7uTHYKxSa2MJZ9OknCy8=;
        b=F0scAcZSnDi2OfzLOzioF5g20lX+vCSk2vcVBfnbwV1APUJG4UiJRl4ykjrU8Lthtt
         dTfSK7Ru/wzrrzHYoCko+n2K9ddrUSb3gpM4WnMVd2tKPDAIlZnM39K2I2B+nMrzY5il
         ALDXAM8hV7kC8eM2sn4TYpCAx2YLObzLmwiJOtvq94A5P/99Pq9TQPeT5ZefZb8TFxMk
         zq9VDQvLjEXn4Q7Ejfj+KGVt7Fv4slTg+F0emRmpmUZ7Ke3zU+QKwRICcxVMUCAQWuhi
         ij3y50uqnS4ITbUb9PFAwrI1QgnaDHVQ/ydfVJds42neLT7o+yzRaxi9RBOMQ3AKMbay
         tbXg==
X-Forwarded-Encrypted: i=1; AJvYcCV71pasqCRhjhFf1W1/Lj/pb0bhURy+HeuF3RAr9Aa7ho0Aii2HuI5vjm/tj3tUb6MMPzyOc2+g2DCilkFAqRqpdRuI
X-Gm-Message-State: AOJu0YzQyD24M08EjaQ0xzOu1L0T+9+CesPCs1lCMv/+QzZL7zmL55c8
	AcupxNJGFEr4wqmvvTvxu37e5fMwMpzTH+J/PRCjXyZ6xaJmr7znfNhCNN/kcl8=
X-Google-Smtp-Source: AGHT+IEwktuJ1CtYSzQb94QGzgaDodUnXytdXmjscinDnu4jw335ZRMBxJxoUFxjs8sU40IQz5cmUA==
X-Received: by 2002:a05:6808:2212:b0:3d9:e1d1:157e with SMTP id 5614622812f47-3db5582e299mr22117856b6e.35.1722967140874;
        Tue, 06 Aug 2024 10:59:00 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4518a6c547asm39893111cf.30.2024.08.06.10.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 10:59:00 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sbOSZ-00Fhpe-RT;
	Tue, 06 Aug 2024 14:58:59 -0300
Date: Tue, 6 Aug 2024 14:58:59 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>, bpf@vger.kernel.org,
	Amir Goldstein <amir73il@gmail.com>, kvm@vger.kernel.org,
	cgroups@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCHSET][RFC] struct fd and memory safety
Message-ID: <20240806175859.GT676757@ziepe.ca>
References: <20240730050927.GC5334@ZenIV>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730050927.GC5334@ZenIV>

On Tue, Jul 30, 2024 at 06:09:27AM +0100, Al Viro wrote:

> 	* ib_uverbs_open_xrcd().  FWIW, a closer look shows that the
> damn thing is buggy - it accepts _any_ descriptor and pins the associated
> inode.  mount tmpfs, open a file there, feed it to that, unmount and
> watch the show...

What happens? There is still an igrab() while it is in the red black
tree?

> AFAICS, that's done for the sake of libibverbs and
> I've no idea how it's actually used - all examples I'd been able to
> find use -1 for descriptor here.  Needs to be discussed with infiniband
> folks (Sean Hefty?).  For now, leave that as-is.

The design seems insane, but it is what it is from 20 years ago..

Userspace can affiliate this "xrc domain" with a file in the
filesystem. Any file. That is actually a deliberate part of the API.

This is done as some ugly way to pass xrc domain object from process A
to process B. IIRC the idea is process A will affiliate the object
with a file and then B will be able to access the shared object if B
is able to open the file.

It looks like the code keeps a red/black tree of this association, and
holds an igrab while the inode is in that tree..

Jason

