Return-Path: <bpf+bounces-66068-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1911B2D875
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 11:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64EF61C42FCA
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 09:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEFC02DC34F;
	Wed, 20 Aug 2025 09:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fbjyb493"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B87C23A9AD;
	Wed, 20 Aug 2025 09:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755681943; cv=none; b=UBQU8Y2YCq68KOU/8HgVixOPpCro2TcH8lZPwuSUy1AFk/35vDUD1IL/StpyISXZRFiRy1puTcG1GLbNxRr+OEQcBO3vmjLeKe6r2p5d/RgDX7frgBGus/5S/kQbAR404gYagjuXXVqLFj4C8/WyUa/vS6vfqqJxtFxCOY22heE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755681943; c=relaxed/simple;
	bh=FQDOmH3hqx2lJBQXg/eBAyjvvUxL+CHcLyrtVGjwuSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lfK3NHgsELXyz36x6AtyH4864c3WuJbp4GlkaD9M05GoFH+ZD0vgzgYDnzSP2irkYLmBpIk97YzGd8TZuGVuS4mAuRtDSyWreQnETMC5ZpB4xQNqr+qUYOJetP+LGJgHvFVqi3Pr7l7N9kbHoH5G8AUbPeE2I4erSyvCHj4hwBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fbjyb493; arc=none smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-6188b794743so9707079a12.3;
        Wed, 20 Aug 2025 02:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755681940; x=1756286740; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TXaugHPMoplpDsoBjFEcdde60xwXGr2k9rLptADyPcg=;
        b=Fbjyb493jAmHzpWd/p1cLSoWqrhOeNA7vUZqspymbiTyQvTV+KNPKoPvEVWOosqQvY
         oLC+r3YToGeuUomhdI/wyCMXuszj6Nei3ToHO7cCuQn8RLA9eSvHldz9PAMXdBI1liZN
         MUm3VUW+gt8v+I1WehbUwjeVH27v2v+haMiirihqXR9xm/KQyy07vfu4kHIS7iU4tVut
         zYCwPafQlr/1YUyTVYADXpTqhiZtLkt84bzPkL5PlGmyXPqya1M/irEkidHGI1YRxUvi
         Q+vb2fGSIW6/T4HRwP0meiGiJxVN3rW0ykD9DzSW5VHxO7r8ykpZV8FwTUV8FUbyQI5U
         z/Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755681940; x=1756286740;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TXaugHPMoplpDsoBjFEcdde60xwXGr2k9rLptADyPcg=;
        b=UASfAsos2fcwvlV9MALNP+Yos0CChZBGlhPHNtlJ3JxESirI72VkJIM5cRdwLL57qs
         qCrfNmQXspbYP0nXuoENBMnG6z5RSZF04/gQgN8ytC7Rnr3ll/a2kcIfwwGXNorIZcjE
         Q2ro+3BxCX0rvt0+pW7gAuirbt2JVG7TrKhPjcKt7tcSsHMcWZHYkoW8QHtb+nWq2Co/
         EQ4glXFdRoLO+CjrTDCrXxWay2+e7C9VVafBXKK9vlbFkfDNntRiloSls3rdoIFIVuXw
         GmAI2gZ/WLnlPVIW+FJQU5L/XRndEZBVXVri75dLqFqUcGu6sYUSBlSnGxmjQeOsHxeQ
         chtA==
X-Forwarded-Encrypted: i=1; AJvYcCUxOzhG5VjgwKs528EwjjjHs/yVxY6zfrh2hLQZBrlccRGwjwO+68xq1NMMqvsXH4t9Qi9YUfmxG0Swkz4j@vger.kernel.org, AJvYcCVNrz/r1S8TWre04VBA1uFPQfmbXlppyp8J/kFV4OdibswZFF7kLADEmMIGupHy4Pi5j4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZfZ98BV+RFiT8NR4z562UPYFAvPpiObazlCats98aPM2iKVx1
	86wzrkVJZcJC1vTYTBjbxaQVsgSfck8+kp5iV9mZAcp6z6OH1oFfCiVoumQKHVA/Nr9NC8UgEq8
	cdUdhtjKKLbbCucYXeTs/4EE1F5K1pRE=
