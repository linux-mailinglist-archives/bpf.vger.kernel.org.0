Return-Path: <bpf+bounces-74411-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D4676C57B2A
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 14:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 32F7D3561FE
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 13:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A296192B84;
	Thu, 13 Nov 2025 13:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fDR36fjc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F4618024
	for <bpf@vger.kernel.org>; Thu, 13 Nov 2025 13:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763040817; cv=none; b=SIhqfUFe/6K/AAxa5yXgvDs1TNFENFX1SWxOLxX+iP3o79aqqFzY8nTPulD0+tLL8ZSTsyzR+e6aZjY88xLbOaIXqn4MkTq8B6sC6MnfWz7C3vtICPnq/xgSpLqIvJVzqSBs7ozhT5dLwpI4Em8wapKv8IccTkabNnp0N+xyiqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763040817; c=relaxed/simple;
	bh=JoJN7+tJKIXlTim12KYLa40sY14YfzETVU9Njrvls9M=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SuqJeJYuA/dbX3obEDETIucEIvCr7jMG9iOE7gDp4OZg3Qaky7IU/sjBV+lYjPNiHq0ZgAwz9S+1vic6Fc8gGUO1nI8FQ8WhGKeIr7/ZdhmhX8PAXO/7SgMAAuGiF8UzRC7jc529iEUQWCqfM7X/V4pSlSBVkJBzd82t1SwWZwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fDR36fjc; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5957c929a5eso1060942e87.1
        for <bpf@vger.kernel.org>; Thu, 13 Nov 2025 05:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763040814; x=1763645614; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MhHd/vd5PilZlak+JY6GVryWSDKciGyRf9y3293OwHk=;
        b=fDR36fjcNzE29GbFRA23uEauf9E9Q3PWB1nLgYmuxEomGjsajArzKz4fqA4+bSTWRV
         EB/5ZLXNPWUjrVpF5NSaPGe56opEG+VuEWqtHKfy3pwImYP7x6B0JpXGIuiaQPDAfnR4
         fBd3ZM9GMdnrdmgxbTRF+F+HdOtdDRWFHiOHZVSRTpx04D2Ytyjpp5TXG2q8lKKDobPx
         YLBRxYr/k+XUI4DTPk1BURRTTi6xBnYi3JEVN1ChHf8xMOh0kt2Ex1SovA0Io8u7cV+V
         tpApVj/xo7ZiWd0HJiLAuIhEjmPKOXuknKFAnKtUhxmTNEK42o7YN1MPgOGQdGq1YlmQ
         5Srg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763040814; x=1763645614;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MhHd/vd5PilZlak+JY6GVryWSDKciGyRf9y3293OwHk=;
        b=GQC1KCrSaN5yS6GWJGa4K3K7luWq6V+GSXOmGPYULOWX4Y8lQYhuq3TW28NE5V8ySO
         1Z4S/MzauNndGuQ5hmYTmMUUc8eUuHlrnBFdPxTNsG7iPiqsIisCKc6MlTeUvePf6Kb6
         JvNtx0+jij8WgknKDnvc+WsxgcEiGORUlZDnA9NAaC9+7dE93vZ99OwaT5AE8a+8+u+u
         7Dc18Tx1OnhiOp3EjHXfPeypReaYA0pLC+adwPysUruyrsP4j9MJ+XFBIcsPzfTIqozH
         jwLnJScNKlJM/mfNE46ekXYZlLTGvTgLPkfFMaqSig60n6RrrWEQOATuZo2gDg05IK4I
         4wGg==
X-Forwarded-Encrypted: i=1; AJvYcCWIKd3hSz7dcb0+lXP+qp2xp7Rq159LPaQlYo4EyMIGSORQliG4dLtXqtbProsuXYjtqfc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP/SHGeJXrIARVFoXz167Oyrdz8VJHqSuYmlRNb7W50M3TM+8V
	CMp0f1MTcCmK7mCpLqP1AACuiNtcAKhxZmac8mbnmGwR0nnypbcHBiW4
