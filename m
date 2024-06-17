Return-Path: <bpf+bounces-32287-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F9490A8B1
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 10:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B629B25F57
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 08:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C32190684;
	Mon, 17 Jun 2024 08:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ibba1TV0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF8B190670
	for <bpf@vger.kernel.org>; Mon, 17 Jun 2024 08:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718613922; cv=none; b=d3B30cy9bEKRaRLXJyPSjt+/WXYn9uSSPbSrFagEm0i9CyItzx9SEQAOjNmw2Zkpzws14MgqdTqUy/fku+GGMigubcv/4bR0hXSqcX8/Q6/GhIk4GMDEz7faPmET4jly41ikijL8UKOOIWls6bgbHC54QSRYvhRzzoLbayV112c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718613922; c=relaxed/simple;
	bh=keAa9rgPRLtNrC8+bublnzimvGcxi7xf6fqMnW/UKMw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J463ZNWfTFLwhk78mKEeF9XfBhUQc7+oO8AHiyNB6Me5dKwutZiy1i/8Wa0QnZ5WQIksiYbahCkvfSQ94LoA+NTewC11qUwLWMueLVGVnRC8M8uhXIk4Kj69vU+Nbo6OhFoJXjYdY+sg9HSQIZjKvxZt5LEolgpzRfXL/FX+7a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ibba1TV0; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-57cc30eaf0aso1553101a12.2
        for <bpf@vger.kernel.org>; Mon, 17 Jun 2024 01:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718613919; x=1719218719; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YeX6qFWjVthmg26DJomDdpV376vR+BuheDRBRzQ7lOQ=;
        b=Ibba1TV0SvV/ProlWxEJDB6LJOT91QVgsPtz3vcOh699oGwWvzWS8xQyzcARy0oLce
         F+MMy5/4upCwu/ntc8mIsWt+hRKmK79soUKDoo31Y0MWR+/fNw8lrXfbqcuc03KVG8P+
         YEH0v6rht/Q4DPInfgULOTRFfNFcAqK7yjZKEWA9KWhNfYc2f4glUuQhFX1kW/sqrH6S
         4ETJplf6bJ4jxac/MIkURSe3IQyi9pgo3AlBlHMMGqwnenl77MlhO4QzsC9OpchuM7UI
         /dGit6Q6MSrfncbyRVLH3xq/MFw14YSfUPtcXtXhdEN8AdTvQz7jSWe+Nt6KAikrIXuo
         zdyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718613919; x=1719218719;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YeX6qFWjVthmg26DJomDdpV376vR+BuheDRBRzQ7lOQ=;
        b=RBHyob48gqdb/oFOtCtnoSWXYyu4hq6RE1vqRrX0u6azvYPU2MmFgIWc8jRRyTnzJ+
         Ugybz/wdKrGz5ahEDW7Oj80CVdU6mTWt87ezXdEYx5Fy+crQhCBzRfScisOLiH6PWtEZ
         Kz50beZf0z5lykCCc3Ih8pUkPFjyMbOfv58s9UWz4AbcOpEymf6gboDzFfhbzDQSrXmc
         zfVp6qMI8vPfkxgYJaqaS2utm1eJY6d44l7uBu0OT63ZpLm03UKLOaaNAJD5Uq3jScQQ
         LGt+6VCK/Rv3yu+fvBWM6EfjvWR8++T4DxOtQOxB45W4H2rHrzxwZ9i1yfOhk1iLmSf1
         kTRA==
X-Forwarded-Encrypted: i=1; AJvYcCXBbqnXKzm1cbNAEIIINytFG0VxXZIwm49dK63HarP7nGTclndIBLc69UeX2znkQ1BUrX9pWTum6gXBhWs1svUQwxjP
X-Gm-Message-State: AOJu0Yw67MTgV6DxKdoMnNKmDcpMSlqBYlEPkB7MHRWe35U+Wj1G6vKn
	qd7ibaGeO1rdk/XMRT1qLlJBuVz36ZN3um/aYA0wqIcpNOwicSTy
X-Google-Smtp-Source: AGHT+IFViX7h53cusCOmdovrr0L3HoVQ0MJ71vus7uWcTSoYM+LyrASNgr+fNTRpl9HIYKshFZYzjQ==
X-Received: by 2002:a50:9e2e:0:b0:57c:ad96:14c8 with SMTP id 4fb4d7f45d1cf-57cbd69022amr6936121a12.23.1718613918659;
        Mon, 17 Jun 2024 01:45:18 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cba492acfsm5653371a12.15.2024.06.17.01.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 01:45:18 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 17 Jun 2024 10:45:16 +0200
To: Rafael Passos <rafael@rcpassos.me>
Cc: andrii@kernel.org, ast@kernel.org, bjorn@kernel.org, bp@alien8.de,
	daniel@iogearbox.net, davem@davemloft.net, dsahern@kernel.org,
	mingo@redhat.com, puranjay@kernel.org, tglx@linutronix.de,
	will@kernel.org, xi.wang@gmail.com, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next V2 0/3] Fix compiler warnings, looking for
 suggestions
Message-ID: <Zm_3nE-ho-MDZbyp@krava>
References: <20240615022641.210320-1-rafael@rcpassos.me>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240615022641.210320-1-rafael@rcpassos.me>

On Fri, Jun 14, 2024 at 11:24:07PM -0300, Rafael Passos wrote:
> Hi,
> This patchset has a few fixes to compiler warnings.

curious, which compiler/setup displayed the warnings?

> I am studying the BPF subsystem and wish to bring more tangible contributions.
> I would appreciate receiving suggestions on things to investigate.
> I also documented a bit in my blog. I could help with docs here, too.
> https://rcpassos.me/post/linux-ebpf-understanding-kernel-level-mechanics
> Thanks!
> 
> Changelog V1 -> V2:
> - rebased all commits to updated for-next base
> - removes new cases of the extra parameter for bpf_jit_binary_pack_finalize
> - built and tested for ARM64
> - sent the series for the test workflow:
>   https://github.com/kernel-patches/bpf/pull/7198
> 
> 
> Rafael Passos (3):
>   bpf: remove unused parameter in bpf_jit_binary_pack_finalize
>   bpf: remove unused parameter in __bpf_free_used_btfs
>   bpf: remove redeclaration of new_n in bpf_verifier_vlog

lgtm, nice cleanup

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka


> 
>  arch/arm64/net/bpf_jit_comp.c   | 3 +--
>  arch/powerpc/net/bpf_jit_comp.c | 4 ++--
>  arch/riscv/net/bpf_jit_core.c   | 5 ++---
>  arch/x86/net/bpf_jit_comp.c     | 4 ++--
>  include/linux/bpf.h             | 3 +--
>  include/linux/filter.h          | 3 +--
>  kernel/bpf/core.c               | 8 +++-----
>  kernel/bpf/log.c                | 2 +-
>  kernel/bpf/verifier.c           | 3 +--
>  9 files changed, 14 insertions(+), 21 deletions(-)
> 
> -- 
> 2.45.2
> 
> 

