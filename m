Return-Path: <bpf+bounces-14308-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D5A7E2D29
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 20:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6299280636
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 19:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D135182C8;
	Mon,  6 Nov 2023 19:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ck63JXfY"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0572F39
	for <bpf@vger.kernel.org>; Mon,  6 Nov 2023 19:47:36 +0000 (UTC)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AEEB103
	for <bpf@vger.kernel.org>; Mon,  6 Nov 2023 11:47:34 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9bf86b77a2aso719508766b.0
        for <bpf@vger.kernel.org>; Mon, 06 Nov 2023 11:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699300053; x=1699904853; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gbs9NK4FuHDf3D8fQTItMB56nrX14FuMF5Y+6e4DZQY=;
        b=Ck63JXfYM+v2FWiYccMaOO019LEImBWjZiPy9tbOPPF6Cgnqzts3iw0C63U6Ev1yEU
         zOtFp3aWPa+ZHuwGPe9qEED0hHbOCvJzZ56gDkpHEqAtC82QX9i0aPyV+VPyDzm8dIq9
         UN02Oq5xp/wcNRMMpiD3UNzfD+hjUnneVZW7l7s/qwz9EuNtq78BfbVjnTIwfS5mTvuu
         c37sIlzW26mmF9BetHHbYSEikawmw1ruVDwPJ1GDNQStOL4zAA+fToM5n4ZAwUrcLxWa
         iQNi7SEOfk2htjzGZ42Zyd83T04H5rT37opnGcyeii4RzInp4ZRwTW2NXdr/sfLYsR+8
         9olA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699300053; x=1699904853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gbs9NK4FuHDf3D8fQTItMB56nrX14FuMF5Y+6e4DZQY=;
        b=igMyrifxFYmtolbElboAvULmm/3PuM+r2yPdXsNRufEYrtvvRZi6faWEtDRR9TuAe/
         u4Ku/PGpls9lFA6xDXnRlbcb8zrfkdG19I0OAKfk7LRm8WgjNKtiCAmOpZPota8abTXB
         mJJCDDu8/44+y2ayR4QtwO9klMctISvrfnhGgIVJLgify5gf3zqMqg9CJ+9TZRWddnol
         Qy2xYzylELGNxmpkwczQnrUPN6AREkJKpuY48csSlgSiWHsPTqmCpgCaQ/RPNgr/Qj/n
         d+6BXiDumjECEOlLoixp/53T1CVJDvzaC/BRuZpHS2upXbcJfI5lauf3ZY+AvKrkqBg6
         V8KA==
X-Gm-Message-State: AOJu0Yx9PPWfD2O0KGf8luPcLYhibiayvEI4OK3MQmmltLkPPCQDJIcw
	viIYBAE7BU0O1PC2qk0lMMIOm6FbCsTq3AfKF7k=
X-Google-Smtp-Source: AGHT+IFU803Yt07y64u8veTat5AZgbVos+JcsCXaIZoQ5k41zO2Mgrzn1SC5GWzKjQyFkY9Nqh98rvzpIq5KlUc5wD8=
X-Received: by 2002:a17:907:4cd:b0:9c2:2d0a:320c with SMTP id
 vz13-20020a17090704cd00b009c22d0a320cmr9706020ejb.46.1699300051751; Mon, 06
 Nov 2023 11:47:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231105185358.1036619-1-yonghong.song@linux.dev>
In-Reply-To: <20231105185358.1036619-1-yonghong.song@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 6 Nov 2023 11:47:20 -0800
Message-ID: <CAEf4BzaerjXW7v6D-29h_yBGL=wWcoyP96FjetKe9AYT1pVt5g@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Add tail padding check for
 LIBBPF_OPTS_RESET macro
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 5, 2023 at 10:54=E2=80=AFAM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
> Martin reported that there is a libbpf complaining of non-zero-value tail
> padding with LIBBPF_OPTS_RESET macro if struct bpf_netkit_opts is modifie=
d
> to have a 4-byte tail padding. This only happens to clang compiler.
> The commend line is: ./test_progs -t tc_netkit_multi_links
> Martin and I did some investigation and found this indeed the case and
> the following are the investigation details.
>
> Clang 18:
>   clang version 18.0.0 (https://github.com/llvm/llvm-project.git e00d32af=
b9d33a1eca48e2b041c9688436706c5b)
>   <I tried clang15/16/17 and they all have similar results>
>
> tools/lib/bpf/libbpf_common.h:
>   #define LIBBPF_OPTS_RESET(NAME, ...)                                   =
   \
