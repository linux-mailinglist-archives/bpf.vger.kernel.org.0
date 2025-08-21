Return-Path: <bpf+bounces-66222-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14639B2FC55
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 16:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 707C93BE12C
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 14:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0285D27A47A;
	Thu, 21 Aug 2025 14:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="REj0gCpe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB492264A8;
	Thu, 21 Aug 2025 14:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755785889; cv=none; b=Zyr4HaBpLAaYQtUi3WMOqeRi/POEgMUSX/yEpFe21Rb6njrtSL/MrVn2iOKClZmzyopuyIPCvMZzV7C+5Oz8wTUPSlkN6p6r0r+mEMDpS0JOO/45jl4Th4Qqs24IswMw+coeTWpFDpnqVlzxbG4bRMhFAI0Y6nw1HsN1ekhJLiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755785889; c=relaxed/simple;
	bh=owjS78g7Ralnh9lSopUuSCuHjZ9PN3Tk5H2DmbuSA3k=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WqTRRWpGkNh+0gRJwPfIJ1cfVlF9OE8XK0eoKqh1H1oBbC+b7nCbbhr95cSQutEzuwqrA55qwMpbqVZP4Xkd45pShzIQh6Arot08gjfrBvmx9+7cCF9NoLL/HLWdOpXJpftIKMRog0VGmSOFa+90pk9IIL5+q+HrZx2lF5eVni0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=REj0gCpe; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45a1abf5466so7132825e9.0;
        Thu, 21 Aug 2025 07:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755785886; x=1756390686; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+XTXcI0LkWh1hCjxmTkr6WUsK2779uimR5uOiEjNsrg=;
        b=REj0gCperml8fDaqVbysaiXzIc2QJ2HV2J34G8/BIs+dy4vcYvj1h8DVZIfTzeVQ0v
         bEaOQtMpDFXj7dHr0+d1kvVYISzfA8xKCgkXhHLsnvOQvvFU4WalURUI/gBJ58KgCST2
         Thi7f86pM7008eopHx1ISrLcpivG7YN1W9Xj5lzm3kvAqJPkYB2s1Z2DoX4UQVLPTTar
         WRzxotFAz+j6Zz1wDSO6xb0uz0Xgw4sARt4o2UTjY7rb3xFQ7hlOHTbmSNwtJVPIpoDh
         /Ul0FVekNDGiyKPhJWaKBVCejykJYGcEcVMPip+7u4Ftxv5igxJYVo+M/FqJ3BY0shL8
         Zzfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755785886; x=1756390686;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+XTXcI0LkWh1hCjxmTkr6WUsK2779uimR5uOiEjNsrg=;
        b=neXZfhNUHJxQwlQSallMsM0sEeNx5Be9bRUa3gyJEEgtjDN/TTAntIr2OPCEtXLaOL
         4LIOYAp8XNqCuu3NsmZK4gbpzhMd0iGQsYKzfq/s62kaZVPMh9HnuhogQRngBqnmKm5c
         631ettiSmzgYa8L6xeu47Yb5On3h2yGdB28ulcsoCcOsfe/x56ve6+Cw1ZHujrStj8eb
         EJNwe3fd9jDoI0naZpo2zHpoHKf/Q/yk9oUktsvHN8M3JoXwrRxWyN2Tozz9d2O3sbys
         UI4vDQrw8JBa++OQCNswDa0iGgix1KY90uICXua3Id0vyczdARNcJtGiix6grIoJ7FAc
         73Sg==
X-Forwarded-Encrypted: i=1; AJvYcCUIizTnEdKiBGCAnkvBb2qBuou1rEtYB9n3Dw6mnbq9+Mj2cRMOpijamHxuhRsWxKvS2Q3a4gz+BSrV/o/+@vger.kernel.org, AJvYcCVn7GS9u2hkREz+95CKbgaHKX7Cob7eTYaarYMOavMqihfsGbts7ln+ZFZ+XLU1kLDMGnk=@vger.kernel.org, AJvYcCWve5fUOTJUL3LTQN8hqwyuIL4u8C8JDq23137lurdHUgVYRsqcXGbA6oitoMSSGznKhTMe5pJPzaGqF7Cu9XRjFDa0@vger.kernel.org
X-Gm-Message-State: AOJu0Yyks01P3NblCLgW7kpJiZ3CH4+Q4v45DbNvSKCQvct0hB2beece
	gneSfdrq84eftWoUizwc0hq2wHHJyL1k7oUw+XNscif0+/0jsKPIo2LmoWHxNQ==
X-Gm-Gg: ASbGnctmND0aFaAhDWPzqxj2JOeALYfJ4eP11vFXRPKdjOJ/lr0j5IizTuy8RV0odvi
	77hqzYmXGS6p/khFlu82anK6hfvbHIM+5RJnnrOTUjwQPpM/5LjBfMr2wNZpvA86W8rU0eUQt7x
	yA2oOjIF36u/IWLYYZqB9CEQU1OHBtouliajyjLUPnkaNwhKGDn7TBNaA33g3ULJ0Z4guDtvNA9
	CY1pBAu85MfXaoBnP96TqmPq6Sbbnd0Ps7sRvlCR0TTPhGSltKSBEHhjFoXSHeL4TKv4EH16RO3
	KWsJoJptw/RhQXGKIJxdOrc5QLgUb0l/F8YAyKZOqnFECTmEuM1ufTTfKG7M6OEJSsWVuCe4
X-Google-Smtp-Source: AGHT+IFkomTMapOtSMVfYWyHPv6ruKXKshWDpEEgQzLg5CxAW2El+loBhHUAmZPgBVKFPy5LiIBBqA==
X-Received: by 2002:a05:600c:1988:b0:45b:47e1:ef7c with SMTP id 5b1f17b1804b1-45b4da17153mr21390005e9.18.1755785886001;
        Thu, 21 Aug 2025 07:18:06 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::31e0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b4db1ba89sm31302345e9.3.2025.08.21.07.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 07:18:05 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 21 Aug 2025 16:18:03 +0200
To: Peter Zijlstra <peterz@infradead.org>
Cc: oleg@redhat.com, andrii@kernel.org, mhiramat@kernel.org,
	linux-kernel@vger.kernel.org, alx@kernel.org, eyal.birger@gmail.com,
	kees@kernel.org, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org,
	songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
	haoluo@google.com, rostedt@goodmis.org, alan.maguire@oracle.com,
	David.Laight@aculab.com, thomas@t-8ch.de, mingo@kernel.org,
	rick.p.edgecombe@intel.com
Subject: Re: [PATCH 0/6] uprobes/x86: Cleanups and fixes
Message-ID: <aKcqm023mYJ5Gv2l@krava>
References: <20250821122822.671515652@infradead.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821122822.671515652@infradead.org>

On Thu, Aug 21, 2025 at 02:28:22PM +0200, Peter Zijlstra wrote:
> Hi,
> 
> These are cleanups and fixes that I applied on top of Jiri's patches:
> 
>   https://lkml.kernel.org/r/20250720112133.244369-1-jolsa@kernel.org
> 
> The combined lot sits in:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git perf/core
> 
> Jiri was going to send me some selftest updates that might mean rebasing that
> tree, but we'll see. If this all works we'll land it in -tip.
> 

hi,
sent the selftest fix in here:
  https://lore.kernel.org/bpf/20250821141557.13233-1-jolsa@kernel.org/T/#u

thanks,
jirka

