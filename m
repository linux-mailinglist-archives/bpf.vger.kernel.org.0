Return-Path: <bpf+bounces-41693-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 167CA999A7A
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 04:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4207B23699
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 02:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A311F470C;
	Fri, 11 Oct 2024 02:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WOOyHs16"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A0C1F470D;
	Fri, 11 Oct 2024 02:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728614164; cv=none; b=sWavclZvj/zCFAwXlkX+ErrVq7Dx6rLnn242Y3gCkckW6K9ZQWvy/P1lQLfUaXs2G7g68TS6QAXn0x2mVkOWKrKL9IS0USJv5RPNpltZIalRoBOJ4aGVASfgDKgmpoQeJuX9V97hH42gQlx+Tbfbu3nXyFCjVAGJ+57jZ1jlmXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728614164; c=relaxed/simple;
	bh=+vMIA/cu/vkqBnx52a1ObvjTlLcczbHQCFo5mkm7/Uo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O1/iiC3HVSGaobhcBKow9leF1mAsRICV7WGNn+ulIdNCLqCU+VlSOjpe517Y/rre32k5R5hn++vbUekBAd0ON4MxrWhO6AkyjDf1xoogpmb3veZs83NQDVMAjCw4ULaIlo2ToJalrvoH8fFL81gmEHoI5knJDAo6o0Kpxrx+lfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WOOyHs16; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2e2eba31d3aso412614a91.2;
        Thu, 10 Oct 2024 19:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728614162; x=1729218962; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r1P7tuB4hLxbBXGAGgneey3fBMAOG19TvuBf4+nhAyo=;
        b=WOOyHs16KnKev7cF6KgPHkfTlppG169uNS5OLbT7Cd8jA/YF73syjJi/qtETk+KDt7
         7jmkUILjklna93UpLL1sZsGTU8b42b6FpZDmkdc37VW12WnRgA+vn3z1cG1G+GpWNUsC
         9tPDutDP5brDpCby6ZlxxmU4NpGxN5ig0PEFtDMorFAZDxNaexLBvSELcbebBWlCuGc6
         dSr07fkXS5VdUojZO3wW5es9X16rfJTDhrflg3H0o17h50EHReNOPePgJzsa2p4eJI2U
         gUlFMK4B3XKsJBVJNXnAl5xYe+cenR/vgHtXkSl34+SOqS6Pv3JBgHhk986iSHq3419o
         t1Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728614162; x=1729218962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r1P7tuB4hLxbBXGAGgneey3fBMAOG19TvuBf4+nhAyo=;
        b=xEE5eO3reu+vUP2GGxMuKyqwSJNumURGGysA+CZW/PWWmJiAK3p6K9IktTA7xBKDCx
         I0B1yn8M1ndA2fchBStAVgAmJasGy/FZfxz6effTinqvkBG5YG1fuTzbQPVHkGs9ZdCB
         onZapmTAssKk18s2MPSIDC688dg1GGVg4w8zWJpKfhsfl7TY+rp3c5NRhHRBavc9kSUI
         JDxo954AZAuu3QcqrMJrBRtua1E5T2dGXVsofpL7ycU4X0uRobBqhUjpCQEZlhumstIn
         eegi/6KNZFnjMH3cRifWcfsE9fiFVqLzxiP8B/CFP3DvHmOi3pJ3xUlE/yXARIPl/cJy
         LSPg==
X-Forwarded-Encrypted: i=1; AJvYcCUIlz0oKHqcoisO+IkM4myuBa+CDWFuqSSHcFU5ow5sirsqq+TQYaOh5sngwV9/8+TcqKkeu4x8vitPewZkH/GjISk6@vger.kernel.org, AJvYcCW2UNH8gVLzo5RCqO8zU50ViGdR43oK8beLyKeh0/ayabd4ox66MiEy7U72B8sc29WCATY=@vger.kernel.org, AJvYcCXuHwAX2vJbh/R/E4iG1PnHyvoMBPCoaO2/hva4IULohoNdyYIiMYCo7l25BD0Ekg7XIUGl64CIpXqNVn26@vger.kernel.org
X-Gm-Message-State: AOJu0Yx874FDQkztmccpcRyqkvFlwRxpZEftdSLgjyijwpHsfK5RRZfR
	1EaiXYLDE+0Tw1b6gWKBK6VGF16bDwDjRmrD2uZxxdGhw0Lu5NG/dP6p54SawEIZkPlmFBSfQMI
	agWlh6UiGQVCvK8k/dOYWK0TgLoE=
X-Google-Smtp-Source: AGHT+IHRvKwhvii4OLSB5Xz+gSEWFWZ4FyItMJy7oxRr642+ExeG6tjlZB9QRfciHtw4LLtVT8cZAjJNchEZFaU7eOs=
X-Received: by 2002:a17:90b:3757:b0:2c9:9658:d704 with SMTP id
 98e67ed59e1d1-2e2f0df9cb7mr1370458a91.40.1728614162471; Thu, 10 Oct 2024
 19:36:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010200957.2750179-1-jolsa@kernel.org> <20241010200957.2750179-17-jolsa@kernel.org>
In-Reply-To: <20241010200957.2750179-17-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 10 Oct 2024 19:35:50 -0700
Message-ID: <CAEf4Bza3VLNKSdRQJtODAwmb4jZ85wq46QHBnXwzu_M+um9d_g@mail.gmail.com>
Subject: Re: [PATCHv6 bpf-next 16/16] selftests/bpf: Add threads to consumer test
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 1:13=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wrote:
>
> With recent uprobe fix [1] the sync time after unregistering uprobe is
> much longer and prolongs the consumer test which creates and destroys
> hundreds of uprobes.
>
> This change adds 16 threads (which fits the test logic) and speeds up
> the test.
>
> Before the change:
>
>   # perf stat --null ./test_progs -t uprobe_multi_test/consumers
>   #421/9   uprobe_multi_test/consumers:OK
>   #421     uprobe_multi_test:OK
>   Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
>
>    Performance counter stats for './test_progs -t uprobe_multi_test/consu=
mers':
>
>         28.818778973 seconds time elapsed
>
>          0.745518000 seconds user
>          0.919186000 seconds sys
>
> After the change:
>
>   # perf stat --null ./test_progs -t uprobe_multi_test/consumers 2>&1
>   #421/9   uprobe_multi_test/consumers:OK
>   #421     uprobe_multi_test:OK
>   Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
>
>    Performance counter stats for './test_progs -t uprobe_multi_test/consu=
mers':
>
>          3.504790814 seconds time elapsed
>
>          0.012141000 seconds user
>          0.751760000 seconds sys
>
> [1] commit 87195a1ee332 ("uprobes: switch to RCU Tasks Trace flavor for b=
etter performance")
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  .../bpf/prog_tests/uprobe_multi_test.c        | 98 +++++++++++++++----
>  1 file changed, 80 insertions(+), 18 deletions(-)
>

OK, LGTM

Acked-by: Andrii Nakryiko <andrii@kernel.org>

[...]

