Return-Path: <bpf+bounces-56166-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA19AA92C60
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 22:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F1C18E0597
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 20:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81161FCF78;
	Thu, 17 Apr 2025 20:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g5qu1XwB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEDF1624DC
	for <bpf@vger.kernel.org>; Thu, 17 Apr 2025 20:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744922753; cv=none; b=Qr0D+I1V2sRlWYf/qYEjAXIkt2WrbGniKb8CvY+zGVUSHbvo9HGU+EIeXSXYTKNtfD86efrWLvZblqIEFz+/r8RMzUlKnbzrmNCr0eriRTxgFHiV1NkCk0AAVFT5qz3oDnalN7C5ZGbwQNMRaKithgXVmysvoX/eS8Bqp79syTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744922753; c=relaxed/simple;
	bh=wIUWM2ufbVC5+IRVGPMvCcNlNgrEGLr9FM+rY1qYksY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gLBdVvl2FzmyrviF1HtkkxdaMdalx6QEBSC0HctwtPgFJCbsTbZXVFmTKRFgZYrgZvCmdJ1nOnEbF+SxjEEUdC/y2bMQ/m6H03nuoxJq1R241EHgeib/9ohvzO/bUXyaZ27QnkHx9ZSbDGTgJAFdqtWGQEA37gCg+F6Pp38jeng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g5qu1XwB; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2ff85fec403so2481826a91.1
        for <bpf@vger.kernel.org>; Thu, 17 Apr 2025 13:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744922751; x=1745527551; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wIUWM2ufbVC5+IRVGPMvCcNlNgrEGLr9FM+rY1qYksY=;
        b=g5qu1XwBvb7n5GL6RjOhrDei8bLgTAoK8dgigJWSqiS4PhgsKdioWj94quamVPqCgC
         clzv47Z9jXYR3MWHNI1ZSfA/I9zRTae9FA6vFOutGKjYVAh48ZA5W9CzITUkec0J6maQ
         30whIgPbW7axeIv/UTcoy9NDqVTg1x5OH1Pg0s9aK55hAP+9S6a4TZmktq/5zicNF177
         s0kTOyeMq+sXH9KBRJZBNwq9/xQp+6xJurjOTNH6VQegvo+h9nINtHA6Ay6yyE+8SYNv
         ZijMjJvGT5wAWWzD75tfMuIHKFTrLaFsGZabxROwZKV5wZPRKFQhpWRdHORoK2k1UMiL
         mnjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744922751; x=1745527551;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wIUWM2ufbVC5+IRVGPMvCcNlNgrEGLr9FM+rY1qYksY=;
        b=YmaJZLcUAFGFANQH5nDgmKh7KA0MIfyk8WxJihUvP9iKckYJlsf14c17m/s8mXPw1J
         m9UChTzzvybmlBmrQDaDaX7Vo9I0RqqIWFmUv/UcVOC13aMiUlM/Rs+Ppn/Xh/JGqBHb
         mVn+t3sqr84ZBglgV7yPksSils5qPJ/IlXGtaHqi5CDVo57boIloKIufW2vhPTcoNxmT
         MWvHCbhMVSLOnBr7WsnLBr9ZdCWFmPxIjI0W4qCYwCQIq/Wk7oiKrm9wcrsXCOF7VZxf
         ajt3SWF4W0ThDCWP/XcyOsoNyubICb9cADVTRE3xuTFIYqeBFNIjdEk8+1pBWIQI40QV
         jWHg==
X-Gm-Message-State: AOJu0YyhFECc34L3AnCAg+RH3dypd544OC5Xzrzm/HpTgY6lLuw52PAU
	4Vd0wMo6yAjxkDfDIep6vnFxWKTIeMjxyI/O1stj9XZIlxAFLgKy
X-Gm-Gg: ASbGncumLNfPLzoQsnNiSEUvOx2r2B1H5EvNSiCmCprjF2S153YjswHWF08MgYvdsvD
	492eywTTNDxxWaRnaIyFpaPrHvMW0k2ZNMRTOJRIkPr0URrZEQ5YMI1HxI6V6LWHz6pQE4ijbI2
	Hu/BH+eblv4H0+jnPFYPZE+I8JZLZoSd1/G/yIVFRjmDpK+BNyWGxMjJSGxWc9Sa68V8j/pwVOv
	1PdysrHtrVCGmU2mtaMakkBinxrOzNH3HqN7UhENoAi3MnuFKdvkUzSGcfsoeKfTjAL1zO5KR0l
	yDjI8ocgyMsef9zT9lJO2tn9QiI3fT/XORhN8Agnttyn0SY=
X-Google-Smtp-Source: AGHT+IGgc3DyS2r5fi+Y5PIk8L1FqW/2f3DHePmWKQUagiDEzpIeMMpW+jNYATcMYZCzp37ZgJuVxQ==
X-Received: by 2002:a17:90b:3808:b0:2fa:4926:d18d with SMTP id 98e67ed59e1d1-30879c02a9dmr1681552a91.13.1744922751175;
        Thu, 17 Apr 2025 13:45:51 -0700 (PDT)
Received: from ezingerman-mba ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3087bb6822asm139227a91.22.2025.04.17.13.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 13:45:50 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org,  Alexei Starovoitov <ast@kernel.org>,  Andrii
 Nakryiko <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
  Martin KaFai Lau <martin.lau@kernel.org>,  Emil Tsalapatis
 <emil@etsalapatis.com>,  Barret Rhoden <brho@google.com>,  kkd@meta.com,
  kernel-team@meta.com
Subject: Re: [RFC PATCH bpf-next/net v1 04/13] selftests/bpf: Add tests for
 dynptr source object interaction
In-Reply-To: <CAP01T74a=65hrUUO6kNqomBPf0Yu+iP_bVrTCqFtdPO2KPeQdA@mail.gmail.com>
	(Kumar Kartikeya Dwivedi's message of "Thu, 17 Apr 2025 22:09:54
	+0200")
References: <20250414161443.1146103-1-memxor@gmail.com>
	<20250414161443.1146103-5-memxor@gmail.com> <87a58g1otz.fsf@gmail.com>
	<CAP01T74a=65hrUUO6kNqomBPf0Yu+iP_bVrTCqFtdPO2KPeQdA@mail.gmail.com>
Date: Thu, 17 Apr 2025 13:44:46 -0700
Message-ID: <m2jz7itt4x.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:

[...]

> I struggled to have more than two callbacks automatically working with
> RUN_TESTS and struct_ops, so I guess I will do explicit loading and
> failure checks.

Could you please clarify the use-case a bit?
In theory two RUN_TESTS should be independent.

[...]

