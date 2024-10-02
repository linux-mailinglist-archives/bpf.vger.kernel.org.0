Return-Path: <bpf+bounces-40787-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C60A898E3C6
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 22:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35A591F24A1D
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 20:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710C2216A0E;
	Wed,  2 Oct 2024 20:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MDcHlhk8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E585194A60;
	Wed,  2 Oct 2024 20:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727899210; cv=none; b=KJW4YoXcACqICOUHeOaF7zul1Iz7BabRENGEQelNU38vjdlmFY5fa7vOKjuQ22uQd/4Czi47+Sl/gbFac7enKKh8Evwwt9+S2h4bCDU2Ed5yTf3rM9hTboStvS0mhVL0jfDn2peyuFlp1x/XMzsnyQIWT7H766Du9atMSMeXxM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727899210; c=relaxed/simple;
	bh=dY1DO/Bdab12HCYSilo87hpOyDgDFJ1xvSdIUFYyzlc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SHB5jEiToV3ltn3TfeKRivNx4jcQCKZ1rnXZA604A4sbFPMBZA5u2cqPBAe6ORTrIAySq/S8T4oqKm/Fov34XIBejE/gu0MuorQstB6YjXOVuWKj0wSyCVogaRjnSp8jagw5DlZPtTrrb3zmPxYaaO8C85dtO64mRGLo0qU884A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MDcHlhk8; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2e0afd945d4so198289a91.0;
        Wed, 02 Oct 2024 13:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727899207; x=1728504007; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PFi0aU0ZyaE28UiAq/QreSkITMXMfz2v8GTogy5BTSs=;
        b=MDcHlhk8MFTfpJ/fmM8965CVMCkTanbWlskBicbrHytaf3rDYU77MRtGCh0hDgyumI
         z3mJo+blNjhZfFkFobruNWDKyGjRj/uS0ibGjve17i03yqXiq2j2DtdUdINkYMrKBtkS
         rZeAPOT74VsKT/Urr0nFE27ouDQlnYWc8yyiR19cmC63Jvw/4WAeUnrptW/CO5dnMXi3
         cEPB4KCSxcgMOpdrWjfbt3ZiNS6y/Y6bTgoQGGB5E5OC13JX2M4eh23YsLedMfMX4C+p
         WVlAeaO/YTCsAqOMwqSD1J1qkdSfwc3cuIF2kzIUuNMPfwb5R3W7cXYHtaPSGCNUoBYS
         EWKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727899207; x=1728504007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PFi0aU0ZyaE28UiAq/QreSkITMXMfz2v8GTogy5BTSs=;
        b=lT0acQhDlLNFMshIWdFCB2/x3ugvj3m5HhR+XDzhE8SU9QrDO88D6ZcGFsVKSDvuOJ
         ONna78cQpUYXMxifCfVsJeDMqzuZUhw2RU3DpCpz94+Ecfxe/Y3/yp1Bd9XaQtQzSNab
         GoHWO/eaQvKhi/7me4HX+5KQw4i8P4BhQEP4bu92r0xwuygwJV6iWSKe3NirSMylWvrL
         VtyxvZjZpsjT7pnO0PMmZGuIvrArEwO8fvx4WrWvl4DtGqX391lDwzT9ELI+dvhNw4f4
         A/GwfoDJZQD7RPtQYftW6HVd62Uuu+N/a4AKguoAsiK3fx0ZmMGOpL2G9LoIo5kux0Ij
         RkRA==
X-Forwarded-Encrypted: i=1; AJvYcCU0PJnk5sDE8aeGTkFe+sx93Yuv42bztlET1bknHbvpUA7226U+fhql1kvQirL+Xbf/P5OBJtAeoDSpxe7V@vger.kernel.org, AJvYcCW7YZ1Tz2VX4qRhBRHU1G4a58gZFCsDr5hu7o6QS7jVwWfA3eaMugk9xSZYjtdylSYkxSI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzItfCVo6OaQKAzKsMF57P045DcQzONAy7ebSuEPEkqzCiqY9dN
	ZXvfiQpjWlNfrWWdJZoygd/fS9nUneairYjje9FWneo/6G8ModN6/i52I1a9t19unyG12nWu/wd
	QZRJT/QQRMDRnfMmnRG9z2L9YASo=
