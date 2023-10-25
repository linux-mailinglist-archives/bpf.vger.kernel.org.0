Return-Path: <bpf+bounces-13257-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BB47D725E
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 19:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27AAF281DE4
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 17:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5275730D08;
	Wed, 25 Oct 2023 17:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PdohBSpY"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB98E30D1C
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 17:34:39 +0000 (UTC)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8052919A;
	Wed, 25 Oct 2023 10:34:36 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-507d7b73b74so8562383e87.3;
        Wed, 25 Oct 2023 10:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698255274; x=1698860074; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=j595mLLB/qbsliLe7iaSAskkCb7lS3rwnUxVp99RqNQ=;
        b=PdohBSpYaJiIC614Q0bhP9MHy30+8lh6sWbjiS98NknY/a8EVLjI45WDCDBbAM0v7g
         3SUOukSrdD3Awr1gffVpOzw1RdDzqAp3W8t8pb8bI5ynI+4Lj/4812KK9ZicCVjZ5KGy
         9t0emEWHy3c1e0LtEUTiAWR8QNY0G9MIUoLvujQ6Cr4rvZdl9AukTwD1RXFHvODUz1Dy
         nXz/9eoDql5Pqw0GW37QFa8fpJH9hyJyUO8o3yMx8EfQ87Pit2MZwr0Dz0hiWdY/lhaE
         lncWXtSSpBh+ShevqbKAFWd7Lqqr1Ke5Ntl+bazFwjGy1xhW4GDmtcpxiIBpbeElszIy
         y8+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698255274; x=1698860074;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j595mLLB/qbsliLe7iaSAskkCb7lS3rwnUxVp99RqNQ=;
        b=FxwilvJk75WM/7iYwbNFQ3J5FQeiWVbrjDmHMO0dqMW1JTyzQX3QBktHCF2IyxuYFX
         h2UV5JkGxV9oF3EolulfUi5rvyly6RVI1klaRoD0+XnHJElwX05vHQ8UQ16rz+iVhLWk
         N83CEOBatg4nja3igOiBXscBTLe2Kfv6FrSwwykArYiL7EnpexCWj1u6lyy8O6YR4v4E
         jFUTel4vbDFpkyUZTiIQP7PitROj41P8lOxrAfdDgksek/PZ8cpL0VojxjMLj+8ZTyqj
         Urgar+VPNgU1fIgrJXW3HXcRVHVPctpmJIOcWMcWQDl9vPlzd5efh97Fzf594OBNos4J
         7fAw==
X-Gm-Message-State: AOJu0YyZsQvll+If43I+Z3CdCyyGgWowGI/07DVkdMJSPKY1zuaN50OB
	VgGcKMs1vvphHLcADi5QYmI=
X-Google-Smtp-Source: AGHT+IEwxVIh9DDWAUYExGFV3PZEOD+CJhk72nqzHgKThvdjKlpIYR3X4Dk72Kg2qQF/nx2bi2ix7A==
X-Received: by 2002:ac2:5e9c:0:b0:507:8f1b:ff59 with SMTP id b28-20020ac25e9c000000b005078f1bff59mr10860025lfq.62.1698255274322;
        Wed, 25 Oct 2023 10:34:34 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id do6-20020a170906c10600b009ad7fc17b2asm10354760ejc.224.2023.10.25.10.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 10:34:33 -0700 (PDT)
Message-ID: <4b354d05b1bb4aa681fff5baca3455d90233951d.camel@gmail.com>
Subject: Re: bpf: shift-out-of-bounds in tnum_rshift()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Hao Sun <sunhao.th@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Linux Kernel Mailing List
	 <linux-kernel@vger.kernel.org>
Date: Wed, 25 Oct 2023 20:34:31 +0300
In-Reply-To: <CACkBjsY2q1_fUohD7hRmKGqv1MV=eP2f6XK8kjkYNw7BaiF8iQ@mail.gmail.com>
References: 
	<CACkBjsY2q1_fUohD7hRmKGqv1MV=eP2f6XK8kjkYNw7BaiF8iQ@mail.gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2023-10-24 at 14:40 +0200, Hao Sun wrote:
