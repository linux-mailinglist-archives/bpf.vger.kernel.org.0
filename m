Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A55F96A4DF7
	for <lists+bpf@lfdr.de>; Mon, 27 Feb 2023 23:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbjB0WZK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Feb 2023 17:25:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjB0WZJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Feb 2023 17:25:09 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885DC1E295
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 14:25:07 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id ee7so32210669edb.2
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 14:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BJdBSaQWTLpewdCsWWhyx2OOAlTIlXsk7iiAjgrNViE=;
        b=lJhPShcogT8sojLZo9hy7Vr+nDi6YCP6ZNtjJfuNwy2GZdK04rMsHHXRB2SGGoINcT
         NqlGrNTmLjOwaQLK5tMDBYxLnRvS6SWDshkIa7F2y4FYfeczSdh2wUopXW/i30pjHsT9
         OUo2YpuuH9XBwfXMQmWsjFs4uZ02bEbtgT7GZ/Y324lteeE8DLLjbsRpcaCw0wEtpndU
         r8vKZ1E8QOUxxZdGe9QDvd+pS28twLboep0bew1fmwVx2L1vb4mkRQepAGwTj6fBcoF4
         YALITU22OfnaCVMrPDlSq4D1nv9qAxneDA4GRccEmKDsNtjFR3/2tpL2u4uLqV31EKsj
         YmQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BJdBSaQWTLpewdCsWWhyx2OOAlTIlXsk7iiAjgrNViE=;
        b=HTOFakQczrQIbKUdDvExxZalspvDabmYdePlQICGdOyC7w9viGX+eH1XVlxHKsufLS
         q149+T9j8CShKV9f2IBqGovFzXRr7ukJslQECawhBnKyqZdc0HWMsCDf2Bfs5MW2PlhW
         PfgU4ua6TfVUVGO8A1l2cmKjpBBIQwM+Ml+QzlnqSDMQLQSQ4smWX2B25Fyq4KY0MWyt
         NxBHaMVLdBwYnQs8BMYvR4urRAYC61/xXjXBNy+VL/iLUHjq9rlW9S/oH2c3A4mdv/bU
         LHkxq1plKK9pK/v3P6bRu9k+SNUE+krXweDHoUe+5kshD1sll8OrsloSWCkUGt9WIh3V
         dMHw==
X-Gm-Message-State: AO0yUKWj/mSPz2OLN4xzNdQGNUHB9uir/BMKMWQfhy9rbneH8sMNYLbr
        FgHDDJNgPicP293Afn8hcHjzsHq/cGZAPdSDRsM=
X-Google-Smtp-Source: AK7set90Rwi8NcGvmh7pjDUZE5YLl8eqbb6klcp8dKvmOzDBFHYJlaskQARLKHVg7RtyCncqyNXon/jXhbLA9N1P9GU=
X-Received: by 2002:a17:906:4910:b0:8af:4963:fb08 with SMTP id
 b16-20020a170906491000b008af4963fb08mr128852ejq.15.1677536705848; Mon, 27 Feb
 2023 14:25:05 -0800 (PST)
MIME-Version: 1.0
References: <4bfe98be-5333-1c7e-2f6d-42486c8ec039@meta.com>
In-Reply-To: <4bfe98be-5333-1c7e-2f6d-42486c8ec039@meta.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 27 Feb 2023 14:24:53 -0800
Message-ID: <CAEf4BzZ+pA4QQGbiS=_-gzGwCOpvGdzkQr1c17j8uGVREykzNQ@mail.gmail.com>
Subject: Re: [v2] bpf: Propose some new instructions for -mcpu=v4
To:     Yonghong Song <yhs@meta.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        "Jose E. Marchesi" <jose.marchesi@oracle.com>,
        David Faust <david.faust@oracle.com>,
        James Hilliard <james.hilliard1@gmail.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Feb 26, 2023 at 10:31=E2=80=AFAM Yonghong Song <yhs@meta.com> wrote=
