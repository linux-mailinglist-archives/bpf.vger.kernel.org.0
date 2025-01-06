Return-Path: <bpf+bounces-48002-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0194EA03143
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 21:19:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8569F188664D
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 20:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33751DFE26;
	Mon,  6 Jan 2025 20:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0vyDbD9E"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155441DFDA2
	for <bpf@vger.kernel.org>; Mon,  6 Jan 2025 20:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736194762; cv=none; b=HlSq603jnsAmXesd0Vqko4TXNceXh1QCFdyeN8LPR9I0OoyiXXipLHGuCUlAGtxS5QNn59K8gsXsEJ8inRBSfhITTlxz4ZygtrJ8jFsidMPk8rApfdVAZbihsF9JogALYF8bafTwCGrta48EpUztwylZsiZjdIrOMLyuHtGV9Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736194762; c=relaxed/simple;
	bh=BEGHNYf1HV04ZdYUrBM9HObaBWYpTXvn0aQoVfK3j7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KOGYDukh4v7341mbN1fl+x87UffWPFNqYNNvYFhI3Eqr/vsMYbVdc4IoICjdKOB0fauKLcJM4jP8YRI7ORKn2uO2U0x8LxMWoLt+qNuyluv6VgCWQWx0T05m+3shxDnSvxtXkAGLaqtjhu8FWxjLJJaHtjInjdooXsgQvRi+ass=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0vyDbD9E; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-215740b7fb8so25975ad.0
        for <bpf@vger.kernel.org>; Mon, 06 Jan 2025 12:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736194760; x=1736799560; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BEGHNYf1HV04ZdYUrBM9HObaBWYpTXvn0aQoVfK3j7g=;
        b=0vyDbD9E/EJ0YXWyOYDDAX1tduDrO0bOFbumDqauMBJbF6P5Jc99RGYwB1q9IBqMMN
         1eHOuut6Q/LtIrY001AYLX7KWzuUI9Tsqpp23Rusw4AhL+oBtDVvWre6+QHpf10zYVyU
         NckA24Y/qJoamFbj1v0RwkuOAE//A5k4/IAspVEVHXMWcVhGTEzkmBnCGMkMpVrdGC4n
         DGZDMYvUnBvJ6TvhOcY9UI6WM9Hoj+zEPOqTnoBAfEwj/iO4c5aQAxXVqtlrW72qgwRO
         1/IRigqd6LilQl8kSyr/q5QBhodRAfL3kO1VOh+m1SMq7V+MhqHK/dQ2z5JCmUY9ZYTC
         yoHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736194760; x=1736799560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BEGHNYf1HV04ZdYUrBM9HObaBWYpTXvn0aQoVfK3j7g=;
        b=Te5B4lFmNJs4+a9/dbUDDL5LbHj0C3wu9MYyOPDKrsAr4iB3XvCkiJZicFZ7jVH/KL
         6KRUBWQFYSomTBZX64CTUJpqOxjGrNYTzrrzdXIFDDHwHdoCdZPQMoePfxQJJ2tJv4Ty
         8veyQ+tc3itOlQnVK+URWOgW6BbdgzrgOFKjqQMIPaeNx5NiZsJUWYyR1/WFMHkdcp50
         uo6g68Jlj+/M/pJLWGrvj9aY4m4uGFXIMpdD/JSXPxk5XVy8djoYTWyyDmL+/BoV+vJp
         clpTVsmMwTeyH7jQpQ8V8b/fG/F15gyg13yIb29hT2p2pz/YcwP4vaT6YywZ2oEtmOxG
         /N5w==
X-Forwarded-Encrypted: i=1; AJvYcCXgCjIwjsM5IwfOrY/T6LG/503qHSTJh6reDMY7vQUb+eB15SdC1vskwe3SFg0W1ysb/kE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5UjBcORsyePPtyZ1d/HUZLRvM+7C7fWMZ7WfnJeScnjKHL33N
	1c/yGkylZo2ogxc4f4p35BgFb1NOr5ASMDFdbIsSFwTUS+8nfO801SlNOb6aF1kPP6vWbmx8key
	NVcTtT74aqV5UTxvq+Tz3Lkw7ukKfrjQovVWO
X-Gm-Gg: ASbGnctN5sByPanltFfRV+XPLlcdN9h6E+PIZpdQLJjm14/QAv2KrbJdvbK+vlQ3sTm
	sbpAJ0lOX9ZRW/Lwwr1Eqcl3A6nNW9pKj7KQ4dWABRO1FaGwt0+RjO6RXvTthFqvvgLdfyms=
X-Google-Smtp-Source: AGHT+IEZs9gdoIt9Lzgc7kMrvGMX2O81Tsoby2UzTbDgJoRlZHNyCguDmX+2yIQysSWrX8iUjp7uIBEB2tZGsdcELi4=
X-Received: by 2002:a17:902:d481:b0:200:97b5:dc2b with SMTP id
 d9443c01a7336-21a7ae5dfd4mr243615ad.15.1736194760083; Mon, 06 Jan 2025
 12:19:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20220911083418.2818369-1-yuanchu@google.com> <20250103031526.529434-1-tianmuyang@huawei.com>
In-Reply-To: <20250103031526.529434-1-tianmuyang@huawei.com>
From: Yuanchu Xie <yuanchu@google.com>
Date: Mon, 6 Jan 2025 12:19:03 -0800
X-Gm-Features: AbW1kvbczPJKPcB1QNME6O5RCEPnK3Uv_yx2M4XE7l0LVmJ1WOJ3dEPMoQWN53g
Message-ID: <CAJj2-QEtASHEfiYuoKrfx7n1UjDS1e+aF0LdYB5vhBUUS3cq8g@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] mm: multi-gen LRU: per-process heatmaps
To: Muyang Tian <tianmuyang@huawei.com>
Cc: Michael@michaellarabel.com, akpm@linux-foundation.org, bpf@vger.kernel.org, 
	corbet@lwn.net, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	yuzhao@google.com, yanan@huawei.com, xiesongyang@huawei.com, 
	wuchangye@huawei.com, liuxin350@huawei.com, zhangmingyi5@huawei.com, 
	liwei883@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 2, 2025 at 7:15=E2=80=AFPM Muyang Tian <tianmuyang@huawei.com> =
wrote:
>
> Hi all,
> It has been a long time since this patchset[0] submitted, and I've been d=
oing something similar recently.
> I wonder why this patchset remains unmerged/uncommented? Is there any oth=
er similar work?
Hi Muyang,

I'd love to learn about your use case and your approach as well. The
code here requires some polish and cleanup, but it's mostly bpf code
in tooling. Happy to work on it.

Thanks,
Yuanchu

