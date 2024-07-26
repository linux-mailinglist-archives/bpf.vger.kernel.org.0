Return-Path: <bpf+bounces-35759-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC81093D9BE
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 22:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 783532853A8
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 20:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E46C1474D7;
	Fri, 26 Jul 2024 20:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ULYVPf2S"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8DF156241
	for <bpf@vger.kernel.org>; Fri, 26 Jul 2024 20:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722025374; cv=none; b=smGlns2C7b5bt4sDcBDjnqj8As1wvhOX6iWzX6awMqzePmgjpQlCR9DQ4SNacwIrkt7mkmyfjPuVyAyCruI5FWvQe7T/Kg1vcaUHZldkEgtvomZpaMY2Fv1WhZZakVlxziSXzDzaXY3Ma1f6PXaS+k6HuNBjk65cb/aPDv1pBQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722025374; c=relaxed/simple;
	bh=4/f3Xo24SJMFivSCJPTpxwyYe9pSYt4gKjHMxidRGx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MOs5YxQdM1+g0xQCM8Jjyko0hwgdOg1eKRxcgFlWU3qZb95dof1lR4RtG2q+gjHge//M+5mEor4FaQSFztG+M3so+rJbgBu0O5ygailhl9k0OKMfejdFWm4RSUHCjIyLR+gjdIY5RS5YM/mT2+Zr2ma5AJLn6H2Z0eKKvryi7LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ULYVPf2S; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5a20de39cfbso3008871a12.1
        for <bpf@vger.kernel.org>; Fri, 26 Jul 2024 13:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722025371; x=1722630171; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S7HAGYTiYeeW7YJ1F5U/ozUy8sPLtbSIKZubmtiBSQA=;
        b=ULYVPf2Sx8oloM3u8fg1pTt1tDSKKwJnS9KU9t9oDQvKmkwoDGUxywMurgOXdBE5hp
         dKOo0aSfWnlXJVY+g3QwFryFNThmNCNhgiVCqZW1Yf/FIbyugf0Nl9pc+rZi5o1M5FN5
         cVS+WwqtmC+FN6C/WjV+g2OzFWgcgLU3qWPiDJc4gLsaHtXY72Por+g3TjrqX89076jQ
         iec7En3sZejwymjTlpJno8wfu+J4TJcMkBFURFen+KfchyW3V9v+Og+jkv7IAJqtxMhQ
         HG/ZjDveeEo+LDssNswEH06lo26sM0qRp0RYFQwW8BA33ksRuNxT9qUOGmbSSc4oHG9n
         sDCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722025371; x=1722630171;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S7HAGYTiYeeW7YJ1F5U/ozUy8sPLtbSIKZubmtiBSQA=;
        b=asuU95Q/gsmIjGJw/3ZoPKtU0pzNWbKmlsiZmbTJow9kabWgDvoC5TvwjIGch4IGk1
         L9ozv6UekYMpFfYBL0Nz1aGlMVnYMemxyb8JgXbUCUx58ljJx3+0Jwo63a/1UXaiK42i
         u2840Cd5dQsINICy+tZzxOn7QgbYJmli5SwkD8waYWdDMSfTr9+ZsrZYvMMTnjt0SStn
         K4zFLFTO+pwWPU/wQcgroohJ2MWC89e34R8CgWIllorTDf72Tgk80sWGR4bBa4EFML37
         J7FKPSm6XT4AIGTd193HNJDVB6/A9v8op4bt64jjl0OAnvnR6m/gVf+JoFlZpXtKQ+zP
         qzdA==
X-Gm-Message-State: AOJu0YzN2ckkXhxzzEitNNPjAVPqxdOMIvxItHPPIPU4t2G+EDJEt5C7
	Qy2g/nW9zy2OSP8RMuH0xWxphSvjARr6mo/5zTBEELDEpHnvGFRb29vy5/iGKg==
X-Google-Smtp-Source: AGHT+IHn7Qj4xJ54JiU2fA8L+KkgDua35UOzDzwnx5obdeUHlcIDiEv3JJXgLuobKLcC7fZRXU6xCQ==
X-Received: by 2002:a17:907:1c19:b0:a7a:8c8d:40ac with SMTP id a640c23a62f3a-a7d3ffc2717mr47705866b.4.1722025370071;
        Fri, 26 Jul 2024 13:22:50 -0700 (PDT)
Received: from google.com (140.20.91.34.bc.googleusercontent.com. [34.91.20.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acadb8356sm209604066b.206.2024.07.26.13.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 13:22:49 -0700 (PDT)
Date: Fri, 26 Jul 2024 20:22:45 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Christian Brauner <brauner@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, kpsingh@kernel.org,
	andrii@kernel.org, jannh@google.com, linux-fsdevel@vger.kernel.org,
	jolsa@kernel.org, daniel@iogearbox.net, memxor@gmail.com
Subject: Re: [PATCH v3 bpf-next 0/3] introduce new VFS based BPF kfuncs
Message-ID: <ZqQFlRiH17ewtOau@google.com>
References: <20240726085604.2369469-1-mattbobrowski@google.com>
 <20240726-clown-geantwortet-eb29a17890c3@brauner>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726-clown-geantwortet-eb29a17890c3@brauner>

On Fri, Jul 26, 2024 at 03:22:09PM +0200, Christian Brauner wrote:
> On Fri, Jul 26, 2024 at 08:56:01AM GMT, Matt Bobrowski wrote:
> > G'day!
> > 
> > The original cover letter providing background context and motivating
> > factors around the needs for these new VFS related BPF kfuncs
> > introduced within this patch series can be found here [0]. Please do
> > reference that if needed.
> > 
> > The changes contained within this version of the patch series mainly
> > came at the back of discussions held with Christian at LSFMMBPF
> > recently. In summary, the primary difference within this patch series
> > when compared to the last [1] is that I've reduced the number of VFS
> > related BPF kfuncs being introduced, housed them under fs/, and added
> > more selftests.
> 
> I have no complaints about this now that it's been boiled down.
> So as far as I'm concerned I'm happy to pick this up. (I also wouldn't
> mind follow-up patches that move the xattr bpf kfuncs under fs/ as
> well.)

Wonderful, thank you Christian!

I agree, those should also reside in alongside these newly added BPF
kfuncs. I'll send through a patch addressing this
separately. Generally, I think the same applies for any other VFS
related BPF kfuncs that end up getting introduced moving forward.

/M

