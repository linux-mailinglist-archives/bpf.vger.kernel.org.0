Return-Path: <bpf+bounces-71032-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 13067BDFBC6
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 18:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 03371505050
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 16:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50EA433EB1B;
	Wed, 15 Oct 2025 16:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CIuMgPwI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0175F33EB06
	for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 16:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760546720; cv=none; b=b3nqJtntxgC1QgjJqPPL0rPSSbIHvwAaTG1iFuEh/NYoRfV6zgoxbjRbWu/j2x9J36sz52bi4zsX6zcxtkxLN9xWY7+3zZv4I0qaNgc9W8DKFH7bAP0fAmJZ4+GXaSBMjrGZeux2Mt/JpaLLY1xx2ysIhdo3xpL05k6eX8C+p2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760546720; c=relaxed/simple;
	bh=URingBQR753jmlXPZV/yHvn8bP0duqlzIE/FbS/FK2o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ar2NEdP37m1dDscyYPBnicNvLRCHBVVz49Iq4BpkRZPW1cjwlxC0YixttQsttdbQWdvMFeswZDzUglfLaBN2aHYQaQ/+IJM0j3D3G80CdcmRJUGtTLT63Z/Ni0plNG1jZRqh8BQ5AqbAyOD94SRfsQ/UhTx8om6QY+hhrTPUQPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CIuMgPwI; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7810289cd4bso6493502b3a.2
        for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 09:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760546718; x=1761151518; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jR7WQe9bvLq9eTGoc+9sGPpcNzcOLrlf+PgAehdTf7c=;
        b=CIuMgPwIE3594g17VsBaqCvqlglmM5zf3TysooLJbFKYrpPkdt8fy7BgxTP8xb4lME
         VsrRUhHQgMfr6qtNMI4TaH5K4S90KPzyfVyzr2bHWY1eh9iH250rDZnNiQmFPyq8Xey9
         Hr1oGAtvkjhWS/y+6G6T1Pioxu5o19h1aiNqz9bF7fJHskqhdbkivdboxUl38u2btAYe
         lY2gqMzUU4xRaLC4gxEjj+6lAbKCdnT7DCM1kzJLJXo76EMnEeisN11nuYwA/fq9am8N
         q68rE21Cy85h9kvzjvSPHiiSFsySs1BQZJMSL0Jjb31SwfXt1sxsfzdrTNjppxDp3wSn
         zpdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760546718; x=1761151518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jR7WQe9bvLq9eTGoc+9sGPpcNzcOLrlf+PgAehdTf7c=;
        b=fXYWw5kQoS2hnGHD6ev872TeuhqHWsVh3ZOiy14n6yKxQxFuF9fw6t9A9ym+1/q87K
         d4GwT1JTf+0FXX0IinSXQ5iOJwxX5srN0s/22Lb49Pw7VQoqRSdpKgaz7Y6YcCluqK5n
         QbT7r7DA74/0Yx0JrZ+0Wt+lehQIbEmhkJ4l0asFYwDEOMM11bH6qKNff3Pq+oAQng3y
         bmUZwy0zLL2YnNylFdONIudx4s2p+r6JzzSNscE3o1NMI+zscB6AxUJenpJxAMg7U3/F
         qkErbV0zzHdMvfwxZ/h3jXKV96Hli/N0h0nRBhG/wJ5wKz+/BF08gysux83xlYiYV8oM
         RLzw==
X-Gm-Message-State: AOJu0YyYC7YfLvOKZVlbcxrVXqsxa/JUrV+pQ3GNYQJn8NZf+GATNXga
	t+ixDZf0ewTYk8kioS7RmF6l5BPuijcI51v5K3DlwxYU1uOwCdDAB30jxjW4ndlO7ZvYvZS96pr
	+7x1WDfa2J2x40w6+vT4ftuy7uGLN4CU=
X-Gm-Gg: ASbGncsyoFj6cEVN+eS1QrSla38Ra4xBqlctVfqXAJonnvUC2mXbQ6uPYf3PN9w1Sae
	FBqBzBCMznbnQPCo+wO2Rl/sORk82wZ78/YKeeIKzCctAhNIdTIpdkJ2/RI+5+xHWqzr069QElz
	f5/BpJH9hJv6cpA9w5ZNlzNst1cxdma2Q9CtQnu4ulLTOMCnpD+fLM07heSpHKA+Llec+7QP40h
	DoWbjtblT7ycdjt2AjDumkH+McA3GLeUC+PL6qbGw==
