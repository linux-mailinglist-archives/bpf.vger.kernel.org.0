Return-Path: <bpf+bounces-20191-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C730839F3E
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 03:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0A7E1C275F2
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 02:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329AD469D;
	Wed, 24 Jan 2024 02:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EqTnO7Qh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBE04402;
	Wed, 24 Jan 2024 02:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706063727; cv=none; b=iNoV+1aUvjALk8NFMTjt6kU+zVYyP2o5bAGEmhADmzrZmBxtMCYTpRnuhL7dD2WQk93gPVigcg6r2kROpnC03FZ9GZb5E56l2yfs9Uu9WNSTfL9ycxRItbrpuUbNsWLhEMo9BCYGzrXIuyM7VAHESYhj4xfd62JVszIXeFgJ1LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706063727; c=relaxed/simple;
	bh=Liv6pTk/vLWxnDQTFyTrR9erFdF7zl9NHX3rNUXQWPg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=G86q5Q632Vk5BxG8KkexfEXhf1fMlsW2uNcUkxfAx64tmVEfFq9YOOx/p8vKXpCNBz5RpfCCxSrJ7KHvLG9QwRNQQWmJU+v+pW4MntGzhTbTlk2ew4YAHwBq3P2TwjT3cfsDT/3zJxNCAkOzz2DGVL4iYNrMILWQsP8nSEA6ArY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EqTnO7Qh; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d74dce86f7so23400605ad.2;
        Tue, 23 Jan 2024 18:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706063726; x=1706668526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YFUl7YI02/JBMotNLWPeCF79OYWFyYFYl1cfdcZaUcc=;
        b=EqTnO7Qh68jHiDPrLboFCMDPdAKi55lx4wjm4YR5NUm5UfhjcPPt8pTLsDedgxK4cE
         1L8mW5AKYxEAfOrGY/RHuqNiDdYFQNoQDbcxhqiIdRBnz7bE2wn3pxbKd7shlk9SqeXD
         b1riFETtkmChgj4YjXphmgzw4VfDR97epp1uyG0XMB5Ng1MCs2OGKsgqMqrCtOLO6cEv
         mhleHq6C6CYHylvb4TfZTIzMf61Pk/WhFuzeZ979DL0q6p6AC2mw5XPQWKP/1flmP0yU
         Yxw8FA0Gz0yIsbFT/M7pZ3NLLpsfmBaPQb4uUShF2ToKFsl4CAp/ANyr4s6gmrY6Gq13
         c62g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706063726; x=1706668526;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YFUl7YI02/JBMotNLWPeCF79OYWFyYFYl1cfdcZaUcc=;
        b=eu0PNDv1or0jihIoG1mkDShqNJ3XYMbDQTNYl+uCv1R8pzMENfC9FlE/fxRLudEpAx
         jRhzEIy05D8Jeo722DjREgPC2ZmhpFNXUfIevNoIGT4B30J5LHx+djDWn4rurIEBDh0s
         YVEAqQ12fnwhCmY3v6KZETjs1AlRvm4y8v7WdQCdBnZ0KFS/oX6ua7qyEnb+SaykXo9h
         fvzLZ7hv6PvpH769QKxOIqTyUr47TAKJN6hfxIt9483MwO2z96JaqmLX33kMmo6H/K/a
         jR01WLwUhQlu8K+V30/lvefX9oYk+wnHjW7+UA8F0qeoJKXPYjDG0ZLWPHThvd43CeEK
         g1lg==
X-Gm-Message-State: AOJu0Yw2cYCfSPSXxj7aTSyTACy8M5LL9i+L6wuP8fHuK0a7DFJTfIFd
	9ZXNid2vLluz5avjQbzYY18FrlPqZ4jRIein4xAL4ZkTlP+79HC2XRhLM0oh
X-Google-Smtp-Source: AGHT+IFrwEjRPN7Ep5FWH9R92zz8vqQtdT3xnPMy4LfJFSvzix90vrZto7iDuiuCPKegpuN1KFRV9g==
X-Received: by 2002:a17:902:ced1:b0:1d5:8aa5:d782 with SMTP id d17-20020a170902ced100b001d58aa5d782mr244950plg.6.1706063725601;
        Tue, 23 Jan 2024 18:35:25 -0800 (PST)
Received: from localhost ([98.97.113.214])
        by smtp.gmail.com with ESMTPSA id bf11-20020a170902b90b00b001d6ed14e309sm9413202plb.179.2024.01.23.18.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 18:35:25 -0800 (PST)
Date: Tue, 23 Jan 2024 18:35:23 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: John Fastabend <john.fastabend@gmail.com>, 
 netdev@vger.kernel.org, 
 jakub@cloudflare.com
Cc: john.fastabend@gmail.com, 
 bpf@vger.kernel.org
Message-ID: <65b0776bd8ee2_fbe42208b8@john.notmuch>
In-Reply-To: <20240123223612.1015788-1-john.fastabend@gmail.com>
References: <20240123223612.1015788-1-john.fastabend@gmail.com>
Subject: RE: [PATCH bpf-next 0/4] transition sockmap testing to test_progs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

John Fastabend wrote:
> Its much easier to write and read tests than it was when sockmap was
> originally created. At that time we created a test_sockmap prog that
> did sockmap tests. But, its showing its age now. For example it reads
> user vars out of maps, is hard to run targetted tests, has a different
> format from the familiar test_progs and so on.
> 
> I recently thought there was an issue with pop helpers so I created
> some tests to try and track it down. It turns out it was a bug in the
> BPF program we had not the kernel. But, I think it makes sense to
> start deprecating test_sockmap and converting these to the nicer
> test_progs.
> 
> So this is a first round of test_prog tests for sockmap cork and
> pop helpers. I'll add push and pull tests shortly. I think its fine,
> maybe preferred to review smaller patchsets, to send these
> incrementally as I get them created.
> 
> Thanks!
> 
> John Fastabend (4):
>   bpf: Add modern test for sk_msg prog pop msg header
>   bpf: sockmap, add a sendmsg test so we can check that path
>   bpf: sockmap, add a cork to force buffering of the scatterlist
>   bpf: sockmap test cork and pop combined
> 
>  .../bpf/prog_tests/sockmap_helpers.h          |  18 +
>  .../bpf/prog_tests/sockmap_msg_helpers.c      | 351 ++++++++++++++++++
>  .../bpf/progs/test_sockmap_msg_helpers.c      |  67 ++++
>  3 files changed, 436 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/sockmap_msg_helpers.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_sockmap_msg_helpers.c
> 
> -- 
> 2.33.0
> 

Will need a v2 to fixup a couple things here. Thanks.

