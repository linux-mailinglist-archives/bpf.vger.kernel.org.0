Return-Path: <bpf+bounces-19368-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D6582B344
	for <lists+bpf@lfdr.de>; Thu, 11 Jan 2024 17:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C92C1C268CB
	for <lists+bpf@lfdr.de>; Thu, 11 Jan 2024 16:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38AF351C52;
	Thu, 11 Jan 2024 16:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CwXUU9WS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353E24EB28
	for <bpf@vger.kernel.org>; Thu, 11 Jan 2024 16:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a2814fa68eeso466293866b.1
        for <bpf@vger.kernel.org>; Thu, 11 Jan 2024 08:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704991563; x=1705596363; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=50Unev01jz67O8IRoUbk7sWbN7KtHB2mRf9sqWTfgMw=;
        b=CwXUU9WS1ezforDwtGeggar+lPSYmq/aHTki9/cOVFEKw+gpsnbogaiMPbfzdMd1JW
         cLbk7xb/scysq1yV6dw9lut89lwipE3QjyLP252SJX4o4TJV3XgculmO2KYyyeu+pAq7
         Ouvzidy6mG+lFjy/R020d5QzH5dsMvdpVt3wUrHqqJHaj3TqtrQr804SIKCJZKbIL/wT
         Gsg4t7aUxcq1w6zFWILfzvl3NsGfNGnCGo7jHnfk/QILKYYRzZpGWT2gOjUIZNJl/yOk
         2WheXOBtobJfOI6GUElt0HnoVoyTWnzKQX6S19eynRl0j+auhg4pCqKjefOTmYlO8R+e
         9auw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704991563; x=1705596363;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=50Unev01jz67O8IRoUbk7sWbN7KtHB2mRf9sqWTfgMw=;
        b=PJPONzG98v/cONlXbMKREoYT1Y6i7qnV3UtS16Bo50dYV0QQOHhpnV7IXH/Eb9dPQ2
         3JOo0SEnq1QIGvDuzGinRZwrgxHzXHMK03NvesIVm6/sjc+BFJ9DqvAkwlPYtGc44+oV
         1oRnwApsZgx53YdZu/vr2J5tGAJg/wfdesXlWNJ4qj7yvt/4casJCMEcPmXUwf/S5/yH
         qyjC0cYb9cmycnaBArO8bkDza942g1ZeZYMIuDpevqG+bQLwJIc1hnT8HBaRhYjSXpzJ
         uAo+lMLRJmtI7wlK0wdfBfeDHwxz81SPzn0xd1NDGB/Gqjfdx7v82AujVDndD9LrPSG9
         Z8YA==
X-Gm-Message-State: AOJu0YzIFWafTASooJh77v6BgKf5dnpZoJCtAi2mQF8qb1CU6kQGMrAn
	OMfnMcQCWQ4Gyje3JAR6RMQ=
X-Google-Smtp-Source: AGHT+IFwyIEhcgCShASQoz7jB753dQQ3SkQMTJDCZpxUbzdzJ9yGfCYEYUujNkzAlCy86ZX3XPKTmw==
X-Received: by 2002:a17:906:488e:b0:a26:4625:eeb4 with SMTP id v14-20020a170906488e00b00a264625eeb4mr815587ejq.51.1704991563386;
        Thu, 11 Jan 2024 08:46:03 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id i13-20020a170906090d00b00a2c11a438a8sm776178ejd.25.2024.01.11.08.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 08:46:02 -0800 (PST)
Message-ID: <fb2f414525573af672e67c51ff18b4725fc9ba64.camel@gmail.com>
Subject: Re: asm register constraint. Was: [PATCH v2 bpf-next 2/5] bpf:
 Introduce "volatile compare" macro
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, "Jose E. Marchesi"
	 <jemarch@gnu.org>, "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Yonghong Song
 <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, Andrii
 Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>,
 Daniel Xu <dxu@dxuuu.xyz>,  John Fastabend <john.fastabend@gmail.com>, bpf
 <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
