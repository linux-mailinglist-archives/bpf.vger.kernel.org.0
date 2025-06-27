Return-Path: <bpf+bounces-61772-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3170FAEC00D
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 21:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C54A57AAAEB
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 19:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E6920C001;
	Fri, 27 Jun 2025 19:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l2gygZhI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A5513C3CD;
	Fri, 27 Jun 2025 19:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751053009; cv=none; b=oWltiRjZHb6WxH30/qVOOHvfTRegPq/QvyhJxKskJan+iPPnxzQlsQCQKZhUclt8NJp71X0JhqjcDMJACDWosfNM6yaenFu9U6onzq5a6Q/TMBY4MUjvx0PYxe3zkIxUVUEdhkhwjqaTZYXyyQpbiDnRbx2IJH5hXEGLzvLpEc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751053009; c=relaxed/simple;
	bh=OBlHHv5BRcsAM2/X4ERxjnFddBc06xIgBu7EDmZ7r+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qIPkkrh3BNb6b4j7XWrA6+2ps3PccGvjYmvg23eUqg+A9s198QPkY+70orUIt5O8VIjT19hEpKJSy44q+G4vvnG2eR65lBwVREHZDiH+qLJ+O8xNOq5QpQmVayc+V2yNszCtqY+psNGb0PI9fVsBlpIi1vMlvFLwn0Ead5H+ikQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l2gygZhI; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-451dbe494d6so2238155e9.1;
        Fri, 27 Jun 2025 12:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751053006; x=1751657806; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sge9kv+qWhs416U9rXTCWTTRXiONTUBYiDk8dbiU+UA=;
        b=l2gygZhIfnwDPqwy9UFdxk4wNqdnNagDl8jWmog0KugaXJ1Du9exAwhTj3wv2RMZHK
         eoKpTDUHZYvTu6bhZLVZMI5NZExEmqXVKVaIH74aaf/xKK/AQ696mAM5HBY50jg+Kr3d
         GoNZrhvlU5zoYwI2Z8mhEeuRozNkj96bRpTgRguJNhRQEN2jgM/xBgwOxTc+h3eU8aB1
         EX0uxzB0ry7exq9e/GSWHBLKHnwUnqmytxOp80GdwoOZ9hX+1YhHB1KEcoqU/1IN990Y
         lWaOTJaKlSd86vRrlhLs/2y4IrDjWkyDQOjOS6E6vdVdP43aua2Qrw7gkhjFWQE26AVU
         iqNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751053006; x=1751657806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sge9kv+qWhs416U9rXTCWTTRXiONTUBYiDk8dbiU+UA=;
        b=KLUKOyztMwfOBpbrthpXUKJkEDXeo2lzeq9xu8qjjvi3h/LgkP8JrmKoSSDo55T+Dq
         qcuA8kPe+qjEbvl+qs9hj0yIe1nwdOZHoC2vJabdW1/V9MEKCP/qknOOvFlBQUcqyMi4
         4Qbri8UpDkU6n0AVaunKufJ8CkytVo263gdtAHMF97kHfsQhxFouc8XQhkYp09LGZsna
         KaPOTTNT7kTyemd5oVQlnF+Ax/0Td6PbvrdI2mmMXmRtVyCT9HBLZ6jJLsibSHODiXo4
         BuTW3SdBfo/IZQAV+8OgjBoB92FMz4O8XwaQr+G85RlMhLGUlB3Fzc6M62apPeREz72z
         qTSg==
X-Forwarded-Encrypted: i=1; AJvYcCVU0rDvZM7uRSy+Jgh26dr8a8soy7/3Gy/yIIbdn7Mr8ELYek0aAgN1pujb/tmkb7ASihc=@vger.kernel.org, AJvYcCWYwdrhASKo+o8gIn9JHBsm4Pfi70kLQycmt7UUv4zuPQT9MjINrMOopRPl0HQ9BhjZmPuqXv8dEHewhxrx@vger.kernel.org
X-Gm-Message-State: AOJu0YxZtbcWUGOhG1iqwEuaGVDLleT1u0IoY6koeXLfZSonhvV2eBI1
	1T4iVT2KEhzl07NfGsJk/gcVsRL2evisvKoiE1px5ypF961xvWo675J8MQJOZVrtRk7XJcdYG/N
	S6GIozNV6Jy+OdDE+lleW8JBdcIiVXtM=
