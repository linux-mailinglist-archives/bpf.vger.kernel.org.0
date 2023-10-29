Return-Path: <bpf+bounces-13562-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3037DAA55
	for <lists+bpf@lfdr.de>; Sun, 29 Oct 2023 02:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13EAE28180B
	for <lists+bpf@lfdr.de>; Sun, 29 Oct 2023 01:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749B939A;
	Sun, 29 Oct 2023 01:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JoVFsXJs"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD14194
	for <bpf@vger.kernel.org>; Sun, 29 Oct 2023 01:13:14 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5980CA
	for <bpf@vger.kernel.org>; Sat, 28 Oct 2023 18:13:11 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9bf86b77a2aso464275866b.0
        for <bpf@vger.kernel.org>; Sat, 28 Oct 2023 18:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698541990; x=1699146790; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d2lSuoazRO6CjUiYppQl67FCdFotAOBl/T/K3Dt8CNU=;
        b=JoVFsXJsIfznylKW/s6r2nJ0c2UGqfPw/1AWlsLTooD61qbczxsD+ADpym3hvLO4BA
         QAuWcbGhiWaCLg96O8knV0ofmygkD6DwRYLhESLc8+kavFjdzb9lvJJ0BuN8iKm09QvF
         up5Z2cJcmSTQXcQkGMI1uCwJq2PqSCa5kX4Lxe4SrWMnIq2iHPcp6WogeyfKTeu5cHU6
         l+IrLBiWiPmd+9b6GbdNHW98EryWW9wBKxP9tJ/ns4FceRgtdPiZAl/bb/sP34Df606A
         nxZ1r61F9Dp+kpivJqlPGZ5TRUsjFA/DDp+6DsAIqbzL3Ll93u1KaeSaKU1v6ZVTtg9o
         Crig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698541990; x=1699146790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d2lSuoazRO6CjUiYppQl67FCdFotAOBl/T/K3Dt8CNU=;
        b=tfwV1A9lz4L3uOnHCPNUkJ34lfxZdD90Jiu2fc6JZXs9sJCR/y0GYCWQ9jVYpT1xNn
         HTmhCQoQFrbq2tLRD+9/wXzczaS8QeR7bsmI0OsHyaO2+0GPgQ7K4Q0fOJ3MyqOg4Xlp
         O/5BqY8SVFTcZyg7EegFIbgncG2Cp+rdWVePiDltS+3xxxbUarJlKAsHFdqHQyjSAq3E
         TerEOx2gcDGfHtfOtGq3F+Wf5PS4Va0n3hsibak9maXFBdT4hDEBF2KMwcaTTw7S+0ZA
         6yt/nxmsezj6ZJR9OXLDxZs9bQe9SrHs2cY8d2gKgD0fOfIyLg/GpicJ4fpSbI4PReGW
         MJ/w==
X-Gm-Message-State: AOJu0YzabkK/4UF9pk83k3xVkXhtJe+fzNP1pyXKmPQXpaeDVIyxRIgb
	a0rHtro2TlQJcsS3BevUCf5Br3/3cvk6GMwXHik=
X-Google-Smtp-Source: AGHT+IE9XZGAZ8ziSdpdMkaGNKB/tD2nItTA6Vax+lujuisKOpCH5oGFHM730aQkF9mx446SRZrHQ/VKZKUWyYOACwU=
X-Received: by 2002:a17:907:1c92:b0:9be:ab38:a367 with SMTP id
 nb18-20020a1709071c9200b009beab38a367mr5719381ejc.16.1698541989793; Sat, 28
 Oct 2023 18:13:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4891ef34-b6a2-4c12-b4cf-eed4d9a84172@gmail.com>
