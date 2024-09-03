Return-Path: <bpf+bounces-38842-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EABD896ABCE
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 00:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B7781C2392B
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 22:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0362B1DA316;
	Tue,  3 Sep 2024 22:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5zotwSH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5881DA2E1;
	Tue,  3 Sep 2024 22:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725401316; cv=none; b=f/8qGfpYAecXWuTjynjL+FtXk5U5VvmMhp7rg+cPQ3Wjb0qinOn0p7XUoHlk84oKKLMf4XrvhgctQN/ICRvlwN2VXHUzJHkMUx25Neu8op+Pl8QYEWHEljYzKAidRhpCATmgo4MfZdU12XCHSz0FqqB6w6n9+LSXta0Nk4N6heo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725401316; c=relaxed/simple;
	bh=WJvWFGlKBfr1UFCnZDHbjycRp7LWitNkxwg5KciGAWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cKfc/Qabg069J9cGrXDZu9AftP9+0zq43Hd6n1as+Wb2PRzCFnQfwn64HWNuyqArnza83Q9nFQ2U6aEvfj0sdAopsBRD83sCVix0R7vBxOeFGhZK8+B5cGdWrnnTMnSQxXRmXitQJEGLEJStOuPcj7KnO8EKl03d3GBnAk2mUS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C5zotwSH; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2d1daa2577bso4090400a91.2;
        Tue, 03 Sep 2024 15:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725401314; x=1726006114; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=05+oB0bcf+Hu9+RUtMLlTIM2Mu/BEj3LxW6llWiweaw=;
        b=C5zotwSHtTfmYCS+1gENouP/6OSFCi8kkCEfrsAlO+2/zyjMgF7iUKuflMuBkJ6+KP
         8OeUoDTc0aWJPiuHT9+I5Z4Lc6taAAzF6FW03OfgZDFMZVWQa5EDSHEqCGcNyE0+kM3D
         PvwpN42Mp2v1IeaZ4XiBKvloqpa8u8uil2GsQRYXPn7fyG8KALjPvDsVByUnO0tr+CGA
         JFjSudA1TyLlE/cibcF+dwLLuunCcmiJqwGMmLluDcpkNhDZVLfDRsyMSd3ixML69VUE
         yEU0d8AQJqhunWV7exejSwWaIZ1oXS7SByV6vtFDnQYKlg64L6+0XwXAmB5J2Eztsw8I
         hdWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725401314; x=1726006114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=05+oB0bcf+Hu9+RUtMLlTIM2Mu/BEj3LxW6llWiweaw=;
        b=bcwvhWCeprz7apLc53rqo25riL3PrUthntDqM9jy35xE7nQeOhUPeS/cmRHMckZtK8
         yBoCK427RDkBiRCEiJ790+3KnyHyzNpKJdzCmVQjQD3CWkLsyZryXyD6hLQxtx1hz2YG
         1sez/5wJZTS/0ZlCCdKFZZRVwEDG6Ra85OwAU5VtwuYWqO7XK7vgfi1yIMr5efPz7hg4
         FPHbYp5ZX7hILCFFahJ4/mzSYPVsJGrGLMYh0u29OJwZUe6e9oT+LwN3CwASgC4Wsfm6
         ouPcI/WdtO9eKgEwLM7VMlaqSjDCKpl4B2y8HM4rTnmBeN59Vp3E9SRfszRIYjz1QmB0
         ZFDQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+IG+qRDVw0LnwHm8tgPJPNsrq/zWRfPHlUh2xNe5Or9ugS7dM5fggs4ty7X4nGq0oBtE=@vger.kernel.org, AJvYcCVnvAI0crcXDuIGGmoAmc3lZtro05Vb+tQbDirsnt6QWc0nqlG0CPlCcTzCQmzHIxgLO3FkP+tjXMA/oP/P@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1ka8p/GooxQkGf1KksoT8g7FnxcNRNPpJ2TdQ+yyc91/IOhKM
	8MK7oKdjZlgmrkmsrX/KKqL9eDRuecZPj2oSeYZ7/lQ7JnwgfTzVaCUeiA3hypytPuyLIZGZHKi
	ICVOwKM3oyHV5wlN+sot6OqwPcBoY5xg6
