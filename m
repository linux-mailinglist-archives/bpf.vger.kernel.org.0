Return-Path: <bpf+bounces-21526-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB49A84E89E
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 20:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67A82295546
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 19:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598A4288B6;
	Thu,  8 Feb 2024 18:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GAnJs4jU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE84208C6
	for <bpf@vger.kernel.org>; Thu,  8 Feb 2024 18:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707418789; cv=none; b=Xgvwk1kpV8ImuSqqLavcXT1SkQswujFJNFubLw2d9LY0nos3N1wp4+PkrQk/y8CVemRDbqicwmh6zGW38drSER+0mRUV4jJ2viZXGe1SmYkEAnWxnD/nfrXN4arLVg+A5AyWvtZlA6gYIKgY+rh0HiLst8QMWAWxScQ5JTIb1xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707418789; c=relaxed/simple;
	bh=vxENL0d9cN+r2jFXWcDqh1BfTN+NV64aEboOi7cVLpo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GCd8DQ16txXg+QwdTKWfs2FToCQzXB0gBYS+e7sKNgf4hR198FTJh2hCZLfdMKnTQ+d9WLk8T/HeC2AvJA0+18QNVyo7lCvnBTMbzPaZRL0tdLn97STySXqdopcx1311mZClnJ0ZNtUjgYpD04YJ544+7eqOYjFh1j52Cpb9pHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GAnJs4jU; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3392b12dd21so30670f8f.0
        for <bpf@vger.kernel.org>; Thu, 08 Feb 2024 10:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707418786; x=1708023586; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vxENL0d9cN+r2jFXWcDqh1BfTN+NV64aEboOi7cVLpo=;
        b=GAnJs4jUB7NmqjPcUKuPMwInkkOb0dEMlN7m2WbrOz4048JjjORZdSQumZ9Cr9nDr8
         RGPVG6lFfFoqjl56K+pBYc55kfON9LOJz0XNK3/+97nV+QVLasxZ6HXdAMPQhg08WhqZ
         2DS+bkvKvf+kSO7/LSKfpOzenipi2PM9rz7NOefbi6LuqU8iV3x6PRdfqeSJH24Dtnrk
         d6ZFRsQ/TV4AI3o7/07QwNHjYNTXO6SuYmHms7BLYyomOxwXVsz+4GWgHxwr84+tqUpY
         DK+AMWFgPESqnTYYeMpPlm92LurACo1SdT+kNTLp8vBEc35heuovglMq0C162mkX/aAy
         A7Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707418786; x=1708023586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vxENL0d9cN+r2jFXWcDqh1BfTN+NV64aEboOi7cVLpo=;
        b=aPjPmX24YR7j1zk3fLJqeFBrSz1BiJU70ihxFEGddc5mnVjh2T8p/lZCRJC5bHjZgI
         e2P1JM//R9fZazpRYBJPv3JuM5zhRNdBaEE5IiWyYzd/4kXQ22msucXQHqJFlgyoGR3M
         ut/fsjeYSWj4GUKDtDKPvFXketaClObGnVn0TYGE7cdd7CNqTc4bQDDKwz4O153E3l40
         TbKR2260ItLhCuioTDO74kuwfNzWNrGtISmWufO/Aj8oI6IF22uYXkJ/ijBWGpytPlxu
         oCes8kWjnWuLR6C1u0OP23yGYRcL6qsxw6SNBcTorYufBYLiKrDVmYGoOgqoZofakQRA
         NuaA==
X-Gm-Message-State: AOJu0YwOgmvbBOFX/hX6hC5LAtGdOKBLfviVinzWeWWDFzEoPmgKsH5m
	il7/MZbhNneGaNO18WmreO6Y46bgdjs5xAcTF9wHWpYAEpEtTIEXKItymLx8ICzkjYpTteBDFqq
	ryzXVw92MgowlI44ClfpTVDM9ZWdFu6a3o9U=
X-Google-Smtp-Source: AGHT+IHOKM+3T7heH6HaJcCg5VQj0kMASUUJP0X3sSgUsT8CpOvInoW0RNEAba23NWfO/xn+waAhMbiODjnr0WIkkBQ=
X-Received: by 2002:a5d:4561:0:b0:33a:ed85:f232 with SMTP id
 a1-20020a5d4561000000b0033aed85f232mr256566wrc.56.1707418786405; Thu, 08 Feb
 2024 10:59:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206220441.38311-1-alexei.starovoitov@gmail.com>
 <20240206220441.38311-12-alexei.starovoitov@gmail.com> <CAEf4Bza9gNXfGXuQnvWnoYNA08enBCkqn9uyHtBNdTpZRvn7og@mail.gmail.com>
 <CAADnVQKjkba_wiUJ9wps_k8+TYu_q3Ai5oQ1mnZQmpv+pnPfFw@mail.gmail.com>
 <CAEf4BzYvgHoBQ0KNFOWoK8XOvRTzGNBM1QsS=zR5iPTq-Z+=4g@mail.gmail.com>
 <CAADnVQJ-rrx-_tC5ek_wyhNdFw2Ya6o3eN_hpdgFswT=CfuXnA@mail.gmail.com> <CAEf4BzZqsX6W33ZXm8Wt+RsBXyYx3em5gQpB_0U8CNaeNL5KFQ@mail.gmail.com>
In-Reply-To: <CAEf4BzZqsX6W33ZXm8Wt+RsBXyYx3em5gQpB_0U8CNaeNL5KFQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 8 Feb 2024 10:59:35 -0800
Message-ID: <CAADnVQ+g18Qf_8B+FRuMkFAN6S_JKUwrpNhnebzh74cuZ-+iWQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 11/16] libbpf: Add support for bpf_arena.
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eddy Z <eddyz87@gmail.com>, Tejun Heo <tj@kernel.org>, 
	Barret Rhoden <brho@google.com>, Johannes Weiner <hannes@cmpxchg.org>, linux-mm <linux-mm@kvack.org>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 10:55=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> You mean when doing this from SYSCALL program?

both. regular syscall too.


> >
> > Looks like we have fixes to do anyway :(
>
> Yeah, it's kind of weird to first read key/value "memory", and then
> getting -ENOTSUP for maps that don't support lookup/update. We should
> error out sooner.

it's all over the place.
Probably better to hack bpf_map_value_size() to never return 0.

