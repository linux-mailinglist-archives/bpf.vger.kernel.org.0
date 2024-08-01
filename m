Return-Path: <bpf+bounces-36242-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1B9945461
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 00:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E11351F244AA
	for <lists+bpf@lfdr.de>; Thu,  1 Aug 2024 22:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9888314BFA8;
	Thu,  1 Aug 2024 22:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VEXG3QZQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17D014B94E
	for <bpf@vger.kernel.org>; Thu,  1 Aug 2024 22:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722549611; cv=none; b=Un2n1HzMu74gxqnDPgZvp7WKf1OFw6Kmcjg8+8iOSF2NoNKqLXjS2yYZiV0h1fnlQJAP7rZEPVeZQ1gmhrcZSwcJJZ3Un1270TB9MJDst98ZoICaqqr9r4rvLhTyZfAyUkXYeZgF86CiNdn+je84tfDUFHJZMDwNiNfmGDiYz9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722549611; c=relaxed/simple;
	bh=vZNCKV/dTMoz1p0DID8yh5N9mw1vzi12mSfN2R2Ax1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EV06zPPGv8an9OOs6u+xT67OKzJXmPKW20NvZaGOAlDE/69OTQZba2QAWPUu877tsg+ZHDUNAvmBJVH75tcjtfCQ0tbCx5EgFns0/rib6yWrFiDIIvXQZnZ7MbuaNWRtamKbwXIMVYMGVh5jHzQJe1ODhl9ZhdHjrHQvtKCPous=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VEXG3QZQ; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-70d1fb6c108so5525072b3a.3
        for <bpf@vger.kernel.org>; Thu, 01 Aug 2024 15:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722549609; x=1723154409; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wkYBuXLS9z1sa/Ae/3t/8L9FWNMPgG5lIowavHpE/xs=;
        b=VEXG3QZQzB3HFb9yDm+nvZRBGgGKOlt4SHltMNeSOkhv1lWEoW2DnX9nphjRtSBrNM
         Rlw1s0d9EUrcTLX/vxDTTfca9t4aJz62crf6N7xEQCftxAVTQ12a5xvnrA6PD1tkAfEU
         /7EBF5c5WrIFvzuyOqYdtjNCd+fKLwCTdixnKD+dPYpPV8jHkzmHMgLvHXY5W5IYBf7o
         RQE+nyu0KcBl8ALLRwfSo/BNuQM1Cd7BXqciymDQkZA3l+k0TSnSwvKx+FLeXzCtKEo9
         B1jWAPlYsDBSjKDUnEgxhQ/S2Kwr8COYJjyYDFGEhQ/s8Z9trnfZ4SPye5d9IPAR9jd7
         eUFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722549609; x=1723154409;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wkYBuXLS9z1sa/Ae/3t/8L9FWNMPgG5lIowavHpE/xs=;
        b=M4v3zW5dWKGIe+4OTKNous5kZJrdtoo7KUu1vQj3gRMj2JQ7yrAVoGhnjr/C3EMKn3
         UD1JizwlXFVekdOJEnscBWlv4bMRonW+VaGOJHTpWh39wDEQBKX8u/YJF7l+Mav8JqDO
         mJFTe3IjPPw4KE2a4kWhKmVNOjkiP4AcG+yx+2Cg/ruPYGFp3706B43rlHIXGXYbCSai
         ctIqlAytKnJVpwnN5i4cUVnPxfKTIvvcodBi5rzgItWEnUUtm66yT4jSYgSUogpBxLnr
         ZtJcaDoA55wf7M+A7hzijTwNcsUnv67u8ByQYrUXoVOcjYTBhHbrXuJhFrD4F1TP5Hbg
         BS0g==
X-Forwarded-Encrypted: i=1; AJvYcCUtGpYGlGfah/47LBE/J1tQ9VYuYDi2nWfiW3p+nB82lElPintifkgiIxxVmGlojgXd5RwrBpUTFwqJp9sSES5pfcWd
X-Gm-Message-State: AOJu0YwGEYMaoBcFRca0cSo50EWy+kIQlqiWy7qD+A6s8yZXbSuy0Ztz
	S+Q/wfI+bEJKBH0v83tVcsdm0wIZpIcXp4qO9eyXmwZsZkKlclI7AvR3Hnd5iB+QEdQ1TZdX3a0
	oaRug
