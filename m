Return-Path: <bpf+bounces-40505-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B41D989659
	for <lists+bpf@lfdr.de>; Sun, 29 Sep 2024 19:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39BC61C209CD
	for <lists+bpf@lfdr.de>; Sun, 29 Sep 2024 17:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DBA017C22E;
	Sun, 29 Sep 2024 17:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/ESwP3q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A74DAD2F;
	Sun, 29 Sep 2024 17:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727629271; cv=none; b=Uk26kYZAGM+chxxhUZHWLlra95RjqWLKiKOgIgoULHNnoujMU4WHqqq5+HLgqIQeh82n0xYTH83fGtBU3nLfWhwcPF9Avq+HABqFxOCdxI3mqLMJCsQ37hkC5B2+yB8rd5P77t4GA6T2pRXNa0uIZuJ2SbLoZGHAGMMQUSFfTd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727629271; c=relaxed/simple;
	bh=l577ahIR5wLdiyALSsVJ8b3p0IEhxwg3Sa90ms3OgOM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XhQDiKpMp4zGlV9EBkbiuSUMuevxHQ5uKGektN2xy1lIPVYrt/hR/WMgT4Mjjf00qX8yCS3g89kMYuYa2UOgDSYvHKnHS1SeixHsBJ4FFA1L/UB4k945D80kU20kjTiaYA4/RGMZHTdBjXp1YJb7lmTnC/Yn78kJU1G35HsAdls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W/ESwP3q; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42cacabd2e0so27870445e9.3;
        Sun, 29 Sep 2024 10:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727629268; x=1728234068; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l577ahIR5wLdiyALSsVJ8b3p0IEhxwg3Sa90ms3OgOM=;
        b=W/ESwP3qZWPRU2kCcOMCeJAzFK1Dq7k0lilZiQw72/2OLpmWMFV5Qy0dCoAKSXOKhK
         CYb8R2I4z/yFq7nBrFbd7dq3HsXU1ojMJqhz1N4ff1gBYZSbHaO0Ne7U5M+veRUhfYfK
         rY1XfLxuZuVOmeOB2Yad60PkU/oz6v4656n91/58CKLNw6HUZ0gVPxx1M7oMRjoOttXq
         Sq0wsxqv3SV1sAoJZTsUjCxsUAc4mwh+t05+F2QP4rHk8ybJZErwTPsaNmqeKj+3b0EA
         sPVWJN5Qbj3q4eXo38S0dZaJyR0ab2fB5KXOAsw24M2v4DshJA2AMDu+HFh3+XwBbavF
         XVWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727629268; x=1728234068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l577ahIR5wLdiyALSsVJ8b3p0IEhxwg3Sa90ms3OgOM=;
        b=iaTXULEKy3xcCoEmd1qAl5eIiZ5xxIE0UVBiggZfuipLI6gsINESEbJ+cEXcFI6QLB
         p+2JAZtRe571ckAIifYV73DtqFmUY6/hdnBG4l3CjTVwGumlHquteNcwjV4wfs3yY3Bd
         BoyCgbdrPRPdTB4qv9ZAuUHByG3UJ4V40Vxbh3ORyL0eeBufR/uAuikK05PNq+rbGt4q
         VbsX4/tfM0ux2e+pE8q+k77TXiueC56Rg5gmGao07+tAFXLTPFZ+NjAOBvi8b6qzYCAc
         ySszUvHIN+rLcG2P3c/Cl5Y5Lk5K+zq4ZjZAnwVKGSjQtUs0sdtZ5iFH6PWa7xwPLO0u
         sBFg==
X-Forwarded-Encrypted: i=1; AJvYcCVL82tmh6/gKml9SRldImLl5MYO41fxpmQF2L15AWI4Mlsjt8KAu4f3XCayiQzNlVMyeQE=@vger.kernel.org, AJvYcCX/H3NFWRdZBKyOhbdUAVhEj/U+PxHFlxZL0qJR6T7V9HtuZOFAhYkK8d7oBGy1ra6NRVgbbeot7E6MeOJ+@vger.kernel.org
X-Gm-Message-State: AOJu0YxUFkXYeAI2GAhaxwEXL4pWZ4Vaxb+h96FWABPpTKdQGMYda1gU
	fd89Q8bmkK1H9YuouS8HyZ8nsoY76y+2YbWYBHlL/Bp/lmeiZn5ovYxXD1tlPCl7ojivJUxEB7E
	jN6agWyqs/OHnbkcPC3qtuhe1ysk=
X-Google-Smtp-Source: AGHT+IEjL439uyMb8VuGXv3gbJZZsJ9N/J7vWF0CFhCFVMbVaVUe4kFuMWHf/TM/QTIrkRUkKgRBkuojVDvGymtLWHM=
X-Received: by 2002:a05:600c:4751:b0:42c:de9b:a1b5 with SMTP id
 5b1f17b1804b1-42f5849732amr65207635e9.32.1727629267831; Sun, 29 Sep 2024
 10:01:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927184133.968283-1-namhyung@kernel.org>
In-Reply-To: <20240927184133.968283-1-namhyung@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 29 Sep 2024 10:00:56 -0700
Message-ID: <CAADnVQLeARMvSqg0aqgBS0vncV-m6e+sM9C_Ox0r3SL1=GpRgA@mail.gmail.com>
Subject: Re: [RFC/PATCH bpf-next 0/3] bpf: Add kmem_cache iterator and kfunc (v2)
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
	linux-mm <linux-mm@kvack.org>, Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 11:41=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> Hello,
>
> I'm proposing a new iterator and a kfunc for the slab memory allocator
> to get information of each kmem_cache like in /proc/slabinfo or
> /sys/kernel/slab in more flexible way.
>
> v2 changes)

The subject is confusing CI and human readers.
Please use [PATCH v3 bpf-next ..] in the future.

Also note that RFC patches are never going to be applied and they are
ignored by BPF CI.
If you want things to land then drop the RFC tag.

