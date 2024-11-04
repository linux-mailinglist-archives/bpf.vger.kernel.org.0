Return-Path: <bpf+bounces-43920-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC5B9BBD3B
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 19:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 176BA284748
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 18:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9395B1C9EDB;
	Mon,  4 Nov 2024 18:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WgQK3Eso"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE531C9B81
	for <bpf@vger.kernel.org>; Mon,  4 Nov 2024 18:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730744599; cv=none; b=QZ47RTXSWv99lU/LTGoC0HjTYMNh8MPYnGH3oKxLoXwxAfubgiAm8nJZpOealoFuzTSXPMS2dJK2fl/gO2W4LxM5BNv1MUJLuEPkLOJJ3cX2j+tZbwpAyd5QedKz4n2O+BX4BkWEpeLr0Wx+8oholx1sgUCEvurIkD1Gd0s+RlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730744599; c=relaxed/simple;
	bh=79I1UhRN+jTllDdhOqzAA5u9ZLJNbGLn+uvmzI6GyFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DufgEkLfhE0d6lRHIWxs9CwgcWzNo2rIQIjepuI15jI7J5NjP+dpJAnkUNwCvxLUe5pQQEnEYHZN68ZaXyi/Iggf3QpbBewdeDt2fBqiC6L+BOz7M7/rNjvl67gG8TVDx4VYvb2yoDDQY0mS0kIMzTbUr0inBKW6mD/Dx3FNX54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WgQK3Eso; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37d4d1b48f3so2651048f8f.1
        for <bpf@vger.kernel.org>; Mon, 04 Nov 2024 10:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730744595; x=1731349395; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZOsar1JVkKQ1IT72kRe7QjsGdKYGp0vaFNV9/YQdXhk=;
        b=WgQK3EsooVMaoFiKf8KJ/asb4S50M5WEHLL/6zVtYOnxbD5FmGEH/VoLqm/i0VlDBX
         KFqKS36PQc6BU3TWvd4/thsyj4eX9I1e8R3WLZFlfdShYt5gbP3x0D0PRsp7O7Ga4njd
         f5z9yv8En/hMi2HN9gyTnW9HLot0fZv97l4/dDkbgoKIgVequ7sYeURzEVvoiBKIo+ct
         Nufy1UyXu8TLP4A6NlN8RT2cVgrOlK8oo0fzpdlLuITEcp4Qwgqvz0SleQts7q63nFx/
         02b1v2YqWpxNeDDH5V3IgVgceqo10SZV1BLO68zqS6mnmVkO6q+xlzimpFADniqsih5a
         Cnaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730744595; x=1731349395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZOsar1JVkKQ1IT72kRe7QjsGdKYGp0vaFNV9/YQdXhk=;
        b=EK1OyFaa7dvBDxM5ZfxOAMLOZba+cJQH/C1BnHy2B6DEZZP55T2Um5pJzvxz/eeSHN
         ZR7c7ivVpuqiwwU8LWhXUxl+fYxeZIvnQVar56qazKxVtTjdSnCdK9c3UBVHG5WdCL+2
         hv4IVEVxIuxNiv5F0CFL93XkFTZ4iQVwP9TzVoNaK0sgmuImAqzEYdZyS7QopZwro2rQ
         e4ZwmFKSdGoJOYBTFB5bwO5dtCkD97VemagjUpwbIwgak20gYZSFDnQjmyPttKZfJv1l
         K5SVkprVbKMLWTQj844P8OhdyKkCvDtT4l+eNNHDYKjs90jovBaa7uSlYgA4TBEXypkr
         0Few==
X-Gm-Message-State: AOJu0YznEOF9inkN4U6PJuFiJ+SINCz8BlVnnPI1trpg8A5gtm4Fiy9T
	c57p6H/eBQt5JEBFZ8LVKzOP+5n2LfVPQbj0raRvDHbyDSN8caysEYCnJB8EoX7/8b4h6Bvt0IM
	aUgdFjD2KG4Lz+iRJvRclQX8Zji01QNgz
X-Google-Smtp-Source: AGHT+IE+X5l150ux6swjOsvV344MxdVlchxYgxUXIuiX8F1XNg1ZZthH+9Q+zp/td4gt8cClKTUKqwTdl9/d8RQSA0k=
X-Received: by 2002:a5d:6388:0:b0:374:c059:f2c5 with SMTP id
 ffacd0b85a97d-381b7076de7mr13506916f8f.22.1730744595492; Mon, 04 Nov 2024
 10:23:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZykIaV1yyTUOI8yF@himmelriiki>