X-Google-Smtp-Source: AGHT+IFtOHn4B6xqEK7p87LRyPu/TIpzbOiCD39GLpoqpdbGJsSLH59r9J8RjEFR9dm5rgt3F6zducB79Te/2AgkqhQ=
X-Received: by 2002:a17:90a:f494:b0:2d8:8ead:f013 with SMTP id
 98e67ed59e1d1-2e18452dd9emr5091984a91.7.1727899207421; Wed, 02 Oct 2024
 13:00:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <26cddadd-a79b-47b1-923e-9684cd8a7ef4@paulmck-laptop> <CAEf4BzZ5mJH5+4j56zSKkvuRLLfcQMEbkjM-T86onZdAWtsN+g@mail.gmail.com>
In-Reply-To: <CAEf4BzZ5mJH5+4j56zSKkvuRLLfcQMEbkjM-T86onZdAWtsN+g@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 2 Oct 2024 12:59:55 -0700
Message-ID: <CAEf4BzYgiNmSb=ZKQ65tm6nJDi1UX2Gq26cdHSH1mPwXJYZj5g@mail.gmail.com>
Subject: Re: [PATCH rcu 0/11] Add light-weight readers for SRCU
To: paulmck@kernel.org
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	rostedt@goodmis.org, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Kent Overstreet <kent.overstreet@linux.dev>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 3:08=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Sep 3, 2024 at 9:32=E2=80=AFAM Paul E. McKenney <paulmck@kernel.o=
rg> wrote:
> >
> > Hello!
> >
> > This series provides light-weight readers for SRCU.  This lightness
> > is selected by the caller by using the new srcu_read_lock_lite() and
> > srcu_read_unlock_lite() flavors instead of the usual srcu_read_lock() a=
nd
> > srcu_read_unlock() flavors.  Although this passes significant rcutortur=
e
> > testing, this should still be considered to be experimental.
> >
> > There are a few restrictions:  (1) If srcu_read_lock_lite() is called
> > on a given srcu_struct structure, then no other flavor may be used on
> > that srcu_struct structure, before, during, or after.  (2) The _lite()
> > readers may only be invoked from regions of code where RCU is watching
> > (as in those regions in which rcu_is_watching() returns true).  (3)
> > There is no auto-expediting for srcu_struct structures that have
> > been passed to _lite() readers.  (4) SRCU grace periods for _lite()
> > srcu_struct structures invoke synchronize_rcu() at least twice, thus
> > having longer latencies than their non-_lite() counterparts.  (5) Even
> > with synchronize_srcu_expedited(), the resulting SRCU grace period
> > will invoke synchronize_rcu() at least twice, as opposed to invoking
> > the IPI-happy synchronize_rcu_expedited() function.  (6)  Just as with
> > srcu_read_lock() and srcu_read_unlock(), the srcu_read_lock_lite() and
> > srcu_read_unlock_lite() functions may not (repeat, *not*) be invoked
> > from NMI handlers (that is what the _nmisafe() interface are for).
> > Although one could imagine readers that were both _lite() and _nmisafe(=
),
> > one might also imagine that the read-modify-write atomic operations tha=
t
> > are needed by any NMI-safe SRCU read marker would make this unhelpful
> > from a performance perspective.
> >
> > All that said, the patches in this series are as follows:
> >
> > 1.      Rename srcu_might_be_idle() to srcu_should_expedite().
> >
> > 2.      Introduce srcu_gp_is_expedited() helper function.
> >
> > 3.      Renaming in preparation for additional reader flavor.
> >
> > 4.      Bit manipulation changes for additional reader flavor.
> >
> > 5.      Standardize srcu_data pointers to "sdp" and similar.
> >
> > 6.      Convert srcu_data ->srcu_reader_flavor to bit field.
> >
> > 7.      Add srcu_read_lock_lite() and srcu_read_unlock_lite().
> >
> > 8.      rcutorture: Expand RCUTORTURE_RDR_MASK_[12] to eight bits.
> >
> > 9.      rcutorture: Add reader_flavor parameter for SRCU readers.
> >
> > 10.     rcutorture: Add srcu_read_lock_lite() support to
> >         rcutorture.reader_flavor.
> >
> > 11.     refscale: Add srcu_read_lock_lite() support using "srcu-lite".
> >
> >                                                 Thanx, Paul
> >
>
> Thanks Paul for working on this!
>
> I applied your patches on top of all my uprobe changes (including the
> RFC patches that remove locks, optimize VMA to inode resolution, etc,
> etc; basically the fastest uprobe/uretprobe state I can get to). And
> then tested a few changes:
>
>   - A) baseline (no SRCU-lite, RCU Tasks Trace for uprobe, normal SRCU
> for uretprobes)
>   - B) A + SRCU-lite for uretprobes (i.e., SRCU to SRCU-lite conversion)
>   - C) B + RCU Tasks Trace converted to SRCU-lite
>   - D) I also pessimized baseline by reverting RCU Tasks Trace, so
> both uprobes and uretprobes are SRCU protected. This allowed me to see
> a pure gain of SRCU-lite over SRCU for uprobes, taking RCU Tasks Trace
> performance out of the equation.
>
> In uprobes I used basically two benchmarks. One, uprobe-nop, that
> benchmarks entry uprobes (which are the fastest most optimized case,
> using RCU Tasks Trace in A and SRCU in D), and another that benchmarks
> return uprobes (uretprobes), called uretprobe-nop, which is normal
> SRCU both in A) and D). The latter uretprobe-nop benchmark basically
> combines entry and return probe overheads, because that's how
> uretprobes work.
>