>         do {                                                             =
   \
>                 memset(&NAME, 0, sizeof(NAME));                          =
   \
>                 NAME =3D (typeof(NAME)) {                                =
     \
>                         .sz =3D sizeof(NAME),                            =
     \
>                         __VA_ARGS__                                      =
   \
>                 };                                                       =
   \
>         } while (0)
>
>   #endif
>
> tools/lib/bpf/libbpf.h:
>   struct bpf_netkit_opts {
>         /* size of this struct, for forward/backward compatibility */
>         size_t sz;
>         __u32 flags;
>         __u32 relative_fd;
>         __u32 relative_id;
>         __u64 expected_revision;
>         size_t :0;
>   };
>   #define bpf_netkit_opts__last_field expected_revision
> In the above struct bpf_netkit_opts, there is no tail padding.
>
> prog_tests/tc_netkit.c:
>   static void serial_test_tc_netkit_multi_links_target(int mode, int targ=
et)
>   {
>         ...
>         LIBBPF_OPTS(bpf_netkit_opts, optl);
>         ...
>         LIBBPF_OPTS_RESET(optl,
>                 .flags =3D BPF_F_BEFORE,
>                 .relative_fd =3D bpf_program__fd(skel->progs.tc1),
>         );
>         ...
>   }
>
> Let us make the following source change, note that we have a 4-byte
> tailing padding now.
>   diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
>   index 6cd9c501624f..0dd83910ae9a 100644
>   --- a/tools/lib/bpf/libbpf.h
>   +++ b/tools/lib/bpf/libbpf.h
>   @@ -803,13 +803,13 @@ bpf_program__attach_tcx(const struct bpf_program =
*prog, int ifindex,
>    struct bpf_netkit_opts {
>         /* size of this struct, for forward/backward compatibility */
>         size_t sz;
>   -       __u32 flags;
>         __u32 relative_fd;
>         __u32 relative_id;
>         __u64 expected_revision;
>   +       __u32 flags;
>         size_t :0;
>    };
>   -#define bpf_netkit_opts__last_field expected_revision
>   +#define bpf_netkit_opts__last_field flags
>
> The clang 18 generated asm code looks like below:
>     ;       LIBBPF_OPTS_RESET(optl,
>     55e3: 48 8d 7d 98                   leaq    -0x68(%rbp), %rdi
>     55e7: 31 f6                         xorl    %esi, %esi
>     55e9: ba 20 00 00 00                movl    $0x20, %edx
>     55ee: e8 00 00 00 00                callq   0x55f3 <serial_test_tc_ne=
tkit_multi_links_target+0x18d3>
>     55f3: 48 c7 85 10 fd ff ff 20 00 00 00      movq    $0x20, -0x2f0(%rb=
p)
>     55fe: 48 8b 85 68 ff ff ff          movq    -0x98(%rbp), %rax
>     5605: 48 8b 78 18                   movq    0x18(%rax), %rdi
>     5609: e8 00 00 00 00                callq   0x560e <serial_test_tc_ne=
tkit_multi_links_target+0x18ee>
>     560e: 89 85 18 fd ff ff             movl    %eax, -0x2e8(%rbp)
>     5614: c7 85 1c fd ff ff 00 00 00 00 movl    $0x0, -0x2e4(%rbp)
>     561e: 48 c7 85 20 fd ff ff 00 00 00 00      movq    $0x0, -0x2e0(%rbp=
)
>     5629: c7 85 28 fd ff ff 08 00 00 00 movl    $0x8, -0x2d8(%rbp)
>     5633: 48 8b 85 10 fd ff ff          movq    -0x2f0(%rbp), %rax
>     563a: 48 89 45 98                   movq    %rax, -0x68(%rbp)
>     563e: 48 8b 85 18 fd ff ff          movq    -0x2e8(%rbp), %rax
>     5645: 48 89 45 a0                   movq    %rax, -0x60(%rbp)
>     5649: 48 8b 85 20 fd ff ff          movq    -0x2e0(%rbp), %rax
>     5650: 48 89 45 a8                   movq    %rax, -0x58(%rbp)
>     5654: 48 8b 85 28 fd ff ff          movq    -0x2d8(%rbp), %rax
>     565b: 48 89 45 b0                   movq    %rax, -0x50(%rbp)
>     ;       link =3D bpf_program__attach_netkit(skel->progs.tc2, ifindex,=
 &optl);
>
> At -O0 level, the clang compiler creates an intermediate copy.
> We have below to store 'flags' with 4-byte store and leave another 4 byte
> in the same 8-byte-aligned storage undefined,
>     5629: c7 85 28 fd ff ff 08 00 00 00 movl    $0x8, -0x2d8(%rbp)
> and later we store 8-byte to the original zero'ed buffer
>     5654: 48 8b 85 28 fd ff ff          movq    -0x2d8(%rbp), %rax
>     565b: 48 89 45 b0                   movq    %rax, -0x50(%rbp)
>
> This caused a problem as the 4-byte value at [%rbp-0x2dc, %rbp-0x2e0)
> may be garbage.
>
> gcc (gcc 11.4) does not have this issue as it does zeroing struct first b=
efore
> doing assignments:
>   ;       LIBBPF_OPTS_RESET(optl,
>     50fd: 48 8d 85 40 fc ff ff          leaq    -0x3c0(%rbp), %rax
>     5104: ba 20 00 00 00                movl    $0x20, %edx
>     5109: be 00 00 00 00                movl    $0x0, %esi
>     510e: 48 89 c7                      movq    %rax, %rdi
>     5111: e8 00 00 00 00                callq   0x5116 <serial_test_tc_ne=
tkit_multi_links_target+0x1522>
>     5116: 48 8b 45 f0                   movq    -0x10(%rbp), %rax
>     511a: 48 8b 40 18                   movq    0x18(%rax), %rax
>     511e: 48 89 c7                      movq    %rax, %rdi
>     5121: e8 00 00 00 00                callq   0x5126 <serial_test_tc_ne=
tkit_multi_links_target+0x1532>
>     5126: 48 c7 85 40 fc ff ff 00 00 00 00      movq    $0x0, -0x3c0(%rbp=
)
>     5131: 48 c7 85 48 fc ff ff 00 00 00 00      movq    $0x0, -0x3b8(%rbp=
)
>     513c: 48 c7 85 50 fc ff ff 00 00 00 00      movq    $0x0, -0x3b0(%rbp=
)
>     5147: 48 c7 85 58 fc ff ff 00 00 00 00      movq    $0x0, -0x3a8(%rbp=
)
>     5152: 48 c7 85 40 fc ff ff 20 00 00 00      movq    $0x20, -0x3c0(%rb=
p)
>     515d: 89 85 48 fc ff ff             movl    %eax, -0x3b8(%rbp)
>     5163: c7 85 58 fc ff ff 08 00 00 00 movl    $0x8, -0x3a8(%rbp)
>   ;       link =3D bpf_program__attach_netkit(skel->progs.tc2, ifindex, &=
optl);
>
> It is not clear how to resolve the compiler code generation as the compil=
er
> generates correct code w.r.t. how to handle unnamed padding in C standard=
.
> So this patch changed LIBBPF_OPTS_RESET macro by adding a static_assert
> to complain if there is a non-zero-byte tailing padding. This will effect=
ively
> enforce all *_opts struct used by LIBBPF_OPTS_RESET must have zero-byte t=
ailing
> padding.
>
> With the above changed bpf_netkit_opts layout, building the selftest with
> clang compiler, the following error will occur:
>
>   .../bpf-next/tools/testing/selftests/bpf/prog_tests/tc_netkit.c:331:2: =
error:
>     static assertion failed due to requirement 'sizeof (optl) =3D=3D (__b=
uiltin_offsetof(struct bpf_netkit_opts, flags)
>       + sizeof ((((struct bpf_netkit_opts *)0)->flags)))': Unexpected tai=
l padding
>   331 |         LIBBPF_OPTS_RESET(bpf_netkit_opts, optl,
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   332 |                 .flags =3D BPF_F_BEFORE,
>       |                 ~~~~~~~~~~~~~~~~~~~~~~
>   333 |                 .relative_fd =3D bpf_program__fd(skel->progs.tc1)=
,
>       |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   334 |         );
>       |         ~
>   .../bpf-next/tools/testing/selftests/bpf/tools/include/bpf/libbpf_commo=
n.h:98:4: note: expanded from macro 'LIBBPF_OPTS_RESET'
>    98 |                         sizeof(NAME) =3D=3D offsetofend(struct TY=
PE,            \
>       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~
>    99 |                                                     TYPE##__last_=
field),    \
>       |                                                     ~~~~~~~~~~~~~=
~~~~~~
>   .../bpf-next/tools/testing/selftests/bpf/prog_tests/tc_netkit.c:331:2: =
note: expression evaluates to '32 =3D=3D 28'
>   331 |         LIBBPF_OPTS_RESET(bpf_netkit_opts, optl,
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   332 |                 .flags =3D BPF_F_BEFORE,
>       |                 ~~~~~~~~~~~~~~~~~~~~~~
>   333 |                 .relative_fd =3D bpf_program__fd(skel->progs.tc1)=
,
>       |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   334 |         );
>       |         ~
>   .../bpf-next/tools/testing/selftests/bpf/tools/include/bpf/libbpf_commo=
n.h:98:17: note: expanded from macro 'LIBBPF_OPTS_RESET'
>    98 |                         sizeof(NAME) =3D=3D offsetofend(struct TY=
PE,            \
>       |                         ~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~
>    99 |                                                     TYPE##__last_=
field),    \
>
> Note that this patch does not provide a C++ version of changed LIBBPF_OPT=
S_RESET macro.
> It looks C++ complaining about offsetof()
>   #define offsetof(type, member)    ((unsigned long)&((type *)0)->member)
> to be used in static_assert.
>
> Cc: Martin KaFai Lau <martin.lau@kernel.org>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---

This patch is adding detection of a potential issue, but doesn't
suggest the solution. Did you have a proposed solution in mind for
cases when we do have padding at the end?

>  tools/lib/bpf/libbpf_common.h                 |   7 +-
>  .../selftests/bpf/prog_tests/tc_links.c       |  70 ++++-----
>  .../selftests/bpf/prog_tests/tc_netkit.c      |   4 +-
>  .../selftests/bpf/prog_tests/tc_opts.c        | 144 +++++++++---------
>  4 files changed, 115 insertions(+), 110 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf_common.h b/tools/lib/bpf/libbpf_common.=
h
> index b7060f254486..f74e5f3cde9c 100644
> --- a/tools/lib/bpf/libbpf_common.h
> +++ b/tools/lib/bpf/libbpf_common.h
> @@ -77,8 +77,13 @@
>   * syntax as varargs can be provided as well to reinitialize options str=
uct
>   * specific members.
>   */
> -#define LIBBPF_OPTS_RESET(NAME, ...)                                    =
   \
> +#define LIBBPF_OPTS_RESET(TYPE, NAME, ...)                              =
   \

We can't do this. It's both backwards incompatible and will breaks
existing users. And it also hurts usability a lot to have to specify
the name of the struct.

>         do {                                                             =
   \
> +               _Static_assert(                                          =
   \
> +                       sizeof(NAME) =3D=3D offsetofend(struct TYPE,     =
       \

you coun't use typeof(NAME) here?

> +                                                   TYPE##__last_field), =
   \
> +                       "Unexpected tail padding"                        =
   \
> +               );                                                       =
   \

I don't see why this static assert has to be inside
LIBBPF_OPTS_RESET() macro. We can just add it next to each opts type
declaration, if we want to enforce this.

>                 memset(&NAME, 0, sizeof(NAME));                          =
   \
>                 NAME =3D (typeof(NAME)) {                                =
     \
>                         .sz =3D sizeof(NAME),                            =
     \

[...]

