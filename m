Return-Path: <bpf+bounces-72665-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F019C17ECA
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 02:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6D2D3AB112
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 01:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0A12DCC17;
	Wed, 29 Oct 2025 01:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MizhU3h9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD832D94A3
	for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 01:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761701586; cv=none; b=WfK79yyxktqDhin5+xWwgdnno3hk0HywNPO2VvWiICvVH/0dkZRr2RAgx05vNO/UOIUS8GBuNC0mnZQcftfujLmVB+/35EhJk1VqMtuC5+PqBK8JbkkNUDt6ZbM+f9EvEfTnHkIh94i/2obbMz5wS0scOc3biEBZu9fCJFGXZU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761701586; c=relaxed/simple;
	bh=pmhydvD2MgUHYPhxKAoACrnhJ2rWSahvGpIvyudUCls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RnSCjOI9R8Lp2UEuAujVHTWXzJGDfaPq/JPTHGQdRPH7QG61ZUhHd5LuxyE5oM9TGv0OP+IhHg3F1c4r8PZEuLcVTTBjLSl1t9J1FwLp83yJVYH8yuC4bCM2/eJDWd2/Z8HYiaU/0Vho/kaUyDl36yZAU/uGiyBM/0skKiKsc/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MizhU3h9; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3ee15b5435bso4986447f8f.0
        for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 18:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761701583; x=1762306383; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZgb8HNWg7Vp1KBGuTQoK7+25dHkAhI3MFTK1ft779c=;
        b=MizhU3h9Lel7JLCJk6nMMY4OqYEGq9BHCo8j5eJxK8SBQrAqgo9HOL04i/m0oqs5yH
         fEToWeGiKZEEPlo37Pxv5oTtj7IGK6sCLlHOMULLTRbx/8upRrm3wIbhHm6dWHJLM5U1
         054OvroyyiDcbhgkOQyo+Q1yKEl+nE30sxEHqRtBo+RCP+wPo9T3T8fFXTMNjiyAFY//
         2lpy1JhVBeVgxRJpRs7LaIplko1aX5+90+v+sciBhlSQWVeJitw1VEdPP5okQ37/YZ4L
         FNtJYl17GTFEjsJV4JAmT+3qQoPD8iV4RxlzIsOp2g78WZBcUpmHZ6V4W7G5y13M/79j
         eabA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761701583; x=1762306383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NZgb8HNWg7Vp1KBGuTQoK7+25dHkAhI3MFTK1ft779c=;
        b=aLsVcpTC6dTZ+6cznFotHf+dQXhMf2OfAh7Ami+uMiLnTpcwPWIhj2BGzL+6gWMFDK
         J+djVsi2q2wLI6mPWzN+wQ5d3kcL/5Pni3UYdL0HJLcgKJ1S3Tvmiqf1FpPT+2XEwrua
         bjefzHb/XbquDsmTENT5SvI62v5Mr/reFTrqtYs1j/GgL5LxQ+X5V2ziGARQ734YOHNB
         fh4Qwq9fYx8g6YC+9V0d1yTbO0+sGTk5IWyfXXCZsZ4z6TDhDSxwAR5BH8VTdDQdIw7y
         0ZGhNJ9EDYpw7qzB++wUqs8PFcA8Nq7VLd+Thj0dtURnqELE2S5w/InopMJknNZplnXj
         ADmg==
X-Forwarded-Encrypted: i=1; AJvYcCWzj9GLiMCLxbN20zsdCjGYqPvaLgQyMeXwnCz4HhMr9Mb+xOatLtWHJk4siz5xqYNBHRM=@vger.kernel.org
X-Gm-Message-State: AOJu0YytXUo6WMnXrhvGXrA09vgJMy7mpPIDe7i/A5M6bGPB9h8W0vln
	Rx4n0+k5Kx/vL5I6Rg29ijUHQqKHyrMb62m/N1cNACV6Jyixl0wOzCzq8M73CLMcavpYRbhX8gz
	H2k0n9SLIYR5fwpsFDM4RWjJcN6a/jIU=
