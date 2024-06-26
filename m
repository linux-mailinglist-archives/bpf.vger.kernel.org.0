Return-Path: <bpf+bounces-33192-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D01A9198E0
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 22:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE4301F22234
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 20:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC0B19005F;
	Wed, 26 Jun 2024 20:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jMlAHiwN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEB08F47
	for <bpf@vger.kernel.org>; Wed, 26 Jun 2024 20:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719433119; cv=none; b=t1XjmeNFh4n5GxkHLSMAj2BeuFuCETvHXjOXAVjBVVUkwnQUKmqQYwopiMXGNQRxKedx5efntacQmnvNe8XKrOLFTLZsDLQ3XJ+CtciXzGRweqexzw0NDaDb0hS8yFXW3GDVx7xAE8YbhQPIY1Lk1s2ucBqgxoM1Xu6N5bbdD0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719433119; c=relaxed/simple;
	bh=6jv3aEP+pFdv8kOhpdn3PxPW2pOn7rB70BqlBqElIcE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s2MvdagQCmnLiYwiXo1qP5HfqrIQf1XVq69jyiqqvgYs1QzvDWz9hgYJXHlolk4yZNt+iOHcF2JAwpPgh5kASkTd8+aCqN1GPIDdaoRDP9AB4v+bqDFoAHQzRuR7oTVOa/ZVYvySUIwiCpWCzMj3Nt+Q+BIGhm9pwYWGuaurBIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jMlAHiwN; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-354b722fe81so4728154f8f.3
        for <bpf@vger.kernel.org>; Wed, 26 Jun 2024 13:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719433116; x=1720037916; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PAEXjYZo3lQPILlHC/GV+hgZUNlRCbCxV9EK5vWYjJU=;
        b=jMlAHiwNOh4W4qRneqbs/DYZSRcY2UVty68IfcR3prTk93pmdNY993HroqUB8oGcVh
         uZAyigsbaGDsx8Bn+4ogvwdTnqoES49XlgIHS+HtUUdF/RDAD9fqA+C6EJfNL26t00lC
         Hg3aIx1RDIOhFq+iaZA5kSy2JLucMbQgLyQS1CtsP9gd5/xclK5lrkPY1YIp7irTeTPK
         QZZpBfhoT0JkFZCdHfKi3Y/BUfAhcHE65ErJIm4dpA+BtaLmbWck4FYlMhmEX9UvAtTC
         n9jNyVV3jKx7hu9d0HgNKD9Kh+MGC63ra6/hXhTNmFq+/Vk7Xr6LEVUxRItukAx+0APB
         IM8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719433116; x=1720037916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PAEXjYZo3lQPILlHC/GV+hgZUNlRCbCxV9EK5vWYjJU=;
        b=c4kHvodmJZvvk5n06cQ3Q2kesdNRLkdNdU06aowOUJIUbRIulFYNJlNwTWbZbA/CNV
         4r9HM8Hw/XvnU7Uwqxun4Ozklg7kjmkZrpcyCR/M857PSUZBEKjtC9M1qY5yxNovVwkb
         i9G3RPUBqc+ePFVlTVfYpUr+61QUQ46UDrFM+bB0eppdkkdsg3bOsHqeN10FWSG1YID2
         cdwmjTS2mt6LZjPwMetUaE8YWe1HWmCMVFr+Fnb/UCOORExJa2Ieg8suXxfDj7el44i4
         jR++EcfNW52ERd3GEcGUtYZv8mlxSoks3biffok7z/teVqZvvyPYsJkapclzMRKop3Al
         OhaQ==
X-Gm-Message-State: AOJu0YzvLKiRyUC6uqepFt4xoFGy67PjoEDGSCXAAxqNZlAe2OOZGY1l
	iw+l8Xphock95WbUCud5QzKlqKGc8imjk0++lyfmlN/z91DNSXVpZ3ls39zSYMynB7h9ARx2B+d
	TtXTj2qFXsNqYsdv+f+Z/Z2sjpDo=
X-Google-Smtp-Source: AGHT+IFxi6FL7ogCOlgz2xHpiGzd7g08U0egWS56iMS5+gIdwDynkQCu1VGD7FYIy8h+84Z6iQ6VMyBvZVQNazXX5+s=
X-Received: by 2002:adf:f547:0:b0:362:4ce:2171 with SMTP id
 ffacd0b85a97d-366e4f00ba5mr9394022f8f.52.1719433116200; Wed, 26 Jun 2024
 13:18:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625062857.92760-1-mattbobrowski@google.com>
