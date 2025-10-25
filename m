Return-Path: <bpf+bounces-72196-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC46C09DF7
	for <lists+bpf@lfdr.de>; Sat, 25 Oct 2025 19:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4540F4E1184
	for <lists+bpf@lfdr.de>; Sat, 25 Oct 2025 17:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503163002A4;
	Sat, 25 Oct 2025 17:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kX61LPqZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27131234973
	for <bpf@vger.kernel.org>; Sat, 25 Oct 2025 17:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761413665; cv=none; b=XanIN13cy7EhtoNFaPmuYBBzXx9jkLULr47I24fCS0T6FStTfVpHcLLxCyHzsICPtBIq9Om7BUWBXoZck0ZKKxwVGbaeSvPglKorjUWmOYKRqvcwfimO00GBu72Kr6vbsIAuP0UESTW3ZZ79EIa4xienOs2cOnVd2Y2gmGRkUq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761413665; c=relaxed/simple;
	bh=FHDfONyn1Pa1QgEUWNZNU8p+yWQnb9uw2CEic6agawY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J4wl7zbll3ZQkx/0CURVLa8xso4JYnyBvFz4w8OMEC9TVa1J0907HhOBw7FdDTdilm4fveMfHx7NbBivVsGpGPCnyWUjgLT57AmVXUpTe6w+fLYuLgtOWShQrmpuEsElmaYYKnkLI972ERajsqMEKulOtbMp5cy1q1qtkopbn28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kX61LPqZ; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4710665e7deso15533755e9.1
        for <bpf@vger.kernel.org>; Sat, 25 Oct 2025 10:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761413662; x=1762018462; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6PeJQCeDjdt8BiGaz282bO088/asJbK1yR6kqHEckT4=;
        b=kX61LPqZX4suXpoNNE7tkL9IFB4ybK2HCv1h5v3j6nFdzzLHMmkR4u/GAerPAp2Kew
         hZHI81cIgm9Dvxhc7D4IQBm01wVngKAdzXP7PloarVANzbB+RGRj38tMYmems6dBWDCx
         bRzmVEKU8FYsRIZAS6nZ/TwpGE6fYAlhGW6UaiDspkRe1kaqUagEW5oa6RDFfA6R40px
         iC8N6hkyzwqeX56nfpijnaiadh3tK51xOjv3dF1kfCdSHw2Y4FjTr9HVeaP6FSYO/j9c
         bcGIB2W6sc57NgISHj3YQ95MNGAFocPzTPUZJG1xNkoFY0mi354gnYOx7NDJZhzXtejj
         ++lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761413662; x=1762018462;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6PeJQCeDjdt8BiGaz282bO088/asJbK1yR6kqHEckT4=;
        b=TRjDBHuv3kSpZsf0tMC0W9k/wG1LSuvj4TxVXIhx8Eh9mSArNsjlN5p5xk7ZI6ju29
         eTdv4QE+zG/5/+iaZ5b3c6rXIOuvZo50uHxvQNLfOvrUXLIk5o0nmne7Spe3ntAOazl7
         AIBCBVREE3WXwFWmuUhCTGhv+guaXmRt6nOhtg2C72HgHx+OOLKO3CvgOKV5fVogopKM
         ev1wfaRgoRSWRiinYo0f2+La0EcfJotK4GC5M7yYodga1lMtoLFuLOUigpN9G0ThcF9A
         AWyOFeTecSHc0JpFBLg+f+TXLVMwbeLkYK2O4JN9lF5bkCHXDUFJZ0tyMoRfe24o9dd3
         8LfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhvkTpL9zeN1Aw0kWtEhX53p3yBDyxPkL+tIc8FTVjRwrJYE1pj/Nz+GrATnE+zyjmh18=@vger.kernel.org
X-Gm-Message-State: AOJu0YylBoYKQU27BCZA5SKtrybOaOGW+32MlygWlw+hsq9n+vD4lfaC
	BLrKBBLVDz/4DN9dUkKQg9Cuu7wmefbX8X0Q/2X/1lDpYrqSCWTSbDK4
X-Gm-Gg: ASbGncuIaPWeeu6KMFQt/1hfABtd8sqnNKZpgyvh9L+EXPpkvQaCTerz4qz7D1SwMvM
	SchCllDnT07IbN5Qm1sNOczviW7tRewd4f8FkH9EQma68nt7/rME/hUDiT602xovNSJDiLCBrXV
	/GmUHwi/7Aji2IBy/pDNAUe43O+eUl9CPPe9JmYl7Kw6JLicebpDGHHJzxZEYyY9YasUVgUCTda
	OrpWbSuZDpIMDeTtVdm/jPs/4n8HkzROl991yTUtG8RA2889jUn2dmTcPNKpCpNqweYFqonYagi
	Qdp+fzS711EiwFn2fZha16htsIbg+TUNbe/YjeXqQTbr//0f5/iu3OpYtew1IrAJh6+IccsFQ4J
	/u4RqE2svfHQZagz8iHtiPQWa6oRK8kY1fwZZoS1Nq9uH0t1mo0MRJX1UbObRTIytJJjWF9Ty1+
	YcBmTH6VIPyQ==
