Return-Path: <bpf+bounces-39858-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFED9788F7
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 21:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 347591F23201
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 19:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E197A1474A5;
	Fri, 13 Sep 2024 19:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AxDDTvm8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DD4BA2D
	for <bpf@vger.kernel.org>; Fri, 13 Sep 2024 19:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726255714; cv=none; b=OSvcZ+zGKhTkC4shLftBXEstyc9JEImw4ex6HdbvfbZG+PidL8yHeL3wfJfgTvDIX6+Nzo3hD3OVr1Lw4nbpaDuUqbJShhrg6lSPkkErKp8D3oEHssg9h3mnevO5I8aN/LNwlRc4F+aEPnhxNDvNjryNxYvfc1kop6Jro6pHfDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726255714; c=relaxed/simple;
	bh=oMIr1U+cfMLTijkTElT0Gc+2bmsF/aQ/husiJmv15bA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hUUbYroXk1ZcP+CFqtjctsI+iTKGxUZWgzk1byQQGuMbUj+Gd6xHE88LHrYmFu/ceJlWpmaQoU9wq6zoHC+PT11k6dyZG06t+iElfNrRX+TOzGHyP75XYjYS/3S5am1MTlTJ6LhcR8jmdpNbo/TH75UUrjPpgwIKECKhy1mKwa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AxDDTvm8; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42cb8dac900so24045955e9.3
        for <bpf@vger.kernel.org>; Fri, 13 Sep 2024 12:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726255709; x=1726860509; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pdRSMI3j1Ra6DXXch4tncYT3k7oh3nnXUnL+dvKbNFM=;
        b=AxDDTvm83Ldq4ShaOfsiPcs69VnArGvv0/JZcs+C8aojxFmofJ+JiZpb9G3YhhF8jN
         FDvnwV9wlCNgNjH3ngqG26ac2dDKKzJWAolJyxs7BRtA0FAEr1CD5si5lHoFW+DFHZXF
         sJu7tpLZRl+aXD5vorZjWLqd4R0CFp2Qqs58lXlpnx1JnI8mEHzUEZSm0FX0z7f2vNaD
         550TyYCYf872ITwGArMIQ7R8cHQBYXTWSgIPjng2FjV/OqgZ6u854ZcMoCNHfXnD6H7l
         vnbPcklGb3+/CSZSGGAEvjbjZoVw1VF0lyJ9IPag36OIgmWKUE6XAQb+d0gacsZcPX33
         50cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726255709; x=1726860509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pdRSMI3j1Ra6DXXch4tncYT3k7oh3nnXUnL+dvKbNFM=;
        b=PCPGYr4rirEs+gB3v7rY+Ki7V1YVY0id2lvmNSYHaN8KOt9ktcSFCJEpHlgehySJuz
         8BqCiiYvVmis3dwy6mT1YHrkGzu4k8M8Dj++QxDFLkVeJHKP7Gp8BtarHw0zDrc0VJJt
         g5NPfU2SaV/IwsCNBlaFcCi68N4UZxwTbn7dKDyNpCn0mnaV91vPJgj701KRN9AeaUtR
         QnJM9wWzlzoWBHS5fHvtA9ePmt6uZS8Wr+JV5APkiodxligqlLiJy4QTs2+bcp+Sm2ac
         ir9Jvh17ipHBTFVeumYr0K0i7CTmqql1ivA/htx9F2x+9CPFXLTdj5Q58Qb/eD2klNFa
         rQ5A==
X-Gm-Message-State: AOJu0YzDkjwgkBmwLXiypJSa+E1NmNwbcMUWqnQ73CMJ012CRe3neaoK
	ytWUT4LnSvrTogtQ3BV0rv5CfqtPg7iVPYnZrUhqU4UJGRLBCiXvUzVynAYfk59YTgJi8VYlziW
	oxPuFMJMnUpj/6UKMcyNyMTTmVnM=
