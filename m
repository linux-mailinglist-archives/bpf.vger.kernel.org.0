Return-Path: <bpf+bounces-17100-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 452B6809AA0
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 04:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA7951F213CA
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 03:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBC046B3;
	Fri,  8 Dec 2023 03:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UFMvOyl7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B50510F9
	for <bpf@vger.kernel.org>; Thu,  7 Dec 2023 19:45:46 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3332fc9b9b2so1549566f8f.1
        for <bpf@vger.kernel.org>; Thu, 07 Dec 2023 19:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702007144; x=1702611944; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c7z6l3loiW7m2DPnvX6IwqTRmAPATQpT7WWi5StzfTE=;
        b=UFMvOyl7fcpxtEywAw5uByMuluTv7Lj0nlSdqrVUiYzgKRYy98oP+bQgApPXiEqX1A
         v8fz/19Cxoz606PHruQyRz25m/d7dDl3zfBMnQz4f5U27ECo1UaWi0Br4sUYajHMdX09
         kiBcpmJDFiT7YRD7WsSVzbhEb2fi6lDtylZejGzeu0+r2APgFvDrDkSRyhVsqlys/JqC
         MpfX2Hsk04NVMZOtLDhmc8ukVJsIvuBQQBD7Gu52o9c6wO2Wk6/YQkQEXofMuJlV1Zq5
         dLV4pySltT80UTWUNxY7agQ4noKO9g6luW1DRMHmPDjLR63r5JcfatwYvrUyVDG93ZJs
         aLmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702007144; x=1702611944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c7z6l3loiW7m2DPnvX6IwqTRmAPATQpT7WWi5StzfTE=;
        b=HxZyWiAsznlrn5j3p/2HqB9P4PXeUDIf6YOBRK1D3/ychQdGyyM1lo95vRH+qnrDGV
         M7CQqbIGeJICv6+NTnacPlMuA3Rtm5DdxZV3FvVoQukhECtAq13+8ql+dtOaCrjM3HwJ
         IFvNxM4W5oW/8/REAdlI/u037JkxmYmDADVxhsWw/U1xc5lw914pasUoG4sRJGKyIeVZ
         IqxSzpZv9aajThNKrNALG4RuhsiK9kvlTARocdjjwKZIZK6IDnd/6CbJlUtR7eQn1RAh
         r/xiVkbVIawuHkccfwatFFu1SrZliqiuqzRIjVKapkgJ8PWAS+46/cTGpHgraZhqtioA
         +kiA==
X-Gm-Message-State: AOJu0YzBd7HhWrtt81jnYEHaf0LjfhodbMBcrOw36a+PCYhCDobQvBzG
	Sc7ILJrmbkEyRLAEHRJ2tLwKkMZGjukiw4s+ULs=
X-Google-Smtp-Source: AGHT+IG1XXcj590dzKdvRfYmJwUGhl6bvqs7i5ZgNcDasywgaia5TBi/p/YXIh2vV8tUtRs5anSmfHGtz9o+VcXmuDA=
X-Received: by 2002:adf:ffcd:0:b0:333:49a8:73e4 with SMTP id
 x13-20020adfffcd000000b0033349a873e4mr989811wrs.201.1702007144374; Thu, 07
 Dec 2023 19:45:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231206141030.1478753-1-aspsk@isovalent.com> <20231206141030.1478753-7-aspsk@isovalent.com>
In-Reply-To: <20231206141030.1478753-7-aspsk@isovalent.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 7 Dec 2023 19:45:32 -0800
Message-ID: <CAADnVQ+BRbJN1A9_fjDTXh0=VM5x6oGVgtcB1JB7K8TM5+6i5Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 6/7] libbpf: BPF Static Keys support
To: Anton Protopopov <aspsk@isovalent.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jiri Olsa <jolsa@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Stanislav Fomichev <sdf@google.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 6, 2023 at 6:13=E2=80=AFAM Anton Protopopov <aspsk@isovalent.co=
m> wrote:
>
> +
> +static __always_inline int __bpf_static_branch_jump(void *static_key)
> +{
> +       asm goto("1:\n\t"
> +               "goto %l[l_yes]\n\t"
> +               ".pushsection .jump_table, \"aw\"\n\t"
> +               ".balign 8\n\t"
> +               ".long 1b - .\n\t"
> +               ".long %l[l_yes] - .\n\t"
> +               ".quad %c0 - . + 1\n\t"
> +               ".popsection\n\t"
> +               :: "i" (static_key)
> +               :: l_yes);
> +       return 0;
> +l_yes:
> +       return 1;
> +}

Could you add a test to patch 7 where the same subprog is
used by multiple main progs and another test where a prog
with static_keys is statically linked by libbpf into another prog?
I suspect these cases are not handled by libbpf in the series.
The adjustment of insn offsets is tricky and I don't see this logic
in patch 5.

The special handling of JA insn (if it's listed in
static_branches_info[]) is fragile. The check_cfg() and the verifier
main loop are two places so far, but JA is an unconditional jump.
Every tool that understands BPF ISA would have to treat JA as "maybe
it's not a jump in this case" and that is concerning.

I certainly see the appeal of copy-pasting kernel's static_branch logic,
but we can do better since we're not bound by x86 ISA.

How about we introduce a new insn JA_MAYBE insn, and check_cfg and
the verifier will process it as insn_idx +=3D insn->off/imm _or_ insn_idx +=
=3D 1.
The new instruction will indicate that it may jump or fall through.
Another bit could be used to indicate a "default" action (jump vs
fallthrough) which will be used by JITs to translate into nop or jmp.
Once it's a part of the instruction stream we can have bpf prog callable
kfunc that can flip JA_MAYBE target
(I think this feature is missing in the patch set. It's necessary
to add an ability for bpf prog to flip static_branch. Currently
you're proposing to do it from user space only),
and there will be no need to supply static_branches_info[] at prog load tim=
e.
The libbpf static linking will work as-is without extra code.

JA_MAYBE will also remove the need for extra bpf map type.
The bpf prog can _optionally_ do '.long 1b - .' asm trick and
store the address of JA_MAYBE insn into an arbitrary 8 byte value
(either in a global variable, a section or somewhere else).
I think it's necessary to decouple patching of JA_MAYBE vs naming
the location.
The ".pushsection .jump_table" should be optional.
The kernel's static_key approach hard codes them together, but
it's due to x86 limitations.
We can introduce JA_MAYBE and use it everywhere in the bpf prog and
do not add names or addresses next to them. Then 'bpftool prog dump' can
retrieve the insn stream and another command can patch a specific
instruction (because JA_MAYBE is easy to spot vs regular JA).
At the end it's just a text_poke_bp() to convert
a target of JA_MAYBE.
The bpf prog can be written with
 asm goto("go_maybe +0, %l[l_yes]")
without names and maps, and the jumps will follow the indicated
'default' branch (how about, the 1st listed is default, the 2nd is
maybe).
The kernel static keys cannot be flipped atomically anyway,
so multiple branches using the same static key is equivalent to an
array of addresses that are flipped one by one.

I suspect the main use case for isovalent is to compile a bpf prog
with debug code that is not running by default and then flip
various parts when debugging is necessary.
With JA_MAYBE it's still going to be bpf_static_branch_[un]likely(),
but no extra map and the prog will load fine. Then you can patch
all of such insns or subset of them on demand.
(The verifier will allow patching of JA_MAYBE only between two targets,
so no safety issues).
I think it's more flexible than the new map type and static_branches_info[]=
.
wdyt?

