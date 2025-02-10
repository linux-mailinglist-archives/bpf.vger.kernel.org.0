Return-Path: <bpf+bounces-50998-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4CDA2F32B
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 17:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EE621885720
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 16:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB362580F4;
	Mon, 10 Feb 2025 16:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Spyl11ur"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11682580D8
	for <bpf@vger.kernel.org>; Mon, 10 Feb 2025 16:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739204512; cv=none; b=gjZo28B4nB1NN7hEvATV/YR7LxiSTRKGsyvAQhZrqVTENugwmUUoTgzcGx85gfF+rgBYWbMe3sEkkCQNUSZPlQbD7Jcl4+Rc/TWaEGivpwrNTteMeBsfwWbFy2zA8YFYlTMvmMRRrCR20HPrxMEv5AoLYrqXSvVtBe0Xyxnkg04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739204512; c=relaxed/simple;
	bh=KIqBkUSyhCVeVPELNP6ISV0HCnomhljLgtcM2pOAoUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O1/bBYrLwqgWdG7cNSQNb78YXcSkHkr5IEL+kJXI7o+23ApQjZ+gbP/qJTKuOsUvtgOmVrnMUUqevUwt9el+BLxJ85dgXfGO6wTdj7h9J3dpb4KUF7UEHXl+B7ewb2D/muxPN6c45ULrPK92qVTMuzcSr1Inxo5SxDAiSHcwCE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Spyl11ur; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5de51a735acso5840658a12.0
        for <bpf@vger.kernel.org>; Mon, 10 Feb 2025 08:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1739204509; x=1739809309; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KIqBkUSyhCVeVPELNP6ISV0HCnomhljLgtcM2pOAoUg=;
        b=Spyl11urk48vjBb63Eiqe68b5dQQq6kwPba4Aww0qcYBhgagSi0EPHuHxnciOeTC5L
         dzooTKDnsUyYYh04/vSp/9RjLK5ptplUHlvc+v5uctevsHfuinmlIkmnkD/uak4Elcjr
         3oKPGFa2R4bt6cs033p786DCzVIJnM+JZfvSOG+GBBh+m1nG3bmNzGTSkw4H8fNDPg4n
         61D42Wcxw4QV+x6/KEnodlLdXVtU3uv+8usJlMntfuUhdHBaXlKTL9d3YmYaHN/LTkJB
         qUwuWRi6kEg5mJcxYBfvaVKsiUs5QYm+ckWfotS+yGiiQzUG1pF0c7EiqraFGyL/KPU5
         0aAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739204509; x=1739809309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KIqBkUSyhCVeVPELNP6ISV0HCnomhljLgtcM2pOAoUg=;
        b=ZMzAVIGvpwG9qZ6r4s21jWmIBqEXkh1rd4umWLzSyMC1B9EEALeYPK41DcoMUkBP3Z
         GSF9BQeCWnc7pP9Iwp53JN/W4/yaAjAC5yNBccAEKEa34SO9d4G50hp9uMgXMlVtxWSJ
         UVaibxaZi9XNuSqfGTgrMnis81n3IHceeb4Cbk9LaM28aLKRfsNx/mISVUQBFWLq5K4F
         Sh45hafJRxJh5XSMWwJkIXGR04M4WeOP1+YG3xQO6BQwfMdWiUFpiWNsB3gsd8M1B3gk
         VLEMUzf0P0GqIpjHt4uoDJRs1yWlloNanySVFiNfFjdlwG6ZOOwo9Wws45hgFzTMBobF
         GAlQ==
X-Forwarded-Encrypted: i=1; AJvYcCV02d049v1baqmMKepQq34HtEsUcZfNQ80IkQKaID8zs8xUtQG1oJu6AaiMgMfNEBBgfG4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHkLooOO++a+PkVmMIkj1PhRa0OQrGaxmKtVjYWlHaCSa4UgOw
	4M3ksdbIWd/W7KCC1jAiTbNSu61ES+KhFmWXASRYHiGNQCAEeu+l+kt7YWfMKO5P+20ehE6OsYR
	8418587MBPdNthGGTaOxNyHlNsJqTF8agAEciww==
