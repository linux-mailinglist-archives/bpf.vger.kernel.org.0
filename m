Return-Path: <bpf+bounces-34097-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3FD92A74B
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 18:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57455B20DCE
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 16:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2424F145B37;
	Mon,  8 Jul 2024 16:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ECPMr5Qn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61E278C7F
	for <bpf@vger.kernel.org>; Mon,  8 Jul 2024 16:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720456093; cv=none; b=sc3fRZHqwpEZSQjFQJxcuNwbt6rtg0XNIIB3Z3hrj5wJ0KHwP2Pn3WfXLF4kKXvOqypIjwLaAUf0o/7cwbVBV120D9Cq9xrg9k+iBcBy/rKYyuHwek87eL4dvDQZAZKLx2bP3BW+uELGC0h+Lqhwbq5Rx/vvAdAtNeVgm/EZXts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720456093; c=relaxed/simple;
	bh=qSxmgG31V84IoW+rfSXF6dFGnH+7qVz8oVGSTT/MjME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X11+DELXkmTYejbxlhC7vhtjcbC5wRhR9LriPQ9Z5qtpdoNFp5baGNrRJCMurSvaGHm4gCLK6XBwWYBcbNfxaS1h/KvYCVZKbMIeKe83Tp2UV1zbYn37wY8iqib9e+7WG8+D9GlYcByXL8W6emvewgD62HzGZyHA03lba25KWVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ECPMr5Qn; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4266ea6a412so3732155e9.1
        for <bpf@vger.kernel.org>; Mon, 08 Jul 2024 09:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720456090; x=1721060890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EIc3uMCsU63XHCjaySruH1YzOND8NBN6heYRarwKbtM=;
        b=ECPMr5QnDmx5jIPqlchOA/kUSDmoBSbtUaPUK6Ck8vuMv1UaHaqGX4q4SWLDvwGYNi
         K/yKctVJOEetWMUbIel+UpekRq2EhK2Hx5EqGSihUAube6g6cBul52o9kbIUvpKwjyOb
         gOeQJMa2CyLhvUZNhpyCvnBjViBh4sRnoLAHvQPVB7Ef/dakQBEI3AacMdSrWnQgmjCj
         PbgScwck5sC+Bf9qvQm3CrLTupim3z7bzi6W/qx0CskgApTKpfVlNAghTbWzuQXnZ5RU
         k6HfAPrqc+3ZHF3J5jf4KfRiAiZI4SpX7vFQcsjD54XgO6ltZrrtHzs9p1NZmKwS5ebY
         FZIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720456090; x=1721060890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EIc3uMCsU63XHCjaySruH1YzOND8NBN6heYRarwKbtM=;
        b=thsAeHoSx6Zr3yHBoJj5ZvAsCJdt2LwCGHZvghh9VVimQ1xTaOFmImbqyH6U/eDwRk
         T9eGWoNecWKukTCBFNcGIz9XVOHYWpkFb9KQpnHIyhapP944zo4cDk7B2V41tafBq0dn
         ZF0UmRR1NWhLe0rM4hY+MIwXmiXcPG0jhHDjZnBy3s+4hPfeuocUFv8SPXWCDOPcTlp2
         n2BDNw9qgiTV0n3AeqwrmpKuG7yA2QarZAfbcpnrOulrrtvWyqh0i8EWcnid1cuuWeZ7
         fObdOAMmvEyNrHd63kVaEUYdEtN7Rtduw9tWXOZOJMnyA/UCxlfMXDwACjYHcYptnpmq
         VksA==
X-Gm-Message-State: AOJu0YzVZ8yh102nvcvP/yiBjegS2Re0X0K/H3PMU9Cac+dDZSRRvZ+R
	Lt7M23DIPMmPrY0nwNILVDPERjGrW0dg28WriuqGjey8RSoRTdCnVra00/Oi/FTV1/Hr0GxK+9O
	soEsvB4KIgze8l3ouRb7pThgD0zo=
X-Google-Smtp-Source: AGHT+IElZJVtiqEADJTH39V3dQH5zbrUjTsDf/DJAXMuZQW5U0BDVkbFCgJGmf4Y826Jj3n8tWCsHqTpzfebURs1Gpo=
X-Received: by 2002:a05:600c:54ca:b0:426:6902:7053 with SMTP id
 5b1f17b1804b1-426707cc0d7mr769145e9.15.1720456090059; Mon, 08 Jul 2024
 09:28:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708154634.283426-1-yonghong.song@linux.dev>
