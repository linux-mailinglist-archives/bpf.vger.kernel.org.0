Return-Path: <bpf+bounces-7809-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 206F477CDD5
	for <lists+bpf@lfdr.de>; Tue, 15 Aug 2023 16:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77F832814FB
	for <lists+bpf@lfdr.de>; Tue, 15 Aug 2023 14:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F32F134B3;
	Tue, 15 Aug 2023 14:09:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D856E10978
	for <bpf@vger.kernel.org>; Tue, 15 Aug 2023 14:09:51 +0000 (UTC)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5995199A;
	Tue, 15 Aug 2023 07:09:49 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b9c907bc68so81609561fa.2;
        Tue, 15 Aug 2023 07:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692108588; x=1692713388;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EUqwQFcaZ1oAyQ7RyvwgmK+J49GL+aD5dHjufsVvaSU=;
        b=Fqcetz549j/J1l7LSDGsSe0rc+gB4GcJOUV/CogTNYr5XSyP1gD1pBlqP91dbEx2Zb
         0UXAfea9JiCp2OnOlL7RlxbkEXW6+Xp9qJe4AJCDFCDyV+ruyDmSWUespR7YjWPrwKVi
         QjEhFkTlJTSWxdhOxngxmNgT53CBEM3Dn2UxefEuob5LAK61LRHEnIVxX3nII3LAIlUV
         g9VIDt1FYfpXwwDsnLDR0XVqgvi59da+N2qJuSVQe6pJcYFYmnHgnsh6+QkYZz2Zjm74
         N3maY4TkO1npeLmxgu+fKN9fjD+y8b9HHD9/9zXq7uhnIT9I0KH6n88NRtTxixcGE22g
         4m9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692108588; x=1692713388;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EUqwQFcaZ1oAyQ7RyvwgmK+J49GL+aD5dHjufsVvaSU=;
        b=Z1RMGgdrw5IPlGX2/zpGh4NusLhsgGqJn5sFFcwTV0MTEdjKuFt6WnJhv8z1ZZxsCq
         hHqK/TGpj72KaWTfYIYm4kwZX+FgWyXkqvT4NeWzHO7iSUDykbkXqZZD4/5lEHDDbnQ2
         1gdWYGciABEjx7OKNETSBYAf8RMa+5v4mWKJdvvRaOYrgNop2wbTuisjSmn4d7IdCN5K
         8X2rOSaZMbtpNmaub7DYadZ+N0V42tqxW69atdSqJlDKmKM2gTtEYFt/oVE7Vg8D3CUJ
         FcER6JuhJ7FYuNHK4qDxxhdpzYCkoyUkX2Sl2YnaJTbWmewGFMsKdwhkgD85f5JLVc7P
         K55w==
X-Gm-Message-State: AOJu0YwVbBRt/s1W2RAR96Nuf0DY0iSyWUK41w2ec/oajreWatmo72oS
	cp/RmdXBokZd7eUK6LwrzZcjeLrDhpfJZbQUID0=
X-Google-Smtp-Source: AGHT+IHFVTgCbx+P55vV/Sr6NoK14EObWpnD7r3nmdPAejOctVxq7J9nAACPeju63tlaFmZYwqFjjngZMGJSVcA2eng=
X-Received: by 2002:a2e:3e17:0:b0:2b7:33b9:8809 with SMTP id
 l23-20020a2e3e17000000b002b733b98809mr7755616lja.16.1692108587782; Tue, 15
 Aug 2023 07:09:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230626085811.3192402-1-puranjay12@gmail.com> <20230626085811.3192402-4-puranjay12@gmail.com>
In-Reply-To: <20230626085811.3192402-4-puranjay12@gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Tue, 15 Aug 2023 16:09:36 +0200
Message-ID: <CANk7y0gcP3dF2mESLp5JN1+9iDfgtiWRFGqLkCgZD6wby1kQOw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 3/3] bpf, arm64: use bpf_jit_binary_pack_alloc
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, catalin.marinas@arm.com, 
	mark.rutland@arm.com, bpf@vger.kernel.org, kpsingh@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Everyone,

[+cc Bj=C3=B6rn]

On Mon, Jun 26, 2023 at 10:58=E2=80=AFAM Puranjay Mohan <puranjay12@gmail.c=
om> wrote:
>
> Use bpf_jit_binary_pack_alloc for memory management of JIT binaries in
> ARM64 BPF JIT. The bpf_jit_binary_pack_alloc creates a pair of RW and RX
> buffers. The JIT writes the program into the RW buffer. When the JIT is
> done, the program is copied to the final RX buffer
> with bpf_jit_binary_pack_finalize.
>
> Implement bpf_arch_text_copy() and bpf_arch_text_invalidate() for ARM64
> JIT as these functions are required by bpf_jit_binary_pack allocator.
>
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> Acked-by: Song Liu <song@kernel.org>

[...]

> +int bpf_arch_text_invalidate(void *dst, size_t len)
> +{
> +       __le32 *ptr;
> +       int ret;
> +
> +       for (ptr =3D dst; len >=3D sizeof(u32); len -=3D sizeof(u32)) {
> +               ret =3D aarch64_insn_patch_text_nosync(ptr++, AARCH64_BRE=
AK_FAULT);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       return 0;
> +}
> +

While testing the same patch for riscv bpf jit, Bj=C3=B6rn found that
./test_tag is taking a lot of
time to complete. He found that bpf_arch_text_invalidate() is calling
patch_text_nosync() in RISCV
and aarch64_insn_patch_text_nosync() here in ARM64. Both of the
implementations call these functions
in a loop for each word. The problem is that every call to
patch_text_nosync()/aarch64_insn_patch_text_nosync()
would clean the cache. This will make this
function(bpf_arch_text_invalidate) really slow.

I did some testing using the vmtest.sh script on ARM64 with and
without the patches, here are the results:

With Prog Pack patches applied:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

root@(none):/# time ./root/bpf/test_tag
test_tag: OK (40945 tests)

real    3m2.001s
user    0m1.644s
sys     2m40.132s

Without Prog Pack:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

root@(none):/# time ./root/bpf/test_tag
test_tag: OK (40945 tests)

real    0m26.809s
user    0m1.591s
sys     0m24.106s

As you can see the current implementation of
bpf_arch_text_invalidate() is really slow. I need to
implement a new function: aarch64_insn_set_text_nosync() and use it in
bpf_arch_text_invalidate()
rather than calling aarch64_insn_patch_text_nosync() in a loop.

In the longer run, it would be really helpful if we have a standard
text_poke API like x86 in every architecture.

Thanks,
Puranjay

