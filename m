Return-Path: <bpf+bounces-71622-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F906BF849F
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 21:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 392C919C3A59
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 19:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9998350A0D;
	Tue, 21 Oct 2025 19:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PGm4pz+I"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A966021FF35
	for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 19:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761075863; cv=none; b=qX9Co7RZXbzJgmVzg3N5YzCMSjmtA+ch+AMYqPruJ+YqviM/cdEm94iQSkEz5FyLZDDMnWEOkJxFfOdSt+RV+3oNolji4WEYFNkGYXcSewikYV5TShojluTvS7LwBVi6VFyfucYZRAyxMc4nrOEZle7nGUju15EVKPDgPTHIx00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761075863; c=relaxed/simple;
	bh=DL3fS/vPB9gAIu+ACpvzgOqcbmF23Fk9X7Q+rsSO+qU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d8PiG94EPS/ibWQca88kzMXkFmShXBpdBzo4PsMj4t0y25M0e+vLwxbOo/S9ERXimZJc9CwWcDi26VnlENta2Ibt+ldam5J7xg3uHjNZvlr+FqForMKBLhTYqjz7H3iQ1O5nraVCnxNyu9VxI61kt48xriAcv+AWgA0bCaWyQm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PGm4pz+I; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4710ff3ae81so22325875e9.0
        for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 12:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761075860; x=1761680660; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bIpA+Kj7A8sSxNMOxUnnzB75cZc306nv06JHOV3hoZ0=;
        b=PGm4pz+Izq+OFhVmE38vOlj/5Pa5CDyBI8m9ald4Iwd1ihtoM6kQzDPT5QCCMol4kc
         SsYsqhHk9HhqE9+g6pn0KUxFmkhkCmrN86gbzrKX3SeDNXH6Shbwqth97U0UIlf76O0E
         KZIRnamWeKoxHtV+0MpJnbtp+ke5pSCB9FIBZKWNZgqmTej3wh/cBJ5NaXh+FIfTEmZp
         UQyqjC0nocfk+WAquy611bAKuLJuG5VRzoKlF9iWlHPnEhYb3TjCthOy9ZhNmmVY5lTO
         RHkT1nrvlgBkB8UMNGjKqomG0ys+qBhO4ylyWYEsewQIQMLUwPBwXegZ+E7d8euj5eAb
         0awA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761075860; x=1761680660;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bIpA+Kj7A8sSxNMOxUnnzB75cZc306nv06JHOV3hoZ0=;
        b=AfZGSJ/0ujVvkDX4s1k2B1fU7tPYoPTDEz+xbxpFrY9KCWiJl+c2Of/gZe/qCwWYwL
         M0jHb8luABAZcG8aDlyEyEkfUhiI+O1QKsvdHjyvCBcjFBpXqNE85kyA8sy33QH6Hmv5
         6BDAwTsujRwCNDQm0+xxwmY74gy0iHg3s6tISuqbiRLLT3WljkbvmB8SXVV6DIaObrf8
         hi/GdL9bSCQd+LuM6eJ8t2N76cRo1pedgCVCEaSrjKIs8r+F8UX19GdSyWAg66jNHtMY
         ESJs9swdUrH6zfCJ597ze48aszldwAk5I/CUq82Vur16Vn2Q2PcZS5KqxEH64QdvrMrs
         /+7A==
X-Gm-Message-State: AOJu0YwEbxcrAshEP2eWGIrLL3ZaPq4s8UgXQe2sbletUdq+Cz2Y4rRw
	hg3Fr+jtgi9blLrP0B1Ju7EemU09S+0lEuGewP/hyLcDTNJV32vDlhGK
X-Gm-Gg: ASbGncurOPLwbt9BDEJnbSfbq1jrYtabeh/J0MLSPPULY47xmIUVbFXV8tl3kJEU71k
	WrDBfoPTEhXhZnuhGHW9SISm20VxpjdlpCe919wr+vtWOw2VjAocmEnT5kWohhxsucyyFcXK1vD
	JRp4fw/wQD1x8ZfIVms+oypcyt9jSHKcew/ErJ/VqTrNS2tcnKcbhnagkVtFWkoRnXMwK8z55c+
	Ovoy/GeWNfWIhB4rDOxDF0JZSlaqTnGv/GpGRHkEK7qzr3VhJ1kFxMTQqj1L9MtbMx7TTIE8QcD
	0lVRhwju0kGM0LRvvi72FWa/4uv3Gba0SVj70gUd+HYvT9wulZRVIp8nSKa7L19evopHn55rC8A
	z3wUMEQ9R/QfuQ120Isbjyw1SpjSFxXh4S0s6DpEX1FZLowUzzFHI1iA8871wad4HRyz/bXeV17
	ARwtCjtzXs7frnIJgBp6tA
