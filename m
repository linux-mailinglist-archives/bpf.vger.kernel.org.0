Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 320A0653A01
	for <lists+bpf@lfdr.de>; Thu, 22 Dec 2022 01:12:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234675AbiLVAMK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Dec 2022 19:12:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiLVAMJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Dec 2022 19:12:09 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA44E01F
        for <bpf@vger.kernel.org>; Wed, 21 Dec 2022 16:12:08 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id l8so303188ljh.13
        for <bpf@vger.kernel.org>; Wed, 21 Dec 2022 16:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uG6LUtZKwbPhaohosILyQcKIih1tWSJ4kjfsVeLU3w4=;
        b=MiXxE80Fwb+3sboknDRBpwQ4R/lG+MDrDRMISGkHS6Cgllk2Em0LoFjg0uw1yxHfAG
         6E8rQBMoMrUJMN0Q7HAqpA5hR4cKTOsKEFW/Jg5FsFdtYddgdBnO9nc/JX3g7xqphAom
         35euf2RzcWaEct+IXV3tnymBqpEz6c94QeXmb/zpE84dg2kYHtzJWKSQxVxyRmcsGENT
         IRTUxWmaWtvUFUKbqGg4hcyF+6B5Pu1f3jF5wr0qhj2P6v8aXkVVxC+eVgcpmUXFAI9D
         qZnrIeN1EbPj9xBiRW0srPP+soqiu8+HUgQyx7529vTAf984x6T42JRCCvtVTAeTlpaP
         8xEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uG6LUtZKwbPhaohosILyQcKIih1tWSJ4kjfsVeLU3w4=;
        b=5oBHYZPhA8Ou5I5cWeF5YaWjQuqnsNz5M4iT7C1V/HvcRt+14Pd5at6phcJkhnSS2v
         8v7+53SnAOUQw3xPlCx7msZX55oFvH4jIHRRKPDoBkceb2BbmFzflWAQC7bUxyrAPnUN
         XF3S7/8wmwFSfseE4Gctv1h4apfVx+7yfKaag2JOox58iVC66VI1TAG2ngZCmN/Exoeb
         fjHzEqJfknUr9806acjRibWXaD3m2MQTGMfxsxoxaNWn9fut7YAVzViAcCWCN7nUSDgV
         SNZw+1710re8eVIulcdYlb7NS5Kj8Vp2QEWg8Pi+BXiGXlmVsBlnTwU4Ee/uj2ItQ0P7
         n0QA==
X-Gm-Message-State: AFqh2kpvHLSzFR4ulA0G6oTDgRbrELu/6l+JpOPEfYSTreWZTcyGq4Nx
        VK8TqOcIV0vvAl90S4ooB4mB+O+1j3T81A==
X-Google-Smtp-Source: AMrXdXsISqf16K2teMx+k+kw46I2EqdEU5c4C8aO+N6ILciS7Q2wd1HYa4z7LbyU2NaR2k0DkyMWoQ==
X-Received: by 2002:a2e:8e2f:0:b0:27a:3eeb:66c4 with SMTP id r15-20020a2e8e2f000000b0027a3eeb66c4mr916226ljk.26.1671667926506;
        Wed, 21 Dec 2022 16:12:06 -0800 (PST)
Received: from [192.168.1.113] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id f13-20020a05651c03cd00b002778801240asm1473525ljp.10.2022.12.21.16.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 16:12:06 -0800 (PST)
Message-ID: <0d59b7bd38e7ba3c7f7664441577d4b7cef3fcf4.camel@gmail.com>
Subject: Re: [PATCH bpf-next 2/4] selftests/bpf: convenience macro for use
 with 'asm volatile' blocks
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com
Date:   Thu, 22 Dec 2022 02:12:05 +0200
In-Reply-To: <CAEf4BzbbyYJHCF_YVPJdYQF7Mh-RwPkdpNCJPHvxb3MXKH2S=Q@mail.gmail.com>
References: <20221217021711.172247-1-eddyz87@gmail.com>
         <20221217021711.172247-3-eddyz87@gmail.com>
         <CAEf4BzbbyYJHCF_YVPJdYQF7Mh-RwPkdpNCJPHvxb3MXKH2S=Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 2022-12-20 at 13:05 -0800, Andrii Nakryiko wrote:
> On Fri, Dec 16, 2022 at 6:17 PM Eduard Zingerman <eddyz87@gmail.com> wrot=
e:
> >=20
> > A set of macros useful for writing naked BPF functions using inline
> > assembly. E.g. as follows:
> >=20
> > struct map_struct {
> >         ...
> > } map SEC(".maps");
> >=20
> > SEC(...)
> > __naked int foo_test(void)
> > {
> >         asm volatile(
> >                 "r0 =3D 0;"
> >                 "*(u64*)(r10 - 8) =3D r0;"
> >                 "r1 =3D %[map] ll;"
> >                 "r2 =3D r10;"
> >                 "r2 +=3D -8;"
> >                 "call %[bpf_map_lookup_elem];"
> >                 "r0 =3D 0;"
> >                 "exit;"
> >                 :
> >                 : __imm(bpf_map_lookup_elem),
> >                   __imm_addr(map)
> >                 : __clobber_all);
> > }
> >=20
> > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> > ---
> >  tools/testing/selftests/bpf/progs/bpf_misc.h | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >=20
> > diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testi=
ng/selftests/bpf/progs/bpf_misc.h
> > index a42363a3fef1..bbf56ad95636 100644
> > --- a/tools/testing/selftests/bpf/progs/bpf_misc.h
> > +++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
> > @@ -8,6 +8,12 @@
> >  #define __log_level(lvl)       __attribute__((btf_decl_tag("comment:te=
st_log_level=3D"#lvl)))
> >  #define __test_state_freq      __attribute__((btf_decl_tag("comment:te=
st_state_freq")))
> >=20
> > +/* Convenience macro for use with 'asm volatile' blocks */
> > +#define __naked __attribute__((naked))
> > +#define __clobber_all "r0", "r1", "r2", "r3", "r4", "r5", "r6", "r7", =
"r8", "r9", "memory"
>=20
> I found that this one doesn't work well when passing some inputs as
> registers (e.g., for address of a variable on stack). Compiler
> complains that it couldn't find any free registers to use. So I ended
> up using
>=20
> #define __asm_common_clobbers "r0", "r1", "r2", "r3", "r4", "r5", "memory=
"
>=20
> and adding "r6", "r7", etc manually, depending on the test.
>=20
> So maybe let's add it upfront as `__clobber_common` as well?

Will do.

>=20
> But changes look good to me:
>=20
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
>=20
> > +#define __imm(name) [name]"i"(name)
> > +#define __imm_addr(name) [name]"i"(&name)
> > +
> >  #if defined(__TARGET_ARCH_x86)
> >  #define SYSCALL_WRAPPER 1
> >  #define SYS_PREFIX "__x64_"
> > --
> > 2.38.2
> >=20

