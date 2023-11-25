Return-Path: <bpf+bounces-15841-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2B07F8CE9
	for <lists+bpf@lfdr.de>; Sat, 25 Nov 2023 18:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EE49B21177
	for <lists+bpf@lfdr.de>; Sat, 25 Nov 2023 17:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915A42D04D;
	Sat, 25 Nov 2023 17:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k1hQ6ZJB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3475E127
	for <bpf@vger.kernel.org>; Sat, 25 Nov 2023 09:47:45 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-5abf640f19aso3638408a12.2
        for <bpf@vger.kernel.org>; Sat, 25 Nov 2023 09:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700934464; x=1701539264; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9pQvrE1VjbnX/y6ByGIqcRM35RSO1PuZh7mCElTQgyQ=;
        b=k1hQ6ZJB1bmgJmzfADagmXFnKtyI3Fwya/qNFf4Gc8YrLkkmHr0Rxm31cII4p8d4li
         loEQpBJs/RAXM2iJJI09Pl+VKEHeSD9G68EjF8UZAwQb0MoCxr94pVXiW3hWkwE+8g2A
         oR+zKUeUcuaPnsCgzJEMDJEqBvu67m9qF3j7KwAbT5l80gc0GcgVwo/bTrGO6EIh+uUN
         FCuUcTvY1Pnh4lqFy6eDHiF5lfwFPn82iHpHeboLDXv1xlLcrYKJ3wUGRDp05gvZ4h3P
         Pa/5O6yDWC0ebIt8htKbVbcJAnC4In3OH+xGnIOgtKWun5hqTKQ5ASAKmFDIoSFqX3M9
         uFIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700934464; x=1701539264;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9pQvrE1VjbnX/y6ByGIqcRM35RSO1PuZh7mCElTQgyQ=;
        b=XVMN0iabR6ZDVyvM9t2mvV7LPE1ksN3gTtO02Hiu7j6L8EoDTI9xCYTGDPR69J7os1
         Xr2nfJSi8BVf3Z6Mg5eFM8qSgkgGQPZ8wvlsnIv2VRLxjPCGpDz3zPdryjnPt0X6xIK7
         sPmoZ+ucdAqmHKSzyfbcByBkB6zkAU+hG3/SguH0sneZaFf4DYB2fULe8rYOod+MSIPm
         Mo8VleO2T2o5AM2lbOcJKPFmVbSguvT3fNxrGugInb/h6GbevgVlVM5Vg2uUNlyeUlsX
         FCw/Pfl2VFX6khmwYOcruO43jRzl1LvjnDyFn4YKpQ0tQ8EqBqxieUJwoCbQ75ycoemr
         jdlw==
X-Gm-Message-State: AOJu0YxqnPF6AY95KGKb2EF3tQtsysOnS+bsmGP2rM+ird7NQJPaAW/n
	lv7/I9bg+aOigMXQGF5QsiVJlKSN4Nivig==
X-Google-Smtp-Source: AGHT+IFflWgX+Gg7h8fTMTF6SpzYKnQOYwGbJCZ4v+j1BmllVH1kpuMX3VxlWRmMPr/i4NyYau2+euR5tvKkyw==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a63:d209:0:b0:5be:1194:9c0b with SMTP id
 a9-20020a63d209000000b005be11949c0bmr1039251pgg.3.1700934464725; Sat, 25 Nov
 2023 09:47:44 -0800 (PST)
Date: Sat, 25 Nov 2023 17:47:42 +0000
In-Reply-To: <20231123193937.11628-3-ddrokosov@salutedevices.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231123193937.11628-1-ddrokosov@salutedevices.com> <20231123193937.11628-3-ddrokosov@salutedevices.com>
Message-ID: <20231125174742.n3ybfum53yd27bo7@google.com>
Subject: Re: [PATCH v3 2/2] mm: memcg: introduce new event to trace shrink_memcg
From: Shakeel Butt <shakeelb@google.com>
To: Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org, hannes@cmpxchg.org, 
	mhocko@kernel.org, roman.gushchin@linux.dev, muchun.song@linux.dev, 
	mhocko@suse.com, akpm@linux-foundation.org, kernel@sberdevices.ru, 
	rockosov@gmail.com, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Nov 23, 2023 at 10:39:37PM +0300, Dmitry Rokosov wrote:
> The shrink_memcg flow plays a crucial role in memcg reclamation.
> Currently, it is not possible to trace this point from non-direct
> reclaim paths. However, direct reclaim has its own tracepoint, so there
> is no issue there. In certain cases, when debugging memcg pressure,
> developers may need to identify all potential requests for memcg
> reclamation including kswapd(). The patchset introduces the tracepoints
> mm_vmscan_memcg_shrink_{begin|end}() to address this problem.
> 
> Example of output in the kswapd context (non-direct reclaim):
>     kswapd0-39      [001] .....   240.356378: mm_vmscan_memcg_shrink_begin: order=0 gfp_flags=GFP_KERNEL memcg=16
>     kswapd0-39      [001] .....   240.356396: mm_vmscan_memcg_shrink_end: nr_reclaimed=0 memcg=16
>     kswapd0-39      [001] .....   240.356420: mm_vmscan_memcg_shrink_begin: order=0 gfp_flags=GFP_KERNEL memcg=16
>     kswapd0-39      [001] .....   240.356454: mm_vmscan_memcg_shrink_end: nr_reclaimed=1 memcg=16
>     kswapd0-39      [001] .....   240.356479: mm_vmscan_memcg_shrink_begin: order=0 gfp_flags=GFP_KERNEL memcg=16
>     kswapd0-39      [001] .....   240.356506: mm_vmscan_memcg_shrink_end: nr_reclaimed=4 memcg=16
>     kswapd0-39      [001] .....   240.356525: mm_vmscan_memcg_shrink_begin: order=0 gfp_flags=GFP_KERNEL memcg=16
>     kswapd0-39      [001] .....   240.356593: mm_vmscan_memcg_shrink_end: nr_reclaimed=11 memcg=16
>     kswapd0-39      [001] .....   240.356614: mm_vmscan_memcg_shrink_begin: order=0 gfp_flags=GFP_KERNEL memcg=16
>     kswapd0-39      [001] .....   240.356738: mm_vmscan_memcg_shrink_end: nr_reclaimed=25 memcg=16
>     kswapd0-39      [001] .....   240.356790: mm_vmscan_memcg_shrink_begin: order=0 gfp_flags=GFP_KERNEL memcg=16
>     kswapd0-39      [001] .....   240.357125: mm_vmscan_memcg_shrink_end: nr_reclaimed=53 memcg=16
> 
> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>

Acked-by: Shakeel Butt <shakeelb@google.com>