X-Google-Smtp-Source: AGHT+IGTmIXNy83R6sw5KQjMh+rhPHZF+qBhFSQ7i4y3SPgzkGai2Dv/krE2g36SXvviuWyiGKDLkA==
X-Received: by 2002:a05:600c:4e45:b0:471:786:94d3 with SMTP id 5b1f17b1804b1-475cb02faa5mr78954315e9.22.1761413662294;
        Sat, 25 Oct 2025 10:34:22 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd47794asm48289985e9.1.2025.10.25.10.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 10:34:21 -0700 (PDT)
Date: Sat, 25 Oct 2025 17:41:05 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Quentin Monnet <qmo@kernel.org>
Subject: Re: [PATCH v6 bpf-next 17/17] selftests/bpf: add C-level selftests
 for indirect jumps
Message-ID: <aP0LsTKYFAxE8OpD@mail.gmail.com>
References: <20251019202145.3944697-1-a.s.protopopov@gmail.com>
 <20251019202145.3944697-18-a.s.protopopov@gmail.com>
 <3a9c5da97ad4f2d3ccccf315cb855b4d896f5a7c.camel@gmail.com>
 <aPjdeCjV4fYqqPeR@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPjdeCjV4fYqqPeR@mail.gmail.com>

On 25/10/22 01:34PM, Anton Protopopov wrote:
> On 25/10/21 05:27PM, Eduard Zingerman wrote:
> > On Sun, 2025-10-19 at 20:21 +0000, Anton Protopopov wrote:
> > 
> > [...]
> > 
> > > diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_gotox.c b/tools/testing/selftests/bpf/prog_tests/bpf_gotox.c
> > > new file mode 100644
> > > index 000000000000..4394654ac75a
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/bpf/prog_tests/bpf_gotox.c
> > > @@ -0,0 +1,185 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +
> > > +#include <test_progs.h>
> > > +
> > > +#include <linux/if_ether.h>
> > > +#include <linux/in.h>
> > > +#include <linux/ip.h>
> > > +#include <linux/ipv6.h>
> > > +#include <linux/in6.h>
> > > +#include <linux/udp.h>
> > > +#include <linux/tcp.h>
> > > +
> > > +#include <sys/syscall.h>
> > > +#include <bpf/bpf.h>
> > > +
> > > +#include "bpf_gotox.skel.h"
> > > +
> > > +/* Disable tests for now, as CI runs with LLVM-20 */
> > > +#if 0
> > 
> > I removed all the `#if 0` and tried to compile this test using LLVM at commit
> > 1a9aba29b09e ("[RISCV] Remove unreachable break statements. NFC (#164481)").
> > 
> > LLVM refuses to compile showing errors like below:
> > 
> >   CLNG-BPF [test_progs-cpuv4] bpf_gotox.bpf.o
> > fatal error: error in backend: Cannot select: <U+001B>[0;31mt15<U+001B>[0m: ch = brind <U+001B>[0;30mt7<U+001B>[0m, <U+001B>[0;30mt14<U+001B>[0m
> >   <U+001B>[0;30mt14<U+001B>[0m: i64,ch = load<(invariant load (s64) from %ir.arrayidx)> <U+001B>[0;30mt0<U+001B>[0m, <U+001B>[0;36mt13<U+001B>[0m, undef:i64, progs/bpf_gotox.c:202:8
> >     <U+001B>[0;36mt13<U+001B>[0m: i64 = add nuw <U+001B>[0;33mt17<U+001B>[0m, <U+001B>[0;35mt12<U+001B>[0m, progs/bpf_gotox.c:202:8
> >       <U+001B>[0;33mt17<U+001B>[0m: i64 = LDIMM64 TargetGlobalAddress:i64<ptr @__const.big_jump_table.jt> 0, progs/bpf_gotox.c:202:8
> >       <U+001B>[0;35mt12<U+001B>[0m: i64 = shl nuw nsw <U+001B>[0;32mt9<U+001B>[0m, Constant:i64<3>, progs/bpf_gotox.c:202:8
> >         <U+001B>[0;32mt9<U+001B>[0m: i64 = and <U+001B>[0;35mt5<U+001B>[0m, Constant:i64<255>, progs/bpf_gotox.c:202:18
> >           <U+001B>[0;35mt5<U+001B>[0m: i64,ch = load<(load (s64) from %ir.ctx)> <U+001B>[0;30mt0<U+001B>[0m, <U+001B>[0;32mt2<U+001B>[0m, undef:i64, progs/bpf_gotox.c:202:16
> >             <U+001B>[0;32mt2<U+001B>[0m: i64,ch = CopyFromReg <U+001B>[0;30mt0<U+001B>[0m, Register:i64 %5
> > In function: big_jump_table
> > 
> > CC'ing Yonghong.
> 
> Looks like no -mcpu=v4. I had to hack Makefile (set v3 -> v4) to build it.
> 
> Even when one tries to build test_progs-cpuv4, the v3 version is
> also built.  In the bpf prog this is easy to ifdef it: x86_64 +
> __clang + one can define a variable like BPF_CPU=4 in Makefile.
> But the prog_tests can't easily see was the skeleton compiled
> with v3 or v4, so I just ended up with putting #if 0 there for now...

Yes, checked with the latest LLVM that this is "v3 vs. v4".
If you pass -mcpu=v4 the code will compile fine.

> > [...]

