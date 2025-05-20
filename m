Return-Path: <bpf+bounces-58582-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F6DABDE8B
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 17:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D9411898E3C
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 15:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14632517A7;
	Tue, 20 May 2025 15:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZqIgHS9W"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A444A06;
	Tue, 20 May 2025 15:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747754014; cv=none; b=fkqYyYqpil3bW+vu6BWdg4omth/h0GLmpzCda5CEny7CsSsSEoRlKoTxW1CbIJIrjZun5ZAGqZa/xMpuiUiIX/HyfV7LZMs9XJimJw7Eeo80v2I1hYuWfy7TcWPjtwG78HAZdO6qUXYbiBXiW52ufXt5dUEG9o45Tk9hTo+jteU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747754014; c=relaxed/simple;
	bh=veZGFcdK7wH4Qm5Hog9XsWF9u/RyJ6GMMKNiavsMVvQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VYrVMOoacewS14N76aN4OeBsffjjKfSfOQp3jdcedn2X0TZ/w230mAP0MB1ENiv8v/SflOM9flLKSFztTLigeUUZpPz3IWs4L/i1ThnOEs/pMFR0W2rKSlx62M8Fl8LPUm3ZCstgRky2WRiDu6yNC+2wXaEFjD3dY5YwTqc1Shc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZqIgHS9W; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a3706ff36bso1789361f8f.2;
        Tue, 20 May 2025 08:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747754011; x=1748358811; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HJE7E40apopw7Tpx/qwpfh+n288sNe31SCRaYQni5/0=;
        b=ZqIgHS9Wb0gjQI+PodncCXA9Da0BBjx9FMbhdQTDb5Cz3xj0rMnZI7MyUl8WjpPsxu
         t0T9dOLCmdFTmWnl4EO3vCnGYRQOgr4NNjKm71Um388kwhCBd8GL8nGyldb6syCU3E4R
         U3ZSlbPYCqj6e0y+1TUVnXN5Be+SlXuIVYzSTKgXhlTXBspsjry6zX05YHGU0j9p4zwP
         T4OjY0+vJGo2zFyVp8TDmKrF1aYaTCbkSoESxZd53NmdV6r35Z/arpTIaSSjH8KPVIHz
         JgTl5A2+WJAHSPGxHE+GRT/ewtEiVAdWTxaAnUcfmnEy8wk4Ze+ec/GigeIIPFIAHncw
         tJHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747754011; x=1748358811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HJE7E40apopw7Tpx/qwpfh+n288sNe31SCRaYQni5/0=;
        b=g+RpqSrYZOhEEenwi11sShQMIwayE9qRlsrAHDjkdgzgO4qxsTkuq1JzFTMUHbLmHT
         V96oHBDgBCWG86qGezbBs3QaXD0wlwaPYKJwV3YuYZuG+PlDqtM8VS8EkibbQPy7lHSn
         h4gKVJm3AJ35DjUAINDB+iXieLDb70RERk3LONNv+n5WmBMlqjIpCPXjk8drOCneAjbh
         uif2GumE6k+Qp7acM2hdPNl00YCGvHN6U50foUB5FgihVGiBoynJXcBbNNM72gujBWzh
         Wu8QBqwNX4HvzMC1ecuYk516thr32Kw10NKOqQDPgaY2aqcJedtn06pdjMfXZCNbDqn6
         zeGw==
X-Forwarded-Encrypted: i=1; AJvYcCVAzMwcUxz86vRq1ITpDGiMdOp5y11Y+yDmFWshAV7yJ7R3B3dm0IA5RAMZJ4P+BRYfKu4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDMLZ58LII/pZR5bnfbg8QdkwmI/G5K05W+J4VYtaV5Ha4iLRl
	flUOs+/naGN1zKRjkhF2yi8zBj6KHGSDJZCKe9HMbTeMnpq00my+JbBq5/UwnN+z3U+bsixG7zL
	fSxtftReQaUQ4IpurfULqPt12JnBf/10GAT7t
X-Gm-Gg: ASbGncvlGr8pLmiE+NN38J6D77wAtLGEmyKcLZynGBSHWSzLHQ/QzCmP/aDeZv2U5OZ
	K8Iivp1ieElxj1XWNB+ErNu+ZR5uIN5pagcw/f3VDSKEPhU57BVaCDCaX6s25LcGKonNoGJsSO0
	3jT08rFGeCkOO3ut1bZabfyRpcDtCUKvqMZw3UZ4hHRoR3gsu22z12gYvjDyo=
X-Google-Smtp-Source: AGHT+IGQ9tICBB7sEkbZA51e/mJQOYCJMcfVUHIMRtqhpRSLoTeN6Rv11yOJ33l/QueTWR4cmW358MUs3b9AhJDrwt4=
X-Received: by 2002:a5d:64e2:0:b0:3a3:6735:1401 with SMTP id
 ffacd0b85a97d-3a367351679mr9550321f8f.56.1747754010719; Tue, 20 May 2025
 08:13:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250519205739.180283-1-rdunlap@infradead.org>
In-Reply-To: <20250519205739.180283-1-rdunlap@infradead.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 20 May 2025 08:13:19 -0700
X-Gm-Features: AX0GCFsJzoYf06YxPp085r0J9TiRll7SRvA0sIeQHzEDXzgDRZtZLCOuhzsRKvY
Message-ID: <CAADnVQLf06k6hFkrc3VWCzPBrqn0u98CH=q3dfJg82LkxK3oxw@mail.gmail.com>
Subject: Re: [PATCH] bpf, docs: add indentation to make the bullet list work
To: Randy Dunlap <rdunlap@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 19, 2025 at 1:57=E2=80=AFPM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
> Fix a docs build warning and make the formatted output render
> correctly as a list.
>
> Documentation/bpf/bpf_iterators.rst:55: WARNING: Bullet list ends without=
 a blank line; unexpected unindent. [docutils]
>
> Fixes: 7220eabff8cb ("bpf, docs: document open-coded BPF iterators")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: bpf@vger.kernel.org
> ---
>  Documentation/bpf/bpf_iterators.rst |   10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> --- linux-next-20250516.orig/Documentation/bpf/bpf_iterators.rst
> +++ linux-next-20250516/Documentation/bpf/bpf_iterators.rst
> @@ -52,14 +52,14 @@ a pointer to this `struct bpf_iter_<type
>
>  Additionally:
>    - Constructor, i.e., `bpf_iter_<type>_new()`, can have arbitrary extra
> -  number of arguments. Return type is not enforced either.
> +    number of arguments. Return type is not enforced either.

This was fixed a week ago in
commit 79af71c5fe44 ("docs: bpf: Fix bullet point formatting warning")

