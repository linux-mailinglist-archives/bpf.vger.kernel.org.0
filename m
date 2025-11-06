Return-Path: <bpf+bounces-73904-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B59C3D476
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 20:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A65001893B11
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 19:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C703502A6;
	Thu,  6 Nov 2025 19:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="STcOuoyP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F331D516C
	for <bpf@vger.kernel.org>; Thu,  6 Nov 2025 19:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762458655; cv=none; b=LQa7LOURAo7it7vTYI1/6buF/9aUSURxbhlz2Qdfb0owlzM+aR17DZs+vBjtTKOxKFjjoDpKbCRC1QfZ5/4Q7/QaKq2JPCcnqAtn4RJYqhklVupxTwQrvTjIKYIvPhIECNHzmgYMIaGPDCTX42Rsm0yhyJ9TBZVbxs/DPTPJAD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762458655; c=relaxed/simple;
	bh=kWYEaNzr87jotlL+rDyr6JOA5/FLONmWaZnNPXmmdAI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bPvF5hBNCmm/erln4Zwg6gem7JGln7dhZpdCwiOxm0WI1lT+21uJWY4gjSypQzQ1egB+j4zyx5lwI/7XdWw2E0YPK7sFcJJvgecxEizx6fC+YvkBHODcMwZ8LB3u93XLXs6F5U+GJG8j76LuowP+rffJud2ZaxDsm0rUR6z9v30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=STcOuoyP; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-294df925292so37555ad.1
        for <bpf@vger.kernel.org>; Thu, 06 Nov 2025 11:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762458653; x=1763063453; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=R+hrd1hNiHiJlob3jEydPuPbFQyGiugiZ570a+FwhJc=;
        b=STcOuoyPkGQZ4m3g1K1g2V20MGrmda1KSGxYxtihseTsVuJs4gRzkqGdJAhZKZx7VX
         InPjMFO+OkcsROcXt6nftXn/stUha2r/6EK9rlRykzQ2VxP7Qy1udSi484A6NX29orqz
         uehM1ykQlo6puWnZdTmIv66dMQnIa7zFeOrOfWxARk/iJ2b4Eguqaa5treNIuHuN880q
         mgpPfstYZuUYjQjDSOkdQkbDxFASnYVRhhoSXk0KvGN1qGBHszDRyaT4ly9nEK/UKdI1
         51fkPf5RkRUVZPlIXmlFmE1VCs93rGf16UKSoKa1AaPPVhoEFJ8w4MmSk3CK9txuJJEE
         UCpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762458653; x=1763063453;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R+hrd1hNiHiJlob3jEydPuPbFQyGiugiZ570a+FwhJc=;
        b=tXo8W3coW9xgsxi5VF5G9kqgG2fYNwv2WlwEFzqmpBrsnXesBrEht+sKKlWNIH94yE
         ZOuuaD2ro+p1tsAwytmY4AmhqsiXpDi8NY1i+VFNcIfdNVYwf33JKiGU9qMKwdjxRz20
         dUIuXE7GnImx2wY8xbIwpWepMXAraFS/Nvsb8aq2pjDQYdyWNh51M7KfnnKPM4X4sIIo
         va03zDsVv8U6EcrSNtans8Krqe9ti7DlEtLx3fqf3oD3plAMhjvciv0pAexoHDEbd/ZE
         CIMx2/lpBpif5yLUelB5UPMzLtqLENKFTUFcGtXa33XcYH+xEymBSv7/4SCE7/F5mqhg
         /nZg==
X-Forwarded-Encrypted: i=1; AJvYcCWNGMCnrquv6Rz3Z/mbz9CU7961eWksTuTcvR4EkagQdNlU/dC3B8ulIAobNcOGdLmZS/4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMsYcenGTkjUVGuFO5pnNcqs5Cwmea6BnHYCGM0pDAGkFekGWz
	p8u8yIvaUOJKWoWMhS4jGNtE0FuS64Fo46+pxJigd+whUgn59D0DdJZy
X-Gm-Gg: ASbGncuaFjVdim2G0KDyfXyAqo94c9ibXnHyMkcj5EBaP8g3Z8rX3Ak/B4EQlC/w2j2
	LlyXsqsUSbTmlbg8CIq/bjXIdwTywjyTyCazE6btZPHXaPPK/jLxi7ODsBm+uPC8jS7IN4N5YZf
	asL9E/vAS25SFpD8oLsZ+h/UiHQyb04v3+W5fFOpTkOzFo23DkvnIecTR/q5eFgoicqJsoZpkGJ
	SyfUI1T7atAGCr0PxWgYUHHgSbQn1EdRFThF9GZfMjtLuCl4uIrwjemk2YcrfCj4PHhZ1gN2Ot7
	KOH1yISetTccoOIwNez4voRfBJcsVwLoIEHZrOYBem2YP210NP00xkFiHj/GxkDy1H5edfb8A35
	6A62Qz2eR3JS2gMKcMR7ELn3k2a3bqdAXNSB2vk65iYSnyNXitlmixvimdoBtEvPaPQttt3EJry
	ARrXKxQhNH
X-Google-Smtp-Source: AGHT+IF6jwyDBFD7xtgFu4UpSkiqYmJngUU3qZbSO7tZO0p3bKJxV68KUsJ4lQ5AsYmkQXnVFZKacg==
X-Received: by 2002:a17:902:f78f:b0:27e:dc53:d239 with SMTP id d9443c01a7336-297c045f0bemr8264145ad.35.1762458653295;
        Thu, 06 Nov 2025 11:50:53 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29650c5fdb5sm36634755ad.44.2025.11.06.11.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 11:50:52 -0800 (PST)
