Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAD7C6C3CD3
	for <lists+bpf@lfdr.de>; Tue, 21 Mar 2023 22:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjCUVhY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Mar 2023 17:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjCUVhU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Mar 2023 17:37:20 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED06336FD2
        for <bpf@vger.kernel.org>; Tue, 21 Mar 2023 14:37:17 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id o12so65184177edb.9
        for <bpf@vger.kernel.org>; Tue, 21 Mar 2023 14:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679434636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vIxpnDN2XOCMZEdVpXbCPUIgl3UgN6HIUNp59OLsU+s=;
        b=EHdTSWUEJeI//LtRCgkMaAp1x1StnZmH04iV9DB4YahXeKGpfYALBGUYhADQEKuNB2
         5bj+5N1IzN9p8dG9yqnCiQwpGhARlveD27SO5Bt3rUAqg66ddYvTyKbzSVPLphM/QhSo
         LBmN7gRdFOMPenpXsCAkvi6kiOidoMYK0sDb8/yll5QQYQwy99gPGW8xYhsqrk6ajhAC
         zXAyTVsToC7A+yl2odlZAz23lA+MsdZTGDGkM055rBZ4yf/7fCtMtKPfxkv0meeVuOGH
         47JT7Yfz/7WFLK6As0xk1XNv3BjK2Q6IoQCP8+DRptCfj0m/Sxx2Kl1bmZEO279hb32W
         8Bmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679434636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vIxpnDN2XOCMZEdVpXbCPUIgl3UgN6HIUNp59OLsU+s=;
        b=Sd1egCTrvMzqS7Sxsl3sj6/MQon+Kbw4r/N4jnYgniT/MLYMTDCrsJnSkL8JeUtX0t
         /a6fbDJLiFRIdGBbLjXOzf3uViw7diwijk48IxYG6tMZLrtNcu0hYMa6DkvNV1X4Trg9
         i+OZjP4fDHsi86R7HvQt5xHT24q/vOrc5y3FLMdqqPInmwV7ghL6gBB2PWAmn2SVTAgX
         bueoAU/KYpylA56boJN3EgoXDid1jGS2I9v6TO3pNEHPgZdjun30ypvOfL92ShVxTLaj
         DXha1gciW8cGjCAdw4tQ9mY5ku+ld9mEjT6k7zFY8TycR+Q+BHZyl3FJd0SnSSdlgpqD
         5BNw==
X-Gm-Message-State: AO0yUKU0on8l95OvR4k1q88zjaZJemjqKK4FyYVANXPZA9DprqKZXcpr
        MfM5AZJ8SO61011Sz0NJfIYsIvsOFvn6BMXexic=
X-Google-Smtp-Source: AK7set/ZJX10/cSe7fwcVSPYRwNL7YZFiAIguQDSc0uy9FlQZ0yfnWQmZw6W5/kVjD5a/s6KpRbEHJ4LprzUQzhNNo4=
X-Received: by 2002:a17:906:2f02:b0:877:747d:4a85 with SMTP id
 v2-20020a1709062f0200b00877747d4a85mr2076342eji.3.1679434636224; Tue, 21 Mar
 2023 14:37:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230318011324.203830-1-inwardvessel@gmail.com> <a16c0bc28b0e252263ad689571e14015733cdd77.camel@gmail.com>
In-Reply-To: <a16c0bc28b0e252263ad689571e14015733cdd77.camel@gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 21 Mar 2023 14:37:04 -0700
Message-ID: <CAADnVQKKUPDosq3c_bwjKGxME=06ZksfXK=gZoJ6eFGxaeJrPw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/2] error checking where helpers call bpf_map_ops
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     inwardvessel <inwardvessel@gmail.com>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@meta.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Kernel Team <kernel-team@meta.com>
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

On Mon, Mar 20, 2023 at 7:19=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Fri, 2023-03-17 at 18:13 -0700, inwardvessel wrote:
> > From: JP Kobryn <inwardvessel@gmail.com>
> >
> > Within bpf programs, the bpf helper functions can make inline calls to
> > kernel functions. In this scenario there can be a disconnect between th=
e
> > register the kernel function writes a return value to and the register =
the
> > bpf program uses to evaluate that return value.
> >
> > As an example, this bpf code:
> >
> > long err =3D bpf_map_update_elem(...);
> > if (err && err !=3D -EEXIST)
> >       // got some error other than -EEXIST
> >
> > ...can result in the bpf assembly:
> >
> > ; err =3D bpf_map_update_elem(&mymap, &key, &val, BPF_NOEXIST);
> >   37: movabs $0xffff976a10730400,%rdi
> >   41: mov    $0x1,%ecx
> >   46: call   0xffffffffe103291c       ; htab_map_update_elem
> > ; if (err && err !=3D -EEXIST) {
> >   4b: cmp    $0xffffffffffffffef,%rax ; cmp -EEXIST,%rax
> >   4f: je     0x000000000000008e
> >   51: test   %rax,%rax
> >   54: je     0x000000000000008e
> >
> > The compare operation here evaluates %rax, while in the preceding call =
to
> > htab_map_update_elem the corresponding assembly returns -EEXIST via %ea=
x:
> >
> > movl $0xffffffef, %r9d
> > ...
> > movl %r9d, %eax
> >
> > ...since it's returning int (32-bit). So the resulting comparison becom=
es:
> >
> > cmp $0xffffffffffffffef, $0x00000000ffffffef
> >
> > ...making it not possible to check for negative errors or specific erro=
rs,
> > since the sign value is left at the 32nd bit. It means in the original
> > example, the conditional branch will be entered even when the error is
> > -EEXIST, which was not intended.
> >
> > The selftests added cover these cases for the different bpf_map_ops
> > functions. When the second patch is applied, changing the return type o=
f
> > those functions to long, the comparison works as intended and the tests
> > pass.
> >
>
> Looks like this fixes commit from 2020:
> bdb7b79b4ce8 ("bpf: Switch most helper return values from 32-bit int to 6=
4-bit long")
>
> To add to the summary: the issue is caused by the fact that test
> program uses map function definitions from `bpf_helper_defs.h`, e.g.:
>
>     static long (*bpf_map_update_elem)(...) 2;
>
> These definitions are generated from `include/uapi/linux/bpf.h`,
> which specifies the return type for this helper to be `long`
> (changed to from `int` in the commit mentioned above).
> That's why clang does not insert sign extension instructions when
> helper is called.

JP,

could you please add Ed's clarification to the commit log
and add 'Fixes: bdb7b79b4ce8 ...' tag and respin ?

>
> Interesting how this went under the radar for so long, probably
> because user code mostly uses `int` to catch return value of map
> functions.
>
> That commit changes return types for a lot of functions.
> I looked through function definitions and verifier.c code for those,
> but have not found any additional issues, except for two obvious:
> - bpf_redirect_map / ops->map_redirect
> - bpf_for_each_map_elem / ops->map_for_each_callback

Please fix these two as well in the same patch.

> Tested-By: Eduard Zingerman <eddyz87@gmail.com>

and please carry the Tested-by tag in the respin.

Thanks!
