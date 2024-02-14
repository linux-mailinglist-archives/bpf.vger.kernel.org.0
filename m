Return-Path: <bpf+bounces-21994-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F195F854F03
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 17:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 636A2281E55
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 16:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0B7604A4;
	Wed, 14 Feb 2024 16:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AUHYlxxz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FA35D49C
	for <bpf@vger.kernel.org>; Wed, 14 Feb 2024 16:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707929261; cv=none; b=mvAZrfRzUYZs2ioy6VYpr5IvmGhE2HulYgLo0NMcoYDXf4ryrgZd8OtaCaYlfra9t3OtzBEQ8pVwRA3VeRBmQgFiK+L782cpeEN3wJ3qGxO7YG6isIx6/ZfGo54ypQ8R77eRr/yNpKj2xDk5tSn2tRvlxJwiELrVBMO5dnYednA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707929261; c=relaxed/simple;
	bh=CUYSjD28hIgnyPKwjnomZz92GJXqP1ETnlE5Ufe592I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AOJOt4VpisM69jRUzoT/1ZsMi6TPeefCoBJIk/1t4ZI03AOSwXDIO1i9Tox2RN9fKIuq9ncaYJV2KwzXp5wKb3vP3rtQ32l7YOKQDgQS4EBfgy18haVnPuS17PgQrVm0zhd0wqOTxOZDTMcdqZfeKJQaFER8LXNwoiDNeSCNctk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AUHYlxxz; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a3cc2f9621aso255486066b.1
        for <bpf@vger.kernel.org>; Wed, 14 Feb 2024 08:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707929258; x=1708534058; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=H8S0aZ7m3AZ1Bg6wTpUAa+vASF6aVcAUXwMA7Rr53/M=;
        b=AUHYlxxzbMJLkQ220WS3J7RNv8FcXVy25Rm92xQFetIPS6ohuDMgaAnjHXbeNmjv5E
         tXm2A1VigC5HAkM0AzVdSgxuDkIOeC+FFZ58mkr1ffXPcElxASRqR0gQIfNAxAFKVyq9
         X1QI1BBmyKSjqg9+jvT0BWHpVJfnuOLeT47BQTvGuNKjyWNMf9EE6bO/Pw1OH5pS2x02
         moD3yjDYm84CtzOwB4t+l6dT2sTXJAtPPgWPijKyHJuvxIIhHC3EDNzcxgk+00cmG0tD
         0W3B18liMgb4FGpJhlXCrjrj9DHbNV9MuEtId9NAmK/Qcwl08jkg2cuSDVUAmIEMHY7I
         5s1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707929258; x=1708534058;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H8S0aZ7m3AZ1Bg6wTpUAa+vASF6aVcAUXwMA7Rr53/M=;
        b=q5o3rbMynrNABAu9dvGbdF9Lj199UAThQOI6ROBRJ2WlIB8mzjX1GVxaGclXv/FotW
         K/un8zUKLGB5tlv2QvnlGS0dXE2xlxpc8zYrUENV3K4z+bZWofvth48MCOZpS3eUHYfc
         lN1Z4UvKGc7RPxsZqgoybIKIX8v6WN6QyRn7fW3J0D2jnFjJiwQXtqfholRDAqoLwPmV
         7Y6raF6LjGYDTD0bvTk1rrb7feewh9Tvso9HoeeXxQLB05KFCRDkyp5PZtBxSJsaLExo
         M1ZIlWgxMRsQYhFOdXzq+Grjjr6tjyUeSq7UI39uNTZHxhbKxNyU03r1vy3n8RWazjuV
         +/ng==
X-Gm-Message-State: AOJu0YzOJaHAxq2FS9RmV7Up+jQQL8KgMTgMZaILjgenl5A9SXdtVfLe
	bXWwRqD1hvfz8/3m5yud3gOUF0peF2ReDLjJvoTtK+qwwwmlFwhC
