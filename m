Return-Path: <bpf+bounces-39315-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55014971A47
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 15:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0ECE1F23C1B
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 13:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E81E1B9B3E;
	Mon,  9 Sep 2024 13:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GYOxmlB6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169A61531E0
	for <bpf@vger.kernel.org>; Mon,  9 Sep 2024 13:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725886976; cv=none; b=W1/g6UmdJEfUCSfBWNfigVJWkOTx9KlYaLfSPPyAnAEVfgkQIEyCJJgQtn2Zrx/UI0NdZrTjzPXMzz4cEOJqAeV+7r4qooD0AXfSKFSfMSri6d7tfxN6NP8CJdhi6VsprgaGDr2vmTG9jTGKhnBBJV4CuEG4B7fCU4i5vboo5Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725886976; c=relaxed/simple;
	bh=T3YX5/Lpd4lYkt45t/7q4cjSITWugSsonc6UgJRAfvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CiMdx2TklBQezCsSzYq+rZeBEMaqJh0CfrDJMfhm5UC9jLCcNTY9y6ypYikYmpLj5eJ0fNAv/CCSU0qWWQtuwYlVgYSOeiVxt9j2h8CbbIDuajPlyx0onDCWvtrkLAIhkuV+hcKYa5a16FAUK6Z5H+iSFml1bwk3HlbLHkE/gz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GYOxmlB6; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a7a843bef98so199620666b.2
        for <bpf@vger.kernel.org>; Mon, 09 Sep 2024 06:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725886971; x=1726491771; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7mMqU87htuX/vKBzsNQkDBJ4RpNR7Zr8uFLI9xAQvGQ=;
        b=GYOxmlB6cqxQooQnEt7X++w7jM/eK/CATiRIFTlUeVsvxT9Ux4sbdQFL2Yj3y9IIxs
         1/hT/mWfLkUwjQW8l2PNx5z/9dOebysSNFmr2JJncBXgRbJQhZb4hNCn3LQWhoQK3uLw
         MV1gOuwILIxvf+50GlQ3QALoWEgbLslRE+2Q64nHbx49SQ6N0NLiheIo0yVonh7UYmeT
         6SMAMkpaiXDARG4w8d4qLxh+oSDXZAPEZQh9Oct2MBiOFq71aPVkh8y/npv7+MtEzih2
         Awjsn9QaZNnSNtTZ7wnelsK2bB36E55nfpNa4W8U2xHredMXRNYHtN1ZsSdL2br2YUGd
         URtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725886971; x=1726491771;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7mMqU87htuX/vKBzsNQkDBJ4RpNR7Zr8uFLI9xAQvGQ=;
        b=NUaowR3jyiE6v59PIEI9CcV8RkiQugHQy+dIjFFdwzrVoaDijN9ZA3C6+KggluX9tK
         KNRfsr54JLEimWmFGVdaOhE7Usu1/MIXUF022Al/Zi/OP73Pgj2x/4k5F8Mio79Ass/v
         9+PH5xk1GKLXFQKFxkKw7F+S1/XqUpi1MX2CoRLMkRIf9wejA7XfG27jX5sz1ab4AZKJ
         9b1XiZSqGyOBUCrdYCWb8aJD4FplqyIOaj7av7aWcDLcxi1EVAQG+9B9ycz+8e16UNOC
         MjEB+QCb1l1F4F7jDyvm/vj1ykbxLPUudE023kJOfrcfgioQf//FoCJpJkl2CkQHQF0g
         WA1g==
X-Forwarded-Encrypted: i=1; AJvYcCUv/d2dYXdoFXmV7vsCUqYU/Biys3eSBj+5QxV6yoNssLv6dnOZShbeEITA+U44ehUxmiI=@vger.kernel.org
X-Gm-Message-State: AOJu0YybJHqNAR/ny5/yGO33rN7ddVokKPS4NskFDL6YMNDeQnnW0B8y
	38H6Oa1it6JVFLPqykFGO7ZRTYFsuWQFTY+j7+0HkrnWA6o0YV5Hx0sRu+zX6Q0=
X-Google-Smtp-Source: AGHT+IGBCWEcHjOnjDa3tv0OU9sQsIWi0rYKMo1x8pgZwqnvO0g9WWezq8axRIpo3yitGDVIG7HaOA==
X-Received: by 2002:a17:907:368a:b0:a86:8953:e1fe with SMTP id a640c23a62f3a-a8a8884be2cmr906103366b.47.1725886971281;
        Mon, 09 Sep 2024 06:02:51 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25d54abbsm337715666b.203.2024.09.09.06.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 06:02:51 -0700 (PDT)
Date: Mon, 9 Sep 2024 15:02:49 +0200
From: Petr Mladek <pmladek@suse.com>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: x86@kernel.org, linux-crypto@vger.kernel.org,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-media@vger.kernel.org, linux-mtd@lists.infradead.org,
	linux-fscrypt@vger.kernel.org, linux-scsi@vger.kernel.org,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH RESEND v2 16/19] lib/test_scanf: Include
 <linux/prandom.h> instead of <linux/random.h>
Message-ID: <Zt7x-dJF6RzEByBO@pathway.suse.cz>
References: <20240909075641.258968-1-ubizjak@gmail.com>
 <20240909075641.258968-17-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909075641.258968-17-ubizjak@gmail.com>

On Mon 2024-09-09 09:53:59, Uros Bizjak wrote:
> Substitute the inclusion of <linux/random.h> header with
> <linux/prandom.h> to allow the removal of legacy inclusion
> of <linux/prandom.h> from <linux/random.h>.
> 
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>

I have just acked v1 and missed that there already is v2.
Just for record:

Acked-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