X-Google-Smtp-Source: AGHT+IGvZoUtmLtLglqrbGXzcQ2X93GVrFFInJCAwPUq9a9ZToo0X5iXfW2raXz9m33c02yJx7iDMTumqNT2zhroDmc=
X-Received: by 2002:a17:90b:274e:b0:2d3:cb16:c8e with SMTP id
 98e67ed59e1d1-2d85649e92cmr19669581a91.43.1725401313781; Tue, 03 Sep 2024
 15:08:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <26cddadd-a79b-47b1-923e-9684cd8a7ef4@paulmck-laptop>
In-Reply-To: <26cddadd-a79b-47b1-923e-9684cd8a7ef4@paulmck-laptop>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 3 Sep 2024 15:08:21 -0700
Message-ID: <CAEf4BzZ5mJH5+4j56zSKkvuRLLfcQMEbkjM-T86onZdAWtsN+g@mail.gmail.com>
Subject: Re: [PATCH rcu 0/11] Add light-weight readers for SRCU
To: paulmck@kernel.org
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	rostedt@goodmis.org, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Kent Overstreet <kent.overstreet@linux.dev>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 9:32=E2=80=AFAM Paul E. McKenney <paulmck@kernel.org=
> wrote:
>
> Hello!
>
> This series provides light-weight readers for SRCU.  This lightness
> is selected by the caller by using the new srcu_read_lock_lite() and
> srcu_read_unlock_lite() flavors instead of the usual srcu_read_lock() and
> srcu_read_unlock() flavors.  Although this passes significant rcutorture
> testing, this should still be considered to be experimental.
>
> There are a few restrictions:  (1) If srcu_read_lock_lite() is called
> on a given srcu_struct structure, then no other flavor may be used on
> that srcu_struct structure, before, during, or after.  (2) The _lite()
> readers may only be invoked from regions of code where RCU is watching
> (as in those regions in which rcu_is_watching() returns true).  (3)
> There is no auto-expediting for srcu_struct structures that have
> been passed to _lite() readers.  (4) SRCU grace periods for _lite()
> srcu_struct structures invoke synchronize_rcu() at least twice, thus
> having longer latencies than their non-_lite() counterparts.  (5) Even
> with synchronize_srcu_expedited(), the resulting SRCU grace period
> will invoke synchronize_rcu() at least twice, as opposed to invoking
> the IPI-happy synchronize_rcu_expedited() function.  (6)  Just as with
> srcu_read_lock() and srcu_read_unlock(), the srcu_read_lock_lite() and
> srcu_read_unlock_lite() functions may not (repeat, *not*) be invoked
> from NMI handlers (that is what the _nmisafe() interface are for).
> Although one could imagine readers that were both _lite() and _nmisafe(),
> one might also imagine that the read-modify-write atomic operations that
> are needed by any NMI-safe SRCU read marker would make this unhelpful
> from a performance perspective.
>
> All that said, the patches in this series are as follows:
>
> 1.      Rename srcu_might_be_idle() to srcu_should_expedite().
>
> 2.      Introduce srcu_gp_is_expedited() helper function.
>
> 3.      Renaming in preparation for additional reader flavor.
>
> 4.      Bit manipulation changes for additional reader flavor.
>
> 5.      Standardize srcu_data pointers to "sdp" and similar.
>
> 6.      Convert srcu_data ->srcu_reader_flavor to bit field.
>
> 7.      Add srcu_read_lock_lite() and srcu_read_unlock_lite().
>
> 8.      rcutorture: Expand RCUTORTURE_RDR_MASK_[12] to eight bits.
>
> 9.      rcutorture: Add reader_flavor parameter for SRCU readers.
>
> 10.     rcutorture: Add srcu_read_lock_lite() support to
>         rcutorture.reader_flavor.
>
> 11.     refscale: Add srcu_read_lock_lite() support using "srcu-lite".
>
>                                                 Thanx, Paul
>

Thanks Paul for working on this!

I applied your patches on top of all my uprobe changes (including the
RFC patches that remove locks, optimize VMA to inode resolution, etc,
etc; basically the fastest uprobe/uretprobe state I can get to). And
then tested a few changes:

  - A) baseline (no SRCU-lite, RCU Tasks Trace for uprobe, normal SRCU
for uretprobes)
  - B) A + SRCU-lite for uretprobes (i.e., SRCU to SRCU-lite conversion)
  - C) B + RCU Tasks Trace converted to SRCU-lite
  - D) I also pessimized baseline by reverting RCU Tasks Trace, so
