Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6AF5653AA0
	for <lists+bpf@lfdr.de>; Thu, 22 Dec 2022 03:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiLVCad (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Dec 2022 21:30:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiLVCac (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Dec 2022 21:30:32 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B112465FB;
        Wed, 21 Dec 2022 18:30:31 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id u7so684137plq.11;
        Wed, 21 Dec 2022 18:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bU8Z99SwhtjnecE1y/hevP0WZYcJF+SzZEK7GtxdCvM=;
        b=ZytbUugcquyBxXD00pbwWSG0pZY+Bt/ijdMlI86ewRQIjJCwbX/tDGBWZ8fdGf8qfh
         gieHpsFW83kIzXfg8vGkDP/AMxey+1fqhJ/DjQ5EmY5JfKDW6ut794CSl10k6ui/q+8j
         aYj03aOqDvEDi7XkSei1QznQytQCGVGH/oMncSLbS3KqBqQhPZj9QvotXQ5QwBXZtJ1i
         6ACQOGzKfd/+S1LuHjY4aYQmsJ/2dUhStcQ3PtJpjyZ8M2dCqNpv50JYTkKFRug23wyN
         0mcXXBZwL42U2xc414DMThAe1Ac02XDqIMS7mL4Jyw1NCYxFl+0Ae5mbdcKwIRlCxyEp
         joMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bU8Z99SwhtjnecE1y/hevP0WZYcJF+SzZEK7GtxdCvM=;
        b=LtESV7Ft52Vh3aQgQfkJEu+CT5/Qwy9/oDxouaR4fekvZIAndrgG/Co5PCWYCVApET
         Oa0VX3X7N9D8HTkgHWeZSjUosi2fjZO3XqUmyOwW+shmRfHYrvMn5rqr9yahgwje6Lhz
         vFio6j/gt9+REpvxY5NUx08L33g3zbYBMSYDa4Y4RG0yMhQgClibf2LoDhLS5GeI5heN
         5j3YTIyNC6fcnLuwqN6zDIuP/h88+53MC7Wa3T/PWB2Pn0L0HelW92hKdtf01dp8mv6p
         2jsroRpE5kNVG2J0oLVgjXiBzzE3In3Px3M0lvJw8N2Qj/LS6+vMkwgs6dDnthrhDsnL
         YR/A==
X-Gm-Message-State: AFqh2kq4+MYS+gtl0F32sONhLGtfp5fIT8mkDKaek/lnI0A6L1LrgPVt
        RJzbQp9BQk/N3710hcMo6LRgDQMCCtFq/Y65zQ==
X-Google-Smtp-Source: AMrXdXteatI0E1ZI/1uHRj5RqrEYN3RXlaY/jHnTWyPz7wDf4HyntB+/bxrRbxmQwWnp9Grmoge5VpdNUGUpIARkfTg=
X-Received: by 2002:a17:90a:8d14:b0:219:dd76:7e87 with SMTP id
 c20-20020a17090a8d1400b00219dd767e87mr515322pjo.233.1671676231084; Wed, 21
 Dec 2022 18:30:31 -0800 (PST)
MIME-Version: 1.0
References: <20221213030436.17907-1-sunhao.th@gmail.com> <20221213030436.17907-2-sunhao.th@gmail.com>
 <7cfaaafa-0eda-a314-5b22-7e22c029f4ad@linux.dev> <7EAED688-C971-410E-BA56-9629CF9B3C91@gmail.com>
 <18e1219a-d2b2-0373-1f30-fcf83acd328f@linux.dev>
In-Reply-To: <18e1219a-d2b2-0373-1f30-fcf83acd328f@linux.dev>
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Thu, 22 Dec 2022 10:30:19 +0800
Message-ID: <CACkBjsa+gOh0pFPctnigXs9ugW06efCqZ+qn+dTcyRJbf6z-MQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: check null propagation
 only neither reg is PTR_TO_BTF_ID
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        David Miller <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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

Martin KaFai Lau <martin.lau@linux.dev> =E4=BA=8E2022=E5=B9=B412=E6=9C=8822=
=E6=97=A5=E5=91=A8=E5=9B=9B 05:21=E5=86=99=E9=81=93=EF=BC=9A
>
> On 12/21/22 5:46 AM, Hao Sun wrote:
> > Hi,
> >
> > I=E2=80=99ve tried something like the bellow, but soon realized that th=
is
> > won=E2=80=99t work because once compiler figures out `inner_map` equals
> > to `val`, it can choose either reg to write into in the following
> > path, meaning that this program can be rejected due to writing
> > into read-only PTR_TO_BTF_ID reg, and this makes the test useless.
>
> hmm... I read the above a few times but I still don't quite get it.  In
> particular, '...can be rejected due to writing into read-only PTR_TO_BTF_=
ID
> reg...'.  Where is it writing into a read-only PTR_TO_BTF_ID reg in the
> following bpf prog?  Did I overlook something?
>
> >
> > Essentially, we want two regs, one points to PTR_TO_BTD_ID, one
> > points to MAP_VALUR_OR_NULL, then compare them and deref map val.
>
> If I read this request correctly, I guess the compiler has changed 'ret =
=3D *val'
> to 'ret =3D *inner_map'?  Thus, the verifier did not reject because it de=
ref a
> PTR_TO_BTF_ID?
>

Yes, and if we do "*val =3D 0", it's rejected due to writing to read-only
PTR_TO_BTF_ID reg.

> > It=E2=80=99s hard to implement this in C level because compilers decide
> > which reg to use but not us, maybe we can just drop this test.
>
> Have you tried inline assembly.  Something like this (untested):
>
>          asm volatile (
>                  "r8 =3D %[val];\n"
>                  "r9 =3D %[inner_map];\n"
>                 "if r8 !=3D r9 goto +1;\n"
>                  "%[ret] =3D *(u64 *)(r8 +0);\n"
>                  :[ret] "+r"(ret)
>                  : [inner_map] "r"(inner_map), [val] "r"(val)
>                  :"r8", "r9");
>

This would work, didn't realize that I can inline BPF insns this way.
Thanks!

> Please attach the verifier output in the future.  It will be easier to un=
derstand.
>

Will do the next time.