X-Gm-Gg: ASbGnctuxrZtchxm+7Fnl142hdwPtCThZs6rXLd7u8KtxtTyqNgjhIhF5Q4eEewP1fL
	rBE8vy6Ex/1cIGmMMLPJr1Y35UCAp2ZPN52E4nJjeHo1wyl7TUNSDhNihcH+ViAY1qVVcFB8aCZ
	Mm1FWWIgc50XCbwec=
X-Google-Smtp-Source: AGHT+IHy71NYgSP/cCvRFmJ3G6I8GQkkK8vW2MV7RYTmiEkeOtYPIG8dZEldxTbMHipBtrY+5n8UQFrBgYq2RkcMjZw=
X-Received: by 2002:a05:6402:13c5:b0:5db:e7eb:1b4a with SMTP id
 4fb4d7f45d1cf-5de45005a3bmr15164299a12.10.1739204509076; Mon, 10 Feb 2025
 08:21:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1739171594.git.yan@cloudflare.com> <85618439eea75930630685c467ccefeac0942e2b.1739171594.git.yan@cloudflare.com>
 <Z6nEsGSbWqCSaVp3@krava> <CAMzD94QZQjpwOA8Os3khG32d2zgH8i=Sy1VoudRCGqZudyHkag@mail.gmail.com>
In-Reply-To: <CAMzD94QZQjpwOA8Os3khG32d2zgH8i=Sy1VoudRCGqZudyHkag@mail.gmail.com>
From: Yan Zhai <yan@cloudflare.com>
Date: Mon, 10 Feb 2025 10:21:38 -0600
X-Gm-Features: AWEUYZlnLuiCJjRJtIJZwpaZNOpATxR3bl3tZuwbBXDssS0d0dx6XXBf-mXpTzk
Message-ID: <CAO3-Pbqa_oOm-u318mTwqPfuRJ2_kdk+ou99BOu53A3O_wEyZg@mail.gmail.com>
Subject: Re: [PATCH v3 bpf 1/2] bpf: skip non exist keys in generic_map_lookup_batch
To: Brian Vazquez <brianvv@google.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Mykola Lysenko <mykolal@fb.com>, 
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kernel-team@cloudflare.com, 
	Hou Tao <houtao@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Brian, Jiri

thanks for the comments.

On Mon, Feb 10, 2025 at 8:47=E2=80=AFAM Brian Vazquez <brianvv@google.com> =
wrote:
>
> On Mon, Feb 10, 2025 at 4:19=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wr=
ote:
> >
> > On Sun, Feb 09, 2025 at 11:22:35PM -0800, Yan Zhai wrote:
> > > The generic_map_lookup_batch currently returns EINTR if it fails with
> > > ENOENT and retries several times on bpf_map_copy_value. The next batc=
h
> > > would start from the same location, presuming it's a transient issue.
> > > This is incorrect if a map can actually have "holes", i.e.
> > > "get_next_key" can return a key that does not point to a valid value.=
 At
> > > least the array of maps type may contain such holes legitly. Right no=
w
> > > these holes show up, generic batch lookup cannot proceed any more. It
> > > will always fail with EINTR errors.
> > >
> > > Rather, do not retry in generic_map_lookup_batch. If it finds a non
> > > existing element, skip to the next key. This simple solution comes wi=
th
> > > a price that transient errors may not be recovered, and the iteration
> > > might cycle back to the first key under parallel deletion. For exampl=
e,
> >
> > probably stupid question, but why not keep the retry logic and when
> > it fails then instead of returning EINTR just jump to the next key
> >
> > jirka
>
> +1, keeping the retry logic but moving to the next key on error sounds
> like a sensible approach.
>
I made the trade off since retry would consistently fail for the array
of maps, so it is merely wasting cycles to ever do so. It is already
pretty slow to read these maps today from userspace (for us we read
them for accounting/monitoring purposes), so it is nice to save a few
cycles especially for sparse maps. E.g. We use inner maps to store
protocol specific actions in an array of maps with 256 slots, but
usually only a few common protocols like TCP/UDP/ICMP are populated,
leaving most "holes". On the other hand, I personally feel it is
really "fragile" if users rely heavily on this logic to survive
concurrent lookup and deletion. Would it make more sense to provide
concurrency guarantee with map specific ops like hash map?

best
Yan

