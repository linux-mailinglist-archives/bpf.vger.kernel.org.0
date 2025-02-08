Return-Path: <bpf+bounces-50867-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB087A2D5A7
	for <lists+bpf@lfdr.de>; Sat,  8 Feb 2025 11:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1D4C188B1B3
	for <lists+bpf@lfdr.de>; Sat,  8 Feb 2025 10:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6D01AAE0B;
	Sat,  8 Feb 2025 10:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=superluminal.eu header.i=@superluminal.eu header.b="KfcODDyJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C3A23C8D0
	for <bpf@vger.kernel.org>; Sat,  8 Feb 2025 10:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739011776; cv=none; b=WiFg0Piw5anX/sDsOgR66MYSNJ1QfQku1kCsJ1Z7QoL9hS+FlRxxKjjFyPc5OxLu6m+bK/HtvQz2Q7VdPbeXzAArI63Z7lIkc47IQpoeHFqAzlDpJefGif2cSlYReUwh/Cu5zLNjOTAkLHUZZMllZ5RBrM6t0MGmDs6N8mJO3K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739011776; c=relaxed/simple;
	bh=1VEKiB8On80JRb2DLFLbRlVcjuDPaq78iqYPh6B5XBc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aKiCYR0pT8+RqHIld8xTJPLfwmkhUAHPC4LTGPa5rlRVFmcOrxsn69PvQgypNPtk54wBjMEn2R4jg7hNml9Gzjp/AB6Wl4ObAAXaSrMCaf9mMp4pu3ol/B0yaFK1sALB6gFqDMvxxDEzVeNC5UHJVO7tO9BQyHJMfi8747X2Hvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=superluminal.eu; spf=pass smtp.mailfrom=superluminal.eu; dkim=pass (2048-bit key) header.d=superluminal.eu header.i=@superluminal.eu header.b=KfcODDyJ; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=superluminal.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=superluminal.eu
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2fa1a3c88c5so3297488a91.3
        for <bpf@vger.kernel.org>; Sat, 08 Feb 2025 02:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=superluminal.eu; s=google; t=1739011772; x=1739616572; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B55h9ee7AnjhNLjdYhLNggeuWJSGljlMlfkcZt6sxOo=;
        b=KfcODDyJSxHq20hM/Xl7ZqdU6b7VhYJ5riIgs/g9NYiNN9qxUZqQKXsvYRB5pqYMpu
         +LfmbbHJwRODUs1+KCk6szyfc1gon8/PY8MAC8RbG8YwiTqykHiknnoEolQcAB7o0bv/
         YkPsIqVrtjkLKsDLzZIOe198HRT1iIhXN/eukp9gULCK3dnVSu+RUt7KhAvvEXBkU3HV
         Aryty0jB/SgkDNDwM+6NKBaV4SaPpMT7nI0ikH7piluNCcPIPNBoCiSMTsArrJq1QXkr
         UQOAa5HUzRZ/Bv5BOvZexk/WmTKD6OIhaEfG3oiwwQRIf8XoYFIfLHx/IembY61MEJOf
         19Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739011772; x=1739616572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B55h9ee7AnjhNLjdYhLNggeuWJSGljlMlfkcZt6sxOo=;
        b=Vunjm0B1ytJPfSXNzxqwdJhTGpd7FxRmD33I3Mpcs9oEDLcvBvjqSW997UBjHzyQCC
         iPzl3+yNC4YNQ/oivk3TAxev6ymr2eyLrqB+ZGlSxOOSqjOCoaFbfCOSExppuGtE7UO9
         ovK/n9r8ZW0HbNWGcHs7jQKAmP6bKPMZB7pFyC2fpg6XR1lJWRZf+Z211KmgMQVnHWsA
         52L4GdPDunvxJH+w3dgbPS+DOdy7mKZ8pZGxT66KfaIu8ibSXnesgfPHTSNb35iD44vM
         DJUWWCQwY1TU+dfbFRyESK6G8nDdHETJtCRKrvzUHVFmNIb4otJCrinT1Wp4MRcd2Aws
         I6EA==
X-Gm-Message-State: AOJu0Yztnjlp35ApRGvRsLzzXwEd+IWI0p4jYnjwB0CP72MWOTkMjNSI
	kq2+HAvq33UhWwPGU8ErqOYkNsIrG9Et9EnxxnPNtEHnhi3DxX8BNQvhQ3wZj2dNgYEK15jtrHJ
	f8z7DMVUbN62PBsKNkT52zM4DKAFa1T/ietQEwg==
X-Gm-Gg: ASbGncuev90kMwGnRK08T+ZHX2Z04rNODRO4HdxWbMl8XS5M13iOEf7RYxWD8kW3NZB
	GUAf0kzvEaCbQjboxXoEamovDildv7Id58JqRlZNsb6LdXkyFliEgwGiWmqTff9kRgMjf70zu77
	BK21P5whH500TOs0UNZcM3q7Kpr4y3v88=
X-Google-Smtp-Source: AGHT+IHZk8E7W4Vebi3hrCTslEqXXGgiAkux4BTvUMnxpgR6BqkNWlPLhvxpIE8NdwUxjv3TtCr7D6F5CaeQiTyvWkQ=
X-Received: by 2002:a17:90b:4a86:b0:2fa:226e:8491 with SMTP id
 98e67ed59e1d1-2fa2406baa8mr10395006a91.9.1739011771986; Sat, 08 Feb 2025
 02:49:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH6OuBR=w2kybK6u7aH_35B=Bo1PCukeMZefR=7V4Z2tJNK--Q@mail.gmail.com>
 <db6b3fb9-bcb7-7670-6cb2-1ef5406e81c4@huaweicloud.com>