both uprobes and uretprobes are SRCU protected. This allowed me to see
a pure gain of SRCU-lite over SRCU for uprobes, taking RCU Tasks Trace
performance out of the equation.

In uprobes I used basically two benchmarks. One, uprobe-nop, that
benchmarks entry uprobes (which are the fastest most optimized case,
using RCU Tasks Trace in A and SRCU in D), and another that benchmarks
return uprobes (uretprobes), called uretprobe-nop, which is normal
SRCU both in A) and D). The latter uretprobe-nop benchmark basically
combines entry and return probe overheads, because that's how
uretprobes work.

So, below are the most meaningful comparisons. First, SRCU vs
SRCU-lite for uretprobes:

BASELINE (A)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
uretprobe-nop         ( 1 cpus):    1.941 =C2=B1 0.002M/s  (  1.941M/s/cpu)
uretprobe-nop         ( 2 cpus):    3.731 =C2=B1 0.001M/s  (  1.866M/s/cpu)
uretprobe-nop         ( 3 cpus):    5.492 =C2=B1 0.002M/s  (  1.831M/s/cpu)
uretprobe-nop         ( 4 cpus):    7.234 =C2=B1 0.003M/s  (  1.808M/s/cpu)
uretprobe-nop         ( 8 cpus):   13.448 =C2=B1 0.098M/s  (  1.681M/s/cpu)
uretprobe-nop         (16 cpus):   22.905 =C2=B1 0.009M/s  (  1.432M/s/cpu)
uretprobe-nop         (32 cpus):   44.760 =C2=B1 0.069M/s  (  1.399M/s/cpu)
uretprobe-nop         (40 cpus):   52.986 =C2=B1 0.104M/s  (  1.325M/s/cpu)
uretprobe-nop         (64 cpus):   43.650 =C2=B1 0.435M/s  (  0.682M/s/cpu)
uretprobe-nop         (80 cpus):   46.831 =C2=B1 0.938M/s  (  0.585M/s/cpu)

SRCU-lite for uretprobe (B)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
uretprobe-nop         ( 1 cpus):    2.014 =C2=B1 0.014M/s  (  2.014M/s/cpu)
uretprobe-nop         ( 2 cpus):    3.820 =C2=B1 0.002M/s  (  1.910M/s/cpu)
uretprobe-nop         ( 3 cpus):    5.640 =C2=B1 0.003M/s  (  1.880M/s/cpu)
uretprobe-nop         ( 4 cpus):    7.410 =C2=B1 0.003M/s  (  1.852M/s/cpu)
uretprobe-nop         ( 8 cpus):   13.877 =C2=B1 0.009M/s  (  1.735M/s/cpu)
uretprobe-nop         (16 cpus):   23.372 =C2=B1 0.022M/s  (  1.461M/s/cpu)
uretprobe-nop         (32 cpus):   45.748 =C2=B1 0.048M/s  (  1.430M/s/cpu)
uretprobe-nop         (40 cpus):   54.327 =C2=B1 0.093M/s  (  1.358M/s/cpu)
uretprobe-nop         (64 cpus):   43.672 =C2=B1 0.371M/s  (  0.682M/s/cpu)
uretprobe-nop         (80 cpus):   47.470 =C2=B1 0.753M/s  (  0.593M/s/cpu)

You can see that across the board (except for noisy 64 CPU case)
SRCU-lite is faster.


Now, comparing A) vs C) on uprobe-nop, so we can see RCU Tasks Trace
vs SRCU-lite for uprobes.

