Return-Path: <bpf+bounces-36489-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FBBA949828
	for <lists+bpf@lfdr.de>; Tue,  6 Aug 2024 21:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B3A2B21A1E
	for <lists+bpf@lfdr.de>; Tue,  6 Aug 2024 19:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA2813C677;
	Tue,  6 Aug 2024 19:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hUyFUZoY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D05F7BB17
	for <bpf@vger.kernel.org>; Tue,  6 Aug 2024 19:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722972164; cv=none; b=VARwJjMkd4dTBEltCRGYcLV/8SZ3ZJAEqtpKjOheuRQIrfPxtDzVStZOQDrNFvT+XQ5eGhWla8nIXotdl66zhYG0lESJAEuIKDvhJt6I3S9uIn2fc1LJ9vbP9OrvuYQEmnE+Iwz0gQLMXuQsigPSuwow6/p35vArc1VMAYuT/hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722972164; c=relaxed/simple;
	bh=MvwWEAcM/1EyrJjuVAEexGviUBsU21ZpX9Xj7G8WnFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Er1tB4vIz5u3TLE24nUxn5lDKayzhbnCBNBGCQWCdvxwYK+wkDjJo02k5qq886UYU1zyLihPKlpDNYtK7cHE76tGlYOEIPMtSEhpIxi8REknTVz+qBUyAO0eQd2e1+9asDGJVIV0SC4kfJSRiBNII9ZmpfWUozVpS5RMvQELrHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hUyFUZoY; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7b8b1743a01so404224a12.0
        for <bpf@vger.kernel.org>; Tue, 06 Aug 2024 12:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722972162; x=1723576962; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hKEoULWi/RXWntaEjUnq9SCItQVYPFNbAJyes5cQFUw=;
        b=hUyFUZoY36aEs2/dswyWu89jWkib5J/tGgbmuwpHlN47zbDnllwkfVXGLXveNImg7i
         gmjwPCmGv2FNPCmCxe4Jncciczyf/vGR0GLVJpuzHzDYa3epG77hpCRw3Y6ImLcB+QAE
         +RaIly9GNpnEj4ok7mqfVeE7z4clZJuPGN9EuHzrhIj22piVuzipbtHFQfpoOcGqCCgv
         LIDtu9dl6TwUYo0QZXq7MyBxhsTG2tSZQCuxfMLATcKuDsXpSf4BKz87JM8DGtPIwFCk
         SqSiOzhXLvQMkZZTBTF/1psX0rgbYLazeodS+Rpxs4zBW/1vEuiWCuGsaxXjvkx10zsN
         Q8cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722972162; x=1723576962;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hKEoULWi/RXWntaEjUnq9SCItQVYPFNbAJyes5cQFUw=;
        b=Btp0ZK66fTPiZVysYLYeaccNyyF9Lc1KNIZCdN5Et6oJ+b/1zmITDy5W3WuxyvSzK4
         1f9OlwBCiaOxu2ES/M2gxVMJNxS5U6HaQPG96tj0r/gOiaqVr+NayenvzzZY74XStMJ4
         tM5W/ZlGbpCkFQNtT14PQhqFiTLOe9jxg8urric22IQrAMK3NDk1VVFgdMxc+Sk7lydk
         YwvixB2dbnAOynWj1ZKUVmSxBhGyucQ16tXfwII3J/yFtU1M8TajZ3/zoMKAlMrB11yr
         ryncjTn6kv6vNFSJldY5C6uupY5ao6qvRUnqjy0RdpIYMyu0c768aNKRBqABZgjUn7OF
         uSpg==
X-Forwarded-Encrypted: i=1; AJvYcCW3iizTO0JTVIaw5W5F4mJNmzzVZd+KpGg52w4y287M6XoSbDnIJ1zBNnJUX9asPF+pd5SvJEj0LAjtUYbx/gYGjYPM
X-Gm-Message-State: AOJu0YxbBgKant/Pw1aeI6lvJTVXVNlwd5zxQm7GgLvoE3OCvsuWcmY1
	9Rjt1zLNQM/AzIH/6hpFYeiqmzoBs8Bi22aoFHgQkXOlC3DHNkHJSwJ9Xj4sUw==
X-Google-Smtp-Source: AGHT+IHjM2JigzPIK3uw3SeEP2R7i6ejMiocT3/IKPFXz6qWvI5ZjAqqgA+dTuqIvXY/Qb44Ztb29A==
X-Received: by 2002:a05:6a20:72a1:b0:1c0:e77b:d37 with SMTP id adf61e73a8af0-1c6995286c1mr17824929637.9.1722972162109;
        Tue, 06 Aug 2024 12:22:42 -0700 (PDT)