X-Google-Smtp-Source: AGHT+IGur5vyllSxHprPJId4u9kW06sPWA1zZTijiwRq8NEcbm66WeQvYVrogGmz84yqbO7I0C1RAbzrNZ+i4I/krr0=
X-Received: by 2002:a05:6a21:33a6:b0:334:93f3:9b23 with SMTP id
 adf61e73a8af0-33493f39dc3mr1968471637.39.1760546717882; Wed, 15 Oct 2025
 09:45:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014051639.1996331-1-yonghong.song@linux.dev>
In-Reply-To: <20251014051639.1996331-1-yonghong.song@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 15 Oct 2025 09:45:05 -0700
X-Gm-Features: AS18NWDMN-8AfZdMjs-Hs3bnMXE26fK4Z1L0RARKLXLULcjp2lXNkrfptBgqZTU
Message-ID: <CAEf4BzaNATrMLU6SpbFAJn8er+0ouGg1Q8RRv589=opgZ8QM5A@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix selftest verif_scale_strobemeta
 failure with llvm22
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 10:16=E2=80=AFPM Yonghong Song <yonghong.song@linux=
.dev> wrote:
>
> With latest llvm22, I hit the verif_scale_strobemeta selftest failure
> below:
>   $ ./test_progs -n 618
>   libbpf: prog 'on_event': BPF program load failed: -E2BIG
>   libbpf: prog 'on_event': -- BEGIN PROG LOAD LOG --
>   BPF program is too large. Processed 1000001 insn
>   verification time 7019091 usec
>   stack depth 488
>   processed 1000001 insns (limit 1000000) max_states_per_insn 28 total_st=
ates 33927 peak_states 12813 mark_read 0
>   -- END PROG LOAD LOG --
>   libbpf: prog 'on_event': failed to load: -E2BIG
>   libbpf: failed to load object 'strobemeta.bpf.o'
>   scale_test:FAIL:expect_success unexpected error: -7 (errno 7)
>   #618     verif_scale_strobemeta:FAIL
>
> But if I increase the verificaiton insn limit from 1M to 10M, the above
> test_progs run actually will succeed. The below is the result from verist=
at:
>   $ ./veristat strobemeta.bpf.o
>   Processing 'strobemeta.bpf.o'...
>   File              Program   Verdict  Duration (us)    Insns  States  Pr=
ogram size  Jited size
>   ----------------  --------  -------  -------------  -------  ------  --=
----------  ----------
>   strobemeta.bpf.o  on_event  success       90250893  9777685  358230    =
     15954       80794
>   ----------------  --------  -------  -------------  -------  ------  --=
----------  ----------
>   Done. Processed 1 files, 0 programs. Skipped 1 files, 0 programs.
>
> Further debugging shows the llvm commit [1] is responsible for the verifi=
caiton
> failure as it tries to convert certain switch statement to if-condition. =
Such
> change may cause different transformation compared to original switch sta=
tement.
>
> In bpf program strobemeta.c case, the initial llvm ir for read_int_var() =
function is
>   define internal void @read_int_var(ptr noundef %0, i64 noundef %1, ptr =
noundef %2,
>       ptr noundef %3, ptr noundef %4) #2 !dbg !535 {
>     %6 =3D alloca ptr, align 8
>     %7 =3D alloca i64, align 8
>     %8 =3D alloca ptr, align 8
>     %9 =3D alloca ptr, align 8
>     %10 =3D alloca ptr, align 8
>     %11 =3D alloca ptr, align 8
>     %12 =3D alloca i32, align 4
>     ...
>     %20 =3D icmp ne ptr %19, null, !dbg !561
>     br i1 %20, label %22, label %21, !dbg !562
>
>   21:                                               ; preds =3D %5
>     store i32 1, ptr %12, align 4
>     br label %48, !dbg !563
>
>   22:
>     %23 =3D load ptr, ptr %9, align 8, !dbg !564
>     ...
>
>   47:                                               ; preds =3D %38, %22
>     store i32 0, ptr %12, align 4, !dbg !588
>     br label %48, !dbg !588
>
>   48:                                               ; preds =3D %47, %21
>     call void @llvm.lifetime.end.p0(ptr %11) #4, !dbg !588
>     %49 =3D load i32, ptr %12, align 4
>     switch i32 %49, label %51 [
>       i32 0, label %50
>       i32 1, label %50
>     ]
>
>   50:                                               ; preds =3D %48, %48
>     ret void, !dbg !589
>
>   51:                                               ; preds =3D %48
>     unreachable
>   }
>
> Note that the above 'switch' statement is added by clang frontend.
> Without [1], the switch statement will survive until SelectionDag,
> so the switch statement acts like a 'barrier' and prevents some
> transformation involved with both 'before' and 'after' the switch stateme=
nt.
>
> But with [1], the switch statement will be removed during middle end
> optimization and later middle end passes (esp. after inlining) have more
> freedom to reorder the code.
>
> The following is the related source code:
>
>   static void *calc_location(struct strobe_value_loc *loc, void *tls_base=
):
>         bpf_probe_read_user(&tls_ptr, sizeof(void *), dtv);
>         /* if pointer has (void *)-1 value, then TLS wasn't initialized y=
et */
>         return tls_ptr && tls_ptr !=3D (void *)-1
>                 ? tls_ptr + tls_index.offset
>                 : NULL;
>
>   In read_int_var() func, we have:
>         void *location =3D calc_location(&cfg->int_locs[idx], tls_base);
>         if (!location)
>                 return;
>
>         bpf_probe_read_user(value, sizeof(struct strobe_value_generic), l=
ocation);
>         ...
>
> The static func calc_location() is called inside read_int_var(). The asm =
code
> without [1]:
>      77: .123....89 (85) call bpf_probe_read_user#112
>      78: ........89 (79) r1 =3D *(u64 *)(r10 -368)
>      79: .1......89 (79) r2 =3D *(u64 *)(r10 -8)
>      80: .12.....89 (bf) r3 =3D r2
>      81: .123....89 (0f) r3 +=3D r1
>      82: ..23....89 (07) r2 +=3D 1
>      83: ..23....89 (79) r4 =3D *(u64 *)(r10 -464)
>      84: ..234...89 (a5) if r2 < 0x2 goto pc+13
>      85: ...34...89 (15) if r3 =3D=3D 0x0 goto pc+12
>      86: ...3....89 (bf) r1 =3D r10
>      87: .1.3....89 (07) r1 +=3D -400
>      88: .1.3....89 (b4) w2 =3D 16
> In this case, 'r2 < 0x2' and 'r3 =3D=3D 0x0' go to null 'locaiton' place,
> so the verifier actually prefers to do verification first at 'r1 =3D r10'=
 etc.