> Hi,
>=20
> The following program can trigger a shift-out-of-bounds in
> tnum_rshift(), called by scalar32_min_max_rsh():
>=20
> 0: (bc) w0 =3D w1
> 1: (bf) r2 =3D r0
> 2: (18) r3 =3D 0xd
> 4: (bc) w4 =3D w0
> 5: (bf) r5 =3D r0
> 6: (bf) r7 =3D r3
> 7: (bf) r8 =3D r4
> 8: (2f) r8 *=3D r5
> 9: (cf) r5 s>>=3D r5
> 10: (a6) if w8 < 0xfffffffb goto pc+10
> 11: (1f) r7 -=3D r5
> 12: (71) r6 =3D *(u8 *)(r1 +17)
> 13: (5f) r3 &=3D r8
> 14: (74) w2 >>=3D 30
> 15: (1f) r7 -=3D r5
> 16: (5d) if r8 !=3D r6 goto pc+4
> 17: (c7) r8 s>>=3D 5
> 18: (cf) r0 s>>=3D r0
> 19: (7f) r0 >>=3D r0
> 20: (7c) w5 >>=3D w8         # shift-out-bounds here
> 21: exit

Here is a simplified example:

SEC("?tp")
__success __retval(0)
__naked void large_shifts(void)
{
        asm volatile ("                 \
        call %[bpf_get_prandom_u32];    \n\
        r8 =3D r0;                        \n\
        r6 =3D r0;                        \n\
        r6 &=3D 0xf;                      \n\
        if w8 < 0xffffffff goto +2;     \n\
        if r8 !=3D r6 goto +1;            \n\
        w0 >>=3D w8;       /* shift-out-bounds here */    \n\
        exit;                           \n\
"       :
        : __imm(bpf_get_prandom_u32)
        : __clobber_all);
}

The issue is caused by an invalid range assigned to R8 after R8 !=3D R6
check, here is GDB log:

(gdb) bt
#0  scalar32_min_max_rsh ... at kernel/bpf/verifier.c:13368
#1  0xffffffff81295236 in adjust_scalar_min_max_vals ... at kernel/bpf/veri=
fier.c:13592
#2  adjust_reg_min_max_vals .... at kernel/bpf/verifier.c:13706
#3  0xffffffff8128701f in check_alu_op ... at kernel/bpf/verifier.c:13938
#4  do_check ... at kernel/bpf/verifier.c:17327
(gdb) p *src_reg
$2 =3D {
  type =3D SCALAR_VALUE,
  ...
  smin_value =3D 4294967295,
  smax_value =3D 15,
  umin_value =3D 4294967295,
  umax_value =3D 15,
  s32_min_value =3D -1,
  s32_max_value =3D -1,
  u32_min_value =3D 4294967295,
  u32_max_value =3D 4294967295,
  ...
}

The invalid range is assigned within reg_combine_min_max() function in
BPF_JNE branch. The following diff removes the error:

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 857d76694517..3d140bf85282 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14485,7 +14485,7 @@ static void reg_combine_min_max(struct bpf_reg_stat=
e *true_src,
                __reg_combine_min_max(true_src, true_dst);
                break;
        case BPF_JNE:
-               __reg_combine_min_max(false_src, false_dst);
+               //__reg_combine_min_max(false_src, false_dst);
                break;
        }
 }

I do not understand what BPF_JNE branch logically means in
reg_combine_min_max(), does anyone has any insight?