X-Gm-Gg: ASbGncs2tnjSHTOd3YtyESMl46rkrwcxrYnYLZQsZ9cRcoIUJnnG28/uW/oT160h7vS
	d5xGF2Dd4Z+4BIhApJjWcrJWqp8P/L38J6vXYS+keumgvFbxBhNjVNgw1/dIgLNQEmuw0noJvrF
	sNm6ymbeecDEBFJ71pd1PQTwXf9V1EbmDHqhc3R7qdvsuKWT4DdwQWvzDihoTRaea9ERyL415rN
	2nEjRZ/Y52poK+L/QyNAGkEoADCA7MGjcdHXVaaND3/qPSr/85xm1n5dDGL6UGDMtZ/kSlfbhA8
	6B0tOEkqTJ33Z3nhVQ==
X-Google-Smtp-Source: AGHT+IGTMzuv/ArJ+OYA4q54z3AmWM67z6gdganGyzk1cdUdXR07L641GaC7I+IwWt6JzcrPAq7tGRPMfDWEY1QXS5M=
X-Received: by 2002:a05:6000:26c2:b0:427:880:9538 with SMTP id
 ffacd0b85a97d-429aefbde03mr708524f8f.45.1761701583059; Tue, 28 Oct 2025
 18:33:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251026100159.6103-1-laoar.shao@gmail.com> <20251026100159.6103-7-laoar.shao@gmail.com>
In-Reply-To: <20251026100159.6103-7-laoar.shao@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 28 Oct 2025 18:32:51 -0700
X-Gm-Features: AWmQ_bntzSgbNvji5U8WdqIphFhfm5XUNy_QTFtw53IwUs3LIlTTv2I1GT8Ge5E
Message-ID: <CAADnVQKziFmRiVjDpjtYcmxU74VjPg4Pqn2Ax=O2SsfjLLy5Zw@mail.gmail.com>
Subject: Re: [PATCH v12 mm-new 06/10] mm: bpf-thp: add support for global mode
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	David Hildenbrand <david@redhat.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Liam Howlett <Liam.Howlett@oracle.com>, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, Johannes Weiner <hannes@cmpxchg.org>, usamaarif642@gmail.com, 
	gutierrez.asier@huawei-partners.com, Matthew Wilcox <willy@infradead.org>, 
	Amery Hung <ameryhung@gmail.com>, David Rientjes <rientjes@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Barry Song <21cnbao@gmail.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Tejun Heo <tj@kernel.org>, lance.yang@linux.dev, 
	Randy Dunlap <rdunlap@infradead.org>, Chris Mason <clm@meta.com>, bpf <bpf@vger.kernel.org>, 
	linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 26, 2025 at 3:03=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> The per-process BPF-THP mode is unsuitable for managing shared resources
> such as shmem THP and file-backed THP. This aligns with known cgroup
> limitations for similar scenarios [0].
>
> Introduce a global BPF-THP mode to address this gap. When registered:
> - All existing per-process instances are disabled
> - New per-process registrations are blocked
> - Existing per-process instances remain registered (no forced unregistrat=
ion)
>
> The global mode takes precedence over per-process instances. Updates are
> type-isolated: global instances can only be updated by new global
> instances, and per-process instances by new per-process instances.

...

>         spin_lock(&thp_ops_lock);
> -       /* Each process is exclusively managed by a single BPF-THP. */
> -       if (rcu_access_pointer(mm->bpf_mm.bpf_thp)) {
> +       /* Each process is exclusively managed by a single BPF-THP.
> +        * Global mode disables per-process instances.
> +        */
> +       if (rcu_access_pointer(mm->bpf_mm.bpf_thp) || rcu_access_pointer(=
bpf_thp_global)) {
>                 err =3D -EBUSY;
>                 goto out;
>         }

You didn't address the issue and instead doubled down
on this broken global approach.

This bait-and-switch patchset is frankly disingenuous.
'lets code up some per-mm hack, since people will hate it anyway,
and I'm not going to use it either, and add this global mode
as a fake "fallback"...'

The way the previous thread evolved and this followup hack
I don't see a genuine desire to find a solution.
Just relentless push for global mode.

Nacked-by: Alexei Starovoitov <ast@kernel.org>

Please carry it in all future patches.