X-Google-Smtp-Source: AGHT+IHwiGyfyymVNBZR1ofQjHbwVTMsuD4tbxxZ4ZQascxUwCYhgzc1narW39/+JWXyv2cq7TiL/Q==
X-Received: by 2002:a05:6a00:9460:b0:70b:1dcc:e5d0 with SMTP id d2e1a72fcca58-7106d09d807mr1544397b3a.30.1722549608446;
        Thu, 01 Aug 2024 15:00:08 -0700 (PDT)
Received: from google.com (217.108.125.34.bc.googleusercontent.com. [34.125.108.217])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ece0b36sm281033b3a.112.2024.08.01.15.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 15:00:08 -0700 (PDT)
Date: Thu, 1 Aug 2024 22:00:04 +0000
From: Peilin Ye <yepeilin@google.com>
To: "Jose E. Marchesi" <jemarch@gnu.org>
Cc: Yonghong Song <yonghong.song@linux.dev>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	bpf <bpf@vger.kernel.org>, Josh Don <joshdon@google.com>,
	Barret Rhoden <brho@google.com>, Neel Natu <neelnatu@google.com>,
	Benjamin Segall <bsegall@google.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	David Vernet <dvernet@meta.com>,
	Dave Marchevsky <davemarchevsky@meta.com>
Subject: Re: Supporting New Memory Barrier Types in BPF
Message-ID: <ZqwFZFbWxSNEUHfp@google.com>
References: <20240729183246.4110549-1-yepeilin@google.com>
 <CAADnVQJqGzH+iT9M8ajT62H9+kAw1RXAdB42G3pvcLKPVmy8tg@mail.gmail.com>
 <24b57380-c829-4033-a7b1-06a4ed413a49@linux.dev>
 <87h6c4h0ju.fsf@gnu.org>
 <87v80kfhox.fsf@gnu.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v80kfhox.fsf@gnu.org>

Hi Jose,