Message-ID: <998304ddd050ef81ce6281ebb88130e836c07fc3.camel@gmail.com>
Subject: Re: [PATCH v4 bpf-next 2/2] bpf: test the proper verification of
 tail calls
From: Eduard Zingerman <eddyz87@gmail.com>
To: Martin Teichmann <martin.teichmann@xfel.eu>, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org
Date: Thu, 06 Nov 2025 11:50:49 -0800
In-Reply-To: <20251106105238.2926962-3-martin.teichmann@xfel.eu>
References: <c571ab7af853a3f775be3a518f99ec809f49797f.camel@gmail.com>
	 <20251106105238.2926962-3-martin.teichmann@xfel.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-11-06 at 11:52 +0100, Martin Teichmann wrote:

[...]

> +SEC("socket")
> +__log_level(2)
> +__msg("19: (85) call bpf_tail_call#12")
> +__msg("(0) frame 0 insn 1 +written -8")
> +__msg("(0) live stack update done in 2 iterations")
> +__msg("14: (95) exit")
> +__msg("(0) frame 0 insn 13 +live -8")
> +__msg("(0) live stack update done in 2 iterations")
> +__msg("22: (95) exit")
> +__msg("(9,15) frame 0 insn 20 +written -8")
> +__msg("(9,15) live stack update done in 2 iterations")
> +__msg("14: (95) exit")
> +__msg("(0) frame 0 insn 13 +live -16")
> +__naked unsigned long caller_stack_write_tail_call(void)
> +{
> +        asm volatile (
> +	"r6 =3D r1;"
> +	"*(u64 *)(r10 - 8) =3D -8;"
> +        "call %[bpf_get_prandom_u32];"
> +        "if r0 !=3D 42 goto 1f;"
> +        "goto 2f;"
> +  "1:"
> +        "*(u64 *)(r10 - 8) =3D -1024;"
> +  "2:"
> +        "r1 =3D r6;"
> +        "r2 =3D r10;"
> +        "r2 +=3D -8;"
> +        "call write_tail_call;"
> +        "r1 =3D *(u64 *)(r10 - 8);"
> +        "r2 =3D r10;"
> +        "r2 +=3D r1;"
> +        "r0 =3D *(u64 *)(r2 + 0);"
> +        "exit;"
> +        :: __imm(bpf_get_prandom_u32)
> +	: __clobber_all);
> +}

This program is not safe, but verifier accepts it as safe.
Note the following log:

  0: R1=3Dctx() R10=3Dfp0
  ; asm volatile ( @ verifier_live_stack.c:318
  0: (bf) r6 =3D r1                       ; R1=3Dctx() R6=3Dctx()
  1: (7a) *(u64 *)(r10 -8) =3D -8         ; R10=3Dfp0 fp-8=3D-8
  2: (85) call bpf_get_prandom_u32#7    ; R0=3Dscalar()
  3: (55) if r0 !=3D 0x2a goto pc+1       ; R0=3D42
  4: (05) goto pc+1
  6: (bf) r1 =3D r6                       ; R1=3Dctx() R6=3Dctx()
  7: (bf) r2 =3D r10                      ; R2=3Dfp0 R10=3Dfp0
  8: (07) r2 +=3D -8                      ; R2=3Dfp-8
  9: (85) call pc+5
  ...
  from 3 to 5: R0=3Dscalar() R6=3Dctx() R10=3Dfp0 fp-8=3D-8
  5: R0=3Dscalar() R6=3Dctx() R10=3Dfp0 fp-8=3D-8
  5: (7a) *(u64 *)(r10 -8) =3D -1024      ; R10=3Dfp0 fp-8=3D-1024
  6: (bf) r1 =3D r6                       ; R1=3Dctx() R6=3Dctx()
  7: (bf) r2 =3D r10                      ; R2=3Dfp0 R10=3Dfp0
  8: (07) r2 +=3D -8
  9: safe

First time instruction #9 is verified for fp-8 =3D=3D -8,
on a seocnd time verifier does not proceed with abstract
interpretation when fp-8 =3D=3D -1024.

This happens because verifier assumes that call at (9) always sets
fp-8 to -16.

And it does so, because bpf_insn_successors() does not tell it about
possible function exit after tail call. Note that sack liveness marks
are propagated over the program control flow graph as defined by
bpf_insn_successors().
kernel/bpf/liveness.c has extensive comments about that.

W/o tweak to bpf_insn_successors() verifier assumes that
write_tail_call always sets fp-8 to -16, from which verifier infers
that fp-8 is dead at instruction (9).  Verifier does not compare
states for dead stack slots when considering states_equal() in
is_state_visited(). Hence it proceeds with state pruning logic and
stops.

Please adjust check_cfg() in a way, similar to visit_gotox_insn(): for
tail calls, store env->insn_aux_data[t].jt pointing either to the next
instruciton or to program exit. And use this information in
bpf_insn_successors().

(You will need to rebase to do that, the changes for
visit_gotox_insn() landed just yesterday).

> +static __used __naked unsigned long write_tail_call(void)
> +{
> +        asm volatile (
> +        "r6 =3D r2;"
> +        "r2 =3D %[map_array] ll;"
> +        "r3 =3D 0;"
> +        "call %[bpf_tail_call];"
> +        "*(u64 *)(r6 + 0) =3D -16;"
> +        "r0 =3D 0;"
> +        "exit;"
> +	:
> +	: __imm(bpf_tail_call),
> +          __imm_addr(map_array)
> +        : __clobber_all);
> +}

[...]

