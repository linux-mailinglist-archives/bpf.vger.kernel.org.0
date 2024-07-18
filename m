Return-Path: <bpf+bounces-35013-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC29893514A
	for <lists+bpf@lfdr.de>; Thu, 18 Jul 2024 19:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 905A61F22186
	for <lists+bpf@lfdr.de>; Thu, 18 Jul 2024 17:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E53144D29;
	Thu, 18 Jul 2024 17:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GcHisq0Q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10AC63A;
	Thu, 18 Jul 2024 17:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721324495; cv=none; b=ifvUlDbwQGMw902nOSGD6U427kNEzzIxqN91it2K9BkOEWSzBJ9kdyADENIH4/NJyFy6KfrXhRDXehKu1YvEk4TlEmbhxepNyTrn7QUORrXiTp2WpIt8l1pKBnqWsmP5RvbWgT59sHs3NjpHuu9ej5zBz2pIop6NVfM25KWPFxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721324495; c=relaxed/simple;
	bh=b9UYGyJ3/vQpMXCA/Sfwxz6MCAKrrxB8FyY3lMOhKCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VA0nfFT3ifdW/7cfDywJVVj3u8iJ5LKASAW0mFgWjDYoi9EehcEI9ev0bbW4hD6hJswV0pVx9k4T4akI6Df2a5WuZuRzC936nPXREfTLkko5kvOpGoJEkMbw2CysbHC5zHKOwP5Zn+ppmTTpPCmIMxXZQbZIQ5dKfgrBlmC3PDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GcHisq0Q; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-78512d44a17so727011a12.3;
        Thu, 18 Jul 2024 10:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721324493; x=1721929293; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jXGWWfWKwu4C0Pwh4ekXo4Fyxb931LLzXNEPPDV5NVo=;
        b=GcHisq0QRkj/bwwgxldvsQ+zttw7dEh/Vs+bm8+QuBv8QSkk1duJlW2R0DiZkUKzLp
         X4tu7gG8BBebmmx4im+ISjfx6rXuyMspXB1x6NucvBGQaFxBbmyrcEHmMHK0nvN5EliA
         0w6x50GTbceG8s9n4Ye5gioEfJbo4eioD9gJG0IwJ4xoTrgLUXCJsPhqChPSKUKNAt1p
         RPmibI0D1duK62fG0ZRsxP9naHnXqS77baS55pTvIBL5gpFeENzGHa7X3TtPhNbtEHj/
         NUX8Mwr6ofmPX4pvw8uVNl79qIxJB/QgH8d7vtvGdUJ09xZk85Ju49FowUeH2DIbDsC4
         cgSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721324493; x=1721929293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jXGWWfWKwu4C0Pwh4ekXo4Fyxb931LLzXNEPPDV5NVo=;
        b=SumtV9DQNCHZsf6Jua7vhLUI5eUdX5nK7IVbHCTM/PBWCFN1sj6qidkfv0/zM6iFtP
         P+ljrnTQaA+C4VXyQaabuL8qVeLFS6DN8olyJvnRka/mYP18pFXjd3F8MV4TS9IRm+Ak
         wgg1sDbozO5PkUOGEq/eiZ4EzZ16CcrFM4CAQRhWlL+5uED2VPOZfx7NY5KpU40SLQcX
         DVZjdOtXxbP0m5OdZRh/Yb4Q6D+QRwZwkFNAtHt26/qgw/AHy0SsiuogHcSOyX3W4zH6
         0uYvVQiCBoZ+SsjK8ZUxyHvl4A4dzVUNU4Qm1lqtUxKuaBSYkMisBAQuN2Ob7jYw/Phr
         1Ktg==
X-Forwarded-Encrypted: i=1; AJvYcCUUsV+Wx6v7RDea4HjSFDJbkybNidnovnb24/SpW+EacLFiG090uer83thSsZwxYunvEXYXVHPsJ0uVXm95/1EAoVs0dr8zIVWuL3PObMPXyLcybo1ZYWg/W6wOvDsPTf8GIvJNpSF9I3rUHnd8tAGpnscjOG31Ya3H/w5Mq9ppjvpKRQ==
X-Gm-Message-State: AOJu0Ywkp+ld5Az2FVez5aP+Y2h6Dl84iITJJENqQ15N/0RrBQxRz1WT
	V15z02G6WlZ/V5kTRUvubR5qFAhgDmzSflxOe5bfysybLRHF4qWBIy9lCup8+woPan7b8TJuTrm
	o7H50yACy5kIFuOKW2oyTUv29NO0=
X-Google-Smtp-Source: AGHT+IFlqXix0J0Vl60VZOa8dpQ6b1kD0/PDt7P1pKnLxKndutbwr7jYSWW2mE3X9PpeGlT0/ouME0Zq10kwP4RWq6M=
X-Received: by 2002:a17:90a:df11:b0:2c5:32c3:a777 with SMTP id
 98e67ed59e1d1-2cb5293597dmr4256261a91.28.1721324492939; Thu, 18 Jul 2024
 10:41:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240715102326.1910790-2-radoslaw.zielonek@gmail.com> <20240715104719.GA14400@noisy.programming.kicks-ass.net>
In-Reply-To: <20240715104719.GA14400@noisy.programming.kicks-ass.net>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 18 Jul 2024 10:41:20 -0700
Message-ID: <CAEf4BzaYL9zZN8TZyRHW3_O3vbHc7On+NSunrkDvDQx2=wwyRw@mail.gmail.com>
Subject: Re: [PATCH] perf callchain: Fix suspicious RCU usage in get_callchain_entry()
To: Peter Zijlstra <peterz@infradead.org>
Cc: Radoslaw Zielonek <radoslaw.zielonek@gmail.com>, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, syzbot+72a43cdb78469f7fbad1@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2024 at 3:47=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Mon, Jul 15, 2024 at 12:23:27PM +0200, Radoslaw Zielonek wrote:
> > The rcu_dereference() is using rcu_read_lock_held() as a checker, but
> > BPF in bpf_prog_test_run_syscall() is using rcu_read_lock_trace() locke=
r.
> > To fix this issue the proper checker has been used
> > (rcu_read_lock_trace_held() || rcu_read_lock_held())
>
> How does that fix it? release_callchain_buffers() does call_rcu(), not
> call_rcu_tracing().
>
> Does a normal RCU grace period fully imply an RCU-tracing grace period?

I don't think so, they are completely independent. So this change
doesn't seem correct. I think we should just ensure
rcu_read_lock()/rcu_read_unlock() before calling into perf_callchain
functionality.

Which is what I'm doing in [0]. Radoslaw, can you please help
validating if those changes are enough to fix this issue or we need to
do some more?

  [0] https://patchwork.kernel.org/project/netdevbpf/patch/20240709204245.3=
847811-10-andrii@kernel.org/

>
> > ---
> >  kernel/events/callchain.c | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> >

[...]

