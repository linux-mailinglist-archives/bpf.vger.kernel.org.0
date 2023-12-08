Return-Path: <bpf+bounces-17187-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D72E980A554
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 15:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D0D7281644
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 14:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48B11DFD0;
	Fri,  8 Dec 2023 14:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fjg0oVqZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07AA8198C
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 06:21:55 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40c256ffdbcso22221225e9.2
        for <bpf@vger.kernel.org>; Fri, 08 Dec 2023 06:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702045313; x=1702650113; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pqeik4fWPC+DE5Yfa3dVGz/R6AwuKhzAbOHXPosE3u8=;
        b=Fjg0oVqZgCfCHHWO0rfRyKkM470Rpiw3Gof335c2SJdLhyY0qHoXIu7DMlNNWm/m9C
         2qVpeJN3SRca5r7l1mR6//yQ0VLQmlbqZZttm9zaEvZp9PMRZSsF00DWWvIT+rwhMPz/
         6jgkyN0h7xs9xwk62Nw4wRMbm+Akq9lfpWcRZg3Oc32gmExTwjv7H8mC7APJbAEItTDE
         gIfdN1UVt3p9ZkT7rsAg9/y9wgWMBBQQHe6n3nU4zGZgBfINc9jx9t6wynnwHjpaOcl6
         5UVmYuv7+LmQp28TkKckxheUpWHxhAYsV0cmyZ+mii9kKb583RxVUuiGA3YvqTU5OMIh
         pVjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702045313; x=1702650113;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pqeik4fWPC+DE5Yfa3dVGz/R6AwuKhzAbOHXPosE3u8=;
        b=AX1vCIvjU4Tet8LCUp9jQSM6JfWpnoIrBSdF6YfuxinUhmC60jzqMCnzLZZRI6B4nz
         WjBVA1BcNeqSirwVC5yut0qOlO5wFiU29TfhMAvJ+8lMhkIOLHsbkvw2TA3sdVuAqmmq
         MJHnLyoExOSly6BnG2f/6bcqaScfKXzpyWcr2BlQEvB/KpL6DTLtFnkHj6lCalHQjlWN
         JUYFbQk0bnhrIu0pZjMaCgoQBfMwCV1BufT8rovJitsj8ciJfVkR3zx70RgJWYIGaZVJ
         rf5QZ5PWYJNcOq9JsV4tGy4qrLwBLTdu1xvYqD3HVBYj3gmQhTpT6EvUrGnY0mkRly+V
         Az/A==
X-Gm-Message-State: AOJu0YwhSOmMXKD2H1eHeC+Hyb9GY9OEYb04/pSIIdhNklM6leGvO4Y+
	4Bq/yNtt78M+Tj5/gTuGpMg=
X-Google-Smtp-Source: AGHT+IHeht0i2U/UKv+9rskGln9FF6tUNQbBijWhfOMXwM5Ij1C/PiA/HTZeCJwXQSiXuIt/0F2DuQ==
X-Received: by 2002:a7b:cc88:0:b0:40c:982:4968 with SMTP id p8-20020a7bcc88000000b0040c09824968mr18837wma.136.1702045313148;
        Fri, 08 Dec 2023 06:21:53 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id bi11-20020a05600c3d8b00b0040c2963e5f3sm2983236wmb.38.2023.12.08.06.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 06:21:52 -0800 (PST)
Message-ID: <069960f88faa6740b9059ff428f7f209d8e8d6d2.camel@gmail.com>
Subject: Re: [PATCH bpf-next 0/1] use preserve_static_offset in bpf uapi
 headers
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, bpf@vger.kernel.org,
 ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	kernel-team@fb.com, yonghong.song@linux.dev, jose.marchesi@oracle.com
Date: Fri, 08 Dec 2023 16:21:46 +0200
In-Reply-To: <1d2a2af0-40db-80f9-da13-caf53f3d9118@oracle.com>
References: <20231208000531.19179-1-eddyz87@gmail.com>
	 <1d2a2af0-40db-80f9-da13-caf53f3d9118@oracle.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2023-12-08 at 12:27 +0000, Alan Maguire wrote:
[...]
> Sorry if this is a digression, but I'm trying to understand how
> this might intersect with vmlinux.h's
>
> #pragma clang attribute push (__attribute__((preserve_access_index)),
> apply_to =3D record
>
> Since that is currently applied to all structures in vmlinux.h, does
> that protect us from the above scenario when BPF code is compiled and
> #include's vmlinux.h (I suspect not from what you say below but just
> wanted to check)? I realize we get extra relocation info that we don't
> need since the offsets for these BPF context structures are recalcuated
> by the verifier, but given that clang needs to record the relocations,
> does it also constrain the generated code to avoid these "increment
> pointer, use zero offset" instruction patterns? Or can they still occur
> with preserve_access_index applied to the structure? Sorry, might be a
> naive question but it's not clear to me how (if at all) the mechanisms
> might interact.

