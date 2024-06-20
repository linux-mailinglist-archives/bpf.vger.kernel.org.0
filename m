Return-Path: <bpf+bounces-32560-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0BB990FCB8
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 08:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 649B01F2567A
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 06:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CF22BCF7;
	Thu, 20 Jun 2024 06:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gWTwEZXU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42B913AF9
	for <bpf@vger.kernel.org>; Thu, 20 Jun 2024 06:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718865128; cv=none; b=KUtO7oqlpHoG2o3I8hNM/UI527F7F+FtHNXI8BGQ5ju7NEQL950uKZxCAuMT6YB+9lbDYCuDQ9Tjc1QDxvW9el/bNvqxCSS9tEyPB7Y3do8wrj31HoY0y/bwVgRmBfl/mGn6qOYuBCyfA5qSY79s3SQ/xy3vvJJlVl/2ibJP2Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718865128; c=relaxed/simple;
	bh=85WcfxaKjkeAj+kccwFuqo4gGUp0/4/pgTDzyiG2Q4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jdi+94BJTpQCULnM97LFyQ3dgSctwCLTsQsK+CeQj32/R7l8BkL2Xq3fwZEiWQWK7Fw92ChVX2zx/Oa3jI/j9gt4w4ctMOiFg71UNOo6KrQqSsjIw+zLa6bWFqtzxctGwTiIwO0oyh+Gya226C2UHHXbgrjBxMgsng0PRjZEJ9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gWTwEZXU; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ebe40673e8so4620231fa.3
        for <bpf@vger.kernel.org>; Wed, 19 Jun 2024 23:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1718865124; x=1719469924; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G8hTFUX1Oa3SWEYlQJpFyFo1Qcg6uCVBqffUrz85gPM=;
        b=gWTwEZXUWb9NDCW7WSPIsIYPyHrfRognv/4SThSaI5TMpou0Kk4iMxxEOdBiOjWzxw
         McafvMH1XCRRAwNa1ETbhQDCDBScNz77cSNQBYODN5RzQ3F4V0L74+g7h7nJ2t/IopT/
         2+RwwYkQkfhBo0Zcjcn0plVK3ZMMTZq8SFOFVl72jp0k7vG1LGS6xgPwdxGGYgJx4dGr
         7ZoipZ1hVhrs+pb8RVHoMJ1qJSSerhvIuE3pUE8dXZTigqRIaECw9ZGTV07ENLIg7AAr
         GNijsLCfDsHOjoHBSRkC7rNs5YFA1QMzpwwsUNQiWDegzU05g7KU+joeIa7EM1cL2zQo
         1bHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718865124; x=1719469924;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G8hTFUX1Oa3SWEYlQJpFyFo1Qcg6uCVBqffUrz85gPM=;
        b=SrNh0/5IX97s9JjwmvfI9iBTspmJLnYWPum+z1+dlOUL04LByThF+L61TRUWbHXdr5
         JNGZWkyU5eWdDJ1eXi3iln9+OxnqZROJeK9WP9l7UY4f1wYHVwm1SV/sRSVUB8H3l35O
         E2YYPOz0ru8NH0tBH2tiMSGqAQt5MY2aMq9kDubengitpnL5blMtzbR7/oHGi8CkBsEs
         V2Mpqo6amWEy+QFG5eDYcL9Oh+ZKcvPAwEnI4odVQgyg6Gxl1Z5C/Uib7+SsiBBSMbk6
         JR8svEGV4daNeVuWxveiIhKh78vdjaY0rt9A8t0bO5CjsRtpGU2u+gY9SYXppGtxsAvx
         0VMA==
X-Forwarded-Encrypted: i=1; AJvYcCXu3Dqd3xZg58xNHXEHw2ZLCkz3kvssQvkX2P3NkqL6IjImdBS3EFSlA/jC0QQScgIOGHQYM/pervNDjjAUimUMrM4L
X-Gm-Message-State: AOJu0YzmOuguLlO4uNBy7OvPrd12/O9jwMNJD2ulXXRF8hdD0KwjJfrG
	tjuGc/AoRh2x411breI29utYM1KG1NHMKUCl3qD4+TBmVxoR2NqVYt5ZDNJDyCI=
X-Google-Smtp-Source: AGHT+IEgKeOEFGusxmkyXs1TEdgP/7LrFxFeZ/hLyA6JLp+cFmJakQWFmmIlP0/xNaFGxNXy0kNGaA==
X-Received: by 2002:a2e:7e0b:0:b0:2ec:2508:f370 with SMTP id 38308e7fff4ca-2ec3cfe1cb4mr24784601fa.51.1718865124081;
        Wed, 19 Jun 2024 23:32:04 -0700 (PDT)
Received: from u94a ([2401:e180:8d03:7b5a:e270:dbd7:376f:a18a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705cc91e133sm11617558b3a.24.2024.06.19.23.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 23:32:03 -0700 (PDT)
Date: Thu, 20 Jun 2024 14:31:57 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, Viktor =?utf-8?B?TWFsw61r?= <vmalik@redhat.com>
Subject: Re: Backporting callback handling fixes to stable 6.1
Message-ID: <fdhl7v45xss45sf4oq6hyst4vadng5753ikriyuo66kzpx57yz@bnzlq2id7n5u>
References: <7k3olfmgvvdjumu6c76nzyynqp5hq252f7u2hqtqo5wbz2ii3x@ksker37jvude>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7k3olfmgvvdjumu6c76nzyynqp5hq252f7u2hqtqo5wbz2ii3x@ksker37jvude>

On Thu, Jun 20, 2024 at 01:18:10PM GMT, Shung-Hsi Yu wrote:
> Hi Eduard,
> 
> I'm seeking suggestions for backporting callback handling fixes to the
> stable/linux-6.1.y (and similar branches), akin to what has been done
> for 6.6[1].
> 
> Testing with the reproducer from Andrew Werner[2] it seems 6.1 has the
> same problem where the bpf_probe_read_user() call is only verified with
> the R1_w=fp-8 state, but not the R1_w=0xDEAD state because the latter
> was incorrectly pruned. So I believe the callback fixes are need.
> 
> The main difference from 6.6 is that 6.1 does not have BPF open-coded
> iterator,

There's seem to be more than that, given regsafe() is critical to the
fix as it is being used in stacksafe() and func_states_equal(), 6.1 is
at least missing the following patch-sets:
- "BPF verifier state equivalence checks improvements"[1] for
  refsafe()-related changes
- "verify scalar ids mapping in regsafe()"[2] for scalar IDs mapping in
  regsafe() and mark_chain_precision()

> ... but AFAICT it does not mean "exact states comparison for
> iterator convergence checks" patch-set[3] can be dropped. This is
> because exact-state comparison from commit 2793a8b015f7 ("bpf: exact
> states comparison for iterator convergence checks") and loop-identifying
> algorithm in commit 2a0992829ea3 ("bpf: correct loop detection for
> iterators convergence") are critical for the fix; but it should be fine
> to ignore all changes to process_iter_*().
> 
> The "verify callbacks as if they are called unknown number of
> times" patch-set[4] name already suggest that it is needed, so no doubts
> there (again, dropping iterator-related changes).

1: https://lore.kernel.org/all/20221223054921.958283-1-andrii@kernel.org/
2: https://lore.kernel.org/bpf/20230613153824.3324830-1-eddyz87@gmail.com/