X-Gm-Gg: ASbGncuWQm+fsPpRc4qgZN9tDlMKMrMjP4P0ZxtmUeLgkzR+GyIQLOJkSv6qsARSUxV
	f8BN8rnBQEdYJvh5prjHeJZOgr6+VbP/EhNb9BE3hoWRhEBaCSLG2wBJPjBPMB2JLRCMCOHYbyn
	674omr3nP+vrPqS7gTMABipVSMnA9lS6+k7UqWB4xTyPLvY+yylNlfaZsSAXKQ8M7pfZh1E1jOI
	lZeDNWTktJ+vg+W4bNN
X-Google-Smtp-Source: AGHT+IH5r/oUOPIaZVKzeJ3UawFBydND2m/Zr4Z8FjLc2Sf4IdgmOgYNeZoUcGG6NZupv1UlJJ+OmXXFf9P7zfIG2lQ=
X-Received: by 2002:a05:6402:42d3:b0:61a:8966:ced6 with SMTP id
 4fb4d7f45d1cf-61a9782505bmr1832376a12.35.1755681939804; Wed, 20 Aug 2025
 02:25:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818170136.209169-1-roman.gushchin@linux.dev> <20250818170136.209169-6-roman.gushchin@linux.dev>
In-Reply-To: <20250818170136.209169-6-roman.gushchin@linux.dev>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 20 Aug 2025 11:25:02 +0200
X-Gm-Features: Ac12FXxpl9gi1KUaEwzxMMmXIWzdn3euZF0dat5BG2FZFZDhN6aQnB8C060Jz44
Message-ID: <CAP01T772oh8t05Pth2eWFzfSGVWDuW6kujRVSYQEreqZy==nOQ@mail.gmail.com>
Subject: Re: [PATCH v1 05/14] mm: introduce bpf_get_root_mem_cgroup() bpf kfunc
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: linux-mm@kvack.org, bpf@vger.kernel.org, 
	Suren Baghdasaryan <surenb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@suse.com>, 
	David Rientjes <rientjes@google.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Song Liu <song@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 18 Aug 2025 at 19:02, Roman Gushchin <roman.gushchin@linux.dev> wrote:
>
> Introduce a bpf kfunc to get a trusted pointer to the root memory
> cgroup. It's very handy to traverse the full memcg tree, e.g.
> for handling a system-wide OOM.
>
> It's possible to obtain this pointer by traversing the memcg tree
> up from any known memcg, but it's sub-optimal and makes bpf programs
> more complex and less efficient.
>
> bpf_get_root_mem_cgroup() has a KF_ACQUIRE | KF_RET_NULL semantics,
> however in reality it's not necessarily to bump the corresponding
> reference counter - root memory cgroup is immortal, reference counting
> is skipped, see css_get(). Once set, root_mem_cgroup is always a valid
> memcg pointer. It's safe to call bpf_put_mem_cgroup() for the pointer
> obtained with bpf_get_root_mem_cgroup(), it's effectively a no-op.
>
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> ---
>  mm/bpf_memcontrol.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
> index 66f2a359af7e..a8faa561bcba 100644
> --- a/mm/bpf_memcontrol.c
> +++ b/mm/bpf_memcontrol.c
> @@ -10,6 +10,20 @@
>
>  __bpf_kfunc_start_defs();
>
> +/**
> + * bpf_get_root_mem_cgroup - Returns a pointer to the root memory cgroup
> + *
> + * The function has KF_ACQUIRE semantics, even though the root memory
> + * cgroup is never destroyed after being created and doesn't require
> + * reference counting. And it's perfectly safe to pass it to
> + * bpf_put_mem_cgroup()
> + */
> +__bpf_kfunc struct mem_cgroup *bpf_get_root_mem_cgroup(void)
> +{
> +       /* css_get() is not needed */
> +       return root_mem_cgroup;
> +}
> +
>  /**
>   * bpf_get_mem_cgroup - Get a reference to a memory cgroup
>   * @css: pointer to the css structure
> @@ -122,6 +136,7 @@ __bpf_kfunc void bpf_mem_cgroup_flush_stats(struct mem_cgroup *memcg)
>  __bpf_kfunc_end_defs();
>
>  BTF_KFUNCS_START(bpf_memcontrol_kfuncs)
> +BTF_ID_FLAGS(func, bpf_get_root_mem_cgroup, KF_ACQUIRE | KF_RET_NULL)

Same suggestion here (re: trusted args).

>  BTF_ID_FLAGS(func, bpf_get_mem_cgroup, KF_ACQUIRE | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_put_mem_cgroup, KF_RELEASE)
>
> --
> 2.50.1
>