Ok, so I created B' and C' cases, which are just like B and C from
before, but each now uses inlined versions of SRCU-lite API. I also
re-ran the latest BASELINE, which I'll call A', just to make sure all
the results are compatible and based off of the same tip/perf/core
branch state (uretprobe performance significantly improved for >64
CPUs, I don't know exactly why, tbh). I'll augment benchmark results
below inline for easier comparison.

> So, below are the most meaningful comparisons. First, SRCU vs
> SRCU-lite for uretprobes:
>
> BASELINE (A)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> uretprobe-nop         ( 1 cpus):    1.941 =C2=B1 0.002M/s  (  1.941M/s/cp=
u)
> uretprobe-nop         ( 2 cpus):    3.731 =C2=B1 0.001M/s  (  1.866M/s/cp=
u)
> uretprobe-nop         ( 3 cpus):    5.492 =C2=B1 0.002M/s  (  1.831M/s/cp=
u)
> uretprobe-nop         ( 4 cpus):    7.234 =C2=B1 0.003M/s  (  1.808M/s/cp=
u)
> uretprobe-nop         ( 8 cpus):   13.448 =C2=B1 0.098M/s  (  1.681M/s/cp=
u)
> uretprobe-nop         (16 cpus):   22.905 =C2=B1 0.009M/s  (  1.432M/s/cp=
u)
> uretprobe-nop         (32 cpus):   44.760 =C2=B1 0.069M/s  (  1.399M/s/cp=
u)
> uretprobe-nop         (40 cpus):   52.986 =C2=B1 0.104M/s  (  1.325M/s/cp=
u)
> uretprobe-nop         (64 cpus):   43.650 =C2=B1 0.435M/s  (  0.682M/s/cp=
u)
> uretprobe-nop         (80 cpus):   46.831 =C2=B1 0.938M/s  (  0.585M/s/cp=
u)
>
> SRCU-lite for uretprobe (B)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> uretprobe-nop         ( 1 cpus):    2.014 =C2=B1 0.014M/s  (  2.014M/s/cp=
u)
> uretprobe-nop         ( 2 cpus):    3.820 =C2=B1 0.002M/s  (  1.910M/s/cp=
u)
> uretprobe-nop         ( 3 cpus):    5.640 =C2=B1 0.003M/s  (  1.880M/s/cp=
u)
> uretprobe-nop         ( 4 cpus):    7.410 =C2=B1 0.003M/s  (  1.852M/s/cp=
u)
> uretprobe-nop         ( 8 cpus):   13.877 =C2=B1 0.009M/s  (  1.735M/s/cp=
u)
> uretprobe-nop         (16 cpus):   23.372 =C2=B1 0.022M/s  (  1.461M/s/cp=
u)
> uretprobe-nop         (32 cpus):   45.748 =C2=B1 0.048M/s  (  1.430M/s/cp=
u)
> uretprobe-nop         (40 cpus):   54.327 =C2=B1 0.093M/s  (  1.358M/s/cp=
u)
> uretprobe-nop         (64 cpus):   43.672 =C2=B1 0.371M/s  (  0.682M/s/cp=
u)
> uretprobe-nop         (80 cpus):   47.470 =C2=B1 0.753M/s  (  0.593M/s/cp=
u)
>

NEW BASELINE (A')
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
uretprobe-nop         ( 1 cpus):    1.946 =C2=B1 0.001M/s  (  1.946M/s/cpu)
uretprobe-nop         ( 2 cpus):    3.660 =C2=B1 0.002M/s  (  1.830M/s/cpu)
uretprobe-nop         ( 3 cpus):    5.522 =C2=B1 0.002M/s  (  1.841M/s/cpu)
uretprobe-nop         ( 4 cpus):    7.145 =C2=B1 0.001M/s  (  1.786M/s/cpu)
uretprobe-nop         ( 8 cpus):   13.449 =C2=B1 0.004M/s  (  1.681M/s/cpu)
uretprobe-nop         (16 cpus):   22.374 =C2=B1 0.008M/s  (  1.398M/s/cpu)
uretprobe-nop         (32 cpus):   45.039 =C2=B1 0.011M/s  (  1.407M/s/cpu)
uretprobe-nop         (40 cpus):   42.422 =C2=B1 0.073M/s  (  1.061M/s/cpu)
uretprobe-nop         (64 cpus):   65.136 =C2=B1 0.084M/s  (  1.018M/s/cpu)
uretprobe-nop         (80 cpus):   76.004 =C2=B1 0.066M/s  (  0.950M/s/cpu)

SRCU-lite for uretprobe (B')
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
uretprobe-nop         ( 1 cpus):    1.973 =C2=B1 0.001M/s  (  1.973M/s/cpu)
uretprobe-nop         ( 2 cpus):    3.756 =C2=B1 0.002M/s  (  1.878M/s/cpu)
uretprobe-nop         ( 3 cpus):    5.623 =C2=B1 0.003M/s  (  1.874M/s/cpu)
uretprobe-nop         ( 4 cpus):    7.206 =C2=B1 0.029M/s  (  1.802M/s/cpu)
uretprobe-nop         ( 8 cpus):   13.668 =C2=B1 0.004M/s  (  1.708M/s/cpu)
uretprobe-nop         (16 cpus):   23.067 =C2=B1 0.016M/s  (  1.442M/s/cpu)
uretprobe-nop         (32 cpus):   45.757 =C2=B1 0.030M/s  (  1.430M/s/cpu)
uretprobe-nop         (40 cpus):   54.550 =C2=B1 0.035M/s  (  1.364M/s/cpu)
uretprobe-nop         (64 cpus):   67.124 =C2=B1 0.057M/s  (  1.049M/s/cpu)
uretprobe-nop         (80 cpus):   77.150 =C2=B1 0.158M/s  (  0.964M/s/cpu)

Inlining does help a bit, adding +200-300K/s in some cases.

> You can see that across the board (except for noisy 64 CPU case)
> SRCU-lite is faster.
>
>
> Now, comparing A) vs C) on uprobe-nop, so we can see RCU Tasks Trace
> vs SRCU-lite for uprobes.
>
> BASELINE (A)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> uprobe-nop            ( 1 cpus):    3.574 =C2=B1 0.004M/s  (  3.574M/s/cp=
u)
> uprobe-nop            ( 2 cpus):    6.735 =C2=B1 0.006M/s  (  3.368M/s/cp=
u)
> uprobe-nop            ( 3 cpus):   10.102 =C2=B1 0.005M/s  (  3.367M/s/cp=
u)
> uprobe-nop            ( 4 cpus):   13.087 =C2=B1 0.008M/s  (  3.272M/s/cp=
u)
> uprobe-nop            ( 8 cpus):   24.622 =C2=B1 0.031M/s  (  3.078M/s/cp=
u)
> uprobe-nop            (16 cpus):   41.752 =C2=B1 0.020M/s  (  2.610M/s/cp=
u)
> uprobe-nop            (32 cpus):   84.973 =C2=B1 0.115M/s  (  2.655M/s/cp=
u)
> uprobe-nop            (40 cpus):  102.229 =C2=B1 0.030M/s  (  2.556M/s/cp=
u)
> uprobe-nop            (64 cpus):  125.537 =C2=B1 0.045M/s  (  1.962M/s/cp=
u)
> uprobe-nop            (80 cpus):  143.091 =C2=B1 0.044M/s  (  1.789M/s/cp=
u)
>
> SRCU-lite for uprobes (C)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> uprobe-nop            ( 1 cpus):    3.446 =C2=B1 0.010M/s  (  3.446M/s/cp=
u)
> uprobe-nop            ( 2 cpus):    6.411 =C2=B1 0.003M/s  (  3.206M/s/cp=
u)
> uprobe-nop            ( 3 cpus):    9.563 =C2=B1 0.039M/s  (  3.188M/s/cp=
u)
> uprobe-nop            ( 4 cpus):   12.454 =C2=B1 0.016M/s  (  3.113M/s/cp=
u)
> uprobe-nop            ( 8 cpus):   23.172 =C2=B1 0.013M/s  (  2.897M/s/cp=
u)
> uprobe-nop            (16 cpus):   39.793 =C2=B1 0.005M/s  (  2.487M/s/cp=
u)
> uprobe-nop            (32 cpus):   79.616 =C2=B1 0.207M/s  (  2.488M/s/cp=
u)
> uprobe-nop            (40 cpus):   96.851 =C2=B1 0.128M/s  (  2.421M/s/cp=
u)
> uprobe-nop            (64 cpus):  119.432 =C2=B1 0.146M/s  (  1.866M/s/cp=
u)
> uprobe-nop            (80 cpus):  135.162 =C2=B1 0.207M/s  (  1.690M/s/cp=
u)
>

NEW BASELINE (A')
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
uprobe-nop            ( 1 cpus):    3.480 =C2=B1 0.036M/s  (  3.480M/s/cpu)
uprobe-nop            ( 2 cpus):    6.652 =C2=B1 0.026M/s  (  3.326M/s/cpu)
uprobe-nop            ( 3 cpus):   10.050 =C2=B1 0.011M/s  (  3.350M/s/cpu)
uprobe-nop            ( 4 cpus):   13.079 =C2=B1 0.008M/s  (  3.270M/s/cpu)
uprobe-nop            ( 8 cpus):   24.620 =C2=B1 0.004M/s  (  3.077M/s/cpu)
uprobe-nop            (16 cpus):   41.566 =C2=B1 0.030M/s  (  2.598M/s/cpu)
uprobe-nop            (32 cpus):   77.314 =C2=B1 1.620M/s  (  2.416M/s/cpu)
uprobe-nop            (40 cpus):  102.667 =C2=B1 0.047M/s  (  2.567M/s/cpu)
uprobe-nop            (64 cpus):  126.298 =C2=B1 0.026M/s  (  1.973M/s/cpu)
uprobe-nop            (80 cpus):  146.682 =C2=B1 0.035M/s  (  1.834M/s/cpu)

SRCU-lite for uprobes w/ inlining (C')
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
uprobe-nop            ( 1 cpus):    3.444 =C2=B1 0.014M/s  (  3.444M/s/cpu)
uprobe-nop            ( 2 cpus):    6.400 =C2=B1 0.021M/s  (  3.200M/s/cpu)
uprobe-nop            ( 3 cpus):    9.568 =C2=B1 0.025M/s  (  3.189M/s/cpu)
uprobe-nop            ( 4 cpus):   12.473 =C2=B1 0.020M/s  (  3.118M/s/cpu)
uprobe-nop            ( 8 cpus):   23.552 =C2=B1 0.007M/s  (  2.944M/s/cpu)
uprobe-nop            (16 cpus):   39.844 =C2=B1 0.016M/s  (  2.490M/s/cpu)
uprobe-nop            (32 cpus):   78.667 =C2=B1 0.201M/s  (  2.458M/s/cpu)
uprobe-nop            (40 cpus):   97.477 =C2=B1 0.094M/s  (  2.437M/s/cpu)
uprobe-nop            (64 cpus):  119.472 =C2=B1 0.120M/s  (  1.867M/s/cpu)
uprobe-nop            (80 cpus):  139.825 =C2=B1 0.042M/s  (  1.748M/s/cpu)

>
> Overall, RCU Tasks Trace beats SRCU-lite, which I think is expected,
> so consider this just a confirmation. I'm not sure I'd like to switch
> from RCU Tasks Trace to SRCU-lite for uprobes part, but at least we
> have numbers to make that decision.
>
> Finally, to see SRCU vs SRCU-lite for entry uprobes improvements
> (i.e., if we never had RCU Tasks Trace). I've included a bit more
> extensive set of CPU counts for completeness.
>
> BASELINE w/ SRCU for uprobes (D)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> uprobe-nop            ( 1 cpus):    3.413 =C2=B1 0.003M/s  (  3.413M/s/cp=
u)
> uprobe-nop            ( 2 cpus):    6.305 =C2=B1 0.003M/s  (  3.153M/s/cp=
u)
> uprobe-nop            ( 3 cpus):    9.442 =C2=B1 0.018M/s  (  3.147M/s/cp=
u)
> uprobe-nop            ( 4 cpus):   12.253 =C2=B1 0.006M/s  (  3.063M/s/cp=
u)
> uprobe-nop            ( 5 cpus):   15.316 =C2=B1 0.007M/s  (  3.063M/s/cp=
u)
> uprobe-nop            ( 6 cpus):   18.287 =C2=B1 0.030M/s  (  3.048M/s/cp=
u)
> uprobe-nop            ( 7 cpus):   21.378 =C2=B1 0.025M/s  (  3.054M/s/cp=
u)
> uprobe-nop            ( 8 cpus):   23.044 =C2=B1 0.010M/s  (  2.881M/s/cp=
u)
> uprobe-nop            (10 cpus):   28.778 =C2=B1 0.012M/s  (  2.878M/s/cp=
u)
> uprobe-nop            (12 cpus):   31.300 =C2=B1 0.016M/s  (  2.608M/s/cp=
u)
> uprobe-nop            (14 cpus):   36.580 =C2=B1 0.007M/s  (  2.613M/s/cp=
u)
> uprobe-nop            (16 cpus):   38.848 =C2=B1 0.017M/s  (  2.428M/s/cp=
u)
> uprobe-nop            (24 cpus):   60.298 =C2=B1 0.080M/s  (  2.512M/s/cp=
u)
> uprobe-nop            (32 cpus):   77.137 =C2=B1 1.957M/s  (  2.411M/s/cp=
u)
> uprobe-nop            (40 cpus):   89.205 =C2=B1 1.278M/s  (  2.230M/s/cp=
u)
> uprobe-nop            (48 cpus):   99.207 =C2=B1 0.444M/s  (  2.067M/s/cp=
u)
> uprobe-nop            (56 cpus):  102.399 =C2=B1 0.484M/s  (  1.829M/s/cp=
u)
> uprobe-nop            (64 cpus):  115.390 =C2=B1 0.972M/s  (  1.803M/s/cp=
u)
> uprobe-nop            (72 cpus):  127.476 =C2=B1 0.050M/s  (  1.770M/s/cp=
u)
> uprobe-nop            (80 cpus):  137.304 =C2=B1 0.068M/s  (  1.716M/s/cp=
u)
>
> SRCU-lite for uprobes (C)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> uprobe-nop            ( 1 cpus):    3.446 =C2=B1 0.010M/s  (  3.446M/s/cp=
u)
> uprobe-nop            ( 2 cpus):    6.411 =C2=B1 0.003M/s  (  3.206M/s/cp=
u)
> uprobe-nop            ( 3 cpus):    9.563 =C2=B1 0.039M/s  (  3.188M/s/cp=
u)
> uprobe-nop            ( 4 cpus):   12.454 =C2=B1 0.016M/s  (  3.113M/s/cp=
u)
> uprobe-nop            ( 5 cpus):   15.634 =C2=B1 0.008M/s  (  3.127M/s/cp=
u)
> uprobe-nop            ( 6 cpus):   18.443 =C2=B1 0.018M/s  (  3.074M/s/cp=
u)
> uprobe-nop            ( 7 cpus):   21.793 =C2=B1 0.057M/s  (  3.113M/s/cp=
u)
> uprobe-nop            ( 8 cpus):   23.172 =C2=B1 0.013M/s  (  2.897M/s/cp=
u)
> uprobe-nop            (10 cpus):   29.430 =C2=B1 0.021M/s  (  2.943M/s/cp=
u)
> uprobe-nop            (12 cpus):   32.035 =C2=B1 0.008M/s  (  2.670M/s/cp=
u)
> uprobe-nop            (14 cpus):   37.174 =C2=B1 0.046M/s  (  2.655M/s/cp=
u)
> uprobe-nop            (16 cpus):   39.793 =C2=B1 0.005M/s  (  2.487M/s/cp=
u)
> uprobe-nop            (24 cpus):   61.656 =C2=B1 0.187M/s  (  2.569M/s/cp=
u)
> uprobe-nop            (32 cpus):   79.616 =C2=B1 0.207M/s  (  2.488M/s/cp=
u)
> uprobe-nop            (40 cpus):   96.851 =C2=B1 0.128M/s  (  2.421M/s/cp=
u)
> uprobe-nop            (48 cpus):  104.178 =C2=B1 0.033M/s  (  2.170M/s/cp=
u)
> uprobe-nop            (56 cpus):  105.689 =C2=B1 0.703M/s  (  1.887M/s/cp=
u)
> uprobe-nop            (64 cpus):  119.432 =C2=B1 0.146M/s  (  1.866M/s/cp=
u)
> uprobe-nop            (72 cpus):  127.574 =C2=B1 0.033M/s  (  1.772M/s/cp=
u)
> uprobe-nop            (80 cpus):  135.162 =C2=B1 0.207M/s  (  1.690M/s/cp=
u)
>
> So, say, at 32 threads, we get 79.6 vs 77.1, which is about 3%
> throughput win. Which is not negligible!
>
> Note that as we get to 80 cores data is more noisy (hyperthreading,
> background system noise, etc). But you can still see an improvement
> across basically the entire range.
>
> Hopefully the above data is useful.
>
> > -----------------------------------------------------------------------=
-
> >
> >  Documentation/admin-guide/kernel-parameters.txt   |    4
> >  b/Documentation/admin-guide/kernel-parameters.txt |    8 +
> >  b/include/linux/srcu.h                            |   21 +-
> >  b/include/linux/srcutree.h                        |    2
> >  b/kernel/rcu/rcutorture.c                         |   28 +--
> >  b/kernel/rcu/refscale.c                           |   54 +++++--
> >  b/kernel/rcu/srcutree.c                           |   16 +-
> >  include/linux/srcu.h                              |   86 +++++++++--
> >  include/linux/srcutree.h                          |    5
> >  kernel/rcu/rcutorture.c                           |   37 +++-
> >  kernel/rcu/srcutree.c                             |  168 +++++++++++++=
++-------
> >  11 files changed, 308 insertions(+), 121 deletions(-)