:
>
> Over the past, there are some discussions to extend bpf
> instruction ISA to accommodate some new use cases or
> fix some potential issues. These new instructions will
> be included in new cpu flavor -mcpu=3Dv4.
>
> The following are the proposal to add new instructions in 6
> different categories. The proposal is a little bit rough.
> You can find bpf insn background information in
> Documentation/bpf/instruction-set.rst. Compared to previous
> proposal (v1) in
>
> https://lore.kernel.org/bpf/01515302-c37d-2ee5-c950-2f556a4caad0@meta.com=
/
> there are two changes:
>    . for sign extend load, removing alu32_mode differentiator
>      since alu32_mode is only a compiler asm syntax mechanism in
>      this case, and not involved in insn encoding.
>    . for sign extend mov, there is no support for sign extend
>      moving an imm to a register.
>
> The corresponding llvm implementation is at
>      https://reviews.llvm.org/D144829
>
> The following is the proposal details.
>
> SDIV/SMOD (signed div and mod)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>
> bpf already has unsigned DIV and MOD. They are encoded as
>
>     insn code(4 bits) source(1 bit) instruction class(3 bit) off(16 bits)
>     DIV  0x3          0/1           BPF_ALU/BPF_ALU64        0
>     MOD  0x9          0/1           BPF_ALU/BPF_ALU64        0
>
> The current 'code' field only has two value left, 0xe and 0xf.
> gcc used these two values (0xe and 0xf) for SDIV and SMOD.
> But using these two values takes up all 'code' space and makes
> future extension hard.
>
> Here, I propose to encode SDIV/SMOD like below:
>
>     insn code(4 bits) source(1 bit) instruction class(3 bit) off(16 bits)
>     DIV  0x3          0/1           BPF_ALU/BPF_ALU64        1
>     MOD  0x9          0/1           BPF_ALU/BPF_ALU64        1
>
> Basically, we reuse the same 'code' value but changing 'off' from 0 to 1
> to indicate signed div/mod.
>
> Sign extend load
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Currently llvm generated normal load instructions are encoded like below.
>
>     mode(3 bits)      size(2 bits)    instruction class(3 bits)
>     BPF_MEM (0x3)     8/16/32/64      BPF_LDX
>
> For mode, existing used values are 0x0, 0x1, 0x2, 0x3, 0x6.
> The proposal is to use mod value 0x4 to encode sign extend loads.
>
>     mode(3 bits)      size(2 bits)    instruction class(3 bits)
>     BPF_SMEM (0x4)    8/16/32         BPF_LDX

can we define BPF_SMEM for 64-bit for completeness here? I can see
some situations where, for example, libbpf needs to switch between
BPF_MEM/BPF_SMEM based on CO-RE relocation and target type, and not
having to special-case 64-bit case would be nice.

It's minor, but so seems to be to support sign-extended 64-bit load
(which would be equivalent to non-sign-extended, of course).

>
> Sign extend register mov
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Current BPF_MOV insn is encoded as
>     insn code(4 bits) source(1 bit) instruction class(3 bit) off(16 bits)
>     MOV  0xb          0/1           BPF_ALU/BPF_ALU64        0
>
> Let us support sign extended move insn as defined below:
>
>     insn code(4 bits) source(1 bit) instruction class(3 bit) off(16 bits)
>     MOVS 0xb          1             BPF_ALU                  8/16
>     MOVS 0xb          1             BPF_ALU64                8/16/32

will this be literal 8, 16, 32 decimal values or similarly to
BPF_{B,H,W,DW} we'll just have values 0, 1, 2, 3 to represent 8, 16,
32, 64?

Also, a similar question about uniformly supporting 32 for BPF_ALU and
64 for BPF_ALU64?


>
> In the above sign extended mov instruction, 'off' represents the 'size'.
> For example, if BPF_ALU class, and 'off' is 8, which means sign
> extend a 8-bit value (in register) to a 32-bit value. If BPF_ALU64 class,
> the same 8-bit value will sign extend to a 64-bit value.
>

[...]