X-Gm-Gg: ASbGncu6x3iYt+r4VxJ5KONLaVv8YHHKM4De+g622LQAWT1A0PJ94PX1ESVpAVA6o7e
	MojAEgPy8v/kk1/v+vxEe9Fx+R84ugdoT/4wHuikcgKY4GEV28Q3IHaW163P1D3hPD/ZHxoa7XM
	/bNDu0g5vYL2mLtrZA2fworDfMJNBteDSxth1jnHB6Kg5/6pqduCgsEsFC6Cs2RCCyzot57VZb
X-Google-Smtp-Source: AGHT+IFJ6sW9aZlzHYqG6nZQUslfkO9AEHSytfv659QepQEpvvFk963bE9My7AemXeg9KlUdJGrL5HrZ59n6bl/5xEY=
X-Received: by 2002:a05:600c:4fd6:b0:43c:f63c:babb with SMTP id
 5b1f17b1804b1-4538ee4f9c5mr44636075e9.1.1751053006033; Fri, 27 Jun 2025
 12:36:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250616095532.47020-1-matt@readmodwrite.com> <CAPhsuW4ie=vvDSc97pk5qH+faoKjz+b51MDYGA3shaJwNd677Q@mail.gmail.com>
 <CAENh_SQPLHC8pswTRoqh0bQR84HHQmnO3bM07UQa1Xu9uY_3WA@mail.gmail.com>
 <CAADnVQ+QyPqi7XJ2p=S9FVDbOxMXvVPU859n+2ApuRQv5T2S5w@mail.gmail.com>
 <CAENh_SQgZ5yVpshKRhiezhGMDAMvgV7SmwD_8u++mACE33oNrg@mail.gmail.com>
 <CAADnVQJgOyBCCySnBkTk-VCsz0dy+ppdGHpggxbtDpBBGhaXVg@mail.gmail.com>
 <CALrw=nFvUwmpjUMYh5iJqjo6SbAO8fZt8pkys7iDjZHfpF2DxQ@mail.gmail.com>
 <CAADnVQLC44+D-FAW=k=iw+RQA057_ohTdwTYePm5PVMY-BEyqw@mail.gmail.com> <CAENh_SSduKpUtkW_=L5Gg0PYcgDCpkgX4g+7grm4kxucWmq0Ag@mail.gmail.com>
In-Reply-To: <CAENh_SSduKpUtkW_=L5Gg0PYcgDCpkgX4g+7grm4kxucWmq0Ag@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 27 Jun 2025 12:36:34 -0700
X-Gm-Features: Ac12FXyQ4sgWqPMwQr7JA7YNzD6LlQrc0xOw38ZKRBCSk16gbbU4DbSm-TLpMD4
Message-ID: <CAADnVQ+_UZ2xUaV-=mb63f+Hy2aVcfC+y9ds1X70tbZhV8W9gw@mail.gmail.com>
Subject: Re: [PATCH] bpf: Call cond_resched() to avoid soft lockup in trie_free()
To: Matt Fleming <matt@readmodwrite.com>
Cc: Ignat Korchagin <ignat@cloudflare.com>, Song Liu <song@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	kernel-team <kernel-team@cloudflare.com>, Matt Fleming <mfleming@cloudflare.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 27, 2025 at 6:20=E2=80=AFAM Matt Fleming <matt@readmodwrite.com=
> wrote:
>
> On Wed, Jun 18, 2025 at 3:50=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > Do your homework pls.
> > Set max_entries to 100G and report back.
> > Then set max_entries to 1G _with_ cond_rescehd() hack and report back.
>
> Hi,
>
> I put together a small reproducer
> https://github.com/xdp-project/bpf-examples/pull/130 which gives the
> following results on an AMD EPYC 9684X 96-Core machine:
>
> | Num of map entries | Linux 6.12.32 |  KASAN  | cond_resched |
> |--------------------|---------------|---------|--------------|
> | 1K                 | 0ms           | 4ms     | 0ms          |
> | 10K                | 2ms           | 50ms    | 2ms          |
> | 100K               | 32ms          | 511ms   | 32ms         |
> | 1M                 | 427ms         | 5478ms  | 420ms        |
> | 10M                | 5056ms        | 55714ms | 5040ms       |
> | 100M               | 67253ms       | *       | 62630ms      |
>
> * - I gave up waiting after 11.5 hours
>
> Enabling KASAN makes the durations an order of magnitude bigger. The
> cond_resched() patch eliminates the soft lockups with no effect on the
> times.

Good. Now you see my point, right?
The cond_resched() doesn't fix the issue.
1hr to free a trie of 100M elements is horrible.
Try 100M kmalloc/kfree to see that slab is not the issue.
trie_free() algorithm is to blame. It doesn't need to start
from the root for every element. Fix the root cause.

