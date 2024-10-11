Return-Path: <bpf+bounces-41777-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F1F99AB07
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 20:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 631C21F22158
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 18:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76FD71C9DC9;
	Fri, 11 Oct 2024 18:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQJfT4ik"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75314125D6;
	Fri, 11 Oct 2024 18:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728671742; cv=none; b=BSCCVEjCyuuqNZaEwnd2ZiN+Wth7QKeyFJH6t6yZnDajR21+cfyiDEeqp4/3uTJQNxWnhNzoTmYJvrOL3Dq3gG9rLnyglZRV/xKXqA5tNSit2n2TlYGF+LQyuRqdKn+8tiMEfbEgaWGAt7df1EOhDyYxuPug041Plh5W57wbIpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728671742; c=relaxed/simple;
	bh=h4zL0ieXGB9zJYJRf743gQUqqucWnxaLm+2rct6vqQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ch1AGy6fR67VTFj+N0RafBEgY7e0HUah5liirLMkGHhBJTuWEBAzjPEdRq8pg8wdle5qKXoHWtX/G2cI3y7BUkOGgBiuCTH8mgm/Bf9b7o0QGAoTpP0PJzCl96nPfNnmfQvGx/hge+AJriuOkMxTgrp9ntihSze9nIfyREGFafg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HQJfT4ik; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-430ee5c9570so25296445e9.3;
        Fri, 11 Oct 2024 11:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728671739; x=1729276539; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f17+CR3aOOh6eTbn9GMPLRytPEIkhoTDYaMcC8ki2/M=;
        b=HQJfT4ikj7v2X3UPqTY04UGVMOoddL3Mu4JjrGP5T/vHKfHkMinvz9LiF3pE0T6hn6
         8akzLSy8GgepSS/Ybsal/11hXm7L+GCNMNgEH40PWtuw8rNWiTHHaZw2p5dlTCNOKRs4
         jjdlOnmRUgl/a5scahChZQIP3x4hFETAiwDZitX/7GQZ+S6AoNcGfr/ZfvUJ6XgafILc
         g6XSkWL5inWS3LKl9viGad65yGL5LfFLFEIXqgFcgX1UzGnKUEkd9leZW43MyOn3xT9I
         l6r2r4PcURIzlc6PeTU9ggGYfVVIHWoepV+8yWQUEVeeRZeVNv3qUs6hvJ8UgL15WELs
         OkVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728671739; x=1729276539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f17+CR3aOOh6eTbn9GMPLRytPEIkhoTDYaMcC8ki2/M=;
        b=Twnl5oEiA7FWbJjGZdSL5zsqixCM1bnwpBTSB3PjtHuMOWfNRzbWGZTJbSL1fdNehJ
         klVHG9oxj0c1k+/y5h4FueZMvio5LCcqq2/GWthpHaC0XQ0w7DBoKpB1R6WlHJj2Zfc1
         0MkQYP51YymCrDo0DjNyXWkZdC3apyQNBCJBAzUCKCHmR4Azr1GrcbZSWKzaCD4tAjhK
         cQPynk/D9/AjmNpU9nijTwgQ+XJ2blqSCXiCSll6Y6qfeyxXRus7bV4/OjFsnutySqdY
         qz+jiEg2fB1ig6O2Hrg1IXyEhI5tg9JjjhDUORnZZ400Y82X0Gq0PIxKxesZJGFMvBki
         sKpA==
X-Forwarded-Encrypted: i=1; AJvYcCU5QLH6AhJjMnGsCxy6RJemsRw0YvCXBxigdqh1Pa/RpwBb3qwuqZfQa2RNPHrgH0lUiOz1huq/PP75ORo4@vger.kernel.org, AJvYcCUVhbIMn3OYBXVs6A6MtK7g3Ql+ylYB6yNrV3tudHh98o/MVa52amkfeidgVpUE0cH9BQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrcZ13AX9u+MJl70CRsmwNf88cLyCGxlSXP2qarwdCs2xU1DHM
	FWGxiIOkBc8PkoKYuTALxFd2477B0TI9goIEYXJZdaD+1je/961qYZKrs+s8hVsFBDwS0Ut18bx
	M0G9QtMMaZnis8i9YImdIbaEpj1s=
X-Google-Smtp-Source: AGHT+IGZi2ojXKY51cROyUPSMxt2G0s4map61sfmzgoTA1mMLzPAGGlrJLO9s55yFhWLECl3B6S2D6QvFfDch43G/IU=
X-Received: by 2002:a5d:498e:0:b0:37d:4eeb:7370 with SMTP id
 ffacd0b85a97d-37d601fb914mr412209f8f.56.1728671738773; Fri, 11 Oct 2024
 11:35:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010232505.1339892-1-namhyung@kernel.org> <20241010232505.1339892-3-namhyung@kernel.org>
In-Reply-To: <20241010232505.1339892-3-namhyung@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 11 Oct 2024 11:35:27 -0700
Message-ID: <CAADnVQLN1De95WqUu2ESAdX-wNvaGhSNeboar1k-O+z_d7-dNA@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 2/3] mm/bpf: Add bpf_get_kmem_cache() kfunc
To: Namhyung Kim <namhyung@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	linux-mm <linux-mm@kvack.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 4:25=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> The bpf_get_kmem_cache() is to get a slab cache information from a
> virtual address like virt_to_cache().  If the address is a pointer
> to a slab object, it'd return a valid kmem_cache pointer, otherwise
> NULL is returned.
>
> It doesn't grab a reference count of the kmem_cache so the caller is
> responsible to manage the access.  The returned point is marked as
> PTR_UNTRUSTED.  And the kfunc has KF_RCU_PROTECTED as the slab object
> might be protected by RCU.

...
> +BTF_ID_FLAGS(func, bpf_get_kmem_cache, KF_RCU_PROTECTED)

This flag is unnecessary. PTR_UNTRUSTED can point to absolutely any memory.
In this case it likely points to a valid kmem_cache, but
the verifier will guard all accesses with probe_read anyway.

I can remove this flag while applying.

