Return-Path: <bpf+bounces-14434-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A63F37E47E1
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 19:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17A21B20DF8
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 18:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66F5358A5;
	Tue,  7 Nov 2023 18:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BBRcOU+m"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD3A3589D
	for <bpf@vger.kernel.org>; Tue,  7 Nov 2023 18:10:17 +0000 (UTC)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6E48F
	for <bpf@vger.kernel.org>; Tue,  7 Nov 2023 10:10:16 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-5437d60fb7aso10099787a12.3
        for <bpf@vger.kernel.org>; Tue, 07 Nov 2023 10:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699380615; x=1699985415; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sjy+x92ORlh199HWLPENj0XIsfgbYJMPyAaZhQKOJNw=;
        b=BBRcOU+mQzm3rHmMFVJpjRkVd7X+zUn8s9sotkx7AX5mcq5TFeKrCK+DKmSRIfSv28
         Dl+6pXcPxVR2CATZu4MI+KJH7GNBBc+LVyC7aIAZTIltyLlccMM+bnOI7ztWMnAIOs2u
         Dh4BCQnJFvXeERJ6xJqYKh4hG4PNnGU75NkG8BJDq0xdwXoynZ8PA3UUtOWy41FiEda/
         OaUhfsmPiXnreUdbjlXEotr3D+IWrHnJ7VbpiO3ZTRCxvO+Dxds2PyvI8r8Q8345hkL2
         uDkKvnvZeJjNeRgSDjipgE90CZap36aF9f2F5djWaTMqasbtWfrCv29Y6ZNev31HYZpE
         4uvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699380615; x=1699985415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sjy+x92ORlh199HWLPENj0XIsfgbYJMPyAaZhQKOJNw=;
        b=Xu4GM3c6zHeDJteXehczaSZuTSZZHN9CPkRE1OrDBPBdTwND77SalSbRqgUV/aonHu
         zEem+wcPmbbJxjX2inPjpK/GXk1NNKp7RmKVJDSuPs321Vxfe0UnCjsZrIUO7GE/VMH2
         TQTdc06sb4rHveVL3gQsjNl7RcCOwfuqvEZvb2JDbPBWIjUEK24WzvoNmHm20xGRZRQV
         U4Einj2C7UYfPwweUY1pM4cZ5jgTa7f6uYAElEQx2YjktKuXzmwX9oFEx0QmQ1mUwX04
         ztQfzS6mn4KFDMQJigsSX+GhiNIDucRps0K5KJcfq0rc6TxPR4z8YFrqqt5SlsXpYz3l
         rCIA==
X-Gm-Message-State: AOJu0YxI6yx8a6Y3Ek35TM9mO05X/koAta/ADb8Trdyf572a7BWF+tWy
	HIylOEzK0SeyI0Vqi8JNGs6o3JTxORkTsTgT40M=
X-Google-Smtp-Source: AGHT+IHs4XVHTECgmWHrMt1cnTnxgeXuPDhZPVrwWHcLlQFT4HOpVs7irwL3Ho4/vfmZTwB4cl3Rqylw+0r/lhJOz4w=
X-Received: by 2002:a17:907:1b12:b0:9bd:a165:7822 with SMTP id
 mp18-20020a1709071b1200b009bda1657822mr19494202ejc.47.1699380614529; Tue, 07
 Nov 2023 10:10:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231105185358.1036619-1-yonghong.song@linux.dev>
 <CAEf4BzaerjXW7v6D-29h_yBGL=wWcoyP96FjetKe9AYT1pVt5g@mail.gmail.com> <6b66f9ab-d100-4a9a-9f78-31eb37e6819d@linux.dev>