In-Reply-To: <20240625062857.92760-1-mattbobrowski@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 26 Jun 2024 13:18:25 -0700
Message-ID: <CAADnVQKYXo9NpGEsfvgSeW_bXi-8BDHAYT0QkPv0gwh9g0CccQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf 1/2] bpf: add missing check_func_arg_reg_off() to
 prevent out-of-bounds memory accesses
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eddy Z <eddyz87@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 11:29=E2=80=AFPM Matt Bobrowski
<mattbobrowski@google.com> wrote:
>
> Currently, it's possible to pass in a modified CONST_PTR_TO_DYNPTR to
> a global function as an argument. The adverse effects of this is that
> BPF helpers can continue to make use of this modified
> CONST_PTR_TO_DYNPTR from within the context of the global function,
> which can unintentionally result in out-of-bounds memory accesses and
> therefore compromise overall system stability i.e.
>
> [  244.157771] BUG: KASAN: slab-out-of-bounds in bpf_dynptr_data+0x137/0x=
140
> [  244.161345] Read of size 8 at addr ffff88810914be68 by task test_progs=
/302
> [  244.167151] CPU: 0 PID: 302 Comm: test_progs Tainted: G O E 6.10.0-rc3=
-00131-g66b586715063 #533
> [  244.174318] Call Trace:
> [  244.175787]  <TASK>
> [  244.177356]  dump_stack_lvl+0x66/0xa0
> [  244.179531]  print_report+0xce/0x670
> [  244.182314]  ? __virt_addr_valid+0x200/0x3e0
> [  244.184908]  kasan_report+0xd7/0x110
> [  244.187408]  ? bpf_dynptr_data+0x137/0x140
> [  244.189714]  ? bpf_dynptr_data+0x137/0x140
> [  244.192020]  bpf_dynptr_data+0x137/0x140
> [  244.194264]  bpf_prog_b02a02fdd2bdc5fa_global_call_bpf_dynptr_data+0x2=
2/0x26
> [  244.198044]  bpf_prog_b0fe7b9d7dc3abde_callback_adjust_bpf_dynptr_reg_=
off+0x1f/0x23
> [  244.202136]  bpf_user_ringbuf_drain+0x2c7/0x570
> [  244.204744]  ? 0xffffffffc0009e58
> [  244.206593]  ? __pfx_bpf_user_ringbuf_drain+0x10/0x10
> [  244.209795]  bpf_prog_33ab33f6a804ba2d_user_ringbuf_callback_const_ptr=
_to_dynptr_reg_off+0x47/0x4b
> [  244.215922]  bpf_trampoline_6442502480+0x43/0xe3
> [  244.218691]  __x64_sys_prlimit64+0x9/0xf0
> [  244.220912]  do_syscall_64+0xc1/0x1d0
> [  244.223043]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [  244.226458] RIP: 0033:0x7ffa3eb8f059
> [  244.228582] Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 4=
8 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <=
48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8f 1d 0d 00 f7 d8 64 89 01 48
> [  244.241307] RSP: 002b:00007ffa3e9c6eb8 EFLAGS: 00000206 ORIG_RAX: 0000=
00000000012e
> [  244.246474] RAX: ffffffffffffffda RBX: 00007ffa3e9c7cdc RCX: 00007ffa3=
eb8f059
> [  244.250478] RDX: 00007ffa3eb162b4 RSI: 0000000000000000 RDI: 00007ffa3=
e9c7fb0
> [  244.255396] RBP: 00007ffa3e9c6ed0 R08: 00007ffa3e9c76c0 R09: 000000000=
0000000
> [  244.260195] R10: 0000000000000000 R11: 0000000000000206 R12: fffffffff=
fffff80
> [  244.264201] R13: 000000000000001c R14: 00007ffc5d6b4260 R15: 00007ffa3=
e1c7000
> [  244.268303]  </TASK>
>
> Add a check_func_arg_reg_off() to the path in which the BPF verifier
> verifies the arguments of global function arguments, specifically
> those which take an argument of type ARG_PTR_TO_DYNPTR |
> MEM_RDONLY. Also, process_dynptr_func() doesn't appear to perform any
> explicit and strict type matching on the supplied register type, so
> let's also enforce that a register either type PTR_TO_STACK or
> CONST_PTR_TO_DYNPTR is by the caller.

The fix makes sense, but I applied it to bpf-next tree.
Since kfunc_dynptr_nullable_test3 had to be adjusted there.

> Reported-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
> ---
>  kernel/bpf/verifier.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 214a9fa8c6fb..fe12463511f6 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -7715,6 +7715,13 @@ static int process_dynptr_func(struct bpf_verifier=
_env *env, int regno, int insn
>         struct bpf_reg_state *regs =3D cur_regs(env), *reg =3D &regs[regn=
o];
>         int err;
>
> +       if (reg->type !=3D PTR_TO_STACK && reg->type !=3D CONST_PTR_TO_DY=
NPTR) {
> +               verbose(env,
> +                       "arg#%d expected pointer to stack or const struct=
 bpf_dynptr\n",
> +                       regno);
> +               return -EINVAL;
> +       }
> +
>         /* MEM_UNINIT and MEM_RDONLY are exclusive, when applied to an
>          * ARG_PTR_TO_DYNPTR (or ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_*):
>          */
> @@ -9464,6 +9471,10 @@ static int btf_check_func_arg_match(struct bpf_ver=
ifier_env *env, int subprog,
>                                 return -EINVAL;
>                         }
>                 } else if (arg->arg_type =3D=3D (ARG_PTR_TO_DYNPTR | MEM_=
RDONLY)) {
> +                       ret =3D check_func_arg_reg_off(env, reg, regno, A=
RG_PTR_TO_DYNPTR);
> +                       if (ret)
> +                               return ret;
> +
>                         ret =3D process_dynptr_func(env, regno, -1, arg->=
arg_type, 0);
>                         if (ret)
>                                 return ret;
> @@ -11954,14 +11965,8 @@ static int check_kfunc_args(struct bpf_verifier_=
env *env, struct bpf_kfunc_call_
>                         break;
>                 case KF_ARG_PTR_TO_DYNPTR:
>                 {
> -                       enum bpf_arg_type dynptr_arg_type =3D ARG_PTR_TO_=
DYNPTR;
>                         int clone_ref_obj_id =3D 0;
> -
> -                       if (reg->type !=3D PTR_TO_STACK &&
> -                           reg->type !=3D CONST_PTR_TO_DYNPTR) {
> -                               verbose(env, "arg#%d expected pointer to =
stack or dynptr_ptr\n", i);
> -                               return -EINVAL;
> -                       }
> +                       enum bpf_arg_type dynptr_arg_type =3D ARG_PTR_TO_=
DYNPTR;

also fixed that to keep the original order and
reduce diff noise.

