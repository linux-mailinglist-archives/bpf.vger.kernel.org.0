Return-Path: <bpf+bounces-17799-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 629D981289B
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 07:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 002CC1F21515
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 06:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D373D516;
	Thu, 14 Dec 2023 06:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iNyv1Yll"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35954100
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 22:56:27 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-28ad9492d75so2097615a91.1
        for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 22:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702536986; x=1703141786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6GlPQBZsdu/diRYjdnscaNpog21tjYqxp0J6E30j4HU=;
        b=iNyv1YllEfO53A3hVO0eAN6Ldo6pgymzAtQWQNk5AXYME3A/BKNppxKb8JUHed8rN3
         IYoYO9XsKE+HhT8VAdJ4pGZTbDgmkEPHlp2o3na285ciQY+/WA623LUnno+NDi0uwsAw
         KiGerrySdRe0G2G3FseS74yKBHDqkZ4gyx8eNCb+cuRZEtrkmn7ray//p5rdv+FrEj3v
         peWE8gB3IdbyPUDW6Im34a5yMyESZ5XCirR8gHCS6LsPxkkHiA6xrC1iyAEBLn20Dhq8
         LRepjpUFwwP/Xz61HyPuQdhjcATm0oXruzZJ9tTfw8hzi9gLxG2dROPuuFwpOCM2xQ63
         nQPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702536986; x=1703141786;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6GlPQBZsdu/diRYjdnscaNpog21tjYqxp0J6E30j4HU=;
        b=jN6Lt2KvNpNJV+juwPRJ56GqhUZMmadnUKJnPZxKcAhOpHOqr+qjdUp/8dhCoYcqdR
         su7EJZbSlvxRX/SFfjJ7oeYxW44ppgSbfrFK07li9aN78TjLCsIiRMITdNA2MnW1D1uw
         IxE/i9rkTNXLrlUR9nkygYlNQP/d0V0cXgixsyOcTSUm1C4EyIrWpdQsuplzAzYgyUNY
         PakE/Wl4TAqgvEf6gULPAI85oEIiNds+FMT/EcpQqxXg7POw4n1H2vJKraq8aRNPWIZx
         iWtq3ocJMUuIB/B5lm4aonV/m9H2VG2g+k/jTxsIsD00fWSVReyjFQbtTJF5wLsOSZ65
         bK2w==
X-Gm-Message-State: AOJu0YwfRL83gewLuI4Bi1nFZZ3lSg4N+NniPo8lD8SlKH25j1pD13k0
	aTc72k5vMvBI6GZfSBaByQc=
X-Google-Smtp-Source: AGHT+IHOz66Juf6w3A5P17B1gKe2Gd8q11b/QwEepTGciDiwznGR3sAovM8nx0YLGMZfUz5daSjKzA==
X-Received: by 2002:a05:6a20:2926:b0:18f:97c:8a4f with SMTP id t38-20020a056a20292600b0018f097c8a4fmr9053723pzf.122.1702536986518;
        Wed, 13 Dec 2023 22:56:26 -0800 (PST)
Received: from localhost ([98.97.32.4])
        by smtp.gmail.com with ESMTPSA id z17-20020a17090ab11100b0028a69db1f51sm8172969pjq.30.2023.12.13.22.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 22:56:25 -0800 (PST)
Date: Wed, 13 Dec 2023 22:56:24 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, 
 bpf@vger.kernel.org, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 martin.lau@kernel.org
Cc: andrii@kernel.org, 
 kernel-team@meta.com
Message-ID: <657aa718c8f1c_4a65f208f1@john.notmuch>
In-Reply-To: <20231213222327.934981-1-andrii@kernel.org>
References: <20231213222327.934981-1-andrii@kernel.org>
Subject: RE: [PATCH bpf-next 0/2] BPF FS mount options parsing follow ups
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Andrii Nakryiko wrote:
> Original BPF token patch set ([0]) added delegate_xxx mount options which
> supported only special "any" value and hexadecimal bitmask. This patch set
> attempts to make specifying and inspecting these mount options more
> human-friendly by supporting string constants matching corresponding bpf_cmd,
> bpf_map_type, bpf_prog_type, and bpf_attach_type enumerators.
> 
> This implementation relies on BTF information to find all supported symbolic
> names. If kernel wasn't built with BTF, BPF FS will still support "any" and
> hex-based mask.
> 
>   [0] https://patchwork.kernel.org/project/netdevbpf/list/?series=805707&state=*
> 
> Andrii Nakryiko (2):
>   bpf: support symbolic BPF FS delegation mount options
>   selftests/bpf: utilize string values for delegate_xxx mount options
> 
>  kernel/bpf/inode.c                            | 231 +++++++++++++++---
>  .../testing/selftests/bpf/prog_tests/token.c  |  52 ++--
>  2 files changed, 225 insertions(+), 58 deletions(-)
> 
> -- 
> 2.34.1
> 
> 

Acked-by: John Fastabend <john.fastabend@gmail.com>