X-Google-Smtp-Source: AGHT+IEir79o7WHjwQ2TjxfXmwzaSItLull/9y6hTIcd86B88GoL6PXdvrfoxNh6nPLTpOY+2dQJFA==
X-Received: by 2002:a05:600c:518f:b0:46e:4a60:ea2c with SMTP id 5b1f17b1804b1-47117925e1dmr142044795e9.37.1761075859707;
        Tue, 21 Oct 2025 12:44:19 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47494aa0336sm24877495e9.1.2025.10.21.12.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 12:44:19 -0700 (PDT)
Date: Tue, 21 Oct 2025 19:50:59 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH v6 bpf-next 12/17] bpf, docs: do not state that indirect
 jumps are not supported
Message-ID: <aPfkI9r6YnS7QNKz@mail.gmail.com>
References: <20251019202145.3944697-1-a.s.protopopov@gmail.com>
 <20251019202145.3944697-13-a.s.protopopov@gmail.com>
 <83225612f07f1d0f2f488efaee9c075b44e8cc03.camel@gmail.com>
 <aPffwozAdFGGgyc3@mail.gmail.com>
 <0c18d017a9faeef2dfdf970683b0fe7b9d63faa1.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c18d017a9faeef2dfdf970683b0fe7b9d63faa1.camel@gmail.com>

On 25/10/21 12:36PM, Eduard Zingerman wrote:
> On Tue, 2025-10-21 at 19:32 +0000, Anton Protopopov wrote:
> > On 25/10/21 12:15PM, Eduard Zingerman wrote:
> > > On Sun, 2025-10-19 at 20:21 +0000, Anton Protopopov wrote:
> > > > The linux-notes.rst states that indirect jump instruction "is not
> > > > currently supported by the verifier". Remove this part as outdated.
> > > > 
> > > > Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> > > > ---
> > > >  Documentation/bpf/linux-notes.rst | 8 --------
> > > >  1 file changed, 8 deletions(-)
> > > > 
> > > > diff --git a/Documentation/bpf/linux-notes.rst b/Documentation/bpf/linux-notes.rst
> > > > index 00d2693de025..64ac146a926f 100644
> > > > --- a/Documentation/bpf/linux-notes.rst
> > > > +++ b/Documentation/bpf/linux-notes.rst
> > > > @@ -12,14 +12,6 @@ Byte swap instructions
> > > >  
> > > >  ``BPF_FROM_LE`` and ``BPF_FROM_BE`` exist as aliases for ``BPF_TO_LE`` and ``BPF_TO_BE`` respectively.
> > > >  
> > > > -Jump instructions
> > > > -=================
> > > > -
> > > > -``BPF_CALL | BPF_X | BPF_JMP`` (0x8d), where the helper function
> > > > -integer would be read from a specified register, is not currently supported
> > > > -by the verifier.  Any programs with this instruction will fail to load
> > > > -until such support is added.
> > > > -
> > > >  Maps
> > > >  ====
> > > >  
> > > 
> > > Nit: bpf/standardization/instruction-set.rst needs an update,
> > >      we don't have anything about `JA|X|JMP` in the "Jump instructions"
> > >      section there.
> > 
> > Ah yes, thanks.
> > 
> > Also, there is a limitation listed in the llvm doc that -O0
> > can't be used due to absence of indirect jumps. I wonder if
> > there should be more limitations introduced since the doc
> > was written. (I've tried, briefly, to compile selftests with -O0,
> > but this fails for other reasons, and I didn't have time to dig
> > into this.)
> 
> Lets fill this section as we go.
> From the top of my head, I can't say what will or will not happen to
> verifier if O0 is used. Things that don't happen at O0 include:
> - SROA (variables are always on stack);
> - constant propagation;
> - inlining;
> - loop unrolling.
> 
> In theory, none of that should confuse verifier in its current state.
> But I'm sure there are special cases.

Stack was the first thing I've bumped into:

    progs/bpf_arena_spin_lock.h:164:12: error: Looks like the BPF stack limit is exceeded. Please move large on stack variables into BPF per-cpu array map. For non-kernel uses, the stack can be
          increased using -mllvm -bpf-stack-size.

      164 |         } while (!atomic_try_cmpxchg_relaxed(&lock->val, &old, new));
          |                   ^

But then also some things, say

    tools/testing/selftests/bpf/tools/include/bpf/bpf_helpers.h:169:15: error: invalid operand for inline asm constraint 'i'
      169 |         asm volatile("r1 = %[ctx]\n\t"
          |                      ^
                                 "r2 = %[map]\n\t"
                                 "r3 = %[slot]\n\t"
                                 "call 12"
                                 :: [ctx]"r"(ctx), [map]"r"(map), [slot]"i"(slot)
                                 : "r0", "r1", "r2", "r3", "r4", "r5");