X-Gm-Gg: ASbGnctdOtoP9X4ymv2h6PU5xkgY3aVNDvljXSo2WKL4AVVkVHEsnNxV5thdYnmu1ji
	b7HDw2evpgcLNDQZ7k4QAtYrF3gTts9ICVQ/vVRROGrCnQ8quiHYMxcNvE8YnYGORPxFqdSKbgQ
	iP/8d3Ezwr45GdRh6KVZaoQ3SsJ1HDEBXnsRBpNNYHATCbje9Wmpbyt0hwcDHuFa9vFYRvjVRxF
	qrttPL4JQu0+ZnREtJb/omKSrgu0zqFNxt2KEOgLdB7rhnLyUx3JabxgNghvGbIDBFtY8OMFPaA
	lvsvtF+Nkx286m9kd+bc7kq9F0WBJWVVXaztYjHmQL0IC0itWeAqFZRdcKfUCEJp812cHwLVOCM
	Aou4QWdiMGnhR5BtZkDR8Cp+6ICkrbVpwgMrB4LAPcE4=
X-Google-Smtp-Source: AGHT+IGUL4qC6K+DHAMyAznh1nPqOVVG3vBedGscK4G1HhCq8iWh/Gjrhh8TEulXo726uPx2/aO9Jg==
X-Received: by 2002:a05:6512:b85:b0:594:34b9:a817 with SMTP id 2adb3069b0e04-59576e19be4mr2460400e87.33.1763040813955;
        Thu, 13 Nov 2025 05:33:33 -0800 (PST)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-595804128c6sm394619e87.111.2025.11.13.05.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 05:33:33 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Thu, 13 Nov 2025 14:33:31 +0100
To: vishal.moola@gmail.com
Cc: akpm@linux-foundation.org, bpf@vger.kernel.org, hch@infradead.org,
	hch@lst.de, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	urezki@gmail.com, vishal.moola@gmail.com, syzbot@lists.linux.dev,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot ci] Re: make vmalloc gfp flags usage more apparent
Message-ID: <aRXeK_C44xGb3ovg@milan>
References: <20251112185834.32487-1-vishal.moola@gmail.com>
 <69158bb1.a70a0220.3124cb.001e.GAE@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69158bb1.a70a0220.3124cb.001e.GAE@google.com>

On Wed, Nov 12, 2025 at 11:41:37PM -0800, syzbot ci wrote:
> syzbot ci has tested the following series
> 
> [v2] make vmalloc gfp flags usage more apparent
> https://lore.kernel.org/all/20251112185834.32487-1-vishal.moola@gmail.com
> * [PATCH v2 1/4] mm/vmalloc: warn on invalid vmalloc gfp flags
> * [PATCH v2 2/4] mm/vmalloc: Add a helper to optimize vmalloc allocation gfps
> * [PATCH v2 3/4] mm/vmalloc: cleanup large_gfp in vm_area_alloc_pages()
> * [PATCH v2 4/4] mm/vmalloc: cleanup gfp flag use in new_vmap_block()
> 
> and found the following issue:
> WARNING: kmalloc bug in bpf_prog_alloc_no_stats
> 
> Full report is available here:
> https://ci.syzbot.org/series/46d6cb1a-188d-4ff5-8fab-9c58465d74d3
> 
> ***
> 
> WARNING: kmalloc bug in bpf_prog_alloc_no_stats
> 
> tree:      linux-next
> URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next
> base:      b179ce312bafcb8c68dc718e015aee79b7939ff0
> arch:      amd64
> compiler:  Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> config:    https://ci.syzbot.org/builds/3449e2a5-35e0-4eac-86c6-97ca0ec741d7/config
> 
> ------------[ cut here ]------------
> Unexpected gfp: 0x400000 (__GFP_ACCOUNT). Fixing up to gfp: 0xdc0 (GFP_KERNEL|__GFP_ZERO). Fix your code!
> WARNING: mm/vmalloc.c:3938 at vmalloc_fix_flags+0x9c/0xe0, CPU#1: syz-executor/6079
> Modules linked in:
>
Again bpf :)

GFP_KERNEL_ACCOUNT? I saw there have been __GFP_HARDWALL added already,
IMO it is worth to replace it by "high level flag", which is GFP_USER.

--
Uladzislau Rezki

