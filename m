Return-Path: <bpf+bounces-52921-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE61A4A5F9
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 23:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C29A3B5727
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 22:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795991DE2B9;
	Fri, 28 Feb 2025 22:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gp75M+hb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A829823F39A
	for <bpf@vger.kernel.org>; Fri, 28 Feb 2025 22:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740782128; cv=none; b=Szy5Ljk5cNxSZ7ZCBxc19lD6xqxpvdy5yAwpG8t8uHrA7SvmkTQDOp2mfZvMMpenYy46Helj5IO9hMz/zHji8jHlZa3Oign9Ev659Dz254gCus9MUSOrtg22XrrEq/vU7s+EMcsi/6zUEs3+plK92GbmoSBKFB1LYifc2dRKZD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740782128; c=relaxed/simple;
	bh=pZpo3k/lnfhw9/Gatnd3FZAJ6WdhzWnzl+6Siy0R0a4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AmHQx+IsdEGQdayinPZm0coIHhCPxK7h1USWvDfp8fhxkIPptJFGan+f4H7dRYa4i3aNQDHL1hZgm/vxnHq1JnDHSYuZBOTc65Sy3MBIotH+B0s4a0Fig1k3MEoJGz6cwB3Ki3XfjQw/vcbFKzIk6uSEL7VSU3hjUn8QFBBmxu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gp75M+hb; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2f441791e40so4422916a91.3
        for <bpf@vger.kernel.org>; Fri, 28 Feb 2025 14:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740782126; x=1741386926; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HVB6iGFLEXs46eOS5CgZ3zEIMl14rDELJhM/g6LETUM=;
        b=gp75M+hbi627v9VFO848akwv+N0AfRsL2vyC3cPC6KnNeSczjg3qW1k6hefP5Ds0J3
         6EMY+/jQnqq6rEqpohpzvsdAPng3+8CYzTbOkD7FDrE9uIuQOIA1KEQ17N791YHBQnAP
         8oLo/inXHqI7P94ozeLjAGefXhFnm+MURF7qVlhp6I3muCz8xPwf/HtmiEL601tuIaXt
         rldebGYgPubfGYaydx0TGycHp3e25CmGB6LvngTV0GDKgzfKchH3gUTXnA7dylUeS5b0
         UnGEAqcAKhiZEQ5q9d1hFuAjufhsJZGPDk2NxIYFD0sRfVkdxFBqvkG+JpcmJARe7Hhn
         73iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740782126; x=1741386926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HVB6iGFLEXs46eOS5CgZ3zEIMl14rDELJhM/g6LETUM=;
        b=EQU7Ulu/jALnBKZk2qLamoe44eJOJQctkx1yt4GUF1+SKlfRCAebgJXp5/Upbc73Hs
         Mz/Xf2dznjs/wdb6jXuZHKCqgjYC+G7vR/2tsfZdIi1WrUmhq6R8pXXJoqR2tkdKhCiY
         EHY78M3+/Yinp+HUWJtmprY5a29DFrTVHhEmTitgKudEBOdm0cypP7X2rdUmiJYAKrEd
         eNW6xb9PYAOTqWcqmisehl0CzlvDpBvhd8pgwKlZqPb7RFnBtCsGlqwPdSfyVcFcr7dM
         uUARmL8/8pVnlErLOpaTa6e+sXDgjyjGxmG8rREXpuHk37KcdYRuymVta7J5TtrRI7Gh
         PJaQ==
X-Gm-Message-State: AOJu0YxHK1Yzd/kF13AtwW4k4Ds6RiLc5TFw9IaoHE6HmAac+KmJFmlF
	ja4Jj8DN0Foivf9+OgxcqEGNyPNbPg0Cjxmn4xgH2MTOh1aQ2fHIXYiB7LY8X4EZ8kf9IVt/7H/
	OK/17BoMCV9gWhffsZO+b/toEVyk=
X-Gm-Gg: ASbGncu4VLcXSdMvpNdJqC0PBWK/hNikiTn55+QK/hJRyg+8fdHuQcV9fH4nKBX5mKl
	IhK5+ooGWkdwpK5JtK6I4YY52vpU0qWh1H27OLX13DDcecAlql8sM7RtUjIyJyk6+2OBOUnHvAf
	nOvhOzuDchJd44FsBWjqt8mqVbVqw70zmggxHDIMPAxA==
X-Google-Smtp-Source: AGHT+IFK2Pywf/ulSorDEmV3q4t5UOCjR6u6Tf/OUnfdVTJUB+BmOkjMMkdm8QbgS9ClTOKdiisKZVW/BMNGvG0BAV0=
X-Received: by 2002:a17:90b:3909:b0:2fe:8c08:88c6 with SMTP id
 98e67ed59e1d1-2febab2ec63mr9138273a91.7.1740782125887; Fri, 28 Feb 2025
 14:35:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228175255.254009-1-mykyta.yatsenko5@gmail.com> <20250228175255.254009-2-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250228175255.254009-2-mykyta.yatsenko5@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 28 Feb 2025 14:35:13 -0800
X-Gm-Features: AQ5f1JqrdcqsUUpCU-BvMaObRirioKWkRzAOWOGJ1Lem-X31h3BsYWUm9U264Eo
Message-ID: <CAEf4BzYxtyGuFP0LjC8jJSToquxe+Y+mXLH=s9usKNio6MfrTw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/3] libbpf: introduce more granular state for bpf_object
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 9:53=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Add struct bpf_object_state, substitute bpf_object member loaded by
> state. State could be OBJ_OPEN - indicates that bpf_object was just
> created, OBJ_PREPARED - prepare step will be introduced in the next
> patch, OBJ_LOADED - indicates that bpf_object is loaded, similar to
> loaded=3Dtrue currently.
>

This is a bit too low-level and explains "what" at a very mechanistic
level, but not really higher-level "what" and "why". Try to make it a
bit more useful for future readers. E.g., something along the lines
that "we are going to split load step into preparation and loading, to
allow more flexibility when working with bpf_object, and this patch
adds a finer-grained object state enum instead of previous boolean
loaded flag".

> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  tools/lib/bpf/libbpf.c | 47 +++++++++++++++++++++++-------------------
>  1 file changed, 26 insertions(+), 21 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 899e98225f3b..9ced1ce2334c 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -670,11 +670,18 @@ struct elf_state {
>
>  struct usdt_manager;
>

[...]