BASELINE (A)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
uprobe-nop            ( 1 cpus):    3.574 =C2=B1 0.004M/s  (  3.574M/s/cpu)
uprobe-nop            ( 2 cpus):    6.735 =C2=B1 0.006M/s  (  3.368M/s/cpu)
uprobe-nop            ( 3 cpus):   10.102 =C2=B1 0.005M/s  (  3.367M/s/cpu)
uprobe-nop            ( 4 cpus):   13.087 =C2=B1 0.008M/s  (  3.272M/s/cpu)
uprobe-nop            ( 8 cpus):   24.622 =C2=B1 0.031M/s  (  3.078M/s/cpu)
uprobe-nop            (16 cpus):   41.752 =C2=B1 0.020M/s  (  2.610M/s/cpu)
uprobe-nop            (32 cpus):   84.973 =C2=B1 0.115M/s  (  2.655M/s/cpu)
uprobe-nop            (40 cpus):  102.229 =C2=B1 0.030M/s  (  2.556M/s/cpu)
uprobe-nop            (64 cpus):  125.537 =C2=B1 0.045M/s  (  1.962M/s/cpu)
uprobe-nop            (80 cpus):  143.091 =C2=B1 0.044M/s  (  1.789M/s/cpu)

SRCU-lite for uprobes (C)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
uprobe-nop            ( 1 cpus):    3.446 =C2=B1 0.010M/s  (  3.446M/s/cpu)
uprobe-nop            ( 2 cpus):    6.411 =C2=B1 0.003M/s  (  3.206M/s/cpu)
uprobe-nop            ( 3 cpus):    9.563 =C2=B1 0.039M/s  (  3.188M/s/cpu)
uprobe-nop            ( 4 cpus):   12.454 =C2=B1 0.016M/s  (  3.113M/s/cpu)
uprobe-nop            ( 8 cpus):   23.172 =C2=B1 0.013M/s  (  2.897M/s/cpu)
uprobe-nop            (16 cpus):   39.793 =C2=B1 0.005M/s  (  2.487M/s/cpu)
uprobe-nop            (32 cpus):   79.616 =C2=B1 0.207M/s  (  2.488M/s/cpu)
uprobe-nop            (40 cpus):   96.851 =C2=B1 0.128M/s  (  2.421M/s/cpu)
uprobe-nop            (64 cpus):  119.432 =C2=B1 0.146M/s  (  1.866M/s/cpu)
uprobe-nop            (80 cpus):  135.162 =C2=B1 0.207M/s  (  1.690M/s/cpu)


Overall, RCU Tasks Trace beats SRCU-lite, which I think is expected,
so consider this just a confirmation. I'm not sure I'd like to switch
from RCU Tasks Trace to SRCU-lite for uprobes part, but at least we
have numbers to make that decision.

Finally, to see SRCU vs SRCU-lite for entry uprobes improvements
(i.e., if we never had RCU Tasks Trace). I've included a bit more
extensive set of CPU counts for completeness.

BASELINE w/ SRCU for uprobes (D)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
uprobe-nop            ( 1 cpus):    3.413 =C2=B1 0.003M/s  (  3.413M/s/cpu)
uprobe-nop            ( 2 cpus):    6.305 =C2=B1 0.003M/s  (  3.153M/s/cpu)
uprobe-nop            ( 3 cpus):    9.442 =C2=B1 0.018M/s  (  3.147M/s/cpu)
uprobe-nop            ( 4 cpus):   12.253 =C2=B1 0.006M/s  (  3.063M/s/cpu)
uprobe-nop            ( 5 cpus):   15.316 =C2=B1 0.007M/s  (  3.063M/s/cpu)
uprobe-nop            ( 6 cpus):   18.287 =C2=B1 0.030M/s  (  3.048M/s/cpu)
uprobe-nop            ( 7 cpus):   21.378 =C2=B1 0.025M/s  (  3.054M/s/cpu)
uprobe-nop            ( 8 cpus):   23.044 =C2=B1 0.010M/s  (  2.881M/s/cpu)
uprobe-nop            (10 cpus):   28.778 =C2=B1 0.012M/s  (  2.878M/s/cpu)
uprobe-nop            (12 cpus):   31.300 =C2=B1 0.016M/s  (  2.608M/s/cpu)
uprobe-nop            (14 cpus):   36.580 =C2=B1 0.007M/s  (  2.613M/s/cpu)
uprobe-nop            (16 cpus):   38.848 =C2=B1 0.017M/s  (  2.428M/s/cpu)
uprobe-nop            (24 cpus):   60.298 =C2=B1 0.080M/s  (  2.512M/s/cpu)
uprobe-nop            (32 cpus):   77.137 =C2=B1 1.957M/s  (  2.411M/s/cpu)
uprobe-nop            (40 cpus):   89.205 =C2=B1 1.278M/s  (  2.230M/s/cpu)
uprobe-nop            (48 cpus):   99.207 =C2=B1 0.444M/s  (  2.067M/s/cpu)
uprobe-nop            (56 cpus):  102.399 =C2=B1 0.484M/s  (  1.829M/s/cpu)
uprobe-nop            (64 cpus):  115.390 =C2=B1 0.972M/s  (  1.803M/s/cpu)
uprobe-nop            (72 cpus):  127.476 =C2=B1 0.050M/s  (  1.770M/s/cpu)
uprobe-nop            (80 cpus):  137.304 =C2=B1 0.068M/s  (  1.716M/s/cpu)

