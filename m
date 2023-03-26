Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A72C66C9201
	for <lists+bpf@lfdr.de>; Sun, 26 Mar 2023 03:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjCZBKV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 25 Mar 2023 21:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjCZBKU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 25 Mar 2023 21:10:20 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251F7BBBB
        for <bpf@vger.kernel.org>; Sat, 25 Mar 2023 18:10:19 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id ew6so22321331edb.7
        for <bpf@vger.kernel.org>; Sat, 25 Mar 2023 18:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679793017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SZfoWnfSUC0kAefYqD05+SpujDSO1EpZUJzv5uI2+90=;
        b=IKu2u/5Uy2ykPvnEfRErBUWMQeuiHThkT+0f+fMfH0X2mOZgjSAsx0g3Hk2icwNkqe
         BB/jPaQ05v5Z0r7CWpiX/HHuNiuN5f1OQYALr050WUtOsKcMMRfyiaAcZQp+ryHFwto/
         hkYmwVSa/0DJwgDIXlbIiVt91R2bKqXq9frQNKXaL/LOPlTTUxxLjz+8tW+vAWNoaV+R
         /FAt7mIb+rH8G0HSfrhmM0yvNRkAVBvs8WmoOPLe6325OGtRvsTWGnBa+0fJLrf2iSOr
         n3cuVEoqOa/0MWA52rkhTuYTI86O9pEQ1Qiwb7UCCIZrzx7C/rXgqcIQQT+gCUcz3Gr9
         JYEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679793017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SZfoWnfSUC0kAefYqD05+SpujDSO1EpZUJzv5uI2+90=;
        b=5M+OPadulIiq0sSkA8j1oVFkBl5CvFKFMzxwbXRDLTHTyTeV/wRwyDFsx68KlIauGj
         G8J0bkHLxJ21aq740yuzJrTUnLH37WSN6rK6hXSRI9qAqiBVQ//sjmlJXs47kIeahGao
         4mFmqxB0IaFd5iQThMRDfV8Yu32cI3/F6R/9BXEBdEjEbndS5vVrG/2tP1azQhgph4fT
         zIXNco4d60B3IvB0Mzle5eo8uH/1jYn7e7DL2haKRL84fqbtsdLr3FUKpLl4hSCvWJ3/
         mRx2SAT0Cy9K7boTsJdaG6/dDhw2+3Egj/gWiVbkNn9D0kT7NZIrE9DLzWPYt3l2USrh
         VVpg==
X-Gm-Message-State: AAQBX9dJwMf+zPtUFxvI6PUKD0aDiEx9o64n37CD0ZLDYJlX5DBRtPam
        zzf4WSvRkrqJEeNbdtMn31/zp/84NnSTNaPkdtw=
X-Google-Smtp-Source: AKy350YROc4UkcK6NSrD3EMM7ct2QmZsefeH4VZkuHQb7kGRV57GRIG48JyUt5cgdQ6zcvmdHq7QIHYdST0ebGUReJU=
X-Received: by 2002:a17:907:20bc:b0:92a:581:ac49 with SMTP id
 pw28-20020a17090720bc00b0092a0581ac49mr3244855ejb.3.1679793017299; Sat, 25
 Mar 2023 18:10:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230322213056.2470-1-daniel@iogearbox.net> <20230322213056.2470-2-daniel@iogearbox.net>
In-Reply-To: <20230322213056.2470-2-daniel@iogearbox.net>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sat, 25 Mar 2023 18:10:06 -0700
Message-ID: <CAADnVQJQ_Kptpa5w=E+Z_PKo7jOxQv+bm6oTDF0cdQ0+avHWcA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Check when bounds are not
 in the 32-bit range
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf <bpf@vger.kernel.org>, Xu Kuohai <xukuohai@huawei.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 22, 2023 at 2:38=E2=80=AFPM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> From: Xu Kuohai <xukuohai@huawei.com>
>
> Add cases to check if bound is updated correctly when 64-bit value is
> not in the 32-bit range.
>
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Acked-by: John Fastabend <john.fastabend@gmail.com>
> ---
>  tools/testing/selftests/bpf/verifier/bounds.c | 121 ++++++++++++++++++
>  1 file changed, 121 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/verifier/bounds.c b/tools/testin=
g/selftests/bpf/verifier/bounds.c
> index 33125d5f6772..74b1917d4208 100644
> --- a/tools/testing/selftests/bpf/verifier/bounds.c
> +++ b/tools/testing/selftests/bpf/verifier/bounds.c
...
> +       BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_2, 0),
> +       BPF_LD_IMM64(BPF_REG_0, 0x7fffffffffffff10),
> +       BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_0),
> +
> +       BPF_LD_IMM64(BPF_REG_0, 0x8000000000000000),
> +       BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 1),
> +       /* r1 signed range is [S64_MIN, S64_MAX] */
> +       BPF_JMP_REG(BPF_JSLT, BPF_REG_0, BPF_REG_1, -2),
...
> +       BPF_MOV32_IMM(BPF_REG_0, 0x80000000),
> +       BPF_ALU32_IMM(BPF_ADD, BPF_REG_0, 1),
> +       /* r1 signed range is [S32_MIN, S32_MAX] */
> +       BPF_JMP32_REG(BPF_JSLT, BPF_REG_0, BPF_REG_1, -2),
> +
> +       BPF_MOV64_IMM(BPF_REG_0, 0),
> +       BPF_EXIT_INSN(),
> +       },
> +       .errstr =3D "BPF program is too large",

These infinite loops take a very long time to execute.
The test_verifier got a lot slower because of these tests.
These infinite loops don't add much value to the actual test.
Please rewrite them without infinite loops.
