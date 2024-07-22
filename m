Return-Path: <bpf+bounces-35208-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BED9D9387B0
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 05:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CF13B20F65
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 03:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADAB414AA9;
	Mon, 22 Jul 2024 03:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L5Z90YwQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BD613FFC
	for <bpf@vger.kernel.org>; Mon, 22 Jul 2024 03:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721619212; cv=none; b=kQPOcV7OWO+4e5sK6eQefjfqdpvBUSbyMlTgc3s8PffaHgkoWOlJRA2NcNN4t/2utnW0p1ggSzy7Y7MZzfx7CM4z5r2FEr7uEBcxTQnTjUIOWbijPpnDxWG4Y4rRErwgXYcwfT+7cE9i8c1WMvPd5yUhBFusPtXqPQDLgApFk6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721619212; c=relaxed/simple;
	bh=HjbEkaDhI3a73beaNs0w8kV6iwuj5Vc5enYP7yR3EwE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D9qs37Jje3ucF4d1Sf4c1bSsJuUq/rnNmQWq7Nvz6tGvGWvzNs9DV3KTaUQi2k1uIkrLLdDjTonf4wUw0ZoXQri4A0EMPSLh+NpnmTMXQgDcvqUpxljDzcg+9GMRXnZpEh4UEYR73GaIkpCLEEHBX8Hkz0NALMZJ702FhAjv1r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L5Z90YwQ; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5d3cf39c239so2085924eaf.1
        for <bpf@vger.kernel.org>; Sun, 21 Jul 2024 20:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721619210; x=1722224010; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2fQ+Rwdj5N8Xcaqe/gJwco8JRsUXj/Rk5cPK+Fku3K4=;
        b=L5Z90YwQcj2hXXBA7XrkeCV4LGo+1CEV7zeE5UXENVQrRPV3H8HWY6JiZq30/00Dls
         abcxm6lNzo9knWxvSmFu+Hhq87VU+ctU/ynCXGEIy4PKNoUkDGP79lgJbOo6nOdQqY27
         02Sw9BmSblVtSLgqlasJgdJbp/D0G36EM4DkbPbdyikW2t1tqj1o9sdORF0x2DBYh9w4
         D5VGPFKAVIXp7pEynm5BmzbQ5BEp3V4ICRvQ5gJW1LlHsIX5xLEMbqIq8qZPAngdu5qo
         XOoNFvB1S2hbhADcbU4wRneB0j+hcfhm6Sh0hf6AXbd5yP3Fx2piVTbt4+Q7EPxHMe4O
         sAZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721619210; x=1722224010;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2fQ+Rwdj5N8Xcaqe/gJwco8JRsUXj/Rk5cPK+Fku3K4=;
        b=GoLh4PidvxDeaJxQWD9rroK5TIRLjsCgXo0UUeg1+UcY4Kv8c8WX/Rn7Lxvh72Xz/b
         qX4/pD4wrgoDGyGUZqp4c5K59DceRSvtgTpNGxbK3SLE4ORevupP7x6chb+4GUsvoHK3
         LFnioG3t8FmHCjaW/G15mQJwE3QzV35o0HbzQKfiaRbmPR7y1XSZYAClV+2tU8CjIE1F
         Udy37V8b3i+g3WxOj1B/BqlVaS+cpJ1uo1lrFBkPmSMw72HFcUkAqa59gnUYkIbT6E1e
         tMQm4pBasWR+h7Jyi7BS1dCVAakw70YM16v+V7Glnq6FSqYkQhVTq4h64ki7AUgFoBdM
         9bwQ==
X-Forwarded-Encrypted: i=1; AJvYcCW590iqK/jLyEcdkSJg3GHANzQm7XX15JPnZC1zFc/9G+zHJ8DQkv1BkT/4LASF1vd3vsfjBnX76ijyGrudxw+EYwNM
X-Gm-Message-State: AOJu0YzIiYCX8D/mcgWIEiwqZLVUXBIv3hoeIEKFkX4u4JlZABh63SQT
	acpWHPxFT1wrbVQKXNKMtSAxwpeFHmKthgfWKvwmCigt+tim/to13QeS4/h0
