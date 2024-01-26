Return-Path: <bpf+bounces-20406-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A05683DDB5
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 16:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 296DE1F23820
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 15:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A491D52C;
	Fri, 26 Jan 2024 15:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V5dMx6yC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E6F1CFBC;
	Fri, 26 Jan 2024 15:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706283648; cv=none; b=Du1YF1hPrshAoHbcNSOp6XihxUXmrkka7BSkulV7N+4FtoZ5p8Ys6Jmy3nel4twiB5MotcTGyHv33NpCK2DS2sSUKVDMLyPwEmt137s/uMelHLCqgydLOu4a/T7q8WgNr5PtOwMUvNP9Aq3VtCc5+WavdWTGwsKml7lDwOIxQ8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706283648; c=relaxed/simple;
	bh=JGaCVuo9SLY43neEoDM3vFibpzcPR2KYm27CYG0feqg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=p3t9bFMXh2cbM3fJ9ktyv7n7LLPLGPU7wqhqBQYxbcxEWHyEJpYkSuEp9O3sbCPy07unXSU2V44L9Y6t+HqMqT6v9tlrTzUdtXy7oQWgIuA/X0ZB+DXt4yWLbUaHQE5xyPtaJsIpiHi4cddYX59YCOPx59Zfktw0buP7w52hgbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V5dMx6yC; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d73066880eso4721325ad.3;
        Fri, 26 Jan 2024 07:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706283646; x=1706888446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7QGY8OPqxdoi1UYLg5JubJbRifmZMmeSmnYhe9kCBBc=;
        b=V5dMx6yC1vcTS2vteYjeMpoWhBJ6oAYtxffxHqVJd5QSf/a7aXCn2zY25OvpwXS8NZ
         g865Xw84Wgw6j/no0Gb3KlC85nNVja7RTDD+aSDd8+kcD4nOuVYGRwBpV4H9FnX/Ci2e
         qd6p9sS2A5kSnlypZmVLvHog69eDZiOtcdJnNbK0dnev84lgd174LYCYxJR243tB+I9A
         zfKvrZ+uQHQZvKOPq+u5HDtsL7Dm3+x1zUho6xutWbuWL9WRr5Q1yiyt/IPjzgztDIpS
         9qlUv1P26RJz/MRejtcZgWGem7stq/aasuscVw+XIlxxCUhyP3BDCaa8A2mFkxHMPflb
         vmoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706283646; x=1706888446;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7QGY8OPqxdoi1UYLg5JubJbRifmZMmeSmnYhe9kCBBc=;
        b=NFK6RrXVxPSKvJK/+AEqWtwkc4zrfSLVHYmF5q55MN7z67VWPbVqi9A5Rtlb7x8ctz
         E3dkyT5TkxJ2uwaLM8RYqqlccfJUpvf4ymCjZXDT0Hpd0FK2nv1jNYx4LbhSRhxm2iyT
         cWu3jWfTsKnwV4hw5QSWNw4DhfOGQgm1bpsSl0CX1MAQALKKy9IM1PasJF/zi2ghwjI2
         V5DQxSwe6RAfTOnJCLEHZicPhRPfArcLBjf17xMGySTr3B5KTyT1iM/RZHMr7NUgB2rg
         ufg6n6dGaM2bKK6a1MdOU5tgvVr7oaUhS5G8sJr2nxsYePHgaRYiTayc9DKV5xOVsgNg
         X3gQ==
X-Gm-Message-State: AOJu0YyLipNYMk8Y4U6FArFZjxhsc8sxP3Z/mL2PbIN5QmthjTXjFkIK
	fE+PT2vEn2ziTXaWAW9+1ikF25Pw+51cfWGerks1E/gtUMqMjdNK
X-Google-Smtp-Source: AGHT+IHmQraxlMcJHf6pPcGAOMlF9pePJ+DQYAsVOCyfRReFwShOeQtatLCKOCBmQ/R57vaGsLRy9w==
X-Received: by 2002:a17:902:dad1:b0:1d8:a827:c338 with SMTP id q17-20020a170902dad100b001d8a827c338mr493528plx.120.1706283644609;
        Fri, 26 Jan 2024 07:40:44 -0800 (PST)
Received: from localhost ([98.97.32.4])
        by smtp.gmail.com with ESMTPSA id z2-20020a170902708200b001d89ed2d651sm1083543plk.102.2024.01.26.07.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 07:40:43 -0800 (PST)
Date: Fri, 26 Jan 2024 07:40:42 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Jakub Sitnicki <jakub@cloudflare.com>, 
 John Fastabend <john.fastabend@gmail.com>
Cc: bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 andrii@kernel.org
Message-ID: <65b3d27a993db_15499720887@john.notmuch>
In-Reply-To: <87jznwdul7.fsf@cloudflare.com>
References: <20240124185403.1104141-1-john.fastabend@gmail.com>
 <87jznwdul7.fsf@cloudflare.com>
Subject: Re: [PATCH bpf-next v2 0/4] transition sockmap testing to test_progs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Sitnicki wrote:
> On Wed, Jan 24, 2024 at 10:53 AM -08, John Fastabend wrote:
> > Its much easier to write and read tests than it was when sockmap was
> > originally created. At that time we created a test_sockmap prog that
> > did sockmap tests. But, its showing its age now. For example it reads
> > user vars out of maps, is hard to run targetted tests, has a different
> > format from the familiar test_progs and so on.
> >
> > I recently thought there was an issue with pop helpers so I created
> > some tests to try and track it down. It turns out it was a bug in the
> > BPF program we had not the kernel. But, I think it makes sense to
> > start deprecating test_sockmap and converting these to the nicer
> > test_progs.
> >
> > So this is a first round of test_prog tests for sockmap cork and
> > pop helpers. I'll add push and pull tests shortly. I think its fine,
> > maybe preferred to review smaller patchsets, to send these
> > incrementally as I get them created.
> 
> Cool to see this transition starting.

Thanks for the review.

