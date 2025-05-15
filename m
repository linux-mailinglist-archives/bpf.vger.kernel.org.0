Return-Path: <bpf+bounces-58367-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 946B8AB91D8
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 23:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A36C53BE13B
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 21:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB19D2882CA;
	Thu, 15 May 2025 21:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZe7E/ib"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22A6B664;
	Thu, 15 May 2025 21:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747345161; cv=none; b=oootb+nwpUnoaCZ23xcu573MYQUnj5AePZBB2TT2RWEzHz/6y5TLlgJPMlVv7Qi/ynEeMAEFaMac2WB4VxBN0GNtmiFqAno+qjcB+mkzbdum1Y9A3EiTgKwwt18jKab9dZH3NSToE2qfk967vk9FdT3hCFmOfOk4FQzAUeus+0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747345161; c=relaxed/simple;
	bh=XLjz8gJZUesCCRUYEuMqFQ7rRJFtNdWciD6tOyLP8lA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P58j90c/QJD5+9UugGYVLoAYWKKRSGm1lKgPR3oPJTP6T+R/5GXf42saq0etQVmayJ4x63w08FqPDj9Nn5JnD0iRGhK/wmhBA8Cd5sVftzoMLqkuOWFq/iOhxkLtGec+Dkrk5RYjD9cVlVUOZ0YQdLR0NfZhoiYio9cGmQsofLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BZe7E/ib; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-af51596da56so1117423a12.0;
        Thu, 15 May 2025 14:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747345157; x=1747949957; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XLjz8gJZUesCCRUYEuMqFQ7rRJFtNdWciD6tOyLP8lA=;
        b=BZe7E/ibYEBmPljafi7O4N1aT19AWNoWtJ90IeE/McSb22jLe73p7p5eUHcqO629XI
         CUyPhmghUYmRW9gJ83NgR/Xr6dztOMUdn+RgXNzxZwdBImlkGvWtnP5VjqEm+3MRQ7LX
         cCv61Y8iyW9EkpaaqvywqdDF6E02M/YwOQwQftr5aKlh5UaKJRhZyJQiyqjZMpcwVNhG
         TmHYT1+EOUJ72KXyge4e2MEJ3Jqzm2VUX9Ca4FSKJouRrBd0farQU2vpkEsa9S6KKVtp
         AILPuObJTnBWe06YmNiESeUBAjtJcQfYTmi1g11TsWRyZVoUd40oezcPtXRaWQtDMvtJ
         PC/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747345157; x=1747949957;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XLjz8gJZUesCCRUYEuMqFQ7rRJFtNdWciD6tOyLP8lA=;
        b=QCnOE4ALKSYNEm4VseCYnpNObX1UvJ+SRRcihDNNBGJl4P5GSgPrif1s0yvG+D1Evr
         5X1x2nxCZXLp4/0bvNIYh6vq9C+R6NcAT0vb3G0k55iRFwgvZqSHSNuR1NYKQAYhcr4b
         5GRpY0LYA29vnt5AuRAOl7GGunkm1VkW9tpDcFDmlhNtfcQSXq4MiZiexmmczdey6SBu
         7f7Q12TmK8hcAGtk0oXeAvRwaf+DHWfxk6SZDTNdpaYzC9G4nYQairx5iEav9P/IBS2h
         HfXpXgoNdaQyEE+gr3QRu31Ucn66+RriF2Gf2dw4K2mluYJvvnYRla9jx6c3iuaOkcCW
         Xi9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVPdkA8rIfWtYviunlj99Dbuga7/Eq9A/zfK606jdYU9a3LOftS8mibo20L1pjzbcNxuBRyQj8STWlZGw0HRoFg@vger.kernel.org, AJvYcCVxFnJvCWI93NTYuF2MzPiCklQrCMgAFWOKO9ZiHhH6OOINagvHGRWrrAmRE8FJsU0CSyY=@vger.kernel.org, AJvYcCW0eo++fcTsFtuAViVT9CSQB6M8OP51vDmBEOAFkDfpjPPucOydEkB0XaaFsxF8s4LLkY7855FaodzW8gAf@vger.kernel.org
X-Gm-Message-State: AOJu0YxTel6LycI/tfEisiSn6DN12RsL1A4Ru3ISf9MR6lAADaijGLKr
	0f+3xLaQOlLfhkwLZc30PBeQnFUgZwNTSblaKzHhHioDYJhePdDXyAv+
X-Gm-Gg: ASbGncsvF96Pxj5SwsGdjlFf8RaSvoesmhf0w6nR2VDNhgNZppEYMqfSydGezk4SSvF
	MfmrZhvVjGuHjqq1Vyle9sqjALk47Qg8fnVOB8EZijbOECjEsK0/7ccoD2F9yCAjXjGeT7WPNpO
	keoWPHKgUyQeyiZG9udZPRj4dWQPci0XpjPfhVc9cszUT858zr6HbMgpB2DwpKtZMdfnY/mMRsO
	WEhS/GnTFm/mJRjkIg3CsF6yP4tnhp2IGGSoFk15hL+G/hfhIBxCeUSEjh7U6Eup7IMfZHBW/ni
	JWj2udMqBlESGvCpKryqazUuoUuMUwlxZCEXE89p61Ao9Ig=
X-Google-Smtp-Source: AGHT+IFJqucu55xwtaxuHQzfFV/gJjZGnpp0tvXJvbw+T1Fs0ayZCl8h/rq1RQyoE1z30b0ZtoMYgg==
X-Received: by 2002:a17:90b:184d:b0:2ee:e317:69ab with SMTP id 98e67ed59e1d1-30e7d2fda18mr1694038a91.0.1747345157045;
        Thu, 15 May 2025 14:39:17 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eaf700e6sm371106a12.29.2025.05.15.14.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 14:39:16 -0700 (PDT)
Message-ID: <73abd7d20395a02b6664ea5ceacb46c530da3b2e.camel@gmail.com>
Subject: Re: [REGRESSION] bpf verifier slowdown due to vrealloc() change
 since 6.15-rc6
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kees Cook <kees@kernel.org>
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>, bpf@vger.kernel.org, 
	linux-mm@kvack.org, Andrii Nakryiko <andrii@kernel.org>, Ihor Solodrai	
 <ihor.solodrai@linux.dev>, Andrew Morton <akpm@linux-foundation.org>,
 Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>,
 Uladzislau Rezki <urezki@gmail.com>, 	linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, 	regressions@lists.linux.dev, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>,  Alexei Starovoitov	
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Pawan Gupta	
 <pawan.kumar.gupta@linux.intel.com>
Date: Thu, 15 May 2025 14:39:14 -0700
In-Reply-To: <202505151435.ECC98E09@keescook>
References: 
	<20250515-bpf-verifier-slowdown-vwo2meju4cgp2su5ckj@6gi6ssxbnfqg>
	 <202505150845.0F9E154@keescook>
	 <c36245a48149a12180ec710c65d317a12cdfa020.camel@gmail.com>
	 <202505151435.ECC98E09@keescook>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-05-15 at 14:36 -0700, Kees Cook wrote:

[...]

> Well that's pretty definitive! Thank you! I'll send out a properly
> formatted patch. May I add your Tested-by?

Sure, thank you.