In-Reply-To: <ZykIaV1yyTUOI8yF@himmelriiki>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 4 Nov 2024 10:23:03 -0800
Message-ID: <CAADnVQK6ThUP34gz2mVpHeN0TvBjD3xtYFNO1SLSkJw6zSZz_g@mail.gmail.com>
Subject: Re: program of this type cannot use helper xyz with bpf_struct_ops
To: Mikko Ylinen <mikko.ylinen@linux.intel.com>
Cc: bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024 at 9:46=E2=80=AFAM Mikko Ylinen
<mikko.ylinen@linux.intel.com> wrote:
>
> Hi,
>
> I was experimenting with struct_ops for my use-case but the programs
> would not load because of "program of this type cannot use helper
> xyz" error. However, [1] suggests that the ones I tried *are* supported.
> Is the doc outdated or my steps are simply wrong here?
>
> Andrii suggested to report the case here with reproduce steps so here
> it goes.
>
> with:
>
> diff --git a/tools/testing/selftests/bpf/progs/dummy_st_ops_success.c b/t=
ools/testing/selftests/bpf/progs/dummy_st_ops_success.c
> index ec0c595d47af..c3ca873957f0 100644
> --- a/tools/testing/selftests/bpf/progs/dummy_st_ops_success.c
> +++ b/tools/testing/selftests/bpf/progs/dummy_st_ops_success.c
> @@ -39,6 +39,7 @@ int BPF_PROG(test_2, struct bpf_dummy_ops_state *state,=
 int a1, unsigned short a
>         test_2_args[2] =3D a2;
>         test_2_args[3] =3D a3;
>         test_2_args[4] =3D a4;
> +       bpf_printk("struct_ops/test_2");
>         return 0;
>  }
>
> and:
> tools/testing/selftests/bpf/vmtest.sh -- ./test_progs -t dummy_st_ops/dum=
my_st_ops_attach
>
> I get:
>
> [build + VM boot cut out]
> ./test_progs -t dummy_st_ops/dummy_st_ops_attach
> [    1.068102] bpf_testmod: loading out-of-tree module taints kernel.
> [    1.068733] bpf_testmod: module verification failed: signature and/or =
required key missing - tainting kernel
> tester_init:PASS:tester_log_buf 0 nsec
> process_subtest:PASS:obj_open_mem 0 nsec
> process_subtest:PASS:specs_alloc 0 nsec
> libbpf: prog 'test_2': BPF program load failed: Invalid argument
> libbpf: prog 'test_2': -- BEGIN PROG LOAD LOG --
> 0: R1=3Dctx() R10=3Dfp0
> ; int BPF_PROG(test_2, struct bpf_dummy_ops_state *state, int a1, unsigne=
d short a2, @ dummy_st_ops_success.c:40
> 0: (79) r2 =3D *(u64 *)(r1 +0)
> func 'test_2' arg0 has btf_id 83075 type STRUCT 'bpf_dummy_ops_state'
> 1: R1=3Dctx() R2_w=3Dtrusted_ptr_bpf_dummy_ops_state()
> ; test_2_args[0] =3D state->val; @ dummy_st_ops_success.c:43
> 1: (61) r2 =3D *(u32 *)(r2 +0)          ; R2_w=3Dscalar(smin=3D0,smax=3Du=
max=3D0xffffffff,var_off=3D(0x0; 0xffffffff))
> ; int BPF_PROG(test_2, struct bpf_dummy_ops_state *state, int a1, unsigne=
d short a2, @ dummy_st_ops_success.c:40
> 2: (79) r3 =3D *(u64 *)(r1 +8)          ; R1=3Dctx() R3_w=3Dscalar()
> 3: (79) r4 =3D *(u64 *)(r1 +16)         ; R1=3Dctx() R4_w=3Dscalar()
> 4: (79) r5 =3D *(u64 *)(r1 +24)         ; R1=3Dctx() R5_w=3Dscalar()
> 5: (79) r1 =3D *(u64 *)(r1 +32)         ; R1_w=3Dscalar()
> ; test_2_args[0] =3D state->val; @ dummy_st_ops_success.c:43
> 6: (18) r0 =3D 0xffffb456400f6000       ; R0_w=3Dmap_value(map=3Ddummy_st=
.bss,ks=3D4,vs=3D40)
> ; test_2_args[4] =3D a4; @ dummy_st_ops_success.c:47
> 8: (7b) *(u64 *)(r0 +32) =3D r1         ; R0_w=3Dmap_value(map=3Ddummy_st=
.bss,ks=3D4,vs=3D40) R1_w=3Dscalar()
> ; test_2_args[3] =3D a3; @ dummy_st_ops_success.c:46
> 9: (67) r5 <<=3D 56                     ; R5_w=3Dscalar(smax=3D0x7f000000=
00000000,umax=3D0xff00000000000000,smin32=3D0,smax32=3Dumax32=3D0,var_off=
=3D(0x0; 0xff00000000000000))
> 10: (c7) r5 s>>=3D 56                   ; R5_w=3Dscalar(smin=3Dsmin32=3D-=
128,smax=3Dsmax32=3D127)
> 11: (7b) *(u64 *)(r0 +24) =3D r5        ; R0_w=3Dmap_value(map=3Ddummy_st=
.bss,ks=3D4,vs=3D40) R5_w=3Dscalar(smin=3Dsmin32=3D-128,smax=3Dsmax32=3D127=
)
> ; int BPF_PROG(test_2, struct bpf_dummy_ops_state *state, int a1, unsigne=
d short a2, @ dummy_st_ops_success.c:40
> 12: (57) r4 &=3D 65535                  ; R4_w=3Dscalar(smin=3Dsmin32=3D0=
,smax=3Dumax=3Dsmax32=3Dumax32=3D0xffff,var_off=3D(0x0; 0xffff))
> ; test_2_args[2] =3D a2; @ dummy_st_ops_success.c:45
> 13: (7b) *(u64 *)(r0 +16) =3D r4        ; R0_w=3Dmap_value(map=3Ddummy_st=
.bss,ks=3D4,vs=3D40) R4_w=3Dscalar(smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=
=3Dumax32=3D0xffff,var_off=3D(0x0; 0xffff))
> ; test_2_args[1] =3D a1; @ dummy_st_ops_success.c:44
> 14: (67) r3 <<=3D 32                    ; R3_w=3Dscalar(smax=3D0x7fffffff=
00000000,umax=3D0xffffffff00000000,smin32=3D0,smax32=3Dumax32=3D0,var_off=
=3D(0x0; 0xffffffff00000000))
> 15: (c7) r3 s>>=3D 32                   ; R3_w=3Dscalar(smin=3D0xffffffff=
80000000,smax=3D0x7fffffff)
> 16: (7b) *(u64 *)(r0 +8) =3D r3         ; R0_w=3Dmap_value(map=3Ddummy_st=
.bss,ks=3D4,vs=3D40) R3_w=3Dscalar(smin=3D0xffffffff80000000,smax=3D0x7ffff=
fff)
> ; test_2_args[0] =3D state->val; @ dummy_st_ops_success.c:43
> 17: (67) r2 <<=3D 32                    ; R2_w=3Dscalar(smax=3D0x7fffffff=
00000000,umax=3D0xffffffff00000000,smin32=3D0,smax32=3Dumax32=3D0,var_off=
=3D(0x0; 0xffffffff00000000))
> 18: (c7) r2 s>>=3D 32                   ; R2_w=3Dscalar(smin=3D0xffffffff=
80000000,smax=3D0x7fffffff)
> 19: (7b) *(u64 *)(r0 +0) =3D r2         ; R0_w=3Dmap_value(map=3Ddummy_st=
.bss,ks=3D4,vs=3D40) R2_w=3Dscalar(smin=3D0xffffffff80000000,smax=3D0x7ffff=
fff)
> ; bpf_printk("struct_ops/test_2"); @ dummy_st_ops_success.c:48
> 20: (18) r1 =3D 0xffff9481c114e5d8      ; R1_w=3Dmap_value(map=3Ddummy_st=
.rodata,ks=3D4,vs=3D18)
> 22: (b4) w2 =3D 18                      ; R2_w=3D18
> 23: (85) call bpf_trace_printk#6
> program of this type cannot use helper bpf_trace_printk#6
> processed 22 insns (limit 1000000) max_states_per_insn 0 total_states 0 p=
eak_states 0 mark_read 0
> -- END PROG LOAD LOG --
> libbpf: prog 'test_2': failed to load: -22
> libbpf: failed to load object 'dummy_st_ops_success'
> libbpf: failed to load BPF skeleton 'dummy_st_ops_success': -22
> test_dummy_st_ops_attach:FAIL:dummy_st_ops_load unexpected error: -22
> #84/1    dummy_st_ops/dummy_st_ops_attach:FAIL
> #84      dummy_st_ops:FAIL
>

This is expected.
Each struct_ops has its own .get_func_proto callback.
This is a dummy struct_ops for testing. It doesn't allow
calling any helpers. get_func_proto is not set:

static const struct bpf_verifier_ops bpf_dummy_verifier_ops =3D {
        .is_valid_access =3D bpf_dummy_ops_is_valid_access,
        .btf_struct_access =3D bpf_dummy_ops_btf_struct_access,
};