Unfortunately preserve_access_index does not save us from this problem.
This is the case because field reads and writes are split as two LLVM
IR instructions: getelementptr to get an address, and load/store
to/from that address. The preserve_access_index transformation
rewrites the getelementptr but does not touch load/store.

For example, consider the following C code:

    /* #define __ctx __attribute__((preserve_static_offset)) */
    /* #define __pai */
    #define __ctx
    #define __pai __attribute__((preserve_access_index))

    extern int magic2(int);

    struct bpf_sock {
      int bound_dev_if;
      int family;
    } __ctx __pai;

    struct bpf_sockopt {
      int _;
      struct bpf_sock *sk;
      int level;
      int optlen;
    } __ctx __pai;

    int known_load_sink_example_1(struct bpf_sockopt *ctx)
    {
      unsigned g =3D 0;
      switch (ctx->level) {
      case 10:
        g =3D magic2(ctx->sk->family);
        break;
      case 20:
        g =3D magic2(ctx->optlen);
        break;
      }
      return g % 2;
    }

Here is how it is compiled:

    $ clang -g -O2 --target=3Dbpf -mcpu=3Dv3 -c e3.c -o - | llvm-objdump --=
no-show-raw-insn -Sdr -
    ...
    0000000000000000 <known_load_sink_example_1>:
    ;   switch (ctx->level) {
           0:   r2 =3D *(u32 *)(r1 + 0x10)
            0000000000000000:  CO-RE <byte_off> [2] struct bpf_sockopt::lev=
el (0:2)
           1:   if w2 =3D=3D 0x14 goto +0x5 <LBB0_3>
           2:   w0 =3D 0x0
    ;   switch (ctx->level) {
           3:   if w2 !=3D 0xa goto +0x8 <LBB0_5>
    ;     g =3D magic2(ctx->sk->family);
           4:   r1 =3D *(u64 *)(r1 + 0x8)
            0000000000000020:  CO-RE <byte_off> [2] struct bpf_sockopt::sk =
(0:1)
           5:   r2 =3D 0x4
            0000000000000028:  CO-RE <byte_off> [7] struct bpf_sock::family=
 (0:1)
           6:   goto +0x1 <LBB0_4>

    0000000000000038 <LBB0_3>:
           7:   r2 =3D 0x14
            0000000000000038:  CO-RE <byte_off> [2] struct bpf_sockopt::opt=
len (0:3)

    0000000000000040 <LBB0_4>:
           8:   r1 +=3D r2
           9:   r1 =3D *(u32 *)(r1 + 0x0)  <---------------- verifier error=
 would
          10:   call -0x1                                  be reported for =
this insn
            0000000000000050:  R_BPF_64_32  magic2
    ;   return g % 2;
          11:   w0 &=3D 0x1

    0000000000000060 <LBB0_5>:
          12:   exit

> The reason I ask is if it was safe to assume that code generation would
> avoid such patterns with preserve_access_index, it might avoid needing
> to update vmlinux.h generation.

In current LLVM implementation preserve_static_offset has priority
over preserve_access_index. So changing __pai/__ctx definitions above helps=
.
(And this priority of one attribute over the other was the reason to
 have preserve_static_offset as an attribute, not as
 btf_decl_tag("preserve_static_offset"). Although that is unfortunate
 for vmlinux.h, as we already have means to preserve decl tags).

[...]

> > How to add the same definitions in vmlinux.h is an open question,
> > and most likely requires bpftool modification:
> > - Hard code generation of __bpf_ctx based on type names?
> > - Mark context types with some special
> >   __attribute__((btf_decl_tag("preserve_static_offset")))
> >   and convert it to __attribute__((preserve_static_offset))?
>
> To me it seems like whatever mechanism supports identification of such
> structures would need to live in vmlinux BTF as ideally it should be
> possible to generate vmlinux.h purely from that BTF. That seems to argue
> for the declaration tag approach.

Tbh, I like the decl tag approach a bit more too.
Although macro definition would be somewhat ridiculous:

    #if __has_attribute(preserve_static_offset) && defined(__bpf__)
    #define __bpf_ctx __attribute__((preserve_static_offset)) \
                      __attribute__((btf_decl_tag("preserve_static_offset")=
))
    #else
    #define __bpf_ctx
    #endif

Thanks,
Eduard

