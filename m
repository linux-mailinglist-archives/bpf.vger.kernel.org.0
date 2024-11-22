Return-Path: <bpf+bounces-45476-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 567F09D6393
	for <lists+bpf@lfdr.de>; Fri, 22 Nov 2024 18:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C78DFB24E11
	for <lists+bpf@lfdr.de>; Fri, 22 Nov 2024 17:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1931DED76;
	Fri, 22 Nov 2024 17:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qlHBvNLW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366C5154BFB
	for <bpf@vger.kernel.org>; Fri, 22 Nov 2024 17:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732297705; cv=none; b=p+pUOPAyb6WlRuCEPXzYGImqOxQalFg9DpAfUyLlml0pqW3CAZyuHcMKBsdNEJHGpMxsV+DFTEy0YKbTS0WvxgxU4wsccj7UuDVivCBiqw+0P0XByf9J+4ZqgRdzBXr+dMow4LDoxsSpsZgBAnOxkRoPjCw/xDHY4GrHoq/shcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732297705; c=relaxed/simple;
	bh=ohzwp247UbmMP1I+eZkVrW621hY8ktchQarpuk3HIHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SMrR+1HwY/6HZzzP6JeBtE7Ek4TWKa6sb3y1vGHYEYyzkhRZXcX2Qa/Hg2cGnQxNWtja5E6vyUknA36MFvH22l36DfsuyNSXjiNn8U05pVNgr8zi1g9tHSU88ECXO1xLu2veM0yuywDVkAJmbCSXGJ9PAvylKZhrrZXkQ6vI818=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qlHBvNLW; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-460969c49f2so761cf.0
        for <bpf@vger.kernel.org>; Fri, 22 Nov 2024 09:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732297703; x=1732902503; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Dzn4IjnMnv34FVgwu/dFGi7pggQRg26ttbIci8IYCo=;
        b=qlHBvNLWBKpD3z6jf3YEGnrLlVNppSrOZqccnrw3ZYj5Uu2CBHjRXfmiHj0v40a/8p
         t40pcGfsG4xKT4HHsyg27g2HhrmE5xuZsKLUvk3fSQW4WoMGfuJiAkFWBlQ7NRwNyk8Y
         CDhr4a3PEooY5zHb5OWOD1eVE1Cjq+YSePr+SE+1aZv13sLKkiMgHpuKEfdR8PN32NDd
         65sKu2i2sfBLvSPjYegazSURbIWYM9+ueFLMEWi2kzOaJ8lTd4ejYNyjEGSDT9v6DnHC
         9YNh18UgR6hDhaIx2yq1VDC+lzNaWT89sqPhDugMZBEnxfH/aJq1w720ykxoFcOLGs5v
         6POQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732297703; x=1732902503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Dzn4IjnMnv34FVgwu/dFGi7pggQRg26ttbIci8IYCo=;
        b=YhNSIorXxMKVbtVntZWkoAz0svYbSY6tR2YuJCyN4klSYyGNSlo9EYXb+ox55jKixl
         gLcvlVhs2DBcV3P2YkXs0JpTzpUFKNktznghfxUea0eOtmyRxALJrILGCIgdivkdhXjO
         tvA1ytIFhA6z1oawI71xGjZP5cgJxKasB26NiBkRYFe0nunsUxfxN/P9McWHqRLJa4x/
         8DSrN20VyyQ1PisC2YewwXEHAjQBUPk06hgM5nbIMbLVqmnyLSpIgWlyLURWOZ0FWw1x
         XjQ3+L5/WCIu/k7SLvIDx3ZgA/IcHcC4QwVp7Ox1EzRATwmb/HlqnencgqrYJyYgiSVC
         6SEQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+y33ENC+Q3HPnXToaNQpi5u0haYSk4zx3XX65CZzrL4ViqEHeSc2vWjUtoBAHi7mRoDw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf21ExxV8WcXfZQxuEnIgTkfI4+BEBQb8Bh9H5kUuy8Wjz/qve
	NrrimkJus5w44gzVuOqzWkVsH3TG4psFhRhBT+9WYteNEn7/fnUomqrigHJ84qDEsXxxe+bQRo0
	SLwoyICbPqJ1GJJr7bN9pDAH3mEbwbh5k4ryH
X-Gm-Gg: ASbGncv9ceOiPbpZATgug01cR7NQ9jub4Wj55Rmq/F7db//yWM/yI1mCMVNHlPhmy9F
	amIznzJkUbh571+2jX42mMP6Z5/96oLVNZuw1qhYq192lmhct7EugxPbiSNawUg==
X-Google-Smtp-Source: AGHT+IHJYPuhBB5R2EsaOfV9PwicTxBNUev5vJnJ3t9Qj6dppnojbsdSrU/Uvzq+90nbzwcB66IiT6EpdiNZHyKRfKc=
X-Received: by 2002:a05:622a:607:b0:465:3d28:8af2 with SMTP id
 d75a77b69052e-4653d5d72b4mr4301521cf.22.1732297702894; Fri, 22 Nov 2024
 09:48:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122035922.3321100-1-andrii@kernel.org> <20241122110737.GP24774@noisy.programming.kicks-ass.net>
 <CAJuCfpFvHwjMDdFGjCfg+fta2=Ccif7XReTH6TpC+V+PZ1JmAQ@mail.gmail.com>
In-Reply-To: <CAJuCfpFvHwjMDdFGjCfg+fta2=Ccif7XReTH6TpC+V+PZ1JmAQ@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 22 Nov 2024 09:48:11 -0800
Message-ID: <CAJuCfpFy27B3B=4QvATTzaM44Ferf1scbt0JCdrCdj2gzo52+A@mail.gmail.com>
Subject: Re: [PATCH v5 tip/perf/core 0/2] uprobes: speculative lockless
 VMA-to-uprobe lookup
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	linux-mm@kvack.org, akpm@linux-foundation.org, mingo@kernel.org, 
	torvalds@linux-foundation.org, oleg@redhat.com, rostedt@goodmis.org, 
	mhiramat@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jolsa@kernel.org, paulmck@kernel.org, willy@infradead.org, mjguzik@gmail.com, 
	brauner@kernel.org, jannh@google.com, mhocko@kernel.org, vbabka@suse.cz, 
	shakeel.butt@linux.dev, hannes@cmpxchg.org, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, david@redhat.com, arnd@arndb.de, 
	viro@zeniv.linux.org.uk, hca@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 22, 2024 at 7:04=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Fri, Nov 22, 2024 at 3:07=E2=80=AFAM Peter Zijlstra <peterz@infradead.=
org> wrote:
> >
> > On Thu, Nov 21, 2024 at 07:59:20PM -0800, Andrii Nakryiko wrote:
> >
> > > Andrii Nakryiko (2):
> > >   uprobes: simplify find_active_uprobe_rcu() VMA checks
> > >   uprobes: add speculative lockless VMA-to-inode-to-uprobe resolution
> >
> > Thanks, assuming Suren is okay with me carrying his patches through tip=
,
> > I'll make this land in tip/perf/core after -rc1.
>
> No objections from me. Thanks!

I just fixed a build issue in one of my patches for an odd config, so
please use the latest version of the patchset from here:
https://lore.kernel.org/all/20241122174416.1367052-1-surenb@google.com/