In-Reply-To: <db6b3fb9-bcb7-7670-6cb2-1ef5406e81c4@huaweicloud.com>
From: Ritesh Oedayrajsingh Varma <ritesh@superluminal.eu>
Date: Sat, 8 Feb 2025 11:49:21 +0100
X-Gm-Features: AWEUYZmez93xhEEHiGPAyWk0SATg_PS_YGMlxuprgK8kgxy4wm5Y6hiVUha66Y4
Message-ID: <CAH6OuBSfRve-uTW4AJd+7xKmwseauwfZLsq1jBbeye4z+61PBg@mail.gmail.com>
Subject: Re: Poor performance of bpf_map_update_elem() for BPF_MAP_TYPE_HASH_OF_MAPS
 / BPF_MAP_TYPE_ARRAY_OF_MAPS
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, Jelle van der Beek <jelle@superluminal.eu>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 8, 2025 at 7:22=E2=80=AFAM Hou Tao <houtao@huaweicloud.com> wro=
te:
>
> Hi,
>
> On 2/5/2025 8:58 PM, Ritesh Oedayrajsingh Varma wrote:
> > Hi,
> >
> > We are in a situation where we're frequently updating a
> > BPF_MAP_TYPE_HASH_OF_MAPS with new data for a given key via
> > bpf_map_update_elem(). During profiling, we've noticed that
> > bpf_map_update_elem() on such maps is _very_ expensive. In our tests,
> > the average time is ~9ms per call, with spikes to ~45ms per call:
> >
> > Function Name:   bpf_map_update_elem
> > Number of calls:  1213
> > Total time:            11s 880ms 994=C2=B5s
> > Maximum:            45ms 431=C2=B5s
> > Top Quartile:        11ms 660=C2=B5s
> > Average:              9ms 794=C2=B5s
> > Median:                9ms 218=C2=B5s
> > Bottom Quartile:   7ms 363=C2=B5s
> > Minimum:             23=C2=B5s
> >
> > The cause of this poor performance is the wait for the RCU grace
> > period when map_update_elem() is called: after the update has
> > completed without errors, it calls maybe_wait_bpf_programs() which in
> > turn calls synchronize_rcu() for BPF_MAP_TYPE_HASH_OF_MAPS (and
> > BPF_MAP_TYPE_ARRAY_OF_MAPS).
> >
> > As I understand from the commit that introduced this [1], the RCU GP
> > wait was added to ensure that user space could be guaranteed that
> > after the update, no BPF programs are still looking at the old value
> > of the map [2]. When this commit was introduced, the RCU GP wait also
> > covered a potential UAF when updating the outer map while a BPF
> > program was still looking at the old inner map. That UAF was (much)
> > later addressed by a different patchset [3] and the discussion in that
> > patchset [4] mentions that maybe_wait_bpf_programs() is not needed
> > anymore with the UAF fixes:
> >
> >> So, you're correct, maybe_wait_bpf_programs() is not sufficient any mo=
re,
> >> but we cannot delete it, since it addresses user space assumptions
> >> on what bpf progs see when the inner map is replaced.
> > Given this, while it's not possible to remove the wait entirely
> > without breaking user space, I was wondering if it would be
> > possible/acceptable to add a way to opt-out of this behavior for
> > programs like ours that don't care about this. One way to do so could
> > be to add an additional flag to the BPF_MAP_CREATE flags, perhaps
> > something like BPF_F_INNER_MAP_NO_SYNC. There are already map-specific
> > flags in there (for example, BPF_F_NO_COMMON_LRU or
> > BPF_F_STACK_BUILD_ID), so it would fit with that pattern;
> > maybe_wait_bpf_programs() could then check the map flags and only
> > perform the wait if the flag is not set (which is the default).
> >
> > In our case, we don't care if running BPF programs are still working
> > with the old map, but for the thousands of bpf_map_update_elem() calls
> > we're doing in certain situations, we're spending _seconds_ waiting on
> > the RCU GP, so adding something like this would greatly improve the
> > latency in our scenarios.
> >
> > If this sounds like something that would be acceptable, I'd be happy
> > to make the change and send a patch, of course. Any thoughts on this
> > are appreciated!
>
> If the time used for synchronize_rcu() is too long, maybe we could
> switch to synchronize_rcu_expedited() instead. Could you please check
> the average map update time for synchronize_rcu_expedited() ?

I'm not very familiar with synchronize_rcu_expedited(), but does it
provide similar guarantees as synchronize_rcu()? If not, it would be a
breaking change.  Reading up on it, it also seems to have a different
effect on the system regarding efficiency/disturbance from
synchronize_rcu().
Either way, I can attempt to test it, but I'll need to see when I can
schedule in some time for it.

That all being said, even if synchronize_rcu_expedited() is faster
than synchronize_rcu(), a flag to skip it entirely would still be
faster, so I think it'd make sense to make both changes.

> >
> > [1] commit 1ae80cf31938 ("bpf: wait for running BPF programs when
> > updating map-in-map")
> > [2] https://lore.kernel.org/lkml/20181111221706.032923266@linuxfoundati=
on.org/
> > [3] https://lore.kernel.org/bpf/20231113123324.3914612-1-houtao@huaweic=
loud.com/
> > [4] https://lore.kernel.org/bpf/CAADnVQK=3DtJRhQY1zfLK2n7_tPA5+vN8+KqWm=
SLqjubUuh6UFAw@mail.gmail.com/
> >
> > Cheers,
> > Ritesh
> >
> >
> > .
>

