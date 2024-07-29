Return-Path: <bpf+bounces-35877-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 178F193F3B1
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 13:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C08311F22AB5
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 11:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D64145B2D;
	Mon, 29 Jul 2024 11:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eRiUPkr1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86753145A14
	for <bpf@vger.kernel.org>; Mon, 29 Jul 2024 11:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722251469; cv=none; b=LLpZ28yJI7XkK4RHHQ2slAuCGvtFV3AhATJp2QQkVm3uvJiMzJrBBIzPG00FREgCGasEqSdynRpZgL2fz/9mUuRhvRA7ncmooVI9b+6ukrY5BOZNubkCvshwJfjvxtr1p++yxMFXsQMP1iIqmsfit2+fCeE8TuLWA0L5DJ3XUOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722251469; c=relaxed/simple;
	bh=+lX/SHox08hcAtJcVc06PuFtfxT7U1AMpGyl1FAohgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nLUXVK5uXqQ67S9O6cwRoZgdWKleGVcXr8UWqOMP2Nf+CXHIY56NEiPi/rl16UDSR1GljSOENAMxO/WWw6sDRKZuhRuSW5SQIxKh76X7in+iaG0N99G32zmBq+BkofJSz0QjFCr5N2Zp7KhxKgne4wTcde6pYtCOed2f+zCqwr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eRiUPkr1; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5a156556fb4so5441738a12.3
        for <bpf@vger.kernel.org>; Mon, 29 Jul 2024 04:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722251466; x=1722856266; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SR8C0Pku0GQE0cOLdJwd96dzmGHIOx8FTS7UlXAOujk=;
        b=eRiUPkr1uA4PcJ7xs+5TiRvzZcJa+V8dy1cQqxbbNOlHTXIWEQkljb7MixeXE+F2yl
         C/cBuaNtLmwCC1E42TcC9p+HFN4Xn9yYoA5FzEyvRA3c25j68iB1NwWNVzB7OLyQ+cUM
         nT8/0MPfFTnCOtocVVS5rdlxvMrvw5Z+E3pu8NU9nda0pPMTkbOaeMWf/cD/Q64pib7z
         Tkt269Tw7IhcqjW5TuSpwFpAhCiCJZxBMhYQibqYj1WocI3m8kQYcGzGYQRZrdNrCggw
         4e++0A1ZZch9a/lHeoubN5SUCFQb4LsFOo4v7PMj41hQfrRfJ0DS5aS2tspWTPRP55lZ
         0Hyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722251466; x=1722856266;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SR8C0Pku0GQE0cOLdJwd96dzmGHIOx8FTS7UlXAOujk=;
        b=e9axey/zc2t5JwhcWT76rp5aTS9dsVb76QPEzB3rl3uMGdKjwY615A2xPktxnE7x1C
         dD3W/2hX2rJFSIq5z/DFPTQ5CXhaAugMVJ5/cybdFr+rW2N/ISXZZCT2kSbIRu/NLU8E
         zLr8qNTzGO3O5wFMpMd0YIWgl15457OHrZWAPWBnnZB+lXmdNu2suSInD2zcMurTTnF+
         8JaDxqqI7p7ahKcnL1q9N35RFM4LUTbaUJbQrcNMRYOyyc6SLdcTfgVjz9pWyBXkeR//
         aaxu3OTn/xJVss5LckpNhtt7WSacSeCs1b7nOjBetSxcDH0kXZstlmZBZ9B6IEvQMMX3
         /M7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWLt9qq0rMhm0G1f47V30GqtoFirhOjjfNoV4FJuXFRCGH0WhUdohrIKSYqSdkww1eq8OoB7aKyzqHjnjl1lwO6bdZ/
X-Gm-Message-State: AOJu0YxQBRyIlAYlCIR/1PDPqxgi6empEHLP65AEBcscCmXFniM2rLyg
	Q0bvDqlypWsWKd54gSYyunXaxBGvtPFuP/sy4R4OWT/fMjuWb3w9FfQXEi3zEw==
X-Google-Smtp-Source: AGHT+IFWfGcIYPXsRAmj14lSrcCao0c+io+0eWif0PXl2BhhdcDWIELPXfSXwp17QCiDW+RC+j77uA==
X-Received: by 2002:a50:aadb:0:b0:5a3:3b44:ae00 with SMTP id 4fb4d7f45d1cf-5b020ea8945mr4508722a12.20.1722251465341;
        Mon, 29 Jul 2024 04:11:05 -0700 (PDT)
Received: from google.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac6359392bsm5596496a12.33.2024.07.29.04.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 04:11:05 -0700 (PDT)
Date: Mon, 29 Jul 2024 11:11:01 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Song Liu <song@kernel.org>, bpf@vger.kernel.org, ast@kernel.org,
	kpsingh@kernel.org, andrii@kernel.org, jannh@google.com,
	linux-fsdevel@vger.kernel.org, jolsa@kernel.org,
	daniel@iogearbox.net, memxor@gmail.com
Subject: Re: [PATCH v3 bpf-next 1/3] bpf: introduce new VFS based BPF kfuncs
Message-ID: <Zqd4xdolgRtARjj5@google.com>
References: <20240726085604.2369469-1-mattbobrowski@google.com>
 <20240726085604.2369469-2-mattbobrowski@google.com>
 <CAPhsuW7fOvLM+LUf11+iYQH1vAiC0wUonXhq3ewrEvb40eYMdQ@mail.gmail.com>
 <ZqQZ7EBooVcv0_hm@google.com>
 <CAPhsuW4i_+xoWXKcPvmUidNBuN7f1rLzfvn7uCSpyk9bbZb67A@mail.gmail.com>
 <ZqaqKc1fCLPTOxim@google.com>
 <20240729-haselnuss-meerrettich-accf4d27ee9f@brauner>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729-haselnuss-meerrettich-accf4d27ee9f@brauner>

On Mon, Jul 29, 2024 at 12:56:54PM +0200, Christian Brauner wrote:
> > think it's OK, but I'd also like someone like Christian to confirm
> > that d_path() can't actually end up sleeping. Glancing over it, I
> 
> We annotated ->d_dname() as non-sleepable in locking.rst so even
> ->d_dname() shouldn't and curently doesn't sleep. There's a few
> codepaths that end up calling d_path() under spinlocks but none of them
> should end up calling anything related to ->d_name() and so wouldn't be
> affected even if it did sleep.

Wonderful, exactly what I had also concluded. In that case, I think we
can relax the sleepable requirement across this suite of BPF
kfuncs. Does anyone object?

/M

