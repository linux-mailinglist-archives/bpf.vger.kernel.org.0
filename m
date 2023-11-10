Return-Path: <bpf+bounces-14787-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDBC07E7E2D
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 18:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DD621F20CD1
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 17:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DCEF20B14;
	Fri, 10 Nov 2023 17:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lPiAGPip"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E748208A9
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 17:37:33 +0000 (UTC)
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D108452C4
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 09:37:32 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-5be3799791fso419190a12.3
        for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 09:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699637851; x=1700242651; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6ms0oM3WlPAazqWb8bKMC1I2zm+2hRPb6foWU6L+CsQ=;
        b=lPiAGPipXF6lqvrvC1RMwWx8Fc3MWCDVBoBEMLg96Mv/IQUQ66/67yDZiZTmC0YHAx
         2kNUyOF9pcpYl4rB/4qJAqTOMTdn3K+v+dVE6Ee7eQyEUmyNQF7bDI3P4INTmSSal/7v
         hE7HoeCA0CkGNo5R9fMppTTRYZpxfcpKf0mEjvhieEMs0f3LVfaMBo9h7jhM80DDRJq/
         iUFabQuOXpmNf1bCfvwl/fCxZTn2uh/yGDIrK21jx1LYvk0qWLCC5Zb6z/ihok0WFSP8
         hof+bsx9TmO0y25ZgXhoE5SCE1oruy2Q0RqLNYo2586u2RVpoLCLfKJ8X/J9c60Nq10z
         R1lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699637851; x=1700242651;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6ms0oM3WlPAazqWb8bKMC1I2zm+2hRPb6foWU6L+CsQ=;
        b=baDYCoh/xsQA8QLmE2F1Tdw+0ikk1HOjfpf4VyAvJEy5ZOcFYGa32NQ8Vn36sazhKU
         LuwkbBUtlMsKwscn7pTQyP9Gs34Ph1jopBa4/Bx32ZAFSgH0o7a70fq4lCoQWTM0pgsS
         lWN0pEiMxy3SyFqPKckHQhw+8yRD+z2iE2ieFz20ZXB31zx6rpfjEoAQ0oPi+g0SJ+YB
         40mja2GyZlHPBgBpZcHP09Hd9tP5Dg3TG+uEFI0kRXjZW+IL5oTKFwAKscoFvXzHc9SJ
         qeMgnoB6C7/WefVsEoHehmkVjDTYiNtTg0p6yoLRM2Ge+mhbw0Lyr2eCQVtbo9Tuc1mi
         C6FA==
X-Gm-Message-State: AOJu0Yycu80OHbF9ehMLdnD+/2zzAY7n57UPrr5fCdFRXxUInLy0y0Fz
	O9YH3R5aDGg5zcP/8P/IzirnT10=
X-Google-Smtp-Source: AGHT+IEdpIL/CmjlHNGY4StluWrSQfI8pLD8TbSGQAQflikUtYgQmHfmEJ+eqDVddTd73jRBqTSDlvs=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:3f88:0:b0:5bd:57e3:d89f with SMTP id
 m130-20020a633f88000000b005bd57e3d89fmr1229542pga.8.1699637851643; Fri, 10
 Nov 2023 09:37:31 -0800 (PST)
Date: Fri, 10 Nov 2023 09:37:30 -0800
In-Reply-To: <20231110161057.1943534-3-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231110161057.1943534-1-andrii@kernel.org> <20231110161057.1943534-3-andrii@kernel.org>
Message-ID: <ZU5qWjVoe--qY_Ja@google.com>
Subject: Re: [PATCH bpf-next 2/8] bpf: move verifier state printing code to kernel/bpf/log.c
From: Stanislav Fomichev <sdf@google.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="utf-8"

On 11/10, Andrii Nakryiko wrote:
> Move a good chunk of code from verifier.c to log.c: verifier state
> verbose printing logic. This is an important and very much
> logging/debugging oriented code. It fits the overlall log.c's focus on
> verifier logging, and moving it allows to keep growing it without
> unnecessarily adding to verifier.c code that otherwise contains a core
> verification logic.
> 
> There are not many shared dependencies between this code and the rest of
> verifier.c code, except a few single-line helpers for various register
> type checks and a bit of state "scratching" helpers. We move all such
> trivial helpers into include/bpf/bpf_verifier.h as static inlines.
> 
> No functional changes in this patch.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  include/linux/bpf_verifier.h |  72 +++++++
>  kernel/bpf/log.c             | 342 +++++++++++++++++++++++++++++
>  kernel/bpf/verifier.c        | 403 -----------------------------------
>  3 files changed, 414 insertions(+), 403 deletions(-)
> 
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index d7898f636929..22f56f1eb27d 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -782,4 +782,76 @@ static inline bool bpf_type_has_unsafe_modifiers(u32 type)
>  	return type_flag(type) & ~BPF_REG_TRUSTED_MODIFIERS;
>  }

Does it make sense to have a new bpf_log.h and move these in there?
We can then include it from verifier.c only. Looks like bpf_verifier.h
is included in a bunch of places and those symbols don't have a prefix
and might (potentially) clash with something else in the future.

Or is not a super clear cut?