X-Google-Smtp-Source: AGHT+IE8uD4JiBk44cABEy8cW5/ROOSt2TFi3bcXJGEajAHBMxyGRPRWvC7w1f/4EckTtlVG6rAjkOWhJFisHo0dSC8=
X-Received: by 2002:a5d:670a:0:b0:374:c8e5:d56a with SMTP id
 ffacd0b85a97d-378c2d726c3mr4862661f8f.48.1726255708672; Fri, 13 Sep 2024
 12:28:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240901133856.64367-1-leon.hwang@linux.dev> <20240901133856.64367-2-leon.hwang@linux.dev>
In-Reply-To: <20240901133856.64367-2-leon.hwang@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 13 Sep 2024 12:28:17 -0700
Message-ID: <CAADnVQJ0yz-VcFCJ0v4+LXGNDOgu1jYoSGHzywnszDjTrRSE7Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/4] bpf, x64: Fix tailcall infinite loop
 caused by freplace
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Puranjay Mohan <puranjay@kernel.org>, Xu Kuohai <xukuohai@huaweicloud.com>, 
	Eddy Z <eddyz87@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 1, 2024 at 6:41=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> wr=
ote:
>
> @@ -573,10 +575,13 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke=
_type t,
>
>         /*
>          * See emit_prologue(), for IBT builds the trampoline hook is pre=
ceded
> -        * with an ENDBR instruction.
> +        * with an ENDBR instruction and 3 bytes tail_call_cnt initializa=
tion
> +        * instruction.
>          */
>         if (is_endbr(*(u32 *)ip))
>                 ip +=3D ENDBR_INSN_SIZE;
> +       if (is_bpf_text_address((long)ip))
> +               ip +=3D X86_POKE_EXTRA;

This is a foot gun.
bpf_arch_text_poke() is used not only at the beginning of the function.
So unconditional ip +=3D 3 is not just puzzling with 'what is this for',
but dangerous and wasteful...

> @@ -2923,6 +2930,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf=
_tramp_image *im, void *rw_im
>                  */
>                 if (is_endbr(*(u32 *)orig_call))
>                         orig_call +=3D ENDBR_INSN_SIZE;
> +               if (is_bpf_text_address((long)orig_call))
> +                       orig_call +=3D X86_POKE_EXTRA;
>                 orig_call +=3D X86_PATCH_SIZE;
>         }

..this bit needs to be hacked too...

> @@ -3025,6 +3034,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf=
_tramp_image *im, void *rw_im
>                 /* remember return value in a stack for bpf prog to acces=
s */
>                 emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -8);
>                 im->ip_after_call =3D image + (prog - (u8 *)rw_image);
> +               emit_nops(&prog, X86_POKE_EXTRA);
>                 emit_nops(&prog, X86_PATCH_SIZE);

And this is just pure waste of kernel code and cpu run-time.

You're adding 3 byte nop for no reason at all.

See commit e21aa341785c ("bpf: Fix fexit trampoline.")
that added:
                int err =3D bpf_arch_text_poke(im->ip_after_call, BPF_MOD_J=
UMP,
                                             NULL, im->ip_epilogue);
logic that is patching bpf trampoline in the middle of it.
(not at the start).

Because of unconditional +=3D3 in bpf_arch_text_poke() every trampoline
will have to waste nop3 ?
No.

Please fix freplace and tail call combination without
this kind of unacceptable shortcuts.

I very much prefer to stop hacking into JITs and trampolines because
tailcalls and freplace don't work well together.

We cannot completely disable that combination because libxdp
is using freplace to populate chain of progs the main prog is calling
and these freplace progs might be doing tailcall,
but we can still prevent such infinite loop that you describe in commit log=
:
entry_tc -> subprog_tc -> entry_freplace -> subprog_tail --tailcall-> entry=
_tc
in the verifier without resorting to JIT hacks.

pw-bot: cr

