Return-Path: <bpf+bounces-21539-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7B084E932
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 20:56:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADCA61F316AB
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 19:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9B3381D9;
	Thu,  8 Feb 2024 19:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G0t48H65"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD644381C1
	for <bpf@vger.kernel.org>; Thu,  8 Feb 2024 19:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707422165; cv=none; b=IbqRtDHvx9GotBNHL2TKJrzBLbVbekvBGfdm4/sht3PMqgiI0jFhiBrYomC4/2BgjQxHr9pdoWW9xWoCC1b/D6xb0SvFcQrM+aIHL8HVtgj4M0qgemxhC4R0tMutHWe9G+fO0MOskvbICE75GRXojw3BfsZPn9aQdbjlyMHWKso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707422165; c=relaxed/simple;
	bh=EK0lkt55MxWccglSM6npB9D4SnFsEVs+7ZIewHNpimg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IwjRXdoCqqS7jMfOIln77vF94sQUUcAymsPydrmvOVuX/8vLEeE3aEyIVcjDqcIyKKoF21enb33ffxWlRpGVrcSd3+prh1qp2aO/U9oEAHskzZu/4irWh3/Cgg2Ai+sawHL6nvOo1OeM1PntS4asPgI5UZZZxQRHaXRBAGh8G1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G0t48H65; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1d9c1d53de7so2184365ad.0
        for <bpf@vger.kernel.org>; Thu, 08 Feb 2024 11:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707422163; x=1708026963; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uMyobnoowJwqThSEq3zdsdMHZ4NxTFeuNgeZPio981s=;
        b=G0t48H65oxgii80DW9HMH9mg/fp3x0SY0O/z1vT3/1LfeFCbgnvShE5XzEBORFza+A
         nqV6dKJQxQf74jQyFozhvGZNPVyTmjAgRK/7UWUR0WbRKgpZ60mfAtuLNzxb8nj7W1WW
         oh2nKwD7kyE8duRY680MX/1GtRYZvpfomTdIOzR2ju3c1sM3apFWTi/vwzbBWvU1XGN8
         tx7y/fFDwgZrJclWp4ZfxzTaQPKTvT85O9hJFPbNVHRXuHsEMJ1w9RS95iPlwqCO6k3Z
         BgCtW0iSLGSfLYL1xjRMWXPt3sFfsf2gaF32JPwUcwAbtf384jMF5jUhx+BiTuQd6X8r
         uf/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707422163; x=1708026963;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uMyobnoowJwqThSEq3zdsdMHZ4NxTFeuNgeZPio981s=;
        b=aISespCvNI/zkbNReZMrKEnQVXs1AIefqxnRp7xDEcr/rEP+QPvPMigps12KZMLMnm
         6/H7RhNckdzTHupyg8BdmQZ/bVJtxaUAaHJ/uRqI8G5zvSEfR2J2/TA6HRQI9ATcXZbY
         6HzdjSg219Za3hnXVAcnUgOxyksKkM9pAQpmggiXeMxuwj1IJnSH2EDooY3TDNj+C4MH
         uKB0/5rFa5RdYqIZI8GoGVO79FydfEAwIDWO3N0UGDtEGNl1t6RZleqhV3q9WgM4Jm4s
         bWSdHlCNtXfa+H2Di9cHqnYRVg4QP+JyEj5BbRSwxOP/cxq8NpHf3AsIqrVs5yA1V9qz
         atlg==
X-Gm-Message-State: AOJu0YzACJYbiyf9NAcjoksQjOApAUhTe5Sk7DFKKw8UahfmIUFq9QMs
	1TrygYVfa+TQ63WBpdqutHlhlKjl0oMmlSKxHfXmUD4iZFaRFX5mLuH2t+yDFQNR8A==
X-Google-Smtp-Source: AGHT+IFMCT5kKAu1do1sMtGLPk7M1cGigwmD5C1CqOdsrHVbQPJo7EOfYkv8ahHbWxC417F70DjxaRI=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:902:ea0f:b0:1d7:2fc2:dff9 with SMTP id
 s15-20020a170902ea0f00b001d72fc2dff9mr1639plg.4.1707422162934; Thu, 08 Feb
 2024 11:56:02 -0800 (PST)
Date: Thu, 8 Feb 2024 11:56:01 -0800
In-Reply-To: <20240208100115.602172-1-hbathini@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240208100115.602172-1-hbathini@linux.ibm.com>
Message-ID: <ZcUx0QdwW4FEDjTl@google.com>
Subject: Re: [PATCH] bpf: fix warning for bpf_cpumask in verifier
From: Stanislav Fomichev <sdf@google.com>
To: Hari Bathini <hbathini@linux.ibm.com>
Cc: bpf@vger.kernel.org, void@manifault.com, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="utf-8"

On 02/08, Hari Bathini wrote:
> Compiling with CONFIG_BPF_SYSCALL & !CONFIG_BPF_JIT throws the below
> warning:
> 
>   "WARN: resolve_btfids: unresolved symbol bpf_cpumask"
> 
> Fix it by adding the appropriate #ifdef.

Can you explain a bit more on why CONFIG_BPF_JIT is appropriate here?
kernel/bpf/cpumask.c seems to be gated by CONFIG_BPF_SYSCALL.
So presumably all those symbols should be still compiled in with !CONFIG_BPF_JIT?