In-Reply-To: <6b66f9ab-d100-4a9a-9f78-31eb37e6819d@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 7 Nov 2023 10:10:03 -0800
Message-ID: <CAEf4Bzak_CNWnefSm6q02-oOxR8r2J1KdDqC6oyiA8HktYTc+g@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Add tail padding check for
 LIBBPF_OPTS_RESET macro
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 6, 2023 at 10:44=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
> On 11/6/23 11:47 AM, Andrii Nakryiko wrote:
> > On Sun, Nov 5, 2023 at 10:54=E2=80=AFAM Yonghong Song <yonghong.song@li=
nux.dev> wrote:
> >> Martin reported that there is a libbpf complaining of non-zero-value t=
ail
> >> padding with LIBBPF_OPTS_RESET macro if struct bpf_netkit_opts is modi=
fied
> >> to have a 4-byte tail padding. This only happens to clang compiler.
> >> The commend line is: ./test_progs -t tc_netkit_multi_links
> >> Martin and I did some investigation and found this indeed the case and
> >> the following are the investigation details.
> >>
> >> Clang 18:
> >>    clang version 18.0.0 (https://github.com/llvm/llvm-project.git e00d=
32afb9d33a1eca48e2b041c9688436706c5b)
> >>    <I tried clang15/16/17 and they all have similar results>
> >>
> >> tools/lib/bpf/libbpf_common.h:
> >>    #define LIBBPF_OPTS_RESET(NAME, ...)                               =
       \