Date: Thu, 11 Jan 2024 18:46:01 +0200
In-Reply-To: <CAADnVQLmXxn9RrniktuW80XO14oyOmgJ_NboBBC_-CU4O=-v9g@mail.gmail.com>
References: <20231221033854.38397-1-alexei.starovoitov@gmail.com>
	 <20231221033854.38397-3-alexei.starovoitov@gmail.com>
	 <CAP01T77fbW-9N+Z-2LFS=174HN6v_OJAbR_s6EOfLLW8Oceh_g@mail.gmail.com>
	 <CAADnVQKY4hB4quJX_oyq4GULEJkehXWx6uW1nAYHveyvdyG8sw@mail.gmail.com>
	 <CAADnVQ+tYBpt_aRG5aU3sAYEysKxUOKQ24dBG4bP2kLy8nmmgA@mail.gmail.com>
	 <44a9223b6638673487850eb9d70cc01ef58e9d93.camel@gmail.com>
	 <CAADnVQLmXxn9RrniktuW80XO14oyOmgJ_NboBBC_-CU4O=-v9g@mail.gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-01-08 at 13:33 -0800, Alexei Starovoitov wrote:
[...]

> Agree that llvm fix [6] is a necessary step, then
> using 'w' in v3/v4 and warn on v1/v2 makes sense too,
> but we have this macro:
> #define barrier_var(var) asm volatile("" : "+r"(var))
> that is used in various bpf production programs.
> tetragon is also a heavy user of inline asm.

I have an llvm version [1] that implements 32-bit/64-bit register
selection and it indeed breaks some code when tested on BPF selftests.
The main pain point is that code base is compiled both with and
without ALU32, so 'r' constraint cannot be used with 'int'
(and constants are 'int' by default), hence the fixes like:

        size_t off =3D (size_t)buf->head;
-       asm("%0 -=3D %1" : "+r"(off) : "r"(buf->skb->data));
+       asm("%0 -=3D %1" : "+r"(off) : "r"((__u64)buf->skb->data));
        return off;

or

 #ifndef bpf_nop_mov
 #define bpf_nop_mov(var) \
-       asm volatile("%[reg]=3D%[reg]"::[reg]"r"((short)var))
+       asm volatile("%[reg]=3D%[reg]"::[reg]"r"((unsigned long)var))
 #endif

or

        int save_syn =3D 1;
        int rv =3D -1;
        int v =3D 0;
-       int op;
+       long op;
        ...
        asm volatile (
            "%[op] =3D *(u32 *)(%[skops] +96)"
            : [op] "+r"(op)
            : [skops] "r"(skops)
            :);

[1] https://github.com/eddyz87/llvm-project/tree/bpf-inline-asm-polymorphic=
-r

Need a bit more time to share the branch with updates for selftests.

> And, the most importantly, we need a way to go back to old behavior,
> since u32 var; asm("...":: "r"(var)); will now
> allocate "w" register or warn.
>
> What should be the workaround?

The u64 cast is the workaround.

> I've tried:
> u32 var; asm("...":: "r"((u64)var));
>
> https://godbolt.org/z/n4ejvWj7v
>
> and x86/arm64 generate 32-bit truction.
> Sounds like the bpf backend has to do it as well.

Here is godbolt output:

    callq   bar()@PLT
    movl    %eax, %eax ; <-- (u64)var is translated as zero extension
    movq    %rax, %rax ; <-- inline asm block uses 64-bit register

Here is LLVM IR for this example before code generation:

    %call =3D tail call i64 @bar() #2
    %conv1 =3D and i64 %call, 4294967295 ; <------- `(u64)var` translation
    tail call void asm sideeffect "mov $0, $0",
              "r,~{dirflag},~{fpsr},~{flags}"(i64 %conv1) #2
    ret void

> We should be doing 'wX=3DwX' in such case (just like x86)
> instead of <<=3D32 >>=3D32.

Opened pull request for this:
https://github.com/llvm/llvm-project/pull/77501

> We probably need some macro (like we did for __BPF_CPU_VERSION__)
> to identify such fixed llvm, so existing users with '(short)'
> workaround and other tricks can detect new vs old compiler.
>=20
> Looks like we opened a can of worms.
> Aligning with x86/arm64 makes sense, but the cost of doing
> the right thing is hard to estimate.

Indeed.

