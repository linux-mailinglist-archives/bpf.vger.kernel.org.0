Return-Path: <bpf+bounces-71724-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D76E8BFC228
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 15:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EFB1188A207
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 13:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618FC345CAE;
	Wed, 22 Oct 2025 13:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Btc9vJBI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385DA33F8DE
	for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 13:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761139693; cv=none; b=Ksp+Lj7z0NcVmeuDiaDnMKdAAD4aRp1zARsoGNZ6iKNPqLvMLjPJ10eNXgFwsR/zg3ylM0BgxoQ8nCoLQcWtT3Vl5s+t53M/dOGUcvsGICaryt5GSC2C8U81cB3UWLqkIEKfejImiMspbIymm1nlgt5mfWa5lJ9VyTHiYZtQIqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761139693; c=relaxed/simple;
	bh=IxjamDNQCsgi0EcPuUY3Ab/mnCK9x4FsQg47nPPIXiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VFXqoPJLyC9REO2SaNkXp9FXvPtlOoyp9SFSMGAZ6cjOTVJ28dl1edUk3nyjBjOEUKeqUjtY4R0lkpRdlj7b+xny0Bu7ES9fxeoP4hJ2U5sj7MG0h7AJzAU4zq6g0jqeHfE1pQZ2aQh+Bcfv2v/r8LgVjFXv0MVdyg+9XiWyDM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Btc9vJBI; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4711f3c386eso35945205e9.0
        for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 06:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761139689; x=1761744489; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SN7QGgRPhzAtlqwfg5Z+k7xiHmKgYQJHAfxaFhh4dDc=;
        b=Btc9vJBIdnJfyxlGJNXaqt+kTqTHv2gY8uUjvRRe6J8JNrzseglmDEWjwmT1xEOb9m
         lYYo8sIm4onqP10+/rgjSzpz23O2fVanbl7qBmTndwFpbWsxZwkGkWe4fQoU7tAuOi8Q
         8EXU4iE4X4NeCF2plAWtfxrGJ53ab4pF5uUOgIoxS2n3N4X6pJ7BkD7g9mOpQC5MFySa
         xTVQTuSJhieeKuJIc1ApgajQ5Q+NaZ4EvCUnyqYZfGg4hxKjCVMt1CB1oI5Kn7da4clA
         74WQ7+nHAxnsf96EHbyL52UUbzwguZxLdjQdZtnYBquSfRgPMlecY6y6WDWpJGlJcwFu
         IgOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761139689; x=1761744489;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SN7QGgRPhzAtlqwfg5Z+k7xiHmKgYQJHAfxaFhh4dDc=;
        b=JTdZ+HURjH3jiUCVqxT0+jnd173kESCdsZk0Z81WbvRqZ8idRA+/Na5BFWEiag0q2P
         1uRTr135q/l+n2m8AirCaHrYlo3gofp2iqS92WLajUYapibgNlTRgwB2S5o6HhrhrUKH
         5dHtFWbM5W5ly+AdHzvZ4jOhj22xNoEg3nG+3ys6AB94WnsZcLAk86JFO1f+aw1tRugj
         8Iu0HUNrnDQhl0d9YriagsnDlygvQVW5AllmnB0nV/DQWdUEzpFNC8rV2ncEgCeZRbUg
         CLjZdQCzZIC7TjUqM9MyzPBYhKCvrdnEJsFqRK8hv3u8FfHltXz1wZ2BjT81SbYEFQK0
         f89Q==
X-Forwarded-Encrypted: i=1; AJvYcCUrNQmxj3igHHXIDHJ7ZhRiCtrHcNZE8Sh0TMf6hKb66BuWHBEEVrNku434TB+VMnavyF8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL3PcujnfH2GjX90PExTXtne5khz4QN28grFNkOuwxByRA/PlK
	IJUrySFsayBlwBBz5gr9g2QA8EdEFFZ64G0xVClhB0l/Lho2fdbwB+vU
X-Gm-Gg: ASbGncvtJ4TVeV6C2BDZ+UInBIBAIS3ujHQsxBeJ9+kpKN4JvVjgng7nqvqLstT+6ra
	kbV+1ztm7Lzuhlm4UeCyJ20F/cvVVEis5V0DTsCn2oh1CrAyuqOmTdq7XKQ3gFcOT3km9ugflvt
	5PPQar99Dy9OtJ3RG0JWWtLviBRy0MvwSfQCH1hAYZOKidLS9pA7ojpIE7rZ5Qx10qDBjcEsSPR
	NnuHpwtBRgG7H0kTVK3AIH5u98T2n/5wufJLjRpFiz2T1xkA1F/e/1vA9QlhmXdNvNWrwp3fjVR
	ZRdX2P1nLTljGBtmiWZ8AvWMbjRpfL18TDcwit349EfGvi/PJdaC7D/jFm7IY8AtVbgNlCCS+Di
	eCKRZEmrb/5Sjl+mjkKbH9XVPrC4FTR2niPD1dR9904VaataO9YQTuc9DTO3qLDG3Xu2heczgdX
	U9XbmXfvXcQLasTGHtYSDP