Received: from google.com (201.204.125.34.bc.googleusercontent.com. [34.125.204.201])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ec410c2sm7262124b3a.57.2024.08.06.12.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 12:22:41 -0700 (PDT)
Date: Tue, 6 Aug 2024 19:22:37 +0000
From: Peilin Ye <yepeilin@google.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>,
	"Jose E. Marchesi" <jemarch@gnu.org>, bpf <bpf@vger.kernel.org>,
	Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>,
	Neel Natu <neelnatu@google.com>,
	Benjamin Segall <bsegall@google.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	David Vernet <dvernet@meta.com>,
	Dave Marchevsky <davemarchevsky@meta.com>
Subject: Re: Supporting New Memory Barrier Types in BPF
Message-ID: <ZrJ3_esc7nBb6k9_@google.com>
References: <20240729183246.4110549-1-yepeilin@google.com>
 <CAADnVQJqGzH+iT9M8ajT62H9+kAw1RXAdB42G3pvcLKPVmy8tg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJqGzH+iT9M8ajT62H9+kAw1RXAdB42G3pvcLKPVmy8tg@mail.gmail.com>

Hi Alexei,

Thanks for all the suggestions!  Some questions:

On Mon, Jul 29, 2024 at 06:28:16PM -0700, Alexei Starovoitov wrote:
> On Mon, Jul 29, 2024 at 11:33 AM Peilin Ye <yepeilin@google.com> wrote:
> > We need more.  During offline discussion with Paul, we agreed we can start
> > from:
> >
> >   * load-acquire: __atomic_load_n(... memorder=__ATOMIC_ACQUIRE);
> >   * store-release: __atomic_store_n(... memorder=__ATOMIC_RELEASE);
> 
> we would need inline asm equivalent too. Similar to kernel
> smp_load_acquire() macro.

I see, so something like:

    asm volatile("%0 = load_acquire((u64 *)(%1 + 0x0))" :
                 "=r"(ret) : "r"(&foo) : "memory");

and e.g. this in disassembly:

    r0 = load_acquire((u64 *)(r1 + 0x0))

I agree that we'd better not put the entire e.g.
"r0 = __atomic_load_n((u64 *)(r1 + 0x0), __ATOMIC_ACQUIRE)" into
disassembly.

> > Theoretically, the BPF JIT compiler could also reorder instructions just like
> > Clang or GCC, though it might not currently do so.  If we ever developed a more
> > optimizing BPF JIT compiler, it would also be nice to have an optimization
> > barrier for it.  However, Alexei Starovoitov has expressed that defining a BPF
> > instruction with 'asm volatile ("" ::: "memory");' semantics might be tricky.
> 
> It can be a standalone insn that is a compiler barrier only but that feels like
> a waste of an instruction. So depending how we end up encoding various
> real barriers
> there may be a bit to spend in such a barrier insn that is only a
> compiler barrier.
> In this case optimizing JIT barrier.

[...]

> > Roughly, the scope of this work includes:
> >
> >   * decide how to extend the BPF ISA (add new instructions and/or extend
> >     current ones)
> 
> ldx/stx insns support MEM and MEMSX modifiers.
> Adding MEM_ACQ_REL feels like a natural fit. Better name?

Do we allow aliases?  E.g., can we have "MEMACQ" for LDX and "MEMREL"
for STX, but let them share the same numeric value?

Speaking of numeric value, out of curiosity:

    IMM    0
    ABS    1
    IND    2
    MEM    3
    MEMSX  4
    ATOMIC 6

Was there a reason that we skipped 5?  Is 5 reserved?

> For barriers we would need a new insn. Not sure which class would fit the best.
> Maybe BPF_LD ?
> 
> Another alternative for barriers is to use nocsr kfuncs.
> Then we have the freedom to make mistakes and fix them later.
> One kfunc per barrier would do.
> JITs would inline them into appropriate insns.
> In bpf progs they will be used just like in the kernel code smp_mb(),
> smp_rmb(), etc.
> 
> I don't think compilers have to emit barriers from C code, so my
> preference is kfuncs atm.

Ah, I see; we recently supported [1] nocsr BPF helper functions.  The
cover letter says:

  """
  This patch-set seeks to allow using no_caller_saved_registers
  gcc/clang attribute with some BPF helper functions (and kfuncs in the
  future).
  """

It seems that nocsr BPF kfuncs are not supported yet.  Do we have a
schedule for it?

Thanks,
Peilin Ye

[1] [PATCH bpf-next v4 00/10] no_caller_saved_registers attribute for helper calls
    https://lore.kernel.org/bpf/20240722233844.1406874-1-eddyz87@gmail.com/