> After load:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> UBSAN: shift-out-of-bounds in kernel/bpf/tnum.c:44:9
> shift exponent 255 is too large for 64-bit type 'long long unsigned int'
> CPU: 2 PID: 8574 Comm: bpf-test Not tainted
> 6.6.0-rc5-01400-g7c2f6c9fb91f-dirty #21
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/0=
1/2014
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x8e/0xb0 lib/dump_stack.c:106
>  ubsan_epilogue lib/ubsan.c:217 [inline]
>  __ubsan_handle_shift_out_of_bounds+0x15a/0x2f0 lib/ubsan.c:387
>  tnum_rshift.cold+0x17/0x32 kernel/bpf/tnum.c:44
>  scalar32_min_max_rsh kernel/bpf/verifier.c:12999 [inline]
>  adjust_scalar_min_max_vals kernel/bpf/verifier.c:13224 [inline]
>  adjust_reg_min_max_vals+0x1936/0x5d50 kernel/bpf/verifier.c:13338
>  do_check kernel/bpf/verifier.c:16890 [inline]
>  do_check_common+0x2f64/0xbb80 kernel/bpf/verifier.c:19563
>  do_check_main kernel/bpf/verifier.c:19626 [inline]
>  bpf_check+0x65cf/0xa9e0 kernel/bpf/verifier.c:20263
>  bpf_prog_load+0x110e/0x1b20 kernel/bpf/syscall.c:2717
>  __sys_bpf+0xfcf/0x4380 kernel/bpf/syscall.c:5365
>  __do_sys_bpf kernel/bpf/syscall.c:5469 [inline]
>  __se_sys_bpf kernel/bpf/syscall.c:5467 [inline]
>  __x64_sys_bpf+0x73/0xb0 kernel/bpf/syscall.c:5467
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x5610511e23cd
> Code: 24 80 00 00 00 48 0f 42 d0 48 89 94 24 68 0c 00 00 b8 41 01 00
> 00 bf 05 00 00 00 ba 90 00 00 00 48 8d b44
> RSP: 002b:00007f5357fc7820 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
> RAX: ffffffffffffffda RBX: 0000000000000095 RCX: 00005610511e23cd
> RDX: 0000000000000090 RSI: 00007f5357fc8410 RDI: 0000000000000005
> RBP: 0000000000000000 R08: 00007f5357fca458 R09: 00007f5350005520
> R10: 0000000000000000 R11: 0000000000000246 R12: 000000000000002b
> R13: 0000000d00000000 R14: 000000000000002b R15: 000000000000002b
>  </TASK>
>=20
> If remove insn #20, the verifier gives:
>  -------- Verifier Log --------
>  func#0 @0
>  0: R1=3Dctx(off=3D0,imm=3D0) R10=3Dfp0
>  0: (bc) w0 =3D w1                       ;
> R0_w=3Dscalar(smin=3D0,smax=3Dumax=3D4294967295,var_off=3D(0x0; 0xfffffff=
f))
> R1=3Dctx(off=3D0,
>  imm=3D0)
>  1: (bf) r2 =3D r0                       ;
> R0_w=3Dscalar(id=3D1,smin=3D0,smax=3Dumax=3D4294967295,var_off=3D(0x0;
> 0xffffffff))
>  R2_w=3Dscalar(id=3D1,smin=3D0,smax=3Dumax=3D4294967295,var_off=3D(0x0; 0=
xffffffff))
>  2: (18) r3 =3D 0xd                      ; R3_w=3D13
>  4: (bc) w4 =3D w0                       ;
> R0_w=3Dscalar(id=3D1,smin=3D0,smax=3Dumax=3D4294967295,var_off=3D(0x0;
> 0xffffffff))
>  R4_w=3Dscalar(id=3D1,smin=3D0,smax=3Dumax=3D4294967295,var_off=3D(0x0; 0=
xffffffff))
>  5: (bf) r5 =3D r0                       ;
> R0_w=3Dscalar(id=3D1,smin=3D0,smax=3Dumax=3D4294967295,var_off=3D(0x0;
> 0xffffffff))
>  R5_w=3Dscalar(id=3D1,smin=3D0,smax=3Dumax=3D4294967295,var_off=3D(0x0; 0=
xffffffff))
>  6: (bf) r7 =3D r3                       ; R3_w=3D13 R7_w=3D13
>  7: (bf) r8 =3D r4                       ;
> R4_w=3Dscalar(id=3D1,smin=3D0,smax=3Dumax=3D4294967295,var_off=3D(0x0;
> 0xffffffff))
>  R8_w=3Dscalar(id=3D1,smin=3D0,smax=3Dumax=3D4294967295,var_off=3D(0x0; 0=
xffffffff))
>  8: (2f) r8 *=3D r5                      ;
> R5_w=3Dscalar(id=3D1,smin=3D0,smax=3Dumax=3D4294967295,var_off=3D(0x0;
> 0xffffffff))
>  R8_w=3Dscalar()
>  9: (cf) r5 s>>=3D r5                    ; R5_w=3Dscalar()
>  10: (a6) if w8 < 0xfffffffb goto pc+9         ;
> R8_w=3Dscalar(smin=3D-9223372032559808520,umin=3D4294967288,smin32=3D-5,s=
max32=3D-1,
>  umin32=3D4294967291,var_off=3D(0xfffffff8; 0xffffffff00000007))
>  11: (1f) r7 -=3D r5                     ; R5_w=3Dscalar() R7_w=3Dscalar(=
)
>  12: (71) r6 =3D *(u8 *)(r1 +17)         ; R1=3Dctx(off=3D0,imm=3D0)
> R6_w=3Dscalar(smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D255,
>  var_off=3D(0x0; 0xff))
>  13: (5f) r3 &=3D r8                     ;
> R3_w=3Dscalar(smin=3Dumin=3Dsmin32=3Dumin32=3D8,smax=3Dumax=3Dsmax32=3Dum=
ax32=3D13,var_off=3D(0x8;
>  0x5)) R8_w=3Dscalar(smin=3D-9223372032559808520,umin=3D4294967288,smin32=
=3D-5,smax32=3D-1,umin32=3D4294967291,var_off=3D(0xffff)
>  14: (74) w2 >>=3D 30                    ;
> R2_w=3Dscalar(smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D3,var_off=
=3D(0x0;
> 0x3))
>  15: (1f) r7 -=3D r5                     ; R5_w=3Dscalar() R7_w=3Dscalar(=
)
>  16: (5d) if r8 !=3D r6 goto pc+3        ;
> R6_w=3Dscalar(smin=3Dumin=3Dumin32=3D4294967288,smax=3Dumax=3Dumax32=3D25=
5,smin32=3D-8,smax32=3D-1,
>  var_off=3D(0xfffffff8; 0x7))
> R8_w=3Dscalar(smin=3Dumin=3D4294967288,smax=3Dumax=3D255,smin32=3D-5,smax=
32=3D-1,umin32=3D4294967291)
>  17: (c7) r8 s>>=3D 5                    ; R8_w=3D134217727
>  18: (cf) r0 s>>=3D r0                   ; R0_w=3Dscalar()
>  19: (7f) r0 >>=3D r0                    ; R0=3Dscalar()
>  20: (95) exit
>=20
>  from 16 to 20: safe
>=20
>  from 10 to 20: safe
>  processed 22 insns (limit 1000000) max_states_per_insn 0 total_states
> 1 peak_states 1 mark_read 1
> -------- End of Verifier Log --------
>=20
> In adjust_scalar_min_max_vals(), src_reg.umax_value is 7, thus pass
> the check here:
>          if (umax_val >=3D insn_bitness) {
>              /* Shifts greater than 31 or 63 are undefined.
>               * This includes shifts by a negative number.
>               */
>              mark_reg_unknown(env, regs, insn->dst_reg);
>              break;
>          }
>=20
> However in scalar32_min_max_rsh(), both src_reg->u32_min_value and
> src_reg->u32_max_value is 134217727, causing tnum_rsh() shit by 255.
>=20
> Should we check if(src_reg->u32_max_value < insn_bitness) before calling
> scalar32_min_max_rsh(), rather than only checking umax_val? Or, is it
> because issues somewhere else, incorrectly setting u32_min_value to
> 34217727
>=20
> Best
> Hao Sun
>=20


