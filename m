Return-Path: <bpf+bounces-44812-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F159C7E07
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 23:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63F2DB2A99D
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 22:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91AEC185955;
	Wed, 13 Nov 2024 21:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JkYKBtOG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE76218BBBD
	for <bpf@vger.kernel.org>; Wed, 13 Nov 2024 21:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731535196; cv=none; b=YM9CO4GkS6dkWUX2GzFcbmZf4htoWSEQCNAqrmEH4v0OPOSkaCK4QNmg8j1Hu8z5/FpY2dc05Zo82moWKGWlhKDi75JNupb+a79wvihfM83EYG3giTKpClsTsVioyZITtFy8yzm9CjIqlqQ7BwiP82vZtLcYk/GgZAXNJJGam5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731535196; c=relaxed/simple;
	bh=3PEpmh0px3olB5uOAutudUAGV0bMGGeTpT2INdb9M9Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rwPM1kHeWbABPNlE0w4XIy2OKmNGHXUoiOYNKej5805SRMNKjlFw9JYjuC02bVAYIDJLFrx0in0ovb9janVNCcMKARn+r0W8dPiZXnZUaUwGUWA6EZPGrFItipDwlbqkDEAhUSBJjYvoafBFvamRpU7PL/LXtVhp4MZfKdvu+iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JkYKBtOG; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2e9b4a5862fso31353a91.1
        for <bpf@vger.kernel.org>; Wed, 13 Nov 2024 13:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731535194; x=1732139994; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p78+Xatx3jDWwzS0joYH5Jw8yEDoI4KUx+bnMFv6eBA=;
        b=JkYKBtOGXM3+Ff2J0f4HzXuyjpFnP+YtCBCGS75r9P8jB94BGe9xDF02umP9eagGut
         AJnvu2uxOW450Ez4xKdzUv+a/Rwlp/jaVNqA4P1ScC4+lJqbdvO11Lnyi5b7EoMaYw7Y
         W398klejsTI4/rrBFsP+YdfuWlCXStZTqDJl5CGTtGUwV70x13sCP0JsumhIK7yIcHvX
         YiFprKp9fnI0kdSi6kENoeU4dadHCbqyd0Q5ngArskMH0QyXSW88Embw20g71H7AHMXL
         hUnKTUPdamAFMoNQ6iROg4KAHep4vDJqS8nM0GcgLkRPQ6HlefX6oPMa75g3w1MA4i5W
         jqjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731535194; x=1732139994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p78+Xatx3jDWwzS0joYH5Jw8yEDoI4KUx+bnMFv6eBA=;
        b=TU0u48bx5q1gdzkj7vR7e5LELHwsk1HhVk7efcqYAevj7YjO9vcBu/K79a/2vrgZhw
         4lmGc6VZlI1IFe0BvLA0ey/ND2kdizuR46TLhG89qV156iBm0AAzgZPjHxWKAmTu/gTD
         RHxFapvdJM3wGyKNF5WQIaVuOuwa5TIy7LJR3m/HHa3/+73sYgi24P/LNAH0EVhWnppA
         iDzp6UXMeh8SW3lRfVINB/c+iC9HOES70SMcI5VafVZ1KFCeD30itO8XUG4AOTaIb7Nl
         4hOO92AEFv64tPWlFZr3rrPcfQpigkcjaFDgcgVVPpDGpXzwY8PBjyZlF9vWRLgFboZ5
         lSSg==
X-Gm-Message-State: AOJu0YzkFq7ef7mrhVCuzaOvlYlViHGmUt1AkiKTdLa2AT4Dt+Jhu7CA
	fRpgKHfOqf9eMJvGSpd/LbDbuTnFX5pCIBqvzNIPXAgBIYEqjCmD8USKhJlU9wViat4WlNvrbGj
	KEWMQeOD7W6sSeNzPMvyuMESDgp0=
X-Google-Smtp-Source: AGHT+IEfTvHDkSMmZ/AXMGBCpuQ2FikXlUzxc+4Aj/djCqyqLt3ch1eFZM0XFU7Rg03btBOgF+S6IC/BDRnJrM2ySYE=
X-Received: by 2002:a17:90b:2886:b0:2e0:80e8:a31a with SMTP id
 98e67ed59e1d1-2e9e4ca288amr9941704a91.35.1731535194051; Wed, 13 Nov 2024
 13:59:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108025616.17625-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20241108025616.17625-1-alexei.starovoitov@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 13 Nov 2024 13:59:41 -0800
Message-ID: <CAEf4BzbTmKri_qOtT7kQzdzaiT3QHMLH742Aw38CrhqqCo9f7A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/2] bpf: range_tree for bpf arena
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@kernel.org, memxor@gmail.com, eddyz87@gmail.com, djwong@kernel.org, 
	kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 6:56=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> Introduce range_tree (internval tree plus rbtree) to track
> unallocated ranges in bpf arena and replace maple_tree with it.
> This is a step towards making bpf_arena|free_alloc_pages non-sleepable.
> The previous approach to reuse drm_mm to replace maple_tree reached
> dead end, since sizeof(struct drm_mm_node) =3D 168 and
> sizeof(struct maple_node) =3D 256 while
> sizeof(struct range_node) =3D 64 introduced in this patch.
> Not only it's smaller, but the algorithm splits and merges
> adjacent ranges. Ultimate performance doesn't matter.
> The main objective of range_tree is to work in context
> where kmalloc/kfree are not safe. It achieves that via bpf_mem_alloc.
>
> Alexei Starovoitov (2):
>   bpf: Introduce range_tree data structure and use it in bpf arena
>   selftests/bpf: Add a test for arena range tree algorithm
>
>  kernel/bpf/Makefile                           |   2 +-
>  kernel/bpf/arena.c                            |  34 ++-
>  kernel/bpf/range_tree.c                       | 262 ++++++++++++++++++
>  kernel/bpf/range_tree.h                       |  21 ++
>  .../bpf/progs/verifier_arena_large.c          | 110 +++++++-
>  5 files changed, 412 insertions(+), 17 deletions(-)
>  create mode 100644 kernel/bpf/range_tree.c
>  create mode 100644 kernel/bpf/range_tree.h
>
> --
> 2.43.5
>

I skimmed through just to familiarize myself, superficially the range
addition logic seems correct.

I'll just bikeshed a bit, take it for what it's worth. I found some
naming choices a bit weird.

rn_start and rn_last, just doesn't match in my head. If it's "start",
then it's "end" (or "finish", but it's weird for this case). If it's
"last", then it should have "first". "start"/"end" sounds best in my
head, fwiw.

As for an API, is_range_tree_set() caught my eye as well. I'd expect
to see a consistent "range_tree_" prefix for the internal API for this
data structure. So "range_tree_is_set()" was what I expected.

But all minor, feel free to follow up if you agree.