On Thu, Aug 01, 2024 at 04:20:30PM +0200, Jose E. Marchesi wrote:
> > GCC behaves similarly.
> >
> > For program A:
> >
> >   long foo;
> >   
> >   long func () {
> >         return __sync_fetch_and_add(&foo, 1);
> >   }
> >
> > bpf-unknown-none-gcc -O2 compiles to:
> >
> >   0000000000000000 <func>:
> >      0:	18 00 00 00 00 00 00 00 	r0=0 ll
> >      8:	00 00 00 00 00 00 00 00 
> >     10:	b7 01 00 00 01 00 00 00 	r1=1
> >     18:	db 10 00 00 01 00 00 00 	r1=atomic_fetch_add((u64*)(r0+0),r1)
> >     20:	bf 10 00 00 00 00 00 00 	r0=r1
> >     28:	95 00 00 00 00 00 00 00 	exit
> >
> > And for program B:
> >
> >   long foo;
> >   
> >   long func () {
> >        __sync_fetch_and_add(&foo, 1);
> >         return foo;
> >   }
> >
> > bpf-unknown-none-gcc -O2 compiles to:
> >
> >   0000000000000000 <func>:
> >      0:	18 00 00 00 00 00 00 00 	r0=0 ll
> >      8:	00 00 00 00 00 00 00 00 
> >     10:	b7 01 00 00 01 00 00 00 	r1=1
> >     18:	db 10 00 00 00 00 00 00 	lock *(u64*)(r0+0)+=r1
> >     20:	79 00 00 00 00 00 00 00 	r0=*(u64*)(r0+0)
> >     28:	95 00 00 00 00 00 00 00 	exit
> >
> > Internally:
> >
> > - When compiling the program A GCC decides to emit an
> >   `atomic_fetch_addDI' insn, documented as:
> >
> >   'atomic_fetch_addMODE', 'atomic_fetch_subMODE'
> >   'atomic_fetch_orMODE', 'atomic_fetch_andMODE'
> >   'atomic_fetch_xorMODE', 'atomic_fetch_nandMODE'
> >
> >      These patterns emit code for an atomic operation on memory with
> >      memory model semantics, and return the original value.  Operand 0
> >      is an output operand which contains the value of the memory
> >      location before the operation was performed.  Operand 1 is the
> >      memory on which the atomic operation is performed.  Operand 2 is
> >      the second operand to the binary operator.  Operand 3 is the memory
> >      model to be used by the operation.
> >
> >   The BPF backend defines atomic_fetch_add for DI modes (long) to expand
> >   to this BPF instruction:
> >
> >       %w0 = atomic_fetch_add((<smop> *)%1, %w0)
> >
> > - When compiling the program B GCC decides to emit an `atomic_addDI'
> >   insn, documented as:
> >
> >   'atomic_addMODE', 'atomic_subMODE'
> >   'atomic_orMODE', 'atomic_andMODE'
> >   'atomic_xorMODE', 'atomic_nandMODE'
> >
> >      These patterns emit code for an atomic operation on memory with
> >      memory model semantics.  Operand 0 is the memory on which the
> >      atomic operation is performed.  Operand 1 is the second operand to
> >      the binary operator.  Operand 2 is the memory model to be used by
> >      the operation.
> >
> >   The BPF backend defines atomic_fetch_add for DI modes (long) to expand
> >   to this BPF instruction:
> >
> >       lock *(<smop> *)%w0 += %w1
> >
> > This is done for all targets. In x86-64, for example, case A compiles
> > to:
> >
> >   0000000000000000 <func>:
> >      0:	b8 01 00 00 00       	mov    $0x1,%eax
> >      5:	f0 48 0f c1 05 00 00 	lock xadd %rax,0x0(%rip)        # e <func+0xe>
> >      c:	00 00 
> >      e:	c3                   	retq   
> >
> > And case B compiles to:
> >
> >   0000000000000000 <func>:
> >      0:	f0 48 83 05 00 00 00 	lock addq $0x1,0x0(%rip)        # 9 <func+0x9>
> >      7:	00 01 
> >      9:	48 8b 05 00 00 00 00 	mov    0x0(%rip),%rax        # 10 <func+0x10>
> >     10:	c3                   	retq   
> >
> > Why wouldn't the compiler be allowed to optimize from atomic_fetch_add
> > to atomic_add in this case?
> 
> Ok I see.  The generic compiler optimization is ok.  It is the backend
> that is buggy because it emits BPF instruction sequences with different
> memory ordering semantics for atomic_OP and atomic_fetch_OP.
> 
> The only difference between fetching and non-fetching builtins is that
> in one case the original value is returned, in the other the new value.
> Other than that they should be equivalent.
> 
> For ARM64, GCC generates for case A:
> 
>   0000000000000000 <func>:
>      0:	90000001 	adrp	x1, 0 <func>
>      4:	d2800020 	mov	x0, #0x1                   	// #1
>      8:	91000021 	add	x1, x1, #0x0
>      c:	f8e00020 	ldaddal	x0, x0, [x1]
>     10:	d65f03c0 	ret
> 
> And this for case B:
> 
>   0000000000000000 <func>:
>      0:	90000000 	adrp	x0, 0 <func>
>      4:	d2800022 	mov	x2, #0x1                   	// #1
>      8:	91000001 	add	x1, x0, #0x0
>      c:	f8e20021 	ldaddal	x2, x1, [x1]
>     10:	f9400000 	ldr	x0, [x0]
>     14:	d65f03c0 	ret
> 
> i.e. GCC emits LDADDAL for both atomic_add and atomic_fetch_add internal
> insns.  Like in x86-64, both sequences have same memory ordering
> semantics.
> 
> Allright we are changing GCC to always emit fetch versions of sequences
> for all the supported atomic operations: add, and, or, xor.  After the
> change the `lock' versions of the instructions will not be generated by
> the compiler at all out of inline asm.
> 
> Will send a headsup when done.

Thanks for taking care of this!

Peilin Ye