In-Reply-To: <4891ef34-b6a2-4c12-b4cf-eed4d9a84172@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Sat, 28 Oct 2023 18:12:58 -0700
Message-ID: <CAEf4BzbZ=2KueQo6BErkS+M2TAov7Q0SbsBmV=3iL2m5ZFCvEA@mail.gmail.com>
Subject: Re: size_t :0 doesn't always work with llvm-16
To: Kui-Feng Lee <sinquersw@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 28, 2023 at 5:52=E2=80=AFPM Kui-Feng Lee <sinquersw@gmail.com> =
wrote:
>
> Recently, while running the test_maps, I encountered an error
> message. Upon further investigation, I discovered that llvm-16 behaves
> inconsistently when it comes to clearing partially initialized local
> variables.
>
> We appends a 'size_t :0' at the end of many types to prevent dirty
> bytes at the end of struct types.  libbpf also check dirty padding
> bytes for CORE. It works most of time with gcc and llvm.  However, I
> have discovered that it is not always work with llvm. The C
> specification does not guarantee this either. Nonetheless, we
> primarily rely on gcc and llvm. In most cases, on x86_64 platforms,
> llvm utilizes memset() to clear a partially initialized variable of a
> struct type.
>
>  > memset(&data, 0, sizeof(data));
>
> However, there are exceptional situations that use a distinct approach
> to clearing a buffer. It does something like the following code.
>
>  > 0000000000010220 <create_hash_of_maps>:
>  >    10220:       55                      push   %rbp
>  >    10221:       48 89 e5                mov    %rsp,%rbp
>  >    10224:       48 83 ec 40             sub    $0x40,%rsp
>  >    10228:       48 c7 45 c8 38 00 00    movq   $0x38,-0x38(%rbp)
>  >    1022f:       00
>  >    10230:       c7 45 d0 00 00 00 00    movl   $0x0,-0x30(%rbp)
>  >    10237:       c7 45 d4 00 00 00 00    movl   $0x0,-0x2c(%rbp)
>  >    1023e:       c7 45 d8 00 00 00 00    movl   $0x0,-0x28(%rbp)
>  >    10245:       c7 45 dc 00 00 00 00    movl   $0x0,-0x24(%rbp)
>  >    1024c:       e8 1f f4 ff ff          call   f670 <create_small_hash=
>
>  >    10251:       89 45 e0                mov    %eax,-0x20(%rbp)
>  >    10254:       c7 45 e4 01 00 00 00    movl   $0x1,-0x1c(%rbp)
>  >    1025b:       48 c7 45 e8 00 00 00    movq   $0x0,-0x18(%rbp)
>  >    10262:       00
>  >    10263:       c7 45 f0 00 00 00 00    movl   $0x0,-0x10(%rbp)
>  >    1026a:       c7 45 f4 00 00 00 00    movl   $0x0,-0xc(%rbp)
>  >    10271:       c7 45 f8 00 00 00 00    movl   $0x0,-0x8(%rbp)
>  >    10278:       bf 0d 00 00 00          mov    $0xd,%edi
>  >    1027d:       48 8d 35 fc 34 06 00    lea    0x634fc(%rip),%rsi
>     # 73780 <map_percpu_stats__elf_bytes.data+0x1fe8>
>  >    10284:       48 8d 55 c8             lea    -0x38(%rbp),%rdx
>  >    10288:       41 b8 04 00 00 00       mov    $0x4,%r8d
>  >    1028e:       44 89 c1                mov    %r8d,%ecx
>  >    10291:       e8 da fd ff ff          call   10070 <map_create_opts>
>  >    10296:       89 45 c4                mov    %eax,-0x3c(%rbp)
>  >    10299:       8b 7d e0                mov    -0x20(%rbp),%edi
>  >    1029c:       e8 cf b0 ff ff          call   b370 <close@plt>
>  >    102a1:       8b 45 c4                mov    -0x3c(%rbp),%eax
>  >    102a4:       48 83 c4 40             add    $0x40,%rsp
>  >    102a8:       5d                      pop    %rbp
>  >    102a9:       c3                      ret
>
> Instead of using the 'memset()' function, this object code effectively
> clears a buffer by utilizing 'movl' instructions.
>
> The above object code is generated from create_hash_of_maps() in
> selftests/bpf/map_tests/map_percpu_stats.c.  The following is the
> source code of create_hash_of_maps().
>
>  > static int create_hash_of_maps(void)
>  > {
>  >       struct bpf_map_create_opts map_opts =3D {
>  >               .sz =3D sizeof(map_opts),
>  >               .map_flags =3D BPF_F_NO_PREALLOC,
>  >               .inner_map_fd =3D create_small_hash(),
>  >       };
>  >       int ret;
>  >
>  >       ret =3D map_create_opts(BPF_MAP_TYPE_HASH_OF_MAPS, "hash_of_maps=
",
>  >                             &map_opts, sizeof(int), sizeof(int));
>  >       close(map_opts.inner_map_fd);
>  >       return ret;
>  > }
>
> The following is the definition of struct bpf_map_create_opts.
> (I added a new filed at the end.)
>
>  > struct bpf_map_create_opts {
>  >       size_t sz; /* size of this struct for forward/backward
> compatibility */
>  >
>  >       __u32 btf_fd;
>  >       __u32 btf_key_type_id;
>  >       __u32 btf_value_type_id;
>  >       __u32 btf_vmlinux_value_type_id;
>  >
>  >       __u32 inner_map_fd;
>  >       __u32 map_flags;
>  >       __u64 map_extra;
>  >
>  >       __u32 numa_node;
>  >       __u32 map_ifindex;
>  >
>  >       __u32 value_type_btf_obj_fd;
>  >       size_t:0;
>  > };
>  > #define bpf_map_create_opts__last_field value_type_btf_obj_fd
>
> When checking the value of 'sizeof(map_opts)', it is observed that the
> struct bpf_map_create_opts occupies 0x38 bytes. Interestingly, the
> offset of the byte after the last member, specifically after
> value_type_btf_obj_fd, is actually 0x34. This means that there are 4
> padding bytes present at the end of this type. Upon thorough
> examination of the aforementioned object code, it becomes apparent
> that the initialization is limited to the first 0x34 bytes.
>
> By modifying the code as shown above, the resulting object code
> behaves differently.
>
>  > static int create_hash_of_maps(void)
>  > {
>  >       struct bpf_map_create_opts map_opts =3D {
>  >               .sz =3D sizeof(map_opts),
>  >               .map_flags =3D BPF_F_NO_PREALLOC,
>  >               .inner_map_fd =3D 0,
>  >       };
>  >       int ret;
>  >
>  >       map_opts.inner_map_fd =3D create_small_hash(),
>  >       ret =3D map_create_opts(BPF_MAP_TYPE_HASH_OF_MAPS, "hash_of_maps=
",
>  >                             &map_opts, sizeof(int), sizeof(int));
>  >       close(map_opts.inner_map_fd);
>  >       return ret;
>  > }
>
> The following is the object code generated by LLVM.
>
>  > 00000000000101e0 <create_hash_of_maps>:
>  >    101e0:       55                      push   %rbp
>  >    101e1:       48 89 e5                mov    %rsp,%rbp
>  >    101e4:       48 83 ec 40             sub    $0x40,%rsp
>  >    101e8:       48 8d 7d c8             lea    -0x38(%rbp),%rdi
>  >    101ec:       31 f6                   xor    %esi,%esi
>  >    101ee:       ba 38 00 00 00          mov    $0x38,%edx
>  >    101f3:       e8 28 b1 ff ff          call   b320 <memset@plt>
>  >    101f8:       48 c7 45 c8 38 00 00    movq   $0x38,-0x38(%rbp)
>  >    101ff:       00
>  >    10200:       c7 45 e4 01 00 00 00    movl   $0x1,-0x1c(%rbp)
>  >    10207:       e8 24 f4 ff ff          call   f630 <create_small_hash=
>
>  >    1020c:       89 45 e0                mov    %eax,-0x20(%rbp)
>  >    1020f:       bf 0d 00 00 00          mov    $0xd,%edi
>  >    10214:       48 8d 35 65 35 06 00    lea    0x63565(%rip),%rsi
>     # 73780 <map_percpu_stats__elf_bytes.data+0x1fe8>
>  >    1021b:       48 8d 55 c8             lea    -0x38(%rbp),%rdx
>  >    1021f:       41 b8 04 00 00 00       mov    $0x4,%r8d
>  >    10225:       44 89 c1                mov    %r8d,%ecx
>  >    10228:       e8 03 fe ff ff          call   10030 <map_create_opts>
>  >    1022d:       89 45 c4                mov    %eax,-0x3c(%rbp)
>  >    10230:       8b 7d e0                mov    -0x20(%rbp),%edi
>  >    10233:       e8 38 b1 ff ff          call   b370 <close@plt>
>  >    10238:       8b 45 c4                mov    -0x3c(%rbp),%eax
>  >    1023b:       48 83 c4 40             add    $0x40,%rsp
>  >    1023f:       5d                      pop    %rbp
>  >    10240:       c3                      ret
>
> The object code uses memset() to clear the buffer for 0x38
> bytes. However, after the change, the behavior becomes inconsistent
> with the previous object code. When a function is called during
> partial initialization, llvm doesn't clear its buffer using 'memset()'
> and leaves the padding bytes uncleared.
>
>

Yes, which is why using LIBBPF_OPTS() is a good idea. And which is why
I submitted [0] to fix this in our test_maps tests. I'll resend this
fix outside of BPF token series.

  [0] https://patchwork.kernel.org/project/netdevbpf/patch/20231016180220.3=
866105-14-andrii@kernel.org/