X-Google-Smtp-Source: AGHT+IFgJrlPOrNHLArFUGo0ucDKM8ASkBxgnWeJAn7sSdAYUq9zRzUDDSruP9yAJW4aUsqDICKlTQ==
X-Received: by 2002:a05:600c:3e8f:b0:45f:2919:5e6c with SMTP id 5b1f17b1804b1-471178b123fmr158757425e9.16.1761139689306;
        Wed, 22 Oct 2025 06:28:09 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47494aad668sm39645525e9.2.2025.10.22.06.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 06:28:08 -0700 (PDT)
Date: Wed, 22 Oct 2025 13:34:48 +0000
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
Message-ID: <aPjdeCjV4fYqqPeR@mail.gmail.com>
References: <20251019202145.3944697-1-a.s.protopopov@gmail.com>
 <20251019202145.3944697-18-a.s.protopopov@gmail.com>
 <3a9c5da97ad4f2d3ccccf315cb855b4d896f5a7c.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a9c5da97ad4f2d3ccccf315cb855b4d896f5a7c.camel@gmail.com>

On 25/10/21 05:27PM, Eduard Zingerman wrote:
> On Sun, 2025-10-19 at 20:21 +0000, Anton Protopopov wrote:
> 
> [...]
> 
> > diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_gotox.c b/tools/testing/selftests/bpf/prog_tests/bpf_gotox.c
> > new file mode 100644
> > index 000000000000..4394654ac75a
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/bpf_gotox.c
> > @@ -0,0 +1,185 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include <test_progs.h>
> > +
> > +#include <linux/if_ether.h>
> > +#include <linux/in.h>
> > +#include <linux/ip.h>
> > +#include <linux/ipv6.h>
> > +#include <linux/in6.h>
> > +#include <linux/udp.h>
> > +#include <linux/tcp.h>
> > +
> > +#include <sys/syscall.h>
> > +#include <bpf/bpf.h>
> > +
> > +#include "bpf_gotox.skel.h"
> > +
> > +/* Disable tests for now, as CI runs with LLVM-20 */
> > +#if 0
> 
> I removed all the `#if 0` and tried to compile this test using LLVM at commit
> 1a9aba29b09e ("[RISCV] Remove unreachable break statements. NFC (#164481)").
> 
> LLVM refuses to compile showing errors like below:
> 
>   CLNG-BPF [test_progs-cpuv4] bpf_gotox.bpf.o
> fatal error: error in backend: Cannot select: <U+001B>[0;31mt15<U+001B>[0m: ch = brind <U+001B>[0;30mt7<U+001B>[0m, <U+001B>[0;30mt14<U+001B>[0m
>   <U+001B>[0;30mt14<U+001B>[0m: i64,ch = load<(invariant load (s64) from %ir.arrayidx)> <U+001B>[0;30mt0<U+001B>[0m, <U+001B>[0;36mt13<U+001B>[0m, undef:i64, progs/bpf_gotox.c:202:8
>     <U+001B>[0;36mt13<U+001B>[0m: i64 = add nuw <U+001B>[0;33mt17<U+001B>[0m, <U+001B>[0;35mt12<U+001B>[0m, progs/bpf_gotox.c:202:8
>       <U+001B>[0;33mt17<U+001B>[0m: i64 = LDIMM64 TargetGlobalAddress:i64<ptr @__const.big_jump_table.jt> 0, progs/bpf_gotox.c:202:8
>       <U+001B>[0;35mt12<U+001B>[0m: i64 = shl nuw nsw <U+001B>[0;32mt9<U+001B>[0m, Constant:i64<3>, progs/bpf_gotox.c:202:8
>         <U+001B>[0;32mt9<U+001B>[0m: i64 = and <U+001B>[0;35mt5<U+001B>[0m, Constant:i64<255>, progs/bpf_gotox.c:202:18
>           <U+001B>[0;35mt5<U+001B>[0m: i64,ch = load<(load (s64) from %ir.ctx)> <U+001B>[0;30mt0<U+001B>[0m, <U+001B>[0;32mt2<U+001B>[0m, undef:i64, progs/bpf_gotox.c:202:16
>             <U+001B>[0;32mt2<U+001B>[0m: i64,ch = CopyFromReg <U+001B>[0;30mt0<U+001B>[0m, Register:i64 %5
> In function: big_jump_table
> 
> CC'ing Yonghong.

Looks like no -mcpu=v4. I had to hack Makefile (set v3 -> v4) to build it.

Even when one tries to build test_progs-cpuv4, the v3 version is
also built.  In the bpf prog this is easy to ifdef it: x86_64 +
__clang + one can define a variable like BPF_CPU=4 in Makefile.
But the prog_tests can't easily see was the skeleton compiled
with v3 or v4, so I just ended up with putting #if 0 there for now...

> [...]

