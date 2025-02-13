Return-Path: <bpf+bounces-51413-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E304CA34007
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 14:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F1843A881B
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 13:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86FE22172B;
	Thu, 13 Feb 2025 13:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/rxmGBy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBBA4D8A3;
	Thu, 13 Feb 2025 13:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739452590; cv=none; b=SfpoTzoQY0qg1bncZElqMuROaP5QK/fQWgOqJI+zIsqBDF/JBdDN28uzrDvJ8Fj59HaW0rh48iQmXYPAbS+vqVFBj84Sc8WJJqPtZuj9+nlOlWWtegiHW5oy8l419Ip0x6wFrfEd7ezNHG//bTPwV5NwaKAC9BjqmLGgiWfd6tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739452590; c=relaxed/simple;
	bh=3eCKYWe6fbh19Hq5SlKDOM6zLaeIkjczUm0VhjXYiro=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cmLTYwbLnENoI4twtMzaZP5afqsB+RRcx+ZA6FphqHwHlMZn38t3ffL3Fffk/hOT6VYvH0wIJTh/VQCd221GOOi/ioAoHRJBzymhWo5FITtEV4spmmqwep4TbzszIo3NFDTlbqjKlHcAb+irCYWZ6souK8FcjxuY04NNjcFGEuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c/rxmGBy; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ab7d58aa674so133526066b.0;
        Thu, 13 Feb 2025 05:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739452587; x=1740057387; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4wIUF5bRe1OT++Cts/lO87ero9KFNDwns7V0gMpPeUI=;
        b=c/rxmGByuOlZg6x0qSRFW5SUjajgqHAehfhsrt1zf7TJ4L3IG5JTSm4urUiNUyhGd2
         2XK4WuBEd2OEugeFOcsd9RTV+jMaE6ZTOrYKr3IeRCcAl4x01/O6b1vVrxlRsP8IY3Qv
         xsjrijoLUmKUtAivJKhkdARA3qUQkrSXdWjdQhfKSYgxmY5gbf2HYseNuzjIt3yLs8Z0
         Nz6DGVCD+T+flMih2fA3U4Jfn3kVgxMnE1muVKPTBHSNF3YHFOW/TxF0Pipe5AoFHQH+
         aWNzZ8Jpn/ra6e1tKRb3eckencmAzAhPurAc3MBBcx6iVjUdo6hXxVgNm1XbNEV+E1o8
         sKkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739452587; x=1740057387;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4wIUF5bRe1OT++Cts/lO87ero9KFNDwns7V0gMpPeUI=;
        b=rvsAncwNIMh/dfm4jRZHSzUYSyN3f6xry4Wzg20iNDFNzgrrAc8zo+kThqhtKhm6fP
         gWPoream5byNB5GFxHit4CTIsHcfh3K3fxD95RbuxRikg8vmRzvIKhWdtr6wyVyavgDh
         0s79P6xAUnuNGL6FEpTQbC/A7mo6ANpOwbfoO3UiIb6RbApLO3JrmITebk36hI4xE2L0
         HyiiEQF6ufj7kb2enO0VAy+uGX2pE3bpMPYXPe8cU3rA56VbvlpGLN1L7E6hA/OfnP9y
         F45Fv3zUTgpQUnnQAcda/bN7alhUOSuLQAP3SzH9apYSF6QtFtB4YO0o1bNVrD84ZWzU
         Odow==
X-Forwarded-Encrypted: i=1; AJvYcCW7YFZ3jAJATVzkotiIGVxp/nUvpiRpp41tghmc8ZPYgpwxOD6bA4prcFaSwMohtxgehC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YziKzja9uBa73yHIkaa7eZ0XBW9yK2KjYkXrFQFQkpJUX8p0DW8
	pOvApQcJs9Ef+gIYuKwrwnikR6OOuXDlAE2FNBxPoLyTLcUwAZCb
X-Gm-Gg: ASbGncuJFNFFgVeszBPGsg1vKt66AyW07/uQcqwTv4DCWIb/kVDiKYPhUuDOhxGMXvx
	9uka7WJymtmj4264NUjxUG4KCT1gV+7NJWlkdNF93TB3fwvmk9mAXPaEP/G4jq1VAFLtVCrgW7J
	INfFgyFqlho+OlH5NfJeYiq8mGry9G8dNUdnCyjXlYKyj6CWh5LyX5YoZsGF1DqHgd410SIDvep
	4josgRtqLhupao0xgwgQo3BXIoIn0Vpu8gyRPTLcyTk9QQwkhwkXNdNHfB8DENrRg5gfD1YFbHH
	2Q==
X-Google-Smtp-Source: AGHT+IH0rY8XRLn/35y8eE7mjNXnWlTVW25Tgqq279T/i9vvqpItmmnnty7HU0DkHN9imhETVUdOrA==
X-Received: by 2002:a17:907:3e0d:b0:ab7:85e2:18bb with SMTP id a640c23a62f3a-ab7f33781aamr721779266b.6.1739452586471;
        Thu, 13 Feb 2025 05:16:26 -0800 (PST)
Received: from krava ([173.38.220.37])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba53376abbsm130283666b.93.2025.02.13.05.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 05:16:26 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 13 Feb 2025 14:16:24 +0100
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: dwarves@vger.kernel.org, bpf@vger.kernel.org, acme@kernel.org,
	alan.maguire@oracle.com, ast@kernel.org, andrii@kernel.org,
	eddyz87@gmail.com, mykolal@fb.com, kernel-team@meta.com
Subject: Re: [PATCH v2 dwarves 0/4] btf_encoder: emit type tags for bpf_arena
 pointers
Message-ID: <Z63wqJlP0QNNsWth@krava>
References: <20250212201552.1431219-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212201552.1431219-1-ihor.solodrai@linux.dev>

On Wed, Feb 12, 2025 at 12:15:48PM -0800, Ihor Solodrai wrote:
> This patch series implements emitting appropriate BTF type tags for
> argument and return types of kfuncs marked with KF_ARENA_* flags.
> 
> For additional context see the description of BPF patch
> "bpf: define KF_ARENA_* flags for bpf_arena kfuncs" [1].
> 
> The feature depends on recent changes in libbpf [2].
> 
> [1] https://lore.kernel.org/bpf/20250206003148.2308659-1-ihor.solodrai@linux.dev/
> [2] https://lore.kernel.org/bpf/20250130201239.1429648-1-ihor.solodrai@linux.dev/
> 
> v1->v2:
>   * Rewrite patch #1 refactoring btf_encoder__tag_kfuncs(): now the
>     post-processing step is removed entirely, and kfuncs are tagged in
>     btf_encoder__add_func().
>   * Nits and renames in patch #2
>   * Add patch #4 editing man pages

lgtm

Reviewed-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> 
> v1: https://lore.kernel.org/dwarves/20250207021442.155703-1-ihor.solodrai@linux.dev/
> 
> Ihor Solodrai (4):
>   btf_encoder: refactor btf_encoder__tag_kfuncs()
>   btf_encoder: emit type tags for bpf_arena pointers
>   pahole: introduce --btf_feature=attributes
>   man-pages: describe attributes and remove reproducible_build
> 
>  btf_encoder.c      | 282 +++++++++++++++++++++++----------------------
>  dwarves.h          |   1 +
>  man-pages/pahole.1 |   7 +-
>  pahole.c           |  11 ++
>  4 files changed, 161 insertions(+), 140 deletions(-)
> 
> -- 
> 2.48.1
> 
> 

