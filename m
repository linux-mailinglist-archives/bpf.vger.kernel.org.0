Return-Path: <bpf+bounces-21843-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0DBB8530F4
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 13:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D321D1C22D5E
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 12:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2097641C76;
	Tue, 13 Feb 2024 12:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GotawsVe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC0D4E1BA
	for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 12:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707828696; cv=none; b=jm6NN+QkQ38i+8UU8tV+9ja2ZzV5n+udTLohSWmTPBzG+KjAsI4T+EPIEnHzGLPR7ZZla9lbDT3LZPUtnthxjx/DYwU16xAkdbjrXRugoRTUDcbXnWPFHKR/0IXFeoYoYv0bOywat7+s1WbzVQwaH7UO18hc5tiwWRifFLnoBHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707828696; c=relaxed/simple;
	bh=aHKWpQjuHKzQXZch0xVcUY/j4NVqKUpHkDHLka6I2X0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mh5vEjDMAZy/U2Q6Mvaf2CFT+vSaPzuNVSVcqbYPT6FKEr2D2DPo3Ofn/xmvR2toAp+YI1db9Ff4m62oUrbGALorkXovn6BRUSqyZZUWWZRxq/jJdTPxMut8671Wi9/EVHE2xVVxm/3RiFylqhWwy3DfFfFBtoMDlmDyeat2al0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GotawsVe; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a34c5ca2537so549898366b.0
        for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 04:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707828693; x=1708433493; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2EGQ/mUr4Oz7J3v4QLiwG30b1jfbPTRHvscnK7OylsM=;
        b=GotawsVesIKZUqsqNsLXWRb2RPzEnaaOgV9SChmNYSneMP+pGQWs1r2LuD5lEf1/w3
         qvUyxW3rQwNzpgZLyvcvWvzm1Vyr7WIJuv7Iu5p2pczlSmMy73PJpdHwlzGI3E6u094V
         YRoZ3uYpeFzuXFAc/XUPbgxp5C+HvzyPA3Mu3mkfO1Zit2wbXH08NAqyssEwcYa1g/St
         zdtyrwSWOmGo4XAgj2wCB+qD/yvYMk9wtgNyaO3obLGRz1ahrm6L5K4cWdsrmxK64oJN
         ZAWcbXhLHvE8LTEKaOVA3tDYAhlEXBhvir1oAjWQ7TyFxIiOllEBotIHSkUOC/91TFuu
         jeaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707828693; x=1708433493;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2EGQ/mUr4Oz7J3v4QLiwG30b1jfbPTRHvscnK7OylsM=;
        b=R0XoVR9SWsFViCKdAW4LRdQm58t2MtWE9L+AeGdIBzHn68H9SjVFQKb4I1KpCUEzT2
         wOOVWAA2+3g86alHZm/HRPFo6oKEbPSnVpoBXDG94HJYhVH7yxzgV4E9IDe0fswgVq0p
         qoCPrmfb7ViE09mMhof/sIkNwtnjrjED8V8vyPGadEYQPUYT3+xE2Vz1425vMnYjvd/G
         YoNYgo2ldGPA1iz6HL3airA13alzKKsbn4/pgjl7wlPDTIuiKFHjHRjURxHYdOUxmwji
         XG5Z1xdBly7b405FoCtdQoz2aqdLeGEGCwWHTq2PaVao3DQivkvrbxEmeUirgBg0sWSp
         K6DA==
X-Gm-Message-State: AOJu0Yy3d9lYZPxibK+peN3GdxBzDHdiQg2ufVQSNlQ5EQRvlSGDzL5i
	o+JCzHNYr7r0Fk9O7mWUtulM8HVNOO51zTExR6iduNudZ0wpVnZk
X-Google-Smtp-Source: AGHT+IHF6pvksEdOUv+KYnpja4oIEJaoklrzj404F/AP8pKJnN7Coj68jdIQBGznjcOaHG9Vv+mINw==
X-Received: by 2002:a17:906:c411:b0:a38:551d:ff1d with SMTP id u17-20020a170906c41100b00a38551dff1dmr7463444ejz.73.1707828693037;
        Tue, 13 Feb 2024 04:51:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUZb1K3TD/iOW33O3L75OzR0y5YJIgwMG4sngukMma3bQHqlp5Di9rWcRgOKkO471wb3hkGvBeq6oJmfxJJtZEwHkGbrSmYobVFxd53V3Lzt575P3ZGoSyfrQ7K/NK8SqtzmF/nmeA+jvMPsk+Px2NLpqNo5Q2ERysUaJwWpB3ziew=
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id m10-20020a1709060d8a00b00a3cd0c09a05sm1251948eji.180.2024.02.13.04.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 04:51:32 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 13 Feb 2024 13:51:25 +0100
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v2 bpf-next 0/4] Fix global subprog PTR_TO_CTX arg
 handling
Message-ID: <ZctlzbtQ9K5PpIBc@krava>
References: <20240212233221.2575350-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212233221.2575350-1-andrii@kernel.org>

On Mon, Feb 12, 2024 at 03:32:17PM -0800, Andrii Nakryiko wrote:
> Fix confusing and incorrect inference of PTR_TO_CTX argument type in BPF
> global subprogs. For some program types (iters, tracepoint, any program type
> that doesn't have fixed named "canonical" context type) when user uses (in
> a correct and valid way) a pointer argument to user-defined anonymous struct
> type, verifier will incorrectly assume that it has to be PTR_TO_CTX argument.
> While it should be just a PTR_TO_MEM argument with allowed size calculated
> from user-provided (even if anonymous) struct.
> 
> This did come up in practice and was very confusing to users, so let's prevent
> this going forward. We had to do a slight refactoring of
> btf_get_prog_ctx_type() to make it easy to support a special s390x KPROBE use
> cases. See details in respective patches.
> 
> v1->v2:
>   - special-case typedef bpf_user_pt_regs_t handling for KPROBE programs,
>     fixing s390x after changes in patch #2.

lgtm

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> 
> Andrii Nakryiko (4):
>   bpf: simplify btf_get_prog_ctx_type() into btf_is_prog_ctx_type()
>   bpf: handle bpf_user_pt_regs_t typedef explicitly for PTR_TO_CTX
>     global arg
>   bpf: don't infer PTR_TO_CTX for programs with unnamed context type
>   selftests/bpf: add anonymous user struct as global subprog arg test
> 
>  include/linux/btf.h                           | 17 ++++---
>  kernel/bpf/btf.c                              | 45 +++++++++++++------
>  kernel/bpf/verifier.c                         |  2 +-
>  .../bpf/progs/test_global_func_ctx_args.c     | 19 ++++++++
>  .../bpf/progs/verifier_global_subprogs.c      | 29 ++++++++++++
>  5 files changed, 88 insertions(+), 24 deletions(-)
> 
> -- 
> 2.39.3
> 
> 