SRCU-lite for uprobes (C)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
uprobe-nop            ( 1 cpus):    3.446 =C2=B1 0.010M/s  (  3.446M/s/cpu)
uprobe-nop            ( 2 cpus):    6.411 =C2=B1 0.003M/s  (  3.206M/s/cpu)
uprobe-nop            ( 3 cpus):    9.563 =C2=B1 0.039M/s  (  3.188M/s/cpu)
uprobe-nop            ( 4 cpus):   12.454 =C2=B1 0.016M/s  (  3.113M/s/cpu)
uprobe-nop            ( 5 cpus):   15.634 =C2=B1 0.008M/s  (  3.127M/s/cpu)
uprobe-nop            ( 6 cpus):   18.443 =C2=B1 0.018M/s  (  3.074M/s/cpu)
uprobe-nop            ( 7 cpus):   21.793 =C2=B1 0.057M/s  (  3.113M/s/cpu)
uprobe-nop            ( 8 cpus):   23.172 =C2=B1 0.013M/s  (  2.897M/s/cpu)
uprobe-nop            (10 cpus):   29.430 =C2=B1 0.021M/s  (  2.943M/s/cpu)
uprobe-nop            (12 cpus):   32.035 =C2=B1 0.008M/s  (  2.670M/s/cpu)
uprobe-nop            (14 cpus):   37.174 =C2=B1 0.046M/s  (  2.655M/s/cpu)
uprobe-nop            (16 cpus):   39.793 =C2=B1 0.005M/s  (  2.487M/s/cpu)
uprobe-nop            (24 cpus):   61.656 =C2=B1 0.187M/s  (  2.569M/s/cpu)
uprobe-nop            (32 cpus):   79.616 =C2=B1 0.207M/s  (  2.488M/s/cpu)
uprobe-nop            (40 cpus):   96.851 =C2=B1 0.128M/s  (  2.421M/s/cpu)
uprobe-nop            (48 cpus):  104.178 =C2=B1 0.033M/s  (  2.170M/s/cpu)
uprobe-nop            (56 cpus):  105.689 =C2=B1 0.703M/s  (  1.887M/s/cpu)
uprobe-nop            (64 cpus):  119.432 =C2=B1 0.146M/s  (  1.866M/s/cpu)
uprobe-nop            (72 cpus):  127.574 =C2=B1 0.033M/s  (  1.772M/s/cpu)
uprobe-nop            (80 cpus):  135.162 =C2=B1 0.207M/s  (  1.690M/s/cpu)

So, say, at 32 threads, we get 79.6 vs 77.1, which is about 3%
throughput win. Which is not negligible!

Note that as we get to 80 cores data is more noisy (hyperthreading,
background system noise, etc). But you can still see an improvement
across basically the entire range.

Hopefully the above data is useful.

> ------------------------------------------------------------------------
>
>  Documentation/admin-guide/kernel-parameters.txt   |    4
>  b/Documentation/admin-guide/kernel-parameters.txt |    8 +
>  b/include/linux/srcu.h                            |   21 +-
>  b/include/linux/srcutree.h                        |    2
>  b/kernel/rcu/rcutorture.c                         |   28 +--
>  b/kernel/rcu/refscale.c                           |   54 +++++--
>  b/kernel/rcu/srcutree.c                           |   16 +-
>  include/linux/srcu.h                              |   86 +++++++++--
>  include/linux/srcutree.h                          |    5
>  kernel/rcu/rcutorture.c                           |   37 +++-
>  kernel/rcu/srcutree.c                             |  168 +++++++++++++++=
-------
>  11 files changed, 308 insertions(+), 121 deletions(-)