X-Google-Smtp-Source: AGHT+IElKCTod01GfS4G6wCUT1411vNkzeR1DKrixPi2f8MlzihRx/1sj1eFUXvx1IcutXOqujBqow==
X-Received: by 2002:a17:906:e0ce:b0:a3c:a65:7bd8 with SMTP id gl14-20020a170906e0ce00b00a3c0a657bd8mr2196420ejb.24.1707929258166;
        Wed, 14 Feb 2024 08:47:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUAsr4yTD8iGtwUj94aSBxWxH40jBcxHbrUSbsF6amB710cZuu/fbB64GLIGAfJkkCLes0kpuzdfCUyvZcvNdUvQ5fYpi7Kp0T8C5jmY30Opqpu63YB3K/K2KpbHvN5K90+7LWSF0z+lGxzlTivKE3RyM4aMzw7yUzlx5DfAUqE7qfl5zskmrP1IVTrvVpzTqtMZd7putFRX/ZB8ajz9F5YLqjMZNFFOlxSlpy/TQGyYgxCDu/QR7HPaR+y26KCMqb5B86fywjfzd8O7RIgfkzBUEXNeEXroXvHwil4DQkRCBPfgI32anlcu6hsaoHTypqdIUtvYcT+mtKxA6q52B2v7InWlCPif/jzzdRjsl0neinoXI+yg20WbA==
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id lg25-20020a170907181900b00a3d4b1c13bcsm694033ejc.162.2024.02.14.08.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 08:47:37 -0800 (PST)
Message-ID: <86d1f3c1483d07815ad1dd542abf6038da1da24a.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 16/20] bpf: Add helper macro bpf_arena_cast()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Kumar Kartikeya
	Dwivedi <memxor@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, Tejun Heo <tj@kernel.org>, Barret
 Rhoden <brho@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Lorenzo
 Stoakes <lstoakes@gmail.com>, Andrew Morton <akpm@linux-foundation.org>,
 Uladzislau Rezki <urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>,
 linux-mm <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
Date: Wed, 14 Feb 2024 18:47:36 +0200
In-Reply-To: <CAADnVQ+FMHN9oMd+Tvz_9wonW6JoGgPboLAJ6ysa+26jNK+Mpg@mail.gmail.com>
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
	 <20240209040608.98927-17-alexei.starovoitov@gmail.com>
	 <CAP01T743Mzfi9+2yMjB5+m2jpBLvij_tLyLFptkOpCekUn=soA@mail.gmail.com>
	 <CAADnVQ+FMHN9oMd+Tvz_9wonW6JoGgPboLAJ6ysa+26jNK+Mpg@mail.gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-02-13 at 14:35 -0800, Alexei Starovoitov wrote:
[...]

> This arena bpf_arena_cast() macro probably will be removed
> once llvm 19 is released and we upgrade bpf CI to it.
> It's here for selftests only.
> It's quite tricky and fragile to use in practice.
> Notice it does:
> "r"(__var)
> which is not quite correct,
> since llvm won't recognize it as output that changes __var and
> will use a copy of __var in a different register later.
> But if the macro changes to "=3Dr" or "+r" then llvm allocates
> a register and that screws up codegen even more.
>=20
> The __var;}) also doesn't always work.
> So this macro is not suited for all to use.

Could you please elaborate a bit on why is this macro fragile?
I toyed a bit with a version patched as below and it seems to work fine.
Don't see how  ": [reg]"+r"(var) : ..." could be broken by the compiler
(when "+r" is in the "output constraint" position):
from clang pov the variable 'var' would be in register and updated
after the asm volatile part.

---

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing=
/selftests/bpf/bpf_experimental.h
index e73b7d48439f..488001236506 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -334,8 +334,6 @@ l_true:                                                =
                                             \
 /* emit instruction: rX=3DrX .off =3D mode .imm32 =3D address_space */
 #ifndef bpf_arena_cast
 #define bpf_arena_cast(var, mode, addr_space)  \
-       ({                                      \
-       typeof(var) __var =3D var;                \
        asm volatile(".byte 0xBF;               \
                     .ifc %[reg], r0;           \
                     .byte 0x00;                \
@@ -368,8 +366,7 @@ l_true:                                                =
                                             \
                     .byte 0x99;                \
                     .endif;                    \
                     .short %[off]; .long %[as]"        \
-                    :: [reg]"r"(__var), [off]"i"(mode), [as]"i"(addr_space=
)); __var; \
-       })
+                    : [reg]"+r"(var) : [off]"i"(mode), [as]"i"(addr_space)=
)
 #endif

