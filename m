Return-Path: <bpf+bounces-27471-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F17BD8AD5BC
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 22:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84D9028154A
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 20:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91191553AD;
	Mon, 22 Apr 2024 20:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="WO/GE4Rd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB4815380B
	for <bpf@vger.kernel.org>; Mon, 22 Apr 2024 20:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713817091; cv=none; b=LXCmu5GQ0xvUqrY1JT+rMRsHT7gYBSk5I7hNiN/xoULhfwrfOP2zepRZ1DlQ90NsKs7MKRDHwbU5W1jhavdhRzCxEBE801pr+Q1LTlm007dRYhKctCemxQnWB9l0B5IzVzAlSITEZIGIRKXaM6kND6Ehz6xnUgYrQabRgnfm8Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713817091; c=relaxed/simple;
	bh=UM0HF6o7aw12WnwJy7EbXFrh9T9uUKJJtluaHVZ93u0=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=K4EbbAm5g+Fbf1/q3O9BzImtTqXXYxE8j6PYoWPNHzYAAKW6zEspGjEtozXcs46B2tRMY5lER+NugbPpFkuNXsmnZOmkm0/C32zamfQJgF5kOBLueflxwjey2KEbBGNtwrgDjRE0vDiZMIGOBB3fdagG13Ev3yF5EvHSKj5Ckgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=WO/GE4Rd; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6f30f69a958so821449b3a.1
        for <bpf@vger.kernel.org>; Mon, 22 Apr 2024 13:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1713817089; x=1714421889; darn=vger.kernel.org;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=PUz55Nl17oll69+3WiaJPfCOIWt9awPUEg5ZbqEmiT0=;
        b=WO/GE4RdYknl5iE9Z87/4FIQZEca/kMN/m2tDa9O3oBWxHfzOxEfvZKHzmOJIc7tCL
         m59QZstVT3HDxUb0FojGRlpBuHktVdNxVgCdto1YYt/gSyZFgiNTtUJOvf2UJwqXoZez
         QD4jCMfRrBgpESrJxIo21NRwShtPjch0RN6Byw6XQGRebdsM7rvWE952vr5C2/HBDqY7
         tFKgYcaujj8e3kYFziNwP4GtXU373LvjU3HDJ/FqPc5/L4WM8iVp1EYx6kgcEooIrk41
         2N9yTUYeKtERZtOL4TBerWwMf88PubHEtY29PIwYvy4ITiNAQNHc8G0msHKogd1NLg7z
         oLJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713817089; x=1714421889;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PUz55Nl17oll69+3WiaJPfCOIWt9awPUEg5ZbqEmiT0=;
        b=s0UIeBHgeJAO4AtqiLF6Rrh5gGkB5RRK27eAWFSc8ep5KN5inDcVGJymdW/keauwJq
         ZVUT5QqB85/gvokrdCE5JIkQkZdeEq8MmvOshEP/le6h/APWhHVSOvglJqq4MkkrOboT
         QjR1F3uke+FJwUNc1fBr9CYv6Qq89JXbB9b7m1sa5Ww/SngFsAwHzVvyac2fQqxChpVz
         OyK71l/B6gFcLsKB560mRkmZE5QRKqKG9zG4iqCsAxG5tpWf2SsFO/sffKYwdc05eqTX
         O7YmFxpLbVohjCteXzEm2YG5qcqBdcnUtYKfwfHkWjVKjfh1VV/SCYK2zQK/Md5otxBW
         JQnA==
X-Gm-Message-State: AOJu0YzZyZ8tVA56GqcHACHSezUaqtdTTHaYiZL6upEtC8yA1CZfbKD2
	lMMHm3zLf9+mwAIHD21o//F7bybYxw8YXkmTR/En3aDSNcGPYZCk
X-Google-Smtp-Source: AGHT+IFNaB/pP2VBDqo9sZ3DuOnugU0crvxKt0zQBpTCpa6JnGQyFKzekv5q1BK5IOYUr9lRKR0Kpg==
X-Received: by 2002:a05:6a00:a1a:b0:6e8:f708:4b09 with SMTP id p26-20020a056a000a1a00b006e8f7084b09mr12704243pfh.15.1713817089260;
        Mon, 22 Apr 2024 13:18:09 -0700 (PDT)
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net. [67.170.74.237])
        by smtp.gmail.com with ESMTPSA id s23-20020a62e717000000b006ed045e3a70sm8235196pfh.25.2024.04.22.13.18.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2024 13:18:08 -0700 (PDT)
From: dthaler1968@googlemail.com
X-Google-Original-From: <dthaler1968@gmail.com>
To: "'David Vernet'" <void@manifault.com>
Cc: <bpf@vger.kernel.org>,
	<bpf@ietf.org>
References: <20240422190942.24658-1-dthaler1968@gmail.com> <20240422193847.GB18561@maniforge>
In-Reply-To: <20240422193847.GB18561@maniforge>
Subject: RE: [Bpf] [PATCH bpf-next] bpf, docs: Add introduction for use in the ISA Internet Draft
Date: Mon, 22 Apr 2024 13:18:05 -0700
Message-ID: <15c701da94f2$30a7c9f0$91f75dd0$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJca10vmlzuYWeV1F8aiImCH38lawJ77JCTsF0twfA=
Content-Language: en-us

David Vernet <void@manifault.com> writes: 
> On Mon, Apr 22, 2024 at 12:09:42PM -0700, Dave Thaler wrote:
> > The proposed intro paragraph text is derived from the first paragraph
> > of the IETF BPF WG charter at
> > https://datatracker.ietf.org/wg/bpf/about/
> >
> > Signed-off-by: Dave Thaler <dthaler1968@gmail.com>
> > ---
> >  Documentation/bpf/standardization/instruction-set.rst | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/bpf/standardization/instruction-set.rst
> > b/Documentation/bpf/standardization/instruction-set.rst
> > index d03d90afb..b44bdacd0 100644
> > --- a/Documentation/bpf/standardization/instruction-set.rst
> > +++ b/Documentation/bpf/standardization/instruction-set.rst
> > @@ -5,7 +5,11 @@
> >  BPF Instruction Set Architecture (ISA)
> > ======================================
> >
> > -This document specifies the BPF instruction set architecture (ISA).
> > +eBPF (which is no longer an acronym for anything), also commonly
> > +referred to as BPF, is a technology with origins in the Linux kernel
> > +that can run untrusted programs in a privileged context such as an
> 
> Perhaps this should be phrased as:
> 
> ...that can run untrusted programs in privileged contexts such as the
operating
> system kernel.
> 
> Not sure if that's actually a grammar correction but it sounds more
correct in my
> head. Wdyt?

That sounds less grammatically correct to my reading, since "contexts" would
be plural but "kernel" is singular.   The intent of the original sentence
was that
multiple programs (plural) can run in the same privileged context (singular)
such
as a kernel (singular).

Dave