>
> The asm code with [1]:
>     119: .123....89 (85) call bpf_probe_read_user#112
>     120: ........89 (79) r1 =3D *(u64 *)(r10 -368)
>     121: .1......89 (79) r2 =3D *(u64 *)(r10 -8)
>     122: .12.....89 (bf) r3 =3D r2
>     123: .123....89 (0f) r3 +=3D r1
>     124: ..23....89 (07) r2 +=3D -1
>     125: ..23....89 (a5) if r2 < 0xfffffffe goto pc+6
>     126: ........89 (05) goto pc+17
>     ...
>     144: ........89 (b4) w1 =3D 0
>     145: .1......89 (6b) *(u16 *)(r8 +80) =3D r1
> In this case, if 'r2 < 0xfffffffe' is true, the control will go to
> non-null 'location' branch, so 'goto pc+17' will actually go to
> null 'location' branch. This seems causing tremendous amount of
> verificaiton state.
>
> To fix the issue, rewrite the following code
>   return tls_ptr && tls_ptr !=3D (void *)-1
>                 ? tls_ptr + tls_index.offset
>                 : NULL;
> to if/then statement and hopefully these explicit if/then statements
> are sticky during middle-end optimizations.

this is so fragile and non-obvious... Just looking at the patch, it's
an equivalent transformation, so as a user I'd have no clue that doing
something like that can even matter...

Have you tried adding likely() around non-NULL case? Does it change
generated code, while leaving ternary as is?

>
> Test with llvm20 and llvm21 as well and all strobemeta related selftests
> are passed.
>
>   [1] https://github.com/llvm/llvm-project/pull/161000
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  tools/testing/selftests/bpf/progs/strobemeta.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> NOTE: I will also check whether we can make changes in llvm to automatica=
lly
>  adjust branch statements to minimize verification insns/states.
>
> diff --git a/tools/testing/selftests/bpf/progs/strobemeta.h b/tools/testi=
ng/selftests/bpf/progs/strobemeta.h
> index a5c74d31a244..6e1918deaf26 100644
> --- a/tools/testing/selftests/bpf/progs/strobemeta.h
> +++ b/tools/testing/selftests/bpf/progs/strobemeta.h
> @@ -330,9 +330,9 @@ static void *calc_location(struct strobe_value_loc *l=
oc, void *tls_base)
>         }
>         bpf_probe_read_user(&tls_ptr, sizeof(void *), dtv);
>         /* if pointer has (void *)-1 value, then TLS wasn't initialized y=
et */
> -       return tls_ptr && tls_ptr !=3D (void *)-1
> -               ? tls_ptr + tls_index.offset
> -               : NULL;
> +       if (!tls_ptr || tls_ptr =3D=3D (void *)-1)
> +               return NULL;
> +       return tls_ptr + tls_index.offset;
>  }
>
>  #ifdef SUBPROGS
> --
> 2.47.3
>