> >>          do {                                                         =
       \
> >>                  memset(&NAME, 0, sizeof(NAME));                      =
       \
> >>                  NAME =3D (typeof(NAME)) {                            =
         \
> >>                          .sz =3D sizeof(NAME),                        =
         \
> >>                          __VA_ARGS__                                  =
       \
> >>                  };                                                   =
       \
> >>          } while (0)
> >>
> >>    #endif
> >>
> >> tools/lib/bpf/libbpf.h:
> >>    struct bpf_netkit_opts {
> >>          /* size of this struct, for forward/backward compatibility */
> >>          size_t sz;
> >>          __u32 flags;
> >>          __u32 relative_fd;
> >>          __u32 relative_id;
> >>          __u64 expected_revision;
> >>          size_t :0;
> >>    };
> >>    #define bpf_netkit_opts__last_field expected_revision
> >> In the above struct bpf_netkit_opts, there is no tail padding.
> >>
> >> prog_tests/tc_netkit.c:
> >>    static void serial_test_tc_netkit_multi_links_target(int mode, int =
target)
> >>    {
> >>          ...
> >>          LIBBPF_OPTS(bpf_netkit_opts, optl);
> >>          ...
> >>          LIBBPF_OPTS_RESET(optl,
> >>                  .flags =3D BPF_F_BEFORE,
> >>                  .relative_fd =3D bpf_program__fd(skel->progs.tc1),
> >>          );
> >>          ...
> >>    }
> >>
> >> Let us make the following source change, note that we have a 4-byte
> >> tailing padding now.
> >>    diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> >>    index 6cd9c501624f..0dd83910ae9a 100644
> >>    --- a/tools/lib/bpf/libbpf.h
> >>    +++ b/tools/lib/bpf/libbpf.h
> >>    @@ -803,13 +803,13 @@ bpf_program__attach_tcx(const struct bpf_prog=
ram *prog, int ifindex,
> >>     struct bpf_netkit_opts {
> >>          /* size of this struct, for forward/backward compatibility */
> >>          size_t sz;
> >>    -       __u32 flags;
> >>          __u32 relative_fd;
> >>          __u32 relative_id;
> >>          __u64 expected_revision;
> >>    +       __u32 flags;
> >>          size_t :0;
> >>     };
> >>    -#define bpf_netkit_opts__last_field expected_revision
> >>    +#define bpf_netkit_opts__last_field flags
> >>
> >> The clang 18 generated asm code looks like below:
> >>      ;       LIBBPF_OPTS_RESET(optl,
> >>      55e3: 48 8d 7d 98                   leaq    -0x68(%rbp), %rdi
> >>      55e7: 31 f6                         xorl    %esi, %esi
> >>      55e9: ba 20 00 00 00                movl    $0x20, %edx
> >>      55ee: e8 00 00 00 00                callq   0x55f3 <serial_test_t=
c_netkit_multi_links_target+0x18d3>
> >>      55f3: 48 c7 85 10 fd ff ff 20 00 00 00      movq    $0x20, -0x2f0=
(%rbp)
> >>      55fe: 48 8b 85 68 ff ff ff          movq    -0x98(%rbp), %rax
> >>      5605: 48 8b 78 18                   movq    0x18(%rax), %rdi
> >>      5609: e8 00 00 00 00                callq   0x560e <serial_test_t=
c_netkit_multi_links_target+0x18ee>
> >>      560e: 89 85 18 fd ff ff             movl    %eax, -0x2e8(%rbp)
> >>      5614: c7 85 1c fd ff ff 00 00 00 00 movl    $0x0, -0x2e4(%rbp)
> >>      561e: 48 c7 85 20 fd ff ff 00 00 00 00      movq    $0x0, -0x2e0(=
%rbp)
> >>      5629: c7 85 28 fd ff ff 08 00 00 00 movl    $0x8, -0x2d8(%rbp)
> >>      5633: 48 8b 85 10 fd ff ff          movq    -0x2f0(%rbp), %rax
> >>      563a: 48 89 45 98                   movq    %rax, -0x68(%rbp)
> >>      563e: 48 8b 85 18 fd ff ff          movq    -0x2e8(%rbp), %rax
> >>      5645: 48 89 45 a0                   movq    %rax, -0x60(%rbp)
> >>      5649: 48 8b 85 20 fd ff ff          movq    -0x2e0(%rbp), %rax
> >>      5650: 48 89 45 a8                   movq    %rax, -0x58(%rbp)
> >>      5654: 48 8b 85 28 fd ff ff          movq    -0x2d8(%rbp), %rax
> >>      565b: 48 89 45 b0                   movq    %rax, -0x50(%rbp)
> >>      ;       link =3D bpf_program__attach_netkit(skel->progs.tc2, ifin=
dex, &optl);
> >>
> >> At -O0 level, the clang compiler creates an intermediate copy.
> >> We have below to store 'flags' with 4-byte store and leave another 4 b=
yte
> >> in the same 8-byte-aligned storage undefined,
> >>      5629: c7 85 28 fd ff ff 08 00 00 00 movl    $0x8, -0x2d8(%rbp)
> >> and later we store 8-byte to the original zero'ed buffer
> >>      5654: 48 8b 85 28 fd ff ff          movq    -0x2d8(%rbp), %rax
> >>      565b: 48 89 45 b0                   movq    %rax, -0x50(%rbp)
> >>
> >> This caused a problem as the 4-byte value at [%rbp-0x2dc, %rbp-0x2e0)
> >> may be garbage.
> >>
> >> gcc (gcc 11.4) does not have this issue as it does zeroing struct firs=
t before
> >> doing assignments:
> >>    ;       LIBBPF_OPTS_RESET(optl,
> >>      50fd: 48 8d 85 40 fc ff ff          leaq    -0x3c0(%rbp), %rax
> >>      5104: ba 20 00 00 00                movl    $0x20, %edx
> >>      5109: be 00 00 00 00                movl    $0x0, %esi
> >>      510e: 48 89 c7                      movq    %rax, %rdi
> >>      5111: e8 00 00 00 00                callq   0x5116 <serial_test_t=
c_netkit_multi_links_target+0x1522>
> >>      5116: 48 8b 45 f0                   movq    -0x10(%rbp), %rax
> >>      511a: 48 8b 40 18                   movq    0x18(%rax), %rax
> >>      511e: 48 89 c7                      movq    %rax, %rdi
> >>      5121: e8 00 00 00 00                callq   0x5126 <serial_test_t=
c_netkit_multi_links_target+0x1532>
> >>      5126: 48 c7 85 40 fc ff ff 00 00 00 00      movq    $0x0, -0x3c0(=
%rbp)
> >>      5131: 48 c7 85 48 fc ff ff 00 00 00 00      movq    $0x0, -0x3b8(=
%rbp)
> >>      513c: 48 c7 85 50 fc ff ff 00 00 00 00      movq    $0x0, -0x3b0(=
%rbp)
> >>      5147: 48 c7 85 58 fc ff ff 00 00 00 00      movq    $0x0, -0x3a8(=
%rbp)
> >>      5152: 48 c7 85 40 fc ff ff 20 00 00 00      movq    $0x20, -0x3c0=
(%rbp)
> >>      515d: 89 85 48 fc ff ff             movl    %eax, -0x3b8(%rbp)
> >>      5163: c7 85 58 fc ff ff 08 00 00 00 movl    $0x8, -0x3a8(%rbp)
> >>    ;       link =3D bpf_program__attach_netkit(skel->progs.tc2, ifinde=
x, &optl);
> >>
> >> It is not clear how to resolve the compiler code generation as the com=
piler
> >> generates correct code w.r.t. how to handle unnamed padding in C stand=
ard.
> >> So this patch changed LIBBPF_OPTS_RESET macro by adding a static_asser=
t
> >> to complain if there is a non-zero-byte tailing padding. This will eff=
ectively
> >> enforce all *_opts struct used by LIBBPF_OPTS_RESET must have zero-byt=
e tailing
> >> padding.
> >>
> >> With the above changed bpf_netkit_opts layout, building the selftest w=
ith
> >> clang compiler, the following error will occur:
> >>
> >>    .../bpf-next/tools/testing/selftests/bpf/prog_tests/tc_netkit.c:331=
:2: error:
> >>      static assertion failed due to requirement 'sizeof (optl) =3D=3D =
(__builtin_offsetof(struct bpf_netkit_opts, flags)
> >>        + sizeof ((((struct bpf_netkit_opts *)0)->flags)))': Unexpected=
 tail padding
> >>    331 |         LIBBPF_OPTS_RESET(bpf_netkit_opts, optl,
> >>        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >>    332 |                 .flags =3D BPF_F_BEFORE,
> >>        |                 ~~~~~~~~~~~~~~~~~~~~~~
> >>    333 |                 .relative_fd =3D bpf_program__fd(skel->progs.=
tc1),
> >>        |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~
> >>    334 |         );
> >>        |         ~
> >>    .../bpf-next/tools/testing/selftests/bpf/tools/include/bpf/libbpf_c=
ommon.h:98:4: note: expanded from macro 'LIBBPF_OPTS_RESET'
> >>     98 |                         sizeof(NAME) =3D=3D offsetofend(struc=
t TYPE,            \
> >>        |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~~
> >>     99 |                                                     TYPE##__l=
ast_field),    \
> >>        |                                                     ~~~~~~~~~=
~~~~~~~~~~
> >>    .../bpf-next/tools/testing/selftests/bpf/prog_tests/tc_netkit.c:331=
:2: note: expression evaluates to '32 =3D=3D 28'
> >>    331 |         LIBBPF_OPTS_RESET(bpf_netkit_opts, optl,
> >>        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >>    332 |                 .flags =3D BPF_F_BEFORE,
> >>        |                 ~~~~~~~~~~~~~~~~~~~~~~
> >>    333 |                 .relative_fd =3D bpf_program__fd(skel->progs.=
tc1),
> >>        |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~
> >>    334 |         );
> >>        |         ~
> >>    .../bpf-next/tools/testing/selftests/bpf/tools/include/bpf/libbpf_c=
ommon.h:98:17: note: expanded from macro 'LIBBPF_OPTS_RESET'
> >>     98 |                         sizeof(NAME) =3D=3D offsetofend(struc=
t TYPE,            \
> >>        |                         ~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~~
> >>     99 |                                                     TYPE##__l=
ast_field),    \
> >>
> >> Note that this patch does not provide a C++ version of changed LIBBPF_=
OPTS_RESET macro.
> >> It looks C++ complaining about offsetof()
> >>    #define offsetof(type, member)    ((unsigned long)&((type *)0)->mem=
ber)
> >> to be used in static_assert.
> >>
> >> Cc: Martin KaFai Lau <martin.lau@kernel.org>
> >> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> >> ---
> > This patch is adding detection of a potential issue, but doesn't
> > suggest the solution. Did you have a proposed solution in mind for
> > cases when we do have padding at the end?
>
> This patch is kind of ONE possible solution in the sense it tries to
> warn people if the tail padding exists when using LIBBPF_OPTS_RESET
> macro. But later I realized that this may not be the best since
> it is possible LIBBPF_OPTS_RESET may use some other existing *_opts
> struct and if those opts have tail padding, then user will get
> struck since they need to modify that *_opts struct which is not
> good. So best way is still to fix LIBBPF_OPTS_RESET to avoid
> uninitialized tail padding.
>
> After some further thought, I found a solution. See v2:
> https://lore.kernel.org/bpf/20231107062936.2537338-1-yonghong.song@linux.=
dev/

yep, taking a look

>
> >
> >>   tools/lib/bpf/libbpf_common.h                 |   7 +-
> >>   .../selftests/bpf/prog_tests/tc_links.c       |  70 ++++-----
> >>   .../selftests/bpf/prog_tests/tc_netkit.c      |   4 +-
> >>   .../selftests/bpf/prog_tests/tc_opts.c        | 144 +++++++++-------=
--
> >>   4 files changed, 115 insertions(+), 110 deletions(-)
> >>
> >> diff --git a/tools/lib/bpf/libbpf_common.h b/tools/lib/bpf/libbpf_comm=
on.h
> >> index b7060f254486..f74e5f3cde9c 100644
> >> --- a/tools/lib/bpf/libbpf_common.h
> >> +++ b/tools/lib/bpf/libbpf_common.h
> >> @@ -77,8 +77,13 @@
> >>    * syntax as varargs can be provided as well to reinitialize options=
 struct
> >>    * specific members.
> >>    */
> >> -#define LIBBPF_OPTS_RESET(NAME, ...)                                 =
      \
> >> +#define LIBBPF_OPTS_RESET(TYPE, NAME, ...)                           =
      \
> > We can't do this. It's both backwards incompatible and will breaks
> > existing users. And it also hurts usability a lot to have to specify
> > the name of the struct.
>
> The original thinking is LIBBPF_OPTS_RESET is introduced in 6.6, so
> we only need to backport to 6.6.

well, it's not about kernel version, it's about libbpf version. This
went into v1.3 which hasn't been released yet, so no need to backport
anything and there will be no breaking change.

But I still don't really like having to pass TYPE explicitly. Let me
take a look at v2, though.

>
> >
> >>          do {                                                         =
       \
> >> +               _Static_assert(                                       =
      \
> >> +                       sizeof(NAME) =3D=3D offsetofend(struct TYPE,  =
          \
> > you coun't use typeof(NAME) here?
>
> Yes, we can. The key thing is TYPE usage in the below line so TYPE has to=
 be added to
> macro definition.
>
> >
> >> +                                                   TYPE##__last_field=
),    \

ah, this one, right...

> >> +                       "Unexpected tail padding"                     =
      \
> >> +               );                                                    =
      \
> > I don't see why this static assert has to be inside
> > LIBBPF_OPTS_RESET() macro. We can just add it next to each opts type
> > declaration, if we want to enforce this.
>
> I found another solution without assert. See v2.
>
>
> >
> >>                  memset(&NAME, 0, sizeof(NAME));                      =
       \
> >>                  NAME =3D (typeof(NAME)) {                            =
         \
> >>                          .sz =3D sizeof(NAME),                        =
         \
> > [...]

