Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E91335A74B5
	for <lists+bpf@lfdr.de>; Wed, 31 Aug 2022 06:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiHaEMS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 31 Aug 2022 00:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiHaEMR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 31 Aug 2022 00:12:17 -0400
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ADE9AB4D6
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 21:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1661919133;
        bh=pzNye2XBDt4NiEtfnZRNvN6qLjvjcmj+9QQheAr/AuI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Gr+E6gBiTpyvMfZhK4bFOaGlS7G+0lXaDxZUMQdh8cjWrPTgQs3pL0nwRmtIrh+g0
         DCyARycW9DvjN0Nfu3VSPUsoUXNTsrfsVO7AMFeFbGE+FKBX2BnaKJNWJqndJhDD7f
         EJWEs2flJZc5rVg01wy13OOzdnERYP+mqmQU5THI=
Received: from localhost.localdomain (xry111.site [IPv6:2001:470:683e::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 5387E66220;
        Wed, 31 Aug 2022 00:12:12 -0400 (EDT)
Message-ID: <75b27dacb8b4d779c6b2c0e46871baf404a32b6b.camel@xry111.site>
Subject: Re: [PATCH bpf-next v2 4/4] LoongArch: Enable BPF_JIT and TEST_BPF
 in default config
From:   Xi Ruoyao <xry111@xry111.site>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        loongarch@lists.linux.dev
Date:   Wed, 31 Aug 2022 12:12:10 +0800
In-Reply-To: <6bc9bd64-1ba9-a35f-c0b7-480429b26b9f@loongson.cn>
References: <1661857809-10828-1-git-send-email-yangtiezhu@loongson.cn>
         <1661857809-10828-5-git-send-email-yangtiezhu@loongson.cn>
         <CAAhV-H6Dq+Z_kS0LcM=QGF1h=k2i0hR7fYZdXgU2kXAfm1VPLw@mail.gmail.com>
         <6bc9bd64-1ba9-a35f-c0b7-480429b26b9f@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.45.2 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 2022-08-31 at 09:23 +0800, Tiezhu Yang wrote:
>=20
>=20
> On 08/30/2022 10:46 PM, Huacai Chen wrote:
> > Hi, Tiezhu,
> >=20
> > On Tue, Aug 30, 2022 at 7:10 PM Tiezhu Yang <yangtiezhu@loongson.cn> wr=
ote:
> > >=20
> > > For now, BPF JIT for LoongArch is supported, update loongson3_defconf=
ig to
> > > enable BPF_JIT to allow the kernel to generate native code when a pro=
gram
> > > is loaded into the kernel, and also enable TEST_BPF to test BPF JIT.
> > >=20
> > > Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> > > ---
> > > =C2=A0arch/loongarch/configs/loongson3_defconfig | 2 ++
> > > =C2=A01 file changed, 2 insertions(+)
> > >=20
> > > diff --git a/arch/loongarch/configs/loongson3_defconfig b/arch/loonga=
rch/configs/loongson3_defconfig
> > > index 3712552..93dc072 100644
> > > --- a/arch/loongarch/configs/loongson3_defconfig
> > > +++ b/arch/loongarch/configs/loongson3_defconfig
> > > @@ -4,6 +4,7 @@ CONFIG_POSIX_MQUEUE=3Dy
> > > =C2=A0CONFIG_NO_HZ=3Dy
> > > =C2=A0CONFIG_HIGH_RES_TIMERS=3Dy
> > > =C2=A0CONFIG_BPF_SYSCALL=3Dy
> > > +CONFIG_BPF_JIT=3Dy
> > > =C2=A0CONFIG_PREEMPT=3Dy
> > > =C2=A0CONFIG_BSD_PROCESS_ACCT=3Dy
> > > =C2=A0CONFIG_BSD_PROCESS_ACCT_V3=3Dy
> > > @@ -801,3 +802,4 @@ CONFIG_MAGIC_SYSRQ=3Dy
> > > =C2=A0CONFIG_SCHEDSTATS=3Dy
> > > =C2=A0# CONFIG_DEBUG_PREEMPT is not set
> > > =C2=A0# CONFIG_FTRACE is not set
> > > +CONFIG_TEST_BPF=3Dm
> > I don't want the test module be built by default, but I don't insist
> > if you have a strong requirement.
> >=20
>=20
> Hi Huacai,
>=20
> It is useful to enable TEST_BPF in default config, otherwise we
> need to use "make menuconfig" to select it manually if we want
> to test bpf jit, and build it as a module by default has no side
> effect, so I prefer to enable TEST_BPF in default config.

IMO we shouldn't enable a test feature which is never used by 99% of
users in the default.

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