X-Google-Smtp-Source: AGHT+IGCWFMkxcZ+sWQmQfs+j/xNs7TktFQm7X3+NSJuHSWAOciyOvYr0dqP/4lyCLNPWZhj8YqBJg==
X-Received: by 2002:a05:6359:4c1f:b0:1aa:bc42:eb01 with SMTP id e5c5f4694b2df-1acc5acb2cfmr725954855d.7.1721619209720;
        Sun, 21 Jul 2024 20:33:29 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f31856bsm43614155ad.124.2024.07.21.20.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jul 2024 20:33:29 -0700 (PDT)
Message-ID: <86b7ae7ea24239db646ba6d6b4988b4a5c8b30cd.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Support private stack for bpf progs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
Date: Sun, 21 Jul 2024 20:33:24 -0700
In-Reply-To: <20240718205158.3651529-1-yonghong.song@linux.dev>
References: <20240718205158.3651529-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Yonghong,

In general I think that changes in this patch are logical and make sense.
I have a suggestion regarding testing JIT related changes.

We currently lack a convenient way to verify jit behaviour modulo
runtime tests. I think we should have a capability to write tests like belo=
w:

    SEC("tp")
    __jited_x86("f:	endbr64")
    __jited_x86("13:	movabs $0x.*,%r9")
    __jited_x86("1d:	add    %gs:0x.*,%r9")
    __jited_x86("26:	mov    $0x1,%edi")
    __jited_x86("2b:	mov    %rdi,-0x8(%r9)")
    __jited_x86("2f:	mov    -0x8(%r9),%rdi")
    __jited_x86("33:	xor    %eax,%eax")
    __jited_x86("35:	lock xchg %rax,-0x8(%r9)")
    __jited_x86("3a:	lock xadd %rax,-0x8(%r9)")
    __naked void stack_access_insns(void)
    {
    	asm volatile (
    	"r1 =3D 1;"
    	"*(u64 *)(r10 - 8) =3D r1;"
    	"r1 =3D *(u64 *)(r10 - 8);"
    	"r0 =3D 0;"
    	"r0 =3D xchg_64(r10 - 8, r0);"
    	"r0 =3D atomic_fetch_add((u64 *)(r10 - 8), r0);"
    	"exit;"
    	::: __clobber_all);
    }

In the following branch I explored a way to add such capability:
https://github.com/eddyz87/bpf/tree/yhs-private-stack-plus-jit-testing

Beside testing exact translation, such tests also provide good
starting point for people trying to figure out how some jit features work.

The below two commits are the gist of the feature:
8f9361be2fb3 ("selftests/bpf: __jited_x86 test tag to check x86 assembly af=
ter jit")
0156b148b5b4 ("selftests/bpf: utility function to get program disassembly a=
fter jit")

For "0156b148b5b4" I opted to do a popen() call and execute bpftool process=
,
an alternative would be to:
a. either link tools/bpf/bpftool/jit_disasm.c as a part of the
   test_progs executable;
b. call libbfd (binutils dis-assembler) directly from the bpftool.

Currently bpftool can use two dis-assemblers: libbfd and llvm library,
depending on the build environment. For CI builds libbfd is used.
I don't know if llvm and libbfd always produce same output for
identical binary code. Imo, if people are Ok with adding libbfd
dependency to test_progs, option (b) is the best. If folks on the
mailing list agree with this, I can work on updating the patches.

-------------

Aside from testing I agree with Andrii regarding rbp usage,
it seems like it should be possible to do the following in prologue:

    movabs $0x...,%rsp
    add %gs:0x...,%rsp
    push %rbp

and there would be no need to modify translation for instructions
accessing r10, plus debugger stack unrolling logic should still work?.
Or am I mistaken?

Thanks,
Eduard