In-Reply-To: <20240708154634.283426-1-yonghong.song@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 8 Jul 2024 09:27:58 -0700
Message-ID: <CAADnVQL4YenuuaAjpW0T7mHv=LEk4xZHS2W=OF6QJsUPL700ZQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Workaround iters/iter_arr_with_actual_elem_count
 failure when -mcpu=cpuv4
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 8:46=E2=80=AFAM Yonghong Song <yonghong.song@linux.d=
ev> wrote:
>
> With latest llvm19, the selftest iters/iter_arr_with_actual_elem_count
> failed with -mcpu=3Dv4.
>
> The following are the details:
>   0: R1=3Dctx() R10=3Dfp0
>   ; int iter_arr_with_actual_elem_count(const void *ctx) @ iters.c:1420
>   0: (b4) w7 =3D 0                        ; R7_w=3D0
>   ; int i, n =3D loop_data.n, sum =3D 0; @ iters.c:1422
>   1: (18) r1 =3D 0xffffc90000191478       ; R1_w=3Dmap_value(map=3Diters.=
bss,ks=3D4,vs=3D1280,off=3D1144)
>   3: (61) r6 =3D *(u32 *)(r1 +128)        ; R1_w=3Dmap_value(map=3Diters.=
bss,ks=3D4,vs=3D1280,off=3D1144) R6_w=3Dscalar(smin=3D0,smax=3Dumax=3D0xfff=
fffff,var_off=3D(0x0; 0xffffffff))
>   ; if (n > ARRAY_SIZE(loop_data.data)) @ iters.c:1424
>   4: (26) if w6 > 0x20 goto pc+27       ; R6_w=3Dscalar(smin=3Dsmin32=3D0=
,smax=3Dumax=3Dsmax32=3Dumax32=3D32,var_off=3D(0x0; 0x3f))
>   5: (bf) r8 =3D r10                      ; R8_w=3Dfp0 R10=3Dfp0
>   6: (07) r8 +=3D -8                      ; R8_w=3Dfp-8
>   ; bpf_for(i, 0, n) { @ iters.c:1427
>   7: (bf) r1 =3D r8                       ; R1_w=3Dfp-8 R8_w=3Dfp-8
>   8: (b4) w2 =3D 0                        ; R2_w=3D0
>   9: (bc) w3 =3D w6                       ; R3_w=3Dscalar(id=3D1,smin=3Ds=
min32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D32,var_off=3D(0x0; 0x3f)) R6_w=3D=
scalar(id=3D1,smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D32,var_off=
=3D(0x0; 0x3f))
>   10: (85) call bpf_iter_num_new#45179          ; R0=3Dscalar() fp-8=3Dit=
er_num(ref_id=3D2,state=3Dactive,depth=3D0) refs=3D2
>   11: (bf) r1 =3D r8                      ; R1=3Dfp-8 R8=3Dfp-8 refs=3D2
>   12: (85) call bpf_iter_num_next#45181 13: R0=3Drdonly_mem(id=3D3,ref_ob=
j_id=3D2,sz=3D4) R6=3Dscalar(id=3D1,smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=
=3Dumax32=3D32,var_off=3D(0x0; 0x3f)) R7=3D0 R8=3Dfp-8 R10=3Dfp0 fp-8=3Dite=
r_num(ref_id=3D2,state=3Dactive,depth=3D1) refs=3D2
>   ; bpf_for(i, 0, n) { @ iters.c:1427
>   13: (15) if r0 =3D=3D 0x0 goto pc+2       ; R0=3Drdonly_mem(id=3D3,ref_=
obj_id=3D2,sz=3D4) refs=3D2
>   14: (81) r1 =3D *(s32 *)(r0 +0)         ; R0=3Drdonly_mem(id=3D3,ref_ob=
j_id=3D2,sz=3D4) R1_w=3Dscalar(smin=3D0xffffffff80000000,smax=3D0x7fffffff)=
 refs=3D2
>   15: (ae) if w1 < w6 goto pc+4 20: R0=3Drdonly_mem(id=3D3,ref_obj_id=3D2=
,sz=3D4) R1=3Dscalar(smin=3D0xffffffff80000000,smax=3Dsmax32=3Dumax32=3D31,=
umax=3D0xffffffff0000001f,smin32=3D0,var_off=3D(0x0; 0xffffffff0000001f)) R=
6=3Dscalar(id=3D1,smin=3Dumin=3Dsmin32=3Dumin32=3D1,smax=3Dumax=3Dsmax32=3D=
umax32=3D32,var_off=3D(0x0; 0x3f)) R7=3D0 R8=3Dfp-8 R10=3Dfp0 fp-8=3Diter_n=
um(ref_id=3D2,state=3Dactive,depth=3D1) refs=3D2
>   ; sum +=3D loop_data.data[i]; @ iters.c:1429
>   20: (67) r1 <<=3D 2                     ; R1_w=3Dscalar(smax=3D0x7fffff=
fc0000007c,umax=3D0xfffffffc0000007c,smin32=3D0,smax32=3Dumax32=3D124,var_o=
ff=3D(0x0; 0xfffffffc0000007c)) refs=3D2
>   21: (18) r2 =3D 0xffffc90000191478      ; R2_w=3Dmap_value(map=3Diters.=
bss,ks=3D4,vs=3D1280,off=3D1144) refs=3D2
>   23: (0f) r2 +=3D r1
>   math between map_value pointer and register with unbounded min value is=
 not allowed
>
> The source code:
>   int iter_arr_with_actual_elem_count(const void *ctx)
>   {
>         int i, n =3D loop_data.n, sum =3D 0;
>
>         if (n > ARRAY_SIZE(loop_data.data))
>                 return 0;
>
>         bpf_for(i, 0, n) {
>                 /* no rechecking of i against ARRAY_SIZE(loop_data.n) */
>                 sum +=3D loop_data.data[i];
>         }
>
>         return sum;
>   }
>
> The insn #14 is a sign-extenstion load which is related to 'int i'.
> The insn #15 did a subreg comparision. Note that smin=3D0xffffffff8000000=
0 and this caused later
> insn #23 failed verification due to unbounded min value.
>
> Actually insn #15 smin range can be better. Since after comparison, we kn=
ow smin32=3D0 and smax32=3D32.
> With insn #14 being a sign-extension load. We will know top 32bits should=
 be 0 as well.
> Current verifier is not able to handle this, and this patch is a workarou=
nd to fix
> test failure by changing variable 'i' type from 'int' to 'unsigned' which=
 will give
> proper range during comparison.
>
>   ; bpf_for(i, 0, n) { @ iters.c:1428
>   13: (15) if r0 =3D=3D 0x0 goto pc+2       ; R0=3Drdonly_mem(id=3D3,ref_=
obj_id=3D2,sz=3D4) refs=3D2
>   14: (61) r1 =3D *(u32 *)(r0 +0)         ; R0=3Drdonly_mem(id=3D3,ref_ob=
j_id=3D2,sz=3D4) R1_w=3Dscalar(smin=3D0,smax=3Dumax=3D0xffffffff,var_off=3D=
(0x0; 0xffffffff)) refs=3D2
>   ...
>   from 15 to 20: R0=3Drdonly_mem(id=3D3,ref_obj_id=3D2,sz=3D4) R1=3Dscala=
r(smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D31,var_off=3D(0x0; 0x1f=
)) R6=3Dscalar(id=3D1,smin=3Dumin=3Dsmin32=3Dumin32=3D1,smax=3Dumax=3Dsmax3=
2=3Dumax32=3D32,var_off=3D(0x0; 0x3f)) R7=3D0 R8=3Dfp-8 R10=3Dfp0 fp-8=3Dit=
er_num(ref_id=3D2,state=3Dactive,depth=3D1) refs=3D2
>   20: R0=3Drdonly_mem(id=3D3,ref_obj_id=3D2,sz=3D4) R1=3Dscalar(smin=3Dsm=
in32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D31,var_off=3D(0x0; 0x1f)) R6=3Dsca=
lar(id=3D1,smin=3Dumin=3Dsmin32=3Dumin32=3D1,smax=3Dumax=3Dsmax32=3Dumax32=
=3D32,var_off=3D(0x0; 0x3f)) R7=3D0 R8=3Dfp-8 R10=3Dfp0 fp-8=3Diter_num(ref=
_id=3D2,state=3Dactive,depth=3D1) refs=3D2
>   ; sum +=3D loop_data.data[i]; @ iters.c:1430
>   20: (67) r1 <<=3D 2                     ; R1_w=3Dscalar(smin=3Dsmin32=
=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D124,var_off=3D(0x0; 0x7c)) refs=3D2
>   21: (18) r2 =3D 0xffffc90000185478      ; R2_w=3Dmap_value(map=3Diters.=
bss,ks=3D4,vs=3D1280,off=3D1144) refs=3D2
>   23: (0f) r2 +=3D r1
>   mark_precise: frame0: last_idx 23 first_idx 20 subseq_idx -1
>   ...
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  tools/testing/selftests/bpf/progs/iters.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/progs/iters.c b/tools/testing/se=
lftests/bpf/progs/iters.c
> index 16bdc3e25591..d1801d151a12 100644
> --- a/tools/testing/selftests/bpf/progs/iters.c
> +++ b/tools/testing/selftests/bpf/progs/iters.c
> @@ -1419,7 +1419,8 @@ SEC("raw_tp")
>  __success
>  int iter_arr_with_actual_elem_count(const void *ctx)
>  {
> -       int i, n =3D loop_data.n, sum =3D 0;
> +       unsigned i;
> +       int n =3D loop_data.n, sum =3D 0;
>
>         if (n > ARRAY_SIZE(loop_data.data))
>                 return 0;

I think we only have one realistic test that
checks 'range vs range' verifier logic.
Since "int i; bpf_for(i"
is a very common pattern in all other bpf_for tests it feels
wrong to workaround like this.

What exactly needs to be improved in 'range vs range' logic to
handle this case?

